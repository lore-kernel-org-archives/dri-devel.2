Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D53CC88E45
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 14:55:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FAF010F658;
	Fri, 11 Sep 2026 14:55:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FjR9zfv4";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E5AC10F658
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 14:55:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1C48142E89;
 Fri, 11 Sep 2026 14:55:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B23C51F00899;
 Fri, 11 Sep 2026 14:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789138540;
 bh=Ehlxs4vtMgR9RcAlIZUqnFbAgU2juQBBekf61dpk1gE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=FjR9zfv4KmsnbMNjNP8zMHEVtTLrSZIKhwZoINZiiIWxAEvJ2hGhu6t7rV34Ww4Rt
 rScV7PUuqn+/Pzc/WY9c44DO7Jq5vMCDBdjMg1KEZh2/AYGexor8ZJnZAo8LfmtnYP
 i0Il5CZkeZfP9UIlCjbl1xDKn+Zn2Q0WfCXIR46PDdkLRb9v2LVxfCzYm6UeAjfTqa
 evuksuBhBTzGvFDf0j0bUvGcf0WeX0sC/TStxcU2IzVw/t4CEW9mBLc2/u94yg5SNU
 +6cVp8QaeX76boFziDXLC4kCsnx6jeNueZIc+Afm7CTIrYPFQYtIYmQJkLVNO6ox1D
 4+ovlQYjqrzfQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] Revert "drm/virtio: Allow importing prime buffers
 when 3D is enabled"
To: "Dmitry Osipenko" <dmitry.osipenko@collabora.com>
Cc: "Eugenio Perez" <eperezma@redhat.com>, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>
In-Reply-To: <20260911144204.2089401-1-dmitry.osipenko@collabora.com>
References: <20260911144204.2089401-1-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 14:55:39 +0000
Message-Id: <20260911145539.B23C51F00899@smtp.kernel.org>
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

> Guest userspace may import udmabuf to vrend. Vrend doesn't support guest
> blobs, and thus, further 3d operations with the imported blob are failing.
> Typical scenario of the problem shown with mouse cursor RGBA image import=
ed
> into virtio-gpu, which previously was rejected by virtio-gpu driver.
> Revert enabling guest blobs importing into vrend to fix the regression.
>=20
> Link: https://gitlab.freedesktop.org/virgl/virglrenderer/-/work_items/674
> Fixes: df4dc947c46b ("drm/virtio: Allow importing prime buffers when 3D i=
s enabled")
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911144204.2089=
401-1-dmitry.osipenko@collabora.com?part=3D1

