Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E63FC982D7
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 10:08:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6932410F2E3;
	Fri, 18 Sep 2026 10:08:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OhRfjipo";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AC6810F2DC
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 10:08:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 659CF436C0;
 Fri, 18 Sep 2026 10:08:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF5711F00893;
 Fri, 18 Sep 2026 10:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789726123;
 bh=0logBO07MURCsBD5KVajDxEUhuvDL975pij67DeQqPQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=OhRfjipoUxGRZa4qoifqVjhwECwzoQtiDEnhGdYa/Fise/Q9MG5ST2g4bIUC04dpL
 TEeWYpcPOq+Cm7J9rQs/DvKQUcHc5bndP6p+B5XX3Tnf3JzM1G1f3d0mnYUgI8kTcL
 ROOoP1fMqB2t1tESdxYQON4XLxsFItPP2HHG5t2pE53gzzq2NIeOTYhxHQ8zfx1W5q
 WNIvtF06hzLX6Kkpyh3TAivZFRU/dFSAQb8FVjfp0Iq+dVCTKa8Dy9KqiR/AfxDt/L
 naDv+6FuEPUgRBXyw6TpCCYfIK/2xrSQbgbV99OQsQ21qMCD8nJEikPwJiiTIa2C2M
 7uaf3IayQnczw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 4/4] drm/virtio: wire blob ioctl creation to userptr
 objects
To: "Honglei Huang" <honghuan@amd.com>
Cc: "Eugenio Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev,
 "Michael S. Tsirkin" <mst@redhat.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20260918095940.2253018-5-honghuan@amd.com>
References: <20260918095940.2253018-1-honghuan@amd.com>
 <20260918095940.2253018-5-honghuan@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 10:08:42 +0000
Message-Id: <20260918100842.EF5711F00893@smtp.kernel.org>
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
>=20
> Signed-off-by: Honglei Huang <honghuan@amd.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918095940.2253=
018-1-honghuan@amd.com?part=3D4

