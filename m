Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11EA9C531C9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 17:26:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3648A10F445;
	Fri, 24 Jul 2026 17:26:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="D5mx34g3";
	dkim-atps=neutral
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF4E810E355
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 17:26:26 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-47f96c5b722so512767f8f.0
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 10:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784913985; x=1785518785; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ohKPnFyz+LLapn/ZZQ/A2iwQbIU5uk0jaD/t+e7o7KM=;
 b=D5mx34g3AW1BOdouirpfcmzduSD93AWh1FGZH8Cu+jtkOtxm72zLSypSK8UEg0U8QR
 EvpnKJ3xPc+boSS9s9upqnMhkjSmYUEsQ4G5Jle1MNR7FhH4myQuQY/Qzjlqe/OMgEeR
 mG9cQglg+V7302FbXxvUol6x/i8MwaulutqyLEN70KUdcH6reolI+QJE2PZvhMqR/Pex
 NnjW4C/mKyWiIvhQ4bPsa7FSqyKBJO/P+XZBB+ptGPt+IopYhSyFC+KiBloKPgcRM0RF
 n3GZ3/uab/UqCDac6NaPpGmxjDJBHr8kWxPY8ZeSxSXu+bUeP9Hx5Tanm0ps3MLSwMqC
 qM6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784913985; x=1785518785;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ohKPnFyz+LLapn/ZZQ/A2iwQbIU5uk0jaD/t+e7o7KM=;
 b=p969okQZg3TmsnfaiSQF1wTBG+0fZ9Jnig8p8VEMBP1ygwY+jHiHKyUqLXLWbfVFki
 fucxLbHzTTYw/ZbxT//3JtxIa9JP5hfc3dA+lfWdeDzIIVuIyof3BgzaTXZbyDqqswQF
 HT1KjdYbjVPn8MKLCs5vCagMWKs92NxIkPJuFZXlcw6bu9Ha6btOGo89T/Z05oCZRKIV
 1ko7wh9j+HWEyusiJaS9Q9fjCofXpzk1P31Fj6XRtAKoAXA21NSXCj7sn0YEFp49rnrr
 +2qEwfK7la86opVsTffsOGyXjFdbbySGCgrt9ASe+zRSttyhDjzOw6OATmrGbDZLRBZq
 li+Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RpQrP6Id1n5A9cwfDrdDeODgD3EbqmyiM9WuafSySQkp/Ir9OPXBUR0SmbLEFD0VZIWY/7B3cwlw2w=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyVxPbbXI3ifpB6dmBpJExAtQF4CL5uhu7T/4D0clsOXO3DcxZj
 iIRvr3UPXL4zuTzV8sR1t4LKdYgEUevC5kz3L5JhMPm/dFaUSFaq3Wh0
X-Gm-Gg: AR+sD12L4/iVE/0jpSt68S6QGWUmQvlxK5trWxeMRopwj3JXyVYr3HJBDNWW2PCIJjj
 oSKFJcSIBW11dllwmLoCIpSdNZkvVSwR+llT1ph7xeobmLgF6PAVLmM4hlpl+ZW+iYY8FOrUGBq
 WEjJBOF47wNvw8o5qKbNygCZM4VBcbCKOb9fgOJnlcUaBa7v9tzgYIBXvANA+VQ/zIMbB1qn4NW
 5QFrdT6c3+Dre8uDEXMgKF3aAcCn0Ah2u+BLoBZ/Tu1MkEZwdUI3ozpUeaSCfL3Hyu/prrsyznv
 zedR/KooyPX9249Dvo/jqyqWo+PrDoq1axaLGJz9TQCBXwjJTWSAetfITZPP5telxKOgdu0lD36
 SPUw2hcB2lAVvX4SBCuJeBihf1gjDkWgKlfsidDi5E33z8HA2RxAGhO1eZYMROfjB+DqC4TIkfe
 i82nZ7fqu+KvHOX/A7XvMkNx+2OdZIcZPItWgI7C6DWAQvNNc36Q==
X-Received: by 2002:a05:600c:468e:b0:495:7a36:bf5c with SMTP id
 5b1f17b1804b1-4957a36bffbmr59403685e9.10.1784913984948; 
 Fri, 24 Jul 2026 10:26:24 -0700 (PDT)
Received: from osama.. ([2a02:908:185:7e40:f13b:d8f5:8fee:f758])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496b4858e28sm5411665e9.2.2026.07.24.10.26.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 10:26:24 -0700 (PDT)
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
Subject: [PATCH v2] drm/panthor: skip zero-sized firmware sections
Date: Fri, 24 Jul 2026 19:26:20 +0200
Message-ID: <20260724172621.63046-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <c31aeec2-6336-4dad-93a8-982e3f4c525f@arm.com>
References: <c31aeec2-6336-4dad-93a8-982e3f4c525f@arm.com>
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
VA range is empty. If such a section is added to the firmware section list,
section->mem is left as NULL.

Later reload and unplug paths iterate over all firmware sections and
dereference section->mem, which can lead to a NULL pointer dereference.

Zero-sized firmware sections are valid, so accept them as no-op entries but
skip adding them to the section list.

Fixes: 2718d91816ee ("drm/panthor: Add the FW logical block")
Cc: stable@vger.kernel.org
Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 drivers/gpu/drm/panthor/panthor_fw.c | 4 ++++
 1 file changed, 4 insertions(+)

v2:
- Accept zero-sized firmware sections as no-op entries instead of rejecting
  them, as suggested by Steven.

diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
index a338c4f0a7f5..66d9f5947af0 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.c
+++ b/drivers/gpu/drm/panthor/panthor_fw.c
@@ -601,8 +601,11 @@ static int panthor_fw_load_section_entry(struct panthor_device *ptdev,
 	if (data_size > section_size) {
 		drm_err(&ptdev->base, "Firmware corrupted, section data exceeds section size\n");
 		return -EINVAL;
 	}
 
+	if (!section_size)
+		return 0;
+
 	name_len = iter->size - iter->offset;
 
 	section = drmm_kzalloc(&ptdev->base, sizeof(*section), GFP_KERNEL);
-- 
2.43.0

