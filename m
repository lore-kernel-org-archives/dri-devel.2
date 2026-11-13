Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9216860A380C
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 08:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RohYJXrR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01CF410E704;
	Fri, 13 Nov 2026 08:40:32 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C814610E704
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 08:40:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E9EE462602;
 Fri, 13 Nov 2026 08:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84A2A1F000C4;
 Fri, 13 Nov 2026 08:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794559224;
 bh=IOY/RbId++uZs7EvLxUNlAYTQutfL70v7D+0+e4U+cY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=RohYJXrRVVF7tO/bA/DeOBcCxcOsynJjG0r87neN9/p0oRuytr0CPtoF3vn+BVrg6
 ssPMyEZShaYEqPuOvPTvOJ2304jCUvoz/hzNIS9H8cHnzQF1BSCdS9PanRJTPqV8YB
 ODtbWyUO1h8PPjX5u2scPNspXY+HSVpu/94ry5kKnpUdjBb5gaFQZ4Z8CQ6sEb+sBz
 KQy8Xmk+tkGJ8WlCJ7a/2hoq4/GWQy+egLBIg1JQRa6kU5EByRteNjwwbTJHEfyv0G
 tBnYO0WAWSQ6rBR4o/SqmRJL8no9QOdbDfADuBJnpvUgUuR2e5rLXJYeuXyz1a7zUx
 lNvFHtcv3/soQ==
Message-ID: <sashiko-outbox-212439@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 06/18] drm/bridge: analogix_dp: Add IRQF_ONESHOT and
 simplify IRQ handling
To: "Damon Ding" <damon.ding@rock-chips.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261113082305.541652-7-damon.ding@rock-chips.com>
References: <20261113082305.541652-1-damon.ding@rock-chips.com>
 <20261113082305.541652-7-damon.ding@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 08:40:23 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] drm/bridge: analogix_dp: missing Fixes trailer for threaded IRQ
  race fix
--

commit 54e0c1601490164c97aa8bfcab7daa854142943a
Author: Damon Ding <damon.ding@rock-chips.com>

> drm/bridge: analogix_dp: Add IRQF_ONESHOT and simplify IRQ handling
>
> The threaded IRQ is requested without IRQF_ONESHOT, allowing hardirq to
> preempt the threaded handler. This creates a read-modify-write race on
> HPD interrupt mask registers between the hardirq mute and thread unmute
> operations.
>
> Add IRQF_ONESHOT to keep the IRQ line masked during thread execution,
> which eliminates the race and makes the per-event mute/unmute calls in
> hardirq and thread handlers redundant. Move interrupt status clearing
> to the beginning of the threaded handler, before
> drm_helper_hpd_irq_event(), to avoid losing events that arrive during
> the event handling.
>
> Tested-by: Heiko Stuebner <heiko@sntech.de>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Damon Ding <damon.ding@rock-chips.com>

[Severity: Low]
This fixes the missing IRQF_ONESHOT flag, the racy HPD interrupt
mute/unmute sequence, and the late status clearing introduced when the
driver switched from a workqueue to a threaded IRQ handler.  Should this
include:

  Fixes: 7b4b7a8db439 ("drm: bridge: analogix/dp: Fix the possible dead loc=
k in bridge disable time")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113082305.5416=
52-1-damon.ding@rock-chips.com?part=3D6
