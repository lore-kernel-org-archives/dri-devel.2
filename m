Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F22960A2630
	for <dri-devel@archiver.kernel.org>; Sun, 15 Nov 2026 06:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MyjW3Yqg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 686F810E136;
	Sun, 15 Nov 2026 06:11:29 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B55910E079
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Nov 2026 06:11:22 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4bb5b8ef642so11995425e9.1
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 22:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794723081; x=1795327881; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=jucsGGsP4A94CkjewiCz+sSfRnTZY+EbzcNS/u6Mk/w=;
 b=MyjW3YqgTORhSA//0Sg3hsaEl9SSLfMned+3BiiPPvXpLCsfmCKUqu63OJNcotRWLp
 i8BuA7srplxIsVMxCDSMqCNuzZRIBM0fUmqUAm/xX2dsLi6zPGNYV0wA+k5VmqwphSHd
 81NmflHJYP+24S530mbK5sEgeB4jYtWqtCcGORJjxJo4gymJQ+ERqK/sAUEEQxVo3+7n
 hxfpfXm5wLLvrhFmAZmfqLzB3vTcgsbdNu+gIPGbrU6F/8TPx99WopcX0meYwIVCLyCv
 jVYcJ0+pUvdbdvBH1QNvhKClgXoqjfhsixf0tO7RcJwiJBK7SRqQiz4p47QKs3Gx6wDg
 3gqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794723081; x=1795327881;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jucsGGsP4A94CkjewiCz+sSfRnTZY+EbzcNS/u6Mk/w=;
 b=wsC2dBCnRB4JoJmhPKHRUXRffoawX0s9zWhoK/I8E4mWrBZQbECuslAiEPXVWfiaxU
 2BW5XC2VC52H4BHy1Pni0VoSSI1vNgxChOx3cK/P3dzN3E81ii29CC7ESXPMmyfOEsnU
 1FlonMGoGpGUaVxGlVJp1VBHO/gh2tDP0TYpEURrHGH3/8RT4j0/ZJtxxa4hcYlccB2R
 FA3KENWPLVEwQQmX2GNPvruwYX6VRVr6KQhGItwrLqtFl/x6rCgNWLVriJ+a9FSKChyW
 hMgg3LIV0wPIiJanCDfMgsJwrtFgspffKf7oQdtCkkM3KUqRldmrmJaf7a0M7CsSwuSR
 C+sQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHz2rYbfrzH03ynbUQNxwk2CEibGyMqvxIvTC8YZAXXcU6tgxqg6Hi69HqXZ7bLSkwij2/6AZmGXb8=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+SC83EBNvkENl3JiXxYvyjgifWnUS65rLuL4i0Y4ZLev+K4t2o
 7aStfz6q5Gjn+NG7YKYJs8mbnPa/0bryafJJy0wJwEU8dUbr9S06P9j8
X-Gm-Gg: AYBFou3xfZh3Ln0QBVpH9+16K5FoWCawFMxai3Tgfvy8r+uwkgKRHnrhlZUNfI1nVHf
 6H7RYYbJNVx9lTbSgAzVC2pSuWkPzZttTKX4lsWEOe5qd+YNaUXZQuqd2MeADLvweiDqQVVMotv
 zsE94puhHeBbHMk+pxJ4k+bgi8Q27SMw4gLBPlGc2PTGTR0NIweBhWTX44RdIkCWnsnccce/tGS
 pQ4CIi//y+syzMyfgi9J+0SU48IhjwHPnwMb+zAXqxNcI7MpO29n9INk9tgDQICUknTR0ojmfDS
 FGSWL0+CHXevZ53T26YrwW1NHr9v/rixHlfGEHXp54GTd1JcL5RaDwjBqAYyUamLihZc5mqAJcu
 s9KMHtLNkFKhCDtF8akRySdo+OxvGwdm0Ei+c2a2336LbFOLxXB7fFebLuBbwq9U27xf3ug+k1r
 uJjTeZbEB8t7cO2oqyjlUMnz6G6T58+Lrwoawrt3WZv0mUABTPfuxgfEe5uNwLqDbry6uFP1DpK
 4Fae3uS8bmJIjrrpcZvV4CLUSRE5nZBpH0vbSaZEJ0oZCgyUBrWwglpPXfjm+CiIWrXiPW6aVvX
 UHEGkBECAd3q3HaZK6MsK86fWkCpjJu2IpRDKubICndMKjnn+g37IEusR/iNqx2pPAq/ciIHB5b
 fGhNzWNGvaT5DO3T9PCGKdyyZ5ILHS0ZS+5PjNOxTc74ji2TrM8rlrqPdz5LOqPaJIlZ3tzRIX/
 BWebME7PiVHSX5ebtAAgfTkgMe7qUOeV98/twJBcGeFUDkfD/fX+XbvodkVofX15f9sgfRSrfmd
 /jGpuYFweIe0Q==
X-Received: by 2002:a05:600c:4e56:b0:4ac:aae6:6400 with SMTP id
 5b1f17b1804b1-4bb55a48042mr148514035e9.13.1794723080596; 
 Sat, 14 Nov 2026 22:11:20 -0800 (PST)
