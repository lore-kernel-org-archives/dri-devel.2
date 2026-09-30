Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B21DCA5FAC
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 12:13:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1449C10F361;
	Wed, 30 Sep 2026 12:13:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="F0FJz83Y";
	dkim-atps=neutral
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 390FE10F1DE
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 06:59:18 +0000 (UTC)
Received: by mail-pj2-f13.google.com with SMTP id
 98e67ed59e1d1-396ccb65437so2941050a91.3
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 23:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790751558; x=1791356358; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gnkiJ0/c9WOQ2H9znsdbaGBhfqk/SIJ50HBt6f4ERZ4=;
 b=F0FJz83Y0rDbaA885adKem4fzUKjR0sH5J2Y5+vA3oNJMcAUjzbIQR/itixFK/np5B
 DDFAHBHkUCIfVkktcyI1HL1uarr2+0kl251vNf5pH9jZwLNbUM6mMuXKonwu8i8M/QWB
 uj7qE5znRN2TGa8fRc6fIDnR0FP4x6jvRunmnI4/N4LUYWlqWaoI1ruth5LFj1x+6RNZ
 Q9OzDEQaAupfSo41vSjdupy1mIBMocW1DlKuSAeG/gGDsW1tD5M0M3N3dvMRNi/KSHTv
 SOcJeFmzCzDLRfocGN61SZbEUE88gZ8+ElkFLchmrl74UUkZ2v1s52cY8mocUoOiYIKU
 sVwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790751558; x=1791356358;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gnkiJ0/c9WOQ2H9znsdbaGBhfqk/SIJ50HBt6f4ERZ4=;
 b=LD4oELvbMQysBWYig7AWaXzQEa0zIVKPePepKzkRVT9+KMYz8aqoT8S3iLW6IrjHGq
 4ujPGv1wokfR160//2jSkrcPq6iWcttOEp329amRLd5Izm3ZvYj2GTK8MbByDf/30qHh
 z0BhV2eMvU2tMxc2xra+n9jtWrVeEFQgArlBc3IEhP9SMLpaOwQfNfYisY8Rup/SmAup
 kVfcU5s3b7L0uJIyRH1AWUdt2W6eU9WiGDDPWG4gX/gUAFokf7AKjZ/liso767KtScIe
 do8AB50e9TikaMuMWT777YJQHza3Mz5S2HcoHKGqjswIkWgErrjsxhDtocH7H2TAVHeK
 vNxA==
X-Gm-Message-State: AFq9FYLK6vTKeqByOyQWAopjSA491sBoTR+mPHy1Jw6CDLlbn9qOOyB9
 jXqDok4iz3Vqv5qFS6MhdAmI32iPZMJ5gu8I1Oz9DSW7ioMIGUVEnP6xNehXdPFR
X-Gm-Gg: AYBFou28HpDN6ebsiViUmcRUADyCkmywJJ0QpWIABMpendLHdMEXk+xvbi8SbURJBTn
 wM2d9ehtmc4RyUZN3seYU8CSLeZnPSblIOl5anR1Mf9GKM32rGshxAgXJTTNQVnrabrBxz7HB+r
 4h48xHDAQu1m+wBJ1J0FOtultHm2S8eknYG65mbbSgMSjYuWsotE/VKZKtNeu3ae1pXnFo4PHwN
 ia03Z56Wj7CB1bOSkhEXZGfPAHoBcUcmQf6K3OtU5HNi//RLIjkGfR2QkG5BkmzO+ieYaxH49sP
 69cOoE09EbatW2/Ubg/W1TCQkRqh/2MNgyau5OFjt15KI/NuV8yFNkgs1VvHqN6iJ5uyr2hqGoB
 pWt9SrXfbh/40fr+QoenL9sd9VhLxLfF00eM9EJo/KbBP8OK4ssARigkQamvF3hMG7kF0WWed6p
 mP8qUuNtkM6cehJ7Cu9vp7pgIzHqSW2BOaItZJdvwO5v2FJlcjc/ROOa+oDU9sJVSKvgKlUv59D
 RK3SUWMTk5oSAlfHT3IhxLI199i7L/o7pl6cnnpyWNIhZh080lVcEIvfadRR3/ZG5nCBP+JdP2h
 ZFbr4QWVCw==
X-Received: by 2002:a17:90b:5446:b0:3a4:acde:1e3b with SMTP id
 98e67ed59e1d1-3a4d197e168mr401773a91.13.1790751557599; 
 Tue, 29 Sep 2026 23:59:17 -0700 (PDT)
Received: from phui-2.c.googlers.com.com
 (25.187.82.34.bc.googleusercontent.com. [34.82.187.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4cae9ffaesm2010442a91.16.2026.09.29.23.59.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 23:59:17 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Hui Peng <benquike@gmail.com>
Subject: [PATCH v2 1/5] drm/gud: Fix probe failure on non-DMA devices by
 moving descriptor check
Date: Wed, 30 Sep 2026 06:59:10 +0000
Message-ID: <20260930065914.393939-2-benquike@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
In-Reply-To: <20260930065914.393939-1-benquike@gmail.com>
References: <20260930065914.393939-1-benquike@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 30 Sep 2026 12:12:40 +0000
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

In gud_probe(), evaluating drm->mode_config.min_width before
drmm_mode_config_init() and before assigning fields from the display
descriptor causes the check to evaluate against 0, returning -EINVAL
and unconditionally failing driver probe on non-DMA USB display devices.

Move the display descriptor min/max width and height validation to after
drmm_mode_config_init() and field assignments.

Tested in QEMU against Linux 7.3.0-rc3 with a non-DMA USB GUD display
device: on the unfixed kernel gud_probe() evaluates zero-initialized
drm->mode_config fields before drmm_mode_config_init() and returns -EINVAL
(failing device initialization); whereas with this fix applied, gud_probe()
validates descriptor min/max bounds after initialization, allowing the
driver to probe cleanly.

Fixes: 40e1a70b4aed ("drm: Add GUD USB Display driver")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
 drivers/gpu/drm/gud/gud_drv.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/gud/gud_drv.c b/drivers/gpu/drm/gud/gud_drv.c
index 3a1b9e2a2eaa..f7826e3d849f 100644
--- a/drivers/gpu/drm/gud/gud_drv.c
+++ b/drivers/gpu/drm/gud/gud_drv.c
@@ -506,6 +506,12 @@ static int gud_probe(struct usb_interface *intf, const struct usb_device_id *id
 	drm->mode_config.max_width = le32_to_cpu(desc.max_width);
 	drm->mode_config.min_height = le32_to_cpu(desc.min_height);
 	drm->mode_config.max_height = le32_to_cpu(desc.max_height);
+
+	if (!drm->mode_config.min_width || !drm->mode_config.min_height ||
+	    drm->mode_config.max_width < drm->mode_config.min_width ||
+	    drm->mode_config.max_height < drm->mode_config.min_height)
+		return -EINVAL;
+
 	drm->mode_config.funcs = &gud_mode_config_funcs;
 	drm->mode_config.helper_private = &gud_mode_config_helpers;
 
