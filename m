Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05216606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 18:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YVKGg/cB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60BA410E0E5;
	Fri, 27 Nov 2026 18:24:53 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A22BC10E0E5;
 Fri, 27 Nov 2026 18:24:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4849843DE5;
 Fri, 27 Nov 2026 18:24:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDE351F0089F;
 Fri, 27 Nov 2026 18:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795803887;
 bh=vmpHK1QD6YoMGBBIMHoP6V75eU9mOZsKKoltFILjgVA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=YVKGg/cBkrFGblrm7KK9N62aXsOd/JBgke0Vc+PesYlp+jJkx0nQ9MV+PQ434WNQR
 mRs28VLk88MFD7ZwHaGzGKn/MFvGEJpxYDi5/1Lw1XfFe2x3HXe+0DJFclyeRvu1Fz
 ZNbUNRZYUQ50LJ9xwmHlJEo6z3sKdnCiZdUv0ookfFAK08j1VTcWlGJVn9PSgtRyoe
 fjr0WpKdYBq3IAMI4SsIPopuQ6Rc882W/XDq5WmRYrz/p2TKGu5xpelzkKFAs2IBDR
 zlADJuYm17z5BWpHYpbksq6pzTgGVlCMISpV1d7wugRCn2QbzxM+spWc0czCMVdIym
 FZYRkO6ZrGGpg==
Message-ID: <sashiko-outbox-238067@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/3] drm/ras: Check the node type in node lookups
To: "Rodrigo Vivi" <rodrigo.vivi@intel.com>, dri-devel@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org
In-Reply-To: <20261127181750.806528-6-rodrigo.vivi@intel.com>
References: <20261127181750.806528-5-rodrigo.vivi@intel.com>
 <20261127181750.806528-6-rodrigo.vivi@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 18:24:46 +0000
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
- [Low] drm/ras: missing Fixes trailer for node type check in
  drm_ras_node_get()
--

commit 9258f81bad25ef1d7e2f5db2a77f4c65a38c081f
Author: Rodrigo Vivi <rodrigo.vivi@intel.com>

> drm/ras: Check the node type in node lookups
>
> drm_ras_node_get() returns a node of any type. The telemetry handlers
> check the type themselves, but the error-counter ones do not, so an
> error-counter operation on a telemetry node fails with -EOPNOTSUPP or
> walks its empty counter range, instead of reporting -ENOENT.
>
> Pass the expected type to drm_ras_node_get(), so a node of another
> type is not found, and drop the type checks of the telemetry handlers.
>
> Suggested-by: Riana Tauro <riana.tauro@intel.com>
> Acked-by: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
> Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

[Severity: Low]
Since commit c95c93b6e26c ("drm/drm_ras: Extend DRM RAS interface to
include telemetry nodes") allowed telemetry nodes in drm_ras_xa without
checking node->type in the error-counter handlers, should this include a
Fixes tag?

  Fixes: c95c93b6e26c ("drm/drm_ras: Extend DRM RAS interface to include te=
lemetry nodes")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127181750.8065=
28-5-rodrigo.vivi@intel.com?part=3D1
