Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7B3FC88E50
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 13:11:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F236A10EE33;
	Mon, 14 Sep 2026 13:10:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YHJGXwf8";
	dkim-atps=neutral
Received: from mail-lr2-f11.google.com (mail-lr2-f11.google.com
 [74.125.230.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3433A10EBFF
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 08:16:55 +0000 (UTC)
Received: by mail-lr2-f11.google.com with SMTP id
 38308e7fff4ca-3a5b0adf48fso12395761fa.0
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 01:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789373813; x=1789978613; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=aUYPK83osLZqDNXLlGB7lbQYloWd+rguo+bEtxrEyi4=;
 b=YHJGXwf8r1Mr9pPaqn0tlAlgrSSw2KxmjjeE+RYA1USZjO1QveAJKcsYQfA4FTW6pL
 dSE9qv+DGWv+6LNKLFLFvOS/3w9moha7Bm3eb0zWxZ7ehMaYV/tjP9R93EDnAxbDoe+y
 ZP43OS/zgOEtNHC6nFDx551qVhq22NE4z2lkqWNyp7VJphuRTOqnqQYIvgqdESZmzrJv
 W8pbVUrvOKVUb3Pjma5j5au+V2RrMI3GZv+DpAIgYtNPT9tzgnLHk/dTOKsM/KXabr7d
 k/l/+7Bcc2L550ITncfIWJtiE1P7YcEZYM25IWsY0Z+YWhIcZbQCVEh9XYAfE9x95jtb
 NGPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789373813; x=1789978613;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aUYPK83osLZqDNXLlGB7lbQYloWd+rguo+bEtxrEyi4=;
 b=BucM8/e/WljQ3l51m0/QQYBcn+uSe9LgT4OnLQ904FLa8jnq3ArguF8mgIhEjoieL/
 Q5VzNrTtYPnU01OOIElwyvMwxHHg0J9jLiMFiIsQjp1+Wy3AIx+c7wMeKvZFbR3bWB73
 BLDUvQ88y3/3TVEy0O+Elbz1/XAYuB13yw6OBGDejuIdMkRscUY6WAAYo3LRpJFxgpK2
 3mP/mcuOPlLtLQ/4Sefh9eRLEzq+RFc0Z/pEeta3e1fNDJNww3JbyFQuzBBb321m2jk1
 81usP7zEpN1UQH66hAyqqrnIrILSUpkSpEl9X83Agxp7KNPeXMR/MpWcNGDY4HB4lwmT
 yWIg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxxjX0n5y9+23MjlGk8PRloZ8cDPYI9HsqFU3N4WBBr5KsnTMht2VxmQZCOKPJ+ZGVqFAAQv0aUJgQ=@lists.freedesktop.org
X-Gm-Message-State: AFuF++n0rClsmDjrnRK9LGtZPOa83j+3HczXp7vWO7Bjc9GVXtEw8svj
 5S+4LA6Vh5ivtM5TsdizcV/FNJKUxOWsTE/jGXLWwKeEvsHPlm66BrG8
X-Gm-Gg: AYBFou3QE4lZjmqzgOABJsiZ8fxgsKAgxZetBYHhOCo6iBrq7AwTOTMA6mVh7qanwpU
 lkkKWHwQhXOgj6izLeHzct7X26ZPBG5yhNuBuxjKqrpxaPpUEAYWu0jNmr9FCMLdEp8M7+c5mcr
 pxN6YC5F/cLDwVA0dCQT1hqMtEG1S0e6mmLKZmi51QaTRAeeRQRht8EUc/3s6Vrkgk84/HrN7p7
 wjTiHXANIdT7xKis9t2q4UPtIWz2hLRQAYnqyUSm3yaSUu9srCqbVZH2/dhrQHd0LUzk2WqC4FJ
 BkpV+9uYBoz6OV7uYzo7++iPjGorr/GvYzGV4ZxdR2HlIwpmascIoFMC/KN8n/xFFYk4I/O3Yg1
 tuHCZfrhg0B3sdPG/jsDqplBBte2hijK40kllJjz0Re44DInNbzpZMGufioJWuaHOCiq1egptDC
 Lzs6/9D1ajzBiBa/1M5PQ80BAUZIAkfDbOZPcBkrOrikFTp5GU+f9Ccube5WSYPPyZW76kTtFHk
 z/ykD86jEt55v+4ZQ==
X-Received: by 2002:a05:6512:3052:b0:5b6:1a7c:fd94 with SMTP id
 2adb3069b0e04-5b8ae6a92b4mr321128e87.58.1789373813016; 
 Mon, 14 Sep 2026 01:16:53 -0700 (PDT)
Received: from localhost.localdomain ([78.40.184.2])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b8a047ab97sm2326043e87.76.2026.09.14.01.16.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 01:16:52 -0700 (PDT)
From: Roman Demidov <roman.demidov.nn@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Roman Demidov <roman.demidov.nn@gmail.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sasha Levin <sashal@kernel.org>,
 Wayne Lin <Wayne.Lin@amd.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Fangzhi Zuo <Jerry.Zuo@amd.com>,
 Mario Limonciello <Mario.Limonciello@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Melissa Wen <mwen@igalia.com>,
 Alex Hung <alex.hung@amd.com>,
 "Mario Limonciello (AMD)" <superm1@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Sunil Khatri <sunil.khatri@amd.com>,
 Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, WenTao Liang <vulab@iscas.ac.cn>,
 George Zhang <george.zhang@amd.com>
Subject: [PATCH 5.10/6.1] drm/amd/display: set new_stream to NULL after release
Date: Mon, 14 Sep 2026 11:16:35 +0300
Message-ID: <20260914081639.12512-1-roman.demidov.nn@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 14 Sep 2026 13:10:56 +0000
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

From: WenTao Liang <vulab@iscas.ac.cn>

commit 9fa26b9eed6195bf840f39ac183b9a6237548755 upstream.

In dm_update_crtc_state(), the skip_modeset path releases new_stream
via dc_stream_release() but does not set the pointer to NULL.

If a later error (e.g., color management failure) triggers the fail
label, the error path calls dc_stream_release() again on the same
dangling pointer, causing a double release and potential use-after-free.

Fix this by setting new_stream to NULL after the initial release.

Fixes: 9b690ef3c704 ("drm/amd/display: Avoid full modeset when not required")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
Reviewed-by: George Zhang <george.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Roman Demidov <roman.demidov.nn@gmail.com>
---
Backport fix for CVE-2026-68236

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index bb5e3a6086f2..deaf98957cb7 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9293,6 +9293,7 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 	/* Release extra reference */
 	if (new_stream)
 		 dc_stream_release(new_stream);
+	new_stream = NULL;
 
 	/*
 	 * We want to do dc stream updates that do not require a
-- 
2.53.0

