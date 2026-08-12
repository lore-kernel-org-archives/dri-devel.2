Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3F9CC5CFEB
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 09:43:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C724A10F278;
	Thu, 13 Aug 2026 09:43:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Fr+4dxhS";
	dkim-atps=neutral
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4DD310F04F
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 15:00:33 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-3856d6fbcb3so1188234a91.2
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 08:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786546833; x=1787151633; darn=lists.freedesktop.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=bsSNRPwXgz4YmhClD9/CFwQgfHi8L4hudE3tc+zdeok=;
 b=Fr+4dxhSer2An64ADigHeGhfMZJEMa35q1ZuMe+SM+9zMpmmyT/7tUJ6Zsbr8LSy92
 +PQMp+L+fOhqmUH2eB3fff54Kg86CNDvGO+liAyglzuuv/PO+2eQDH3iq7LWVssfRmQ+
 YY+t3ipef+tUGaK5k2p32Ohs0SMmQjaHqmo4WTIuA8TZtT6Z6oEaXN1yeYPwLL3wUMAA
 bnBBSuOtAzJ1b1g+XMaEnS0OTzXIZoMkT9FuAgkPjDdZh58M2AqomQyz4gMDIbUzG3+T
 Sso7LiQxZ1A4d4ophOib2NxPtBaMNBXrLx1xiouCToUNbK4eTxKHWYWh37D6PcdH4jkG
 Gu/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786546833; x=1787151633;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=bsSNRPwXgz4YmhClD9/CFwQgfHi8L4hudE3tc+zdeok=;
 b=OyR4kQi4RpHtQnI9ZRMJc52nITcXSmLhsKjz+fK3ulEhuvQHMPetZEEP9O+FV52DpB
 wuctIgKh/L3BQgALfc5yvyB8tHWSewpFmnVNapNu+dj0+aj54Qi2RJeYXQHH3M7Wwrat
 ak1LpCwtL713OdF0jZZY8S7pdFB6l80857w6HJ+61aZcCECnOhW6ZiUjlJMQiVbzRg3G
 MT897y7ex2F0YK5e6r3Nxa2ye28qKrcuCJd0HTalGAcyFq6KnQkSCJzoJD5gxtvGKd4r
 pPpS+v7Gg6RnZHwuKbEF4/29kh3TbnVHCrftkeezmshvpRz+IbBGUFSlC1UfXrTWzbxy
 KdRQ==
X-Gm-Message-State: AOJu0YwJMurt0MdjeSC0ydsa6qPTqbYdnO+mgj5ZRK0Ms6VUoMp6M4M1
 V5JEtraEGATO31keuertZZ5S5mw6SvuIn8Y2EeLem5dODoQUmjHJ03Or
X-Gm-Gg: AR+sD10E6AgC54ChaBu7UxpeM1VnsJIY51KjkkewpzFqT2Ip6e49tlkquE4qnnJZ623
 D0Dkuk4WxnWe2f7Y83raz6Pc0IuucNesvg1ygkMsJdwipBkYZznsvBbjnfTgRapVwoXnO4ab0wD
 S/ilZ+x/hcceo/ZHHKDU2MNT6cNArD9wB84MxiJBEjasdUhFRN4U9F+NBn7n1IkPWH8YGAUK3xZ
 PfW9Xl9m8ppGmTyR1sx7UxliI3g2gzaw5QSs5wTv8vksHaG4VS+MeSUybwyf/KZR7WbtntB2WNz
 zwCQxHD4QLyl0en9S1/l9lTbsV/XdrGm+Pr4WJv8W5ZbdOANgyfBinG5FG+8da0OA+aLSTY44ul
 zhwNmKRoeDtd00e4YmViswef+wm1+Q8nu5fqgkz4IxqhkuHhAc8cgvaak92SmoC6oYBVIViQSPa
 4ClsvJ5QYXxw0SvwtzQA==
X-Received: by 2002:a17:90b:528a:b0:37f:e1b6:4c7d with SMTP id
 98e67ed59e1d1-39301287f66mr6968430a91.6.1786546832312; 
 Wed, 12 Aug 2026 08:00:32 -0700 (PDT)
