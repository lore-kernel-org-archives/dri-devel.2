Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71E91CD13D2
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 10:45:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D356910F2FD;
	Thu, 30 Apr 2026 10:45:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="e2+NOuif";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 754B210F2FD
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 10:45:34 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-488a8ca4aadso8219755e9.3
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 03:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777545933; x=1778150733;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tuw4DQUQ8wFwSodwVVRsikXJG5LLCcS+5kiwz8365jg=;
 b=e2+NOuifSs++QfvJif6ThAHuz7mdTPkBB/rX9wyeYAtZs/2mB8v1hPdmCHC33k0pPy
 BbTavMRyDv0M+qsAknYWTLICaW4Ol63i2C5waqcjmL1CbNiNE3m+IrND0KFJer84j6Hx
 T8ySK1mbt6AA629LMXtEtaZzYG00OnDzOBSB0XdvHvHDYcUOxYArKh3BtoiGi9LtNrC6
 IbK3zPszHkiZgPp1OHxJxvb495Kvs/tNJ1qMoR+NXpW6oOl/c69kimTHLiKs8g8AdoEo
 XlnwLDDOWO2hjnBA7Cy6TdDl7x+JkfcGqyLLGhREByMIvUVAYuc1GxSH2lGlTeKKn45Z
 13fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777545933; x=1778150733;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tuw4DQUQ8wFwSodwVVRsikXJG5LLCcS+5kiwz8365jg=;
 b=ipF8JVM92ftaZIQaSIAvj4dww4duk0MlaVvDpqlMdZLFJRjBjieA37Jwo1oEsmJxui
 /gkoxqmR8vBDGoejXkCklI/v7/NBI0lp4U0JUl8NaxzA8dj8Tv38dm+1gND3Kvt1B2K6
 u/6DTouIF2c1xEDFV87bkT5sZAK0jLWZKvfb3+Qz5YGOiCQM9ZaXFueoJ9S+OWe0glhH
 P/uQxHnMvkS+yBDEiWk6+vq/mADKg3Dg0WnBEVcMAPomwLcUOsWr3oekBF1KfhRe1SwX
 sDjFWFhb9eP9jzQz/OfC5Q/opJAKaw/8KgtQxc9yjG24eaSWiwD7P1NFmpwwPvIXmo5b
 THXQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+OYrcMEWbEbvy6VxWTPpAb6G2U6OdGnvDHMOiy2qHNy+pTAPNIX7eOqkroMoDpiLBI9g22a2zBv/c=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzfUUeq68xqtOJANIR66Ttl6fnYkFqNtkIk3M5mgE3p30Gy3znp
 IwUK1neuwR5xsbvGUnS8PdQV9EggAe6DwahRfTyWSou3F5Dcqu1UN/Duai5IifmPxSs=
X-Gm-Gg: AeBDieut2wjlYBh5xCnkqVvm4V+lXAFDpUJxUSW1pZdH0P52MX6O7EABm3wMypfvhF+
 wuRUhqchwFSZvculRGljPy1NmOF8l0Hi3xt7Ffuk4cxW9a/G01TfctshuUEzDz1v1tZCoelT1oL
 vY6OioNW31r9RoJlWSVhAzWZCERCa4Tprbm1LPrXtgpLIzHoo+dQZ2H5vRd1cZW9yxKu3hNePLZ
 slt3Wxnf3g4suTSZ3MKLtalNqn+0y28J6V+gQIQx3geW8lSKOLcQBJTdX5GNuL79f4eS/+QH/Uv
 Xt8Jvk7DlXfNfgaPlk9B4LELUWM8u6pEfk3FAhze8OdT8MVN7YYHPMDLVkBd2vZrWh/U+fJxJop
 5PGUdxY0OVM1qdCoUXKJp2NLU0OEC6J0bGNcEw1r2mlFFd6eo/ASAbLFUJQLQt+BNAMQiBfVW1u
 W2ZCDKE2sY0KxBo/1r7Tn3p9IA8qTtGh7l/wRRg1AphqQ/tfJVPVu+BI2wTr/gB3s/cBfp6TGkr
 OICIS9szBo/vU3FO/CUbGSZs6JFAllFzPvR
X-Received: by 2002:a05:600c:a30b:b0:488:c014:34da with SMTP id
 5b1f17b1804b1-48a8449dee7mr30397465e9.26.1777545932923; 
 Thu, 30 Apr 2026 03:45:32 -0700 (PDT)
Received: from localhost
 (p200300f65f114e08c77bcc4a3b99186a.dip0.t-ipconnect.de.
 [2003:f6:5f11:4e08:c77b:cc4a:3b99:186a])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-48a82307f28sm92585885e9.13.2026.04.30.03.45.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 03:45:32 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?=
 <u.kleine-koenig@baylibre.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Dave Airlie <airlied@redhat.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Markus Schneider-Pargmann <msp@baylibre.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Jocelyn Falempe <jfalempe@redhat.com>
Subject: [PATCH v1 0/3] drm: Drop unused include of <drm/drm_pciids.h>
Date: Thu, 30 Apr 2026 12:45:12 +0200
Message-ID: <cover.1777545446.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1078;
 i=u.kleine-koenig@baylibre.com; h=from:subject:message-id;
 bh=l+YDHlVs7ftuNxR+PsZazTu554cMr6hKc5EqbljDrkM=;
 b=owGbwMvMwMXY3/A7olbonx/jabUkhszPRjsfzrV/+Pl/U2m10H+L4CmVpbMrag5Msun/t7r47
 TIJFuuXnYzGLAyMXAyyYoos9o1rMq2q5CI71/67DDOIlQlkCgMXpwBM5MNn9n/K1s3zmN58X1lQ
 9ffp+jypjMWr2L4ZOC9q3+s60+/l5ce1si8karo41LO8Ntkm6NxWi9Wfb/nsTfjlZb6FzdNzjWQ
 qSvoYGPq6U76vkJMTZv7qGXnxuWkfx92jwnm2ibsuq/nkhp1v/Ou84O6Mv0c7P8cwigmELlc3um
 lUp1TB0uD7e9bl1AinjrBTtpvTtsbvzPnWvj/+TNhdXZ/Cr7XbD53nsbEumWeZtvpxm8WX3qX6/
 g+Xvy9Z1G+abxHGzfYybOVl2cIHNenb7b5oWi55XD2d8bmxqm/qWw8HgamOF/MWPBG39d6/jTMz
 Z2X6sc2WPc2dPycX8qtf03dJrcw97fqOb6H/hBQuY/ZSAA==
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp;
 fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
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

Hello,

<drm/drm_pciids.h> is only actually used in the radeon driver but
included in several others. This series drops these includes.

The obvious continuation would be to fold the definition of
radeon_PCI_IDS into the only .c file using it. But I post-pone that
until
https://lore.kernel.org/all/20260430102958.136859-2-u.kleine-koenig@baylibre.com/
is out of the way.

There are no dependencies between the patches, so I suggest that each
maintainer team applies their material to their own tree at their own
pace.

To state the obvious: This is merge window material.

Best regards
Uwe

Uwe Kleine-König (The Capable Hub) (3):
  drm/amdgpu: Drop unused include of <drm/drm_pciids.h>
  drm/gma500: Drop unused include of <drm/drm_pciids.h>
  drm/mgag200: Drop unused include of <drm/drm_pciids.h>

 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 1 -
 drivers/gpu/drm/gma500/psb_drv.c        | 1 -
 drivers/gpu/drm/mgag200/mgag200_drv.c   | 1 -
 3 files changed, 3 deletions(-)


base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
-- 
2.47.3

