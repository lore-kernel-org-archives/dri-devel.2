Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAC63EBFD0F
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 08:01:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B24D10E350;
	Mon, 13 Apr 2026 08:01:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="O71ZCOlp";
	dkim-atps=neutral
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A60AC10E08E
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 16:50:00 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-43d72875729so337676f8f.3
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 09:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776012599; x=1776617399; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zY6yfZkHIbKAhpXHmyMs2cR3FIwM5tf4pW3ivO5AZFE=;
 b=O71ZCOlpImtCVbYM1VhufUz18XbdR44AfwGLaVqKhJcFcp3iD+/ea7d/tv8PGt/Tlc
 PpCz0LRVQCzn4nogqRzLwsrh+SeW8Ndv8c4jR1xq8KS69vkqRNKOPuVHdGKH5tfsEZqk
 WNE5TeutH7RpM48J3w6ZO1xStf2gGfk8Kh1ijkhFH/JNGkEVX2+/Rw1T6ZE0HIyRrQMv
 nVFddiI6rkibHVR8LJsaygduIcLW3d7Au96+vylQf4Q2kmvL1wgxePjk2w9TAeQWQJjp
 bb4etA+lASNTgFCpog8lvxwRcLj+8/j05uo2kc3dk+8gqMEu0wfCEk+hk2QL2Yfk2vqt
 m3Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776012599; x=1776617399;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zY6yfZkHIbKAhpXHmyMs2cR3FIwM5tf4pW3ivO5AZFE=;
 b=nSB3pNUbNtoJluhwgXcjgPM1Kc2uFo7iNkaJVJh/qBb1wfMlsXAC2xMPiqC4IOIoId
 TH0MRto++ZqCKVIHMlHc+evBRQAXn4VjmElHuzr/aHGDPwx2vWw5UJnZu3aPQ0qhD7AA
 Vv/xdiQf0DosfNAnJV3RmJnpx71oHAbCS8vxjM3NPyhVw/mgMEQPj5LTcyVnfHB4p7Wi
 ZYz4G3+Vp68NCO1V9SQ/zS5D/atA4HoSby0guAC2OYGRl77DB6ysXieXXTwuKMyYz1So
 icLpwZQ8zbaLyzO4QPHJM8qS08ImcDbHR4N5v3LX/k1o0QFeXSgnIo7mMJHq2ZX9EK87
 lusw==
X-Gm-Message-State: AOJu0YzrofQ1iQEp6HRAyOUUVqwxCK4VTJo6fo1moFvRLAqE3uuB3053
 JmwUn3KhY/cwaN10h2IVkEve+DlUGMHEGDacE9EdsOuV3jAs1rw3WEIW
X-Gm-Gg: AeBDiesI19baGYhXDRctTYvBnMfr4iA9HZR66cIizFb6SZojeqRs32N/sCqcEmGWZ6+
 hIuPV+veSZCco0kxftnXwZBJNCOxltur6q2GC8FogDDp+EU4WerN+Znao14X9kcOOWdhiRGFY3/
 /DCZLM1bOnPXaK0Mx1DnShv7wy0Jm4zG9uGM72qXx1pjtl0yXk5wtmUks7mKlfSIy+bcfbw6dVS
 nqvHWEV7LlYaRrAR7EGO58kAqrojHn/E0TTsyDUG4wKCrdiXJZ+v3EvE0yLeDJA+8VgqIrzf89d
 BNop0WP2ABpFgoWVzX4wml+pn+V+wgo0IKlGkB/UpPortFVZbeEI6o6RJ6sbSS8V5r62JXvATxQ
 /lR2E1V4EDIAuuIpYD35oMUmwwwBzFQWSSUHOljDx3+brvxnCgp5fsu7a2DVl+ehU2b65GU/J8T
 5iUgoFO30dcwB3QuKcWF1T
X-Received: by 2002:a05:6000:238a:b0:43d:7883:87ce with SMTP id
 ffacd0b85a97d-43d788389c8mr903275f8f.34.1776012598717; 
 Sun, 12 Apr 2026 09:49:58 -0700 (PDT)
Received: from localhost.localdomain ([2a09:bac6:d6c7:2682::3d6:8f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d63de2999sm24999175f8f.6.2026.04.12.09.49.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2026 09:49:58 -0700 (PDT)
From: Baker <mzndmzn@gmail.com>
To: andy@kernel.org,
	gregkh@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
 Baker <mzndmzn@gmail.com>
Subject: [PATCH] staging: fbtft: fix coding style issue in fbtft-bus.c
Date: Sun, 12 Apr 2026 11:49:53 -0500
Message-ID: <20260412164953.1470-1-mzndmzn@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 13 Apr 2026 08:01:34 +0000
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

Remove trailing space and comma before closing parenthesis ')' in
define_fbtft_write_reg macro as reported by checkpatch.pl.

Signed-off-by: Baker <mzndmzn@gmail.com>
---
 drivers/staging/fbtft/fbtft-bus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fbtft-bus.c
index 30e436ff19e4..409770891c54 100644
--- a/drivers/staging/fbtft/fbtft-bus.c
+++ b/drivers/staging/fbtft/fbtft-bus.c
@@ -62,9 +62,9 @@ out:									      \
 }                                                                             \
 EXPORT_SYMBOL(func);
 
-define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, )
+define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8)
 define_fbtft_write_reg(fbtft_write_reg16_bus8, __be16, u16, cpu_to_be16)
-define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, )
+define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16)
 
 void fbtft_write_reg8_bus9(struct fbtft_par *par, int len, ...)
 {
-- 
2.47.3

