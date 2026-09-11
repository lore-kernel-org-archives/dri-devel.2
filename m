Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69FB7C88E5C
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 20:53:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97E2E10E9D4;
	Sun, 13 Sep 2026 20:53:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jB4Yr0RH";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A41010E412
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 20:02:14 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-49a97714f5dso11997885e9.0
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 13:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789156932; x=1789761732; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=WpWwiGaL36YcweuGSaJBrN203pu/dlOicI/VWEKjlnY=;
 b=jB4Yr0RHvhnAQV/NgIpMAsjfti/wrso5mv1Pb2Aptx6lPPCxdtimMcI4K+MZvaUzUu
 Eh2jKQHdF/L3NIdXEGx1ZFBMVVxxzc+PwY04lvQgyUy48VKRtDzJ+4BsZGcveQqmZkdK
 D6wlKe07gcJIiRWOPKAWZDMYITCI7Z9I713avAEIEzAtzUasr1uIFRaPYLdTCbhWF9e1
 RPE6mtFcpMKl4QUjPi2k18YVpc3ZzRyQh1qXI8171OAEqZjvfWJNH1DBYwmfAmAs6P0v
 ZhfN3KSuG2mYG/Zst/HFvKpMukTgR4VHXYE433d0q/6K11BAwG8VKU+LGryfOPXsvbuN
 k8vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789156932; x=1789761732;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WpWwiGaL36YcweuGSaJBrN203pu/dlOicI/VWEKjlnY=;
 b=g3EHiQwfS3yj/FKDqGbw58O9Qr235CDCq6szfVTZRLbPPA+YVetVZeYFRPJ61MZN3E
 AIp5ZCmX+1tPS8QCVfxpMoaFDap8uwD/zjaLK5CicyDz6q/rTrCF7j789lDUb/FCYd0B
 FWP53RBjH9gUwXkxYgKIrejO9t+03OP+q1K+cXWtLpuYPF0grq3P0mAKaZFvDEOV4MSK
 XoOJbrGjcGKXR0u49vgSqYxAYEgUkdWxQeTx+6fWnNPpnBUpsGbqGqePSQL1z94kmxyU
 2s3/i7xSfbTpsm+0KWEzMBV+MAH1PPxj1lA0F94YP0nN67ah6siWQ9KX6TV7rtOVrryg
 krHg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwCpwbQVmEWYQy3NYZNeb5jNEoVQkkzJqi0DZy4dIBNPt9Dc9qozeH23LIJ0A0D+zWR64xtONz4cC0=@lists.freedesktop.org
X-Gm-Message-State: AFuF++ndP7E0OuIbV/5yP6slOLJ/F74grHZ7DT3cc2nMIo1s6CRvLWuh
 3/F1+SPg4rYYEm8CD1PEDso/G+bM7D4KNYYc9VnHiIESZNHPLfH+zZvI
X-Gm-Gg: AYBFou3vJoNvTdw2Yo6jWh+AU4Ffxlx7PurRCmEt4OQjhzRMEnKCPmTmYx1niMX2/ZF
 1vEh0IoPQRSwuiTeFAiR0khyFxmAJNDGT8eCAddATRO+gcXKkK2DC+TUMRuqcL9sAC7VvvQ5jOE
 9mOeXUh1qCkh6BpEyHt82aH1buKiY0E6FLVRg4cdXaENX90VzbaCQ68bLoK3XpxmhLwyc9WCayP
 /auZtdrMvCVd22PYfVV8qyy5/q30xH9Ev7eraDvaN3omtOjSj7pZzIeKMI1D7zyrP6j1Ku9zMdE
 AYJSAdj4KTARm8EtHcammK+Kbpc2mpPoIEbhB+yTD6+X/508CblhCshqy0duSJnpKYoNJBOixVc
 O7LgyimdcCIqBRkqhm06OpzxyBeOlFke9Ta0GoznZqKYx5TEEtKQ+F7NDQmmebxZAIjZIYYDNOl
 2+mf2JACwHL5JsXeFbl4Rqk5/qDWincCB9/BLcH+PSct69lS7YDWffAIL3Znf6NJ4AQUdvvO2bQ
 A5GIwKKkVyhEW3iEQ7Zx8TbaZuNGSGLTHfa1/iEKRv6kC3AENBNESqwD/plAW8ON0buk5u2CVWH
 yd8KqcYlo5IAE+TUP41wBvXwtFeO7eb8HOGJ
X-Received: by 2002:a05:600c:4691:b0:49c:fea1:f792 with SMTP id
 5b1f17b1804b1-49e6198f947mr76504605e9.12.1789156932186; 
 Fri, 11 Sep 2026 13:02:12 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-095-114-033-154.95.114.pool.telefonica.de. [95.114.33.154])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e69f02c92sm28156515e9.2.2026.09.11.13.02.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 11 Sep 2026 13:02:10 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 =?utf-8?b?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Chris Wilson <chris@chris-wilson.co.uk>
Cc: Karl Mehltretter <kmehltretter@gmail.com>, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/i915/audio: Fix names that do not exist in kernel-doc
 comments
Date: Fri, 11 Sep 2026 22:00:53 +0200
Message-Id: <20260911200053.78731-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 13 Sep 2026 20:53:15 +0000
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

The audio component overview still refers to the former
i915_audio_component_ops and i915_audio_component_audio_ops struct
names. The generic audio component split renamed these types to
drm_audio_component_ops and drm_audio_component_audio_ops.

Update both references to match the current types.

Fixes: ae891abe7c2c ("drm/i915: Split audio component to a generic type")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/gpu/drm/i915/display/intel_audio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_audio.c b/drivers/gpu/drm/i915/display/intel_audio.c
index eae76e9611055ea684dd98c34889be2413a89f80..c703da26914c1d957dff61a0220b70d3275255ce 100644
--- a/drivers/gpu/drm/i915/display/intel_audio.c
+++ b/drivers/gpu/drm/i915/display/intel_audio.c
@@ -63,9 +63,9 @@
  * covered here.)
  *
  * The struct &i915_audio_component is used to interact between the graphics
- * and audio drivers. The struct &i915_audio_component_ops @ops in it is
+ * and audio drivers. The struct &drm_audio_component_ops @ops in it is
  * defined in graphics driver and called in audio driver. The
- * struct &i915_audio_component_audio_ops @audio_ops is called from i915 driver.
+ * struct &drm_audio_component_audio_ops @audio_ops is called from i915 driver.
  */
 
 struct intel_audio_funcs {
