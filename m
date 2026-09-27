Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6247DC98324
	for <dri-devel@archiver.kernel.org>; Sun, 27 Sep 2026 05:13:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95CD410E171;
	Sun, 27 Sep 2026 05:13:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dJcfK4lx";
	dkim-atps=neutral
Received: from mail-dl2-f36.google.com (mail-dl2-f36.google.com
 [74.125.229.164])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7754B10E171
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 05:13:00 +0000 (UTC)
Received: by mail-dl2-f36.google.com with SMTP id
 a92af1059eb24-14373bcc010so1798240c88.1
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 22:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790485980; x=1791090780; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Li1CFbWIegv8mAz9zTeIVGn7vrMtVUxmg53aaPsA4qQ=;
 b=dJcfK4lxvRom5VrfEiiwfHtUsISnRxTUHvlK9k83oJAquQLIqo74EQyV3MOPGhXiFk
 O3ocxrzfNAf2/XCU1p1jM5xMu/YbyEAekBNg1EDxvjxeR4PYRNMM76AzfaGjpxAaVzIn
 TiY/1ZQp0Zei+qPX1uEc7Zuulvh4nfP/KOOueVxFrUn/3uHwXG0S4vd3dFY9xHzk22Vq
 EzuKCQLo2b87xRcAx+wqQ1ziKthvANvJZ7PZcfW8oEGwTi5VGD8xiR8Uzc6VBBnniz9W
 KRIKVSFLe7udaPOZSfZ6TPOkd6uwbVWHx4Q9SAMpNFYnOpjp7+hJRSphV07fzC+HuNwI
 3ohQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790485980; x=1791090780;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Li1CFbWIegv8mAz9zTeIVGn7vrMtVUxmg53aaPsA4qQ=;
 b=ZJKivc+78tMEpxB1mWYh9IEpg1LYgX9+yJQI8zRcJC7MSf9Hcr6bzygx1eBTBdTKEn
 Nj/LehDuUgAsnlfanA+u7SgntjStO+gR815Hqc9RepXHyCRFumHirvkKJVRm8NTj/59E
 8pjCXUS0D31JHEPbFmVYFM9U96FK5jFgyLJw8/50UI9IuWOObpC/QfSigqA+FqGn5PqL
 Bpuzlf1lvLNivnErD/M5tSg8uCLPtzWWL7qPPIbrHrHYnqgsWgoMrDNhyGWBw4xLm6jV
 7qngtapmdY3N4rzn85VGx5Kkt5w+qC2uypAYW4Ak2RBX50FiZt8gfjqQ9fCHTDTG7xzj
 pICw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwbX9InxwJUVGjYRKnPcl56COQLQvNHPXd8O0L/ny1ZMv474DD+onhqrgI9WylEQCqsHrnrutgRHAI=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lALkZPPcAUE9w6CGpQtm7S1fTwBtKEB1pRcV9qbuPT5u6+EyPI
 KWduppnyAKWoKt/o4aedJmZpKV3csf6ur4fccy2fIdOKNmYEfu+Vl2zC
X-Gm-Gg: AYBFou3X7cnIe2RQjXPWQUc1u8jH4YPmsQzxvQAg7Zam9AacM1wwy1j1qw98wYldWHH
 YWW17BjFl9JdiHZeX363Vfan42o9cXzAeWHiRApoEIfYzXyhMpLO3r5uWldAR9dWJY6wPiCiuCI
 efaISdAzvp+rNu6cDaQC/Izmu/4hFey/MLXY5i/zTPRqw0pf5zCVDcDUGyCLIv7ETCAOBXUlUn9
 5w+kL5+lPi3Sf/omYGk+Al9vfzOsm6tulyR3pZhKHHr1S+7Htk5zbb3R4krCqHpy3yj4W2wObvu
 d/urOkv5ltLtq9XYQtTJ+uzl2fM4IBc1DegtSnZsn6Cx6/cHgHX00QkLEiBzPs3qIyCW8q8NfJk
 fSe4wGVbzYHnbZtaRS3zImPVU8T+g835V7YJgjZN1I4ao2EpbScsElbErhdYg3yQ3xAt+LoJ/Hl
 5LLZGN5fdkkG5nW4KzIh4dHymWy3Mg0TtFgXYY+JlE8z1ysZQXdfeySOcm9iZzAit/mx+WxWsKa
 OkmgxWI9aoFOHUfCBkcrNLIvEXsuyswf4e2psOpIqme9Q6d4QuTLahZ/tsm8Vc3DJP613NPITde
 SoOHpfP5u6vpT4dn/EKcVbJY4FTVXLCUFPiJu3D9v/mvTvzSEpLa4DoyLKM/
X-Received: by 2002:a05:7022:ba2:b0:143:297d:21f6 with SMTP id
 a92af1059eb24-146d0497c6cmr6882989c88.35.1790485979436; 
 Sat, 26 Sep 2026 22:12:59 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-145aa0cb7bcsm14790970c88.2.2026.09.26.22.12.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2026 22:12:59 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH] MAINTAINERS: name the deller/linux-fbdev for-next branch
Date: Sun, 27 Sep 2026 13:12:56 +0800
Message-ID: <20260927051256.2752154-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
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

The T: entry for FRAMEBUFFER LAYER names deller/linux-fbdev without a
branch.  The repository's HEAD points to branch master, which mainline
already contains.  linux-next merges the for-next branch of this
repository (Next/Trees).  Name that branch in the entry.

Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
---
This is part of a cleanup of all T: entries whose repository HEAD is
not where development happens: one patch per repository, sent in small
batches.  The plan is at [1], and why it goes out in batches at [2].

[1] https://lore.kernel.org/all/20260924033200.3615554-1-matthias.goergens@gmail.com/
[2] https://lore.kernel.org/all/20260924101844.2403008-1-matthias.goergens@gmail.com/

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 140eafcbbd78..b275a2254738 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10339,7 +10339,7 @@ L:	linux-fbdev@vger.kernel.org
 L:	dri-devel@lists.freedesktop.org
 S:	Maintained
 Q:	http://patchwork.kernel.org/project/linux-fbdev/list/
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git for-next
 F:	Documentation/fb/
 F:	drivers/video/
 F:	include/linux/fb.h

base-commit: 62f4c998b297cf233997a2b4cd6fc2d2df0319c9
-- 
2.55.0

