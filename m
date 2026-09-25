Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C743DC9830E
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 10:19:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27F8210F9BB;
	Fri, 25 Sep 2026 10:19:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="c82dJQwg";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YKaBj4J2";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40B4D10F9BB
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 10:19:48 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68P5JEXj3627535
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 10:19:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ClUZQgHA+YXoNCn8HMzXL9kMN9fbDxeAKcAHr9vfWms=; b=c82dJQwgJaxCKTLQ
 CGw5sM33mKWVibfXzRzB6bWaocYOcqSmaYcVUlPBOU0Pm94fs7khL3sxTkhvXJTV
 BLp3ZpXhyaBDqLwoBcrfHwsONrcOpzlP1kq7itJ9eSx/8ijg7DcXP/kg4s1h/SHe
 pZXE0uocI6UGEPncqyxIWEXqnBiT0QQDx08cO3DZ5JDttsikTgrY5z02mhWkz0Z4
 LcpFQwElqmek6P7cJGMDYcJv9YkyuA+5wCzof2FMhJp/3EtWavc5uu7McB3T04K4
 Komc0yVLl2UbC/QcPOjUa2hFt7pXOY+e2K0IugK/yfrJkgmc/rnKsZmuDFZH0kLM
 iZGhLA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwjq38wr2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 10:19:46 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e661ce1dcso12222185a.0
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 03:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790331586; x=1790936386;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ClUZQgHA+YXoNCn8HMzXL9kMN9fbDxeAKcAHr9vfWms=;
 b=YKaBj4J2DxxgqyjoqdTUrHKu3DReA1Mr9W1mxA7Z2YKFUg2cF7r0Vo1CcMnNDA+ARg
 EYTWGENm5SBikaKW2YDaLpDzsT1pnTer74rnMv+o+4QdTUW8Q65+k9uWKDcYXxmTunA7
 9NsMDiXPS5zHr9PzE7DvauEirRlacHNSq2hIDWCsDC8vKX9oI/VGae46A+tWDBOO4P/2
 vTsqrG6GNCdXmzyn0pgK4CvesBITqDHCNANhlOOYhDmrxvSzrtxaoS7gmWUs9ODxeZVN
 BQCVVrLKA9eVsE7x1E+npexo6zx8UlekiE1h5wO2ppFE9K9GNjXZ9cC+yLtTIsoHdaKg
 NyQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790331586; x=1790936386;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ClUZQgHA+YXoNCn8HMzXL9kMN9fbDxeAKcAHr9vfWms=;
 b=b8LxUZiMSamMhHeiFnQZuKqgtIHd6JRKQu++CoV+WoraWkY8BJACdRCwgAnuicgkF8
 NJ+Z+Pby/OtsGKSB8wW2PPyNkp3r7WmZDdevSRTP/57vwr912fRWdqqA+acNaG3tW9aL
 L3ulWGIRFEs3DiYkux+h1k1ol4TRHCEtr328sJcyMQWwxZkzx7wEARaH1IbvsLJYRnvt
 bH0FoZbmqlbTtKdhaPYESZvvlKC7lJWZN9Yi0fCrGv3MrldBIS7Zris1BYOMDy1Qsa9n
 94j4yCpzji7t/qaZRBLz04ompDDMfJh1nRVVz0tZN1e3YVmudhRqHvxmllQBO9RrSozl
 BBjw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzha4IBwBvMUvKRsGjeSQmWBDPtW0vCnsoYvqIHvEHrks+pV5YoaTWsFjjvgTBUBFCpbIM+Q9T7m4o=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m1VymdKkfqAPjZkWi65s6uoUxZyqmmaBn/iy1Pv6+lBZYF4r68
 wUr5M9SSkiuDWML7D9cnzgoiS7oaDdU18d6YG8U1YWr6Fr4vnnb7G4ctusXKb7HMgq+kOuMkS7D
 RLM7ughFcya2oUdoPXaV3nMOfOVqJfaOXgY8igTksKAmitJNOMuRAK9oLSNXGIfeSUsXiJHQ=
