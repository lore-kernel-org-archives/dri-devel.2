Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23208CD5BA4
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 08:08:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8556E10E462;
	Thu, 21 May 2026 08:08:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="S8E6FkRB";
	dkim-atps=neutral
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1535B10E462
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 08:08:05 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-44b330c5cc6so4275480f8f.1
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 01:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779350883; x=1779955683; darn=lists.freedesktop.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VsyjDgwHHARWnP4+ZoDcZHojZF27pffHLJUGeT8qjE0=;
 b=S8E6FkRB66U3kaYHwuVE7ImzKTC4UEN9OyrqVGyrDjVoI7fVBqrUoF4G9s6KcNCw12
 k9lUqISfcwAX8A9jReKz9fGkauCZB8VgkBDjmyZ0DqNdSbJRWkCJkEszoIA05LLJJaoF
 mp8Wh22j883uG8r68OSpx5wdY8I+Q+1QEkYUmDs+UL/cAYz7kbFAqzIWlFTnEEf0TmOf
 Kjn42kflXrWEiaL1BkkYOi4srmCMbN+LzfiGmpYipGiGaoTsXEABoO/qM3A/7/Hn20II
 71tvz8RuwjTXTBeiULFY0dj1iplNMWc8pnGKFrjFgpMLMyYF2QdBsQ2G1lW0g1SQ2YrA
 3eBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779350883; x=1779955683;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VsyjDgwHHARWnP4+ZoDcZHojZF27pffHLJUGeT8qjE0=;
 b=jFznLzBKcXaqdG2T7/HPp7+/BayuLjIDDiCwQPf1sRs8qlh1nYJ2WQwnU3AZxY6ae+
 LS0tK4DRzbHUqUuIoq+NwMqoPi7LJBXMIRiMz/+sXikyz0X6xq9nbm5NVu7RwvP1yM2O
 N3cuuft0pyTNEUMzfU+XTvzRUiB/V9RvT6VOdfieznlavMfA+qNyVVv8lZ6RWtOdp2ih
 2Df8TBzu+EPa3jetsTsG/kWoUAKMJVgKEYgh9RYL0l8b7A5BRYTQACgWd4ueUi7kZOzJ
 OFZPwZzJw22dNTG1/K2mvFUSO1N4ACi5qTjQr11/9P0tMYPSVTUxYGfgRNv5izL7RCnQ
 EPYg==
X-Gm-Message-State: AOJu0YxAJrgihmq9dMe5QfGSqdlTZkEYugjKJXaLSAbKXmXCptTorkuD
 u2qCgAJ3qFHcddc3uZJOzV/3QXrPbL3icSo+KICKfSVttFCuRJeeupWzkzBEURDr65U=
X-Gm-Gg: Acq92OHJ6+TdRBaCiIwpAijG4VdGpxfuO3ZplYmbQTH88u/TE0loN7WKSya4OXcMu5s
 55Cam9JMpU1xRcmvWfcgLs20M9Qr+1ojmtst9Kdn3lNDzutQwxJkenROe0A4TLOlKHAyOpEOzni
 cSNk/5lJze8iZ+S5z0mypXdblQtoK8SanUhMv4+yabLBBEsqX9iUDZdFMkEEIVN49F9Az6XovJJ
 /ZSZ5ehetL7b+aWS80QmcMlAlODIK1mpr4PEj56n/lImm20uZbckp/lMG0X7lA8LhnW9VtznQrr
 vepMK5MM1XKO+JDwAtW2l2fYx8D9OwhOrGxXn2Xi0Lt3VvsZMyifAReOHd0Vc5jxD6kZdpj/+jG
 rFW4YuEojA+WohoIx1x+iOVZg5Om2sc2E9v4j6ASTLA3fUGcUcD80NRSHil/BoQtINP7UZrNnK4
 5p/vnfthodmgqyB+GBat9pcCgaqxtHLZhtVSjJXKJ+TsncS3bCwujwVCQ=
X-Received: by 2002:a05:6000:986:b0:441:1e41:194 with SMTP id
 ffacd0b85a97d-45ea38cbe46mr2942980f8f.17.1779350883499; 
 Thu, 21 May 2026 01:08:03 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eaa92ca4esm814369f8f.22.2026.05.21.01.08.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 01:08:02 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v4 0/2] backlight: Add SY7758 6-channel High Efficiency LED
 Driver support
