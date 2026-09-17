Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8D93C982D0
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 05:42:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD30D10E73F;
	Thu, 17 Sep 2026 05:42:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="hcKf4THM";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gfm3Jmqx";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FFF910E65E
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 05:42:50 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68H1GRFl3559506
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 05:42:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 k1NtjGOsgxTer/ktLWGwA754RLEQUuhJE+6j0sZd88w=; b=hcKf4THMRAh/vmJp
 BubSj/LyppmFhIkPNTS2wErU1g/5Gghmmau6DFxcsRpUN7AjOgn2remCMZ7XXhS4
 5r40cva5vmvuMtGQvUmnccAAHKgfHf2LgKXnP02J3JxR6sad7hK/jWJMJwgkx3nN
 7cyEuEedo67hpT7UckiTX35NydDQ+ut+5jA4ZJ5vqpbwfmHyxFxQQ2Vgqk/ZJvRv
 8vvzW6MIHIH3fG+PHLJvVmnso1m8V2jIyidtv8Kz3dZKDTEyLWRutSLu4MJle0Et
 KweAGkFLF3a+z+PJjpR+T3NAA6OIcdX2oHxQ0jlF8Y4e4S0oueuu+uuLKmZL/jVS
 6nRd2w==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gqy7hakbp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 05:42:49 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-8710450f731so658610b3a.0
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 22:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789623768; x=1790228568;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=k1NtjGOsgxTer/ktLWGwA754RLEQUuhJE+6j0sZd88w=;
 b=gfm3Jmqxja0/M1+wAydczw/rdgARtRf4S1vkwdEqbfftMY3aJWkmrrhKykuV0VTlj4
 HvQuqfq4+KtwJG8K1Zby8VDud19dVs8h4AmOtnCOPXX1KRSgEvJlHxHwTIeGaCjSSdEV
 NRvo14R6I/LmsNvhCxvr8QXWxqjSSmpHtQyxzAPeLcP3SSuo6FhOxYwF7/HMYY7zptIb
 OsQtfk6MU2Ar2q68oEauM4/flW8OFBp4Psww9VtPmD8FY8wUzyonHRUg463xTfqTg3Dk
 skKb2v3k/2tUEmlYKBwJsHs9onO6jJP5x5eKKwp3/cBCMR+gAfuo7+O4EGU2ESOd+z5C
 NU+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789623768; x=1790228568;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=k1NtjGOsgxTer/ktLWGwA754RLEQUuhJE+6j0sZd88w=;
 b=ZWs5VZpkgqDqQldHFGbopYyDeJ10xzdwCdym7brUhpaO1UX0yqxzTKYG83z6tWNiqv
 r5F72QmkhFyyfUI7FMi+qg+DhxABw3ujNRbP2JboafWp4Q/lrPoip43xXTQjkY/agp82
 qbeHh3x0jP+azNYOiY5++8yhj/+aJWtd2oKaW+p0aM0VJzxgKtFq7v2Mht3KwODk8wNe
 NE/WByItwJ2+ITyoRvcMasLl1YLb0uIlcCrlNhbWx5VqtDQj+e98O8EdyEMo4gJPpQMm
 jq+Np1Jnag3PlEjA+ipl+gNykl/pcrFlVjxInFUgIw2sU4BGOKfZN3J01IJeC3MPsHpB
 ZFIg==
X-Forwarded-Encrypted: i=1;
 AKwUvBx9P82AFJ0dkekxBA1pcrsYTPqv0CFTsZhAWI7Nq171/J632SF9mfXts2LsMPr1vOcqZ0yuXsEeIvg=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mQtH5p2bA/Ztvzs0d/tnZ+v1hCCMEPwd+l+8bd4qe8Pw/Sr6Yn
 ohuUw8DtwrknMoxeSchaSaxQcC7/pkz9eVG/hHagX1RNHdySIM+8PPMfqukSVORJ3bZow6X0ePJ
 +tAU0NYVdWOi0I6Lw2P6ydMWyKsxwvBzqTI/ccY6jF0Vj/7/ccCuNgUKhWskyy0blryuXdqk=
