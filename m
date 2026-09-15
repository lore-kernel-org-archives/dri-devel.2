Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79435C88E53
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 07:47:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9983510FAC8;
	Tue, 15 Sep 2026 07:47:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZuIX6xkG";
	dkim-atps=neutral
Received: from mail-lr2-f4.google.com (mail-lr2-f4.google.com [74.125.230.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DEBF10FAC8
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 07:47:28 +0000 (UTC)
Received: by mail-lr2-f4.google.com with SMTP id
 38308e7fff4ca-3a48db5ecfcso22892361fa.0
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 00:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789458446; x=1790063246; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=reJctIGiQbHHtQqBXNj1e8Lzl4odeNP0FCDfrK7fh/A=;
 b=ZuIX6xkGtBJGeZmOCiUguRHHEaO3VrF9LurFIO1CwtuKatmRe1hAY1MQVkqi2Bqjkk
 gRmQy/fMqJ/4oh46WBYBGdsRzpUBh/4qVkA4dFsWTN02mEaojRjoTtGSGtfXb+bvhBKk
 a6Xc5viSEmynONBJ0oD3QmgxApHNTouHV9Ak0Dm9TkxetFSkucgnq4/Xt25Af8qq+PG5
 iJjABk4v/TXyIVpZBfxen5/LKEcm0NWE4Ywx8cjcirljYrkZT4vSMR6EACJGV5sCWtpo
 QEk069eAdDJs+R+ttgRjEUKQ0k58e/+NpCka/jePCrnA0LeT+4YpQoV6GibgURjqU5uI
 9w4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789458446; x=1790063246;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=reJctIGiQbHHtQqBXNj1e8Lzl4odeNP0FCDfrK7fh/A=;
 b=LnRvL6tTkUV2cieeZBgKIYDAunZuPkhVMtmJ/TZ4vHFU2ZE021CpM40WWnhSC82SEc
 WG+9y1nnDE4lbpgPJIpJawd1RiQGF3chaGVSXNSH2dnX1VVQlhLUtTEcIjjiTXPiEqdz
 Up6W6mXlmH4sv6eAHB/lPjAuAWRyKLAJKolNm+UR7Z9aPNjCywlDS9CT1sbDZ3ptnB9H
 9YXYu26FPstCyjDmLD/07t+MaBZWlhSr8rwogbyQyBw2whkBwZjl6PGr0hmZskLLx3TV
 I/Pmzwtm4Akgvobx/KS7V0oF/4cp2xzPxD0ybYrR+qSv0eegkBzEoQ64JfpSPPGl5x+6
 jZWw==
X-Forwarded-Encrypted: i=1;
 AKwUvBykjWxMxRvFeho7eD0Dx7awx6Pov9p9oeYkPzT44Dqb3aNjKLJZtKrsW3qWWf1p+G7lYI0cqZFwLkI=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mBmRG8h4MEMeQI/susAJVkjGOLXz+Gn96R7U4XsslxmSyfPAtP
 AEBcl0A0SBZk9olwECV5jjTgzo+owRhAqzjDGN2s0Iz+OXSow1wo2107
X-Gm-Gg: AYBFou3oyxGpCOYKKpfVpimn/C0uWQOJKb4tyIZiE8RmVPcS1gh/QrHquuzA/AF3kzZ
 kbAxe7Q3uzIyjNqqJr9pp0opUXttBIDshasRSv82u3KFQhjMdeNB2NhH3hT3mgcFjky2AYaHQsd
 KzqRjGKkzHejTgNJRIpnNc3wOsIoeTXkBa68vGuOxCKCHxSINctfieqGySy6kmgE0e6QiLEfIN2
 6FOsIMux/aC9r4ZRqxGfaJ1/1QuVNLQvKsLkcfX5n/4f5QTPPB6VpT2vEbug+NxdcSrS0XhpjB/
 JtKQSqS392kEJFNKVB5f4aE6uoPgMz0HHO06wNToMYG2VkNn+1KeeKuCGrsM71iNRB6Z19gKXId
 8cHpI1mpPTEY3Y6RXIaeVqFzUUuCRZsjqN18cQrEQOYGMHMOc9cbWgWl/oK7lBf2lLVANkYt+MV
 5RvDFicyACO3T8mlrEHQXTWKkSU/Q63vcA8EDuCu6+J7cQnOYhxRMY4SHnqrO3a/RHLxRrLx27G
 7WGPzuyUbCZS6eK
X-Received: by 2002:a05:6512:10cb:b0:5b4:ef51:8cfa with SMTP id
 2adb3069b0e04-5b8ae68c142mr2989522e87.8.1789458446213; 
 Tue, 15 Sep 2026 00:47:26 -0700 (PDT)
Received: from localhost.localdomain ([78.40.184.2])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b8a0469a8esm3090013e87.50.2026.09.15.00.47.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 00:47:25 -0700 (PDT)
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
Subject: [PATCH 5.10/5.15/6.1 v2] drm/amd/display: set new_stream to NULL
 after release
Date: Tue, 15 Sep 2026 10:46:09 +0300
Message-ID: <20260915074611.9133-1-roman.demidov.nn@gmail.com>
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
v2: Include version 5.15 in the patch, as Sasha Levin <sashal@kernel.org>
suggested.

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

