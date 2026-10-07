Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9101CA6002
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 22:26:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E354410E680;
	Wed,  7 Oct 2026 22:26:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="h+eq8uQe";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E588410E680
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 22:26:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DEEC1601DE;
 Wed,  7 Oct 2026 22:26:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A89B1F000FF;
 Wed,  7 Oct 2026 22:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791412013;
 bh=wdpFw+0FWg90J2bNCbp3S6jUX948ir6CAlMfviI4umQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=h+eq8uQepAAe/GVD9dYfwVGCrzH2nFzEQnpNRtB1l3DwKYmCnF5Vf+pedZs9HLjgN
 cKhxs/lh/EuJgXGW//GIvmCgqANwuxB59KMpkfOg+xnEi+f1zrBzS8dqbY798EBHiM
 wcyLPGFY54k8JQ6VlXywszA7uRb2T7kxGx8xAwhH3iJYtT9MkE/opd8csAuYlRqRQ+
 ZOJ4jyOHu2vgSabRNMlGraS2lOSVK9LSYFryUWoeuZqKgkKM/L0qLvyDXnCwuf9ifc
 MXwzRL74T0wlDa6smD7vv2y+Y+Go+oSCeK7PZyLcBv8IUCwjX2Nw7Pqd1ZQtMvnGXC
 7UYU5RYya+OLw==
Message-ID: <sashiko-outbox-163411@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] Revert "drm/virtio: Add pixel blend mode property to
 cursor plane"
To: "Dmitry Osipenko" <dmitry.osipenko@collabora.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, dri-devel@lists.freedesktop.org,
 "Eugenio Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev
In-Reply-To: <20261007222244.295186-1-dmitry.osipenko@collabora.com>
References: <20261007222244.295186-1-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 22:26:52 +0000
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

> The cursor blending mode was added twice because the same change was
> applied by accident from different patches. Revert the second patch.
>=20
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Link: https://lore.kernel.org/dri-devel/ce84d3d2-e78b-4939-aecf-9ef7267bd=
42a@samsung.com/
> Fixes: 6947b78df4d2 ("drm/virtio: Add pixel blend mode property to cursor=
 plane")
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261007222244.2951=
86-1-dmitry.osipenko@collabora.com?part=3D1

