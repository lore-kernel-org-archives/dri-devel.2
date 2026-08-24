Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D5D3C5DF94
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 12:42:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B1E110E557;
	Mon, 24 Aug 2026 12:42:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="T4dE81bG";
	dkim-atps=neutral
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com
 [209.85.218.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFE9A10E557
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 12:42:47 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id
 a640c23a62f3a-c214321dc32so669444666b.0
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 05:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787575366; x=1788180166; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=MzHfY6cefdCdPGqFyAr7rWtx24z4JIT/TgxLZWE2Czc=;
 b=T4dE81bGKM3voX6tNT6pj0fMmxzgCcNOCjH9UTEOmpqrtmgojC1drVrA4eF3sTxhqz
 BfI4qZrL2TDqwIQCXYoCTmZiLEDiW1I1lawSVan/k5rPHkW1rnSb78zzkOFui+66ThS5
 ZsR1HewdehrpPNx0UqpGGiYspwlsL2VH5+g/W6uIbUSJnpuM5D9G4VB0y3+HlTbKOL8d
 3UknK/uKHJnnH3Sh5JmLwjwC0eMK5mo2rtgTS/OLBnOc23YMPucEH19EPvViKu84x6Ac
 FAl4cUMtOxhAIntO2hvoPmoROXSftmcDZvYbyTsnwjKsW+PCmeBk9VrA9mJ5p4kux3NG
 KwjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787575366; x=1788180166;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MzHfY6cefdCdPGqFyAr7rWtx24z4JIT/TgxLZWE2Czc=;
 b=So4637ltoHMKtngziaof4rbvGZWVST+2VYCsgmjJTvb0kjv51u6UqMPk9NHsUQrP7d
 wLFlvZVY2O0bzZdeXGZKIXWfeJ0aLUGct6P9na7JC77N3tSym4hNDIsMrrCpWxpw4Gvv
 phEEcYwaA0+sl3SPXJxtGXw8TiNXxInpSb05TxrAwEdzLYtrPcM6GKbLOgSv6TAovqQA
 seWKByZ+dJuuym/90SdhWNRAUmWWa+J8x0Rp5R1XdGiqhymWcdP0mgut6NNwYLCXMoRe
 5DCvERo30tkLZzmbm8e6BwyxmdYYb3aq7Qvdjk80PtGYsbrAnnYysr2OyXpgh2u83X/H
 QYyw==
X-Gm-Message-State: AFuF++namRKGW9yo9dMb+8b6/FmVhjpRXpYQ5AdNSBp2hjMWnXKL+NXk
 y8mI30QNPpKQ5mGdNtSvDYTOBcYH9xYLj8N+zKbjK5kY7B1YDA/QTxIn
X-Gm-Gg: AR+sD12WiyTPU22wCVJa7THk2VDX7V6AuGqHhzHgtlBeex+R0s2qo3zmxubF5NS86JZ
 5Ocl08NlqmQCpd6GmCsJp+SQMP2zqiAr4OnGuoWrqJR27vZbRM4+QIuHQZVz0WcOLAFpFr9zimk
 EFfnfFGwinb/1iq9v+ttH6eduLDVMmaGXI1N70xnJjnZ1X7FE9vlknmXvbwoigBib3ddv35SAsz
 6qu8kwyK0yjYyN4Fp5ifoYz0SB+1cClCR5UbT7nJcjxNUH6VFaOUSS3l04EUVQJp3999VvLNCt4
 NAAxg+4euFUqE4zY9p8xOnmPhnpgaVeeR9eDqdll8UezjQVLoHxomX5uDmEBx4rmreHpnRCmBxL
 aqF+2jngbC4NWCbvuCRla0pYehavTOCGXfouHIoKK0Ffi/dK4+9jCYewMb0kWzuvFm4D+F26F+M
 nBdGo/bl4C8+7wcQ1CFm3Mq1EE6ouzfnxBJyH3htVLggwnc2dGmmpewOp97LtoPdrspQVBgZbho
 MEnvntXiDYtFs3TChOG
X-Received: by 2002:a17:906:f246:b0:c21:61a6:8821 with SMTP id
 a640c23a62f3a-c246a6cd384mr2373422566b.23.1787575365769; 
 Mon, 24 Aug 2026 05:42:45 -0700 (PDT)
Received: from [192.168.178.84] ([134.19.53.142])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c249689fa97sm1090754566b.57.2026.08.24.05.42.44
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 24 Aug 2026 05:42:44 -0700 (PDT)
Message-ID: <b7e18a9b-2c1b-43b1-b62d-afca4659b4dd@gmail.com>
Date: Mon, 24 Aug 2026 14:42:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/4] dma-buf: fix fd leak when copy_to_user() fails
 after fd_install()
