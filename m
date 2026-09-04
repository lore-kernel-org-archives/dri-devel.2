Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B57B2C79F8B
	for <dri-devel@archiver.kernel.org>; Sat,  5 Sep 2026 15:04:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 492DD10E60F;
	Sat,  5 Sep 2026 15:04:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OCzO5GPq";
	dkim-atps=neutral
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com
 [209.85.210.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1718D10E561
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 11:11:56 +0000 (UTC)
Received: by mail-ot1-f50.google.com with SMTP id
 46e09a7af769-7ee37dc91f5so529717a34.3
 for <dri-devel@lists.freedesktop.org>; Fri, 04 Sep 2026 04:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788520315; x=1789125115; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=wZtWfz8k9yebmPOl53AMpbrmlWc8q0MMFm5Ljx0y4d0=;
 b=OCzO5GPqtmlZRCJjRn37Mmw8y7EXF7Y4oBoMrcu285w+J7hLSV/zGf/dgp+u/e/YUb
 oRw0ZO5yM9BX7VE7c1OiVGhpU05PDyfgmKNIQK+qkULYSnR+KJ0jsH4gYnQZOCZ0NgVh
 sj3SAWWvVAGfC4dVdiAgFnC2wy3su3CT3lJgQCxQnelWU7niUgpynrm408tbSocmvED9
 HhZU8H75porXIm4ABBh9Ky6H/HyONvUxXExnoKUJNc53eZzhr3MlvosOhhw7QtAu4J/S
 wI6B8TuIHbHhcFVUTKwqvDUUx7KtVAVPXuBbCJu6McQ/wSQyBNJcZBK+ADkjV2pm93hn
 8/qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788520315; x=1789125115;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wZtWfz8k9yebmPOl53AMpbrmlWc8q0MMFm5Ljx0y4d0=;
 b=BGKEBCH4gejlvGKWZhaSbnliJnWNsr5IXKegKDp4QBW5nJ6N7ZjUF/SKdWcOY5rG+V
 1Xiy1B04i+3mA2KoBPIR7Bh+SnRIEf93tnPvnKOMlxY75wqjNnmd08bNPWJvbS39Ee5Y
 8dtK3ja40VEvD99KoM9fJ7WkXW5lr2cKPIuUeev5G+Hf318krV+Q+80+8J0XFUXVUTUv
 iXVNDflbEsDbstPA+COkvuNojZHX65WlktFHn6qc+xc7Wsbs41cLP5LEnVRLwzE7Km6v
 /TWfHCU5c/qZmlF+Pzoa2WhXESaWjwyKkhVZy4Ul3nhkKIpQQAmzZFQ3ovpdhdWAba0f
 Dz4A==
X-Forwarded-Encrypted: i=1;
 AKwUvBzutvmHAe7vLEB/DaBBSkMSErJjFyDNw8IBl9bYI5py/whu6MXg/MESDBnJoc/g09hKgRtYald60O4=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lm9mBwtK9yE7+ooEbxBlRvpeBJ/EG2hfhyMfyxG/jWC8XdkRPs
 DP2Z8OMrsehnspMeqqZiJ+3ESU7Q2wyOOGqXw3Whllrn2jSu4ugqbc+B
X-Gm-Gg: AYBFou0/NYhtkG1NoPCMP4LubKI2xH8ZyvjnGjxrCy954B43BPUhQuADSNgPx+mXFk8
 B8cZZf7cDjU0yWHBpDMhp3bRMZxWe8WGfHndcVXneh393USkmfug/OzCU+0sadl95g/wmR8Nidy
 DsN1Nv4dOHXEsj/OptS4y+GGIjkhbQpEq74mWpsQwAgLEViMyzXMl4wRvb1SOw35bOJqdhPP6KH
 3aPwE67zd2fxVMKYutuGtNJYVFI8imgcDJy29RsIQ1SnusS3nY8pHLuxNiNyMmuHGqc4yuClhQx
 yuT+orh3O3jUr9TFsDkVkJ8DC1ngYVk+3jzFGrFLL4cHQOWeMUm56vB5Dp0mfl+DbhDfmShSmrj
 ATHx2mo7NkZVUFV5sqYAzWyPVPLNUHcxNVfHWJFIPY2gga67aWEkFKOmYtaQKyQbk/KM9IOrItA
 uithxK6OnkVaXp8xpvijDPyJrS+XVaXHqKVDJdBsM5Ca/bo4H+xqOFPZKq5pEKH42RxOxdZgntI
 in4nQ2ajr1xOEI=
X-Received: by 2002:a05:6820:188b:b0:6b7:46e9:96f9 with SMTP id
 006d021491bc7-6b746e9a2e5mr1706058eaf.41.1788520315117; 
 Fri, 04 Sep 2026 04:11:55 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14324356931sm9779797c88.4.2026.09.04.04.11.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 04:11:54 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Inki Dae <inki.dae@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Peter Griffin <peter.griffin@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Subject: [PATCH] drm/exynos: fix typo "vaild" in comment
Date: Fri,  4 Sep 2026 16:41:46 +0530
Message-ID: <20260904111147.23677-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 05 Sep 2026 15:04:14 +0000
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

Correct "vaild" to "valid", reported by scripts/checkpatch.pl using the
misspelling list in scripts/spelling.txt.  Only touches comments, no code
changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 drivers/gpu/drm/exynos/exynos_drm_g2d.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_g2d.c b/drivers/gpu/drm/exynos/exynos_drm_g2d.c
index e92a4d872c41..c420e61b7610 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_g2d.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_g2d.c
@@ -32,7 +32,7 @@
 #define G2D_HW_MAJOR_VER		4
 #define G2D_HW_MINOR_VER		1
 
-/* vaild register range set from user: 0x0104 ~ 0x0880 */
+/* valid register range set from user: 0x0104 ~ 0x0880 */
 #define G2D_VALID_START			0x0104
 #define G2D_VALID_END			0x0880
 
-- 
2.48.1

