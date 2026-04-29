Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FCCFFF8875
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 09:59:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2DC110EEFF;
	Wed, 29 Apr 2026 09:59:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="MZlO9R2B";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA26410EEFF
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 09:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1777456756;
 bh=TF5ce7a1hK8I+tQv5MlsWOrZ1SFQR0W0h74iMjRsckg=;
 h=From:Subject:Date:To:Cc:From;
 b=MZlO9R2BIZUsr5JLlzrvbxrG+OIEu7C3PV9K7g/F2uC3d4pmMr6DVAd0hjuc8rN7C
 g6bZ1djAxhyNniADCcHeIv1sZi7VXs/nmaYwv7yArlEWIXWZYSlgUWyVTy8ucPcKoT
 W2tQbon3d5vd9CetHO+o1jB1JNsKm5YFn4O/9BRvVtDwtCJShvT0AVkz4gEfsj3HCe
 dM3DHP/rgdPTr+zaXcJOnb7fZbPDTeCzCPjfVpdYB2lmQ08V3wf9SDwTN7E+RNqPyw
 OtIG8YYWRSIE/ada6qiN8CN9gX2V79K99X60jKT4X1v3uGm51mYIKn1VevfN2cVo1w
 /nIoI/NH/O9ow==
Received: from yukiji.home (unknown [100.64.0.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: laeyraud)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 9C6D617E131F;
 Wed, 29 Apr 2026 11:59:15 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Subject: [PATCH 0/4] drm/mediatek: fix sparse warnings
Date: Wed, 29 Apr 2026 11:58:58 +0200
Message-Id: <20260429-mediatek-drm-fix-sparse-warnings-v1-0-d95c4d118b83@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y2NwQrCMBBEf6Xs2YU0BC39FekhJmtdJGndpFoo/
 XcX6/ENM/M2KCRMBfpmA6E3F56yQntqIDx8Hgk5KoM19mycdZgosq/0xCgJ77ximb0Uwo+XzHk
 seHHGRWo7a1wAvZmFtPZTXIeDhV6LmuoRws3rPkwpce2bTGvFv62DYd+/oMRrvaMAAAA=
X-Change-ID: 20260424-mediatek-drm-fix-sparse-warnings-7404de18204c
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 CK Hu <ck.hu@mediatek.com>, Alexandre Mergnat <amergnat@baylibre.com>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>, 
 kernel test robot <lkp@intel.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777456755; l=1136;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=TF5ce7a1hK8I+tQv5MlsWOrZ1SFQR0W0h74iMjRsckg=;
 b=LxfQX0tyMzx/jWdvideYpWdeIBEBaeVsm7QmrVnk+VO54njMPWiGYzvbVKzTiX/NgWQ0MrP0N
 pgKBYWIGs2vBGuC/xlPL6sc6eAHLQbG+mekspcZ1lSe3uw5RmNRaPTL
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=
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

This series fixes in the mediatek-drm driver the sparse warnings
reported by [1] and two others introduced during v6.16 development
cycle.
    
The series has compile-tested and is based on linux-next (tag:
next-2040428).
    
[1]: https://lore.kernel.org/all/202604132044.fcYjEcU8-lkp@intel.com/

Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
Louis-Alexis Eyraud (4):
      drm/mediatek: mtk_hdmi_ddc_v2: Fix non-static global variable
      drm/mediatek: mtk_hdmi_v2: Fix non-static global variable
      drm/mediatek: mtk_cec: Fix non-static global variable
      drm/mediatek: mtk_hdmi_ddc: Fix non-static global variable

 drivers/gpu/drm/mediatek/mtk_cec.c         | 2 +-
 drivers/gpu/drm/mediatek/mtk_hdmi_ddc.c    | 2 +-
 drivers/gpu/drm/mediatek/mtk_hdmi_ddc_v2.c | 2 +-
 drivers/gpu/drm/mediatek/mtk_hdmi_v2.c     | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)
---
base-commit: 0f3ef35b0747832b58b97171bad99011d084c6b1
change-id: 20260424-mediatek-drm-fix-sparse-warnings-7404de18204c

Best regards,
-- 
Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>

