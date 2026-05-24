Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31840CD5BAB
	for <dri-devel@archiver.kernel.org>; Sun, 24 May 2026 16:27:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4593B10E2D1;
	Sun, 24 May 2026 16:27:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="o7izL9+O";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B41110E25F
 for <dri-devel@lists.freedesktop.org>; Sun, 24 May 2026 16:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1779640062;
 bh=QFCgggknjOATRW/TDy4B91bZJukHxDqEhm2761Ixqtw=;
 h=From:Subject:Date:To:Cc:From;
 b=o7izL9+O6MhzByckC2blHRZQN5pNHxAK4XT2KWmx/sneSlmeVKJ8siB0P5jftYFdY
 qY5NERwfXXEsxJsu0IQcCnH1Yw+hvC5Rdywi/5lFowb5xLn9KPk84XB+7trtCKBXHo
 bW0NFYsk7DENKZqE/HJUYxNdX7sjBW3f7+55DPNtX+FteQNVZodct5r4Mfzpuph6L1
 A+lNa34GXp5KUJDcKOqEjWwbZXtYIGajhCAktXqfh1sPKawnX8YYj12dptA3GJBbnm
 B6/TIzo5i/aQEgaiQZo60eXlF0EB9f1CqaMNJYM9UAtWNfCuK6vMmYGrOeQHfjvBZI
 xdCaNbd2h6Uzg==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 1B97217E093F;
 Sun, 24 May 2026 18:27:42 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Subject: [PATCH 0/2] YUV support for VOP2 background color
Date: Sun, 24 May 2026 19:27:27 +0300
Message-Id: <20260524-vop2-bg-yuv-v1-0-dcb6a52923f5@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQ5AMBBA4avIrE1SjZ/UVcRCa9RYIC0NEXdXL
 L/Fexd4ckwe6uQCR4E9L3NEliZgxm62hNxHgxSyFIXMMSyrRG3x3ANmWlDZCWWKSkEsVkcDH9+
 taX/7XU9ktncB9/0A2WOk528AAAA=
X-Change-ID: 20260524-vop2-bg-yuv-1b0e6a09c579
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
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

Since commit bec7cbfa7d4f ("drm/rockchip: vop2: Support setting custom
background color") the VOP2 display controller allows configuring the
background color of each video output port.

However, this is currently limited to RGB formats.  When operating in
YUV overlay mode, the color must be programmed using YUV format.

Add the necessary RGB-to-YCbCr conversion logic, covering all color
spaces supported by the display controller: BT601L, BT601F, BT709L and
BT2020L.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
Cristian Ciocaltea (2):
      drm/rockchip: vop2: Rename CSC_BT2020 to CSC_BT2020L
      drm/rockchip: vop2: Add YUV support to background color

 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 154 ++++++++++++++++++++++++---
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.h |   2 +-
 2 files changed, 139 insertions(+), 17 deletions(-)
---
base-commit: 213c92ac9717e4951f052a499f91c89302889813
change-id: 20260524-vop2-bg-yuv-1b0e6a09c579

