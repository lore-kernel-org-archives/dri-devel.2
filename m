Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FECFCA6012
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 10:48:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE3AC10E9A4;
	Fri,  9 Oct 2026 10:48:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="LOosSm7y";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="V76/cd4C";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3CCE10E2F0
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 10:48:22 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6998KJbk1746882
 for <dri-devel@lists.freedesktop.org>; Fri, 9 Oct 2026 10:48:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1z/X9tGm5aE4WYRZZCAENSK6cH/4JbMWNqBqxrfbL3Q=; b=LOosSm7yKO+alq4p
 xcXdKdZ7BFVPTvAS9Xw4HBdBEDKfV7yDDLNZgPoMCS6j5ACC0k6ddntH7emkY9oM
 LAmt7cz/gqQkX/Vc910ZWDBlBv6RCq/zXjGqfjj0YHjc8Lu55SI5PODHeKxES8QP
 ULvgvQz2bdAs9sXfGRPC7y0Ur2OMpeLBcuFWrQBJXrPLrTRfTSAVj8jBCP9clDQH
 D6M9VPLlLKn0MZ1RjNAmHDiERtmffiGg2UVYbSe+EJd6ELr9l1zuLmGAEu/1q47p
 AIghGFOobUraSNoy1yq5dlJnoBUVHF2EiUsj+MfmI4nrkj/WvdwJTFghvEAWvE1D
 y0atkw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6ekvbg62-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 09 Oct 2026 10:48:21 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-88f2b158139so4879440b3a.0
 for <dri-devel@lists.freedesktop.org>; Fri, 09 Oct 2026 03:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791542900; x=1792147700;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=1z/X9tGm5aE4WYRZZCAENSK6cH/4JbMWNqBqxrfbL3Q=;
 b=V76/cd4CMEfZgB5toi2IOoiIUabJvnvSAAIGwcKeFP/UpboQZmAvczdAeq4MZ2F7kZ
 JyOS1MdWm4+1VOyYOlKzWZEgG2SS7cHhr0iljLqM9Qix2NPvts7ToKRdT4iEgumzhqE0
 7KlhrbaZRZiqR2PHFEiunlI/VL6vHolpB4GAZW97nDRJ7uL8hUQxGN9H2cXiOysEPv1x
 M1MYDU1USr/rPFoGaRtfIwWmy4E7p+9nBftwSkTeJrEK+ypLfx4Oum2m9uctgULHtneN
 C4U74q9CCEHyPwuPJOnyhhnJDpLhKjUo5f4yuuBh/vFc11d5FXtJEhtMlJ14L74c6XnL
 +x2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791542900; x=1792147700;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1z/X9tGm5aE4WYRZZCAENSK6cH/4JbMWNqBqxrfbL3Q=;
 b=nMYwwsmJf3J6Q/i1Ylwfc3VOfIBXvO6Lasnx/qUPwGljoWFDlKD/gYcuxtIPsTyjnK
 PjuQPDZPaq7f9IAhBBawKExP8xTssoBtQbPmp6pWNYo1uqQ5PJIzX+FkcAasb0VNA10y
 Kjh332lQIk+UGJRTtjbiDFyJTbI/lsE3rH3gLfq3v+pWwvE7BanWJd3c6W7wyOFau6bO
 bc3mCCYXyesPreUTuZ/PxOHZxDGF3cfKok/i+c31bpJK7seuoPAvXiRukX5gIjzeznBh
 ADoVypfWbjhR75WaYYbcWEe5hNZP8LJdpDgler2oJZBMzwlm2Rrpv902sVHwHSCnHb6A
 LUGQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzUHI30/jPgIYpMtopCuTgd+bv6dgbCEwgzg0Wam90Jg9TUqZ9w2u2v4K+Iy/8F1YehlbjujVUnMZs=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLQluDDwBBGDifwoE6cDBjrNFYAlrSkozEMh7Xr8KyncAM0ICI8
 tzLVYSuMRSrFTAZVEdUXTT3v+Do6awLzsjnodndyOl1Df7Ww2K1c1OdsfdVDnAvlfbDfTcVAXfw
 vVjaC0SztsLRQqO5NWOtAMSJfTb7U3K0P5fvH7VmH4gxJZ8JlTrA2Lf6lVrN1M0GryFUhwFI=
