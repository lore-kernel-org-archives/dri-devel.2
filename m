Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71467CDE00E
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 07:54:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25F3810F4B6;
	Fri, 26 Jun 2026 07:54:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=permerror (0-bit key) header.d=fastmail.org header.i=@fastmail.org header.b="GYr8xJjV";
	dkim=permerror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X/MEOeUQ";
	dkim-atps=neutral
Received: from flow-b1-smtp.messagingengine.com
 (flow-b1-smtp.messagingengine.com [202.12.124.136])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB04A10F412
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 04:50:52 +0000 (UTC)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailflow.stl.internal (Postfix) with ESMTP id 124F513004F6;
 Fri, 26 Jun 2026 00:50:52 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Fri, 26 Jun 2026 00:50:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
 cc:content-type:content-type:date:date:from:from:in-reply-to
 :message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
 t=1782449451; x=1782453051; bh=h8S69FdSZBCUU1LIGkRE8nLruWX/vcmq
 dFp04vny9zo=; b=GYr8xJjVNC8i/yn90JJuSHDTaBN5nY7yxZevIFAk12Rc/CKY
 a4+MPq9Bvy8FRDVRIpVmf/qDR1ocFqT5j+Tel5eBYaqo7FDURwPL1WvWbHwK6eQL
 65JgywaLG5BEh+oYQQoat0nO8+ckc4f2F/7UOadO9woQaecC5UKMh1ofUluBW1a+
 RKXutFzod+hUK1itmQlF7YxPQbfqowPS41sxz1uMpMrOznmUiJGYoGPoOB8Pk4DV
 drDP8Fuhq9UKt3Li3PaN5WEt1Wt2IdQfBfGpjXwEmvYym2D+GOTV1TgFNh/HZLWa
 81lDO4lYgUqDFwJA9DpqEbSU24HUZ3092jctUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:message-id
 :mime-version:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782449451; x=
 1782453051; bh=h8S69FdSZBCUU1LIGkRE8nLruWX/vcmqdFp04vny9zo=; b=X
 /MEOeUQN23z+ir6Se5f7iQfc4gKh4NFolz8IFh6BO8Cp0f/5l3Gc7cL03ir2mqvF
 HU+nRz8vKMwMlcOyqcDXarQ8o59aSWfOljCJLc6oSQ4k+pSIyBhddoptLlqkoF5x
 IzQm0b9mCPHhdFqsgEHCBBr0QQtrYceOWzA7iiprS3Pyaa38M3YwKFouemiWRduH
 Cim2ZruFVMYcLwhTXkkvZndSqRCaQk8bfqLo+ZwWTkp3G1hii//jOA9FRBZUPAx7
 TQfsCu+5PCbwKdTibK1hbFAghvnYctInlm2fl0J8FmjR9Dd+Y6buZlvNvAv+G2GL
 Rlio3DXAKn5FYqc5UdWtA==
X-ME-Sender: <xms:KwU-antBUVvzPNjUmtcFkZtSvk3b93E5HkqOs-GZK9Js2_mywO7e2w>
 <xme:KwU-amarCkCHXo3KWe8jdFtGE7Fyx3NVTzWSidoW-AqH4cvJzpS-TYEZML2GudWLy
 s1U0ebIuh7TtEdEYXFJuDDg4uQay0sO93OuUp38s-Xo2b5OwGxFFFw>
X-ME-Received: <xmr:KwU-atHfAUhRNHFGx8dd_4z23xOWuH81H7ktQeiVYQepZTZ8f4x4Z2Lj7dI>
X-ME-Proxy-Cause: dmFkZTGrMPsZopihuVJOo0nXITJN0WAW2RnYuJoHbE6ztnK3QHqtRRpJJxBAGFqG4F/m8h
 cEEDt/K8nlvR70bXUmej/52RUqU2A40D6zAqNbg38KYopSHjB3UyVoiBQ5v1hX1f1/GXxW
 qc4d9JnRsWCDz2v1XLi53Z1FBayBPMpiCJd9ay2kp28uMngqeiN9ysx5CwuxV5P8oX24tv
 /WkJESuXAcke2qPdjOfRNypp9yWhvYXb27mFOiNs29QL5Cf8lZDEKjNYEZMFvH+oG+Fphb
 tVgLXbd42YokXjajhN3x1WicZN7HPGrvNGMMh9cmXH7LES492cU3zCXYL4sF96YaiFXTZW
 UMPdplhjGc2b9u1p8PZ7sU0TlghTkNOlF065booytK/AQcKQejjbTZ5SaULJ8NkQRvfpV/
 y5QoqrtReBKZGMOR/FIcLZujv7G/kffWRNNHxeWED5Thlp+Zpurga1zyFkOUhwZB27c9VH
 9nNqNfdHVPh98l1Av7WMEbldQB+iMiM2G+QgRUINZw5g2z/QMrBFBBt+4gbMgsZHqChPAO
 aiNBC1Ey2IDanrQ+Ul4yzWxmNYhP0s+BOa8/WJ3CY+grUEcGquKGl81aWtfhirN0Rn+RoG
 kEWpKN06QohLz9NKZzVY63gLqfw5WfBypuembJDqCIgXZt2i402UwoJEsfoQ
