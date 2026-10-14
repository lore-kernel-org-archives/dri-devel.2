Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA076CC6B2F
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 07:57:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CCD8112159;
	Thu, 15 Oct 2026 07:56:49 +0000 (UTC)
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com
 [113.46.200.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9CDC10FC43
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 09:09:42 +0000 (UTC)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=x3EsdaRvMyKuQsUzQnjljfbRPAeeeJAXvtQiAWUd2x8=;
 b=5TafZdWKIXlBi1nRlDXbcwbfutsUMyBNFsvtqbFtk1iBcfIzrYaxAhFDR64HfvbONw22zJUpn
 kRrEn7E/+TsvKVbRPQdhmQTWejV02QSGbXnunv0f9147bpUdw7BzKFEUv7j8/vIBe+jzXtVdKlp
 g5AzFte4oTLvmYGshB8b/wc=
Received: from mail.maildlp.com (unknown [172.19.162.197])
 by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4j4Q8154zGzcZxr;
 Wed, 14 Oct 2026 16:57:37 +0800 (CST)
Received: from whupemp100012.china.huawei.com (unknown [7.152.185.135])
 by mail.maildlp.com (Postfix) with ESMTPS id 6228E40591;
 Wed, 14 Oct 2026 17:09:40 +0800 (CST)
Received: from huawei.com (10.67.174.121) by whupemp100012.china.huawei.com
 (7.152.185.135) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 14 Oct
 2026 17:09:39 +0800
From: Yao Yiqi <yaoyiqi3@huawei.com>
To: <deller@gmx.de>, <tzimmermann@suse.de>, <simona@ffwll.ch>
CC: <dri-devel@lists.freedesktop.org>, <linux-fbdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] fbcon: Retry rotated font allocation after failure
Date: Wed, 14 Oct 2026 08:51:02 +0000
Message-ID: <20261014085102.497789-2-yaoyiqi3@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261014085102.497789-1-yaoyiqi3@huawei.com>
References: <20261014085102.497789-1-yaoyiqi3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.67.174.121]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 whupemp100012.china.huawei.com (7.152.185.135)
X-Mailman-Approved-At: Thu, 15 Oct 2026 07:56:36 +0000
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

fbcon_rotate_font() records the font and rotation it is about to handle in
par->rotated.fontdata and par->rotated.buf_rotate before calling
font_data_rotate(). If that allocation fails it clears par->rotated.buf,
but the cached font/rotation state already looks up to date, so the next
call takes the early-out and never retries. The rotated putcs/cursor ops
keep returning early on the NULL buffer and the console stays blank until
the font or the rotation is changed, even once memory is available again.

Also test par->rotated.buf in the early-out so a failed allocation is
retried the next time fbcon_rotate_font() runs.

Fixes: e4ef723d8975 ("fbcon: Avoid OOB font access if console rotation fails")
Cc: stable@vger.kernel.org
Signed-off-by: Yao Yiqi <yaoyiqi3@huawei.com>
---
 drivers/video/fbdev/core/fbcon_rotate.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/fbcon_rotate.c b/drivers/video/fbdev/core/fbcon_rotate.c
index 6cdbc96eeca6..6b148e0e81e6 100644
--- a/drivers/video/fbdev/core/fbcon_rotate.c
+++ b/drivers/video/fbdev/core/fbcon_rotate.c
@@ -21,7 +21,9 @@ int fbcon_rotate_font(struct fb_info *info, struct vc_data *vc)
 	unsigned char *buf;
 	int ret;
 
-	if (par->p->fontdata == par->rotated.fontdata && par->rotate == par->rotated.buf_rotate)
+	if (par->p->fontdata == par->rotated.fontdata &&
+	    par->rotate == par->rotated.buf_rotate &&
+	    par->rotated.buf)
 		return 0;
 
 	par->rotated.fontdata = par->p->fontdata;
-- 
2.34.1

