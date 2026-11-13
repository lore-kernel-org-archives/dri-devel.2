Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EFE606A332
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 21:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=SZLbHbU5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB18C10ECCB;
	Fri, 13 Nov 2026 21:59:25 +0000 (UTC)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by gabe.freedesktop.org (Postfix) with ESMTP id 19DF710ECA0
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 21:59:19 +0000 (UTC)
Received: by linux.microsoft.com (Postfix, from userid 1216)
 id 7AB4220B7169; Fri, 13 Nov 2026 13:59:14 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7AB4220B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1794607154;
 bh=7ifjFCac933JF6hRAF3X68K0PAA4uFjFHVSURYbAqFA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=SZLbHbU5SwTPfmEDtQdZsCuIDA6foZLsRz8hfs1JOuf2i6YuGm3UT0LLULWnJubVj
 LyYe/r1WXh6/EzH00EpIgjPUbGViO98NblPzY1DOa0alZd6VW+AJhYGPrRZ1AoEC7O
 hIxUveqAbKeuBg9fI8tUsErAziYPTheiNtlyi81M=
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: dri-devel@lists.freedesktop.org
Cc: Dexuan Cui <decui@microsoft.com>,
 Saurabh Sengar <ssengar@linux.microsoft.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 linux-hyperv@vger.kernel.org, linux-hardening@vger.kernel.org,
 Michael Kelley <mhklinux@outlook.com>,
 Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Subject: [PATCH 2/2] drm/hyperv: batch dirty rectangles
Date: Fri, 13 Nov 2026 16:58:43 -0500
Message-ID: <20261113215843.1939889-3-hamzamahfooz@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261113215843.1939889-1-hamzamahfooz@linux.microsoft.com>
References: <20261113215843.1939889-1-hamzamahfooz@linux.microsoft.com>
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

Every damage clip of a primary plane update is sent to the host in a
dirt message of its own, although a dirt message can hold up to 255
rectangles and updates may come with many clips, e.g. up to 256 from
the DIRTYFB ioctl.

So, collect the clips of an update in one message instead, and send it
once all of them were copied to VRAM, or earlier whenever it is full.
The panic handler keeps sending a message of its own, as it may
interrupt a plane update.

Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
---
 drivers/gpu/drm/hyperv/hyperv_drm.h         |  6 ++
 drivers/gpu/drm/hyperv/hyperv_drm_drv.c     |  4 ++
 drivers/gpu/drm/hyperv/hyperv_drm_modeset.c |  3 +-
 drivers/gpu/drm/hyperv/hyperv_drm_proto.c   | 69 +++++++++++++++++----
 4 files changed, 68 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/hyperv/hyperv_drm.h b/drivers/gpu/drm/hyperv/hyperv_drm.h
index 6006d665343b..c17f06f18232 100644
--- a/drivers/gpu/drm/hyperv/hyperv_drm.h
+++ b/drivers/gpu/drm/hyperv/hyperv_drm.h
@@ -47,6 +47,8 @@ struct hv_drm_cursor {
 	u8 msg_buf[VMBUS_MAX_PACKET_SIZE];
 };
 
