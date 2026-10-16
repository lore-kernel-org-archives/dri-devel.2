Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B64FACCF2C9
	for <dri-devel@archiver.kernel.org>; Sun, 18 Oct 2026 14:54:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25DAB10E6A5;
	Sun, 18 Oct 2026 14:54:37 +0000 (UTC)
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEE63112734
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 10:16:03 +0000 (UTC)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-35cd4e8bdbdso8303054eec.1
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 03:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792145763; x=1792750563; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=EkQ2fSP0Uv8z7vsyAAy4/OpXnLsDXMhIw27wTwsr6Bc=;
 b=sQFUAF7gfQwLJheg9FZ/8Me9kKwOzITcdvuRVpucQy/pyTIlb3KBznDfgGKl8LPLFZ
 t17dkivjJMZNhzJIWjK6CXKFU0r1d1t2b8n6yhqDE2R3T2NG7tluhaFOK0hX7y13xOxN
 OM0UkSYZwZqzqquNNzFkTUtKHlEG1diC1URPU6YA6UCF3NHqxqMaf5SRPRDxZbE5A3i4
 9SiQApwo/emV09oR2K4TQ4/figyL8W6/sxFuTSx0ToGiJCZcG9e3kdRqO/4o/guPQCCx
 hVPlN5uowuNkzI75ProayK1rBTFjlzmV/HHHJ3VcpaRimjTs+IX3G3cLFsXqvJwsXKNJ
 tFtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792145763; x=1792750563;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EkQ2fSP0Uv8z7vsyAAy4/OpXnLsDXMhIw27wTwsr6Bc=;
 b=OSiC5ArwPto+kEYHHiz7TsDME3c5PiXPyONS8YuWATsMTa1yM1Fl740idy0NWES26A
 vSyuPdCGdw3Rmd8gRgGDOTgt/fXV0MZtxS3qmtCIYZRCjuXLxs+LAo2fTVkzrz5kxrgV
 A1b0MRM26D1Sw2XxupAKm3/0Gni7HitGd7PWLi3TnOhHU8U75zMx2OJ/sLJheeHknlRk
 Zgxc2dtevPAO9mFoGV+4SNa7gAvpGS2NCi3TDsLkN/sOpibK4itBFz/rUrOceIukJ37f
 bTqDCX8SpVuXowguQE/NKtdygBb8Ezbgkn8UlSp9AwDzzRf7RG6eTrL+qQSubKQL1HP9
 TpIg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzb+FEZsnxNzNqfTAUywuPUmWEErWv9XAtj/xNpzGSIyv6hGxul7pM07hrPMv3X5OvvZryAAP7YTBU=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKU6tAoWMHTin0lohw+khymT0orQhoUegqX1oExklFbsmLLCOec
 3y0AmJisiVazumjmT/dGNIX2K2QnzmzxaVAnmnqG78saAAyDB+9JJn7k
X-Gm-Gg: AYBFou1cDY+F4q4H6ZfFd4VP8SSOJ4mG7zn3u08+JVq0sYtyqr62n8D7bId8I0KRatg
 LuWEHIynWG83Xs6WpywJ4BUf2tyegAiQfYb9GmnFPK6kDwi/Ta8/QgncwK2Y/Rb+gEz/SFKYZs0
 17noFFL2t8XArXs6zemqHK4qmoJ9DHF8fhbvg0KEyHbhKOjyXl0pAcjmOV131JoaNHz3Xzaa1os
 VltWrBsGyaa8I5PZ4cLKj3RcG10+KI81ejDPRbve9bqBr01zyy3tNm38sub9ajV8LMdwk9Qux6T
 qYsIsjEsAh+khJQRM41MKsZl9JNMdcWg8nSRNpnFsn8HnO2HvWE2rPMA2c5wco2bOf0yPO9YTVP
 D5CisIXh4MsT3sA3KCz3TE3cdA//sO56oCzuSBQ8WrzGgTTKuFaFk8lc/MAp9lUZdEISWMqGSlR
 hVvwm0lrn0/q67LXFpv8DipJx8Kioq79Bv6q41r1igux2rL1GcogczjufCvSHq+N/wXOJoWcCT4
 qaYyfkWQ8t+8fO/M0HKra0Jg3k7FN/fPUmwwKJPRxuXxCmpBiv1aBAE4l9sonSIAnb6AoEt
X-Received: by 2002:a05:693c:60d4:b0:359:2f0b:aa89 with SMTP id
 5a478bee46e88-3592f0bc083mr26553110eec.10.1792145761800; 
 Fri, 16 Oct 2026 03:16:01 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:301c:f8cd:1467:1666:71b7:b993])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3608308a87csm9389619eec.28.2026.10.16.03.15.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 16 Oct 2026 03:16:01 -0700 (PDT)
From: Aryan Sinha <sinha.aryan03@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Tomeu Vizoso <tomeu@tomeuvizoso.net>
Cc: Oded Gabbay <ogabbay@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Aryan Sinha <sinha.aryan03@gmail.com>
Subject: [PATCH] accel: ethosu: Fix kernel-doc for
 ethosu_gem_cmdstream_create()
Date: Fri, 16 Oct 2026 15:45:49 +0530
Message-ID: <20261016101554.14231-1-sinha.aryan03@gmail.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 18 Oct 2026 14:53:13 +0000
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

The comment documents an exclusive_vm argument the function never had, and
leaves out data. Swap the two so the list matches the signature.

Signed-off-by: Aryan Sinha <sinha.aryan03@gmail.com>
---
 drivers/accel/ethosu/ethosu_gem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accel/ethosu/ethosu_gem.c b/drivers/accel/ethosu/ethosu_gem.c
index 9afe2549e..2b89f70f4 100644
--- a/drivers/accel/ethosu/ethosu_gem.c
+++ b/drivers/accel/ethosu/ethosu_gem.c
@@ -712,8 +712,8 @@ static int ethosu_gem_cmdstream_copy_and_validate(struct drm_device *ddev,
  * ethosu_gem_cmdstream_create() - Create a GEM object and attach it to a handle.
  * @file: DRM file.
  * @ddev: DRM device.
- * @exclusive_vm: Exclusive VM. Not NULL if the GEM object can't be shared.
  * @size: Size of the GEM object to allocate.
+ * @data: User pointer to the command stream contents.
  * @flags: Combination of drm_ethosu_bo_flags flags.
  * @handle: Pointer holding the handle pointing to the new GEM object.
  *
-- 
2.46.0

