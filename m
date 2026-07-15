Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D350C4450A
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 04:06:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C4F710E115;
	Wed, 15 Jul 2026 04:06:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="MBX2aI/E";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CyN/fzL6";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E54610E115
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 04:06:41 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66F3lD362406018
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 04:06:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 aq8pKEu+zdq3GBZfc94BkwVIZ1D/MyJMoeF2wETynLU=; b=MBX2aI/E267mc+Ri
 Ae2koslafqgvNgkufljnooxJZ/mYOzcNmTBJ1O/GCjLaXODOL5WMxsAmoeNgAgIE
 T7+FdX/FegTXjic/uied/NqaF7LWQDNJfU6Z6YMNMCltGUy1bNIjc9L6kPkMFrFZ
 0PTkWf1iKlUWhR/crNap7gH52HnFbIWZGWp+fcWYv42fyODmgAh32aswrBpNIXkz
 K2UbaBp2xUTQxdDOqPMJCL225uzX9oFNVb+WcMj/cf21/x0P58UnoF+IjHZrgMk/
 iF3LCwyM27PRzeKEwuDkKgt46NW5UhMR4Thwe607JpSy0awSC/QxOrSjpiQOmvsp
 AcvVnw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fds9g1uh8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 04:06:40 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c9d5a5b63c5so7552998a12.1
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 21:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784088400; x=1784693200;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=aq8pKEu+zdq3GBZfc94BkwVIZ1D/MyJMoeF2wETynLU=;
 b=CyN/fzL6TCO/HZaOOrEqJArWrGU8BPkZV5TCCmQuKuC1Ox5yYs8ooqd0BD9InrjFmO
 fzPYXPfJitf77dEz/CLzjvYmFZME75yd2PbE0bPwMROqlNvXbHsn8lrE/uqD/O+WT0yG
 eVBXJKVxkddcRTuJaiGu3DGvYB+P/yTcKgROnkq0/RWlY/tR7nMJTMh4U/53HWxAHzc2
 wJCVTdA5OPLKE3ZQROzku4v0xAwHYbav0MrsHBb7utEgzJMK/+8dbGT3CLgtq1rwS3oA
 cw71taJuO6hF39X8ibXrtb7uEt2xBZL2dNn+0TwMu6/Ae7N4s8TWiOMFWofvDI/yb+yb
 0YvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784088400; x=1784693200;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aq8pKEu+zdq3GBZfc94BkwVIZ1D/MyJMoeF2wETynLU=;
 b=nUHRdHyCntxt/H31ygK+YFKR17ojZ+oRLTQ7nHBvlN/7/yeX4t/0rd204IMFoSk5Zs
 iA/202MYqaT+5x98pJuLQHccDG2Gr7I306r2fpAlcM6zm5vItAwweCl6k9ztpwByi/pz
 zvr+5q3ulvSJNVp1rV/DRJHhbJEo6m3cy+oaOT7cJVjcaStzNdZUpOVDtVHpDnM0kzrK
 YltN9q2Dqx/OubgyyVauePBBETWZyMFN7kzBesspOIngNaHPd03hHVrknapnZbEWRhU2
 H5AVc88g5jdT3zDJ4Ke949hkemKjGr48SsB6NrO+lk5gClZbHmLmvoC5JvTimby0rcct
 rJ7Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RqPSsDIt5zPnTpuoowqwA/JDCkioDgnkvolA+DFIn8N3WVJo9drYx1rzG29Tawg7+21uj7Rc7TGQkk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YysiGqsk9ELjhbmimzBD5tET6mU4nkYFtxD5dsHxBkkeXg5YjDG
 VB2RBEeZeL2QT7IAXsCSPkIV/jx7n3Tzsnnh+TW7JiZjn2yX1jV4yNDVU3jZzrxxHZlE9PMpQUP
 QBtQVDecm4sHFyr80HPRGW+hXoSUYUVc28FmtKoyEylcAtiMR34ZG48hsRm3IwhERfeTIlDU=
X-Gm-Gg: AfdE7cnAxdp+gJ0DNURoYtgvrgzkWeEb9t/9DYqrvsiyAoW2VvWLRBrf9REnWwuJjU0
 godUOd4lSt1UiZH6hrVUnm1YI+icSu5KNZoP0BnT/cl+m7Wyk26mjlpg0Ee/AcXUZnaCWGh7xQS
 +2R2YKQNFmtbhHj6gaQXWxLC0LkBvNdZrOVB3YNO38BJ0dwSZj9hv5yGd7+vJb9dg3NEMtPFogE
 xIC7cMzIECmkeVLWNWqKokcpW/RiTlex/G7rE4fqLvfJZmrUoKwJXrZrRd8QCCHxzR1c5G1xIxh
 SNyKzLDeOniBgWlxiwaj29dPyPFh/M6TASC9+8Pyt/IxgCokOfmnLvbJqwM94B29cp9mThjtEG8
 MkTmtGZJHP/oNLxJJG1BsbDVOOnIYpfLyepRygcLVI8ZM/Q==
X-Received: by 2002:a05:6a21:8cc9:b0:3c0:9c18:d5a6 with SMTP id
 adf61e73a8af0-3c35729077fmr6943830637.67.1784088399580; 
 Tue, 14 Jul 2026 21:06:39 -0700 (PDT)