X-Gm-Gg: AYBFou0zDySf7DS5ao8owmlxt3Aktt8mjwQe4D4wqN46o06u9rxr5rZUhRawghEIMkc
 RC4ZB+sMIINL7ZahJtiQr2QdUW7e3DEIlecXXkcpTxm6k6J1aDFJ/HdaMJsbm9HE53G2JTwf2Py
 yy7v1SchcG7+ewxu8UGVYE/why3Vm9Zh9UfXlOtCU15o+ReKwYknz8zv2P+wmG1Rwx3rV+TGuFU
 cI2Z4jdywHPdbik9DnLHF8qNX7NZBIZc07SWTPflHr6J+Kl7lt7NYJiTCNwTenqq3pcbXkXm/rp
 GegdFGYW1Xkm+6Y1ZOxH4AewuqHLpMLnhOEhj+dveNzHv8eilr7XTab1d6AyiPmDQPHw6CzY7qU
 dStuE+r7kx6x3eVQxFec/R97nOoJ5wJWhBw==
X-Received: by 2002:a05:6a00:3403:b0:890:b4c2:d7e8 with SMTP id
 d2e1a72fcca58-897c79e0cf1mr1408248b3a.33.1791542900115; 
 Fri, 09 Oct 2026 03:48:20 -0700 (PDT)
X-Received: by 2002:a05:6a00:3403:b0:890:b4c2:d7e8 with SMTP id
 d2e1a72fcca58-897c79e0cf1mr1408225b3a.33.1791542899607; 
 Fri, 09 Oct 2026 03:48:19 -0700 (PDT)
Received: from [10.204.78.217] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-896c3ecb01dsm712832b3a.36.2026.10.09.03.48.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Oct 2026 03:48:19 -0700 (PDT)
Message-ID: <6e7779bc-89db-4ed9-b5b5-bff1dfd968b5@oss.qualcomm.com>
Date: Fri, 9 Oct 2026 16:18:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] arm64: dts: qcom: kaanapali: Add DisplayPort
 controller
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
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
 Conor Dooley <conor+dt@kernel.org>, Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261005-kaanapali_dp-v1-0-6faeac3a6d59@oss.qualcomm.com>
 <20261005-kaanapali_dp-v1-3-6faeac3a6d59@oss.qualcomm.com>
 <e2ng5qasvi7bd2btgbmli6oehn774k57giwzalsyksimgbcf7t@phjas5ymdwgc>
Content-Language: en-US
From: Balaji Kalkonda <balaji.kalkonda@oss.qualcomm.com>
In-Reply-To: <e2ng5qasvi7bd2btgbmli6oehn774k57giwzalsyksimgbcf7t@phjas5ymdwgc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Ui1SQjdqQaoBUhSKfi3JowV6mQ1cqyZG
X-Authority-Analysis: v=2.4 cv=csYOAF4i c=1 sm=1 tr=0 ts=6ac8c675 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=6Q945mz2-PRHoXMB8K4A:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA0MiBTYWx0ZWRfX+TAvCr581fkJ
 Ugjw4d3y7+8ZaIh+n6kD8wA10sRP2ZdniBLTaptj2b/BI0ZVgEIXP5uBP+sjrbeRQb//z17f8Qd
 E4OgYNa8bjrK0N2dxAJvpxmAoojy+SawgnCXB/Whcd+RiOhehke8f98mIEHLdeCsqWlvTZm+IaX
 0PGKBohfMYEaG0JFhV4c6LlN5HsxQrrnrZtJgYEuDcCIn9BlfRTsmbsM/+WAw7KAeHBRllNUcxs
 zLR+zJ3bopTxU1K4yhb/Dfde7XJCk+pwN8dZKS2ekX9IR5CEZ3s52BpPTwjhEyNz+kyKB3VRZw5
 zWSMal7n2JIrRVRr4YbsYHpfpLD0cLxTaISbhZ8sTJzfFtrdls31Yj1T/4B6d21dkG7SOKFQenK
 CLMMkQvOdQBVxK+CIhyvpl4f5Z3Blm3ciKJT+WLESeyaa8EQ0x7fYgvau1LTCtWfhTTUD6KAnkS
 ZNnvnMCIO296Wdj0izQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA0MiBTYWx0ZWRfX+zAkHbtnjeq1
 iBTdOek9xRgV0LcZnm+HcKKl/Rkjy3+JFOwQMV7gKguSsiMl/tsCabEnzwyL4avWhy5Ata3u8ka
 G5TrUB/JvHIMKCSMEeu8fsKe2jCbPCs=