X-ME-Proxy: <xmx:KwU-aqxsUTOXJrvPYBeVP7Eg3cF7KQm_6MWCOjN4WHFS3Aik_8fnyw>
 <xmx:KwU-avk8yzs5IgAbd0bc7ZFY2E6awpFJ3pEAQJztq_O1RMmei5OmZA>
 <xmx:KwU-ajl7Upiv6qbbL5v7FkwocJrHIR-SFg6-jK7uZUT6pLs9EYN1lA>
 <xmx:KwU-ahzMj4s018ZVfO7Ou3T73x4_qxCloZEMZAVqeYtI7Cx-NRaBgA>
 <xmx:KwU-amTiOSofnwZ3CPbC9A3T9ieEZIjPdWpDEQgdmBacasmEkHxnqphN>
Feedback-ID: ib53e4b78:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Jun 2026 00:50:51 -0400 (EDT)
Date: Thu, 25 Jun 2026 23:50:48 -0500
From: Ian Bridges <icb@fastmail.org>
To: Simona Vetter <simona@ffwll.ch>, Helge Deller <deller@gmx.de>,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2] fbdev: fix use-after-free in store_modes()
Message-ID: <aj4FKJtIuU97rEA4@dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Fri, 26 Jun 2026 07:53:42 +0000
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

store_modes() replaces a framebuffer's modelist with modes from userspace.
On success it frees the old modelist with fb_destroy_modelist(). Two
fields still point into that freed list.

One pointer is fb_display[i].mode, the mode a console is using.
fbcon_new_modelist() moves these pointers to the new list. It only does so
for consoles still mapped to the framebuffer. An unmapped console is
skipped and keeps its stale pointer. Unbinding fbcon, for example, sets
con2fb_map[i] to -1 but leaves fb_display[i].mode set. An
FBIOPUT_VSCREENINFO ioctl with FB_ACTIVATE_INV_MODE later reaches
fbcon_mode_deleted(). That function reads the stale fb_display[i].mode
through fb_mode_is_equal(). The read is a use-after-free.

The other pointer is fb_info->mode, the current mode. It is set through
the mode sysfs attribute. store_modes() does not update fb_info->mode, so
it is left pointing into the freed list. show_mode(), the attribute's read
handler, dereferences the stale fb_info->mode through mode_string(). The
read is a use-after-free.

Clear both pointers before freeing the list. Commit a1f305893074 ("fbcon:
Set fb_display[i]->mode to NULL when the mode is released") added the
helper fbcon_delete_modelist(). It clears every fb_display[i].mode that
points into a given list. So far it is called only from the unregister
path. Call it from store_modes() too, and set fb_info->mode to NULL.

Reported-by: syzbot+81c7c6b52649fd07299d@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=81c7c6b52649fd07299d
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/ajjoDhAi2y4ArSlz@dev/
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Ian Bridges <icb@fastmail.org>
---
Added in v2: clear fb_info->mode, which is left dangling by the same free
in store_modes(). Sashiko flagged that second pointer while reviewing
v1 [1].

[1] https://lore.kernel.org/all/20260622080749.D7FC61F000E9@smtp.kernel.org/

 drivers/video/fbdev/core/fbsysfs.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/fbsysfs.c b/drivers/video/fbdev/core/fbsysfs.c
index d9743ef35355..ea196603c7a8 100644
--- a/drivers/video/fbdev/core/fbsysfs.c
+++ b/drivers/video/fbdev/core/fbsysfs.c
@@ -10,6 +10,7 @@
 #include <linux/major.h>
 
 #include "fb_internal.h"
+#include "fbcon.h"
 
 static int activate(struct fb_info *fb_info, struct fb_var_screeninfo *var)
 {
@@ -108,8 +109,15 @@ static ssize_t store_modes(struct device *device,
 	if (fb_new_modelist(fb_info)) {
 		fb_destroy_modelist(&fb_info->modelist);
 		list_splice(&old_list, &fb_info->modelist);
-	} else
+	} else {
+		/*
+		 * fb_display[i].mode and fb_info->mode both point into the old
+		 * list. Clear them before it is freed.
+		 */
+		fbcon_delete_modelist(&old_list);
+		fb_info->mode = NULL;
 		fb_destroy_modelist(&old_list);
+	}
 
 	unlock_fb_info(fb_info);
 	console_unlock();
-- 
2.47.3

