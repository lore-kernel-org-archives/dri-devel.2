Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95702EA3C5D
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 13:23:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8D7B10E7F4;
	Thu,  9 Apr 2026 13:23:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jbb/Zijd";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98F7C10E7F4
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 13:23:49 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 688BE4423C;
 Thu,  9 Apr 2026 13:23:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF3A2C2BC87;
 Thu,  9 Apr 2026 13:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1775741029;
 bh=cpyLN38qyvMpYLDnGTZI62G7deRPujFBSc+WS6/Reoc=;
 h=From:To:Cc:Subject:Date:From;
 b=jbb/ZijdRe/uXBIDZZsWPwu/cy/NBkCpykHfgs0Wu0Uxcsg2dadumQ9Cm0EJBRcSd
 izmnooFWNmuTYoy9onLE1160mECFpfbnCdP34dAYEN4X5XrLPC59tmYHJePe3AmuoR
 cIGy/nktl3J96bH4z8wJUJe1Eub5TVgsxsvfUQxI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bernie Thompson <bernie@plugable.com>, Helge Deller <deller@gmx.de>
Subject: [PATCH] fbdev: udlfb: avoid divide-by-zero on FBIOPUT_VSCREENINFO
Date: Thu,  9 Apr 2026 15:23:46 +0200
Message-ID: <2026040945-glare-devouring-f242@gregkh>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1050;
 i=gregkh@linuxfoundation.org; h=from:subject:message-id;
 bh=cpyLN38qyvMpYLDnGTZI62G7deRPujFBSc+WS6/Reoc=;
 b=owGbwMvMwCRo6H6F97bub03G02pJDJnXVyQKnrEVFDxSoR1x+KtPikjk3veLX7Nq/J+xUTZXi
 +289/ozHbEsDIJMDLJiiixftvEc3V9xSNHL0PY0zBxWJpAhDFycAjCRj9UM890+eq3cIfFHb8nW
 nKStfPxlDF9O1DPMTy7tmVty1YSPP1FE8rxuRFzz88BnAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp;
 fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
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

Much like commit 19f953e74356 ("fbdev: fb_pm2fb: Avoid potential divide
by zero error"), we also need to prevent that same crash from happening
in the udlfb driver as it uses pixclock directly when dividing, which
will crash.

Cc: Bernie Thompson <bernie@plugable.com>
Cc: Helge Deller <deller@gmx.de>
Fixes: 59277b679f8b ("Staging: udlfb: add dynamic modeset support")
Assisted-by: gregkh_clanker_t1000
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/video/fbdev/udlfb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/video/fbdev/udlfb.c b/drivers/video/fbdev/udlfb.c
index 3c6a9b5758d9..c341d76bc564 100644
--- a/drivers/video/fbdev/udlfb.c
+++ b/drivers/video/fbdev/udlfb.c
@@ -1018,6 +1018,9 @@ static int dlfb_ops_check_var(struct fb_var_screeninfo *var,
 	struct fb_videomode mode;
 	struct dlfb_data *dlfb = info->par;
 
+	if (!var->pixclock)
+		return -EINVAL;
+
 	/* set device-specific elements of var unrelated to mode */
 	dlfb_var_color_format(var);
 
-- 
2.53.0

