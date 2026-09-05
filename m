Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A3D6C79F82
	for <dri-devel@archiver.kernel.org>; Sat,  5 Sep 2026 00:43:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D99610E587;
	Sat,  5 Sep 2026 00:43:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TvTq2pz8";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 083F310E457
 for <dri-devel@lists.freedesktop.org>; Sat,  5 Sep 2026 00:43:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E05A3447B9;
 Sat,  5 Sep 2026 00:43:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ACCC1F00A3E;
 Sat,  5 Sep 2026 00:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788569025;
 bh=/EC9ZBX0cgu1a8NTQofCZuIZlpK7/v0NjA/+edl44jM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=TvTq2pz87OVmpG2aXnDtzAISUiLGEoenKMAESoy6WoEMnisEdTUBGWulmQpaO4Zy/
 gQodzxC9GPjDw6D8K+wRiXg3sgrtxG6Mewx2xirK5eBfXKlCoSaQCJIp3xGicIC0y4
 mhO3vcyz8Mt8nuNAlJ+M6+BOU54L+OsJpKDGLxXakh1O7u3S89/qkzp8O1UpTG6njb
 aQDecBqvQ8+u2Wean9gORMJJPZnw7r8plefEx8rg8lOcL4RjbwKx86urrEc/i4DCG9
 k1t75aaSCOa/uyE7+tH/5xBytEpktQij0Ok12ON/GQvEJNdpBi258JhJnoKPAkZHu+
 N88c2IXGUd1AQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Fri, 04 Sep 2026 19:43:22 -0500
Subject: [PATCH v2 03/19] accel: ethosu: Disable clocks on PM setup failure
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-ethosu-fixes-v2-3-3767738756a4@kernel.org>
References: <20260904-ethosu-fixes-v2-0-3767738756a4@kernel.org>
In-Reply-To: <20260904-ethosu-fixes-v2-0-3767738756a4@kernel.org>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>, 
 Frank Li <Frank.Li@nxp.com>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16-dev
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

ethosu_init() enables the clocks directly to reset and query the NPU
before runtime PM takes over. If runtime-PM setup fails, the error path
returns while those clocks remain enabled.

Disable the clocks before returning the setup error to balance the
initial direct resume.

Fixes: 5a5e9c0228e6 ("accel: Add Arm Ethos-U NPU driver")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
v2:
 - new patch
---
 drivers/accel/ethosu/ethosu_drv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/accel/ethosu/ethosu_drv.c b/drivers/accel/ethosu/ethosu_drv.c
index c684e28ac787..65b148e770e5 100644
--- a/drivers/accel/ethosu/ethosu_drv.c
+++ b/drivers/accel/ethosu/ethosu_drv.c
@@ -311,8 +311,10 @@ static int ethosu_init(struct ethosu_device *ethosudev)
 	pm_runtime_set_autosuspend_delay(ethosudev->base.dev, 50);
 	pm_runtime_use_autosuspend(ethosudev->base.dev);
 	ret = devm_pm_runtime_set_active_enabled(ethosudev->base.dev);
-	if (ret)
+	if (ret) {
+		ethosu_device_suspend(ethosudev->base.dev);
 		return ret;
+	}
 	pm_runtime_get_noresume(ethosudev->base.dev);
 
 	ethosudev->npu_info.id = id = readl_relaxed(ethosudev->regs + NPU_REG_ID);

-- 
2.53.0

