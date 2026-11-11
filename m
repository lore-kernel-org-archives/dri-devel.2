Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F86606A324
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 08:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BvFbPdo4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D1C210F98B;
	Wed, 11 Nov 2026 08:45:56 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D7B410F98B
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 08:45:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 095686346A;
 Wed, 11 Nov 2026 08:45:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 948BE1F00A06;
 Wed, 11 Nov 2026 08:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794386748;
 bh=o6fnFOUCbTxURHh4yZXOrkM3kFo859+w3p7pNDl3bas=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=BvFbPdo4NBxdATixmnIQvTJ708vYhuqK5EM7tZ3qMXQ+Xr198AdNPD9cHU0FWRb+4
 6I1LrPx0AQYbTAHqG5pGdscLoIEbUUO+TXsjrVNVW6NpZQRyB/Tl6lDU4eBDdV+Cr8
 Fdwtt7W1QT8LNMEDI/hFUrFwqUsvHKFrCScsqB4sJGK3C8oUG05aTcqPainP9PryW9
 Vr2jKl2qmL65YG6Sv4DdR54CcDY3PYU4CxK4FNX1NHgz0MTfJM4KLAwd6+A+aC1U5k
 6FjggiRX7zVyfUYML4PexppTDtKraP+Xp1kBHa/TBz20f4xpGixUZsdM75XoYR5vkD
 dPwiQj772E3Yw==
Message-ID: <sashiko-outbox-208631@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/5] drm/amd/display: send the flip event right away if
 vblank is off
To: "Prike Liang" <Prike.Liang@amd.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261111083534.514290-3-Prike.Liang@amd.com>
References: <20261111083534.514290-1-Prike.Liang@amd.com>
 <20261111083534.514290-3-Prike.Liang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 08:45:48 +0000
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
- [High] drm/amd/display: missing Signed-off-by trailer in commit
  message
--

commit 26c603fc4a2cad18ac38e5e382079d6b467933c0
Author: Prike Liang <Prike.Liang@amd.com>

> drm/amd/display: send the flip event right away if vblank is off
>
> dm_arm_vblank_event_pre_programming() takes a vblank reference for a
> page flip or cursor update that carries an event, and the handler that
> later sends the event drops that reference again. The return value of
> drm_crtc_vblank_get() is ignored, though. If vblank is off, the event
> is armed anyway, and the handler that eventually sends it drops a
> reference that was never taken, which unbalances the vblank refcount.
>
> That can't happen today: DM only turns vblank off for a CRTC that it
> disables, and a disabled CRTC has no active planes. The next patch also
> turns vblank off while a GPU reset has the streams stopped, though.
> Page flips that don't modify the DC state skip
> amdgpu_dm_commit_streams() and only take dc_lock after this point, so
> they still get here while the reset holds it.
>
> Send the event right away when no vblank reference can be taken, like
> drm_crtc_vblank_off() does for queued vblank events. No vblank interrupt
> could deliver it in that case anyway.
>
> Add a KUnit test for it.
>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Assisted-by: Copilot:claude-opus-5.5

[Severity: High]
This commit message is missing a Signed-off-by trailer from the patch
author.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111083534.5142=
90-1-Prike.Liang@amd.com?part=3D3