Date: Thu, 21 May 2026 10:07:59 +0200
Message-Id: <20260521-topic-sm8650-ayaneo-pocket-s2-sy7758-v4-0-73c732615e4a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF+9DmoC/5XPTW7CMBAF4Ksgrzto/Jc4rLgH6sJxJuC2xJEdo
 kYod8eGBa26ocsnPX1v5soSRU+J7TZXFmn2yYchB/W2Ye5khyOB73JmAkWFShiYwugdpLOpNIJ
 d7EABxuA+aYIkIC11rQ1INJyo7jkJzTI1Rur9933m8P7I6dJ+kJuKXRonn6YQl/sdMy+9f07OH
 BDQWduR7rtWiv2XH2wM2xCPrGzO4ocq8UVVZLV8o7BS2FHzR5VPVfPmRVVmlZzhjWpbZ4z+pa7
 regMKkgi0lwEAAA==
X-Change-ID: 20260428-topic-sm8650-ayaneo-pocket-s2-sy7758-3081ee7f1e25
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>
Cc: dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fbdev@vger.kernel.org, KancyJoe <kancy2333@outlook.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1730;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=YBbY9olX8HOO1A5gzOhDFsNSnz9cTCkzfdmYMvhCaEU=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBqDr1hWipqu60COySXeKJkvQ84kMBCE8ACnzZjFmO1
 /Hq8EZWJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCag69YQAKCRB33NvayMhJ0ZjWD/
 9BwlD5o2k2ZD7qroIiXcIjLh8l8FZAoFYMbaKdF3Vd7NWdusguE90ZJxJKFwOyOL0iPMkWWJTlUDDA
 JKAe5eAna2ZGiBfiCSKPl6cpOZk4Wzd3mAl6+7JHZVD3a/UMcQdu9feCLToqexyKZy/URYNMbLTtRB
 8gT5djk5NoHSiGVBxKdRmCb9Y/EMrjNxKSc+b1lTi9YJIm9UVfrjivmGPDnFSoJJBQV9uIXF7L4J/I
 kQn4YCf0XfTyNiXQKE+H3cvxQa+WuUf6Ippe2oq2WAXzhJ6XIQHrrP5Z+Ucua2H5wNsA4V8UGEO+vK
 K6u1Zpht5sNSX3qBrAC17W3LJcWwDD8ceZbJ483a8qSjH5Qc4y5Kop5+nt2IX9bJRq73jYudP6iR3G
 Lpy7FwIMgPYKbVuoD5esixrkbq84JoMQyhCKAIxIcMIOJyM6pLhH5If6OzYRq4TVJOAp5EmsIN0e0d
 5F/UTpN8cpG7sQAX4wySw/2m/2rgcPGKsxbbdJhn03emVEawhmKDbb79oLWaebgSQZBPDxiQX+pZ+x
 jsF6rv+tlEGiwCkEhpZWZy2MNSpaVdbwZ4kk8P+ZDF5tTBQEWrG/O211f8J7Mxwb4SNLtjsPJiCOdT
 l+6kr5icWtjgphddWAeEXo1cMcH6myhstUuXrUAeLZCF6cb3F1R0mVc5VkYw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

Implement support for the Silergy SY7758 6-channel High Efficiency LED Driver
used for backlight brightness control in the Ayaneo Pocket S2 dual-DSI panel.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v4:
- Fixed Kconfig typo
- Remove again unused macros
- Added delay.h include
- Link to v3: https://patch.msgid.link/20260519-topic-sm8650-ayaneo-pocket-s2-sy7758-v3-0-ec8194bbc885@linaro.org

Changes in v3:
- Dropped unused macros
- Added second autho entry to match header and commit message
- Move my signof at the end
- Switched to flseep()
- Link to v2: https://patch.msgid.link/20260430-topic-sm8650-ayaneo-pocket-s2-sy7758-v2-0-308140640de9@linaro.org

Changes in v2:
- Fixed bindings subject and removed "|"
- Added review tag
- Added higher delay before reading ID from HW (100us was too short)
- Removed probe defer if i2c read fails
- Link to v1: https://patch.msgid.link/20260428-topic-sm8650-ayaneo-pocket-s2-sy7758-v1-0-0caade5fdb32@linaro.org

---
KancyJoe (1):
      backlight: Add SY7758 6-channel High Efficiency LED Driver support

Neil Armstrong (1):
      dt-bindings: leds: backlight: document the SY7758 6-channel High Efficiency LED Driver

 .../bindings/leds/backlight/silergy,sy7758.yaml    |  53 +++++
 drivers/video/backlight/Kconfig                    |   8 +
 drivers/video/backlight/Makefile                   |   1 +
 drivers/video/backlight/sy7758.c                   | 259 +++++++++++++++++++++
 4 files changed, 321 insertions(+)
---
base-commit: 39704f00f747aba3144289870b5fd8ac230a9aaf
change-id: 20260428-topic-sm8650-ayaneo-pocket-s2-sy7758-3081ee7f1e25

Best regards,
--  
Neil Armstrong <neil.armstrong@linaro.org>

