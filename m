Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9A2BCD8C9D
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 06:45:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3ED2B10EDA6;
	Mon,  8 Jun 2026 06:45:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="FY1glRxY";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eCT3K8uq";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1A4210EDA6
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 06:45:41 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6586Ou5d2347374
 for <dri-devel@lists.freedesktop.org>; Mon, 8 Jun 2026 06:45:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MSL8eMVgQmCH7+wdnIkRquHtCibP6jzfmw6XCEBAK3U=; b=FY1glRxYMMop3k1K
 ogZhmECBSOUHc1vA3nB8tVX1ql4aXZ1UHJYLXfcwbuISwZvi95nnNREhrjBBn2GU
 PP4iUa4D74iduphnKFj+Ux+lanriVOx44DeL1Mq8TfQFplUjPnBQCT4nkayyzs9g
 MA2tMT3BsRMBd7ByxR0jQlVaLl+UIfRus6U6n4cUdFOdiKTGiYJ1cDGGFFoqCEoy
 nznxZl2zlscf0Z7NGeBnCZBP4sB+WWLHiQpnGu9DqGHumeSJhY95LcCjWgZdeknz
 BYAYsGCgKJtzT1lV3YfpXVMOm7qj2UnO8whEqJcN6oKs1OLYDH/49N3WGODTSfkX
 g4jG1g==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emagremd0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 08 Jun 2026 06:45:41 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-36bc380fbf9so3878555a91.3
 for <dri-devel@lists.freedesktop.org>; Sun, 07 Jun 2026 23:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780901140; x=1781505940;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MSL8eMVgQmCH7+wdnIkRquHtCibP6jzfmw6XCEBAK3U=;
 b=eCT3K8uqYyykmkAiF/SA9IgQ55U5vhX3GRjlbOEQVIWKw4HcaUF+pMS/C69MOFrJ4b
 U5gIgPAKPv1IAEuseEqBV5eeYpqQfXZqlLkpmt/P5FRf9IK9ww6cfHnKh11yMDkhj3ud
 CvFTmMiklcfAaRZ13g2xukxX6e50PrpvwEEXTiUracx20oYelj+ndvvGiOMcAXyf62AQ
 nxnvzwjRvvkc44TgshHhxEHTgiwENvBFt54lTmJMVzV4UPPYnLS34JeLSv5wYNP+hLCE
 FUaa4wgMpSLStSeVVI8wlQOgUnxypyJ68jGorde9n3IVkrA3etS1/XXWaC/ljtu4LNNo
 XDBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780901140; x=1781505940;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MSL8eMVgQmCH7+wdnIkRquHtCibP6jzfmw6XCEBAK3U=;
 b=WLEPTYIgnCgHYGJ97/V22Y176ovmeuuPJDJ2t3QeWbboCjdILPT0/wT64MB5cz98An
 SdL04/B3kkV3v4JVQwnWFRfBRizlKElMGchQa01GIr+O7R+hU7QcUsSh89Pxq0pbl/Ks
 Z1Bpi/a6mgVq0Ntr6ViCuIt2X+De8+LRc630GSYN+QsF3x2Dw1/Nv+UtCnS7mZq+emZc
 oTnF+g6UT0mLAFK3XCvTdJQkMLPLUnmEzNBtHLgQ7ynAUuXGByt/rWjM3ZzfRmGzS8IV
 HDg+vlfRVW2bto3fHRKUvebrx29XeShfr0MP7r1TaCi+vu443GNaec5GjQfxphu3OtFS
 x7GA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8etkdNwwexMWLoV7wydEUsWtUeLHWhVcQsIKVF7D+5Z3ny02Ku7McIcWPQKm/HExOSA7UKVMkxrEg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx7r/MyDVjdzmsnaO8lADMNGq5661bwU4UI0dFnRafoRAtn7iOo
 KolJG/4IYbhteUP8eYaM466vSe67098kgh/q/1CK03L2Md71Zn15Gm32s8hWo1MbHKw7LGSsudp
 9AAQwUKVh7Bsq+7TN6IR4uuDqUExQPXwhRrU6AqKu/ztXOpof4NaIacvA/Ea5k9Hsi5djzRI=
