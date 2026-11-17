Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DC1606A329
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 11:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A/aMTSCe
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9701E10E562;
	Tue, 17 Nov 2026 11:32:38 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A809D10E576
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 11:32:32 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4a140e7405dso46639925e9.3
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 03:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794915151; x=1795519951; darn=lists.freedesktop.org;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ah0q/JTuhX4xDVOrwkG1t5tUQwpt5YsuBa7AH/Yk8Vk=;
 b=A/aMTSCe/NeC2lXSdMeCjv4Eo0//qFZEu7PtMP6Q66LzqFKlnaMXBixxOwGB/XCTJx
 wSm7rTwYM7iKVwiheUbqmZyyzaVG+JLpspZXkOkgHPq93W4/Gj58zrB3rwqFiCfggea/
 5rUTz6g3OeVeumlYyjd2k+TqCFNLTRc9Yw77izHuZZ47KuqOQIeYNdZIU6WQi73b7EFP
 n2y2WnbhBi8CX4oZXn/ho4LnGuB5zcakMSGmAE4bV95vVZrRWPc0Vi4fp91pNTBCEqmp
 n2aR9nzhdkhpjPYbUr7BDv0QAAuYzvyaXhnC2CyK24JdQ7WXXtgNpqoUAX2QYssMS96D
 UlZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794915151; x=1795519951;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ah0q/JTuhX4xDVOrwkG1t5tUQwpt5YsuBa7AH/Yk8Vk=;
 b=kdRFzff4S+uqAaxnWXs6awkxpFukZinPITDiftoHkL5qTnySqDj4BqA6+xve5Vz/Tg
 /WONHKLJBDzoi0FcvgyM3PN78ovnAgqjMfNGAUdj456H+EA9louk88esXwvuCtkGHLdV
 t9h31kVFTWtiS1AvBery2GZd9ya6zvFVLPp2gimOEI+UPS522ycrcyxeZnjY51RSIv7D
 n11ndkAj/iIO7kJFsH8Z2zfJ3szfSUnKt8CzVrksjT4oc9l3Gd1nh4idWhfQbADKd5Au
 P7mL+2QsH0VuunBCIQOQwTiC3N52y9f8pAIjHCkZOnBVfO/7RxRFbYhmBta4Hroj6yVO
 cE0w==
X-Gm-Message-State: APuU4Z/fjnHUIu0eZ5hWZUoSSzeUfAQsYM4XdnKzPE1p07SYwckPKZnG
 jc7ngvy8BMH846LEpcxHOadjbkKwzKUeHx6vtfVi6TfcNIuyBPk7YgtX
X-Gm-Gg: AYBFou29ZazIfij53EA2TrttFyyZ6AWOVGLqYlCXRsW9II8sWPEbrz6j3Wqck7py1fM
 uaYAARmSJRPfGlqTGU2eMWJRAhAIz3yxmg3Ul2aRuSy0pTR7+zyEWbo4Slthl5R3Lbt7qciQN1Z
 aOlYlxioBxThaoUMk7s77rOwZPo5Tsiy6ZmqJ3w5kN+51sDXYgZA5fIlHfZA4rQ1MB49igm/g/e
 FNDrQ6N9iXGcqevHNcQZm7ztEcTcz2zyHOmvaBN304HWwv7Um589Xo/8NFiVnApf3oy3FgYh2jj
 Ww0hBqcTRScsyySNUmIATl+WtbXc45zFcp3qOMTrKw9fvZeqBVMvk74g/IbaQQ7cw+NfTLnDud4
 tYjsqJSIQGuXM4QlacCrT3nLelmYzcrGIq4PowLN62DbF02iJooTV+kNggcLX2WW/R1CUmnxj9t
 WCyCqzB1xs0eN2Tblu2+uLmmgvtkfYfIIuWk0MY04/Xd/ZspM3YcAkNV5NU+CKc/SgMtP6hK0LQ
 EgVcCORy4Fx2TvXyjM+N/5fmJfdupVGXo3Kxl9cAtCw/UqL/EeHv9ZZMpc+OvjWcHSf3RkYcnib
 vBCsPbzdse22bpmWHTLWfexNfpkdn+FPdHfJ1k4xfQ==