X-Received: by 2002:a05:6a21:8cc9:b0:3c0:9c18:d5a6 with SMTP id
 adf61e73a8af0-3c35729077fmr6943801637.67.1784088399121; 
 Tue, 14 Jul 2026 21:06:39 -0700 (PDT)
Received: from [10.217.219.142] ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b9a67c217sm27006165c88.8.2026.07.14.21.06.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jul 2026 21:06:38 -0700 (PDT)
Message-ID: <e53ea721-bcd1-4d8f-9b7a-ea6ec3003f71@oss.qualcomm.com>
Date: Wed, 15 Jul 2026 09:36:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4] i2c: qcom-geni: Add dynamic transfer timeout based on
 transfer length and frequency
To: Aniket Randive <aniket.randive@oss.qualcomm.com>,
 viken.dadhaniya@oss.qualcomm.com, andi.shyti@kernel.org,
 sumit.semwal@linaro.org, christian.koenig@amd.com
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 naresh.maramaina@oss.qualcomm.com
References: <20260710161056.1799019-1-aniket.randive@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260710161056.1799019-1-aniket.randive@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDAzNCBTYWx0ZWRfX+mzXjGFPxAPD
 0wGg4fee6k1gwORw9jSKImHIVIqDCT+WDJvA4lnGlZssW6TpIxgvMmbZQAZz+AGHGfGGm+5uyao
 6C5qE5kRub3wjI4DIfRCbtK8V0rxE6c=
X-Proofpoint-ORIG-GUID: 9HZddwqn5NJaU_wc6ck24yRwfJZaT3cV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDAzNCBTYWx0ZWRfX2bIHq2nejim2
 HB7hao6He6U9YjeaMLQ/w1HZ35b0gfxCwF1pEKbZjCs9OhLZIMJfkHFCVgT+pZXgAaeYGhCpcPS
 wlGR4ADb3jSvp3cKb44OvisvnxAh7epMWPI1RCtU+Y/LGYNVOZJmxZvzSJAzX5S222fxdlQ9YQz
 j9lH4BXCvYOmFxt7QwLjEU5/BYxuO+AeRaPvZHv+YzQ/xg2Exe3GbfdyAW3lY00oEyKzn6NfuC5
 vWkTQnTApKw8H8NyTsYQADmFqU96aa8wJhlJFTByNqRiJFjUBuuYe4QRC6xvWtg+QbdZHdxMr2w
 cIYq5NCTPBClkT/JQKorpx5sfAOfroeqg+ZFb2j0gM9xLBpcrVgwG8LCIb4Xxn3HQS0W5VHgswf
 Y8QuF2s2SBMjLxl5YD1ect5mfqlHgy60x+eBAdfqcJjSB0CrShCVsB8NhSBc9k6TGQqp1oCtuX3
 +iulw4TqP0hw9qJJcNg==
X-Proofpoint-GUID: 9HZddwqn5NJaU_wc6ck24yRwfJZaT3cV
X-Authority-Analysis: v=2.4 cv=VoATxe2n c=1 sm=1 tr=0 ts=6a570750 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=ENRykshp9vPgoFS4LJQA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_02,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607150034
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

Hi Aniket, Thanks for addressing previous comments.

On 7/10/2026 9:40 PM, Aniket Randive wrote:
> The driver uses a static XFER_TIMEOUT of HZ (1 second) for all transfers
> regardless of message length or bus frequency, causing unnecessary
> delays on error paths.
> 
> Compute the timeout dynamically from message length and bus frequency
> with a 10x safety margin over the theoretical wire time. Add a 300ms
> floor to budget for I2C clock stretching, where a slave may hold SCL
> low indefinitely during internal processing. This detects real hangs
not only internal processing but it may go bad holding SCL low indefinitely.
> 3x faster than the old 1s static timeout.
Meaning, in such case/scenario, don't need to wait till fixes timeout.
I guess, 3x faster is relative to the 1 sec, but for larger data and 
slower frequency it may not be 3x. Hence, correct it accordingly.
> 
> For GPI multi-descriptor transfers, use the maximum message length across
> all queued messages as the per-completion timeout.
> 
> Signed-off-by: Aniket Randive <aniket.randive@oss.qualcomm.com>
> ---
> 
> Changes in v4:
>   - As per konrad suggestion used mult_frac() for bit_usec to avoid intermediate
Do not keep space before starting, directly start with "- As per....."
>    overflow on 32-bit targets.
>   - Updated the commit message and added a driver comment explaining the
>     rationale for the 0.3-second minimum timeout floor value.
> 
>   drivers/i2c/busses/i2c-qcom-geni.c | 46 +++++++++++++++++++++++-------
>   1 file changed, 36 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
> index 96dbf04138be..c5c3adc8ec77 100644
> --- a/drivers/i2c/busses/i2c-qcom-geni.c
> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
> @@ -74,9 +74,13 @@ enum geni_i2c_err_code {
>   #define PACKING_BYTES_PW	4
>   
>   #define ABORT_TIMEOUT		HZ
> -#define XFER_TIMEOUT		HZ
>   #define RST_TIMEOUT		HZ
>   
> +/* 9 bits per byte (8 data + 1 ACK), 10x safety margin */
> +#define I2C_TIMEOUT_SAFETY_COEFFICIENT	10
Add a line space to make it look clean
> +/* 300ms floor: budget for clock stretching; slave may hold SCL low indefinitely */
Already explained in commit log, can remove second part.

> +#define I2C_TIMEOUT_MIN_USEC		300000
> +
[...]
