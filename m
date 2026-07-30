Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92256C5516D
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 18:27:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA9F810EFEA;
	Thu, 30 Jul 2026 18:27:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=0x0f.com header.i=@0x0f.com header.b="XxacgQE2";
	dkim-atps=neutral
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com
 [209.85.210.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87C1D10EFEA
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 18:26:59 +0000 (UTC)
Received: by mail-pf1-f180.google.com with SMTP id
 d2e1a72fcca58-84862b0d5f8so194742b3a.3
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 11:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=0x0f.com; s=google; t=1785436019; x=1786040819; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=wO9ENFeIo1i8UFssNPgLpbWODUeNcQJ8iH/TKOtI5vc=;
 b=XxacgQE2X+zSC9U+FARXhY3d7M0FBam01jxhZko1ZKkHgFPDxDWIG8MPw33VmpdL3G
 RQhFbJBhbAFCTT5Gb5MM29dXtdY3sS7lgJ4MDwglAMWF4tvWStJN3sxSsCiJrCJaQNNB
 Z4Lw2XOEgDUnctCbbU8oa0Nw3Qc0TKX7J7AAo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785436019; x=1786040819;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wO9ENFeIo1i8UFssNPgLpbWODUeNcQJ8iH/TKOtI5vc=;
 b=SZfcZ7l+mwI4ODI6Kl24ujfrdpgTnRF3KhxCTychVowU1MUGmx8astjvO2BS1XALXz
 9J8BAvwKNWvRPwG7+PNZIFPvWWnFLh50IGfw5Q/d7pV7xPWuzOoh09WbFJ7fbhfHyxbU
 yEWvW+FlJLnetF4tpwzlyGPjS1A1MnJdN1HDOEdBJQm9GGSYdANpQWD5OU7Lg9f4xgfl
 Va3L23rm00vLFSTGCC3iZnOSXkAVNoUlgXAMmhk8jJTlUnI7wk/dBWhHy8jZ3MqpTmw9
 Bu7gNdQVpYXJfmCGhPTv3zlOFlPfstRhn3lQHZLlgy97/ZNk7JIUOwR4BhqqIZBofRig
 j7Qg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrYy83ClORI7TEmi95UjaLA5/EherxXyPqf3IvNsK98WAivhp7tlN8m3a+MOn+red5+ZDHTD7U0l0w=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw6F6/N8uWUqiz6EIs5wqYduBV61Ii28RmU4QxGp1bUcQtr/5h8
 2u2X61zhvpAbRSb+gcE5/qvIgHYTFhJyX7hUZD6Muo/AgDABPPqLmCnIwu+lKz1oN+E=
X-Gm-Gg: AR+sD122ZSXyXXJ8WCbXdmsv3AeObBL6psDhhD6WiC+D1TvWIQJuLdJcq3X7byfbvIA
 w5D+tPR7wH5FzDDPPfQTKxYL3wx6OOO034WpvAdD22ld7y25a3+EX2k/inmaO19jJKMUojoD6go
 pC8KtrUGya99uQXFFiX3a79DmlaXR97Kg3MLJxXG/XTAci6FmQOrC+ZuaRE0EusXHgP6QVbpLKa
 QuyQYHCIgcKkuxwVfJaTEFQRXIx1sHSvk1iuQGZKWddygLJtBeKGozh4KkAw26g8QNv3Q97RYT8
 CBorYYJqhe4pkJApc9H4O/QhT8lJWQmp0qntiGdDHbASzD/E1iJ0Ol+tBmtX4Uqs2SJsXGeiUDt
 ZDaFXNukag8f/MP/ADDMRt8igdNOQTbUY0ENHeiPx4Y7MKmL0g2pl+aVXAdVSH3G1uwcf+jXLr4
 xbOtTqAXd1bksXJ72vNtNzLqAdfulGq0eGWBfeArjnV90DqtAqieDa
X-Received: by 2002:a05:6a00:13a1:b0:848:6ef9:f5ca with SMTP id
 d2e1a72fcca58-84ebc421141mr3212810b3a.63.1785436018914; 
 Thu, 30 Jul 2026 11:26:58 -0700 (PDT)
Received: from shiro ([2400:4162:2428:2ffe:f84d:1f36:28ac:c15e])
 by smtp.googlemail.com with ESMTPSA id
 d2e1a72fcca58-84ea0378b18sm3428806b3a.48.2026.07.30.11.26.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 11:26:58 -0700 (PDT)
From: Daniel Palmer <daniel@0x0f.com>
To: deller@gmx.de
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH 0/5] fbdev: tdfxfb: Make "unbooted" cards work
Date: Fri, 31 Jul 2026 03:26:35 +0900
Message-ID: <20260730182640.2808572-1-daniel@0x0f.com>
X-Mailer: git-send-email 2.53.0
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

Currently using voodoo cards that weren't booted by the video
BIOS aren't usable.

This means if you happen to have a proper - non-x86 - computer,
another card is the primary or you have a new BIOS that cannot
run the video BIOS tdfxfb would probe but you be staring at
"no signal detected".

This series implements manually booting cards using the
values from the video BIOS' own table.

Debugging was partially assisted by Claude Fable 5. I could not
work out why this would not work for months so I told it to
create a voodoo 3 emulation for QEMU to compare the BIOS against
my code. That made it obvious my init sequence matched the BIOS
but the VGA core wasn't running.

This has been tested on a real voodoo 3 in an x86-64 board.
I have some patches to add an interface for doing 3D rendering
that are not included in this series and 3D rendering is also
working so as far as I can tell everything is good.

Daniel Palmer (5):
  fbdev: tdfxfb: Add helper to read config table from BIOS
  fbdev: tdfxfb: Attempt to detect if the card wasn't booted
  fbdev: tdfxfb: Manually boot unbooted cards
  fbdev: tdfxfb: Wake the VGA core before programming the CRTC
  fbdev: tdfxfb: Program the initial video mode

 drivers/video/fbdev/tdfxfb.c | 151 +++++++++++++++++++++++++++++++++++
 1 file changed, 151 insertions(+)

-- 
2.53.0

