Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82968606A333
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 08:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dihCHPQH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEA8110F98A;
	Wed, 11 Nov 2026 08:43:05 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46AEC10F98A
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 08:43:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2F4E3475B7;
 Wed, 11 Nov 2026 08:43:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E822C1F00A05;
 Wed, 11 Nov 2026 08:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794386580;
 bh=ij7t8QBeUn+pKE5JZxN9KiIFeONeabzkb1oOPq5+6Co=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=dihCHPQH+LeXbVF5iN4xQXtkOXLrhi/aq8NPjzPhJBLR4pAdl0yHRTN59t2QzO4x/
 pPgxCXwjJi3ciBn7WPFco9ms7IrhNtcAB0sL+4kIlVnS35bON5KIuc/u4xaZ78sGoT
 7pE9USfC22cQGuxtexN/DsAby/e8blDNO9TVySUFVhW/sMan1EMaVWX6HO3Iv4wfPi
 rcR9u5DXxN7Oj66/PlvKMen6Ki9buIgMz3urDAcgy88g4IDE8+rNS+Nw71ZqQs9n85
 9ni6KQHUDoTBDddeHBrQff/lKGMYmpBpD5DuRcPWUU4/6yO42zIifyGzU7tkGqm0SV
 jM36ByFQGHkSg==
Message-ID: <sashiko-outbox-208626@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/5] drm/client: Make the FBIO_WAITFORVSYNC vblank wait
 interruptible
To: "Prike Liang" <Prike.Liang@amd.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261111083534.514290-1-Prike.Liang@amd.com>
References: <20261111083534.514290-1-Prike.Liang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 08:42:59 +0000
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] drm/client: missing Signed-off-by trailer in commit message
--

commit bc9640f0750976b2feac736dbfd1a54661008656
Author: Prike Liang <Prike.Liang@amd.com>

> drm/client: Make the FBIO_WAITFORVSYNC vblank wait interruptible
>
> FBIO_WAITFORVSYNC calls drm_client_modeset_wait_for_vblank(), which
> waits with drm_crtc_wait_one_vblank(). That wait is uninterruptible and
> only gives up after one second. If no vblank interrupt arrives, for
> example while the driver resets the display hardware, the caller sleeps
> in D state for the whole second and can't be interrupted, not even by
> SIGKILL.
>
> DRM_IOCTL_WAIT_VBLANK waits interruptibly, and so do fbdev drivers that
> implement FBIO_WAITFORVSYNC themselves, such as atyfb and matroxfb.
>
> Add drm_crtc_wait_one_vblank_interruptible(), a DRM-internal variant of
> drm_crtc_wait_one_vblank() that a signal can interrupt, and use it in
> drm_client_modeset_wait_for_vblank(). Return -ERESTARTSYS when a signal
> interrupts the wait, so that the ioctl returns to userspace or is
> restarted. Timeouts and disabled CRTCs are still not reported.
>
> The fbdev damage worker also calls drm_client_modeset_wait_for_vblank(),
> but it runs in a kernel thread, which doesn't receive signals, so its
> wait doesn't change. Drivers keep using drm_crtc_wait_one_vblank().
>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Assisted-by: Copilot:claude-opus-5.5

[Severity: High]
The commit message is missing a Signed-off-by trailer, which is required
under the Developer's Certificate of Origin before the patch can be
merged.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111083534.5142=
90-1-Prike.Liang@amd.com?part=3D1
