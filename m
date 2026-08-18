Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C21FFC5DF82
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 17:48:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B94610E4EB;
	Tue, 18 Aug 2026 17:48:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=edera.io header.i=@edera.io header.b="IGzMkFex";
	dkim-atps=neutral
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com
 [209.85.219.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B8DC10E4EB
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 17:48:42 +0000 (UTC)
Received: by mail-qv1-f54.google.com with SMTP id
 6a1803df08f44-8efbafa1bacso1597196d6.1
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 10:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=edera.io; s=google; t=1787075321; x=1787680121; darn=lists.freedesktop.org; 
 h=content-type:mime-version:message-id:date:user-agent:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=sZfKlpmmAGMPY0pYQ5qB8sNVCzbuLBNICRyvhJ/UKoY=;
 b=IGzMkFexZkGUyebuYhvkvpOkYfgqsmMklpWzZ3102U3fkrqSJsDUEEgBlbbzNqofo2
 b5H4mrPULSP1fu8/00Dlq8Y0giMptTI8jSYA9ouO1zL4USBoBwhJvnmQejLHGwu3u926
 Em6B5gtcuTg3Hjq35QAcs3BGlYepznRhhOFdMEfFtTTWOgwaSd7qMr//NZX0NwXbb133
 zzQGc1IB2mV2pnC/TpRa5Uq8yQ6a2PeSCDRCucxNtjY1G6wZ8hosSd218sAU7B2FNtDg
 OskGDnWr2zkcXVcznfEYvD14ZoG7r9jCpy2aPY0fk1AElQ3d/XSqhv38lh24u7jbSR5F
 VuCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787075321; x=1787680121;
 h=content-type:mime-version:message-id:date:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=sZfKlpmmAGMPY0pYQ5qB8sNVCzbuLBNICRyvhJ/UKoY=;
 b=r7pPJETq1IFXPUuARW55x769lBHkbxKjN2mHDYKdHAq3kn4wqCKo/FXmp+mWvQ08Yp
 LhLW4d+01mas0sVKogKMW9dwcv7NfAluGZe77CJgHogMElFmLmUrX+uYskJBZv/9NfiB
 XCNnH9o5L0ETj9efsolLErk12qdU1bU6OUiH9FVRQlXzBujYvMxpJ7VPNKDFcfQSHwlZ
 CKXIjcrwzYMdgn2aBHz8Q1OTHsDd3L9evXa5SRE3wV5KGRuxo8g0rWeb+Vz+uIr2y74z
 l94fcWKdaWB7374XZJTWn2oYMYPOM8PLvV1sRYp+B8ZBnbPdJLaR5gavRbYIAri/OIui
 Fbag==
X-Forwarded-Encrypted: i=1;
 AHgh+RqTToMIJ/Yp8W1R/bL9mIxT4Lg87fn0P/8dxX5gnCOEL9zvMy+RN/fFe1WhrE1VI3LcXfZ6NxXN7Wk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx1yXMCy26N+8ZL4kY8x/0fQCQH6KnepnQlPY0NFgQyjFLixnAk
 lXSgJ8O54cVEjqpFDSDOeCevr4tHxQMAafW/OC45wASEmM0hGuTjDplmN3xCCbWwfOU=
X-Gm-Gg: AR+sD11Y30v+ZKg/APxbVJzc0YmJEPH/LeRA+bIpPsJMQiMGE2SfOl54Koi8BzF5Tfk
 bU5ahuFI+wgV5QCGAZpS9Xw8OMCQMZccE3O2Fb1tKTGH+0nZsm74f+q8CgiQj9t+j/4B9pCgveK
 HKK/bpQOZTa+5EfX7V47bQNwB5a0Qcg4/D8e1Jx+Biy29NvVcCj7itb7eTIb7GglFxGniSjC/O+
 osmAMN/ahJXaO2oANo25cUUis0kCOoY+ZbU8QsuNOpRrtpUrrZaTfBpb1aJbl7KJwGio7IdyJXp
 YmyySW46oZmfQFQffq001cy8WAGYZmi7vAyulcfVcTl1ni+ZiYpwSSysg/rVNFid+n6LjCOw5Rc
 E4yft8miiwGvY0Ff+5NSRsidWJt+8MZVweGODVctHBqeOoz95vBtOCoz06+ew79SiLIoVvQtjQf
 WIqGJTThNO79lTP68e+aOaTM5RKRvmpH0GTp7rOcggdsjSn4qy0HnEK9FOORmzr20icOmCJlo9H
 Q2gtsdgalkFCAAJTt5/uK6hkd2/Y4BYiToHM+N9RjIn
X-Received: by 2002:a05:6214:860d:b0:8ec:235c:7a66 with SMTP id
 6a1803df08f44-90c5c12de8dmr1581236d6.27.1787075321126; 
 Tue, 18 Aug 2026 10:48:41 -0700 (PDT)
Received: from StolidWingnut ([174.80.170.224])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90c4597b7desm36800736d6.46.2026.08.18.10.48.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 10:48:40 -0700 (PDT)
From: Benjamin Leggett <benjamin@edera.io>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: David Airlie <airlied@redhat.com>,  Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>,  Chia-I Wu
 <olvaffe@gmail.com>,  Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>,  Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,  Simona Vetter
 <simona@ffwll.ch>,  dri-devel@lists.freedesktop.org,
 virtualization@lists.linux.dev,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/virtio: use the DMA API for resource backing on Xen
In-Reply-To: <657a88d7-e1d4-46ee-9b79-b33144e749dd@collabora.com>
References: <20260806-virtgpu-xen-dma-v1-1-e499b345bbad@edera.io>
 <657a88d7-e1d4-46ee-9b79-b33144e749dd@collabora.com>
User-Agent: mu4e 1.12.12; emacs 32.0.50
Date: Tue, 18 Aug 2026 13:48:37 -0400
Message-ID: <875x17tj4a.fsf@edera.io>
MIME-Version: 1.0
Content-Type: text/plain
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

Dmitry Osipenko <dmitry.osipenko@collabora.com> writes:

> On 8/7/26 01:54, Benjamin Leggett via B4 Relay wrote:
>> From: Benjamin Leggett <benjamin@edera.io>
>> 
>> On a Xen PV domain page addresses bear no relation to the real machine
>> addresses the host would have to use to reach it.
>> virtio_ring.c handles this correctly, vring_use_map_api() returns true
>> for any xen_domain() regardless of VIRTIO_F_ACCESS_PLATFORM.
>> 
>> virtio-gpu makes the same decision independently, but its copy
>> looks only at the feature bit:
>> 
>> 	bool use_dma_api = !virtio_has_dma_quirk(vgdev->vdev);
>> 
>> QEMU does not set iommu_platform on virtio-vga by default, so
>> VIRTIO_F_ACCESS_PLATFORM is not negotiated, use_dma_api is false, and
>> virtio_gpu_object_shmem_init() describes the framebuffer's backing pages
>> to the host with sg_phys().  Those are guest-physical addresses. In a PV
>> domain they resolve, on the host side, to pages belonging to some other
>> domain, so the host scans out unrelated memory.
>> 
>> Move the decision into virtio_gpu_use_dma_api() and give it the
>> xen_domain() check, like vring_use_map_api() has. This
>> additionally enables the dma_sync_sgtable_for_device() calls in
>> virtgpu_vq.c, which are required for correctness whenever swiotlb
>> is in play.
>> 
>> Reproduced with a Xen 4.21 PV dom0 nested inside QEMU 8.2 with
>> virtio-vga, on both a distro 6.8 kernel and 6.18 LTS. A PVH dom0
>> works fine and doesn't need this fix because it is identity-mapped,
>> only PV dom0s are affected.
>> 
>> Fixes: a3b815f09bb8 ("drm/virtio: add iommu support.")
>> Signed-off-by: Ben Leggett <benjamin@edera.io>
>> ---
>>  drivers/gpu/drm/virtio/virtgpu_drv.h    | 20 ++++++++++++++++++++
>>  drivers/gpu/drm/virtio/virtgpu_object.c |  2 +-
>>  drivers/gpu/drm/virtio/virtgpu_vq.c     |  6 +++---
>>  3 files changed, 24 insertions(+), 4 deletions(-)
>
> Feel free to send follow-up patches to fix problems reported by the
> Sashiko bot.
>
> Applied to drm-misc-fixes, thanks!

Thanks, a proposed followup for the Sashiko-bot reported issue
submitted: https://lore.kernel.org/dri-devel/20260814-virtgpu-from-host-sync-v4-1-64dd736b1779@edera.io/
