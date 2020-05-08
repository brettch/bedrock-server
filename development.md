To create a new release, the following steps are used.

1. Update `bedrockVersion` in `Dockerfile` to match the latest version of [Bedrock Dedicated Server](https://www.minecraft.net/en-us/download/server/bedrock/).
2. Update `elementZeroVersion` in `Dockerfile` to match the latest release of [Element Zero](https://github.com/Element-0/ElementZero/releases).
3. Check-in to Git and tag as:
  * `${bedrockVersion}-${elementZeroVersion}-${revision}` - where revision starts at 0 and is one greater than the last revision for the same combination of bedrockVersion and elementZeroVersion.
  * `${bedrockVersion}-${elementZeroVersion}`
  * `${bedrockVersion}`
