Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06A93C531FC
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 07:28:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F3DF10F2F0;
	Fri, 24 Jul 2026 07:28:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="swJCnry/";
	dkim-atps=neutral
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1003110E5C9
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 18:46:08 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-38e3617ba36so976874a91.3
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 11:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784832367; x=1785437167; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6s5SzAkwTqv2cG0ZEuCiRJMYbGatFZIR2B9nCnRkYh8=;
 b=swJCnry/ty0QL/7YNUuATb9PxZpkBgPmIWNpb3chH//atTMSEaSx9QGco/SI/GX5/c
 8DSV+QpPjLRs/7oIkWBVcUpPREQdHpMooy4jDlwY2rSFjJ8gRFmC/qROH9y3ItOHBD3H
 +Cdkmu1ldYmpdaKpTvFrK2+83mAgQnQlH7Uczexp5KyTcGePjHkySSMQpz2+/yP086wp
 2PTT5xiZjb+UyixmWU67tdAyU+HH7qwx9Ezkawa+AbvMeqkHUH8eXlrHACJPzziiFwCI
 ZGtbQLipg/qAZ+mMuBE4Z+BrP0ykuegOXh++7NJ971g7EXXfav2nVZCnie8s0g9LfGOJ
 DT+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784832367; x=1785437167;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6s5SzAkwTqv2cG0ZEuCiRJMYbGatFZIR2B9nCnRkYh8=;
 b=OtId6QqxH0Mu+W2l2P1phPMhGMIKhUKTnqyq3hisR/k+sFjfyXMgJG1s4VF0Pn8BI4
 L4mChbVwn9oGyL9q7fKddOEC/UeKmal+Cn7PbAWTkU8w/VkicZ8q7sPfS+dDiJrkytRg
 Dgm1RGdmVgck/7L3sVYM06hedYIJgpqabiBPVTiRaiZbyIMOu3omQglh4wBVClnsgOfO
 rXrs+1e9AfveH10WFFhmaC69bcLOo9KLzGSz7Y6aWdTUIZFpMLp5VDih96usYr65Z+Vn
 sByTkja4s4iB/QhTpeyCqcY6J2C2YOImLCXdy909APOS+9OHxc36Cqqtmu8fqrYWxxEA
 sd5A==
X-Forwarded-Encrypted: i=1;
 AHgh+RpVtxRZVdCKHzPncHS7WeRKEmPGpDEvZheIZGukEsdYaaHaQ+kzLzVZb6f4RbVhBp0yr5cAznw8Ty8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwLoqaiYRxPO+k3Eswqlp6kiUp82t29Kd63UG9bvHhzH4pLb6hW
 r/GaZhyBuj8ubkJwwtq9TwyMfNfZhvDIoyRQ586GN9qjfnlSpG4mIDzd
X-Gm-Gg: AR+sD12ZsPRuojF27DQd7kdg3hesDQqCbbtSXVTTTtcRLG5w9sHUVVbOD42c4j+NPlf
 54oLRO1Vz4UkgZiQKu4DS5AWPYstBdV/ucd4i7ZbYveaaasYuVIG3PqGCFE8XphKUSgswJrgSS9
 tuEJRnKsZNhSn8jTVuulFYfsEU/2PHNjHB90ztcE1aQhkM/w9kxFJ5Z6w+rMl6iFWpX/TXwuE9U
 6m+y+wFoEfpu57SqXqiGw4k07ZhWNmUiKT1/pXug6mL9wCATU1uj7rYdn2QB2QjMDohHOUyMWLn
 XaBDYworBZyBbU2P8RW0/WlcpXDIw+c2AXenvBDi0fF9H7LetKmyGHjtHaYxrhTfqISFkZasI1H
 jnr6ClVaURFrJJfAJl3tFUMU0oQjG5dLXbXh0GWMh0oHkNoOP/JNB9va+nb5gQpIqX9bcnBEN
X-Received: by 2002:a17:90b:4b92:b0:37c:18e0:90dc with SMTP id
 98e67ed59e1d1-38ec697d294mr3808455a91.16.1784832367424; 
 Thu, 23 Jul 2026 11:46:07 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38f03af8a45sm308155a91.10.2026.07.23.11.46.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 11:46:06 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Julia.Lawall@inria.fr, Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: cocci@inria.fr, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Zhenyu Wang <zhenyuw.linux@gmail.com>,
 Zhi Wang <zhi.wang.linux@gmail.com>
Subject: [PATCH 05/36] drm/i915: remove conditional return with no effect
Date: Fri, 24 Jul 2026 03:45:07 +0900
Message-ID: <20260723184538.3888637-6-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723184538.3888637-1-ekffu200098@gmail.com>
References: <20260723184538.3888637-1-ekffu200098@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 24 Jul 2026 07:28:31 +0000
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

Both branches of the check return the same value, so the check has
no effect. Remove it and return the value directly.

This is the result of running the Coccinelle script from
scripts/coccinelle/misc/cond_return_no_effect.cocci.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 drivers/gpu/drm/i915/display/intel_hdmi.c | 7 +------
 drivers/gpu/drm/i915/gvt/gtt.c            | 8 ++------
 2 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/i915/display/intel_hdmi.c
index 8a019d3574df..90880be63a1e 100644
--- a/drivers/gpu/drm/i915/display/intel_hdmi.c
+++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
@@ -2658,13 +2658,8 @@ static int
 intel_hdmi_connector_register(struct drm_connector *_connector)
 {
 	struct intel_connector *connector = to_intel_connector(_connector);
-	int ret;
 
-	ret = intel_connector_register(&connector->base);
-	if (ret)
-		return ret;
-
-	return ret;
+	return intel_connector_register(&connector->base);
 }
 
 static void intel_hdmi_connector_unregister(struct drm_connector *_connector)
diff --git a/drivers/gpu/drm/i915/gvt/gtt.c b/drivers/gpu/drm/i915/gvt/gtt.c
index 5056a5887b31..6bca40128d99 100644
--- a/drivers/gpu/drm/i915/gvt/gtt.c
+++ b/drivers/gpu/drm/i915/gvt/gtt.c
@@ -725,15 +725,11 @@ static int ppgtt_write_protection_handler(
 {
 	struct intel_vgpu_ppgtt_spt *spt = page_track->priv_data;
 
-	int ret;
-
 	if (bytes != 4 && bytes != 8)
 		return -EINVAL;
 
-	ret = ppgtt_handle_guest_write_page_table_bytes(spt, gpa, data, bytes);
-	if (ret)
-		return ret;
-	return ret;
+	return ppgtt_handle_guest_write_page_table_bytes(spt, gpa, data,
+							 bytes);
 }
 
 /* Find a spt by guest gfn. */
-- 
2.43.0

