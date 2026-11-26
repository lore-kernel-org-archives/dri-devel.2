Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A32606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 06:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QUIHPcE/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99E3210E16A;
	Thu, 26 Nov 2026 06:52:48 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CBAF10E16A
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 06:52:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 117DD605E2;
 Thu, 26 Nov 2026 06:52:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 670391F000D1;
 Thu, 26 Nov 2026 06:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795675960;
 bh=K160DLQIeQ8EwIyklKHnsSmJz40xuRmQQDAQQgw7lW4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QUIHPcE/v4tM9R1NeZwMH1ZvT5zZ7O0GFDTzoo04MY8V8CYdcmcAXEqAVkuG12gZD
 Kvt9dvFzOiIxvnucGZdpPMxmtiEVvpHjwFAiaOwrnqHMPy4hF/rFGx4psCGGv+iPrP
 LgGsmSu/giI/y/z58NUbgJZtGAG7fl3fkUFJi660qJ3Z4YtxB8MIItNaxQYRmCjcBQ
 fn7kxIBmqwgcnaOHrr8vaevLDaDlk0QGj3qloxQwZr7dC/z89NpwZKobZvOj4ViCR8
 a6uD+3Wjf8AtMHlvKXI9HicC1t/9qZmYuvu2QPlV6qSW6szqPiRSw4yeMxexIQ/rQ2
 YRaxT/qCJUJYQ==
Message-ID: <sashiko-outbox-234911@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 02/21] drm/msm/dcp: Add HFI packet helpers
To: "Jayant Shekhar" <jayant.shekhar@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org, media-ci@linuxtv.org
In-Reply-To: <20261126-jshekhar-v3-dcp-v3-2-f1e9d7505039@oss.qualcomm.com>
References: <20261126-jshekhar-v3-dcp-v3-0-f1e9d7505039@oss.qualcomm.com>
 <20261126-jshekhar-v3-dcp-v3-2-f1e9d7505039@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 06:52:39 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential
issues to consider:
- [Low] drm/msm/dcp: Kconfig help text contradicts qcom,dcp.yaml DT
  binding
- [Low] drm/msm/dcp: DRM_MSM_DCP Kconfig forces built-in VIRTIO_MMIO and
  QCOM_IPCC
- [Low] drm/msm/dcp: 20-bit HFI_PACKET_SIZE_MAX mismatches 21-bit packet
  size mask
- [Low] drm/msm/dcp: duplicate HFI packing macros and KV property
  parsers
- [Low] drm/msm/dcp: malformed kernel-doc comments and __cplusplus
  guards in HFI
--

commit 1a12340ec280848da59198aa830dba2527674b79
Author: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>

drm/msm/dcp: Add HFI packet helpers

This commit adds the DRM_MSM_DCP Kconfig option and defines the HFI packet
formats, packing and unpacking helpers, and key/value property parsing
utilities for communicating with the DCP firmware.

> diff --git a/drivers/gpu/drm/msm/Kconfig b/drivers/gpu/drm/msm/Kconfig
> index ed1c4775d1e92..df25373d7847f 100644
> --- a/drivers/gpu/drm/msm/Kconfig
> +++ b/drivers/gpu/drm/msm/Kconfig
> @@ -114,6 +114,32 @@ config DRM_MSM_DPU
>  	  the MSM DRM driver. It is the display controller found in devices
>  	  using e.g. SDM845 and newer platforms.
> =20
> +config DRM_MSM_DCP
> +	bool "Enable DCP firmware-delegated display support in MSM DRM driver"
> +	depends on DRM_MSM
> +	depends on VIRTIO_MMIO=3Dy && QCOM_IPCC=3Dy
> +	select DRM_MSM_KMS
> +	select VIRTIO_QCOM_DCP
> +	select DRM_BRIDGE_CONNECTOR

[Severity: Low]
Does DRM_MSM_DCP need to depend on VIRTIO_MMIO=3Dy && QCOM_IPCC=3Dy?