X-Proofpoint-GUID: Ui1SQjdqQaoBUhSKfi3JowV6mQ1cqyZG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_03,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090042
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


On 09-10-2026 02:02 pm, Dmitry Baryshkov wrote:
> On Mon, Oct 05, 2026 at 12:54:28PM +0530, Balaji Kalkonda wrote:
>> Add device node for the DisplayPort controller, its OPP table, clocks
>> and power domain, and connect it to the DPU and USB/DP QMP PHY.
>>
>> Signed-off-by: Balaji Kalkonda <balaji.kalkonda@oss.qualcomm.com>
>> ---
>>  arch/arm64/boot/dts/qcom/kaanapali.dtsi | 87 ++++++++++++++++++++++++++++++++-
>>  1 file changed, 85 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/kaanapali.dtsi b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
>> index e48a179d0722..155c590c8eb6 100644
>> --- a/arch/arm64/boot/dts/qcom/kaanapali.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
>> @@ -3565,6 +3565,7 @@ usb_dp_qmpphy: phy@88e8000 {
>>  			#clock-cells = <1>;
>>  			#phy-cells = <1>;
>>  
>> +			mode-switch;
> Not mentioned in the commit message.
>
>>  			orientation-switch;
>>  
>>  			status = "disabled";
>> @@ -3851,6 +3854,86 @@ mdss_dsi0_phy: phy@9ac1000 {
>>  
>>  				status = "disabled";
>>  			};
>> +
>> +			mdss_dp0: displayport-controller@9ad2000 {
>> +				compatible = "qcom,kaanapali-dp";
>> +				reg = <0x0 0x09ad2000 0x0 0x10c>,
>> +				      <0x0 0x09ad2200 0x0 0xc8>,
>> +				      <0x0 0x09ad3000 0x0 0x78>,
>> +				      <0x0 0x09ad4000 0x0 0xa0>;
>> +
>> +				interrupts-extended = <&mdss 12>;
>> +
>> +				clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
>> +					 <&dispcc DISP_CC_MDSS_DPTX0_AUX_CLK>,
>> +					 <&dispcc DISP_CC_MDSS_DPTX0_LINK_CLK>,
>> +					 <&dispcc DISP_CC_MDSS_DPTX0_LINK_INTF_CLK>,
>> +					 <&dispcc DISP_CC_MDSS_DPTX0_PIXEL0_CLK>;
>> +
> Please define all pixel clocks that are used by the DP controller. Is it
> not MST-capable?
>
>> +				clock-names = "core_iface",
>> +					      "core_aux",
>> +					      "ctrl_link",
>> +					      "ctrl_link_iface",
>> +					      "stream_pixel";
>> +
>> +				assigned-clocks = <&dispcc DISP_CC_MDSS_DPTX0_LINK_CLK_SRC>,
>> +						  <&dispcc DISP_CC_MDSS_DPTX0_PIXEL0_CLK_SRC>;
>> +				assigned-clock-parents =
>> +					<&usb_dp_qmpphy QMP_USB43DP_DP_LINK_CLK>,
> Don't break the line here.
>
>> +					<&usb_dp_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>;
>> +
>> +				operating-points-v2 = <&dp_opp_table>;
>> +
>> +				power-domains = <&rpmhpd RPMHPD_MX>;
> MMCX. If you need to cast a vote on MX domain too, add second entry to
> the power domains and handle it in the driver.
>
>> +
>> +				phys = <&usb_dp_qmpphy QMP_USB43DP_DP_PHY>;
>> +				phy-names = "dp";
>> +
>> +				#sound-dai-cells = <0>;
>> +
>> +				status = "disabled";
>> +

Hi Dmitry,

Thanks for reviewing.

I'll address all these comments in v2.

Thanks,
Balaji

