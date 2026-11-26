Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBAD606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 08:09:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33095112108;
	Thu, 26 Nov 2026 08:09:42 +0000 (UTC)
X-Greylist: delayed 398 seconds by postgrey-1.36 at gabe;
 Thu, 26 Nov 2026 08:07:33 UTC
Received: from sniper.uos.ac.kr (sniper2.uos.ac.kr [203.249.96.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 697ED10E2DB
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 08:07:33 +0000 (UTC)
Received: from unknown (HELO localhost.taild276f1.ts.net)
 (love09010224@uos.ac.kr@1.229.202.195)
 by 203.249.96.39 with ESMTP; 26 Nov 2026 17:00:51 +0900
X-Original-SENDERIP: 1.229.202.195
X-Original-SENDERCOUNTRY: KR, South Korea 
X-Original-MAILFROM: love09010224@uos.ac.kr
X-Original-RCPTTO: airlied@redhat.com, kraxel@redhat.com,
 dmitry.osipenko@collabora.com, gurchetansingh@chromium.org,
 olvaffe@gmail.com, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux.dev, security@kernel.org
From: Seojin An <love09010224@uos.ac.kr>
To: David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Gurchetan Singh <gurchetansingh@chromium.org>,
 Chia-I Wu <olvaffe@gmail.com>, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux.dev, security@kernel.org
Subject: [PATCH] drm/virtio: bound execbuffer commands to control queue size
Date: Thu, 26 Nov 2026 17:00:44 +0900
Message-ID: <20261126080044.2898223-1-love09010224@uos.ac.kr>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 26 Nov 2026 08:08:59 +0000
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

DRM_IOCTL_VIRTGPU_EXECBUFFER accepts a user-controlled command size and
stores the command in vmalloc memory. virtio-gpu maps each command page to
one SG entry, then adds a request and response entry before submitting the
chain to the control virtqueue.

With indirect descriptors negotiated, the driver accounts for the chain as
one free ring descriptor. An unprivileged render client can therefore
submit more SG entries than the device Queue Size. A sufficiently large
command also exceeds the u16 index range of a split indirect table, causing
the final SG entries to replace the request and first command descriptors
after the next index wraps.

Reject commands whose page count plus the fixed request and response
exceeds the actual control Queue Size. Perform the check before command
copy, object reservation, fence allocation or queue publication.

This also avoids relying on the current queue error path:
virtio_gpu_queue_ctrl_sgs() only warns when virtqueue_add_sgs() fails, then
advances sequence and pending-command state and returns success.

In a no-vIOMMU QEMU/virgl guest, the malformed chain let a render client
substitute RESOURCE_ATTACH_BACKING, obtain guest physical read/write and
gain initial-namespace uid/euid 0. On a 256-entry control queue, 254
command pages continue to complete and 255 pages now return E2BIG.

AI tools assisted the source audit, reproducer construction and patch
drafting.

Fixes: 5edbb5608256 ("drm/virtio: fix ring free check")
Reported-by: Hyeonjun Hong <hyeonjunhong330@gmail.com>
Reported-by: GEONWOO HAN <gunwoo9643@uos.ac.kr>
Cc: stable@vger.kernel.org
Signed-off-by: Seojin An <love09010224@uos.ac.kr>
---
 drivers/gpu/drm/virtio/virtgpu_submit.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/virtio/virtgpu_submit.c b/drivers/gpu/drm/virtio/virtgpu_submit.c
index 6580ece658704..9aff7f8d5195f 100644
--- a/drivers/gpu/drm/virtio/virtgpu_submit.c
+++ b/drivers/gpu/drm/virtio/virtgpu_submit.c
@@ -482,6 +482,8 @@ int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
 	u64 fence_ctx = vgdev->fence_drv.context;
 	struct drm_virtgpu_execbuffer *exbuf = data;
 	struct virtio_gpu_submit submit;
+	u64 command_sgs;
+	unsigned int max_sgs;
 	u32 ring_idx = 0;
 	int ret = -EINVAL;
 
@@ -491,6 +493,17 @@ int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
 	if (exbuf->flags & ~VIRTGPU_EXECBUF_FLAGS)
 		return ret;
 
+	/*
+	 * The command contributes one SG entry per vmalloc page in addition
+	 * to the fixed request and response entries.  Virtio requires both
+	 * direct and indirect descriptor chains to fit the device queue.
+	 * Reject oversized commands before copying or queueing them.
+	 */
+	max_sgs = virtqueue_get_vring_size(vgdev->ctrlq.vq);
+	command_sgs = DIV_ROUND_UP((u64)exbuf->size, PAGE_SIZE);
+	if (max_sgs < 2 || command_sgs > max_sgs - 2)
+		return -E2BIG;
+
 	if (exbuf->flags & VIRTGPU_EXECBUF_RING_IDX) {
 		if (exbuf->ring_idx >= vfpriv->num_rings)
 			return ret;

base-commit: 479e381e77dcde0dfcc9d51e89ff3273da199804
-- 
2.43.0