X-Gm-Gg: AYBFou3X3nHHI90ZbTP8dNIcv9WPjSdXlhHm8Zcgt1on3aWEutc+JeZi5v5IJZ2dGy3
 M7JjMnZpa1Vo/sjIh4FQtN6LZguTC0LUrHzlXgCKP+uXy/WpfGYRXjcd+uODCzecVBVscNdceQK
 RasmSwL7CT7pYJV3msh63A6okSGf5IQ3i6p5rrIn9oZtEHdC2odU8UMwgSgupJ4t11d4OEyWrBl
 ODKoW0RCk2lioIxOrpDnvzTmI4/ECpsfm29C4ZviyhpXWdaVVBtt0NcH3rV8KzWA1yPMZAThj6t
 cPZ1POS/ykxrr1NqLmaeBwUDM++H1Cd+keyk1Ha3f67t+R83hUQ+BBYoRNekPPfdoGEayRc5Hy5
 qTqfX0e2/uJGDIQjCAsxTePRJGESh
X-Received: by 2002:a05:6a21:514:b0:3c3:6928:8b25 with SMTP id
 adf61e73a8af0-3dd5f5ab211mr15101555637.17.1789623768388; 
 Wed, 16 Sep 2026 22:42:48 -0700 (PDT)
X-Received: by 2002:a05:6a21:514:b0:3c3:6928:8b25 with SMTP id
 adf61e73a8af0-3dd5f5ab211mr15101484637.17.1789623767817; 
 Wed, 16 Sep 2026 22:42:47 -0700 (PDT)
Received: from [10.204.78.119] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5af4f0bsm14466679eec.24.2026.09.16.22.42.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Sep 2026 22:42:47 -0700 (PDT)
Message-ID: <7d2611bb-532f-4553-9d16-66c4b9c495c9@oss.qualcomm.com>
Date: Thu, 17 Sep 2026 11:12:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/17] dt-bindings: display/msm: Document Nord MDSS
To: Shawn Guo <shengchao.guo@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>, linux-arm-msm@vger.kernel.org,
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, Ritesh Kumar
 <ritesh.kumar@oss.qualcomm.com>, Mahadevan P <mahadevan.p@oss.qualcomm.com>
References: <20260911-nord-drv-dt-v1-0-e25c073cf1b6@oss.qualcomm.com>
 <20260911-nord-drv-dt-v1-3-e25c073cf1b6@oss.qualcomm.com>
 <aqtECDwHPiUUZqTB@QCOM-aGQu4IUr3Y>
Content-Language: en-GB
From: Nabige Aala <nabige.aala@oss.qualcomm.com>
In-Reply-To: <aqtECDwHPiUUZqTB@QCOM-aGQu4IUr3Y>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDA3MyBTYWx0ZWRfX3mXGWQw2M+im
 qbLdk6BBmhDGrdhMgF0P3WrF15ob2Q/HiLpEuejYJXjIerbQhkqRv4KAxy2oFby6lyj0MuPPtJ/
 jmf5RQJYFC7SCwU97RwoSd0wfnn1etsY/FMmJ62oSwrS8MkeDpMp3i2Itiwsqspv/6ehUPhSRAR
 vcMWHBZlqKlZWwSlNvkrSPJDWUMfNwA5PhTHqgzYvNR8DZgHu/Jh+y2cPZlxO+AZL2MgLZA0OZb
 TXgSSjCoKNzIEKkYLVqphxZB2ztedDbYc1x9iBrdW4UljDOpe8WorTkjWtVOt6Ie3vBQYD5Y/A7
 giWe7+AHPjmX+TgwT72LVYsL//wufdGkHLldqIqpfPOtpod0aARwasjDrffHgP/BRIMBJjeWaLs
 0rqWnvhHrvMJgFv/ERJJ1j/5hu6J+PWpKjroxJ/HsQdv5l8A+Bg15tkJwvBh+OiJa0KJX5vRbRy
 Hr4dcRcpU/o2Ynx70Ag==
X-Authority-Analysis: v=2.4 cv=L8aI0OT8 c=1 sm=1 tr=0 ts=6aab7dd9 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=gEfo2CItAAAA:8 a=JfrnYn6hAAAA:8 a=EUspDBNiAAAA:8 a=T1TI9GLrlG5TBy_zXBgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
 a=sptkURWiP4Gy88Gu7hUp:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-GUID: YC34jgspbrE9Mlr8siJzrZVjX23oMuze
X-Proofpoint-ORIG-GUID: YC34jgspbrE9Mlr8siJzrZVjX23oMuze
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDA3MyBTYWx0ZWRfXzw8/yxieRlIM
 4YRnpYuopxYbASxQ0/ZH6FBT36AjPKhWSd7MlaeMqrqVeF8jG5WCRRcbVVxj5wBBzP7YoaKnqPd
 9s0uKAPbhyXLDl8vmBiz87R5vM62ao8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0
 clxscore=1015 suspectscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170073
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


