Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A015FC43458
	for <dri-devel@archiver.kernel.org>; Sat, 11 Jul 2026 23:07:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92F1410E2B0;
	Sat, 11 Jul 2026 23:07:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=asu.edu header.i=@asu.edu header.b="J7aICwPN";
	dkim-atps=neutral
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6F6710E181
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Jul 2026 23:07:33 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-38a0c7e841fso2391766a91.2
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Jul 2026 16:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=asu.edu; s=google; t=1783811253; x=1784416053; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=b01MPLPFUTPl/FZxo6tsZL3gbo3NnjDL9LbETEmQYys=;
 b=J7aICwPN3yO2bWpZvoq+DsSdj8GXURuum0etHGOvEUNUpF2FnBhzYdw/VrQJ6kbpkM
 6qOJjzJ1ncR/Eyb0KagfF3ouUVBOfCCR6eI39nXVrjN43r8t6qR4Nf8fRH1KFIEkvcpg
 aZNsvY5bjh9atHY2HAkRFaGPGM6z2+ESKzfzWxXDyQvd8EDYbXxAX+WH/H033yO1mKW2
 L47MeUjctNLM4/W1Qa6LsX1rU0vH1xg8ct1rDqU8O554nVcVmwi9dN6MDJuxeYIhBDG+
 Rxhripc1GmPR/v6675OY79rw75Wu64E+DrLwnMOA4sAMBsmr2nLxz5daVTxuBAtyDxHi
 O9Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783811253; x=1784416053;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=b01MPLPFUTPl/FZxo6tsZL3gbo3NnjDL9LbETEmQYys=;
 b=ALEtqLb50MvbwFYmEB5FVKD2n8c45mhBzlnhfZSq1fbjcMfy7zL0Zzi+o+mMo5Xbkn
 GUTp1BM9N5AnMGL2ppXrb68Ml2+s4s4wiCPc25peQLmC5Mxleax65Y0yogEa2jxfu4qA
 8CoknyjfndUbW72Fx2uTQETa89B2wGT4S/5wGxJmo57kB2/lxI/eGEypw2tiycGg70SW
 X0XqBYIhIFhNxSwU7awqKeeHQQ8T/1q1AKFJpD8Ye0vLq02tgXmDD76PiXSMMa0Zj/Tl
 UADzw+Wd4PxV8ez/9QIMye8EvlJz17czbDlRElM7EvdpuNV4wLrQrAVpEy+zIrOT8cVS
 ETHA==
X-Gm-Message-State: AOJu0YybygNKxt6R4Kzagmz2Cdsd5W1VFM+uO1NHac6QAHKR9sn2Z3sR
 5WY4MeJn0yfwviGAWLLdRhOCPmgmG1Bn6NmtrzY20BWO06YHkI0NMttJjoLn5ZEKcQ==
X-Gm-Gg: AfdE7cmyJ9D4TgKKbyHe9maYUBATmPnLl9YYHkTx5hpXRYpPmAvvmnEnnzQIKAX9BI5
 ePlF8D9jX1dJ0FY/L5UNG3cdAbwqzyRVKNVNzjLInLWFfFbm4fPWDQAf7gFzVaZr9rDyzfoRXYl
 i24KM3KsGu+3X1WvW86OkMQ+KJggnJATCjuck8W3x80376JE13JPMMUWpcgGnA+8rIOXG/HPYVj
 T3SoO+JdGhDnJWT8+KyxVqIZvsA0J4xIYKAKjqL5N0KI3E1o+OBOWiAquGb4Wevk/ICvsqTqyOH
 /4baU2QPujI7NTxCLWkbdZAwr87bcQEmkhPbRAkWf1N4wLVSXbIaDTkNZK/6yQyR0uVd3bxCAWU
 oPkqr6dDyBiJyIKSmEWL0speaZIim2Ffm4li+QR9Ja5i02MWp2JCoP7B4347ZcDiNAs0iTQiCow
 ==
