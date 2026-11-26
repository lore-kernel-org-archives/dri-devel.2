Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67737606A6A3
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 21:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GMhAFYpg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A728B112735;
	Thu, 26 Nov 2026 21:44:46 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F864112735
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 21:44:40 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-4a68190a2a7so6319640f8f.1
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 13:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795729478; x=1796334278; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=cLndCsyaUJbef6+HCqjnikoRIrtmLL/VU/FOWgoJqac=;
 b=GMhAFYpgEp3FIjXtpngr1tYVwejQZ5oabDTr/G1xxg7DFrRVn1g9P0hRQp+opYdmN8
 oWC8RPIt+M07ICHd++GFEKV67tzcg+mEAR0B5+e7gEcLDPInUZpWXPzwB85hdi4phIjs
 ULg5r71dZwEedJakd47HU6VCsGPUspKdJ9n29DEHxHG1Ivy9OetqFUOHZtq3u5Wi8g5f
 pUv4AjWz9xb4ijFzze8pCsZKCftETmCb8I16tdr1gYqGTOxQCmbypLo4XT3BnDLnBQx4
 7NjD7r2N+AQYN45uEbHpVa8OIhPmtMAz3+A36oo9vM2gj1s6LaYYhpUwB/pCsNBUZRrK
 20zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795729478; x=1796334278;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cLndCsyaUJbef6+HCqjnikoRIrtmLL/VU/FOWgoJqac=;
 b=yS4QKh71GcM3I6+aaWZHAIzyhYdAoO2dyWqzcFuUcdlT5PgpmCqJZsLYxBz50q7re4
 eKOY2CfcuQi9PGkBkyVniGzw+TvU+8s3vaqz+Ot2HKYzjOGgAUPNX6e7zf8lGt+Tx5K/
 ftWfI/jeCiLxjL52ZvAuYy7JqJahzHFp4EeFcmDxkZigPtUvmo5uT3uPwqSbfyO6e0kI
 aes8+2r5QAUplIj0T0EIwcNQMvQUzj0LmoYQzUO9lsIgYD9Yt5IgZvVxIKLkvaA4bn33
 r2Ja95S0Dze4GVTNp0pHzkZGynaRzK5rSp5V88Az2mto32JLUFrksqNIQJrD7LMHJhzF
 MRqQ==
X-Forwarded-Encrypted: i=1;
 AL+hErG5ljmrTY//y4ntDlVN4EWHmnIlwUvqhCsiQ0SKPPrE5doiJVVvbkJSaZbSDjMf24OKHmFnyt730hQ=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+riMtRS82qEf5QaloBgmZRKYVn1bynf47Y8rlpzyPpWaoOClWM
 YiTdGSMZqZbN2/Ai5bmHkJD/UcxXHm/V3AgIUjxmYzzjU0i3KbewPj7I
X-Gm-Gg: AZFdTZfNxDtaCvC0tr9WBRFSRTvxq+V0Gb30AVk8GgdbXRS7D/iNsd51gStBdOqR5UD
 5PDVrPBZKIMuu2wwoPBVSDu+bBC1+L47t05RMuYvJph0PW/fjVBM0ETwjKYUth1WdjvfCBDwU+n
 Il/nKkYeqOmVGo8ABaEOK69kus7yWcq9JB9MJ655KBrjs5stcG8QkR7v8J3tb2pr01N4pQjwRvl
 z5xcivGFsmF7g8YnG3xzHHFpd3glxC++IC01JEN4Okzwx9j/Ot8rc4oPS37tx1Wtds4pBvfcXRy
 UDZV+iYTxjWxEy83x1KNC0CIfnbbF+YleKbACf4azphYv+L663D44c5k/9l26Tm2eIeKkIQJzcn
 trFUR2WMNpMPF+XBQ1FGF9PUDOxifq4AHCm/l8m0YVo0LwQFZSI+Nn0dAA4TLyABcTs51feNjZ8
 ffVnXhKlnVvoEIMsNhJl3w+campyyFqAcJBu2o6ovAyjzg9s9xK48dCz3RX7ORTouOlHkCJAbKC
 B5W2+DpewDMHyPMWajazo1vF9EvS75MpQrY6BSaugb7bg7WNIYK8G1QQ2vATen+hcQ2gN1b+n5R
 TKtYQGa119CxkxpMbvBgqJ2qboVLP1F9dJZGSyU6FtXuGhnw41m7uyRyP32VrxPBbyprCJNwnrh
 WoF+6fv+nvQimEGrbpZB9dIR7H7Pt0wPe0y+lffAY8HoPwu4Vit8BdBoe3TBNafTzXabe+foD05
 vBMiWEYVU+SjVSIhhkTg490cx0+G8b2Z03IzpYp3gmhhoD9pfnuhWcjzkF8ouyJcFHwqqPtPjd+
 9odRlpSlojxZrQqkwqj9mJTFyWwFOSm3Na6Xw4g4BFrnv52Xfe5tHpprxAJm5c=
X-Received: by 2002:a05:6000:2607:b0:48f:bb92:c5a7 with SMTP id
 ffacd0b85a97d-4abb0c5d665mr44566145f8f.9.1795729478381; 
 Thu, 26 Nov 2026 13:44:38 -0800 (PST)
