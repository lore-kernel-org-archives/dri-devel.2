Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61DF3CD3436
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 07:05:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F91210F398;
	Fri,  8 May 2026 07:04:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="TZ7DwyFk";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E487F10F389
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 07:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778223898;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=WDLrnBsL1sK2PwoR7fSEo7yQJ46Xs/LW+n8piri14To=;
 b=TZ7DwyFkO2Ok3EDwcDjWea78Pv74lB0UOEHMdPuaNlPiLgiOz1Hb9naq3va9r+IHilFb+2
 sYmFnzDZnsImo0D89gB74Nvy4ppgS1v5AaOsnraIpCLb2yVEPkP2hr9j2MS6vM/WU93oD1
 xps8zVR8MyFJTDxql/HoZx9his7/z30=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-558-JZ_EtmUnN2GxdDU7SJpYww-1; Fri,
 08 May 2026 03:04:54 -0400
X-MC-Unique: JZ_EtmUnN2GxdDU7SJpYww-1
X-Mimecast-MFC-AGG-ID: JZ_EtmUnN2GxdDU7SJpYww_1778223892
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4084B195609D; Fri,  8 May 2026 07:04:52 +0000 (UTC)
Received: from [192.168.1.153] (headnet01.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.101])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E28D3300019F; Fri,  8 May 2026 07:04:48 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
Subject: [PATCH v2 00/10] drm/panel: Use refcounted allocation for
 remaining panel drivers
Date: Fri, 08 May 2026 09:04:40 +0200
Message-Id: <20260508-drm_panel_init_rm-v2-0-0bd4ac429971@redhat.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23NQQqDMBCF4avIrJuSpGqqq96jiIQ4qQM1kYlIi
 3j3pkJ3Xf4P5psNEjJhgrbYgHGlRDHk0KcC3GjDAwUNuUFLXctK1mLgqZ9twGdPgZaeJ3GxZXl
 tjFReSch3M6On12Heu9wjpSXy+3ixqu/608wfbVVCikr5bDrjdKNujMNol7OLE3T7vn8AHJ3Ra
 rMAAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778223888; l=3271;
 i=aesteve@redhat.com; s=20260303; h=from:subject:message-id;
 bh=zPvX6XO7f5tC2a919WneKz5UDrIfz6rBWAUggNl/B3M=;
 b=434xQ8UxPkRgAMb+7Z7IUWa3Mtg+C2jO8rC44WYAzLp9iszh2I+8au1kQ0pcApxHKYUIvuUHe
 ciossgzK/n7BgrZOUGNfj7Lp/HAUaCdmdF8uOFYeuMdhE4PxlRIWAZ9
X-Developer-Key: i=aesteve@redhat.com; a=ed25519;
 pk=YSFz6sOHd2L45+Fr8DIvHTi6lSIjhLZ5T+rkxspJt1s=
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: vWeR-eJS7EXCG4_VtUl3Ij2knfEC36-YRGuuboHK3CI_1778223892
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
Changes in v2:
- Remove drm_panel_init/alloc precedence mentions in kdocs
- Link to v1: https://lore.kernel.org/r/20260507-drm_panel_init_rm-v1-0-51f448c7c291@redhat.com

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

 drivers/gpu/drm/display/drm_dp_helper.c             |  2 --
 drivers/gpu/drm/drm_panel.c                         |  7 +++----
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
 12 files changed, 57 insertions(+), 62 deletions(-)
---
base-commit: 74fe02ce122a6103f207d29fafc8b3a53de6abaf
change-id: 20260506-drm_panel_init_rm-3a4489701f10

Best regards,
-- 
Albert Esteve <aesteve@redhat.com>

