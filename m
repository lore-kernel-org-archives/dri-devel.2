Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF2A1C4452D
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 07:16:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DE5D10E7A8;
	Mon, 20 Jul 2026 07:15:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MqY1jgBY";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2124510E0A1
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Jul 2026 19:04:04 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-49550ec592cso5028125e9.0
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Jul 2026 12:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784487842; x=1785092642; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Vg4zSEjVbfEP06hnLHW/Sb6yLZpwyX9YPwNFfcUBv8c=;
 b=MqY1jgBYJTLOK2DQNwUJgIxfBEJDt9Au5smaQZxv+l8u/T6XxlU954GJDzi0fZsTpj
 hXI+rB62RRFwSUjptJ9Brae2qpVbQbmyvun487onn7PoD7sEB+7VH++Upk+A6wwGIg0q
 +r02xxNL+wV9EcL0TGYEClMq2hNFd/rZifYZkG+aXYpP23zynPQK8er80f8cpnL3rnPp
 1NNzsyeOp/8enugEIGew6alV/ubQhx9gOtMaaQZJJnPZsWJdIL1QHPI0D5ldiSciFwyE
 JXLSQIn8g1x0dREgbS+yjCc8KYPJSuWB0KTDn3/k9NCPlnMUMqaoFCZEloAQ2RsqFOk5
 UM5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784487842; x=1785092642;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Vg4zSEjVbfEP06hnLHW/Sb6yLZpwyX9YPwNFfcUBv8c=;
 b=eVCZFGSfjlEBnSpC6TwXY6wt5fkE3Asx9+5YrjAPBobz4/Mhm/+bGMVCvG6a4J9kZ1
 6yb2NX1hJz20RSIYEE6AldM8nB+pdgla0kcfLEWWMW2QekKTb1PsHiCk0sVU3hryQcPx
 yXwsVTaBSgos4aVao1uZRxlppG37woV9rGO1musS42h1Epj9hMCpPBE9dcCcFIqHan0v
 cCYAVx35f+pNHMhARd27TSdctLYJvTt/t5oSCfBY+XMGbe6O68bDaVpNwNt6UrIsyeVc
 SXwJGBztJee2oRuA0u985J/sdd3ukOKEKkpqkbixYdQ+rfwSb2WmCccVBYNDfy8x3Mcj
 grlw==
X-Gm-Message-State: AOJu0YyhPksZBNc6e/LiDoVIXnzqeDD9A3hbRjophdM1C51hIJXtRBUS
 SwJOZpaiHEYjvCfkO7w8Z3j4ar3yJwrN58g9/qOeH7ygyDJCZZQ2nUBr
X-Gm-Gg: AfdE7cn+XPnAD0svvJtJyqVh8bEbbPb8u/XkREq9YHuUX/BQnZcDNdKOsO8RTQSMcM5
 YqERF0rwI61YHLiqT4LZYsSrGz04U4vSZjbXaXFM+yCvyYHCJaH9OqEpdGpLZz4KxoUH71i2xST
 iadWA0oghHxGbOmxdpzdfavFEhJphD2+6kT9l1SNg8Q0Jh3FAVlzIGEI+Uox4RaQO/j5x27GV4k
 D8VhBEUbjashOC90cNwjcRko3AdkaDciCG/eTdF/d0AC4r4SqMoVyJf2kFnHCHJ4KBF0ZBfhVoz
 JD5wj+Zh5alS+Qg31wkJ95PLfG7Ojx6rrhvOhw+M+am+V72Ho7ZN5G5BxfEU3cAT9czCFmO8hti
 EjtDJ9IW8aJOlZKjw1V9Ii9GXXwM16UswV2q7J1D/4yz3//32dR+u2QWFN3WSbkOXnj0NjOM5kK
 NuNi5FI1l/s0VMyOfdPIr4RrB4/TEm94fyQ+d7lg==
X-Received: by 2002:a05:600d:8443:20b0:493:ecf5:89fd with SMTP id
 5b1f17b1804b1-4954a341a2bmr89158815e9.17.1784487842350; 
 Sun, 19 Jul 2026 12:04:02 -0700 (PDT)
Received: from michalis-linux (adsl-75.176.58.251.tellas.gr. [176.58.251.75])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4954c841a0dsm181983315e9.5.2026.07.19.12.04.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Jul 2026 12:04:01 -0700 (PDT)
From: Michail Tatas <michail.tatas@gmail.com>
To: michael@amarulasolutions.com, neil.armstrong@linaro.org,
 jesszhan0024@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, dianders@chromium.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Michail Tatas <michail.tatas@gmail.com>
Subject: [PATCH v2 0/3] drm/panel: ilitek-ili9805: convert to *_multi API
Date: Sun, 19 Jul 2026 22:03:54 +0300
Message-ID: <20260719190358.438699-1-michail.tatas@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 20 Jul 2026 07:15:03 +0000
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

 drivers/gpu/drm/panel/panel-ilitek-ili9805.c | 207 ++++++++-----------
 1 file changed, 84 insertions(+), 123 deletions(-)

-- 

Changes in v2:
Addresses review feedback from Doug on v1
- Patch 1 remains the same as v1
- Added patch 2 dropping struct ili9805_instr and used
  per-panel init functions
- Added patch 3 making the cleanup functions return void

Revisions
- v1: https://lore.kernel.org/all/allWpYxgHfpKughy@michalis-linux/

The changes are compile tested only. Also I run checkpatch.pl, 
sparse, smatch, gcc W=1, clang W=1 and coccinelle.

2.43.0

