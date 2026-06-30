Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF922C43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 02:37:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14ACE10E14A;
	Tue, 30 Jun 2026 02:37:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JlTW0/mJ";
	dkim-atps=neutral
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EBD510E14A
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 02:37:10 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-37ff436a048so945808a91.1
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 19:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782787029; x=1783391829; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=21ZT2NLOqak/UmjGCnvaZ01Nfpagn9lBx2F49mLQoMU=;
 b=JlTW0/mJ8G0sF1/HoldmPDHlkJ9BGUC7u1CyUmBi+KptPIAR0V9yR8See2sdP3CK/T
 4sGv4npK5GfjQXLEJhLcIOPN+XotT2aNyx8jtW4vs1gqcZruaFw6htHeESIo4tLS3LrG
 8YrDJ8TgiBYpMGhrWr1BFZ0iSYBfXz5EQR2SvYFXC8hjTnzWYVoNThdU8sAFUK9C07Cd
 4AFMbS357EhV7IjNlKW1Y6APESsL8lU1RIH0PnNL/7ByngxyhNixP0ZmNAysQmwLXKFT
 LYJUpQCJzr02Yi1smlX/+je7UDfRFbVir3eGvjuOgmsrQF0ucEfNUIkCbXV41Ul6krGz
 jzsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782787029; x=1783391829;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=21ZT2NLOqak/UmjGCnvaZ01Nfpagn9lBx2F49mLQoMU=;
 b=Wo7UHCTOGla/2FiDDl5KDpczuHeP/vF3PiNuRlyhavMrxkCi+6ur825bEsbAZb8IVh
 elxit4UDZD+KSKSooWHE1puUzDIfVhNyfFSYFp1hxMMSqnptSwX415eZWuWxbYPjW6MG
 ifGhE30/ApNVcQRZg2CRWp9aKZ7rCvywrlM1u/kuA78J77HgOHhEvPgIyKkG4khrliVd
 GimkrzVj44EyFXXhkZYTlxc6/5iTYqpxiZl5uNredfwZOYUqMXb6v0OJ7JsqxbxksAc9
 g+9H4gGlopqTcsYkd5ICH+prONrtgWNu9qoJGa/ts6yeQnOalRIuz8d951EWghlXG1vA
 np+w==
X-Gm-Message-State: AOJu0Ywo6/d/5d8qjBJzhAEhcjwFdgLBCzL7FufolUcyKKvhFWj3Etxg
 lkeLX5dYOCUf2jbqBTxK/G3kCXHkqNeG7lHrwvkUctfsq48WDx86Irb8
X-Gm-Gg: AfdE7cn22eM2oZbVBZ6ufk2HhdX1WWVDUzz13WrlcGWObHAF/CaDG9MDZu6NATJ9AWt
 7RRqIUcUOibcxxS6HQnuQIPvEkXNY8xYBhn7AAbTD1M1n6mttImQaxFw55XDaga+NMnmjJY5r99
 dRhVPJ4uq6X/2/pHEw8c5xrWwQPCcGOGL0jsJNcvQF0yPdCLQu8jrUCu9t/Dmegmp+qePebD8h8
 CT2krbjOlLxHP2ufbk4AJ1s7WIDH/SdbFOcVqx51Ilbl5BJBmzVNa9Zk+cZGXrZoF5ythGTdFKJ
 LYSBS6cWD6LzBMXeVXrB8Q/nMDHFwK4uwHkRY+82RsS1LeEJVjtOoicDu4Mp1Av1cP7hhmtmn3I
 rs3bx6N/8Sd7fo2JZItH7zSaX9zuYYAa5XLaloCyP40/HPPbYTwaHKLG6h+X8qjKhIWWALO1hrC
 s+Q4ZqDIHIerc=
X-Received: by 2002:a17:90b:2ec8:b0:37d:edb2:830d with SMTP id
 98e67ed59e1d1-3805255b088mr1242206a91.9.1782787029418; 
 Mon, 29 Jun 2026 19:37:09 -0700 (PDT)
Received: from nuvole ([2408:844c:b00:2b2f:398a:8bef:b88c:653a])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ca3828c2fesm3310465ad.49.2026.06.29.19.37.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 19:37:08 -0700 (PDT)
From: Pengyu Luo <mitltlatltl@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Pengyu Luo <mitltlatltl@gmail.com>
Subject: [PATCH 0/2] drm/panel: Add Novatek NT36536 panel driver
Date: Tue, 30 Jun 2026 10:34:37 +0800
Message-ID: <20260630023439.248861-1-mitltlatltl@gmail.com>
X-Mailer: git-send-email 2.54.0
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

Add a driver for panels using the Novatek NT36536 Display Driver IC,
including support for the CSOT PP8807HB1-1, a 10-bit panel found in
LENOVO Legion Y700 Gen4.

Signed-off-by: Pengyu Luo <mitltlatltl@gmail.com>
---

Pengyu Luo (2):
  dt-bindings: display: panel: Add Novatek NT36536
  drm/panel: Add Novatek NT36536 panel driver

 .../display/panel/novatek,nt36536.yaml        |  90 ++++
 drivers/gpu/drm/panel/Kconfig                 |  11 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 drivers/gpu/drm/panel/panel-novatek-nt36536.c | 494 ++++++++++++++++++
 4 files changed, 596 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/novatek,nt36536.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-novatek-nt36536.c

-- 
2.54.0

