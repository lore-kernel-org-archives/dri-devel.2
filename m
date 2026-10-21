Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D519606A319
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 11:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=T9VRn1QL;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HSpxB6ap
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD71210E132;
	Wed, 21 Oct 2026 11:39:40 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B413C10E132
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 11:39:29 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LA5hGi1356974
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 11:39:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bGXJfjCCrUH5RZmEcReSeM7EPT2qwuvFA/PK6PwffXI=; b=T9VRn1QLoZ3qsW1g
 7n1m07aEUz0lY+4t+8Oe1+aBdXw9JEmYIQnw6ZkxlTM4byCoWqImniHAyYrLeGHz
 8nrooNDQ0kSJvUSTpw3Pv1i38317ZFO1LJ6BYSzejBh59oEGQgCKptPeIWL3Znlc
 WD2Vw0Fqb16vKs+6YDgQwN0DfK4HnT6Z5uWYUvCaq9kFuuiw7MPh8+Ovc6j2HcM2
 GCn0bRvkJVmP186Zn7rL82ZhDfmZ6LTxyHJeKWRelnS5ADJISfORmV9o23G04RCC
 ai93GFgIIN22kofHu3LBpjMkloNAPsWhUVek8QWEM0fk0kPuenN+WRZqMKWbyOmY
 qHxjcQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4heda4upnc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 11:39:29 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cd652c0385bso352476a12.2
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 04:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792582768; x=1793187568;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=bGXJfjCCrUH5RZmEcReSeM7EPT2qwuvFA/PK6PwffXI=;
 b=HSpxB6apktaXwfA5C/UWqAv93q/NgdGhTkDeirD15WsW5/kzq9uGoomJ+VID2N+meU
 KpzhD+vMoEUiRrr4QZbOd7ucTgCBjNmzpfnE+clJPZwpRXRb7HuMvDFlpZlpN+voaTtN
 wcHyUw1Mhz+y0NdSk+zrQ7gm719bkehkTxg7h4LxxvsQIvjuWH0RanphqMB/9Y0YKQQy
 vZNE/JOjEKZPKvQCt7tkzBNGapXgWTWQHTRNR60bCc1sQKeck7MkCxd1Yb19nHz1StH5
 ap7GZfP59ajWAsRCX9Y45+Kc+WeCKgDnFYzBJjGvfT6Gu0WJ/cZyTK9RUHAHA4BqiTeD
 7jwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792582768; x=1793187568;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=bGXJfjCCrUH5RZmEcReSeM7EPT2qwuvFA/PK6PwffXI=;
 b=m/RIXQZLZSx6PhSPZgO+Wgc5Ad4bqXRYHb6v/da/EiQx77qpPIguUzskx/umc8LXGJ
 LVbDKzL80tIb/poeYgTpqDArAfa4YTCGbnVVeTQ5X8br21UQVIxsI2/+EUzRvOOr1SBF
 bF2JNyol3Deep1z9gNP2TxKYlIhdnCIlBTncincDLRH2El7J2h2TYVeNeWxErrP0O0Mn
 vS0Xs3cQ7Zv3h2O55iaYEvqrnONIMDEUk414IBahLK4tN4L7sc4WSkAEc7sA5wHx4sJm
 M8o1Uq+4OVrDbIUqxkDwORem4vW5BRTYwC9upFTkT3im6zCAwx647LBvKIjCocm5jKFe
 GJnA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzPrUkqUdrIiN6Q5ShcacZBDZFp3zYJwaystmldLTpedADlrE3bm4TZ9szDgFA3+LRY5NWUSlz+lbE=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJU3qISeB1nAp0XqMlgbiJDxU70d2PLwaHbrcXCyI+BS0ZoU53o
 IUCaCz9ov82to/OF/lDJQmAGSlfIk7UIrTX0Km8b7LFGEEwcCzDKTXoJ8f9dlKxLH4TqB4BWz/C
 deOiSuWU3pTlkLMwR3nMaITFgPi/fegotCQsifx/XjAQaSnxpyYnHF7NaCPFmr9aic5rv4J0=
