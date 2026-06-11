Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1C2BCD98CC
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 10:49:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13A0310EE63;
	Thu, 11 Jun 2026 10:49:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZgXn7F9y";
	dkim-atps=neutral
Received: from mail-dl1-f68.google.com (mail-dl1-f68.google.com [74.125.82.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E499610EC5B
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 01:30:19 +0000 (UTC)
Received: by mail-dl1-f68.google.com with SMTP id
 a92af1059eb24-137335bc3caso9510450c88.0
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 18:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781141419; x=1781746219; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zzr9EpiC86PYUO+6HwHEv+DWj/5lwfmBLneVLzjCz+E=;
 b=ZgXn7F9yXky2tlPGW11pBfPJnWeAu9ZHLDKb/ds5Abxx9MPA3MDYcJXhT10xUHXLB7
 REkBhHvMc8YEmQGELKs/eYwO3sTsHVv8q8toZk2QLdYiOO/Ifxi+W2OzfUNYYBk7Y4cJ
 GbgDOSQg/7NJUp76khHpvUcWnEf/6UM3giWsM9pTv51umpfZhEDw0WQDif+o3ta3vVLg
 tQVU53gwo5kJRHIKljYOwMlHlnugvo7VJqOjEpr6eXhAPG9OWacBi99WtvXPCshqxrWe
 kkfD63ZO2PXTlHyo/3BL8W3kIqaqG0TN3ccXS6wTl5y8uS9nzxxrNz4WRbE66Z63b6Xv
 LolA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781141419; x=1781746219;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zzr9EpiC86PYUO+6HwHEv+DWj/5lwfmBLneVLzjCz+E=;
 b=dLWNshw/89ulBDZqIwZIbDT0aagkKOeLXDrSshERsbRAfdWwylDLujqwoOu3oMTzTQ
 8xCxRnXcTPb1EHz3cLS5clF4vBOsp+1uQDSWtePZuQ1xxelF9/syFgcOEmUpluDnFrxj
 SDuEFKUszpU03w3KLyl6DF5QRfP8Fdc6Yfh5/AVbcL1q//V1l8yZRwQPGxJUyaVWWWB5
 kmj41oNi0uCdrDKKlODNqUYrfbCQNlwQSr2fVGVygeogu+GZ5js13Z5u19nGfjc5ZxNy
 qSmKfkuBJZu6S2pFbyFBJz/jxbOLI1U/XwBXHKcBNn8V0PakTSyqE2UgUJKy6YqumB21
 RrXA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/mRy7efH89BnIw+1vk/xVXt/dutJYvLc4qW/pqE+xhXkMl7AlUA4BuGadS2paOs5cKkLjP2zWCovo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxcMIhjiwQYKrmxjIjt2bXdvR3cNB1iZENzrleASo7Q3hE1V6vv
 yTGEgvLt/qN/eudz9Mtv+w7MsSJuLu8dzV+6iiaXDVc2zFcsWM5wxiXh
X-Gm-Gg: Acq92OFYZozYJ5bNBRqnAbkPNmcuB5zPB+3cEbtZiCk0ZefCFp5YEJp6DafiKyq9YDb
 6JR1E3lwf4cs9prOodMZbZJAF1TYYc+bSgMxsfX/Z1iwv26hvbOv6RPwF47MQ+CHcFdACTcnwzZ
 JVpCQ89TA9Ng4AztrOoZPyAHpmPTW2qh8S7lCy8TOSAafuPAwP5SIJwmzZCfBoAiQwX0A9jt4CH
 Xy8lUzeo69gSr1hkht9RL1d0OepgvZ6bHe877IhXRogailL79fvgOiiSTLgrQgFzqdPsxpXBDUQ
 68tfxsEITgmMPdQOITsJ3+a6dz4pLw+5hzrAz7ct1YOXoF3DqDxizpFzYNZ37TDLdUMo2VVl+tQ
 ExiYYeGrlX7ZaxngMfqKh4LjFYUBbv2DTyxQXT9gA1B408T2lZveaEu+M/X8ZhGgyoiIsDxfLN/
 ed2Gzmae2bDNOFRiVa31d7PJEru6vIF4j23wbMFXgSB89/Vf28kOzMXgOEWWLV8I/eS7H5l43y7
 c3QGaEWqGE1y5lFDfqAAzcmF16oA3CmSDljHbDPwKYSd/HyHlpKy6fr7uAW16sKbs5+Q5OsF9Et
 4VkP9kcLMzZlxi00IPjI7F3VDIfB
X-Received: by 2002:a05:701b:4183:20b0:136:b370:64c5 with SMTP id
 a92af1059eb24-138422d9798mr282268c88.30.1781141418926; 
 Wed, 10 Jun 2026 18:30:18 -0700 (PDT)
Received: from ethan-latitude5420..
 (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13842ed1ccdsm332436c88.0.2026.06.10.18.30.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 18:30:18 -0700 (PDT)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: Rodrigo Siqueira <siqueira@igalia.com>,
 "GitAuthor: Ethan Nelson-Moore" <enelsonmoore@gmail.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Subject: [PATCH] drm/amd/display: remove check for nonexistent CONFIG_HAVE_KGDB
Date: Wed, 10 Jun 2026 18:30:11 -0700
Message-ID: <20260611013015.433679-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 11 Jun 2026 10:49:05 +0000
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

drivers/gpu/drm/amd/display/dc/sspl/spl_debug.h checks for
CONFIG_HAVE_KGDB or CONFIG_KGDB to determine whether to call
kgdb_breakpoint(). CONFIG_HAVE_KGDB has never existed in the kernel.
Remove the check for it and retain only the correct check for
CONFIG_KGDB.

Discovered while searching for CONFIG_* symbols referenced in code but
not defined in any Kconfig file.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/sspl/spl_debug.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/sspl/spl_debug.h b/drivers/gpu/drm/amd/display/dc/sspl/spl_debug.h
index a6f6132df241..a0e9df382582 100644
--- a/drivers/gpu/drm/amd/display/dc/sspl/spl_debug.h
+++ b/drivers/gpu/drm/amd/display/dc/sspl/spl_debug.h
@@ -5,7 +5,7 @@
 #ifndef SPL_DEBUG_H
 #define SPL_DEBUG_H
 
-#if defined(CONFIG_HAVE_KGDB) || defined(CONFIG_KGDB)
+#ifdef CONFIG_KGDB
 #define SPL_ASSERT_CRITICAL(expr) do {	\
 	if (WARN_ON(!(expr))) { \
 		kgdb_breakpoint(); \
@@ -17,7 +17,7 @@
 		; \
 	} \
 } while (0)
-#endif /* CONFIG_HAVE_KGDB || CONFIG_KGDB */
+#endif /* CONFIG_KGDB */
 
 #if defined(CONFIG_DEBUG_KERNEL_DC)
 #define SPL_ASSERT(expr) SPL_ASSERT_CRITICAL(expr)
-- 
2.43.0

