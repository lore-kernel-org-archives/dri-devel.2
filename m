Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 323F3CD4F42
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 21:47:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CFD510F356;
	Thu, 14 May 2026 21:46:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.b="mFb+5fkT";
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="mFb+5fkT";
	dkim-atps=neutral
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A882E10E37B
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 08:56:57 +0000 (UTC)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=JanbdM56CkwBqJ6g/H1kv8/ziSFNkUIn/j0QG690EJs=;
 b=mFb+5fkT7AH65DQImojKQzSLQDBYrAYFC6/4xWScuPyOQvxrl5MxTR/TDlA93aVW8VwB6POD4
 KHqIxWN/P6cuwNCLryxNK4H3P1pNWMDetoLjOhFrmuDPwD8nCXBsnEtp5pZexjHkJtZE6LHdLRn
 4pqMvPJ/P3/xi7ywv35Tei0=
Received: from canpmsgout10.his.huawei.com (unknown [172.19.92.130])
 by szxga01-in.huawei.com (SkyGuard) with ESMTPS id 4gGPMD6y5fz1BGC5
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 16:56:24 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=JanbdM56CkwBqJ6g/H1kv8/ziSFNkUIn/j0QG690EJs=;
 b=mFb+5fkT7AH65DQImojKQzSLQDBYrAYFC6/4xWScuPyOQvxrl5MxTR/TDlA93aVW8VwB6POD4
 KHqIxWN/P6cuwNCLryxNK4H3P1pNWMDetoLjOhFrmuDPwD8nCXBsnEtp5pZexjHkJtZE6LHdLRn
 4pqMvPJ/P3/xi7ywv35Tei0=
Received: from mail.maildlp.com (unknown [172.19.163.200])
 by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4gGPBy2MWlz1K98N;
 Thu, 14 May 2026 16:49:14 +0800 (CST)
Received: from kwepemk100016.china.huawei.com (unknown [7.202.194.64])
 by mail.maildlp.com (Postfix) with ESMTPS id A345F40563;
 Thu, 14 May 2026 16:56:50 +0800 (CST)
Received: from localhost.localdomain (10.50.85.180) by
 kwepemk100016.china.huawei.com (7.202.194.64) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 14 May 2026 16:56:50 +0800
From: Jiacheng Yu <yujiacheng3@huawei.com>
To: <deller@gmx.de>, <tzimmermann@suse.de>, <simona@ffwll.ch>
CC: <sravankumarlpu@gmail.com>, <dri-devel@lists.freedesktop.org>,
 <linux-fbdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <liuyongqiang13@huawei.com>
Subject: [PATCH] fbcon: Use correct type for vc_resize() return value
Date: Thu, 14 May 2026 17:19:18 +0800
Message-ID: <20260514091918.1607234-1-yujiacheng3@huawei.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.50.85.180]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemk100016.china.huawei.com (7.202.194.64)
X-Mailman-Approved-At: Thu, 14 May 2026 21:46:51 +0000
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

The return value of vc_resize() is int, but fbcon_set_disp() stores it
in an unsigned long variable. While the !ret check happens to work
correctly by coincidence (negative values become large positive values),
the types should match. Use int instead.

Eliminates the following W=3 warning:

  drivers/video/fbdev/core/fbcon.c: In function 'fbcon_set_disp':
  drivers/video/fbdev/core/fbcon.c:1494:14: warning: implicit conversion from 'int' to 'unsigned long' [-Wconversion]

Fixes: af0db3c1f898 ("fbdev: Fix vmalloc out-of-bounds write in fast_imageblit")
Signed-off-by: Jiacheng Yu <yujiacheng3@huawei.com>
---
 drivers/video/fbdev/core/fbcon.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index b0e3e765360d..641687a734d5 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -1440,8 +1440,7 @@ static void fbcon_set_disp(struct fb_info *info, struct fb_var_screeninfo *var,
 	struct vc_data **default_mode, *vc;
 	struct vc_data *svc;
 	struct fbcon_par *par = info->fbcon_par;
-	int rows, cols;
-	unsigned long ret = 0;
+	int rows, cols, ret;
 
 	p = &fb_display[unit];
 
-- 
2.34.1

