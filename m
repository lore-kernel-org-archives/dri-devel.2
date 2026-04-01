Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3BA710FCAE6
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 21:19:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 406F910ED38;
	Wed,  1 Apr 2026 21:19:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="HG6A0XHg";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BlVv7odo";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B8B610ED38
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 21:19:08 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 631J6tIu1045902
 for <dri-devel@lists.freedesktop.org>; Wed, 1 Apr 2026 21:19:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MFIuY4/3MQgVWulfNuG870ap3FwBWrkYASAoWuf76ww=; b=HG6A0XHgM4NikeWw
 iuQ4XvQ/3a2P3x1LZcqrAKSUezJhEAH4I3qnlwSeX924GFzDH9XVZiBSyKJg7hOc
 6t+47w1hJXPxqtN6QPksN5ErCpENlVZ9YkxPwk82hHPMGDk+K+9zaJ3HlPGX0XCY
 ZMD4ggJ1YIxSyKQ7cypdcYMMF/Vz+PQpzrFED2CCNWUzc/EjWuYh8ssFWVWg9DVo
 oEJVKezHZOUl49KssKIVDmjTfPqtf+6jWG0A2BlOZ596OslQsxqaDtRSfCm+A1vX
 9CrDqpK6Y6vKOuVfYR0wC7OFCQBc6kgxt8pA9erR8vjTWqP4RoHoVS4BE2X5bVrm
 PJctWQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d95119nbq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 21:19:07 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-82c8768a704so90704b3a.3
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 14:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775078346; x=1775683146;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MFIuY4/3MQgVWulfNuG870ap3FwBWrkYASAoWuf76ww=;
 b=BlVv7odo1dUhUleaDIZek1wd8rsMDAcFCEUqAigkeX6+E449TROqCrBkU3UnLc/k9g
 v6U6/FchBeZQBIJxYZ5EwcRwvBn7xcPVm6Zr5SYjmullmhBioOkfeqBEPm0TvxIpT8MC
 dKz8QTG4TmDPh0pEsKGHUHaw31ljuTtUoshqB+hY1AdutGnDxTDAkp+WXZzDbul/imjr
 H4640KYs+miFm8BZLyPkdDbDrNt+/+DTC2QtnqAEHO/xwiN1AdohEfmndkF31l/vw0Iq
 wkgMUY+DAkR3t5abwSkxP1FOfWl0d93PxK5VYEUBZyDw6oCUl2nKN/0VAkTvTfGflFT9
 BCPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775078346; x=1775683146;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MFIuY4/3MQgVWulfNuG870ap3FwBWrkYASAoWuf76ww=;
 b=Qh/a9txZVvKwujw559WyHVFnihHg/Lf59yoQKgCcxEROaj6gU1ll+r/4lbWCtWCUUF
 CoSpImroMq5SWKaIMi/x3WssOZivnLYgIS0oYfi1KOIZ0DBhPdNz+onSRhQSkvYqagMb
 S6831GqlBab1NRi4Ves8Ys1i897S369Ch9aFQUGl9DigTUq9wbbIzJJI20GkjgXsYS54
 3spn7QJHt7RP0INNi29xB5FFCNcLaWKI2U4ZwNwQW56onyH7TXfzP8o6bdP68LAKOYbq
 dryREsjG7b/k10N+Xy4R7WTfBZBkm0WWdkln/ulNFM+YukoJtSDxaHxNiEHWT6pay5Dk
 4VjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhHG6S/zaS4cRhuFh5m7Wd6ABg6z9ayH1Sb9fGtS8F7EBIpGbmTa75fkVSdXr2MsQtCoep218YfMo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyI50aOQRfm4OmsBTBg3A3xs/qXAA353tWTmGNZqoQmQopaXnia
 WYyVQX4KItmImVsjP2o9t7yT6SZaVzC5T3SIYAsxaiFb0rYhSKLmi52bpHjg4fEVG7cML+p8Qja
 rZA2/9iVV8JmrTrd/7Te3P6YgSf0ySO2Q3mQB1ePQ1UuWBb3+kgGT7BNpGiRDaDXbXvXxq/Q=
X-Gm-Gg: ATEYQzwzr5Rei4sX7kk+uwlpOFwckwxg1hjDRFo3Gs+jC3QV3qKx2gsmT/SpdWWeCam
 wwd+tTFmIYNwon6FhetbD2J2ieC9tHfW1/ffKXIn0jODeNqwdAGekTEV1Nhpyd2kRo5z1qjV1zU
 IfrJ35o5qIvok3sznqdwGr9IeZKRpfgq1MDc/byl8su+7JkPrQCDYq8tGiDqv8i01eMkTQ1ljfZ
 lZWwDQ2rakfieDTXs08BX1Kyd4aHreVvwpWQGTcfUUK84b3kB9IYwDxODJSja2z2SuirYrhjzcw
 VmAmRq7LjBea4hTOMS341iHDTTL3JVfQUZSDhB+id/Y1gzrAtswju+4dJg/ZjG9dQl1SJTQovuY
 /ICWwo+dcAK5YE6r5I6z625m0bno1ClXrKCH3Zlzsv5FIgw==
