Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39765606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 09:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=EaOa7kKM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B01B10F475;
	Tue, 20 Oct 2026 09:56:06 +0000 (UTC)
X-Greylist: delayed 402 seconds by postgrey-1.36 at gabe;
 Tue, 20 Oct 2026 09:55:59 UTC
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D10D210F482
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 09:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Ei
 RTXA8tWnpKHyyK9Kym502kD2EE1/XY6ULlSm9bIHI=; b=EaOa7kKMRj2/BYSNL5
 UMPjHNXFzG2Xlp2i9cnpS/Bp4AX6kd5ew/sm3sl3a2ZFhb6NhgKkz41JH6p0wbXU
 xPbDti05bUxdEX0UjqhTuqZTSnIez2TPaws1tDQ/v1+0l4cKeO/0O5BbVWLLlqQk
 qq4IaebX6o57DyWRCmANU/yf8=
Received: from localhost.localdomain (unknown [])
 by gzsmtp3 (Coremail) with SMTP id PigvCgD3P1nwONdqe1PyAw--.25428S2;
 Tue, 20 Oct 2026 17:48:33 +0800 (CST)
From: oushixiong1025@163.com
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Dave Airlie <airlied@redhat.com>, Sean Paul <sean@poorly.run>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Shixiong Ou <oushixiong@kylinos.cn>
Subject: [PATCH] drm/udl: fail fast on stalled URB pool
Date: Tue, 20 Oct 2026 17:48:30 +0800
Message-Id: <20261020094830.695425-1-oushixiong1025@163.com>
X-Mailer: git-send-email 2.25.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: PigvCgD3P1nwONdqe1PyAw--.25428S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Gr1xXryruw45tF1ktw17GFg_yoWxGFW7pF
 4UJa4YyrW8ZFWakr13Ja1kCr43J3WfKa97G3yxGasa9w15Kr95Jas5CryYgFyDJrW3GF12
 qrn2vrs0kF4Yyr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jn4SrUUUUU=
X-CM-SenderInfo: xrxvxxx0lr0wirqskqqrwthudrp/xtbC4RHa6WrXOPFCIwAA3W
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Shixiong Ou <oushixiong@kylinos.cn>

A stalled device never returns its URBs, so every allocation waited
out the full timeout and stalled the display stack on each operation.
Flag the stall and fail fast until an URB comes back; give damage a
short timeout and keep the long one for modeset.

Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
---
 drivers/gpu/drm/udl/udl_drv.h      | 14 +++++++++++++-
 drivers/gpu/drm/udl/udl_main.c     | 30 +++++++++++++++++++++++++-----
 drivers/gpu/drm/udl/udl_modeset.c  |  6 +++---
 drivers/gpu/drm/udl/udl_transfer.c |  2 +-
 4 files changed, 42 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/udl/udl_drv.h b/drivers/gpu/drm/udl/udl_drv.h
index 145bb95ccc48..43cff97e12f7 100644
--- a/drivers/gpu/drm/udl/udl_drv.h
+++ b/drivers/gpu/drm/udl/udl_drv.h
@@ -11,6 +11,7 @@
 #ifndef UDL_DRV_H
 #define UDL_DRV_H
 
+#include <linux/jiffies.h>
 #include <linux/mm_types.h>
 #include <linux/usb.h>
 
