Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AF8FC88E64
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 07:39:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7152810EBC8;
	Mon, 14 Sep 2026 07:39:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="jfTN+u7S";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dB6epCX3";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DCF710EBC6
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 07:39:08 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68E7SDlW3351935
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 07:39:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 IXK1/kL2U0HScIthPTsqaR/1KhHLZK14qm7gOn1yzQo=; b=jfTN+u7S6s8Kygfv
 0tQlYEdwyKq8ulo4jCKxzfpCIEIokRYe67J1CXZq2zfbGPmL8hsEUcBco582PNp8
 1zYSZfZNhKI97emj/ts84LZXDvpvzHX/6rJUppL0yKTC5J3wGOgimLHKeRsthC51
 PzDrO6MAF7kEk+5xCOjqW8WLB6s0hW7itvI8yROr4s5vy1q7gZYtpw9ptSDp0ASM
 dPAjafj/jl/zCsj/qMZ6aAB+j8Hg/JFfMxZiYvJd9yb9GZ9QeP0x6DcTZ1FtZJpX
 CDY2HucOfa4tuFIkz1OmtBCbNSBdEuG3yU1L6ZIRljjWUpewpggZrUQQRzZ30+Ma
 f8MYPw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpcjg01b4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 07:39:08 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93821883e26so80476285a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 00:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789371547; x=1789976347;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=IXK1/kL2U0HScIthPTsqaR/1KhHLZK14qm7gOn1yzQo=;
 b=dB6epCX3MyswL34rG5Cu8eToInaewGI2BsAPrPBxaPQ1nrbZwu0f+EjQ6ffk0eH2s+
 Pbex0Y7rRbdPHhRMtV/RUk15N2tFktM58vhvt0tFDawZwYH2QfRviGtoi2VFOFk93vbK
 lPRiGTbun9p7b37pIlZfJAoQRMoqWJfNm9sbyc+bxrBBnUfKLrbmXjaVgRVdAvkqPhjt
 E1ehI1W7CunK3K7Tljes4Y5XG01dTvH4ZD4sbk9Z1ytBZFgSaVAT/tAzL5gjrluMxlWk
 40uMVmT3rO6Awy1HT7iX3Rmb8uYR/ndp5RVC9H6OPjKL7gu1sn2lqlGtCZWgSK1S6p1H
 N0Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789371547; x=1789976347;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IXK1/kL2U0HScIthPTsqaR/1KhHLZK14qm7gOn1yzQo=;
 b=ZG8SoHg0lculg8A6b08u/SIHz3XapJ9NB2KIMUpXRImoybbocKeQSRg90yeuuHxqm2
 D1bCtJaqvkQmU/adcJZon2sbQ15mkdJYH6zZ94y6bQFCj4XyipfNeT5dTVFbHZYF8Brb
 +LOtsbP5Y1E6l5o8VhY4WLgHSQGzWs5XWRFDo3tL1ez6xCjsS2oJBISy1lru1sZ35uYm
 wHXnNr1wQu3fDUiSNo/YTH4Zoh7/AdA4Ri52/cecZWQJYWKdO0udJ0VSc/cNmVhJ6MQ2
 ZWgd70lS2QtdX+eksytx9HGu+ESUhvr+yGWrLigfkKHreSNvHh1IWqe2AcsopXk1O3QD
 8Fpw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzqz1PkAQicUq1xxuV7GH2KazhxXKGJqaYOiAmZGu6nIefHV/4SLM26/EWd6XImbw/+896EGptzIKY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++k+u8roUoaBhbk3iyscMKRMec2M0bLVqOWr5420re+wlYD3X8eE
 FNjhNIjgD1fnKPm3tKNNeOtR+RKWxFvaJKS3ArR/1QJ0+cqsY+GoEkRZtkV522hSuve67U75Lae
 onWgif7hq5Uko+ev1Msv96UZbxYiBNKgUP+/gWTQ26cyGSDzEdfpjg37OZpDBoVGUT7fG3rg=
