Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5CB60A380D
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 09:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YDYOKV2J;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BBiKj3jH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D588A10ED6D;
	Mon, 26 Oct 2026 09:57:28 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D192110ED6D
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:57:17 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69Q4afi02222806
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:57:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=dGnG5N1ZMXpqMyBYThGtGJOs
 /WO26PEcfUhLHu/F/Bo=; b=YDYOKV2JX+1XhCXrSc+M95MP6jTtaiO5uJUfdKId
 temZMZpb6j8SuG3hMvnY/9fkFje+MoJsqoTuPz2q0TjsO+QGcqWWDxx8hFk8dp7M
 IvildnYkKkgcaLM7WeHIJDdD4dFFAZeqSXTnvedAP4tbOGwA3vKH8uZRumztIGvf
 C2nRmK+Vn0RxFgqH8VX+0BwPjMjxMnhjRNqGJUHZ0h95GO3JurB5pvyhfkE41wCd
 2Nzo4nAVOMEu95gS+dl7rBsxm2nCKiNx73lEBJ1LQaEn0jgzQy/oGRu4isC3orHF
 xRX8EKWfiAWh3l6mrE36DXBV+ckRjyR6jORdVLpf65W/KA==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hhvdd9jka-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:57:16 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-5eae356241fso731163e0c.0
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 02:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793008636; x=1793613436;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dGnG5N1ZMXpqMyBYThGtGJOs/WO26PEcfUhLHu/F/Bo=;
 b=BBiKj3jHOkHKIvhuOkTnMiahYdV9sFI5gO8XgLSnzOTdpX+dw6p9seMLBhs9BAUvwO
 ZwDH7FSLC7/2mCrloINF/mkEFc13l9S/HIdvFEHXx9pwwhXyzwsIrNUNoLieJDS3tIeL
 j1PRfu49WGIxBWUOHBkM//+Pgcw8ly6in3iQr36nydEy72oETGu+8RgIoWTjCjqBdytG
 yTAN1CMZ0TPLGDKh2AeG2y7piYuACbW1VX5ob/370yGJ7oQ48DEWJEQ58yJH6mldmpbw
 q/xvVqdhVbCHQSp5k2UW4nggADB++6NTeGbrVk7kaWKQQVnlQnBo9sfZWO0pbihRbqzd
 eQRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793008636; x=1793613436;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dGnG5N1ZMXpqMyBYThGtGJOs/WO26PEcfUhLHu/F/Bo=;
 b=dBDLRf6DPL7wpyzoHvoYT3CkJGCUn9Q9dVTVeSpAXZrX9JkvNcdIfOtG4569/GOxvR
 XnV7Nt9PzYRoHUJmQMiODOqkjwWIx4EvTaJjUavtLXmx3Yn+j3BdXybtpT6bwUn2yr0q
 /tAe6xVCgZNIDOIYpxiUEaqiy+L8aG7IZbaILLKRRepet8McyLVccGTnzkvJK23K30gX
 12x6LJTu9IrkhKGB+srnDyFae9UhmXCSF6DQMZH5ifbFvksMXiqqBwTr+Af+ftXVL10C
 kZrDCdFusCHakSvbPXbDtopm1u2530T6JdY5LFTLK7OlbzZd42Ynf1/U77d0BnZ2IZDc
 ZsAA==
X-Forwarded-Encrypted: i=1;
 AKwUvByvWhiPn2QAdoM8N4rMkeodtOGm1qAGWsVHnYwvM8SnkX62zsjopPk4QluNOByFf1LJE9Wh2CJjWUg=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJSTRfnf3lhkHqr+44VxROzExeOJAgjPv7ETUPGcajjcWYUmL03
 Uh3LT1ZjqGr/9lNdHhdcPjQdlJdMSFjFbArKwnhUcLni9fRHHux0T0UUV5BL0/9cG4ZqscmMWgn
 1s+cfUuVTkInKCTMSFxL1QgtJdI5/CpCPpxD3x0Q1NmibLrwto3/zGe6til3S/jBv68SzfH4=
