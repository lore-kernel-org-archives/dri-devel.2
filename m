Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64636606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 02:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EaaNVpth
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6A7389B57;
	Tue, 17 Nov 2026 02:32:55 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1F0589B57
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 02:32:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8A8B962741;
 Tue, 17 Nov 2026 02:32:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D0531F000C4;
 Tue, 17 Nov 2026 02:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794882768;
 bh=Zuk1QlhOZi6Iahvs49TKUdJjbm9IYXjveOINjE8ectc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=EaaNVpthn9rGaMNi5rkoDycGiecONQY4N/1h/puC3lZUnjcBse8p91Ev1+3ucwQGg
 1SHtNSHIyvnOjWenEiF21Og03PGaEFmdOiKNGLWebs9s7AequwZPoev0OJOfo5flak
 +1nfjcumv8E2OfIeIawoAvyQD35DsoJfDEL3lXsQtblOe9vlRwb1c0uowCi07dz3dM
 CUsMIX7CTncS3Q0jhkWtmNYSpop5lvQp8uCcP5T+yosKimXgkzfK9NwbmScr68qpLK
 8alV+ket8Bw8G0hCUNyByhxHSROxXPO1Ijbh9VL48OhrY3MD0z6eh85XxL9MMrItLC
 ZEUlWl+Cr9rlg==
Message-ID: <sashiko-outbox-218089@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] fbdev: sstfb: Error out if pixclock equals zero
To: "Xue Haolin" <xuehaolin@uniontech.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261117022031.252357-1-xuehaolin@uniontech.com>
References: <20261117022031.252357-1-xuehaolin@uniontech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 02:32:47 +0000
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
- [High] fbdev: sstfb: single-word username in Signed-off-by trailer
- [Low] fbdev: sstfb: unresolvable commit SHA in Fixes trailer
--

commit e66c7f16c1f32c41672200f2d9995e82c7ac0132
Author: xuehaolin <xuehaolin@uniontech.com>

> fbdev: sstfb: Error out if pixclock equals zero
>
> The userspace program could pass any values to the driver through
> ioctl() interface. If the driver doesn't check the value of pixclock,
> it may cause divide-by-zero error.
>
> sstfb_check_var() calls PICOS2KHZ(var->pixclock) which expands to
> 1000000000UL / var->pixclock. If var->pixclock is zero, this causes
> a divide-by-zero exception.
>
> Fix this by checking whether pixclock is zero at the beginning of
> sstfb_check_var(), before it is used as a divisor.
>
> This is similar to CVE-2022-3061 in i740fb which was fixed by
> commit 15cf0b82271b ("video: fbdev: i740fb: Error out if
> 'pixclock' equals zero"), and the fix in savagefb by
> commit 04e5eac8f3ab ("fbdev: savage: Error out if pixclock equals zero").
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

[Severity: Low]
Commit 1da177e4c3f4 ("Linux-2.6.12-rc2") cannot be resolved in the
repository (or only exists in an unfetched historical tree).

> Cc: stable@vger.kernel.org
> Signed-off-by: xuehaolin <xuehaolin@uniontech.com>

[Severity: High]
The Author and Signed-off-by lines use a single-word username (xuehaolin)
rather than a full legal human name, which does not meet the Developer's
Certificate of Origin sign-off requirements in
Documentation/process/submitting-patches.rst.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117022031.2523=
57-1-xuehaolin@uniontech.com?part=3D1
