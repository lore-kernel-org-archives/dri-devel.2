Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60262CD98ED
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 06:30:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B31E310ECA5;
	Thu, 18 Jun 2026 06:30:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WUCXSPv5";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F74B10EC4A
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 06:30:25 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id B2B5C60052;
 Thu, 18 Jun 2026 06:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 67F2FC2BCB0;
 Thu, 18 Jun 2026 06:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1781764224;
 bh=2AXvxyAImZLWIbVapZ+mESkLjtssGF0r7mGVvapmQw0=;
 h=From:Date:Subject:To:Cc:Reply-To:From;
 b=WUCXSPv5UeomtCGpLlYI8T3qjhW7qjNCJdnOjN22uCjxQcbGGVZh/B8CmwsczZ6o3
 1mtIy4fks5ksQblIOiWiSNfitF4FBjQWlvtfhQCrnlDdBKRxewhtXDQIT76sbnofkQ
 XjiX3qCFM0O8KoKFTyvuLcNU93hAVKZYcMJF91zLuUTusu+GTKqER6oxuRUVxcTSlP
 9IlMGhXYPm2Nlp3Dmng5+8mFDqMTyrsbpJf1QwIoFmsQd3czZFCMRShTAwON7yLgN+
 Lbyj2pDw6+XXf7ZcOnlb8NBrBCTS4jfvRPVYzIV6QjNIwPmRuxtSJvtEdD3fSHwC4T
 +B0BbYdhnMoDA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 488B2CD98ED;
 Thu, 18 Jun 2026 06:30:24 +0000 (UTC)
From: HAN Ruidong via B4 Relay <devnull+rdhan.smu.edu.sg@kernel.org>
Date: Thu, 18 Jun 2026 14:30:17 +0800
Subject: [PATCH] fbcon: Avoid OOB font access if console rotation fails
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-prep-base-v5-15-209-v1-1-cfcf596dca7a@smu.edu.sg>
X-B4-Tracking: v=1; b=H4sIAHiQM2oC/yXMQQqDMBCF4avIrB1IUhONVyldaBx1urCSaUNBv
 LtRlx+8928gFJkE2mKDSImFP0uGLgsIc7dMhDxkg1HGKacbXCOt2HdCmCxqi0Z5tN4NVR184x4
 15GfejPy/qs/Xbfn1bwrfMwX7fgDVFM0GdwAAAA==
X-Change-ID: 20260618-prep-base-v5-15-209-596d47c98637
To: Andrew Morton <akpm@osdl.org>, Antonino Daplas <adaplas@pol.net>, 
 stable@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>, 
 Helge Deller <deller@gmx.de>, HAN Ruidong <rdhan@smu.edu.sg>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1989; i=rdhan@smu.edu.sg;
 h=from:subject:message-id;
 bh=pCtdGjG+ab6vAzMlyNVdJgcjHkRUp/+84n9btP5SAHM=;
 b=owGbwMvMwCG27fhf/yDP2WsYT6slMWQZT6g7of1/Y8mMJOa/t+R4pJPbfD78X7/VX4Gj9HhHv
 eMCDcvtHaUsDGIcDLJiiiw5Nbps8Wedr5ze/qsHZg4rE8gQBi5OAZhIZyLD/2Q31iC5+8qZF8+7
 WsVdqoh9pN8wW2Buv6dIsdUKmfaHHxgZTjWy+4b8/nKk7d0Fk6Z1YeImp9z3HLTb5RTucunk5wg
 mFgA=
X-Developer-Key: i=rdhan@smu.edu.sg; a=openpgp;
 fpr=6C7C2D065FCD43D4CBB7FA8CB6C7FD4F52499BAC
X-Endpoint-Received: by B4 Relay for rdhan@smu.edu.sg/default with auth_id=829
X-Original-From: HAN Ruidong <rdhan@smu.edu.sg>
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
Reply-To: rdhan@smu.edu.sg
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: HAN Ruidong <rdhan@smu.edu.sg>

[ Upstream commit e4ef723d8975a2694cc90733a6b888a5e2841842 ]

Clear the font buffer if the reallocation during console rotation fails
in fbcon_rotate_font(). The putcs implementations for the rotated buffer
will return early in this case. See [1] for an example.

Currently, fbcon_rotate_font() keeps the old buffer, which is too small
for the rotated font. Printing to the rotated console with a high-enough
character code will overflow the font buffer.

v2:
- fix typos in commit message

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: 6cc50e1c5b57 ("[PATCH] fbcon: Console Rotation - Add support to rotate font bitmap")
Cc: stable@vger.kernel.org # v2.6.15+
Link: https://elixir.bootlin.com/linux/v6.19/source/drivers/video/fbdev/core/fbcon_ccw.c#L144 # [1]
Signed-off-by: Helge Deller <deller@gmx.de>
[ renamed `par` to `ops` to match the v5.15 local pointer name ]
Signed-off-by: HAN Ruidong <rdhan@smu.edu.sg>
---
 drivers/video/fbdev/core/fbcon_rotate.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/fbcon_rotate.c b/drivers/video/fbdev/core/fbcon_rotate.c
index ec3c883400f7..4a06e71ae443 100644
--- a/drivers/video/fbdev/core/fbcon_rotate.c
+++ b/drivers/video/fbdev/core/fbcon_rotate.c
@@ -46,6 +46,10 @@ static int fbcon_rotate_font(struct fb_info *info, struct vc_data *vc)
 		info->fbops->fb_sync(info);
 
 	if (ops->fd_size < d_cellsize * len) {
+		kfree(ops->fontbuffer);
+		ops->fontbuffer = NULL;
+		ops->fd_size = 0;
+
 		dst = kmalloc_array(len, d_cellsize, GFP_KERNEL);
 
 		if (dst == NULL) {
@@ -54,7 +58,6 @@ static int fbcon_rotate_font(struct fb_info *info, struct vc_data *vc)
 		}
 
 		ops->fd_size = d_cellsize * len;
-		kfree(ops->fontbuffer);
 		ops->fontbuffer = dst;
 	}
 

---
base-commit: dc027a595035729e290c0adffae363a653acde7c
change-id: 20260618-prep-base-v5-15-209-596d47c98637

Best regards,
--  
HAN Ruidong <rdhan@smu.edu.sg>


