Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C124C88E53
	for <dri-devel@archiver.kernel.org>; Sat, 12 Sep 2026 15:13:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7951A10E72F;
	Sat, 12 Sep 2026 15:13:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="atIjrsUS";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BD6D10E72F
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 15:13:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B6BF260232;
 Sat, 12 Sep 2026 15:13:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E00E1F00893;
 Sat, 12 Sep 2026 15:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789226035;
 bh=EEII5qATS+xMj7RwUKFw7/C74ONpBJrA9tcRX4RLt4c=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=atIjrsUS4ytYAeRP+bak489cApXmhgJAva2xYPIc5h/w9qMp64k3Qo2mbW9HrCAaQ
 iEuKhn9ZMWui/Dwmjakp2DyAcDoXRJqejmjoRJjX1m7bWcETubVBiCuUTo+Ec4jZQF
 1bSXEJxFbwOrWJ3dbcR9eDh4p+ux1Xn3PGiTC8RJ4qDZvbjGLjVm3vpnPgii/QZaHl
 qZ/shYbysrIRliMoBmCMT4lSNMrQtj1Vwspim02oxQPDnbgWOQ2ORcVdoZOQEVbztD
 z9AZuqRUlF/+SPwv+nvyZ0aq0OStS4iKhRdQRkb55OPzD+B08LB+EY8VyzZlqK5fto
 tyF7cpkRIqkZQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] drm/msm/gem: Add modparam to disable shrinker
 blocking
To: "Rob Clark" <robin.clark@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260912145922.24115-2-robin.clark@oss.qualcomm.com>
References: <20260912145922.24115-1-robin.clark@oss.qualcomm.com>
 <20260912145922.24115-2-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 15:13:54 +0000
Message-Id: <20260912151355.4E00E1F00893@smtp.kernel.org>
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

Pre-existing issues:
- [High] msm_gem_shrinker_scan incorrectly returns SHRINK_STOP when pages a=
re successfully freed but the scanned LRU becomes empty, or when the scan y=
ields no freed pages but pages remain.
--

commit 9512c359aecfd18777a053ee1d115de39b75b08a
Author: Rob Clark <robin.clark@oss.qualcomm.com>

drm/msm/gem: Add modparam to disable shrinker blocking

This commit adds a module parameter, eviction_can_block, to disable the
shrinker's ability to block waiting for GEM buffers to become idle. This
provides a way to avoid latency issues during memory pressure for sensitive
use-cases.

> diff --git a/drivers/gpu/drm/msm/msm_gem_shrinker.c b/drivers/gpu/drm/msm=
/msm_gem_shrinker.c
> index 3514d5c849896..83ee032cb21d7 100644
> --- a/drivers/gpu/drm/msm/msm_gem_shrinker.c
> +++ b/drivers/gpu/drm/msm/msm_gem_shrinker.c
> @@ -19,6 +19,10 @@ static bool enable_eviction =3D true;
>  MODULE_PARM_DESC(enable_eviction, "Enable swappable GEM buffers");
>  module_param(enable_eviction, bool, 0600);
> =20
> +static bool eviction_can_block =3D true;
> +MODULE_PARM_DESC(eviction_can_block, "Enable blocking for GEM buffer to =
become idle for eviction");
> +module_param(eviction_can_block, bool, 0600);
> +
>  static bool can_swap(void)
>  {
>  	return enable_eviction && get_nr_swap_pages() > 0;
> @@ -26,6 +30,8 @@ static bool can_swap(void)
> =20
>  static bool can_block(struct shrink_control *sc)
>  {
> +	if (!eviction_can_block)
> +		return false;
>  	return (sc->gfp_mask & __GFP_DIRECT_RECLAIM) ||
>  	       (current_is_kswapd() && (sc->gfp_mask & __GFP_KSWAPD_RECLAIM));
>  }

[Severity: High]
This is a pre-existing issue, but does msm_gem_shrinker_scan() correctly
report reclaimed memory?

In drivers/gpu/drm/msm/msm_gem_shrinker.c:msm_gem_shrinker_scan(), the
return value uses a ternary operation:

	return (freed > 0 && remaining > 0) ? freed : SHRINK_STOP;

If the scan successfully frees all remaining pages in the LRU (remaining
becomes 0, freed > 0), wouldn't this evaluate to SHRINK_STOP? When
do_shrink_slab() receives SHRINK_STOP, it breaks its scanning loop and
bypasses accounting for the successfully freed pages, causing them to be
lost from shrinker accounting.

Similarly, if the scan fails to free any pages because the objects are
active or locked (freed is 0, remaining > 0), it also evaluates to
SHRINK_STOP. Wouldn't this cause do_shrink_slab() to abort scanning the
msm_gem slab entirely for this cycle?

This means unfreeable objects at the head of the LRU completely block the
reclaim of reclaimable objects further down the list, which could severely
impact the system's ability to reclaim GPU memory under pressure.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912145922.2411=
5-1-robin.clark@oss.qualcomm.com?part=3D2
