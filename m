Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2872FD5F87
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 07:26:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BE3D10E54A;
	Wed,  8 Apr 2026 07:26:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="D5g2CpXR";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HATcsAKV";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAEB910E548
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 07:26:34 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6385WDTm1006023
 for <dri-devel@lists.freedesktop.org>; Wed, 8 Apr 2026 07:26:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NHy+iMr3Xqnr1XEITbbqSi8Jils/yDblCvPpvjVgONo=; b=D5g2CpXREiB8xYvp
 gQYIZLSZAb4UPRwCpFw07wMuDmOY4Y47vWCtOtPVzhoYS0AcFT6MXfCbGec4BNvO
 lEOfSfzOOvtn0UnrJ/SGp18CRgthWEiZIt/5cv6BBybRtlCObEfh7I9eJA+lR6t/
 aBtzO/8RQ9c403MUYNlT1JnfUGniPelMZcMbj5h5ZTLDyQzQxWpq5rkdnqIJDXO/
 xdU1bM8N3ny2tcQ7swPECrcLEjv6qvCxBkxNu7D0P+eud+mT3YhrKGN25vjLK2KF
 P/OToiPeQOIhO4QdyRTm9iWzKyhmAetkoW7zfSb41t+069PJr66EW52b2oFrJAYf
 P+3gsw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dd7tpa1vh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Apr 2026 07:26:34 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-82cd9fa609aso3652664b3a.3
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Apr 2026 00:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775633193; x=1776237993;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NHy+iMr3Xqnr1XEITbbqSi8Jils/yDblCvPpvjVgONo=;
 b=HATcsAKVXZCR0AaW4U0dKqolnGOnPAeztXyrM6OkxhsRug4xDOc1ceKpiRbyNSHdIj
 +lDtTbNPBBbbh8Ax+//7u8zLy3hrOfURF3wlT/0TBo3j4zdrcQamb3f85bP/tBi/P2DP
 yRWeFO9OHQLPAoOyGIZlpAjZd14rOsInnEARJJKVB537Mo6nqI90a9tqL2+EE7GDAzqg
 2HQGdhtfJO50913fGbkd32RR0JReuS/ZCEo85ocDfSe5QnZzcCekugHL76t7OywcGTDi
 iW30dUX9xlsNoWTmOe0xqKO2pUxF0pgmtyQsd3XVdPR+8H9hCJ+MYQ9VDQCY3/zg15wu
 Vizg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775633193; x=1776237993;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NHy+iMr3Xqnr1XEITbbqSi8Jils/yDblCvPpvjVgONo=;
 b=Ru1OG/nA26cp89lHtYPAQyI0+LN3NgT5hwiSFvUwdJNX9FA7u1XYmw0YqU+00w+4/u
 MErVYqmqmfkunGizU5Dh8ZmUABJoGatUr+/srmSebdkBVEE1mygDBfXLvYpFw7TFCeWn
 n+dBbAAUamkizaZVrd2kYC88WPywUE1n6f/oAGeUSFAzVEQi9dMoBe6otim/N5BKg4AW
 bwhn7tvvoaipPLSFwPx1zPZsXlDu1Xpv0uz5+KNPrIqHQYYd8epanxaLwcu5y4Pqf1aL
 DjpRQSq/crrAye5cKuDr+YDcseJG+ZcXOGQ1NX2+hu10BqFDLK4M4KB0VBFNCGbxBsnp
 p5kQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1afemXb/6g43n8WVMdO+/fW8n5cTwkEyMhM3OoSeNCLkWtEiBQ4nh3no7H/Zg6PAFNySWNdxLUW8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw0d5f2nGNB9zQouHGX7mM90dGk0vIvngRA+ehANyCVzIuYhxRO
 uuq3yLgmj2+x2xSF1d0A7vDjuQwEJRRQzOW9b/cPLd4AiHe7BAbnrm8qoEdVhEBxqXofi7AQRrA
 8Fdu4A7gqxttTpZw/0QkEzualySJ5S44kVzMRBkcTryA/rgg7jX0t+8V0VxtCrp3D4eemvFM=
X-Gm-Gg: AeBDievxGwrJxgvgEXTcSoyD435Kr15KFH6zz70q6Qg34fPRCf5Ckr6Kwpq6PMPWWeH
 QeeGCYv7iSYKvq7nzMmfP3n2Oo3dlJ9Kbnf4PKXDLaXOrxZtWwtqKQJ+b5nJk9CB8fxMy3+U9gd
 m8JqVFIgwJbxF0nPAEkvo+a1e9ieKv+ca7Tz1nnyra4YQTIhqLHsNT3wjEwZXxSE6H896FZckSp
 HRaV/nYK19gXvaTQRuo3/mUCHKXzyS1YBbeUhtJiqU3YW9WQaOUM0II9s2HIfAHk0Dno3nxwWwM
 ihJuUogbxn8qz18TY5lvsw6aiKQuEDwbKpruUv6RGIq7fxN5fluOSgzX6GA17bKQGpV1ojaZmmO
 lfkKHEYrLoyh5HXbTIG7XHbf6FhQr3qm1WaNKREP/eXCV6DbPjQ==
