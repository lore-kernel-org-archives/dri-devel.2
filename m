Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717BC606A326
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 10:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zgcSASu3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC67510E5BB;
	Mon,  2 Nov 2026 10:38:30 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6570010ECA4
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 10:38:25 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-48e6eb21a8fso1052750f8f.1
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 02:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793615904; x=1794220704; darn=lists.freedesktop.org;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=nIaLyIlOqzSWlOX7liBCjVqH7iW6BW00x93u2nQ8ElU=;
 b=zgcSASu3bxXdbTAirwkR4ZQlFYHX8cCVa7hNdDspuVQE0gzv26hIlP5OsvI/4UJqL7
 NxVD0Cu2mA6kxlRT8XtvcK69SpRgsPADbceO6iYirwyGRW9NtWXRveB8zB44/8vlQKzh
 5dy85oQ5pk+UKiYXMCgxyPyWw5h5Gp7XfaB/aaqFhUWaa4jAH2YM/tULmk6P4il2Zsq6
 qJstYblPWC8GMfRf9nfECWC13SY/+3/UycKcip8aH8njrRZZK4vIfvBU7aX45MNZ7ytC
 n9ubtmhItHf9cX7KRRQvyd2/BEUwscyS8W++ZdZoOrMLuqXCxIUliIQ8jin7ZdK8U6xL
 xihA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793615904; x=1794220704;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=nIaLyIlOqzSWlOX7liBCjVqH7iW6BW00x93u2nQ8ElU=;
 b=Ex8BVIUkEAWdHRww1x/w79DcHZSF51vlthtvEeCLsn02HepWOHPaus0rzb5yabjNOy
 sazR0BMIr5d0oVmSVlPvEbKAIetQVORYRwCWbkQ3YquVaE0ZPVynOMTui/l4FUCnaVX4
 +5MaW4RsDCbnnm9JLLezxi+6Wxi9Go65g2ma6Zk4HYipreRdi/mGv36rq7ZGARYwJa8O
 FCwZKtJIDsJrPcEgjyvI1GY3ioMeHbla6p9A6YMe/AkrfNNy7TareBFToMJJ7UGMQKBE
 gtaPo+q7apdfmmnDInHJNU04ZT2awkntVbBiQjIauvdJgaXb9RMXX5S4+vmFouD3BG0H
 RRdA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzRpKkrtzAlMZb9woh4PeIfquoswljGP1gbjPSwFWwWXbU8kcdqCiHouREEauAV7o4RtiPTYeU6//Y=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIXpfKOP9+Vo0kkOHpwzXVq1kb4msPHWUwwcf+3eDb75FJRVT54
 1OGxKTS0O2bIteHVOfgYTR5fkK9kEJiBBiLUndAvfw9eYbYxvS+nYJ2i
X-Gm-Gg: AYBFou0A6ci/DA60H02zHZYej2CQiBHhM2Ysbi5Brbp5BtckiGHBXB0yGb05FTgJLtP
 av+cg7138EA7Z1VViu54t+A9Qhaisph+BXM7EZpBrOFnEv1OTT1A19rL6CFvvtMc/N5SY1Iy9Rx
 TjFMLCmjN3WLFyZ+bPtHkrMQe8WVe+ykLco1VAOiEHRZxIXdqr5qDk8GzzmsrVF8IJIRFCJAHGN
 0fEmao2NLZjhgBMAqrNB1Ql6NP6RMHhd3gnaNHTp64/ynbq0NBErCFaI0eIP3uuk+qowdJOmBgw
 KPpsVvSc+8qyqMvyuUfZ9xBFtsRuj4s4DzGNY+2+OJRqAUGGcDJUmsCTAaw6GM7xFoPyLmQqGMb
 KpOA+yoPC8UlEuvmSVE+Ish8jrJUboSZ35h+x4Oo9adr+HROnQR0xgQMYzZ7KUf6fVmDp4Sv8ds
 7lj7+XWvcctqEBUOT1EVwt5M2tC7tTeDMowxln+UOR6jfkdc5X/fwlwXjm0i87rqwtkbSQUQOWu
 /ySem/s+wKo1zY5vBLeIDgOnGJjQTkD/TtUdZZ1l4spH3b9/kvbwBCekl3NjncVQqPHEoUX6yfT
 SFtjio+UtN/xn3iB4E4RZazeN/g75bdLcmgLY5oQuxnmuJGqDfFVK6PrTNtdN5wqT3dbcEqIUwT
 k2iZlrSbdYUR1SYjS/oi8w/r2VhqxaieF7bvRQQPW3g5hRFRblng=
X-Received: by 2002:a05:600d:e:b0:4ad:181a:4350 with SMTP id
 5b1f17b1804b1-4ad181a44a0mr139552635e9.21.1793615903562; 
 Mon, 02 Nov 2026 02:38:23 -0800 (PST)
Received: from localhost.localdomain (80-108-121-211.cable.dynamic.surfer.at.
 [80.108.121.211]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abf6c76507sm282109515e9.10.2026.11.02.02.38.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 02:38:22 -0800 (PST)
From: Christian Gmeiner <christian.gmeiner@gmail.com>
Date: Mon, 02 Nov 2026 11:38:17 +0100
Subject: [PATCH] drm/etnaviv: Fix NULL dereference on unbind without PPU
 flop reset
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-etnaviv-unbind-flop-fix-v1-1-588fd16f6768@igalia.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqAIBAAvxJ7biElE/pKdChdayG20JIg+nvSc
 QZmHkgUmRL01QORMifepYCqK3DrJAsh+8KgG90p1WikU6bMGS+ZWTyGbT8w8I3GWRus8dSaAKU
 +IhX9n4fxfT8KF+MpaQAAAA==
X-Change-ID: 20261102-etnaviv-unbind-flop-fix-5c77f75de45f
To: Lucas Stach <l.stach@pengutronix.de>, 
 Russell King <linux+etnaviv@armlinux.org.uk>, 
 Christian Gmeiner <christian.gmeiner@gmail.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Gert Wollny <gert.wollny@collabora.com>
Cc: etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Christian Gmeiner <cgmeiner@igalia.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Christian Gmeiner <cgmeiner@igalia.com>

flop_reset_data_ppu is only allocated on GPUs that need the PPU flop
reset. However, etnaviv_unbind(..) frees it unconditionally, and
etnaviv_cmdbuf_free(..) dereferences cmdbuf->suballoc before checking
whether cmdbuf is NULL.

As a result, unloading the driver on GPUs that do not need the PPU
flop reset causes a NULL pointer dereference at address 0.

Fixes: 85ba57ad88cf ("drm/etnaviv: Add PPU flop reset")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Gmeiner <cgmeiner@igalia.com>
---
 drivers/gpu/drm/etnaviv/etnaviv_drv.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
index 08aca9035fc1..ec1352c1b09f 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
@@ -601,8 +601,10 @@ static void etnaviv_unbind(struct device *dev)
 
 	component_unbind_all(dev, drm);
 
-	etnaviv_cmdbuf_free(priv->flop_reset_data_ppu);
-	kfree(priv->flop_reset_data_ppu);
+	if (priv->flop_reset_data_ppu) {
+		etnaviv_cmdbuf_free(priv->flop_reset_data_ppu);
+		kfree(priv->flop_reset_data_ppu);
+	}
 
 	etnaviv_cmdbuf_suballoc_destroy(priv->cmdbuf_suballoc);
 

---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261102-etnaviv-unbind-flop-fix-5c77f75de45f

Best regards,
-- 
Christian Gmeiner <cgmeiner@igalia.com>

