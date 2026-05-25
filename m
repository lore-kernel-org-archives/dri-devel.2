Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74A61CD5BB1
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 13:28:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAC1410E340;
	Mon, 25 May 2026 13:28:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="TMGZ0Le7";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JCLnGB+x";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6ACD310E340
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 13:28:40 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64PA4ZGV2145970
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 13:28:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=3vsvTb/6Fe8DgRA6zwwPppPj
 vzf3iLOZvmJxDZPKrYo=; b=TMGZ0Le7NMFB6fG0wtxslTrHN0Y6o0OdMykaD9w4
 gvIY2We44w90bZaD+rxypWal8n+XvSTLi62iKa87ZdriFCXWmocTzmODxbBSvrZr
 Yhv+lg91GXzYStbYxQr2TYUJHX5sPuQbdjYXPrZVzDDbkBndLtpq3iZo9IxXaICa
 1Ua+OpQmxHhxKglraXQGN+N2AoujYXwmXir9s7FP/lFu55MjYmFp5sQPSqbSLXVG
 FXZyxA3nfRVivqrVqnKquP/D3FRCH65+BFQ+KLJquHR2zRTu1WFRAj1jZQCtOiVE
 ksw33zbS6gFSXCuV3dj5Y4l6sf+s5uowmpA9TD/gr5ASbg==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ecmbv0ms2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 13:28:39 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-63a6257148cso5651718137.2
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 06:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779715719; x=1780320519;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3vsvTb/6Fe8DgRA6zwwPppPjvzf3iLOZvmJxDZPKrYo=;
 b=JCLnGB+xQFpl0/ObJpbqyFTD2h65G7g8z6IvNcZ54hzlfSRWi9RAuNBhmVNYyHY5/f
 L6BvZOjIGGawvtxD4eKsGcyZMHPXPpM9JHbe0qzq9GYPXeGxHdWA6zLTS4fi86a2OwQB
 p1y2w4WZnvH0i12uULHliKRWccpnCDUZdV0TGHhrJTdplThikulLXBWq1w9bOicAyJuH
 NpoHPUyBP5Wo51QrOboCLy3R8Cu+qyYNG4dS2gNGTEaH2/QF6xGanVYe+q3Bq8ZQCGf8
 1cxYhZEoRcHLy3k3FwixqC8RzFTmUBOcVUfARyse95Dv0AEUKJQjkNa7unZTFQSV8qdp
 61xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779715719; x=1780320519;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3vsvTb/6Fe8DgRA6zwwPppPjvzf3iLOZvmJxDZPKrYo=;
 b=Fzd4JKI4dPBU5PDhHzhb4fwa76Zx4XDq1vxi2J3EzD0t8XOd57lmtSOCNMR1ng0IzW
 g4PMLICgThyUShBGWUBFBHI8Ma1DSSLXqEvakTyTcgPRMqV8W0kg88DfX51b/D3MNvQi
 3CWlqKzE9Ofe9fRxmH6XsUdyTwGGUNPmmh1fY6tqY1c6eND3W7pxBrcMpq1RdDKUmlkQ
 GVTzFZABJ3Mh0QCcOIrsGldVlioRcYYJtBJgJuAbGbReHXyeUfbCpLP9oY5mqbKbgyrM
 nOD1th5/Xao8o5O51NY0VBXWmdBqY+kP/fxCLJDF4dtpG/R96IMSMcq6SsXBA7tRKb69
 Sp5w==
X-Forwarded-Encrypted: i=1;
 AFNElJ8j3ziYTskZlusXq12lScHS6ANBqxW2jTTt/NkTvHcOz59bRirpzoG3iuWa5XA9j6qi6vk33rfO+xk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzfcKTHiVaFVkDe34REpd68hPo76HNc2e/1Gc+Sa+X2hTXeQPgc
 y3CSsjM5YWKMy2h/KifYgh8m2FfD8UsQASIWmS0sXZ+7lBf4hCPXXJmBKh3/gPL29Prg0tCzfa3
 +e75nCl1rVj6BpcoMtetSMC4QZj3KnaQM4al6hKv7l4pCDakEpiAVAm/5CS+JeUOFeO762+A=
X-Gm-Gg: Acq92OGVLFZYo5ZCpkKRGclUpathoEwltyl4P9FUJCo1J173pzuofptNI2j2o+La4dU
 OZDS8aO4OyCJJ5ogk/AqPITvKFG2ZdJS/Sj4AjqemOuSpFDmhx/It4DfAmIUvLQ6WDkNoTQnphz
 xanbF03uH8dVYRAG+aiTVTP7daYWA8emKM6QhX28YVwCciJWKQ/JEx6bHZdjnM66APSwt9g833m
 aU8zNNNMk1Xi+TP5expvucT0pvvGNLnIeFDJJ+VcqJFTr3VJtNsUyExbDTMH+Rn2lDOy9XT7fTb
 WVEIZUw3RQCqkpRMSdAvvwi5aIXPLLBO8D56SU50GFXYXozOL/MQ/2LcD2DGzGkDmdU4aBdrEvl
 Usv/sqHq7bnxwF9eeQZWfGc11q/jpljlzIPn8bMWdsC5li6S58tOruuo4guGHmKkWgoBCvngSTa
 kISD8c2tqBBiy9XMh6LlABa1IWALHS1q/MjtE=