To: Baineng Shou <shoubaineng@gmail.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 "T . J . Mercier" <tjmercier@google.com>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>,
 Sandeep Patil <sspatil@android.com>, "Andrew F . Davis" <afd@ti.com>,
 Srinivas Kandagatla <srini@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org
References: <CABdmKX1-0bXdU_pWKrY3LR4JmOpxC48ka9akS8PHYDBnngFqWQ@mail.gmail.com>
 <20260817050457.1005285-1-shoubaineng@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20260817050457.1005285-1-shoubaineng@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

I've gone ahead, added one more rb and pushed the result to drm-misc-fixes.

Thanks for the help,
Christian.

On 8/17/26 07:04, Baineng Shou wrote:
> Several drivers call dma_buf_fd() — which internally calls fd_install()
> — before copy_to_user() returns the fd number to userspace.  If
> copy_to_user() fails, the fd is already published in the caller's fd
> table but the ioctl returns an error, so userspace never learns the fd
> number.  Worse, the window between fd_install() and copy_to_user()
> allows other threads to observe and manipulate the fd (dup, close,
> SCM_RIGHTS), making any "close it on the failure path" fix unsafe.
> 
> The fix is to split the allocation into three steps: reserve an fd with
> get_unused_fd_flags() (not yet visible to other threads), do
> copy_to_user(), and only then publish the fd with fd_install() via the
> new dma_buf_fd_install() helper.  On copy_to_user() failure,
> put_unused_fd() + dma_buf_put() cleanly unwind with no user-visible
> side effects.
> 
> Patch 1 introduces dma_buf_fd_install() in dma-buf.c (wrapping
> fd_install() together with the DMA_BUF_TRACE call to preserve export
> tracing) and applies the fix to dma-heap.
> 
> Patch 2 applies the same fix to fastrpc, which even had a comment
> acknowledging the problem could not be fixed before.
> 
> Patch 3 replaces the bare fd_install() in drm_gem_prime_handle_to_fd()
> with dma_buf_fd_install() to restore tracepoint coverage for DRM PRIME
> exports (suggested by Christian König).
> 
> Patch 4 adds a selftest to tools/testing/selftests/dmabuf-heaps/ that
> reproduces the fd-leak scenario (mprotect flip before the ioctl) and
> verifies the fd count is unchanged after a failed ioctl (suggested by
> Sumit Semwal).
> 
> v1: https://lore.kernel.org/dri-devel/20260703080922.1838362-1-shoubaineng@gmail.com/
> v2: https://lore.kernel.org/dri-devel/20260710105740.3080070-1-shoubaineng@gmail.com/
> v3: https://lore.kernel.org/dri-devel/20260714114654.3885457-1-shoubaineng@gmail.com/
> v5: https://lore.kernel.org/dri-devel/20260730062645.233148-1-shoubaineng@gmail.com/
> v6: https://lore.kernel.org/dri-devel/20260807101140.1357218-1-shoubaineng@gmail.com/
> 
> Changes in v7:
>  - Add Reviewed-by: T.J. Mercier to patch 4 (selftest).
>  - Add Acked-by: Sumit Semwal to the whole series.
> 
> Changes in v6:
>  - Rework the selftest (patch 4) per review: extract a count_open_fds()
>    helper, fix the copy_from_user() comment, fail (not skip) when the
>    ioctl does not return -1, drop the bogus mprotect-race mention, and
>    reword the result message.
> 
> Changes in v5:
>  - Add selftest (patch 4) reproducing the fd-leak scenario (Sumit Semwal)
> 
> Changes in v4:
>  - Add patch 3: drm/prime: use dma_buf_fd_install() (Christian König)
>  - Add Acked-by: Christian König to patches 1 and 2
> 
> Changes in v3:
>  - Split into two patches (dma-heap + fastrpc separately)
>  - Add dma_buf_fd_install() to preserve trace_dma_buf_fd tracepoint
>  - Add fastrpc fix using the new helper (T.J. Mercier)
> 
> Baineng Shou (4):
>   dma-buf: dma-heap: don't publish fd before copy_to_user() succeeds
>   misc: fastrpc: don't publish fd before copy_to_user() succeeds
>   drm/prime: use dma_buf_fd_install() to preserve export tracing
>   selftests: dmabuf-heaps: add fd-leak-on-EFAULT regression test
> 
>  drivers/dma-buf/dma-buf.c                     |  20 ++++
>  drivers/dma-buf/dma-heap.c                    |  80 ++++++-------
>  drivers/gpu/drm/drm_prime.c                   |   2 +-
>  drivers/misc/fastrpc.c                        |  16 +--
>  include/linux/dma-buf.h                       |   1 +
>  .../selftests/dmabuf-heaps/dmabuf-heap.c      | 113 +++++++++++++++++-
>  6 files changed, 180 insertions(+), 52 deletions(-)
> 

