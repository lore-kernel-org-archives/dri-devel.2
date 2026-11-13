Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52126070FF7
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 16:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a3cGsWWE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFE4610EC6D;
	Fri, 13 Nov 2026 16:18:48 +0000 (UTC)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com
 [209.85.218.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6F5C10EC33
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 16:18:42 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id
 a640c23a62f3a-c4d581da0aaso191143966b.2
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 08:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794586721; x=1795191521; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Eirh/4i1JKisBRrsumJjSRboncwjaisgQnevXkb1w8M=;
 b=a3cGsWWE6khJQWvZTRZRphXOMFIBXq85oy7dV23CTVX/ZKTpllti9/Tql/kf5NJ9Oo
 VfuD4RlgxG7QOZ/UNPSQprMpl56NoWoJRrNgm9HDRclCNf47IKoElDowGG6kj1u+giS7
 2hDaaS0MuyQJyFujkA2tB0H/TUGI6WBgjJ9nhuvcW7esgDeu7woru7kh70P4JDDt3qoR
 u0O9lHo7hWjBAsk4Ha0xM+6kXoADopnGFHfkochVcvBbOvvaYLa+jZT/N2NFh1nqlAR6
 ++SMPHu7YjF0gx1ZRnrm2hlggLYvYfkqm0c5DLcat7UJaTpnidxo/ZJ6JiakkgjONHf3
 BsWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794586721; x=1795191521;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Eirh/4i1JKisBRrsumJjSRboncwjaisgQnevXkb1w8M=;
 b=lvlqiUJihY6tDTqzCx1Ycp8YY4wSdRoDuIeF553O38YMJiPQUe36Al0k+ICY8YgQjh
 phgN+3LGtN2qGmrAKbawalwbmQTNKEv56StWe1U4iiEJVscSO8fV6r46zCnsobvZAime
 lWTQI9kb1SuOUR9Q64JJX9NGRPuIB3bVoxuF1HYurDJNOPrmRdATlM36rzcJ2o9FXIL+
 yqWzjPPD/zb9UaEQARoNsNu+DmWu88NgWy/s0odHsvEfHUpfGevEk2BXBcdwtqdgS5m5
 0Eaob9BmV+J/s725NjGSPED/ZudYF40JUKmD0TNTw7ta7r/t1gK0kHuSzkfMZHbnRvlD
 gdDQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEj6TIKLCg/DytRk8PaKIkLMlD1efJhRcP/zm/cKSMnKo/mZMjwE2HU7LQ/ME7WcKa7Y/Ao9X1zV6E=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+xERRL8rGLKHeEFrVnRVRDRxpN+daXlFXOqBgF787x/4bYo8+w
 ISD2zdBfOcRCZJp52jZl0hnAdUH2UpY/+yNQagPLZt2qd6qU5n5jUpfS
X-Gm-Gg: AYBFou3fYUBSJmo+dtRHTaeOWkHiKY2rHZdYEcKj4BDure7n0MsH/lf4uTT4aaZropT
 IEZrZAiMgOv+W+It8wdnKSjOjpM/mIf3VkNv6+6eRiE6UsbAIBr3YZ8xIrGHnAdg6pWemkfh+Vv
 sGzKjXRXB0FEXvtcTU8rU13UUiWKkFyW/GMMpTVe2/OgH2O2ZjOYuYkVJrFXb4BFmTwj8eH09NS
 v6wOlzSfqjL4lHjexOs0X4VA+EmGXNf62e5mpCbtpxwwWeJc/dLR63Li8MRNjisjQPIo8/VDZkj
 /hVhURQsk7PirN4mqq1eotfc0od1E7EVpm8HNBtITuQ+qgr/f68FIx2PPfzY+Xb51z+0a9tXjz+
 X6NAXwPf2JaSUzX4p9FTeQG+ZFyoxIm5mlHScbzKQXKuKTYaA/nb1F1xZbKeSworEYmamHL4bSU
 JG3WddG5vosDSQISKoLSVa2CvavAnBuBYZ61KEdZt1/nzfbudPW1w0CcA1nUnKlrdyhx14W2VbW
 Z9+RybB0gP/D9F/sLoMQDo7NgB8wo4ufzJInWrZnxCR8JZCFG3ZCasu4TdnZGfWYdP6aZh63UKe
 410sKzOd3vyMAaGZs5jFcjB/nWZHea2umgsCZb0XmW/sJfg6FYMvBwybEnor6YuOL0kM8S7BbaL
 7/XLI+rFiBg==
X-Received: by 2002:a17:907:930a:b0:c40:19dc:a24d with SMTP id
 a640c23a62f3a-c5096344fa5mr275778966b.9.1794586720616; 
 Fri, 13 Nov 2026 08:18:40 -0800 (PST)
Received: from xeon ([188.163.112.62]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c5095b24b88sm122297266b.16.2026.11.13.08.18.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 08:18:39 -0800 (PST)
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
 Hans Verkuil <hverkuil+cisco@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Cong Nguyen <congnt264@gmail.com>,
 Faisal Mukhtar <mukhtarfaisal03@gmail.com>,
 Dan Carpenter <error27@gmail.com>, Hungyu Lin <dennylin0707@gmail.com>,
 Hao-Qun Huang <alvinhuang0603@gmail.com>, Yury Norov <ynorov@nvidia.com>,
 =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: linux-media@vger.kernel.org, linux-tegra@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH v1 00/10] Tegra Video Input updates
Date: Fri, 13 Nov 2026 18:18:09 +0200
Message-ID: <20261113161819.36847-1-clamor95@gmail.com>
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

This patchset contains various updates for Tegra Video Input driver:

1. Tegra Video Input driver is moved from staging to media since
   the driver is quite developed by now.
2. Fixes for Tegra20 and Tegra30 VI configuration (clock adjustments)
3. Updates and optimizations of VI implementation itself for complex
   media devices attached
4. Addition of Tegra114 CSI support

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

Requires this patchset: https://lore.kernel.org/lkml/20261113145708.261530-1-clamor95@gmail.com/
("clk: tegra114: Add CSI pad clock gates")

Svyatoslav Ryhel (10):
  staging: media: tegra-video: Move driver to media/platform/nvidia
  dt-bindings: display: tegra: Remove Tegra30 fallback
  media: tegra-video: vi: Diverge Tegra20 and Tegra30 VI SoC
    descriptions
  media: tegra-video: vi: Switch to
    media_entity_remote_source_pad_unique() helper
  media: tegra-video: vi: Use entity function to check subdev type
  media: tegra-video: vi: Adjust pad assignment logic
  dt-bindings: display: tegra: Document Tegra114 CSI
  media: tegra-video: Add CSI support for Tegra114
  ARM: tegra: Remove fallback compatible from Tegra30 VI node
  ARM: tegra: Add CSI node for Tegra114

 .../display/tegra/nvidia,tegra20-csi.yaml     |  23 +++
 .../display/tegra/nvidia,tegra20-vi.yaml      |   5 +-
 arch/arm/boot/dts/nvidia/tegra114.dtsi        |  34 +++-
 arch/arm/boot/dts/nvidia/tegra30.dtsi         |   2 +-
 drivers/media/platform/nvidia/Kconfig         |   2 +
 drivers/media/platform/nvidia/Makefile        |   1 +
 .../platform/nvidia}/tegra-video/Kconfig      |   0
 .../platform/nvidia}/tegra-video/Makefile     |   1 +
 .../platform/nvidia}/tegra-video/TODO         |   0
 .../platform/nvidia}/tegra-video/csi.c        |   3 +
 .../platform/nvidia}/tegra-video/csi.h        |   6 +
 .../platform/nvidia}/tegra-video/tegra20.c    | 171 ++++++++++++++++--
 .../platform/nvidia}/tegra-video/tegra210.c   |   1 +
 .../platform/nvidia}/tegra-video/vi.c         |  47 ++++-
 .../platform/nvidia}/tegra-video/vi.h         |   8 +-
 .../platform/nvidia}/tegra-video/video.c      |   7 +-
 .../platform/nvidia}/tegra-video/video.h      |   0
 .../platform/nvidia}/tegra-video/vip.c        |   0
 .../platform/nvidia}/tegra-video/vip.h        |   0
 drivers/staging/media/Kconfig                 |   2 -
 drivers/staging/media/Makefile                |   1 -
 21 files changed, 281 insertions(+), 33 deletions(-)
 rename drivers/{staging/media => media/platform/nvidia}/tegra-video/Kconfig (100%)
 rename drivers/{staging/media => media/platform/nvidia}/tegra-video/Makefile (84%)
 rename drivers/{staging/media => media/platform/nvidia}/tegra-video/TODO (100%)
 rename drivers/{staging/media => media/platform/nvidia}/tegra-video/csi.c (99%)
 rename drivers/{staging/media => media/platform/nvidia}/tegra-video/csi.h (95%)
 rename drivers/{staging/media => media/platform/nvidia}/tegra-video/tegra20.c (88%)
 rename drivers/{staging/media => media/platform/nvidia}/tegra-video/tegra210.c (99%)
 rename drivers/{staging/media => media/platform/nvidia}/tegra-video/vi.c (97%)
 rename drivers/{staging/media => media/platform/nvidia}/tegra-video/vi.h (97%)
 rename drivers/{staging/media => media/platform/nvidia}/tegra-video/video.c (96%)
 rename drivers/{staging/media => media/platform/nvidia}/tegra-video/video.h (100%)
 rename drivers/{staging/media => media/platform/nvidia}/tegra-video/vip.c (100%)
 rename drivers/{staging/media => media/platform/nvidia}/tegra-video/vip.h (100%)

-- 
2.53.0

