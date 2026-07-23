Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8DB2C531CC
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 20:36:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19E8610F1F9;
	Thu, 23 Jul 2026 20:36:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ja3dxhnL";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0F5210F1F9
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 20:36:05 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4954a2e73a9so7487095e9.3
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 13:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784838964; x=1785443764; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=eOoo7EZ1Hzfz3hHGbRxuZ572y7WHohS2AdGQHbHYkgI=;
 b=ja3dxhnLA0AS/DDUN9koqhzdAK5IP30cbVEuA5L2iuGmvjkDNt2hzN9vOz0tYc5U26
 bq6oWcRJS2eKzVo4ptQxA5vfhKwvcPgi2dV//l+hC8X3ltRi6nK4xtOLoZtYM99aL+d6
 dpWk1XP45d9N5RubT70abacBYvlunosezq5nSzwpygZGpsPhPWXgrZ46rzE2vzMygrgh
 x8xcu0wBNY2m0o5R3ueRLyZudqtMLkxsmBMNvlBXFlWgrNZruKwEYHLn4LTuoCBrD7E0
 CGMfQRrhkH6b4Jug43K1+bTdR1bRl30CvLP9dG5ERCkVtmKXrXFBqBZgT0P1qfGPto+x
 nUUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784838964; x=1785443764;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eOoo7EZ1Hzfz3hHGbRxuZ572y7WHohS2AdGQHbHYkgI=;
 b=Bmtw0zXGSjvuvalKHZ+TxHUq/YCbkOEhE4U0X8sA+EZGzW3ZacyBW2LkqXJWvgyiHs
 OXCwC5gkZJ2WrkwJyfPjs0CuAxjI+WTa8nYEjPhwU/cDH+Wt1/kIfEvnOZGhVYPgICoS
 L/6f5RRGeLo5EGsG/D3q5mOxdX0XiuXR6Q10wfFd91YgNfmbiEtHyXZtzPw258En3DGE
 NAmh4DBJ72Fm9OmaVerYvUd2/mW/FgMQIrKiATovlMh/IMNUu3VWK3Wl0fF7BLZ6OGlq
 0gGjgYBdYKpRCkiaKqI+la0s8u+6cg2v/61GCcFFUB61MqoXkmaeDNH78GLGddsdEPei
 7EhQ==
X-Gm-Message-State: AOJu0Yx0vC8gUDXGAusqjD8MJYN1t2LJ3VkMTYVlqxxcqdp8eriaooGu
 VWnY/IHNCA2nXQ2ucJZN8m7hP8VOBE+7l7JPtXXlSqv8jifmBc5Tv7+z
X-Gm-Gg: AR+sD10aNRnSwgRdrHxVm3fcAINMxMXN0+vG7F7Ebzny9uXJ8N+rCoiJMSALnqW+9As
 IlP1NXJvtCwvkONOuq1dF4W/Mp8ASeEYpP3HzYVS6ailIajXrkEzCkyWwAq3eo2/C45mcEBmqE1
 mLqV0R4R5qDqBqDEc7Xa3/ATt+I0s5AghZj5uvSr8XxX52mHaK5St8gVP9+Ocsttd2GvmWZObRJ
 Fu1536iJ3SN8H7TLDEQg1iviAG1UUAYDbpULk+ycuOtvfrkwh2HzGT5d3aiOQD57+ux+pw9iNFZ
 xBi79PXsJK0JBLM/fE5Mzys8Txwu9eTnh1A6ceQ+P1SN4DCwUyz/XD/7xzPzIHRIlA7/79gO9PC
 CJRQucOUwOyvnDQc7RsqieOwU86RQyzALZ7fa68dqKjt+wwTgoMd5RKNNxOHpqhpURwu4/XRSMX
 5Q1kVk0KoRZQMzqlElVjQSwIMbrY2Uf8TTHvmZ2g==
X-Received: by 2002:a05:600c:468e:b0:493:f140:c3fb with SMTP id
 5b1f17b1804b1-49573cc12efmr54584635e9.7.1784838964092; 
 Thu, 23 Jul 2026 13:36:04 -0700 (PDT)
Received: from michalis-linux (adsl-75.176.58.251.tellas.gr. [176.58.251.75])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957af181b7sm23460695e9.0.2026.07.23.13.36.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 13:36:03 -0700 (PDT)
From: Michail Tatas <michail.tatas@gmail.com>
To: michael@amarulasolutions.com, neil.armstrong@linaro.org,
 jesszhan0024@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, dianders@chromium.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Michail Tatas <michail.tatas@gmail.com>
Subject: [PATCH v4 0/3] drm/panel: ilitek-ili9805: convert to *_multi API
Date: Thu, 23 Jul 2026 23:35:58 +0300
Message-ID: <20260723203601.806697-1-michail.tatas@gmail.com>
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

This series converts panel-ilitek-ili9805 to the
mipi_dsi_*_multi helpers and cleans up the resulting code.

Patch 1: Convert the individual DSI calls to their
*_multi variants

Patch 2: Replace the ILI9805_INSTR table with per
panel init functions using the *_multi API, dropping
struct ili9805_instr

Patch 3: makes ili9805_power_off() and ili9805_deactivate()
return void, since no one checks their return values.

Michail Tatas (3):
  drm/panel: ilitek-ili9805: Use _multi variants
  drm/panel: ilitek-ili9805: Use dsi_multi in init
  drm/panel: ilitek-ili9805: make cleanup funcs void

 drivers/gpu/drm/panel/panel-ilitek-ili9805.c | 212 ++++++++-----------
 1 file changed, 87 insertions(+), 125 deletions(-)

-- 
Changes in v4:
Addresses review feedback from Doug on v3
- Delete unused field name in struct ili9805_desc
- convert MIPI_DCS_SET_PIXEL_FORMAT
  from mipi_dsi_dcs_write_seq_multi()
  to mipi_dsi_dcs_set_pixel_format_multi()
 
Changes in v3:
Addresses review feedback from Doug on v2
- Convert hex to lowercase
- Align to match open parenthesis
- Change lines to not cross 100 chars

Changes in v2:
Addresses review feedback from Doug on v1
- Patch 1 remains the same as v1
- Added patch 2 dropping struct ili9805_instr and used
  per-panel init functions
- Added patch 3 making the cleanup functions return void

Revisions
- v1: https://lore.kernel.org/all/allWpYxgHfpKughy@michalis-linux/
- v2: https://lore.kernel.org/all/20260719190358.438699-1-michail.tatas@gmail.com/
- v3: https://lore.kernel.org/all/20260721172715.602196-1-michail.tatas@gmail.com/

The changes are compile tested only. Also I run checkpatch.pl --strict, 
sparse, smatch, gcc W=1, clang W=1 and coccinelle.
2.43.0
