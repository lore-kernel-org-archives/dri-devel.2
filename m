Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C06D3C44501
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 10:05:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E34D810E16E;
	Wed, 15 Jul 2026 10:05:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="LTh5Fnct";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QFmKExKH";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B92C410E16E
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 10:05:15 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66FA5C843547443
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 10:05:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NqzgSP5QBmA9GAEIiwoOdcOIySaSoE/ED4xZMe7OFWM=; b=LTh5Fnctn1zN9gfG
 8w2C0QzhlwwmTDvtrld62C9SeZg7nQt0der8k4w6oR3QXAXJ2gY7f/TrCB0wBgLg
 viqWIrHgHdgTZNyKcUzRtKFvkCdPr40oMImVSJ2FJRDcA4SlGqVD8cxFEMVTLWml
 QB62TqHvPtDdkSm+Z/7Jt5Sb9kXqBI/YsQiu8q6CkkSzeY8P1c6zzGWpFhqK1vIG
 JVP9EDwiSJBiMn/J3sjG+QYtfXuKscp0dVLDuBr9ezNaYPEw4iARMonm+sPpXpiI
 9eIoNmosFM9i1aP+sXKITngk2OR1Ptyz4nl0aPhdJYi8r2rJli3Yuvi74IeH7nrI
 /PFa4g==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fe855800g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 10:05:14 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2cacf17c7e0so28118845ad.0
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 03:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784109914; x=1784714714;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=NqzgSP5QBmA9GAEIiwoOdcOIySaSoE/ED4xZMe7OFWM=;
 b=QFmKExKHoGNKY8/bQo9qdsQMfOgAQ+FBAFQarvWcrC1C42AWh4jljLV7sXggbeqxbB
 m/4KboQVctsFv7FddnFlg8xAu6xJQ4BGaVetaJrcR0pwjIyPEw8AGWHc7dXQkO6kqebA
 x+pDSYWeqEokOA8DTTqL4yYMHFr91FV1ROHBf/WzhszMq7TrSJcniC5dhrG2mv520udE
 ua+kvrlg99PeKJLDnyEW2w8MyDqjDMqMGXMoPyIGEIdEh7Hzr6WNIBknj1stfYTWoYcx
 RKOEendY3WUmsIQmNEUbrB/hUUn32ygn/UNwdxSlFfIHu2HE+90VAssQ9zK4Mo8IifB7
 Pa4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784109914; x=1784714714;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NqzgSP5QBmA9GAEIiwoOdcOIySaSoE/ED4xZMe7OFWM=;
 b=j0RdgJU2iOeV+NMIkO90vsjLFRvF0w9e7/YrkZ51/Wvijhkdfc6q2JksX2cmYaVN8l
 YMfb3vbHePs/4/RGyy1mursUXZduwP3s9AP4wnWcltgtdh6vpk/5C8bhO5tpbda+fVbT
 ddwzDYuPcM9HLvs+gPQUB54RRw+21m1Zc4OrD8L4HGQ0eU5PTII2dooK3AsvaJ3VhFde
 XJr1UodbSBAFfvqp26Lnkmmb8dkWYVljLLWd316awE0myl+P80YJg2LhQQEkX+JCnizs
 nGrTR6cLL5yMgXNTxqC8eVBRVxxiJPsf6ae/rRbewQA1ehEfhWxun3Qtw8A0JfQJZcjg
 p6fA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrNmFVTKE4E/dHu+KLtZsXe7hNIpDEcWuC8CSAJnaaeqADwgDaEHe4thbDDrJB97Jm6+Q7SaoSnUxo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxsWsaOB/hbDi9Bu20KahWbCattT9hMpse/+jNQA51Acu8DRPmf
 8gQp6YRBCL5VjkA7BqNeP5DdP6CVItjba9AT90wVkBD4yij67KjC9I6fwmIwhbA+a5FMRCXCojF
 fKgmYxyVoSHBPJ0SuVLdM6WSjZgwHko4a/yxx6wV/fjSHQ58d0mOY+GQ2Qz4mj0sVKQTxbQk=
X-Gm-Gg: AfdE7cmOo5uJXbtO/ZgWBl6W+EJeO0XGeur4fxuWT9y5O1zm+4JKpxVyaUEd5JlECcP
 QqHED+aovCUkOLScXHcqGPE8mefi1Ks2j0nYiPUnZn/y4JhIce6p7RjKb+PpckgftktxyMP/UGa
 15r1z+F9pMLRbYU3xLJzvom52U/0dxvm6q1V/Tjs1EI9nsSe2HMQ6pCU+b/409PLTaOyEsX8GeJ
 E62bz9RhcrMFS2cEXnuiA3zP1GtirCk+jYKc0+rK+wv+9jsV1Cjez1tLHJ8yf0KbJl+g6acznI9
 GMB+FGnXKaEhgP2Qif0MOUZIKaXsFbZC/SIHhyTnY6GhPSyntQCUfDrOobxeVBfMWOzkBppHW6l
 QFAm/ts9YL/c04E7Mrho3NYrrGi3amy/54Birdm16jv0=
X-Received: by 2002:a17:902:d98b:b0:2c8:f34c:82c0 with SMTP id
 d9443c01a7336-2ce9e5a55c5mr162929085ad.2.1784109914146; 
 Wed, 15 Jul 2026 03:05:14 -0700 (PDT)
X-Received: by 2002:a17:902:d98b:b0:2c8:f34c:82c0 with SMTP id
 d9443c01a7336-2ce9e5a55c5mr162928845ad.2.1784109913683; 
 Wed, 15 Jul 2026 03:05:13 -0700 (PDT)
