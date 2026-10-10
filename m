Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEB6CCA9EC1
	for <dri-devel@archiver.kernel.org>; Sat, 10 Oct 2026 20:19:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20B0B10E284;
	Sat, 10 Oct 2026 20:19:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="bKepcU/U";
	dkim-atps=neutral
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50A1610E284
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 20:19:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1791663546; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=DQ2vfMmhnUm4hE/dkcpkXKloV4x4qCl3l4A2sqrmocj0ng7dkRwd97nJCNw2yYq1sfumR1unGvaG+W0DpxzxqMboFATzAA0QzMujt43hLMBzQPGQCyx6a8r976o336URr+ESWuhqdbZmFitQ7T1umnI7h65s8qU2OSAk2FsOdFw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1791663546;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=vrWGR9SAVLhrNl8QfDeyWpcETJt0y8/ezyo4jgasdzI=; 
 b=CR5PWmnmakhEyzpOo2Y0ljlVaCLB8fvY7Fy11n8va+FBVeurtXSala4dnPiLIbpZ31hLoCkQciTFgzS6atzN3aumeVYRF5LeTEi1uf6s4ReXVi1AD2CRbpkHbnVx8f7aFgtD79FOfbQ50fLQEkoXf1juwxbv7U1QMhc7DpT2/dI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791663546; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=vrWGR9SAVLhrNl8QfDeyWpcETJt0y8/ezyo4jgasdzI=;
 b=bKepcU/UlgnVQZv5wRS1OSjU6I/XAqZ/qEM7+AXewsM5xwqE+QNwMwfRxt1hqqjF
 22kvcdqovT7vFl6Yy7zCIC4026+kcneJnsQc3/6VVE7bzSUj8XNaQ34rs6zhmQtq7LJ
 cbpf2Zh54sp5c9kftV+EyIqdWymqmIsf0hSKJHJA=
Received: by smtp.zohomail.com with SMTPS id 1791663545919289.48010554267705; 
 Sat, 10 Oct 2026 13:19:05 -0700 (PDT)
Message-ID: <8393a8a2-2ed5-4d63-b937-5d837c1bb1aa@collabora.com>
Date: Sat, 10 Oct 2026 23:19:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/virtio: reject mappable HOST3D blobs without
 host-visible memory
To: Henry Martin <bsdhenrymartin@gmail.com>, David Airlie
 <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Chia-I Wu <olvaffe@gmail.com>, Gurchetan Singh
 <gurchetansingh@chromium.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Simona Vetter <simona@ffwll.ch>, Junrui Luo <moonafterrain@outlook.com>
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261010081059.3096312-1-bsdhenrymartin@gmail.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20261010081059.3096312-1-bsdhenrymartin@gmail.com>
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

On 10/10/26 11:10, Henry Martin wrote:
> virtio_gpu_resource_create_blob_ioctl() -> verify_blob() validates
> blob flags, memory type, context and alignment, but never checks
> VIRTGPU_BLOB_FLAG_USE_MAPPABLE against vgdev->has_host_visible.
> 
> For blob_mem == VIRTGPU_BLOB_MEM_HOST3D the blob is created via
> virtio_gpu_vram_create(), and on a device without host-visible
> memory (plain virtio-gpu-pci,blob=on with no hostmem) the failure
> comes too late: the GEM object has been allocated, a host resource
> id taken and the create_blob command issued when
> virtio_gpu_vram_map() returns -EINVAL, and the cleanup calls
> virtio_gpu_vram_free(), which is a no-op while bo->created is still
> false (the host response has not been processed yet).  Every such

virtio_gpu_cmd_resource_create_blob() is invoked before
virtio_gpu_vram_map() in virtio_gpu_vram_create(), hence bo->created is
always true, how come it's false?

-- 
Best regards,
Dmitry
