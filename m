Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D933C5DF81
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 07:47:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FDB510EF28;
	Thu, 20 Aug 2026 07:47:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="agAReysm";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="en8Ex+wm";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 250A510EF28
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 07:47:08 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67K6EPK3491129
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 07:47:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FWemyG4N4ylx8AJN2NYbSRutWHMPkhp+MiTGTIekUm4=; b=agAReysmKjIortik
 PpCcf6FrLsBAFvE0L36aRTnWYqI+2R+0kYuY77jU6VmYzah32kclW2u3mzNnW8OX
 M4+9abOckXZ1aVh+cheNvogAjrVtl5op3ScbA0oxs18pLFQwmFZE6u51IDK3nA0V
 AG+BpfPw/uMiNl8Yigark5SmCr0wq6OIJNBtOFYchSOdgDrWOYtfRm0wgHhG8P0F
 Nd7f2l8UBeQtWDILlHMdk5SsvsbCe5cdm/C7McjEZwwhXr74nCvTNoZUMehQUS8C
 CGb+yjf1tzdvKdaGaJCxvSQ0UEV5ECe7kaMsaZgJrhH0B1p1NOSSnOcAR84qe4Wt
 87Yieg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5ervktyj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 07:47:07 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-9080b7b2f2bso20090226d6.3
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 00:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787212026; x=1787816826;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=FWemyG4N4ylx8AJN2NYbSRutWHMPkhp+MiTGTIekUm4=;
 b=en8Ex+wmeR9sltzhRDFit9satoJDPYN5Az8u7QfRZVlNRXE+18C56jVfRXnsTaZ2st
 10BuK0b8KZ5xp00k/A2j1roBdir3KEzvQrA6YjRuZNF+n5oHytqFUdWwzp44yaye9yWW
 WJ7DFdk8nW0cLF70/nMKsTbfwlf8MqsrvfeS9lQ4BsEueD5QcLw+JNK2zJRhLhBvasC6
 MPzTwt3fMLDT28ehB1CO31AExfl3cv+ZOL+tbbdCshrld0eMRLUYrjQrzPioo95MvooZ
 3OYEXl/31Ti06nIPpOWSh3spkluCZGm/P9BZPjibFC6p35hsRcyvq+0TOWqlSkgqmKt+
 0/LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787212026; x=1787816826;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FWemyG4N4ylx8AJN2NYbSRutWHMPkhp+MiTGTIekUm4=;
 b=onGV2INYk0EUiBnD/1GfhzTxrsjT8JjbBVflw44503zCdo6wvuJIZERYosyC1YBkvo
 yKudNKCTi01EAqRgq/Dxp6/+0Xq1ccQ0ZftDMN6ZN2V/LghG+pk/wrV8gldO2nN5RhBZ
 blVJi30dT3X/UdC5iJFiwuYerzyy70M9RAxgRCDcGmZOZL6wc2zVA2BsW9s+bHB5Ik+2
 1QYjsggUMwIaGWABrot7xmznLjbLvVONSr9qbSY8U5LTWmkm6UgFB+34uhF5nzI93vRD
 mjg9Le64kbJ4U8DUa5mfWB7qzc6xvlZ05cvxm6DAs+enw6pAI5+TQx4tWqE72OdEWihZ
 emZQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpfrIPHsrrfzHN+8LlKJrZ01RfJhuZ5xbExm+UEE7sQ+vJkssVP5We65TAUdOc/ZEV+OPs4D0rOS+A=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyeVssfn8nKE2Bm8lt8CLLC8/zydsPFT3/6fIkix4CtyUhX/DVY
 YwjLxuCcapir0KPhHpy68oovVboEJOYhxrzGpLDP7tN/pI7CAqacLydpSGhD6/p9rQIrm6SOdO3
 OU1q1Y9mey/4X/X8Qc9Usyfz6zxXHJ9bzMQi0AnkqX28ew5/TFqtn3RjXRDt8fC0ozVEIX64=
X-Gm-Gg: AR+sD107IVRWdbcGTPnKLnIQEPa8+egE2ZGJT+otOXMKAPhBdvehxUWNKa7P+lQvvW4
 RLiVQfAc5wgHiCT6JX99HYRKvvqXytwunTQcD5p4NKMY5B4Zj5ikCLqgrWWfGjaG9adI+RCeImB
 8R4FKUmtspMA6XJALcHqYdAWn3UGNTd0ll0SiBkicLFJTGuKIxa/aGpvi7lgVEiCZ89uY9t2IWm
 YodmQnJtqTXSKjNGutvkyOrQRpK/YCF6gjtXlZZ4uzTkxGz4gNdNJELELofc7Ra/nixaRzwhDwl
 W+Wdi6Ol4z79wKXlkuHY4k+MmWfePq2XyYVXz+/SrPO81Ci+SjvTm5mPI9mxGK5PSpsOTwM9sAj
 4TNwEW1x1QpOzPQfDBAZLNdDsVS27
X-Received: by 2002:a05:622a:2b4b:b0:51c:a70:5ed with SMTP id
 d75a77b69052e-52dd5c9313dmr98105211cf.30.1787212026515; 
 Thu, 20 Aug 2026 00:47:06 -0700 (PDT)
