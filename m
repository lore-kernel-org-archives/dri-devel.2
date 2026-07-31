Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C1D7C55174
	for <dri-devel@archiver.kernel.org>; Sat,  1 Aug 2026 07:58:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEEA110E2B9;
	Sat,  1 Aug 2026 07:58:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.b="aaUVPUMh";
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="aaUVPUMh";
	dkim-atps=neutral
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 543DB10E1FC
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 09:20:48 +0000 (UTC)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=ZuF9xjCt2CNH2BQj5jWOWwh2QTh09rtVzZv+3BXi12Y=;
 b=aaUVPUMhamlKFKZ0DgLc6oX4WFVuMZneCQH7yTtlqOV/a1bqSWVJvzfnHfKW6SkD6lOBuU54Y
 /2ZX7eItLm0vU5j0Seq+YdllAh9GlXcTn/5ilYie8ErfooZkVAhr/jYFn6psCjJvYXOhS+Rjc+7
 xALE/1QJMidmHmJNr7XXIfA=
Received: from canpmsgout05.his.huawei.com (unknown [172.19.92.145])
 by szxga01-in.huawei.com (SkyGuard) with ESMTPS id 4hBKnT2x93z1BG2w
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 17:01:49 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=ZuF9xjCt2CNH2BQj5jWOWwh2QTh09rtVzZv+3BXi12Y=;
 b=aaUVPUMhamlKFKZ0DgLc6oX4WFVuMZneCQH7yTtlqOV/a1bqSWVJvzfnHfKW6SkD6lOBuU54Y
 /2ZX7eItLm0vU5j0Seq+YdllAh9GlXcTn/5ilYie8ErfooZkVAhr/jYFn6psCjJvYXOhS+Rjc+7
 xALE/1QJMidmHmJNr7XXIfA=
Received: from mail.maildlp.com (unknown [172.19.162.223])
 by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4hBKbJ1XBTz12LHh;
 Fri, 31 Jul 2026 16:53:00 +0800 (CST)
Received: from dggpemr500006.china.huawei.com (unknown [7.185.36.185])
 by mail.maildlp.com (Postfix) with ESMTPS id E361540561;
 Fri, 31 Jul 2026 17:02:28 +0800 (CST)
Received: from localhost.localdomain (10.50.85.180) by
 dggpemr500006.china.huawei.com (7.185.36.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 31 Jul 2026 17:02:27 +0800
From: Yao Kai <yaokai34@huawei.com>
To: David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, Gurchetan Singh
 <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>
CC: <dri-devel@lists.freedesktop.org>, <virtualization@lists.linux.dev>,
 <liuyongqiang13@huawei.com>, <jifa@huawei.com>
Subject: [PATCH 2/2] drm/virtio: free control buffer when scatterlist
 allocation fails
Date: Fri, 31 Jul 2026 17:22:36 +0800
Message-ID: <20260731092236.2262403-3-yaokai34@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260731092236.2262403-1-yaokai34@huawei.com>
References: <20260731092236.2262403-1-yaokai34@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.50.85.180]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemr500006.china.huawei.com (7.185.36.185)
X-Mailman-Approved-At: Sat, 01 Aug 2026 07:57:53 +0000
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

A vmalloc_to_sgt() failure leaks the control vbuffer, its data buffer,
and any GEM references held by vbuf->objs.

The queueing code owns the vbuffer by this point, but the failure path
only unlocks fenced reservations before returning -ENOMEM. No caller
reclaims the unqueued buffer.

Drop the object-array references and free the vbuffer before returning.

Fixes: e1218b8c0cc1 ("drm/virtio: Use vmalloc for command buffer allocations.")
Cc: stable@vger.kernel.org
Signed-off-by: Yao Kai <yaokai34@huawei.com>
---
 drivers/gpu/drm/virtio/virtgpu_vq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index a470339b6747..7ccc487e3332 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -477,6 +477,8 @@ static int virtio_gpu_queue_fenced_ctrl_buffer(struct virtio_gpu_device *vgdev,
 			if (!sgt) {
 				if (fence && vbuf->objs)
 					virtio_gpu_array_unlock_resv(vbuf->objs);
+				virtio_gpu_array_put_free(vbuf->objs);
+				free_vbuf(vgdev, vbuf);
 				return -ENOMEM;
 			}
 
-- 
2.43.0

