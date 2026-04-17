Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D430F99C63
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 21:55:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98A0410EABA;
	Fri, 17 Apr 2026 21:55:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IFs0917m";
	dkim-atps=neutral
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16D6110E98F
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 09:33:39 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-36143b0dbdbso149478a91.2
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 02:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776418418; x=1777023218; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vMX7hr4YVNh8uAt3LdTcIDPI1RjqIWFFZ3Ztn6YuqVw=;
 b=IFs0917mkYIVGRiT8JZNtDcJSAPVd8cywTx0X6LnymicEx5RHlzP2QhOp5LXH1U1Bt
 BmxXSeG5IIuLCpx+gFVbQdk9Xw9A0eGXyB9RJBsjHIg2aPLJgU0sPCk9U9b5nEc1WS0E
 CS0Py+NkMRVZEskTKZYSxwopcPgkEKtI31KpWP/wj3OoXDD1ZaxhKlLw99Ip2YDZWzgE
 F7C0NVsozidwp7iDLedtG+wzkP7Yrsbf7l6DRzYbX4ZEMuyKqqwKBOB7LJldfTXCq9nA
 tBimUphobbkfQvH0R+F18ng7RLx3xKrA1vZQEgG3F7pUyOJsLzn2vZYs9PKLUCy2HRST
 SX/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776418418; x=1777023218;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vMX7hr4YVNh8uAt3LdTcIDPI1RjqIWFFZ3Ztn6YuqVw=;
 b=iDl/NRWJIHSPeOqTV2YmlSiHmep9PFC/5ydJmF8IzoCAnwfR+PJ0XADd0imIje4Ihd
 YzXKd8HEBjny7oop2dau1r0B6nnjJTf/iBoNdI1c66KavcPbunVYD06teb4JBFUOY69A
 BjcpVwo5HDeTcyFKoKty1qHpgN12Um3GMuihXXAxBvDlDc2ZWDu7PywAZ7ApIITAnWWz
 ioKFkzrWz/WtBtrzBE+NBL0Ou6JUpp/cZTrKjZ4LSBM29WQcWQqNYZ+TLfv7IYi4gS9m
 rRetaxHIQp7+vT7CMiuapYTF/TqtdmMisVF3SzrjtsWG0+GGLGf4aloB/HugcWxsjglR
 MUtw==
X-Gm-Message-State: AOJu0YyPdmo2rCLHcyMbmonLz9NOFeeRc9kNUxBNI1yp2v+cQBCX8alg
 HjSTwA9DscId3Hwd8gUjJ6DPqOBsXuZb8ZoB85tJPgD32DP8ayg5BLuB
X-Gm-Gg: AeBDieuZtoVOSETpa087JseilK96KsxHzmEiMANn8oQZjr2sLHbbsTgPu4CA+2dgFWH
 I+2YHa5acvZ5NbdMRwNZ82g4/Cd5SiTDL52/lNg6ywSyuuOavSctGH1Z//SLI36SVOBGZTZoefb
 fkhmg1aDPwA1ou8JQNiGooK1MlS8jZZ0+2k3nVCsE8rgtqG2XSrl6Caf89D0Y/JWpP+bjpvhEqt
 G4hBl/FK+zKiovAjzaZcfo3W/ApkBUvMHhO5IUtAtaR24zTPHlAXbHjjxQLkBMoeFGyP+es7rIc
 qyqMRSVQ/UsEq90YfWGyDAL+6rVcYY6bEmFtHf9EXXXtX3iHDBkxEHXHOK99ljrgNvvFfRNCfab
 d3vVGtzYLMqdopAgLHQHwvSmvoT0cm0FPuU3VTSUZx4papqJaJiCF5+ZmqMZ/vIUGlV3LDsOX3t
 pDELF1dQvi6VLxKOXr4o94FC8dfCqI8pI2flewSdBBCsAEnB5OqJAU0aMRgPRjYsGzCha0OcfgW
 Uu4mWBgylCCQdQ5Sr1dz7kyg5uOnQ2gvxk=
X-Received: by 2002:a17:90b:518f:b0:35e:5051:fb13 with SMTP id
 98e67ed59e1d1-361404a78aemr2176490a91.26.1776418418422; 
 Fri, 17 Apr 2026 02:33:38 -0700 (PDT)
Received: from lucifer-Victus-by-HP-Gaming-Laptop-15-fa1xxx.iitbhu.local
 ([103.151.209.194]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36140ff2e1esm1410806a91.8.2026.04.17.02.33.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 02:33:38 -0700 (PDT)
From: Sachin Kumar <sachinkumar905846@gmail.com>
To: andy@kernel.org,
	gregkh@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
 Sachin Kumar <sachinkumar905846@gmail.com>
Subject: [PATCH v3] staging: fbtft: clarify TODO comment in fbtft-core
Date: Fri, 17 Apr 2026 15:03:03 +0530
Message-ID: <20260417093303.33670-1-sachinkumar905846@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAHp75VeFZ7PDV_tT8tDibQk-VPkFFHsxiAHOAx-9Xp0N1ijvAQ@mail.gmail.com>
References: <CAHp75VeFZ7PDV_tT8tDibQk-VPkFFHsxiAHOAx-9Xp0N1ijvAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 17 Apr 2026 21:55:24 +0000
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

Improve wording of a TODO comment to better describe the
intended optimization. The comment now clearly states that
only the changed display area should be updated instead of
refreshing the entire screen.

Signed-off-by: Sachin Kumar <sachinkumar905846@gmail.com>
---
v3:
- add missing changelog for previous version
- simplify TODO comment to match kernel style

 drivers/staging/fbtft/fbtft-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
index f427c0914..cff838955 100644
--- a/drivers/staging/fbtft/fbtft-core.c
+++ b/drivers/staging/fbtft/fbtft-core.c
@@ -414,7 +414,7 @@ static void fbtft_ops_damage_range(struct fb_info *info, off_t off, size_t len)
 {
 	struct fbtft_par *par = info->par;
 
-	/* TODO: only mark changed area update all for now */
+	/* TODO: update only changed area, not entire display */
 	par->fbtftops.mkdirty(info, -1, 0);
 }
 
-- 
2.43.0

