Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0D07C61DD3
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 12:10:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4043010F54F;
	Thu,  3 Sep 2026 12:10:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="qgMElyhh";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5CC910F54F
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 12:10:20 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id AA16BC1;
 Thu,  3 Sep 2026 14:08:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1788437327;
 bh=1o0HV5ptWkPncFS17Yk0IazxMvMPnOZ52wTQeaFw8m8=;
 h=From:Subject:Date:To:Cc:From;
 b=qgMElyhhxG0A24A1GewZoUxbSi6gILlE3nNMo6SiBfUt5H8DWB4/4MNuT0DR45KmI
 OLLnKaSxSKY/vuXlKZbMPREGbe0CBUW7ezuUPbq/ZBWriD14n7twRh3bL/IpRBJEEJ
 uQ6+fNbFyQJRswxnz9bxNYsRH4nlw+fOPvC6n4cw=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: [PATCH 00/10] drm/tidss: Preparation for AM62P and BeagleY-AI
 display support
Date: Thu, 03 Sep 2026 15:09:50 +0300
Message-Id: <20260903-tidss-pre-beagley-v1-0-93928baa8b12@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI9jmWoC/yXMQQqDMBCF4avIrDuQTjEQryJdJGaqI6Ilo2IR7
 26sy4/H+3dQTsIKVbFD4lVUpjHj+Sig6fzYMkrMBjJkjTMvnCWq4jcxBvbtwD8sI5G3LhBZB/m
 Xt49s/2b9vq1L6LmZrxAcxwmT7uH1dQAAAA==
X-Change-ID: 20260903-tidss-pre-beagley-5d22a69b2269
To: Devarsh Thakkar <devarsht@ti.com>, Swamil Jain <s-jain1@ti.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2247;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=1o0HV5ptWkPncFS17Yk0IazxMvMPnOZ52wTQeaFw8m8=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBqmWOikW23aSBgqTDlri5ZUITdtqYCp3PVbIM4Q
 4gZWtl9B62JAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCapljogAKCRD6PaqMvJYe
 9fufD/9wUYoQgNWY+KAqZ1NHV9RCbejZ5I7mkj6R1vF7YxEfKdrjYdgdTTOk2DhNrH9csnXv+7D
 BQRNz16s9ZLu1nrZAGiS5nEc+1a4jBJZLueP3Pkp1/b+MT6THF0sJHtvHp/MX4F4t6hL+mweISs
 /w/WjEVS2YJL5gZ1fSKhuIohsE9l7vsu7O/l7yWHhxJVY2svFfNXZ9CGegz2mLzl3WPRhoEUrZf
 qbnkFxp8Lqwxl4RYljJk3imbkB9scVVQyXZ+n64WWbGV1ESgbTNOsJJknmWGb0Tc/ULZe8FSfKZ
 pqXrYMTuqnPc7jGWUh2vgKuvAqTeOqij2ZjM2X4vVTwaF9VDVrb+vjQwsDmwsz6er7S1/GCWdW5
 ub9JkYWx1Furi8Adr7UUhShpr1kAg9nfzDNLRJCbeOoSviamCsblBbjG0vkg4Fiw6tlmy0SgDKQ
 ACapwSAdh+kbB7SbOBovTSPLhfb824M+QJ9qJk7lTQ90NaemetrWkyRTKx9G/2lt9+iojGXLbmY
 GH4rndRve+Hsjqz4OimoOQKykNcGbHAEJAb6QR7KacUNDFudh3q4c14hFtI7RssfVoM1d+escpS
 +hRtToqysYnhCLxz6Ha38bHhuJYJpJ0BO6UVcPIGtyzmV/pD6+4QOOl42q/RKURKHIH+vJWXvsD
 gLouZ2XjbzK07hA==
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

This is a reduced set from the original "[PATCH v3 00/15] drm/tidss: Add
BeagleY-AI display support (and some more)" series, with a few new ones
on top. I have dropped the patches that still have unresolved issues.
Essentially that means AM62P and BeagleY-AI support is not added in this
series, but all these patches stand on their own and are needed for the
future AM62P support.

Most of these have already been reviewed.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
Tomi Valkeinen (10):
      dt-bindings: display: ti: Move ti,am62l-dss binding to a new binding file
      dt-bindings: display: ti,am65x-dss: Simplify binding
      dt-bindings: display: ti,am625-oldi: Add optional power-domain for OLDI
      drm/tidss: Remove extra pm_runtime_mark_last_busy
      drm/tidss: oldi: Remove define for unused register OLDI_LB_CTRL
      drm/tidss: Add mechanism to detect DPI output
      drm/tidss: Add support for DPIENABLE bit
      drm/tidss: oldi: Fix OLDI signal polarities
      drm/tidss: Drop WARN_ON() from tidss_runtime_put()
      drm/tidss: oldi: Fix missing of_node_put()s in error paths

 .../bindings/display/ti/ti,am625-oldi.yaml         |   3 +
 .../bindings/display/ti/ti,am62l-dss.yaml          | 136 +++++++++++++++++++
 .../bindings/display/ti/ti,am65x-dss.yaml          | 149 ++++++---------------
 MAINTAINERS                                        |   1 +
 drivers/gpu/drm/tidss/tidss_crtc.c                 |  10 +-
 drivers/gpu/drm/tidss/tidss_crtc.h                 |   4 +-
 drivers/gpu/drm/tidss/tidss_dispc.c                |  28 +++-
 drivers/gpu/drm/tidss/tidss_dispc.h                |   5 +-
 drivers/gpu/drm/tidss/tidss_dispc_regs.h           |   1 +
 drivers/gpu/drm/tidss/tidss_drv.c                  |   7 +-
 drivers/gpu/drm/tidss/tidss_kms.c                  |  70 +++++++++-
 drivers/gpu/drm/tidss/tidss_oldi.c                 |  46 +++++--
 drivers/gpu/drm/tidss/tidss_oldi.h                 |   1 -
 13 files changed, 323 insertions(+), 138 deletions(-)
---
base-commit: 97c594f71fa71dc30a0583a76d8b6ef5c5ea10b1
change-id: 20260903-tidss-pre-beagley-5d22a69b2269

Best regards,
--  
Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

