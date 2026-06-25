Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66922CDB466
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 06:17:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92DB810E502;
	Thu, 25 Jun 2026 06:17:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Cye2bB3C";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60A5410E502
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 06:17:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 86873600FC;
 Thu, 25 Jun 2026 06:17:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2957C1F000E9;
 Thu, 25 Jun 2026 06:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782368243;
 bh=4P1F+qsnPy8woF4AXwG0lXDzNsX28qDh2pupithWkpc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Cye2bB3Cq2jA9rR5U0/JtvL1kj28VY6orl0J+wHOi/Y2JyvSrLa1shafHXbGGodPZ
 oVSMB/RD7+PGQf6LgrB5aL/ETO5SpfGJa092/pzW97hqF03SMV8jk88zWdHHxbXjn2
 461lVwTtCzhOhgBTelNwgnP80exOvD8Ba5R1H9ZrXnapApcq4DFQDueXl2K/B3Mh8R
 bS/6kxpK0+xvQ6oh9RhNnRDRqOs1Uw7hVzu8XpqeTqvWBzxG5IXH32ucOK+S5BtFh6
 csY9jor3so+EbkAKw9CJMyrmlQfD+q8iRyYzbr1IlwFfI/WBs5Z3JSE6xKtTzvfHuM
 vx4vQpAJ6WFsQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/i915/psr: Skip PSR exit for legacy cursor
 updates on LunarLake onwards
To: "Aaron Ma" <aaron.ma@canonical.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260625055514.3636380-1-aaron.ma@canonical.com>
References: <20260625055514.3636380-1-aaron.ma@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 06:17:22 +0000
Message-Id: <20260625061723.2957C1F000E9@smtp.kernel.org>
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
- [High] Skipping PSR exit on LunarLake for legacy cursor updates leaves th=
e panel in self-refresh, freezing the cursor visually.
--

commit 04eaf4bdd079c2712c8f636ed5b61d70a97e245e
Author: Aaron Ma <aaron.ma@canonical.com>

drm/i915/psr: Skip PSR exit for legacy cursor updates on LunarLake onwards

This commit attempts to optimize PSR behavior for legacy cursor updates on
LunarLake and newer platforms by skipping the PSR exit and matching the
ORIGIN_FLIP behavior.

> diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i=
915/display/intel_psr.c
> --- a/drivers/gpu/drm/i915/display/intel_psr.c
> +++ b/drivers/gpu/drm/i915/display/intel_psr.c
[ ... ]
> @@ -3772,7 +3772,7 @@ void intel_psr_flush(struct intel_display *display,
> =20
>  		if (origin =3D=3D ORIGIN_FLIP ||
>  		    (origin =3D=3D ORIGIN_CURSOR_UPDATE &&
> -		     !intel_dp->psr.psr2_sel_fetch_enabled)) {
> +		     (DISPLAY_VER(display) >=3D 20 || !intel_dp->psr.psr2_sel_fetch_en=
abled))) {
>  			tgl_dc3co_flush_locked(intel_dp, frontbuffer_bits, origin);
>  			goto unlock;
>  		}

[Severity: High]
Will this cause the cursor to freeze on the screen during legacy cursor
updates while the panel is in Panel Self-Refresh (PSR) mode?

LunarLake lacks hardware PSR tracking. When userspace uses drmModeMoveCurso=
r,
the fast-path cursor update writes directly to cursor MMIO registers and
triggers a frontbuffer flush with ORIGIN_CURSOR_UPDATE. Since this fast-path
does not use the atomic commit flow, it never calls intel_vrr_send_push() to
send a TRANS_PUSH frame change event.

By returning early here on DISPLAY_VER >=3D 20, the driver skips
_psr_flush_handle() and intel_psr_exit(). Without a PSR exit or a TRANS_PUSH
event, won't the panel remain asleep and ignore the newly written cursor MM=
IO
registers?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625055514.3636=
380-1-aaron.ma@canonical.com?part=3D1
