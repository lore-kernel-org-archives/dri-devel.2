Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC84ECA5FC5
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 22:24:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A73410E297;
	Wed, 30 Sep 2026 22:24:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ECVXCgOD";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A582010E297
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 22:24:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7CC1143811;
 Wed, 30 Sep 2026 22:24:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E2DD1F000FF;
 Wed, 30 Sep 2026 22:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790807067;
 bh=ZG8bC5kH+mnTwQmBknY7tt/+iynOnhcYvEELtpShYiU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ECVXCgODznKyNrZs81iI6n7b5ZBGtlB9JwLTOUwer1Q2WhsmY3cK3XZmA48HJ/zQu
 cGmgGkVD3BbKBnrKirn/V/9iOMaziSlx8ntJ/y/cR9aZ7iQTU3Zaxdu8yiXXBsfFxx
 zsV56do8q1h5aOXrRUrab2EJ/mLhdBz2yZt8xofUGE7R+R06bY1N98fQqG8ADxEbN1
 V/qvZ3W6tO98WqVX+c8BdvIw+dr8zp+XGDm2omuG8rMzpPyBvHbZvqTM+Vt4JFiqw5
 94rnSouO5pT8CmymX8B3C57xOowCweAGEfQWHyekr0G9feTct3hWx1Vhs7aXJWMKVg
 VHsxVh1BU0S4g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/qxl: return -ENODEV for unsupported revisions
To: "Matheus Alves de Almeida" <matheus.aalmeida@inf.ufrgs.br>
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev, "Eugenio
 Perez" <eperezma@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
In-Reply-To: <20260930222214.69443-1-matheus.aalmeida@inf.ufrgs.br>
References: <20260930222214.69443-1-matheus.aalmeida@inf.ufrgs.br>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 22:24:26 +0000
Message-Id: <20260930222427.0E2DD1F000FF@smtp.kernel.org>
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

> The qxl driver currently returns -EINVAL when the emulated qxl revision
> is too old. This is not a driver initialization failure but rather a
> match rejection, which should return -ENODEV.
>=20
> Change the value returned when the qxl revision is below 4 to -ENODEV.
> Switch the xf86-video-qxl suggestion log to be info level, as this is
> not an error.
>=20
> Fixes: f64122c1f6ad ("drm: add new QXL driver. (v1.4)")
> Signed-off-by: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930222214.6944=
3-1-matheus.aalmeida@inf.ufrgs.br?part=3D1

