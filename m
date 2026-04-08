Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFD40FD5F88
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 08:45:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05C9F10E594;
	Wed,  8 Apr 2026 08:45:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ch1ehORK";
	dkim-atps=neutral
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com
 [209.85.222.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A67D10E596
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 08:45:18 +0000 (UTC)
Received: by mail-qk1-f177.google.com with SMTP id
 af79cd13be357-8d67a483d3eso395383585a.1
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Apr 2026 01:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775637917; x=1776242717; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=3lr+SQhutbSWGABS7oQ2OjJMnCc+Y1xCXHP8EbLYn64=;
 b=Ch1ehORKhIcyC14cSR/WO7bL4FBH6PadmhAIO3BLfGMf8X8r58JJY8F6idH4paX2VU
 lpESWUfZBDdWjNmD9segymcehWLh6CexXRAkTxSIlKPINC0xtJYaQBvKb02GqJwZHGUB
 jdhMD2b/jmx5fp0ycdB2CrWUnKWtuwo2Ds2+pkjSMvQ9h8Fam3NlnzcNciSCibRT/HU8
 dv3CHp3sfsBx0LOtpep0vvqP3eyRqAkjgjohbytfZUYfTHM6ATetiYTa/Cz7ZX4Cvtbt
 H79aWDJK8qim53pmZDYDSdPQbkka9Mv735tdKddA8ELMq/vIGe89INytrV2asmcANH/2
 km8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775637917; x=1776242717;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3lr+SQhutbSWGABS7oQ2OjJMnCc+Y1xCXHP8EbLYn64=;
 b=fek+VBdtGjtqE5EYypEoxzQXLtCqq7ubTVw7XG3a4ixDJs+o6vOm8bTNjF2TUqwSXi
 066mXii+b6mCRk2pb+XkMagk7RgF6GnDfcxCUEFhbX0HbtDEz+lDdb9h7b8H5w5My+Yv
 mhflfV7vidt2a0SMTVEqRhHx0x/ls0Zd0NpZnoX/uAx5tGckfnuPj3zlQ2/kKx/qHnaz
 UtSGPN53e6EBYaVJNO95wk7ZLnjYsy0i49b+g2D2ax2r7kLIYEEazRheEnn3VeyTBUyy
 /+LfYW9rRPcqQuCTa97o6tb5L0nLyz2ZyZHnV3uSOeXIIAm/enxcIc4sYpWFfYGMx2HN
 o/eQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVusshROEGKqEdwwWXz0oTkE+WDDiYDIhDE0UnD9ZJc2tcEXCPWv+g37g0g9IU/cJF3xfb1PvIHGTE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw1EYiwYhW/HUAwNoJTisIsR46CpSHz5HuQOZL6K08/67oUqDYe
 bbGve2n7cs6RavJjgFoUMeaYWT6sKAF0H/tTgnddVTZJGEjNxVOOugWa
X-Gm-Gg: AeBDieufx8b5tkFRKXpXdVK0PDG53SSk7KEXRf0n5ohuxY5pjrQMMCeyITPFFc9wByJ
 VXgh8Bfe7ZoE+nkEtW97JMAx7+0+kjBKEVthlgf39iJyVHDR9EilzEojHQbZG4QEvkKu25QqH23
 S1cMR/cuIQOi46KyGpq/tHndfeciOVfZYrmtFLRxsWIXClgqcQTtbo9n3o9RwN+iv5T3ynUnoEF
 OW/pBqsDIxVr18sZ/agRGAKqydThhXDd0YVjU3mcNlZpD416+j1fnR7rsR2DE9PXT4vzoCDWTBV
 FGl5B+OWnci8t+sAH+L7MUcuHfR+YC39tJK/43pFDfABraoeGk58mC7VK/3LrsZg9y7PykM2Myw
 BcjF1GSjI4BvXDSASrGR4bfjicshb0PRF9KnyS9aq4Yi1pAYl95ZTK2J70CyVKfmFYMLtUPAGRG
 RsQKWWA0+yOERXmbbR
X-Received: by 2002:a05:6214:468c:b0:89c:e4c3:dc2d with SMTP id
 6a1803df08f44-8a7022bbe6amr337024886d6.2.1775637916961; 
 Wed, 08 Apr 2026 01:45:16 -0700 (PDT)
Received: from localhost ([2001:67c:1562:8007::aac:4468])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ac56e3a898sm39028506d6.38.2026.04.08.01.45.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 01:45:16 -0700 (PDT)
From: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>
To: Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/i915/dp: Clear accumulated HPD events after link training
Date: Wed,  8 Apr 2026 16:45:09 +0800
Message-ID: <20260408084509.555045-1-acelan.kao@canonical.com>
X-Mailer: git-send-email 2.53.0
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

After link training completes, intel_dp_stop_link_train() calls
intel_hpd_unblock() which fires all HPD events that accumulated
during training via queue_work_for_missed_irqs(). On MST hubs that
generate rapid short HPD pulses (observed at 5-55ms intervals on
Dell U2721DE with Realtek MST hub), this creates a burst of stale
ESI processing that races with the ongoing modeset pipeline enabling
the 2nd MST stream, resulting in a GPU hard lockup.

Use intel_hpd_clear_and_unblock() instead, which clears the
accumulated HPD events before unblocking. These events are stale
since they reflect link status before the successful retrain. Any
new HPD events arriving after the unblock will be processed normally,
and the scheduled link check (intel_encoder_link_check_queue_work)
provides a safety net for detecting legitimate link issues.

Signed-off-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
---
 drivers/gpu/drm/i915/display/intel_dp_link_training.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp_link_training.c b/drivers/gpu/drm/i915/display/intel_dp_link_training.c
index a26094223f780..4de2b3d3ea21c 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_link_training.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_link_training.c
@@ -1267,7 +1267,7 @@ void intel_dp_stop_link_train(struct intel_dp *intel_dp,
 			lt_dbg(intel_dp, DP_PHY_DPRX, "128b/132b intra-hop not clearing\n");
 	}
 
-	intel_hpd_unblock(encoder);
+	intel_hpd_clear_and_unblock(encoder);
 
 	if (!display->hotplug.ignore_long_hpd &&
 	    intel_dp->link.seq_train_failures < MAX_SEQ_TRAIN_FAILURES) {
-- 
2.53.0

