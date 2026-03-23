Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C73DEFC72C5
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 12:41:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B96510E2D7;
	Mon, 23 Mar 2026 12:41:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="N00s9hEm";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89AFD10E2D7
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 12:41:31 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-48702d51cd0so26676865e9.2
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 05:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774269690; x=1774874490; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=Lau9h99Y6y8FLxIXBEqJDS1ul9IwPI7IFZFtPXW8rMc=;
 b=N00s9hEmniYmxQX82yDngBWxCoRsmUcO4y16BCECrBsooLkPujfZDmT1uKX/iYh3Fo
 49veUb+ALg2nM07qiZK9xKPfBMAkjElrwox2eXSSAj1GoT82KsPIRkuzmzhsZpFNE4fp
 EuLymf5BiKBd0IgplgCIoKI0oEoYPVB1ci65ooiXGqXR6gc7MYgxVuiPZ3zOIDt0dNUZ
 IXFIAP5gEAVD8VqFsyOzoLcrpYXoJrLMgM7xJtKupbrkKR9LFbAI72cK17lDX0d0Dv6j
 zkneSp8PgoaIMBFBwioWuCnMU3lB8jFhGaKm3EVonqjgUZ9VyrElookxxsK/WVmfWgLb
 05lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774269690; x=1774874490;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lau9h99Y6y8FLxIXBEqJDS1ul9IwPI7IFZFtPXW8rMc=;
 b=WxRnr0/U0Vtpi9A9hyDapcN/FZfePOg09wvszdKk48MgNDlFfoGJoqmxb4eGziAPR3
 pHNbxmbjqiF4AAzr25P14TG3zJBAv2jtv5gWnJL53qkN125Oqfn5h4TYYH0+nkEzWCNs
 RXSQpknKNR2RDojr/PA23mur/4ABvMmnxHJ2Byrm9NfbSS9bLSkFEO9ZZ0qyMmliPBln
 1U3+o7rYijTLbNyKs3+Wcrx/CQM/FtJrs8ShZ/piiTazJIaFsaEwYnycHfLVtt+kSOKp
 R0Af5sk/ceuA9gsoK9/7+QANHfevTHbnk29SFeWeCFjRgi18MSGXyQmHJdnDfaHLF/FW
 YUZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuOwSgNYWWZ1fSlsqK5W215k4B0NLBUa0wB3vHk7wgnQpFjBv1S1aXY58eM+tbrawRFMXkdK83oJY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwvTxuBvclSBNrz1zHrrSslcTuVclbHhnJlD0jf/B60nB+yFmkq
 zOfuc6G6jGXW/eLEhqUG02ZOHaLR2yz2I8YLhXfnq+3PW2NILYi+7zf1
X-Gm-Gg: ATEYQzzd7QsGPQiul8eyRtHhYMHYdYUIXi7msqbhUZobDM1jCdgVFFbSuYteZ30D9TX
 3f1bv71vKwknzczvgM5zyWmd9TDYMVNrqRuVoc70ar16cvbAv/Ukin01a9io4HkW2Ma4ZQ9LIjI
 60piHZS+y2D1vktd3MsrkahhIYJPtaIMmCTqvnKzQtvEaxP0hubGWo2uW9MBH0F+rzXc7QG0LKi
 IOoisqKBzpqaVm9ROt3bhVL6RW4+tEUQseoX1rIZc6x+SjqtIFX1X6UL93eUdOzeBBlfEl2rgzg
 +q7HttEJ8kvmMeFNJLPdo4YYugqzX79cAhYgvMJqzQas8HDslJ6s2vH8EpQtFSa4H6EFAHLwLCD
 LrSDYU+tAJSb3iQSUASXq0dsmxVU5n5WY57b0Nd8KOe/WcWg+DqhWN8pGGlXmwU5a0PGeCc5s5r
 hmiMsO6V1/vR8PhMYXU9QhEO6E4Q==
X-Received: by 2002:a05:600c:3b8c:b0:486:d76c:fa51 with SMTP id
 5b1f17b1804b1-486ff03ffa5mr161795585e9.27.1774269689772; 
 Mon, 23 Mar 2026 05:41:29 -0700 (PDT)
Received: from nixos-office ([92.250.99.190]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486fe8ceebdsm111295345e9.4.2026.03.23.05.41.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 05:41:29 -0700 (PDT)
From: Julian Braha <julianbraha@gmail.com>
To: mripard@kernel.org, maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
 christian.koenig@amd.com, karolina.stolarek@intel.com
Cc: airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Julian Braha <julianbraha@gmail.com>
Subject: [PATCH v2] drm: fix dead default for DRM_TTM_KUNIT_TEST
Date: Mon, 23 Mar 2026 12:41:18 +0000
Message-ID: <20260323124118.1414913-1-julianbraha@gmail.com>
X-Mailer: git-send-email 2.51.2
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

The DRM_TTM_KUNIT_TEST config option should default
to KUNIT_ALL_TESTS so that if all tests are enabled then
it is included, but currently the 'default KUNIT_ALL_TESTS'
statement is shadowed by an unconditional 'default n',
meaning that this second default statement is currently dead code.

This dead code was found by kconfirm, a static analysis
tool for Kconfig.

Signed-off-by: Julian Braha <julianbraha@gmail.com>
---
v2: removed fixes tag
---
 drivers/gpu/drm/Kconfig.debug | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/Kconfig.debug b/drivers/gpu/drm/Kconfig.debug
index 05dc43c0b8c5..75c186f938b0 100644
--- a/drivers/gpu/drm/Kconfig.debug
+++ b/drivers/gpu/drm/Kconfig.debug
@@ -86,7 +86,6 @@ config DRM_KUNIT_TEST
 
 config DRM_TTM_KUNIT_TEST
 	tristate "KUnit tests for TTM" if !KUNIT_ALL_TESTS
-	default n
 	depends on DRM && KUNIT && MMU && (UML || COMPILE_TEST)
 	select DRM_TTM
 	select DRM_BUDDY
-- 
2.51.2

