Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B880C88E66
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 13:21:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F6E310E8FD;
	Sun, 13 Sep 2026 13:21:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MSLp9JNI";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B722310E8FD
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 13:21:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5D4CA4093D;
 Sun, 13 Sep 2026 13:21:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 165FE1F000FF;
 Sun, 13 Sep 2026 13:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789305672;
 bh=FzNDJMQfkv09mpj1lo2dWM4ad5TFDDkA6tTNXNiiamI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MSLp9JNIaeaMjSpcBKCKcdMFa3FQBDNJdKzCG15kgiKZUyD7NuonLTW1wHyYFHiqd
 xfLLbTNIu6ozKc9GNrPv4/us6oyj3D5M7lXNrZSW1M1J0pwT8LNlZLXPBYDFyqdf0j
 BmdtXF/v7Xqf5xkmFDvTNQxyd/Rba1LjBzLafsU1jK7qB9lg7gNytIEeuGlIZwMYlN
 4ptKVtkYg3Tg/CUbgkTUKSr2gr0agT7+YxYSXuRmDhMZH6fnNIZ/Li/8gsl3SrJnkC
 wIg74tJP+pLhvkCRcJ3vr/4D5Cloyw1Vemk4oHN3X/VpcZCH21WJDqa4TcSsQn+uBm
 WjUyVIo16nf0w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] gpu: ipu-v3: prg: fix clock cleanup on remove
To: "Guangshuo Li" <lgs201920130244@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260913131117.1561280-1-lgs201920130244@gmail.com>
References: <20260913131117.1561280-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 13:21:11 +0000
Message-Id: <20260913132112.165FE1F000FF@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but a sleeping funct=
ion `readl_poll_timeout` is used in a display driver function designed to b=
e called from the atomic commit path.
- [High] This problem wasn't introduced by this patch, but the return value=
 of `pm_runtime_get_sync()` is ignored, leading to unclocked hardware regis=
ter access on failure.
--

commit e147aed08964b1f246d1a5b035f162b665564efa
Author: Guangshuo Li <lgs201920130244@gmail.com>

gpu: ipu-v3: prg: fix clock cleanup on remove

ipu_prg_probe() enables the IPG and AXI clocks before enabling runtime
PM. The clocks are subsequently controlled by the runtime suspend and
resume callbacks.

> diff --git a/drivers/gpu/ipu-v3/ipu-prg.c b/drivers/gpu/ipu-v3/ipu-prg.c
> index d38d3ba54d722..93033e847d0e5 100644
> --- a/drivers/gpu/ipu-v3/ipu-prg.c
> +++ b/drivers/gpu/ipu-v3/ipu-prg.c

[ ... ]

While reviewing this file, I noticed a few pre-existing issues regarding
runtime PM and atomic context that might be worth addressing.

drivers/gpu/ipu-v3/ipu-prg.c:ipu_prg_channel_disable() {
    ...
	pm_runtime_get_sync(prg->dev);

	val =3D readl(prg->regs + IPU_PRG_CTL);
	val |=3D IPU_PRG_CTL_BYPASS(prg_chan);
	writel(val, prg->regs + IPU_PRG_CTL);
    ...
}

[Severity: High]
This isn't a bug introduced by this patch, but the return value of
pm_runtime_get_sync() is ignored, leading to potential unclocked hardware
register access on failure.

If clk_prepare_enable() fails during resume, the clocks remain disabled.

Is it possible for the hardware to trigger a Synchronous External Abort (AXI
bus error) and a kernel panic when readl() and writel() unconditionally acc=
ess
the unclocked registers immediately after?

The same pattern also exists in ipu_prg_channel_configure():

drivers/gpu/ipu-v3/ipu-prg.c:ipu_prg_channel_configure() {
    ...
	pm_runtime_get_sync(prg->dev);

	val =3D (stride - 1) & IPU_PRG_STRIDE_STRIDE_MASK;
	writel(val, prg->regs + IPU_PRG_STRIDE(prg_chan));
    ...
}

[Severity: High]
This isn't a bug introduced by this patch, but the return value of
pm_runtime_get_sync() is also ignored here.

Should we check the return value and handle the error to prevent unclocked
access?

drivers/gpu/ipu-v3/ipu-prg.c:ipu_prg_channel_configure() {
    ...
	/* wait for both double buffers to be filled */
	readl_poll_timeout(prg->regs + IPU_PRG_STATUS, val,
			   (val & IPU_PRG_STATUS_BUFFER0_READY(prg_chan)) &&
			   (val & IPU_PRG_STATUS_BUFFER1_READY(prg_chan)),
			   5, 1000);
    ...
}

[Severity: High]
This isn't a bug introduced by this patch, but a sleeping function
readl_poll_timeout() is used in a display driver function designed to be
called from the atomic commit path.

ipu_prg_channel_configure() is called from ipu_plane_atomic_update(), which=
 is
a plane atomic update callback.

Since readl_poll_timeout() internally calls usleep_range() and will sleep,
could this trigger might_sleep() warnings or deadlocks in the atomic commit
path?=20

Should readl_poll_timeout_atomic() be used here instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913131117.1561=
280-1-lgs201920130244@gmail.com?part=3D1
