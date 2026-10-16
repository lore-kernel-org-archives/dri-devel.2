Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F191ACCA46D
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 07:35:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A60E111265D;
	Fri, 16 Oct 2026 07:35:42 +0000 (UTC)
X-Greylist: delayed 300 seconds by postgrey-1.36 at gabe;
 Fri, 16 Oct 2026 05:33:34 UTC
Received: from mta1.migadu.com (out-222.mta1.migadu.com [95.215.58.222])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1511E10E10C
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 05:33:33 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=uw7fxBE4sS4SzyBiLGjQGBSyw365kfF4L/SJZG9QNu8=; 
 c=simple/simple; d=justthetip.ca;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792128812; v=1; x=1792733612;
 b=IYRS2mo9/6M/213FGoB5qzRNfiWwSfOnbyReEst2j+vQco93Ussw9qCTtBpHvjUob/m2dUij
 MLxoTsVo37YJ7eOL3+rZR2U1h/Rjs4Uj2oPnLcI0oRIQow9HPVw+J6KQPCzQdCVAaZ5UEgWZduD
 zlpzMu0c6r20ajwF975NWBJ+phoqir6uzJAmrGydjNQOvLwiJ/Gk1//SwILZLctZ2BUF47Hli3f
 Ka4tvqcy1PVKnLPzhmL5qrGMHAg4hkqZHqaR2yjahGmApnj5gIJI8AnwnO+arMvZVAK/niG4BXS
 QWeS1dg00sCiF8aXJDMjRiNUVmA/kBjMcGeY5sCWhp5DA==
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: by smtp.migadu.com with ESMTPS id f028aeaa80b00641;
 Fri, 16 Oct 2026 05:27:28 +0000
X-Mizu-Trace-ID: f028aeaa80b00641
X-Migadu-Flow: FLOW_OUT
From: Devin Wittmayer <lucid_duck@justthetip.ca>
To: Jocelyn Falempe <jfalempe@redhat.com>,
 Javier Martinez Canillas <javierm@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, luyuantao <luyuantao01@163.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: [PATCH 1/2] drm/panic: Fix kmsg screen hang on a long log line
Date: Thu, 15 Oct 2026 22:27:21 -0700
Message-ID: <20261016052722.60051-1-lucid_duck@justthetip.ca>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 16 Oct 2026 07:35:41 +0000
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

The kmsg panic screen reads the log back one chunk at a time. A record
that does not fit in a chunk comes back empty without moving on, so the
screen asks for it again forever and the panic never finishes. Every
oops logs the list of loaded modules, and on my machine that list does
not fit.

Read into a buffer the size printk formats one record into, and stop if
a read still comes back empty.

Fixes: 54034bebb22f ("drm/panic: Add a kmsg panic screen")
Cc: stable@vger.kernel.org
Signed-off-by: Devin Wittmayer <lucid_duck@justthetip.ca>
---
I usually work on Wi-Fi drivers, so this is new ground for me. While I
was testing a fix for a Wi-Fi driver crash, my test machine froze after
the crash where it should have rebooted, and stayed that way until I
power cycled it. Working out why led me here.

To reproduce, with the kmsg screen and panic=10 on a display driver with
panic support, as root:

  printf "%600s\n" "" | tr ' ' x > /dev/kmsg
  echo c > /proc/sysrq-trigger

Before this patch the panic never gets to its reboot.

QEMU, 10 runs each, on drm-misc-fixes and drm-misc-next (bochs) and
6.12.113 (simpledrm):

                                     before    after
  one 600 char line                  hangs     reboots
  same, then 400 short lines         hangs     reboots
  one record of 300 short lines      hangs     reboots
  oops with 24 modules loaded        hangs     reboots
  plain panic                        reboots   reboots

amdgpu, 2 runs each, Arch's source and config, before and after:

  6.18.52, the two commands above    hangs     reboots
  6.18.52, one record of 300 lines   hangs     reboots
  6.18.52, oops                      hangs     reboots
  7.2.6, kmsg screen set, oops       hangs     reboots

luyuantao's patch [1] stops reading once the screen is full, so it only
helps the second row. With both on drm-misc-fixes, every row reboots.

The buffer is shared, like the QR code buffers; a panic only draws from
one CPU. In drm-misc-next this code is in drm_panic_helper.c, where the
same change was tested.

[1] https://lore.kernel.org/all/20260126100732.365-1-luyuantao01@163.com/

 drivers/gpu/drm/drm_panic.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
index e576c4791861d..29b1487de7ae0 100644
--- a/drivers/gpu/drm/drm_panic.c
+++ b/drivers/gpu/drm/drm_panic.c
@@ -556,7 +556,8 @@ static void draw_panic_screen_kmsg(struct drm_scanout_buffer *sb)
 	const struct font_desc *font = get_default_font(sb->width, sb->height, NULL, NULL);
 	struct drm_rect r_screen = DRM_RECT_INIT(0, 0, sb->width, sb->height);
 	struct kmsg_dump_iter iter;
-	char kmsg_buf[512];
+	/* the size printk formats one record into, too big for the stack */
+	static char kmsg_buf[2048];
 	size_t kmsg_len;
 	struct drm_panic_line line;
 	int yoffset;
@@ -574,6 +575,10 @@ static void draw_panic_screen_kmsg(struct drm_scanout_buffer *sb)
 		char *start;
 		char *end;
 
+		/* a record that does not fit comes back empty, every time */
+		if (!kmsg_len)
+			break;
+
 		/* ignore terminating NUL and newline */
 		start = kmsg_buf + kmsg_len - 2;
 		end = kmsg_buf + kmsg_len - 1;

base-commit: 324fac81f365fc123247f9c8a52cb66ebd93b5e5
-- 
2.56.0

