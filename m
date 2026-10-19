Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513D0606A319
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 07:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=p+rzkMLk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6364E10F300;
	Tue, 20 Oct 2026 07:36:34 +0000 (UTC)
Received: from mail-dy2-f6.google.com (mail-dy2-f6.google.com [74.125.229.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2649810E4D5
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 09:43:46 +0000 (UTC)
Received: by mail-dy2-f6.google.com with SMTP id
 5a478bee46e88-35adc681e1aso4272962eec.0
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 02:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792403025; x=1793007825; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=knrHyzES/QXTzztJhLzmWRpJR+Ay5sPD9k7TLCcmxn4=;
 b=p+rzkMLkKUjZydvC7km83sLmQNo6GrH/fenI6TeI52G/Y+/C1gC2hTy/LSaRp+5rJR
 Lx7xILy14FwHln+eNBpPw1VPE+wPVaXtQ3DlfVQfVfcvc/b35wV4+x249QyY8Zhj7Hob
 u3ROtN2rlPtt+/DVsS4o+5sbQYeh2/00YeoHOZeDxo5zN/mPkI8J0etnliKOm0oZJ2cP
 mmxNM/ugm67SRHEitNTsE+abfjuuqLu0oQ8IBkA7A9vwi1j5JUV2WVOiefXvm0d8av9Q
 w5wnTmY/xfwQgHAp7nuorV7Swkjbbodn0hvxS3onBGhE2uB4KAaMRd6tU6/dzXO6Yiuv
 YYOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792403025; x=1793007825;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=knrHyzES/QXTzztJhLzmWRpJR+Ay5sPD9k7TLCcmxn4=;
 b=GSuK3Z76+g9IFaoELrvfT6mtSiJ7JuU5YeezaDEXeDjg/03ncltWKfc0fvzepJD7WA
 EGCFoyXTdYQpyfGpYwLaZWKK77BFN6GNT2P0Z2ILTSkV+R9X3252kb5C5BRTrMauiYlb
 qcpiKLvt89iiXfZZOIpA2UEsVyEURkj2RXXAjMy9H8isMkwdhkb/swVEZTNFtNLantZJ
 gUAXu8+Jf2FexzhCzMSd5lsqideo8Dy/HLS2XaUX3U9ex60L4S6sbzXErG9eFZNqmhma
 6nJ1nFm5Nu5qTtHsAnRnhDWi+xldC7XMA1vBkJMY3/MzsRIHEM0RyEWuLWjk+PqsXrOW
 1OKw==
X-Gm-Message-State: AFq9FYLxKSmgmUdOsFrF3AOv5VrqRSsBKCJri+nFF9QJLmJdk1rEe4rI
 iFWwQ5rIoqnHnJYe8uQonR8FOja/UnXVBxjA2I+07pYFV1SFR1j1jGGk
X-Gm-Gg: AYBFou3MvAEcSl3QkbzHFV5ZMpyjVpl7YIPAnLTk5q28fxmgV++snhrD3g3iD+6Be1Z
 Km8lcK0c4LmelsXFXN3jEpnxW3gCwpGLwI/XKYyw249U1QMqOt08UmfjcaoFrI2lYh/bR1i/lBw
 6OtPiYRY67h/JipSYmEFaOAEokj4lBIehim5b2nyfhZFbM95Vh+nGgH5VkfhMcH+ETBcUYz9c2j
 oA/fQl3SMsvLCtfQGDoEswf96Pm692IoCFIcMg/U7/U0vnwGW0lEUVMoEiTajStLrlQFyloupP4
 16H/AoElGsxO2ALuC3CctMQsrfflm0Ny2VeI0E1le3lzWFcE9OHYh+7uGvgBVUpyzNeYvVZGLXv
 6ByIXFdNPeP8iSDu9/1sx3n1SRXSoV0N0iMM1bt3+4iDOXnCBavSPM1cD/Mb2My9AteFvlqOsS7
 dkcuvZE9AgVOoQIgPZTxRbeCPDDiW6QrAgiSLoS2R1eWl6R2gEQoAuIsZX0DeliBEvpanI6v33b
 CCrGDvCE+WZAVxiwJashtpzcaTwhFe4E1z6
X-Received: by 2002:a05:7301:2727:b0:35d:a10d:11ef with SMTP id
 5a478bee46e88-361a186599emr11742279eec.11.1792403025311; 
 Mon, 19 Oct 2026 02:43:45 -0700 (PDT)
Received: from blue.tailcc13ef.ts.net (104.194.64.109.16clouds.com.
 [104.194.64.109]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3607bc950f9sm34370074eec.0.2026.10.19.02.43.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 02:43:44 -0700 (PDT)
From: Yao Yiqi <yyaqia@gmail.com>
To: deller@gmx.de,
	tzimmermann@suse.de,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, yaoyiqi3@huawei.com,
 Yao Yiqi <yyaqia@gmail.com>
Subject: [PATCH v5 0/3] fbcon: fix rotated font buffer handling on font change
Date: Mon, 19 Oct 2026 17:43:28 +0800
Message-ID: <20261019094331.1128871-1-yyaqia@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 20 Oct 2026 07:36:08 +0000
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
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Fix out-of-bounds reads of the rotated font buffer when the console
font changes on a rotated console (fbcon=rotate:N). KDFONTOP installs
the new geometry and vc_resize() redraws before par->rotated.buf is
updated, so the old buffer is indexed with the new cell size.

Patch 1 keys the rotated font cache on the font geometry. Patch 2
rebuilds it on font changes, saving and restoring the whole cache if
the change fails. Patch 3 retries a failed allocation.

Changes since v4: save, clear and restore the entire par->rotated
state instead of only the buffer; restoring just the buffer left the
cache key describing the rejected font, which could make a later
switch skip the rebuild and index the smaller buffer with the larger
font's geometry (found by the Sashiko review).

v4: https://lore.kernel.org/all/20261019090206.1094958-1-yyaqia@gmail.com/
v1: https://lore.kernel.org/all/20261014085102.497789-1-yaoyiqi3@huawei.com/

Yao Yiqi (3):
  fbcon: Include font geometry in the rotated font cache
  fbcon: Rebuild rotated font buffer on font change
  fbcon: Retry rotated font allocation after failure

 drivers/video/fbdev/core/fbcon.c        | 46 ++++++++++++++++++++++++++
 drivers/video/fbdev/core/fbcon.h        | 19 ++++++----
 drivers/video/fbdev/core/fbcon_rotate.c | 10 ++++++-
 3 files changed, 68 insertions(+), 7 deletions(-)

-- 
2.56.0

