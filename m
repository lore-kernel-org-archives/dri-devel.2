Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0754606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 08:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UwC5m0sx;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GbjTiJSk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0360810FC97;
	Wed, 21 Oct 2026 08:46:21 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A236410E2E3
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 08:46:09 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69L5j2nV165261
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 08:46:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 T34/HlSHyjCRDqfk2vimEJ3Pwwh0TycFh3fKBLlyT8Q=; b=UwC5m0sxAo9CranQ
 I2wU+VQqqlLBpXX/XorF7YaZxJhNq7sUCkB6IfeCqY03U38I6Ef0cVK+uqRM1xch
 w2Vud5soXpT3FMmGLaY7sSMFoSgE4/Qpzure2JdmOyUJrnqz3qRYit2HILj56kb6
 AC/Szb3w3pnZegQYU8U14VCsPWFWOtUEuJO37i3c+20pZqONT7EXW5AQg5LcclX2
 GnrvAhn4vs/brcWWechVCSZGKF0Q2c6Kn8dVlq/Hb2InR/htWIT/oa8H1D8BnndP
 wziW71SPMwPvgOp6Xg+P3b+kLyWQEL9qgw31ow5uvye5iihyITY/RK3N0SON2X6E
 WEna2Q==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hegs027cx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 08:46:08 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-14373747468so422174c88.1
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 01:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792572367; x=1793177167;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=T34/HlSHyjCRDqfk2vimEJ3Pwwh0TycFh3fKBLlyT8Q=;
 b=GbjTiJSkD9fRMXhJEavMNjozQgXUsIso+kTSnQriBT1HntlhalObIxJRzGTxCs9h5w
 DM/OEyXrCkXGsaGcEbqu0h5G7guNLpRWRknZk6XsAmmmw0yGQO3O4+7cOR6DqCXQeDE5
 SnijWqFJI7kprVwJcEOAcOHQVqjZZ9GcGrNgexd7yAJltHNZq3S1TQup7c/rJT5IqDzb
 j42KFo5RUBKNVW2bEZL2ZDBZhOIrK5oLA3F8EPM5VJeGQemriw7DLzwqpsuiSzhr8E25
 8cZpsAon6IroJlas7vr8RewbLpJYXt0XXhqyx2PiNMbzAEj/2ylFpO47U8jsmnL0CpIW
 XiSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792572367; x=1793177167;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=T34/HlSHyjCRDqfk2vimEJ3Pwwh0TycFh3fKBLlyT8Q=;
 b=L1FJZayd7lO1RqksoVSp8fnuKdCHvWKAngVq4Kadg1QVfjmvXUX7N2SYaNA4lmAmlB
 O/IIii4WLm84T6a1A3qNPsR48WZyfthZv8AQLuV9cgRvJjuih9tekM3BIItE84OypRCy
 14wEPIvbwJgxEYu7o31LF/Rp2y8RX9e6wvXJHozcaXAzc96ZdRpSEYO6PRlxWxdwypWr
 jN50RaAk1GSvEGneRBjjh8ia7/TwjR9tcBEZo3sVtw+Sg53UUVUAnLX68xFN/ETYETjy
 0Iq72Bbw+LXFvHLS2UJ9u43nod5+ey1Uw0ExNnTTMvo25H+wzyTMiTW15Awfw2mCbjPc
 c1NQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzBUNAf2mGaJqJBF9CV2qYce8eJJXMW78jwGVqI4hmLkwZG8ntB4UiUXSuVbi001hmJcHeiykAIsiE=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIwZUo40LIThtLaAutqPChwj0ACBta0Gx2BeptaYh6c9ls+P/mU
 MnrHqLMsDojyKTBHpN7DodBpUmIB9Vr2JwMBT1HCwe48mb/BbGdxyLYMrr1FUCuyOX1Czr4D+5k
 dZKAGcCIBZZc2WY2O3eDGk8u4bMwiDZOC768lrbsnQ/MEsp4ZTYViP0OUjqV8lJL+Gpdl8II=
