Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFDE5C61DD7
	for <dri-devel@archiver.kernel.org>; Sat, 29 Aug 2026 06:38:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 203C110E0A6;
	Sat, 29 Aug 2026 06:38:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QRGD46HF";
	dkim-atps=neutral
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C884C10E0A4
 for <dri-devel@lists.freedesktop.org>; Sat, 29 Aug 2026 06:38:21 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-398b3c37877so142829a91.0
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 23:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787985501; x=1788590301; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5O2ZS9+ansg0/IUrCuwtyZKXd4BjLxjahxk05rb1blQ=;
 b=QRGD46HFUKgmICwQcffPKNZ2eC7waNvwDE31xPb92w8xSUfUjNInhf+vafwlylCNU1
 KCABbZhYLgRCNKcLMK6a8WWQkzFiGgFTmsoDDyUcHnjSWSmx2LUtUEW7AKD1Gw5Yd/ZZ
 4NEISfhqJlNNSrn7ocTDBI2+ZuJW+k6Qsw/+LMeZYH2cH/r+q3GM8vDZKFqTMH83dQUq
 eyw1D4BBIbZr7cWKTd9hKMV9s6RSuFjIUhSJxjiiHzwaaSfD66vQ/J67hI3i312id03Z
 6+i072jRFdAUGHs3EBy4CynPYJ5mEV8UWmQnVg10fExlfq3DLjyqU3mX9m699wR5qqPr
 D7lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787985501; x=1788590301;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5O2ZS9+ansg0/IUrCuwtyZKXd4BjLxjahxk05rb1blQ=;
 b=LXHdD3clFaIGwfn3f7Dc4rdrze5BKoUGoNNuEdlmUSTha3KXa1KbqvMCRSsguQajtE
 bdLiFqgDBmFZoqJFVL96/nTRLdE+N3trrmgsj2wRWGNcLoUYr5Lj2sBt5i62Nvf6YgiP
 JTVHaYMXJyY7hJeASSCUmTpk0QaBEtA0M1+qD+zgmgd8hQ64UxJY2FDk6ce3yie+srOM
 oJju/0C7KhoQJqv+cXW5jmWw+kkt29BEQqW5cQJ9nt/+0mKnAXx8nDzoKd8LVpEWinCh
 gCRyQn86vj9BEiKVkLX7JVHiRxjodWRMQXWiCvZTF5LGH5YfdiQonGkgQ7K+sShASRWF
 swpg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwzY6AdVjfPZQX5Gx4yu4b/9D0SOKq7Rb5U3JKaysDSXXNBHPM3XJWb6rH6trI8vG6LbUmgi9JoRPc=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kt9oKi+o1k7SISgB+pnKUmkTU4yaN6SEkYj4fSJcqXcUutm6/K
 Mm/B1Lpzq5PW5sZSxfZcpqyNpGuZKTaWw84ij5rjW72tAWix3MvXPHY=
X-Gm-Gg: AYBFou3i0ufNoR5k8dN2XJkb/ZNdkr3EHp1HFw9dU1+kft83e3D39qE6n3wrLsPvLO0
 31Elz+iaa/oxMhdcWhD4wooe1DRNCOciVBSav2KsU1AYolmTRxO6GjvDef29nsvpZpWeAG3KJjZ
 UWbG/L4jhSuLSygTJID/Xtzhka83Wbnb7P1/QG4IE+3SvelvBbzW12jPGAMRPRY7DIgSsvBTDm1
 0XM8fqtcefB8L8Ui0i/SVr+wEh2AGzcQvDjqM3Ak9ZE3NkzqidPBSS6zT5/3s3cIc6a0MZmt028
 /SYD3gTf/L+0i+vdP+ooVDTZ7ieS2LRK2csGaQX6JILeE5oul1laV7esivXtcmL0EnbF0eogKwR
 42JLCDqmcUYc4Cvayx0DJoG4/pBu4dUo0dmcSSXIfFkxBbapOTtso6qyhWig/UQuFYVR5mvHGPq
 7ZjBcSj0XR9QCdhL1k448eTg12Rbt3Wysf9yT4clmajulDrj2EmyLpssCETl4o63zyHqhjE8+B9
 JwuSxaeC6hg5xa897jXPiZhR/gzKEa760tv0Pt1qzdZvTL7qw==
X-Received: by 2002:a17:90b:50c6:b0:38e:97f0:aa4b with SMTP id
 98e67ed59e1d1-396d1017316mr22749011a91.13.1787985501343; 
 Fri, 28 Aug 2026 23:38:21 -0700 (PDT)
Received: from localhost.localdomain ([186.158.238.108])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-142e0d1abbdsm10957539c88.2.2026.08.28.23.38.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 23:38:20 -0700 (PDT)
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
Subject: [PATCH v3 3/3] MAINTAINERS: add entry for Chipwealth CH1115 OLED
 Controller
Date: Sat, 29 Aug 2026 03:32:15 -0300
Message-ID: <b02861a81badc32b414147f36e0c429969aae225.1787973729.git.nico.antinori.7@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1787973729.git.nico.antinori.7@gmail.com>
References: <cover.1787973729.git.nico.antinori.7@gmail.com>
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