X-Received: by 2002:a05:6a00:2d98:b0:829:8942:2ca4 with SMTP id
 d2e1a72fcca58-82ce890ea64mr4893849b3a.19.1775078346177; 
 Wed, 01 Apr 2026 14:19:06 -0700 (PDT)
X-Received: by 2002:a05:6a00:2d98:b0:829:8942:2ca4 with SMTP id
 d2e1a72fcca58-82ce890ea64mr4893811b3a.19.1775078345645; 
 Wed, 01 Apr 2026 14:19:05 -0700 (PDT)
Received: from [192.168.1.9] ([106.222.231.116])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82cf9c41b8dsm776662b3a.34.2026.04.01.14.18.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Apr 2026 14:19:05 -0700 (PDT)
Message-ID: <6a3eb07c-4771-4e4c-a4eb-9bdab874c0ad@oss.qualcomm.com>
Date: Thu, 2 Apr 2026 02:48:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/4] Support for Adreno 612 GPU - Respin
To: Bjorn Andersson <andersson@kernel.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Jie Zhang <jie.zhang@oss.qualcomm.com>,
 Qingqing Zhou <quic_qqzhou@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Jie Zhang <quic_jiezh@quicinc.com>, Rob Clark
 <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jessica Zhang <jesszhan0024@gmail.com>,
 Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
References: <20260312-qcs615-spin-2-v8-0-fca38edcd6e6@oss.qualcomm.com>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260312-qcs615-spin-2-v8-0-fca38edcd6e6@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDIwMCBTYWx0ZWRfX8umSpFnyzXRM
 YlZh50wuCmLgqDlu/rpJk6WWUMi59vVfOa8psSagU0mRbEstbyILA5qRdF+TJoe6ngO+mOj5OIK
 Azx+rxMUvF8oAYM00fD0LB19mllXNf3V5T/DLcAw0rizYMi6+tJmisWn3o5m/TN+lSRk31sWhTp
 SuiMJ3B/21ETE5fZbn2ME6q+JXWfMQjUz5oI0WqPwc2XzPdT40K0BbiFdXhYxrhBRHXOXcEOAmL
 ZBBDNfzhGu5j9ubBrA7o1XwBCXheMlD1jQiOjaEoRPlPh05v3JYPgY6TptSE1ySbH+8vcOOV/wt
 MqgVxw7Xdo0j4W7ISW2HiOnNcJw8XFbhpaUv9VwCKExHdyZLKWTP4Q/rDEHUI5oGbR40hSbipQS
 FgmvYo+HK73uEI+xbykqBwzeB5ti7HgBs76sXXCePvAm6KrVzfMXtOSv/koU/EEkeKATKi6rpJT
 kWVrrUgceK4JA/BXxJw==
X-Proofpoint-GUID: me1-bwqqQWMfmIUvBeeiktXxe6AB86Zo
X-Proofpoint-ORIG-GUID: me1-bwqqQWMfmIUvBeeiktXxe6AB86Zo
X-Authority-Analysis: v=2.4 cv=F8pat6hN c=1 sm=1 tr=0 ts=69cd8bcb cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=YUf46QchBRIYdusOZX0V1g==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=kFibZDKCZPP84u6MAsYA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_04,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 suspectscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010200
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

On 3/12/2026 4:39 AM, Akhil P Oommen wrote:
> This is a respin of an old series [1] that aimed to add support for
> Adreno 612 GPU found in SM6150/QCS615 chipsets. In this version, we
> have consolidated the previously separate series for DT and driver
> support, along with some significant rework.
> 
> Regarding A612 GPU, it falls under ADRENO_6XX_GEN1 family and is a cut
> down version of A615 GPU. A612 has a new IP called Reduced Graphics
> Management Unit or RGMU, a small state machine which helps to toggle
> GX GDSC (connected to CX rail) to implement the IFPC feature. Unlike a
> full-fledged GMU, the RGMU does not support features such as clock
> control, resource voting via RPMh, HFI etc. Therefore, we require linux
> clock driver support similar to gmu-wrapper implementations to control
> gpu core clock and GX GDSC.
> 
> In this series, the description of RGMU hardware in devicetree is more
> complete than in previous version. However, the RGMU core is not
> initialized from the driver as there is currently no need for it. We do
> perform a dummy load of RGMU firmware (now available in linux-firmware)
> to ensure that enabling RGMU core in the future won't break backward
> compatibility for users.
> 
> Bjorn, I have rebased the pending DT patches on top of arm64-for-7.1
> branch to make it convenient for you to pick them.

