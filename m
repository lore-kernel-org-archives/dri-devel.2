Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A21ACC43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 08:31:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D92C810F590;
	Fri,  3 Jul 2026 08:31:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="XCBPZ2IJ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FlpkuqTg";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2036310F590
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 08:31:51 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6635rjl33108915
 for <dri-devel@lists.freedesktop.org>; Fri, 3 Jul 2026 08:31:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 30jHl1aofyomvSG7on5YYtAKEDMGwM3o7HFcEeYIKXc=; b=XCBPZ2IJ3Eb8DgH9
 1Sst3yHvnu6gkYi6RdjV5PmhLo13mTWF9d03tdUedS6pbuhV3uP9MbGUdNNQzQKZ
 +rsy2HtQSjckn2dnP/f/UX9syZ6kffWztVskGwjs5gzqyqNrvkQDjrvZBwv/b8ZC
 xeSA6eNAecY6IThuro6QZpqEgrc98Qdsqw1Wr5D9Q2ZfTT3p9dkQIXTahQ8Tl+hk
 V/75xDZZ1XeOuaz0GFILi7iaV7sSJOjXg7nJzp7pvNRyTHONNSzfeqEReEDdKOCk
 PIE4uwe5faUsh8v6LRv+jjlxdudDI73QoWTszPJCMvnPgm7HnksSC13bhO1FQJvl
 bmmcXQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f60eya46f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Jul 2026 08:31:49 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2c80f89b64bso6302965ad.2
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Jul 2026 01:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783067509; x=1783672309;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=30jHl1aofyomvSG7on5YYtAKEDMGwM3o7HFcEeYIKXc=;
 b=FlpkuqTgUa2GaCL92GJVlnMczn6Bx2sjrnAPy6Jo4vqd9ahbfWJ58tKoacwOJTsWc1
 6CyuR6YomXGv63duceLFJdho719OLyEHvA18P+8RksryKrIEyepsdEDLCa+k8SsLEsp5
 2Pt1mIOGMmWloYRPen56EO6izfvIbsfJr9pabVVDkvI+lmmxIzrtwo+CNbNq9J2oDcvC
 qxJpXW0PatgYEiEdgT+7KCpKkO364+019PCq08AQM0ZzO5PqKmleY2f9ubHpVkI+Xo4L
 aaUiZIoyWLV2z1dW9tL1NkHMBXugbQDIg4ctyxN4XD83iIE9xkEd6hoqjMAVZvHItopa
 OpYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783067509; x=1783672309;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=30jHl1aofyomvSG7on5YYtAKEDMGwM3o7HFcEeYIKXc=;
 b=sR9RqdgxTi+ulAOEnAp+T399WAeBi3eC2iuXh+OyKtOjefjKb0vWZxlG+NR0GnBx47
 j1hCdPxXf5iaYmvPADbIn9asxOAB+oeXtzGefFd6Y1sdCsvUBP7ZZJ2ysEPW2Z28xe8F
 5DVsTYYKMp9ucwQnvKqfERoX+QG0Jva96KVGJsdBHOMNIEsBn6AhNTO9FolHXNWqLhxc
 KQSPfTfca2G2wEUfaxeW4ErZOIU4KyZUZDgD1sR8UBn7PNxKUOjfNsCqpPFoA3DA/hlz
 qiIlUZ4TT7ohOeMBeITiq6F4MDvPTs+N1rC5FO3OjuGghmhSIJn6jDgRp/euXjHJwC5P
 rIyQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrAdJZ2GjounmOSPOl4LM4U4H4W2/HdFVMq0Yyl2Nyc0lmmKzzIKQycQrCoIuTgwpKqmh68QSj/klo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyGxyz7/O9PWv7Nc3apO1GI0yaLTFSj8ODiYFMDv3Z2lxrOq5v+
 o4ku2gdbqefr3vf4knKyqAAO90bnw6vpTGBtR9i7Fb2TLq+h7a66Up8VP6mLC9jChzu0PxHZo7P
 ZY/qpmQ4HwrH1B5m+VyqU2yelmxYxtoLK3niC9S0eb5qgqE/PkgpJJLd/qRlpmAcp2Apwn5E=
