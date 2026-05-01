Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EE7DFF885A
	for <dri-devel@archiver.kernel.org>; Fri,  1 May 2026 07:10:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AFBF10E189;
	Fri,  1 May 2026 07:10:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BCcPQmht";
	dkim-atps=neutral
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com
 [74.125.82.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7425F10E4B6
 for <dri-devel@lists.freedesktop.org>; Fri,  1 May 2026 00:13:39 +0000 (UTC)
Received: by mail-dy1-f176.google.com with SMTP id
 5a478bee46e88-2d832f2f44cso1476758eec.0
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 17:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777594418; x=1778199218; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EjUGoLHqPL5VETUhJL72vL6nLh8xGP28jw0K/tf57Dw=;
 b=BCcPQmhtDXVY+n8aD1jONqCJ/7xF8tibN/3+mJpMPND3NzvLmY6t4FewWFWn77UKB/
 74G4KgHPvLTNuw5pQSfbbLqNAEPkkdTDmJGzXqxYtNJFrI3OHbSlsqNYhJJ9/iPGoE2H
 kkrHZ/7AF9YW7uw0Zq9BX2SISYLqe3LgGLpBXE5fEfDAqWPFf8pSJvjYsWGMOMuryzpu
 M2NFEECQ4Lt2LCfkL6mIHf1XyYqWh2Zfsoded7PD2COoBrD6Zupo1rbgPZkhpq2k51uR
 VyOM6YobYvU+aSUCrRsfRDmx/v6W+LptmBtQEfm2MX3NTfdxG3rs0sHRtwDFPl1ll6L9
 FMfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777594418; x=1778199218;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EjUGoLHqPL5VETUhJL72vL6nLh8xGP28jw0K/tf57Dw=;
 b=sHfI8xlO8O/O35rpopHLx4DEriTnQWo5k5Jd2m/rRoWk1Ez/d+stF1iSd9yr6ajNVI
 marC6ARReozdAWeAQrHvQ3/sBy1LTKTmlNGsPynm0zYH4Groy8IbdjvjG/yIejrFT4Y+
 vLkbG8C6gzb0D8barzj9cW7Xzb4SCrRdU8hhwq2T6NY+FnYg80b7DgPo+ZC4bMl9ucM9
 FilNGRxfytlwuFAFezUITXWW432DGWUgNFYc1P1FaBbFqQknmtCGJR9WFbIYGClHsx4n
 NDBcpVaStm4o/pQhwdxvZoydlNUQ2Dfl0kPB8oi8IJcPotkSMEwiCsLGkplHySDD0KxS
 MzKQ==
X-Gm-Message-State: AOJu0YwF+hdqEcOxUvioau4VSqCaO+lCHnPNejGrCXLON1zMY0XqzDft
 Amyavz1InPGAQQaobqdQcgsO1AugF6CgHOdod6kdlS0E8N1bC4ZGQb1qjWgYattU
X-Gm-Gg: AeBDieu44ccIEAIm02nrMxsKPzkB9s/ExPnu8yIF5nHYjmyCLT0A+kLrPu9gajbsxyS
 OOBDJkPs7nuK2n7be2sZBz2gvDixB4E7mRTbvCHErujLacV7oYJ+Px759oCfaQmhOMkiylk55U+
 CHs4Kk/MTxnRdnqwau/x0l1LgZqWpnuxJo4vmLES1nb/YTy2uIqdZCBLchMfIRkEiu/t0lIEtsg
 qaeK++saJv1uIQGzdJ2UQDfAqra9ZnBVMsuPrjc39rsi035VtaM0p4/2v7eCZ1CgTxfRfrQT+HX
 w4BrWT5pfx9HDtKIQb0c4VQgK/Votow0iA640z5o7cItZEYzcqukbSAnS9fRRbTKVxAxcMDMqJ6
 RMvWHVGtUk+dWT9AR2SQeb0Yj0msp4q/d28SrJisxQoYzs4dJuNHSstRw3drjJEjV8Eo61D6zvz
 yiBeggQiz4h2783708NYYquStnambDJa2SoyNeB454IwLteReVUp9FGslWpUsUD7zhkrNjz7s1D
 cieIsNe+ZucYkovzg==
X-Received: by 2002:a05:7300:570f:b0:2df:7882:1ce0 with SMTP id
 5a478bee46e88-2ee89705e5bmr395130eec.29.1777594418045; 
 Thu, 30 Apr 2026 17:13:38 -0700 (PDT)
Received: from pop-os.UNKNOWN ([2804:14c:f25a:8247:ca3c:d9ec:76ed:197d])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ee38e71ccesm2808237eec.10.2026.04.30.17.13.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 17:13:37 -0700 (PDT)
From: Gustavo Piaz Da Silva <gustavopiazdasilva2102@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, linux-kernel@vger.kernel.org,
 Gustavo Piaz Da Silva <gustavopiazdasilva2102@gmail.com>
Subject: [PATCH 0/1] drm/blend: size zpos array to active planes instead of
 total
Date: Thu, 30 Apr 2026 21:12:59 -0300
Message-ID: <20260501001301.7666-1-gustavopiazdasilva2102@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 01 May 2026 07:10:41 +0000
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

drm_atomic_helper_crtc_normalize_zpos() allocates a temporary
array sized by dev->mode_config.num_total_plane, which counts
all planes registered on the device. The function only operates
on planes active on the given CRTC, as described by
crtc_state->plane_mask.

Replace num_total_plane with hweight32(crtc_state->plane_mask)
to size the allocation to exactly the planes being processed.

Gustavo Piaz Da Silva (1):
  drm/blend: size zpos array to active planes instead of total

 drivers/gpu/drm/drm_blend.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.43.0

