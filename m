Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA866CA5FFD
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 03:56:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06BB010E718;
	Thu,  8 Oct 2026 03:56:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EtVbMEQ9";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40E5610E718
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 03:56:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0BBA140990;
 Thu,  8 Oct 2026 03:56:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B96AD1F000FF;
 Thu,  8 Oct 2026 03:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791431795;
 bh=XCdDq9vjbWKx/oBkNIipksgr3LdPCjUuTALj3FtHXns=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=EtVbMEQ9bnpn0j4Z0KPAP6FzmbUDGRmZL6u7mV6dbRFLeqDWm+f5lfUiStGtGTxHe
 /YG8rbxU6KXHEkLkuQsfwx5sAF4OEy3CayeFQ4vbqETrnguRHElP5oQyE40l0lq4Wk
 khxzlI2YF7PRFapoXfPqcpBclzoca2FyWTwTmKnOmAEWhRFWov4FTQMm8kgmf+uqlW
 5YhK/Kbm2WtuoCvUxQ1f5or7zCk9UoI1U1mkrh1d8Xh0YNvtlnn2S8iovFXGIXkhkR
 MKol5i+3k7XR7Xow+iYRsK/ahtCoWECSTl1hQI4pcXQqaFtxg2wt6JHQCiLL/D7UQ/
 yV0YZJ1rPrqJw==
Message-ID: <sashiko-outbox-163595@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V3 14/19] accel/amdxdna: Move HMM invalidate wait into
 common GEM code
To: "David Zhang" <yidong.zhang@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261008032348.2044667-15-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20261008032348.2044667-1-yidong.zhang@amd.com>
 <20261008032348.2044667-15-yidong.zhang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 03:56:35 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] amdxdna: hardware DMA into freed memory due to interruptible wait =
in hmm_invalidate
--

commit c5bcbac3bd594f37cab09ce7ecaa29fea4a1e25a
Author: David Zhang <yidong.zhang@amd.com>

accel/amdxdna: Move HMM invalidate wait into common GEM code

This commit moves the HMM invalidate wait for user mappings into the common
GEM code within amdxdna_hmm_invalidate(). Devices that don't attach fences
to user BOs will return from the wait immediately.

> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/=
amdxdna_gem.c
> index f4832337ec31d..eebd93b6f2c31 100644
> --- a/drivers/accel/amdxdna/amdxdna_gem.c
> +++ b/drivers/accel/amdxdna/amdxdna_gem.c

[ ... ]

> @@ -249,8 +251,12 @@ static bool amdxdna_hmm_invalidate(struct mmu_interv=
al_notifier *mni,
>  	mmu_interval_set_seq(&mapp->notifier, cur_seq);
>  	up_write(&xdna->notifier_lock);
> =20
> -	if (xdna->dev_info->ops->hmm_invalidate)
> -		xdna->dev_info->ops->hmm_invalidate(abo, cur_seq);
> +	ret =3D dma_resv_wait_timeout(to_gobj(abo)->resv, DMA_RESV_USAGE_BOOKKE=
EP,
> +				    true, MAX_SCHEDULE_TIMEOUT);
> +	if (!ret)
> +		XDNA_ERR(xdna, "Failed to wait for bo, ret %ld", ret);
> +	else if (ret =3D=3D -ERESTARTSYS)
> +		XDNA_DBG(xdna, "Wait for bo interrupted by signal");
> =20
>  	if (range->event =3D=3D MMU_NOTIFY_UNMAP) {
>  		down_write(&xdna->notifier_lock);

[Severity: High]
Does this interruptible wait allow hardware to DMA into freed memory?

amdxdna_hmm_invalidate() is called by the OS memory subsystem when unmapping
or reclaiming memory. The driver is expected to wait for the hardware to
finish accessing the pages before returning true.

However, dma_resv_wait_timeout() is called with intr=3Dtrue, which makes the
wait interruptible by signals. If the process receives a signal, the wait
aborts early and returns -ERESTARTSYS. The callback logs a debug message
but then proceeds to return true, which tells the OS that the device is no
longer accessing the memory.

Since the hardware job is still executing when the OS frees the physical
pages, can this lead to memory corruption when the hardware DMAs into those
pages?

Should this wait use intr=3Dfalse to be uninterruptible in this context?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008032348.2044=
667-1-yidong.zhang@amd.com?part=3D14
