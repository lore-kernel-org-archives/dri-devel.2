Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DADF8CCA48B
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 07:36:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F6ED11264C;
	Fri, 16 Oct 2026 07:35:48 +0000 (UTC)
Received: from mail-dy2-f6.google.com (mail-dy2-f6.google.com [74.125.229.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29CF5112622
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 07:31:07 +0000 (UTC)
Received: by mail-dy2-f6.google.com with SMTP id
 5a478bee46e88-3537f63c9e6so1447589eec.1
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 00:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792135866; x=1792740666; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8JLrQsk/HzdxZDjqIwFPPIYECJQe+WNmXx2ayIsdeN4=;
 b=BvFty1pPgnh7+UwqhmHtNOmiZXsfX/BlkDYW11cdzob+dTqhLTcAPSOB9oeUjWpTUk
 UaA/l21E1P89wzzGADRnL1eJtGeeeGKojfTSWctZODs1x3/7ZDqh5NfVKLv/kwjxbOoy
 705civy9Cx8usTemXV4rDCuzW7FrxtP7Ax5wT5iL2fe+bMoMx381vCu6lPPPrM1j64DU
 lmATOXSBZAW3k6TBy1YWHTP6Ushnq3QcSZx+DUl08dg2UoaB17kDec1cP5a14CgcW4q9
 ThHKMGikpe51tyOUc8IL+4ZWvX+zkJH6vOI04ZPz8skWH9eTelquNUE0oCWY+U8EOqsx
 mEjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792135866; x=1792740666;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=8JLrQsk/HzdxZDjqIwFPPIYECJQe+WNmXx2ayIsdeN4=;
 b=oCxMfzr5JZcK56tgBQFdKaYwG9neqxeaJmVyQZTh/pT5Ll/+s2VAfM3jbOeaMXuXWr
 w3BKyBFc/I6JuQnanWH/3Tov1nuapGdkWtWKhnWTTrYqJaYXfBDfNDQuwRrvRUIKMa//
 J19w2xysEeeeQw6WueEfguYJzjDbeNsbAzOvlZmLXazf1INnJiiW2A7swabg+OfwoWef
 ecMjWvuekb2Miq4uqgW2wwSdeozrDmdjw1WpOMnUMh9/IaOWIc1cqrHudWc5tlQbphaE
 zdraH4GDGWrTJWC71qe5CLO43ZJRQVqpjCDnQb9pcNTt24ImJAcIDmYWSGDOA4kwAktF
 dG6A==
X-Gm-Message-State: AFq9FYJ5mlQgyxknnH35TBguAvdfGsAzJExffsa77g5+9t+n9avHRi2F
 cJZDzImkct/K7mc8S80Wy1ix5MxfXk0Qm7zNu3/Y8Z6MgCOmuyTivsqn
X-Gm-Gg: AYBFou3Od0yq3Bgh2MW7OJjz8RIhxjTXmeIAba/o4AYncgwPyGNA6eTaDgZTS0Tjjpy
 umjmNGrtFVa2XehJ28BwhA6UM+TL/kTa5CqjLujyaXNxy9wRvVkXyQKH9FY+8JPX2UJwpbidMWU
 SjfSDlrujuCON+pYme9/PgbNf4e8X8WDa2QYnRBO2ReI8t57dMCWQsdOlGzqXpnAV0ukQC2Rl1b
 zvcfRMCZG3qxZHMNjLZKysTsZKC8GDCnsLyWT/9RNGZAxrL8c7eS7ElhFbZsaJMiDmRCABZ0plz
 l9AqzNt5Pn0fJmWjHC9wWV1CEGnIK6bN1s+glkWJVA2Ve5Sudd976lhHSpNkSJEEvqsReLBHQV2
 NT8SLgRt8jk3x+cQzbbMMn2sAMsH+f6GCoCBzVcPX2dfEf6qsGozf8g1F+57xi+Ig9uh4fPkkUF
 gIO2WDI1d3t/sQn04OfBHfc8+aLISYXrUfCDU2/L+SdmWiSjxqw12oAnZoTnNutV5fZZriLJmbI
 4y/3Ar662f3T2ri4ToqAg5jahcb7vJQNos=
X-Received: by 2002:a05:701b:454b:10b0:14d:baf5:c40e with SMTP id
 a92af1059eb24-16a5faa76admr26546434c88.8.1792135866370; 
 Fri, 16 Oct 2026 00:31:06 -0700 (PDT)
Received: from blue.tailcc13ef.ts.net (104.194.64.109.16clouds.com.
 [104.194.64.109]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1831a6f58c2sm5367021c88.11.2026.10.16.00.31.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 00:31:05 -0700 (PDT)
From: Yao Yiqi <yyaqia@gmail.com>
To: deller@gmx.de,
	tzimmermann@suse.de,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, yaoyiqi3@huawei.com,
 Yao Yiqi <yyaqia@gmail.com>, stable@vger.kernel.org
Subject: [PATCH v3 3/3] fbcon: Retry rotated font allocation after failure
Date: Fri, 16 Oct 2026 15:30:23 +0800
Message-ID: <20261016073023.490430-4-yyaqia@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261016073023.490430-1-yyaqia@gmail.com>
References: <20261016073023.490430-1-yyaqia@gmail.com>
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

From: Yao Yiqi <yaoyiqi3@huawei.com>

fbcon_rotate_font() records the font, its geometry and the rotation it
is about to handle in par->rotated before calling font_data_rotate().
If the allocation fails, the error path clears par->rotated.buf, but
the recorded font, geometry and rotation already look up to date, so
the next call takes the early-out and never retries. The rotated
putcs/cursor ops keep returning early on the NULL buffer and the
console stays blank until a font or rotation with a different key is
installed, even once memory is available again.

Also test par->rotated.buf in the early-out, so a failed allocation is
retried the next time fbcon_rotate_font() runs: at the next
fbcon_switch(), fbcon_modechanged() or font change.

Fixes: e4ef723d8975 ("fbcon: Avoid OOB font access if console rotation fails")
Cc: stable@vger.kernel.org
Signed-off-by: Yao Yiqi <yaoyiqi3@huawei.com>
---
Changes in v2:

- The early-out now also compares the font geometry (previous patch in
  this series); the retry covers the combined key.
---
 drivers/video/fbdev/core/fbcon_rotate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/fbcon_rotate.c b/drivers/video/fbdev/core/fbcon_rotate.c
index 660a3fa81bae..7afd63dcee7b 100644
--- a/drivers/video/fbdev/core/fbcon_rotate.c
+++ b/drivers/video/fbdev/core/fbcon_rotate.c
@@ -25,7 +25,8 @@ int fbcon_rotate_font(struct fb_info *info, struct vc_data *vc)
 	    par->rotate == par->rotated.buf_rotate &&
 	    vc->vc_font.width == par->rotated.buf_width &&
 	    vc->vc_font.height == par->rotated.buf_height &&
-	    vc->vc_font.charcount == par->rotated.buf_charcount)
+	    vc->vc_font.charcount == par->rotated.buf_charcount &&
+	    par->rotated.buf)
 		return 0;
 
 	par->rotated.fontdata = par->p->fontdata;
-- 
2.56.0

