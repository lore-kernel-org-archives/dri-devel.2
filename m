Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54AECC5DF93
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 14:38:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EB5810E305;
	Fri, 21 Aug 2026 14:38:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gkUxmGaX";
	dkim-atps=neutral
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com
 [209.85.128.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEBD510E2FE
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 14:38:43 +0000 (UTC)
Received: by mail-yw1-f180.google.com with SMTP id
 00721157ae682-836d2861a39so15827347b3.2
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 07:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787323122; x=1787927922; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5O2ZS9+ansg0/IUrCuwtyZKXd4BjLxjahxk05rb1blQ=;
 b=gkUxmGaXYBLbLZz15qELTLls0K8nuS9SpPournqpN7uaJIrF02wgJhsCEiM8IveaMw
 WxoZrZmNwRLCB/npHvb3tj6BkcMRU3hFVKE68TibMRf3yECa0U3271SXvzoMRdjvtr71
 qSIL0AonDVux84MP1fYUwsNdd32y4MCx1ZMFI+ewTIVxDhXK5cN1ZK2XqieeEwSEGs3q
 4TwheKo+olkIKrwf7soOXw097GWGJVLADmXVr2kFwjXz4VIvFIi5G6bIZrf5mbFWBIYj
 aRamAIGMT1RWpn+F0D5B25b1mMy2LoxeJnvYHP3nTE67WoqVsBbQLzfnGN8RZ22yXCWP
 pWfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787323122; x=1787927922;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5O2ZS9+ansg0/IUrCuwtyZKXd4BjLxjahxk05rb1blQ=;
 b=qrSJYfTETXuuIv6TWVHTI5SEswnAGxnrLhDTjtdsRXq64pTK/KThyudLRzWN+M7eMc
 07pPPS1LHbhdvbiR1YNyx+d9CuSGnXNGFFQmheLjX0DRoufKd2W/3hXA1tbJhyvD2aZD
 xqQXDg5m0KqGPMuJOjV0DaPXUlMoucIJCmAH38us9mqaSHu5CWO55B43KMh2S5EUkt8J
 4HUZs1nwJt99Hmu2AMVx670SVXgT3YhfsH/LspnVxQv2OohxBwfNeqEfvGiYswzrTa2c
 UJo4pAK3EL9BgBA44u3paYFwWOt9zfv0FpIeo/j+rQ9E8bVABKy/KM4ssDqbosUh2sqA
 +C+w==
X-Forwarded-Encrypted: i=1;
 AHgh+RoLU1bvPCAGWzS7OqNSKL3odFZ9FcrzJOutFbassT7KJPs3KgCcvpuayed/3ELN5/vcybsFQng19VU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lzEn4cXdea9k/PckHl+MZkWhKJjQeKFxNlC4gn+0ZaJ9hZrqJ0
 s+i14ipaU61/UT3iYbiYSbcRiM54mjxSxiQgzVkacQb1V8F8nHm5AU0=
X-Gm-Gg: AR+sD11+/lN+enBxhbEaulKokLT0YWdJuMJwfT4kNI1V059TJ16/chSEwgv75D7A/Qf
 SpCGz++BusI8Xmy6kanWoHFUbvXRRnPEar86yKNUqcjzXBrGX69KI4usp6EyngBAkuU3J3Vb43I
 tIb5EYPn9kgyx/uIC5e3C3BfpJHVj7z1jGAehU4uR+eIzF5coCKiYtUAmGP1QfB6FkuNu853aeE
 vtlf0RLyBJMWtSVsbOSBhDQ5Tjdnw6j54pQKoYXccW1grcE2R2aj4moxi7tqPOYIT5OtTzf1WF5
 EQ4DEAANfZpktnoz43Pm1mz58xbcJzh2mVflQ+YOglTckCcN5CdRTBK41PGdbMyXu01JVPmXgj/
 pUBitKsVlVgL7/otN8Rda6g8Pf4O2SCgyTUSBuOsHmfbgQJQ4FUYuJPtNsCBnSvch/YlGpJekQx
 bUDZcAvRnCOGkTKx+9Paf6WR6szZaGTSkj5OiYU1qQXliXhbfalUSwVTokxgXG/FZa3R9hucS87
 t4BTM3YODeWOlvDIqDPZMt7vyV6MjOgzroMQ70B
X-Received: by 2002:a05:690c:e288:20b0:81f:d505:8ea4 with SMTP id
 00721157ae682-849f449c2b8mr21855567b3.18.1787323122701; 
 Fri, 21 Aug 2026 07:38:42 -0700 (PDT)
Received: from localhost.localdomain ([186.158.238.108])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-845188b28f2sm41868277b3.38.2026.08.21.07.38.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 07:38:42 -0700 (PDT)
From: =?UTF-8?q?Nicol=C3=A1s=20Antinori?= <nico.antinori.7@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: =?UTF-8?q?Nicol=C3=A1s=20Antinori?= <nico.antinori.7@gmail.com>,
 Brigham Campbell <me@brighamcampbell.com>,
 Jori Koolstra <jkoolstra@xs4all.nl>,
 Shuah Khan <skhan@linuxfoundation.org>, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev
Subject: [PATCH v2 3/3] MAINTAINERS: add entry for Chipwealth CH1115 OLED
 Controller
Date: Fri, 21 Aug 2026 11:34:18 -0300
Message-ID: <a56f15cab62e16df835fd702f26739a381949bec.1787321297.git.nico.antinori.7@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1787321297.git.nico.antinori.7@gmail.com>
References: <cover.1787321297.git.nico.antinori.7@gmail.com>
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
index 59d60df34dfa..dff105e5f01b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8581,6 +8581,12 @@ T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
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