X-Received: by 2002:a05:600c:8b34:b0:4a2:1364:252a with SMTP id
 5b1f17b1804b1-4bb559f7039mr282186425e9.3.1794915150911; 
 Tue, 17 Nov 2026 03:32:30 -0800 (PST)
Received: from [10.111.176.198] ([2001:19f0:6c01:2c43:5400:5ff:fef6:1b30])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a4de4cb1b6sm1908215f8f.3.2026.11.17.03.32.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 03:32:30 -0800 (PST)
From: Oarora Etimis <oaroraetimis@gmail.com>
Date: Tue, 17 Nov 2026 12:32:19 +0100
Subject: [PATCH] drm/fixed: use fls64() in drm_fixp_msbset()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261117-fixp-msbset-v1-1-60526519ae2d@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXM2wpAUBCF4VfRXNtlnIpXkQuzDUY5tAcpeXcbl
 1+r9V+g7IQVyuACx4eoLLMHhgHYoZl7NtJ6QxzFOSImppNzNZOS8mayIs8spmSpIPCP1bGfv1p
 V/9adRrbbm4D7fgCm7wGSbwAAAA==
X-Change-ID: 20261113-fixp-msbset-5965c14bcb9b
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Oarora Etimis <oaroraetimis@gmail.com>
X-Mailer: b4 0.15.2
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

Replace the loop with fls64() on the value with the sign folded away.

Output is unchanged. The loop runs once per bit it has to skip, so a
channel value takes it about 47 iterations and 347 executed
instructions. The replacement is 6, and the work is one bit scan: bsr on
x86-64, two bsrl on i386, clz on arm and riscv.

Signed-off-by: Oarora Etimis <oaroraetimis@gmail.com>
---
drm_fixp_msbset() walks from bit 62 down, one bit at a time, to find the
highest bit that differs from the sign bit. fls64() returns the same
value in one step.

In the other users it is only called a few times, so the loop does not
show. In vkms it runs for every channel of every pixel of every frame,
and a channel value is 16 bits wide, so each run starts 47 compares from
its answer.

  Link: https://lore.kernel.org/20261108-lut-v1-0-f762d70ae4cd@gmail.com

Fold the sign away and let the CPU find the highest set bit. The range
drm_fixp_div() shifts by is unchanged, and the output is bit-identical.

Counted with callgrind, gcc 16.2.1 at -O2 on x86-64, function body only.
---
 include/drm/drm_fixed.h | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/include/drm/drm_fixed.h b/include/drm/drm_fixed.h
index 21d822aeed55..7dbe89ca30c6 100644
--- a/include/drm/drm_fixed.h
+++ b/include/drm/drm_fixed.h
@@ -28,6 +28,7 @@
 #include <linux/math64.h>
 #include <linux/types.h>
 #include <linux/wordpart.h>
+#include <linux/bitops.h>
 
 typedef union dfixed {
 	u32 full;
@@ -121,13 +122,9 @@ static inline int drm_fixp2int_ceil(s64 a)
 
 static inline unsigned drm_fixp_msbset(s64 a)
 {
-	unsigned shift, sign = (a >> 63) & 1;
+	u64 v = (a < 0) ? ~(u64)a : (u64)a;
 
-	for (shift = 62; shift > 0; --shift)
-		if (((a >> shift) & 1) != sign)
-			return shift;
-
-	return 0;
+	return fls64(v | 1) - 1;
 }
 
 static inline s64 drm_fixp_mul(s64 a, s64 b)

---
base-commit: fc72cd52fb284f3707fa36a68ea5a22543a51d71
change-id: 20261113-fixp-msbset-5965c14bcb9b

Best regards,
--  
Oarora Etimis <oaroraetimis@gmail.com>

