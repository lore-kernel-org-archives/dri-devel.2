Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC919C5DF6D
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 13:55:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 111D610E5E6;
	Wed, 19 Aug 2026 13:55:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nxN4P6vq";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 342CC10E14A;
 Wed, 19 Aug 2026 13:54:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1D11E43E14;
 Wed, 19 Aug 2026 13:54:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0CE01F000E9;
 Wed, 19 Aug 2026 13:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787147693;
 bh=EClGM/zR2hwBguFJCprrRZowMgH49jdBQXZX5/JZVuU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nxN4P6vqwlLcjI+RmTG+efEGqOZh/VE63+QD2mhF9V1QUCBeQds8+oMyuCoZC8u+r
 A5YUeh1zfW6ebbwF8tOTf+XJui5TNcL4pIym09hYbbH57TmOHG7n2EmYTgTaL3jzmG
 x8uD5WgYntwl0Az8m/PHM+bK0uv1xqLU9HRlg5mPm/LHHNuv/GsCuLp5oJzNV4pMyb
 dpbdAGZZ4r3Np8AllKekMqdJHSAiT5YuL+zcrF7SVuI/CG9ZM8cWYAu/14IL+w7Wtj
 uQcxkncFaVTZgsBQzxyHpYPOsUc7ABtFX+Fm17/n7RhLD8raKSt15HBvnQVJ5Edk0p
 3zWRCeSN5+klw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/5] drm/ras: Introduce error threshold
To: "Raag Jadav" <raag.jadav@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260818135304.497098-3-raag.jadav@intel.com>
References: <20260818135304.497098-1-raag.jadav@intel.com>
 <20260818135304.497098-3-raag.jadav@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 13:54:52 +0000
Message-Id: <20260819135452.C0CE01F000E9@smtp.kernel.org>
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
- [High] The drm_ras_node pointer returned by xa_load() is used without RCU=
 protection or locking, leading to a Use-After-Free if the node is concurre=
ntly unregistered.
--

--- Patch [2]: [PATCH v6 2/5] drm/ras: Introduce error threshold ---
commit 4fde8387621a92c01fa74b45df16200c6e02bd2a
Author: Raag Jadav <raag.jadav@intel.com>

drm/ras: Introduce error threshold

Add get-error-threshold and set-error-threshold command support which
allows querying/setting error threshold of the counter. Threshold in RAS
context means the number of errors the hardware is expected to accumulate
before it raises them to software.

> diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
> --- a/drivers/gpu/drm/drm_ras.c
> +++ b/drivers/gpu/drm/drm_ras.c
[ ... ]
> +static int get_node_error_threshold(u32 node_id, u32 error_id, const cha=
r **name, u32 *threshold)
> +{
> +	struct drm_ras_node *node;
> +
> +	node =3D xa_load(&drm_ras_xa, node_id);
> +	if (!node)
> +		return -ENOENT;
> +
> +	if (!node->query_error_threshold)
> +		return -EOPNOTSUPP;
> +
> +	if (error_id < node->error_counter_range.first || error_id > node->erro=
r_counter_range.last)
> +		return -EINVAL;
> +
> +	return node->query_error_threshold(node, error_id, name, threshold);

[Severity: High]
This is a pre-existing issue, but can this cause a use-after-free?

The drm_ras_node pointer returned by xa_load() is used without RCU protecti=
on=20
or locking. If the node is concurrently unregistered and freed, for example=
=20
during driver unbind, the node memory could be freed before we invoke=20
node->query_error_threshold(). This would result in a use-after-free on the=
=20
node pointer.

> +}
> +
> +static int set_node_error_threshold(u32 node_id, u32 error_id, u32 thres=
hold)
> +{
> +	struct drm_ras_node *node;
> +
> +	node =3D xa_load(&drm_ras_xa, node_id);
> +	if (!node)
> +		return -ENOENT;
> +
> +	if (!node->set_error_threshold)
> +		return -EOPNOTSUPP;
> +
> +	if (error_id < node->error_counter_range.first || error_id > node->erro=
r_counter_range.last)
> +		return -EINVAL;
> +
> +	return node->set_error_threshold(node, error_id, threshold);

[Severity: High]
This is a pre-existing issue, but does this suffer from the same concurrent=
=20
unregistration race?=20

If the node pointer from xa_load() is freed before we call=20
node->set_error_threshold(), this dereference could also access freed memor=
y.

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818135304.4970=
98-1-raag.jadav@intel.com?part=3D2