X-Gm-Gg: AYBFou0OBCrlqFCzz6u/CLly6DRhF1aZVnt0G18nKzIVmPp2ILkkqt2L3inWWS7r7LK
 vAUhkJ6HWO2IWB3UdIKYAuvaK6J4zTgsbhW0/jqHBXtNJls5ne/XfnpVFWS+Z/uAY0i5Zd/+jfP
 JOTi6bU38AwAPfsPiVaK5w/mwKEyFtRdTNAQAKCWliRtVrImrrKtCTsaPUNeG8EB0PVhBhTuTrO
 lGOQcQuO6uFa8Tz0WdmSq+SB1VjJ6OCYvokGNIvvCNgKTfZ1zo1Y8Q0gJMLsO+lDoDY1+TArwuX
 tgIX6VphYxtJ8YQVOSW0p3qnGf0OPjdBk5LzBLxfHRyd2x9m+txptf4tOQLkTObjhNW6AfyOuzw
 RoWjipSQwXF0/bz/5PSYDVA==
X-Received: by 2002:a05:620a:4707:b0:939:de49:6c78 with SMTP id
 af79cd13be357-93a297cbe3bmr160272585a.2.1789371546950; 
 Mon, 14 Sep 2026 00:39:06 -0700 (PDT)
X-Received: by 2002:a05:620a:4707:b0:939:de49:6c78 with SMTP id
 af79cd13be357-93a297cbe3bmr160270385a.2.1789371546524; 
 Mon, 14 Sep 2026 00:39:06 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a9d0ef7228sm2170656a12.9.2026.09.14.00.39.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2026 00:39:05 -0700 (PDT)
Message-ID: <31fa4256-f285-40a9-bb8a-0b5495badf69@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 09:39:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm/a6xx+: Increase GMU FW init timeout
To: Rob Clark <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 Greg Ociepka <greg@ferrisoft.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 open list <linux-kernel@vger.kernel.org>
References: <20260912150915.28700-1-robin.clark@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260912150915.28700-1-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=CKa/zhrD c=1 sm=1 tr=0 ts=6aa7a49c cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=9tEP0OE30YQ_IqY-BwIA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: WLZkA-GfYKthifNu2Dx_vmjO_LoVK3os
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDEwNiBTYWx0ZWRfXydiw2B0rDsmf
 Nr81KrlLgZFWArigHm9KS/tIxFyE+6GxHSanH+l6tvItjfh2r6yLRZ9XMbw7sDq/D5iEM6X8l/v
 Byi7+KET48Yj4mgVDqnp9wN49GjCGGw=
X-Proofpoint-GUID: WLZkA-GfYKthifNu2Dx_vmjO_LoVK3os
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDEwNiBTYWx0ZWRfX8Db+TO7oQnuK
 6+Uz1otIeZqCDI/Mru24gw8CR0Hn41p3qq876vxLVn2HBb7AE2ypTLp8MoHG9RTWVBanDmcQ51S
 ZIAPPak2Ijg+WpUKVIsT7PGbtKsSSIRmM5vpSjCm0Jt+unNceQTTFJtzMbYz8A6VS4+au9qsM96
 bWb1LSZ+6hDtJXWNTmGRSpzB6eN1d4s2yV+ZHFcMwqQTRlGzQYFmpvUB54RycqbAQT/e3fsDttK
 CEOytEPT75MQqhiOXDPLYHL9qJHaavL/oLT1N938U1I9cAjACeKelKyYtGno9o36Qxogq41Eteg
 m4HuKjRWu8p0y5bU/qo4C2FWCCMG31ykg8WYoIzErv3RXgWLIjPjPlTr/EgPgnSiZcJVQD4QiFq
 ZlN8HARELah9m1V+kLHIaW6GXjIz+gUYytmQdwIlZwIoajpzb8HQ7vVD4DkjXry+qcXPMlgftJl
 w52iLVuoiCvq2r3yqlw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_02,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140106
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

On 9/12/26 5:09 PM, Rob Clark wrote:
> We were using 10ms, kgsl uses 100ms.  In practice it is usually takes
> less than 10ms, but very occasionally goes a bit above 10ms, leading to
> a "GMU firmware inialization timed out", from which point things go
> south.
> 
> There are probably some things that could be done to speed up init, like
> increasing GMU freq.  But to be safe, increase the timeout to match
> kgsl.
> 
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
