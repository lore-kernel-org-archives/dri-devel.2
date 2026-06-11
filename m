Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 306ECCD98CC
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 13:10:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8138010EF11;
	Thu, 11 Jun 2026 13:10:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VLMFwDzx";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF80B10EF11
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 13:10:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 095ED60098
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 13:10:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A03D1F00893;
 Thu, 11 Jun 2026 13:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781183410;
 bh=wBSGjyUJtcXDpGIJgk1Phh1M7+2MtpAsxu8xysdwt08=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject;
 b=VLMFwDzx69DCpHo+v1GSziCSbNpnfvCO2CsnjpAbZcjxFwZHjsoP7K4mxcnWt9T8x
 Hkoh7j/v7LL7ctpwJgwek0ludDLEfFDqKp5sZiqX9Vhu4eEvfWaR5Xe+hRP9AMqfZv
 stAVEHuPWjHhXPdjzoRNVt2HZXVF0VKeKo7BkgNvWtvp9NpKYDf0oeBbO9xWXmtdkS
 EYw+UtNKoqNMuR5AZoSqwO4masrXTEY71TyA1XaOjHwZ8ZkHfYrg2Gur4/H35FmQZT
 cckO5H9RrxRsq0jZflun/aGPjbYfD4NuzQPveCAAvVkqvKwHWZk1SE1rIN1QfLf56H
 yKZZDF5M/7ArA==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfauth.phl.internal (Postfix) with ESMTP id 9895EF40084;
 Thu, 11 Jun 2026 09:10:09 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
 by phl-compute-04.internal (MEProxy); Thu, 11 Jun 2026 09:10:09 -0400
X-ME-Sender: <xms:sbMqanyP98ILpge8RnPAxc1YFoXpTzkiJQR8P_ZRYO268Z6tpfx1Kg>
 <xme:sbMqaqFTMBi2S_L-HsbXMpWmItsWKAeSgcyzAx5N3ojJWQMU8cPN6QyAMhgd0t5f7
 s_DDWTE1NWHKU3P2K8lUaPTJTtD5Kxt9QoKheLTqX17n54-s5PH0Nc>
X-ME-Proxy-Cause: dmFkZTEme83pekAybtxD1gGc717p/3ydRSLdop2WS6iFwwB1KLSyS4MEmr7D8w34EGiEiJ
 /oMOXz6XGaVTgf6WhpCd34DiWMrNqs2yDYSpIEw4O6Hhdc+9q12rsKUn5re4a/x6xcOO91
 sESSR25t5XGG11ngvsxHDdKUmP/iHsVvcUGrCt4++Bx3N79xqiLKaVD4nNEiIKpLk2cfTj
 a9VcjnTgQwCGX4ARW7J57pJHlQbVIQsBGOSm4ZJXEAN9/ZSFUD9Gf9Q733tA1TqfyEw1VK
 rAV1OwcOUV/Bsf9eHuChzWLmdsgxxg19FAbjTOrqFvWBRbHOhf6CGfi65eqTuY2r5aY6aX
 ZURltO12+pjdy4SNxMsug76zZyQQGX6ZzIg0jq9i26bGOry5afcv8phZzDFsOMxqCBDuY3
 s7zWD7Exmn5Wr2zoPkQ8sWEirMJTVjCaEpGgWdmctNH6DqOgIf7sXH1DsnTA2AEYrJoqcB
 Dcn+wQ8GIE4XkfKXnOK/JlcnzlS3UAhLSvnV0RvqQ5vTK4WTp1sHFfzemyOJiR2+hXxecV
 ykmb2ms3L/iGg+Kd7w3EFHufNZDpC7K51GBg+MhecEz0WdncIulMC+KTVK7jwYD3/0iRyu
 Or8aGawVBVYnjKTgXq4HfKASfpglv/1OS8c+WGGQvnkbDR9mD9CDTztoCbMA
X-ME-Proxy: <xmx:sbMqajG_WLWjg_AROYz91UUz-QNmWXyzQVIdGIdf54ENvzn6i9wlfA>
 <xmx:sbMqakpZU0_b4yDxoj_jzbbzvywEwkLiy-QHv92Y8etzlRNO_cegew>
 <xmx:sbMqakQzggBrWUDWcYwOLKjnHYIq9INcJitULLnfGnFDRr_dPpuNQQ>
 <xmx:sbMqapPjAB42u41zYPUwjD4LvO0PpN9RlFgRKwalm1pH5A0Jh1VERA>
 <xmx:sbMqavP_2AxhL1X59LEwuNf7bFggng_4pkcjIXOHBtiloTc9UO74RzbA>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id 7ADB71820086; Thu, 11 Jun 2026 09:10:09 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: A-ht9oflRpwo
Date: Thu, 11 Jun 2026 15:09:49 +0200
From: "Arnd Bergmann" <arnd@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
Message-Id: <dfabf162-aa69-4667-a6d9-fa922ebc191a@app.fastmail.com>
In-Reply-To: <20260611130843.13C4F1F00893@smtp.kernel.org>
References: <20260611130240.3388318-1-arnd@kernel.org>
 <20260611130843.13C4F1F00893@smtp.kernel.org>
Subject: Re: [PATCH] amdgpu: lockdep: move temporary mutexes off stack
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
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

On Thu, Jun 11, 2026, at 15:08, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential 
> issue(s) to consider:
> - [High] The `reset_ctl.reset_lock` mutex is left uninitialized after 
> the removal of its `mutex_init()` call, leading to a crash or lockdep 
> splat when `mutex_lock()` is subsequently called on it.

The initialization in part of 'static DEFINE_MUTEX()'.

     Arnd
