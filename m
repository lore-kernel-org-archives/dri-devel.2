Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31D9FCC6B19
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 00:30:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6604610E9A6;
	Wed, 14 Oct 2026 00:29:56 +0000 (UTC)
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com
 [209.85.221.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B073B10E11F
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 00:29:44 +0000 (UTC)
Received: by mail-vk1-f173.google.com with SMTP id
 71dfb90a1353d-5e78346891fso2841478e0c.1
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 17:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791937783; x=1792542583; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5gCpZntt7rlk90yQDGnnj9e91a6SUbPGGE+tmaduhpU=;
 b=jfNLu2Oee2gO/ZN9UTI7UjW/m2VLve61bEI+ZesYpDHZUw9QuYEFosbc/mwJ+U0ueA
 LzvtjpV2Tq2WuhnHq5QrOTzta4M+v6G8uhAgfTtG5parUR7TI7fQ2ReYcCnpxfUiIJAI
 hswAMk5BQuUz+71rW+dM1xzxQoBU0SQjDSmHxmyCNgSM6FOo34k9mekJukx+dthxJe9+
 2zvjMCVu9OU8rfR7BY4uE043N7KjBFMlJwz0JyE31O5Wj00kwHs5TAeYHrxSYNcRXaBe
 tlgGCdP5HrwCYvejX4Ll40Zn77nR1VccCZvl9wsSfheAzIkh+VX5MSTNa/P7ElL3MLOy
 ia1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791937783; x=1792542583;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5gCpZntt7rlk90yQDGnnj9e91a6SUbPGGE+tmaduhpU=;
 b=Frkoza9Hme1g7aRg1cFQVqnrwv2v94SApMm5UlHyD/RDTI/QBOlxaEYeeoWqoZVd8y
 e0ZAZHWHkBkAoOcVWQk+Z60gp++DZqZDhtytbguMs2XT92sV5L9/V2JuMFUpF5CmNGYZ
 kq8W+Q5+K+J+MZZ0COu2SlIOg08ozLMl5HKj6OJFJqcK7X/ifufdwMv+bui7a7WxZC5X
 1siFt2UkdjE6qzqQgvwR869X+t1TRjAKCQpSV3+iR/dfWqm5ByOq6vIg2KaTF16OnBxG
 CkgBfnfO7Flv0Oe+UEcN9hWX+XRG120j+vMzzdiaHSlVjXYEF8la9x9fgi1grV2/uQhA
 M8EQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByfFP+m43LfZ2SYPCPbEvAHrBzCJi1oq3frPpePEjOOD2WPvE5N7H4cXtfRv7Wpf12Oy4hHOJX+sno=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIZAx9uRWJ1Zsq+U+8BsErQJX/xdcHGlxE2N9N3wrKXLFe1Vx1z
 zf9XW3FY/IocJflV0qDgcJF+SXYDl9m9+fT8Jqq+S56DVHWip/+xWxjO
X-Gm-Gg: AYBFou2bA6kr0b0Kh7aWM7WnUVBGGC86k9IJDc2yBSctMC788YGIU/DhN4UUFp8FJD7
 1NNhmsyv0fN7pdD8r9XOeBwJmpku6YVMnLf7dQTB9PY4nb/YjMV8sG217mArP26P6iy34PSWWqR
 cp1qfKMkClrCPWiHY4V4Dx3DndsvGdQu31OKhj5apuVAfduuoCOu8rh1U0DcJNpgT7or53SxLlr
 iwQkME5+cq4qUEyo3uGuJ+KJ4OhqrP4s+rRAOztbr5NLUg/MNiaN8IewkOB4hjl15tLZ0zO3JKc
 naOvLBHcjQrdwZAfXN82yMbX3ibepIsCAv0Ce+43Nnr5j6U9OiMCuInwQljXePA+yf2RNE0PviP
 EKipToe9BD9UiAKr83rEGTMvSmZNbWrBstDAIXdbzqCPUS7ajyqAtQSu25+v8zARXtRyHVqYXno
 t9mOAxBfjUwouGZXd+FqP8XGQ3Z8RWm0Pgupdw3e7Acizt3W0hkvFSmgeyyPqMbOED1Bvw8tcs0
 cjAygFgJYtPzk5VkkPBkMipUSVljCe+eJ2Z8Pxv
X-Received: by 2002:a05:6122:6161:b0:5c9:a60c:2732 with SMTP id
 71dfb90a1353d-5e91f44e07cmr4861188e0c.10.1791937783452; 
 Tue, 13 Oct 2026 17:29:43 -0700 (PDT)
Received: from localhost.localdomain
 ([2804:5698:10bd:5700:de7a:f49a:c785:d4aa])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5e91cb3117esm10165836e0c.9.2026.10.13.17.29.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 17:29:42 -0700 (PDT)
From: Willian Oliveira <williandossantosdeoliveira287@gmail.com>
To: alexander.deucher@amd.com
Cc: christian.koenig@amd.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org,
 Willian Oliveira <williandossantosdeoliveira287@gmail.com>
Subject: [PATCH] drm/amdgpu/gfx8: remove redundant RLC cleanup
Date: Tue, 13 Oct 2026 21:28:58 -0300
Message-ID: <20261014002858.172853-1-williandossantosdeoliveira287@gmail.com>
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

gfx_v8_0_sw_fini() already releases the RLC objects used by gfx8
(clear_state_obj and cp_table_obj). The generic
amdgpu_gfx_rlc_fini() also frees save_restore_obj, which is not used
by gfx8.

Signed-off-by: Willian Oliveira <williandossantosdeoliveira287@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 7f91186ef1d1..088428e41f44 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -2059,7 +2059,6 @@ static int gfx_v8_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	amdgpu_gfx_kiq_fini(adev, 0);
 
 	gfx_v8_0_mec_fini(adev);
-	amdgpu_gfx_rlc_fini(adev);
 	amdgpu_bo_free_kernel(&adev->gfx.rlc.clear_state_obj,
 				&adev->gfx.rlc.clear_state_gpu_addr,
 				(void **)&adev->gfx.rlc.cs_ptr);
-- 
2.47.3