Received: from [10.217.218.21] ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9d3bbaesm130823715ad.57.2026.07.15.03.05.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jul 2026 03:05:13 -0700 (PDT)
Message-ID: <54c99b8d-158d-476a-b965-bf2f64b16237@oss.qualcomm.com>
Date: Wed, 15 Jul 2026 15:35:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4] i2c: qcom-geni: Add dynamic transfer timeout based on
 transfer length and frequency
To: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>,
 viken.dadhaniya@oss.qualcomm.com, andi.shyti@kernel.org,
 sumit.semwal@linaro.org, christian.koenig@amd.com
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 naresh.maramaina@oss.qualcomm.com
References: <20260710161056.1799019-1-aniket.randive@oss.qualcomm.com>
 <e53ea721-bcd1-4d8f-9b7a-ea6ec3003f71@oss.qualcomm.com>
Content-Language: en-US
From: Aniket RANDIVE <aniket.randive@oss.qualcomm.com>
In-Reply-To: <e53ea721-bcd1-4d8f-9b7a-ea6ec3003f71@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: OB7agn-bstLr6Dxr2ebGkIz-EQCLLG-5
X-Authority-Analysis: v=2.4 cv=KOlqylFo c=1 sm=1 tr=0 ts=6a575b5b cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=z_QR8a_bo-jD1fP4SgEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDA5OCBTYWx0ZWRfXwKEH3TMXWFzS
 1b39Vv2zY+3SpmOio+fszBfLUKyuH50qa0S07QgwyuEHKa91lc80EzTqWWHEtSbmMZ0dMiwBjBJ
 vqj8bIhK0XGKUy4Uc40Qk+pZglEp8ZrxGdyh2KNY6ILRWWOuUkL+qEhBw0ssH7gXEgeicU3kVoi
 1D/WNGboHgwsFWcDEBmTz+dyyEMo9VJ7Q6ueKylyQpdKnqeyFcaHRarcg6G2hLFi5HgzCYDlSKc
 UeNS2U8AXLusmfxIJHketiZcyDVL1XxY5ypC8Ul1ljH6vKlWJo30deJDDJ+zBX/sBgoWfK49BcL
 ZbGWceehy/j/p8QTpK2VlOgbcZwkJXHYjYY8lbPJ1lBrgLLE+8FR7mA1AXFV6qFgLCV5ASg3y7n
 wyQDrz0tQRth0wGdL1VY3uR39RvP+1P8dSkxeuRi6y7YtuLpYXejI4D3lLuMunHAjxBMAK80J6T
 hXVzTA7ZV4xZPsECp+g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDA5OCBTYWx0ZWRfX39vuuw9CcnOq
 nhh2qQxXT+qhyseVqApgR0Oblu3336c1PDfxu/iq2JPaw25lTf4mG8Uc3ETIqbPuKL/xo0LOhSz
 FGedisS3Rx5zX5AQknAuGjomONm7z7Y=
X-Proofpoint-ORIG-GUID: OB7agn-bstLr6Dxr2ebGkIz-EQCLLG-5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_02,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 impostorscore=0 malwarescore=0 spamscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607150098
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



On 7/15/2026 9:36 AM, Mukesh Savaliya wrote:
> Hi Aniket, Thanks for addressing previous comments.
> 
> On 7/10/2026 9:40 PM, Aniket Randive wrote:
>> The driver uses a static XFER_TIMEOUT of HZ (1 second) for all transfers
>> regardless of message length or bus frequency, causing unnecessary
>> delays on error paths.
>>
>> Compute the timeout dynamically from message length and bus frequency
>> with a 10x safety margin over the theoretical wire time. Add a 300ms
>> floor to budget for I2C clock stretching, where a slave may hold SCL
>> low indefinitely during internal processing. This detects real hangs
> not only internal processing but it may go bad holding SCL low 
> indefinitely.
>> 3x faster than the old 1s static timeout.
> Meaning, in such case/scenario, don't need to wait till fixes timeout.
> I guess, 3x faster is relative to the 1 sec, but for larger data and 
> slower frequency it may not be 3x. Hence, correct it accordingly.

I will update the commit message in next patch.
Thanks,
Aniket

>>
>> For GPI multi-descriptor transfers, use the maximum message length across
>> all queued messages as the per-completion timeout.
>>
>> Signed-off-by: Aniket Randive <aniket.randive@oss.qualcomm.com>
>> ---
>>
>> Changes in v4:
>>   - As per konrad suggestion used mult_frac() for bit_usec to avoid 
>> intermediate
> Do not keep space before starting, directly start with "- As per....."

Ok. I will take care of this in next patch.
Thanks,
Aniket

>>    overflow on 32-bit targets.
>>   - Updated the commit message and added a driver comment explaining the
>>     rationale for the 0.3-second minimum timeout floor value.
>>
>>   drivers/i2c/busses/i2c-qcom-geni.c | 46 +++++++++++++++++++++++-------
>>   1 file changed, 36 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/ 
>> i2c-qcom-geni.c
>> index 96dbf04138be..c5c3adc8ec77 100644
>> --- a/drivers/i2c/busses/i2c-qcom-geni.c
>> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
>> @@ -74,9 +74,13 @@ enum geni_i2c_err_code {
>>   #define PACKING_BYTES_PW    4
>>   #define ABORT_TIMEOUT        HZ
>> -#define XFER_TIMEOUT        HZ
>>   #define RST_TIMEOUT        HZ
>> +/* 9 bits per byte (8 data + 1 ACK), 10x safety margin */
>> +#define I2C_TIMEOUT_SAFETY_COEFFICIENT    10
> Add a line space to make it look clean
>> +/* 300ms floor: budget for clock stretching; slave may hold SCL low 
>> indefinitely */
> Already explained in commit log, can remove second part.
> 
>> +#define I2C_TIMEOUT_MIN_USEC        300000
>> +
> [...]

