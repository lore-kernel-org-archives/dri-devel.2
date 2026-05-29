Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5105CCD6E43
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 11:05:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A226910FD4A;
	Fri, 29 May 2026 11:05:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VhofJ7DS";
	dkim-atps=neutral
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 757E110FD4A
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 11:05:32 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-45e8a834cc2so8506470f8f.1
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 04:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780052731; x=1780657531; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qE6RnHPAGUOc6JTeO2foqPr0MsIVa35llYbJ9yTYeCg=;
 b=VhofJ7DS72Ob/C/irwJPIFTTVt3rtDEd2M0+36gEUedU5GxDxH4JqhZcC0BpZM46+p
 /7M/2bVHhlJ1dBPVU0Nw6zjW89gL4X0+MINWkvvOzPUdNCPQL7uY6ZKW/2y+glnDUBMU
 //PfDW8uA/75nVvZRD8l30oFLJuEacEWOwQaYF5qhyzRZomsANCpE9gc9emtoH4UmHAn
 uF+HiaAE9VWRQqYVBTOObVvn1k2vU0d+7qkLuMDww9P7yzXT+vEVNlM9bgw/maunDvaT
 4avY1Oq80RwfobE4VTDV1QbYshfB2HrznEYFmL/mLBWIn32y7fduwilhR1IZVgx+1fxr
 7Rwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780052731; x=1780657531;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qE6RnHPAGUOc6JTeO2foqPr0MsIVa35llYbJ9yTYeCg=;
 b=Ezr8Sp3NbdNkFyzcuZcbqDEdlDWmzXvM5dmL+9N0BUKTL1vgCT4RfJnetwl3ySBQvO
 4mQLygkW2XaOcQif5xm3kBpFCDvjDGZ0UKH3SwMaJUViyFTtMBX1NWtobuqrL7mcOOCJ
 BbIU+xgpehed9Tkz2sZl6449sdC4ee2VYF1QqgEviNZuOHbCD4YfnfqjCSjv1Xiibvet
 97e0VTf+5PxVweSnXX9wDZ0Nvv0vlCMqpcPRMtDJBoBhQWSDnYAaStUe2Myqq0lK5sl/
 YnRet9tVQb2XubCuJ/l1k8ZtQXszEMNviXiWp2I7ds/XZEUmlbclp+l/y/5xZQkJNdVM
 /lYg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Q0+9pb3Z/mHHTGnKq1T2ic47M9KIBBjhGKgK9p6lA4nU8ztOshD47l+Qx+VapSdgSDzocsK6BkEw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwSCQW4g3Ray7vQ5OIsX1V6AtS5bVJ2OOp0PlE3ZUkn3Re2Dyfo
 mllJBc869u5WHDskP4AGNUc6ADeAee23Lt2tmZM4v2KrcDZo7NL/tQcZ
X-Gm-Gg: Acq92OFbIlf6R7BOxPCmZJapWoaf7it+4qUVgA20tGkH9DpqXwsrGfmf0vt8p1ONq5g
 q81fUSBI9eVdUa4jvYuOC3qKKZNzIqoBNkv/0POzNZhyXi6nHPJVc7/wT14mBzTr//SmjXKsGEe
 /WWgiXwCqsi8qadazm1oNOwg8MyWSBvSL6HUF3yhhsaVgXn81Na53JhjFVSEE/NE+1kNiahDGBh
 2V9weLbGpA/m67vH2FnVRcW5pzN7stuMNCaXd3AlbEuptkLtwSHd/feTzuCVYX5rWrWRYQvosYa
 V8BEKVoYJMUWbcTRl/ymEyjFbWC8PDLhOutUQr+Js3c0AiVyBE8O3vZsEHvGTIoFzsHpTpjrKKE
 iWD1GCTZP11FSYGP9kq06Ebru6SkG6bPx+0OYO34zgvZmt8ZBOXwqlu0OTr8OeS3NV/ggFR41aa
 9lR/4afCaLqxJ9YvCF+QsDDIh0758CNlEko6eS
X-Received: by 2002:a05:6000:1a8c:b0:43b:5b25:67f8 with SMTP id
 ffacd0b85a97d-45ef144a48emr4457888f8f.20.1780052730683; 
 Fri, 29 May 2026 04:05:30 -0700 (PDT)
Received: from vitor-nb ([2001:8a0:c4c6:f00:7677:753b:2cb5:7f25])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef34c3081sm3033663f8f.15.2026.05.29.04.05.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 04:05:30 -0700 (PDT)
From: Vitor Soares <ivitro@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Tero Kristo <kristo@kernel.org>, Francesco Dolcini <francesco@dolcini.it>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Thierry Reding <thierry.reding@gmail.com>
Cc: Vitor Soares <vitor.soares@toradex.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 0/2] dt-bindings: display: panel: Add LG LP156WF1 dual-LVDS
 panel
Date: Fri, 29 May 2026 12:05:18 +0100
Message-ID: <20260529110518.624454-4-ivitro@gmail.com>
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

From: Vitor Soares <vitor.soares@toradex.com>

Add support for the LG LP156WF1 15.6" Full-HD dual-link LVDS panel and
a Verdin AM62 overlay for using it through the Verdin Development Board
with the Verdin AM62 Mezzanine LVDS interface.

This is a follow-up to an earlier attempt [1], where panel-lvds.yaml
was incorrectly extended to describe dual-link panels. Back in 2023,
when a generic dual-channel LVDS binding was proposed, Rob Herring [2]
pointed out that dual-link panels should follow the existing
advantech,idk-2121wr pattern instead of introducing a new generic
compatible.

Following that approach, this series adds a dedicated binding for
lg,lp156wf1, with the dual-link LVDS ports described by
lvds-dual-ports.yaml, and excludes it from the generic panel-lvds
schema selection.
The second patch adds the Verdin AM62 overlay for the LG LP156WF1 panel
on the Mezzanine LVDS connector.

This series should be applied on top of [3] to avoid conflicts in the TI
device-tree Makefile with the other overlay additions.

[1] https://lore.kernel.org/all/20260521150038.103538-17-ivitro@gmail.com/
[2] https://lore.kernel.org/all/20230130170441.GA2796575-robh@kernel.org/
[3] https://lore.kernel.org/all/20260522161105.277519-13-ivitro@gmail.com/

Vitor Soares (2):
  dt-bindings: display: panel: Add LG LP156WF1
  arm64: dts: ti: k3-am62-verdin: Add Mezzanine with LG LP156WF1 LVDS
    panel

 .../bindings/display/panel/lg,lp156wf1.yaml   | 105 ++++++++++++++
 .../bindings/display/panel/panel-lvds.yaml    |   1 +
 arch/arm64/boot/dts/ti/Makefile               |   5 +
 ...verdin-dev-mezzanine-lvds-lg-lp156wf1.dtso | 131 ++++++++++++++++++
 4 files changed, 242 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/lg,lp156wf1.yaml
 create mode 100644 arch/arm64/boot/dts/ti/k3-am625-verdin-dev-mezzanine-lvds-lg-lp156wf1.dtso

-- 
2.54.0