X-Gm-Gg: AYBFou1NLeLDO3ZBwfWEityzCfi38khMdYlNn6ureYo4/fKWN86Ka9yWUtsCPLhjnQG
 sA+BqBzWHkVJPeedz4GXERPi7FDOvvYaSnk3NBpx9jleybUv+Nz29uK2eQOdSjvGWk7DOuAAQIe
 SDBiLgENWbqBpzy6n02Ct8g0IXuExqMfnuoL+VYNmtZHmLLZyQgjvFZEw56+QU/xo1b0fJRtguJ
 +3YaByDrhhOQVDSzD0eZEahhLlG8QN578pfWOTVt/JwjB5yNRnNDW3O57t6aIIMIqwM2CcE5Kgh
 1tmWgue9MrxPIhN72G/c/DMwbNEXRiNhMU+CJ6wxF+Y7RSVTTYHmz2IlrRmpGuyVYFLQeJY2G7O
 4Cfjo20pHtRbSMCySPVt/u0lPThCavTesSw==
X-Received: by 2002:a05:6a20:6a1b:b0:3de:46cc:b63c with SMTP id
 adf61e73a8af0-3e287d53782mr1589287637.11.1792582768187; 
 Wed, 21 Oct 2026 04:39:28 -0700 (PDT)
X-Received: by 2002:a05:6a20:6a1b:b0:3de:46cc:b63c with SMTP id
 adf61e73a8af0-3e287d53782mr1589233637.11.1792582767612; 
 Wed, 21 Oct 2026 04:39:27 -0700 (PDT)
Received: from [10.204.79.28] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cd6a85a32b2sm712484a12.8.2026.10.21.04.39.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2026 04:39:27 -0700 (PDT)
From: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
X-Google-Original-From: Jayant Shekhar <jshekhar.shekhar@oss.qualcomm.com>
Message-ID: <f7926ef7-1edf-4d74-9758-2ee0c8a795bc@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 17:09:15 +0530
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
 <ea81fcc1-c7e4-4b80-b65e-f483487bd1a1@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <ea81fcc1-c7e4-4b80-b65e-f483487bd1a1@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: MUjGP4gxivV67pCSakPQfxZqitwrEQHi
X-Proofpoint-GUID: MUjGP4gxivV67pCSakPQfxZqitwrEQHi
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA0NiBTYWx0ZWRfX7Nu8+EDOUGZX
 EbMun9fs6xdY15uU3a1J5jv8RLfy7JbJtQW1j5bUvKS+qGW5a3MCaz0TMKEDFSdgbDgu8bZcMnM
 mqw8A0/FgyYaBBPp/VaUAh3pULk77aw=
X-Authority-Analysis: v=2.4 cv=R7aWitRX c=1 sm=1 tr=0 ts=6ad8a471 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=kn4dWm41NmOkgBkIVkoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA0NiBTYWx0ZWRfX40zUAiB2jjE/
 9ftImIJ8T6wvSj9Sq2G+Pwle7yQzrvcjejDsG0TSl9hhjLkewWvxkvdyW5wg32/e/k9FVM0a3vs
 MN4vv0aN803Uk5t4IS52JEXBvl9ColnAbMX6wOCfCujINW7XK78Mdpj6jvKqzptGuoTEY841FsE
 rDN8zfS+608gOJoue0qBTIpzUgA3ZOZY3ZDvXpZll8NgUEA+6hYD1RqGWDzi1jm1qSs5I9fZ6Ai
 kubSZUpWGWCNdEkGxqFhSLVJmaYs+7bIcmB85+UE3N8pEogf/wWQe7CmNNQ8RzGfkyp0iybG9MX
 ti9YbDHuKk2aj3tS/gP1Zrf0tWwWpVYTCsqDi9qFJV4xTpJkVrn3KqkBOBr9XYRuxmRhvcijY11
 RbFuAn4IjUfSzAcfzDaZAHY41zML5Ti7Ul5KSrMgVRONV9LHCa/NKA+xgLQHR69P27OybXyYgBC
 3XL8+BkCre1YkZxkMjA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_03,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610210046
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


