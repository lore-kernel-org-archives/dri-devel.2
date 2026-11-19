Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36D9606A326
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 19:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=dF9sRKwl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F423F10E790;
	Thu, 19 Nov 2026 19:39:42 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 151DF10E790
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 19:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 Message-Id:Date:Subject:From:From:Reply-To;
 bh=ULkJYcH9aKX38zM3HpAXEa6rCmb4BClr4apdW+tJtI4=; t=1795117176; x=2110477176; 
 b=dF9sRKwlsBuWpHJ8lcq8yZbv48Bgkf87mnfp9MoLHQiLV+86Et/yQ146E7aU+5seGHV6wkUwLWr
 e/X9FMrqoPsXHzfS4lBURICLYNmzr9GATGlU767kWoxnhprfrZu5vHlgJLsOBTVcad/quFNGwfrFI
 /hwvJmRN45wfavLPdt+232lu1dqkOK512lrHG+8rC+mn33UdGJsEJp2eXrhDZSdPY8lSdE5oIjMEV
 aZ4HdzJE4OEF43Hn+DKZybSTjHeTYJvEcr4gvIeuLUl4uh8lC+7XQZ/Y8S0KRvGUzHdGtd+9vlplv
 unecD77psXUwCOnOc12doIQ/neNkwC0bayvg==;
Received: from [179.105.94.163] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xU7yn-00000001bU7-3OuI; Thu, 19 Nov 2026 20:39:34 +0100
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Subject: [PATCH 0/6] drm/panfrost,panthor: Refuse to export WB_MMAP BOs
Date: Thu, 19 Nov 2026 16:38:15 -0300
Message-Id: <20261119-pan-drop-dma-buf-hooks-v1-0-6c6f1629e7f9@igalia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqEMAxA0atI1hMwyqj1KoOLOk00iG1pUQTx7
 lNm+Rb/35A5KWcYqxsSn5o1+AJ6VfBdrV8Y1RVDUzcdERmM1qNLIaLbLc6H4BrCltEM0gsZaec
 3QYljYtHrP/5Mz/MDF6an9mgAAAA=
X-Change-ID: 20261119-pan-drop-dma-buf-hooks-98f7f19f3b51
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Faith Ekstrand <faith.ekstrand@collabora.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Liviu Dudau <liviu.dudau@arm.com>, Akash Goel <akash.goel@arm.com>, 
 Karunika Choo <karunika.choo@arm.com>, 
 Lukas Zapolskas <lukas.zapolskas@arm.com>, 
 Chris Diamand <chris.diamand@arm.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Alice Ryhl <aliceryhl@google.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 rust-for-linux@vger.kernel.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3189; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=Yan1nsrMqmbjshJ/S9xZKYqQsyvHOFJvhtMSHFfwIc4=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBq/1BuykThLrJSkVzBudGsmGQLAGH/H/zqu0828
 SCU3m9xITuJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCav9QbgAKCRA/8w6Kdoj6
 qtbJCADOY2NOpCkpYyH5j6uRDYrwDy6dE8kZTIk1ipIDOec+WitxSyOD30ruHwg6INwqCCnjoG4
 Jhu9dp6AMa+MrWrIIBdD8ZYhzVZGkfcbpLJBL0OFDP0WCRoN86JojNyd3YObbvJ14J1lHJamCKc
 J+bOcgQzl7H0wsqpkgmW6YAh6i0gc0B0FopwSls9MxCPB9oiMXFiGdJUFe4SC3cjfrfzDlq2V1s
 DfSJE5mla//JR4fmNs+BZohGjXeVDIOAYaxv+S2uQ3J4rYtzPi0DINb8jEtQ9uiJ4Hi34Qb/Hba
 sMYcXnC32c4vyv/5zTH/UXfBN0Xuw2h27g9hi+ZFtSFngNEt
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series follows up on the discussion in the V3D cached maps series
[1], about how to handle CPU-cached BOs that are shared through dma-buf.

As pointed by Faith and Boris, when a buffer is shared through dma-buf,
there's no way to ensure that a client will properly bracket their CPU
accesses with DMA_BUF_IOCTL_SYNC. With WC mappings, waiting on fences is
enough to guarantee consistency. However, with WB mappings, a missed sync
can leave dirty cache lines behind, which another client can end up
writing over.

PanVK already keeps WB_MMAP BOs private, so this series only makes the
kernel enforce the same policy on Panfrost and Panthor. As WB_MMAP BOs can
no longer be exported, the custom dma_buf_ops providing begin/end_cpu_access()
are no longer needed for them and are replaced by the default PRIME ops.

- Patch 1 adds the drm_gem_shmem_sync() helper, taken from [2].
- Patches 2 and 5 refuse to export WB_MMAP BOs in Panfrost and Panthor.
- Patches 3 and 6 drop the custom dma_buf_ops from Panfrost and Panthor.
- Patch 4 converts Panfrost to drm_gem_shmem_sync(). V3D will also use it
  to implement its cached maps, which I'll send in a separate series.

Patches 3 and 6 need some extra attention as they aren't a no-op on
IO-coherent GPUs. In this case, all BOs are CPU-mapped WB, and the custom
begin/end_cpu_access() could be used to sync the mappings of non-coherent
importers.

However, I decided to send these patches either way because they only
restore the behavior prior to commits 3ae6637378e6 and 925ad0c26dd8, which
is what we discussed in [1] (IIUC). Also, Mesa writes through the GEM mmap
without DMA_BUF_IOCTL_SYNC, so it never relied on these hooks anyway.

Still, if you think this would be problematic, I can drop patches 3 and 6.

The Panthor changes were tested on hardware, but Panfrost changes were
only compile-tested.

[1] https://lore.kernel.org/dri-devel/20261030-v3d-cached-maps-v1-0-0a6a6b363382@igalia.com/T/
[2] https://lore.kernel.org/dri-devel/20251126124455.3656651-1-boris.brezillon@collabora.com/

Best regards,
- Maíra

---
Faith Ekstrand (1):
      drm/shmem: Add a drm_gem_shmem_sync() helper

Maíra Canal (5):
      drm/panfrost: Refuse to export WB_MMAP BOs
      drm/panfrost: Drop custom dma_buf_ops
      drm/panfrost: Use drm_gem_shmem_sync()
      drm/panthor: Refuse to export WB_MMAP BOs
      drm/panthor: Drop custom dma_buf_ops

 drivers/gpu/drm/drm_gem_shmem_helper.c  |  93 +++++++++++++++
 drivers/gpu/drm/panfrost/panfrost_drv.c |   1 -
 drivers/gpu/drm/panfrost/panfrost_gem.c | 194 ++------------------------------
 drivers/gpu/drm/panfrost/panfrost_gem.h |   3 -
 drivers/gpu/drm/panthor/panthor_drv.c   |   1 -
 drivers/gpu/drm/panthor/panthor_gem.c   | 120 +-------------------
 drivers/gpu/drm/panthor/panthor_gem.h   |   4 -
 include/drm/drm_gem_shmem_helper.h      |  17 +++
 include/uapi/drm/panfrost_drm.h         |   1 +
 include/uapi/drm/panthor_drm.h          |   2 +
 10 files changed, 126 insertions(+), 310 deletions(-)
---
base-commit: 8e2afcd2b57990465f132367fd8fdc2e55c1adad
change-id: 20261119-pan-drop-dma-buf-hooks-98f7f19f3b51

