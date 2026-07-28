Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67C62C53219
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 13:00:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECCA210E8D9;
	Tue, 28 Jul 2026 13:00:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="pr2EqesM";
	dkim-atps=neutral
X-Greylist: delayed 763 seconds by postgrey-1.36 at gabe;
 Tue, 28 Jul 2026 08:42:22 UTC
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B7B810E551;
 Tue, 28 Jul 2026 08:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=OO
 PV6L7HY5yVcZiBAtsBlbq3jqF8pQf+S4wrz3I/d08=; b=pr2EqesMvG66lLcVLE
 3K+qKUrT6nK84R+c9NG6TaBxYr85BYeyiaDOoVY9f5yAF19KOjkFYNPJ2h5x4L9K
 CNEDlM+xXA5btdwbkg4koYou8/E0zbRfo6kqHpil9230b0iHT/m/nG8H7l4J5EJD
 dvN2k5WtXentIUgwsBZTZ52Hg=
Received: from localhost.localdomain (unknown [])
 by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id
 _____wD3X1dgaGhqCgBNLw--.24887S2; 
 Tue, 28 Jul 2026 16:29:22 +0800 (CST)
From: Guo Tenglong <micronull@163.com>
To: Alex Deucher <alexander.deucher@amd.com>
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Guo Tenglong <micronull@163.com>
Subject: [PATCH] drm/radeon: fix typo in comments
Date: Tue, 28 Jul 2026 16:28:54 +0800
Message-Id: <20260728082854.5938-1-micronull@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3X1dgaGhqCgBNLw--.24887S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KFyktw1DGFyxtF4UGF1UGFg_yoW8Xw13pF
 srWFy3Kr90kw4UKw13Zay2yFy5C3Z7ta1jgr4UKw43W345A348XFyfZr1UJr4kJ3y8u3WY
 yFyv934UCF10yr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U2Q6AUUUUU=
X-Originating-IP: [2409:8a0c:6630:3f10:c9d1:37f1:aee3:7fa2]
X-CM-SenderInfo: xplf20hqxozqqrwthudrp/xtbC3ALmHmpoaGKOiAAA3o
X-Mailman-Approved-At: Tue, 28 Jul 2026 13:00:37 +0000
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

Correct "sucess" to "success" in function comments.

Signed-off-by: Guo Tenglong <micronull@163.com>
---
 drivers/gpu/drm/radeon/radeon_device.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_device.c b/drivers/gpu/drm/radeon/radeon_device.c
index 705c012fc..fb79c990a 100644
--- a/drivers/gpu/drm/radeon/radeon_device.c
+++ b/drivers/gpu/drm/radeon/radeon_device.c
@@ -777,7 +777,7 @@ bool radeon_boot_test_post_card(struct radeon_device *rdev)
  * Allocate the dummy page used by the driver (all asics).
  * This dummy page is used by the driver as a filler for gart entries
  * when pages are taken out of the GART
- * Returns 0 on sucess, -ENOMEM on failure.
+ * Returns 0 on success, -ENOMEM on failure.
  */
 int radeon_dummy_page_init(struct radeon_device *rdev)
 {
@@ -969,7 +969,7 @@ static uint32_t cail_ioreg_read(struct card_info *info, uint32_t reg)
  *
  * Initializes the driver info and register access callbacks for the
  * ATOM interpreter (r4xx+).
- * Returns 0 on sucess, -ENOMEM on failure.
+ * Returns 0 on success, -ENOMEM on failure.
  * Called at driver startup.
  */
 int radeon_atombios_init(struct radeon_device *rdev)
@@ -1045,7 +1045,7 @@ void radeon_atombios_fini(struct radeon_device *rdev)
  * @rdev: radeon_device pointer
  *
  * Initializes the driver info for combios (r1xx-r3xx).
- * Returns 0 on sucess.
+ * Returns 0 on success.
  * Called at driver startup.
  */
 int radeon_combios_init(struct radeon_device *rdev)
-- 
2.25.1

