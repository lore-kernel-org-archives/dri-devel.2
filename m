Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DA29C43458
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 15:02:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0E8E10F5FB;
	Fri, 26 Jun 2026 15:02:33 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45F5110F5FB
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 15:02:32 +0000 (UTC)
Received: from localhost.localdomain (unknown [117.182.75.66])
 by APP-01 (Coremail) with SMTP id qwCowAB3GtOBlD5qi1BrAw--.4034S2;
 Fri, 26 Jun 2026 23:02:27 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: Zack Rusin <zack.rusin@broadcom.com>,
	dri-devel@lists.freedesktop.org
Cc: bcm-kernel-feedback-list@broadcom.com,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Thomas Hellstrom <thellstrom@vmware.com>,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 WenTao Liang <vulab@iscas.ac.cn>
Subject: [PATCH] fix: drm/vmwgfx: vmw_simple_resource_create_ioctl: fix base
 object refcount leak on ttm_base_object_init failure
Date: Fri, 26 Jun 2026 23:02:24 +0800
Message-Id: <20260626150224.49792-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowAB3GtOBlD5qi1BrAw--.4034S2
X-Coremail-Antispam: 1UD129KBjvJXoWrurWrJFyDJFy5AFyxXw4xWFg_yoW8Jr1Dpr
 4fJrW3Gry5JrWIqrZrAa1kJFs7A3Wq9F4rKFyFkwsxZ3Wqvr9rJws8CrZ0vF1DCrZ3Ar4a
 qr1kArWkuFyDAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUU9214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
 JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
 CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
 2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
 W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
 Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
 0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
 zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr
 1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_
 JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYx
 BIdaVFxhVjvjDU0xZFpf9x0JUgXocUUUUU=
X-Originating-IP: [117.182.75.66]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgYKA2o+h0EmQQAAs8
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

ttm_base_object_init unconditionally acquires a base object reference via
  kref_init. When it fails, the error path only calls
  vmw_resource_unreference but never calls ttm_base_object_unref to release
  the base object reference, causing a refcount leak.

Add ttm_base_object_unref in the error path to properly release the base
  object reference when ttm_base_object_init fails.

Cc: stable@vger.kernel.org
Fixes: 0b8762e997df ("drm/ttm, drm/vmwgfx: Move the lock- and object functionality to the vmwgfx driver")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_simple_resource.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_simple_resource.c b/drivers/gpu/drm/vmwgfx/vmwgfx_simple_resource.c
index 0d51b4542269..05f0f5544142 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_simple_resource.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_simple_resource.c
@@ -176,6 +176,7 @@ vmw_simple_resource_create_ioctl(struct drm_device *dev, void *data,
 
 	if (ret) {
 		vmw_resource_unreference(&tmp);
+		ttm_base_object_unref(&usimple->base);
 		goto out_err;
 	}
 
-- 
2.39.5 (Apple Git-154)

