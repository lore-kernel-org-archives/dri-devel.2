Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB1C4C98328
	for <dri-devel@archiver.kernel.org>; Sat, 26 Sep 2026 13:17:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFF4D10E1DF;
	Sat, 26 Sep 2026 13:17:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RdT7UcMR";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24CFF10E1DF
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 13:17:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0D4AD43258;
 Sat, 26 Sep 2026 13:17:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B9FC1F000FF;
 Sat, 26 Sep 2026 13:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790428641;
 bh=wtbXqDxYJ+fXu0msVrSYQq3hHAakzipc5tFwCJC/Qwo=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=RdT7UcMR3+utgAUAcl+2E9Ad88+klv+W8/EHXh8HFnCisVfusSz9lm3HjPp77Ylb4
 TwfbFuIRJGePrznNOQ7Y7+jqFqVpShewGR2YVTbrELoT5CvhyNqNTO9ynFvo+Hg0eU
 bwLUmbKVn+GDcDKPrgwmF8zszCTk1n61ysUT1EPlXtkUAigJp0BDUFrOWRh5Hc12CK
 YbFXX96XFPCRyi5qQMs/ILq5PrXuGLNhDoWz/qQAcMde95M1PWVr4gi2TLOqaqia2X
 PH9PAOmcywOUiNzqsjD6EgxbY1WH1D6/5pxQkfVoZ2VBclB17yN73QtSWelqb1oQwU
 fF68SnVCqgAJw==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Sat, 26 Sep 2026 14:17:00 +0100
Subject: [PATCH 2/6] fbdev: xen-fbfront: check for fb_deferred_io_init() error
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260926-fix-fbdefio-error-handling-v1-2-a94810b6e263@kernel.org>
References: <20260926-fix-fbdefio-error-handling-v1-0-a94810b6e263@kernel.org>
In-Reply-To: <20260926-fix-fbdefio-error-handling-v1-0-a94810b6e263@kernel.org>
To: Helge Deller <deller@gmx.de>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, 
 =?utf-8?q?Bruno_Pr=C3=A9mont?= <bonbons@linux-vserver.org>, 
 Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Bernie Thompson <bernie@plugable.com>, Greg Kroah-Hartman <gregkh@suse.de>, 
 Steve Glendinning <steve.glendinning@shawell.net>, 
 Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 Steve Glendinning <steve.glendinning@smsc.com>, 
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1514; i=ljs@kernel.org;
 h=from:subject:message-id; bh=8bKrepULYvgg1nh28mHYXcYdVUXLFHADnNiLS+Xz4eU=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLK2H73iHcQql2Rjm//aPsz8+p1Z+gynLG8fPcD9XO/1H
 NtNx+5+7ihlYRDjYpAVU2R5/kV8f5BI2LzOC/5uMHNYmUCGMHBxCsBEYvgZGR6Jvr5+9zH/o3Vb
 VinIRJ1byVfpKs/Ol7NhuXSQ8LSVS7czMqxt0I8S+XBm4p9s9X3KdW4CP96qbZZTdu37NfngtHt
 ui1kA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14
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

fb_deferred_io_init() allocates deferred I/O state, populating
info->fbdefio_state, or leaving it NULL if an error occurs.

Currently xenfb_probe() ignores its return value.

Therefore if an error arises in fb_deferred_io_init() (for instance, due
to an allocation failure) info->fbdefio_state is left NULL.

When the file is subsequently opened, fb_open() will dereference a NULL
pointer (calling fb_deferred_io_open()).

Fix this by checking for the error.

Fixes: 56c134f7f1b5 ("fbdev: Track deferred-I/O pages in pageref struct")
Cc: <stable@vger.kernel.org>
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 drivers/video/fbdev/xen-fbfront.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/xen-fbfront.c b/drivers/video/fbdev/xen-fbfront.c
index 4385976277ac..7ef909d4242d 100644
--- a/drivers/video/fbdev/xen-fbfront.c
+++ b/drivers/video/fbdev/xen-fbfront.c
@@ -443,7 +443,11 @@ static int xenfb_probe(struct xenbus_device *dev,
 	}
 
 	fb_info->fbdefio = &xenfb_defio;
-	fb_deferred_io_init(fb_info);
+	ret = fb_deferred_io_init(fb_info);
+	if (ret < 0) {
+		xenbus_dev_fatal(dev, ret, "fb_deferred_io_init");
+		goto error_cmap;
+	}
 
 	xenfb_init_shared_page(info, fb_info);
 
@@ -465,6 +469,7 @@ static int xenfb_probe(struct xenbus_device *dev,
 
 error_fb:
 	fb_deferred_io_cleanup(fb_info);
+error_cmap:
 	fb_dealloc_cmap(&fb_info->cmap);
 	framebuffer_release(fb_info);
 error_nomem:

-- 
2.55.0

