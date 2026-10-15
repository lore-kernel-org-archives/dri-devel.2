Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E03DBCC6B34
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 12:17:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 466D510E328;
	Thu, 15 Oct 2026 12:17:28 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D85F710EA27
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 12:17:17 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69F9jhct3510339
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 12:17:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=kwvB1zKyxNXdUuzLtE3Xrjsi
 oZNHT7RX4lExGCslwX0=; b=AmpdpgarodzIVAKJa8VQxjU3IzQux0vpqCcAhD7c
 ZFlIcas0KLQn13sqWS0jJh40xKUrAc8+I3v0bHOpN0XSKUfV5uS+AVw2cjQYO3Pi
 /j9iz4brp7TwDEzjLTTfHoedSoLBLvf93/yZCeBhCDXNPGA8JNM9hSLtw5759kEH
 2hOYzU2+cscF3mrrIw7GqLyf2wDE7jFE7lAG1fMNgbkoABZ7voXmD8TS7kIzOleC
 fEihV5xE3MJimuMr+LQNUuaUH696j4epbU+JbrtpDfoZ5m6lhITY+2HRuyyuhOQl
 wPB7BS2p0K8KCN7ykoebhsPhW+jlLvSmm1IX/OimxfRIZw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4haqds9xhj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 12:17:16 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-939c30aa9a0so156979185a.0
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 05:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792066636; x=1792671436;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kwvB1zKyxNXdUuzLtE3XrjsioZNHT7RX4lExGCslwX0=;
 b=G25VYHW9leZuuAJcd5k18hTzk5eOgcoXOezp74rq7rnQc92Phvl41RlEghUxkLoHZ8
 tPcu8K8HocyTXA1dr2mP7EguLuZ1AE54Xu6vZYem5UVNrkD1FA86quZYzJg3yCnpV6M9
 CtURSWq5eF6rgCeJVLm6eLnIKbIm5Bd4RQFm9qFZDW+VvITQJY/mfQhhuzXcWyh9uAwt
 n1lfb7J0FukA6hlCsqHac/ntBS+isg2jqSCnmvM4c1Xq+sDY8IG8OQZ4oTMJ7/+78R7d
 BMMard2Ikk/hLXjFclDOFJPbzKpCupV+kPSFQx5bSCpSsvex6jhknJHCoJ6E753W1qst
 h7BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792066636; x=1792671436;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kwvB1zKyxNXdUuzLtE3XrjsioZNHT7RX4lExGCslwX0=;
 b=Wekr264d38KQupdr129ypBdV9GfMGxdLQIZNXORIms0o0HVCqVRcXd3pgB8WjA8F1U
 jgmY5FHC817jAVnSgphL5PE14y9qiksIqdJBybzBvWkJEdl1vGKCaBiMJh0VTnVEjwZN
 8CjZgydpUZTbTuWwHj4Kb0bblvCYCoZd25YnJxp/aq5fyZDiV4xCB/quLshGFe5mYs5x
 daPA+H2gVxY79mzqYQPWTx07O6aM5Nq4KRorHkOyXvVqVYKBELVgmpasDnAZvbI6pd63
 e7Kdaiob4FRshZxfIOEmEG/CSm4jQtBE1lhzyGy9UpoJqv/a5oA4lDpbZLhpVM/KRow7
 TAKg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxdEZdTfjVMa1lrBFYDnTI3+C80mTnm+io4muyYAFM05MBese1bVg8c8N51GFj+IdfrjbNdlrAmnHI=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKWOmAhu2RhvqUyEKx6/2BNyT2f3ae1bJ/a0TxDMHRez4MLVJbd
 /yGj6zifVR3MdwsvmmB8uieTOl476w4xtpH9/NOahULYKZhoBP5BzfCKNggVnV/sRC6VzjI0SQL
 D/NvbHunWJW3DoV0Vf2vjBlIF6icmwyQtQdP0hFU+C69zVgA943ggv8wjvEyByNPGYIwa3mA=
X-Gm-Gg: AYBFou198LfdOa8D5CNNcl8IRZ+N2nP2/ylYXQXnwuut6r3/KlVhgZLZdtw/aB0Kilb
 UUHg6fhlYvukreR+QPOwWxb0/7qQrQjiLhxUivUzSYyWUrJYSxiYPY5DMzoKSRwwm+PQsJAZ3zp
 740KqL5IMa4ySi1aA3RcP0DnPS9nNvgW/rYWD0Z4b4D9pOJpj3jHwWJpRmsChsWwbDAGSwuOJaf
 lmFIErviaAgVdjE4IAcsqRV0VTLw7bSDh/VkexApFd1QFzzevI8lOsa7u4DFP9VaLF8nkkCbe4y
 3KQ3Wp2FWjKiXx53iL3MxXTIxw3zKZB8ydTjaqXPRb+Fl5mRfbLm5096JSYumx510jNsmfbJInS
 XafT83agnKiFUOIhdSBbXmEDM4vOc2/+JLXC01QInuoTdIGmlkobs/aQCasbaDkWU/Al7KxnWRq
 kAOriUF5mUQ77y
