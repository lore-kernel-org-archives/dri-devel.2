Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BDD606A320
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 03:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HL9AiSs1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 090ED10E010;
	Wed, 11 Nov 2026 03:52:10 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDA3910E061
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 03:52:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E98756349E;
 Wed, 11 Nov 2026 03:52:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78E921F0089F;
 Wed, 11 Nov 2026 03:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794369122;
 bh=THn1fPif7AbIHYGCc5QCrYtv9Cl+UoZA6Pz15HZUKZE=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=HL9AiSs1uYqFjJAgj1Qcn/sj/vXgqSfboYFIolgWZy1rRipWznyQgeiw0W9w5lU5j
 AT+9kraa7JFkqhqG3Rbrg6fTwvuqZTLXtU/VRVmR2xM2nBH5kesvGiQPAmv6QVvU58
 TuypC3qw0+qyiHKiK3AfuwmjqyYLMwWaocszpI/uUU+7CMclf9lSoc5p0zzPojwW9g
 rYe1LQf7Tmi2/B5vxF9C6ovKyM9+PapadhY+bksW1Z/5k5nz96oVTsECmSArh/kFo7
 1jmZjkCsDuGCuCn2nPz4kE2+BNnNiA2oIyDDodxiBtdUD3xP8Apr7dPz9D+L2w3q4o
 wHmUjpc0ZHVFQ==
Message-ID: <sashiko-outbox-208238@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/fbdev-shmem: don't warn on a transient dirty
 callback failure
To: xujiahao <xujiahao@cmss.chinamobile.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261111114108.675721-1-xujiahao@cmss.chinamobile.com>
References: <20261111114108.675721-1-xujiahao@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 03:52:01 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] drm/fbdev-shmem: single-word handle used in Author and
  Signed-off-by
- [Low] drm/fbdev-shmem: missing Fixes trailer for
  drm_fbdev_shmem_helper_fb_dirty()
--

commit 3bcd442074e2ca85eb8c3537eb31d873b7b1b756
Author: xujiahao <xujiahao@cmss.chinamobile.com>

> drm/fbdev-shmem: don't warn on a transient dirty callback failure
>
> The fbdev dirty callback (drm_atomic_helper_dirtyfb()) can fail with
> -ENOMEM when the atomic commit allocation fails under memory pressure.
> That is a transient runtime condition, not a driver bug: the damage is
> only cosmetic and the frame is redrawn on the next flush.
>
> drm_WARN_ONCE() turns this recoverable failure into a WARN splat (and a
> panic with panic_on_warn), which syzbot keeps reporting:
>
>   virtio-pci 0000:00:01.0: [drm] Dirty helper failed: ret=3D-12
>   WARNING: drivers/gpu/drm/drm_fbdev_shmem.c:118 at ...
>
> Keep the warning for other failures, but do not warn about -ENOMEM.  The
> error is still propagated to the caller.
>
> Reported-by: syzbot+369ee6a6e9d0bbf14b37@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D369ee6a6e9d0bbf14b37
> Signed-off-by: xujiahao <xujiahao@cmss.chinamobile.com>

[Severity: High]
Both the Author field and the Signed-off-by trailer use the single-word
handle "xujiahao" instead of a full real name.  Per
Documentation/process/submitting-patches.rst, the Developer's Certificate of
Origin requires signing off with a full human name (for example, "Jiahao
Xu").

[Severity: Low]
This fixes a false-positive warning in drm_fbdev_shmem_helper_fb_dirty().
Should the commit message include a Fixes: trailer?

  Fixes: 150f431a0831 ("drm/fbdev: Add fbdev-shmem")
  Fixes: f0f195d1a3ae ("drm/fbdev-shmem: Support struct drm_driver.fbdev_pr=
obe")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111114108.6757=
21-1-xujiahao@cmss.chinamobile.com?part=3D1
