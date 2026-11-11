Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FC1606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 08:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aOorIyEz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6989A10F988;
	Wed, 11 Nov 2026 08:45:38 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8508F10F988
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 08:45:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5393240F06;
 Wed, 11 Nov 2026 08:45:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16C481F00A05;
 Wed, 11 Nov 2026 08:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794386732;
 bh=5eT9nj+RwGrHJP2YmoAgR4YnW7EygHXzLtu6JmP5+08=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=aOorIyEzr9TQm3VsVF3w7EsZGNgZGbzniTZlnjWZISNWNRIEvXxZMD8GEa2DEfnS/
 1bmj7a+RCDu+gY2TW665CzsHps1zfJcziuZjWoZfkh+90jrRc0qWUzJGpMXAuqNiFw
 Q/2tDn6iRLxPESWtf7UmKU0nX8E8BFR7tVnMX52NygBhRc26Z3PS+cLa2Ux63ICjOY
 tcrC5bSHGzoIxspuUKVR39SCRz4VOY/N/0VFZLF9bInMZxPkRgoULk1jtOfdE75rQs
 1Unn2x+vxvGSUoz8g8MIkRLrd+34o11Km0yPBsznNkpZUHnZhvLRIZ7nNSrf1Iteqw
 OOEOMZ/iQyidA==
Message-ID: <sashiko-outbox-208630@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/5] drm/vblank: Stop drm_crtc_wait_one_vblank() when
 vblank is turned off
To: "Prike Liang" <Prike.Liang@amd.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261111083534.514290-2-Prike.Liang@amd.com>
References: <20261111083534.514290-1-Prike.Liang@amd.com>
 <20261111083534.514290-2-Prike.Liang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 08:45:31 +0000
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
- [High] drm/vblank: missing Signed-off-by trailer in commit message
--

commit 7617b69ad08b75966bdfac2d98682c551d654593
Author: Prike Liang <Prike.Liang@amd.com>

> drm/vblank: Stop drm_crtc_wait_one_vblank() when vblank is turned off
>
> drm_crtc_vblank_off() turns off the vblank interrupt even while someone
> holds a vblank reference and waits for a vblank. It then wakes up the
> vblank wait queue. DRM_IOCTL_WAIT_VBLANK stops waiting at this point,
> because its wait condition also checks whether vblank is still enabled.
>
> drm_crtc_wait_one_vblank() and drm_crtc_wait_one_vblank_interruptible()
> only check whether the vblank count has changed. Once vblank is off, the
> count doesn't change, so the woken waiter sleeps again until the wait
> times out after one second and warns "vblank wait timed out". This
> happens, for example, when the fbdev damage worker or FBIO_WAITFORVSYNC
> waits for a vblank while the driver turns the CRTC off for suspend or a
> GPU reset.
>
> Make __drm_crtc_wait_one_vblank(), which implements both functions, also
> stop waiting when vblank is turned off, and return -EINVAL if no vblank
> passed, the same error that drm_vblank_get() returns when vblank is off.
> The wait condition is checked before going to sleep, so this also covers
> vblank being turned off between drm_vblank_get() and the wait. Waits
> that see a vblank, time out or are interrupted behave as before.
>
> Fixes: e8450f51a4b3 ("drm/irq: Implement a generic vblank_wait function")
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Assisted-by: Copilot:claude-opus-5.5

[Severity: High]
This commit message is missing a Signed-off-by: trailer from the patch
author.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111083534.5142=
90-1-Prike.Liang@amd.com?part=3D2
