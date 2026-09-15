Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1896BC88E73
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 07:50:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EAB210E25A;
	Tue, 15 Sep 2026 07:50:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mq5MLTPf";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78D0910E25A
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 07:50:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2CE0A4094D;
 Tue, 15 Sep 2026 07:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1ECD1F000FF;
 Tue, 15 Sep 2026 07:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789458623;
 bh=EF2ymQ4tW1U2Z64algIG08ECO7Om/xa+Jf4IPs5eDTU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mq5MLTPf8XCnZZZ0ibD++gUf7DNS6VpJCqgyZDTaKehNtgfs1/I9ctgxCbmEOEnrH
 PxbL5vxuXy5Hoi+nMTNUtjWW+GdhrwkW1ULU9lwqHvslNdVrNezAUHH/FmCOj4r1Qs
 tHfqfaFFraJBZ57ARkXy9DzCHizU0TuSAAvd2oNO6R//C4jH2rIYs0bRys0KP8KHYH
 b65auMxLL/+Av5IxJiQMAW4jo9Z0nMHKvCJtcCO6ELnttWVm6ZY9bGmiaAT3t2lgNR
 +a2PCJCI56igHlWuBDkUaRB9GIylfCAYELTmePW57r1LUruK4sJAaOluoMNt6tZizo
 q5/W+etvqhsOw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/4] drm/virtio: release the GEM object on
 virtio_gpu_vram_create() errors
To: "Junrui Luo" <moonafterrain@outlook.com>
Cc: dri-devel@lists.freedesktop.org, "Michael S. Tsirkin" <mst@redhat.com>,
 "Eugenio Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev
In-Reply-To: <20260915-fixes-v2-4-a0d799e4db66@outlook.com>
References: <20260915-fixes-v2-0-a0d799e4db66@outlook.com>
 <20260915-fixes-v2-4-a0d799e4db66@outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 07:50:22 +0000
Message-Id: <20260915075022.C1ECD1F000FF@smtp.kernel.org>
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
> virtio_gpu_vram_create() frees the object with a bare kfree(vram) on
> both error paths after drm_gem_private_object_init() has run, and on the
> second one after drm_gem_create_mmap_offset() has linked obj->vma_node
> into the device's VMA offset manager. The freed object stays in that
> interval tree, so a later lookup or insertion walks freed memory, and
> the dma_resv and gpuva lock are never destroyed.
>=20
> Call drm_gem_object_release() before kfree() on both paths.
>=20
> Fixes: 16845c5d5409 ("drm/virtio: implement blob resources: implement vra=
m object")
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Junrui Luo <moonafterrain@outlook.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-fixes-v2-0=
-a0d799e4db66@outlook.com?part=3D4