X-Received: by 2002:a05:6a00:ad08:b0:82c:77cd:50e1 with SMTP id
 d2e1a72fcca58-82d0da993b4mr19225537b3a.20.1775633193558; 
 Wed, 08 Apr 2026 00:26:33 -0700 (PDT)
X-Received: by 2002:a05:6a00:ad08:b0:82c:77cd:50e1 with SMTP id
 d2e1a72fcca58-82d0da993b4mr19225502b3a.20.1775633193088; 
 Wed, 08 Apr 2026 00:26:33 -0700 (PDT)
Received: from [10.217.217.198] ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82cf9c68273sm24431255b3a.41.2026.04.08.00.26.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Apr 2026 00:26:32 -0700 (PDT)
Message-ID: <404ca234-1bab-4094-b7dc-c4d0b072d929@oss.qualcomm.com>
Date: Wed, 8 Apr 2026 12:56:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] clk: qcom: gdsc: Add custom disable callback for GX
 GDSC
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Abel Vesa <abel.vesa@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
 Imran Shaik <imran.shaik@oss.qualcomm.com>,
 Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org
References: <20260407-gfx-clk-fixes-v1-0-4bb5583a5054@oss.qualcomm.com>
 <20260407-gfx-clk-fixes-v1-1-4bb5583a5054@oss.qualcomm.com>
 <6149513e-2c0f-4f01-a467-b4a213d65609@oss.qualcomm.com>
Content-Language: en-US
From: Taniya Das <taniya.das@oss.qualcomm.com>
In-Reply-To: <6149513e-2c0f-4f01-a467-b4a213d65609@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: -7ZuE9dfyEOwhloN9vD_gYK8wvwBYeBi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDA2NiBTYWx0ZWRfXxFsR4nnNiu0m
 VWbnKEq1XT5ivezgwJapFQ3wHPgmQUE9wUAKokVFTQJGjjPgM50e/9rbhFv4V/7en7McHRbVttb
 k/0WhjSyR4InbsEeMOqwNu7bnFmHDpv4hVLAQASEUa8tOFZeGP8wTbvFmkQiJ0EiKkpTmQcYKHu
 wzCKn2sQ6iwv4ll+/3grQUA3TPIVyySoGkoWdY9Ti/nBDUvTM+irijs9cpsBcFcqMdZuYeXnokR
 fOc/tWmhBOwsGZ75U2gMe5M9xigJFwmf+KDZ62fla51M0OCey3IdcBtdcs2ttHivNiOIhYKxupJ
 MCD7r0+HosQAxIiHCnt6l/LzaQrJEV0QZqEnjk0S6+jDFxFJZO64PfoMvzpOZsjeRwNnue4FLTn
 ViimqEf24vRQJm2JHwueJK92dw23YI/5LQOMvCUT7EyYacbCSWol+KideBG14v+4IgLXZSSStBq
 OC+X3vjZ+KGzsmAQx+g==
X-Proofpoint-ORIG-GUID: -7ZuE9dfyEOwhloN9vD_gYK8wvwBYeBi
X-Authority-Analysis: v=2.4 cv=DNS/JSNb c=1 sm=1 tr=0 ts=69d6032a cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=RnFGxym7J1TeeuKG4B0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_03,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 clxscore=1015 bulkscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080066
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



On 4/7/2026 4:26 PM, Konrad Dybcio wrote:
>> @@ -675,3 +675,25 @@ int gdsc_gx_do_nothing_enable(struct generic_pm_domain *domain)
>>  	return ret;
>>  }
>>  EXPORT_SYMBOL_GPL(gdsc_gx_do_nothing_enable);
>> +
>> +/*
>> + * GX GDSC is a special power domain. Normally, its disable sequence
>> + * is managed by the GMU firmware, and high level OS must not attempt
> nit: "and high level OS must not attempt" -> "and the OS must not attempt"
> 

Sure, will update in the next patch.

> 
>> + * to disable it. The only exception is during GMU recovery, where the
>> + * GMU driver can set GenPD’s synced_poweroff flag to allow explicitly
>> + * disable GX GDSC in hardware.
>> + */
>> +int gdsc_gx_disable(struct generic_pm_domain *domain)
>> +{
>> +	struct gdsc *sc = domain_to_gdsc(domain);
>> +
>> +	if (domain->synced_poweroff)
>> +		return gdsc_disable(domain);
> Can we use this version to replace gdsc_gx_do_nothing_enable() too?

No, Konrad, the enable should be always a no-op in every scenario.
synced_poweroff can't be used to handle enable of GDSC.


-- 
Thanks,
Taniya Das

