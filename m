Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 431C3C5DF6D
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 06:36:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A6E310EA25;
	Wed, 19 Aug 2026 06:36:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BawctR3U";
	dkim-atps=neutral
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1294910E74D
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 11:23:03 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-382ef647e20so3025088a91.1
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 04:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786965782; x=1787570582; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=P5TTthgk+Rg78pTtJpD/DUUy985t633wbAtev7NEJS0=;
 b=BawctR3U2ioi9cEc+8B8oqpawmRq6GeaSsCzlmR0GKz0kgzBIAmx3UF9uPAN6JQSq3
 P4oC4ugOIWHqEnB35tsj6iz4Q0Mh7hJSEJP8YVxw4ZfeBE9EUcE5RQeHlWxEPErzo4r5
 WbmhVSmarKNv0NdJ/XqwI/P/XCaoudbJyNgICFNUmaaBDTi1bQVU5acTp5scdq7G5KnU
 9VUZShl7MGwrGmxFhe81Qp9JmfOAu8JHW+Mb3picbxA1a6UMMOss5EDdFefea8jjsZVP
 Wysjsq3aeW6j3+xtdSzCPv78i6OmhSvv9/0nWaLSK7bDsIzSkqlq0Gqs0ViAaSF8RtpI
 4bZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786965782; x=1787570582;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=P5TTthgk+Rg78pTtJpD/DUUy985t633wbAtev7NEJS0=;
 b=AmOUgWXJRoIy658CCgesp0JvIM+lxmXCaMC2tP+qIqQX5e2h8Sj3H7rbMqDuVrKoHo
 bIELsZ5zDc0cIbLn6po7GVLa7zQtxlp+H+vEwSrKllyAYn11advf4dCTlQhcX+rQwpeG
 A2ooOlQIvh6DUkcZsrofpOj+/zQKmCeBO5eZS6LRhZc12CglTuRtROAnwkUQ3AXg+6iX
 pT4rAvVx0mVN3XsbKsEeo41RCdOUZoffCbQ4CyLGGXelH8I2cOXTB1ShbQScydxcDImB
 dr2TE0phUJjNBws6Y6mUgz3nhiLUXIWqKRD1xxA8Jh6Q9tETc3TgKmiW7/7ZwA5ZgG85
 YTQA==
X-Gm-Message-State: AOJu0Yzsmfaxf3ijA4WZ23wIGhvPUa7fHfaEqIIQ3x+mSUfkL9uMQn8r
 ZndDp5yqUqcvZxWoAdJWuE4ULwFp7DpBe8FSoHWkR87vJ5VLGD5Mv6g=
X-Gm-Gg: AR+sD13mWQ2mcukuOVXoo6C4vc4+laHBaju+oz/1A8qtrx1paPZa8fl7guNDPRzBRmM
 NntBOR3yTdGFAdemsxr/xr4dFpArkUZXrwFcIJQIR00lsrYpnuqLLjp+HFFdYCEMIlBTDzHX0hZ
 PDfTmxVtXQOn9xoaB1zBULwtq8JOjSbVK7JVNZBy6HNFYcciRgTloXZCGyh3DPZpCDKyCd66S5z
 jzeblaomNvK/xHX3dwCOqQ5xTuZE8ndiK3RE831WrjvNGg3xO2roTcbjmzNIxESb+EWlyxD0sZZ
 KJ1nue9g2/13J5hfBD7RqVs+WJFRHHQF/YuOGLRzebUy2umATdizpzy8bbzdqLcmXhn68hrWT9u
 82/3187gxNmkcib4HqkvAEonojfkOBoLf6t2i+BncDE3G1aBkU8PSJ0rHCl08tzvgQQDIagDkjo
 JjGAb2EGYT70aHooJtpT77pTwbbHaSmUTWcUMLF/ly0S5XI0QDsHPUWJrGWjM040TK/Bx9gCur+
 TC6cF24DwEYld4FTNMyo0FEHt7g5mOQ7pGVrJ+CH/wkOhhU46R2SZUM2Y+Lvkd6
X-Received: by 2002:a17:90b:5291:b0:36a:5d1f:7b6 with SMTP id
 98e67ed59e1d1-3933bd18849mr25980349a91.2.1786965782511; 
 Mon, 17 Aug 2026 04:23:02 -0700 (PDT)
Received: from
 codespaces-a1fa80.ktkhmpmw22vebpok31ngjx2qsb.ix.internal.cloudapp.net
 ([23.97.62.112]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3954d2e64dbsm1953571a91.8.2026.08.17.04.23.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 04:23:02 -0700 (PDT)
From: Triet Hoang <triet.hoang.dev@gmail.com>
To: Markus.Elfring@web.de
Cc: dri-devel@lists.freedesktop.org, ogabbay@kernel.org, tomeu@tomeuvizoso.net,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 royalnet026@gmail.com
Subject: [PATCH v3] drm/rocket: Check allocations before use
Date: Mon, 17 Aug 2026 11:22:53 +0000
Message-ID: <20260817112253.26086-1-triet.hoang.dev@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <eb5a74fd-8db4-4ea6-8fb0-96ade2f3566d@web.de>
References: <eb5a74fd-8db4-4ea6-8fb0-96ade2f3566d@web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 19 Aug 2026 06:36:31 +0000
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

Hi Markus,

Thanks for the review. I'll update the patch accordingly in the next version.

Regards,
Triet
