Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F583606A32F
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 08:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sDAHg3c5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F6AD10EB9D;
	Mon,  2 Nov 2026 08:03:45 +0000 (UTC)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF0DF10EB9D
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 08:03:38 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-2e5378b281aso14992995ad.2
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 00:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793606618; x=1794211418; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Z8EJgkp2KeWeadwF4AcKa6qCzv/o/cHNGkKe7Zmmr4k=;
 b=sDAHg3c5a4xR6OZKKbUDxsXWiGlAEP4evw2rLSdKICM4xvjug1Na/Kgoo6N4RP74gx
 PlonqBed9NAv7POUwox36/0zm1zuQSQBGL+4UT9Rl3J8U3YFV7iPb3j345qY8/vEF1mG
 nmW7tdocElwQSVFp8NpjBQlmAretWNS/rMA/CXAlyQXV5YlneyxnSKSTjj8XxF4fgmj/
 Vy8bKnelQ4uWuSghifr8VA2b89QKM/D2/r4hAL/3xC5nke8lSV/9P66Z7qD5/BXoArVL
 jm8wqE21m/h8CI/w1NVD0GEGyBVa2JLbDvS8FfNTr8ZPL8C4ST3HiLL8OvyAW27UWAQ0
 FXPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793606618; x=1794211418;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Z8EJgkp2KeWeadwF4AcKa6qCzv/o/cHNGkKe7Zmmr4k=;
 b=qMCGeXndGMw6jtnHJBR7IRUjvUsAMlC0hEBab7t6uq+UMR4BXGwg/ZRmI1wIWkpmYS
 r1aopKrZT+U/AUc9lixrGqk4IvBt6iqVk0of7/oUaPFMBYW22U7MUGgxtUiKft8DJLXp
 5GHrFChaNKzvR8oMs0ZQ1xO7iytUmVLwtFGI/kYLOB5wa7mF3AAd93gdGqTaZ3sWoRsZ
 MbKdiFaRTIYZH/XxDaliyYnLrllc1C9IQsSyF8eS5y2E2rf52Z51oEt57G2yWNItqXhZ
 a6QH1hrTT8MCr1A9K+0HFTL3cNDVIzP2OqHef3GZLDBXDf7TopW35vpFaCUat+YQXZvS
 Akyw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwlvBfr3cSvnyGNjO02YrKUhkwuxbESJHkbAkULOM9UVjhTV2VkA13eSXKbZ1EX/dYf46lUkFAQGKY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+sA6h7G7LzMLVEQJx+GnGhy/sZwjWo4e4/FfuQuQ3fZpYCYJi/
 UiqImUyFUoEZ34cNbGwawh9bOKv6kUe1ufOpoXW7DcyV0CoQkdWQ6n+H
X-Gm-Gg: AYBFou12e5Wv0qy/IMBqw3M8NcqgT36HSv5iYKjzoxyegE5OSvQS0QJNE9Zk4aZ9bkj
 fxmaYiFo64toE8Ms8Qy30f9YqQJlCn4+6gXD/tOzL1zopY1ZnGpCyHk+gOb9CnVYQLz+dnKDAJV
 g2Bk4BcW6HoXqjdsAzD6Hn5qx53HyR/064Uog0nhDtFXoUFGS/BwqQNlpQkRDMgyqg3j5f8bt2J
 qwMvJwUSe5csvF0GaUGa2lnlLn0tv2RmELt1JIWFUsC//FmzGayzFgtQQoxLomuUkuTAp19hGvQ
 qfbDCOwDzUiS92opgLdByumIllZ0ysrB5cWqtDIUkwAiqGrwNMjyoGY1ofHnyR9tuNehsW+SEUM
 Ru5gAndBwGZqPyYVZyrI3NnIWqB6hyYY6nsOhSo2KeDU3N2yV4T+SlrwVU9Tcax0KuYjM3RqfsV
 dADddXYyrFJ6nFgBGVlr1EIxLUyzhTYDgBj5d9DNHhoUlYYdhv4hSSuezy/8EdOjThvFb2ttPJB
 LhFk7+U4/2O4p+VgXJim68ezIdkrSnNZeI8B1f9hh1cw4t0WFqAJGsNVImS2lBdMqlR3ObqXgcd
 e84YxUFcUuFZee2iDIYTCN09W10ODv+wAnVHnVd07V7amaipnk29RQeTNo5gZQxACQ7tf7+LeEM
 WfgHk3hQMxhwdHZ3UXJRNAV4DQWIHJ9hB4PPWUYcS8Zzg3VBKiJV10Me5BQn4i5iPTORoyWLYDV
 qq+VNC55IQCO9snsw=
X-Received: by 2002:a17:903:18b:b0:2e2:b624:54b7 with SMTP id
 d9443c01a7336-2eb3649b19emr87836225ad.17.1793606618284; 
 Mon, 02 Nov 2026 00:03:38 -0800 (PST)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2eb392afa5asm23573655ad.72.2026.11.02.00.03.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 00:03:37 -0800 (PST)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] fbdev: pxafb: unregister cpufreq notifier on removal
Date: Mon,  2 Nov 2026 16:03:30 +0800
Message-ID: <20261102080332.1466689-2-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102080332.1466689-1-matthias.goergens@gmail.com>
References: <20261102080332.1466689-1-matthias.goergens@gmail.com>
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

pxafb_probe() registers a cpufreq transition notifier, but
pxafb_remove() never unregisters it.  The notifier block is part of
struct pxafb_info, which is devm-allocated and freed after removal, so
once the driver is unbound or the module unloaded, the next CPU
frequency change calls pxafb_freq_transition() through freed memory.

Unregister the notifier in pxafb_remove().

Sashiko, the AI review bot, pointed this out while reviewing a pxafb
cleanup.  I have no PXA hardware; this is build-tested only.

Link: https://lore.kernel.org/all/20260722081427.413EF1F000E9@smtp.kernel.org/
Fixes: 9f17f2874834 ("[ARM] 5118/1: pxafb: add exit and remove handlers")
Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
---
 drivers/video/fbdev/pxafb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/video/fbdev/pxafb.c b/drivers/video/fbdev/pxafb.c
index 1682345fb9b0..4f5c408eae56 100644
--- a/drivers/video/fbdev/pxafb.c
+++ b/drivers/video/fbdev/pxafb.c
@@ -2384,6 +2384,10 @@ static void pxafb_remove(struct platform_device *dev)
 
 	info = &fbi->fb;
 
+#ifdef CONFIG_CPU_FREQ
+	cpufreq_unregister_notifier(&fbi->freq_transition,
+				    CPUFREQ_TRANSITION_NOTIFIER);
+#endif
 	pxafb_overlay_exit(fbi);
 	cancel_work_sync(&fbi->task);
 	unregister_framebuffer(info);
-- 
2.56.0

