Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDBB7CD8C92
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 04:32:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8AE410ECB3;
	Mon,  8 Jun 2026 04:32:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Pu4NH3fB";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hakA8dRJ";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A64010ECB3
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 04:32:39 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6580FgG82004225
 for <dri-devel@lists.freedesktop.org>; Mon, 8 Jun 2026 04:32:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 AhE1r+/Z7fVsTmMsF7iSZtgbqyLki//uNGgX9+Uqu0I=; b=Pu4NH3fB3QZanzjY
 ZtkPCTAEQirUnqtJgso+XYtQtN2XJf1T/KHHHnUIfeRu98HWczrsyfj+s+yVEEd/
 JI2pQoydqhsma+K+GMbM3rZFDFsjvT5yWUK4re0b2zR/lncxEsfSa5rR7y9Fwr1e
 AEE7RI6VtyUjuYNLhSNfGBbdTL9pwzcE0sGovqbuvvKXODnKL/S5S6wLsv26nhJO
 naQIBiwyQodqm7N6D/VXCDPcIizGQRPYg1XRBK3BQTvQLmoe9znx9WzoaBe3+DDi
 X9PDKEnyUwOrTjOHFaBOFsl3dxuXA+DvnILtVMa9ut0EFI9BNOPDb/o+LKj3Phfy
 aUv3Qg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emb4w5vbv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 08 Jun 2026 04:32:38 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2bf1dece2ecso39868265ad.1
 for <dri-devel@lists.freedesktop.org>; Sun, 07 Jun 2026 21:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780893157; x=1781497957;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:cc:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AhE1r+/Z7fVsTmMsF7iSZtgbqyLki//uNGgX9+Uqu0I=;
 b=hakA8dRJpTKehQdDKW9PmlQjmZIKFK58gyHF3CHIzSiFBp3vPvHi6OH456e4RXJewx
 H5lUbWpRoYSRoNQwIilh9AUZYSd0Qcx7VmiA6fijxt75kKgQqG8ZEbtcHMbWbrR5F/ru
 ogBVwBjuZNM4dRMHKiNtLcCfPrkSYFX9nEHC6XKXoi11d9fdawh+BHlfOXxzvaZonggf
 hWQtkAG8hLp5L1H1HMpQtBzCjxhwz/1HjXCamu5loEbwaf2D34jaVrNyDlbwH7/UGSqV
 bND6sr/5EcxtPx17SAeY3Q49b+9MDL0Jzq18mHfG/qExwMP9vfz2eW9JCLXBr8a+xRml
 6RaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780893157; x=1781497957;
 h=content-transfer-encoding:in-reply-to:cc:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AhE1r+/Z7fVsTmMsF7iSZtgbqyLki//uNGgX9+Uqu0I=;
 b=hiZVm7UhzsIv7E/TxUzjffzDb1nGbBCpUKQr4mkul8lgha1FWQwMrTWUWI62MTLv4f
 xYrK7z/d4/RxkBr/WXzGy2VvtqP0ttrcvsjSxksSLpd3wayG0YUCIwIiWICrfIKO53fF
 V1mtoUSd7TUvNXH0bZZ/cGX/3suv72cuzOswvCiTo5IUqu6a4bfWoFZ0Xz48TZYVzJPz
 UXx+FikhUd7J9BSxjKDcly/NuV4AnnNpDABTaMDPorUxFAWi2Hd/B6WFVUtfsFaXkymN
 E7CtAlNPZq26GpFIqoRy50SVxfTX5iLLxgPxP7lU+O1E1ZOg5SzqN1HESlCcP6kH9U93
 gIRA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/CGv2OqAgGOjzAzVR8/tZoQqZCFdJJlQVek/mvDN3WuE1O1ota6UNH+7pUyVMeDiEhHchvcMvNLS8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyfzj8CBkaa8pzyYc/22Xvww4GtboZf86aD3rnJu/+0Nm+0MS7Q
 l2wFNX6EZWicj6DyF7y0Bj8uOHT9pZR8qRjY2ZwF5ptEquLaOwNg9w7InZoBN6oKJeX61RJ7P9n
 yGLZEhG8IZS6WdD8RYbw2e3DKqQRJ9Np+BQX1DJaoqhrJFwW/Jb3oJM9yHgMwovEJSpogKEE=
X-Gm-Gg: Acq92OHy9vhkUp3szWWkNo0B6qx7+Xfo1H6i0MW5X2SdiOPM+pJFgvNOCGP/KYCe+eC
 uY++0r7DLHg/B8Dp+a7eczBjK2o9CTwmf2vJOcpJqxLrxxhSNLWS+ta8R7f9s86wm+2/MM3gfQq
 NWd81yXrYtVOC+dVfLBoxMZt3grN3RalwCx7SmcAMUSRZHRDty0OYoxRw310XaxpYRNERzzd2bV
 jMteObhF+pMUofy/P6xxtU8o28FO0eg5x9eF8VQq+QeGJKT7S+IsI/ugb8jYD5UflxCjMtc+vjj
 izsCcJehDfMKJ91OqO19UhLcbtOwkTQ43p9bSbyVXr+8dW1FbpxAyjh4Bt5GnQ+sZNKBuJl5tGW
 TU9Zv2UcSlXA7Au2i1fjM0EN5wWnO+Wk4OEeKep/4OzQzwrVnB5YGgksddbMaFeDM2G/kqNj/Xo
 WwMMILu4PrG+zyjgPPQYcN9TFwb1M=
