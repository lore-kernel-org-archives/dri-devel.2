Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70955606A329
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 10:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rjf5coCS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23DD710ECF6;
	Mon,  2 Nov 2026 10:55:14 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F14410ECEB
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 10:55:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DF2FE43C4C;
 Mon,  2 Nov 2026 10:55:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7A2D1F00A1A;
 Mon,  2 Nov 2026 10:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793616902;
 bh=uSesaCAY+uIr3oSTEUZtMDZF+TzayUSuf5NedXKeA8o=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Rjf5coCSfkwrRqfAnpU69wkPv6Uh1wghXxL6qi/qqJkRqnFy+h62k83jc1wNuKPQW
 FsFt9g/ufceyJNJDCK+1grHJS+eG2PQxGaHjVNqfg2j8hJTFog7HoPUM8TKZr5pQrZ
 ujjafjev7fogIiAwRY9KFGyc9d2Jq+6MsIMiYbCgXiSsddi/MFeXkgBppLJYq2yS3L
 nso1s/C9KYwG766b0oWbNVoIqCkh1bP3+4baFkLtYuOEPbdgJrIHKPyaU4pZKX0VkC
 vhnEjTPbglrQ1kL36oTWpLoCbjFYgCLCxHznW1PEmfqA+LeFSRLBE05hjiGkS5wD/Y
 Lnnphxk+THv6g==
From: Hans Verkuil <hverkuil+cisco@kernel.org>
To: linux-media@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: [PATCH 04/13] media: i2c: adv7511-v4l2: call cec_s_phys_addr only if
 EDID is present
Date: Mon,  2 Nov 2026 11:36:55 +0100
Message-ID: <2e25c7038aecc2720a5fe9afc43ca840e4609e98.1793615824.git.hverkuil+cisco@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1793615824.git.hverkuil+cisco@kernel.org>
References: <cover.1793615824.git.hverkuil+cisco@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

If an EDID is present, then call cec_s_phys_addr. If not, then
call cec_phys_addr_invalidate. This helps the CEC framework differentiate
between CEC_PHYS_ADDR_INVALID due to no EDID, or due to an EDID without
a Physical Address.

Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
---
 drivers/media/i2c/adv7511-v4l2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/adv7511-v4l2.c b/drivers/media/i2c/adv7511-v4l2.c
index 27e0e2c31dbd..1cc87049c6be 100644
--- a/drivers/media/i2c/adv7511-v4l2.c
+++ b/drivers/media/i2c/adv7511-v4l2.c
@@ -1466,7 +1466,7 @@ static void adv7511_notify_no_edid(struct v4l2_subdev *sd)
 	ed.present = false;
 	ed.segment = adv7511_rd(sd, 0xc4);
 	ed.phys_addr = CEC_PHYS_ADDR_INVALID;
-	cec_s_phys_addr(state->cec_adap, ed.phys_addr, false);
+	cec_phys_addr_invalidate(state->cec_adap);
 	v4l2_subdev_notify(sd, ADV7511_EDID_DETECT, (void *)&ed);
 	v4l2_ctrl_s_ctrl(state->have_edid0_ctrl, 0x0);
 }
-- 
2.53.0

