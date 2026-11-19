Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84653606A320
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 16:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=justthetip.ca header.i=@justthetip.ca header.a=rsa-sha256 header.s=key1 header.b=MxnII4w0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C434B112BCB;
	Fri, 20 Nov 2026 16:18:35 +0000 (UTC)
Received: from mta1.migadu.com (out-55.mta1.migadu.com [95.215.58.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37E1910F0CF
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 19:10:58 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=AWOkBBAq/YXJUhDBoogWOzXz+yE7PZKM8xjPAy/bQ9M=; 
 c=simple/simple; d=justthetip.ca;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795115456; v=1; x=1795720256;
 b=MxnII4w0zaxTOJoEonw/Gh62OmKqWz4MsNYCsQtKuW8AszrboA4QWpVidKdKRztIRAwrk3t0
 bllrPUlnqGkaVYuCU+9drBOg9mTpvUf2zX9WotHe3otMFEcYi8hXOa2z+9huA06OYZp1KhoqH14
 4s1iBlYOxXwKCMaNOtVKPCLgUlUsFcgnLPQSfjbulMfovPa17H3B7AC0c0hgcMpyCPy9e5NGX2T
 uKqVtEXP7+CCUZN401Qe2S5N2PQ9MHkNANSczKhmNxgKfTTxpoHvr2AXc92Tcvc5Kz7vERdmoN9
 LAO91wrFYY/Epl/RenZYVWRHOetyQ14sQb2UzQsCoyn3w==
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: by smtp.migadu.com with ESMTPS id 58450e64729725f2;
 Thu, 19 Nov 2026 19:10:46 +0000
X-Mizu-Trace-ID: 58450e64729725f2
X-Migadu-Flow: FLOW_OUT
From: Devin Wittmayer <lucid_duck@justthetip.ca>
To: Jocelyn Falempe <jfalempe@redhat.com>,
 Javier Martinez Canillas <javierm@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, desobei <desobei@outlook.com>,
 luyuantao <luyuantao@kylinos.cn>
Subject: [PATCH] drm/panic: Bring back the kmsg screen fixes lost in a merge
Date: Thu, 19 Nov 2026 12:10:38 -0700
Message-ID: <20261119191038.146963-1-lucid_duck@justthetip.ca>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 20 Nov 2026 16:17:37 +0000
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
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Commit b537d87d2632 ("drm/panic: Fix the loop that causes kmsg to not
display correctly") and commit 1ba640563843 ("drm/panic: Fix kmsg screen
hang on a long log line") changed the old panic file. By the time they
reached drm-fixes, that code had moved into the helper library, and the
merge left the helper as it was.

So the panic screen that prints the kernel log hangs again on a long
log line, and the machine never reboots. The helper's KUnit suite hangs
the same way.

Make both changes in the helper.

Fixes: 5c3d323984fd ("drm/panic: Move panic display code into helper library")
Reported-by: desobei <desobei@outlook.com>
Closes: https://lore.kernel.org/all/PH7PR19MB6658FDBDD012399C6E8D330FAF792@PH7PR19MB6658.namprd19.prod.outlook.com/
Tested-by: desobei <desobei@outlook.com>
Cc: luyuantao <luyuantao@kylinos.cn>
Signed-off-by: Devin Wittmayer <lucid_duck@justthetip.ca>
---
Both were lost in merge 1c3b1398f1cf. My other fix in that pull, for
the panic screen setting, made it through.

Panics with a long line in the log, on drm-misc-fixes:

                              without this    with this
    QEMU, 40 panics           all hang        all reboot
    AMD mini PC, 8 panics     all hang        all reboot

Panics with nothing long in the log reboot either way.

 drivers/gpu/drm/drm_panic_helper.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_panic_helper.c b/drivers/gpu/drm/drm_panic_helper.c
index 8913c3d22e8d..385a07ed314b 100644
--- a/drivers/gpu/drm/drm_panic_helper.c
+++ b/drivers/gpu/drm/drm_panic_helper.c
@@ -513,7 +513,8 @@ VISIBLE_IF_KUNIT int drm_panic_helper_draw_screen_kmsg(struct drm_scanout_buffer
 	const struct font_desc *font = get_default_font(sb->width, sb->height, NULL, NULL);
 	struct drm_rect r_screen = DRM_RECT_INIT(0, 0, sb->width, sb->height);
 	struct kmsg_dump_iter iter;
-	char kmsg_buf[512];
+	/* the size printk formats one record into, too big for the stack */
+	static char kmsg_buf[2048];
 	size_t kmsg_len;
 	struct drm_panic_line line;
 	int yoffset;
@@ -530,10 +531,15 @@ VISIBLE_IF_KUNIT int drm_panic_helper_draw_screen_kmsg(struct drm_scanout_buffer
 	drm_panic_helper_fill(sb, &r_screen, bg_color);
 
 	kmsg_dump_rewind(&iter);
-	while (kmsg_dump_get_buffer(&iter, false, kmsg_buf, sizeof(kmsg_buf), &kmsg_len)) {
+	while (yoffset >= 0 && kmsg_dump_get_buffer(&iter, false, kmsg_buf,
+	       sizeof(kmsg_buf), &kmsg_len)) {
 		char *start;
 		char *end;
 
+		/* a record that does not fit comes back empty, every time */
+		if (!kmsg_len)
+			break;
+
 		/* ignore terminating NUL and newline */
 		start = kmsg_buf + kmsg_len - 2;
 		end = kmsg_buf + kmsg_len - 1;
-- 
2.56.1

