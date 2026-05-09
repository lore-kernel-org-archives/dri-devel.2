Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30DB9CD37B5
	for <dri-devel@archiver.kernel.org>; Sun, 10 May 2026 10:07:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5AD410E635;
	Sun, 10 May 2026 10:07:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gEg2ZEul";
	dkim-atps=neutral
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com
 [209.85.210.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2872510E101
 for <dri-devel@lists.freedesktop.org>; Sat,  9 May 2026 16:24:25 +0000 (UTC)
Received: by mail-ot1-f46.google.com with SMTP id
 46e09a7af769-7dcd54a8d17so186552a34.0
 for <dri-devel@lists.freedesktop.org>; Sat, 09 May 2026 09:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778343864; x=1778948664; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kgw+L8XNnYGvME6rXbV9iC3YSJ8U6lhlX0++8uG2LmQ=;
 b=gEg2ZEulHN6AJ6IvTw+kKDcFUpPeH5DUfo+iO7caFt9DPCRB1UEHbc/Mc6ekbYGvgk
 qGlViM7pnJCl+/maNAyDgxEvcW0fZUpZLkOVhKN2SgzaIMdIkRjuGOa4n85r4Rt5vilM
 MV4S8+BiA8d6vKokkxB9rJxPfBbfQb+MssWRl1tTfig22NSl2e0+ROTMpjxmyiPUKroI
 RSHFtUXkabwxqL4bOhM0Ee2JaEZONSngliyx9d6MwuZNUK5/C0pHEVeYWpOtPzX2n4Vk
 mC6ePJLwIxfKdpDCfaqDNvsw2DmobG1cOY8ChNLNkj4q40hxn372/x5bEIVaT6xBGZwJ
 3jWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778343864; x=1778948664;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kgw+L8XNnYGvME6rXbV9iC3YSJ8U6lhlX0++8uG2LmQ=;
 b=U4q6hKtNPJZCu1W+WFjlljBY0VkMfGtCK1vgtjzPnLHhXR33w0z5dLhyNSVXXGa84w
 Y78QiE8Ma9FoBmEl09Ecv0bpi4QlwsfD3VpygX249/gzfSOetErNgZOl0/NG8gKG0UqD
 8PnLDcdNzzfj06x/TYu1ZRlBIH+pAg1x8WAtOKhvQwCZqKl4aXYn0V8LTJwL72YFizMz
 HQUe2vrtkXu+oiYScevNSAEhPrXiul06qBg4Ld9JBMfoo7VnEeXDt7FRmoxzyjdJ1mTK
 xMkLnDd5Qp07/h32k9ob9SzYj7iSnA/L1ILrsHTZM8n1uT8ywNpS3InPg24bcbf9B0ox
 jfdg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/G1S+c5J+d7JBAjnCeA11RlP/6US4ayBF8B4rR+z+TPb4VZlTrBomiBmynTNh1Mx+6hfoGfvqAWfE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwJgLNsV4hDwA91BimuGR8aJwaTXV5h3THEhyIM/biSjFNujbjA
 r/bi+bc+fkIeAKrsyOCFYWoFNezNH77or2GOQVufzcM4eEb5uQdximmmzXXiN89kq1s=
X-Gm-Gg: Acq92OFXOERZCnOBNGzh5EG/tlZhTgae6dQlEnCSupv9VH5lcjZ/rJGBFyvUWyriU1R
 x0Y/OI6dbAH4UGuwVPGRCnSMgL7otriNfwsatd4y529sWnytf6j6IOUbeSbkVBfuVnWXnBqF0Zt
 cBksWjLlB+U4nLSfrnKRmk96CkuEGEFiWi4bKyrLJXEHcdCyRzBOdPw29XrrjovT6iOu7VPYd4n
 OW4kpKuEH/HM6Xal5iHPmhDppQbzHhg19Gy2J7ehHFukm4g8VVTYtv94KUbFHSntpJWGEk531vU
 BfKDz30Ws4Jb1YI8a5HeM0Hz5/NmeyU+Odf5/6pHvA30iAJnkB9rZ/LwYTihwXvqJ/q+xjrYDy7
 vRO0Fp91IslOIyZST4ukB36knD1/7W8kA7hNXu86zFBpLvhqYFN94yhqzx+flj1W2ssVU0qGnFL
 O1SPSPPIZQYdBQY4YjpsM2XcORtqkY28venHXyco4G657fL1D79GQXTbYPYOVF/mUGRS90FU1d+
 qhoiDFEPC8GtA9XM9vEwDTd
X-Received: by 2002:a05:6808:4f65:b0:47c:3d8d:1ff8 with SMTP id
 5614622812f47-48045236867mr5560241b6e.7.1778343864317; 
 Sat, 09 May 2026 09:24:24 -0700 (PDT)
Received: from localhost ([136.49.184.116]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-47c76986404sm16691775b6e.15.2026.05.09.09.24.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 May 2026 09:24:23 -0700 (PDT)
From: Aaron Esau <aaron1esau@gmail.com>
To: intel-gfx@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 jani.nikula@linux.intel.com, rodrigo.vivi@intel.com,
 joonas.lahtinen@linux.intel.com, tursulin@ursulin.net,
 mika.kahola@intel.com, stable@vger.kernel.org,
 Aaron Esau <aaron1esau@gmail.com>
Subject: [PATCH 0/3] drm/i915/cx0: fix PLL enable failure handling on Meteor
 Lake
Date: Sat,  9 May 2026 11:24:04 -0500
Message-ID: <20260509162407.510539-1-aaron1esau@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 10 May 2026 10:07:04 +0000
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

On Meteor Lake with a hybrid Intel/NVIDIA GPU setup, s2idle resume can
leave the CX0 PHY MSGBUS unresponsive. When this happens, the PLL
enable sequence silently fails: register writes via MSGBUS are dropped,
the PLL never locks, but the driver marks it as enabled and proceeds to
drive the pipe.

The root cause of the MSGBUS becoming unresponsive appears to be the
NVIDIA dGPU not participating in S0ix (addressed via the
NVreg_EnableS0ixPowerManagement module parameter). However, the i915
driver should handle PLL enable failures gracefully regardless of the
trigger.

This series:
  1. Fixes intel_cx0_pll_is_enabled() to check the hardware ACK bit,
     not just the driver-set REQUEST bit, so a PLL that failed to lock
     is correctly reported as disabled.
  2. Adds error propagation through the DPLL enable path: changes the
     .enable callback to return int, threads errors through
     _intel_enable_shared_dpll() and intel_dpll_enable(), and checks
     the result in hsw_crtc_enable() and ilk_pch_enable().
  3. Makes the CX0 PLL enable path return -ETIMEDOUT when the PHY
     fails to come out of reset or the PLL fails to lock.

Found on a Lenovo ThinkPad with Intel Ultra 7 155H and NVIDIA RTX 2000
Ada. Kernel traces before each crash:

  i915: Failed to bring PHY A to idle.
  i915: PHY A Read 0c70 failed after 3 retries.
  i915: Timeout waiting for DDI BUF A to get active
  i915: [CRTC:149:pipe A] flip_done timed out

Aaron Esau (3):
  drm/i915/cx0: check PLL ACK bit in intel_cx0_pll_is_enabled()
  drm/i915/dpll: add error propagation to DPLL enable path
  drm/i915/cx0: return errors from CX0 PLL enable on failure

 drivers/gpu/drm/i915/display/intel_cx0_phy.c  | 54 ++++++++----
 drivers/gpu/drm/i915/display/intel_cx0_phy.h  |  6 +-
 drivers/gpu/drm/i915/display/intel_display.c  | 10 ++-
 drivers/gpu/drm/i915/display/intel_dpll_mgr.c | 87 ++++++++++++++-----
 drivers/gpu/drm/i915/display/intel_dpll_mgr.h |  2 +-
 .../gpu/drm/i915/display/intel_pch_display.c  |  7 +-
 6 files changed, 117 insertions(+), 49 deletions(-)

-- 
2.54.0

