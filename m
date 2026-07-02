Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AEDEC44501
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 07:04:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43E1210F677;
	Fri,  3 Jul 2026 07:04:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EcGPNAat";
	dkim-atps=neutral
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF5AB10F2F5
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 11:28:34 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-37c5d42ba2aso161374a91.2
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 04:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782991714; x=1783596514; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=vwpv11A8Wqk34ZvqVFhL1Yv/Rbg0bjinwLUWjlhF31w=;
 b=EcGPNAat4oLuA406gmVGA7c4OaI7UU7Nlr4iz/qLZNnz3xvCPxTfXSIltLoxJIpo+3
 7U2Lmzxf4fTNgrJmTScdBlkcLRT+m9Ul0VlvYHTGVe7xFstGeqxx4bPX1UYpepr+Jj5P
 jMida/VmgbS2kksHtTBFYxkAyNaAYLpq9Ha2s0ACDzKxO1XdMw4yQMdNvSOX64lDKzfo
 SXv5hg/Du/wbDOWmvWr6cClG5are6tDUFNS/kK9SX3zJ5Cn2TvvtywAh98ofmo95aVtA
 aQq5DifiG63DyGHEXLpzMc8nbi7jIFs9Z11d/DsCLdBgk6v1/7uedUR2b3k0U5zYtvsL
 c8aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782991714; x=1783596514;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vwpv11A8Wqk34ZvqVFhL1Yv/Rbg0bjinwLUWjlhF31w=;
 b=dLeC5tmz7872bZAVaJykJWOCBp9056fDU3s396R3GEC5Kmhi1yrHofPmLJR3uGokTH
 T1ttmma8thHSYRe8JewZsfJT23nNdiV7fbFkuJeYocQs+H/Wl6KxqultJi6528dn0upP
 ckl1NYE+s75esRM+DmwPU7uxlvw8sga/FbcGyan+MgmkmC89ZLam8+PjrMye/l7fL2/A
 u8TdSpT4jTLrhT50nE16fAJRsN2g1RrNSl3ZWuojoEvZgdg6Se3yd0WatEX2X7xUr3Pq
 6isxiC8ALtkIu0Z4AeYZAsNu4GgnofOuBZb2l6GXSY4Yv7f226xpGRCO7u60X9qZca2O
 iRDg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq+Xn4RBCMsExlT6iJJNa0LkjZscrdoMIanj0Beca9PioBfa0ly46kkJgcTP+WxDDuVWBavvdgKXN0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxthuNYZMVecvGu6jXOcGF481r0zbk7wFT2qpOh2w0FdJ9V9QtG
 b3EEkwwX17nC4CL2c27aHOXMFTGYRcm0wMdwaFmOf5nGJfb0vET4GuDZC0ZbmR0/y6EolA==
X-Gm-Gg: AfdE7ckimdk7NO+5P3/d3oizc5E8hG9HIu8NnwwMuGzOIhT51dyMnZ9Ty2tm362LpAv
 CHSkmTZkDMjDRblZy0bZOs8oUBPhJY9AkQxQ6b1GVRlmcM/QUQrkGPB5UbWy5OYlO4HrWZQLxiv
 V/YdnYWpusVPn7FhpWooj0BumV5KNA952KK2B0JLapMYFPWidLJn99lrqikazGkA6dgpQFATSpY
 ZUpNdJ1fFHwbSRsRo3POz9b911KdAGN4BQQVDU8JE1siUobQZCBzCGycd+etBhua2wSHPYT3p8s
 zqawNNtXPbAZbWZfmfVkQjKBg4GSXY/VubfkvEv0OrC84if0uCVQe9ed44/1q2O9wxIyCFJ8vrA
 /X71RUjiEI5MSXXWSaTkV8oF+YP0aSXGexKFxSQS/kt1DOO77mnUHuwUEIztYtjYNggwmbewJJG
 ie4CuP7kydj9GfIk+vpVcj+oaamwbBpIb2rOThS5JcJb7bbxAi8PwlPZxhnvL7OUX0EEJLI6pH2
 b4js8L1OSGWpkzoauwYWARtREFInpvNiTfISFddIGG3lahgRNaJbwyIo8Udh3Luoas8G5MF7vAZ
 ONxNYf9sbFj/4/kBGyoEe0+FZ2CQIVZOA/+YriQtC5dhEUTU
X-Received: by 2002:a17:90b:258c:b0:37d:f70f:fbf8 with SMTP id
 98e67ed59e1d1-380a9e471dcmr3852595a91.0.1782991714179; 
 Thu, 02 Jul 2026 04:28:34 -0700 (PDT)
Received: from midnightair ([2401:4900:1c94:62e8:bc10:77d0:2fda:415d])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-380e1636a03sm954793a91.1.2026.07.02.04.28.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 02 Jul 2026 04:28:33 -0700 (PDT)
From: Anas Khan <anxkhn28@gmail.com>
To: Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Peichen Huang <PeiChen.Huang@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Anas Khan <anxkhn28@gmail.com>
Subject: [PATCH] drm/amd/display: remove duplicate link_dp_panel_replay.h
 include
Date: Thu,  2 Jul 2026 16:58:28 +0530
Message-ID: <20260702112828.34698-1-anxkhn28@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 03 Jul 2026 07:04:17 +0000
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

link_dp_irq_handler.c includes "link_dp_panel_replay.h" twice. Drop the
redundant second include; this is a non-functional cleanup flagged by
scripts/checkincludes.pl.

Fixes: 1e5cd4adfc54 ("drm/amd/display: move panel replay out from edp")
Signed-off-by: Anas Khan <anxkhn28@gmail.com>
---
 .../gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c  | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
index 54ce768ae6ad..da679fb7d89c 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
@@ -39,7 +39,6 @@
 #include "link/link_dpms.h"
 #include "dm_helpers.h"
 #include "link_dp_dpia_bw.h"
-#include "link_dp_panel_replay.h"
 
 #define DC_LOGGER \
 	link->ctx->logger
-- 
2.54.0