X-Gm-Gg: AYBFou0tgpMYXJFABItzoRDClRdux445gk8Gyg2xP0y/lmMRZF8CZZcJcLssrSO5gJt
 ZFt7AHfquQbVbgkcQcMXtNTw+wTan4Sa4XD33xWaX179zps4DVTmvgsJG53g3wdqtc8kulKLCm+
 3A1umVFHZs7ULuQOKaUleeyIEuxHd8msoQGErH4aFuQ4ETrpPopYaPkTqvDvgDNUsvwkyzmxdYy
 Q8Ydpbbvk9BnlmOIRa/8Nhs/EfdCXgbK/36WDyn1agMWzbZHFNDOMwLkPvd13Cn8Ti5fZpNfeK5
 /4FUnxAzBstvYwi0EW9to3PKOoZpVkLYbg0ws8feg9m9tM8Hb+v7xCtX4juFB1z51jyttU1Jz/U
 xqKta1yBmf0+b2DL+twnTJcVOTaEFiqYyTwWb+7vV7lgtlcO24MzxO7uKd0CvmRG5f9WD3u9E8/
 5V7nJ1cENUJwz1
X-Received: by 2002:a05:6122:46a2:b0:5ea:dddc:49de with SMTP id
 71dfb90a1353d-5ec232ecbc7mr1873446e0c.14.1793008635581; 
 Mon, 26 Oct 2026 02:57:15 -0700 (PDT)
X-Received: by 2002:a05:6122:46a2:b0:5ea:dddc:49de with SMTP id
 71dfb90a1353d-5ec232ecbc7mr1873419e0c.14.1793008634997; 
 Mon, 26 Oct 2026 02:57:14 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ac70a493b6sm15800951fa.37.2026.10.26.02.57.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 02:57:13 -0700 (PDT)
Date: Mon, 26 Oct 2026 11:57:11 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowangio@gmail.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Flemin Jose <flemin.jose@oss.qualcomm.com>,
 Mahadevan P <mahap@oss.qualcomm.com>, virtualization@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, iommu@lists.linux.dev
Subject: Re: [PATCH v2 01/23] dt-bindings: display: msm: Add Qualcomm DCP
Message-ID: <fzchmbho74ii6d2zhzni4qy4g74hiwv4fwf5xudrqdrstt6klm@7wdoo4acr6fm>
References: <20261026-jshekhar-dcp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com>
 <20261026-jshekhar-dcp-hlos-v2-1-7cf014efdee1@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261026-jshekhar-dcp-hlos-v2-1-7cf014efdee1@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: eMYzJlgmNYI74TPidfCSFR-kvbKgFGvR
X-Proofpoint-GUID: eMYzJlgmNYI74TPidfCSFR-kvbKgFGvR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAzOSBTYWx0ZWRfX76s5n6Mj3+pB
 4gJ1zEQaBZ+7muoD1eAmo0h0sHDPT6Bgqsx3J5UH724xW2dbhjCDSvLO3stNVy1iAnPgq+Gc4H5
 QkjhOZbzlxhlG1F6p2wwmILiZFTbvGFAAaJ8LAIrnE3o7BRqYIUH3kONCJo5TATAAYgcdXd2sou
 TLXE0BzNTpqk/f1JMBmYrbELXVRasogb8M0AUMlwDczawNXKs12WeS7im6isyAEEGzJ/FZq+N7C
 d3IHc/+n/LU/bc9+B5TUEzJkM4cIYbgvZhp9IDGlU1Iyb+LV/Tun4s7InpWVwDuvVyngQ6/BMpm
 pIhLgkkUrYgpFUr0+P/mg+aU8mMWgavvVhn3ckTVl6QfYgnzDx3qJwul9LxEp9WO/dR+9Dfi3Az
 nMjm//k/ZCHBtLUF426zqMPn+m4D/CRUkIH+Ur3pDj/YHCehOf3RhH3vW1ND/6fWTy+JGeNOfsd
 IsJczs2RWSG3Hz/d93w==
