Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E64BAC61DD6
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 09:45:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2EBF10EF72;
	Thu, 27 Aug 2026 09:44:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imm0nv1nhtv.is-a.dev header.i=@imm0nv1nhtv.is-a.dev header.b="tD8HLVET";
	dkim-atps=neutral
Received: from sg-2-3.ptr.blmpb.com (sg-2-3.ptr.blmpb.com [71.18.227.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E75E10E10E
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 20:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=lark2602131731; d=imm0nv1nhtv.is-a.dev; t=1787777106;
 h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=bQkE0sp1250wEmpHG0fFU1uyDKyKi32y1d4HaaoYnpE=;
 b=tD8HLVET4ZuqyWfqkhTP7joZUg5k6z5THi86/hEvhE4KKxCuk5QSjKwNQ0Cp0+TTevfl8W
 upAF2Lrq6k4vIGpD5uwGaWD2FSHzzXJoMtQIXK5UZykRy85pg2zDb8olBBtSOvwf72Fa1W
 tdmQbxpCLgcjrWURr4AjzjuHHZJ2ZujWPDf0lzTh5bcAS8eyHi+ZQoNZmX3oHp+S1WpwmA
 BF1UDXwjmbh7U5pRNztex61cT4vGZbSGD/IxnzjOMz1DPqQKMPPDgD07IPBwpo3IUHW1dL
 3fpncCP70fgMPXwAQyoF+mqmqHLq2h3ZLx5aBwDJnMPCCiZyWlkhB/6NR4gQUQ==
Content-Transfer-Encoding: 7bit
Received: from Neptune-PC.kiko-royal.ts.net ([58.186.164.158]) by
 smtp.larksuite.com with ESMTPS; Wed, 26 Aug 2026 20:45:05 +0000
In-Reply-To: <20260826204457.4666-1-neptune@imm0nv1nhtv.is-a.dev>
Message-Id: <20260826204457.4666-2-neptune@imm0nv1nhtv.is-a.dev>
X-Lms-Return-Path: <lba+26a8f5052+3907d6+lists.freedesktop.org+neptune@imm0nv1nhtv.is-a.dev>
To: "Harry Wentland" <harry.wentland@amd.com>, "Leo Li" <sunpeng.li@amd.com>, 
 "Alex Deucher" <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Date: Thu, 27 Aug 2026 03:44:57 +0700
Mime-Version: 1.0
References: <20260826170549.21985-1-neptune@imm0nv1nhtv.is-a.dev>
 <20260826204457.4666-1-neptune@imm0nv1nhtv.is-a.dev>
Content-Type: text/plain; charset=UTF-8
Cc: "Rodrigo Siqueira" <siqueira@igalia.com>, 
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, 
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>, 
 <linux-kernel@vger.kernel.org>, 
 "NepNep7601" <neptune@imm0nv1nhtv.is-a.dev>
From: "NepNep7601" <neptune@imm0nv1nhtv.is-a.dev>
Subject: [PATCH v2 2/2] drm/amd/display: close DDC on I2C engine setup failure
X-Original-From: NepNep7601 <neptune@imm0nv1nhtv.is-a.dev>
X-Mailer: git-send-email 2.47.3
X-Mailman-Approved-At: Thu, 27 Aug 2026 09:44:45 +0000
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

acquire_i2c_hw_engine() opens the DDC pins before setting up the
hardware engine. If setup_engine() fails, the error path releases the
engine but leaves the DDC pins open and the engine's DDC pointer set.

Subsequent attempts to open the pins then return
GPIO_RESULT_ALREADY_OPENED, preventing further I2C transfers, EDID
reads and hotplug detection on that port until reboot.

Mirror the normal teardown path by closing the DDC pins and clearing
the pointer after releasing the engine.

Assisted-by: Codex:gpt-5
Signed-off-by: NepNep7601 <neptune@imm0nv1nhtv.is-a.dev>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c b/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c
index 05892ab4529f..e7a05494abab 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c
@@ -485,6 +485,8 @@ struct dce_i2c_hw *acquire_i2c_hw_engine(
 
 	if (!setup_engine(dce_i2c_hw)) {
 		release_engine(dce_i2c_hw);
+		dal_ddc_close(dce_i2c_hw->ddc);
+		dce_i2c_hw->ddc = NULL;
 		return NULL;
 	}
 
-- 
2.47.3
