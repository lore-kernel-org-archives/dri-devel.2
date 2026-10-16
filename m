Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02DA4CCA46D
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 07:36:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E21E11263F;
	Fri, 16 Oct 2026 07:35:47 +0000 (UTC)
Received: from mail-dy2-f7.google.com (mail-dy2-f7.google.com [74.125.229.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B89010E3F9
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 03:45:57 +0000 (UTC)
Received: by mail-dy2-f7.google.com with SMTP id
 5a478bee46e88-33e5ae86ff2so1742851eec.0
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 20:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792122356; x=1792727156; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qZAMtIxyqaOU5P+355zxZjtsgqUUs04q64AQMCXAlLY=;
 b=g4u+8zRV1s85tzjIrZhhQsxOTFrnkS3epBOSYBk4qdmCj10R6pE5nSspFnfgbG+j5u
 HBqhJ19K58Sby/Tq/8XX3UzykffnmPJpjNmH940IOQ6iKHF6YwjssdQI0VEA8ybYSACp
 TAFF2vSCnvaBvybGekcTgjPAe+W7Ta3I3W4Pc8XsB6EY04+w0Hlz0X0+OGmDGisSZaQo
 3Gy15yrmGzAT00daGCAUtYMJ0ljWGEF3pxgU5ORMWxgUPE36NUSzpDjet+k3qKmD/hBz
 yhZO0rINwXXGcQ2Q4HRXwq4ekLs+lYhdsDHWl5zF2ayw7mH4KmTHrcBUnIWVd9aO8JAs
 2e4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792122356; x=1792727156;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=qZAMtIxyqaOU5P+355zxZjtsgqUUs04q64AQMCXAlLY=;
 b=pVkE951zzpokddq0LSNkEpFGbiyBBiai2j9dxSr4qGpO4IHblgI01sPwtjToi2Vok2
 MWVdanGbfsYb/JYqCgyc0P60WQDc4v5dv2U9K0JNLfCb0sxPO3RDJGGOAgyzSSsl5nDZ
 /m8N2APYfWxWPNfxUTvjEON4wK5Pmxrx/n6x6ImjeWJyzNuW/7033bWpDFyqghNUIyBG
 fqhlK6Qu708+umYGNG4pOJbh9uh7qqh9SZczPGSiTDncl8WXVIKyGHYVDHsL2KX5hhCa
 zfGRa/NaSevOobUl98ZvgJJ/5VBANY20vFMVSnouDnuSRKXr2Em1wATtAS/Blg08HeWO
 7T8Q==
X-Gm-Message-State: AFq9FYI5cfUcHjMtFjuCxMrdIcYBR3veM2sMnf+dA0Eiu+oqRMKaxeCB
 b5mo8D/kZmOd+zQzQ89LGXdyV6niUmapy04dQ6lMrqgUgr+FSdYQaFnJ
X-Gm-Gg: AYBFou1yg4WfeaRwl7hNys1FZJm8Nk6HdecdpKha6wQPsqaR3JL8WvxMk1wd47lWadj
 U19dQqbXwp7x9uo/c11hhH8sWgKY15KawamgZyV9EYXfhe0za+M+Eim1UaqVpssb3ka+RBnj3r5
 PGPNymtA3ILgLytE1SILe6dN0NqtZE/NmNNnaiUOy8l/KnU9sP8sGKYhIq54XYXfXJYB4mKBSDf
 D9N6igCC2eoQHNKoHv4JBkxa6AdsSVPpw57Ctau7Q4KwCJ3SuJ6Q1ZoK8ZgOBw2XOLIzBHb3xcm
 jWNpCYPTC7PW84I1zwzBcOXOEsq/+cGf/fNOgJmDEzfxoLSf8hTP8lDdLiZf1tz+6BWILRhAxFT
 L7Km1Qlx9qaiPlc3WbJYyRq4glygppsyRZI/cZKY462aHL5XiuJ4EEVfZ2vJWGoF+IDCtWpRvD7
 KXB77LdaepL4zr8MBHnkl0T6USHcybe+OkyB46uNovsfdcGd9LdzO+h9zxtpt/RzODmys7alQBm
 1lsJOTPPrQFHcYUZXy+df+7Usf5nd0D07TL6bQ=
X-Received: by 2002:a05:693c:41c5:20b0:35c:ba31:6fef with SMTP id
 5a478bee46e88-35cba3173b2mr12712550eec.36.1792122356200; 
 Thu, 15 Oct 2026 20:45:56 -0700 (PDT)
Received: from blue.tailcc13ef.ts.net (104.194.64.109.16clouds.com.
 [104.194.64.109]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3608297f4f7sm2434229eec.23.2026.10.15.20.45.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 20:45:55 -0700 (PDT)
From: Yao Yiqi <yyaqia@gmail.com>
X-Google-Original-From: Yao Yiqi <yaoyiqi3@huawei.com>
To: deller@gmx.de,
	tzimmermann@suse.de,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, yaoyiqi3@huawei.com,
 Yao Yiqi <yyaqia@gmail.com>, stable@vger.kernel.org
Subject: [PATCH v2 3/3] fbcon: Retry rotated font allocation after failure
Date: Fri, 16 Oct 2026 11:45:33 +0800
Message-ID: <20261016034533.445862-4-yaoyiqi3@huawei.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261016034533.445862-1-yaoyiqi3@huawei.com>
References: <20261016034533.445862-1-yaoyiqi3@huawei.com>
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

From: Yao Yiqi <yyaqia@gmail.com>

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

