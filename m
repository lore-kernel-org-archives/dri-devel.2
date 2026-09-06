Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2A06C79F89
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 07:00:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4986910E664;
	Mon,  7 Sep 2026 07:00:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ib71+jNo";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F89C10E108
 for <dri-devel@lists.freedesktop.org>; Sun,  6 Sep 2026 17:03:09 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-49b392ccaacso40797165e9.2
 for <dri-devel@lists.freedesktop.org>; Sun, 06 Sep 2026 10:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788714187; x=1789318987; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=keOtw6Clq8MhI7P5qphmjdddbgYhK6syZpV3w0I8X+w=;
 b=Ib71+jNoGUWG47hTuUbj1J+RHjrBXwIK43+85Vy7AN6wrWmEwh5g9e+CswoT2wXg30
 1X3ke2R1A1eJfxtHh3B1uww6MZfwsQ9tkxIhJc4c9tO9Wnf1WFc8D6w1RTiUt8AkEBbQ
 ITAJ4saBArxVP47Jmb83Mamd3VfTRmrG9+XgtnVHgeoft45rmmJR20A3wAkeYefJEBnn
 eLZhhUBwn/XL00HDU3bChZ/CmqgYDXuc3uqh6hn0M+1/HgcSC7F0cl4rWZnAUCiTRVSq
 q/2NxlZSeWonk8kTqZUZpaAvZiGvpH/ZfGjfErDOISFX5S+BAV3HTFIskHkKF2d6Ixze
 QCGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788714187; x=1789318987;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=keOtw6Clq8MhI7P5qphmjdddbgYhK6syZpV3w0I8X+w=;
 b=qdVRVuyyhEqA3efmFFp+CVHwMcSmOF8FXye6gY2AwLZ1iryDUIEaipQxHIJEWBpteY
 GQWBZ4lXsWj+1mMw+dPGdAhr4y3oNuueoi1rkqwgwa8/0Qjg8p+BmM772kj0wk+gn1o0
 3BBtb1Hi0wuxJhJpKoF/7szAYCIJ+lPjVMpRtBTKtLR8nRreVLxRBfxp0vfRLv9Bfu1o
 N4H9pLPI8jBETAvFxYjsxLIcbijqFoCGB5vBhRh3u60O1V6EKOjL7HD/yedLZazUo8Go
 y2PJgpJVUnC5JysFjtlhdl5cZFeY+/C8lSDicWWgJTecRxzVZhToG6vYTLsrUg1hDiYM
 YIPQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxFaZozzgnUQkdLKJ7V08FiSzNCDGzUdpHCBgGiON9P2Q4gVHkhKHawxoHwIYyWdVcLApYviKaxUTI=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nM2ybEqizFnCD7iwWQIda4wAB+InvOS4KxS+AtqGfIoZ+arBiK
 +s1glYisxNDEl7THFlFgwqFcdiIbJYOLEvcadJS4CHnbTF+QribKAhPN
X-Gm-Gg: AYBFou0FJLaUQ9TkHUDgmGrJ+ffh7VtYhkTbN6wUcNZVIrC9jpoobj4SUp1O/YQGi9P
 s4E6FsVqMbNcsEEXJrazFbOevYI5CYoz6HQU0rLcKmvuz+U5QDaMG0g7+j+wB9o+2XXrtOa+o90
 y/LYagBm5CazQbmDzNqtW0uwUm7h3ndN3Rm8Xlr3G8w8Oh8bj0yvFRrvLRvvpbRzWhFiKQ5MGFR
 6zN7+vQ5ecI+jrZyIMPOyrrNl9cNDAftzhSr4D3b5EUd2ycQKZDorfd6hWKyrlvNH96BQRiQnX9
 jr9r5tzAFEZKuaQzOai4eCPmjPkQK6sMo4cdHpLdUTwzW17hN7w2lJcgBdciWJSk5+6vOGt5qKd
 a489Yxg1smoOEk912Me769Xc+eFe5+Prf/CbXG6HX/cIzUvXM4bCLjV+sr2pouCE5oR5tbWocQ5
 tincfPhP7sfKg7CE13Yvydn1P7oMjeB4EYIIlrWK/7/8KN3LTx62HcgOhdKNqeVeN2bR5lyPA6I
 KDx6AH5NZ/gOwSxlhBgO6xwqqE4VHXKr+l9f1fGml1Up8CGAud9AYvaEILtWg0DCiJd/A0sMgOx
 0L8W1XP68JDLJ7ZULyO3FL+1zsW1M00h2PZK7WDl9weieQ71fbfuFZ0en/zJm6BaO3d2nO3e
X-Received: by 2002:a05:600c:190e:b0:49c:fa21:1c82 with SMTP id
 5b1f17b1804b1-49cfa211d3dmr159299395e9.23.1788714186823; 
 Sun, 06 Sep 2026 10:03:06 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-2a02-3100-9d84-5101-9c80-d25b-14b6-410c.310.pool.telefonica.de.
 [2a02:3100:9d84:5101:9c80:d25b:14b6:410c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf75ce49esm427796685e9.1.2026.09.06.10.03.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 06 Sep 2026 10:03:06 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Subject: [PATCH] drm/msm/adreno: Fix the skip_gpu parameter description
Date: Sun,  6 Sep 2026 19:03:01 +0200
Message-Id: <20260906170301.2393-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 07 Sep 2026 07:00:30 +0000
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

The module parameter is skip_gpu, but its MODULE_PARM_DESC() names
no_gpu, so modinfo describes a parameter that does not exist and shows
no description for the real one.

Use the parameter name in the description.

Fixes: 3f17991488af ("drm/msm/adreno: Add a modparam to skip GPU")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/gpu/drm/msm/adreno/adreno_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index 7f20320ef66a..05c77fe27e62 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -25,7 +25,7 @@ MODULE_PARM_DESC(disable_acd, "Forcefully disable GPU ACD");
 module_param_unsafe(disable_acd, bool, 0400);
 
 static bool skip_gpu;
-MODULE_PARM_DESC(no_gpu, "Disable GPU driver register (0=enable GPU driver register (default), 1=skip GPU driver register");
+MODULE_PARM_DESC(skip_gpu, "Disable GPU driver register (0=enable GPU driver register (default), 1=skip GPU driver register");
 module_param(skip_gpu, bool, 0400);
 
 extern const struct adreno_gpulist a2xx_gpulist;

base-commit: 986c24e0fe44f844b44d365b71ce831947f50298
-- 
2.53.0

