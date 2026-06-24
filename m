Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9C4DCDB466
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 07:03:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EEC810F13D;
	Thu, 25 Jun 2026 07:03:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=permerror (0-bit key) header.d=fastmail.org header.i=@fastmail.org header.b="MFBx5/t3";
	dkim=permerror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aXKg3ZQb";
	dkim-atps=neutral
Received: from flow-a3-smtp.messagingengine.com
 (flow-a3-smtp.messagingengine.com [103.168.172.138])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A2D088697
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 21:11:39 +0000 (UTC)
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
 by mailflow.phl.internal (Postfix) with ESMTP id C546313806D7;
 Wed, 24 Jun 2026 17:11:38 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-07.internal (MEProxy); Wed, 24 Jun 2026 17:11:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
 cc:content-type:content-type:date:date:from:from:in-reply-to
 :message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
 t=1782335498; x=1782339098; bh=HLvIbEEh4LRcXndYsesxCx6snQfBdL+u
 rW4VdjcGabI=; b=MFBx5/t3bDYp1v4eLJ0wdxfgxFFCywm49fVzIiIfFZm1nPJ7
 vuxMwsb/CdAYXSB8O/7pJJitubIPZx+IaQXiPrPUwft/oT1Km6e4EWrBx1gMFb7J
 IOQM11kK7keQfklGc7/eOAw3hdPaAx5zZ0Qaekzl8wkyATwsgGi3pEmFMyVdf7p5
 r6cmanEsPcHr1bzwUpnE5Qo09R3kCXg7Zl05BDK4k5hVZhuP8Ifv7vXTDZSiBu/y
 6yzf05RbMT8n/BxWEvF5NsEIjUwYUZ11rew7rCKe9K/l0W9dp3YREnO8/ZGc4rGA
 vn97VYGLJsQan4UtCpLbaDmcBrlI3xYMzR3IqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:message-id
 :mime-version:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782335498; x=
 1782339098; bh=HLvIbEEh4LRcXndYsesxCx6snQfBdL+urW4VdjcGabI=; b=a
 XKg3ZQbnXTZwQRCFg2XqvVo6IBgR0dkKRqheaJKiI5UNhsyf9+ZqCUO1+Nsv3Psj
 JC3jUSisdi9Wrf9glUBy+uauWNge1ciFpAyifOUA5cd73QFe/IjiqRj1b2PLsHtm
 GCIupW9p1HXinriB6DVSvOYsI+ffBYT9bjSJbinLV3Y5sdk8qliDawglKRvbG9gv
 uABoubV4sYPiO8LtE2x0ptZE+enrOfeK+OaiHxJ2JawMNUj6U8pELp2aeOziaKO1
 tHCQBFlc8t9uGitA6zbuKLznx8tbxaey3ZkSe/tBVBOVCjBUoqlxiHxJNVSFjR9V
 NmXsnQCim0lK2qiHyKkMw==
X-ME-Sender: <xms:Ckg8aibLDL6qVcZMY67fHExBIFJPLCKOGe1F3PpFUfj_dEmV4j410Q>
 <xme:Ckg8agXCLjRKQZvmYlOm1KoIzk7Q16XVvWTj6NY-2KVb3bTuzpUaHjr3736zm_Vqz
 pRYb6Bqm6FWSdgItMeOLOvXfLitULafP2kyf0wg5BGN9I88l0OWJyZ6>
X-ME-Received: <xmr:Ckg8ar-Q3XoSIX-QVEXeo9mVKqCyMRD2NJmeD8l6BxwHDlc4LKEX9jsXLiA>
X-ME-Proxy-Cause: dmFkZTEoJUJZAbIrMiuSeodSbMwEfc4MOjLc8W4PcGDO69zM/tp1kxpSFKNl05EZ+oYspp
 9s5vDWghVzHBTnV+6rRNv2VDSyt8wl9UPm9OTDQPsenMFy4zHsUa6UijWeXrH/MFHm6z/T
 kDtDDwk7nXVSNYBpHua5sIQYeN9Pu6vaXlyfA1RSmY1DoXmA823EcoLjVZ0IrVaSgkbKc4
 cn2HD3hK3axHZi0AKBEuquYDzX9JY+BAC05NcRLYkoqjtMQsycOBmFS6pu3k5cyuNkk6Og
 zFzFWJQzGuFlLbMdLWYiC4RhWzrhzOk6TyRD04nrUyE4IgGNQpRzTG3jTNUCOKhnaL4zWs
 Z5LPENRPZAOQTb5hw/zUecu+URwE4BDoM/Fx5UBZC7e90eeKAF6ODKWBjbrNw3M3AT9iiK
 8D8ONuTAF3XmDbXg4yB1WlpBWXwCIHrmStOHwMlV8rnFxcBRlUDiawY7pFdgOBjxYGs+R8
 mTNEphw6ts8io0Mny1EFp+R/gMGOt9/G7BGvuAQtBBKJif7lV4vtS7V6tVKQkDMPjCrDUl
 PhH7/aLTFvmEsCNPrGGP2qP0gK2XyJqjiQztDPJ1A0yKszDWGmQizFbq9CK5O19M2gjqe8
 jO5b1kDzPJ9W6tD/CiedCHnrZK7lesyygYeO11MxQmw4nYy91k4sA+CfdMVQ