X-Received: by 2002:a05:6102:580d:b0:631:4191:6f7e with SMTP id
 ada2fe7eead31-67c6f273735mr6956988137.4.1779715718774; 
 Mon, 25 May 2026 06:28:38 -0700 (PDT)
X-Received: by 2002:a05:6102:580d:b0:631:4191:6f7e with SMTP id
 ada2fe7eead31-67c6f273735mr6956962137.4.1779715718168; 
 Mon, 25 May 2026 06:28:38 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aa32cb37b4sm2734652e87.1.2026.05.25.06.28.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 06:28:37 -0700 (PDT)
Date: Mon, 25 May 2026 16:28:35 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Anandu Krishnan E <anandu.e@oss.qualcomm.com>
Cc: srini@kernel.org, linux-arm-msm@vger.kernel.org,
 gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
 dri-devel@lists.freedesktop.org, arnd@arndb.de,
 ekansh.gupta@oss.qualcomm.com, stable@kernel.org
Subject: Re: [PATCH v1] misc: fastrpc: fix context leak and hang on
 signal-interrupted invoke
Message-ID: <37zqhqm3ryyigcalimems2xvy2ccq3eyssls2pqx4qjufx57z6@w5kbehynw4h6>
References: <20260525124222.3082420-1-anandu.e@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525124222.3082420-1-anandu.e@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDEzOCBTYWx0ZWRfX1turLEW+cKnf
 2gtnZQA2xfuHcCo4hYb11hGjmDh9ceaS8cvXzNAqX0ljbYPHYMaOltGKiifhJbV+/jeypm3OBQY
 UXr12HRHlyhDzgcRQRNvZML20bICDZmNmTuHIaMJ129LFK4RrPSelqwAIZ6QkI7otOTOF8IUmF0
 LZSDDYJhKudsMWvp5FDFDraTDfL2Iod61CNC0UBGKyD+ByLYvCQOKFo8dkxOai+e8FpNb03USqa
 jCVY8dZqyYw9KnXGrFmBFgO+Xr2hIJyweYt9ZAgolYcaVbxdTj7K9QOnOTakJzg1qcPoNwWFPRH
 tjJwlt5B+JMGH6De355op8qA+o9IDQVTOm0MRP8EMFNbO5+ErsRECWyq87lJ2OoY3+F59srGnUx
 Ybi4YcSlfyblOmjqIyfU6it5B27v5YJxurEBDtM3zyaAKEluDmhjKDCYjEIhikoha8kSHTH0CCR
 939B8h+8eLOmW0b1/HA==
X-Proofpoint-GUID: bLfr-IyNhsc0ST0_zoCXeshhU4EDk2LS
X-Proofpoint-ORIG-GUID: bLfr-IyNhsc0ST0_zoCXeshhU4EDk2LS
X-Authority-Analysis: v=2.4 cv=XqTK/1F9 c=1 sm=1 tr=0 ts=6a144e87 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=pCu_hpMinXdEdo1Js9MA:9 a=CjuIK1q_8ugA:10
 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605250138
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

On Mon, May 25, 2026 at 06:12:22PM +0530, Anandu Krishnan E wrote:
> fastrpc invokes work by sending an RPC message to the DSP and blocking
> in wait_for_completion_interruptible() until the DSP responds. If a
> signal arrives during this wait, the syscall returns -ERESTARTSYS and
> the invoke context which holds the in-flight DMA buffers and
> completion state is left stranded in fl->pending.
> 
> On the next syscall attempt (either auto-restarted by the kernel via
> SA_RESTART or manually retried by user-space after EINTR), a fresh
> context is allocated and the RPC message is re-sent to the DSP. This
> has two consequences:
> 
>   - The original context leaks in fl->pending until the file is closed.
>   - The DSP receives a duplicate invocation. If the DSP was mid-way
>     through processing the first request and had issued a reverse RPC
>     call back to the host, the retry sends a new forward request
>     instead of the expected reverse-RPC response. The DSP thread
>     waiting for that response is never woken, causing a hang.
> 
> Fix this by saving the interrupted context to a new fl->interrupted
> list on -ERESTARTSYS. When the same thread retries the invoke with a
> matching sc, restore the context and jump directly to the wait,
> skipping context allocation and message re-send.

What if the userspace doesn't honour -ERESTARTSYS and submits a new
workload?

> 
> Also drain fl->interrupted on process exit and complete any sleeping
> contexts with -EPIPE when the rpmsg channel is removed.
> 
> Fixes: 387f625585d1 ("misc: fastrpc: handle interrupted contexts")
> Cc: stable@kernel.org
> Signed-off-by: Anandu Krishnan E <anandu.e@oss.qualcomm.com>
> ---
>  drivers/misc/fastrpc.c | 69 ++++++++++++++++++++++++++++++++----------
>  1 file changed, 53 insertions(+), 16 deletions(-)
> 

-- 
With best wishes
Dmitry
