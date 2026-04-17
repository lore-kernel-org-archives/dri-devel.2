Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0029FF8E4A7
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 06:18:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61F6310E956;
	Fri, 17 Apr 2026 06:18:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Rh1af8Fg";
	dkim-atps=neutral
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86A2810E956
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 06:18:58 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-35da2d35eccso251413a91.0
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 23:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776406737; x=1777011537; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Fe4W3HnVO+YZd9jb3JNthV1TX4F0wRs5lu3mbDk9034=;
 b=Rh1af8FggWf4Yz1a+8+Q5W1OzPXdRi+s2eTaRDJ8suVyS5MVaX5OouOofDizyNUuqw
 XJoPhDOtYHyHiwLL2VtHqTwWgJhH1ivtAGm0MFhxJjPisy6E6DtWnPKZIrBNkEvpfoxs
 1AZ67uN1N281kABFRo39Nl9GtT22Hq32uD6Eh1r4KbRyWjzvIjWFT/alasc42MKOCFnI
 r8iTeOcSsnovSPHToLJwuSKo2CqcqDU5VfHstv9LhhralXhtjXoonAiQQMunFT51O/Aw
 pJiyrptXfhhaTv+RoheTIS+ihyu3SsI7PYR4aeDk/wzjnmQxetpPq7/c66Fu0XcAX0g3
 Z6Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776406737; x=1777011537;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fe4W3HnVO+YZd9jb3JNthV1TX4F0wRs5lu3mbDk9034=;
 b=kv4brtljMkt6I39LuxWgltPLChbalJp4g47Eb3l1CQ8ju8pcz2ow1IX2kTZzNVkfpy
 SYcWONa2rIeBynzg4exL+2ShMT3Ch7zn2ALpTo+vcy1F0UpkJB5lg80RuhVJyjXP03CV
 C9xnJIu/JkDUHFrQiGXNvPHF/MTTwf0BPofdlznPk+vyeu64GskjRaHUM4A4PSdDMc9Y
 EF9NHKiSYHxA7Mysw3NzZv0+OIpkm8dA3Fb8/HGhdWe7/5rXD4L1SIZ7YxrHBolFC6nV
 vguXvBvVOUUdLV2FQpGkwhk/GG0ct3R1GETzhGwkvxcYNqWRjOmx4vvri14OWXyPHDye
 Bxng==
X-Gm-Message-State: AOJu0YzFV0fT/YSfI0UieL1BgtQRjn1T68HaeYHNfBzwx91Z/0XoWi8Z
 9ruGlIT22lPJSYkFMOnNtQmBQ/kPYHaTgOi7NU9GtpZ51CNJ/Hw8zf7tmyy4wiOM
X-Gm-Gg: AeBDieuEJRVkTFqj0xpFNi6u2joFf3ziO+L0dNvqBBNMp6Xz+EZU82+Tm7EPemlp64I
 iy7O8nUXZGTm+eyi+uhJwmQVO952bUOSGqTctdJtp59Bn+MgDurnQg4uUgrogZP+WuLOjViFIbJ
 EJrkPsXE3PomnAlJwEakx11mk/c2Y4ynF4he/HaoB0Mt/f1tluz7IIth6UGuCxRXvhhZ/z3Fiwm
 g0fkDVeQi+zoELsfSI2ALRYVK0uN5GLFoBw26+CYFVlz9Ra/P5b/hdbm9twvmA0ZX9NI0QapiHf
 zZ4R6E3LZEACN3L98SjwbAKtr+vgKzlBzfLSuTmo3vdHJZhwo3gMBAeVR+eRSNfofEous5NKI0O
 4qYPjgxKDKtviSAlUa6SmPz6Qq6N2VhFJROO7+ypDkqLrNrV+/8IbFm5u1pPg5qm9nUmXsyrQty
 qMK2RzgWJtIQAU9Z2BlY4Kei80nxf218Dq7lMqzqIJOdrb4Da77skRaxzdFoYVUD2OuA==
X-Received: by 2002:a17:90b:5890:b0:35e:5723:85e3 with SMTP id
 98e67ed59e1d1-361403f12ddmr1614648a91.9.1776406737233; 
 Thu, 16 Apr 2026 23:18:57 -0700 (PDT)
Received: from fedoraemon.neon-universe.ts.net
 ([2406:7400:11d:a9dc:9a14:72eb:1a60:868a])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab40786sm9046225ad.79.2026.04.16.23.18.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 23:18:56 -0700 (PDT)
From: Avinal Kumar <avinal.xlvii@gmail.com>
To: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 neil.armstrong@linaro.org, dianders@chromium.org
Cc: lumag@kernel.org, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch
Subject: [PATCH v5 0/2] drm/panel: panasonic-vvx10f034n00: transition to
 mipi_dsi wrapped functions
Date: Fri, 17 Apr 2026 11:48:40 +0530
Message-ID: <20260417061842.66631-1-avinal.xlvii@gmail.com>
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

Changes from v4:
    - simplified code after removing redundant error printout
    - there was a branch mismatch on my local and that resulted in a
    typo, it was fixed in v3 but I had my v2 changes open and I
    mistook it as 'serial' rather than 'several'. Apologies, fixed it now :)
    - updated commit body 

Avinal Kumar (2):
  drm/mipi-dsi: add mipi_dsi_shutdown_peripheral_multi
  drm/panel: panasonic-vvx10f034n00: transition to mipi_dsi wrapped
    functions

 drivers/gpu/drm/drm_mipi_dsi.c                | 28 +++++++++++++++++++
 .../drm/panel/panel-panasonic-vvx10f034n00.c  | 24 ++++++++--------
 include/drm/drm_mipi_dsi.h                    |  1 +
 3 files changed, 42 insertions(+), 11 deletions(-)

-- 
2.53.0

