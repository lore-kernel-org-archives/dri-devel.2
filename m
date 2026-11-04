Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B061F606A31B
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 02:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=h0pZBYfh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E17C510E1F0;
	Wed,  4 Nov 2026 02:03:49 +0000 (UTC)
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2866F10F948
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 02:03:44 +0000 (UTC)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-3552883bd19so726807eec.1
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 18:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1793757823; x=1794362623;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xcyAzaTPZiwAw7CWkuV0s8KVDfnYJoff712343ApSNE=;
 b=h0pZBYfh9+TeaqE4Na2Do2AQyvIjVhFuUQGIlsUGiYe1OfqeJjQOC0R+AWA2Nw6hgs
 R+Vw6M81x75G6Jy4192p0uf5miSYwjMSrj8umcEp1CU09bcvHczQhi5oodRZuj6cwpj1
 56w/LlQ8iWMkaIsYnml0boPyOxLYpIxTXD615IVO1VSEFL1iVIoTaMPeROREN7yQG49h
 3+SWrX7OuzKz47k8I0qhMMZNeY9hLrgkIOSCFTpr+MotHXmbaWqtC+wAJE1aQ0bo77Y7
 lp5Xa3Nhlj4aTewOUjQVgwF7DLdNClglom7rlyh8aDHEJ3rU39K2HOWRpDnwxjOdmRqa
 /bdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793757823; x=1794362623;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xcyAzaTPZiwAw7CWkuV0s8KVDfnYJoff712343ApSNE=;
 b=icOWt/2Gnpbg1OF66bPuuUVreF1buz1T+YXjsVdPEJHDYaw+zc+yMPi5OJ/pbipV7y
 SnxwUa2Z03yoQ97jV3Y0ZaPn963N1RJ1FtzjOv4HQJlFyVLEBQB5oIIqTbNPBI350aZ0
 b9NVyGosCF6eoxh5EtDo11ePXrxWUnjBkT8b4ZVniZFd7OeIbAX5sutvKTFPLWsLh+wW
 x5f0vhuz6fHiK2WNgAAnxAZTiMZ9vQGSmkERi5p70nRYGl+gDO+cWP216gTwI/JtAOzO
 w6XY766ig68WrRbvWCdPNDqPluwq1yJVNx0hApcZ8A5XwQWSW5mAtLbkyMwsadKGd1aJ
 bFBA==
X-Forwarded-Encrypted: i=1;
 AKwUvByPy8JJzFwtCInzSatRwcDeXpKA76cu+I7UDrWauv4VgL6BkHJBG5+ZbR0vMS7hug62e6tAFR8AOYc=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+041YVlScCxM7xoLUy1MhTY+0ogZv7hcrzZDuq6z0SkYLAUl1x
 shwagNkKfzzY8xMM+0akZn7fVhIrphUUL3MY8FXPy5W2149rj0m2kz2OmJQ6zRduF7DF4F5l8dC
 As2wEdg==
X-Received: from dynv12.prod.google.com ([2002:a05:7300:5a0c:b0:36c:9b55:8436])
 (user=sabujp job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:693c:895c:10b0:369:f05d:6c5c
 with SMTP id 5a478bee46e88-36a4240f66emr23559790eec.28.1793757822858; Tue, 03
 Nov 2026 18:03:42 -0800 (PST)
Date: Tue,  3 Nov 2026 18:03:21 -0800
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261104020321.77378-1-sabujp@google.com>
Subject: [PATCH] drm/amdgpu: check importer DMA addressing for P2P DMA-buf
 attachments
From: Sabuj Pattanayek <sabujp@google.com>
To: Alex Deucher <alexander.deucher@amd.com>, 
 "=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, stable@vger.kernel.org, 
 Sabuj Pattanayek <sabujp@google.com>
Content-Type: text/plain; charset="UTF-8"
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
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

amdgpu_dma_buf_attach() currently keeps attach->peer2peer enabled for
non-XGMI attachments whenever pci_p2pdma_distance() returns >= 0.
However, pci_p2pdma_distance() only verifies PCIe bridge topology and
does not check whether the importing device can DMA-address the
exporter's VRAM BAR physical address range.

When amdgpu_dma_buf_map() maps a VRAM BO for P2P via
amdgpu_vram_mgr_alloc_sgt() -> dma_map_resource(), if the importing
device is not behind a translating IOMMU DMA domain (IOMMU_DOMAIN_DMA or
IOMMU_DOMAIN_DMA_FQ) -- for example, when booted with iommu=pt or when
quirks_force_identity_mapping() places a GPU connected directly to an
AMD root port into IOMMU_DOMAIN_IDENTITY -- dma_direct_map_phys() checks
dma_capable() against the importer's DMA mask.

On systems where the exporter's 64-bit VRAM BAR is mapped above the
importer's DMA mask (such as a Radeon PRO W6400 with BAR 0 at
0x48030000000 paired with a 40-bit DMA mask Radeon PRO WX 3200 / Polaris
12 importer), dma_direct_map_phys() fails with DMA_MAPPING_ERROR and
warns:

[   18.421053] amdgpu 0000:c1:00.0: DMA addr 0x0000048038000000+8388608 overflow (mask ffffffffff, bus limit 0)

Because attach->peer2peer remained true, amdgpu_dma_buf_map() attempts
VRAM P2P mapping and fails with -EBUSY instead of falling back to GTT.
In multi-GPU desktop setups driving displays across both GPUs, this
breaks cross-GPU PRIME buffer sharing and causes compositors such as
gnome-shell and Xorg to fail command submission or crash on startup,
leaving the desktop unusable without manual IOMMU or sysfs workarounds.

Mirror the IOMMU remapping and BAR DMA mask check from
amdgpu_device_is_peer_accessible() (commit 75f0efbc4b3b ("drm/amdgpu:
Take IOMMU remapping into account for p2p checks")) in
amdgpu_dma_buf_attach() via a new amdgpu_dma_buf_is_p2p_addressable()
helper. Disabling attach->peer2peer when the importer cannot address the
exporter's VRAM aperture allows amdgpu_dma_buf_pin() and
amdgpu_dma_buf_map() to transparently fall back to GTT (system memory),
eliminating the DMA mapping overflow and restoring working multi-GPU
PRIME buffer sharing out of the box.

Fixes: 48262cd9499c ("drm/amdgpu: add checks if DMA-buf P2P is supported")
Cc: stable@vger.kernel.org
Signed-off-by: Sabuj Pattanayek <sabujp@google.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 31 ++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index bbe518757907..837330831eb2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -42,6 +42,7 @@
 #include <drm/ttm/ttm_tt.h>
 #include <linux/dma-buf.h>
 #include <linux/dma-fence-array.h>
+#include <linux/iommu.h>
 #include <linux/pci-p2pdma.h>
 #include <linux/pm_runtime.h>
 
@@ -68,6 +69,33 @@ static struct amdgpu_device *dma_buf_attach_adev(struct dma_buf_attachment *atta
 	return NULL;
 }
 
+/**
+ * amdgpu_dma_buf_is_p2p_addressable - Check if importer can DMA-map exporter BAR
+ *
+ * @adev: exporter amdgpu_device
+ * @attach: DMA-buf attachment
+ *
+ * Returns:
+ * True if the importing device can address the exporter's CPU-visible VRAM
+ * aperture either via IOMMU DMA remapping or directly within its DMA mask.
+ */
+static bool amdgpu_dma_buf_is_p2p_addressable(struct amdgpu_device *adev,
+					      struct dma_buf_attachment *attach)
+{
+	struct iommu_domain *domain = iommu_get_domain_for_dev(attach->dev);
+	resource_size_t aper_limit;
+
+	if (domain && (domain->type == IOMMU_DOMAIN_DMA ||
+		       domain->type == IOMMU_DOMAIN_DMA_FQ))
+		return true;
+
+	if (!adev->gmc.aper_size)
+		return false;
+
+	aper_limit = adev->gmc.aper_base + adev->gmc.aper_size - 1;
+	return aper_limit <= dma_get_mask(attach->dev);
+}
+
 /**
  * amdgpu_dma_buf_attach - &dma_buf_ops.attach implementation
  *
@@ -98,7 +126,8 @@ static int amdgpu_dma_buf_attach(struct dma_buf *dmabuf,
 		attach->peer2peer = false;
 
 	if (!amdgpu_dmabuf_is_xgmi_accessible(attach_adev, bo) &&
-	    pci_p2pdma_distance(adev->pdev, attach->dev, false) < 0)
+	    (pci_p2pdma_distance(adev->pdev, attach->dev, false) < 0 ||
+	     !amdgpu_dma_buf_is_p2p_addressable(adev, attach)))
 		attach->peer2peer = false;
 
 	/*
-- 
2.56.0.385.gac671c819a-goog