X-Gm-Gg: AfdE7ckAS1RuJGrnXULZwM/ygtOM/mu8fdVPh2CK44kWFGXLfqY/sCE19g7yZ9WclIi
 pIOmw1oY0VJb9cIogxqIxs8mEc6daQ5Tye7I231Na/O4catxxXN2vK+0UEOr17889AR9IzHagJc
 NM8D/clzQSG8l6dmCYZRAU8YVJJ6H3ilS+BXz27bec62aHuN184knYb5sBcxTWcBItT8HHifaP4
 pelTpDzjS2lpXeiIojYpIbKAysmTlq3slck7yNjy060OkFjeByY1OyuKlrvew782sTIOQ1NQPvq
 3Z6Gw2K1udtEStpbqo9dK0TgHG4k4OrektnH++BZLPiIpA3VHR0WxCiRDLXTDmFBa6FveMkyL6A
 L0p1LXa3Jqhd91/6Mh5qq3uwRogWhfOzDWh6QQmc0rx1+7suR2xs3ma9ItLNNKn5r8w5X+lfC/k
 KWjKFvgw==
X-Received: by 2002:a17:903:fae:b0:2c9:e261:95bf with SMTP id
 d9443c01a7336-2ca7e757955mr102746955ad.26.1783067508756; 
 Fri, 03 Jul 2026 01:31:48 -0700 (PDT)
X-Received: by 2002:a17:903:fae:b0:2c9:e261:95bf with SMTP id
 d9443c01a7336-2ca7e757955mr102746625ad.26.1783067508205; 
 Fri, 03 Jul 2026 01:31:48 -0700 (PDT)
Received: from [10.133.33.167] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cad7871366sm5880105ad.62.2026.07.03.01.31.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jul 2026 01:31:47 -0700 (PDT)
Message-ID: <d883112c-5ea5-46e3-abb7-f7c611f52ab2@oss.qualcomm.com>
Date: Fri, 3 Jul 2026 16:31:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fastrpc: Reduce log level for DSP info and reserved
 memory messages
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260514062825.50172-1-jianping.li@oss.qualcomm.com>
 <cg526ebtmnboqpw5aabwrtmoc7fhnvc57dmjax5zltcjonnazv@pynuwgpx3bi5>
Content-Language: en-US
Cc: Srinivas Kandagatla <srini@kernel.org>, amahesh@qti.qualcomm.com,
 arnd@arndb.de, Greg KH <gregkh@linuxfoundation.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
From: Jianping Li <jianping.li@oss.qualcomm.com>
In-Reply-To: <cg526ebtmnboqpw5aabwrtmoc7fhnvc57dmjax5zltcjonnazv@pynuwgpx3bi5>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA4MCBTYWx0ZWRfX/VSnvFSKeVl+
 oH9KWvAEeeoMWu/RD6YsXet3RDykQvwUWseeyVu0ILlmYRoic0y0iVzEl8kJ2afS2yHCptOqDQ6
 aK9ZiAunJpU4pcq9RIO2V9NoPJdQoRYJEEca77q6Gl1pqecGEWliWUezDRyYEqYDX9oYbjnyU/C
 qF9GYIOwOwUQKvQMQf5o7wMU1wtIFV9LivoJ65Y1LlCUkaImkcSdV0ilg5O+66qIZNfRxFdt9/o
 uMVaXO24CsLNIGDnIvoI9gDDr9F9mGip8TZBmo8zviL07U7U1zFlG+EdJHPTkCtY24fJrJNpdz5
 rWadgjJD1hP+vt3P7sV4ULswO8k8OIB9Bk5xTo90G6w07SFxXKkz/+FIVQZihD2JxQFd/Lo91bk
 Ubb2PMtXoEULqCGxoSNTdTn2Lvnc9FaB10tHWLJtQgWyUV6tTcv917p682BZMzc9J6q/wybJ50p
 +Vp6TaGA1PT+AaUd5yw==