Because DRM_MSM_DCP is a bool symbol that selects the tristate
VIRTIO_QCOM_DCP, it forces VIRTIO_QCOM_DCP=3Dy and prevents enabling DCP in
modular kernel configurations where DRM_MSM, VIRTIO_MMIO, or QCOM_IPCC are
built as loadable modules.  Also, selecting DRM_BRIDGE_CONNECTOR here is
redundant because DRM_MSM_KMS already selects it.

> +	select DRM_MIPI_DSI
> +	select DRM_DISPLAY_DSC_HELPER
> +	default y
> +	help
> +	  Compile in support for the DCP (Display Coprocessor) firmware-delegat=
ed
> +	  display architecture in the MSM DRM driver.
> +
> +	  DCP is used on Hawi (qcom,hawi) SoC where all display hardware is
> +	  owned by a separate Display Coprocessor firmware. The host AP
> +	  communicates with DCP via two interfaces:
> +	    - IPCC SMP2P mailbox: power notifications and response wakeups
> +	    - HFI over VirtIO MMIO: display command/response exchange
> +
> +	  DPU and bridge nodes in the Device Tree are topology-only (no
> +	  compatible string, no reg). The driver detects them by node name
> +	  prefix using of_node_name_prefix().

[Severity: Low]
Does this help text match Documentation/devicetree/bindings/display/msm/qco=
m,dcp.yaml?

In the binding, the DCP node requires compatible =3D "virtio,device34", its
port@N, interface@N, and dsi@N child nodes all require reg properties, and
internal DPU resources are discovered at runtime from firmware rather than
represented as compatible-less DT nodes matched by arbitrary node name
prefixes.  In addition, the commit message only mentions HFI packet helpers
and does not mention adding the DRM_MSM_DCP Kconfig symbol.

> diff --git a/drivers/gpu/drm/msm/dcp/hfi/hfi_pack_unpack_common.h b/drive=
rs/gpu/drm/msm/dcp/hfi/hfi_pack_unpack_common.h
> new file mode 100644
> index 0000000000000..b767e6ee8e405
> --- /dev/null
> +++ b/drivers/gpu/drm/msm/dcp/hfi/hfi_pack_unpack_common.h
> @@ -0,0 +1,79 @@

[ ... ]

> +/* Header size field width. */
> +#define HFI_HEADER_SIZE_MAX                                   0x00ffffff
> +/* Packet size field width. */
> +#define HFI_PACKET_SIZE_MAX                                   0x000fffff
> +
> +#define HFI_HEADER_CMD_BUFF_TYPE_START_BIT                              =
     24
> +#define HFI_PACKET_PAYLOAD_TYPE_START_BIT                               =
 21
> +
> +#define GET_HEADER_SIZE(data)           \
> +	((data) & ((1 << HFI_HEADER_CMD_BUFF_TYPE_START_BIT) - 1))
> +#define GET_HEADER_CMD_BUFF_TYPE(data)         \
> +	((data) >> HFI_HEADER_CMD_BUFF_TYPE_START_BIT)
> +#define GET_PACKET_SIZE(data)           \
> +	((data) & ((1 << HFI_PACKET_PAYLOAD_TYPE_START_BIT) - 1))

[Severity: Low]
Should HFI_PACKET_SIZE_MAX be 0x001fffff instead of 0x000fffff?

struct hfi_packet in hfi_packet.h documents the packet size field as bits
[20:0] (21 bits) with payload type in bits [31:21], and GET_PACKET_SIZE()
masks 21 bits via HFI_PACKET_PAYLOAD_TYPE_START_BIT (21), whereas
hfi_create_packet() validates payload_size against the 20-bit
HFI_PACKET_SIZE_MAX (0x000fffff).

