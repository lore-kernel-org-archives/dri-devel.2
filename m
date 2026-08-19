Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13A47C5B572
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 06:03:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4589310E2B5;
	Wed, 19 Aug 2026 06:03:57 +0000 (UTC)
X-Greylist: delayed 302 seconds by postgrey-1.36 at gabe;
 Wed, 19 Aug 2026 06:03:55 UTC
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B783F10E2B5
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 06:03:55 +0000 (UTC)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 19 Aug
 2026 13:58:50 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 19 Aug 2026 13:58:50 +0800
From: Jammy Huang <jammy_huang@aspeedtech.com>
Date: Wed, 19 Aug 2026 13:58:37 +0800
Subject: [PATCH v3] drm/ast: DisplayPort edid supports 256 bytes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260819-upstream_ast_dp_edid-v3-1-15d36c28afe2@aspeedtech.com>
X-B4-Tracking: v=1; b=H4sIAAxGhWoC/4XN0QrCIBTG8VcZXmd4tCnrqveIGE7PmhfbRE2Ks
 XfP7SqI6PL/wfmdhUQMDiM5VwsJmF1081RCHCpiBj3dkTpbmnDGJRMg6MPHFFCPrY6ptb5F6yy
 te5Ta9kpbIUk59QF799zZ66304GKaw2v/kmFb/4AZKFCuVd0pwxro+EVHj2gTmuFo5pFsauafk
 voh8SIJACkVE+bUwJe0rusbt/OquAcBAAA=
X-Change-ID: 20260313-upstream_ast_dp_edid-5fe6adf7ad36
To: Dave Airlie <airlied@redhat.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Jocelyn Falempe <jfalempe@redhat.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <jani.nikula@linux.intel.com>, <ville.syrjala@linux.intel.com>, Jammy Huang
 <jammy_huang@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787119130; l=2920;
 i=jammy_huang@aspeedtech.com; s=20251124; h=from:subject:message-id;
 bh=mOF4mUY8m9fVNE8LqeVkJT2xXPKlpZXeHeztxFh1mws=;
 b=NeYUgk5661rr81bAvbou0cJgbc2pDl6Dsyn+97b1WdEPVy91Hvjc6W62MGWkc0fzsHbhSkOV+
 vKSVnTXrSCODlVOu1h9G5kOeV2a+OjkdPC+uCloMuL4TrMBwLZ+KLny
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

DisplayPort supports EDID up to 256 bytes (blocks 0 and 1). Update the
block check to allow these two blocks. For any block beyond that
(i.e. the monitor's EDID is larger than the 256 bytes ASPEED DP can
hold), report it as an all-zero block instead of a read failure.

Also remove the manual checksum/extension-count patch of block 0's
last four bytes. That code was already dead, so the condition can never
be true.

Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
---
ASPEED DisplayPort's EDID size can be 256 bytes at most. Thus, EDID
blocks fetched can be 0 and 1.
---
Changes in v3:
- For block > 1, write a zeroed buffer. Returning a zeroed block
  instead makes drm_edid's block checker classify it as
  EDID_BLOCK_ZERO, which is treated as a non-fatal invalid block.
- Link to v2: https://lore.kernel.org/r/20260317-upstream_ast_dp_edid-v2-1-31166703c491@aspeedtech.com

Changes in v2:
Becasue drm-edid will handle invalid EDID if happen, we have 2 changes
below.
- Return 0 for the number of block more than 1.
- Remove modification of EDID
- Link to v1: https://lore.kernel.org/r/20260313-upstream_ast_dp_edid-v1-1-2a75b7c091b2@aspeedtech.com
---
 drivers/gpu/drm/ast/ast_dp.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/ast/ast_dp.c b/drivers/gpu/drm/ast/ast_dp.c
index 9d07dad358c..38530cd126c 100644
--- a/drivers/gpu/drm/ast/ast_dp.c
+++ b/drivers/gpu/drm/ast/ast_dp.c
@@ -88,8 +88,14 @@ static int ast_astdp_read_edid_block(void *data, u8 *buf, unsigned int block, si
 	int ret = 0;
 	unsigned int i;
 
-	if (block > 0)
-		return -EIO; /* extension headers not supported */
+	if (block > 1) {
+		/* ASPEED DP's EDID buffer holds blocks 0 and 1 only (256
+		 * bytes). Report anything beyond that as an all-zero block
+		 * rather than a read failure.
+		 */
+		memset(buf, 0, len);
+		return 0;
+	}
 
 	/*
 	 * Protect access to I/O registers from concurrent modesetting
@@ -154,20 +160,6 @@ static int ast_astdp_read_edid_block(void *data, u8 *buf, unsigned int block, si
 		ediddata[2] = ast_get_index_reg(ast, AST_IO_VGACRI, 0xda);
 		ediddata[3] = ast_get_index_reg(ast, AST_IO_VGACRI, 0xdb);
 
-		if (i == 31) {
-			/*
-			 * For 128-bytes EDID_1.3,
-			 * 1. Add the value of Bytes-126 to Bytes-127.
-			 *		The Bytes-127 is Checksum. Sum of all 128bytes should
-			 *		equal 0	(mod 256).
-			 * 2. Modify Bytes-126 to be 0.
-			 *		The Bytes-126 indicates the Number of extensions to
-			 *		follow. 0 represents noextensions.
-			 */
-			ediddata[3] = ediddata[3] + ediddata[2];
-			ediddata[2] = 0;
-		}
-
 		memcpy(buf, ediddata, min((len - i), 4));
 		buf += 4;
 	}

---
base-commit: 5ee8dbf54602dc340d6235b1d6aa17c0f283f48c
change-id: 20260313-upstream_ast_dp_edid-5fe6adf7ad36

Best regards,
-- 
Jammy Huang <jammy_huang@aspeedtech.com>

