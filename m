Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CCA7D58CA3
	for <dri-devel@archiver.kernel.org>; Sun, 22 Mar 2026 22:01:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4790510E08B;
	Sun, 22 Mar 2026 22:01:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EWOWlrKq";
	dkim-atps=neutral
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5613B10E08B
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Mar 2026 22:01:32 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-43b44c0bcdbso3747108f8f.1
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Mar 2026 15:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774216891; x=1774821691; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=LoniouiS4pfhVpBZnivyj0bnq4HH5JzaMv3Qz8c4efc=;
 b=EWOWlrKqKeoiSTBL1L2UnhAub3q7B1JPyqZ9++oyt+1sOlCL6ZJkUDuBClqz6/pkkM
 eQnWEy3bcoc36pj11f4w40eHTpkOwDNmUMznc6exkNvcQuG3kYPSXONqtjdG7py/ZI+s
 bghkHxrNgQcKN6hVXeUza7LUBxtUYCpDbSSw+7feygpKc5QUYWOth9wg/7qXZQbymMWC
 ZIUXEDpL/2pfm6GYhb9sfVlu/2uLGn0b7FEe3uuHR+aOpOwlVK6OxRa2AF38T63X0qHZ
 P+XOR+KmhOwHnhDxyCh8cZAFeIMhXjpo9Yhsw56+j25sW8QJ7a9Q/GPDkkAzac0c4g1D
 /M7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774216891; x=1774821691;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LoniouiS4pfhVpBZnivyj0bnq4HH5JzaMv3Qz8c4efc=;
 b=JiAGAcaL/Z6AvMY4p8Tpl+zbY1iTENRu75JetOWq9hD9cMyqpeX2sMLalB50NkiCku
 n5K1aXsQ1Boe+VtyuL6nm+YyeGq89AI816ZgdT7xIhNEI33tzHRNgTDHXGg34wyrwNMe
 HsVPE+SpJWmbvYYaPByCxL8o9kjwwYgx1pbcuJoDou5NtqdhKivbXKow8QTR59XI62lq
 S6a1hU6ZfSabiLXzsNt34zKlsLsmswNYHfCSVaLquhnDA/54oA44AUsCxh9cQInEpzWE
 2dhRzFzAe+dmntJElDWpCRecfnUuSZLe3OvWOPNrI3BnE8eiawC7QGqFodvKgsfFe0Rz
 VETg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhWwH9G1bq8uV5EDz3iBdk5cuq8Z3bKvTkQ9nYWOi1gab4QfDj1eQJNJSuIiTnZZkwEzYHDJSGiyY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywc5TYlEMWEbPrZ0gkwGLanNPwgDGxDxIiF1aS5fhSLXHyZ3cMP
 s5QoKNjSW9j0wuofs7g1k5LKmUThW4dlfG8iuD6647vrNWbz5R4q4krL
X-Gm-Gg: ATEYQzxEVekKalrOa1jPkJJLForNCJstCtro2RoZbqlNWR9vFigcn/n4WnwPuyAsi+q
 M7LQjVS6JMEYX0vS8R5ALzMHwvGm1zE/IwTz5UCSr9EHbKcIsJgr5Xistdtkt0V2uHc8BfIWggf
 6lTGvUtXTgDsqhnu2cj6iAfq3bKoDVSAFmGcMBi8TDUzHP1uogwMHGe2uQcyQc2J1UnT3W68h1D
 vdlYk8oYZXThsTIdUyuI+OaarqQ7+jusB5W2ohlHnUT0Plst3Rh31yUuacb0TS7F60P6Hi3M+Gv
 aSTA+MCY8gI/SSg588B40raruSnynsZVq1oTLeAQT2M0myK9FoO0KnvyRYGjPM5Nez625LnWQYy
 ilba5wv1er4dcPDH6FWiHcD5w+a4IDcpVYx4IO1xfrS61+MTP1lFsao2vW7/2QL37uICvJaO9hN
 LJve62ttnWtEErILq7nG42tIKSh9Yz7P1aYb9JNdlP0/SZVxLoP3pSBfDp6kp2dIIyMQ==
X-Received: by 2002:a05:6000:40ce:b0:43b:5097:6f62 with SMTP id
 ffacd0b85a97d-43b6426d5a9mr15833451f8f.36.1774216890443; 
 Sun, 22 Mar 2026 15:01:30 -0700 (PDT)
Received: from nixos-office (195-23-151-163.net.novis.pt. [195.23.151.163])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b6471a297sm25215437f8f.37.2026.03.22.15.01.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Mar 2026 15:01:28 -0700 (PDT)
From: Julian Braha <julianbraha@gmail.com>
To: mripard@kernel.org, maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
 christian.koenig@amd.com, karolina.stolarek@intel.com
Cc: airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Julian Braha <julianbraha@gmail.com>
Subject: [PATCH] drm: fix dead default for DRM_TTM_KUNIT_TEST
Date: Sun, 22 Mar 2026 22:01:25 +0000
Message-ID: <20260322220125.1380776-1-julianbraha@gmail.com>
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

Fixes: e3912d09bf8d ("drm/ttm: Introduce KUnit test")
Signed-off-by: Julian Braha <julianbraha@gmail.com>
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

