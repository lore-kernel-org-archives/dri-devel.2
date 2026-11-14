Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DD8606A338
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 01:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fmpxA95K
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F27710E664;
	Sat, 14 Nov 2026 01:52:27 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE2DE10E561;
 Sat, 14 Nov 2026 01:52:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A39AE61849;
 Sat, 14 Nov 2026 01:52:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27A431F000C4;
 Sat, 14 Nov 2026 01:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794621140;
 bh=xGD+ImPPMSdRVjb8LyXNlIDELcjgx0xmYwlBg3ducEk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=fmpxA95KGiWINwaez0Z32HSPpZUvWL1Fia/lSNl0D4BwsDRiZI/UmRX0QZsLNJGE2
 93nZVWqnUGUT4PmbDXqUElMtuzfRqHB41bj9/PGr52bX3EWADRKL868adpDkH2LXdo
 8pJrtd5Qypvq1MDEQZe7fjlZzTlyhuo4nAcq3T2pl8b2CFQDtwxWouUCIVf2T52iDh
 MzSMGHBbrIqw/rktLh3Hw+BHeWobR4UGf4F7SqU9Xij7LiTQqXmcunuWIlSScx+YKf
 hvuEL6Uw2vzca6ib6BKCwD1ikcMO3KibpdIMX/B18ETAni43LRM0j1czPbG/ajAZ1O
 Yc8ANNUH+3Zrg==
Message-ID: <sashiko-outbox-214014@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/7] drm/i915/vrr: Fix the pixel clock overflow in the
 vmax computation
To: ElXreno <elxreno@gmail.com>, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261114014335.2132756-3-elxreno@gmail.com>
References: <20261114014335.2132756-1-elxreno@gmail.com>
 <20261114014335.2132756-3-elxreno@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 01:52:19 +0000
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
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] drm/i915/vrr: use of handle instead of real name in
  Signed-off-by trailer
--

commit a171d275708d23dc260c42db008a450a9d345462
Author: ElXreno <elxreno@gmail.com>

> drm/i915/vrr: Fix the pixel clock overflow in the vmax computation
>
> intel_vrr_compute_vmax() multiplies crtc_clock, which is in kHz, by
> 1000 in a signed int. A 3840x2400@240 timing has a 2342.4 MHz pixel
> clock, so the product overflows, the quotient turns negative and vmax
> is clamped to crtc_vtotal. vmin then equals vmax and VRR is never
> enabled for the mode, although it is within the range of the panel.
>
> Do the multiplication in 64 bits.
>
> No Fixes tag: intel_vrr_compute_vmax() is only called for a mode
> within the VRR range, such a pixel clock needs the joiner, and
> intel_vrr_compute_config() takes joined modes out of the range so
> far.
>
> Signed-off-by: ElXreno <elxreno@gmail.com>

[Severity: High]
Could the Author and Signed-off-by lines be updated to use a real full name
rather than a handle?  Documentation/process/submitting-patches.rst requires
a known identity rather than a pseudonym or single-word username for the
Developer Certificate of Origin.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114014335.2132=
756-1-elxreno@gmail.com?part=3D2
