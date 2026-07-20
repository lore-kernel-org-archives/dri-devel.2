Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE661C44520
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 11:31:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F88510E8B1;
	Mon, 20 Jul 2026 11:31:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HjRDzRFE";
	dkim-atps=neutral
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 860B710E8B1
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 11:31:06 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-47de0093c42so5336033f8f.3
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 04:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784547065; x=1785151865; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Kk/EdydNuPaevf5JbgU06sHPzz6RMAwoT7HsixFynpc=;
 b=HjRDzRFE5Ys0pkA6BHtvvP1Th8hHMIG+CRv9HeL1Vdj4pAPwDMU8/UdgqqbhVMjThl
 b8UIvm8Ja+sf9PRwC6111jMUC5eAn4XmvItvnEOZ02E/bJ9UAkfYCZjEfVALl8FS+SKw
 4+6PpACykKJ8Buj9CygUh68LMTALZ5aa/08HqvL7ZrnQEXEv5yrhOHK6l9tn+RIvUck2
 t9yN+aWbwrELzF18IrxGKK/Fn7Y4Kf2WTZ6Z5mDpbaXCEjDfI82bV08zJZBLiEN6tQCs
 cyJgu+eR0Eh2UBl9vHvVB88o522bACnr9Xb95lo3CiXVOLs7Wrbi+G2tUwlPSUjzy7cT
 pK/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784547065; x=1785151865;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Kk/EdydNuPaevf5JbgU06sHPzz6RMAwoT7HsixFynpc=;
 b=sXEugMmZwApyk0+bAFB+ue7NRL+OpuF8O3fV+L+EvNNe0RjfkE+ag4zI2D2nezHFB2
 OBHSOSaPcxG7k1e7N/3AlHn3UkPcij2wvFmPieS8y4ZStyJ7PHKc+/hh0nvcfEv7S/uE
 tTAS7X+pEXZU1bBG5+rs67CdNTHYocT7oUOyqg6NUjmwT2MMbj6n9bKadwjdE1UZGy83
 U0WqwsElRTEqIoZM+RiYctYOBv8M+DoyjFbqur+VC8CcJMcrDUGhaW7Zp0/B3Y916YAJ
 Kv8+FW8hx2R8sLAj+rckXh0wCLOKXSsl3nnNn0Chk9OoaYh1Ntf6QLA8iXBpevHDhNk7
 PbOA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp8gj9zyYhCzLGgP96Aom+RyeCNtBKQOBwIGG0/UJCymGMoWb5fF1f1b2opS8G0iO4AQ6TxuAr53XM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz9mPYSj6MKeniiLTYgz2BweGrxXZjnvWAyTj3YZIsIb0N8fsGW
 YJ+mP1gAvvVaJJ8H4LiKWA3w/xyN8XQ/vJkxGufPnJBWk/0QMNCPyhn1
X-Gm-Gg: AR+sD106L0yGDdJyADUcScf4d+U2dj6Q414pw1jiuLJTBkp0s4gXtgzW4HTRt10yM0x
 gKGYUByjPrljbvCKXfGgLZByey24kX6CWQ4kSJvBAI2+necWiNwBmSTHBRy0ormS6sZaQ5Ev84A
 a3cX66IyA9E3vBUxJAxUbLCdbjL8hE/8iwRKR0CtwT/6e+/n9GwlvWq2z9FCN8OuKnBkUC8l8rZ
 JUJopnn8LfD1WEX1tWXZjw5TPf9sTyZH/OR4nKgBygiWXOr+T5MgGbXlWyyo1Lj8V5mxjR24vCH
 f6bnkOOJLeUcjH7bXZBzygVEeytvzK1jmaTH9NJ5lSqQhESoXFH2Vjbi/ulM8RY0JLHg8cOMLgX
 YWpnLlkUIlDF7xuytLZ9YJ1sUu86IuPlrZyp3Pi75FPVGhFiWB9D1Xqt+UdpY8ThIBgzOGTYAlb
 MRjrLwetXvBc6lEFWGpw9IiAXrZzlcaSS4Le6+bw==
X-Received: by 2002:adf:e192:0:b0:47f:5710:8cad with SMTP id
 ffacd0b85a97d-47f622f2a3fmr14665764f8f.4.1784547064514; 
 Mon, 20 Jul 2026 04:31:04 -0700 (PDT)
Received: from osama.. ([2a02:908:185:7e40:a26b:a888:7408:fac])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63ed1911sm31098429f8f.22.2026.07.20.04.31.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 04:31:03 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Heiko Stuebner <heiko@sntech.de>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/panthor: reject zero-sized firmware sections
Date: Mon, 20 Jul 2026 13:30:23 +0200
Message-ID: <20260720113024.11619-1-osama.abdelkader@gmail.com>
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

panthor_fw_load_section_entry() skips BO creation when the firmware section
VA range is empty. The section is still added to the firmware section list,
leaving section->mem as NULL.

Later reload and unplug paths iterate over all firmware sections and
dereference section->mem, which can lead to a NULL pointer dereference.

Reject zero-sized firmware sections before adding them to the section list.

Fixes: 2718d91816ee ("drm/panthor: Add the FW logical block")
Cc: stable@vger.kernel.org
Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 drivers/gpu/drm/panthor/panthor_fw.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
index a338c4f0a7f5..6335893d3f16 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.c
+++ b/drivers/gpu/drm/panthor/panthor_fw.c
@@ -596,6 +596,11 @@ static int panthor_fw_load_section_entry(struct panthor_device *ptdev,
 	}
 
 	section_size = hdr.va.end - hdr.va.start;
+	if (!section_size) {
+		drm_err(&ptdev->base, "Firmware corrupted, zero-sized section\n");
+		return -EINVAL;
+	}
+
 	data_size = hdr.data.end - hdr.data.start;
 	if (data_size > section_size) {
 		drm_err(&ptdev->base, "Firmware corrupted, section data exceeds section size\n");
-- 
2.43.0