X-Received: by 2002:a05:620a:3708:b0:93e:c12c:fbcc with SMTP id
 af79cd13be357-93ec12d072cmr2801923485a.72.1792066635839; 
 Thu, 15 Oct 2026 05:17:15 -0700 (PDT)
X-Received: by 2002:a05:620a:3708:b0:93e:c12c:fbcc with SMTP id
 af79cd13be357-93ec12d072cmr2801917085a.72.1792066635216; 
 Thu, 15 Oct 2026 05:17:15 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3aafdc040d3sm5939231fa.3.2026.10.15.05.17.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 05:17:13 -0700 (PDT)
Date: Thu, 15 Oct 2026 15:17:12 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 iommu@lists.linux.dev
Subject: Re: [PATCH 01/13] dt-bindings: display: msm: Add Qualcomm DCP bindings
Message-ID: <hprf3vrsveovq3hwcgjrfj6uhmlxlq5u5bx4lkbswgxe476qwz@pacalsdgrjx7>
References: <20261015-jshekhar-drm-msm-dcp-v1-v1-0-48aad0fe4f72@oss.qualcomm.com>
 <20261015-jshekhar-drm-msm-dcp-v1-v1-1-48aad0fe4f72@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015-jshekhar-drm-msm-dcp-v1-v1-1-48aad0fe4f72@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: NbxSBis2ckwF0iVyte2UwawEtEGEX8z1
X-Authority-Analysis: v=2.4 cv=fNusTpae c=1 sm=1 tr=0 ts=6ad0c44c cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=gEfo2CItAAAA:8
 a=EUspDBNiAAAA:8 a=-nBYf6lyRfyxIgOjefsA:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA0OCBTYWx0ZWRfX5wGw8zmAJsbj
 SnWUK0dy6YyC6Ws7Ft/bJFhZ+BxzGm2LzB3x8YL8xVvpbuMcduekqhlTAgP1JYf4eGJlD8hNnZo
 YBc8eRT01tG8NKFTzGszQZC1zOL5YOKpsWN+JwwYE21BrJ2rClrVsAVjl/b2BurXiyKyU/jEYez
 sFj5uxJVWHQddQ7z+Og5+GyX2DYJi3pV6Lg2w3c/yxZXTt0+z1J3ESLIV3iemBtIvKVMsI6wWlW
 4vhi4E6J4UguGa0JcC5MWf6U+doO/IBaNXUDFE4AMV4BnDSaCJx/XbdwzofRgLIrQ3qTQFNoP3z
 Iy0m3PwlRiUpomlHSLZwofshXLV/3kU6fSX66S/qa2hx2GXfkfokwC90Y1prgg/GOuZU0zJ3bwL
 QjRAML/lgrBBOox1/wehjB9GUFKHi1XgSa2dJoxS0trAseZVtWNBWqDDD7qiTQaXZY/PShsNFRW
 0HlV3B74ZOdPEn2kNMA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA0OCBTYWx0ZWRfXzrNvI6e1SzxI
 lAB7grNzu1puu4nIC9a7TT+DCfHfDhLOXdVilrANJGQESPB0Unpm5QVFU/JimLOH90GjgPc2qdX
 KeqordullhPPGQOO3Exorim4bx4kg1w=
