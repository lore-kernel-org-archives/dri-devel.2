Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1D28C88E58
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 12:54:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C13F410F5E7;
	Fri, 11 Sep 2026 12:54:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nZeKQIG2";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11BDF10F5E4;
 Fri, 11 Sep 2026 12:54:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5A1906020C;
 Fri, 11 Sep 2026 12:54:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFC8A1F000FF;
 Fri, 11 Sep 2026 12:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789131268;
 bh=XDQh51NcC8m5ick0utcnmIljTIdDpBigjrTxnTdj2E8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nZeKQIG2kbvCp89PeorFoW8sECJ2PQe9c6GdJlamOR4Tmq5pEh68bXvE7d7QmvhPw
 98Yc1UjiMxsl7YsZWs5vbHI5NSAuUhqLTmN+p1v/sICfeLNo3QkVPzsaHOmaiDAjJV
 UIGAh1y/gvKRFjF0IDVgnAW2V7wDLu32Byt6+uI3wvEqrxjUv/iZbwhTCOlA+5DzMX
 I48QmGYwgXB2S+2NznO7ao2TWREKT2xJVeKGg5m4ZHFTTmM0GIsVDkphH6/FlAo+SA
 8DOkn5iV0iO5Kb35Pipaz5nm0U8DngRIicw3PM3ZDyRdZ8wbfmssjmHlTEXyMyX1yH
 bDKwlgZRR9rYA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 01/14] drm/panic: Do not use un-escaped URL as format
 string
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: linux-hyperv@vger.kernel.org, "Eugenio Perez" <eperezma@redhat.com>,
 intel-gfx@lists.freedesktop.org, ojeda@kernel.org,
 virtualization@lists.linux.dev, imx@lists.linux.dev,
 wsa+renesas@sang-engineering.com, gary@garyguo.net,
 dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org, "Michael
 S. Tsirkin" <mst@redhat.com>, Frank.Li@kernel.org
In-Reply-To: <20260911124540.279841-2-tzimmermann@suse.de>
References: <20260911124540.279841-1-tzimmermann@suse.de>
 <20260911124540.279841-2-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 12:54:25 +0000
Message-Id: <20260911125425.EFC8A1F000FF@smtp.kernel.org>
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

> Replace the direct use of DRM_PANIC_SCREEN_QR_CODE_URL in snprintf()
> with a %s conversion specifier. Avoids a possible vulnerabilty from
> a crafted URL string.
>=20
> As the attacker needs to control the kernel at the Kconfig level, the
> potential for an exploit is likely low.
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911124540.2798=
41-1-tzimmermann@suse.de?part=3D1

