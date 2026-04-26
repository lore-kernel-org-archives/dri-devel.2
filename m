Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5772FF885D
	for <dri-devel@archiver.kernel.org>; Sun, 26 Apr 2026 16:59:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E494B10E25A;
	Sun, 26 Apr 2026 16:59:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=emersion.fr header.i=@emersion.fr header.b="Q2eC4HQL";
	dkim-atps=neutral
Received: from mail-4323.protonmail.ch (mail-4323.protonmail.ch [185.70.43.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 525D710E25A
 for <dri-devel@lists.freedesktop.org>; Sun, 26 Apr 2026 16:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail; t=1777222765; x=1777481965;
 bh=tUDUyDOnCOqPoW+O+WZwKRHRLeRqAPThkvPuVS5TBX0=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=Q2eC4HQLRpZSF7fKkw2jeTRA1Grf+H9SotgXdn/xfVfVSyUsecMh2sbyIGhss4WJY
 5I4FsFw9AiJLGyqQmU1GSKm4dryeO6FPDhNKD71NJSv5XGutGnnklgA0991Wq6mOYQ
 FL7W7+7JqeiiGkbTjwYmq5SbX1h8HZiJou6GU3fb0F2J3jRVc0nexq8MNKTk0L9zt4
 xb2v7Ug7pxmgT0PkICq2Jy2dQIanD8cw/plhrDoFRzvnECLcTWSy8OigqVQhrCsm64
 dAyc+5JCp5dzNOha/nMzdDTpcaLeQtOtPc0ewnm/TFgLt0WXsMig5fr9X7zXu3EoJm
 DBlJB0luLKVfw==
Date: Sun, 26 Apr 2026 16:59:19 +0000
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
From: Simon Ser <contact@emersion.fr>
Cc: dri-devel@lists.freedesktop.org, Pekka Paalanen <ppaalanen@gmail.com>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Daniel Stone <daniel@fooishbar.org>
Subject: Re: [PATCH] drm/fourcc: document format naming scheme
Message-ID: <XUz08zbEN3acyjqze6qP6M8Mx2WdKet8WU6eVe9vF2XMr7vlYxEXNAy7qfbmi6V3STr5sLeU0Ew6_9MCm7VQFxHZg8zznLQ8etKUVbi-dLI=@emersion.fr>
In-Reply-To: <20260426164739.GE2964234@killaraus.ideasonboard.com>
References: <20260426151641.93763-1-contact@emersion.fr>
 <20260426164739.GE2964234@killaraus.ideasonboard.com>
Feedback-ID: 1358184:user:proton
X-Pm-Message-ID: d48cc7349b6266edda2777ceda7e20e167f6ec78
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

On Sunday, April 26th, 2026 at 18:47, Laurent Pinchart <laurent.pinchart@id=
easonboard.com> wrote:

> > + * Memory layout is always described in little-endian order.
>=20
> This sentence may be a bit vague, especially given that we have the
> DRM_FORMAT_BIG_ENDIAN() macro.

Right, that macro is almost never used=E2=80=A6 I see it only used for
XRGB1555 and RGB565. Someone recommended against using it, I don't
remember who.

See also:

 * Note that the DRM_FORMAT_BIG_ENDIAN flag should only be used in
 * case the format can't be specified otherwise, so we don't end up
 * with two values describing the same format.

> > + * - The first digit indicates chroma sub-sampling: 0 for 2x2, 2 for 2=
x1, 4 for
> > + *   none.
>=20
> We also have 4x4 and 4x1 sub-sampled formats, it would be good to
> document them.

Yeah, but these use a completely different scheme, like the NV family.
And then there's single-plane YUV formats, which are just the wild west.
Not sure how to document all of that=E2=80=A6
