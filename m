Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BD5CC982D2
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 02:19:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4953710E7C6;
	Fri, 18 Sep 2026 02:19:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Z2KH9j8M";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68FAA10E7C6
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 02:19:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1CEA341207;
 Fri, 18 Sep 2026 02:19:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA3A21F000FF;
 Fri, 18 Sep 2026 02:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789697995;
 bh=FZ3sKjPiL35u4euseu+9abNWPjFUoUM67jyRj7sdo1Q=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Z2KH9j8M3yWhQ5uMKp474GySQeEs+jgbbT7354eWITyPLCl1aqmkvp6e9UXYXf27M
 QOnw9f+IL+Omf6cSkn2NZjat52gxCkfQ3AYkqvjK1EotndhmTIru3+K9IrNKcmMyCB
 fltaz2u8K/G/DG47J9wBwcXMYON2idhgh95Mg7tjkgNJq+sQf9htIndffUYIsTpvbP
 wAh3gABo1GYbHLnXIWPVTfZngdjlFUUFvPUaP/ulfz+DHmoEPLSC85S9lMErqxyHI1
 05aSIOPsSkJFRt2FyT42MADAJTWkQJ8n5TW2aEAWMdYX5mFyOyLzpx43iBZAuKjVCD
 w33NQ4nic8/Vw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/4] drm/virtgpu api: add blob userptr resource
To: "Honglei Huang" <honghuan@amd.com>
Cc: "Eugenio Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev,
 "Michael S. Tsirkin" <mst@redhat.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20260918021154.1432154-3-honghuan@amd.com>
References: <20260918021154.1432154-1-honghuan@amd.com>
 <20260918021154.1432154-3-honghuan@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 02:19:54 +0000
Message-Id: <20260918021954.AA3A21F000FF@smtp.kernel.org>
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

> Add DRM ioctl flags and a userptr address field so userspace can
> request a blob backed by an existing process mapping.
>=20
> UAPI changes:
> - Add guest-only VIRTGPU_BLOB_FLAG_USE_USERPTR and
>   VIRTGPU_BLOB_FLAG_USERPTR_RDONLY flags
> - Add a userptr field to drm_virtgpu_resource_create_blob
>=20
> These flags select guest pin behavior in the ioctl. They are not
> part of the virtio CREATE_BLOB wire ABI, so mask them out in
> virtio_gpu_cmd_resource_create_blob().
>=20
> Signed-off-by: Honglei Huang <honghuan@amd.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918021154.1432=
154-1-honghuan@amd.com?part=3D2

