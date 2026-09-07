Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B181C79F99
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 11:14:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A59F410E187;
	Mon,  7 Sep 2026 11:14:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="GnAYek+1";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E627F10E187
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 11:13:58 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 06351177;
 Mon,  7 Sep 2026 13:12:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1788779542;
 bh=56OAbhQ3adSKBuifYbnSJEbDr51GFitcGCdxj2RVnrU=;
 h=From:Subject:Date:To:Cc:From;
 b=GnAYek+1KSXBPFfvXgdQMPK8V96zl0qC8HHoZhHOEhC+xr8qI/y7QeHfioviIU07+
 MkwSO1puQ25YT6I3rJvIFzpjJJRpFd2imVAgSr2XGKViCRVCI407E6sVSdnXo3w1hh
 XIz0eO7VdA08LzRNUZHDD1b3iVP0+7WHnIrx48g0=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: [PATCH v2 0/3] drm/bridge: cdns-dsi: A few fixes
Date: Mon, 07 Sep 2026 14:13:34 +0300
Message-Id: <20260907-cdns-dsi-fixes-v2-0-96d9b116e9bc@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF6cnmoC/3WMSw7CMAwFr1J5jVES+oMV90BdtLVLvSBBMYpAV
 e5O6J7lvKeZDZSjsMKl2iByEpXgC7hDBfM6+jujUGFwxrXm5DqcySuSCi7yZsWa7dSYlmvbEBT
 pGXk/inMbCq+irxA/ez/Z3/o3lSwaNH3PRLXhc7dchXjU4KcwRjrO4QFDzvkLGz/efLMAAAA=
X-Change-ID: 20260327-cdns-dsi-fixes-4e1b506e415d
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Devarsh Thakkar <devarsht@ti.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=774;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=56OAbhQ3adSKBuifYbnSJEbDr51GFitcGCdxj2RVnrU=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBqnpxvXFXEosRWQ3KOSFa+ktGEFsaPs8ePKYJak
 Qp0hNVFH96JAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCap6cbwAKCRD6PaqMvJYe
 9ZXsEACu2AE/fl6FTXTyI0DZtGJyUuTTuMEjxSdXm+arKiPDPUiBB6UWaaepMOJirZWGWzAXpfa
 PeFz0Gj9PQy5jsN63vsVOKRMfhNoLNEZUmk7py48xM+47WTIXkNKPzI0ueZbw6A6ZtqQP6502HR
 gRcpfMal8h2h9YBMRh6QVlYfgxhlkbQuW77KcqPtl/QMwUuy5wWsUZjQ91TgXgR7dOf/se1lLMr
 lDaDkAhkFROeyeyY0UiaaFGQ6NFFNPXMvQW9HcXTLbmDiY8M8GGx2DFbeT9u3suVENJaDM4t9lc
 nZ7eU8pSm8skFZBwgiTIzSod4gpkywswA1iY+ouqH7wZDT07+pMFnSVw/rluZ0hkgcqxcat1Dzy
 005xKNsmQkLzZiGyQC8CVgqUj2dyj0WVMBYQB2jPTovPAYtlyLC2uZe2bXhoZtattl2AliBWOiS
 ywZ7Eycc7hHdxan2se4EVEvzvK2UvrtZ9pdoWTZTgxDYKaVZ7epnf98ARzyv2p94GTdv1QLaoaf
 yw46J9Xj3vDtfKBZhXSHYi7VGUOqIRU/ste5GwVU6KrU8XfA7l1lvExsPcn7o/MlgxuptndlWZL
 c1YiYuR5nlJQG4j313USt8yvDEp+IaHvFtKSzv0ndO/woOa/r5QmujjJaes8MSjYuivax63VAXC
 Ogibblr9HvpDWlA==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5
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

Cadence DSI bridge fixes for missing stop-state and bus flags.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
Changes in v2:
- Add Fixes: tags
- Link to v1: https://lore.kernel.org/r/20260327-cdns-dsi-fixes-v1-0-088edd40e97f@ideasonboard.com

---
Tomi Valkeinen (3):
      drm/bridge: cdns-dsi: Add clk debug print
      drm/bridge: cdns-dsi: Fix stop-state at enable time
      drm/bridge: cdns-dsi: Fix mode and bus flags

 drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)
---
base-commit: df2908090cda368b01ff43709f51890076c56157
change-id: 20260327-cdns-dsi-fixes-4e1b506e415d

Best regards,
--  
Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

