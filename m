Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0B71C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 07:21:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38FE610E76E;
	Mon,  6 Jul 2026 07:21:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DuGV/ub5";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A7E510E76E
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 07:21:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 33D25416B3;
 Mon,  6 Jul 2026 07:21:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9CAF1F000E9;
 Mon,  6 Jul 2026 07:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783322484;
 bh=4AtxVpE5vkcVI7wPrl6wVHFTMFi0ZpAtzSnzFk30tko=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DuGV/ub5UAWkYxI/PNuAQN9RRKA3Va1L+/zVuABSYx16gjyN68NdMF+dKSobxaNT8
 ZbTyiKfhomGCoBXGYsiQBTjjUlmDpXWmkxL6HaBPcYJJXjV1yx8oylz6F2IoQ1tgXZ
 H8vasH+x/qOG393mr47GxaRVazI4SmIxGZn68qSN6OdFlbBDm4emEtN5+k+0MXnEMc
 6XtCkj15BQazA8LbC2l6dQ5kSfxiBcpYEFITQM6zMrbLok67NYsa9gx96wgsGHXucB
 +/XSSEfBNlv5jK4QxN3r04S6QlsPZfynk2QHSl9uA/bgoKF3iu115Xwhs6EceUwSNb
 O7TQgCzbe+zEw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/i915/guc: Return NULL for missing multi-lrc parent
To: "Linmao Li" <lilinmao@kylinos.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260706071412.559909-1-lilinmao@kylinos.cn>
References: <20260706071412.559909-1-lilinmao@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 07:21:23 +0000
Message-Id: <20260706072123.E9CAF1F000E9@smtp.kernel.org>
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
- [Medium] Uninitialized stack memory dereference in logical_sort().
--

commit 6153c2c3d514c7a85b553bf0d2bcce6d2b569814
Author: Linmao Li <lilinmao@kylinos.cn>

drm/i915/guc: Return NULL for missing multi-lrc parent

This commit updates multi_lrc_create_parent() to return NULL instead of
ERR_PTR(0) when there are not enough engines, making the non-error path
explicit.

> diff --git a/drivers/gpu/drm/i915/gt/uc/selftest_guc_multi_lrc.c b/driver=
s/gpu/drm/i915/gt/uc/selftest_guc_multi_lrc.c
> index 28e8a092f4e7d..18077801b2e60 100644
> --- a/drivers/gpu/drm/i915/gt/uc/selftest_guc_multi_lrc.c
> +++ b/drivers/gpu/drm/i915/gt/uc/selftest_guc_multi_lrc.c
> @@ -44,7 +44,7 @@ multi_lrc_create_parent(struct intel_gt *gt, u8 class,
>  	}
> =20
>  	if (i <=3D 1)
> -		return ERR_PTR(0);
> +		return NULL;
> =20
>  	logical_sort(siblings, i);

[Severity: Medium]
This is a pre-existing issue, but does logical_sort() dereference
uninitialized stack memory here?

In multi_lrc_create_parent(), the local array siblings is allocated with si=
ze
MAX_ENGINE_INSTANCE + 1 but only populated up to index 'i' before being
passed to logical_sort().

Inside logical_sort(), the inner loop iterates up to MAX_ENGINE_INSTANCE + 1
instead of num_engines, accessing elements that were never initialized:

static void logical_sort(struct intel_engine_cs **engines, int num_engines)
{
	...
	for (i =3D 0; i < num_engines; ++i)
		for (j =3D 0; j < MAX_ENGINE_INSTANCE + 1; ++j) {
			if (engines[j]->logical_mask & BIT(i)) {
				...
			}
		}
	...
}

Could this lead to a wild pointer dereference during selftest execution=20
whenever j >=3D num_engines?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706071412.5599=
09-1-lilinmao@kylinos.cn?part=3D1
