Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A33F606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 07:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jB6VIFln
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78338112070;
	Thu, 29 Oct 2026 07:59:24 +0000 (UTC)
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com
 [74.125.82.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A9F910FD93
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 16:46:18 +0000 (UTC)
Received: by mail-dy1-f176.google.com with SMTP id
 5a478bee46e88-33bf40b0c8bso66724eec.0
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 09:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793205977; x=1793810777; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=B4aeA1JDhDSlavAe3QtN317ZVxvJh8xk7OKR4/iEpbs=;
 b=jB6VIFlnN0M1j0WmXzo+LRMXeCP07A2SP3ROQFJ8Cfd/eZB9FRJCiaLfmKwMxkHm/O
 Rz8LeNaanDJouPTc0cOOI6EjyO9yQrrttdNPYbk+/jj1QY2PcZM/N8Z6aJ8QYbfycC7f
 YFyEk31XpWoe8j1ZXIKfx5G4Ous0BkmcF3Q3bu8F0OeSzdnZJjFQcltEeqeUT1COKb9Q
 BDBuAYNbSezDGuz6ntz9q4mhgD1Y30FnX9MwXcZpR/jjmdtWpwg6Rb56SyhI2csGdY43
 lQYDm9L23b2KUfu9SI3DEJFR/ZUr1+wZauEZItBuaJOtaGKGdHhz7+DBD3CJy1ryjHDe
 WvLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793205977; x=1793810777;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=B4aeA1JDhDSlavAe3QtN317ZVxvJh8xk7OKR4/iEpbs=;
 b=xr9zJafSRlqbPENuDer0oC0GHASNxjW3O+p9M4hjDmVjWVlEBm+n522jtga3L6Z8tQ
 chrI0gmdPiY1EiJScIrwL1xMTAwE20vAiMhzlY49v+YP9xDVd8DfClu61CRgjvH/WRtD
 rWS5M1E2gWHd3RQctCb5Je1uFgKoa46ca5PmHvhL4gEu5LxNbL/KCImZkO6u3NH9wDqI
 GbIamUQ3ayFr5ScBGaTyE3ECTWKhGGia+OLnGI5f7wyiV1Lwh0WIXQofNGJd/4QVCGdQ
 8gtWvhcoV94wl/X5wHWZsLAZjSBZCZ7uUSIZcUN00/LKnAH8JZBq6K8V7tWaSt6jSaA9
 oxAw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxbv4BgBjxC01vN+q+wwD4YK05JH/RHCI7nEMbrBfeIk0goPYQhR/enLGyokDMLzXSe7HEqqNxDiF8=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIa/+kLX6FKb1JT2h85+azIU9k675cMcT1H0wOk7XzJpwZDeK4o
 o/fGl9VK3STyuWJIMnz52eRjiG1YP0lQ+J/UUIVpEqNz95BoNh8Vkoa+
X-Gm-Gg: AYBFou24PoRw73LRczDRrW3eWhMI43EYgX9erbgPLoT76+P0Xz0p4wn71sOnJ+0ayQu
 IwMV1RBnhKPozkNvXmLybduMm8cHURp5m0oc1W5ZCZxWx4jcqa6n9FwU+7+9p96bgqlbQjtMXAu
 h92DK7Ht/vMNKFIwPUwWfc6WuRsZQPzX6CkjmhjGup2jZya8Jf8WyxqywIhDKijD3bpVJcS07vB
 qn1IZLc14p9G898NrNenvAMBBh2vuHsj2OkCa7uX5TyXtj6oPDJ++V+B6OfhPQHCsN53jqK4rNZ
 eFBV1AWGZ32zLQCcGqfj8fFRPfsqq1bCQf7MbMe0eodXkmH1mGFUbJG/gFbysxIARgPCyyMIJHl
 crrCIcSAG+9K3UAukyXg00i14qHKg+1BdLAgsIfGwggqB0irS4qoXD64MfhdGdmQ+y0QNP8zWhX
 5+PSHGBPrmtrjXP/A1o/M5Lmt8UKlyzWAPKvpYNbSLLLmYND0j0VsAorbuTMiC2IDi6pYD+EGmU
 SaTlx4jdIFddtzSLSg0cATq8OhSnFFVa4dpxOUPsEbofZ4SNlP8xQj3uZoZJpMst+fnwVsAwq3b
 RXsAkPeC/ok7BP6N3hLccaRTlo1nQhcQaZANMZsXc3kSMR9lFw4GC0UMOQceyC6MVeokId7OxPn
 QcGS0iFBurEfBQ1bS
X-Received: by 2002:a05:7301:4d08:b0:360:905a:7c27 with SMTP id
 5a478bee46e88-36a20417e00mr3738593eec.26.1793205977381; 
 Wed, 28 Oct 2026 09:46:17 -0700 (PDT)
Received: from localhost.localdomain ([136.126.251.209])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a23908449sm7821964eec.11.2026.10.28.09.46.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 09:46:16 -0700 (PDT)
From: Henry Zhang <henryzhang62@gmail.com>
To: Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: Henry Zhang <henryzhang62@gmail.com>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/5] drm/vc4: dsi: Rate-limit error interrupt messages
Date: Wed, 28 Oct 2026 09:45:28 -0700
Message-ID: <20261028164539.3471833-4-henryzhang62@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261028164539.3471833-1-henryzhang62@gmail.com>
References: <20261028164539.3471833-1-henryzhang62@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 29 Oct 2026 07:58:56 +0000
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

The error interrupts (contention, sequence and timeout errors) are
always enabled and each one is logged with drm_err() from the interrupt
handler. When a peripheral leaves the data lanes in a bad state, the
same error is raised again as soon as it is acknowledged. On a
Raspberry Pi 4 a "data lane 0 sequence error" was seen at more than
50000 interrupts per second; printing every one of them, mostly to a
serial console, starved the rest of the system to the point that the
SD card driver timed out and the board had to be reset.

Use drm_err_ratelimited() so that the errors stay visible without
taking the system down.

Signed-off-by: Henry Zhang <henryzhang62@gmail.com>
---
 drivers/gpu/drm/vc4/vc4_dsi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_dsi.c b/drivers/gpu/drm/vc4/vc4_dsi.c
index 1eea60aec..be9caaf50 100644
--- a/drivers/gpu/drm/vc4/vc4_dsi.c
+++ b/drivers/gpu/drm/vc4/vc4_dsi.c
@@ -1487,8 +1487,8 @@ static void dsi_handle_error(struct vc4_dsi *dsi,
 	if (!(stat & bit))
 		return;
 
-	drm_err(dsi->bridge.dev, "DSI%d: %s error\n", dsi->variant->port,
-		type);
+	drm_err_ratelimited(dsi->bridge.dev, "DSI%d: %s error\n",
+			    dsi->variant->port, type);
 	*ret = IRQ_HANDLED;
 }
 
-- 
2.47.3