X-Authority-Analysis: v=2.4 cv=N8+8hG9B c=1 sm=1 tr=0 ts=6adf23fc cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=gEfo2CItAAAA:8
 a=EUspDBNiAAAA:8 a=5JPbPPqDrGKWpyQmkvkA:9 a=CjuIK1q_8ugA:10
 a=vmgOmaN-Xu0dpDh8OwbV:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAzOSBTYWx0ZWRfX8rzMsFvBeLhW
 BEizCKRe4abM3zN62jdS1Aj0+bMaDUtV5a0yD8uKDoyCIJ2FmitSFwqYlhlJrq5q01m5Iv3Fsc6
 GyeYEHX6/PmUSfDQrmEfknD2B4U1NSQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260039
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 26, 2026 at 11:51:11AM +0530, Jayant Shekhar wrote:
> DCP platforms place the display pipeline under firmware control, so Linux
> cannot discover display resources through direct register access. The DRM
> driver therefore needs device-tree descriptions of the Qualcomm transport
> wrapper, display topology, IOMMU contexts, and panel connections.
> 
> Add bindings for the Qualcomm DCP transport wrapper and VirtIO display
> subsystem. Document the IPCC power-notify resources, transport and
> framebuffer IOMMU contexts, firmware-visible IOVA range, INTF graph, and
> DSI panel connections. The wrapper creates a standard VirtIO-MMIO child
> after the IPCC power-notify sequence has completed.
> 
> Assisted-by: LLM
> Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
> ---
>  .../bindings/display/msm/qcom,dcp-dsi.yaml         |  79 ++++++++++++
>  .../devicetree/bindings/display/msm/qcom,dcp.yaml  | 123 +++++++++++++++++++
>  .../bindings/virtio/qcom,dcp-virtio.yaml           | 132 +++++++++++++++++++++
>  3 files changed, 334 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,dcp-dsi.yaml b/Documentation/devicetree/bindings/display/msm/qcom,dcp-dsi.yaml
> new file mode 100644
> index 000000000000..9a0acaf00bb3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/msm/qcom,dcp-dsi.yaml
> @@ -0,0 +1,79 @@
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
> +  qcom,dcp.yaml). It follows the generic DSI controller binding, with panel
> +  devices described as child nodes. The DCP INTF graph endpoint connects
> +  directly to the panel; the DSI host node is not a graph endpoint. The host
> +  node uses the dsi@N naming convention, and its reg property identifies the
> +  DSI host index.
> +
> +allOf:
> +  - $ref: /schemas/display/dsi-controller.yaml#

If there are no separate compatibles, can this be folded into the main
DCP schema?

> +
> +properties:
> +  reg:
> +    maxItems: 1
> +    description: DSI host index matching the DCP output port.
> +
> +required:
> +  - reg
> +  - "#address-cells"
> +  - "#size-cells"
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    dcp-subsystem {
> +        compatible = "virtio,device34";
> +        iommus = <&apps_smmu 0x400 0x2>;
> +
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        ports {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            port@0 {
> +                reg = <0>;
> +                dcp_intf0_out: endpoint {
> +                    remote-endpoint = <&panel_dcp_in>;
> +                };
> +            };
> +        };
> +
> +        dsi@0 {
> +            reg = <0>;
> +            #address-cells = <1>;
> +            #size-cells = <0>;

Yes, fold it there. It's not a separate device on its own.

> +
> +            panel@0 {
> +                compatible = "novatek,nt37801";
> +                reg = <0>;
> +
> +                vddio-supply = <&vreg_l12b_1p8>;
> +                vci-supply = <&vreg_l13b_3p0>;
> +                vdd-supply = <&display_panel_vdd>;
> +                reset-gpios = <&tlmm 210 GPIO_ACTIVE_LOW>;
> +
> +                port {
> +                    panel_dcp_in: endpoint {
> +                        remote-endpoint = <&dcp_intf0_out>;
> +                    };
> +                };
> +            };
> +        };
> +    };
> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,dcp.yaml b/Documentation/devicetree/bindings/display/msm/qcom,dcp.yaml
> new file mode 100644
> index 000000000000..96f6c2a17e9e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/msm/qcom,dcp.yaml
> @@ -0,0 +1,123 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/msm/qcom,dcp.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Display Co-Processor (DCP)
> +
> +maintainers:
> +  - Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
> +
> +description: |
> +  The Display Co-Processor (DCP) is a firmware-owned display subsystem.
> +  Linux communicates with DCP over HFI through VirtIO and does not access
> +  display hardware registers directly.
> +
> +  This node describes the externally connected display graph between DCP
> +  INTF outputs and attached DSI panels. It is assigned to the VirtIO device
> +  by the Qualcomm transport driver and is not independently enumerated.
> +  Firmware capabilities and internal resources, including pipes, mixers,
> +  CRTCs, and clocks, are discovered at runtime.
> +
> +allOf:
> +  - $ref: /schemas/virtio/virtio-device.yaml#
> +
> +properties:
> +  compatible:
> +    const: virtio,device34
> +
> +  iommus:
> +    maxItems: 1
> +    description:
> +      SMMU context used by DCP firmware to access GEM framebuffers. This
> +      is separate from the HFI transport context specified by the
> +      iommus property on the parent DCP transport node.
> +      The child context is used for framebuffer DMA performed by DCP
> +      firmware, while the parent context is used for VirtIO transport and HFI
> +      queue buffers. These contexts represent distinct firmware-visible DMA
> +      address spaces and must not be used interchangeably.
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +    description: |
> +      DPU INTF output-only ports. The port number matches the firmware INTF
> +      index. The corresponding DSI host is the child node whose reg value
> +      matches the port number; the graph endpoint itself connects directly to
> +      the attached panel. Unused INTF ports are omitted.
> +    unevaluatedProperties: false
> +    patternProperties:
> +      "^port@[0-9a-f]+$":
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false
> +        properties:
> +          endpoint:
> +            $ref: /schemas/graph.yaml#/$defs/endpoint-base
> +            unevaluatedProperties: false
> +            required:
> +              - remote-endpoint
> +
> +patternProperties:
> +  "^dsi@[0-9a-f]+$":
> +    $ref: qcom,dcp-dsi.yaml#

