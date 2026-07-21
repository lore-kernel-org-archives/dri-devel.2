Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2B1DC4452D
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 20:02:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08F3810EB3C;
	Tue, 21 Jul 2026 20:02:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Bqr1X9Hs";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF38810EB36
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 20:02:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 924B2417C0;
 Tue, 21 Jul 2026 20:02:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29B9B1F000E9;
 Tue, 21 Jul 2026 20:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784664134;
 bh=ujvJr9/9fRNZtODXpux8Y7H70PdPOvrhrGGFXLoaRJk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Bqr1X9HsCI1yQR+fHB3t/lbmJXMvyv9OnRngh0ylHpEWvSdK6HZvvj5KZNwHMGrH4
 4n4pY7PPeujjkZECiGSUrksLa0RRxVfPSMTMQZlf4JB2W9bVJD6QOorlh46mlEIX9E
 meaRrCZPGf6m8p8C5SYayBIKVfOwUnLlbZwZBNFKhK3EefwtSo1dx7GL3iohMAY+Lt
 4rDv5SLAHIRbeZpor9cjP2rQDMhZIUKNBJNdQQr0Gys7H6t3xjPDQuiApp3Sxw+XQe
 2xcqWZCVlKxAyG2+lZGhVPOtk1yCNcalDuOD3xY09pCb7BYx+KLcpIOXp3BYYKvkeJ
 iLac2jNHhHuFw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 5/6] drm/ttm: Be more aggressive when allocating
 below protection limit
To: "Natalie Vock" <natalie.vock@gmx.de>
Cc: mkoutny@suse.com, hannes@cmpxchg.org, tj@kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260721-dmemcg-aggressive-protect-v7-5-97c4b1014315@gmx.de>
References: <20260721-dmemcg-aggressive-protect-v7-0-97c4b1014315@gmx.de>
 <20260721-dmemcg-aggressive-protect-v7-5-97c4b1014315@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 20:02:13 +0000
Message-Id: <20260721200214.29B9B1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Missing IS_ERR check on get_cg_pool_unlocked() return value in dme=
m_cgroup_get_common_ancestor() causes a css reference leak and returns an E=
RR_PTR.
- [High] alloc_state->may_try_low remains uninitialized (false) when ttm_re=
source_try_charge fails with -EAGAIN, preventing necessary eviction of low-=
protected buffers.
--

--- Patch [5]: [PATCH v7 5/6] drm/ttm: Be more aggressive when allocating b=
elow protection limit ---
commit e2b13b1ad2c262766026403c3b8254d739bd29e9
Author: Natalie Vock <natalie.vock@gmx.de>
Subject: drm/ttm: Be more aggressive when allocating below protection limit

This patch modifies the TTM allocation process to consider cgroup protection
limits. When a cgroup's memory usage is below its low or min limit, TTM will
now attempt to evict unprotected buffers to make space rather than forcing
allocations into the GTT domain.

> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
> index 95ce3fc0f8764..ec0821e306da1 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
[ ... ]
> @@ -544,6 +548,42 @@ static int ttm_bo_alloc_at_place(struct ttm_buffer_o=
bject *bo,
>  		}
>  	}
> =20
> +	/*
> +	 * cgroup protection plays a special role in eviction.
[ ... ]
> +	 * eviction path that only evicts buffers covered by neither 'low' or
> +	 * 'min' protections.
> +	 */
> +	if (!alloc_state->in_evict) {
> +		may_evict |=3D dmem_cgroup_below_min(NULL, alloc_state->charge_pool);
> +		alloc_state->may_try_low =3D may_evict;

[Severity: High]
If ttm_resource_try_charge() fails with -EAGAIN earlier in this function, it
returns early and bypasses setting alloc_state->may_try_low here.=20

Since alloc_state is zero-initialized, may_try_low would remain false.
Would this unintentionally prevent the fallback eviction pass in
ttm_bo_evict_alloc() from executing, thereby preventing a cgroup at its max
limit from evicting low-protected BOs from its own subtree?

> +
> +		may_evict |=3D dmem_cgroup_below_low(NULL, alloc_state->charge_pool);
> +	}
> +
>  	ret =3D ttm_resource_alloc(bo, place, res, alloc_state->charge_pool);
>  	if (ret) {
[ ... ]

While reviewing the interactions with the dmem cgroup API, I noticed an
issue in kernel/cgroup/dmem.c:

kernel/cgroup/dmem.c:dmem_cgroup_get_common_ancestor() {
        ...
		pool =3D get_cg_pool_unlocked(css_to_dmemcs(ancestor_css),
					    a->region);
	if (!pool)
		css_put(ancestor_css);
        ...
}

[Severity: High]
Could get_cg_pool_unlocked() return an error pointer like ERR_PTR(-ENOMEM)?

If it returns an error pointer, the !pool check evaluates to false, causing
the ancestor_css reference to be leaked.

Additionally, since this function is expected to return NULL on failure,
returning an ERR_PTR could cause callers checking for NULL to dereference
the error pointer. Should this check use IS_ERR(pool) instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721-dmemcg-agg=
ressive-protect-v7-0-97c4b1014315@gmx.de?part=3D5
