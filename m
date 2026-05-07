Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 439DACD343F
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 11:53:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B08AC10F02F;
	Thu,  7 May 2026 11:53:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="GFuRzYYI";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9D1210F02F
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 11:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778154804;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=dqv0zewb+mB9YOh/iwiNtku4IW670gSU4IUgUjoQOUQ=;
 b=GFuRzYYILRScuXzf2vVMySYL3bGRy5JPoy1zxvOHiJihEMKr0X6YjcQILJm2lYZv3vuihN
 JzlOB+qWyYHoTnQp6mJMD6n29+z8noCDjiqMZ0D1NlQB9CDvpoix2slZYDW+xqtT4lBpvJ
 MP+JzwLEkjddOBJ/VqkmG+cjBU+nQ58=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-447-GWQ82iRKN2qWwIuNnGzPPw-1; Thu,
 07 May 2026 07:53:21 -0400
X-MC-Unique: GWQ82iRKN2qWwIuNnGzPPw-1
X-Mimecast-MFC-AGG-ID: GWQ82iRKN2qWwIuNnGzPPw_1778154799
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 46D4D1955DCD; Thu,  7 May 2026 11:53:17 +0000 (UTC)
Received: from [192.168.1.153] (headnet01.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.101])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AAF701944B08; Thu,  7 May 2026 11:53:13 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
Subject: [PATCH 00/10] drm/panel: Use refcounted allocation for remaining
 panel drivers
Date: Thu, 07 May 2026 13:52:58 +0200
Message-Id: <20260507-drm_panel_init_rm-v1-0-51f448c7c291@redhat.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MSwqAMAwA0atI1hZS/3oVkVI0akCrpCJC8e4Wl
 28xE8CTMHnokgBCN3s+XIROExhX6xZSPEVDhlmFJVZqkt2c1tFm2PFlZFe5LYqmrVHPGiF2p9D
 Mz//sh/f9AGWoRlpjAAAA
X-Change-ID: 20260506-drm_panel_init_rm-3a4489701f10
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Michael Tretter <m.tretter@pengutronix.de>, 
 Michael Walle <mwalle@kernel.org>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Albert Esteve <aesteve@redhat.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778154793; l=3092;
 i=aesteve@redhat.com; s=20260303; h=from:subject:message-id;
 bh=wACrlXRkFryBPuuM4IxESD8nJ+I0xShiVyq/JXQxDD4=;
 b=Bs3gIfdmr9SRNiznMDG8u+fPVPALk1wcx+UDr7ufjI8tvSiP1wTyBsNwsEvMonit65OzGWsyc
 T+85v3V1pytALSNcm2FV1RHt91lvs+KPX2ZPHqSi0iWvWzROVe5DNY7
X-Developer-Key: i=aesteve@redhat.com; a=ed25519;
 pk=YSFz6sOHd2L45+Fr8DIvHTi6lSIjhLZ5T+rkxspJt1s=
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: ucbJF2S1nnE4S6oftDTrGXEkRKPM-qME58G4X5ht7mA_1778154799
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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

This series converts 9 remaining panel drivers from the deprecated
devm_kzalloc() + drm_panel_init() pattern to the refcounted
devm_drm_panel_alloc() API. This follows the work by Anusha Srivatsa
who introduced the refcounted panel allocation infrastructure [1] and
converted a first batch of drivers [2] (the last part of a 5 sub-series).

Reasoning:
----------
The old allocation pattern is unsafe: when the panel device is
unbound, devm frees the context struct immediately, but the DRM
device may still hold a reference to the embedded drm_panel through
the panel bridge, leading to a use-after-free. devm_drm_panel_alloc()
wraps the allocation in a kref scheme, so the memory is only freed
when the last reference is dropped.

After this series, there are no remaining callers of drm_panel_init()
under drivers/gpu/drm/panel/, and drm_panel_init() is entirely removed
from the public API.

[1] https://lore.kernel.org/all/20250331-b4-panel-refcounting-v4-0-dad50c60c6c9@redhat.com/
[2] https://lore.kernel.org/all/20250710-b4-driver-convert-last-part-july-v1-0-de73ba81b2f5@redhat.com/

Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
Albert Esteve (10):
      drm/panel/visionox-g2647fb105: Use refcounted allocation in place of devm_kzalloc()
      drm/panel/samsung-s6e63m0: Use refcounted allocation in place of devm_kzalloc()
      drm/panel/novatek-nt37700f: Use refcounted allocation in place of devm_kzalloc()
      drm/panel/lxd-m9189a: Use refcounted allocation in place of devm_kzalloc()
      drm/panel/ilitek-ili9806e: Use refcounted allocation in place of devm_kzalloc()
      drm/panel/tdo-tl070wsh30: Use refcounted allocation in place of devm_kzalloc()
      drm/panel/sharp-ls043t1le01: Use refcounted allocation in place of devm_kzalloc()
      drm/panel/truly-nt35597: Use refcounted allocation in place of devm_kzalloc()
      drm/panel/startek-kd070fhfid015: Use refcounted allocation in place of devm_kzalloc()
      drm/panel: Make drm_panel_init() static

 drivers/gpu/drm/display/drm_dp_helper.c             |  2 +-
 drivers/gpu/drm/drm_panel.c                         |  8 ++++----
 drivers/gpu/drm/panel/panel-ilitek-ili9806e-core.c  | 10 +++++-----
 drivers/gpu/drm/panel/panel-lxd-m9189a.c            | 11 ++++++-----
 drivers/gpu/drm/panel/panel-novatek-nt37700f.c      | 11 ++++++-----
 drivers/gpu/drm/panel/panel-samsung-s6e63m0.c       | 14 +++++++-------
 drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c     | 11 ++++++-----
 drivers/gpu/drm/panel/panel-startek-kd070fhfid015.c | 12 ++++++------
 drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c        | 14 +++++++-------
 drivers/gpu/drm/panel/panel-truly-nt35597.c         | 10 +++++-----
 drivers/gpu/drm/panel/panel-visionox-g2647fb105.c   | 13 ++++++-------
 include/drm/drm_panel.h                             |  4 ----
 12 files changed, 59 insertions(+), 61 deletions(-)
---
base-commit: 74fe02ce122a6103f207d29fafc8b3a53de6abaf
change-id: 20260506-drm_panel_init_rm-3a4489701f10

Best regards,
-- 
Albert Esteve <aesteve@redhat.com>

