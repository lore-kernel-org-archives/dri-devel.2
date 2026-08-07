Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68A41C2A09B
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 14:34:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2B6310F507;
	Fri,  7 Aug 2026 14:34:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gngUnmo2";
	dkim-atps=neutral
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com
 [209.85.128.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC2D410F507
 for <dri-devel@lists.freedesktop.org>; Fri,  7 Aug 2026 14:34:18 +0000 (UTC)
Received: by mail-yw1-f172.google.com with SMTP id
 00721157ae682-80c5cb9a888so41433707b3.3
 for <dri-devel@lists.freedesktop.org>; Fri, 07 Aug 2026 07:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786113257; x=1786718057; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=MzF/w9lvZNrmRnz4jgcRkPusnf5swWX+v3tY1GV4EgY=;
 b=gngUnmo2FHXum3kNIOQmQn81886pPGHojJZiTtSf3LZqjbs5oXWG59BTYPcsISh8O8
 FVYh/5fdbLIITZ2bE/7mfnw/DYJkJb2fkc6MrksvZE3oNwKaC5XuKqsZd4p3O71fDBy+
 HjpF1QTPN1LFanVObkDZ4fcaz4EerC8SU9Qg/pdJefsB7qyCDzVGRAiZZF9yYIpd/K2t
 3GFTpYmrsbA0QjFtLA5nPto2rF+SdJKkQPcGamaSlWPov53i/g2H+YiaqH8fy7hauO2V
 nyPlf/w7IABRvRy+CA6wiAPxPVHLSXYY7zhcEXsodp0eOGgBY5LHsFZAORdcNUou4GW/
 SrDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786113257; x=1786718057;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MzF/w9lvZNrmRnz4jgcRkPusnf5swWX+v3tY1GV4EgY=;
 b=RDqBAkI2HFpNn1HTpa+cTwWxYVu7k40TfZukNwkfWdvZbEXgWQQtmukOpB3JDQw6K1
 yQHWB8eI1/yHgYsgwaHwEFHaDeb3Hn2vgnQiAAlw8xgYPF8PZ1/5VMYcLap6ha0D9SIu
 N4y8JtjO6EQ1R4s9TfA97MSlzjGXW+LoGtp6yJGVItwwnupvSOSiV4/0fWd1VbJnr4Je
 mTO/qXw76ecGho13wGlgFjSZ4p/YzwQlMT8yQAyQXmXxDH8JReDrhDdu+ZnR2qow6anH
 3Vm4GlbOkIVDxik9MPErBpcxtVrbkyqPmPARCATIKvTUqVN7vwemzcRrI/0Lx0hj6RGM
 U/MQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpPdcc/RODQ26gYuZzGAK/IZ2mKxYR1ds16oCuMx4iC6wmk350e7k2xpT0phORXC4s6mdEJKNEqsZo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxPl25KgEkgSE1U3UBBkBR6O+RJHTPjjYQd0NcREFhAHpsIKrE2
 b2OqQM/AiNf0G/wS9oN3UfGK8cYCdBMJiMX2EpUtZ2es0LuELefwpP2Y
X-Gm-Gg: AR+sD1261/+CnOMEFfYCcIQ5LjzPTs0vq2DsgaQgU3RY/Z4eMeu3QtOIr2bVWQV3Iu5
 jNjuqKKlnREIweLrE29z6L+jL4T/OQtsGp9WF3HO4WXptFZ5iq2wpqT8k/abG1aCRMGA0UUzXUi
 OUTpFyFFkWsszExAf8KTioMG/6RCHAg6RMCV23oW6poDZNK9Dk6lLT5mNdlw8RwDArijkHSx3Be
 pFq1sXJXbZYtAD0sctbgQhJNgcDmf7pfISd3HMoAu3w9LiIgLaP79gMWdQ5fchPAwuv9Gp+LQPD
 DINNC26+s3i5wrpTZqS03CX41NVCdUBGtwOUAhnaMedP9CsnQw4G6fExv5LcljeDRtE9CkiFTIz
 zq8WU8Cv2INAV8x+VZEbc+O0H+Tu/cGU2dZvak+sasUpdntU0H6afCUkbi7vKen5t7N70Tb3FCf
 lD5PUzoAjMVr+PwuNU1/BVJaqzSGdBD7StK7YH9wXgLTM=
X-Received: by 2002:a05:690c:4988:b0:81e:c17d:7b8f with SMTP id
 00721157ae682-820229a0a00mr138806907b3.31.1786113257374; 
 Fri, 07 Aug 2026 07:34:17 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1000::f280])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-823f6238b91sm10227337b3.34.2026.08.07.07.34.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 07:34:16 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Min Ma <mamin506@gmail.com>, Lizhi Hou <lizhi.hou@amd.com>,
 Oded Gabbay <ogabbay@kernel.org>,
 Karol Wachowski <karol.wachowski@linux.intel.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>
Subject: [PATCH] accel/amdxdna: fix usage_count leak when autosuspend_delay is
 negative
Date: Fri,  7 Aug 2026 22:32:00 +0800
Message-ID: <20260807143200.2500342-1-lgs201920130244@gmail.com>
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

amdxdna_pm_init() calls pm_runtime_use_autosuspend(), but
amdxdna_pm_fini() does not call the matching
pm_runtime_dont_use_autosuspend() when tearing down runtime PM.

If autosuspend_delay is set to a negative value while autosuspend is
enabled, the runtime PM core increments usage_count to prevent runtime
suspend. Without calling pm_runtime_dont_use_autosuspend() during
driver teardown, this reference is not dropped and usage_count remains
unbalanced.

Add the missing pm_runtime_dont_use_autosuspend() call in
amdxdna_pm_fini() before restoring the runtime PM usage reference and
forbidding runtime PM.

This issue was found by manual code inspection.

Fixes: 063db451832b ("accel/amdxdna: Enhance runtime power management")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/accel/amdxdna/amdxdna_pm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/accel/amdxdna/amdxdna_pm.c b/drivers/accel/amdxdna/amdxdna_pm.c
index b1fafddd7ad5..7dcedb7c105f 100644
--- a/drivers/accel/amdxdna/amdxdna_pm.c
+++ b/drivers/accel/amdxdna/amdxdna_pm.c
@@ -73,6 +73,7 @@ void amdxdna_pm_fini(struct amdxdna_dev *xdna)
 {
 	struct device *dev = xdna->ddev.dev;
 
+	pm_runtime_dont_use_autosuspend(dev);
 	pm_runtime_get_noresume(dev);
 	pm_runtime_forbid(dev);
 }
-- 
2.43.0

