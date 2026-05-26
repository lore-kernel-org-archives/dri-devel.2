Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CBE7CD5BC8
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 08:35:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8283910E608;
	Tue, 26 May 2026 08:35:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="HfvsJ4JG";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XuDEHFAK";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0116410E608
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 08:35:36 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64Q5ivoo1802490
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 08:35:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DxN7uZ0WxSxkaNekTFdgi3oj+0DA7+48Vw++MklSwVQ=; b=HfvsJ4JGWoXw1fuD
 Krxf92uXqUokgbUoD/JC4DyGvFSiA39CXGRsv1WmMpYfPazMuL2rjuiY5eRfd0O5
 M62T2BzXqzeN8byKZABnSjRSU7sPVZSGgN51iGT8+9Kl+pa+0YUOUkDf+RSp+FaZ
 IsZUbTvPzPiMLbpmvjSvCaVVDRiI9quaaOxjwpOdkiiJkXeCOfSHOS+aZ1Mdz5q5
 GrfIFLY8I3dz1wyVXtXwKBisORSNB8vG+EJC69CBGzGBr2GaDwG9hPxOCd9QgAl+
 NvsnJJIOq/w4eqp9thjx5ooh85MoC1RgycqRCLWQvnbachSEa4M7lO747CwC5s8y
 /Ff+lA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eckyqku9v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 08:35:35 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-82f85179263so12089581b3a.3
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 01:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779784535; x=1780389335;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DxN7uZ0WxSxkaNekTFdgi3oj+0DA7+48Vw++MklSwVQ=;
 b=XuDEHFAKSWjP3YNGPgKIyzQzjZPXEo4jcT8Ik6nPrvMUV5dImu9noQeHe4O+nOsNI6
 Aa/RgEtAuiZYFAF7MACVaRvReIb1CLVlkAgEZOxtARCEzWzJzRJLBktC5dQOwH3FRk5f
 VeQ4ZY0/n2i0bkjlsqLOYHuVRhaxqCnGRnLLndcXOFxqbWyEu0lAIRQT0W0Rtjv2l5Xj
 fISwBI8e0zePF+gWZC0kyLq2/KF++s94JNPG144f33ruhYBqWmB59T4omrVM+nHHIij9
 q8Waz0nopI7099g7OFOWHqw3zSPwXvI2aZxr170Q1cjGYLXUx/O+N63ud5FKrpa69glj
 kk0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779784535; x=1780389335;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DxN7uZ0WxSxkaNekTFdgi3oj+0DA7+48Vw++MklSwVQ=;
 b=r4lKtAukJaiN/ajkhfAmk/kwQb0PLGZXgvjghtNylmJcZ77lCAr6bMxOs4ROgqYOKr
 G5DFzTrcpoWhT6JvkYP7Ce6c+56GrW2pknGT0/AnUSBIa5zHZ/Nrw2pKFGRV/0W6hhei
 tWJnQXRV5iTG8KRy6irRRRdVnPO768cOlVTsojmM5S+uZ2RFLTobjILT4WOwJNGclh4H
 0OaUojSIk+5dht+0tai3pubXfAoAkWCMbUs0OYhWTscMFLp6V915H5tC3LE6YKAYeEsx
 IazxgjNjrgH48Ah4WLESfx3ozsmJ1zEHsYr8Skd3ACVCqjXiNSiHsZ4s3z+4IIgmIHFX
 GfKg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/KaQ7UU3M8fMCn8zbGSF7XVSoNXfhOWTNWJzzsSaYSUVsNl+QSsHhEY/71iTPIYffeiPsUpxz3huY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzFJfyXERh/fNdtgWfAht4pQxsfAyMUQCFvpLjfCHe7eZJrm6Y1
 hchErYigp3zmtKQN5lN5qjMCjmJgJMm+dTdZ6Ygln9EJHbGOcekWwtnPHJwz6C3l06QQpGgxIZS
 0+zAl26aJleZav05e5pDPHwzUxfpK4HKG6Whj6BwlxxktY7Bz4dP0sdD0wyYbNqLGJDC1kgE=
X-Gm-Gg: Acq92OHBl/qQPLcJYm813/Cs7ssuCbABut4lfBwRSGpbA8Bp1c8ul6ZpftiPEpbTord
 iKXKtwAcCo3VESmqC0/TFFbURidLLFcq9oh0FwoElQRT3IxHzQHYSrtNOrh/4HHCbkKueJRNo8p
 9pU4eM4XMr1c6bjDJYuOcaML2z0Cb6fULbNrG9hpf69t06EOCNW3iiuu5tHfTiqivMbwyd8ktS2
 6G07S7sxOeK1qqlFHSnTRZxd+ysuaNPEps//ImfG7pI4h76EX5Ll5BFzBG7s2dMigdrHFN1pcir
 rGE+d4ykIxin/LUNRdqe1dYpet2aN98NbRsEzIXixHFQgZPnoqGyqe053bWWZyh1rGO8ibkgOjx
 VZMlSSFOZU4hYtZyqxNXdW3iNVXJvWyMncg+wCnaAJbNbqA==
X-Received: by 2002:a05:6a00:3a0d:b0:82f:3828:a009 with SMTP id
 d2e1a72fcca58-8415f3b0771mr16934565b3a.3.1779784534879; 
 Tue, 26 May 2026 01:35:34 -0700 (PDT)
