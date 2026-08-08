Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5DA7C5B571
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 06:38:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C1AB10E64E;
	Mon, 10 Aug 2026 06:37:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pYcEhLtX";
	dkim-atps=neutral
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com
 [209.85.215.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D1A210E043
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 22:29:29 +0000 (UTC)
Received: by mail-pg1-f169.google.com with SMTP id
 41be03b00d2f7-c9e607d81fcso344246a12.2
 for <dri-devel@lists.freedesktop.org>; Sat, 08 Aug 2026 15:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786228169; x=1786832969; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=l7mobE6iuvRSDNq5l6lCLR+AOwfPsO7VXjaRec5r9EE=;
 b=pYcEhLtX/m/JyuyasHWdyevFuMgK4zZm+WALPEsDO0sUuTVORahWbqEpiTmq7fOAKP
 edXL+2d6fFDWvKrf6tcI6CXR8YEDFU20nAKPFWIQmDd9WtpIeQraPZ+pnc9gvZG16C45
 Xkb78DleOXPfUmGHxI8NXritWEYFImsFIGOkbN6uurUJ88zOHIO1Eu2irzEeriv7dkXG
 AQD/t2FZtiBOD8ufUBir7IHyptmuo6rJDMzNsQf0rG4Phh0rkHmq/BB/7ZLctPG9Ae6j
 rw1VxcUWVVuhRDu27QmCbT42mxcjTfAqRhH4R86woBqE++gX0kTtXsh+DrEizp7dGSeK
 EGrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786228169; x=1786832969;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=l7mobE6iuvRSDNq5l6lCLR+AOwfPsO7VXjaRec5r9EE=;
 b=Kmemj85DJNnWWRGES1tMu7q/684/xqXYAcJkU5sWJN7hSzztjQbRrrv8ptenfviAeH
 0vzkxwJ0brShyzmaMufz5lqvNHL1UvK1AfRfrTY+92R6et6SrYvzAU1hwlaX1g34R7vq
 gAxUAcCbHTrPFqlgw7uYydsU7v5VonLYGSeJRwxHL8A4o6137Ak16iccPyS0KBXc0ewJ
 dd6OzTHet0Ydhdwa1mpbYGAU7LVt9B9TfX6KxJsw0U8nym8aAPiOcH5Ph0EnFh8etmVm
 W0IWZvtTo/84wI90/tAyTdTqpMj5m2sQzjv00pr8rIRNmX5Nj17YiUpXllEZ4zubEwcF
 SEmA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoWQp8OFp6PbXpcdtt/9b5dZEeu8hgE6c4re3fZfdXXMP4CeqlrrUbJCNmd+GHKDg70LlQfnBKwmFg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzX4MK4mvlz0QH5CcYspf+k1X4n6ZYzRRvb2xbWOhzMXzAUbSWv
 JF9Pif9nIkoEZ0NPdU+KSMz6e3Z9ir2YobHEbqCNWcHXnyoPt6pM+tnzHNGm7wJ7
X-Gm-Gg: AR+sD13v4sSkDyyENw7jboqdXO2IsYAcok/H0ipdplqa6KYQNwaUiZ2Ac/QH8JTe0AV
 6kvOLc725zQ8vwkLC0RuAmPXc8r0rtjLxA6K5wHUujy/fzFHbwIhQg3ROSrFFRhzioPEN+DScAS
 LUxxveVSNSi7ltq6SBEKlTVIUpUklrIAhi5BiikoCCa0+AFeWLnLMAbP3lD3pNK1DJ1x1D0b+kq
 fs+kXEmK8YUpt5Md2r4klLNzjz5E0AlwpAZf5mdxjPnN51ysEvkFsELKpl+pEhhdZ7PA8e2jmJO
 k1gMw+/Il+uwpQCbhxVzX5or2AXMLTnXjw5UD+4LHEnifsX/4EgMgxly7Hh1TulN+0TNqsFJ2JG
 kqRCTbH4VfKeToBRjST2cpilX3kjryv2nclBTGF8WqyOp+penHZ8KqNl6UB/daNfVERSnOerTfP
 5Phiv63JDCZeAjyRNDd8/DrHxCgwgae2jk89HbeDu/KMvJOOVroYQHAIf+VPX/I/rX0eTmmTIe8
 zjXxZWaDllyTiXgHGVKHg==
X-Received: by 2002:a05:6a20:7349:b0:3c6:3c5b:f2e1 with SMTP id
 adf61e73a8af0-3cbadcfcacfmr19149793637.32.1786228168911; 
 Sat, 08 Aug 2026 15:29:28 -0700 (PDT)
Received: from localhost.localdomain ([103.178.204.72])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315beb877b4sm27463910eec.19.2026.08.08.15.29.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 15:29:28 -0700 (PDT)
From: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, airlied@gmail.com, simona@ffwll.ch,
 Sreeraj S Kurup <sreekuttan2156239@gmail.com>
Subject: [PATCH v2 0/5] drm/amdgpu/aca: Robustness and safety fixes for ACA
 driver
Date: Sat,  8 Aug 2026 22:27:37 +0000
Message-ID: <20260808222742.2859-1-sreekuttan2156239@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 10 Aug 2026 06:37:47 +0000
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

This patch series addresses several race conditions, boundary check bugs,
logic inversions, NULL pointer checks, and buffer size parameters across
the AMDGPU ACA (Accelerated Compute Architecture) driver subsystem.

v1 -> v2:
  - Patch 3: Updated remove_aca_handle() to use list_del_init() instead
    of list_del(), ensuring list_empty() properly evaluates removed
    handles and avoiding potential UAF during device teardown.

Sreeraj S Kurup (5):
  drm/amdgpu/aca: Fix race condition and UAF in error cache logging
  drm/amdgpu/aca: Add upper bounds check in aca_bank_hwip_is_matched
  drm/amdgpu/aca: Fix inverted validation logic and handle cleanup
  drm/amdgpu/aca: Add missing NULL check for banks parameter in
    aca_banks_add_bank
  drm/amdgpu/aca: Fix off-by-one buffer size parameter in add_aca_sysfs

 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 33 ++++++++++---------------
 1 file changed, 13 insertions(+), 20 deletions(-)

-- 
2.54.0