When adding DP support, would you add more devices at the same level? If
so, we risk getting a warning about multiple devices using the same
address.

> +required:
> +  - compatible
> +  - iommus
> +  - "#address-cells"
> +  - "#size-cells"
> +  - ports
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    dcp-subsystem {
> +        compatible = "virtio,device34";
> +        iommus = <&apps_smmu 0x400 0x2>;
> +
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        ports {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            port@0 {
> +                reg = <0>;
> +                dcp_intf0_out: endpoint {
> +                    remote-endpoint = <&panel_dcp_in>;
> +                };
> +            };
> +        };
> +
> +        dsi@0 {
> +            reg = <0>;
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            panel@0 {
> +                compatible = "novatek,nt37801";
> +                reg = <0>;
> +
> +                vddio-supply = <&vreg_l12b_1p8>;
> +                vci-supply = <&vreg_l13b_3p0>;
> +                vdd-supply = <&display_panel_vdd>;
> +                reset-gpios = <&tlmm 210 GPIO_ACTIVE_LOW>;
> +
> +                port {
> +                    panel_dcp_in: endpoint {
> +                        remote-endpoint = <&dcp_intf0_out>;
> +                    };
> +                };
> +            };
> +        };
> +    };
> diff --git a/Documentation/devicetree/bindings/virtio/qcom,dcp-virtio.yaml b/Documentation/devicetree/bindings/virtio/qcom,dcp-virtio.yaml
> new file mode 100644
> index 000000000000..6020e848ce25
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/virtio/qcom,dcp-virtio.yaml
> @@ -0,0 +1,132 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/virtio/qcom,dcp-virtio.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm DCP VirtIO transport
> +
> +maintainers:
> +  - Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
> +
> +description: |
> +  Qualcomm DCP VirtIO transport. The IPCC power-notify channel and
> +  associated interrupts are required before the transport can access its
> +  MMIO registers. This is a Qualcomm-specific transport and must not use the
> +  generic virtio-mmio driver. The DCP VirtIO function is described as a child
> +  node and is assigned to the registered VirtIO device by this transport.
> +
> +properties:
> +  compatible:
> +    const: qcom,dcp-virtio
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts-extended:
> +    minItems: 2
> +    maxItems: 2
> +    description: The VirtIO-MMIO and DCP power-notify interrupts, in that order.
> +
> +  iommus:
> +    maxItems: 1
> +
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

'dcp' is not a generic name. If you want to list it here, it should be
something like 'display-subsystem' or 'display-controller'.

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
> +        compatible = "qcom,dcp-virtio";
> +        reg = <0x09be8000 0x1000>;
> +        interrupts-extended = <&intc GIC_ESPI 956 IRQ_TYPE_LEVEL_HIGH>,
> +                              <&ipcc 13 5 IRQ_TYPE_EDGE_RISING>;
> +        iommus = <&apps_smmu 0x15a3 0x0>;
> +        iommu-ranges = <0x0 0x84000000 0x0 0x04000000>;

This doesn't match the address / size cells.

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
> +                port@0 {
> +                    reg = <0>;
> +                    dcp_intf0_out: endpoint {
> +                        remote-endpoint = <&panel_dcp_in>;
> +                    };
> +                };
> +            };
> +
> +            dsi@0 {
> +                reg = <0>;
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                panel@0 {
> +                    compatible = "novatek,nt37801";
> +                    reg = <0>;
> +
> +                    vddio-supply = <&vreg_l12b_1p8>;
> +                    vci-supply = <&vreg_l13b_3p0>;
> +                    vdd-supply = <&display_panel_vdd>;
> +                    reset-gpios = <&tlmm 210 GPIO_ACTIVE_LOW>;
> +
> +                    port {
> +                        panel_dcp_in: endpoint {
> +                            remote-endpoint = <&dcp_intf0_out>;
> +                        };
> +                    };
> +                };
> +            };
> +        };
> +    };
> 
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry
