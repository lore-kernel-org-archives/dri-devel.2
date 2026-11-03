Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D45A606A332
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 07:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RwLeFBYG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6260810F3F2;
	Tue,  3 Nov 2026 07:40:36 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E226210F3F0
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 07:40:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5CA3D60609;
 Tue,  3 Nov 2026 07:40:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 036D91F00A15;
 Tue,  3 Nov 2026 07:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793691629;
 bh=uSesaCAY+uIr3oSTEUZtMDZF+TzayUSuf5NedXKeA8o=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=RwLeFBYGtodHHrUssFLZPMfSjbxexqX/akQK/ibN7zo66jtcJ1GYgcnYbq2UHB1fD
 F5miYHH/RxHnYb6E99o7GMS1gBbe3wlwFBJhJ2kRBaXbdk1pYXXBYMvp1ym3ki1cm1
 BV14JoD0CK1z12X00cuEaxaQpkuWR2KyoIiFXyQwm8swztCf+oE8Z1eRoAE4hNc0yi
 68KvlLOVv+R9CbiIsYmlkkqgsD/jhJ7RQheJhhmjAdhevG2q++lecKR7qLmPFAxgKT
 P8qYmZ7ecfxh+elPTxTSXGZxa8dartsUBVm3A9oNU7WIAPC+Yb+moq6CKCV5qHQxJj
 DvG/mCaaPPiVQ==
From: Hans Verkuil <hverkuil+cisco@kernel.org>
To: linux-media@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: [PATCHv2 04/13] media: i2c: adv7511-v4l2: call cec_s_phys_addr only
 if EDID is present
Date: Tue,  3 Nov 2026 08:31:55 +0100
Message-ID: <96a98136443ef4d8b2f5ba0cf5c9c15be03e7015.1793691124.git.hverkuil+cisco@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1793691124.git.hverkuil+cisco@kernel.org>
References: <cover.1793691124.git.hverkuil+cisco@kernel.org>
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

