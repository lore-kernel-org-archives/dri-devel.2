Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA2BCC43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 16:30:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9110110F4D9;
	Thu,  2 Jul 2026 16:29:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="kxGeIi2i";
	dkim-atps=neutral
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CC7610F4DD;
 Thu,  2 Jul 2026 16:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
 t=1783009480; bh=YuJVkhEfcgaku4wOWS2SXkCc3/Q3CpYqNBhzmDhas60=;
 h=Date:In-Reply-To:References:Subject:From:To:Cc:From;
 b=kxGeIi2i5d+7183oVQFPlU5HR5zElNsysUWUX15VK+2bpHCaVuK5+xqdIOCMQPd/O
 doqppXRegZ3Wz9TiPB/GnC6D2l9mhTCcFJALiMFVdvo9IiDsJK7MDwT9DHlqzoNh4r
 cvSdKk4CXDng/MuCmctHz4jxY3t7mdCTKO/CQ7CkCA4pXwBsulPIr0wtdprmFJaB0G
 nl2BAJlCyNP+2ceOdFlpCYzv0fu2ivJQ8l8q6yCQUfLjsV1E/XYAxEfNlKCiDxBat0
 xyeXkXLGC+7vLCTbLkzpNm1HK5eeP7XtAu67QJjhX+mdxa15HNrFqBVuEWQSZ1hktQ
 8ghJX7fK+c9Dw==
Received: from remote.user (localhost [127.0.0.1])
 by rere.qmqm.pl (Postfix) with UTF8SMTPSA id 4grhzr1yCgzKq;
 Thu, 02 Jul 2026 18:24:40 +0200 (CEST)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 1.4.3 at mail
Date: Thu, 02 Jul 2026 18:24:40 +0200
Message-ID: <df3064b3a250a694e39adedd96b9f2133eb3dcf6.1783009338.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1783009338.git.mirq-linux@rere.qmqm.pl>
References: <cover.1783009338.git.mirq-linux@rere.qmqm.pl>
Subject: [PATCH 2/5] drm/amd/pm/smu7: make SMU message reports more readable
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
To: Alex Deucher <alexander.deucher@amd.com>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Kenneth Feng <kenneth.feng@amd.com>, Leo Li <sunpeng.li@amd.com>,
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

Make the lines greppable by removing an extra EOL and report the
status only once - after the reply is detected.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 .../gpu/drm/amd/pm/powerplay/smumgr/smu7_smumgr.c   | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu7_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu7_smumgr.c
index 0d4cbe4113a0..ffe3ce87d907 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu7_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu7_smumgr.c
@@ -134,14 +134,6 @@ int smu7_send_msg_to_smc(struct pp_hwmgr *hwmgr, uint16_t msg)
 
 	PHM_WAIT_FIELD_UNEQUAL(hwmgr, SMC_RESP_0, SMC_RESP, 0);
 
-	ret = PHM_READ_FIELD(hwmgr->device, SMC_RESP_0, SMC_RESP);
-
-	if (ret == 0xFE)
-		dev_dbg(adev->dev, "last message was not supported\n");
-	else if (ret != 1)
-		dev_info(adev->dev,
-			"\nlast message was failed ret is %d\n", ret);
-
 	cgs_write_register(hwmgr->device, mmSMC_RESP_0, 0);
 	cgs_write_register(hwmgr->device, mmSMC_MESSAGE_0, msg);
 
@@ -150,10 +142,9 @@ int smu7_send_msg_to_smc(struct pp_hwmgr *hwmgr, uint16_t msg)
 	ret = PHM_READ_FIELD(hwmgr->device, SMC_RESP_0, SMC_RESP);
 
 	if (ret == 0xFE)
-		dev_dbg(adev->dev, "message %x was not supported\n", msg);
+		dev_dbg(adev->dev, "SMU message %#x was not supported\n", msg);
 	else if (ret != 1)
-		dev_dbg(adev->dev,
-			"failed to send message %x ret is %d \n",  msg, ret);
+		dev_info(adev->dev, "SMU message %#x failed: response is %d\n", msg, ret);
 
 	return 0;
 }
-- 
2.47.3

