Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E979CC61DB9
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 09:44:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 056BD10EF69;
	Thu, 27 Aug 2026 09:44:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lDPRqkIk";
	dkim-atps=neutral
Received: from mail-pz2-f6.google.com (mail-pz2-f6.google.com [74.125.228.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69D0A10E249
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 05:24:33 +0000 (UTC)
Received: by mail-pz2-f6.google.com with SMTP id
 41be03b00d2f7-cc1c4267d50so56679a12.0
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 22:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787721873; x=1788326673; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=2iIl3uA7kRHPn8Sz3ycjaBFmA0XngwesOSx8TRlbXC0=;
 b=lDPRqkIkxtVPTcEwoCLWB88kXsB3OikqGSyE6WlWTJ1wykSxCyolB/OHUGjjG5WZ51
 qpbYl7P3mCFYQMyIZ3PlFlHNF54DCHG1eXRrce+PSJOdzDBp1qx2As03HJtrUUoi7RNN
 akvGOwzu5S1qym20Ch1H9gfNZNEXRXDlTZhiy6LFMVuEAzp/YkFEvxEGUlAVR1POuzMn
 oE89CSKdccIZbHSclmWyPWBoAWQt7zJlrXj/ssIC1vGQ7TfENX30Kh9hu5k99GMAmBKq
 6G/zG15pXgVnpAyHhrC7Kliclh7ASTjZLPCGu4EyyBeyffqPJ7kt9K4X2AObnxOog7ww
 9Ecw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787721873; x=1788326673;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2iIl3uA7kRHPn8Sz3ycjaBFmA0XngwesOSx8TRlbXC0=;
 b=AMxhUCiWxJbkAXRRMc0pZzPGt7oYaYXjpaYe/+w/bwM43YYgY3Jfidmd888/6gnpc5
 DT5vHWgDARkOHTDV0cX7M7ZewsCUQZNmFVbpLCuT+HqJvbU2LBB02E1L397n9am3AYe/
 Wd4Tr/Qv/AgzhpunOcImjMDDcJvGqabMlKaHljBoJ3FYDlWi/X/9CEhFXG64v6xOzSHk
 hloQAh6Zx0Q1E8qg44pcHKfEqcvVbaQKyegKmft5b4UsCNsUHYd3cn4ahJat8h2vrpX/
 ANtpLX9xKu5ZNqSEkWh/h3QXmJu90VYACGlhzpPrmZrpbWxR7N01oOqOIXqLEhorXPZ6
 Ivhg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqHvwBJSboGYt0HdQFKH1ruLo8xXpHXCJH/7vlYT3qeVR/7dQfIR0In2s8DaoKTvTpBd4fFIh/VdUI=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mBs9RqUdBsyB3hTBXU1jDDE8wKXV9e6KckGCT/qcboQfcDFuGy
 gcT7vmS5Yn7c/rXIyCdsZxL9a10vOyOSzAnhxZMCRt6YwsPuTROCnmdY
X-Gm-Gg: AR+sD13VvyXNBd/iizuvmDxr1YlxljbWNWxGVKbGdD1aa6DQQsWO2LhNUEBy+9Yvknp
 /zJ/tS62ecQAI+YJeNYZGdq3vFiq2sScX6oMKBRmDbktRWKRA/IiOMWAI7s8RMWr5Hd1gN3qQMu
 wF8RkVa1zL6P3dYWJ8eJF5Mvw/JU6w5PzI+8W4GbjE6juc2hY/G/ZggYQK1cATdGEVbWonPmpvV
 Zn9hNCR91bEyqHIu7IQLTC69x6K23+NHt83sxit10ya/HsJZDpi2BE4xa/7pFHNKQfhPRBiklts
 THqnrwwPKqVuJv527vJeZjLSYm+Dl5E+5uo6V2AMh/Ls0RNOinJZR6oEo6ptIxoCZSKiltTddbl
 ngTF9pq7mSpxIDGX7LTJQv6ZXrGx0nSt6lmy5i9Y56rzADnBuv7EEPqt6EhwEdVQ2GPdUOb6URl
 aQCtQ+MtKHC+35yWjdzdr+OBPGHAJ9hRymhlo6wXd98cVmdt7wdXzxes+Pkvb1sXTssGFcWX0ja
 pd+aP7Vsuk=
X-Received: by 2002:a05:6a20:a106:b0:3cd:602e:f8ab with SMTP id
 adf61e73a8af0-3cf7576bc90mr6714349637.4.1787721872732; 
 Tue, 25 Aug 2026 22:24:32 -0700 (PDT)
Received: from DESKTOP-BDFNLNM.localdomain ([27.63.245.244])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3283d8dc465sm4505557eec.24.2026.08.25.22.24.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 22:24:32 -0700 (PDT)
From: tarund18303@gmail.com
To: jani.nikula@linux.intel.com
Cc: rodrigo.vivi@intel.com, joonas.lahtinen@linux.intel.com,
 tursulin@ursulin.net, airlied@gmail.com, simona@ffwll.ch,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, tarun-tarun143 <tarund18303@gmail.com>
Subject: [PATCH] drm/i915/dp: remove redundant link state check
Date: Wed, 26 Aug 2026 05:23:57 +0000
Message-ID: <20260826052357.10151-1-tarund18303@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 27 Aug 2026 09:44:45 +0000
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

From: tarun-tarun143 <tarund18303@gmail.com>

The DP link state is checked and recovered through the encoder link
check work from the modeset and HPD paths.

The detect handler also used to queue the same link check work for
non-eDP sinks. This was added when link recovery was moved to the
encoder's check link state work, and the original change explicitly
left a TODO to remove the detect-time check once it became redundant.

Remove the detect-time link state check and rely on the existing link
recovery paths.

Signed-off-by: tarun-tarun143 <tarund18303@gmail.com>
---
 drivers/gpu/drm/i915/display/intel_dp.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 113d767e62e9..ffd39206b958 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -6379,18 +6379,6 @@ intel_dp_detect(struct drm_connector *_connector,
 		status = connector_status_disconnected;
 		goto out_unset_edid;
 	}
-
-	/*
-	 * Some external monitors do not signal loss of link synchronization
-	 * with an IRQ_HPD, so force a link status check.
-	 *
-	 * TODO: this probably became redundant, so remove it: the link state
-	 * is rechecked/recovered now after modesets, where the loss of
-	 * synchronization tends to occur.
-	 */
-	if (!intel_dp_is_edp(intel_dp))
-		intel_dp_check_link_state(intel_dp);
-
 	/*
 	 * Clearing NACK and defer counts to get their exact values
 	 * while reading EDID which are required by Compliance tests
-- 
2.43.0

