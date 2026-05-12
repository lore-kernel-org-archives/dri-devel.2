Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40390CD4F24
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 14:41:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99A7E10EABF;
	Tue, 12 May 2026 14:41:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XSxxeiIm";
	dkim-atps=neutral
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6042410EABF
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 14:41:40 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-44b052142e1so3163906f8f.1
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 07:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778596899; x=1779201699; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/ZnXaO2XR/XSxB1WPtMHUkL50ezRh+7N6eUtxXGLRy8=;
 b=XSxxeiImGrK1nAXiMK4C6ETVHUTRUM6U2l7xJ5uXLYy3IiK38OvKN/ZKsArMKfF+lA
 jgpX+d2TZ5KpJFhBAxE4XZdInqcXRClg6D6FgIcEE34vyvLI5rcAcVUWkJI5NLWGSsN3
 CvojcquQMoK35XA90Pe8lybG4mi+zIEVmKsrjgoqgMolZyAlGZiQ7WOVxFbK2HGNEAbj
 lbgSRuB0W9arh0m3HGrZx/n4Nx88I55sXbomJktbBSNMo8x8uUMCenPu9ltDxsGVIxDj
 Lyk+3d49sLKQGjERdNJ6gShmAOpcoEgfX7oww+vbeCrVtP5Ih9jEZT06Ay1kgUFSB6hN
 5J/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778596899; x=1779201699;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/ZnXaO2XR/XSxB1WPtMHUkL50ezRh+7N6eUtxXGLRy8=;
 b=F+RhI7XHojz2cR2raK3YaD/j+shojRl7z00btnW6eyjp4kZtbK8SwEef6TJuxUHD4C
 HBEZSm9hXY4vWuim7XmnjYHZftNhOCxgNMfW7BZonGlGMPQMOOD47HUMCahCZUgjpGNs
 E6L590F+PIHnGQLvA2wYKa/epQxArp8AmBAJIL9nP9h1cCaBuFoCh6xDkUhUe0l3o54B
 fko7zrcE7PNWbbefSMSoRHn4RLbLZF22iaRCxI57NQ5bvsxm5fKJvJjcy6evxEn/wRst
 6X6rnpWdBxVNLCEHYmsRHixzUJ8+4HUIatYs/OMl1sWTUAdezwFhM2bMEoFfyHeBnVgL
 s3OA==
X-Gm-Message-State: AOJu0YwV7ddX4zE6gHT4q3Fhdy5iHE0nTPt6U9IWpGCf2h1IXkJ6Ut/k
 1GQ/FGGL0QQSkO2/aN5/osx1ZOB2+CNATLV787o1phXtN4dyk1oz+zvA
X-Gm-Gg: Acq92OFmnibHBwLDRDHMygzyGsvVu+U/8iHFc3Onn6IRposcz06uieDUXqQBSNOnk7j
 b+wrT53s5H6rbVyaAfDt52fNQ/k4C4862j1iVMUInvCpC1JXsh2RXwB8l+W6s11dzyFMRJOsoqq
 38V5tPePzqgZ3IDAh2agebaIuppV4IpY29+7NVm4Dq7fUbCHwypMcK+Xd34s+oVXXwlqbRaGTCu
 8DtyC6IE5o4ExerDMFcUKI/jVaNNjuNdrcmr/oMsLGha1ewGTq8JRS3ZbGO1oFIzZ3e3CFSl4DJ
 UkGydgscuyJJec0jgaT2/p7oc8ZdmfR0QAPBdVxSJMztPrzWciZSwN3vTDpLpDmDaSzWukhphuM
 KJKPMbtO/2Jt0AglvTxN8uAYHZsvTPgK6OIe6NwTQyEnxUk5yzRno44CS1eVs8nZfM8aFwsGxVs
 MrslJ5g6KSkAJvO1CL4e81ukygvJrBmTyvgZ3ED60+m84nB/eO4zseQAos9eHq75hZV4v3+Uitp
 /kILWwJqrY+kqbkNHJKnbcTYrzwqzIGTK8=
X-Received: by 2002:a5d:588c:0:b0:43d:300b:2285 with SMTP id
 ffacd0b85a97d-4568a2785a4mr21502140f8f.11.1778596898639; 
 Tue, 12 May 2026 07:41:38 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:77f5:545a:798:321])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45491cab9c2sm34978713f8f.31.2026.05.12.07.41.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 07:41:38 -0700 (PDT)
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
Subject: [PATCH v3 0/5] Add DU support for RZ/T2H and RZ/N2H SoCs
Date: Tue, 12 May 2026 15:40:59 +0100
Message-ID: <20260512144104.761531-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Patches are rebased on next-20260508 and apply on drm-next.

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
  drm: renesas: rz-du: Move mode_valid logic to per-output clock limits
  drm: renesas: rz-du: Add support for RZ/T2H SoC

Tommaso Merciai (1):
  dt-bindings: display: renesas,rzg2l-du: Refuse port@1 for RZ/G2UL

 .../bindings/display/renesas,rzg2l-du.yaml    | 21 +++++++++++++++++--
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c |  9 ++++++--
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c  | 18 ++++++++++++++++
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h  | 14 +++++++++++++
 .../gpu/drm/renesas/rz-du/rzg2l_du_encoder.c  |  6 +++++-
 5 files changed, 63 insertions(+), 5 deletions(-)

-- 
2.54.0

