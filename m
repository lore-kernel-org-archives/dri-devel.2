Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EA96C61DD3
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 19:52:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A44A10EACC;
	Mon, 31 Aug 2026 19:52:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Yvsm0xZ5";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D353610EACC
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 19:52:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8FB03401A1;
 Mon, 31 Aug 2026 19:52:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52F081F000E9;
 Mon, 31 Aug 2026 19:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788205976;
 bh=PBItDgul4QgByQsNEks4ssdEKb5OqYWfqwB8El3unWI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Yvsm0xZ5wFiJdazp3f3U+TY1Xx4/qAY4ywpE1y6ZX9RTu4omQpaOg0B4+LO184sq4
 4fQamVWexVcNe2G4FMmEZTSe2O9g6gAbf4RO7OfHglU8+4ARLIWHvyR///EnKo0iZz
 jjIRKo8EteQuuJE0AXnSpSClmaKshYdegDDBDqY4hy3hVfEnrYb0rNw/tGC/IyPps8
 lIpSwRFF8I/kcptRiZ6fAnsho4loAzYjmumb2pcgyNDhD7WsjeIdmZL1ujPGqh+X0N
 8wYnZhG8xUx5TgLHrCfUJwQBR+pepkd4VatklTo1hUUbWlQPCqFwzIDmQ4zKofpYCE
 wGAdiZmxfUs/g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/gem: Drop ticket arg to lru_scan()
To: "Rob Clark" <robin.clark@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260831174409.465181-1-robin.clark@oss.qualcomm.com>
References: <20260831174409.465181-1-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 19:52:55 +0000
Message-Id: <20260831195256.52F081F000E9@smtp.kernel.org>
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
- [Low] Orphaned kernel-doc parameter documentation for @ticket in drm_gem_=
lru_scan()
--

commit 318d69710561d35ea8d576756a021027b6ce9703
Author: Rob Clark <robin.clark@oss.qualcomm.com>

    drm/gem: Drop ticket arg to lru_scan()
   =20
    Commit 3392291fc509 ("drm/msm: Fix shrinker deadlock") dropped the only
    use of the ticket arg, but at the time left drm_gem_lru_scan() unchanged
    to avoid conflicts with in-flight pathor shrinker support.  This commit
    is the followup to remove the unused arg.

> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> index 018df97d590dc..5d724da019124 100644
> --- a/drivers/gpu/drm/drm_gem.c
> +++ b/drivers/gpu/drm/drm_gem.c
> @@ -1655,8 +1655,7 @@ drm_gem_lru_scan(struct drm_device *dev,
>  		 struct drm_gem_lru *lru,
>  		 unsigned int nr_to_scan,
>  		 unsigned long *remaining,
> -		 bool (*shrink)(struct drm_gem_object *obj, struct ww_acquire_ctx *tic=
ket),
> -		 struct ww_acquire_ctx *ticket)
> +		 bool (*shrink)(struct drm_gem_object *obj))
>  {

[Severity: Low]
Does this code introduce a documentation regression? The ticket parameter is
removed from the drm_gem_lru_scan() function signature here, but it looks l=
ike
the @ticket description is left behind in the kernel-doc comment block right
above this function. This can cause a kernel-doc warning during documentati=
on
builds.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831174409.4651=
81-1-robin.clark@oss.qualcomm.com?part=3D1