Received: from jernej-laptop (77-38-7-250.dynamic.telemach.net. [77.38.7.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4abbd84e661sm40403963f8f.18.2026.11.26.13.44.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 13:44:37 -0800 (PST)
From: Jernej Skrabec <jernej.skrabec@gmail.com>
To: Chen-Yu Tsai <wens@kernel.org>,
	Samuel Holland <samuel@sholland.org>
Cc: mripard@kernel.org, maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, robh@kernel.org,
 jernej.skrabec@gmail.com, p.zabel@pengutronix.de, krzk+dt@kernel.org,
 conor+dt@kernel.org, Andre Przywara <andre.przywara@arm.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: [PATCH 00/11] drm/sun4i: Add H616 display pipeline support
Date: Thu, 26 Nov 2026 22:44:22 +0100
Message-ID: <20261126214433.3562326-1-jernej.skrabec@gmail.com>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series adds the remaining bits for the H616 display pipeline:
TCON TOP, TCON LCD (R40 style) and TCON TV support, HDMI PHY, display
engine compatible, DT nodes and HDMI enablement on several boards.

TCON LCD support also covers SoCs with the same die and full LCD
outputs, like T507: both TCON LCDs share one LVDS reset, so it is now
requested as shared, and TCON LCD1 programs the second LVDS PHY. TCON
TOP now also routes LCD TCONs to the LCD pins explicitly. Dual
link LVDS is not supported by the driver yet. As on R40, only two of
the four TCONs can be enabled at the same time, since there are two
mixers.

HDMI PHY tables follow the BSP: PLL settings per TMDS clock band, like
on H6, and BSP specific values at CEA clocks, including their 1000/1001
variants.

The series is based on linux-next, since DT patches touch boards which
were changed in sunxi dt-for-7.5.

Tested on T95 Max (X96 Mate DT) with a 4K monitor and with a HDMI
capture device: picture captured and checked at 25.175, 27, 40, 65,
80.14, 88.75, 108, 119, 148.5, 178.2 and 297 MHz. 4K60 at 594 and
593.41 MHz shows a clean picture on the monitor, which reports
scrambling, lock and no character errors over SCDC (channel 0, the only
one it reports).
All capture device EDID modes set and checked twice, plus 15 hotplug
cycles.
An earlier version of these patches was tested on MYD-YT507H (T507)
with an LVDS panel on TCON LCD0 and HDMI working at the same time.
Shared LVDS reset and TCON LCD1 (second LVDS PHY) changes are build
tested only.

Best regards,
Jernej

Jernej Skrabec (11):
  dt-bindings: display: sun4i-tcon: Add R40 TCON LCD
  dt-bindings: display: Add H616 display engine compatibles
  drm/sun4i: Add support for H616 TCON TOP
  drm/sun4i: tcon: Request LVDS reset as shared
  drm/sun4i: tcon-top: Route LCD TCONs to the LCD pins
  drm/sun4i: tcon: Add support for R40 LCD
  drm/sun4i: Add H616 TCON TV support
  drm/sun4i: Add support for H616 HDMI PHY
  drm/sun4i: Add compatible for H616 display engine
  arm64: dts: allwinner: h616: Add display pipeline
  arm64: dts: allwinner: h616: Enable HDMI on several boards

 .../bus/allwinner,sun50i-a64-de2.yaml         |  20 +-
 .../allwinner,sun4i-a10-display-engine.yaml   |   4 +-
 .../display/allwinner,sun4i-a10-tcon.yaml     |  11 +
 .../display/allwinner,sun8i-a83t-dw-hdmi.yaml |   4 +
 .../allwinner,sun8i-a83t-hdmi-phy.yaml        |   1 +
 .../display/allwinner,sun8i-r40-tcon-top.yaml |  33 ++
 .../dts/allwinner/sun50i-h313-tanix-tx1.dts   |  30 ++
 .../allwinner/sun50i-h616-orangepi-zero.dtsi  |  25 ++
 .../allwinner/sun50i-h616-orangepi-zero2.dts  |   5 +
 .../dts/allwinner/sun50i-h616-x96-mate.dts    |  30 ++
 .../arm64/boot/dts/allwinner/sun50i-h616.dtsi | 420 ++++++++++++++++++
 .../allwinner/sun50i-h618-orangepi-zero3.dts  |   5 +
 .../sun50i-h618-transpeed-8k618-t.dts         |  30 ++
 .../sun50i-h618-yuzukihd-chameleon.dts        |  30 ++
 drivers/gpu/drm/sun4i/sun4i_drv.c             |   1 +
 drivers/gpu/drm/sun4i/sun4i_tcon.c            |  67 ++-
 drivers/gpu/drm/sun4i/sun4i_tcon.h            |   2 +
 drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c        | 170 +++++++
 drivers/gpu/drm/sun4i/sun8i_tcon_top.c        |  15 +-
 drivers/gpu/drm/sun4i/sun8i_tcon_top.h        |   3 +-
 20 files changed, 895 insertions(+), 11 deletions(-)


base-commit: 3dd8c790a7b7027abdd568e36db5e82ffaea7c77
-- 
2.43.0

