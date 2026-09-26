Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE3ABC9832F
	for <dri-devel@archiver.kernel.org>; Sat, 26 Sep 2026 18:43:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F37DC10E276;
	Sat, 26 Sep 2026 18:43:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aD8jZf8Z";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8ED7110E276
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 18:43:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4BDF6402FC;
 Sat, 26 Sep 2026 18:43:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F1351F00893;
 Sat, 26 Sep 2026 18:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790448195;
 bh=du773oKMCa8hpylRwv023BbgMLG3FVpsCZV/mA8l+w0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=aD8jZf8ZZngyXTs6/ulm03Yog2oaLnij150KC2VNghnKeM9T+CasPpCb4QLYOe/WJ
 7eTdRMvxHNlYqAdsQve+BbHtYe6TT2pRYhRHhP/F+8ZbNdhI374jKR/QIfVQb7q3rN
 Yu41xUQta3ME36I1vEjzRTDATfqAeQVaDCzdUByP4pn7Wv4qyuusY1baioO8KRW8L8
 m+/hW35lA7anhDiRkYIBfk6z8rD0+nNgZtDCY6WSPQIWUF5yqZH6Kii/Pf0yQ11yZW
 l5/6EHRVsoxw1kkAVwBjRmxYLsGaiypDGME6uLZEwedysoPlj460O29fIZpd0sXdCx
 UG1LSRq9OtbXA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/6] drm/msm/gem: Stop calling get_pages() for imported
 dma-bufs
To: "Rob Clark" <robin.clark@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260926183051.25754-6-robin.clark@oss.qualcomm.com>
References: <20260926183051.25754-1-robin.clark@oss.qualcomm.com>
 <20260926183051.25754-6-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 18:43:14 +0000
Message-Id: <20260926184315.0F1351F00893@smtp.kernel.org>
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
- [High] drm/msm: memory leak and LRU invariant violation due to is_residen=
t() relying only on sgt
--

commit 5c4dfee34fe56ce4eb175d5b53ce5d68a5bafe60
Author: Rob Clark <robin.clark@oss.qualcomm.com>

drm/msm/gem: Stop calling get_pages() for imported dma-bufs

This commit stops calling get_pages() for imported dma-bufs and uses
the sgt instead of pages to determine if an object is resident.

> diff --git a/drivers/gpu/drm/msm/msm_gem.h b/drivers/gpu/drm/msm/msm_gem.h
> index d7df016b1f272..d8ec696d89d74 100644
> --- a/drivers/gpu/drm/msm/msm_gem.h
> +++ b/drivers/gpu/drm/msm/msm_gem.h
> @@ -425,7 +425,7 @@ static inline bool is_unevictable(struct msm_gem_obje=
ct *msm_obj)
>  /* Are backing pages/sgt allocated? */
>  static inline bool is_resident(struct msm_gem_object *msm_obj)
>  {
> -	return !!msm_obj->pages;
> +	return !!msm_obj->sgt;
>  }

[Severity: High]
Can this cause a memory leak and trigger a WARN_ON?

If get_pages() successfully allocates msm_obj->pages but fails at
drm_prime_pages_to_sg(), it returns an error but retains msm_obj->pages
while msm_obj->sgt is NULL. With is_resident() now relying strictly on
sgt, this partially backed object is considered non-resident.

If userspace retries pinning the object, get_pages() sees msm_obj->pages
is already populated, returns success, and increments pin_count while sgt
remains NULL. A subsequent unpin or madvise will call update_lru_locked(),
which uses is_resident():

drivers/gpu/drm/msm/msm_gem.c:update_lru_locked() {
    ...
	if (!is_resident(msm_obj)) {
		GEM_WARN_ON(msm_obj->pin_count);

		drm_gem_lru_move_tail_locked(&priv->lru.unbacked, obj);
	}
    ...
}

Because is_resident() returns false, the object is placed in the unbacked
LRU list, causing a memory leak since the shrinker only scans dontneed and
willneed lists. It will also trigger the GEM_WARN_ON splat.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926183051.2575=
4-1-robin.clark@oss.qualcomm.com?part=3D5