X-Proofpoint-GUID: -GdpwcozjGbDglS9ggUACLry7R-zvRP8
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA4MCBTYWx0ZWRfX7q1wk6UFQBew
 O3wDQQ5Fkvhpyp81QNOHZIFJm4ddU2B1B3n5+woXVCM7blEXS6hcC0eRqjW8UDkQRWioW3h6nAR
 tjpbQ2VEfLR1FpKH25nzkd49zv+UQig=
X-Authority-Analysis: v=2.4 cv=SPRykuvH c=1 sm=1 tr=0 ts=6a477375 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=C2AwR90XAiyykRj1wVUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: -GdpwcozjGbDglS9ggUACLry7R-zvRP8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030080
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


On 5/18/2026 7:08 AM, Dmitry Baryshkov wrote:
> On Thu, May 14, 2026 at 02:28:25PM +0800, Jianping Li wrote:
>> On some platforms (e.g. QCS615 Talos), fastrpc may temporarily fail
>> to retrieve DSP attributes during boot, resulting in repeated
> temporarily? What does it mean? Should there be any sync with the DSP,
> letting the FastRPC driver know when it's safe to retrieve the
> information?

Hi Dmitry,

Thanks for the review — "temporarily" was a poor word choice on
my part, sorry for the confusion. There is no boot-time race
that eventually resolves; let me walk through the code to make
the actual scenario clearer.

The FastRPC misc device is only registered after the rpmsg
channel to the DSP is up (fastrpc_rpmsg_probe ->
fastrpc_device_register), so the transport-level sync between
the driver and the DSP is already in place before userspace can
issue any ioctl. And fastrpc_get_info_from_kernel() already
caches the result the first time it succeeds:

     if (cctx->valid_attributes) {
         spin_unlock_irqrestore(&cctx->lock, flags);
         goto done;
     }
     ...
     err = fastrpc_get_info_from_dsp(...);
     if (err == DSP_UNSUPPORTED_API) {
         dev_info(... "DSP capabilities not supported\n");
         return -EOPNOTSUPP;
     } else if (err) {
         dev_err(... "dsp information is incorrect err: %d\n", err);
         return err;
     }
     ...
     cctx->valid_attributes = true;

So on platforms where the DSP firmware implements the attribute
RPC, the message is not printed and the query happens exactly
once for the lifetime of the channel.

On this SoC the DSP firmware returns a non-zero error that is not
DSP_UNSUPPORTED_API, so the else-if (err) branch is taken every
time: valid_attributes is never set, the next open re-queries
the DSP, and the same dev_err line is printed again. On RC
builds with metadata flashing enabled, several such clients come
up at boot and the console gets flooded.

I think lowering the kernel log level is the least invasive fix.

I'll respin v2 with the commit message reworded to drop
"temporarily" and describe the above accurately. No functional
change beyond the log-level downgrade.

Thanks,
Jianping

>
>> "Error: dsp information is incorrect" messages printed on the
>> console.
>>
>> These messages are observed continuously during boot when metadata
>> flashing is enabled as part of RC releases, causing unnecessary
>> log noise.
>>
>> Similarly, the absence of reserved DMA memory is a valid
>> configuration and does not represent an error condition.
>>
>> Since these scenarios are expected and do not indicate a failure,
>> downgrade the log level from dev_err/dev_info to dev_dbg to avoid
>> flooding the console.
>>
>> No functional change intended.
>>
>> Signed-off-by: Jianping Li <jianping.li@oss.qualcomm.com>
>> ---
>>   drivers/misc/fastrpc.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
