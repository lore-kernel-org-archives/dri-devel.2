Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 916A5CA5FD2
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 19:59:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAF7410F771;
	Thu,  1 Oct 2026 19:59:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="G1KR9xXC";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F10EB10F772
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 19:58:59 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-4a024e16179so4793435e9.2
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 12:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790884738; x=1791489538; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gkbMt1iWPzKqAl5Y1iQuN/ShWwz04PZhQ+M6tBc7F18=;
 b=G1KR9xXCqqRAyldR4I1uo2KTKC1mokBFMZypNk/WfuMwfIJBEpHOjK51IVA84e395q
 jyEKXXLQ3Fw/MNVnlFQi1o+HBlo3IwLR2sUKaW7I+urw4jNRSnzlr4boBQu09zeL82F8
 7EnyBrXhvHEx4uWLoGu4Z2curF3uALRoe3iUsZTjENwlUkutT7JT5r+VEL1W27uJYKqM
 6qe0VmM7sfJLymI5yA0HMCGLspB4massicULY/T5/zAPFfPy4cvshdN81/zsP2h90UoG
 TMjKNVwrFstNmMHmsNvsyNmPqL0WzaV4W+IsBkL6FvsItog1OnerFKpoDN3guQP2gs76
 CKmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790884738; x=1791489538;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gkbMt1iWPzKqAl5Y1iQuN/ShWwz04PZhQ+M6tBc7F18=;
 b=iFt7W8C1aHaSAGtBjGpfoda79rkGs7j1HolsQLq11yn1tikuUgbRTO38yjLY9vwG8C
 Of1W0Q2VJIQfIcL2iYdJl0a7x7fp20CCrQnorAnHoeaiUIxZShva3RN3PDa74oYTo74+
 apK6iN3Zommlbu7YzIUrEgQV43LW2EpGv9CMtNbVuEWdHPO5mEz9wCTK9R7pvK6mvT5d
 r9cnAMxV/MZL/2f3ez6/cYft94lRNUFLdqLT5Zsc6R3pzduMImXm+oS0FahGyx10n+G6
 gne9ZDVFFQTRACe3HjFGXJQwPicqmoXC3kmO527tTl543JLrU2von984p+ieoaMuv01s
 NP9Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBwwRXIIIx8SWIXxzVbsnK2qDbZ7WftU2hh3dAEHZ/zsZ0OSkazgce+snXzgXisSAsmY26e/8PXr/qo=@lists.freedesktop.org
X-Gm-Message-State: AFuF++l700HC7gzpC0C7WzZSYzPwdozE5+Lr1xh4gC4v6at9v4poPfnn
 9u4+fHu4dgW36GLapWOGv1IziDYKb0UEA/DT+sZbO15NntVvf6ElcE2N
X-Gm-Gg: AYBFou3Pt04rlDRI90MQB+i14/MWxSGx0d0L2vtOafh5o+2J+2nJs9lW0r91kY55dCb
 4rv/c1wVFmC9f7jY55Ynto+9Yvsn1QNHMQoHHzVRagnd13T8eBs+xq73i4PhcZHYuYs9NZLKLzi
 4/g59rYDiHI70og5vL6zlEw0VWZkF9bZTxC7JzKN6JAKk2o52jhN52bGZET+tS71Pw8+Ov+uazH
 EepBBtVPkbKfc/ZIcaMaQC457cAPMZ/13rNXkWHADybplwYenNJKLogQhdp0RI0KavgmGkiDAQD
 uPopP8WLUxMyqLviVmt2BvI2d37X1nIih3syr+2p/KLidK8wXegVKaJq5ZGgZKJBsHe1dK2ewxO
 JZWZ+2+ICACO6pyr19CgjNHoo3XOLOxwfpD+4RpJ0W6k5oxjRaEfSyl2MvS3mvDl4ZI0CUpfaZo
 CV2EjoxKq0OBeYqnW0/DzVeoPMADrfWJZRDOEi6KuHvuJhOrPdLr8heJ39frQEwxi3JKmg+YhJ1
 0WxaMpFpHfMvVmgx1nvzXrHvQ==
X-Received: by 2002:a05:600c:6d1:b0:4a0:1d3d:502d with SMTP id
 5b1f17b1804b1-4a02755f856mr8010975e9.10.1790884738342; 
 Thu, 01 Oct 2026 12:58:58 -0700 (PDT)
Received: from ingenieria31.oficinasStQ.local ([79.112.15.218])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0276f92d9sm15031045e9.4.2026.10.01.12.58.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 12:58:58 -0700 (PDT)
From: =?UTF-8?q?M=C3=A0xim=20Pedraza=20Padilla?= <maximpedraza@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>
Cc: Francesco Valla <francesco@valla.it>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Jocelyn Falempe <jfalempe@redhat.com>, Sam Ravnborg <sam@ravnborg.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-efi@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-embedded@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH RFC v4 04/13] MAINTAINERS: add entry for DRM splash client
Date: Thu,  1 Oct 2026 21:58:38 +0200
Message-Id: <20261001195847.141192-5-maximpedraza@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261001195847.141192-1-maximpedraza@gmail.com>
References: <20261001195847.141192-1-maximpedraza@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Francesco Valla <francesco@valla.it>

Add myself as maintainer for the DRM splash client.

Signed-off-by: Francesco Valla <francesco@valla.it>
[Màxim: add myself as co-maintainer]
Signed-off-by: Màxim Pedraza Padilla <maximpedraza@gmail.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4d108339f44e..44730414e5df 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9155,6 +9155,14 @@ F:	Documentation/gpu/drm-ras.rst
 F:	drivers/gpu/drm/drm_ras*
 F:	include/drm/drm_ras*
 
+DRM SPLASH
+M:	Francesco Valla <francesco@valla.it>
+M:	Màxim Pedraza Padilla <maximpedraza@gmail.com>
+L:	dri-devel@lists.freedesktop.org
+S:	Maintained
+T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
+F:	drivers/gpu/drm/clients/drm_splash.c
+
 DRM TTM SUBSYSTEM
 M:	Natalie Vock <nat@pixelcluster.dev>
 M:	Arun Pravin <arunpravin.paneerselvam@amd.com>
-- 
2.39.5

