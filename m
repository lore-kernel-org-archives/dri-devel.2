Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD79AC5AC82
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 06:47:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C2CB10F357;
	Fri,  7 Aug 2026 06:47:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; secure) header.d=dewith.io header.i=@dewith.io header.b="OYP2+wss";
	dkim-atps=neutral
Received: from meve.dewith.io (meve.dewith.io [157.90.20.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F369F10F2B9
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 20:26:40 +0000 (UTC)
Received: from localhost (70-26-208-87.ftth.glasoperator.nl [87.208.26.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1)
 server-digest SHA256) (No client certificate requested)
 by meve.dewith.io (Postfix) with ESMTPSA id 402B223D90;
 Thu,  6 Aug 2026 20:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dewith.io; s=default; 
 t=1786047591;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=X1dLP/FEQKxT40U9k4SifBNc/F8DQLWHwpEry3VU43g=;
 b=OYP2+wsszoD4nkj5o+EnNtlwsJovLvNEJdG4ICx50cUdAh00lLG2ew3smBWEgvC3VeIEG5
 pu6WhLKFda5RrTTpAWFgcxN1IAzXRDpvfjLlw6Envy2yvLZBVZZG2C+tVL5v0DNpxwb2OL
 oHzMIv04SgiYTQi0i3glVL+qFT8kRwU=
From: Wim de With <wf@dewith.io>
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>
Cc: Wim de With <wf@dewith.io>, dri-devel@lists.freedesktop.org,
 linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 0/2] backlight: Add support for Orient Chip OCP8178
Date: Thu,  6 Aug 2026 22:15:39 +0200
Message-ID: <20260806201541.101304-1-wf@dewith.io>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 07 Aug 2026 06:47:17 +0000
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

The ClockworkPi uConsole[1] is a modular handheld console manufactured
by Clockwork Tech that runs Linux. It consists of a mainboard which
connects a number of peripherals, such as the screen, batteries and
keyboard. This mainboard hosts a system on a module (SoM), such as the
Raspberry Pi Compute Module as a so-called core to provide the compute
for the device. The device supports different kinds of SoM as cores. The
mainboard is shared between different devices, such as the DevTerm[2].

Currently, the uConsole requires a number of out-of-tree drivers to
support the hardware. In addition, most (if not all) supported SoMs
require vendor kernels. In practice, this means that kernel support for
the device is scattered across various repositories in the form of
patches with dubious quality.

This patch series is the first in an attempt to upstream as many of the
needed drivers as possible. The goal is to support at least the
mainboard and the peripherals of the uConsole in the upstream kernel.
These drivers should find their way downstream to the SoM vendor kernels
eventually.

This series adds the driver for the backlight controller, the Orient
Chip OCP8178. I wrote the driver from scratch using the datasheet, to
avoid any copyright or attribution problems.

[1]: https://www.clockworkpi.com/home-uconsole
[2]: https://www.clockworkpi.com/home-devterm

Wim de With (2):
  dt-bindings: backlight: Add Orient Chip OCP8178 bindings
  backlight: Add support for Orient Chip OCP8178

 .../bindings/leds/backlight/ocs,ocp8178.yaml  |  46 ++++
 MAINTAINERS                                   |   6 +
 drivers/video/backlight/Kconfig               |  10 +
 drivers/video/backlight/Makefile              |   1 +
 drivers/video/backlight/ocp8178_bl.c          | 243 ++++++++++++++++++
 5 files changed, 306 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/ocs,ocp8178.yaml
 create mode 100644 drivers/video/backlight/ocp8178_bl.c

-- 
2.55.0

