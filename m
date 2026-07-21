Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62FF6C4451C
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 05:06:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FCC110E2A0;
	Tue, 21 Jul 2026 05:06:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nUM5gEjR";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6133A10E2A0
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 05:06:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 013EE42006;
 Tue, 21 Jul 2026 05:06:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6DDC1F000E9;
 Tue, 21 Jul 2026 05:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784610368;
 bh=UmoYdee2FLBm8kvOtobCZf4dlgWV3sGgyZWq4skgCkw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nUM5gEjRHqc/tLEez6yK81Meo5R8BuG5zHMjWHkJYUozrqMpRYAkUwNDnzr/BkN5A
 BfhqrFQ1hkeH/hcINH4GXFhFbWuEKucM6qVwjV9dsuSaxwMp8qbJEWIckKxl2+lOLG
 tvupgDy235sr9sPgf021O3kqw2Zq7twaMhKDjFHaL411MIlTnZ2jHGMJoZGyXI1MNv
 CTogJU7BszBKLJ8qYx0DF3zYYPRdaI5r1d2H5Sj/AOOXztdyVUVeJi/0nySYGjThC4
 tw2Lx7HQwAE5iZttv14UwXNxRmcqvvrWdIRbe9cK2mMEIesO0GRLyKv3w5/fWZ3Tst
 qHJOXHGLKLd+w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] accel: Arm Ethos-U NPU: fix most uapi kernel-doc
 warnings
To: "Randy Dunlap" <rdunlap@infradead.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260721050257.3546073-1-rdunlap@infradead.org>
References: <20260721050257.3546073-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 05:06:08 +0000
Message-Id: <20260721050608.B6DDC1F000E9@smtp.kernel.org>
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
- [Medium] The commit message explicitly claims to resolve kernel-doc warni=
ngs for the `flags` and `id` members of `struct drm_ethosu_perfmon_set_glob=
al`, but the patch entirely omits adding the corresponding documentation.
--

--- Patch [1]: [PATCH v3] accel: Arm Ethos-U NPU: fix most uapi kernel-doc =
warnings ---
commit 0321c04e286a508fa979adef1d2ae1df38206a86
Author: Randy Dunlap <rdunlap@infradead.org>

accel: Arm Ethos-U NPU: fix most uapi kernel-doc warnings

This commit updates the kernel-doc comments in the ethosu_accel uapi header
to resolve several documentation warnings. It adds missing struct member
descriptions and corrects prototype names.

> Warning: include/uapi/drm/ethosu_accel.h:230 struct member 'perfmon_id' n=
ot described in 'drm_ethosu_submit'
> Warning: include/uapi/drm/ethosu_accel.h:274 struct member 'flags' not de=
scribed in 'drm_ethosu_perfmon_set_global'
> Warning: include/uapi/drm/ethosu_accel.h:274 struct member 'id' not descr=
ibed in 'drm_ethosu_perfmon_set_global'
>=20
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

[Severity: Medium]
Does this patch accidentally omit the documentation updates for flags and i=
d?=20

The commit message mentions resolving the warnings for=20
drm_ethosu_perfmon_set_global, but the actual changes do not appear in=20
the diff.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721050257.3546=
073-1-rdunlap@infradead.org?part=3D1
