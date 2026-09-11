Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29029C88E45
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 14:42:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69CC388FAE;
	Fri, 11 Sep 2026 14:42:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="fUL6+2ry";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DEF388FAE
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 14:42:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1789137734; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=brY5/I/IU3glConP221EXqrkTgS0z2b30CDw+GEgnpKZVTGc9G0sX+eWx7e3+c1dowNNf/h4QVQ1yCGFqeiud4mph4fkzrC6+8Q2Ms1EGN0WkZk/UHE/DAJfsqYjLHqgCAIL6PQ8WYNdX1TIhY9X9pyrCxfHGn4vK3bogr1QcqM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1789137734;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=rxsslYv3tWD36EWcz86ZGSWyt5LVhADlqJgn1u33jEk=; 
 b=EOt9Be874NalLmk+D+NIYrSCJt3ZQDDIuFQDSPRJ750OgaeOO+ZW4lgNi24FbQEqTyrW+J571rw55e60G9JkSM7/iB/LMNkmpF2pxiip9afeTxSrNR8nif66KIfIJUvm1DtoHrKRirbt28mwmI8PASuto8QK/hTuVF1ES38ABXk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789137734; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=rxsslYv3tWD36EWcz86ZGSWyt5LVhADlqJgn1u33jEk=;
 b=fUL6+2ryaRas5ID4lRAasjvDVxliG75y7gQkN7S6CyyIGAd0W1idB8buIAb59bhD
 pDTTeHIdQPkPaMclkklOTfzdFW2UgRk/pe6xn3lbWGn81S2Ii3QjyBWZwkSMtx0IE/U
 KYMfG/Ujc4MEX9a9mtJ7t+meDVK952eo6BqhjkIY=
Received: by mx.zohomail.com with SMTPS id 1789137733042390.7448294474557;
 Fri, 11 Sep 2026 07:42:13 -0700 (PDT)
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Chia-I Wu <olvaffe@gmail.com>, Val Packett <val@invisiblethingslab.com>
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, Yiwei Zhang <zzyiwei@gmail.com>
Subject: [PATCH v1] Revert "drm/virtio: Allow importing prime buffers when 3D
 is enabled"
Date: Fri, 11 Sep 2026 17:42:03 +0300
Message-ID: <20260911144204.2089401-1-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Guest userspace may import udmabuf to vrend. Vrend doesn't support guest
blobs, and thus, further 3d operations with the imported blob are failing.
Typical scenario of the problem shown with mouse cursor RGBA image imported
into virtio-gpu, which previously was rejected by virtio-gpu driver.
Revert enabling guest blobs importing into vrend to fix the regression.

Link: https://gitlab.freedesktop.org/virgl/virglrenderer/-/work_items/674
Fixes: df4dc947c46b ("drm/virtio: Allow importing prime buffers when 3D is enabled")
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/gpu/drm/virtio/virtgpu_prime.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_prime.c b/drivers/gpu/drm/virtio/virtgpu_prime.c
index 149e6bcb5878..ebf471044d06 100644
--- a/drivers/gpu/drm/virtio/virtgpu_prime.c
+++ b/drivers/gpu/drm/virtio/virtgpu_prime.c
@@ -349,7 +349,7 @@ struct drm_gem_object *virtgpu_gem_prime_import(struct drm_device *dev,
 		}
 	}
 
-	if (!vgdev->has_resource_blob)
+	if (!vgdev->has_resource_blob || vgdev->has_virgl_3d)
 		return drm_gem_prime_import(dev, buf);
 
 	bo = kzalloc_obj(*bo);
-- 
2.55.0