> diff --git a/drivers/gpu/drm/msm/dcp/hfi/hfi_packer.h b/drivers/gpu/drm/m=
sm/dcp/hfi/hfi_packer.h
> new file mode 100644
> index 0000000000000..460c11c724162
> --- /dev/null
> +++ b/drivers/gpu/drm/msm/dcp/hfi/hfi_packer.h
> @@ -0,0 +1,65 @@

[ ... ]

> +/* Pack a version-zero property and return its serialized word count. */
> +#define HFI_PACK(payload, property_id, ...) \
> +({ \
> +	const u32 __hfi_values[] =3D { __VA_ARGS__ }; \
> +	u32 *__hfi_payload =3D (payload); \
> +	u32 __hfi_count =3D ARRAY_SIZE(__hfi_values); \
> +\
> +	*__hfi_payload++ =3D HFI_PACK_KEY(property_id, 0, __hfi_count); \
> +	memcpy(__hfi_payload, __hfi_values, sizeof(__hfi_values)); \
> +	__hfi_count + 1; \
> +})
> +
> +/* Pack a property with an explicitly selected protocol version. */
> +#define HFI_PACK_VERSION(payload, property_id, version, ...) \
> +({ \
> +	const u32 __hfi_values[] =3D { __VA_ARGS__ }; \
> +	u32 *__hfi_payload =3D (payload); \
> +	u32 __hfi_count =3D ARRAY_SIZE(__hfi_values); \
> +\
> +	*__hfi_payload++ =3D HFI_PACK_KEY(property_id, version, __hfi_count); \
> +	memcpy(__hfi_payload, __hfi_values, sizeof(__hfi_values)); \
> +	__hfi_count + 1; \
> +})

[Severity: Low]
This isn't a bug, but HFI_PACK() duplicates the body of HFI_PACK_VERSION()
instead of expanding to HFI_PACK_VERSION(payload, property_id, 0,
__VA_ARGS__).

Also, this patch introduces two separate key/value property unpackers and
key-extraction macro sets: hfi_unpacker_get_kv_pairs_count() and
hfi_unpacker_get_kv_pairs() (both taking an unused cmd_buf_hdl argument)
with HFI_UNPACK_KEY() in hfi_unpacker.{c,h}, which are never used anywhere
in the series, alongside hfi_util_kv_parser_init() and
hfi_util_kv_parser_get_next() with HFI_PROP_ID() and HFI_PROP_SZ() in
hfi_utils.{c,h}.  In hfi_utils.h, HFI_VAL_L32() and HFI_VAL_H32() are also
unused and duplicate lower_32_bits() and upper_32_bits() from
linux/wordpart.h.

> +
> +/** hfi_get_header_size() - Return the bytes used by an HFI header. */
> +u32 hfi_get_header_size(struct hfi_cmd_buff_hdl *cmd_buf_hdl);
> +
> +/** hfi_create_header() - Initialize an HFI command header. */
> +int hfi_create_header(struct hfi_cmd_buff_hdl *cmd_buf_hdl,
> +		      struct hfi_header_info *header_info);
> +
> +/** hfi_create_full_packet() - Append a packet and its payload. */
> +int hfi_create_full_packet(struct hfi_cmd_buff_hdl *cmd_buf_hdl,
> +			   struct hfi_packet_info *packet_info);
> +
> +/** hfi_create_packet_header() - Append a packet without a payload. */
> +int hfi_create_packet_header(struct hfi_cmd_buff_hdl *cmd_buf_hdl,
> +			     struct hfi_packet_info *packet_info);
> +
> +#ifdef __cplusplus
> +}
> +#endif /* __cplusplus */

[Severity: Low]
This isn't a bug, but single-line "/** ... */" comments without parameter
and return descriptions are malformed kernel-doc and trigger
scripts/kernel-doc warnings.  Also, the #ifdef __cplusplus guards in
hfi_packer.h and hfi_unpacker.h are not needed in internal kernel headers.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126-jshekhar-v=
3-dcp-v3-0-f1e9d7505039@oss.qualcomm.com?part=3D2