X-Gm-Gg: AYBFou3E8+z5Q4RB4AWNy+6Sv/WSw8SiAEdZ6Vqgc4X5OkTX2kSzif29SIkdkwDBGRH
 2A2K11Xw5k5rtPKO9zsUzDs63xOVmgwH5MnDbtrWCo2Au7J85PpjhNi1lyVo+aSmzSoXjdNtmeH
 cSmRgHDMmkuiXyu/bjz/K9gco87muUaXqRofmj8bH6AVvYJQ0020BbNTJTufZ3IwAupa2lcP+ol
 Sr8dlOiqPOfudlFz8gXOZUEC6VnwftdF1qxE4sxOtESJdjYCCr6MlGan8rIjTxXJ2227+2kJd/v
 WNmJrD/3Cv/zGMFhybNrB3rjNP9ymWApkUcACop+KdxEqwStns+lH+IGkAJ04DFHrLvZGsdmLym
 m6Njx+fuGBN0PtMX3+pJQGOzHE3jAKXUknQ==
X-Received: by 2002:a05:7022:eb55:10b0:187:cf46:4c51 with SMTP id
 a92af1059eb24-190a728a309mr1916560c88.31.1792572366976; 
 Wed, 21 Oct 2026 01:46:06 -0700 (PDT)
X-Received: by 2002:a05:7022:eb55:10b0:187:cf46:4c51 with SMTP id
 a92af1059eb24-190a728a309mr1916523c88.31.1792572366229; 
 Wed, 21 Oct 2026 01:46:06 -0700 (PDT)
Received: from [10.204.79.28] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1903bd6b7ccsm4271323c88.13.2026.10.21.01.45.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2026 01:46:05 -0700 (PDT)
From: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
X-Google-Original-From: Jayant Shekhar <jshekhar.shekhar@oss.qualcomm.com>
Message-ID: <ea81fcc1-c7e4-4b80-b65e-f483487bd1a1@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 14:15:53 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/13] dt-bindings: display: msm: Add Qualcomm DCP bindings
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 iommu@lists.linux.dev
References: <20261015-jshekhar-drm-msm-dcp-v1-v1-0-48aad0fe4f72@oss.qualcomm.com>
 <20261015-jshekhar-drm-msm-dcp-v1-v1-1-48aad0fe4f72@oss.qualcomm.com>
 <hprf3vrsveovq3hwcgjrfj6uhmlxlq5u5bx4lkbswgxe476qwz@pacalsdgrjx7>
Content-Language: en-US
In-Reply-To: <hprf3vrsveovq3hwcgjrfj6uhmlxlq5u5bx4lkbswgxe476qwz@pacalsdgrjx7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=S/NMU4sP c=1 sm=1 tr=0 ts=6ad87bd0 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=GUqRGlKH2whgtnOLMxAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAzNCBTYWx0ZWRfXyKORhFPxHWf0
 Xv63rjK/l2VohC1whJWhi5Ak1H9SknrwlnufU3LO9JCsKBkRhZQVnfd/IqkVxEMS83OG0xVxrbD
 I2onwfzqAuSS///mU4y36CcvUJEFAVmkW7R7M5ZvfFRMOH2Qa+5iDFlz3fZjuDsNl2XNZVcMK1Z
 MYgtHFRgyERKJVJKT/Kk81oR86iil7EFKWMoF6+mnjBNgB0UtTZDLrzIpveqA+wHaIbJeHXg5jE
 xXUhj5ByUDpmQWTIRpLMu7BVw/IsLh5bvAhj0i9tCAfaiJDVYaTmoV9WTNzutbuGRsY1xwP0ojy
 zwrovIWPjPneNaeBmlXTV0FspYaEJDlNgOLBRWADjEUWUOact5oJkvN03kIKky1jvFp5bveKKbm
 MEgfuNmc9JLWCvWvZILcfXA66Zz1kifsbqI/yXb+0IMtwWe8MBgLtnnnUWZgxPhFvIJsf5LTYg8
 BWG6RhNfgC0UUWMtnGQ==
X-Proofpoint-ORIG-GUID: 9B0eq_SOSdtyDlTcsfzR9-5qQFSdEyZo
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAzNCBTYWx0ZWRfXwtvZiFRh7iEU
 ZAxJObWazwnG8zN3fvKHZYbsGnvLh+7OQ5O1t85bg2Ho+Oys8h2PFXhl0lUO8X+2VQnv7zpQYUQ
 881cvUKJ0bZeLbCuMrErDQ0cNRxJmvY=
