Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5897CD8CB9
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 15:23:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C38410E5C4;
	Wed, 10 Jun 2026 15:23:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="ExOTwLKO";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79B8110E5C4
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 15:23:40 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-490b23c828aso57395e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 08:23:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781105019; cv=none;
 d=google.com; s=arc-20240605;
 b=KqJVhuW5Dkm+gH21HGEpJoxA8moIZv7KOlO0NjqU8MWZgp4q1pgPGJyJPg28uMsnu1
 caqXzI8PQqnJ2tRpggU/VjTWKwse2llUatLJSwaF7iFkRxpNN0yR2TnAim1uABlM/n61
 p3DgMvJOsGPy7SLAZvxlwXlXY84W+KwBowtUp3AUYTE9rhJmYyGQ6BTAqbZWv0QVZbyy
 fvlE65tB57erZnjt2/sYgBvbUdLPXdy8Mk3wRsrebA3E1gtNJAMKcTTJP3wxjeC9vYND
 ypfzjmO2m0eF/01p6NP6V0f0nNpMpV75NxFtsFEHI7qW6chb6DNdg/no1K+a+0g70N6l
 dcJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=HLSNIkxH7X+mkcTC4TNft77b6jFG+UTH6aJ4cVsmWLs=;
 fh=DujrL3s1riTKzOBabuZ6a3fjnx7u2noai9J+FgB9Eo0=;
 b=F2NRRWK1sAjB/rYfmugvuL+HyZkrYtir0/3PYsP0ndcKelSN/npzZWtmBIRAFjjDTS
 32ps16SeSOJrv1Z+svlwrD6rMlq11AEHmPi1K83GemKdViUKa0+Utcw+8LtxO24Ebu+0
 KGu6qPYiXUtan/B5Mj0X4rpJbYEupwV5eC2vMtijEYlqDE3Qkt7oh6RiYH0tM6HSifby
 YMc6zNo+QxMV3Vp6qGD4iAxmcAh+hvOa89xheC3KLbooTQndcP4YsxnDdTFkTnGMvmI1
 4AltF9iBMvuRbaQHHn+Suy2FuKHqpUYm5TLzlRJEgwB5FFGqnOFPuNV6exrUregAZtBZ
 hBaA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1781105019; x=1781709819;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HLSNIkxH7X+mkcTC4TNft77b6jFG+UTH6aJ4cVsmWLs=;
 b=ExOTwLKORECW+arfyy+9liUJcqQPko2VnQ8qR76j6eXY+QoeWs40Q3b61VJb+bUIus
 d+0/m7M9ZfGqj6TSTIBU4VjY7a/NMxC2VdzUZFgantVFmGvI3wFTnA35svK/8S5AoCZV
 Ei4N5f6VWZgtkLbcovF2xYnAS0L1IQFfrsQrTHIHQW2Sate38wz15Die1vwBQx+TRrhi
 4tFsip7GioO0x9gWoSpcyzDXZdqus0tfTcjXslwMOZ9r6zgMW7vJWmKK0At1lnVxlsJy
 b69Zo/wPHkwDnObucUA7Es3DK5NPyLKGEuBAw04I7nyTu3ldt7Xq7AXVKViLqSb42JxQ
 Fueg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781105019; x=1781709819;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HLSNIkxH7X+mkcTC4TNft77b6jFG+UTH6aJ4cVsmWLs=;
 b=OK1UWjCyfS2S7GUOqTS/arZ+1DZVpXh8ZTVmIs5WTZ4rfn4lVVnNrH1si+F/yLPmNh
 Hr2qaJ/gIu0vmMSODHahAkTfS36MvbfIwSzYLKgUXRCVcI0lFHsV/HNI70Afjx0Vflpy
 7+9uxtFk3zsRfNJFYA/DHoq9u53SlI5LMDUmOdtnIJHpTyoCB+akNx+zmo6kndf5y6jF
 L0WOtWotENvQKt1TQZexQgS+EoBGVeLNB2wRZp/8kp/rbgWVPiy86jhrY5E/5OxV1gxm
 DMZSM/xIjP3KNbsm3ExMC0PhM0SljBBsw5SzrCCUqf+guHFRyW+wwtYmlLTS1wEfwMc0
 umpA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/a4Od3jrBnCrXF+jf1NtGNB/xajbkhFzl/o76YjArmEZ2+D1CGrHfM5irHIJ8Qa0k4S3MF0GLMjVE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyq1ab0/TO3x4SRsLW77i8oTauUti7HuVwwr4cNns+YU+q4PMQ8
 RQfh2HalHS1g3WlGHmft8pEVC49tqn/YLKg3oEbc8X5eecJExBXuhLNs76e6bAv2lY5Ciu68T5+
 g1hQZ1h7PlHmdWmQxNwRYxxcTxihRXZ3LUDGODZPx
