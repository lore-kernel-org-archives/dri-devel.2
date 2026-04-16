Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0285F8E4B5
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 07:06:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53B3610E968;
	Fri, 17 Apr 2026 07:06:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Bsfnn2PR";
	dkim-atps=neutral
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DD8310E1ED
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 18:54:58 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-2b4650d5f5cso19624625ad.0
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 11:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776365698; x=1776970498; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PLeKkfzWHS5ML4Om9B8pQ3L/JlsStI2i/wsWT7w+17c=;
 b=Bsfnn2PRkG5PGdgIXuautgYFgvQcMvwT+YBFjtm4ProA6odwHNYn/DfGizFn7/VDWR
 yymiuMWhQv5xlN9gPhmh1yme1ZGcYFyebAtBU2xVZ0ctszeKqcHwpEfA3RfLShnmzdY3
 6HTh50Y2XOW9b+JwPOvoOv2Gmd5CrHCa0o6rv9eIHRQh6sGhlSpJ/mJ/AsvD64jdFxkh
 Y8Z/H+rwl6xksGr/4R1MzxL+2lm810KiNtfgNw1gsVfBUY/DdXXNVpRAuSM7OCyFeRly
 MiWrAkUWydkOcD2K4jxMZpnOP/pq2lnwP9CiJJ1ds4utezNeOYlfI0yPfPX5xW08YOoo
 +dZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776365698; x=1776970498;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PLeKkfzWHS5ML4Om9B8pQ3L/JlsStI2i/wsWT7w+17c=;
 b=UPMWLY/WXDwhnpqsJnuN16ieEwlSUr+n+e3ZSZ64R1BNA5/MpxMGSKNYsCkIBnvkPd
 cAK2PuDnKxmtnWzGmDYZK2/T2BhJ+SxHdefhdGFSg0BkHE5/ijltN/EJRmGJcYHazYDG
 R1WwsyhrfuWtfkaFr5XvfAc4sf1us9I00XAdiOdi2mlNWxAhuj+dQuFNR6lXwFvxtfHZ
 voZaHXpKpeNVvClXu+HE+GYZMyr18V46rCilh5/djmf7xiIsIsD+a4m/EZIEf12HkPqX
 zTY+qAKNrIqhkWTqs661VfCTVLux0HgHdDeWQXJLg1Y75SHzT/DDhW+aOV/YO/I6OSbV
 HBIw==
X-Gm-Message-State: AOJu0YyxjsZ9M4rvUJjG1AApk0B+wNMtdstTfX4llblQfOkx4L7nMeDt
 0po7UDMK16e/EDlF7Na4cymse9OVmOoDPbl32+xE7kTZcMHBOhrvCVoR
X-Gm-Gg: AeBDieux2SM+s4eRXlbVY7RaH9avcKRpJaMT6oYtSBsi6KT8AazJiBFwO8xEHrGrGFg
 ONFDpnEmyfd+QBa0EJ01C8TnTJqlRjWZ0vev6W/x5bfICgU02j30LP2XMmcGFyJiijX7rHtlsNK
 oOHCQStSaLUe7Ttt69GHnPjm2FIMbB9zLidyVSfq1m7AeigjjmiBN8JjEPwU9UJ79Sw77vLTE0y
 9sr928dE0pWWkvD11qLaBP0FxiflSnmp1q+StwP/TNeQR52VDzDKEUwMJ8o4U0McV0MtWAAeJsw
 R8+7GiaON/nqVwX+5g9voIt0awgwHopz4/AYqXdbYJprtxWENMQtGquJiHlYO+b96a8xxTNgdy7
 25Iry/LsXBJflLpTCcB+7SZwd3OviU/ZjmL0auSQq6CcL1MbZBMHJc7g2m2P+ESPp1HTgHiaXXn
 CsATIFMv/wNCmEldnYoMpLa+QUmz10HnVAvzymgoiDeLMmgEpnuEjv8JxER+zRFqAXEhIjuR4uc
 IvFzFypIQ0egft6/loi2inODcLz0nCk4vZkwFEv8+TjXg==
X-Received: by 2002:a17:902:8214:b0:2b4:5e7e:34ce with SMTP id
 d9443c01a7336-2b5f8f6674amr1059555ad.39.1776365697609; 
 Thu, 16 Apr 2026 11:54:57 -0700 (PDT)
Received: from lucifer-Victus-by-HP-Gaming-Laptop-15-fa1xxx.iitbhu.local
 ([103.151.209.194]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b4782ceb25sm64369245ad.81.2026.04.16.11.54.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 11:54:57 -0700 (PDT)
From: Sachin Kumar <sachinkumar905846@gmail.com>
To: andy@kernel.org,
	gregkh@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
 Sachin Kumar <sachinkumar905846@gmail.com>
Subject: [PATCH v2] staging: fbtft: clarify TODO comment in fbtft-core
Date: Fri, 17 Apr 2026 00:24:38 +0530
Message-ID: <20260416185438.273165-1-sachinkumar905846@gmail.com>
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

