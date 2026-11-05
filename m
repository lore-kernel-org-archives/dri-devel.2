Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35C5606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 09:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qlXX3DTr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B220112C58;
	Fri,  6 Nov 2026 09:18:54 +0000 (UTC)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31BEC10E939
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 06:04:47 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-3b083afebe4so194031a91.0
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 22:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793858687; x=1794463487; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qq/4vwt5KZIiFWaAeaK5UibLMyaTMg//P8AG8snjRNo=;
 b=qlXX3DTrbRIFQok0wMIJxpFq7+g0PwubwMJLo6iJjj4hBpHE4O4ym36bw30sljo8us
 ByEodnTfVVq1VmvqzuyidmrUxosDI9VrMWpvPOj/ucRKMJukjUi0Nq616sgt6mNfeErG
 aqPeljQ0g017y4WU1unAX1okVewyeKkX5Oex9gfFrOPlhgvNRQhvvpPV9pNGYfz+6ZtP
 kvug4izV6fWWjYYrqY6a9U+7ZqGJVTsQfiNgNlsuCHU0hgGKfmh3bLoI1FG3FSbeXFYt
 TToZahZfqheN3Tx0HugUGltpTD9HwpPW5HBCNqyWynE59qnuy7nxjx+3gDPLUH6wOaZf
 3JJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793858687; x=1794463487;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=qq/4vwt5KZIiFWaAeaK5UibLMyaTMg//P8AG8snjRNo=;
 b=V7HhcVmpDoFdabhqPUBAodjSvBSpy0cRslyT87uF7sA/QhvlVEsBgB0tyZcGYtM9vm
 Q2fDI75FHN8vNbWqUo8W9sBTJIbFGejtfktRigA6Te0rHKbly6ZT6eOBKd4awfllU6De
 RNpQtPKSweK8Y9fKUMIrozOw1Lh/lra58n2jNvTmLxm/iYCubQTri6+zgP7LU/NNQTI2
 O1p+diBIu2qGNeD+FQQABXDTVDNutE4dC/B2KR+ONM7Q8FBW9/9c+L+BpnuR+13+8lXM
 O5Az3woGzeOSbu+lKS2plaTB/qScnAZiw7IEwdrNBGpgn24JmC3uhhlhCbE9U0ADLRSA
 EOaA==
X-Gm-Message-State: APuU4Z+U9zLG6yTS3Us8tRfT2v/H7uRQ4aqWE26UogbxWeUDM+ZZBR//
 HPW+4R14g6UYpR4vGNaQ6t39/P3JYHJAHV952LB5Hp7pznVNj0fJlQcj
X-Gm-Gg: AYBFou0srHKJ9+gwZdBcr/RLUl+1KCpe9FvBKDYD0d8vB9ShH5dp7JASS42l6L8B2YS
 NaGA0u7BuGO1pNm4Rcd921SGAuSwpK0VH9B9bf1seRC1AyKuz1Nsp6ENR4xZncXmg2d+YzhoPSc
 puqfivrm1qnx1HofSjfZTQPYEO4hUOKncOZZobkEwkbZ8SzsNwlp0dPse+tBec1/2Qd7bf7rd4a
 cTSE3yVzHmbxZX1Vfgcdf/VVlVom4V6MUe9wF+FE5Z8CK32UZos7vdxTtt5rSiOpzOGGkdLuFO5
 juQSb98xRarw/wVFYxU3crzUyOFkO2N+HKsUD/1H4SNue/jJRitL6MWgoVwfCygEH39DWTMnL3p
 WVAXlCYp4z0JRTA7uCNPo7+5LDEWcTv+07iayRubxk2T9BfdQbmXArwFJSTe2U2Ue0mRpKNNYX0
 2fgEBomwc4AKR8nygQjkWzbqNoKTit7lR38mWDiC6QMAxQQhzYyRXU0m35cSjkvCP9DVosgRT0m
 0ekvsJzMFoVGCUv2D4XNgjJuW/xqYzB1rPIAzygcByBTjRyY9e1+ZxxYRu9vfbfUyl2iMzCNsd3
 e0My4ooa478A+7v6AOdTAwJwtnueJMGm6re3wBL7Qw==
X-Received: by 2002:a17:90b:2f4f:b0:3a0:c162:51af with SMTP id
 98e67ed59e1d1-3ae89291df0mr25913696a91.0.1793858686515; 
 Wed, 04 Nov 2026 22:04:46 -0800 (PST)
Received: from CRASHEDROM.localdomain ([142.249.36.161])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b0b313c0dcsm2093100a91.1.2026.11.04.22.04.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 22:04:46 -0800 (PST)
From: Chengyu Liu <lui2012qwq@gmail.com>
To: intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, ville.syrjala@linux.intel.com,
 jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
 rodrigo.vivi@intel.com, tursulin@ursulin.net, stable@vger.kernel.org,
 Chengyu Liu <lui2012qwq@gmail.com>
Subject: [PATCH v2 2/2] i915/perf: remove sysfs entry if idr_alloc() fails in
 add_config
Date: Thu,  5 Nov 2026 14:04:22 +0800
Message-Id: <20261105060422.51848-3-lui2012qwq@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261105060422.51848-1-lui2012qwq@gmail.com>
References: <20261105060422.51848-1-lui2012qwq@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 06 Nov 2026 09:18:40 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

i915_perf_add_config_ioctl() creates the dynamic sysfs entry for the OA
config before allocating its id.  If idr_alloc() fails, the error path
drops the config reference via reg_err: without removing the sysfs
entry - unlike the normal remove path, which does sysfs_remove_group()
first.  The leftover attributes point into the freed oa_config; kernfs
only stores the attribute pointer, and show_dynamic_id() reaches the
freed object via container_of (including the show() callback itself),
so reading /sys/class/drm/cardX/metrics/<uuid>/id afterwards is a
use-after-free.

Remove the sysfs group on the idr_alloc() failure path, mirroring the
remove ioctl's ordering (under metrics_lock).

Found by static analysis.

Cc: stable@vger.kernel.org
Signed-off-by: Chengyu Liu <lui2012qwq@gmail.com>
---
 drivers/gpu/drm/i915/i915_perf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/i915/i915_perf.c b/drivers/gpu/drm/i915/i915_perf.c
index 19b82427aa41..40385f991abb 100644
--- a/drivers/gpu/drm/i915/i915_perf.c
+++ b/drivers/gpu/drm/i915/i915_perf.c
@@ -4716,6 +4716,7 @@ int i915_perf_add_config_ioctl(struct drm_device *dev, void *data,
 		drm_dbg(&perf->i915->drm,
 			"Failed to create sysfs entry for OA config\n");
 		err = oa_config->id;
+		sysfs_remove_group(perf->metrics_kobj, &oa_config->sysfs_metric);
 		goto sysfs_err;
 	}
 	id = oa_config->id;
-- 
2.25.1

