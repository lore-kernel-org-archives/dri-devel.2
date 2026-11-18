Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1086A606A326
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 07:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=eJNYHRwI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C266C10FB8D;
	Thu, 19 Nov 2026 07:48:40 +0000 (UTC)
X-Greylist: delayed 304 seconds by postgrey-1.36 at gabe;
 Wed, 18 Nov 2026 14:27:40 UTC
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com
 [101.71.155.101])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFABE10FD17
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 14:27:40 +0000 (UTC)
Received: from lgs.. (unknown [101.76.249.61])
 by smtp.qiye.163.com (Hmail) with ESMTP id 5526d7972;
 Wed, 18 Nov 2026 22:22:30 +0800 (GMT+08:00)
From: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
To: Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH] fbdev: s3c-fb: Fix potential registration corruption on probe
 failure
Date: Wed, 18 Nov 2026 22:22:29 +0800
Message-ID: <20261118-324f82bd41-fbdev-0@mail.sdu.edu.cn>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa1ef09abc403a1kunmfc88f5031a12ca
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCSk9MVhgYSEkdTBlLTk5MQlYeHw
 5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKS0pVTE1VSU9CVU1KWVdZFhoPEhUdFFlBWU9LSFVKS0lCQ0
 NMVUpLS1VLWQY+
DKIM-Signature: a=rsa-sha256;
 b=eJNYHRwIFeniVMid2Oy+In7DqyaRyzjNcRq4bw24gImwksylgJsGXjQdQKsCqNdyYzWh9d+Yl7k+WxqEglV4Bad/cMs33UCs2u2/zzdDQdTa/C21pXtSEz6rYaZdNNZ1ACYC4WQwwu+7kTvoaEy2rdQW14pgDzofId/GxuUq9IU=;
 c=relaxed/relaxed; s=default; d=mail.sdu.edu.cn; v=1; 
 bh=haqNkHmYUBM8afAHWDurlnqO/foJXidzEpjadaLQhdY=;
 h=date:mime-version:subject:message-id:from;
X-Mailman-Approved-At: Thu, 19 Nov 2026 07:48:39 +0000
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

Probe failure cleanup calls unregister_framebuffer() even when the
window has not been registered. Its zero-initialized node can then
remove another framebuffer from registered_fb[0].

Track successful registration and only unregister those framebuffers.
Also skip empty window slots while unwinding a failed probe.

This issue was found by our static analysis tool under development.

Fixes: ec549a0fdc32 ("fb: add s3c-fb driver for newer Samsung SoC framebuffer devices")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
---
 drivers/video/fbdev/s3c-fb.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/s3c-fb.c b/drivers/video/fbdev/s3c-fb.c
index 82a3bc9de433..c67ad47a49f0 100644
--- a/drivers/video/fbdev/s3c-fb.c
+++ b/drivers/video/fbdev/s3c-fb.c
@@ -161,6 +161,7 @@ struct s3c_fb_palette {
  * @pseudo_palette: For use in TRUECOLOUR modes for entries 0..15/
  * @index: The window number of this window.
  * @palette: The bitfields for changing r/g/b into a hardware palette entry.
+ * @registered: Whether the framebuffer was successfully registered.
  */
 struct s3c_fb_win {
 	struct s3c_fb_pd_win	*windata;
@@ -172,6 +173,7 @@ struct s3c_fb_win {
 	u32			*palette_buffer;
 	u32			 pseudo_palette[16];
 	unsigned int		 index;
+	bool			 registered;
 };
 
 /**
@@ -1142,14 +1144,15 @@ static void s3c_fb_release_win(struct s3c_fb *sfb, struct s3c_fb_win *win)
 {
 	u32 data;
 
-	if (win->fbinfo) {
+	if (win && win->fbinfo) {
 		if (sfb->variant.has_shadowcon) {
 			data = readl(sfb->regs + SHADOWCON);
 			data &= ~SHADOWCON_CHx_ENABLE(win->index);
 			data &= ~SHADOWCON_CHx_LOCAL_ENABLE(win->index);
 			writel(data, sfb->regs + SHADOWCON);
 		}
-		unregister_framebuffer(win->fbinfo);
+		if (win->registered)
+			unregister_framebuffer(win->fbinfo);
 		if (win->fbinfo->cmap.len)
 			fb_dealloc_cmap(&win->fbinfo->cmap);
 		s3c_fb_free_memory(sfb, win);
@@ -1272,6 +1275,7 @@ static int s3c_fb_probe_win(struct s3c_fb *sfb, unsigned int win_no,
 		return ret;
 	}
 
+	win->registered = true;
 	dev_info(sfb->dev, "window %d: fb %s\n", win_no, fbinfo->fix.id);
 
 	return 0;

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.43.0

