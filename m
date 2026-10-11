Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3EB7CA9EC5
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 07:32:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84ADE10E513;
	Mon, 12 Oct 2026 07:32:08 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 201F410E030
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 06:47:20 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4956869750eso7689885e9.2
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 23:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791701238; x=1792306038; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=1QXG/OHOueFMbmPjMgjHa4I8+bxiyo5Fb5MP2BTqljM=;
 b=OAoH/exmUOIzUSU4ZER7UMQ4qWGYlqpxeeyNm0XOteJOImS5GqZx854SIYfUTVFl/W
 yPu3uml0CQqdszTA0Ln1873hxeBXKvmGTVWg0b8yOZcfmGmYJwCPjT6j6KwstJCgVTOa
 efkEa8Agi6yBkbQYf5sd80uPNwK5oTEI2VkUyPirUzZND4OPR/p6XDNURC7sSXLvWkWd
 YPpDahdb4ARBCil/yPYsgnaFktPSb9J1uRzt7kz9slAbrHQg1vTLiurv6oGrOeBDe7YX
 fATXq3Xk2Lfe7MJN3rEXq7fazpw15yU+dMeDir6xGWIue2mIrKeGWZuMY6sUeOpgc42f
 Yk6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791701238; x=1792306038;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1QXG/OHOueFMbmPjMgjHa4I8+bxiyo5Fb5MP2BTqljM=;
 b=BOmgxmUnk3xSNFdrZKNBSQFTiGD5IiHfdGexOuuNAGWaEzkcvimvlmIoZJ/PYJ6O1k
 ZjROClSSi/bQrfU2aWEhU4oANZye1CmaerTiBuTmljLq+/okpGUN5U7+dd0au2ntEpsE
 2E5ngU0TpNoF34Gl3pmfU8oVRODUlzL1mDWPftgJgfP8HC6bN3Ie0b1gOOAjSK2nW8oJ
 e7j7ld8ajkTJMwykFa0bEMwNfmAKTuC0l3FmEyb1S5IPmHEyLy6baqrOSxrGGcht7Q5Z
 LO6LQCWJPreZEjXtIawHnyhBEYYHnjjb1zo2Yejyt/6wsrrNo8OsW4qENdmjvEiBJ0Sb
 ffdA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzYX1fFa1XcigxfUT51EDGdXsWxFBwKYiro4KhocyuSY53p3NdoXZpXSLV1+AZBcsKWhryKQRisFto=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJ8ZHSUTjnK/2oEVuEaeJOPNiPEm8vqjLXFw+HQ9eVCfjGLIZYx
 ij6NcdP1fW/jGerfziCubxZjj5AiK2+4EtsHxCb+DhTSbzLaGFLRqD9U
X-Gm-Gg: AYBFou1zRj9BXwRNV1MxsOgCUcd81ZMBL1xw4xwj3qRohZIXp4nxe5HDv4k8x0TGfme
 uuOzhLdj7GU0diqCGROXPXBn6vavjViFxtlROyNAt7t6R632USgs/hOfjwMC3Yg0wJuISYVVPpW
 4XxSlgUyBR0mI8zUBPB9G17jB6rnnPIsnBnST94M7ZI4P25zf0FDvVk6cYoUTsO9CUBZy0eoKv+
 Nw7RZQwyBA9ndxzT93AsDgLfxlCK5gErDTuKO59xSk92aq20u5kVWfIxHQD4Fcv+GfCE0mAdQJ7
 zm2GcoOm0fds96APFBkr9AERkjUM3NdNUUK5xMRhFHzLXMqX9kG/urpq1BzhqNBZG67r674D4AA
 RXTuut1uhBomd4/4w16JrVC7AhWEpRaVzfwWNrCUpsenyrTLVgUzKUA7hgJG7b97JIdBrtn8t4J
 6wiM3eZltSnV9c4PiBE1LqPHcCPRi+Z6orMMhzlJOw7OwuEx+PHU6SR7CfOEn/B2hT5BQtuc+nE
 ZDmmGj/PZ7qOtR3dJY1h+jY5E6JJXGhtyQ=
X-Received: by 2002:a05:600c:1c15:b0:4a0:2867:d8a9 with SMTP id
 5b1f17b1804b1-4a18e4d67e2mr131695315e9.30.1791701238379; 
 Sat, 10 Oct 2026 23:47:18 -0700 (PDT)
Received: from LAPTOP-AVI.taile24b5.ts.net
 ([2a06:c701:4778:c500:e952:dc8f:95c1:823c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18bf31b83sm194319945e9.12.2026.10.10.23.47.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2026 23:47:17 -0700 (PDT)
From: Avi Weiss <thnkslprpt@gmail.com>
To: Joel Stanley <joel@jms.id.au>
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>,
 linux-aspeed@lists.ozlabs.org, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/aspeed: Propagate DAC mux register update errors
Date: Sun, 11 Oct 2026 09:47:14 +0300
Message-ID: <20261011064715.2422596-1-thnkslprpt@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 12 Oct 2026 07:32:01 +0000
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

dac_mux_store() currently returns 0 when regmap_update_bits()
fails, implying a zero-length write instead of the actual error.

Return the negative error code itself for observability. No obvious
reason that this return should be clobbered to zero.

Fixes: 696029eb36c0 ("drm/aspeed: Add sysfs for output settings")
Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
---
 drivers/gpu/drm/aspeed/aspeed_gfx_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
index c8746766f258..a933ad358852 100644
--- a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
+++ b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
@@ -268,7 +268,7 @@ static ssize_t dac_mux_store(struct device *dev, struct device_attribute *attr,
 
 	rc = regmap_update_bits(priv->scu, priv->dac_reg, 0x30000, val << 16);
 	if (rc < 0)
-		return 0;
+		return rc;
 
 	return count;
 }
-- 
2.43.0

