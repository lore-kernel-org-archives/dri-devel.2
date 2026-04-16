Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB6EDF8E49D
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 07:06:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D8D810E970;
	Fri, 17 Apr 2026 07:06:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IBe8Jf3Z";
	dkim-atps=neutral
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com
 [209.85.210.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2352910E1D9
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 18:49:54 +0000 (UTC)
Received: by mail-pf1-f176.google.com with SMTP id
 d2e1a72fcca58-82f41fce3e6so2446044b3a.1
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 11:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776365394; x=1776970194; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PLeKkfzWHS5ML4Om9B8pQ3L/JlsStI2i/wsWT7w+17c=;
 b=IBe8Jf3ZWNMONUVJFhDWbQSlbM4PODlYHzGcbkUL3Oh41B/2PGXvLLPDg2a6wZsNBb
 T+2Xkg8zD4s2A/WEj8OvrkHUcUlndWXOUMOrSA9A9lecfE/2fA/t5LdSIJhBGCxRDGeM
 bRxQe5frYot2UCuLUMMwbx8my9X9X5zOfrpgmjZql4T7UVTkS1vBsaHEHWifuJh4zpBv
 UGnlOEUcUuAS3Xibn4impdoPLSmushYHklLcHIsVVSZhBD2hd+eBpUw68dah5X+pLP52
 rCPrECuiGPb7Q2VTde1hXU8VbxVqjH3SadjGZ3hbkpZeYnv+EyTEJyb593YhJVC7ktRc
 XdKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776365394; x=1776970194;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PLeKkfzWHS5ML4Om9B8pQ3L/JlsStI2i/wsWT7w+17c=;
 b=RH9ZUjkZDtSeg83HGn1we4bIqLK6dp11G4I84GdAdlg2wTupTbdp4/lpN10cPoG+2e
 GPpy8fuca9eWIiI6ohTVV/pO+k0IFoejStX971ccZEXmVM/fctdCvn0M8Exmuobrm8Cq
 +87G3D8af6+G363xfMPEp3XGkU2ZjzGxHBvwhC6slyUVkcWAvS1r82ivihduGNnx57ni
 nP3N915oX3xvNaN3t7AplfZ5RwMkCHAEZVL5VgURgfqkdOJ249fp29icF1FERbYWKCnO
 3EWotQw4qqoHy6gZNOyxbsPQL3zKaOJOzB6Dea+J8rn5KRYxW4sqj3n9Gm4imGZnij2F
 wszg==
X-Gm-Message-State: AOJu0YyLviK8EaPLpuM2/54OpRrfFJd5pWaO13OyiE8+SmE7rf4VuYlI
 YtIm0/yjgZ69nn3JJhXQIP5yWKCo5+RiiFBRRZxr0eJK2C3lS3VJh5+K
X-Gm-Gg: AeBDieuO2LxyWs9gxCs37rg9/aZwB74ZPmQtGe9lw0/kCM6zGnqmYNb5lcHIgJMDHCw
 RR7m9kRg/noaQrfaijU0wYIgDBVmBPlGq1tKHgyXnxpC5wgEQ++w3F27DN15wxWCwf+wCbnZNgp
 1wHVkauxGXQttTlZ7jPF3wHwMDtqDk0+InIEnl5NGXKSdC0VG1kV2i6cLv5NGZ881ouJEicb4iZ
 hA21z0F5jL1tIAi5OnoNQK60oJb7GU4g05MXSPncEEth0b+w4S1gXKVtYM+4/ua32sfch7t7vDl
 8cykznOKqoNy3VCPP2lhhuVrnPK0YhBaaQ+I7kZSJ0RAmAETDWBS3dMl8WEQl3Gn8RZLDGgjITA
 Om/je2uUKI6FOWMQgK0P7dvZ47EajAUE/CLe0csPFGFhKJerKiTHibz40ZY7iAophGPC6Dk/Ps1
 WupLHwik8jhhOw8yP1LG1SwmC3iwAifVlglRVLGk+0DKbSBOTTYW4FDUqDxK2HtKjqMXHG3EPzR
 ZFMHn8VeeI/75KcwtLYX3Zp6UQQanybobA=
X-Received: by 2002:a05:6a00:2283:b0:82f:6a87:f75 with SMTP id
 d2e1a72fcca58-82f888fe3f8mr508335b3a.33.1776365393532; 
 Thu, 16 Apr 2026 11:49:53 -0700 (PDT)
Received: from lucifer-Victus-by-HP-Gaming-Laptop-15-fa1xxx.iitbhu.local
 ([103.151.209.194]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f69ef0b79sm5378617b3a.36.2026.04.16.11.49.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 11:49:53 -0700 (PDT)
From: Sachin Kumar <sachinkumar905846@gmail.com>
To: andy@kernel.org,
	gregkh@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
 Sachin Kumar <sachinkumar905846@gmail.com>
Subject: [PATCH] staging: fbtft: clarify TODO comment in fbtft-core
Date: Fri, 17 Apr 2026 00:18:28 +0530
Message-ID: <20260416184828.266168-1-sachinkumar905846@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAHp75VeFZ7PDV_tT8tDibQk-VPkFFHsxiAHOAx-9Xp0N1ijvAQ@mail.gmail.com>
References: <CAHp75VeFZ7PDV_tT8tDibQk-VPkFFHsxiAHOAx-9Xp0N1ijvAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 17 Apr 2026 07:06:15 +0000
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