+struct synthvid_msg;
+
 struct hv_drm_device {
 	/* drm */
 	struct drm_device dev;
@@ -73,6 +75,7 @@ struct hv_drm_device {
 	struct completion wait;
 	u32 mmio_megabytes;
 	bool dirt_needed;
+	struct synthvid_msg *dirt_msg;
 
 	u8 init_buf[VMBUS_MAX_PACKET_SIZE];
 	u8 recv_buf[VMBUS_MAX_PACKET_SIZE];
@@ -96,6 +99,9 @@ int hv_drm_cursor_init(struct hv_drm_device *hv);
 void hv_drm_cursor_set_hidden(struct hv_drm_cursor *cursor);
 void hv_drm_update_cursor(struct hv_drm_device *hv, bool shape);
 void hv_drm_restore_cursor(struct hv_drm_device *hv);
+int hv_drm_dirt_init(struct hv_drm_device *hv);
+void hv_drm_flush_dirt(struct hv_drm_device *hv);
+void hv_drm_add_dirt(struct hv_drm_device *hv, const struct drm_rect *rect);
 int hv_drm_update_dirt(struct hv_device *hdev, struct drm_rect *rect);
 int hv_drm_connect_vsp(struct hv_device *hdev);
 void hv_drm_disconnect_vsp(struct hv_device *hdev);
diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
index 21e5fcc3eb68..56995eaec4d1 100644
--- a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
+++ b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
@@ -124,6 +124,10 @@ static int hv_drm_vmbus_probe(struct hv_device *hdev,
 	if (ret)
 		goto err_hv_set_drv_data;
 
+	ret = hv_drm_dirt_init(hv);
+	if (ret)
+		goto err_hv_set_drv_data;
+
 	ret = hv_drm_connect_vsp(hdev);
 	if (ret) {
 		drm_err(dev, "Failed to connect to vmbus.\n");
diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c b/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
index 177f804dca0c..b04b0a30a1c1 100644
--- a/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
+++ b/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
@@ -217,8 +217,9 @@ static void hv_drm_plane_atomic_update(struct drm_plane *plane,
 			continue;
 
 		hv_drm_blit_to_vram_rect(new_state->fb, &shadow_plane_state->data[0], &damage);
-		hv_drm_update_dirt(hv->hdev, &damage);
+		hv_drm_add_dirt(hv, &damage);
 	}
+	hv_drm_flush_dirt(hv);
 }
 
 static int hv_drm_plane_get_scanout_buffer(struct drm_plane *plane,
diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
index 81ffb88ba6a1..1f35a32858e4 100644
--- a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
+++ b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
@@ -133,10 +133,12 @@ struct rect {
 	s32 x2, y2; /* bottom right corner, exclusive */
 } __packed;
 
+#define SYNTHVID_MAX_DIRT_COUNT 255
+
 struct synthvid_dirt {
 	u8 video_output;
 	u8 dirt_count;
-	struct rect rect[1];
+	struct rect rect[] __counted_by(dirt_count);
 } __packed;
 
 #define SYNTHVID_EDID_BLOCK_SIZE	128
@@ -442,6 +444,57 @@ int hv_drm_cursor_init(struct hv_drm_device *hv)
 	return 0;
 }
 
+int hv_drm_dirt_init(struct hv_drm_device *hv)
+{
+	hv->dirt_msg = drmm_kzalloc(&hv->dev,
+				    offsetof(struct synthvid_msg, dirt) +
+				    struct_size_t(struct synthvid_dirt, rect,
+						  SYNTHVID_MAX_DIRT_COUNT),
+				    GFP_KERNEL);
+
+	return hv->dirt_msg ? 0 : -ENOMEM;
+}
+
+static void hv_drm_add_dirt_rect(struct synthvid_dirt *dirt,
+				 const struct drm_rect *rect)
+{
+	u8 idx = dirt->dirt_count++;
+	struct rect *r = &dirt->rect[idx];
+
+	r->x1 = rect->x1;
+	r->y1 = rect->y1;
+	r->x2 = rect->x2;
+	r->y2 = rect->y2;
+}
+
+static int hv_drm_send_dirt(struct hv_device *hdev, struct synthvid_msg *msg)
+{
+	msg->vid_hdr.type = SYNTHVID_DIRT;
+	msg->vid_hdr.size = sizeof(struct synthvid_msg_hdr) +
+		struct_size(&msg->dirt, rect, msg->dirt.dirt_count);
+	msg->dirt.video_output = 0;
+
+	return hv_drm_sendpacket(hdev, msg);
+}
+
+void hv_drm_flush_dirt(struct hv_drm_device *hv)
+{
+	struct synthvid_msg *msg = hv->dirt_msg;
+
+	if (msg->dirt.dirt_count && hv->dirt_needed)
+		hv_drm_send_dirt(hv->hdev, msg);
+
+	msg->dirt.dirt_count = 0;
+}
+
+void hv_drm_add_dirt(struct hv_drm_device *hv, const struct drm_rect *rect)
+{
+	if (hv->dirt_msg->dirt.dirt_count == SYNTHVID_MAX_DIRT_COUNT)
+		hv_drm_flush_dirt(hv);
+
+	hv_drm_add_dirt_rect(&hv->dirt_msg->dirt, rect);
+}
+
 int hv_drm_update_dirt(struct hv_device *hdev, struct drm_rect *rect)
 {
 	struct hv_drm_device *hv = hv_get_drvdata(hdev);
@@ -451,18 +504,8 @@ int hv_drm_update_dirt(struct hv_device *hdev, struct drm_rect *rect)
 		return 0;
 
 	memset(&msg, 0, sizeof(struct synthvid_msg));
-
-	msg.vid_hdr.type = SYNTHVID_DIRT;
-	msg.vid_hdr.size = sizeof(struct synthvid_msg_hdr) +
-		sizeof(struct synthvid_dirt);
-	msg.dirt.video_output = 0;
-	msg.dirt.dirt_count = 1;
-	msg.dirt.rect[0].x1 = rect->x1;
-	msg.dirt.rect[0].y1 = rect->y1;
-	msg.dirt.rect[0].x2 = rect->x2;
-	msg.dirt.rect[0].y2 = rect->y2;
-
-	hv_drm_sendpacket(hdev, &msg);
+	hv_drm_add_dirt_rect(&msg.dirt, rect);
+	hv_drm_send_dirt(hdev, &msg);
 
 	return 0;
 }
-- 
2.56.0

