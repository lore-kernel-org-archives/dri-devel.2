Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66B63C9830E
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 10:04:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0C2810F412;
	Thu, 24 Sep 2026 10:04:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Tv7KPr95";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F29510F412
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 10:04:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 87432600AA;
 Thu, 24 Sep 2026 10:04:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F19D11F00893;
 Thu, 24 Sep 2026 10:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790244276;
 bh=MHiXcNsBxy839ksHAvRHdUeWlT/N2Ox4T8wUTGeSj8E=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Tv7KPr95dzpyTyv5wgpuiMhLmqH6LwTrZwhmtwIFyu/NHiPhCs1CrSlKgnpEnMf+Y
 lFwjI0+auncujd/IqIJdFSysZREldSf0VESMvs4fCh2PsYIAe2qRtWeIGcGc63eySu
 nJ6LFdEsWKdqUQXlVr1KZDq3aFZQf5spZTj+AdHlFwruQIH4+qWR+bJY40hVc++kuF
 qTwg5Dl5Dysdq0dNWLj0AvpaBZsP4n6DvdjzWj+utuYTSe2bV87XYznBaHnPuFampi
 BdGzUE1GC/eqQsmUhl2UCi4KmWcyIxvP5TcxDmC3PoNTHpxkC1HVPjWTeZ0GUpFtkl
 IyWIF7BLa1edw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v9 4/4] drm/virtio: wire blob ioctl creation to
 userptr objects
To: "Honglei Huang" <honghuan@amd.com>
Cc: "Eugenio Perez" <eperezma@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux.dev
In-Reply-To: <20260924095556.1326164-5-honghuan@amd.com>
References: <20260924095556.1326164-1-honghuan@amd.com>
 <20260924095556.1326164-5-honghuan@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 10:04:35 +0000
Message-Id: <20260924100435.F19D11F00893@smtp.kernel.org>
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

> Integrate userptr into the blob resource creation ioctl.
>=20
> - A non-zero userptr selects virtio_gpu_userptr_create()
> - Reject userptr unless blob_mem is VIRTGPU_BLOB_MEM_GUEST
> - Reject VIRTGPU_BLOB_FLAG_USE_READONLY unless the device
>   advertised VIRTIO_GPU_F_BLOB_READONLY
> - Advertise VIRTGPU_PARAM_USERPTR and VIRTGPU_PARAM_BLOB_READONLY
> - Add VIRTIO_GPU_F_BLOB_READONLY to the driver's features[] array
>=20
> virtio_has_feature() routes device-specific feature bits through
> virtio_check_driver_offered_feature(), which calls BUG() when the
> driver queries a bit it never declared in features[]. The
> VIRTIO_GPU_F_BLOB_READONLY probe added to virtio_gpu_init() hit
> exactly that: every probe crashed regardless of host support because
> the bit was missing from features[]. Registering it there fixes the
> crash.
>=20
> Signed-off-by: Honglei Huang <honghuan@amd.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924095556.1326=
164-1-honghuan@amd.com?part=3D4

