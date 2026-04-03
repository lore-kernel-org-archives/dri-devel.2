Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F7E8E7E351
	for <dri-devel@archiver.kernel.org>; Fri,  3 Apr 2026 08:59:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8507110F40B;
	Fri,  3 Apr 2026 08:59:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ATwxNbYL";
	dkim-atps=neutral
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com
 [209.85.167.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DEE310F3C9
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Apr 2026 08:22:25 +0000 (UTC)
Received: by mail-lf1-f48.google.com with SMTP id
 2adb3069b0e04-5a10d130b37so1556980e87.0
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Apr 2026 01:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775204544; x=1775809344; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=iX2gAg3Cvwni3EvZpLj5YxG0NykzLvzc2v6h1lU8a+w=;
 b=ATwxNbYLOgTADG1UFmDs6slDzP46h9MdfxSgavLA4us275F09WJgKcCheqJUaohR3s
 UInlOigRAHdis8KS9ClPvVqCwGNyHkAP6IKNbfRbKPC8aJlH14NTwysxnoY/zgwVXiDi
 sUxXa2IglfD6PYeW9I+yl4ewJnsxzRgmfPpy4fAh+RniKi7wNQh2SvtR7lLlFTPhjSsZ
 /CHSNddeevkR1v/9jW5sp8tdJrbeFJCp7p68ahixRjr1e8SWYrDga4xh6Kg36P53pJT5
 KG7aaDBvWCpgPLSqFMRYGsxnrpwItpe8yiMGGQXm4Rv0fYRxaD3nwXKlPGhSpSu5madf
 YFQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775204544; x=1775809344;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iX2gAg3Cvwni3EvZpLj5YxG0NykzLvzc2v6h1lU8a+w=;
 b=AqjmFVhBws8ufX9wiLZmBsSvJBYlU9caOFFYNH7U+rzzN+vpjAbiENOSsdKVzvwtA9
 aPabLjSZiAwBWfzz2vCQcaKy8DDI1OVXwNu+GWN4Fr+MwCMYO+7MDrLcX9AfpFi/pwrM
 o0CHqOGzdl9GkBMCa/IiHmErFf60rPBB02JuqIQ+6JFZ0AlE7te9X9wPTVlT6GDjdbgx
 hLyRkCEA38KUH1SpynlwEU/Sc9r6ixwwuUppD+3RPvxPQFQYHHrsgA4HJJ9j5vmyLrTw
 LUAJcV9CYsUocx0CPLclGD4WfyFIcuSBJlA5a46TZRhvwXZIDcdJn2Qdf5dgiANespwC
 xKPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoG/3BI8+y93WyKQh6f2EVl+mCn6/OYTB7fNhYx9Y9v2hALwi3Tm+ZjWeFlKMBHhR0Tu8Yb7BEwtU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwpZJjNVUrddS5if9hRy1zUIilnb44NGPzcqQ4Yrc/14F9HzXWh
 DtipqWxwzMJRDAS105/3muhGq3GFZyMpV6Y2V81q0AXCUd4BV/yGokIe
X-Gm-Gg: AeBDieslQEWr5VnU5KGgl4Jbrc017NE0Tu/5uvdgH1qSEpQ9kejPk1w/cHSgoZbsbe3
 jYf6iETIJf1c4WW79ZvgX7vR3bjprL9LHbbMcL720NsNShwGFeaV7ZwBLO6iPc/pjQnZT+MReWE
 /iaH1DdLS3QakPyEUX0dtUVXWMjIC567zoW0zIYh8bUV9gH+l3j5FQNVfKJu3mBxDTNOO6WPh7r
 U/4k+pGeC4J+2+qbfkcqIxMsDsf1DJYUeHqlP6pbODEl/8M5/bQr85bIfAwFA+QL+4OdkiIShyq
 jS78EMIk6C5M2NC9gAJHKBPOQ1lr1/kkT3K19CDdWz0YR6URvaOl5pvan1cg903Q6nkW6uyPacV
 gru2WNNiDQYBnDTDHPXggwmIILX1MJQA3loso/VHXW46v/ZVZZjQXNRhuJPemKNGEnQR2MZJdjy
 UTj3ASrSUkUvjfpyrD6Qb8eFyK3D7Tse3znP3Jk9QX3RmMsGYLcrKn
X-Received: by 2002:a05:6512:3d9e:b0:5a2:c0b8:271 with SMTP id
 2adb3069b0e04-5a2c8d97952mr1848851e87.17.1775204543248; 
 Fri, 03 Apr 2026 01:22:23 -0700 (PDT)
Received: from localhost (94.191.136.33.mobile.tre.se. [94.191.136.33])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a2c6ccca2dsm1274752e87.60.2026.04.03.01.22.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2026 01:22:22 -0700 (PDT)
From: Linus Probert <linus.probert@gmail.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Linus Probert <linus.probert@gmail.com>
Subject: [PATCH 0/2] drm/amd/display: Replace NUM_ELEMENTS -> ARRAY_SIZE
Date: Fri,  3 Apr 2026 10:22:05 +0200
Message-ID: <20260403082207.1533450-1-linus.probert@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 03 Apr 2026 08:59:17 +0000
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

There's a coccinelle script which attempts to replace cases where sizeof
array is divided by sizeof an element. Most of these occurences have
been handled but a few remained in this driver in the shape of the
NUM_ELEMENTS macro.

In two cases the NUM_ELEMENTS macro has been removed and its use has
been replaced by ARRAY_SIZE. (1)
In 4 files the NUM_ELEMENTS macro existed but was never used so it has
just been removed. (2)

I couldn't trace why these cases hadn't been picked up by the coccinelle
check. Just NAK this if there's a reason for NUM_ELEMENTS to be kept as
is. Thanks.

Linus Probert (2):
  drm/amd/display: Replace inline NUM_ELEMENTS macro with ARRAY_SIZE
  drm/amd/display: Remove unused NUM_ELEMENTS macros

 drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c     | 5 +++--
 drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c     | 6 +++---
 drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp_cm.c   | 3 ---
 drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c | 3 ---
 drivers/gpu/drm/amd/display/dc/mpc/dcn20/dcn20_mpc.c      | 2 --
 drivers/gpu/drm/amd/display/dc/mpc/dcn30/dcn30_mpc.c      | 4 ----
 6 files changed, 6 insertions(+), 17 deletions(-)

-- 
2.53.0

