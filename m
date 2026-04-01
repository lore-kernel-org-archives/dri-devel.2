Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0689210F9313
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 00:39:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D37D89E33;
	Wed,  1 Apr 2026 00:39:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="amV5trs4";
	dkim-atps=neutral
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6392389E33
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 00:39:31 +0000 (UTC)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-2c18af885c0so7241367eec.0
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 17:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775003970; x=1775608770; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jlXNZ6YErxvr6V0/1Nzao8eMwm0DA+edMLaU07KmQkY=;
 b=amV5trs41cBIoa9sgg4ccHpmbD85vSuh/xrztmrbhVNRFBcOpt3d52z8cO1c+riGa8
 QVtf9IpfhPD04Y5ywNwWqNrHu7hZKOmW0NKRhHZSOI4pMfU/46apL/GRMEMlOrL/x4U6
 6HBFF2fWRgLiBs05AHlQO6izkd+/fZ6a8Ot8jpZtx7k/LXzo3lWdTHaGf/c7aT9f3xkF
 PM+8KqlPcxLzvOLXUhzISXOn/fuosJmmFZbHBS3MaxAtUq7bPUj/2Zj7zxEr58l65A51
 Uf4+YEOMkLGLjMgBg9AG2LcZEdy4TCqeqZGfaUhyCsS7xHqYsUQBIfmIEuxFQl6TNi2T
 M4Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775003971; x=1775608771;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jlXNZ6YErxvr6V0/1Nzao8eMwm0DA+edMLaU07KmQkY=;
 b=bZ18kc6fwm06eRWzjF/7au4Ycc39ipU061Vq9RPgJkE6QTSAv0JRgyydbg2bpHbnbt
 9lkWLQm0ESCyiOoTnvqBf+bOQxSyAHEVLWv4x+GNZ9j9d6L7RzKDTxB+uAlKWPbl2A6h
 8xspt/iLc6lTYgUUt1vhzvbdVDXDhGYN8MNFMfIFDFgkpwjBS/t5QyMncXQk+gVfaRVq
 uiugXwaH9dJor+EhtO5jqLfrtijXQv2LL09eRoEmEbzqrYWW4WGJQwyj4aczXEf5y/t7
 /jashetZGWwYheED9bO5K16PQciT0sxDYymcBroG1pIthgVuAmLTYeShtkgavuRR1Dz9
 FhPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvwniYiuUD4nzZZgrenkaVda75qyzsTPC1MK9YmdSdqaHXXWkXVadfIW/Un+8yqEokos1QDvCaNEc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwxJUqABJ8YEx5S3pE0ijk7Jk+73qdin3aFhz7YR+ohv2uIKsJp
 v/k3OHkIfahe0zM249eaFYXb6z/UlSZtYqusvR6b77RnpSCRtKtdD16W
X-Gm-Gg: ATEYQzw/slA5yyHzGSno3QkHLKH9L7sqrOLU9fkOkVNPQ3VQ/o2jbFJ4GBAAtPGJ31J
 3oa/VHdG86xOEPUmIpjZQ3LOIih0QWvbNL3cD5ijA0Rdx7SlCRSjclxt8s3Wb3RyR/WLnjSL4hv
 ooZ3qewkz74Yd+CNx1GBM+cJFaaJGJDAGFyQOEVDO5TfS/vEEnuBgDTBrOMcntBd2LWgfLvx7B6
 YFu5BK/4a31DwvqB+XCesMQhyo9nBel/tVKU852tZp08rSttCKXDxAtgmpytI75HREkwhbs3DuN
 cU/3pd9zwsCUzPMee7XVjkp9o3AZwcau60YWDGi6B8xcjGPFdaSslQbJdRPNg4sUYaDdl53hLR7
 73ROW+h8XS4m/hwodWa98XNZ4utH2pF602tgrUm4LanKgo0esnqrFJ3I6G+1KZhO53XCvzpUzb3
 4qnCZnryAAmmPJXPEqKqTXdw43l6Wo0lPaavBxLk8Farw5JJ/wDeB8q8Q=
X-Received: by 2002:a05:7300:8626:b0:2c0:cc90:a71 with SMTP id
 5a478bee46e88-2c930e6a365mr1054199eec.8.1775003970551; 
 Tue, 31 Mar 2026 17:39:30 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c3c3bd9894sm11543019eec.4.2026.03.31.17.39.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2026 17:39:29 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: stable@vger.kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Ray Wu <ray.wu@amd.com>, Wayne Lin <wayne.lin@amd.com>,
 Mario Limonciello <Mario.Limonciello@amd.com>, Roman Li <Roman.Li@amd.com>,
 Eric Yang <Eric.Yang2@amd.com>, Tony Cheng <Tony.Cheng@amd.com>,
 Mauro Rossi <issor.oruam@gmail.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Alex Hung <alex.hung@amd.com>,
 amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
 dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 for 6.12 01/10] drm/amd/amdgpu: decouple ASPM with pcie dpm
Date: Tue, 31 Mar 2026 17:38:59 -0700
Message-ID: <20260401003908.3438-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260401003908.3438-1-rosenp@gmail.com>
References: <20260401003908.3438-1-rosenp@gmail.com>
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

From: Kenneth Feng <kenneth.feng@amd.com>

[ Upstream commit df0e722fbdbedb6f2b682dc2fad9e0c221e3622d ]

ASPM doesn't need to be disabled if pcie dpm is disabled.
So ASPM can be independantly enabled.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index d5e6d5ec69c8..dbee43c58741 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1782,8 +1782,6 @@ bool amdgpu_device_should_use_aspm(struct amdgpu_device *adev)
 	}
 	if (adev->flags & AMD_IS_APU)
 		return false;
-	if (!(adev->pm.pp_feature & PP_PCIE_DPM_MASK))
-		return false;
 	return pcie_aspm_enabled(adev->pdev);
 }
 
-- 
2.53.0