@@ -46,6 +47,7 @@ struct urb_list {
 	int available;
 	int count;
 	size_t size;
+	bool wedged;
 };
 
 struct udl_device {
@@ -72,7 +74,17 @@ static inline struct usb_device *udl_to_usb_device(struct udl_device *udl)
 int udl_modeset_init(struct udl_device *udl);
 struct drm_connector *udl_connector_init(struct drm_device *dev);
 
-struct urb *udl_get_urb(struct udl_device *udl);
+/*
+ * How long to wait for a free URB before giving up.  The damage path runs
+ * on every atomic update, so keep its timeout short: a stalled device never
+ * returns its URBs and the wait would otherwise stall the whole display
+ * stack on every operation.  Modeset is low-frequency and worth waiting
+ * longer for.  Once the pool is flagged wedged, neither path blocks at all.
+ */
+#define UDL_GET_URB_TIMEOUT_DAMAGE	msecs_to_jiffies(100)
+#define UDL_GET_URB_TIMEOUT_MODESET	msecs_to_jiffies(2000)
+
+struct urb *udl_get_urb(struct udl_device *udl, long timeout);
 
 int udl_submit_urb(struct udl_device *udl, struct urb *urb, size_t len);
 void udl_sync_pending_urbs(struct udl_device *udl);
diff --git a/drivers/gpu/drm/udl/udl_main.c b/drivers/gpu/drm/udl/udl_main.c
index 17950fe3a0ec..b92cd5300030 100644
--- a/drivers/gpu/drm/udl/udl_main.c
+++ b/drivers/gpu/drm/udl/udl_main.c
@@ -169,6 +169,7 @@ void udl_urb_completion(struct urb *urb)
 	spin_lock_irqsave(&udl->urbs.lock, flags);
 	list_add_tail(&unode->entry, &udl->urbs.list);
 	udl->urbs.available++;
+	udl->urbs.wedged = false;
 	spin_unlock_irqrestore(&udl->urbs.lock, flags);
 
 	wake_up(&udl->urbs.sleep);
@@ -213,6 +214,7 @@ static int udl_alloc_urb_list(struct udl_device *udl, int count, size_t size)
 	init_waitqueue_head(&udl->urbs.sleep);
 	udl->urbs.count = 0;
 	udl->urbs.available = 0;
+	udl->urbs.wedged = false;
 
 retry:
 	udl->urbs.size = size;
@@ -265,16 +267,34 @@ static struct urb *udl_get_urb_locked(struct udl_device *udl, long timeout)
 
 	assert_spin_locked(&udl->urbs.lock);
 
+	/* A device that stopped completing transfers will never wake us up:
+	 * fail fast instead of stalling callers for the full timeout on every
+	 * call.  Allocations for teardown (MAX_SCHEDULE_TIMEOUT) still wait,
+	 * since the USB core returns all URBs on disconnect.
+	 */
+	if (udl->urbs.wedged && timeout != MAX_SCHEDULE_TIMEOUT) {
+		if (list_empty(&udl->urbs.list))
+			return NULL;
+		goto take;
+	}
+
 	/* Wait for an in-flight buffer to complete and get re-queued */
 	if (!wait_event_lock_irq_timeout(udl->urbs.sleep,
 					 !udl->urbs.count ||
 					 !list_empty(&udl->urbs.list),
 					 udl->urbs.lock, timeout)) {
-		DRM_INFO("wait for urb interrupted: available: %d\n",
-			 udl->urbs.available);
+		if (timeout == MAX_SCHEDULE_TIMEOUT) {
+			DRM_INFO("wait for urb interrupted: available: %d\n",
+				 udl->urbs.available);
+		} else {
+			udl->urbs.wedged = true;
+			drm_warn_ratelimited(&udl->drm,
+				"no URB returned within %u ms (available %d); device stalled, dropping frames\n",
+				jiffies_to_msecs(timeout), udl->urbs.available);
+		}
 		return NULL;
 	}
-
+take:
 	if (!udl->urbs.count)
 		return NULL;
 
@@ -285,12 +305,12 @@ static struct urb *udl_get_urb_locked(struct udl_device *udl, long timeout)
 	return unode->urb;
 }
 
-struct urb *udl_get_urb(struct udl_device *udl)
+struct urb *udl_get_urb(struct udl_device *udl, long timeout)
 {
 	struct urb *urb;
 
 	spin_lock_irq(&udl->urbs.lock);
-	urb = udl_get_urb_locked(udl, HZ * 2);
+	urb = udl_get_urb_locked(udl, timeout);
 	spin_unlock_irq(&udl->urbs.lock);
 	return urb;
 }
diff --git a/drivers/gpu/drm/udl/udl_modeset.c b/drivers/gpu/drm/udl/udl_modeset.c
index 289711035b67..c907846048f8 100644
--- a/drivers/gpu/drm/udl/udl_modeset.c
+++ b/drivers/gpu/drm/udl/udl_modeset.c
@@ -218,7 +218,7 @@ static int udl_handle_damage(struct drm_framebuffer *fb,
 		return ret;
 	log_bpp = ret;
 
-	urb = udl_get_urb(udl);
+	urb = udl_get_urb(udl, UDL_GET_URB_TIMEOUT_DAMAGE);
 	if (!urb)
 		return -ENOMEM;
 	cmd = urb->transfer_buffer;
@@ -342,7 +342,7 @@ static void udl_crtc_helper_atomic_enable(struct drm_crtc *crtc, struct drm_atom
 	if (!drm_dev_enter(dev, &idx))
 		return;
 
-	urb = udl_get_urb(udl);
+	urb = udl_get_urb(udl, UDL_GET_URB_TIMEOUT_MODESET);
 	if (!urb) {
 		drm_err_ratelimited(dev, "get urb failed when enabling crtc\n");
 		goto out;
@@ -377,7 +377,7 @@ static void udl_crtc_helper_atomic_disable(struct drm_crtc *crtc, struct drm_ato
 	if (!drm_dev_enter(dev, &idx))
 		return;
 
-	urb = udl_get_urb(udl);
+	urb = udl_get_urb(udl, UDL_GET_URB_TIMEOUT_MODESET);
 	if (!urb)
 		goto out;
 
diff --git a/drivers/gpu/drm/udl/udl_transfer.c b/drivers/gpu/drm/udl/udl_transfer.c
index 7d670b3a5293..bfff17bba58d 100644
--- a/drivers/gpu/drm/udl/udl_transfer.c
+++ b/drivers/gpu/drm/udl/udl_transfer.c
@@ -202,7 +202,7 @@ int udl_render_hline(struct udl_device *udl, int log_bpp, struct urb **urb_ptr,
 			int ret = udl_submit_urb(udl, urb, len);
 			if (ret)
 				return ret;
-			urb = udl_get_urb(udl);
+			urb = udl_get_urb(udl, UDL_GET_URB_TIMEOUT_DAMAGE);
 			if (!urb)
 				return -EAGAIN;
 			*urb_ptr = urb;
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus

