Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FD34105F78B
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 10:09:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA02910EB6D;
	Fri, 13 Mar 2026 10:09:55 +0000 (UTC)
X-Greylist: delayed 302 seconds by postgrey-1.36 at gabe;
 Fri, 13 Mar 2026 10:09:54 UTC
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7E3C10EB6D
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 10:09:54 +0000 (UTC)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 13 Mar
 2026 18:04:49 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 13 Mar 2026 18:04:49 +0800
From: Jammy Huang <jammy_huang@aspeedtech.com>
Date: Fri, 13 Mar 2026 18:04:45 +0800
Subject: [PATCH] drm/ast: DisplayPort edid supports 256 bytes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260313-upstream_ast_dp_edid-v1-1-2a75b7c091b2@aspeedtech.com>
X-B4-Tracking: v=1; b=H4sIADzhs2kC/x3MMQqAMAxA0atIZgtqsYJXESnBpJpBLY2KIN7d4
 viG/x9QTsIKffFA4ktU9i2jLguYFtxmNkLZ0FSNq2xtzRn1SIyrRz08Rc8kZNrADil0SNZBTmP
 iIPe/Hcb3/QChjKzYZgAAAA==
X-Change-ID: 20260313-upstream_ast_dp_edid-5fe6adf7ad36
To: Dave Airlie <airlied@redhat.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Jocelyn Falempe <jfalempe@redhat.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>, "Jammy
 Huang" <jammy_huang@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773396289; l=953;
 i=jammy_huang@aspeedtech.com; s=20251124; h=from:subject:message-id;
 bh=q+5Rngv8J3KnnMomdYe31TzEmI3IX581GOcBXpFbRMQ=;
 b=MoAxffeBfxK+iE9TOLE51LGrineVH6IM5f51EaJxGomKp8Jhri0bx4MdSomAtvqZesu3LL+c/
 yvrr2E4cX4qBqlJ2MJGVErby9ltzNyMYu3kBSO8Y5ycmxrGTzBeRukK
X-Developer-Key: i=jammy_huang@aspeedtech.com; a=ed25519;
 pk=E5YwijeJZZcuDR6srvwNlXrNHvLxwipUg3Mb/xxUF9o=
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

DisplayPort supports edid at most 256 bytes. Thus, allow it to fetch
edid block 0 and 1.

Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
---
ASPEED DisplayPort's EDID size can be 256 bytes at most. Thus, EDID
blocks fetched can be 0 and 1.
---
 drivers/gpu/drm/ast/ast_dp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ast/ast_dp.c b/drivers/gpu/drm/ast/ast_dp.c
index 9d07dad358c..c938e1d6b1d 100644
--- a/drivers/gpu/drm/ast/ast_dp.c
+++ b/drivers/gpu/drm/ast/ast_dp.c
@@ -88,7 +88,7 @@ static int ast_astdp_read_edid_block(void *data, u8 *buf, unsigned int block, si
 	int ret = 0;
 	unsigned int i;
 
-	if (block > 0)
+	if (block > 1)
 		return -EIO; /* extension headers not supported */
 
 	/*

---
base-commit: 5ee8dbf54602dc340d6235b1d6aa17c0f283f48c
change-id: 20260313-upstream_ast_dp_edid-5fe6adf7ad36

Best regards,
-- 
Jammy Huang <jammy_huang@aspeedtech.com>