X-Received: by 2002:a17:903:1a10:b0:2bd:606d:b342 with SMTP id
 d9443c01a7336-2c1e881ff09mr158867585ad.26.1780893157567; 
 Sun, 07 Jun 2026 21:32:37 -0700 (PDT)
X-Received: by 2002:a17:903:1a10:b0:2bd:606d:b342 with SMTP id
 d9443c01a7336-2c1e881ff09mr158867175ad.26.1780893157068; 
 Sun, 07 Jun 2026 21:32:37 -0700 (PDT)
Received: from [10.133.33.209] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c164f890b2sm166345345ad.26.2026.06.07.21.32.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 07 Jun 2026 21:32:36 -0700 (PDT)
Message-ID: <ecd4007d-7e8e-46c3-b8fc-bafbac48f762@oss.qualcomm.com>
Date: Mon, 8 Jun 2026 12:32:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/5] misc: fastrpc: Fail Audio PD init when reserved
 memory is missing
To: Jie Gan <jie.gan@oss.qualcomm.com>
References: <20260602071750.526-1-jianping.li@oss.qualcomm.com>
 <20260602071750.526-4-jianping.li@oss.qualcomm.com>
 <7e5299fd-85f9-4f74-9e69-5192aca81f05@oss.qualcomm.com>
Content-Language: en-US
From: Jianping Li <jianping.li@oss.qualcomm.com>
Cc: srini@kernel.org, amahesh@qti.qualcomm.com, arnd@arndb.de,
 Greg KH <gregkh@linuxfoundation.org>, abelvesa@kernel.org,
 jorge.ramirez@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>, quic_chennak@quicinc.com,
 stable@kernel.org
In-Reply-To: <7e5299fd-85f9-4f74-9e69-5192aca81f05@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: L4nI4r4ATQNHb8GcMfxm8IQgG8m0OCT9
X-Proofpoint-GUID: L4nI4r4ATQNHb8GcMfxm8IQgG8m0OCT9
X-Authority-Analysis: v=2.4 cv=YIWvDxGx c=1 sm=1 tr=0 ts=6a2645e6 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=LuRWb-Sg13DV_SJKcp8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDAzNyBTYWx0ZWRfX8ZZPWW77Pknn
 IHZpxd7wC3ilwUnqSXtrLMg3gpSg+U5D8/Lzb/PVBQQf0oYZSSlel6yaJLfCi9fQsYT8qY1Jp9a
 JBUIpiuaUwdz4BGJlT/toRBaMza9BAd4qxIzfRE2L30BlZ/94oKEKhlq95pOGiSb4bs6xCbSbdU
 QeVieAQfLjrK2NXXurSXntuDZymsA0brM+zvJWxsH/XhGFURUcFid02NZ5+yoavflL5iWJFcrN9
 BEx2sRnpMHc71Ev3AtweEpBas4UYpM9eP+T0mAF295kC9JjRPMZhY/tdB2octsgyDI09iI5NwvL
 NrpZg+fEr99MV48WKdWtWg2LSD10L5aRpkOogNTbiHDIsFAj2zGfwcYWmP3h/OCi0c1Lz4mF7S7
 yPTwGIvBQNAepWDRdpKQHZFv+1x1BgQ+NKngijL6LBBp3XAwtHJKLd2Rep9ofIfNkIYiK+RCKB/
 KSb3qTjPDAotzLynbXQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_01,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080037
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


On 6/2/2026 5:25 PM, Jie Gan wrote:
>
>
> On 6/2/2026 3:17 PM, Jianping Li wrote:
>> Audio PD static process creation assumes that a reserved-memory
>> region is defined in DT and exposed via cctx->remote_heap.
>>
>> If reserved-memory is missing or incomplete, the driver may pass
>> invalid address/size information to the DSP, leading to undefined
>> behavior or crashes.
>>
>> Add explicit validation for remote_heap presence and size before
>> sending the memory to DSP, and fail early if the configuration is
>> invalid.
>>
>> Fixes: 0871561055e66 ("misc: fastrpc: Add support for audiopd")
>> Cc: stable@kernel.org
>> Signed-off-by: Jianping Li <jianping.li@oss.qualcomm.com>
>> ---
>>   drivers/misc/fastrpc.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
>> index a8a58f889d07..f46a8f53970d 100644
>> --- a/drivers/misc/fastrpc.c
>> +++ b/drivers/misc/fastrpc.c
>> @@ -1354,6 +1354,13 @@ static int 
>> fastrpc_init_create_static_process(struct fastrpc_user *fl,
>>       } inbuf;
>>       u32 sc;
>>   +    if (!fl->cctx->remote_heap ||
>> +        !fl->cctx->remote_heap->dma_addr ||
>> +        !fl->cctx->remote_heap->size) {
>> +        err = -ENOMEM;
>> +        dev_dbg(fl->sctx->dev, "remote heap memory region is not 
>> added\n");
>
> should be an error instead of dbg info.
>
> Thanks,
> Jie

I will use dev_err to print this log.

Thanks,

Jianping.

>
>> +        return err;
>> +    }
>>       args = kzalloc_objs(*args, FASTRPC_CREATE_STATIC_PROCESS_NARGS);
>>       if (!args)
>>           return -ENOMEM;
>
