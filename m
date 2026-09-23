Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F0A2C98311
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 22:36:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2180110F21A;
	Wed, 23 Sep 2026 22:36:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pJiQmhLM";
	dkim-atps=neutral
Received: from mail-ua2-f12.google.com (mail-ua2-f12.google.com
 [74.125.226.204])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3870510F205
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 22:36:30 +0000 (UTC)
Received: by mail-ua2-f12.google.com with SMTP id
 a1e0cc1a2514c-97e7c6e580fso477218241.2
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 15:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790202989; x=1790807789; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jqAh36LRZFOSOGvgNmY+eEB5gitwvA40LvfMFJdUpDA=;
 b=pJiQmhLMxNIX+ArSivQe3PC467cmMn2AM5ypvVCkQbqDssR1iS+QO5glKLD44iDg/i
 sqst4q1vucprC5FLdE6oFBd/Beh2clqVhmq1DihlXa941FVbEcMuoch7DEroRCmhQK6y
 VqqBNdUg0jVD6MnDjjDDWqYWBWP4Iseje78PDvhoafkmsM5av7u5Jpv6N6mb5P4iAF8Y
 0P63Fqh9x2Cw6UTzPPTLihqbJcRzkG5J5ingST/jSfRFYng3WOH63mMlKz/5A3RetLFV
 Ln5c3Y4anIIpQijdbyHZN+iKL95yKr1PdFlgC0wPHFgI8KYP0o1fPpmaS+p0ONYOUfnr
 9Mvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790202989; x=1790807789;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jqAh36LRZFOSOGvgNmY+eEB5gitwvA40LvfMFJdUpDA=;
 b=dHKI5IWAp3TDt4rBBF7SzVhsM/ld5WqMUsKfMCArwX1zQ1F9q3kJU/68e+jmJDJtIq
 9uWEIrlkmypH4lhrywRy06ev+lv/sKdJc+zwaYTg+VI+vX8d4EcjuP8ZhfJb1UisV9NT
 7uAEpZSVjOdbryOQTR8U1juuyMjHJQbWtEXbUQwKtfef0QQGF4XBrSQ7rdgFoZAuI3DB
 /H9cDiwpdp+Phnc8xG8BaQLqTlV8ZS/7MuShy9sMIuZwTXjPdxh6Hqdy7uXbBEkziYt+
 /23vL1+ISDWGhFkt7JNS3xapugVxLb2oK7yy2cltK1tqIPqNc3wBcBDs9JtgiOBSVFRw
 rcyQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxse8wlICqSZzg3j9WC07lF+bmbGz/aEtSOrk+sXuL+QmTFUHhBb4THBPGS9wiFzRLjOjfvoMNAmXo=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m+7gRZaDtXvifmc729S1gZRgn8rad5ltBY6mhwyGQQlmdTyEXG
 BXss6Nu66F6I9jfMQs0208Nx9RCIpfaLsv/wmG7CQxlUB7x96YKODBY=
X-Gm-Gg: AYBFou2+05oPlT1V5xKoQ4zUir7EvkC/zcd+IA8hXPN7yHLSbbgxwF/Be9W4GMH0nio
 9ihvAdPL+Tw/aBpmIQC6F2eTNhxxQENDUTfqxr1Kmvj1A2iPmfpUqQq46ZrqfGdiE9cScM4QXYd
 DK9P/wvFytuJDQlJvpXY87a/JlJ4aFRziBYkNiqhG2fkcda+p8VXEj+SrCp5qfIMrYLV+gJH0VY
 AQdm2gbXgv/HBUVNWk7HGLQ2qQzI4wQPBhObxtOiputzne4d+UDeMF3+c3pIDRgqsSYJewS+OhT
 pnt+QNl9WeLJV+quWals+ltpoivUXwanKTUPLTCOeLWPLNstno3bILWObW4HMxTnBMZ70oBtveQ
 jF1CD5DHVfksS96y+72/SQzdzpmAqLJfPet89l7Iq4qT0vriMwudRYt/6izA3W+u6l19OpH4s4f
 cF2mm2sHnZlYI8oIaLqzK2QPMefoyB/9rBttwhOjz/qV+TMGCdKFPZOMVCbQe3ONK++uABF210q
 Cs1goNrZ4BhMLEcygAbe+fkYT8NW0rDyME7tyhi03okBvyZrw==
X-Received: by 2002:a05:6102:2914:b0:7a6:e08f:9fa with SMTP id
 ada2fe7eead31-7af1cc992f3mr537802137.13.1790202989138; 
 Wed, 23 Sep 2026 15:36:29 -0700 (PDT)
Received: from localhost.localdomain ([186.158.238.108])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5c9f04fb621sm5162983e0c.9.2026.09.23.15.36.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 15:36:24 -0700 (PDT)
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
Subject: [PATCH v5 3/3] MAINTAINERS: add entry for Chipwealth CH1115 OLED
 Controller
Date: Wed, 23 Sep 2026 19:35:15 -0300
Message-ID: <5ba56a096d825fef6b291f4cddfdc5f0caef9dbb.1790200427.git.nico.antinori.7@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1790200427.git.nico.antinori.7@gmail.com>
References: <cover.1790200427.git.nico.antinori.7@gmail.com>
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
index 054178b88dcb..0a3c3e6f0af1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8665,6 +8665,12 @@ T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
 F:	Documentation/devicetree/bindings/display/panel/samsung,lms380kf01.yaml
 F:	drivers/gpu/drm/panel/panel-widechips-ws2401.c

+DRM DRIVER FOR CHIPWEALTH CH1115 PANELS
+M:	Nicolás Antinori <nico.antinori.7@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/display/chipwealth,ch1115.yaml
+F:	drivers/gpu/drm/tiny/ch1115-i2c.c
+
 DRM DRIVERS
 M:	David Airlie <airlied@gmail.com>
 M:	Simona Vetter <simona@ffwll.ch>
--
2.47.3

