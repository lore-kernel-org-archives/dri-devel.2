Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE4ABCD3447
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 11:17:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1550610E2FD;
	Fri,  8 May 2026 11:17:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OOl0GUwj";
	dkim-atps=neutral
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB28910E2FD
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 11:17:50 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-449de065cb3so1745918f8f.2
 for <dri-devel@lists.freedesktop.org>; Fri, 08 May 2026 04:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778239069; x=1778843869; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=a++Qkbe0N+QcN8OOW7PnS6Fd5+vAfw/HCIN0DGOehPI=;
 b=OOl0GUwjI/2L0GBEFiZYNVZ5ZDmbYTMvvlvBp+GTIjRXhIJ1vLkfMQIaXT93Tp8uhX
 QOuARLBk/4gFnLcU1v+iS19aAk2ehC6YEB+FhBNt4zrs/GFagN4abiRSIa4wZRjaFrRX
 R2V60dKaG2tU1hDwRRPmKM2pxRMY6giZxp5x/JnUnZly8ql2tsyq4ceTTBfXMJxC5Gkb
 KSwXa5/fPm2G91um9LB2jRLD78mrCaghcbrNL2OX0wrvJRMd2NNm2OgQ9HyONLYkqEFY
 slZmqxa7kNIu4a+8AJOoJgJgdRdHPWAXzGhUghWNVH7VazyrFk0YcLswuhAlMXNTXwK/
 b/qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778239069; x=1778843869;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a++Qkbe0N+QcN8OOW7PnS6Fd5+vAfw/HCIN0DGOehPI=;
 b=Ba8kUFIvBkOw4HeIhG9hK7IacPDc7SoNx9uJfZaqG2MqeXAqqBtpiKasNl7nv/q7bp
 m0t5vr403txbmj+Q88oJAHfiFt/yh0h5A+gKfI8M1NpojUg8RK3yeXMB23hMPh3m6H8s
 xf/eF4KHsElzUv0CPMcdNzFaxHgoFtIf1h+fgGiLNY9u/uJ0ie/MbHcx+uOnffvGHv4V
 9b3qs64qmBSUeLlHug46vtTyEqjjUd6spUWknhDspc2UvVfyt6SwXtVbsxRQyTemRVQD
 kp0jlNXR1HHMnSVD6ZjnpE9a9lFwW+qrXYLX9YPQVN1YOj/Zoa4NNjXMGwlg/HnffKa5
 PU9g==
X-Gm-Message-State: AOJu0YyLlSkVRWQiEvRe9BeMwLv8SpvFKHaKCek4999iR3lG2Uf9El1q
 2ygrBY7ieBvCC3D1W89WcUy/rrg265qCPH8T4A/Z3QbCEvRYUVItiJrI
X-Gm-Gg: Acq92OGtuGp0ieZnKGjWPmTlagUqrsfUMM0rHHClbcVpKXCPIMaWqPYsn37irOX0+1w
 Fx6/ajIRz7TlZ06XZG18D9ZZ/sUe4GWLqMoYIaeCxqimx1yaM9ky22iEjkq27GMZiEYKxQDlO0M
 H5CwItASopW7JA40NsHcyBk0mPZazq9/sVxPocyQvW3w2YeMVxdnReG1E7Rv0mCiNdeR23Elqgy
 JHJh0O5BHRwCJAdG0a8OAhWPlwOarwyyjWeh0zdCEx7iTnuE2fYxYSbEPqJ1OITF5tGn/vZ237F
 MkZfeE905TUmV0B81UaRUFz+XOb8MRO48WLeNb5Au5No3Co48pCAJWdls0cuzB97Zdhk8iB9hQC
 4Uu35fsrYu/qn7FWp4TxcbGwf04yfF1wUqpdMqUUyteXFQE2rWtR9ECV5YP9UUp+NUHgI5KEM19
 xwKLY+PHKd/3Sw6/xbtL8I9SWQNcf/yITgV/OtnX/KgdRwpgdyZi+ckEMxzzyZrvXZlRpOMvRdk
 n7WG054GUdUQdbjdWUdU45CXhs9l+D3O/gzaqF8Cy4y9gTO
X-Received: by 2002:a05:6000:288f:b0:43e:a8ad:975e with SMTP id
 ffacd0b85a97d-4515ce1c8damr20978761f8f.27.1778239068762; 
 Fri, 08 May 2026 04:17:48 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:74ae:919a:e57c:bd9c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-454916df968sm3535563f8f.25.2026.05.08.04.17.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 04:17:48 -0700 (PDT)
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
Subject: [PATCH v2 0/4] Add DU support for RZ/T2H and RZ/N2H SoCs
Date: Fri,  8 May 2026 12:17:40 +0100
Message-ID: <20260508111744.771659-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Patches are rebased on next-20260507 and apply on drm-next.

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

 .../bindings/display/renesas,rzg2l-du.yaml    | 20 +++++++++++++++++--
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c |  9 +++++++--
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c  | 16 +++++++++++++++
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h  | 14 +++++++++++++
 .../gpu/drm/renesas/rz-du/rzg2l_du_encoder.c  |  6 +++++-
 5 files changed, 60 insertions(+), 5 deletions(-)

-- 
2.54.0

