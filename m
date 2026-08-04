Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE89FC55172
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 06:41:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F54510E86C;
	Tue,  4 Aug 2026 06:41:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="BbTnORsC";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Hy/OewEf";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA22510E672
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 06:41:13 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67418gAD2591821
 for <dri-devel@lists.freedesktop.org>; Tue, 4 Aug 2026 06:41:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 H39lZchhwgB2ZWI/XVAzanrpPj07o0jZUVBWG+r19OE=; b=BbTnORsCORVs0RdE
 qwOBWAuR649hCYk5p3cTncjrKrWIxp+OUO7wqGRrNzfxfhJChk/L6Fg3fmFptKMV
 1MZeseQ4QC0ka0Iyz18cOsjHoXU2wQk0bpY6Gv374g0EtiWtRaD0rgrqvWiYfLpy
 PQw6OKJqhoSaxyc1DuqNe1ueXwKMdXKtXgjG4pQ3VJnYv21JgAhucr6x2MBiS8Yv
 M0z5PlOZAlbspYFVL3Xia3HvcP2kjGYdENepUhDNxWM3QCBYUZjifTbPaGSKg/g+
 irSKFrGgDRnis/7WfmH+r/cFaIPUVksaC+NPioUKlR+gFDbLFnKKqeJX7//HC31b
 NeHUdQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fu3vs1jmp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 04 Aug 2026 06:41:12 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2cc73f47bdcso76185725ad.3
 for <dri-devel@lists.freedesktop.org>; Mon, 03 Aug 2026 23:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785825672; x=1786430472;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from:cc
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=H39lZchhwgB2ZWI/XVAzanrpPj07o0jZUVBWG+r19OE=;
 b=Hy/OewEfMUJQb0PAeU3THmYLq2PJVaaTEDNpkOtidGaMYerUoBiTN2z9ljMx/oCAGi
 VeZgwoCGcXW8PvENpMFmQ7BPHTDYbrUHTn+PnvFWDaCteMfGNbq64bnAr7JX/0H8GqQn
 BbL7I4uR+xoEF1ptBsPpdn8Vep4EhsbWXpK0QZlbzEh2B1LCA8RSambNecWXYbbn7dYV
 oE3ycbnB24jF7HBYYS14q1MQ8d1nvYabNKILrK0AdH+26ATi3MOaH1GXK1YgEJtMGp1B
 gfIfUSSqXBjbiM+vcNEKo8bV7sQ/fgfiTlf9n9Wi+5255Rtrh7x72LmJ46CXCf6RLR+N
 kKHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785825672; x=1786430472;
 h=content-transfer-encoding:content-type:in-reply-to:from:cc
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=H39lZchhwgB2ZWI/XVAzanrpPj07o0jZUVBWG+r19OE=;
 b=GSHgTfekSBuufAD/RvZstRskEJX+U4C06gBE6vh5wSXbIxVHVTnjskhrYcFAUMljgY
 gOGoJ7P7SH/Rlo5M8K1RN8abCQrYVwZ+Fu3YqG2YTb2Hf1c8yIb8pS5FGf96YB3AyTa0
 sDLWMknWvSVc/CkSArtU95BN0gunG7YE/LxbmV/tmOkJnWutik0fs5kZWBY1otxR5ETD
 aeIIEAs9+UwlzHC+W7i45APVmMSKEW6ZDU/K86qjWXUQNPe8W16ojMRLD3HCjWhAUkwI
 9lmvBt0OPCicLOkCrv+xN4bBZnLf4ES2Y3ecWD+jcClGPieA3W30YMLLCOJx5eyrqVSk
 93eg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoxYctnJMeX9841vS/pUBZNgWn8MVvjtIP5t5Ybaq6VutJ00WVQKvuIi+h/IOO70a3ValMm51DZC38=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw66y6H/QzlD0pBTWNUIGpzJW+/mH/ty0bFQG+KeVIn7gw2zYJ7
 /hlq5n7EBsa4JDWuHutfx9wVQ5SI2omR//uvTnkGsZ/NL1fClq84WH4m99NkLBQB/ZJVbz2ktB8
 684nDaKkTaa4SJchAErjJ6bvPSxYlhbSGBiqt1lS6ISEz4KB755YL37FdVf6dZbLdu9fQ5X0=
X-Gm-Gg: AR+sD11Mogq5z1423NTJ0v0tX8zN7bR1rCpbe9aTUXZCPvV7cWmxdT7TVpI5LjJgpGl
 bohHe+D16/mm1+svghNtsmI1Fhif6WfsniWb+XxcY6IeZK1QMhxdjSXglHxF8jEjSzBVDm+THvz
 72E4RnfyrZL3aGUxPkLLis777N0UoVTSfCQv3g4A5SmDECfzfDtUmgC/QpsEECxIvrqsATWfe4/
 gDoMoGbwh7m4vcFVUP4/DpBXcfKh5r1wKuJwdrBc4FsPsUYW+FpC4A2nsgLAh8PlAlS4ZJKIenb
 ri7GrBEqY5jlVHingaXOHQKjQ54y9DSKBehJcpB4WPr6Gfs4RN0fhAD+sGs0Vzc8XCZZ/b63u2l
 sfhMPH6SOJj49ugd4oHuTfjKRYtTSqC2FxYFDiOWPYKWDvjXFDnkZvvvS/18zg/nuYU7B8g==
