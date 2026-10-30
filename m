Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00D1606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 20:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=aqhXKm9j
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A89110E071;
	Fri, 30 Oct 2026 20:51:41 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3178F10E097
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 20:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 Message-Id:Date:Subject:From:From:Reply-To;
 bh=uz1cz2p8OdBpW6ZDN0/gPNl8dMZtYrtmWwM9MAQCVwM=; b=aqhXKm9jA/0dQnPxIMSoKxzLYY
 LJqpV/8iTHbFD0dYj8q6+NZO1ba0i6Afm637G5FqYQijtjEeT60Z+dlTjGzwGbCA/brQc9MRCDOum
 SUZ1NjfBLUoVDgtjazYy4QwbtlarMiysvYnrU4pWW3u/3Vi45BAlTbNwvYBjskYS3w1+0cK1FwkV7
 KrVbeloS+OQXeTezDhN9A6Gwa3Bms6YS9jvj59A7UPFjQHKJSScGYGeAxL2WcZ79ggZwj2Yll7KJy
 L+R3kvTcFOv+dn7buv+3JUbMp/ui5O/5XPTMmmQoYoZDNmD3eib/a1vydh0GnhCSr9R0omDhLnLba
 SgJAqxFQ==;
Received: from [179.105.94.163] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xMtZI-00FLiF-Ee; Fri, 30 Oct 2026 21:51:20 +0100
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Subject: [PATCH RFC 00/12] drm/v3d: Add support for write-back cacheable
 BOs
Date: Fri, 30 Oct 2026 17:50:18 -0300
Message-Id: <20261030-v3d-cached-maps-v1-0-0a6a6b363382@igalia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDAyML3TLjFN3kxOSM1BTd3MSCYt20xMRU46RES9NUQ0MloK6CotS0zAq
 widFKQW7OSrG1tQC9lXzVZgAAAA==
X-Change-ID: 20261028-v3d-cached-maps-faae3ba95e11
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Faith Ekstrand <faith.ekstrand@collabora.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Liviu Dudau <liviu.dudau@arm.com>, Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>, 
 Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>, 
 JaeHoon Lee <dlwognsdc610@gmail.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3722; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=CrzrETQ4ymAmS2t4W3YPcDeDKPnmhJr7a0Qjlvu3I/w=;
 b=owGbwMvMwMVo/5mvq6zj1yrG02pJDFlPme3UTT83d/gx1bcbNEnYKdvmiSfJGrfPYyyxuqay3
 z+v6UonozELAyMXg6yYIsuPJ7G1jGLl7JrLyi/CDGJlApnCwMUpABO5MZf9f/wLrczYg2Khi4JS
 yibayExuV0/v33qf27HF9ala26/XtbrPlVbIml+4LxPzrebvg6ZPDBsSNHjbrsU4TNr86E6XQsT
 1rK///CxPdb+eEn2GUXnm+lqhmiR2K/P34vGXje3f8Rh1s0Qz268I3/UqoLPi5Sv98+uWTpKR6L
 n4KztpxeRVCZO/5Zse1HiQsP3y556pym7nan7ue/dAdpv5l2VZnn8zxV7P5tzE0J5ttDI5Xnqyk
 57x3f8Kn6ydOQVz56zdWdLY+Txto/RyrYepLxLNEywX+30Lsn3cV/iu56J25Rcx47MT8v+7cerF
 Z/S4acv2f5T/fyjKkWHpl/V3JV1cV2+8sGO3gPOiohI2AA==
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series aims to implement cached maps and explicit flushing for the
V3D driver, which is mostly motivated by Vulkan's host cached memory.

V3D's implementation of cached maps is quite similar to Panfrost's and
therefore, I decided to revamp Panthor/Panfrost's efforts [1] to implement
common shmem helpers for CPU cache maintenance. The other option would be
copying the same code in V3D, so I preferred to retake the discussion
and see if we can reach some consensus.

The most controversial part of this series are the first three patches,
which were extensively discussed in Boris' series.

Patch 1 lets the PRIME helpers work with custom dma_buf_ops, following
Thomas' feedback on [1]: drm_gem_prime_export_with_ops() exports with
driver-provided ops, and gem_prime_is_exporter() lets a driver recognize
its own DMA-BUFs on import, without adding buffer callbacks to struct
drm_driver, as requested by Thomas.

Patches 2-3 are taken from [1], rebased on top of drm-misc-next with some
minor kernel-doc fixes.

Patches 4-8 convert Panfrost, Panthor and amdgpu to the new helpers. Note
that I didn't use the new helpers from patches 2-3 in Panthor, as they
recently parted ways with DRM GEM shmem.

Finally, patches 9-12 add v3d support to cacheable BOs and the new ioctl
DRM_IOCTL_V3D_SYNC_BO.

About the userspace implementation, I tested this implementation using
a hack implementation (based in PanVK), as I preferred to leave the
userspace implementation to be finished by JaeHoon Lee, which is already
working on it on [2].

[1] https://lore.kernel.org/dri-devel/20251126124455.3656651-1-boris.brezillon@collabora.com/
[2] https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/42974

Best regards,
- Maíra

---
Boris Brezillon (1):
      drm/shmem: Provide a generic {begin, end}_cpu_access() implementation

Faith Ekstrand (1):
      drm/shmem: Add a drm_gem_shmem_sync() helper

Maíra Canal (10):
      drm/prime: Allow custom dma_buf_ops in PRIME helpers
      drm/panfrost: Use PRIME helpers with custom dma_buf_ops
      drm/panfrost: Use common shmem helpers for dma_buf CPU access
      drm/panfrost: Use drm_gem_shmem_sync()
      drm/panthor: Use PRIME helpers with custom dma_buf_ops
      drm/amdgpu: Use drm_gem_prime_export_with_ops()
      drm/v3d: Provide a custom dma_buf implementation
      drm/v3d: Add flag to map BOs write-back cacheable
      drm/v3d: Add a DRM_IOCTL_V3D_SYNC_BO ioctl
      drm/v3d: Advertise support for write-back cacheable BOs

 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c |   9 +-
 drivers/gpu/drm/drm_gem_shmem_helper.c      | 208 ++++++++++++++++++++++++++++
 drivers/gpu/drm/drm_prime.c                 |  47 +++++--
 drivers/gpu/drm/panfrost/panfrost_drv.c     |   2 +-
 drivers/gpu/drm/panfrost/panfrost_gem.c     | 185 ++-----------------------
 drivers/gpu/drm/panfrost/panfrost_gem.h     |   5 +-
 drivers/gpu/drm/panthor/panthor_drv.c       |   2 +-
 drivers/gpu/drm/panthor/panthor_gem.c       |  28 +---
 drivers/gpu/drm/panthor/panthor_gem.h       |   5 +-
 drivers/gpu/drm/v3d/v3d_bo.c                | 101 +++++++++++++-
 drivers/gpu/drm/v3d/v3d_drv.c               |   5 +
 drivers/gpu/drm/v3d/v3d_drv.h               |   6 +-
 drivers/gpu/drm/v3d/v3d_irq.c               |   2 +-
 include/drm/drm_drv.h                       |  11 ++
 include/drm/drm_gem_shmem_helper.h          |  27 ++++
 include/drm/drm_prime.h                     |   4 +
 include/uapi/drm/v3d_drm.h                  |  58 +++++++-
 17 files changed, 474 insertions(+), 231 deletions(-)
---
base-commit: a1e63ab695ad76850ab9787b9eb6aab695dc2965
change-id: 20261028-v3d-cached-maps-faae3ba95e11

