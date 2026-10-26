Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA11606A324
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 09:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G9M0Xfv7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EFBE10E076;
	Mon, 26 Oct 2026 09:39:00 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BABF10E076
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:38:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F037943948;
 Mon, 26 Oct 2026 09:38:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59F481F01825;
 Mon, 26 Oct 2026 09:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793007533;
 bh=1gZceDB5JLaDORdRyGWYQSRD3vgwVOwK8Zur333F1/s=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=G9M0Xfv7Kq7IilAIm8zurx9hac+5nKKhHsBhDz+BuvyCR7dZ0+WzsZDRlaPlHuqsY
 3PtadpEeESZm4EYhNQis6oCpFDd3heGt6NRIKTVf3iGXP445fOUwH4tst1XSIfnoVB
 f+YbF4uga/RRSuJgqUYtlaoMepgh7geSy6kfDChRKipj1bh2yRL88xpuwKFU+TLtvO
 YQnsvtFI2QENTvH+1xEqaJVBPnTG1DPZlYoePmrDngetRMn6hyhL1D65Ze/naWA796
 nmivBC7E+he182/UXxGU6iJCaENJWwvKpQ9C5KscA9oPHWYFlKeW8cX5LK0vj0tdaj
 AQFt7AiMaHGrA==
Message-ID: <sashiko-outbox-184814@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 01/23] dt-bindings: display: msm: Add Qualcomm DCP
To: "Jayant Shekhar" <jayant.shekhar@oss.qualcomm.com>
Cc: virtualization@lists.linux.dev, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org,
 media-ci@linuxtv.org, "Michael
 S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261026-jshekhar-dcp-hlos-v2-1-7cf014efdee1@oss.qualcomm.com>
References: <20261026-jshekhar-dcp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com>
 <20261026-jshekhar-dcp-hlos-v2-1-7cf014efdee1@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 09:38:52 +0000
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] dt-bindings: qcom,dcp-virtio: invalid uint32 $ref in iommu-range=
s items
- [Medium] dt-bindings: qcom,dcp-virtio: mismatched reg and iommu-ranges ce=
ll counts
--

commit 148fd24e1536920168a0cc19486ca6a7b8039591
Author: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>

dt-bindings: display: msm: Add Qualcomm DCP

This commit adds Device Tree binding schemas for the Qualcomm Display
Co-Processor (DCP) VirtIO transport wrapper, the DCP VirtIO display
subsystem, and its child MIPI DSI host controller.

> diff --git a/Documentation/devicetree/bindings/virtio/qcom,dcp-virtio.yam=
l b/Documentation/devicetree/bindings/virtio/qcom,dcp-virtio.yaml
> new file mode 100644
> index 0000000000000..6020e848ce259
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/virtio/qcom,dcp-virtio.yaml
> @@ -0,0 +1,132 @@

[ ... ]

> +  iommu-ranges:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description: |
> +      The firmware-visible IOVA range, specified as a four-cell tuple
> +      containing a 64-bit IOVA base followed by a 64-bit range size.
> +    items:
> +      - description: IOVA base, high cell
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +      - description: IOVA base, low cell
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +      - description: IOVA range size, high cell
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +      - description: IOVA range size, low cell
> +        $ref: /schemas/types.yaml#/definitions/uint32

[Severity: Medium]
Does make dt_binding_check pass on properties.iommu-ranges in
Documentation/devicetree/bindings/virtio/qcom,dcp-virtio.yaml with these
per-item $ref entries?

When iommu-ranges uses /schemas/types.yaml#/definitions/uint32-array at the
property level, dtschema validates each entry under items against
meta-schemas/cell.yaml#/$defs/single-cell, which sets additionalProperties:
false and does not permit $ref, causing dt-doc-validate to fail.

In addition, /schemas/types.yaml#/definitions/uint32 is a property-level 2D
matrix schema rather than a scalar cell schema, so applying it to individual
cells of a uint32-array creates an array-versus-integer type conflict when
dt-validate checks the example's iommu-ranges property. Should the four $re=
f:
/schemas/types.yaml#/definitions/uint32 lines under items be dropped?

> +
> +  dma-coherent: true
> +
> +  mboxes:
> +    maxItems: 1
> +
> +  mbox-names:
> +    const: dcp-power-tx
> +
> +  dcp-subsystem:
> +    $ref: ../display/msm/qcom,dcp.yaml#
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts-extended
> +  - iommus
> +  - iommu-ranges
> +  - dma-coherent
> +  - mboxes
> +  - mbox-names
> +  - dcp-subsystem
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/mailbox/qcom-ipcc.h>
> +
> +    virtio@9be8000 {
> +        compatible =3D "qcom,dcp-virtio";
> +        reg =3D <0x09be8000 0x1000>;
> +        interrupts-extended =3D <&intc GIC_ESPI 956 IRQ_TYPE_LEVEL_HIGH>,
> +                              <&ipcc 13 5 IRQ_TYPE_EDGE_RISING>;
> +        iommus =3D <&apps_smmu 0x15a3 0x0>;
> +        iommu-ranges =3D <0x0 0x84000000 0x0 0x04000000>;

[Severity: Medium]
In the examples block of
Documentation/devicetree/bindings/virtio/qcom,dcp-virtio.yaml, reg is
specified with 1 address cell and 1 size cell under the default example bus
(#address-cells =3D <1>; #size-cells =3D <1>;), whereas iommu-ranges is wri=
tten
as a 4-cell tuple (2 address cells and 2 size cells).

When the kernel parses iommu-ranges via
of_iommu_get_resv_regions() -> of_iommu_derive_resv_regions() ->
of_translate_dma_region() in drivers/of/address.c:

    struct device_node *parent __free(device_node) =3D __of_get_dma_parent(=
dev);
    ...
    na =3D of_bus_n_addr_cells(parent);
    ns =3D of_bus_n_size_cells(parent);

    address =3D of_translate_dma_address(dev, prop);
    if (address =3D=3D OF_BAD_ADDR)
        return NULL;

    size =3D of_read_number(prop + na, ns);

both reg and iommu-ranges use the parent bus #address-cells and #size-cells.
With a 1-cell parent bus, wouldn't of_iommu_derive_resv_regions() misparse
<0x0 0x84000000 0x0 0x04000000> as two 32-bit ranges ([0x0, 0x84000000) and
[0x0, 0x04000000)) instead of one 64-bit range ([0x84000000, 0x88000000))?
Should the example wrap virtio@9be8000 in a parent bus node with
#address-cells =3D <2> and #size-cells =3D <2> and use a 4-cell reg propert=
y?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026-jshekhar-d=
cp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com?part=3D1
