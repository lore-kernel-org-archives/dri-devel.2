Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD975C88E53
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 07:48:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDD2810FAC3;
	Tue, 15 Sep 2026 07:48:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ADrPzxim";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E61E010FAC3
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 07:48:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6A460600D1;
 Tue, 15 Sep 2026 07:48:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D323E1F000FF;
 Tue, 15 Sep 2026 07:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789458501;
 bh=Oei46MargQ0iqhuuujiA27xfsU3tzyY18TFZ2Wr4Lo8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ADrPzximHpC9EhkGcPNcT6YSpJ36A6I7JFiBBxysDSh9PWIxmBF+CNg+jPbzVLKJg
 TW4ASLAZmuoX31beaN2QAMwYfsZyN2LxiBnPnu6G9PwsnnK1vu3TNw97mcOswjWwXr
 5Vxe79Dv3VzwH/BslB+id788mR6vGtAgTuoSDoLGCVZ51yZBBZmDWmjdNl6rKzRPi4
 4DXjnY/tADhWD5IVQQs15vH4KvDlYEIfbWdR6tPeaBx47Kormj/KMWSWBsatjFtObw
 cVvz2Dpry3lCwijxyxDRnhIIaUmgrUA8d8mINowOCdJPrqWgPV+S29p5iSEIxobJfU
 CczEAblrB5S1w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/4] drm/virtio: fix object leaks in
 virtio_gpu_resource_create_blob_ioctl()
To: "Junrui Luo" <moonafterrain@outlook.com>
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev, "Eugenio
 Perez" <eperezma@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
In-Reply-To: <20260915-fixes-v2-3-a0d799e4db66@outlook.com>
References: <20260915-fixes-v2-0-a0d799e4db66@outlook.com>
 <20260915-fixes-v2-3-a0d799e4db66@outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 07:48:20 +0000
Message-Id: <20260915074820.D323E1F000FF@smtp.kernel.org>
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

> From: Junrui Luo <moonafterrain@outlook.com>
>=20
> virtio_gpu_resource_create_blob_ioctl() calls drm_gem_object_release() on
> both the virtio_gpu_resource_assign_uuid() and drm_gem_handle_create()
> error paths instead of dropping the reference it owns, so
> obj->funcs->free() never runs and the virtio_gpu_object, the resource id
> and the host-side resource are leaked.
>=20
> Use drm_gem_object_put() instead.
>=20
> Fixes: 897b4d1acaf5 ("drm/virtio: implement blob resources: resource crea=
te blob ioctl")
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Junrui Luo <moonafterrain@outlook.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-fixes-v2-0=
-a0d799e4db66@outlook.com?part=3D3

