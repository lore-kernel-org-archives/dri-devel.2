Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DFC606A334
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 07:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=OjI874MW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C03810FBFA;
	Thu, 19 Nov 2026 07:48:43 +0000 (UTC)
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 680C910E072
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 02:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1795056480; bh=8BIIDtFx5PmzL3Uepd4NxUuQ5zZW+dOp5Ub913wqFiI=;
 h=From:To:Cc:Subject:Date;
 b=OjI874MWkKWmhu+3sQuTelsugkPnIKnveqwBjd4ncHr7k/NzoZFFT3788zsFSoMRt
 3vt1i/4Lsjt+fktnpib+xd8rElAV8J/D2zUve/0Z5FiZANbC89EN+smSaHxuBk6vt4
 sou2FMJ6Qf9NqpL1HsmCKIn1RZgM9+WvGThDMqao=
Received: from [192.168.2.135] ([113.90.236.90])
 by newxmesmtplogicsvrszb43-0.qq.com (NewEsmtp) with SMTP
 id BFA264FE; Thu, 19 Nov 2026 10:47:58 +0800
X-QQ-mid: xmsmtpt1795056478tpnvxxxva
Message-ID: <tencent_31F36F1EEAC0B8EDC79A55CF772421CB1306@qq.com>
X-QQ-XMAILINFO: OVFdYp27KdlJ821YX0vfkxhM7TMkCDgzgCFtfqNJ/2YJUvziFTw+lIDOhHNk3c
 4zLCfW8Eo91iem4NHxsJ+yMrXhrX02w4EGziX5sKocdfpbuQFh1hS719z65t91bkRCxl4VWpEbM2
 jzso7xe+ykcfpVMyEPBSDts0RuGY7GLQQoxPbFXqoHllOiRGrR0PJR1Wxn12h+QgOlNN0u1vu17U
 zP4PTlkNa2NhBmT8zufgB1YjFhn9+UAH/a5ep4onncIj/IXQx4DR8aJekH9ax+VxU+YIYAxWuuQj
 /VXvh4cQxGHibx2ibZWd3rwmwyWnXPaJrNdZvaiLTctRBO0gqT3aPTMr5/0Op0L9jnqOg4aaJMdE
 nTj9nhHz9GggWlezn6UKUg6uBv+xRtKIN5Ie3nXq4yhx2Lu0WBov7qzzrIjLPEaKkLW/qPFs6m5I
 XtWfRAnY9TlIBNCgsB69PLFSfEF75aWsYEmkD28TjQN164F/9q3L06AFpB7xcKVUwWvzLdQOpi0/
 f/b2uMQHi1QThUDbFdBXolyd01SE1QvICbCW7r5rBfr/ZCELcZKBHnFXfpFWtva0TMS5g+2Tt5Yp
 bMCbqU7IByxsbniWMDyEbKJIBsgUKZyZOgYa3gL1DIS/23qZU+i0up0Hf7L96emSKpR13G/HWiqu
 T0v+oDWN6k8ykSwUCVhWVdYBMsVoUX6Ipw9G9YosyiTQ3P1qI0KwagK5ouDk+Z/BWqjAF/F1lbsl
 U8E6f0xRBg/HJXtJ/zsYOsYRId9yjvGzYzzc7A8z0lP6P/InvUrIV7jGODY+w5wFDX8Q5LdYw/9O
 kwbs+vxduIrW3mKFbpB67LNf/5pA7o4sXAx4JGsNKaTRZlln3CddP7Fdf4ggig+bskFIYBrZnXw4
 8K/kO9hq9+rXZQmLxV9Y42HumMgCKScPBEOfgfFVy8LcZfEkG4gwO30SqLpPKsnOP46S+hMGo/4Q
 J5+/BtWaDN2zNcOBuUHB7i5ad3k1G+F8o2omB/SkPBsnNbHFHei+I1xX6OVgMyT/ainVMCaP9a4w
 gkMVWI9i6wn6g8vrScLovYGpTopGe66g2Hzkop1MMiaoKAwYPo7vFndXcbXwj5xk86builmg==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: Hefei <3066883572@qq.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] Add VIEWE 7" JD9365TX MIPI-DSI panel support
Date: Thu, 19 Nov 2026 10:47:59 +0800
X-OQ-MSGID: <179505647943.50956.16853759149713125338@qq.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 19 Nov 2026 07:48:39 +0000
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

This series adds support for the VIEWE 7KF82 7" 720x1280 in-cell MIPI-DSI
panel based on Jadard JD9365TX (2-lane video mode), plus the companion
I2C touchscreen and I2C backlight MCU used on the same FPC.

This is a different programming model from the existing JD9365DA driver
(panel-jadard-jd9365da-h3.c): page select uses 0xDE (not 0xE0), bring-up
uses 0xDF unlock, and lane config is via 0xCC rather than 0x80. The init
sequence and bindings are therefore kept separate.

Tested on Raspberry Pi 4 and Raspberry Pi 5 with a downstream dtoverlay
(not included here). A matching series is also under review for the
Raspberry Pi downstream kernel:
  https://github.com/raspberrypi/linux/pull/7633

Patches:
  1/6 dt-bindings: display: add VIEWE JD9365TX panel binding
  2/6 dt-bindings: input: add Jadard JD9365TX touchscreen binding
  3/6 dt-bindings: backlight: add VIEWE I2C backlight binding
  4/6 drm/panel: add VIEWE JD9365TX 7 inch DSI panel
  5/6 Input: add Jadard JD9365TX in-cell touchscreen driver
  6/6 backlight: add VIEWE I2C backlight driver

Signed-off-by: Hefei <3066883572@qq.com>
---
0 files changed
-- 
2.47.0

