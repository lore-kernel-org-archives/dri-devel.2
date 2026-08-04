Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A485BC55822
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 15:36:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A91D10EAEA;
	Tue,  4 Aug 2026 15:36:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="h2CQSHtx";
	dkim-atps=neutral
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com
 [209.85.208.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A7CA10EAEA
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 15:36:15 +0000 (UTC)
Received: by mail-ed1-f47.google.com with SMTP id
 4fb4d7f45d1cf-6a0cb6e96dcso4828307a12.0
 for <dri-devel@lists.freedesktop.org>; Tue, 04 Aug 2026 08:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785857774; x=1786462574; darn=lists.freedesktop.org;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ksBlfHiQymAuiEvSzpwhdyj7GzYzB5CWn+8bkyQnsf0=;
 b=h2CQSHtxLe/6RR0ALWc3sG6U3wH8CyliioDHtkdtIOSOZNlrUTrH+0GO86v10uytuk
 ZYLDoEhyRfALWeFQmsL+Wji2yB+4EZImy8yqHALIyEhRx8SBmuz0EzML1RDaW0RU03eS
 m7LUWlRHTJpeZSm32CqzVxeoGruVDme4DPeSNZb/ceF2TON4rt3SFnV+NHGvi6Zx6dr0
 FLgagydZWQs2O6tt7YluOXusaOQWUqP6hy+aK+vFABT2qEz12n/0xoqs4h00gng/HimZ
 GaCHnirG19HfK9pPXhaJ95cv6Wwufkm8zCtZATfMcTq6HP8AcepYg2MziiwKfojJyaDV
 bmdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785857774; x=1786462574;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ksBlfHiQymAuiEvSzpwhdyj7GzYzB5CWn+8bkyQnsf0=;
 b=DXcJ5f/zLgZ6zTOAt34smGiUIpJpmbHRciCtpt1uvVR/7X0F7edDVfyE6aYMOk7ylu
 pG//wM+ftKPDS9iBquhie8KTFmUmUMjLND2/0pd/a9IidOyMLAmvo0285WgLl8HN8D4K
 fGn0BUiw8tr5DnvJ5zcAW8qmcUhn7VV7PybMUPv1qdNj9p9gYzS87yyWQcSZfU1T2K2z
 r5buiJOF4Eeb87w4tNNe7Cn/4C4LITKabop/JRzHqfuHYzKm5JsHjaRH8knNmPo9ZDfB
 Lrp1vg3FOrPjWW9EfDSw2NvdfQdn6aE8zIlnsKLR50C9AaYWGDn19gbKLtEb+6vzcCwz
 nURw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpniri1tBQ32r3D+6BhNNg3cN7g07N3h/BlxoJBYBHtuklG3riQ2kZYdavyGgpBrqvH/LhfX8gq41c=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxlQyULX7fxeCCxmbcr1YN/aOISfaFd7RzYnEmoxZirz84TPyqn
 LtQlWnRY98bPqOy6kQ+JENqsSbPki216woPNyg9W+lN5Sbi0ux5uItJw
X-Gm-Gg: AR+sD12pj8VdJOrr8GgccFRJSL6e2ZigfGC4PGnYjo7S3eLCdvVdf7oBfY1uvdgAKKZ
 24gmFs4C/PB+rR1h8YfeRjQtJit4sJqdYM6QpsMvaolTCv5y8ZPlRpXI05mgNfbJGfqnVMYfbSx
 leiSs4HTdNpQiZ/7NcRikrUsuAi5VmQkaOVOKpLWjOTvoWtOW7pV3YruDph1owyrDGNUIjIN3jf
 AXLlVhAU6ZRRGu23tXTCXecHHIP/3/qwhIgVz847AfJ/kYHUmWluqfqofAtgBef4So0Cp+ZX/Do
 2KG3cfMwgEhHpdvXkPhqE6M40kd5Y067tdMAdpeaFvNB2zO1ajDUIf5B4tC5Pr4E8Y/uJu8kV1c
 sYlUoVrtwCzM7kw8zvk4n3vrr30mZOBfeR/Xs3xqFU2FYHYf3Jnn/Ii3/m0EG4m6FuP6g3qLITf
 KIGhIWAz9rNFaf+ZHP2Yepuj0KU91YvtjVSnEsmwJ+7bLHVbfCA8yhEGZRopAeN/l20wBPyXrf3
 ouHkfV2VqSskFyZBBySk8hcjAZ+dD6L4AzH
X-Received: by 2002:a05:6402:4541:b0:6a0:a505:1b54 with SMTP id
 4fb4d7f45d1cf-6a0a7ca981bmr10891559a12.16.1785857773324; 
 Tue, 04 Aug 2026 08:36:13 -0700 (PDT)
Received: from timur-hyperion.localnet (5401D2B5.dsl.pool.telekom.hu.
 [84.1.210.181]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a1462c4f8fsm265025a12.29.2026.08.04.08.36.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 08:36:11 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: Maarten Lankhorst <dev@lankhorst.se>, Maxime Ripard <mripard@kernel.org>, 
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 Michal =?UTF-8?B?S291dG7DvQ==?= <mkoutny@suse.com>,
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Tvrtko Ursulin <tursulin@ursulin.net>,
 Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
 Natalie Vock <natalie.vock@gmx.de>
Cc: cgroups@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: Re: [PATCH v8 0/6] cgroup/dmem,
 drm/ttm: Improve protection in contended cases
Date: Tue, 04 Aug 2026 17:36:07 +0200
Message-ID: <lpofhPXuQVOAKGLqOkO7sA@gmail.com>
In-Reply-To: <20260804-dmemcg-aggressive-protect-v8-0-07af96681bf8@gmx.de>
References: <20260804-dmemcg-aggressive-protect-v8-0-07af96681bf8@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Tuesday, August 4, 2026 10:25:15=E2=80=AFAM Central European Summer Time=
 Natalie=20
Vock wrote:
> Hi all,
>=20
> I've been looking into some cases where dmem protection fails to prevent
> allocations from ending up in GTT when VRAM gets scarce and apps start
> competing hard.
>=20
> In short, this is because other (unprotected) applications end up
> filling VRAM before protected applications do. This causes TTM to back
> off and try allocating in GTT before anything else, and that is where
> the allocation is placed in the end. The existing eviction protection
> cannot prevent this, because no attempt at evicting is ever made
> (although you could consider the backing-off as an immediate eviction to
> GTT).
>=20
> This series tries to alleviate this by adding a special case when the
> allocation is protected by cgroups: Instead of backing off immediately,
> TTM will try evicting unprotected buffers from the domain to make space
> for the protected one. This ensures that applications can actually use
> all the memory protection awarded to them by the system, without being
> prone to ping-ponging (only protected allocations can evict unprotected
> ones, never the other way around).
>=20
> The first two patches just add a few small utilities needed to implement
> this to the dmem controller. The other patches are the TTM implementation:
>=20
> "drm/ttm: Be more aggressive..." decouples cgroup charging from resource
> allocation to allow us to hold on to the charge even if allocation fails
> on first try, and adds a path to call ttm_bo_evict_alloc when the
> charged allocation falls within min/low protection limits.
>=20
> "drm/ttm: Use common ancestor..." is a more general improvement in
> correctly implementing cgroup protection semantics. With recursive
> protection rules, unused memory protection afforded to a parent node is
> transferred to children recursively, which helps protect entire
> subtrees from stealing each others' memory without needing to protect
> each cgroup individually. This doesn't apply when considering direct
> siblings inside the same subtree, so in order to not break
> prioritization between these siblings, we need to consider the
> relationship of evictor and evictee when calculating protection.
> In practice, this fixes cases where a protected cgroup cannot steal
> memory from unprotected siblings (which, in turn, leads to eviction
> failures and new allocations being placed in GTT).
>=20
> Thanks,
> Natalie
>=20
> Signed-off-by: Natalie Vock <natalie.vock@gmx.de>

Very nice work!

Reviewed-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>

for the whole series.

> ---
> Changes in v8:
> - Fix a few Sashiko complaints
> - Link to v7:
> https://patch.msgid.link/20260721-dmemcg-aggressive-protect-v7-0-97c4b101=
43
> 15@gmx.de
>=20
> Changes in v7:
> - Fix incorrect refcounting/locking around dmem_cgroup_common_ancestor
>   (Cascardo)
> - Rebase on latest drm-misc-next
> - Link to v6:
> https://lore.kernel.org/r/20260313-dmemcg-aggressive-protect-v6-0-7c71cc1=
49
> 2db@gmx.de
>=20
> Changes in v6:
> - Rename dmem_cgroup_common_ancestor to dmem_cgroup_get_common_ancestor
>   (Maarten)
> - Use ttm_bo_alloc_at_place in eviction cb as well (Tvrtko)
> - Clean up the more aggressive eviction logic (Tvrtko)
> - Link to v5:
> https://lore.kernel.org/r/20260302-dmemcg-aggressive-protect-v5-0-ffd3a26=
02
> 309@gmx.de
>=20
> Changes in v5:
> - Added cgroup_common_ancestor helper to use with
>   dmem_cgroup_common_ancestor (Tejun)
> - Note: "drm/ttm: Use common ancestor..." needed minor changes since
>   dmem_cgroup_common_ancestor now grabs a reference to the ancestor
>   pool which needs to be dropped after use
> - Removed extraneous whitespaces in "drm/ttm: Split cgroup charge..."
>   and unnecessary changes done in "drm/ttm: Extract code..." (Tvrtko)
> - Applied a comment from v3 about below_low not needing to be
>   initialized in "drm/ttm: Be more aggressive..." (Tvrtko)
> - Fixed uncharging the cgroup on allocation failure (Tvrtko)
> - Fixed a typo in the message of "drm/ttm: Split cgroup charge..."
>   (Tvrtko)
> - Added case in ttm_bo_evict_cb for when charging fails, since we need
>   to retry the charge (found myself)
> - Link to v4:
> https://lore.kernel.org/r/20260225-dmemcg-aggressive-protect-v4-0-de847ab=
35
> 184@gmx.de
>=20
> Changes in v4:
> - Split cgroup charge decoupling and eviction logic changes into
>   separate commits (Tvrtko)
> - Fix two cases of errno handling in ttm_bo_alloc_place and its caller
>   (Tvrtko)
> - Improve commit message/description of "drm/ttm: Make a helper..." (now
>   "drm/ttm: Extract code...") (Tvrtko)
> - Documentation improvements for new TTM eviction logic (Tvrtko)
> - Formatting fixes (Tvrtko)
> - Link to v3:
> https://lore.kernel.org/r/20251110-dmemcg-aggressive-protect-v3-0-219ffcf=
c5
> 4e9@gmx.de
>=20
> Changes in v3:
> - Improved documentation around cgroup queries and TTM eviction helpers
>   (Maarten)
> - Fixed up ttm_alloc_at_place charge failure logic to return either
>   -EBUSY or -ENOSPC, not -EAGAIN (found this myself)
> - Link to v2:
> https://lore.kernel.org/r/20251015-dmemcg-aggressive-protect-v2-0-36644fb=
4e
> 37f@gmx.de
>=20
> Changes in v2:
> - Factored out the ttm logic for charging/allocating/evicting into a
>   separate helper to keep things simpler
> - Link to v1:
> https://lore.kernel.org/r/20250915-dmemcg-aggressive-protect-v1-0-2f3353b=
fc
> dac@gmx.de
>=20
> ---
> Natalie Vock (6):
>       cgroup/dmem: Add queries for protection values
>       cgroup,cgroup/dmem: Add (dmem_)cgroup_common_ancestor helper
>       drm/ttm: Extract code for attempting allocation in a place
>       drm/ttm: Split cgroup charge and resource allocation
>       drm/ttm: Be more aggressive when allocating below protection limit
>       drm/ttm: Use common ancestor of evictor and evictee as limit pool
>=20
>  drivers/gpu/drm/ttm/ttm_bo.c       | 223
> ++++++++++++++++++++++++++++++++----- drivers/gpu/drm/ttm/ttm_resource.c =
|=20
> 51 ++++++---
>  include/drm/ttm/ttm_resource.h     |   6 +-
>  include/linux/cgroup.h             |  21 ++++
>  include/linux/cgroup_dmem.h        |  25 +++++
>  kernel/cgroup/dmem.c               | 103 +++++++++++++++++
>  6 files changed, 383 insertions(+), 46 deletions(-)
> ---
> base-commit: 44e9eb5a762142a4aa46c0b5da7c39bfeb78910e
> change-id: 20250915-dmemcg-aggressive-protect-5cf37f717cdb
>=20
> Best regards,
> --
> Natalie Vock <natalie.vock@gmx.de>




