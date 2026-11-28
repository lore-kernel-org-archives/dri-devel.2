Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63F5606A31E
	for <dri-devel@archiver.kernel.org>; Sat, 28 Nov 2026 06:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.a=rsa-sha256 header.s=google header.b=oops9jnV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E02F510E273;
	Sat, 28 Nov 2026 06:39:16 +0000 (UTC)
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A98F10E17F
 for <dri-devel@lists.freedesktop.org>; Sat, 28 Nov 2026 06:39:09 +0000 (UTC)
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-cddc250d815so3387921a12.2
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 22:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=furiosa.ai; s=google; t=1795847949; x=1796452749; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7/KIItuSkOccTTrf3OQEivNTHfzC9rlU/LCr+peVUCg=;
 b=oops9jnVuPKahVe3CUNk85f4HBAQCyWOFw2IaYq0tvylCJon90v1vfUY9e0QuFC9c6
 9PqO7o1WhoN/1wRl6csYqMkOuog+uEA9kyhQFARS6o/+JOG7rSD0mLCdJXRqJPiwLK0/
 mCRolxnqBKnaZ0xLFmCG++tHgkz8uSxXneNvg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795847949; x=1796452749;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7/KIItuSkOccTTrf3OQEivNTHfzC9rlU/LCr+peVUCg=;
 b=I0D2s3Rn0PXTEElW+g8qV+h+1h+UUHO9dV5DaopYhcOzGUtaL6w3F26d3ylFpW6AwD
 CJK+H4K8q4ye/+Pgv6oZe7VprfruneGqLsA2WL5WOLELlxOLuvCQ2Im5Hru48ejo+wYV
 CHmsCKaBY86U3ULumWyivxfPbT11MqtMoLUZ7FNBsuU7vAYphim0LZTd0HWqGYQihZgo
 4GhUTO8C1AtP8HwGx5oWZAtLfVpEbkL4Yp5J012Tld4BgbDbbR4MBgT4lOqUpwoRBq2f
 Yd/FjLjLwJtgrCY00BITApiGnHt5h+qsMhIpgiKxdSCyDx4tj2BURiQVuwN0WiYRfkSJ
 53Gg==
X-Forwarded-Encrypted: i=1;
 AL+hErFl02MSRA/2+l6VDwI0dSFAiFoxq7kcoYrXiCp5L9kYQWkWfeg20wlKw2gpdOXGTF0c9aTeniD76Gs=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+9DIpNWpLctWVsK8rvVgpX1WZc4OGMjA5Ri5iCNEssf+9Ei4sn
 Nf2LXQoK/7kRDZqTMjEjf5PrmhJfKUjDYGjFczoUIeIaAiBgd9sNVx9wTfA7dFoLFKQ=
X-Gm-Gg: AZFdTZeWP9L9Ga6py2devfbiro20pFH4G4bJhb+WGLQrRRwmEQW5rWMB+2MLPORgDmJ
 juQnFKKMmfrHK342Q4Q3U94ti64F9iSn/sRiClfZkUiSFOb3iZmU2iEPNn1Ttzm82QJd8bEZ7W7
 1L5d71h2PPZSrED/RY2MUKB1jpJQPx5zuzcNY+XDwSM1SjIbIU2t8uA35CStjp9i7oVPQD2sSin
 gawQWLG0KcVBtPU4knGMuh/HwBmXf+QRo34mqePDL/4O8cjP840pylrIgmJyhYOo3OBbWPGErxC
 DdsxZRABxNKazQw68qjy3aWyKc9GsSJ9Qr84FitCh0RjAxHteZqkh7R1ZDzPQxBMZjGJ7mo9eAH
 Wdg63rhTsmCYkdE4j8L7PP25yaqDvkFTfledGORisdc+yEkzsPqQMjUskiwnWnPlN389TnfTpSZ
 V8f+C9zZT9i9m0vgF0qXvO2SvY/pIZlCNobCqUMjuEMUai2BZ8Z+FBcyni4a+ZUKwItew2F/Olw
 XARUPxvBIGp8nw1QNOuFvyuA9ANnBiVN1scuMRF+WjiN1QoTk+V0VhZ74vT01p45pgK9iezbmmM
 FraHZmc5Yst011caUpR/XDPO+OiQ8CZbgpBGVE7++QwBLxdW/bBL7CRQtJWs5TGCiD0oqvRSSwr
 b1LQbj0bxnCd4
X-Received: by 2002:a05:6300:278a:10b0:3f9:797f:385a with SMTP id
 adf61e73a8af0-407235c3a0cmr11591887637.15.1795847948803; 
 Fri, 27 Nov 2026 22:39:08 -0800 (PST)