X-Received: by 2002:a05:622a:2b4b:b0:51c:a70:5ed with SMTP id
 d75a77b69052e-52dd5c9313dmr98104821cf.30.1787212026125; 
 Thu, 20 Aug 2026 00:47:06 -0700 (PDT)
Received: from [192.168.1.110] ([178.197.219.214])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aa0dd5fcsm133844445e9.14.2026.08.20.00.47.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2026 00:47:05 -0700 (PDT)
Message-ID: <0f8f3d24-41ec-4878-8182-c805c7db7c23@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 09:47:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 04/12] dt-bindings: npu: rockchip: add
 rockchip,rk3576-rknn-core
To: "Rob Herring (Arm)" <robh@kernel.org>, Jiaxing Hu <gahing@gahingwoo.com>
Cc: linux-kernel@vger.kernel.org, tomeu@tomeuvizoso.net,
 p.zabel@pengutronix.de, ulfh@kernel.org, will@kernel.org,
 conor+dt@kernel.org, chaoyi.chen@rock-chips.com,
 dri-devel@lists.freedesktop.org, zhangqing@rock-chips.com,
 linux-arm-kernel@lists.infradead.org, joro@8bytes.org,
 devicetree@vger.kernel.org, iommu@lists.linux.dev,
 linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org,
 krzk+dt@kernel.org, alchark@flipper.net, ogabbay@kernel.org,
 royalnet026@gmail.com, diederik@cknow-tech.com, robin.murphy@arm.com,
 heiko@sntech.de
References: <20260817113603.1436067-1-gahing@gahingwoo.com>
 <20260817113603.1436067-5-gahing@gahingwoo.com>
 <178709455518.1014304.1443906758035976924.robh@kernel.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <178709455518.1014304.1443906758035976924.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: y4A_VtWm_hXgdDk5r305xA4sy00aIKDd
X-Authority-Analysis: v=2.4 cv=VZ3H+lp9 c=1 sm=1 tr=0 ts=6a86b0fb cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=+bKQE0WJfmhK2875HamI0Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=9GNsruGHAAAA:8 a=EUspDBNiAAAA:8 a=SdGosrV6Qt3YffhYJa8A:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22 a=gf-oSkQAjqHFJRp-GQfY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDA1NSBTYWx0ZWRfX3ERQAsHjEoqm
 GqaoxS4a3NnvrNPojFNDvTrtKPewE8IL7ckQf2umwhB8bVjXhnjpd3me5B9ec4yjG3yGq2Xcg4P
 9BEWxOae1pLn5P/QoVf1HaJDjgiJ5EMUyBCpodlBd14SKmaq1NXvJ37SrELbJqi73168Rjh7JFr
 CX8d+tnm4tIJjKvzd8Ydqan4gGsTOEFOHyFn1j9OfgbZ4KE4j7aj7pAo5/5awQMssNDHXvMABR7
 ay1O4R45e1pTLw9wZaJLzSREQGULc6JCjMBeruHXfpRFk2zoOVOBkSllI9jdncXLXj30Hvtn6e2
 jFF9R1Oig+qNCWK47qLguAwKovNkwKBqj81nrVX5UUsKormpW07F4fakh1E/RbKPJnfiFvs7Vuv
 gw+ZcT+u2rWTqkzNztrWBQfxLK3DXWLDAdvhmhYbAyk0yHleVIjasq+8IbCI5eBEaSkX/gIKeLN
 i4oP8Jiac81fURpAM9Q==
X-Proofpoint-ORIG-GUID: y4A_VtWm_hXgdDk5r305xA4sy00aIKDd
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDA1NSBTYWx0ZWRfX39Fc81zN6CQ6
 v6f2OsBnjzGm1V8kqcynFr3M2pIjdFb4+mwKepgoFUeI9XuREDh3FOQOu1+z4tJlituQD5ZBjlK
 4HsGdkJ257hSvtUyQomBMHLuIk6lpY4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608200055
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

On 19/08/2026 01:09, Rob Herring (Arm) wrote:
> 
> On Mon, 17 Aug 2026 23:35:55 +1200, Jiaxing Hu wrote:
>> The RK3576 NPU has two cores of the same RKNN block the RK3588 binding
>> already describes, but it wires them up differently: two extra CBUF
>> clocks, two power domains per core, and a single reset instead of two.
>> It also has no NPU SRAM supply.
>>
>> Widen the property ranges to cover both, then pin each SoC back to its
>> own shape in allOf so nothing loosens for RK3588, and keep sram-supply
>> required for rockchip,rk3588-rknn-core only.
>>
>> Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
>> ---
>>  .../npu/rockchip,rk3588-rknn-core.yaml        | 47 +++++++++++++++++--
>>  1 file changed, 44 insertions(+), 3 deletions(-)
>>
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml: Unresolvable reference: /schemas/input/qcom,spmi-haptics.yaml#
> 
> doc reference errors (make refcheckdocs):
> Documentation/translations/pt_BR/process/security-bugs.rst: :doc:`regular path submission </../../../process/submitting-patches>`
> Documentation/translations/zh_CN/how-to.rst: Documentation/translations/zh_CN/xxx.rst
> arch/arm/xen/enlighten.c: Documentation/devicetree/bindings/arm/xen.txt

Most likely false positive due to other things in the kernel broken.

But just in case - be sure you tested the bindings.

Best regards,
Krzysztof
