Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC6F0C43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 07:51:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E007710F1C4;
	Thu,  2 Jul 2026 07:51:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Bu0Tn7yt";
	dkim-atps=neutral
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com
 [209.85.167.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C27D10E3E2
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 23:17:11 +0000 (UTC)
Received: by mail-lf1-f50.google.com with SMTP id
 2adb3069b0e04-5aea9d606f0so1074551e87.3
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Jul 2026 16:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782947829; x=1783552629; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BlV+b2hyTXngEK/PbvCEICZBOhLaT4J0DD/N8TVmLnU=;
 b=Bu0Tn7ytLHilxLpVYqQBPydXL4FYB7Q9qarpIENMYrGCZLoFHT1/5+ny6f8G52qKV+
 o1ZzLLYuWJDASZLwM7u1cnpq7ENFMBaOOtA86qc9uOGcC3kob37PY5RIH1v4oat/LnlE
 pgY1X20BmpTqGdgZ9mw/Km/iJhOWr6YVral8L2GvThu34Wd4cmH1PvspwZ7Pc2saYNtK
 rFhRPDYd00/Y3w3NzfkyCba4UpNVn3xJlQiKxb64dXV6RseLD9H+/+Z2FvQVjmyyEf2F
 NNhwy7Df+PuGlJG4uwCfllDflWY+wHmYD08oWuUqxctyvzlMy8I8VJf4n1ggj3mOkY/d
 dYNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782947829; x=1783552629;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BlV+b2hyTXngEK/PbvCEICZBOhLaT4J0DD/N8TVmLnU=;
 b=hWrH+GPCBl38exbI4i3QjIFMbMOcEpcnaAMFSStSqhB/KbN5ALxNu+XOyvUjviEuJ7
 FtVem/6u3p9970I0SUHP6E0P2yfuml736O2eY1F1wBil9kuQKcTKHeU5h2pLR6zD4SDT
 Eu+4CiplAlHglUpxnaPaurbfjA0jo5ALCByOylM+PqZSdkHEZLqFfrWkwQJ0jDoUbSUc
 g2WSurraetT7Dkz7Jarp3EOtupX1LkR3PR0POYPrtBtEVxypg8TNuW91TcpqbQcRfrUg
 OW2l+2AAFWwrbjNvO8hrIHe22hYv2kIAVWFVScAvqH9eV+44VltbrvJeVuniQj+jJp0H
 pPsw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqslIAXx9Z+SCCdPI4K5+8XGU7H3AhmyX4c4FOIOSZyE9AeqBmRdlsdTTdIWGUHsUAMDmPTeEBMkbM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxDuYxUELobSKR/+r0u6yC/MIL30EgbewDDhtVWnOpK1jNL0SYr
 G4HQyubUDs1SxIEivPTPWc5aJ0PdrpkO3kE1XHIK4Vy2QeTSz5C36aB9
X-Gm-Gg: AfdE7cnAoEjZxUhirLk77zk0GoGvY9k3+/y0g+2Sw4FWsL6r58oHCTT0XwSOn4Mf21O
 QGri36sGAuhpTNCNo3XKLuEyllhWtpG3Q5YGS7U6oo+d9aOmui5IPDaq0s7jW+pEDb0+x0WSI0y
 Y/putA8ZtL65gpk+fTkIA7SmJivXGr7F9z2TF1IDrGZBvxPGsAPFvY8BlsCNp7UpdE8G+M2Mboi
 3pabkqyfycibUt7CBJqf6u5AkBgeNUXnY38tc6YlmzrchiiSyBfp7Zr0hzmU5U5u8MlGLCckHWg
 uEYDs1P4TJ3H+dUopBGWQ2GgPS9ULildhW9n2H01U1UnShWPZQO10fkUwp2QWf1e68m321il5Lo
 49zSo1rfWhbZsLPF7abRsHkypoMqLU95FlS1gnHkfiDRDe47oUcpVdpDH60EnKrQndabmQ9R/5k
 TUfZmwavQj+UrXsQ8+ckSoz2fdM3Tzv8o=
X-Received: by 2002:a05:6512:4501:b0:5ae:b260:cf47 with SMTP id
 2adb3069b0e04-5aec6795b38mr793205e87.10.1782947828852; 
 Wed, 01 Jul 2026 16:17:08 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f9:2a:1c13::2])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aec8991974sm308950e87.4.2026.07.01.16.17.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 16:17:06 -0700 (PDT)
From: Melbin K Mathew <mlbnkm1@gmail.com>
To: deller@gmx.de
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Melbin K Mathew <mlbnkm1@gmail.com>
Subject: [PATCH v2 0/2] fbdev: fix mode sysfs lifetime and bounds issues
Date: Thu,  2 Jul 2026 01:17:04 +0200
Message-Id: <20260701231706.234715-1-mlbnkm1@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260701221757.231490-1-mlbnkm1@gmail.com>
References: <20260701221757.231490-1-mlbnkm1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 02 Jul 2026 07:51:30 +0000
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

This v2 addresses the remaining fbdev mode sysfs lifetime issues noted
during review.

Patch 1 bounds mode sysfs output so show_modes() cannot advance the
sysfs buffer offset past PAGE_SIZE. mode_string() is given a size
parameter and switched to scnprintf().

Patch 2 serializes mode sysfs access with lock_fb_info(), including
store_mode(), show_mode(), and show_modes(), so these paths cannot race
with store_modes() while it replaces and frees the old modelist.

Changes in v2:
- Add bounds handling for mode_string()/show_modes().
- Extend locking to store_mode() via activate_locked().
- Keep show_mode() using a stack copy after dropping lock_fb_info().
- Avoid overclaiming unprivileged impact in the commit text.


Melbin K Mathew (2):
  fbdev: bound mode sysfs output to the sysfs buffer
  fbdev: serialize mode sysfs access with lock_fb_info()

 drivers/video/fbdev/core/fbsysfs.c | 59 ++++++++++++++++++++++++------
 1 file changed, 47 insertions(+), 12 deletions(-)

-- 
2.39.5

