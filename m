Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60B7FC982EA
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 07:39:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A3F210E299;
	Wed, 23 Sep 2026 07:39:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="E0g4Nwf1";
	dkim-atps=neutral
Received: from mail-lr2-f11.google.com (mail-lr2-f11.google.com
 [74.125.230.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49E0010E299
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 07:39:32 +0000 (UTC)
Received: by mail-lr2-f11.google.com with SMTP id
 38308e7fff4ca-3a49e7d0b4eso3452991fa.1
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 00:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790149170; x=1790753970; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=IzZ+cNf2z4J5z3qvFn6/NJ8ACjL3I/i0NM3vzaSh4n4=;
 b=E0g4Nwf1Rcuo2gByFcM3JY6vVcE5z45qJtrPFTXEsgNDi3nc6E6BVP4O7oOYJTV7rU
 SiCR2UJgYGj+3fi/rcQXfByYt5LmRssgktVD2JoBLghtMF6pXSYXW1z/XXSbHjSUxH6P
 3q8EzQEK/b5pa8dJ8/ww0VJ2/24RwFGwggq6GnshsBj+3/oNX2mLq1BSZCn76dmXZwu/
 S1S8vukcnrmMR1jfDLOlZ7ZYWhTQ7WSgwFyRhKAfMvQRDa2zn1a+QArBOqV4aLcGFw06
 u41bY7Su5H4WwZaZr8mRM7bXCHkOeC2NEqxcWXi3R0w75VdMTHQdkpErdOqy4Ka+Q4pv
 z9Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790149170; x=1790753970;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IzZ+cNf2z4J5z3qvFn6/NJ8ACjL3I/i0NM3vzaSh4n4=;
 b=P0vhDGFzVtEQEhbH0xO2g7FD7LBP3+14crbMKIrEsSOQxVkNA+Wsv0mchYYRxhKCe7
 dekWIJJzSf8zae7yHNYZNMNE2qxFec9+7RJrDYFACoIckStlYto0GoE0P1qP6roaJT6/
 pO50fSK4nr/GTWydQovisFnmdZHsKl3uliQkEat4LkujZSyHI7/UXIOa9PMqvP53wNoK
 CKw9Tvh5UC/3zN1qLJEC/OXwyj81JjK6cEU5U/YzMPcB3NpF7ZLrH6I8/dW8pUoEhVoI
 v0hSo35lR18LkSE/NafuWQ7hAntzFwruVEJOXDVRSjxMzpT2kI/ptE0ztcVtdGF1YZ66
 cqhg==
X-Forwarded-Encrypted: i=1;
 AKwUvByFXxqsjG1Rkyjoh1FHsexWvocM98dnbNqPAYANcu1po1SWOiv9NlkWNeSQUMKc/mpQvWral7oncvQ=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kY+l5nvNjevIt5VXNSfpc0JtaK4ezY79goYAIxVbblWjWrJ4n8
 zoUHQsFjKTTfw9WUoCsT+jiVD/UKNpfO2jFw0hwe0SuzaHuGxNHVx3Y6
X-Gm-Gg: AYBFou2vSyb7tenVrUVN4uQy/amT5r46zRbdEqslIYeP/s/cRhsnD/mW/SdbO23B6O+
 7hRsnAed0sIUfsqD9ChD7SDVtaueJIr/LOn8PYiNQLV6X82+mkmOxe7D6ZRZjSabQrBWurbgBYj
 rBocs72xUxHUx4rz2kAsU0OVUsBCpCelgxn84gyH2BtiYWTQIqLNES8c2gembCz3Bv48Dd/xWB7
 n6sO00hvQHdcyvIMvVY/MTesk7SyXpIoiZH5dJfJcMI7pqBm4P7511pY4oqWFzOaQDrYWVGt3sg
 1+P4z0oNHn9Hem4k/86ahAaH0yeXUwNBHBHy7LIifjN7nfmJRAGl5IwaB2KIHifQ3v6VW05PP5K
 5zAUgraSHUZ5BBH5Ph2JtnMaMOaclOypmIT79SF9Irc6yfJs+D6GY9yeCOhZnRqmwTdUuxQwrIv
 xJ7uGT/9OcjoZsV/XzIjMVWbPT3U3o/QyJKhoJfGLg1sRJ3utAuFqCRvEXCvedxpmCe0xsjAXqp
 OnKJ1tXjDSlkKgF
X-Received: by 2002:a05:6512:3996:b0:5b6:1a7c:59e8 with SMTP id
 2adb3069b0e04-5b8d8ac9b9fmr472193e87.66.1790149170031; 
 Wed, 23 Sep 2026 00:39:30 -0700 (PDT)
Received: from localhost.localdomain ([78.40.184.2])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b8d8580568sm395754e87.34.2026.09.23.00.39.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 00:39:29 -0700 (PDT)
From: Roman Demidov <roman.demidov.nn@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Roman Demidov <roman.demidov.nn@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org, Guangshuo Li <lgs201920130244@gmail.com>
Subject: [PATCH 5.10/5.15/6.1/6.6] drm/amdgpu/atom: Check kcalloc() for WS
 buffer in amdgpu_atom_execute_table_locked()
Date: Wed, 23 Sep 2026 10:39:12 +0300
Message-ID: <20260923073913.39211-1-roman.demidov.nn@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Guangshuo Li <lgs201920130244@gmail.com>

commit cc9a8e238e42c1f43b98c097995137d644b69245 upstream.

kcalloc() may fail. When WS is non-zero and allocation fails, ectx.ws
remains NULL while ectx.ws_size is set, leading to a potential NULL
pointer dereference in atom_get_src_int() when accessing WS entries.

Return -ENOMEM on allocation failure to avoid the NULL dereference.

Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
[ Roman: added parentheses to the 'if' statement, matching the upstream
commit. ]
Signed-off-by: Roman Demidov <roman.demidov.nn@gmail.com>
---
Backport fix for CVE-2025-68190

 drivers/gpu/drm/amd/amdgpu/atom.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdgpu/atom.c
index cb6eb47aab65..0a7666be1dea 100644
--- a/drivers/gpu/drm/amd/amdgpu/atom.c
+++ b/drivers/gpu/drm/amd/amdgpu/atom.c
@@ -1228,10 +1228,15 @@ static int amdgpu_atom_execute_table_locked(struct atom_context *ctx, int index,
 	ectx.ps = params;
 	ectx.abort = false;
 	ectx.last_jump = 0;
-	if (ws)
+	if (ws) {
 		ectx.ws = kcalloc(4, ws, GFP_KERNEL);
-	else
+		if (!ectx.ws) {
+			ret = -ENOMEM;
+			goto free;
+		}
+	} else {
 		ectx.ws = NULL;
+	}
 
 	debug_depth++;
 	while (1) {
-- 
2.53.0

