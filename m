Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 221AECC6B2F
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 07:56:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFE6D11213F;
	Thu, 15 Oct 2026 07:56:38 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F8F610FB9C
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 07:32:35 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-48deeadb3fdso86377f8f.0
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 00:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791963153; x=1792567953; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=dQ9Vi8ze8lwdPqHYidKfxChexwTLWFdZyXa9tkQZSpQ=;
 b=QdSXNglrja129vuU8HZVy5mA9LNme+TTI5+3PLWQI/VF4jLOtFPnqF21xPvoHaf4pO
 jqqPAJYiHnVO9lsXQLgZKzsWei4Au5aUKOa+9Qz9bZlzeuADNw6dw7f/OhQZhgOb61Rn
 YwYCx0utO1io9WUbbcOWWRtvFTdaiOnn4IOMIw8nuj4JnJweY/+LeWeKs/iqMFvpZkuH
 27miVmLVWp1yPvxA2u/Pf1BYYd5b7Mfnjq8H9dgtzI+ydzUsqh0hIT7mMqSmKjUNDkXq
 v3QL5KV8+1bzhHI/ti2TuTanb54zZHNG1vj0v2xbk0IchFmykcHbHkDmQxvhSN8OnM8H
 CSIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791963153; x=1792567953;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dQ9Vi8ze8lwdPqHYidKfxChexwTLWFdZyXa9tkQZSpQ=;
 b=ONPxJ7fKA9dwqPey3zeGaKnzbmsJN0LTdBX/LCCxtQYe3igDAcTjtmTvAjVtTzDPXQ
 hafcd57PbQbmgGglTQrkdXvsX1ouMXIDocn9dM1pm3ZSgtGXNY3MXrosgWcxmaKpmVka
 gzEqTBhliGV6CBNqgIM2OPdHn29WGyEbEvIkCXBr/xASHGL2fZrvVqLfvtIXFX5awNfy
 bsRYZ0zBcTFdvx7mFNU7nEhy6agkUj++lnUW6GVFyotSOiCH9UExg6YYdpT+QfC8oPtj
 GTuL3ekAKqh63GKjRLEu/Y3UXSvncjOriaObCa9k6OGsHkfssjpZ7VdQ45pm9bdvhUgY
 yqwA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwwO2kcIANNlYBYJcbwEpv6kL3Z5KbTkUwn4y0mDhPJZNRXwAwTAgq7V6mpdqSC//m2e77vIwFVqYY=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIcKPHvucEvLvviUZ0Vl37BdbJS7j25Q0XNAYOCWuco1LcWpc8d
 05huFzFsQJoJ8m5unRSlQp1QB88LpzL0U0B1mdxe8tltmOyjoYNKVJg8
X-Gm-Gg: AYBFou0ZtXFyu9d1oFt/GuY4mopqcAWWEAMegKzSmgvmIH8kKtDJRvCIBMsOi3//Ogt
 lRacHPH93qAFHVsTcpH0QZGd6GPpitFRMsI1f/cCA1y6PQt/nAI6iITMfc4shV1LdYjaU64pJY1
 cnyz546/F/Krbum/a+StFAqNGlaVokXneoICkf26ED1tNIWyMKXS+N97Upp0Xyww2b8AnDpntip
 sZxnyKfhuNdkJenU1ITu0gH9JHNCGZvkRa01ow9speTI2AYJnTNKm/2dK8SqzgZ+3Yjclnm8Hfq
 1yQ14ZJAh3sTFUE4SoEPzSn0ewTuhYCrfM2ukjXLh2B2w7r0y09Nu/zJLKVQzzljrHx9hyKepwE
 Tw+89eQ6vhx511PI2GVKobcwzKSdrwc1qlPtFtlaMLoSjeIX/dS+hDfSI2JC2pvmr6lQhBvzXJG
 uG7aOUARSOkBVNqlpnDIU7+sLuV3CNkVLNOvnKbGf2o1n7QSvlZJ+pt4qiaJ0ueGeOjoKfr07QG
 ntzySCwbACGfQ==
X-Received: by 2002:a05:6000:2906:b0:48b:226:839 with SMTP id
 ffacd0b85a97d-48dbaaed220mr27241742f8f.14.1791963153131; 
 Wed, 14 Oct 2026 00:32:33 -0700 (PDT)
Received: from localhost.localdomain ([2a06:c701:4778:c500:9cb0:7d9f:2fd:3903])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0967bf5sm9622415f8f.5.2026.10.14.00.32.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 00:32:32 -0700 (PDT)
From: Avi Weiss <thnkslprpt@gmail.com>
To: Kenneth Feng <kenneth.feng@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Avi Weiss <thnkslprpt@gmail.com>
Subject: [PATCH] drm/amd/pm: propagate errors when forcing SMU11 clock levels
Date: Wed, 14 Oct 2026 10:32:28 +0300
Message-ID: <20261014073228.2095339-1-thnkslprpt@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 15 Oct 2026 07:56:36 +0000
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

navi10_force_clk_levels() and sienna_cichlid_force_clk_levels()
return success when a DPM frequency lookup or soft frequency range
update fails. smu_force_smuclk_levels() then records the requested
clock mask even though the operation failed.

Return the helper error from both callbacks instead to improve
observability. No obvious reason to clobber the return values here.

Fixes: db439ca21b81f ("drm/amd/powerplay: add function force_clk_levels for navi10")
Fixes: b455159c05313 ("drm/amdgpu/powerplay: add initial swSMU support for sienna_cichlid (v2)")
Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c         | 6 +++---
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index f8ca5eb9adc6..2d05088619f6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -1439,15 +1439,15 @@ static int navi10_force_clk_levels(struct smu_context *smu,
 
 		ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, soft_min_level, &min_freq);
 		if (ret)
-			return 0;
+			return ret;
 
 		ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, soft_max_level, &max_freq);
 		if (ret)
-			return 0;
+			return ret;
 
 		ret = smu_v11_0_set_soft_freq_limited_range(smu, clk_type, min_freq, max_freq, false);
 		if (ret)
-			return 0;
+			return ret;
 		break;
 	case SMU_DCEFCLK:
 		dev_info(smu->adev->dev, "Setting DCEFCLK min/max dpm level is not supported!\n");
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index b42897e7c066..4ef3863fae1a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1460,7 +1460,7 @@ static int sienna_cichlid_force_clk_levels(struct smu_context *smu,
 	}
 
 forec_level_out:
-	return 0;
+	return ret;
 }
 
 static int sienna_cichlid_populate_umd_state_clk(struct smu_context *smu)

base-commit: 4056b3c9d3c92ea45955641dbafeb9b960e146ef
-- 
2.43.0

