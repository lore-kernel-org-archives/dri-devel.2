Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FD860A5BDA
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 11:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MHk3q0Br
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C97210FB8D;
	Wed, 25 Nov 2026 11:26:37 +0000 (UTC)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com
 [209.85.208.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7280110FB8D
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 11:26:30 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id
 4fb4d7f45d1cf-6bab377105dso4097180a12.1
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 03:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795605988; x=1796210788; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=G+BRXkvsKkCtNetmP+qei8f/iduzEEyC3n2dsxTeZ90=;
 b=MHk3q0BrSLO4/Dat8/Lhae805KyRX/6ivQHbgiTTreoDhkT/qWDe9mXKtfW7rnrpbO
 cvaeEc80unXvKr0mPly8YpY1QfliHyC7+kl31iIIT5PFR3YDr0BePUBJZqoKVlMQafCq
 DI5XCft1qf2y4CGZqMYKBKVe1EhiFCg41zdk+4hJsbpHjukQ2+dBTNWnjcoQPluyCIfQ
 EqLJ8o++fRAo9E7Nk7WILImk/F0hpSMfMpF5D/vA+Ii1M+p8zLowUaKLPVLELEIPKqej
 PMSODNk8sKY3ceeFasPPMB9EIwSmbCvGqj5uWqs6m8M6sdpuBS1Y85hiay4BnWzlG4rd
 pZcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795605988; x=1796210788;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=G+BRXkvsKkCtNetmP+qei8f/iduzEEyC3n2dsxTeZ90=;
 b=OQbWQk8c8h/eyjKUwX7esMQdXJOZhPFTRmCCVp8Gm3/IDTiL+0mwiN7dQ1oHhCwyou
 wT4wo/tyEY4mSlyPS8Pb3GDlLk5HGzgjF2VFAjDcrSClXOcjAuTxA8ZivxRsillv5rmw
 js1CQHKyduXM87xFJUe0gZXZ8yzTusmM0Gs9RIxiE2ZVTARUwTYbkMNZXu/DmM0oFLBJ
 +exiLWprH/8Nmy2R4uLD8XlRATW59/YVBDeAFcUmcAzef549AAIcKbOUV/uuVAfOBeAq
 W+ix3/1yHI6fs+Q4xHuYyX4D0UiasPiLSJ5lLU8r9rHcxREyL3zk1gscllteOSEI/Ppc
 AwOw==
X-Forwarded-Encrypted: i=1;
 AL+hErEgueXu87iPOvWznNlgUMU2aAUtulDxo32xfJ1v1FlVq+3LxiTjeCaf5hJcFkmh1GBR9Zq2c3Oy+9Q=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8IdwwpkHWMo/FGyQ6WrY2AUyqEgQ0OywTufPokS14gyaireYL8
 q+0uaXAzV++4H4YvNvMNF1D9VwtdZyldGbv5AY4Quso1TkiDU0aQZCXG
X-Gm-Gg: AZFdTZfcEeBDmf04HDXVA5VJuNH/hE57xEH+Ka58zqEP4zpl/kH+vJVPl0gIzElAoga
 HpjFwKgBV2OmA6aeT0Gyhl7WsYzupVLHPZiw1zLwSuAcIxFf1A16F1FJV2qYxLnvFxC7cTKNWVH
 uxf5pzSEGVIxeXSk80/Z2zktx8e6YinkpbL8QtgrTM1KLuFz0fZy+yfsUNEzZtJjk4XEBFMCbes
 vVuTWZDZz5mTBSMgPF9l8laoQaqdF2ixKyAozVcmkpOX6z4o4aPcaBmiPMAFRKA6HkXaQKRzoIR
 TQahscctLHHJFwIZyiDI9Sd3mz4XIsLJ3fsh1PvYG031nrVFsgd09ayX7/AG4Dt1Ii3TMFWGZV+
 0LZvK6CRLW3VYrbqI4sK5yCBgelId1abZD7a90vPcnMS5YRn/XrRw7Dn56v8wU0xzfcwpmbqc1v
 /Qc3UFwDD70hBteKoi3t/7VMsjTAqT66RSPkcSr63FxO2NwASEh7JKUCj9jWv7TMvNUYVYRot8t
 YEwgAofNrW0YQsx7heiklJUZlxHRVsX9Cl6W7ii2FDgIHL7Dblzlcw6AVJbQESqvx1ObRjKta30
 J3CNoYgsiRONT+r/HNoK16PQo6oBKMpGbRkm9wNUYZqFxOsnyETKr25Fiy4pLd86nCf1dfwO9C/
 3p9pKjFp/quxY4E7xsPbnE8OP+wHq7hA=
X-Received: by 2002:a05:6402:1155:b0:6b5:7312:4f48 with SMTP id
 4fb4d7f45d1cf-6ba37e90a38mr10062440a12.28.1795605987551; 
 Wed, 25 Nov 2026 03:26:27 -0800 (PST)
Received: from xeon ([188.163.112.54]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6bb1b93a8efsm1202907a12.7.2026.11.25.03.26.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 03:26:27 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Sowjanya Komatineni <skomatineni@nvidia.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: linux-media@vger.kernel.org, linux-tegra@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH v2 0/7] Tegra SoC specific Video Input updates
Date: Wed, 25 Nov 2026 13:26:06 +0200
Message-ID: <20261125112613.237333-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

This patchset contains various SoC specific updates for Tegra Video
Input driver:

1. Fixes for Tegra20 and Tegra30 VI configuration (clock adjustments)
2. Moves Tegra210 specific code into tegra210.c from csi.c
3. Addition of Tegra114 CSI support

All changes were tested on:

LG Optimus Vu (P895) Tegra30 device:
 - MT9M114 front sensor with complex topology and irregular pad mapping
 - IMX111 rear sensor which has simple pixel array and a single pad

ASUS Transformer TF701T Tegra114 device:
 - same MT9M114 front sensor
 - OV5693 rear sensor which has simple pixel array and a single pad

Nvidia Tegra Note 7 (P1988) Tegra114 device:
 - OV5693 rear sensor

They all work and produce images.

The "ARM: tegra: Remove fallback compatible from Tegra30 VI node"
should be applied with "dt-bindings: display: tegra: Remove Tegra30 fallback"

This patchset is based on
https://lore.kernel.org/lkml/20261125110750.223628-1-clamor95@gmail.com/T/#m46981c261c3178126ce806aabddcc38cc33f747e

---
Changes in v2:
- "staging: media: tegra-video: Move driver to media/platform/nvidia"
  moved into media-device conversion
- dropped:
  "media: tegra-video: vi: Switch to media_entity_remote_source_pad_unique() helper"
  "media: tegra-video: vi: Use entity function to check subdev type"
  "media: tegra-video: vi: Adjust pad assignment logic"
- fixed schema clock-names configuration for Tegra30 and Tegra114
- added "media: tegra-video: Move Tegra210-specific functions from common CSI"
  (Move and staticize the tegra_csi_error_recover() and
   tegra_csi_calc_settle_time() helpers from the common CSI file into the
   Tegra210-specific code)
Link to v1: https://lore.kernel.org/lkml/20261113161819.36847-1-clamor95@gmail.com/
---

Svyatoslav Ryhel (7):
  dt-bindings: display: tegra: Remove Tegra30 fallback
  media: tegra-video: vi: Diverge Tegra20 and Tegra30 VI SoC
    descriptions
  media: tegra-video: Move Tegra210-specific functions from common CSI
  dt-bindings: display: tegra: Document Tegra114 CSI
  media: tegra-video: Add CSI support for Tegra114
  ARM: tegra: Remove fallback compatible from Tegra30 VI node
  ARM: tegra: Add CSI node for Tegra114

 .../display/tegra/nvidia,tegra20-csi.yaml     |  37 +++-
 .../display/tegra/nvidia,tegra20-vi.yaml      |   5 +-
 arch/arm/boot/dts/nvidia/tegra114.dtsi        |  34 +++-
 arch/arm/boot/dts/nvidia/tegra30.dtsi         |   2 +-
 .../platform/nvidia/tegra-video/Makefile      |   1 +
 .../media/platform/nvidia/tegra-video/csi.c   |  75 +-------
 .../media/platform/nvidia/tegra-video/csi.h   |  11 +-
 .../platform/nvidia/tegra-video/tegra20.c     | 171 ++++++++++++++++--
 .../platform/nvidia/tegra-video/tegra210.c    |  71 ++++++++
 .../media/platform/nvidia/tegra-video/vi.c    |   8 +-
 .../media/platform/nvidia/tegra-video/vi.h    |   8 +-
 .../media/platform/nvidia/tegra-video/video.c |   7 +-
 12 files changed, 324 insertions(+), 106 deletions(-)

-- 
2.53.0

