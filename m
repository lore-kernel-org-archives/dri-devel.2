Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97A5DC43327
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 07:51:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD27710F1C1;
	Thu,  2 Jul 2026 07:51:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aHHBDDYW";
	dkim-atps=neutral
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com
 [209.85.208.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1400610E3F4
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 23:42:55 +0000 (UTC)
Received: by mail-lj1-f175.google.com with SMTP id
 38308e7fff4ca-39b011ae0b4so10814411fa.1
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Jul 2026 16:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782949373; x=1783554173; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ycdmV2nQEP91NkF/uwFJLP2QOp24ehuy24vYh15fuUM=;
 b=aHHBDDYWA0dhNJ6FyCsGsXo4FcaBNE7o78D3IjYOMrqeaTu4Dznfamwx5zmmMtNH4R
 S+pGGBrHF+/wNOTOz5ZnsLoardiMumvFwQ8H2DXSwLmwZ7nHVe+xADMwwRsTaol4mX3X
 Jb2vVThtlzYFjBg7HRGHbrwM3fuflF41G7Y6iRlS0NS4wUxpy3kIkax7FHj5ou6GgA9+
 jpuLHfKtSxWwtk9N2pj7uwoDcCdpXhAVPEEV3tvgvv39m1lXS0XPRUkwMa4ZIhFWMuKN
 tsYET93auET6MRf+zL3hnvFZ3XBH1yLg9Qcp8cnRmWHT60YJXFXc50Ydp32k2yCdMkE8
 QRYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782949373; x=1783554173;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ycdmV2nQEP91NkF/uwFJLP2QOp24ehuy24vYh15fuUM=;
 b=BzPM5n2XsNxDhwdoPEbT3Wyli4fsfdb+3ZmB5NRVm6g/mZEPdgQynyaStxVikimg/C
 6w/yfZgdXs2WBzTNK0P3IqEeMUoQHzsa1Ps1nOfjJM8SqC7JNFkIoUFF6M8DgVx45Ezh
 JHQV+XJQqQYl03clkOsA1gTj46VliHJpZN1vZDOThUMbvERaPyvbLruOCJjNhJ60xyBV
 xSjXCTJtwG0IHDdPF8h509gN6lJePr4IZFL4akSpjVxXEwa3XjeJ7MwP7qphQ2O/hA0B
 LKTnIoSRkuFhc3x/nA+GhRU0my+Gp/iGbVWoIhk6AModo8CbjE9rptGIrG4P/CpzIdTO
 Ynuw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrVhDpPY4k+2FYVvOXnlvlUUetAnMJBGmZzdMW6bRfHOFqWvwgr7PgI/s5FdS4S8Mcs59G5eFAuh/g=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz746JBJIL833MlPyo4e8g67XS4l1Xr6LzmuR5GVKauYfowMxR4
 BJFNFQn/Po1iQRcZb73LRMLC6XkR/lIqoKUOGeZm4+Xl3pOL3mCsRAUk
X-Gm-Gg: AfdE7ckOSLYyA4J/n5k9wjCnmzH6EB+PDlRuFemku5TZ1cm08x2iCwxvlFaDeeTlIO4
 MuM6orGtQ3a71RX2mjuHwAz4fGe3Y6inm51SUvVyRSMDR2qOVmf3QtXjx3qnAwtoBgvuh0nzlEz
 rvv7SRWqiL74E1XfIqeUcDGl3BdDyeHnVm17DSw9tICqQ5CVc257PmaqXHLgVzIlKRY7cLDDrj0
 mqJHKr5IW5vUB3Pba/FmveVktGyr+w5rdQdQ4nuQMlJnTxalDz9xDPqR12O5CaCyamCStNDZsMg
 Qlj566v5XNC5PolDSW/aFQ4wGsrR4aQWyv7M6szHi7Tgw7QlIW4fTJ92y8r8zvvIYGaxeTX7+1d
 xjTWZWb0aomOeCRkLpPSvIYZ5htyyn3W7xLozoC3H8bWQn63sOrfJ7Fhv5CjUApHNKCBjhldXPJ
 Gpi6E1OG3YrKjsZ6OE3GVi7G+OOal1Rxo=
X-Received: by 2002:a2e:9e08:0:b0:39a:e29b:9a2d with SMTP id
 38308e7fff4ca-39b34102c99mr5958141fa.39.1782949372729; 
 Wed, 01 Jul 2026 16:42:52 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f9:2a:1c13::2])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-39b37fda160sm2836261fa.29.2026.07.01.16.42.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 16:42:50 -0700 (PDT)
From: Melbin K Mathew <mlbnkm1@gmail.com>
To: deller@gmx.de
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Melbin K Mathew <mlbnkm1@gmail.com>
Subject: [PATCH v3 0/3] fbdev: fix mode sysfs lifetime and bounds issues
Date: Thu,  2 Jul 2026 01:42:45 +0200
Message-Id: <20260701234248.236023-1-mlbnkm1@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260701231706.234715-1-mlbnkm1@gmail.com>
References: <20260701231706.234715-1-mlbnkm1@gmail.com>
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

This v3 adds a patch to clear fb_info->mode before deleting a
videomode through FBIOPUT_VSCREENINFO with FB_ACTIVATE_INV_MODE.

Patch 1 bounds mode sysfs output so show_modes() cannot advance the
sysfs buffer offset past PAGE_SIZE.

Patch 2 clears fb_info->mode before fb_delete_videomode() when it
matches the mode being removed via the FBIOPUT_VSCREENINFO ioctl.

Patch 3 serializes mode sysfs access with lock_fb_info(), including
store_mode(), show_mode(), and show_modes().

Changes in v3:
- Add patch to clear fb_info->mode in fb_set_var() INV_MODE path.


Melbin K Mathew (3):
  fbdev: bound mode sysfs output to the sysfs buffer
  fbdev: clear fb_info->mode before deleting a videomode
  fbdev: serialize mode sysfs access with lock_fb_info()

 drivers/video/fbdev/core/fbmem.c   |  5 ++-
 drivers/video/fbdev/core/fbsysfs.c | 59 ++++++++++++++++++++++++------
 2 files changed, 51 insertions(+), 13 deletions(-)

-- 
2.39.5

