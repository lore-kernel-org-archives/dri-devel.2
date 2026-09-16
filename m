Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB458C982D2
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 07:04:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF49110E868;
	Thu, 17 Sep 2026 07:04:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b="XrnN/ayq";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAEB210E1AF
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 21:18:33 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49e7bcb94d3so1342045e9.2
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 14:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=starlabs-systems.20251104.gappssmtp.com; s=20251104; t=1789593512;
 x=1790198312; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8c7Lrwf6LLYMTB0zxM6IKxndmvRTeS9nJzIt6c8lINU=;
 b=XrnN/ayq1WTDX10IsxxPHPFBuqBGLVubeyJDRItcR29CKupXRZnu4Vx3FAKnhYQFek
 +i+zCQs+5/WT8gAp6zo7pw2Kujz7apN0cvXSF5GJDLKzC+0Nkbtpe/rehGhkJnAjBvI7
 PznlHj3Q07qwL7YGvja3SZLtdn1k3JbI86MbGZy1Ssc7kRMXB8uh+gFGJTsTw5/u+/HD
 NVNteJAICcoQBTtjAHWYQFLhmg0RCvELiYKQlRfMkkOBmRPIIO1GRAV7svkL56g4UyQB
 upaJg1PNquMludcjRv9EZfZfzKt6H1rC4F44rprQ9PzlO4/+sSE+w0xKE7pyu1M9YAr4
 CnWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789593512; x=1790198312;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8c7Lrwf6LLYMTB0zxM6IKxndmvRTeS9nJzIt6c8lINU=;
 b=hGWasQb0HcLbdGjVMNd0WLNBNOe5e309Q2VXq/q5OG2t+2uVATmpLI/TxsYfmD9PcI
 7CkC76DhVqxK9UV6tmttRnGRUq6ZlYqhzvvN3F8taT62K8YNkX99Jc5vXMy2YdPRxTWx
 1RH9u1kOMbBh71Xkn3CjXIFWhIpgTbbsZFWccb6aS5RhOi94pq4AkNDlWYEwZderxVrT
 J5pTsRdtu6rmN4NsmgKMqQecW4TxIyqZUz8fROrwifFo08ARcTMtIXonJzqqOs8SnmG/
 paxMruRvZOMkLIKgnhoeQKRuuxR8VdmlSRECQv6SDKu2xlKnuk4QIwwJgvsllY+yqtYA
 6S1Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBwvw7b1hsvycN/hvTua3XhuDvOAFE95J4qIJMLj73QucBRX7pF8cAi7YgwGLNM5w8zkdhRaVqWBwzM=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kK57EZ7YT6NNIDL8psNDdzef5ctK4Tr0o0dbMcs/PyYl6moFe6
 x7pUC8Ve0ZUs3Rw7KrPpuiq77+Nqtfgy3JUuCFKcAU19CKafquY7u1Zmy7NsExOpSw==
X-Gm-Gg: AYBFou3B+BW52vkZAR6rc31NY3i1wGM6BjVjoJDjs/9Nl+gt29dQRENaNlWWxt4my46
 BHxwrHLIGWuQdSOOEcm+s4Yy2sClJr3ozsZm3zV1gfbAnQRS5B/z8u8o2Vec58ZlsDZn0rRCyoS
 79KX5YizVjZjDVGuBT7C2koznp8kWLK8/lyWAiIR2szmuTF2w2hppmb3kU+IG7CVwelHodrRR67
 lCdVPUYreJTI5TNTpjWyzTWqrJ5QIhzqtUgyNB8uhVREqPXYioOGD/CkjE1jNA4vo/5UpMJV6eL
 4MWqLmJXHl+2lG4fKfxiupTSatfE1i8KX85eYTJNTfS19/bZ6AD5B0MCpcdx5nUlaNMXQJP0vLw
 meDqHgOPKuBMEFRUN+LZzMVlq4g5bnTM7kHYme1aQ/JRrqxOFg9iPEJePu1S52YWyXR4566G7OB
 w8n/6mWNMjJjLKv4p5pDApkxlp6sHOJArM5Db9DjdklEyL0LPvdyGX8z6G8vRGJ8EBdZqi9B4Sy
 y9p2FWk38HJecwj5CQF5Ka+hg==
X-Received: by 2002:a05:600c:8b78:b0:49c:fc6e:8cb4 with SMTP id
 5b1f17b1804b1-49ebb4297c4mr52763795e9.24.1789593511641; 
 Wed, 16 Sep 2026 14:18:31 -0700 (PDT)
Received: from horizon ([217.155.46.38]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fbbd83e39sm46567695e9.4.2026.09.16.14.18.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 14:18:31 -0700 (PDT)
From: Sean Rhodes <sean@starlabs.systems>
To: linux-kernel@vger.kernel.org
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/i915/drrs: Ignore sync polarity when matching modes
Date: Wed, 16 Sep 2026 22:18:30 +0100
Message-ID: <6436114aa461b08bf0abddadf2c091c45dc81075.1789593508.git.sean@starlabs.systems>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 17 Sep 2026 07:04:01 +0000
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

Some panels advertise DRRS modes with matching timings but different sync
polarities. is_alt_drrs_mode() currently includes DRM_MODE_MATCH_FLAGS and
rejects such pairs.

Commit 2bd0db4b3f0b ("drm/i915: Allow panel fixed modes to have differing
sync polarities") already made is_alt_fixed_mode() ignore H/V sync polarity
because panels can declare alternate modes with different values and
Windows/GOP accepts them. Apply the same rule when matching DRRS modes.
Continue to require matching timings, 3D flags, and all other mode flags.

Tested: BOE NE160QAM-NZ1 (3840x2400); DRRS reached low refresh.
Tested: Huawei 23040676 (2520x1680); DRRS reached low refresh.
Signed-off-by: Sean Rhodes <sean@starlabs.systems>
---
 drivers/gpu/drm/i915/display/intel_panel.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_panel.c b/drivers/gpu/drm/i915/display/intel_panel.c
index 81e638d0c7b3..e79c51a1c33c 100644
--- a/drivers/gpu/drm/i915/display/intel_panel.c
+++ b/drivers/gpu/drm/i915/display/intel_panel.c
@@ -144,10 +144,13 @@ intel_panel_fixed_mode(struct intel_connector *connector,
 static bool is_alt_drrs_mode(const struct drm_display_mode *mode,
 			     const struct drm_display_mode *preferred_mode)
 {
+	u32 sync_flags = DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_NHSYNC |
+		DRM_MODE_FLAG_PVSYNC | DRM_MODE_FLAG_NVSYNC;
+
 	return drm_mode_match(mode, preferred_mode,
 			      DRM_MODE_MATCH_TIMINGS |
-			      DRM_MODE_MATCH_FLAGS |
 			      DRM_MODE_MATCH_3D_FLAGS) &&
+		(mode->flags & ~sync_flags) == (preferred_mode->flags & ~sync_flags) &&
 		mode->clock != preferred_mode->clock;
 }
 
