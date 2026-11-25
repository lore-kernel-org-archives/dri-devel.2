Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F238606A321
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 11:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MF8O2BDw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6DA510E0EF;
	Wed, 25 Nov 2026 11:31:55 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F57610E0EF
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 11:31:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 71816627D7;
 Wed, 25 Nov 2026 11:31:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E454B1F000C4;
 Wed, 25 Nov 2026 11:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795606308;
 bh=OcpetI1cPY6uRSwd23zgdGgTTz506Xp6ndxu9HSEqJY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MF8O2BDwPi7vR15LECcoUa75FLhZUWPV0BMzcF3D3F4bj6OmhJeopO/QXDxJ7fDGe
 67v5LQjywiYF8DomY1BR9FlQWdlRUA0O/BWhFsSsCSgpt9bxIghJjw3xVPVBqflycM
 gYZCQdgR1hsFDs3JB8aZQo/ZEeZ9990gvlwaHZb/mvrE4NL6mbRIy9XdVEbhzs/N0+
 WAAyZAgzcVIKtDcN16FVSSQX9lMI7m2nlsVQxpvXZr+zWRh7PZl45ZE2y1ZsQrqYRb
 SYQ1StWcWBb+bsciTfrRt1thm8NJrRi9iO9x2nKpcWzgt3/6TI6p2GT51Khv7cW4E4
 2Z6KcuTTjDNiw==
Message-ID: <sashiko-outbox-233255@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 08/20] drm/bridge: analogix_dp: Add IRQF_ONESHOT and
 simplify IRQ handling
To: "Damon Ding" <damon.ding@rock-chips.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261125112141.1434903-9-damon.ding@rock-chips.com>
References: <20261125112141.1434903-1-damon.ding@rock-chips.com>
 <20261125112141.1434903-9-damon.ding@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 11:31:47 +0000
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
- [Low] drm/bridge: analogix_dp: missing Fixes trailer for threaded HPD
  IRQ fix
--

commit 3370787a5586a7966ed5ca8d45e47fcb0a1d3a91
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
This fixes the threaded HPD interrupt registration, the mute/unmute race,
and the late interrupt clearing introduced when HPD handling moved to a
threaded IRQ.  Should this include:

  Fixes: 7b4b7a8db439 ("drm: bridge: analogix/dp: Fix the possible dead loc=
k in bridge disable time")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125112141.1434=
903-1-damon.ding@rock-chips.com?part=3D8
