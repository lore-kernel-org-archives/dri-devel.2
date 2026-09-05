Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77300C79F85
	for <dri-devel@archiver.kernel.org>; Sat,  5 Sep 2026 15:04:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C9BB10E440;
	Sat,  5 Sep 2026 15:04:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AYTnlyKb";
	dkim-atps=neutral
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com
 [209.85.128.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 127E010E2C5
 for <dri-devel@lists.freedesktop.org>; Sat,  5 Sep 2026 13:34:24 +0000 (UTC)
Received: by mail-yw1-f181.google.com with SMTP id
 00721157ae682-7dbcb505578so22396697b3.3
 for <dri-devel@lists.freedesktop.org>; Sat, 05 Sep 2026 06:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788615263; x=1789220063; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=9QXsz0fC9wZ+JNlekr0mg4nAz0vKv90Qs6khri27jlc=;
 b=AYTnlyKb2whZffi4izozoY7wGmRp70h2LOtgQMMCjguBMDF/n2fngrqhOq+353zvNO
 moPlGBNoQp1hvTSJ499MOklhnUEvn39zCzOVpjIaISC+4ew+qFL1MyI4IhcqjQd1sO9c
 hydJe3KEqhCbooVY3O4aRdx8zX6TY0cuC+wbITT1rzkeVZ/tvTzqQvNPQY5kytRs6oUm
 E4Ids6nZijB7tyEa0sl6J7BemLzJxrpM9MTng5XTd0Z1cTniD13oVJ3u6wWJ1/NJmzdY
 wh+n6IwFv/o5GbxQ297wXURxJD+jcOnUcm9gTEgfDIpGNEELM8ZCa5/1sDuaThniYgrO
 RHoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788615263; x=1789220063;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9QXsz0fC9wZ+JNlekr0mg4nAz0vKv90Qs6khri27jlc=;
 b=sQDNSlaeFi3KuB2wazx646cgwnQyC1aGPO7FTeL7w4+NK1dqRninyYD5HjadBJiHor
 Uvpq2Romrtn7+DavO5At4l8ADX9k7KLmZy+r67KFR6WLq9dfD/w411o72U5VPjYo9h9V
 ncXbCypfjU1s2IfWlN8fzLyboG2xB1f8wCu/WiC3Gx/pOWU+8eiln7TR9jfafCaav/sv
 8E1GyJH07vcuropmY/R1MWyPwJPqElrkihSHqx+ADTWmhZA/y3Thoz8Sc25WwiA12/DU
 GZj70HBeiIY7osbjuhRh/uKYOFQ+qhYexjVa6ghECfQWIrxMrMu2GT/YxhxaxxG4QZg3
 l2Yw==
X-Forwarded-Encrypted: i=1;
 AKwUvByUJqxUcgsZtL6kimT6Snp2zgQO6f1+1Xt0T21yABxUN1mT9nlFWImeQxSSgflqUiv8EEHIXs+Z3j0=@lists.freedesktop.org
X-Gm-Message-State: AFuF++n+pqDEIJqHHE+EqKvi+FRJyy/+PTCnPbk3ytKZSpMrSINY8aWl
 NSafcDuLAxHWC55qrUiroJFnNRah9kEHbLg4ToycwcJ6MKy+4uPep3iX
X-Gm-Gg: AYBFou0K3tdURo/Bu/qpyaKtrIYPiv5Q3TuQ4Q8J5lyeA3zMF7+r0vfVpX+Is95y0nZ
 8/sX6Oxk3mdlECZQHRp9NZg/HqXOX2dd3J95mIIl5ycp4m8/fEWw9R+ggnSbjTkdoy/QjEgtEVK
 oNq5GMX80p/4FDzIi4HbG7qHOYjt96ZuHx/jgQVKVAVCnfusWy2kQZHGHe42WNmhtP68XqJgePW
 jQycJgeL5PhhRnrSeyfcZtGQe4pyilTdcTvhhgnLCa4nnys6oFDrhx4pJUOhaWmNASGrMtSuq7B
 8Vx90nLYrLWwYVZ/ROoJee/IUIp8lcj+nRqKce7InQnYncTWl4h/tTwh5e2uDhOC1alULLfzDQo
 j3+m2O2C+bO6QKRJuMrf69XLCjGXO/zRZh2rlgEkxVKnuMgSSfgOd4sdFAI9RNwOF73ILSc5Xxk
 zbZXZITLh2jHwtbStDRm3GfsG6j8gueRvXEv0df/if9Nxex6U0qMAyZ+FhvzNYK1Sq7/AVsdmdC
 +PO4fItyuruj+gNz6DKlUjwMZoHbA==
X-Received: by 2002:a05:690c:c1a:b0:854:d9d0:467b with SMTP id
 00721157ae682-87126aa91b3mr51195547b3.22.1788615262799; 
 Sat, 05 Sep 2026 06:34:22 -0700 (PDT)
Received: from localhost.localdomain ([2804:5698:103f:d00:26b6:2d03:3cc6:9121])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8714b62bc77sm38919807b3.39.2026.09.05.06.34.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2026 06:34:22 -0700 (PDT)
From: Willian Oliveira <williandossantosdeoliveira287@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Willian Oliveira <williandossantosdeoliveira287@gmail.com>
Subject: [PATCH] drm/amdgpu/gfx8: fix register_list_format leak in
 gfx_v8_0_init_microcode
Date: Sat,  5 Sep 2026 10:34:05 -0300
Message-ID: <20260905133405.3733-1-williandossantosdeoliveira287@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 05 Sep 2026 15:04:13 +0000
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

gfx_v8_0_init_microcode() allocates rlc.register_list_format before
loading the MEC firmware.

If loading one of the subsequent firmware files fails, the function
returns through the error path without freeing register_list_format.

Use gfx_v8_0_free_microcode() in the error path so all previously
allocated firmware resources, including register_list_format, are
released.

Signed-off-by: Willian Oliveira <williandossantosdeoliveira287@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 7f91186ef1d1..b213870ecb96 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -1211,12 +1211,7 @@ static int gfx_v8_0_init_microcode(struct amdgpu_device *adev)
 out:
 	if (err) {
 		dev_err(adev->dev, "gfx8: Failed to load firmware %s gfx firmware\n", chip_name);
-		amdgpu_ucode_release(&adev->gfx.pfp_fw);
-		amdgpu_ucode_release(&adev->gfx.me_fw);
-		amdgpu_ucode_release(&adev->gfx.ce_fw);
-		amdgpu_ucode_release(&adev->gfx.rlc_fw);
-		amdgpu_ucode_release(&adev->gfx.mec_fw);
-		amdgpu_ucode_release(&adev->gfx.mec2_fw);
+		gfx_v8_0_free_microcode(adev);
 	}
 	return err;
 }
-- 
2.47.3

