Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 987ADC79F89
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 12:29:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE8E710E7D1;
	Mon,  7 Sep 2026 12:29:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CcbUCn1j";
	dkim-atps=neutral
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com
 [209.85.128.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFA2A10E7CB
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 12:29:29 +0000 (UTC)
Received: by mail-yw1-f170.google.com with SMTP id
 00721157ae682-861145fc841so28236207b3.3
 for <dri-devel@lists.freedesktop.org>; Mon, 07 Sep 2026 05:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788784169; x=1789388969; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5mjYZ3k2SfS7QDSelwqxhC0sbri/VrXDhQqho6Hz/5E=;
 b=CcbUCn1jrZs3TJq73NoUWwugdrrUnY70axJeXZDwAs7D0DMRMDuTWCE739c+n1uOGK
 aewlCz5+ahm87EIwFfMhg8xqGpXYcWX2NW1xmESIgI86e7T3MOAbqVRBLDQBIBRmLfKi
 L9ESOUt+7quI0T6F4T24B6rsM9X/yKDSeJVT4QLtdeffpcSvRrMCec/CRConsah76jJT
 ZGzF8HAHDREg7VwZOlg+FUcI7LBx0g6bi4oVSQXKtA5YoH7C1BBqzABn+OnZURJi77kT
 lTnSRn6e6afw39fbDRgTV+6oiJS+etEbuTnDUlKSCFP/IUqhbMipbT3Gu2z3h8UziyYg
 op5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788784169; x=1789388969;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5mjYZ3k2SfS7QDSelwqxhC0sbri/VrXDhQqho6Hz/5E=;
 b=G8FazPwRJ384bgZLafZCWQMhFi66VdUfNF8+MUa0xxyPp6pm5vXp79BC71BuJUYy1Z
 j+uVk4QkgBXvF6H5wGOW7PHfYjTKMw6EHElgabKeoM92pmHnY0lraKIG/OAKJjlk7N+b
 s5ragcXvjlXgg+Cb3s9WT8GaxerRoyOT6OZUYCQnJAXWIGNBZau/qwoyB1XxUIek4usf
 JMeXyc/6BPJMn/YS3lmNrbkrFViUp5Cm7+xY9qE+oa8b5k90eEZu6HtH+Vc4cZq8lVar
 l/QlNxqlg5ezI2Zl7pUf57jJ6nR5djQZ0JxtJWxMTsszk2n4GeoHhTDmj4BeWnRAUGTh
 ddtA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz8x9NSClVLZmeO8RLQNL0+ExFg0RJT5m9BbqIkCIBo4y1fAw9ACDvmwJAYes8IpvbqWJ2Fvzoidmc=@lists.freedesktop.org
X-Gm-Message-State: AFuF++maWv9PB3fXzIHWqjpxHipWeHbyxbJKu5QPzpIL5rMgxtj68ir9
 mDk+JeOB1/WGXUftoTdG+5fd4ubVuk5L7ABr3/8hZQxvJuoKWEeRmKo=
X-Gm-Gg: AYBFou1uZBr+zvMbez64BV/uD6xlhi5AlnmUiux4aBcolpf9NlCAZAV7x8+cuafasCy
 RA6JXzd9g3MzTtTr6bfTqZtYF6HB47v4wB3keA3Q46feJY3+fb+8hWJK3DhsfkuoPNkNvAdjlH0
 qSLbZCdnxwNxZ0PvDp9pfl2uRA/BBvTQ8V/AW62uyoK7D5qGBEKnzj+P26ucAuKek63zVmADEK4
 9THbULhPcQqgaa21wt65x0c3Fnm9uwhl1tiMMjPE8pgSssoVSaBrSs36RHgGy95YQ9NOXNAvfM2
 XA9ofSKhhkHVvJKTlAb+GInybiJsjWe0WAdsaVbg1eUL22xAXuqSqTyUHG3r6rmQjoVdfGq54Xx
 mSIr21yZKxNzfr2I11TXyFOZGfK87dKoCzgVBXgT3HPpPyKQbQE443Z92EF0LhqdKEe30oCqK69
 2nc6C/XwNC5voto+m2lLrMzvgY++J+nGhAR+8N6Lyg0CHevZtO31JWqwo2hDClPNl/DufzmKzNU
 JJa/x9LwDuecNlzkMD7/LnZVTgQ+2omuSAXfI4=
X-Received: by 2002:a05:690c:d8f:b0:7e9:4a7:9899 with SMTP id
 00721157ae682-871261dc570mr103556167b3.11.1788784168867; 
 Mon, 07 Sep 2026 05:29:28 -0700 (PDT)
Received: from localhost.localdomain ([186.158.238.108])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8714bb0efc1sm70511967b3.45.2026.09.07.05.29.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 05:29:28 -0700 (PDT)
From: =?UTF-8?q?Nicol=C3=A1s=20Antinori?= <nico.antinori.7@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: =?UTF-8?q?Nicol=C3=A1s=20Antinori?= <nico.antinori.7@gmail.com>,
 Brigham Campbell <me@brighamcampbell.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Jori Koolstra <jkoolstra@xs4all.nl>,
 Shuah Khan <skhan@linuxfoundation.org>, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev
Subject: [PATCH v4 3/3] MAINTAINERS: add entry for Chipwealth CH1115 OLED
 Controller
Date: Mon,  7 Sep 2026 09:23:31 -0300
Message-ID: <b8ec70dfa6e4e711cc95df2a6046741223d67c92.1788711082.git.nico.antinori.7@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1788711082.git.nico.antinori.7@gmail.com>
References: <cover.1788711082.git.nico.antinori.7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Add MAINTAINERS entry for the Chipwealth CH1115 dot matrix OLED
controller.

Signed-off-by: Nicolás Antinori <nico.antinori.7@gmail.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 054178b88dcb..0be510e16a8d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8665,6 +8665,12 @@ T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
 F:	Documentation/devicetree/bindings/display/panel/samsung,lms380kf01.yaml
 F:	drivers/gpu/drm/panel/panel-widechips-ws2401.c

+DRM DRIVER FOR CHIPWEALTH CH1115 PANELS
+M:	Nicolás Antinori <nico.antinori.7@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/display/chipwealth,ch1115.yaml
+F:	drivers/gpu/drm/chipwealth/ch1115-i2c.c
+
 DRM DRIVERS
 M:	David Airlie <airlied@gmail.com>
 M:	Simona Vetter <simona@ffwll.ch>
--
2.47.3