X-Received: by 2002:a17:902:f70c:b0:2cf:dcd4:c646 with SMTP id
 d9443c01a7336-2d052462f7fmr125110605ad.33.1785825671568; 
 Mon, 03 Aug 2026 23:41:11 -0700 (PDT)
X-Received: by 2002:a17:902:f70c:b0:2cf:dcd4:c646 with SMTP id
 d9443c01a7336-2d052462f7fmr125110275ad.33.1785825671075; 
 Mon, 03 Aug 2026 23:41:11 -0700 (PDT)
Received: from [10.249.10.23] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d0aa49325bsm685055ad.40.2026.08.03.23.41.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Aug 2026 23:41:10 -0700 (PDT)
Message-ID: <68a09a71-9b34-4219-a5aa-eba3467a2ae1@oss.qualcomm.com>
Date: Tue, 4 Aug 2026 14:41:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fastrpc: Reduce log level for DSP info and reserved
 memory messages
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260514062825.50172-1-jianping.li@oss.qualcomm.com>
 <cg526ebtmnboqpw5aabwrtmoc7fhnvc57dmjax5zltcjonnazv@pynuwgpx3bi5>
Content-Language: en-US
Cc: srini@kernel.org, amahesh@qti.qualcomm.com, arnd@arndb.de,
 Greg KH <gregkh@linuxfoundation.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
From: Jianping <jianping.li@oss.qualcomm.com>
In-Reply-To: <cg526ebtmnboqpw5aabwrtmoc7fhnvc57dmjax5zltcjonnazv@pynuwgpx3bi5>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA1MSBTYWx0ZWRfX5xCWMzewN+4k
 SKbA0QH0twC5Xm3x258pPh47F7Ob4uKdLsWul1U2UDxepFF+rj4CtcYwb+zp0wML5dBCwcAemh9
 sVZx9539j8UKHVHYv5mXpS8ZLw1YGAxroe4uvpwxEv7+x9Xswojpl2VF9lOnvYRJFJ081YULbRM
 UcoCSbHmzzyPHg0Y+R5iwKtVLD90FZ4KTNG/qZOxuKoGzeLpkmk3c553IvyW1VrCiVs+e6Ddf0E
 j4OphAPYauYfozLIBLLTdCEMgEz/RXE766iIz6TxzrgTAHJQLnbz99hUd2WV0H+mRjO801suME/
 LJoTNaoJYMLTFG5ecF7u0dbmOJ//1Y3uEGaCO8Bvu//5IGfoSJkhhBFSTILvSbtYP/Jk7SC8o3n
 dJiv4VFbk81qTJKmIfdQnTQhmhOhyDp9umKo5bS/tcmrLOTLrOTzIODxsz2moP07ZPMB8RIDtGM
 KSnW/kJbG02DtxS+ylw==
X-Proofpoint-ORIG-GUID: oqJLtEsjQFuMnJYBECShfuhooTQk1Kg6
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA1MSBTYWx0ZWRfX1H7ddwAp8KRf
 p3mNyMzF4BkIdUAGZIYi9QD01qu0q9xxfa6w5xPqE0wXtmuomJxIXY3Iw5YAqBgqHjNGzsKIEXs
 E5QJR2lXe7s7Was7mAKulV/t5kSOA2w=
X-Authority-Analysis: v=2.4 cv=EK82FVZC c=1 sm=1 tr=0 ts=6a718988 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=Ek8-BH9n-rQyWAOU1C4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: oqJLtEsjQFuMnJYBECShfuhooTQk1Kg6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_01,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 spamscore=0 phishscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608040051
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



在 2026/5/18 7:08, Dmitry Baryshkov 写道:
> On Thu, May 14, 2026 at 02:28:25PM +0800, Jianping Li wrote:
>> On some platforms (e.g. QCS615 Talos), fastrpc may temporarily fail
>> to retrieve DSP attributes during boot, resulting in repeated
> 
> temporarily? What does it mean? Should there be any sync with the DSP,
> letting the FastRPC driver know when it's safe to retrieve the
> information?
Hi Dmitry,

Thanks for the review.

You are right, "temporarily during boot" is not an accurate description.

After further investigation, the message is not tied specifically to 
boot timing.
I can reproduce it at any time by manually starting adsprpcd on QCS615 
Talos:

     # adsprpcd

which results in repeated:

     Error: dsp information is incorrect err: -1

The failure originates from the DSP capability query path, where the DSP 
side returns an error while handling the request.
This feature is not currently available on Talos adsp.

Therefore my intention is not to hide a boot synchronization problem, 
but to reduce console noise for a condition that appears to be 
platform-specific and non-fatal.

I'll update the commit message to describe the issue more accurately in 
the next version.

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