X-Received: by 2002:a05:6a00:3a0d:b0:82f:3828:a009 with SMTP id
 d2e1a72fcca58-8415f3b0771mr16934512b3a.3.1779784534257; 
 Tue, 26 May 2026 01:35:34 -0700 (PDT)
Received: from [10.206.98.126] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84165009852sm11859079b3a.59.2026.05.26.01.35.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2026 01:35:33 -0700 (PDT)
Message-ID: <02630778-a16d-405e-9ce4-7076d14c06b2@oss.qualcomm.com>
Date: Tue, 26 May 2026 14:05:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] misc: fastrpc: fix context leak and hang on
 signal-interrupted invoke
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: srini@kernel.org, linux-arm-msm@vger.kernel.org,
 gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
 dri-devel@lists.freedesktop.org, arnd@arndb.de,
 ekansh.gupta@oss.qualcomm.com, stable@kernel.org
References: <20260525124222.3082420-1-anandu.e@oss.qualcomm.com>
 <37zqhqm3ryyigcalimems2xvy2ccq3eyssls2pqx4qjufx57z6@w5kbehynw4h6>
Content-Language: en-US
From: Anandu Krishnan E <anandu.e@oss.qualcomm.com>
In-Reply-To: <37zqhqm3ryyigcalimems2xvy2ccq3eyssls2pqx4qjufx57z6@w5kbehynw4h6>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=RMyD2Yi+ c=1 sm=1 tr=0 ts=6a155b57 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Kv5pTRVh4xdshmm17rYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: 7Lh24gzv9EqCxihrpfruyw5V40fKe8Do
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDA3MyBTYWx0ZWRfX06kxhwW/aSbl
 vzlPrP9+OZ7z/vncVJARn/qUbQUEt4AS8FLrK2nfbvHgYWiSJUqhxghPfysXKQsieJBzH6RZTEU
 O2zC/SBfM31Vwwe7htUIO4Ipb8KDcMIMT1OFAUK5thaPBnETbMx1hK5uoMyiJwIMipdnAr72Baw
 ERJ+D+AnDUKvKCMmnAiE579ODmWSJToOwYUW2j+wqxdUrIDJzPJbvynHkUGh13t3RNpkgS+OqmM
 Ku089bhT0aUCP27I66E5/zh9TaZJvgerjS7uavo82uyj6Hb7Nz2BJDJA0ZXmUMKDHTY3Cz4RuPl
 uMRUxu1R732/4avDzgert5qlRcfecczUW61UBj7DDllhF5hlOJSKDUKGywU8JMY9oZ+7Kwn1H3z
 S/M1x4s1hy78pluoWckS8nv91rN4k/cS1Ar1Ox18Ttnb8EBgQJC7oCFSeJIaVbIbpma1Jq+10my
 +cLTkXif7rmJa0GIV4w==
X-Proofpoint-GUID: 7Lh24gzv9EqCxihrpfruyw5V40fKe8Do
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-26_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605260073
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



On 25-05-2026 06:58 pm, Dmitry Baryshkov wrote:
> On Mon, May 25, 2026 at 06:12:22PM +0530, Anandu Krishnan E wrote:
>> fastrpc invokes work by sending an RPC message to the DSP and blocking
>> in wait_for_completion_interruptible() until the DSP responds. If a
>> signal arrives during this wait, the syscall returns -ERESTARTSYS and
>> the invoke context which holds the in-flight DMA buffers and
>> completion state is left stranded in fl->pending.
>>
>> On the next syscall attempt (either auto-restarted by the kernel via
>> SA_RESTART or manually retried by user-space after EINTR), a fresh
>> context is allocated and the RPC message is re-sent to the DSP. This
>> has two consequences:
>>
>>   - The original context leaks in fl->pending until the file is closed.
>>   - The DSP receives a duplicate invocation. If the DSP was mid-way
>>     through processing the first request and had issued a reverse RPC
>>     call back to the host, the retry sends a new forward request
>>     instead of the expected reverse-RPC response. The DSP thread
>>     waiting for that response is never woken, causing a hang.
>>
>> Fix this by saving the interrupted context to a new fl->interrupted
>> list on -ERESTARTSYS. When the same thread retries the invoke with a
>> matching sc, restore the context and jump directly to the wait,
>> skipping context allocation and message re-send.
> What if the userspace doesn't honour -ERESTARTSYS and submits a new
> workload?
If the same thread submits a new workload with a different sc while an
interrupted context is pending, 
fastrpc_context_restore_interrupted() detects the mismatch (ictx->sc !=
sc) and returns -EINVAL .
This blocks the new submission and forces the thread to resolve its
in-flight interrupted context first.

This is intentional. The original DSP request is still in-flight and the
DSP may issue a reverse RPC back to 
the host as part of completing it. If we allowed a new forward request
from the same thread in parallel, 
the DSP would receive an unexpected message instead of the reverse-RPC
response it is waiting for, 
causing a hang/ unexpected behavior.

i am open to new suggestions as well , can you please help suggest what
is the correct way to handle 
interrupted scenarios ?. 
>
>> Also drain fl->interrupted on process exit and complete any sleeping
>> contexts with -EPIPE when the rpmsg channel is removed.
>>
>> Fixes: 387f625585d1 ("misc: fastrpc: handle interrupted contexts")
>> Cc: stable@kernel.org
>> Signed-off-by: Anandu Krishnan E <anandu.e@oss.qualcomm.com>
>> ---
>>  drivers/misc/fastrpc.c | 69 ++++++++++++++++++++++++++++++++----------
>>  1 file changed, 53 insertions(+), 16 deletions(-)
>>