On 9/17/2026 7:06 AM, Shawn Guo wrote:
> On Fri, Sep 11, 2026 at 09:06:34PM +0530, Nabige Aala wrote:
>> From: Mahadevan P <mahadevan.p@oss.qualcomm.com>
>>
>> Add the binding for the display subsystem (MDSS) found on the Qualcomm
>> Nord SoC. Nord is MDSS 12.1, DP-only (no DSI), with two independent DP
>> controllers.
>>
>> Signed-off-by: Mahadevan P <mahadevan.p@oss.qualcomm.com>
>> Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
>> ---
>>   .../bindings/display/msm/qcom,nord-mdss.yaml       | 98 ++++++++++++++++++++++
>>   1 file changed, 98 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,nord-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,nord-mdss.yaml
>> new file mode 100644
>> index 000000000000..0b0cacdca9db
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/display/msm/qcom,nord-mdss.yaml
>> @@ -0,0 +1,98 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/display/msm/qcom,nord-mdss.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm Nord display subsystem (MDSS)
>> +
>> +maintainers:
>> +  - Mahadevan P <mahadevan.p@oss.qualcomm.com>
>> +
>> +description:
>> +  Nord display subsystem consists of MDSS (display controller), DPU 1499A
>> +  (display processing unit), and display interface controllers (DP only, no DSI).
>> +  This is MDSS 12.1, DP-only, with 2 independent DP controllers.
>> +
>> +$ref: /schemas/display/msm/mdss-common.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    const: qcom,nord-mdss
>> +
>> +  clocks:
>> +    items:
>> +      - description: Display AHB
>> +      - description: Display hf AXI
>> +      - description: Display core
>> +
>> +  clock-names:
>> +    items:
>> +      - const: iface
>> +      - const: bus
>> +      - const: core
>> +
>> +  iommus:
>> +    maxItems: 1
> The DTS in downstream repository doesn't seem to agree. There is two
> items for iommus.

I checked the Nord IPCAT. the resulted SID is same for both the SID 
(i.e.  0x03e0) in downstream repository.

I think we should update the downstream DT and use a single SID entry.

>> +
>> +  interconnects:
>> +    items:
>> +      - description: Interconnect path from mdp0 port to the data bus
>> +      - description: Interconnect path from CPU to the reg bus
>> +
>> +  interconnect-names:
>> +    items:
>> +      - const: mdp0-mem
>> +      - const: cpu-cfg
>> +
>> +patternProperties:
>> +  "^display-controller@[0-9a-f]+$":
>> +    type: object
>> +    additionalProperties: true
>> +    properties:
>> +      compatible:
>> +        const: qcom,nord-dpu
>> +
>> +  "^displayport-controller@[0-9a-f]+$":
>> +    type: object
>> +    additionalProperties: true
>> +    properties:
>> +      compatible:
>> +        const: qcom,nord-dp
>> +
>> +  "^phy@[0-9a-f]+$":
>> +    type: object
>> +    additionalProperties: true
>> +    properties:
>> +      compatible:
>> +        const: qcom,nord-dp-phy
>> +
>> +required:
>> +  - compatible
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/qcom,dispcc-nord.h>
> Please run dt_binding_check against mainline kernel where the header is
> actually qcom,nord-dispcc.h.

Ack, I will update according to mainline kernel.

Thanks,

Nabige

>
> Shawn
>
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    #include <dt-bindings/power/qcom,rpmhpd.h>
>> +
>> +    display-subsystem@ae00000 {
>> +        compatible = "qcom,nord-mdss";
>> +        reg = <0x0ae00000 0x1000>;
>> +        reg-names = "mdss";
>> +        power-domains = <&dispcc_gdsc>;
>> +        clocks = <&dispcc DISPCC_MDSS_AHB_CLK>,
>> +                 <&gcc GCC_DISP_HF_AXI_CLK>,
>> +                 <&dispcc DISPCC_MDSS_MDP_CLK>;
>> +        clock-names = "iface", "bus", "core";
>> +        resets = <&dispcc DISP_CC_MDSS_CORE_BCR>;
>> +        interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
>> +        interrupt-controller;
>> +        #interrupt-cells = <1>;
>> +        iommus = <&apps_smmu 0x800 0x420>;
>> +        #address-cells = <1>;
>> +        #size-cells = <1>;
>> +        ranges;
>> +    };
>>
>> -- 
>> 2.34.1
>>
>>
>> -- 
>> linux-phy mailing list
>> linux-phy@lists.infradead.org
>> https://lists.infradead.org/mailman/listinfo/linux-phy
