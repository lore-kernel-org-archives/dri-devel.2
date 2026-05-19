Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBC0ACD4F5B
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 16:08:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4464A10EDD0;
	Tue, 19 May 2026 16:08:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Wy64NpnF";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2DCC10EDC9
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 16:08:44 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-48d146705b4so41338925e9.3
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 09:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779206923; x=1779811723; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wxS3QQnk5GN7d0xeWk5k+vZ7DrxTc2p5byKRqEc/Aw0=;
 b=Wy64NpnF7NpXvU3d/e1tmy3+zp5dzHv2jwbN4CLAAHf85h7t7fxL59uE+G0f/YDxk/
 XfRgAYCPNGomKVcoKjAVLmsWoX8t096sWTgxbMiUxD/pAWkXmCJLNOA395EPYp0wLA6H
 wlNZpkZbIe1C3hQdxEoxOYL0rsDOHalwu41TmMReoRiVNQIPeX4v59X+XR8KYRpa1xSZ
 EwYiqooOIOl7hLQ4O8Glmvg/7ErwCa9x5W/gwV+z4/hCW+bpV4sK+eftqm9PQSEJzeV6
 ViS/jBsgPzY5/yhxc/+XOmSuS6+HmLDFsDoJfcXZBbs0fZjvhwM7KnWpEP9gjAUJi4QM
 hqvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779206923; x=1779811723;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wxS3QQnk5GN7d0xeWk5k+vZ7DrxTc2p5byKRqEc/Aw0=;
 b=B7TVcRaLHDbm62izbADRqlrkuhUkq4KHlxJ31TBgJOcsGfLDblMxsRoALXF4tucs87
 irKS2qSiWAv4PIx5AVkP6lIAX0YI3kSWbcqhEb2a9X7ua6OzUDjALMrz4HD/dtU9RfEz
 2w+J9I+goS1Bz4oFQSihR/BpFwZpXszlWyv4+QWNa5hv/4prkYCG7Bx82VlmYQNedvPy
 Sp1Vm4MTk1k22GPrj7Aauybyr+0KvzjZbEKRPxfIhwqOzO1oHtfOMCie/MMIjQ2O/Skw
 JR+e3SOFqXrZFjc6KPewDFapbzNxpvO1cslHAe3BoT0/GnDpfJz2CLJ/UVseX1qEZuzP
 I/uw==
X-Gm-Message-State: AOJu0Yzzm5F0agKuVShUnmKWtFMF0uPScfzpBvjol+IDo1GFP/OOCuRM
 21rUDhyevO32VMzLcwlaqz3IJYlMjTPVL7R100/oQEZJgOj3wpc2jcFt
X-Gm-Gg: Acq92OFQmje9D+nwHs8MF8smDtmyVAFA9MIfH0Woklr4jLQk8AY22dAAKBmjh9AJePG
 Tolsl62QcJl8nHiN4ysWmO+hJksAJwPAjqi8q59mdc5PNCJqnBB3eaAngGJ86Eqvnw2NsYfhT0w
 SM4NWoYDEnQOcD42/SnKiD06M/HqgAr4IbNqfm7j+jFSeK/rK2ADSt4SS6j2gzP6uM04nFPNuLq
 kxezJ0KbhSFo2IAK0vypw9ePjScqZEVKYGFI8yJtKb2wPVKEyO5LA21gku5auV7jAUi47PisKUl
 TKJgpL9p/iCwwX4UPEKIKMCbNHQcsdc2wX/KubbpXS7eXgLpP2d6L362Vvk5W2oHr4ANp1RlxXD
 ArsPA01a/A1JOeE4TwMgZBX5pAw8v2GiKE8HJymt2pYP0Z+OeTMwmGCYGxq9XCeDodnDRa+hyiU
 7ObyPxybvzV3a/V0nYyTzsT/bp2/iCGN3ADlG00DTDs1fv7i30tSnEjTl6mB5W9UffZMZAYHD9u
 YLZdgKzUu7G6DkmXipZ9qAcgAe6ieOUUtOIc+kfforl6z91
X-Received: by 2002:a05:600c:491e:b0:48e:978f:c45a with SMTP id
 5b1f17b1804b1-48fed455991mr192575895e9.19.1779206923119; 
 Tue, 19 May 2026 09:08:43 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:3f5e:825d:a98f:fd29])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe5ab527asm372645305e9.11.2026.05.19.09.08.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 09:08:42 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Prabhakar <prabhakar.csengg@gmail.com>,
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v4 0/5] Add DU support for RZ/T2H and RZ/N2H SoCs
Date: Tue, 19 May 2026 17:08:20 +0100
Message-ID: <20260519160825.4082566-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Hi All,

This series adds support for the Display Unit (DU) on the RZ/T2H
and RZ/N2H (R9A09G087) SoCs. The DU on these platforms is
functionally similar to the RZ/G2UL DU but includes some SoC
specific differences such as a single output port and explicit
DPI output enable control. The series includes the following
changes:
1. Add device tree bindings for the RZ/T2H and RZ/N2H DU variants,
   including a new compatible string.
2. Make the DU reset control optional to allow probing on RZ/T2H
   where the DU does not have a reset line.
3. Move pixel clock validation logic to per-SoC constraints in
   rzg2l_du_device_info to accommodate different clock limits
   across SoCs.
4. Implement support for the RZ/T2H DU variant in the driver,
   including handling of the DPI output enable signal.

Patches are rebased on next-20260519 and apply on drm-next.

v3->v4:
- Added Acked-by tag from Rob for patch #1
- Added Reviewed-by tag from Rob for patches #2
- Dropped per pad limits in patch #4 and added
  a check to return early if the output is not DPAD0,
  as the clock limits only apply to that output.
- Updated commit message in patch #4

v2->v3:
- Rebased on latest next-20260508.
- Included Tommaso's patch to refuse port@1 for RZ/G2UL, which was
  previously in a separate series.
- Moved clock limits from device_info to output_routing to allow
  per-output constraints.
- Updated commit message for patch#4

v1->v2:
- Dropped the "port" property in favor of "ports" with a single port@0
  child, to align with the existing RZ/G2L bindings and simplify the
  device tree structure.
- Updated the commit message to reflect the change from "port" to "ports".
- Dropped storing info pointer in struct rzg2l_du_encoder as it's not
  needed.
- Add Reviewed-by tags from Laurent for patches 2-4.
- Rebase on latest next-20260507.

Cheers,
Prabhakar

Lad Prabhakar (4):
  dt-bindings: display: renesas,rzg2l-du: Add RZ/T2H and RZ/N2H support
  drm: renesas: rz-du: Make DU reset control optional for RZ/T2H support
  drm: renesas: rz-du: Move mode_valid logic to per-SoC clock limits
  drm: renesas: rz-du: Add support for RZ/T2H SoC

Tommaso Merciai (1):
  dt-bindings: display: renesas,rzg2l-du: Refuse port@1 for RZ/G2UL

 .../bindings/display/renesas,rzg2l-du.yaml    | 21 +++++++++++++++++--
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c |  9 ++++++--
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c  | 20 +++++++++++++++++-
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h  | 14 +++++++++++++
 .../gpu/drm/renesas/rz-du/rzg2l_du_encoder.c  |  9 +++++++-
 5 files changed, 67 insertions(+), 6 deletions(-)

-- 
2.54.0

