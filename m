Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A04A0C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 06:28:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF06410E698;
	Thu,  9 Jul 2026 06:28:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="iuGkr4Jb";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SOdkybMB";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFF2010E698
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 06:28:35 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66960M9t916691
 for <dri-devel@lists.freedesktop.org>; Thu, 9 Jul 2026 06:28:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 P6rkqMfXLK638vUXHiaFMs9sT739rEtUIMeGGDeaRaw=; b=iuGkr4JbT9ADw3uA
 mXUmcOFWX7uDjojELZtVMUO/2WVsuu82pzhw3sTMP59spjvrcKITavLMQ/+vFzUx
 iMKsNPhdUREk3Hi9w8tbS22d9T2NTteWo3xXTRQBLn7pnHVTlffOnWnBmKm7rQ37
 HU5Binf8tdkKyTdEqzUed+9e+h2kyeTK7fWrevbIp0BCKulC1EDXIi63e7UuwzsB
 2UIx7wJ1DButXX6eTtfmaPbO+YvTjS3eHYE9UZbwO+y06mIHjPRE0QZq2ze5CSkq
 sgY8ZOLVKRj6lUUNKJ51RDQM5+k+DLPCY2YJ0V/fNAIOJ0k5wi5ZoloNMyqae+zV
 CTgzaw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9hnv5810-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Jul 2026 06:28:34 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-847a00bcbd0so2045617b3a.0
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Jul 2026 23:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783578514; x=1784183314;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=P6rkqMfXLK638vUXHiaFMs9sT739rEtUIMeGGDeaRaw=;
 b=SOdkybMBcPEVutERbLvILEbczg5W//DQo6E7eYV18kVtdPHheSBvXnGtzynI8y8GMN
 K5ZRAQBBIOnI19C8Rinc5akUPHcneb5CfgmQHBrDwk+VLV2CZaMxblhbemo1owKYaPTf
 gW17emgja31gRGFgIoW3BvTmyrICH74v2HcimLSoAyEQKALV8JN1e7mV0jsAzdf+EwkD
 0R0kZihK5Jf4EhgoxwPng77Fr6laPKNGH9zyTDjkO/hPwY5vc/xUohmVJgTnDRYhQefX
 h+Yn5dnJ1WLvyBixMjtCjn2zRDv9+H/nRgNHXe+hZHdOG8k2LdvQbCT5Ga+c2htcjUP4
 N3qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783578514; x=1784183314;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=P6rkqMfXLK638vUXHiaFMs9sT739rEtUIMeGGDeaRaw=;
 b=UfG6FtCmzHXV+oLX6ahmcGCnWzP6h7DcvDV4u3yrDtK4VQISPVNuYGvB0P/vZcANu/
 KUXnViFpSKqPoYhFPYra5owDpbvUehZVLZZEcb+sjX+fq0ZGETXH3nMeNp1YEO5Nza8f
 SBZ4gEiZ5kA11mp/WK9/HJ3wBq6qdyvt1mMEJY6cfI8Ike2PqsLYb67Dlil/AGL9L7jo
 L/LK10MLV6uqwXuwTHvGJwbXu1l8Jjf82v8HNaT8a6s1ribS7n+Jk9XkjvFRPR8PKBLP
 gsCm7GMy6sojFFwprMkNJAVWLhTYmcAps2Tv2lPSEjhHgVJRiRZPFJ2AnBdtx2dZeA6s
 /GyA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpOYy5IZnfe5rhBZsDxw5UnAlgFWazAbVO1CqknTYNupF48MvSJ/TkkzmaaQs+wMkbROiQ6PRGrJy4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyyXjv+8+4SLrn3xCHMtWSMVA5OqZo2e482fRNq0hgGCWAnJNiY
 CAC5ztPSYlVWlWe17UmNDvS26mLfOv2KgICIdyAj1jaM0aRoZaHs80wuSsPl4SyBDBuCuSIdgP+
 WL3ec+2u4Stb5br7wtcow38sdnZrA4KLkD6SG60EVOs87YHulZ5sTg7AodtxSTXLMgeyWJ12m/m
 IgoKs=
X-Gm-Gg: AfdE7ck652DR1O8paYSnoKb/o2bOC1/KlskzvxNuHTBRl6ZDKOdddllPvkOJJHnmv9u
 JAWGgCVq4f525vP2ZaQVGkKFZT7gNfdaRDjuDFiFOdTLaX4GNt4pvw1uOdf0TiaiPvag+JTCuwE
 8TjnFShgWd3ho4G4VK4VbQGxHHZY+/bVbhroZ4ApHCWUogm2LbI1cBf4J3iWTDs/zS8n0xFJTmu
 lT/J0vKoK5pnVodnYGxX4K1M9Xg8vGgoomsYxD/TZe8BW7oh0S7kmZe9cltRRHrbM4YR3du2t+X
 evY3PwTR8HXRK4Y0S5V8tHfBlZ7Q+dA6ixPN1fJIgqLfiw4f59XTUG5Y2vmWaYgdQ195tvvLp9r
 K32mER4GbnFyAj5L4sFy85/n4/P+JKW296+ldYi08pCGqYtDgQQ==
X-Received: by 2002:a05:6a00:cd6:b0:848:30c3:45d6 with SMTP id
 d2e1a72fcca58-84842ef886amr5946294b3a.14.1783578514271; 
 Wed, 08 Jul 2026 23:28:34 -0700 (PDT)
