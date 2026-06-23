Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27202CDB47F
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 07:48:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E395510EDD0;
	Wed, 24 Jun 2026 07:47:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="awdclbKP";
	dkim-atps=neutral
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com
 [209.85.208.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4109C10EB4F
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 13:19:53 +0000 (UTC)
Received: by mail-ed1-f50.google.com with SMTP id
 4fb4d7f45d1cf-697ebe536b6so20253a12.1
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 06:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782220791; x=1782825591; darn=lists.freedesktop.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7PhzB9IpnBw2GMjA06F7mqNVMnbUZwmTYPMzQKsAxjM=;
 b=awdclbKPvszo96wD+X2/q4wauTEOYpilNcLD+kGLjR+cHos6pWNRGc6XJ7kQ+Gn2Oe
 OP1Lh2G1Bn0r5eKGUev5u2NU9TgIAsh761lkMpFc9seyJGFfPerDjvp3SB8sfGxc9Sto
 2WXrRxCxSjFpnthUHx6o5iQ382OX2F/9fLAmkieL/vJUVSpsh5RYlmo0Bb5IDnrMjaoE
 sgkjoK2CVpf9IdNgcn2JIzIqpzzb+I9Zzhq1/rX8sb/qr5QsZKgaTEbdBgXWFM3iynvz
 68LgXf7w63+HiKGWEB0ARzBmOFHhKSEGoPL494GmUDVgtL8kevfi5fRyjphaRGUy6teK
 hUsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782220791; x=1782825591;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7PhzB9IpnBw2GMjA06F7mqNVMnbUZwmTYPMzQKsAxjM=;
 b=cxCzhKqHNxGXXotWjTkkXMylG+JzGovash+eGAxhbnyjeJq2NeTArym1jA/12JI/IS
 SxN0aRPh7VXKsbc0QX4csG//V4QYT3xz1Ez3cG2PGLjkNqrZLBwPxpMXpdL87eLm0WRb
 oJyUCdb+QR4E2sAsn0pdx0YC94+1KxZaDLqIzCoTtS2oyF/QC0At7yk12kfqjMeHISHm
 U+3DU4paU9GTkm0KtzUxfz/+Lrvc54SSYFmzfn0hn98rcpUjIyvpW2BUePJc/jx/AMh4
 MyJR52WItAR4xylSILe8a9FfPB+0tG/UDG7AlciIXl0VX+36AR8vbvweH7HVLBor/dQT
 oDJg==
X-Gm-Message-State: AOJu0YxN47lZdrQTUlNQTcVXoQr45t+ZgBy2kicmMrSBQVkTdeHioC+k
 WjlHQiGvhbIX2VEYchqAmrfGpzS5R/2BjKsemX9V6kXWWx3fwuP/OLzk
X-Gm-Gg: AfdE7cnEfqVMvqKN6Lp++ZEVCv8/eNmwAQ3KzxOXpKd6Ig1dCbBwGE+E7psPWGUPgEZ
 SkHRh/E44i4Yytf38qJHAtFvZh/MkORDZm8MS7QeC2bWqcId+oS11r0C/fsyurU82k3pqqWtgNX
 MqbjTtt/Gwbqh2CS80i5nGqeShnWm2QxDe87ECP9Mh7ivVbIlqNeFBOExY6uhzWOQueuUmHExli
 3EKrYcL8P/k92yFL6p4+7cEy4GBqlB2o4jDJe9TcLvqOgj9hfw1wCEj8BBzsUrzkwFZcmYmolMu
 ZMxie1R2Vi9/a3V/q1+zKsaeEFD8oqGLGfRpOBwHJLyyQJZQphLOaRRXIpALmCoWz+GPfBYpxEF
 Aa+NhSJELX2dRq/NRMGcKZ6J4ElODpHXSut58rOmojGVg4n+Lu2yWPh3CcPfP2AI/Sx22xD5f9T
 se+wqeOoUQ6iyCdC9uJhYv
X-Received: by 2002:a05:6402:5107:b0:697:bdb9:51f with SMTP id
 4fb4d7f45d1cf-697bdb909c9mr3759928a12.4.1782220791355; 
 Tue, 23 Jun 2026 06:19:51 -0700 (PDT)
Received: from [127.0.0.2] ([194.35.121.133]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6977b82f95dsm5060107a12.3.2026.06.23.06.19.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 06:19:50 -0700 (PDT)
From: Diogo Silva <diogompaissilva@gmail.com>
Subject: [PATCH v2 0/2] drm/exynos: DRM encoder improvements for Exynos devices
Date: Tue, 23 Jun 2026 15:19:29 +0200
Message-Id: <20260623-exynos-drm-simple-v2-0-a8d59678b7d2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOGHOmoC/32NQQ6DIBBFr2JmXRrESrWr3qNxITLqJAIGGqIx3
 L3oAbp8L/nvHxDQEwZ4FQd4jBTI2QziVsAw93ZCRjozCC4kl6JiuO3WBaa9YYHMuiBTqq4aqeW
 jbp+Qd6vHkbar+ekyzxS+zu/XRSxP+68WS8bPpBh526gS8T2Znpb74Ax0KaUfj96zn7IAAAA=
X-Change-ID: 20260623-exynos-drm-simple-bb5386d64597
To: Jingoo Han <jingoohan1@gmail.com>, Inki Dae <inki.dae@samsung.com>, 
 Seung-Woo Kim <sw0312.kim@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Diogo Silva <diogompaissilva@gmail.com>
X-Mailer: b4 0.14.3
X-Mailman-Approved-At: Wed, 24 Jun 2026 07:47:57 +0000
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

This series does two things:
	- Open-code drm_simple_encoder_init() since it is deprecated
	- Handle the error code from drm_encoder_init (previously
	  drm_simple_encoder_init) to prevent silent failures and
	  cleanup of uninitialized encoders

Signed-off-by: Diogo Silva <diogompaissilva@gmail.com>
---
Changes in v2:
- Fix mistake in exynos_drm_vidi
- Fix indentation
- Link to v1: https://lore.kernel.org/r/20260623-exynos-drm-simple-v1-0-bb52f098b1ee@gmail.com

---
Diogo Silva (2):
      drm/exynos: Remove dependency on DRM simple helpers
      drm/exynos: Add error handling to drm_encoder_init()

 drivers/gpu/drm/exynos/exynos_dp.c       | 13 +++++++++++--
 drivers/gpu/drm/exynos/exynos_drm_dpi.c  | 14 ++++++++++++--
 drivers/gpu/drm/exynos/exynos_drm_dsi.c  | 11 +++++++++--
 drivers/gpu/drm/exynos/exynos_drm_vidi.c | 14 ++++++++++++--
 drivers/gpu/drm/exynos/exynos_hdmi.c     | 15 +++++++++++++--
 5 files changed, 57 insertions(+), 10 deletions(-)
---
base-commit: 60326b17f877e12846167bf8ef83680b9875218a
change-id: 20260623-exynos-drm-simple-bb5386d64597

Best regards,
-- 
Diogo Silva <diogompaissilva@gmail.com>