X-ME-Proxy: <xmx:Ckg8ap8_RHHF5hchWpNVSuTF3MupdNfvB9FlMZue9FMuk5Yjx8LNLA>
 <xmx:Ckg8arTMD_9uxo6uSofBVVHF8zKHVx2_dTL-E2K_UzPLaUep8NYPNA>
 <xmx:Ckg8atdOQygom_5CoLGH5KEZUuPlXYdw83WlY-iwzgRVrMOo6P6Zhw>
 <xmx:Ckg8avCPZgWj3Pj3Q7U-O14oD6-9UmWDmFevBMfjtO-J-eAZDFqslw>
 <xmx:Ckg8atCKT2eaGq88AfJqwn6JbCiFq0RwZUaPRj9vSRZOSzLfNXgt_62A>
Feedback-ID: ib53e4b78:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jun 2026 17:11:37 -0400 (EDT)
Date: Wed, 24 Jun 2026 16:11:36 -0500
From: Ian Bridges <icb@fastmail.org>
To: Helge Deller <deller@gmx.de>, Thomas Zimmermann <tzimmermann@suse.de>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fbcon: fix NULL pointer dereference for a console without
 vc_data
Message-ID: <ajxICA0v-_5NrqhS@dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Thu, 25 Jun 2026 07:03:17 +0000
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

fbcon_new_modelist() runs when a framebuffer's modelist changes. For each
console mapped to it with fb_display[i].mode set, it reads vc_cons[i].d and
passes the vc_num to fbcon_set_disp(). This assumes a console with a mode
set has a vc_data, but it can be NULL. fbcon_set_disp() sets
fb_display[i].mode before it checks vc_data, and fbcon_deinit() leaves the
mode set after the vc_data is freed. fbcon_new_modelist() then dereferences
the NULL vc_data.

Keep fb_display[i].mode set only while the console has a vc_data. Check
vc_data before setting the mode in fbcon_set_disp(), and clear the mode in
fbcon_deinit(). The existing mode check in fbcon_new_modelist() then skips
such consoles.

Reported-by: syzbot+42525d636f430fd5d983@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=42525d636f430fd5d983
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Ian Bridges <icb@fastmail.org>
---
This patch fixes a NULL pointer dereference in the framebuffer console code.
fbcon_new_modelist() dereferences a NULL vc_data. It was found while writing
a reproducer for a separate use-after-free in store_modes(). Sashiko
independently flagged the same dereference in its review of the fix for that
use-after-free [1].

The dereference happens when a console has fb_display[i].mode set but no
vc_data, and the modelist is then replaced, as follows.

1. A console ends up with fb_display[i].mode set while vc_cons[i].d is NULL.
   Either fbcon_set_disp() sets the mode (fbcon.c:1446) before it checks
   vc_data, so mapping an unused console with FBIOPUT_CON2FBMAP leaves the
   mode set, or fbcon_deinit() (fbcon.c:1268) frees the vc_data but keeps the
   mode.
2. A write to the modes attribute calls store_modes() (fbsysfs.c:91), which
   replaces the modelist and calls fb_new_modelist() (fbsysfs.c:108).
3. fb_new_modelist() calls fbcon_new_modelist() (fbmem.c:770).
4. fbcon_new_modelist() walks the consoles mapped to the framebuffer, takes
   vc = vc_cons[i].d for the one with the mode set, and reads vc->vc_num with
   vc NULL (fbcon.c:3046). This is a NULL pointer dereference.

This patch does not change that line:

    fbcon_set_disp(info, &var, vc->vc_num);

vc is vc_cons[i].d, which is NULL.

syzbot reported the same crash, with the call stack store_modes() ->
fb_new_modelist() -> fbcon_new_modelist() [2]. That report had no reproducer
and was closed as obsolete.

It reproduces on a KASAN kernel with two framebuffers, two ways:

1. Map an unused console to one framebuffer and back to the other with
   FBIOPUT_CON2FBMAP, then write a modelist to that framebuffer's modes
   attribute.
2. Open and close /dev/ttyN, then write a modelist to its framebuffer's
   modes attribute.

The reproducer was written with the help of a coding agent (Claude Code). The
patch is against commit 3726ce7f6cef on the for-next branch of
git://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git. The
file offsets above are from that commit. The dereference is present in the
initial 2.6.12-rc2 import, so there is no Fixes tag.

[1] https://lore.kernel.org/all/20260622080749.D7FC61F000E9@smtp.kernel.org/
[2] https://syzkaller.appspot.com/bug?extid=42525d636f430fd5d983

 drivers/video/fbdev/core/fbcon.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 9077d3b99357..97d4b836b26a 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -1273,6 +1273,7 @@ static void fbcon_deinit(struct vc_data *vc)
 	int idx;
 
 	fbcon_free_font(p);
+	p->mode = NULL;
 	idx = con2fb_map[vc->vc_num];
 
 	if (idx == -1)
@@ -1443,14 +1444,14 @@ static void fbcon_set_disp(struct fb_info *info, struct fb_var_screeninfo *var,
 
 	p = &fb_display[unit];
 
-	if (var_to_display(p, var, info))
-		return;
-
 	vc = vc_cons[unit].d;
 
 	if (!vc)
 		return;
 
+	if (var_to_display(p, var, info))
+		return;
+
 	default_mode = vc->vc_display_fg;
 	svc = *default_mode;
 	t = &fb_display[svc->vc_num];
-- 
2.47.3