Received: from rock-5b-plus ([61.83.209.48]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8c87077944bsm13939838b3a.2.2026.11.27.22.39.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 22:39:08 -0800 (PST)
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>,
	Oded Gabbay <ogabbay@kernel.org>
Cc: Heiko Stuebner <heiko@sntech.de>, Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Haoming Gao <Naixumogu@whut.edu.cn>, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 Sidong Yang <sidong.yang@furiosa.ai>, stable@vger.kernel.org
Subject: [PATCH 2/4] accel/rocket: Fix iommu_map_sgtable() return handling in
 create_bo
Date: Sat, 28 Nov 2026 15:38:42 +0900
Message-ID: <20261128063844.1537615-3-sidong.yang@furiosa.ai>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261128063844.1537615-1-sidong.yang@furiosa.ai>
References: <20261128063844.1537615-1-sidong.yang@furiosa.ai>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

iommu_map_sgtable() returns ssize_t, not int. Storing its return value
in int ret truncates any mapping of 2 GiB or larger (reachable via the
__u32 args->size) to a negative value. The error path then removes the
drm_mm node without calling iommu_unmap(), leaking the IOMMU mapping and
causing subsequent allocations at the same IOVA to fail.

In addition, if iommu_map_sgtable() ever returns a short mapping, the
error path fails to unmap the already mapped range, and the drm_mm node
was sized from the unaligned args->size rather than gem_obj->size.

Store the return value of iommu_map_sgtable() in ssize_t, size the
drm_mm node from gem_obj->size, propagate negative errors directly, and
unmap partial mappings before returning -ENOMEM.

Fixes: 658ebeac3351 ("accel/rocket: Add IOCTL for BO creation")
Cc: stable@vger.kernel.org
Signed-off-by: Sidong Yang <sidong.yang@furiosa.ai>
---
 drivers/accel/rocket/rocket_gem.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/accel/rocket/rocket_gem.c b/drivers/accel/rocket/rocket_gem.c
index 9f3d85e3dd30..e52fc6ea7cf0 100644
--- a/drivers/accel/rocket/rocket_gem.c
+++ b/drivers/accel/rocket/rocket_gem.c
@@ -67,6 +67,7 @@ int rocket_ioctl_create_bo(struct drm_device *dev, void *data, struct drm_file *
 	struct rocket_vm *vm;
 	struct sg_table *sgt;
 	size_t size = PAGE_ALIGN((size_t)args->size);
+	ssize_t mapped;
 	int ret;
 
 	if (!size)
@@ -81,7 +82,7 @@ int rocket_ioctl_create_bo(struct drm_device *dev, void *data, struct drm_file *
 
 	vm = rocket_vm_get(rocket_priv);
 	rkt_obj->vm = vm;
-	rkt_obj->size = args->size;
+	rkt_obj->size = gem_obj->size;
 	rkt_obj->offset = 0;
 
 	sgt = drm_gem_shmem_get_pages_sgt(shmem_obj);
@@ -98,19 +99,27 @@ int rocket_ioctl_create_bo(struct drm_device *dev, void *data, struct drm_file *
 	if (ret)
 		goto err;
 
-	ret = iommu_map_sgtable(vm->domain,
-				rkt_obj->mm.start,
-				shmem_obj->sgt,
-				IOMMU_READ | IOMMU_WRITE);
-	if (ret < 0 || ret < args->size) {
-		drm_err(dev, "failed to map buffer: size=%d request_size=%u\n",
-			ret, args->size);
+	mapped = iommu_map_sgtable(vm->domain,
+				   rkt_obj->mm.start,
+				   shmem_obj->sgt,
+				   IOMMU_READ | IOMMU_WRITE);
+	if (mapped < 0) {
+		drm_err(dev, "failed to map buffer: err=%zd request_size=%zu\n",
+			mapped, gem_obj->size);
+		ret = mapped;
+		goto err_remove_node;
+	}
+	if ((size_t)mapped < gem_obj->size) {
+		drm_err(dev, "failed to map buffer: size=%zd request_size=%zu\n",
+			mapped, gem_obj->size);
+		if (mapped)
+			iommu_unmap(vm->domain, rkt_obj->mm.start, mapped);
 		ret = -ENOMEM;
 		goto err_remove_node;
 	}
 
 	/* iommu_map_sgtable might have aligned the size */
-	rkt_obj->size = ret;
+	rkt_obj->size = mapped;
 	args->offset = drm_vma_node_offset_addr(&gem_obj->vma_node);
 	args->dma_address = rkt_obj->mm.start;
 
-- 
2.53.0