Hi Bjorn, Gentle reminder to pick up the last few pending dt patches in
this series for v7.1.

-Akhil

> 
> [1] Driver: https://lore.kernel.org/lkml/20241213-a612-gpu-support-v3-1-0e9b25570a69@quicinc.com/
>     Devicetree: https://lore.kernel.org/lkml/fu4rayftf3i4arf6l6bzqyzsctomglhpiniljkeuj74ftvzlpo@vklca2giwjlw/
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
> Changes in v8:
> - Rebased on top of arm64-for-7.1
> - Link to v7: https://lore.kernel.org/r/20260121-qcs615-spin-2-v7-0-52419b263e92@oss.qualcomm.com
> 
> Changes in v7:
> - Drop msm driver and dt binding doc patches as they got picked up by Rob Clark
> - Update interrupt property to use 4 cells
> - Rebase on top of arm64-for-6.20 branch in Bjorn's tree
> - Capture trailers
> - Link to v6: https://lore.kernel.org/r/20251231-qcs615-spin-2-v6-0-da87debf6883@oss.qualcomm.com
> 
> Changes in v6:
> - Move the rgmu register range update from patch#8 to patch#6.
> - Capture trailers
> - Link to v5: https://lore.kernel.org/r/20251226-qcs615-spin-2-v5-0-354d86460ccb@oss.qualcomm.com
> 
> Changes in v5:
> - Rebase on v6.19-rc2
> - Make the reg list in A612 GPU's binding doc stricter (Krzysztof)
> - Link to v4: https://lore.kernel.org/r/20251204-qcs615-spin-2-v4-0-f5a00c5b663f@oss.qualcomm.com
> 
> Changes in v4:
> - Rebased on top of next-20251204 tag
> - Added a new patch to simplify gpu dt schema (Krzysztof)
> - Added a new patch for GPU cooling support (Gaurav)
> - Updated the gpu/gmu register range in DT to be more accurate
> - Remove 290Mhz corner for GPU as that is not present in downstream
> - Link to v3: https://lore.kernel.org/r/20251122-qcs615-spin-2-v3-0-9f4d4c87f51d@oss.qualcomm.com
> 
> Changes in v3:
> - Rebased on top of next-20251121 tag
> - Drop a612 driver support patch as it got picked up
> - Rename rgmu.yaml -> qcom,adreno-rgmu.yaml (Krzysztof)
> - Remove reg-names property for rgmu node (Krzysztof)
> - Use 'gmu' instead of 'rgmu' as node name (Krzysztof)
> - Describe cx_mem and cx_dgc register ranges (Krzysztof)
> - A new patch to retrieve gmu core reg resource by id
> - Link to v2: https://lore.kernel.org/r/20251107-qcs615-spin-2-v2-0-a2d7c4fbf6e6@oss.qualcomm.com
> 
> Changes in v2:
> - Rebased on next-20251105
> - Fix hwcg configuration (Dan)
> - Reuse a few gmu-wrapper routines (Konrad)
> - Split out rgmu dt schema (Krzysztof/Dmitry)
> - Fixes for GPU dt binding doc (Krzysztof)
> - Removed VDD_CX from rgmu dt node. Will post a separate series to
> address the gpucc changes (Konrad)
> - Fix the reg range size for adreno smmu node and reorder the properties (Konrad)
> - Link to v1: https://lore.kernel.org/r/20251017-qcs615-spin-2-v1-0-0baa44f80905@oss.qualcomm.com
> 
> ---
> Gaurav Kohli (1):
>       arm64: dts: qcom: talos: Add GPU cooling
> 
> Jie Zhang (2):
>       arm64: dts: qcom: talos: Add gpu and rgmu nodes
>       arm64: dts: qcom: qcs615-ride: Enable Adreno 612 GPU
> 
> Qingqing Zhou (1):
>       arm64: dts: qcom: talos: add the GPU SMMU node
> 
>  arch/arm64/boot/dts/qcom/qcs615-ride.dts |   8 ++
>  arch/arm64/boot/dts/qcom/talos.dtsi      | 149 +++++++++++++++++++++++++++++++
>  2 files changed, 157 insertions(+)
> ---
> base-commit: bb4d28e377cf04fbee8a01322059fa14808cdfe9
> change-id: 20251015-qcs615-spin-2-ed45b0deb998
> 
> Best regards,