X-Gm-Gg: AYBFou09yikB9ewZmq61cz71tjqNTKzENG+RRfHvHOWtUnpNRk8RsRhRMVDRoxWCEGX
 SZl1PmDVC/tnXIgZClujAbNlRS+YzN8m/2Sq+zJrBngUo1oQ+GZA5D00QrsCkrVaOfSsLnslGqV
 A8cQYHQd5uXwdaiW86OGTSiRJNbLW+znTzuWRnSjB67F+RLu69QC9HgdWdk0PyCyEFhCT3uBlyV
 bLNVdlHLHh/wmOFFHD4WUjiCFkv8CvufWGeD+FhU5Ox03y5WF/BvT1Z5o3llS4qfsdvRO0USpoD
 QNPi57I2M+B6vREgwHKoNRJfSOZTfD1f62NB9p+QExZiG1nEpIoVrlowZA7rOncc5GkxMfkBg0w
 RHbCk77xi2aaQvuGY3E4Tqw==
X-Received: by 2002:a05:620a:6f06:b0:93a:19cc:107a with SMTP id
 af79cd13be357-93c43b941d0mr350438985a.1.1790331586143; 
 Fri, 25 Sep 2026 03:19:46 -0700 (PDT)
X-Received: by 2002:a05:620a:6f06:b0:93a:19cc:107a with SMTP id
 af79cd13be357-93c43b941d0mr350436385a.1.1790331585697; 
 Fri, 25 Sep 2026 03:19:45 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2ae74815easm93578766b.23.2026.09.25.03.19.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Sep 2026 03:19:44 -0700 (PDT)
Message-ID: <6c8c9823-4d22-49b2-9c50-476f61110def@oss.qualcomm.com>
Date: Fri, 25 Sep 2026 12:19:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] arm64: dts: qcom: glymur: fix Adreno X2-90 GMU
 compatible
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jie Zhang <jie.zhang@oss.qualcomm.com>
References: <20260925-mahua-gpu-v1-0-0fa0bfd8d315@oss.qualcomm.com>
 <20260925-mahua-gpu-v1-2-0fa0bfd8d315@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260925-mahua-gpu-v1-2-0fa0bfd8d315@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA0MSBTYWx0ZWRfX71WMEA0sCN8+
 qRER+yGpxEEIJT8rgkPpnBIWCFdWweBjYiNfZTL6nQ+Mg3WFu0b8XSQ3xbyBn7aipHtZd/WXq1E
 g+Jkc10V6bCjpTlm/lLozFCjlBe0Qug=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA0MSBTYWx0ZWRfX1jCmft/Qo4/s
 M4mZ15sMHWfksP2nZIX2h4yC6U6uR6IMJx647NreD8hcYdTumI1ZFR3bQugM1WrJhh/kXFC9Gjy
 SAAw+pKb16gwgRDJGhqgulayOayC83Nk8crLx36la1uLQBoB1OiU+xypQsCKU6AvlTQOJu1Dicg
 fRaXpS8V9xs8bejx76bgKore+UdD0DPjyA7Ft3AsevsEQeb/XdFhBn5C7Ykmg0YuaIjcJWoOjpR
 xYH/3qWctl4UMSrvXlDbQgsSH74TTXjvByJh0byqv9n6AwbOWWGv1AG2No3C4+FFWfAoAIlLVjs
 HmsJoVUIeDiXkWEM+v7PJmFIGZP4I5HzA4AuIiaJpYMJc550sbnGsS8sIfzjJQSobNm3Q0aO8ZD
 OfwIUt/LknHl9dM8iZ/hH3vmqbf7CAMXb1ehLBFFsp0zihhlLU+LSLN+brE6NAhw8TR1SfjZDHU
 lkN0aQOMtcfFYt6MR2Q==
X-Authority-Analysis: v=2.4 cv=VuO2kO2n c=1 sm=1 tr=0 ts=6ab64ac3 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=QDjCMyA0A8yHJihhU1wA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: ATAn4I3rQvC4TG7u-jkNuI2zLlBoZaZX
X-Proofpoint-ORIG-GUID: ATAn4I3rQvC4TG7u-jkNuI2zLlBoZaZX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609250041
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

On 9/24/26 11:14 PM, Akhil P Oommen wrote:
> From: Jie Zhang <jie.zhang@oss.qualcomm.com>
> 
> The Glymur's GMU compatible was set to the wrong string
> qcom,adreno-gmu-x285.1. Correct it to qcom,adreno-gmu-x290.1.
> 
> Fixes: b6ff8cec8aaa ("arm64: dts: qcom: Add GPU support for Glymur")
> Signed-off-by: Jie Zhang <jie.zhang@oss.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