X-Gm-Gg: Acq92OFzDG2P6jGV0DUzK8d6xkdvJYb+qpgRf8wMxjKoNDO/49RnSgeKm40BGuSd/Z1
 4Owu/w2Gz05Vslxaeurz4dDMp/knxgLk5Czl+cuz9OH7JmxIji7tZuEZdzZoayRIV7BwgCkk8pl
 eyqQcYmbhtGwznydp0HGtSFsOYRScEPE+l9qtESsniNmdftZZl17UbCfL3GtbiOOigYAtwiH/yC
 Z1azjskwVG9cF3IKKYFqxKvhGI9LsUGRoBOOrwRmcTj2kMBIp3Ej2jKuqAwHFSfT6C8ajWzGfVW
 WAMnEZna17eTFdHxs4M4zyGRc591a2SGucPjb026a3cupJyu89WMCg6uAv3LBeyfEpEffbLGUpK
 dHZH0
X-Received: by 2002:a7b:c055:0:b0:48a:5aa3:ac1e with SMTP id
 5b1f17b1804b1-490e250419dmr39465e9.3.1781105018413; Wed, 10 Jun 2026 08:23:38
 -0700 (PDT)
MIME-Version: 1.0
References: <20260610142329.3836808-1-sumit.semwal@linaro.org>
In-Reply-To: <20260610142329.3836808-1-sumit.semwal@linaro.org>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Wed, 10 Jun 2026 08:23:24 -0700
X-Gm-Features: AVVi8CeKPjOw-ulqerfXTIRQXgt0wS2BLRdaHk4b32zpbgZavKZyW6IeEygncls
Message-ID: <CABdmKX0K22aaPTrk7Xs_8859ePYQsPNuqcG3v4oMZHK3T0xqKQ@mail.gmail.com>
Subject: Re: [PATCH] dma-buf: move system_cc_shared heap under separate Kconfig
To: Sumit Semwal <sumit.semwal@linaro.org>
Cc: christian.koenig@amd.com, jgg@ziepe.ca, jiri@resnulli.us, 
 hch@infradead.org, maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
 chleroy@kernel.org, linuxppc-dev@lists.ozlabs.org, lkp@intel.com, 
 agordeev@linux.ibm.com, gerald.schaefer@linux.ibm.com, 
 linux-s390@vger.kernel.org, djbw@kernel.org, thomas.lendacky@amd.com, 
 x86@kernel.org, arnd@linaro.org, benjamin.gaignard@collabora.com, 
 Brian.Starkey@arm.com, jstultz@google.com, mripard@kernel.org, afd@ti.com, 
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org, 
 Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, Jun 10, 2026 at 7:23=E2=80=AFAM Sumit Semwal <sumit.semwal@linaro.o=
rg> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> While system heap and system_cc_shared heap share a lot of code
> and hence the same source file, their users have different needs.
>
> system heap users need it to be a loadable module, while
> system_cc_shared heap users don't.
>
> Building as a loadable module breaks system_cc_shared heap on
> powerpc and s390 due to un-exported set_memory_encrypted /
> set_memory_decrypted functions.
>
> Fix these by reorganising code to put the system_cc_shared heap
> under a new Kconfig symbol, which allows either building both
> into the kernel, or leave encryption up to the consumers of the
> system heap.
>
> Fixes: fd55edff8a0a ("dma-buf: heaps: system: Turn the heap into a module=
")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Sumit Semwal <sumit.semwal@linaro.org>

Reviewed-by: T.J. Mercier <tjmercier@google.com>