X-Gm-Gg: Acq92OE5zeIgVUJKrvm0UdbzUNYObMfe5N2zbf4qIaaxkFc19oWbOFCzK6sBiPLd/s6
 prlqWtmI8vQuDngdZpEau9v6SLLJVH3km/hmmLkZodg+bFMW0OjYL1HOPKiP1JwJp0o03kMJaXq
 teoSQFqAZlooIkWUGsauLEpojP/Z6mjBridyiGKqU9sCkynft28cd5dpBtYfqH4nl7usdQ5bSrK
 C1JLqc9IXOCAKY1ntw1b7eIeqpcOBDFvUON/MA0KMdERDMQTIIUSeZAn3dIwa0pHct2HjmRbBUf
 IATENYh6r/12mmco9urSFxCmID14kVjZVske1bmQfg31td765n3cXjF7oskeXPAew1UlvqAZezC
 KPOnMy1JqlmJQgYjMKRhK4qkGrSjuz+14KUPZt+ZlCldSfHVeQkYAnk7iAc0Nns38mHV34Jzuc7
 v+LL3W8tR1eA1gN3P9dwMq3vGWz4Q=
X-Received: by 2002:a17:90b:48ce:b0:367:b819:2214 with SMTP id
 98e67ed59e1d1-370f076d7e4mr16889784a91.13.1780901140481; 
 Sun, 07 Jun 2026 23:45:40 -0700 (PDT)
X-Received: by 2002:a17:90b:48ce:b0:367:b819:2214 with SMTP id
 98e67ed59e1d1-370f076d7e4mr16889748a91.13.1780901140012; 
 Sun, 07 Jun 2026 23:45:40 -0700 (PDT)
Received: from [10.133.33.209] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36f6dba8573sm18435796a91.14.2026.06.07.23.45.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 07 Jun 2026 23:45:39 -0700 (PDT)
Message-ID: <671f75e3-888c-40ee-9365-1c41f72e008f@oss.qualcomm.com>
Date: Mon, 8 Jun 2026 14:45:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/5] misc: fastrpc: Fail Audio PD init when reserved
 memory is missing
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260602071750.526-1-jianping.li@oss.qualcomm.com>
 <20260602071750.526-4-jianping.li@oss.qualcomm.com>
 <bcm2eufawifaq65i5qlqmbam4wtv2du5re6c54tiamdbynmras@lbfd44kjb6da>
 <ddeff296-abc0-4e1b-a721-761e2cbd331d@oss.qualcomm.com>
 <mdmtc4sfeoishc64essdbrzcasd5kotbwtulk4pajjzvcy56fa@2dcpz23uuxkw>
Content-Language: en-US
Cc: srini@kernel.org, amahesh@qti.qualcomm.com, arnd@arndb.de,
 Greg KH <gregkh@linuxfoundation.org>, abelvesa@kernel.org,
 jorge.ramirez@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>, quic_chennak@quicinc.com,
 stable@kernel.org
