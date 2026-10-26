Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA67E606A31A
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 09:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=A/5Z/1/8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 014F010F336;
	Tue, 27 Oct 2026 09:32:06 +0000 (UTC)
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com
 [74.125.82.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66EBB10E38A
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 19:16:59 +0000 (UTC)
Received: by mail-dy1-f173.google.com with SMTP id
 5a478bee46e88-35f036b17easo9092240eec.1
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 12:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793042219; x=1793647019; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=H9O3EyZsKeFAzZtWZLEzjcyBe+AD1OsUYXEPFbUhLD4=;
 b=A/5Z/1/8FCOTzR+oHJsQ04WVP2g794fGFLkWecbXn1aKdnpIoODmq0gRrAc3MSFk3/
 v9/LC7nThTb5ee2G4KQV+sHcciGIgewL8Ll2iWuh+rTQZkHvr7LDCbPprGNgmK4a55SL
 JxQtDjU9Uq7VvTSoCbrH57kqmIRweevuydjbCe0K66C4qgwJG6uJ4qwXiCThDR3bqksU
 qjlAn/rfMqa6zohLVsFgHqg6XsaDQ9tG9jbd2hiGGVX9zKYsszJbfhHiYbOVE2efvkO4
 uQxqRZmwzw69y8LKduL9xpi+UsptvgbMYS6Rhg4UClo242sQAcUyHBIB8iWG+xtfbm7D
 /YDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793042219; x=1793647019;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=H9O3EyZsKeFAzZtWZLEzjcyBe+AD1OsUYXEPFbUhLD4=;
 b=wsD2Ah9iEbBrxz5bN5/MqarSHd3psO6K0EgN9k3T6ddAoQt+MI734890+BeWSgZfyB
 DKTVH8K+Fs5sONCFnl2+En2+GLWCJC1kDhBPFY1o6+hqpe6EhEQx4waAa9T9Yxy8IakS
 q5Z6Q214zB138iBymPTKMQjHojlGkyTQsM6m97CiFtqhMt6hShP28No3S00fXwBlpcj3
 yMJkpJzxxTL2eMV7DHhzKRueL1H559zi6AIJ/dMkSWt84Var8BR1WNwPQOnRKcp2HKXl
 /mOGqFpuTNQh5g8PPtonl9kndhcb+KU0epUER61PIcMDulXr4fLFVHJJtW4W0nLSoxQs
 P/+g==
X-Forwarded-Encrypted: i=1;
 AKwUvBzZwBSgL2eyfC2dH3cf22OyCigRZRao2GA6oMW3Oqb+6GRtO5YRsY3aq/offDmH0Z9x7TFK4b856ZY=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJJY90C7HFxHgJ35QDb4clfkc3UaX6AsvecWkkXKya6sINplIgn
 fCk5qyRGr8ddlH/mDDijjiNQNmOXEUQN/3Nbxt8tsbAYnBxFjPJFNbNv
X-Gm-Gg: AYBFou39zc0BtiaPq6bMYIVqrjPHHmJx8rKvkZ9wVQ2kiUApH+HjEpIY14m6RcWpxYU
 IhNMZ9LkBYBT/JcSeNIFF4MfbzoNIow5IgWwyNvDWmJrUzn2gna+WZQnUrvjw+ymlzTK0unZfNP
 lxN6RE914LeASYm72WBztOQ0zUrjmOJgPe7LcSWwfgqgfRY4pKP8FvT86MnsPLOu3jceAxE5cgF
 XMAhE6KnLCdGg7JWXBZ2eningTYbQgamq7G2qc0ovU7e5r0bW06FwNxI7l34Hd2VzJzaqK4GbYY
 jEnLXl7RvgPZgokNcINEyrXARe+Oka1NE1cHK/gsbWwyq1YPmEuDV5XSH2zmwzKBcUK7xK446rL
 rk6gbEBkGFyWT2/AwhTy1DpcbP9UwMqASHCjB9gdhF6bdf+Ielg4z69vq3LnahJTaW6ATOdgK/M
 x8Q2fsj5OBcd18KudWJpDE8ThAXZtrExrCEHHj/VOKe50kAlHs1T5XbMw6KUlv98aegqAG8MAeo
 fL3o86LLKYWr7XuQ+MUW/Kl/Rol7vrPlVxZsJsso1Ozt77uyzFb0UOKrss27odeg1n2dUmO38EG
 4ojfWVukVjAGj0+jR4Mz
X-Received: by 2002:a05:7300:2301:b0:347:8d01:164f with SMTP id
 5a478bee46e88-369e84b15ccmr18128253eec.19.1793042218554; 
 Mon, 26 Oct 2026 12:16:58 -0700 (PDT)
Received: from localhost.localdomain ([136.126.251.209])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a01fa4c58sm25348449eec.21.2026.10.26.12.16.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 12:16:58 -0700 (PDT)
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
Subject: [PATCH v3 2/4] drm/vc4: dsi: Rate-limit error interrupt messages
Date: Mon, 26 Oct 2026 12:14:56 -0700
Message-ID: <20261026191618.9430-3-henryzhang62@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261026191618.9430-1-henryzhang62@gmail.com>
References: <20261026191618.9430-1-henryzhang62@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 27 Oct 2026 09:31:58 +0000
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
index 5452b727a..face44a23 100644
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

