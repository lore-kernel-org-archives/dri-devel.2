Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1F3FCA601E
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 19:13:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EDFA10EB23;
	Fri,  9 Oct 2026 19:13:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mXURl5jE";
	dkim-atps=neutral
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com
 [209.85.128.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1D0010EB23
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 19:13:24 +0000 (UTC)
Received: by mail-yw1-f180.google.com with SMTP id
 00721157ae682-8acda240937so41467877b3.3
 for <dri-devel@lists.freedesktop.org>; Fri, 09 Oct 2026 12:13:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791573203; cv=none;
 d=google.com; s=arc-20260327;
 b=Q9JF6inPrpFAkk5ECixjXk98rvpVPv/bTiP81h1Y/XO3Jae0gU5e4H6Cq9brYL4SWJ
 emi1v0wnKv81xYbQgLan/MDYJwxKBPbDkS4PJ+IScLszB5htolZjz64HOxd3vtt7NEM0
 CLYZyWkfLJYNEtWWjLWOICVZerHazkbqAOXNXV5VetjLi2ZYcV5PuOJyKYrdQTXfcZv/
 iGwvhnwO59muc8j/UTWCsIFLc6k72Wg35Sjbx6gTaS/Wy3io6gtuLGexltkS+ny55Gp9
 yR/pjF/C/4Nfzpxc3osjY6/+BJQ5cexTU8+NTYL/rfMuu4O91zTIoL3OsmJrjXaNbQ6J
 7Zrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=+m5RVY/Fd1R44a1Q2Ut7yuguyjSg/NovE0vzMnvGQ8Y=;
 fh=5xTYYYG61svQVHhUs/manmCfRH0zuLGYL+f4sVmIV8c=;
 b=STsJTUsGYT3NrV8anklqR4wmB1VYHp2P2QPAsVXtXuT+7Rt27YVKThcTqwoOiIH3S7
 /tKLs4Bdwi3DD/ZyQboTD2GvULhJ0Q/niLtilOxsJF1TbeTFgjr/jPSkHDkpaKd6FX5I
 CUU/6rbTN7PzeL0Wkdfb+g56yn3ws4ocNkJianGyMEiCKWlmqnKFrvzuBWn+2J1XeNe0
 l/oibO3tNbKDXs2pSnwc/3L3Ed1E/+z2P1WZ9qX4Eg1SvrCl2OCjINyKbacyN4frJQF3
 VnEKu/SJhWA5HtjELTVFMqmQSxVWVcqd/YPiiQHza61sXGrjgszUTgulowxjfi/c7pTM
 P6xw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791573203; x=1792178003; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=+m5RVY/Fd1R44a1Q2Ut7yuguyjSg/NovE0vzMnvGQ8Y=;
 b=mXURl5jEqfjyxDco0nGdGY//6sEiHlm3Z2DY5GdBG6aPL9AoMFkZhfk/e0CQeO2IFM
 AxzoYb7HZvFFaLJW6HSAZ7F0+v9kzoGNYOtXWVP8Hc+dxCejfsrZt8Z0p0eNS/MgNkmB
 deqQDmYNjsr1baIgo+Ooh8c5FAAUeRvkrp7GeYBcM3709qL9KqrzCQeIH/ns7e3Za0nl
 /Qv4j9E6L8Tdn89uumtqRiC0NcMzsQlRpULL6RqwqxRyEHYYftF2uxV3nFJPqFhOlkfO
 qr1li9k0dovVpMe3an3c5J9zmhpFuDLb53MtvDQEIaknmSfUvmPiM4XVSE/V9c14iBUx
 dOgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791573203; x=1792178003;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=+m5RVY/Fd1R44a1Q2Ut7yuguyjSg/NovE0vzMnvGQ8Y=;
 b=xFvGrFyCDz6CKGFY/d0oplhHee5gEUTzr2sSiQTU0ifO6Cf4Vn9ynCjZNRkmgBE7Ju
 Bbce9UMqK47AUOz4Ixh6Br/ag9QCa4fdf8wP1c3FJgB74kMwiJQE2gZGwZJXTAFD1hTP
 Ke7ijJGIwM5Ebj856Kkt0RrF4NCzf31JkvxoXmNGQ8QkMH1qPhAsgG/RudziM7lziPhW
 hUteJZBYpcb2+6rHgy9jMC3ZN6UimNs7mLdGXUVfVe+PXq1m2NeILW/MJVVVcTZuQFco
 S0nQbGqbfFzov4qTXwzhseMK22niGvKKskB5sv58IL5mzap27+NBiR+4dlvIopQ/sZbf
 XXVQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxOJF/Eo9wTp4vRLx4VySVAKo2qxeJnMVVtnjRZkFycjVinAwc3wu//5b+YzKyffNWlnaw1YrmtjNA=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJHnGsSvV1MHp/3XBAmYKSS1IlwnCc26RrGipqLXejRaA7hbs/k
 8ziORi4aHKU+TUrgRg9hflFBCHJ0N79mxwqfSsLIqBgHan/wPQXISsDcQk3Wz93pWPjBoYs0DGa
 8mW1RyFZVV6xbuLh6bT0GtdY2vL51+VU=
X-Gm-Gg: AYBFou1G/RGkkIlIJ0XPBlyH0QJspa3gVQrYeHo1u8r0qTyrWD1k1kjEg6hTZ6SgH6L
 UN1fnun3gz9G0xonp6jm45DrzsbE89MtmHU8L5L0pBrVs5CukbUfu7/+H83y6jjyjftWeErR/q3
 YVC93djkWltKkFTi09dmBLYY7eYSXFMMNveaeSXqI6Dvc/xoCFhw2eBsHxsV6dGRUgBL4iKe83x
 3GczYXs2/jT6OKm4GEKNhALTG+uURzbx7nKgnfejivjqaJ9ZCBbkv/8Ax8bI8iNEUzLFDHrhN1x
 yo14gzHkWCDQUljwlaT5pN2L1HvON2AAeyxlRi8rJjUK7f9yaXHZhCnr8Xd0AlbGPKjIDlOmobR
 +aYLULQEChddGqTc1kDBaWExXs8Mts/3Uho4TCavFKpEkG+cEWrqw6QFl96ga2tnkvENQZPZTDQ
 ==
X-Received: by 2002:a05:690c:1d:b0:8b0:8a9c:fac1 with SMTP id
 00721157ae682-8b08a9d034bmr1353337b3.21.1791573203443; Fri, 09 Oct 2026
 12:13:23 -0700 (PDT)
MIME-Version: 1.0
References: <20261009032616.432392-1-0xiviel@gmail.com>
 <74b15e57-1387-e37c-d343-eeba1de33ceb@amd.com>
In-Reply-To: <74b15e57-1387-e37c-d343-eeba1de33ceb@amd.com>
From: Eva Crystal <0xiviel@gmail.com>
Date: Sat, 10 Oct 2026 08:13:11 +1300
X-Gm-Features: AclHuK_cy9U-CWUp8mwYJvruBGY0UqEQuD2c3_YFDBhDH3-C0Ix51_bl-Ikk4B8
Message-ID: <CA+pz=kL0a0BpNf_ozK=MUntN8EjtAzb1Z_5MS4TLEV+sTLEtWA@mail.gmail.com>
Subject: Re: [PATCH 6.18.y] accel/amdxdna: Bound the sync_bo flush range to
 the BO size
To: Lizhi Hou <lizhi.hou@amd.com>
Cc: stable@vger.kernel.org, Min Ma <mamin506@gmail.com>, 
 Oded Gabbay <ogabbay@kernel.org>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On 10/10/26, Lizhi Hou wrote:
> It needs to check if size is zero.

Thanks for the ack.

The zero-length guard from dc1475366424 is already on 6.18.y as
45962da5821d, shipped in 6.18.52, moved into
amdxdna_drm_sync_bo_ioctl() because amdxdna_flush_bo() does not exist
on this branch.

My check at drivers/accel/amdxdna/amdxdna_gem.c:947 runs before it,
and the clamped size cannot reach the drm_clflush_virt_range() at
drivers/accel/amdxdna/amdxdna_gem.c:966 as 0: with args->offset below
abo->mem.size, min(abo->mem.size, end) exceeds args->offset whenever
args->size is above 0, and an args->size of 0 already returns 0 at the
guard.

That is by code reading. The arms I measured on this branch all used
size 0x40, so I have no zero-size run.

A zero-length sync at an offset past the end returns -EINVAL from my
check, where upstream reports no error for AMDXDNA_BO_DEV, as my
commit message notes.

So no second patch is needed. v1 applies as is with your Acked-by, or
I will resend as v2 carrying the tag if stable prefers.

Eva Crystal (0xiviel)
XSource Security
https://xsourcesec.com