X-Proofpoint-GUID: 9B0eq_SOSdtyDlTcsfzR9-5qQFSdEyZo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_02,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210034
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
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 15-10-2026 17:47, Dmitry Baryshkov wrote:
> On Thu, Oct 15, 2026 at 01:08:21PM +0530, Jayant Shekhar wrote:
>> DCP platforms place the display pipeline under firmware control, so Linux
>> cannot discover display resources through direct register access. The DRM
>> driver therefore needs device-tree descriptions of the firmware transport,
>> display topology, IOMMU contexts, and panel connections.
>>
>> Add bindings for the Qualcomm DCP VirtIO display function, including the
>> INTF graph and DSI host outputs. Document the framebuffer IOMMU context,
>> IPCC power-notify mailbox and interrupts, firmware display topology, and
>> firmware-visible IOVA window supplied by the parent VirtIO-MMIO transport.
>>
>> Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
>> Assisted-by: LLM
>> ---
>>   .../bindings/display/msm/qcom,dcp-dsi.yaml         |  75 +++++++++++++
>>   .../bindings/display/msm/qcom,dcp-virtio.yaml      | 113 +++++++++++++++++++
>>   .../devicetree/bindings/display/msm/qcom,dcp.yaml  | 119 +++++++++++++++++++++
>>   3 files changed, 307 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,dcp-dsi.yaml b/Documentation/devicetree/bindings/display/msm/qcom,dcp-dsi.yaml
>> new file mode 100644
>> index 000000000000..f7178c66c09e
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/display/msm/qcom,dcp-dsi.yaml
>> @@ -0,0 +1,75 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/display/msm/qcom,dcp-dsi.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm DCP DSI host
>> +
>> +maintainers:
>> +  - Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
>> +
>> +description: |
>> +  A MIPI DSI host exposed by the Qualcomm DCP VirtIO device (see
>> +  qcom,dcp.yaml). DCP is a firmware protocol shared across multiple
>> +  Qualcomm SoCs, not specific to any one of them; Hawi is its first
>> +  platform. The DSI host and its connection to a panel are described
>> +  using the standard DSI controller and OF graph properties.
>> +
>> +allOf:
>> +  - $ref: /schemas/display/dsi-controller.yaml#
>> +
>> +properties:
>> +  reg:
>> +    maxItems: 1
>> +    description: Index of this DSI host among its siblings.
>> +
>> +  status: true
>> +
>> +  ports:
>> +    $ref: /schemas/graph.yaml#/properties/ports
>> +    description: |
>> +      port@0: Input from the DCP virtio device's DPU INTF output port.
>> +      port@1: Output to the attached panel.
>> +    properties:
>> +      port@0:
>> +        $ref: /schemas/graph.yaml#/properties/port
>> +      port@1:
>> +        $ref: /schemas/graph.yaml#/$defs/port-base
>> +        unevaluatedProperties: false
>> +        properties:
>> +          endpoint:
>> +            $ref: /schemas/media/video-interfaces.yaml#
>> +            unevaluatedProperties: false
> Why do we need OF graph here? Would it be enough to link one of the
> ports of the root node with the panel's input?
>
>> +
>> +required:
>> +  - reg
>> +  - ports
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    dcp-subsystem {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +
>> +        dsi@0 {
>> +            reg = <0>;
>> +            #address-cells = <1>;
>> +            #size-cells = <0>;
>> +
>> +            ports {
>> +                #address-cells = <1>;
>> +                #size-cells = <0>;
>> +
>> +                port@0 {
>> +                    reg = <0>;
>> +                    dcp_dsi0_in: endpoint {
>> +                        remote-endpoint = <&dcp_intf1_out>;
>> +                    };
>> +                };
>> +
>> +            };
>> +        };
>> +    };
>> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,dcp-virtio.yaml b/Documentation/devicetree/bindings/display/msm/qcom,dcp-virtio.yaml
>> new file mode 100644
>> index 000000000000..018694310dfb
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/display/msm/qcom,dcp-virtio.yaml
>> @@ -0,0 +1,113 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/display/msm/qcom,dcp-virtio.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm DCP VirtIO host
>> +
>> +maintainers:
>> +  - Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
>> +
>> +description: |
>> +  Qualcomm's DCP VirtIO host provides the generic VirtIO-MMIO transport and
>> +  the host-side IPCC channel used to wake the DCP firmware.
>> +
>> +properties:
>> +  compatible:
>> +    contains:
>> +      const: qcom,dcp-virtio
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  iommus:
>> +    maxItems: 1
>> +
>> +  iommu-ranges:
>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>> +
>> +  interrupts-extended:
>> +    minItems: 2
>> +
>> +  interrupt-names:
>> +    items:
>> +      - const: virtio
>> +      - const: dcp_power_notify_irq
>> +
>> +  dma-coherent: true
>> +
>> +  mboxes:
>> +    maxItems: 1
>> +
>> +  mbox-names:
>> +    const: dcp-power-tx
>> +
>> +  dcp-subsystem:
>> +    $ref: qcom,dcp.yaml#
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts-extended
>> +  - interrupt-names
>> +  - iommus
>> +  - dcp-subsystem
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    #include <dt-bindings/mailbox/qcom-ipcc.h>
>> +
>> +    virtio@9be8000 {
>> +        compatible = "qcom,dcp-virtio", "virtio,mmio";
> Is it really compatible with virtio,mmio? Can it be handled completely
> by virtio,mmio?


There are two possible approaches:

Option 1 — Use the standard VirtIO-MMIO parent (preferred)

Keep the parent as:

compatible = "virtio,mmio";
reg = <...>;
interrupts = <...>;
iommus = <...>;
iommu-ranges = <...>;
dma-coherent;

The generic virtio/mmio.yaml binding would be extended only to document 
the generic iommu-ranges property.

The DCP-specific resources would be placed on the virtio,deviceXX child:

dcp-subsystem {
     compatible = "virtio,deviceXX";
     iommus = <...>;
     interrupts-extended = <&ipcc ...>;
     mboxes = <&ipcc ...>;
     mbox-names = "dcp-power-tx";
};

The parent uses the standard VirtIO-MMIO interrupts property. The child 
has one DCP-specific interrupt, so interrupt-names is unnecessary and 
the driver uses interrupt index 0.

Option 2 — Add a Qualcomm-specific VirtIO-MMIO parent binding

Keep a Qualcomm-specific compatible such as:

compatible = "qcom,dcp-virtio", "virtio,mmio";

and extend the parent binding to describe iommu-ranges, the additional 
IPCC interrupt, mailbox, and related DCP resources.

However, this approach duplicates the generic VirtIO-MMIO binding and is 
only justified if the transport requires Qualcomm-specific handling. 
Since the DCP transport is handled completely by the standard 
VirtIO-MMIO driver.

Which one do you prefer?

I will be addressing other comments in v2.


Thanks

Jayant


>> +        reg = <0x09be8000 0x1000>;
>> +        interrupts-extended = <&intc GIC_ESPI 956 IRQ_TYPE_LEVEL_HIGH>,
>> +                              <&ipcc 13 5 IRQ_TYPE_EDGE_RISING>;
>> +        interrupt-names = "virtio", "dcp_power_notify_irq";
> Why do you need names? Can they be dropped in favour of using indices?
>
>> +        iommus = <&apps_smmu 0x15a3 0x0>;
>> +        iommu-ranges = <0x0 0x84000000 0x0 0x04000000>;
>> +        dma-coherent;
>> +        mboxes = <&ipcc 13 5>;
>> +        mbox-names = "dcp-power-tx";
>> +
>> +        dcp-subsystem {
>> +            compatible = "virtio,device34";
>> +            iommus = <&apps_smmu 0x400 0x2>;
>> +
>> +            #address-cells = <1>;
>> +            #size-cells = <0>;
>> +
>> +            ports {
>> +                #address-cells = <1>;
>> +                #size-cells = <0>;
>> +
>> +                port@1 {
>> +                    reg = <1>;
>> +                    dcp_intf1_out: endpoint {
>> +                        remote-endpoint = <&dcp_dsi0_in>;
> Can this point directly to the panel_in? What's the point of describing
> internal paths in the DT?
>
>> +                    };
>> +                };
>> +            };
>> +
>> +            dsi@0 {
>> +                reg = <0>;
>> +                #address-cells = <1>;
>> +                #size-cells = <0>;
>> +
>> +                ports {
>> +                    #address-cells = <1>;
>> +                    #size-cells = <0>;
>> +
>> +                    port@0 {
>> +                        reg = <0>;
>> +                        dcp_dsi0_in: endpoint {
>> +                            remote-endpoint = <&dcp_intf1_out>;
>> +                        };
>> +                    };
>> +                };
>> +            };
>> +        };
>> +    };
