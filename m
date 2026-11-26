Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE34606A323
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 06:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kj+S6PFj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B330C112009;
	Thu, 26 Nov 2026 06:45:05 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7746C112009
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 06:44:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4328944447;
 Thu, 26 Nov 2026 06:44:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCAC31F000C0;
 Thu, 26 Nov 2026 06:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795675498;
 bh=UJFC6Y+nb9Ne2tyaG8UOhCpLdvksHFDqRMq0C2pZPhg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kj+S6PFjmkqdtidHqH7M+0eud7MC9jmb1bqUH+tkpdfg3wBX7zoczXkaVb3mDyZvc
 vHq38cjhUePG9HqVx8xAQV8atHUd2FnsirNR8OgNuGSL9rAkRAsMz0epE2bS7hwwtu
 utxs5BHZY/eJtXg/hEQ7ET8SGFv6KaUUahxLQbw9tpycAnWN8fdzurbp33qltRYraf
 za+o2cpfX1uabtlSDec6JOjTt+eAX1OStX3mO4VRgXA/8REu8F1Pe913rxttWv2kfn
 XSGaQy3T+gNfMEAGNBdrd1+ChODVBZ5FWqGxKGlm8k0QdNJmk3b6F3F1VyvNh0eP/a
 mv1IxuQXfaSfg==
Message-ID: <sashiko-outbox-234896@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 01/21] dt-bindings: display: msm: Add Qualcomm DCP
To: "Jayant Shekhar" <jayant.shekhar@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org, media-ci@linuxtv.org
In-Reply-To: <20261126-jshekhar-v3-dcp-v3-1-f1e9d7505039@oss.qualcomm.com>
References: <20261126-jshekhar-v3-dcp-v3-0-f1e9d7505039@oss.qualcomm.com>
 <20261126-jshekhar-v3-dcp-v3-1-f1e9d7505039@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 06:44:57 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] dt-bindings: display: msm: qcom,dcp globally claims generic
  virtio,device34
- [Low] dt-bindings: display: msm: qcom,dcp: non-canonical property
  order in interface@
--

commit f399de20b9c1b05effa463501fa719abbb97394c
Author: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>

dt-bindings: display: msm: Add Qualcomm DCP

This commit adds the Device Tree binding schema for the Qualcomm Display
Co-Processor (DCP) VirtIO display function.

> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,dcp.yaml =
b/Documentation/devicetree/bindings/display/msm/qcom,dcp.yaml
> new file mode 100644
> index 0000000000000..ff7dc4e5c5eef
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/msm/qcom,dcp.yaml
> @@ -0,0 +1,159 @@

[ ... ]

> +properties:
> +  compatible:
> +    const: virtio,device34

[Severity: Medium]
Does defining compatible solely as const: virtio,device34 without a select
rule cause dtschema to apply this Qualcomm DCP schema globally to every
vendor-specific VirtIO device node?

VIRTIO_ID_VENDOR (0x34) is a generic device ID shared across all
vendor-specific VirtIO functions, and virtio_device_of_init() matches child
nodes against virtio,device<hex_id>.  Without select: false (assuming the
parent transport schema references this schema directly) or a device-specif=
ic
compatible string, dtbs_check will enforce Qualcomm DCP's required properti=
es
(iommus, ports, #address-cells, #size-cells) and unevaluatedProperties: fal=
se
on any non-DCP device using virtio,device34.  In addition, commit "virtio:
Add vendor-specific device ID" notes that device ID 52 (0x34) is only propo=
sed
for VirtIO TC allocation and not yet formally allocated, so hardcoding
virtio,device34 here ties the DT binding ABI to an unallocated ID.

[ ... ]

> +patternProperties:
> +  "^interface@[0-9a-f]+$":
> +    type: object
> +    properties:
> +      "#address-cells":
> +        const: 1
> +      "#size-cells":
> +        const: 0
> +      reg:
> +        maxItems: 1
> +        description: DCP INTF index matching the output port.

[Severity: Low]
This isn't a bug, but in ^interface@[0-9a-f]+$, reg should be listed before
#address-cells and #size-cells under properties to match the canonical DT
property ordering as well as this node's required list and example.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126-jshekhar-v=
3-dcp-v3-0-f1e9d7505039@oss.qualcomm.com?part=3D1
