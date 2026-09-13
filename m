Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24672C88E63
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 20:53:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA03510E9D6;
	Sun, 13 Sep 2026 20:53:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="PAC/7A5R";
	dkim-atps=neutral
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com
 [45.254.49.198])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE21010E0A4
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 12:52:08 +0000 (UTC)
Received: from seu.edu.cn (unknown [58.241.16.34])
 by smtp.qiye.163.com (Hmail) with ESMTP id 4d907a3eb;
 Sun, 13 Sep 2026 20:52:03 +0800 (GMT+08:00)
From: Slavin Liu <bolin.liu@seu.edu.cn>
To: jeff.hugo@oss.qualcomm.com,
	ogabbay@kernel.org
Cc: carl.vanderlip@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 bolin.liu@seu.edu.cn
Subject: [PATCH] accel/qaic: tolerate absent crashdump state during cleanup
Date: Sun, 13 Sep 2026 20:52:01 +0800
Message-Id: <20260913125201.109964-1-bolin.liu@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa09ad3229603a1kunm4732dfae2511b8
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCHx5LVk5CSh5OQh5LHRoaSVYeHw
 5VEwETFhoSFyQUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhOQ0
 NVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
 b=PAC/7A5RqifP9Fv2Cv7IoZhQprGO769BWgl/oyOqc+Y0BYNB4/fji2Ngs9QYVz9LmyhfS8pTGOeOVnZYeEEIW9UYrbRs4WVVs8cp90ncloorySyfYJ1y2XNNn2iqDDoIHloPCSEvWgD5hh7f/Lci3OuiKeQ5j5s/lMv1Kqv+Flc=;
 c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1; 
 bh=PO8y2509JB5N7S49pOyCwIPjvSnjKVxeZ9e5YXPBqIc=;
 h=date:mime-version:subject:message-id:from;
X-Mailman-Approved-At: Sun, 13 Sep 2026 20:53:15 +0000
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

A negative response can be sent before crashdump state is assigned.
If queuing that response fails, cleanup receives NULL. Treat that as
no owned crashdump resources instead of dereferencing it.

Detected by static analysis and reviewed with AI-assisted source auditing.

Fixes: 6bc1fe6c748c ("accel/qaic: Collect crashdump from SSR channel")
Assisted-by: LLM
Signed-off-by: Slavin Liu <bolin.liu@seu.edu.cn>
---
 drivers/accel/qaic/qaic_ssr.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/accel/qaic/qaic_ssr.c b/drivers/accel/qaic/qaic_ssr.c
index a98928654959..d9ba1d333cdb 100644
--- a/drivers/accel/qaic/qaic_ssr.c
+++ b/drivers/accel/qaic/qaic_ssr.c
@@ -194,7 +194,11 @@ struct dump_file_meta {
 
 static void free_ssr_dump_info(struct ssr_crashdump *ssr_crash)
 {
-	struct ssr_dump_info *dump_info = ssr_crash->dump_info;
+	struct ssr_dump_info *dump_info;
+
+	if (!ssr_crash)
+		return;
+	dump_info = ssr_crash->dump_info;
 
 	ssr_crash->dump_info = NULL;
 	if (!dump_info)