X-Proofpoint-GUID: NbxSBis2ckwF0iVyte2UwawEtEGEX8z1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150048
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Thu, Oct 15, 2026 at 01:08:21PM +0530, Jayant Shekhar wrote:
> DCP platforms place the display pipeline under firmware control, so Linux
> cannot discover display resources through direct register access. The DRM
> driver therefore needs device-tree descriptions of the firmware transport,
> display topology, IOMMU contexts, and panel connections.
> 
> Add bindings for the Qualcomm DCP VirtIO display function, including the
> INTF graph and DSI host outputs. Document the framebuffer IOMMU context,
> IPCC power-notify mailbox and interrupts, firmware display topology, and
> firmware-visible IOVA window supplied by the parent VirtIO-MMIO transport.
> 
> Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
> Assisted-by: LLM
> ---
>  .../bindings/display/msm/qcom,dcp-dsi.yaml         |  75 +++++++++++++
>  .../bindings/display/msm/qcom,dcp-virtio.yaml      | 113 +++++++++++++++++++
>  .../devicetree/bindings/display/msm/qcom,dcp.yaml  | 119 +++++++++++++++++++++
>  3 files changed, 307 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,dcp-dsi.yaml b/Documentation/devicetree/bindings/display/msm/qcom,dcp-dsi.yaml
> new file mode 100644
> index 000000000000..f7178c66c09e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/msm/qcom,dcp-dsi.yaml
> @@ -0,0 +1,75 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/msm/qcom,dcp-dsi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm DCP DSI host
> +
> +maintainers:
> +  - Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
> +
> +description: |
> +  A MIPI DSI host exposed by the Qualcomm DCP VirtIO device (see
> +  qcom,dcp.yaml). DCP is a firmware protocol shared across multiple
> +  Qualcomm SoCs, not specific to any one of them; Hawi is its first
> +  platform. The DSI host and its connection to a panel are described
> +  using the standard DSI controller and OF graph properties.
> +
> +allOf:
> +  - $ref: /schemas/display/dsi-controller.yaml#
> +
> +properties:
> +  reg:
> +    maxItems: 1
> +    description: Index of this DSI host among its siblings.
> +
> +  status: true
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +    description: |
> +      port@0: Input from the DCP virtio device's DPU INTF output port.
> +      port@1: Output to the attached panel.
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/properties/port
> +      port@1:
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false
> +        properties:
> +          endpoint:
> +            $ref: /schemas/media/video-interfaces.yaml#
> +            unevaluatedProperties: false

Why do we need OF graph here? Would it be enough to link one of the
ports of the root node with the panel's input?

> +
> +required:
> +  - reg
> +  - ports
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    dcp-subsystem {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        dsi@0 {
> +            reg = <0>;
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            ports {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                port@0 {
> +                    reg = <0>;
> +                    dcp_dsi0_in: endpoint {
> +                        remote-endpoint = <&dcp_intf1_out>;
> +                    };
> +                };
> +
> +            };
> +        };
> +    };
> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,dcp-virtio.yaml b/Documentation/devicetree/bindings/display/msm/qcom,dcp-virtio.yaml
> new file mode 100644
> index 000000000000..018694310dfb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/msm/qcom,dcp-virtio.yaml
> @@ -0,0 +1,113 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/msm/qcom,dcp-virtio.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm DCP VirtIO host
> +
> +maintainers:
> +  - Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
> +
> +description: |
> +  Qualcomm's DCP VirtIO host provides the generic VirtIO-MMIO transport and
> +  the host-side IPCC channel used to wake the DCP firmware.
> +
> +properties:
> +  compatible:
> +    contains:
> +      const: qcom,dcp-virtio
> +
> +  reg:
> +    maxItems: 1
> +
> +  iommus:
> +    maxItems: 1
> +
> +  iommu-ranges:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +
> +  interrupts-extended:
> +    minItems: 2
> +
> +  interrupt-names:
> +    items:
> +      - const: virtio
> +      - const: dcp_power_notify_irq
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
> +    $ref: qcom,dcp.yaml#
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts-extended
> +  - interrupt-names
> +  - iommus
> +  - dcp-subsystem
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/mailbox/qcom-ipcc.h>
> +
> +    virtio@9be8000 {
> +        compatible = "qcom,dcp-virtio", "virtio,mmio";

Is it really compatible with virtio,mmio? Can it be handled completely
by virtio,mmio?

> +        reg = <0x09be8000 0x1000>;
> +        interrupts-extended = <&intc GIC_ESPI 956 IRQ_TYPE_LEVEL_HIGH>,
> +                              <&ipcc 13 5 IRQ_TYPE_EDGE_RISING>;
> +        interrupt-names = "virtio", "dcp_power_notify_irq";

Why do you need names? Can they be dropped in favour of using indices?

> +        iommus = <&apps_smmu 0x15a3 0x0>;
> +        iommu-ranges = <0x0 0x84000000 0x0 0x04000000>;
> +        dma-coherent;
> +        mboxes = <&ipcc 13 5>;
> +        mbox-names = "dcp-power-tx";
> +
> +        dcp-subsystem {
> +            compatible = "virtio,device34";
> +            iommus = <&apps_smmu 0x400 0x2>;
> +
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            ports {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                port@1 {
> +                    reg = <1>;
> +                    dcp_intf1_out: endpoint {
> +                        remote-endpoint = <&dcp_dsi0_in>;

Can this point directly to the panel_in? What's the point of describing
internal paths in the DT?

> +                    };
> +                };
> +            };
> +
> +            dsi@0 {
> +                reg = <0>;
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                ports {
> +                    #address-cells = <1>;
> +                    #size-cells = <0>;
> +
> +                    port@0 {
> +                        reg = <0>;
> +                        dcp_dsi0_in: endpoint {
> +                            remote-endpoint = <&dcp_intf1_out>;
> +                        };
> +                    };
> +                };
> +            };
> +        };
> +    };

-- 
With best wishes
Dmitry
