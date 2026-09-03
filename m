Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FCEEC61DD3
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 18:48:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADA7710F749;
	Thu,  3 Sep 2026 18:48:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="d3jbOm09";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F32D810F72F
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 18:47:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 062A160219;
 Thu,  3 Sep 2026 18:47:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8608E1F000E9;
 Thu,  3 Sep 2026 18:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788461278;
 bh=TQnz93ltx8OcA7rbgOzIQ+bkCjBiBoLy7YZEDk7e7MM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=d3jbOm09v90QPKVLU3vSZmgUJHetIAULATE/yyKthtrx6E4s7WG6EX/t7W+heAn3B
 DTviHMk7xE6g9T2E/s3iz72fZ1CHsvq87mpDTjZdRJu9BAS5RDeH5EWfFfZqodOYz4
 Q1mgqTr/5dlrOl2lVAeNzNRPPx8NiBd36B9XWL/+NyJUTOd00zK1WRNxudDchVl7yP
 qUHlusSbVjXSenyKQup/EzXUcY2km3oaH2Qn7gxzga1sVsYzWuaE/q/+Bl4Tc41vxh
 EgNNkspWCTPKuwVBKOZq7gVqgsi2MfdCpkFx8SNMr2Y9JHUmPD0IlLNUmr8jcfsVGc
 +UUXb1EtPOiqA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] drm/msm/gem: Add modparam to disable shrinker blocking
To: "Rob Clark" <robin.clark@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260903183725.15835-2-robin.clark@oss.qualcomm.com>
References: <20260903183725.15835-1-robin.clark@oss.qualcomm.com>
 <20260903183725.15835-2-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 18:47:58 +0000
Message-Id: <20260903184758.8608E1F000E9@smtp.kernel.org>
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
- [High] The shrinker scan function `msm_gem_shrinker_scan` loses count of =
freed objects and aborts prematurely by returning `SHRINK_STOP` when all sc=
anned objects are successfully freed.
--

commit 1da508dba68cbcbae647ca4f3177e66e5a19e756
Author: Rob Clark <robin.clark@oss.qualcomm.com>

drm/msm/gem: Add modparam to disable shrinker blocking

This commit adds a module parameter, eviction_can_block, to disable
blocking for GEM buffers to become idle during shrinker eviction. This
helps prevent the shrinker from waiting on idle BOs during high memory
pressure, which is undesirable in latency-sensitive use-cases.

> diff --git a/drivers/gpu/drm/msm/msm_gem_shrinker.c b/drivers/gpu/drm/msm=
/msm_gem_shrinker.c
> index 9d2788f79acee..db57609046d1b 100644
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

[Severity: High]
This is a pre-existing issue, but I noticed the shrinker scan function can
lose count of freed objects and abort prematurely.

When the VM calls msm_gem_shrinker_scan(), it loops over LRU stages calling
drm_gem_lru_scan():

drivers/gpu/drm/msm/msm_gem_shrinker.c:msm_gem_shrinker_scan() {
    ...
    for (unsigned i =3D 0; (nr > 0) && (i < ARRAY_SIZE(stages)); i++) {
        ...
        stages[i].freed =3D
            drm_gem_lru_scan(priv->dev, stages[i].lru, nr,
                     &stages[i].remaining,
                     stages[i].shrink,
                     NULL);
        nr -=3D stages[i].freed;
        freed +=3D stages[i].freed;
        remaining +=3D stages[i].remaining;
    }
    ...
    return (freed > 0 && remaining > 0) ? freed : SHRINK_STOP;
}

In drm_gem_lru_scan(), the remaining parameter is only populated with objec=
ts
that failed to be shrunk:

drivers/gpu/drm/drm_gem.c:drm_gem_lru_scan() {
    ...
        if (!ww_mutex_trylock(&obj->resv->lock, ticket)) {
            *remaining +=3D obj->size >> PAGE_SHIFT;
            goto tail;
        }
    ...
}

If all scanned objects in a batch are successfully freed without encounteri=
ng
a locked object, remaining will be 0. The return expression
(freed > 0 && remaining > 0) ? freed : SHRINK_STOP; then evaluates to
SHRINK_STOP instead of the number of freed items.

Does this prematurely abort the core memory management shrinker
(do_shrink_slab) and under-report the amount of reclaimed memory,
potentially degrading memory reclaim efficiency and triggering unnecessary
OOM kills?

>  	return (sc->gfp_mask & __GFP_DIRECT_RECLAIM) ||
>  	       (current_is_kswapd() && (sc->gfp_mask & __GFP_KSWAPD_RECLAIM));
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903183725.1583=
5-1-robin.clark@oss.qualcomm.com?part=3D2
