Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D78DCD37B2
	for <dri-devel@archiver.kernel.org>; Sun, 10 May 2026 17:08:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 818C910E03D;
	Sun, 10 May 2026 17:08:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ncMDpR4w";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28D8610E224
 for <dri-devel@lists.freedesktop.org>; Sun, 10 May 2026 17:08:07 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 2B0BE600C3;
 Sun, 10 May 2026 17:08:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BF519C2BCB8;
 Sun, 10 May 2026 17:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778432885;
 bh=j9Ye8Bo4e4CCLXroVD+JMNJOsB6GNLf669OJjbSVu6I=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=ncMDpR4wEvVdO2WufqBBelMu49cRmk+imUtCuK/a/t51iIdPCcKvPa199ZmkDrerU
 Jk+mTpZyvFvYPsX1syuHITyVQyb+IqwQlLzP+kFmsi6xgLIa9lh8Yw7LJBddFECq7G
 2MVLBRXGxoopwfxMxmHwUVRYFLzClbKVhcL0q1Z94iVPZ0sVLWsX8R13GwELVPXo5I
 Gp6UoA+EPiE5BUySxmLprRnq5KcQYUY5Cq8xwWopXLCtF62fbsPVon/t2HRMZQg12T
 qqOI9+3ziD4Vpb4n0zwtkTWdq1gwrVmmwaU695VZbzXHx7IBbYbyMNwmXAG0bJVXxG
 35WT6K/O9VgMw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id AAF9BCD37B9;
 Sun, 10 May 2026 17:08:05 +0000 (UTC)
From: Alexandre Hamamdjian via B4 Relay
 <devnull+azkali.limited.gmail.com@kernel.org>
Subject: [PATCH 0/2] backlight: add support for Silergy SY7758
Date: Mon, 11 May 2026 00:08:01 +0700
Message-Id: <20260511-sy7758-v1-0-999a33081304@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMyw5AMBCF4VeRWWtSopd4FbFAB2OBdBDSeHfF8
 kv+cwIwekKGMgng8SCmZY7I0gS6sZkHFOSiIZe5liqTgi9jlBVYaGdV76Q1GmK8euzp/I6q+jf
 v7YTd9q7hvh8sVWe/agAAAA==
X-Change-ID: 20260510-sy7758-e46d85fd0876
To: Philippe Simons <simons.philippe@gmail.com>, Lee Jones <lee@kernel.org>, 
 Daniel Thompson <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, 
 Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>
Cc: dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fbdev@vger.kernel.org, 
 Alexandre Hamamdjian <azkali.limited@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778432883; l=1464;
 i=azkali.limited@gmail.com; s=20260510; h=from:subject:message-id;
 bh=j9Ye8Bo4e4CCLXroVD+JMNJOsB6GNLf669OJjbSVu6I=;
 b=xi7FLiPtS8KaNvygEBd7kai0RXgNgf3tewAGPMcel307gKtZBLi1SkfUK93Nvs4rIUSdJSRTS
 rE6EmwAJrwbBrceXgxoALcRSGzmr/4CK13LRMrGtba/6eON2lxG7NLv
X-Developer-Key: i=azkali.limited@gmail.com; a=ed25519;
 pk=I0Z0IdCdQJqNGX+FQUnXhrHg950u3cM6Xzz3YT6JOyQ=
X-Endpoint-Received: by B4 Relay for azkali.limited@gmail.com/20260510 with
 auth_id=774
X-Original-From: Alexandre Hamamdjian <azkali.limited@gmail.com>
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
Reply-To: azkali.limited@gmail.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

The Silergy SY7758 is an I2C-controlled multi-channel LED backlight
driver used to drive the edge-lit LED strings of LCD panels. It is
present on the Ayaneo Pocket DS handheld, where it drives the panel
backlight, and is required before the panel can be lit.

This series adds the device tree binding for the new "silergy,sy7758"
compatible and the matching driver. The driver registers a backlight
class device with a 12-bit linear brightness range and programs the
chip's mode and current configuration registers on the first non-zero
brightness update.

The Ayaneo Pocket DS device tree, posted as a separate series, depends
on the binding introduced here to describe its panel backlight.

Signed-off-by: Alexandre Hamamdjian <azkali.limited@gmail.com>
---
Alexandre Hamamdjian (2):
      dt-bindings: leds: backlight: add Silergy SY7758
      backlight: sy7758: add Silergy SY7758 backlight driver

 .../bindings/leds/backlight/silergy,sy7758.yaml    |  47 ++++++
 MAINTAINERS                                        |   7 +
 drivers/video/backlight/Kconfig                    |  14 ++
 drivers/video/backlight/Makefile                   |   1 +
 drivers/video/backlight/sy7758.c                   | 169 +++++++++++++++++++++
 5 files changed, 238 insertions(+)
---
base-commit: e98d21c170b01ddef366f023bbfcf6b31509fa83
change-id: 20260510-sy7758-e46d85fd0876

Best regards,
--  
Alexandre Hamamdjian <azkali.limited@gmail.com>


