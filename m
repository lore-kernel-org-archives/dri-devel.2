Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2670C606A32D
	for <dri-devel@archiver.kernel.org>; Sat,  7 Nov 2026 18:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UiRdV/BC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8316F10E0E4;
	Sat,  7 Nov 2026 18:47:25 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD8B010E0E4
 for <dri-devel@lists.freedesktop.org>; Sat,  7 Nov 2026 18:47:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9D2B061106;
 Sat,  7 Nov 2026 18:47:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E8771F0089F;
 Sat,  7 Nov 2026 18:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794077237;
 bh=s1YDMPjR480/8+mH+OLR3UO4b82dHbKlTpbf6m7yADc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UiRdV/BCEEJDbUF3Q/GL3GzmF3vf1vZooxE/9e9EccLyU/eVJRRx/qPKqTcvr6o5n
 iDILcH1+FhDmd3NbEarx9wqGgycuZaOPYrdfWU4hu2/5OZaGslc8OrY8RJtQmb3t69
 Zp4ufDFEtXms1cOPtfrrtBwCwnmP8Oa13I+i8GXXdxR5FkVThnf7ZTiU66QWzDFS9V
 cvMHntBKunm2956PAEmwN+W1svpcw9eV1rIl0B3o2YPvTgilrKP5DV3rlmL9s6mJrf
 GR5vvZxszg3z73OSh7Gbj2HtgPRqcqqibUK9pDUDqlW9qWVq0bbrF/hbjTelBfGhsr
 YY7Nj63mqhYSQ==
Message-ID: <sashiko-outbox-203186@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] firmware/sysfb: Fix device reference count leak in
 sysfb_disable()
To: "Wentao Liang" <vulab@iscas.ac.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <1794071765.2669957.4378216502938475@iscas.ac.cn>
References: <20260916073815.1972045-1-vulab@iscas.ac.cn>
 <2d89b88f-863c-4e8d-839c-5e800b4c4902@suse.de>
 <1794071765.2669957.4378216502938475@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 18:47:16 +0000
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
- [Low] firmware/sysfb: conversational reply and mbox headers in commit
  message
--

commit 138aa0cb748b38d7396e354631327333b8c26fd3
Author: Wentao Liang <vulab@iscas.ac.cn>

> firmware/sysfb: Fix device reference count leak in sysfb_disable()
>
> Hi Thomas, Alex,
>
> Sorry for the very late reply, and thanks for the review.
>
> Alex, you asked whether sysfb_unregister() would still need to be called
> when the parent device lookup returns an error. It does: without a known
> parent we cannot tell whether the system framebuffer belongs to the
> calling device, and leaving it registered could make sysfb interfere with
> the native driver. Thomas, that is the defensive behaviour you suggested,
> so v2 unregisters unconditionally when sysfb_parent_dev() fails and only
> drops the reference on the non-error path.
>
> The reference leak fix itself is unchanged.
>
> From 8c5f084941a3b6aca5d3ae8cff0c3bd1d4ae1e6f Mon Sep 17 00:00:00 2001
> From: Wentao Liang <vulab@iscas.ac.cn>
> Date: Sat, 7 Nov 2026 17:02:27 +0000
> Subject: [PATCH v2] firmware/sysfb: Fix device reference count leak in
>  sysfb_disable()
>
> sysfb_parent_dev() returns a pointer to &pdev->dev with an acquired
> reference when it finds the PCI device that contains the system
> framebuffer. sysfb_disable() never drops that reference, so a reference
> to the PCI device is leaked on every call that resolves a parent.
>
> Release the reference with put_device() before leaving the critical
> section.
>
> If the parent device cannot be determined, unregister the system
> framebuffer unconditionally, as it might still belong to the calling
> device. Leaving sysfb registered in that case can make it interfere
> with the native driver.
>
> Fixes: b49420d6a1ae ("video/aperture: optionally match the device in sysf=
b_disable()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

[Severity: Low]
The commit message includes a conversational reply and a duplicate
git-format-patch header block above the "---" tear line without a
scissors line ("-- >8 --"), so git am records them in the commit log.
The reply notes belong below "---" (or above a scissors line), and the
extra mbox headers should be removed from the changelog body.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/1794071765.2669957.=
4378216502938475@iscas.ac.cn?part=3D1
