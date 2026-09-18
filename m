Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBA30C982DA
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 10:21:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF6B310F2CC;
	Fri, 18 Sep 2026 10:21:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="a1Wf6GXK";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93EA810F2CC
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 10:21:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EA70960A79;
 Fri, 18 Sep 2026 10:21:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5847E1F000FF;
 Fri, 18 Sep 2026 10:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789726861;
 bh=KDsfkNxMFu5fqNLr0RTeR89UAJDLSJBZCWfVWM75MFo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=a1Wf6GXKTpNhuJQ9XN32fR3nMZ5wEl8C+cq410//0xpco48IwJ+d/k2I67gsnqZ5Y
 iFVILAh5ViSspakfHFTG+W5HjXnSwO5+u840QIVGQx5NiFCpWX/KwcEjxNT7H7kUav
 9Z2KcfDq+tbWB9mG07wkhW92NDGq7UoS3FAANKbtQZ/SmlqUmfrO45UkgrwKBG9Qr7
 /AX0rU3Qt2YiHgQpS0J3ezafg0NLZkWgVU3P6UCVzSvstIN6Wwx+YYkoM6Lh/YhS0U
 CVpKwkjkXuNCCJFQ/B6SPt42fnmp9er4Y/NOEwwZ5MEU2epucl/gFrohyPDe3iftYn
 dWFhN+PwJ7x2A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 3/4] drm/virtio: implement userptr support for
 zero-copy memory access
To: "Honglei Huang" <honghuan@amd.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>,
 dri-devel@lists.freedesktop.org, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20260918095940.2253018-4-honghuan@amd.com>
References: <20260918095940.2253018-1-honghuan@amd.com>
 <20260918095940.2253018-4-honghuan@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 10:21:00 +0000
Message-Id: <20260918102101.5847E1F000FF@smtp.kernel.org>
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

> Add userptr blob objects so the guest kernel can pin an existing
> userspace mapping and advertise it as CREATE_BLOB backing entries.
>=20
> - New virtio_gpu_object_userptr type for userptr resources
> - Pin pages with pin_user_pages_fast() and FOLL_LONGTERM
> - Omit FOLL_WRITE when VIRTGPU_BLOB_FLAG_USE_READONLY is set
> - Charge FOLL_LONGTERM pins against RLIMIT_MEMLOCK
> - DMA-map the scatterlist only when virtio_gpu_use_dma_api() is
>   required; use DMA_TO_DEVICE for USE_READONLY blobs
> - Sync userptr SG for the device on TRANSFER_TO_HOST
> - Mark writable pages dirty when unpinning
> - Keep pages pinned until RESOURCE_UNREF is queued; drop them from
>   cleanup_object() on the unref response or on create failure
> - Clear userptr->pages on pin failure to avoid double-free on cleanup
> - Reject unaligned or overflowing userptr ranges at create time
> - Disallow PRIME export of userptr objects
> - Save CREATE_BLOB params and restore userptr resources after
>   hibernation without using the shmem restore path
>=20
> Signed-off-by: Honglei Huang <honghuan@amd.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918095940.2253=
018-1-honghuan@amd.com?part=3D3

