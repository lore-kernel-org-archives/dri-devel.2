Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66A02C5B572
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 13:41:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE50310E564;
	Fri, 14 Aug 2026 13:41:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="LRrdDobo";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B1DB10E564
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 13:41:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1786714872; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=RPAEiFY7tlBpNyUSFu4iAFTijwPBqFSYUxPCH85r6LQJwy5b0Rwe7bWuJdBsQIpZzK38T2vJSQjg0P4wZ7NDw0TGhlFEEzZPeU9iIAenn++tY+HUzJKPnwW6zUN+MaASQjHu0yVTHmUr+PhH5gG10qCNbNBp7fGdyLDldy0aQXw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1786714872;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=DVIRt8un9B6NE6v0MmUTpJ/DVfMnBa2UrPJWrJJB3fg=; 
 b=fJlKWYKGz/EPq1+7YuOtF7lW+OP+s3CK2r/HcVrZUEUbMwcCl6EN1mJMoFu+DVKGH/v9XAv4Qxmg6PoD3CPtJuggx/ixzqeQgPPOGd2JAw4K4ErXiO++pioDXFCtqdQTV7SNrStH5FEtrd95adhWv1OHMvh3PWs7WNkHSU7JtC4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786714872; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=DVIRt8un9B6NE6v0MmUTpJ/DVfMnBa2UrPJWrJJB3fg=;
 b=LRrdDoboMKaPVKUQzBau4DQkIAJIPpzcVp07CI8ZpIAS5hsgoPL7exkROF6w4djP
 bwMe6tzzCUEoIa6dk1arlpQc21JnRdGdsoGxaxdZGaov7CBrMcxBpLvUKx6YyfSkHyB
 2rXexmP5E8+eYme8Ga8GD9zOVSMWXPqCxCqjZ3cY=
Received: by mx.zohomail.com with SMTPS id 1786714870162348.7749122373514;
 Fri, 14 Aug 2026 06:41:10 -0700 (PDT)
Message-ID: <657a88d7-e1d4-46ee-9b79-b33144e749dd@collabora.com>
Date: Fri, 14 Aug 2026 16:41:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/virtio: use the DMA API for resource backing on Xen
To: benjamin@edera.io, David Airlie <airlied@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260806-virtgpu-xen-dma-v1-1-e499b345bbad@edera.io>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20260806-virtgpu-xen-dma-v1-1-e499b345bbad@edera.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On 8/7/26 01:54, Benjamin Leggett via B4 Relay wrote:
> From: Benjamin Leggett <benjamin@edera.io>
> 
> On a Xen PV domain page addresses bear no relation to the real machine
> addresses the host would have to use to reach it.
> virtio_ring.c handles this correctly, vring_use_map_api() returns true
> for any xen_domain() regardless of VIRTIO_F_ACCESS_PLATFORM.
> 
> virtio-gpu makes the same decision independently, but its copy
> looks only at the feature bit:
> 
> 	bool use_dma_api = !virtio_has_dma_quirk(vgdev->vdev);
> 
> QEMU does not set iommu_platform on virtio-vga by default, so
> VIRTIO_F_ACCESS_PLATFORM is not negotiated, use_dma_api is false, and
> virtio_gpu_object_shmem_init() describes the framebuffer's backing pages
> to the host with sg_phys().  Those are guest-physical addresses. In a PV
> domain they resolve, on the host side, to pages belonging to some other
> domain, so the host scans out unrelated memory.
> 
> Move the decision into virtio_gpu_use_dma_api() and give it the
> xen_domain() check, like vring_use_map_api() has. This
> additionally enables the dma_sync_sgtable_for_device() calls in
> virtgpu_vq.c, which are required for correctness whenever swiotlb
> is in play.
> 
> Reproduced with a Xen 4.21 PV dom0 nested inside QEMU 8.2 with
> virtio-vga, on both a distro 6.8 kernel and 6.18 LTS. A PVH dom0
> works fine and doesn't need this fix because it is identity-mapped,
> only PV dom0s are affected.
> 
> Fixes: a3b815f09bb8 ("drm/virtio: add iommu support.")
> Signed-off-by: Ben Leggett <benjamin@edera.io>
> ---
>  drivers/gpu/drm/virtio/virtgpu_drv.h    | 20 ++++++++++++++++++++
>  drivers/gpu/drm/virtio/virtgpu_object.c |  2 +-
>  drivers/gpu/drm/virtio/virtgpu_vq.c     |  6 +++---
>  3 files changed, 24 insertions(+), 4 deletions(-)

Feel free to send follow-up patches to fix problems reported by the
Sashiko bot.

Applied to drm-misc-fixes, thanks!

-- 
Best regards,
Dmitry
