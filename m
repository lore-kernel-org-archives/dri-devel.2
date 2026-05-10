Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55404CD37B2
	for <dri-devel@archiver.kernel.org>; Sun, 10 May 2026 22:26:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C09B10E201;
	Sun, 10 May 2026 22:26:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="EdN7zR/+";
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=valla.it header.i=@valla.it header.b="HoBVklFE";
	dkim-atps=neutral
Received: from delivery.antispam.mailspamprotection.com
 (delivery.antispam.mailspamprotection.com [185.56.87.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF17910E201
 for <dri-devel@lists.freedesktop.org>; Sun, 10 May 2026 22:26:39 +0000 (UTC)
ARC-Seal: i=1; cv=none; a=rsa-sha256;
 d=outgoing.instance-europe-west4-kz0n.prod.antispam.mailspamprotection.com;
 s=arckey; t=1778451999; 
 b=zvE/XPeu42QgWCS66z6C1MtR9pJB91Ip4uABIkaF4zQMT3gNMh7txP4Lp9vi1JpmWa23gWp3YN
 i80MNsfVAXKs8XifRZqSfqtaNHPIP5XKjJQEwgi1CTdOutlD804Asi1VfjK7/qYxosF5nGwCf6
 oZ3SzKZfAqXM6I0b49SdzqPGoPt2UZYgSzcjwTIdpO39loaONJNdrdr4L/5PQgpFEsSEd0yMBi
 7pogDxkGPsgT2bAnRWpS1iThkVw28jo6CWuRJlCadu82+NWRrd5EAqF5YdTBsKNFxW242eBWCg
 wu7uz9uL0B5qN6hF+dh587+elmkw2OgHvvDl7fjT0nOJfQ==;
ARC-Authentication-Results: i=1;
 outgoing.instance-europe-west4-kz0n.prod.antispam.mailspamprotection.com;
 smtp.remote-ip=35.214.173.214; 
 iprev=pass (214.173.214.35.bc.googleusercontent.com)
 smtp.remote-ip=35.214.173.214; 
 auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
 dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
 arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed;
 d=outgoing.instance-europe-west4-kz0n.prod.antispam.mailspamprotection.com;
 s=arckey; t=1778451999; 
 bh=rR+36T8oiKeMi7IFE5YhT8MhKdSCfW4HON6L9TmdTZY=;
 h=Cc:To:In-Reply-To:References:Message-ID:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:DKIM-Signature:DKIM-Signature;
 b=n44sDv2Weg6j/MU+0KdfJb35rd9AY3V3NKLKGtl1rSm/PBxCnJsebSJGHjNfxkqmAWxtFo0Srn
 X0BB3IBJPNp9shdZWG+q9EyQJCALBfr2S6VVtS0yKAk8NOYz7aTj+xsM3qu9sN68wFCgBEbOAD
 i7eSqxOq5qb+yujpaErauSgNAkixGuiZCQXQ9zSQygivO0NsnW3/YqMG4hFHhjaurCebv0/dqt
 RpDyMG70MTDK+p+c1y6Sb31V1AvKdQWu4r7+Uoncb1Gn8zclolHherfIjOdMMgB69Su9CTEYWC
 hnTkQQlNt73M5COlmKsCTrGwIr83T26qySaTovS0zmZ8fg==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
 :Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject
 :Date:From:Reply-To:List-Unsubscribe;
 bh=9CfoUdWJmLDzHn3cJ6W2kDGkt8ZqvTaMqW9oJ3gqphQ=; b=EdN7zR/+8Qcbq4h3zAgsykntmP
 h2+iKQr294AUeDPnpeMYYoME0zMJiYKsj3O9X9quFxVSVlCTv2V+oEQ/TvoE41DVFk8RtU7Kjp+tg
 nkGlrIah7hF3xTtow2biKpgjlVvbNlRNhpoOOSmZW+nsINezFb5eHP8plmjJIAjCJ2Js=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214]
 helo=esm19.siteground.biz)
 by instance-europe-west4-kz0n.prod.antispam.mailspamprotection.com with
 esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384 (Exim 4.99.1)
 (envelope-from <francesco@valla.it>) id 1wMCbb-000000041UO-2pBP
 for dri-devel@lists.freedesktop.org; Sun, 10 May 2026 22:26:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
 s=default; h=Cc:To:Subject:Date:From:list-help:list-unsubscribe:
 list-subscribe:list-post:list-owner:list-archive;
 bh=9CfoUdWJmLDzHn3cJ6W2kDGkt8ZqvTaMqW9oJ3gqphQ=; b=HoBVklFEW1jHuZMcwQaMw7jhSS
 lot+wQwCQeGnwrDhufeOYnjLofyzOs0vXh37AqOWXPygZ0A2ogQgvYSxvL+XqqePFi1Aij94jArZS
 5TwW4MjfrbiSSMk0G++rtk6ePuO+g/C9UCpPyG279CFuYSnJ1ET0hhvf4k9xUCCXFGSA=;