Received: from jernej-laptop ([2a00:ee2:6a02:9300:bb69:6bcf:1b11:e85b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb5ba25b50sm139331075e9.14.2026.11.14.22.11.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 22:11:20 -0800 (PST)
From: Jernej Skrabec <jernej.skrabec@gmail.com>
To: Chen-Yu Tsai <wens@kernel.org>,
	Samuel Holland <samuel@sholland.org>
Cc: mripard@kernel.org, maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, bmasney+clk@redhat.com, jbrunet+clk@baylibre.com,
 sboyd@kernel.org, Andre Przywara <andre.przywara@arm.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v3 0/8] drm/sun4i: update DE33 support
Date: Sun, 15 Nov 2026 07:10:54 +0100
Message-ID: <20261115061102.229680-1-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This is second series out of tree which aims at properly introducing
support for H616 Display Engine 3.3. Previous series [1] reorganized
driver so proper DE33 support can be easily implemented.

H616 DE33 support was actually introduced a while back, but it was done
without fully understanding hardware design. Issue with existing binding
is that it considers planes as resource which is hardwired to each mixer
as it was done on older Display Engine generations (DE3 and lower). That
is not the case anymore. This series introduces new driver for planes
management, which allows doing proper plane assignments.

Note that this series intentionally breaks existing H616 DE33 mixer
binding, which was released in v6.17. Old binding can't describe shared
planes, so second mixer can't be supported with it, and it never had any
user - there is no H616 Display Engine node in upstream DT, rest of H616
display pipeline is not upstream yet and no other known DT consumer
implements it. Reasons are documented in patch 7 and driver prints error
asking to update DT if old binding is detected (patch 8). See v2
discussion for more details.

Remaining patches, which introduce all the missing bits to fully support
display pipeline on H616 SoC, will be sent once this series is merged.
WIP patches, which can be used for testing purposes, can be found at [2].

Please take a look.

Best regards,
Jernej

Changes since v2:
- rebased on v7.4-rc3+ (mainline sun4i fixes)
- patch 1: explain in commit message that DE33 has only one bus clock
- patch 2: don't register regmap with syscon, drop preset plane mapping
  and reword commit message
- patch 4: don't expose YCbCr color properties on planes without YUV
  formats (kept Chen-Yu's R-b)
- patch 5: collected Krzysztof's R-b
- patch 6: renamed, get mapping regmap from display clocks device and
  add device link instead of using syscon, defer probe until display
  clocks are bound, set drvdata only after mapping is initialized,
  register driver from mixer module instead of module_platform_driver()
- patch 7: explain in commit message why old binding is incompatible and
  will not be supported
- patch 8: renamed, initialize blender pipe modes for DE33, add device
  link to planes device, limit DE33 display regmap to its 128 KiB region,
  print error asking to update DT when old binding is detected

Link to v2: https://lore.kernel.org/linux-sunxi/20260509190015.79086-1-jernej.skrabec@siol.net/
Link to v1: https://lore.kernel.org/linux-sunxi/20251115141347.13087-1-jernej.skrabec@gmail.com/

[1] https://lore.kernel.org/linux-sunxi/20251104180942.61538-1-jernej.skrabec@gmail.com/T/#t
[2] https://github.com/jernejsk/linux-1/commits/sun4i-drm-refactor/

Jernej Skrabec (8):
  clk: sunxi-ng: de2: Fix Display Engine 3.3 definitions
  clk: sunxi-ng: de2: Export register regmap for DE33
  drm/sun4i: Add support for DE33 CSC
  drm/sun4i: vi_layer: Limit formats for DE33
  dt-bindings: display: allwinner: Add DE33 planes
  drm/sun4i: Add DE33 shared plane driver
  dt-bindings: display: allwinner: Split H616 DE33 layer reg space
  drm/sun4i: Switch DE33 to split plane bindings

 .../allwinner,sun50i-h616-de33-planes.yaml    |  46 ++++
 .../allwinner,sun8i-a83t-de2-mixer.yaml       |  16 +-
 drivers/clk/sunxi-ng/ccu-sun8i-de2.c          |  82 ++++++-
 drivers/gpu/drm/sun4i/Makefile                |   3 +-
 drivers/gpu/drm/sun4i/sun50i_planes.c         | 215 ++++++++++++++++++
 drivers/gpu/drm/sun4i/sun50i_planes.h         |  43 ++++
 drivers/gpu/drm/sun4i/sun8i_csc.c             |  71 ++++++
 drivers/gpu/drm/sun4i/sun8i_csc.h             |   5 +
 drivers/gpu/drm/sun4i/sun8i_mixer.c           | 193 +++++++++++-----
 drivers/gpu/drm/sun4i/sun8i_mixer.h           |  10 +-
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c        |  72 ++++--
 11 files changed, 663 insertions(+), 93 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/allwinner,sun50i-h616-de33-planes.yaml
 create mode 100644 drivers/gpu/drm/sun4i/sun50i_planes.c
 create mode 100644 drivers/gpu/drm/sun4i/sun50i_planes.h


base-commit: b3dfbde62cf1981c4638939c159dfd087b7a72e9
-- 
2.43.0

