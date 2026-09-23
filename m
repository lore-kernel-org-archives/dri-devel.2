Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5ABBC98302
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 13:59:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E56910F071;
	Wed, 23 Sep 2026 13:59:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nIhqG3tJ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E435010F071
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 13:59:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F16A8601FB;
 Wed, 23 Sep 2026 13:59:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C5DD1F000FF;
 Wed, 23 Sep 2026 13:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790171956;
 bh=ZGV+V//FpYtY++nf6j5+NnSlKWY3IBj7GjG+SG5yZ1k=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nIhqG3tJ66ws7/rX67sNMwmsGPT6MKuB4rH/0SsVdUxYycpOU5n8IhySu1PyGirfu
 LCnlc2BD2vVmZaWyO8l4InqduBoOmqbbtwsyjs5O3q/CPjHXVfjilDl9W+M1q+jPRu
 kuJoPPZxFIQhtjdyfvqjiZpx/b3SQpYkhfWmuj6fQY6uNojpNhY47ZWeANETktxgaO
 hiPAhxd6S8u256r9ScK4PAjDbYXEPt7Mm3pUIXANFzgd3Co68S7RwqLK1O/IZbPenx
 rR1ejnSqqVN+MCCUMA69oQqxp8x4uFCWKE07+3CLei99/nxyjyKU3dI15KfstBFfZy
 DvuroTftgp9Ew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/qxl: remove double page-size scaling in kmap
 fallback paths
To: "Aldo Ariel Panzardo" <qwe.aldo@gmail.com>
Cc: "Eugenio Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev,
 dri-devel@lists.freedesktop.org, "Michael S. Tsirkin" <mst@redhat.com>
In-Reply-To: <20260923134952.1750600-1-qwe.aldo@gmail.com>
References: <20260923134952.1750600-1-qwe.aldo@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 13:59:16 +0000
Message-Id: <20260923135916.7C5DD1F000FF@smtp.kernel.org>
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

> qxl_bo_kmap_atomic_page() takes a page_offset parameter that callers
> compute as a byte offset aligned to a page boundary:
>=20
>     reloc_page =3D qxl_bo_kmap_atomic_page(qdev, info->dst_bo,
>                                          info->dst_offset & PAGE_MASK);
>=20
> The VRAM/PRIV path adds it directly to the mapping base (both in
> bytes), which is correct:
>=20
>     offset =3D bo->tbo.resource->start << PAGE_SHIFT;
>     return io_mapping_map_atomic_wc(map, offset + page_offset);
>=20
> But the two system-memory fallback paths multiply it by PAGE_SIZE
> again:
>=20
>     rptr =3D bo->kptr + (page_offset * PAGE_SIZE);
>=20
> For page_offset =3D 0x5000 (page 5), this computes
> 0x5000 * 0x1000 =3D 0x5000000, a 80 MiB offset instead of 20 KiB,
> producing a massive out-of-bounds access into kernel memory.
>=20
> Remove the spurious multiplication so the fallback paths use the
> same byte-offset semantics as the io_mapping path.
>=20
> Fixes: f64122c1f6ad ("drm: add new QXL driver. (v1.4)")
> Cc: stable@vger.kernel.org
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923134952.1750=
600-1-qwe.aldo@gmail.com?part=3D1