From: Jianping Li <jianping.li@oss.qualcomm.com>
In-Reply-To: <mdmtc4sfeoishc64essdbrzcasd5kotbwtulk4pajjzvcy56fa@2dcpz23uuxkw>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA2MCBTYWx0ZWRfX7/H/L0BsBdrv
 aswtQbyrmeRXvXeEB+y/wHpLX+/+fGV+EYeUZez0055UHGjiOfbavLlF5zGKPN9nxrPSYejVB20
 wcUdc0/s3ZAJ3JI3gZIFp4Hr0jqKhtiXKHtMf2x2RgZybCPQRUl13W9W1ocrdbllRtWFG15PxOT
 pkgs6KIFeXtqKqV2gb2XI50RzUARyv+Ga2imhghoT2NClbgOw/gy0X/6PKGFbBCXx48FBSpemQy
 Dxst3PlGtmlZPMg6Qdu33DmPWZ4I16uIPT2L1fKg/g5Jh0z6W770aYVhZopsQA8v4iYnGe26FcG
 rmFK1JnVW8HRB1YnStxRS7yP618LN+PnxyjTIQkeSO4mcTIy9IsBhcfQlBSY6oMg3NbOaXC5IuM
 E5ID/uGYIHaYeeOygwzCDDh6CKP+Sp65sReDEsuGN+oS2iwmT+45a+MBC8GIdYA82+FlMEpFpaL
 wNPsQnK0ZIpMyej/RmA==
X-Authority-Analysis: v=2.4 cv=G/4s1dk5 c=1 sm=1 tr=0 ts=6a266515 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=ZwHI9cLKf8hZ7ncMh4sA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: lSfn6Q0g64wPUpsc6kxsYa7m-ByMjSjz
X-Proofpoint-GUID: lSfn6Q0g64wPUpsc6kxsYa7m-ByMjSjz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 impostorscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606080060
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


On 6/8/2026 2:37 PM, Dmitry Baryshkov wrote:
> On Mon, Jun 08, 2026 at 02:29:13PM +0800, Jianping Li wrote:
>> On 6/8/2026 2:11 PM, Dmitry Baryshkov wrote:
>>> On Tue, Jun 02, 2026 at 03:17:48PM +0800, Jianping Li wrote:
>>>> Audio PD static process creation assumes that a reserved-memory
>>>> region is defined in DT and exposed via cctx->remote_heap.
>>>>
>>>> If reserved-memory is missing or incomplete, the driver may pass
>>>> invalid address/size information to the DSP, leading to undefined
>>>> behavior or crashes.
>>>>
>>>> Add explicit validation for remote_heap presence and size before
>>>> sending the memory to DSP, and fail early if the configuration is
>>>> invalid.
>>>>
>>>> Fixes: 0871561055e66 ("misc: fastrpc: Add support for audiopd")
>>>> Cc: stable@kernel.org
>>>> Signed-off-by: Jianping Li <jianping.li@oss.qualcomm.com>
>>>> ---
>>>>    drivers/misc/fastrpc.c | 7 +++++++
>>>>    1 file changed, 7 insertions(+)
>>>>
>>>> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
>>>> index a8a58f889d07..f46a8f53970d 100644
>>>> --- a/drivers/misc/fastrpc.c
>>>> +++ b/drivers/misc/fastrpc.c
>>>> @@ -1354,6 +1354,13 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
>>>>    	} inbuf;
>>>>    	u32 sc;
>>>> +	if (!fl->cctx->remote_heap ||
>>>> +	    !fl->cctx->remote_heap->dma_addr ||
>>>> +	    !fl->cctx->remote_heap->size) {
>>>> +		err = -ENOMEM;
>>>> +		dev_dbg(fl->sctx->dev, "remote heap memory region is not added\n");
>>>> +		return err;
>>>> +	}
>>> Won't this check without the next commit break the kernel? I don't see
>>> where else the remote heap is being allocated.
>> Yes, this check depends on remote_heap being populated during rpmsg
>> probe from the reserved-memory region, introduced in a subsequent
>> patch in this series.
>>
>> If there is no dependency on the next series, the remote_heap allocation here after the if check.
>> The logic will be wrong.
> So, at least you need to squash those two together.

ACK.
I'll squash those two patches together in the next revision.

>
>>>>    	args = kzalloc_objs(*args, FASTRPC_CREATE_STATIC_PROCESS_NARGS);
>>>>    	if (!args)
>>>>    		return -ENOMEM;
>>>> -- 
>>>> 2.43.0
>>>>
