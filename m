Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54A4ECA5FB1
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 07:15:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95CF310F1FC;
	Wed, 30 Sep 2026 07:15:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="W+4eq34k";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93BE910F1FC
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 07:15:25 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49e6c0fce17so26586895e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 00:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790752524; x=1791357324; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=2prECYlfUYJhHJY0ODA9AKxpvoyiJexfpX9S3WhkkKk=;
 b=W+4eq34kpUBsvEhGE561pkbnuN5vT4/5HmbE8PjZOLVLe6TUXZ+lAi+YUZQp/CCxyC
 LMM0luJxAunU3Z3G5TeHpDpZX7SaZd92SyEGH6TD8PJyKxwG0le7eq89OrPm7V50HFqP
 AWXpBaFw42KZmn03brrS0i2yW6QKfOrMnfR6m/FpN2LtqW9xKWemxLczK8iW3EejtclV
 0xSpEfeMtH74HZghnPxJufiJTz9lVhCLBQJfZ9Le/5nmT5IR2NJhtEZR6O9UFqfKUF/Q
 RXQOrOycG8M2c8gR1xkA1GDBtyxm7F83Z+tzSQ6T9erWB3KJryhFWzgbSUfg2jFss2Im
 6PBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790752524; x=1791357324;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2prECYlfUYJhHJY0ODA9AKxpvoyiJexfpX9S3WhkkKk=;
 b=EcxiMRJgWKh5szYtcTGaDAz0Wl1tfikLjqUhw0P+cgt6rZSbrTRb8jCl+GmCKr5M1+
 1L1MBkQEQR5L5/DZZPS1F7xs0C1HTVopNZGRVKZTb5+P9j917x6/3bVg/bmjBmeMy1hL
 7GfDXrWpAmet+8A7suWqLQlGHm/gohNY8/K2GSjpogarXErO9HpbVgcWrDYAIap9KSkX
 VeikjGjT5q3lkEDRJqxFlXvNl/4kpqtUjgkIRASjwKEck4yjzBX+FupounzQvQ1eWnnR
 B6NLogbgKdvMKIPZQsqNBVGPGnmQl61TcnV5eYZ1YRvgw4L3Wrj5HXMriVIv8MeUCVSf
 vw2g==
X-Forwarded-Encrypted: i=1;
 AKwUvBw18z35fAoTFhnU5Az0CbV/z/p03WCJKbEFcquRxtNN1r1FI5nDNlPUwadhGulotLn2H/F7hk6wnD4=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nVe1+GMAgiVQfEGcISQI2QfH7B4XCrVqGNg7rB6+nUyhshGbWx
 yP7q4b1ZdxUPYP6d3OHNKsHU+kR78RjiJFLBDO/hsVf1sFpk4VyU5afY
X-Gm-Gg: AYBFou0gCFgffsKEbswXW315tSohu+FvAR9lY+OpAl9Vg3PufS2pjHQHnL3yGLZ/W3e
 0uVoBQ+ebuaTINYQXsZI008PydnhpYPxr/OLN2UJIGA7k1XYQTF1YAOVza4fgAwHFu5R1aEWhom
 NyFk5s//2C2fzOXAnC7Cljc2QyehujWyyd4SzndzUWvGtFgDKhDX7d9endCJXsP2IOedLjC26+Z
 mQja/1h9mB2TOv/stDvr+7eQPUtQbI7dDM8j07uNnIr9DIC5ZmvzxpdyeaXVEK9YPOqskkorCKN
 HnY/BqNz95TJWyLlYEfquwK7aNBqNWv2bTzGd7nnve6Ee1VtpZGIgisV5IimA40foCFspgy6CHP
 2QVryLZX6JxkDgOFc0Vt0ncOXDL7OCcmp13Dq3dGtHBvLbTEIk+fdYVnS9dtWKKZWwUcDu6kkEd
 i4B+nkXpY74m0f6lpg/I12Lkl7AJFJwYbfDmglMElXkRSrK2ucLIGzE1EeDJYPvYDkkQpGvZWMs
 G9Zf9RqWMpKEe4Qqo6p
X-Received: by 2002:a05:600c:8b08:b0:4a0:4a8:d444 with SMTP id
 5b1f17b1804b1-4a01b00226dmr7192805e9.33.1790752523915; 
 Wed, 30 Sep 2026 00:15:23 -0700 (PDT)
Received: from xeon ([188.163.112.76]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b029be7e4sm1256979f8f.12.2026.09.30.00.15.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 00:15:23 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, mfd@lists.linux.dev,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v1 0/3] mfd: aat2870: Convert to use OF bindings
Date: Wed, 30 Sep 2026 10:15:10 +0300
Message-ID: <20260930071513.54697-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Document Skyworks AAT2870 into schema, convert existing driver to
use OF bindings and remove platform data, add support for
in-supplies.

Svyatoslav Ryhel (3):
  dt-bindings: mfd: Document Skyworks AAT2870
  mfd: aat2870: Convert to use OF bindings
  mfd: aat2870: Add support for VIN and IN-LDO power supplies

 .../bindings/leds/skyworks,aat2870.yaml       | 127 ++++++++++++++++++
 drivers/mfd/aat2870-core.c                    | 120 +++++------------
 drivers/regulator/aat2870-regulator.c         |  71 +++++++---
 drivers/video/backlight/aat2870_bl.c          |  54 ++++----
 include/linux/mfd/aat2870.h                   |  95 +------------
 5 files changed, 237 insertions(+), 230 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/leds/skyworks,aat2870.yaml

-- 
2.53.0