Received: from [95.232.18.244] (port=61481 helo=[192.168.178.43])
 by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.99.1) (envelope-from <francesco@valla.it>)
 id 1wMBin-00000000PdN-1XU3; Sun, 10 May 2026 21:29:57 +0000
From: Francesco Valla <francesco@valla.it>
Date: Sun, 10 May 2026 23:29:40 +0200
Subject: [PATCH RFC v3 3/3] drm: docs: remove bootsplash from TODO
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260510-drm_client_splash-v3-3-a9aee9f0b2fc@valla.it>
References: <20260510-drm_client_splash-v3-0-a9aee9f0b2fc@valla.it>
In-Reply-To: <20260510-drm_client_splash-v3-0-a9aee9f0b2fc@valla.it>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jonathan Corbet <corbet@lwn.net>, Jocelyn Falempe <jfalempe@redhat.com>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 Shuah Khan <skhan@linuxfoundation.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, 
 Mario Limonciello <mario.limonciello@amd.com>, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, 
 linux-embedded@vger.kernel.org, Francesco Valla <francesco@valla.it>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1171; i=francesco@valla.it;
 h=from:subject:message-id; bh=rR+36T8oiKeMi7IFE5YhT8MhKdSCfW4HON6L9TmdTZY=;
 b=owGbwMvMwCX2aH1OUIzHTgbG02pJDFkMPy69ubF0adbcjQHlCTycx4OMI9InzuyY77VN7P7Vf
 9PSeQI+dpSyMIhxMciKKbKErLtxb89c829pGxgfwcxhZQIZwsDFKQAT8ctg+O9Sv7jzp8mdxjWy
 fFrPzWvfT+96P/n9not7bNe/9O/occtgZJgicD2wi0mm8OgakdoNTF9eSR5/wnWLTzlBsfX4m6U
 PXzADAA==
X-Developer-Key: i=francesco@valla.it; a=openpgp;
 fpr=CC70CBC9AA13257C6CCED8669601767CA07CA0EA
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - lists.freedesktop.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: c86049ea7cb27eba96038ab7496dc802
X-AntiAbuse: ID - c86049ea7cb27eba96038ab7496dc802
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1wMCbb-000000041UO-2pBP-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-kz0n.prod.antispam.mailspamprotection.com; 
 iprev=pass (214.173.214.35.bc.googleusercontent.com)
 smtp.remote-ip=35.214.173.214; 
 auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
 dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
 arc=none
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

Now that a splash client exists, remove the bootsplash task from the
TODO list for the DRM subsystem.

Signed-off-by: Francesco Valla <francesco@valla.it>
---
 Documentation/gpu/todo.rst | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
index bc9f14c8a2ec..f367d8980a87 100644
--- a/Documentation/gpu/todo.rst
+++ b/Documentation/gpu/todo.rst
@@ -802,23 +802,6 @@ See drivers/gpu/drm/amd/display/TODO for tasks.
 
 Contact: Harry Wentland, Alex Deucher
 
-Bootsplash
-==========
-
-There is support in place now for writing internal DRM clients making it
-possible to pick up the bootsplash work that was rejected because it was written
-for fbdev.
-
-- [v6,8/8] drm/client: Hack: Add bootsplash example
-  https://patchwork.freedesktop.org/patch/306579/
-
-- [RFC PATCH v2 00/13] Kernel based bootsplash
-  https://lore.kernel.org/r/20171213194755.3409-1-mstaudt@suse.de
-
-Contact: Sam Ravnborg
-
-Level: Advanced
-
 Brightness handling on devices with multiple internal panels
 ============================================================
 

-- 
2.54.0