On 21-10-2026 14:15, Jayant Shekhar wrote:
>
> On 15-10-2026 17:47, Dmitry Baryshkov wrote:
>> On Thu, Oct 15, 2026 at 01:08:21PM +0530, Jayant Shekhar wrote:
>>> DCP platforms place the display pipeline under firmware control, so 
>>> Linux
>>> cannot discover display resources through direct register access. 
>>> The DRM
>>> driver therefore needs device-tree descriptions of the firmware 
>>> transport,
>>> display topology, IOMMU contexts, and panel connections.
>>>
>>> Add bindings for the Qualcomm DCP VirtIO display function, including 
>>> the
>>> INTF graph and DSI host outputs. Document the framebuffer IOMMU 
>>> context,
>>> IPCC power-notify mailbox and interrupts, firmware display topology, 
>>> and
>>> firmware-visible IOVA window supplied by the parent VirtIO-MMIO 
>>> transport.
>>>
>>> Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
>>> Assisted-by: LLM
>>> ---
>>>   .../bindings/display/msm/qcom,dcp-dsi.yaml         |  75 
>>> +++++++++++++
>>>   .../bindings/display/msm/qcom,dcp-virtio.yaml      | 113 
>>> +++++++++++++++++++
>>>   .../devicetree/bindings/display/msm/qcom,dcp.yaml  | 119 
>>> +++++++++++++++++++++
>>>   3 files changed, 307 insertions(+)
>>>
>>> diff --git 
>>> a/Documentation/devicetree/bindings/display/msm/qcom,dcp-dsi.yaml 
>>> b/Documentation/devicetree/bindings/display/msm/qcom,dcp-dsi.yaml
>>> new file mode 100644
>>> index 000000000000..f7178c66c09e
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/display/msm/qcom,dcp-dsi.yaml
>>> @@ -0,0 +1,75 @@
>>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/display/msm/qcom,dcp-dsi.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Qualcomm DCP DSI host
>>> +
>>> +maintainers:
>>> +  - Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
>>> +
>>> +description: |
>>> +  A MIPI DSI host exposed by the Qualcomm DCP VirtIO device (see
>>> +  qcom,dcp.yaml). DCP is a firmware protocol shared across multiple
>>> +  Qualcomm SoCs, not specific to any one of them; Hawi is its first
>>> +  platform. The DSI host and its connection to a panel are described
>>> +  using the standard DSI controller and OF graph properties.
>>> +
>>> +allOf:
>>> +  - $ref: /schemas/display/dsi-controller.yaml#
>>> +
>>> +properties:
>>> +  reg:
>>> +    maxItems: 1
>>> +    description: Index of this DSI host among its siblings.
>>> +
>>> +  status: true
>>> +
>>> +  ports:
>>> +    $ref: /schemas/graph.yaml#/properties/ports
>>> +    description: |
>>> +      port@0: Input from the DCP virtio device's DPU INTF output port.
>>> +      port@1: Output to the attached panel.
>>> +    properties:
>>> +      port@0:
>>> +        $ref: /schemas/graph.yaml#/properties/port
>>> +      port@1:
>>> +        $ref: /schemas/graph.yaml#/$defs/port-base
>>> +        unevaluatedProperties: false
>>> +        properties:
>>> +          endpoint:
>>> +            $ref: /schemas/media/video-interfaces.yaml#
>>> +            unevaluatedProperties: false
>> Why do we need OF graph here? Would it be enough to link one of the
>> ports of the root node with the panel's input?
>>
>>> +
>>> +required:
>>> +  - reg
>>> +  - ports
>>> +
>>> +unevaluatedProperties: false
>>> +
>>> +examples:
>>> +  - |
>>> +    dcp-subsystem {
>>> +        #address-cells = <1>;
>>> +        #size-cells = <0>;
>>> +
>>> +        dsi@0 {
>>> +            reg = <0>;
>>> +            #address-cells = <1>;
>>> +            #size-cells = <0>;
>>> +
>>> +            ports {
>>> +                #address-cells = <1>;
>>> +                #size-cells = <0>;
>>> +
>>> +                port@0 {
>>> +                    reg = <0>;
>>> +                    dcp_dsi0_in: endpoint {
>>> +                        remote-endpoint = <&dcp_intf1_out>;
>>> +                    };
>>> +                };
>>> +
>>> +            };
>>> +        };
>>> +    };
>>> diff --git 
>>> a/Documentation/devicetree/bindings/display/msm/qcom,dcp-virtio.yaml 
>>> b/Documentation/devicetree/bindings/display/msm/qcom,dcp-virtio.yaml
>>> new file mode 100644
>>> index 000000000000..018694310dfb
>>> --- /dev/null
>>> +++ 
>>> b/Documentation/devicetree/bindings/display/msm/qcom,dcp-virtio.yaml
>>> @@ -0,0 +1,113 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/display/msm/qcom,dcp-virtio.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Qualcomm DCP VirtIO host
>>> +
>>> +maintainers:
>>> +  - Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
>>> +
>>> +description: |
>>> +  Qualcomm's DCP VirtIO host provides the generic VirtIO-MMIO 
>>> transport and
>>> +  the host-side IPCC channel used to wake the DCP firmware.
>>> +
>>> +properties:
>>> +  compatible:
>>> +    contains:
>>> +      const: qcom,dcp-virtio
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  iommus:
>>> +    maxItems: 1
>>> +
>>> +  iommu-ranges:
>>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>>> +
>>> +  interrupts-extended:
>>> +    minItems: 2
>>> +
>>> +  interrupt-names:
>>> +    items:
>>> +      - const: virtio
>>> +      - const: dcp_power_notify_irq
>>> +
>>> +  dma-coherent: true
>>> +
>>> +  mboxes:
>>> +    maxItems: 1
>>> +
>>> +  mbox-names:
>>> +    const: dcp-power-tx
>>> +
>>> +  dcp-subsystem:
>>> +    $ref: qcom,dcp.yaml#
>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +  - interrupts-extended
>>> +  - interrupt-names
>>> +  - iommus
>>> +  - dcp-subsystem
>>> +
>>> +additionalProperties: false
>>> +
>>> +examples:
>>> +  - |
>>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>>> +    #include <dt-bindings/mailbox/qcom-ipcc.h>
>>> +
>>> +    virtio@9be8000 {
>>> +        compatible = "qcom,dcp-virtio", "virtio,mmio";
>> Is it really compatible with virtio,mmio? Can it be handled completely
>> by virtio,mmio?
>
>
> There are two possible approaches:
>
> Option 1 — Use the standard VirtIO-MMIO parent (preferred)
>
> Keep the parent as:
>
> compatible = "virtio,mmio";
> reg = <...>;
> interrupts = <...>;
> iommus = <...>;
> iommu-ranges = <...>;
> dma-coherent;
>
> The generic virtio/mmio.yaml binding would be extended only to 
> document the generic iommu-ranges property.
>
> The DCP-specific resources would be placed on the virtio,deviceXX child:
>
> dcp-subsystem {
>     compatible = "virtio,deviceXX";
>     iommus = <...>;
>     interrupts-extended = <&ipcc ...>;
>     mboxes = <&ipcc ...>;
>     mbox-names = "dcp-power-tx";
> };
>
> The parent uses the standard VirtIO-MMIO interrupts property. The 
> child has one DCP-specific interrupt, so interrupt-names is 
> unnecessary and the driver uses interrupt index 0.
>
> Option 2 — Add a Qualcomm-specific VirtIO-MMIO parent binding
>
> Keep a Qualcomm-specific compatible such as:
>
> compatible = "qcom,dcp-virtio", "virtio,mmio";
>
> and extend the parent binding to describe iommu-ranges, the additional 
> IPCC interrupt, mailbox, and related DCP resources.
>
> However, this approach duplicates the generic VirtIO-MMIO binding and 
> is only justified if the transport requires Qualcomm-specific 
> handling. Since the DCP transport is handled completely by the 
> standard VirtIO-MMIO driver.
>
> Which one do you prefer?
>
> I will be addressing other comments in v2.
>
>
> Thanks
>
> Jayant
>
>

I think Option 1 is not suitable because the IPCC power-notify sequence 
is required before the first VirtIO-MMIO register access. The standard 
VirtIO-MMIO driver would otherwise probe the DT node directly and access 
the registers before Qualcomm-specific initialization is complete.

   Would the following Qualcomm-specific transport approach be acceptable?

   - qcom,dcp-virtio is the DT-compatible Qualcomm wrapper. It 
initializes IPCC and sends the required power notification before 
creating a synthetic virtio-mmio platform device.
   - The unchanged generic VirtIO-MMIO driver probes the synthetic 
child, accesses the MMIO registers, creates the VirtIO queues, and 
registers the VirtIO device.
   - The DCP VirtIO driver binds to the resulting VirtIO device through 
its VirtIO device/vendor ID table and initializes HFI, firmware 
capabilities, and DRM/KMS.
   - The virtio,deviceXX DT child is discovered by the VirtIO core and 
describes the DCP-specific IOMMU context, DSI hosts, display graph, and 
panels.

   The flow is:

   qcom,dcp-virtio
       → IPCC power-up
       → synthetic virtio-mmio device
       → generic VirtIO-MMIO driver
       → virtio,deviceXX DT child
       → DCP HFI/DRM driver

   Since the Qualcomm wrapper creates and owns the synthetic VirtIO-MMIO 
device, the parent node uses only:

   compatible = "qcom,dcp-virtio";

   It should not also advertise "virtio,mmio", because the generic 
driver must not probe the parent directly before IPCC initialization.


>>> +        reg = <0x09be8000 0x1000>;
>>> +        interrupts-extended = <&intc GIC_ESPI 956 
>>> IRQ_TYPE_LEVEL_HIGH>,
>>> +                              <&ipcc 13 5 IRQ_TYPE_EDGE_RISING>;
>>> +        interrupt-names = "virtio", "dcp_power_notify_irq";
>> Why do you need names? Can they be dropped in favour of using indices?
>>
>>> +        iommus = <&apps_smmu 0x15a3 0x0>;
>>> +        iommu-ranges = <0x0 0x84000000 0x0 0x04000000>;
>>> +        dma-coherent;
>>> +        mboxes = <&ipcc 13 5>;
>>> +        mbox-names = "dcp-power-tx";
>>> +
>>> +        dcp-subsystem {
>>> +            compatible = "virtio,device34";
>>> +            iommus = <&apps_smmu 0x400 0x2>;
>>> +
>>> +            #address-cells = <1>;
>>> +            #size-cells = <0>;
>>> +
>>> +            ports {
>>> +                #address-cells = <1>;
>>> +                #size-cells = <0>;
>>> +
>>> +                port@1 {
>>> +                    reg = <1>;
>>> +                    dcp_intf1_out: endpoint {
>>> +                        remote-endpoint = <&dcp_dsi0_in>;
>> Can this point directly to the panel_in? What's the point of describing
>> internal paths in the DT?
>>
>>> +                    };
>>> +                };
>>> +            };
>>> +
>>> +            dsi@0 {
>>> +                reg = <0>;
>>> +                #address-cells = <1>;
>>> +                #size-cells = <0>;
>>> +
>>> +                ports {
>>> +                    #address-cells = <1>;
>>> +                    #size-cells = <0>;
>>> +
>>> +                    port@0 {
>>> +                        reg = <0>;
>>> +                        dcp_dsi0_in: endpoint {
>>> +                            remote-endpoint = <&dcp_intf1_out>;
>>> +                        };
>>> +                    };
>>> +                };
>>> +            };
>>> +        };
>>> +    };