X-Received: by 2002:a05:6a00:cd6:b0:848:30c3:45d6 with SMTP id
 d2e1a72fcca58-84842ef886amr5946271b3a.14.1783578513823; 
 Wed, 08 Jul 2026 23:28:33 -0700 (PDT)
Received: from [192.168.31.103] ([152.58.31.181])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-847f6b9a832sm8089294b3a.18.2026.07.08.23.28.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2026 23:28:33 -0700 (PDT)
Message-ID: <6b53fa97-0fae-4ba2-a774-ae8df2c2ad4e@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 11:58:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] i2c: qcom-geni: Add dynamic transfer timeout based on
 transfer length and frequency
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 mukesh.savaliya@oss.qualcomm.com, viken.dadhaniya@oss.qualcomm.com,
 andi.shyti@kernel.org, sumit.semwal@linaro.org, christian.koenig@amd.com
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 naresh.maramaina@oss.qualcomm.com
References: <20260705135739.4038826-1-aniket.randive@oss.qualcomm.com>
 <4f865aaf-a400-4dc6-acaa-80dc22a36af7@oss.qualcomm.com>
Content-Language: en-US
From: Aniket RANDIVE <aniket.randive@oss.qualcomm.com>
In-Reply-To: <4f865aaf-a400-4dc6-acaa-80dc22a36af7@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=KNNqylFo c=1 sm=1 tr=0 ts=6a4f3f92 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=9AXozQ6IwN0d4JI31gUtBA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=5GfgTEDUgWdp11RPFvgA:9 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDA1OSBTYWx0ZWRfXxs/VVJhMR1CW
 E09LyZHBw2P5kw27i1vIPYhRkagDia65WUPur+xHTt0NwkbSuWupo+cggNKWeNZFx/b5ueqC8td
 yTlMXX7J9B7QuWyZu+k5pWGYijqiKeY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDA1OSBTYWx0ZWRfX9EdLK1M2vCUQ
 aWKLZj7RHzbqfnqMdaguIzaZhBaf9tjtcmborOCPZBRuWwsoJm1b/NsskRr1pz3No8OVTYHlrTM
 XggMDEGvnN6mH5RpeCL3KSR5uMCuFoLwEclLRuW9JgZEybRe1Hbwat/aYNX3dgSoVlDpyeZbJHN
 EAtgJnqADXQ6jXusRct1ODpTL328PakrEXa1EpfFfNgZswVvNEL2gWiPs4tnzEEntu9PbHbUkbj
 qrfUNae3SzHSXzITKqIUDRnblUIRH9tZO1IsbucONp/vxTQ/OMFi1CZWe66pL/6Eqe1mJwk1sv3
 l2d5J7dj/kZJaT+Saey0YXU6dZnBM3ntbLB+j7yNCw4wNjfwhANzcbYbHl5kUWh6/wVMKbs7jv0
 ryvzBj/MH9z68e6DdW+ExhNrb5JZn88LAj+rNUimoXobQFe+RSjzfcQTdsZalv1mM6/qL88Z3Hg
 yIVoTPV3bRnFRw3FLbA==
X-Proofpoint-ORIG-GUID: iVvqxw0k7feVlpFfm_6ZHcIl_Hl19s_X
X-Proofpoint-GUID: iVvqxw0k7feVlpFfm_6ZHcIl_Hl19s_X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_01,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 spamscore=0
 malwarescore=0 phishscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090059
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

Thanks Konrad for the review.

Sorry, I missed your comments on the v2 patch and ended up posting v3. 
I'm happy to post a v4 incorporating your feedback once the discussion 
concludes.

On 7/6/2026 5:11 PM, Konrad Dybcio wrote:
> On 7/5/26 3:57 PM, Aniket Randive wrote:
>> The driver uses a static XFER_TIMEOUT of HZ (1 second) for all transfers
>> regardless of message length or bus frequency, causing unnecessary
>> delays on error paths.
>>
>> Compute the timeout dynamically from message length and bus frequency
>> with a 10x safety margin over the theoretical wire time and a 300ms
>> floor. For GPI multi-descriptor transfers, use the maximum message
>> length across all queued messages as the per-completion timeout.
> 
> What's the reason for a 0.3 s floor?

The floor accounts for I2C clock stretching. The spec allows slaves to 
hold SCL low indefinitely during internal processing. A dynamically 
computed xfer time alone gives no time for that.
300ms value covers worst-case stretching while still detecting real 
hangs 3x faster than the old 1s static timeout.

Thanks,
Aniket

> 
> Why a 10x safety margin specifically?
> 
> [...]

The multiplier covers the gap between theoretical xfer time and actual 
completion time (DMA descriptor setup, interrupt latency, and scheduling 
jitter on a loaded system)
Without it, short transfers would have almost no extra time before a 
spurious timeout.

Thanks,
Aniket

> 
>> +static unsigned long geni_i2c_xfer_timeout(struct geni_i2c_dev *gi2c, size_t len)
>> +{
>> +	size_t bit_cnt = len * 9;
>> +	size_t bit_usec = (bit_cnt * USEC_PER_SEC) / gi2c->clk_freq_out;
> 
> mult_frac()
> 
> Konrad

Good catch. I'll switch the calculation to mult_frac() as suggested in 
the next v4 patch.

Thanks,
Aniket
