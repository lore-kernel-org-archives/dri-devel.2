Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EABEAC43327
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 16:30:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C5EE10F4EC;
	Thu,  2 Jul 2026 16:30:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="SsZUx1jS";
	dkim-atps=neutral
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32EB010F4D9;
 Thu,  2 Jul 2026 16:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
 t=1783009480; bh=xYz8IsIbgJ2pPSj19g3xtCx6A7aGJCN0ZFyKL/P6/8U=;
 h=Date:In-Reply-To:References:Subject:From:To:Cc:From;
 b=SsZUx1jSEp2BtBWZnGydCsR9uJgrP41ZXNH0a9qrZqozAcPYilTr4inXcV/UUnxWw
 PIoPPLLzfePBSvhPjvMHw6jVkkcHOFtr5uF7cNTwgGtPgDQ0Zv12fPisfomJo7VGag
 TWfVwoqFaSVuG8u2TP4wi09+IZHvi9BS67b+8l2WkV5kD6vTGmgQHcyD5GihwkFcJV
 fnLJszXRJ8D32gyM2iXDMR1nmyS8ofTYGqL6iRPEPemhxOhKc8rbwCoz3kCFJfWZlY
 XllEfYkH8IJnT0V9gMVi8Sv+vwEt4b8Nc6cQ+cvKQ3NU+TulD8h5ie18TpsVJHcLJ7
 0CovN6xvTqj0A==
Received: from remote.user (localhost [127.0.0.1])
 by rere.qmqm.pl (Postfix) with UTF8SMTPSA id 4grhzr54H1zP4;
 Thu, 02 Jul 2026 18:24:40 +0200 (CEST)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 1.4.3 at mail
Date: Thu, 02 Jul 2026 18:24:40 +0200
Message-ID: <b284acc0dd71b46fbb402ed60f1da23604259e0a.1783009338.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1783009338.git.mirq-linux@rere.qmqm.pl>
References: <cover.1783009338.git.mirq-linux@rere.qmqm.pl>
Subject: [PATCH 3/5] drm/amd/pm/smu7: return error on message send failure
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
To: Alex Deucher <alexander.deucher@amd.com>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Kenneth Feng <kenneth.feng@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
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

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 .../gpu/drm/amd/pm/powerplay/smumgr/smu7_smumgr.c    | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu7_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu7_smumgr.c
index ffe3ce87d907..2e6dfe864306 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu7_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu7_smumgr.c
@@ -141,12 +141,16 @@ int smu7_send_msg_to_smc(struct pp_hwmgr *hwmgr, uint16_t msg)
 
 	ret = PHM_READ_FIELD(hwmgr->device, SMC_RESP_0, SMC_RESP);
 
-	if (ret == 0xFE)
+	switch (ret) {
+	case 1:
+		return 0;
+	case 0xFE:
 		dev_dbg(adev->dev, "SMU message %#x was not supported\n", msg);
-	else if (ret != 1)
+		return -EOPNOTSUPP;
+	default:
 		dev_info(adev->dev, "SMU message %#x failed: response is %d\n", msg, ret);
-
-	return 0;
+		return ret != 0xFFFF ? -EIO : -ENXIO;
+	}
 }
 
 int smu7_send_msg_to_smc_with_parameter(struct pp_hwmgr *hwmgr, uint16_t msg, uint32_t parameter)
-- 
2.47.3