Received: from LAPTOP-N3B6U5LC.localdomain ([117.147.100.52])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-392f935f73csm3896491a91.6.2026.08.12.08.00.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 08:00:31 -0700 (PDT)
From: Zhenhao Wan <whi4ed0g@gmail.com>
Subject: [PATCH 0/2] drm/nouveau: guard two render-node NULL derefs of
 absent NVKM subdevices
Date: Wed, 12 Aug 2026 23:00:03 +0800
Message-Id: <20260812-nouveau-nvkm-absent-subdev-null-deref-v1-0-7e057f6aeba0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHOKfGoC/yWNywrCMBBFf6XM2oE0tFL8FXGRx1RH61SSJgil/
 +7ULs+Be+4KmRJThkuzQqLKmWdRaE8NhIeTOyFHZbDGns3QWpS5VHIFpb7e6HwmWTAXH6milGn
 CSIlGHHsbfR9s15kBtPVRyd//z/V2sI6eFJY9Dtv2AyjbMc+JAAAA
X-Change-ID: 20260812-nouveau-nvkm-absent-subdev-null-deref-f52db5c24408
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>, 
 stable@vger.kernel.org, Zhenhao Wan <whi4ed0g@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786546828; l=1909;
 i=whi4ed0g@gmail.com; h=from:subject:message-id;
 bh=9ZuFZsbGjnuxi4gxJ6gdaTdFRQu5GUSAhJ89zKR0YI4=;
 b=ElzEuFopoAhqiGv9INlGlqScomht2xFPIi93NufKAn1DNkZgTULNfaJV8/oZt+WbKtSpDl6Sw
 eDE++5uEgHRAeL36Y9JM6kVgJxmbBIj+FxNbkntO4u8h5M94nPrFYqu
X-Developer-Key: i=whi4ed0g@gmail.com; a=ed25519;
 pk=zRTKlstE0LmilshGwJsFYEVjiT6RiXMBXK8Og6VmuVQ=
X-Mailman-Approved-At: Thu, 13 Aug 2026 09:42:01 +0000
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

Two NULL-pointer dereferences are reachable by an unprivileged local user
holding a /dev/dri/renderD* fd when an optional NVKM component is legitimately
absent after probe.

When a subdevice/engine constructor returns -ENODEV, the NVKM device
constructor (NVKM_LAYOUT_ONCE) treats it as an optional absent component: it
deletes the subdevice, leaves the device-> pointer NULL, and continues probing.
disp can also be NULLed by nvkm_subdev_disable() (strap-driven) on a headless
card. nouveau still completes init and unconditionally registers a render node,
so two method sinks that assume the subdevice is present become reachable:

  - the NV50/GF100 sw-class vblank methods load device->disp->vblank.index_nr
    (disp == NULL on a headless card);
  - GETPARAM_GRAPH_UNITS calls nvkm_gr_units(gr), which reads gr->func
    (gr == NULL when GR construction returned -ENODEV).

Either yields a NULL read -> kernel oops -> panic-class local DoS.

Both fixes extend tolerance that neighbouring code already proves is expected:
the sw channel constructors already guard disp, and nvkm_gr_units() already
returns 0 when the engine exposes no units callback. No new control-flow paths
are added.

There is no Fixes: tag: these are long-standing bugs predating the nvkm
reorg, so they are sent to stable without one.

---
Zhenhao Wan (2):
      drm/nouveau/sw: prevent NULL deref of disp in vblank methods
      drm/nouveau: prevent NULL deref of gr in GETPARAM_GRAPH_UNITS

 drivers/gpu/drm/nouveau/nouveau_abi16.c        | 2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/sw/gf100.c | 2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/sw/nv50.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)
---
base-commit: db2ddb87143519e20a95aa36c60b36107b736a58
change-id: 20260812-nouveau-nvkm-absent-subdev-null-deref-f52db5c24408

Best regards,
--  
Zhenhao Wan <whi4ed0g@gmail.com>