X-Received: by 2002:a17:90b:1c88:b0:38d:b36e:9824 with SMTP id
 98e67ed59e1d1-38dc7736eb2mr3773848a91.20.1783811253273; 
 Sat, 11 Jul 2026 16:07:33 -0700 (PDT)
Received: from p1.. ([2607:fb90:ecae:8611:d369:525c:ef37:7318])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38a583a16c2sm4447555a91.13.2026.07.11.16.07.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Jul 2026 16:07:32 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Dave Airlie <airlied@linux.ie>, Zhao Yakui <yakui.zhao@intel.com>,
 Weiming Shi <bestswngs@gmail.com>, Xiang Mei <xmei5@asu.edu>
Subject: [PATCH] drm/modes: reject out-of-range GTF blanking duty cycle
Date: Sat, 11 Jul 2026 16:07:28 -0700
Message-ID: <20260711230728.2250485-1-xmei5@asu.edu>
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

drm_gtf_mode_complex() derives the blanking duty cycle from the GTF
C/M/K/J coefficients and divides by its complement:

	ideal_duty_cycle = GTF_C_PRIME * 1000 -
				(GTF_M_PRIME * 1000000 / hfreq_est);
	hblank = total_active_pixels * ideal_duty_cycle /
			(100000 - ideal_duty_cycle);

ideal_duty_cycle is an unsigned per-mille percentage that must stay below
100000, but nothing enforces it. Via drm_gtf2_mode() the coefficients come
straight from an EDID secondary-GTF range descriptor, so a crafted monitor
(or an edid_override re-probed with DRM_IOCTL_MODE_GETCONNECTOR) can set
ideal_duty_cycle to exactly 100000, making the divisor 0 and trapping with
a divide error; a larger value wraps the unsigned subtraction and yields a
garbage modeline.

Reject a duty cycle of 100% or more, which is never a valid GTF result.
drm_gtf2_mode() and the inferred-mode helpers already handle a NULL return.

Crash:

  Oops: divide error: 0000 [#1] SMP KASAN NOPTI
  RIP: 0010:drm_gtf_mode_complex (drivers/gpu/drm/drm_modes.c:972)
  Call Trace:
   drm_gtf2_mode (drivers/gpu/drm/drm_edid.c:3365)
   drm_mode_std (drivers/gpu/drm/drm_edid.c:3464)
   _drm_edid_connector_add_modes.part.0 (drivers/gpu/drm/drm_edid.c:4024)
   drm_edid_connector_add_modes (drivers/gpu/drm/drm_edid.c:7020)
   bochs_connector_helper_get_modes (drivers/gpu/drm/tiny/bochs.c:575)
   drm_helper_probe_single_connector_modes (drivers/gpu/drm/drm_probe_helper.c:426)
   drm_mode_getconnector (drivers/gpu/drm/drm_connector.c:3376)
   ...
   __x64_sys_ioctl (fs/ioctl.c:597)
   do_syscall_64 (arch/x86/entry/syscall_64.c:94)
   entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
  Kernel panic - not syncing: Fatal exception

Fixes: 26bbdadad356 ("drm/mode: add the GTF algorithm in kernel space")
Reported-by: Weiming Shi <bestswngs@gmail.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
 drivers/gpu/drm/drm_modes.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
index 3f8e025fd6d9..b6f263e9ba86 100644
--- a/drivers/gpu/drm/drm_modes.c
+++ b/drivers/gpu/drm/drm_modes.c
@@ -966,6 +966,10 @@ drm_gtf_mode_complex(struct drm_device *dev, int hdisplay, int vdisplay,
 	/* 18.Find the ideal blanking duty cycle from blanking duty cycle */
 	ideal_duty_cycle = GTF_C_PRIME * 1000 -
 				(GTF_M_PRIME * 1000000 / hfreq_est);
+	if (ideal_duty_cycle >= 100000) {
+		drm_mode_destroy(dev, drm_mode);
+		return NULL;
+	}
 	/* 19.Find the number of pixels in the blanking time to the nearest
 	 * double character cell: */
 	hblank = total_active_pixels * ideal_duty_cycle /
-- 
2.43.0

