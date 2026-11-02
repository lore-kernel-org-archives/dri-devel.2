Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF39606A33C
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 19:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BtfCpacz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17C2510F1CA;
	Mon,  2 Nov 2026 19:59:02 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A9F010E21B
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 19:58:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2C94C609E0;
 Mon,  2 Nov 2026 19:58:52 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1793649531;
 b=UhaMjoPb+KY0LB+y2HS9t6TpCZPvowCdo8fe6bYPo2rnkHvJLRkasf9GeRplb80KCUE0
 nLbjFdO4z1O83DBeEKawx5Ko3M/jXP83HvC+gpyXGXQ6Oo2imcZaaTFlCAF9h7Z+2tBSz
 xLDJbd+eumxHc5P3A0Xkm4YBqKXFLYuN+ryu1Jti5pu8QtatwdgPZJxjQ+kP/4y/ygK1U
 IwRjBxyzjPYEaFpvhHxMOOmQJG5gLbbqtcQj8FL3nMRpgMjIGE/X3ORadG8alCQYpb6Nk
 ioRWmdpBhM+/ywWpGzvvukh5j+3Ydt7YWRqRhku+ncPPd0DMUxBmkrMl86tpB2GbrCQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1793649531;
 h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=Fz48w1sQmqI19+GALVP4NbCSaslqMTNm8iv+7vNWies=;
 b=TK97rnWBHloTwDpxtX7G16eLPpeFLwrgrYNZGbPybrWijNG72/IYqWRgR4tq3ZJ0vb2J
 mgkM0qD73sBsqbuSdL5p7ftEoKKJTTYb6fnxaAJhLY7jEnlikuCQKzxLi6eVDlWGBVzIf
 7b58pN4yYMbsNz5HVafHPA3kua59ZE3ARrTTS4np75EXcoMTw8KZjBTYlTS2Ch8y5f2X7
 pibfZe5ETQmtVcAIm68sW3vdJTPBgYMGPdx7rwteyESCzCShA0eqVEKRIQadLvSUCdScU
 v30MS8fwUgM0bgLOKXlN0259mS8rVBXdQ3KUIdmhBSbnIoDnEL2gcwDt3e5DEoGPmUw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id BB5571F00A16;
 Mon,  2 Nov 2026 19:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793649531;
 bh=Fz48w1sQmqI19+GALVP4NbCSaslqMTNm8iv+7vNWies=;
 h=From:Subject:Date:To:Cc:Reply-To;
 b=BtfCpacztCLgGGIoTcFPA5I+pSiSGHOL8RDoMYuIjICmz+exz1jSuFoclBy93FJ+n
 Wo56IWhifOsWG+v3UEzFlzfkmVTrFjoXdZZj+MiqFGKLIycX5IFrTvlmhVCuWUTxSN
 TkOu/3eSFgbb40m9MZ98Jrw0Cgj9fNxAtx1OoC+xnKYy5fTubBuWXAWy9ZBWjj7+5S
 LQNU30N/smulIQQL1gllA+OkeQrGz0asa2FvQRsFMV8DozegesNyaZY17TRrWmSs/B
 VLD1rhNwI3Vx94LmCXmk5YRCTlRy2NUpCcqiQUONmr8GbeBzMrMl9G1jRlbBxSa1/2
 noLf1i8xvkY3w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 1919446612;
 Mon,  2 Nov 2026 19:58:50 +0000 (UTC)
From: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Subject: [PATCH 0/2] backlight: add ktd3137 support
Date: Mon, 02 Nov 2026 21:58:47 +0200
Message-Id: <20261102-6768-ktd3137-v1-0-b5b4f903c56e@protonmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQ5AMBBA4avIrDVpi/FzFbGgBkOCtIhE3F2x/
 BbvXeDIMjkoggssHex4mT1UGIAZ6rknwa03aKlRKakFppiJaWsjFaUiJpMnErOuwRp8slrq+Px
 2ZfXb7c1IZnsfcN8PWFwMyXAAAAA=
X-Change-ID: 20261102-6768-ktd3137-4ec95068fb6a
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>
Cc: dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fbdev@vger.kernel.org, Roman Vivchar <rva333@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793649528; l=1234;
 i=rva333@protonmail.com; s=20260510; h=from:subject:message-id;
 bh=/mr61SqES4OjMu/nXS3z130f9tijC/yFjMxrAicySaA=;
 b=eOg774+CURNnDRRZWvxeH/ftUyYBMEG9OfIE/+kbBKDMtOdgJ7K7fvLw7iuJ8mEBo5eG3ZBM2
 XBAVbD8lPw2Cz19HqzYDCUkYfPTQt9XVioP5vvNwB6oypOePywXgGJo
X-Developer-Key: i=rva333@protonmail.com; a=ed25519;
 pk=zww/nWjBGoQ4POXCG0BV6fx2iuXK6jx77rsKPA5YK5Y=
X-Endpoint-Received: by B4 Relay for rva333@protonmail.com/20260510 with
 auth_id=777
X-Original-From: Roman Vivchar <rva333@protonmail.com>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: rva333@protonmail.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_REPLYTO_END_DIGIT,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This patch series adds support for Kinetic KTD3137 backlight IC. It
supports linear brightness range from 0 to 2047.

While the chip supports PWM and MSB modes, they weren't included, since
MSB mode supports only 8-bit brightness range, and PWM is not enabled on
this board. I have checked other Xiaomi vendor kernels, and their
configuration appear to be the same as on my board. I'm not aware if any
device uses PWM mode with this chip.

This series was developed and tested on the Xiaomi Redmi Note 9 board.

Signed-off-by: Roman Vivchar <rva333@protonmail.com>
---
Roman Vivchar (2):
      dt-bindings: leds: backlight: add Kinetic KTD3137
      backlight: add ktd3137 support

 .../bindings/leds/backlight/kinetic,ktd3137.yaml   |  64 +++++
 MAINTAINERS                                        |   6 +
 drivers/video/backlight/Kconfig                    |  11 +
 drivers/video/backlight/Makefile                   |   1 +
 drivers/video/backlight/ktd3137.c                  | 262 +++++++++++++++++++++
 5 files changed, 344 insertions(+)
---
base-commit: 5e6de6a2b522f659defacb1551d0465ba6ce13cf
change-id: 20261102-6768-ktd3137-4ec95068fb6a

Best regards,
--  
Roman Vivchar <rva333@protonmail.com>


