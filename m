Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F9E3C98311
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 10:08:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A93F10F427;
	Thu, 24 Sep 2026 10:07:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Gaf9HbiN";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91ABD10F427
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 10:07:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7A67643540;
 Thu, 24 Sep 2026 10:07:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ABB01F00898;
 Thu, 24 Sep 2026 10:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790244478;
 bh=cOuYAWQzfp8h6z0+79qmbP7zq2+xblr6aMlVg6a2ckk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Gaf9HbiNhHHf5dQyvcAZIYUyrSopIWn1MQxOTtJanlzbjFiBFmmAA4Y958gGE9E00
 LSZqf/BSd7cfSfk6IV/3PIqDzNxnxs7YT7EqK/BLLy+kmcpLJEnbxL4al9WCYEqm5g
 dU3+tTfQMknG1sDq3rBbXgtsAkp/eBjwrwC+ymQwS8VDoqxCkFb555AMlRY73PhyTM
 jD/On4Srv3FrnvBCO5mAZMVcPqLzPXByJLzwcNoE6AlDD5z/nor5kUwR+57bmr5mKD
 K/ak7JOfDLm78/636Ai9slKngf+mvOqxaDloPx5d/lZJHCo3pbl2IwYAuLzraIDS6F
 KDgoWipW0zjaQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v9 3/4] drm/virtio: implement userptr resource support
To: "Honglei Huang" <honghuan@amd.com>
Cc: "Eugenio Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev,
 dri-devel@lists.freedesktop.org, "Michael S. Tsirkin" <mst@redhat.com>
In-Reply-To: <20260924095556.1326164-4-honghuan@amd.com>
References: <20260924095556.1326164-1-honghuan@amd.com>
 <20260924095556.1326164-4-honghuan@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 10:07:57 +0000
Message-Id: <20260924100758.1ABB01F00898@smtp.kernel.org>
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
> - Mark writable pages dirty when unpinning
> - Keep pages pinned until RESOURCE_UNREF is queued; drop them from
>   cleanup_object() on the unref response or on create failure
> - Clear userptr->pages on pin failure to avoid double-free on cleanup
> - Reject unaligned or overflowing userptr ranges at create time
> - Disallow PRIME export of userptr objects
> - Save CREATE_BLOB params and restore userptr resources after
>   hibernation without using the shmem restore path
>=20
> The hibernation restore path maps with the same attrs and direction
> used at create time, as documented next to the call. Like shmem
> blobs, the DMA API can still bounce through a buffer there. This
> design only avoids a second guest side shmem allocation and memcpy,
> nothing more.
>=20
> Signed-off-by: Honglei Huang <honghuan@amd.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924095556.1326=
164-1-honghuan@amd.com?part=3D3

