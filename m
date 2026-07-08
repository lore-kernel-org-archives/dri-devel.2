Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6C69C43602
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 07:32:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35CB810E585;
	Wed,  8 Jul 2026 07:32:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="I+50Nq60";
	dkim-atps=neutral
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB75310E585
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 07:32:54 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-2cad225673bso3264355ad.3
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Jul 2026 00:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783495974; x=1784100774; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Keeefd38WvRLYS9r2pdjAYV6V+Tg/ODVFYOu8UceE3I=;
 b=I+50Nq60qzntlBtWH5t/v5IZYeuNJSqu55QbT0HtFnbAhD7HsjioOf85tBnxMUMSOo
 K40zVz5qdlvvhBWnKOmh9lSqdKt04/gLSXGWgzV2fiUJtu9irzfKCfR5NmEb0meq/AMW
 Sa6tn99rR9pW/voljiRhRtHvuEAxggPNtNbRhtR4zjH5WEzj+jbkcLnpybhVggtDSj18
 ExyuCNTFWJWgPznH9/IMhjcuZn/GxntONVUHFj6b0PEKfPe20EV1n26eWcGZK9cPbsOc
 aCoN0uV7BYP16O4flUvT/9bhtTFazR0qEge7kk/5Tn3/+qsb0P9rBP3AL7118NZdp+Zm
 5qdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783495974; x=1784100774;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Keeefd38WvRLYS9r2pdjAYV6V+Tg/ODVFYOu8UceE3I=;
 b=ZLAB8+Ym0gD/IDlzJmvfmSQ4KHywWtk8JNGidARWUWyV8LYPDrDSZ1CyOLuzmHw1Dm
 T7SZx2nwyHrcC2JGv0qn5X1jREQ/kHN+zR83OSNJnj1f7DwA8t4Op/4jAur3O7sLb+0B
 mQiFbHf6UwjbgpB8J16X+0qivLmhU50VD0xsIHzZ5Ln7+/wALu+hkFHovDH8kPx1DpdJ
 Oh/HYZOewDJTxwmPHrnYscYwKBC8H7ZXnPoaKu9kfhkCSxQQZ/flxWzkprhmNCWwr8Xg
 5pavWIEkNluyJyaRz973it1cl5O2nPgnKqO4ZHImjxlCflu7SsoB11P2p8zN2g6LYKts
 BjDg==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro+AxXHEkGsEUY6GC4KiKMgLvnvzDcqo0Kn1gKn15PieU8ru+wU9jrf3fjW0QnU8bqbpuZKM8nzWv4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxqiAvEF5m1g48XOWQmluq6rrPeQcsIW8tV7wSrBSb6d+CpqGNe
 4LOPIJPqbQqFaciZ594KNW+9zcABIBqF4VgX7by3yPppNW0GsdfOd1T7
X-Gm-Gg: AfdE7ck/gydr8YbriCrX1+EPI531lI4VvqW37PS/bjZbYH5d3M1kUfJBqYz5XSJvCh6
 Lf7t9Zqlsaoc4qTWZCyFTcQ0TOhAhcLk/xJ1dtcN4c2yfh1HMF01jiYbBE85oDAtFzweuiMuNVA
 ujKFJfPiyqhZb7EnKDDf4SMjG1/z8IirKKOxhyfFsjfMJgdEkkHWByV0e8qbjiOZhVhwZ0rnkLV
 NkUR1lchtMeF/+31c3OwoRYFSJFaqIUEZYHhNbH6VvlAe2Hlb/vAoyWkUrgpWMzPRxTEjWG4A1x
 1nS2BBcC2A7ABSvwTeGkLIumI1JhgebLmLh7iVAX63LVH0oWhZrPBPcPiNldE8Q4Nd+IPa4fP6m
 3iTqNDcV5z2s5lFQ4W4r9RqZeEZJMeOOWAh3Q5HBMjas0p2KrFSaJb4Kw0wgc+VcoF09l1CU=
X-Received: by 2002:a17:903:b86:b0:2ca:bb6:e7c6 with SMTP id
 d9443c01a7336-2ccea36e129mr14778595ad.37.1783495974343; 
 Wed, 08 Jul 2026 00:32:54 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1000::f280])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9d3d2efsm23314995ad.64.2026.07.08.00.32.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 00:32:53 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Alex Hung <alex.hung@amd.com>,
 "Mario Limonciello (AMD)" <superm1@kernel.org>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Ivan Lipski <ivan.lipski@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Ray Wu <ray.wu@amd.com>,
 Chenyu Chen <chen-yu.chen@amd.com>, Maxime Ripard <mripard@kernel.org>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>
Subject: [PATCH] drm/amd/display: move connector state dereference after NULL
 check
Date: Wed,  8 Jul 2026 15:27:51 +0800
Message-ID: <20260708072751.724400-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
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

amdgpu_dm_connector_atomic_check() checks whether the old or new
connector state returned by the atomic helpers is NULL before using
those pointers.

However, new_con_state is already dereferenced while initializing crtc,
before the NULL check is reached. If
drm_atomic_get_new_connector_state() returns NULL, the function can
dereference the NULL pointer before the WARN_ON() check can handle it.

Declare crtc first and initialize it only after the NULL check has
succeeded.

Fixes: 1e5e8d672fec ("drm/amd/display: Avoid a NULL pointer dereference")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index d3a8d681227a..7b040fd7e3fb 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8640,13 +8640,14 @@ amdgpu_dm_connector_atomic_check(struct drm_connector *conn,
 		drm_atomic_get_new_connector_state(state, conn);
 	struct drm_connector_state *old_con_state =
 		drm_atomic_get_old_connector_state(state, conn);
-	struct drm_crtc *crtc = new_con_state->crtc;
+	struct drm_crtc *crtc;
 	struct drm_crtc_state *new_crtc_state;
 	struct amdgpu_dm_connector *aconn = to_amdgpu_dm_connector(conn);
 	int ret;
 
 	if (WARN_ON(unlikely(!old_con_state || !new_con_state)))
 		return -EINVAL;
+	crtc = new_con_state->crtc;
 
 	trace_amdgpu_dm_connector_atomic_check(new_con_state);
 
-- 
2.43.0

