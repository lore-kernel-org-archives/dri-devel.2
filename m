Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F1DCC982FD
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 01:54:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1449810E03A;
	Tue, 22 Sep 2026 01:54:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZxWRQpYH";
	dkim-atps=neutral
Received: from mail-vs2-f42.google.com (mail-vs2-f42.google.com
 [74.125.227.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC2FA10E117
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 01:54:30 +0000 (UTC)
Received: by mail-vs2-f42.google.com with SMTP id
 71dfb90a1353d-5c67e5292faso1588547e0c.1
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 18:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790042069; x=1790646869; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8cyk+VZJdV3suIAqf0J24P3aiMZPO/cLIo47aUCTTlQ=;
 b=ZxWRQpYHXv7D8mmt5aMooyFMBDyDm96y2X3ZjqM3kFAg6OVPVmoFRblFg4Ze18AIYj
 JIWjfN7DXMBbdQ3yuAx2qu1Uz7G+7NzuNXMSxlHQFeOfkFsauhI4w268jZqk4Ezia7wP
 cw7tKKUYYkC9gjtI7kzttut7pFiAAP3GjY5gdNsPF30WAFaPSW/XYA+U5rnxdkqJyiYw
 wBNqoH0SwR53V0Eb4RDoYBpcmn4AV7P7MZLcvkeJ85fgpH2Wc7b8MBPtl0M2CFmFDI6C
 fgVDpd1CnlgNjazkFnSsg8vobzBHeOnUgOc2Znlgi/iPmmBkq+/KBzMTp2QWN3Hjrsuc
 ebYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790042069; x=1790646869;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8cyk+VZJdV3suIAqf0J24P3aiMZPO/cLIo47aUCTTlQ=;
 b=J2eIloIJLiaLWsc36PnTz8JdOYllU8CosPua7SZU7KB6voxU8upCCodw1NLK3RiYql
 89FnzQBVYI8SH51TcawlagqXUeVggi9eke3lBHDuY7Ll4jSrtQYZ+Roy35DMA1vHVxVt
 LHizpB+aIYsKcqyx+zmGagiBgsfFLo6BC0tvcoPnlm7/TtXhDWbhnO/WmcSUWajWHWdH
 55mDfiX1fRxRcSYWtIdWDgrbruvgA70XM6hfYt6OM2oFwFMBMDixlJMvw0mYC4t/3pDW
 0lDMMb7Td9GxFNYVUzdYywv2+vRUXxlrhdRYq0Bk5gJpFWD2viJu0jg+0bIepeZ5P3Ay
 Y2lQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwQTT8xSaloZh5JtO5jPJh4hxoxI3g+ZLRiwr6V0nOex+9yb3eeq9cxtRDP3z8yuq2Xd/Yp+QS11g4=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mCMwgv4K6SgKkKz255LtDxaDSzIO/Z5bYWTRstrSsKt/4y0/y9
 xUx6TKdxVqrzXedYAkZMG7EHClEBTffDaRZP1AUDNh9BzJl1oaMT4TKI
X-Gm-Gg: AYBFou3rTVFLZHA+2bQd5PqcprZmW73mNUnaxPUl8SSV9yLc3+OzsThRZ84s+q5WRZQ
 6sIn81hI291wp/ItZIrFF8sr2Ak6GvcufhBCVWhoEWjSWMBl+sB4eZ9w2xS9K7SLYoSD2Q7Mi8p
 YpYACffH572i/ijSq9FTjCFKxvcCcCId+Qwk0P11GCecdhI85hjiGDQDcyPjKUhwHP7m26Yt2Tl
 gRBLvZOlLDXy5AqoCo+vQSInoca0SmI3+t7XUqcyjC76G0JF8AklL4x486MrkrVX6DmKe/g35y/
 5AmfwuqZ6jm+tQ7XYMB7Qgr6hBwWU+EdS/xtuWZGXUkVQZPCE11vDNYLSJa6CEhnzIlMAGI5Tnj
 l1ffYms6BFpl5RguUoK+9oVtUWAfDYQWC7fkFS2Le8DtppSwx3yDEvFUOyBUNK6p/s1mIZflQuX
 X0xIfJ8YUgeq/jFKHBUpJOsFcuiZVHZo/s2FR2AxEnxDBz0HKdNrv3CwxBgeXymz3unY1lzV0kC
 +SvfEDvjciToX5mNdeYmrmVAcT0FthePiXtxCNf
X-Received: by 2002:a05:6122:3281:b0:5bf:8955:a8ce with SMTP id
 71dfb90a1353d-5c9b58fa150mr7030545e0c.1.1790042069444; 
 Mon, 21 Sep 2026 18:54:29 -0700 (PDT)
Received: from localhost.localdomain
 ([2804:5698:1029:f600:548c:a202:2a24:b2c2])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5c9e7d09aa0sm314462e0c.10.2026.09.21.18.54.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 18:54:29 -0700 (PDT)
From: Willian Oliveira <williandossantosdeoliveira287@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Mario Limonciello <superm1@kernel.org>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Willian Oliveira <williandossantosdeoliveira287@gmail.com>
Subject: [PATCH] drm/amdgpu/gfx6: fix firmware leak on teardown
Date: Mon, 21 Sep 2026 22:54:10 -0300
Message-ID: <20260922015411.116292-1-williandossantosdeoliveira287@gmail.com>
X-Mailer: git-send-email 2.47.3
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

The firmware requested in gfx_v6_0_init_microcode() is not released
when the GFX block is torn down, leaking the firmware resources.

Add gfx_v6_0_free_microcode() and call it from gfx_v6_0_sw_fini()
to release the PFP, ME, CE and RLC firmware.

Signed-off-by: Willian Oliveira <williandossantosdeoliveira287@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
index 95e939363db6..a5553d181d97 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -322,6 +322,14 @@ static const u32 verde_rlc_save_restore_register_list[] =
 	0x00000000
 };
 
+static void gfx_v6_0_free_microcode(struct amdgpu_device *adev)
+{
+	amdgpu_ucode_release(&adev->gfx.pfp_fw);
+	amdgpu_ucode_release(&adev->gfx.me_fw);
+	amdgpu_ucode_release(&adev->gfx.ce_fw);
+	amdgpu_ucode_release(&adev->gfx.rlc_fw);
+}
+
 static int gfx_v6_0_init_microcode(struct amdgpu_device *adev)
 {
 	const char *chip_name;
@@ -3254,6 +3262,7 @@ static int gfx_v6_0_sw_fini(struct amdgpu_ip_block *ip_block)
 		amdgpu_ring_fini(&adev->gfx.compute_ring[i]);
 
 	amdgpu_gfx_rlc_fini(adev);
+	gfx_v6_0_free_microcode(adev);
 
 	return 0;
 }
-- 
2.47.3

