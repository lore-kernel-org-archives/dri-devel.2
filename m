Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E21E2CA6007
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 07:42:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1181F10E774;
	Thu,  8 Oct 2026 07:42:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="c2RYVRQP";
	dkim-atps=neutral
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com
 [208.88.110.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0550910E6BD
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 20:19:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by mail.savoirfairelinux.com (Postfix) with ESMTP id 106BE3D818A0;
 Wed,  7 Oct 2026 16:19:04 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id 6YAIV7jNVkQz; Wed,  7 Oct 2026 16:19:03 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.savoirfairelinux.com (Postfix) with ESMTP id 085983D81859;
 Wed,  7 Oct 2026 16:19:03 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 085983D81859
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
 t=1791404343; bh=egqWC/42mwW2SZfbT/ur767U61gd29E6H+p4BrJ2fGw=;
 h=From:To:Date:Message-Id:MIME-Version;
 b=c2RYVRQPeXBHOB0aCQTf59Y6j9WcvUWSIztS6bzem1Z+r234kFgJ98mTEd1omKOIP
 cq2YuAr8Czpu3M1qXjgTPGvWCMg5+kDrc+1JgPuswI4tYuUSyRKkrwUzfVzzehFchn
 dOBMuf3bVnW869BBEHF+VbNUy/pBJp2exhmWbUcjwElo8MW4jvMDtAg6NEouD/a/R9
 +Cheo2gBP/GCuPc4M/OEifBe89sA8L5Mc9DzQOyw4KLiJ/LM7h15ACHFBDiboyLKYp
 Fj9SL2sx9ZWCbDgzJy9WhE1xsdbi3MjRmGDH/Lp54g/TZurradmvkaeF2rKg3wbcj/
 f2XvtIM/EnVPw==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id OONYnz5ObB-z; Wed,  7 Oct 2026 16:19:02 -0400 (EDT)
Received: from localhost (unknown [192.168.51.254])
 by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 6E4383D8182D;
 Wed,  7 Oct 2026 16:19:02 -0400 (EDT)
From: Marc-Olivier Champagne <marc-olivier.champagne@savoirfairelinux.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
Cc: Ondrej Jirman <megi@xff.cz>, Purism Kernel Team <kernel@puri.sm>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Marc-Olivier Champagne <marc-olivier.champagne@savoirfairelinux.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Jerome Oufella <jerome.oufella@savoirfairelinux.com>,
 Felix Boucher <felix.boucher@savoirfairelinux.com>,
 Quentin Lehoux <quentin.lehoux@savoirfairelinux.com>
Subject: [PATCH 0/4] drm/panel: st7703: add support for DCLTek DT300248
Date: Wed,  7 Oct 2026 16:18:55 -0400
Message-Id: <20261007201859.3709656-1-marc-olivier.champagne@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 08 Oct 2026 07:42:48 +0000
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

This series adds support for the DCLTek DT300248 10.25-inch MIPI DSI
panel based on the Sitronix ST7703 controller.

Patches 1 and 2 are necessary preparation: they make the driver send
the init sequence from prepare() with the DSI host guaranteed up,
since not all hosts accept commands once the video stream is running.
These affect all panels using the driver.

Patches 3 and 4 add the binding and panel.

Marc-Olivier Champagne (4):
  drm/panel: st7703: set prepare_prev_first
  drm/panel: st7703: move init commands to prepare()
  dt-bindings: display: panel: add compatible for DCLTek 300248 10.25in
    panel
  drm/panel: st7703: Add DCLTek 300248 10.25in display

 .../display/panel/rocktech,jh057n00900.yaml   |   2 +
 drivers/gpu/drm/panel/panel-sitronix-st7703.c | 117 +++++++++++++++++-
 2 files changed, 116 insertions(+), 3 deletions(-)


base-commit: 5d7b464a4f517d1db533b1b231f42ddcf4e1dff4
--=20
2.34.1

