Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF6D606A328
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 08:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0ih307SX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC87410E2D2;
	Thu,  5 Nov 2026 08:41:52 +0000 (UTC)
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com
 [209.85.219.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4B861121E6
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 08:41:46 +0000 (UTC)
Received: by mail-qv1-f49.google.com with SMTP id
 6a1803df08f44-91c7b00a75fso16911056d6.2
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 00:41:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793868106; cv=none;
 d=google.com; s=arc-20260327;
 b=gvis4g4KunJAx4dB3cgmlEJ62DWg/VXgk+flxb1h7+yblBWeS6waDMc4dFUWvuz7Ja
 qrre3ZNWTb/NbqMENb+C2MUXl3I9+3TZpE8kncYaOxBm0CFa5195ZUKpJrjsgQAqPsGZ
 yceCXEKI/zWhBmktZBrHOF9Z51MzD03iRQfOp+a7bmDJviaz4HoDKU7jeDvDARA9TCDG
 7qBtgVvzxoGtn5LLbO6lTS1MnoPbgHZWcj9JK7LaaAUqjzWS/Qha+lYqnOgFPy/xi6Ja
 IL4su9GPJrQ8RpMDM8NJQfzU1qVriqxbjOY84Ew8i8r0yzSalpoV/tp7s+6+zP5vYBfF
 xBig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=+LZ7gEkfFBWbsyE8LX9YD8wYeXwI3Z2u8xYCO3dSD/0=;
 fh=w3+A9peOxgit18E54dCoE5D4kJN3asU55ZvbFLtfxFY=;
 b=iBSeb9rLOLoNFkNuGp4W0FKrtFDcPou6NS5Y0fIEWD29rhLP9o6igT8WJ01IVJ8V/l
 g7jSaoIkDXdoHKtL9gukM4G/LobWHanXG+8FKQBBrQYUSG8o4GU5LDMgC1TUZ6dWjDAO
 a2STvLZPyrWeHW7B2vbDjJ7BzWheXVnhYctZRnkIU4YIdWunTAKtbjgjF40H7b88P1a0
 nRYhGo+Wq5bLhnrGEi+h3NRiRjuT7LNonTr0N29Ld1F801HrG+ZDd5lg4TOMWIkkc98v
 Fgzj+N/ARv+bFpUBo4kdP4q7mWhDdH491qRb3rETN4h2+eI4mGtF6M4mz4nFHUPymuZQ
 SOaw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793868106; x=1794472906; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=+LZ7gEkfFBWbsyE8LX9YD8wYeXwI3Z2u8xYCO3dSD/0=;
 b=0ih307SX746IjhIgG7MS7M9B20TtFWgVb+TagZgUrU8yf5cDlTzlqtGrtp5+2T9iyY
 nGbPEVGltlMFfZMgwdS75PMtQEHN9IbfHIKaFPd06IuNuDgdHl3fjLg5qdUWRY38J7qa
 y79brkDTQhMCgc+ZjyFdmtgcRipMP4nI6ghrYcTFKP66YqqESyg87EYLpc5i+0uX+vlm
 snqdBBflbYzkU+ju/TerVrfxonOJDmeXYkWPclPewXYiM0zOBHSvMEgTQe1lrqq++toh
 zZzQmPdu8aHLPIjkUYdb2PoyyLUYft1HyJ8QGYYplvDqVvuE6vn0zipVFEYbabqzjOFx
 Ms7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793868106; x=1794472906;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=+LZ7gEkfFBWbsyE8LX9YD8wYeXwI3Z2u8xYCO3dSD/0=;
 b=E7QQQuZZJLawXT4brapYuMKCP1k5iOO3BipLGvO/hd4LsqfBRVaal1XCVNnGjTwvSE
 NFU0BkFlPMEfkd2pMN1/f5lWkIqFIERaM4YNINDrt16xl0fwmGnCJOcoie6BesQznm89
 e5VeIzgR8DHSQmwssLvb+sd9wQaukvxw3lbx5J3qyzNSYDOgqarlI9euomQnTtxZGK7o
 zJIrWZN7vATTlW+z9u0mYy7Fs8+jQqCpf6AUCbT9zIqI0QFD7LyP7k3rhTSyGOt0Fz9K
 iS6ezyvK/8vnIoWhBX3URSGrA+CBtUQ06YQyYQ8iIySfFfgOYrHZRwTwWOVmgilM27x0
 Uo/g==
X-Forwarded-Encrypted: i=1;
 AKwUvBz4pVBmoNDB0td/aMcPojd+KMbMPNxK2drPHk0ORNvRBjRYVD0dl728EWmqlCsp4S3kZLh3VZJlrOc=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8jhOVe79TDRrs+Pxniw4lNfSpRwbR2hIsM9Mff7sUzGa9Dlqk0
 sprdtuOGHiM+odNIFM2XbC9X9JplKUqlP8AADaPVLaIZK/md3MGRuDMQVMnlRDl9REU2a2/+NGv
 r+Mi28wTI7LTsCPgno47unuqVZvk73/E=
X-Gm-Gg: AYBFou0576j4DnOjZgYXSHV1ktceaoA+n4toXKqRMwFJDkHtTZ5oUWkznKCEa5yaVq8
 6ISHNEbUZYlY4p8DTfkM+h1DtAQddVSl5OSwNeBa4nBhYSGYbhYnd7msRgRamra0vgbpnEQN+r9
 AS5PNJW1z9L0StMkEDnRGKfr4W3EyflDIjpBHeW0NrgqjPAcjjdJQp1C96C5YhCgVl7/SdgP+do
 1jLRbup6NIMhRQSCHW0mDeBO82oQ8qTMmf0sV7w6zlE3p8oSQDHyHGj28zdspb8zh22hboWuBQp
 ZW2n6ty+E4vLM/Nzl0GE/6BlbgG5eMMFJo7bxEy0yHltth7ZGdtQ+sySUQAmFe6gk20iLwlFJkW
 gJ27mXelkifVLcXh4iSWtFNsa3Up5A6gO3oshdUNP0fp1Wti/Kg60+waozf8G6+lUtoRtE7UcPf
 0kmvKWxcRE740XR/vUQDFxoA==
X-Received: by 2002:a05:6214:5d0a:b0:91e:8cb1:b856 with SMTP id
 6a1803df08f44-91e8cb1bcb3mr50976416d6.41.1793868105578; Thu, 05 Nov 2026
 00:41:45 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261101200428.16959-1-rosenp@gmail.com>
In-Reply-To: <20261101200428.16959-1-rosenp@gmail.com>
From: Dave Airlie <airlied@gmail.com>
Date: Thu, 5 Nov 2026 18:41:33 +1000
X-Gm-Features: AclHuK9RB4mLTs1goTvN9X54_7uH3Et6Jl_r8Cy2cfziD_nx9SDo27jgCkGyM08
Message-ID: <CAPM=9tzacWJenKpU_-zbCOSupybgJjXFV7SZLvT+DNBs5fZNEQ@mail.gmail.com>
Subject: Re: [PATCH] drm/nouveau/nvkm: clear use.enabled when subdev init fails
To: Rosen Penev <rosenp@gmail.com>
Cc: nouveau@lists.freedesktop.org, Lyude Paul <lyude@redhat.com>, 
 Danilo Krummrich <dakr@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Simona Vetter <simona@ffwll.ch>, Ben Skeggs <bskeggs@redhat.com>, 
 "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS"
 <dri-devel@lists.freedesktop.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 2 Nov 2026 at 06:04, Rosen Penev <rosenp@gmail.com> wrote:
>
> On Kepler boards without the video decode falcon firmware installed
> (msvld/mspdec/msppp), every other VA-API decode attempt binds to an
> engine with no ucode loaded. The submitted work never completes, which
> leads to a context switch timeout, a channel recovery that cannot reset
> the engine, and eviction waits on fences that never signal. The process
> ends up stuck in D state, or killed by SIGBUS when it touches a buffer
> evicted after the wait times out:
>
>   msvld: unable to load firmware data
>   msvld: init failed, -19
>   fifo: SCHED_ERROR 0a [CTXSW_TIMEOUT]
>   vo[5444]: channel 14 killed!
>   WARNING: drivers/gpu/drm/nouveau/nvkm/engine/fifo/runl.c:117 at nvkm_runl_rc+0x2a4/0x3b0 [nouveau]
>   [TTM] Buffer eviction failed
>   WARNING: drivers/gpu/drm/nouveau/nouveau_bo.c:1092 at nouveau_bo_move_ntfy.part.0+0x9b/0x100 [nouveau]
>
> Tracing nvkm_subdev_ref() and nvkm_subdev_init_() shows the pattern:
> a reference taken with enabled=0 runs nvkm_falcon_init(), which
> returns -ENODEV; the next reference sees enabled=1 and succeeds
> without running it.
>
> Clear use.enabled when init() fails, so that every later reference
> retries init and fails cleanly.  The other readers of use.enabled are
> fini() handlers that use it to skip teardown, which they now also do
> after a failed init().
>
> On a GK107 (Quadro K1100M) without video firmware, playing H.264 with
> mpv --hwdec=auto: without this patch the GPU channel is killed within a
> minute and mpv hangs; with it, VA-API decoder creation fails, mpv falls
> back to software decoding, and no faults are logged.

Appled to drm-misc-fixes.

Thanks,
Dave.
