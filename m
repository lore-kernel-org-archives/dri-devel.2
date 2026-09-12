Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1D2FC88E53
	for <dri-devel@archiver.kernel.org>; Sat, 12 Sep 2026 18:22:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC60310E769;
	Sat, 12 Sep 2026 18:22:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ok+9yY2g";
	dkim-atps=neutral
Received: from mail-oo2-f11.google.com (mail-oo2-f11.google.com
 [74.125.231.139])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5D9D10E769
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 18:22:31 +0000 (UTC)
Received: by mail-oo2-f11.google.com with SMTP id
 46e09a7af769-8069d92e182so73230a34.0
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 11:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789237351; x=1789842151; darn=lists.freedesktop.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=BjdcnniX+ccVQA7cSgS2ONHbmJ0xMV8RyAyGUcD/M60=;
 b=ok+9yY2gv/6wTYQjMJZrCvzxcn1M3j38IJzCG7PgxciQCZ41m8Q4+L5YYjjEgmvBT+
 OjUgCLd9hTD2jZR38BSENjG36UMr2JosBtKdBaDMZ1lrEBN98L8BtEVKWYuRUoOOIakJ
 u2Qwy+SPByhzbQ5+Iox4LSQ0kil8l6ql8blTOWfq8HFEanGg38vAuWU8YbD6Q8oYK/q6
 uiUPFyW2tDM7zXFawWINqubQ+iCGsTAgGGsbHRQmkc3bALZw6LxtSUMvO8Ue5PyicAmd
 NjU57J7vrWHvJH8FG+0i8f1ovQ4LTlZWVqR9PicRsQkAyhLyvR7EsKFWIIZ/QMip979K
 /nzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789237351; x=1789842151;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=BjdcnniX+ccVQA7cSgS2ONHbmJ0xMV8RyAyGUcD/M60=;
 b=WqTCVa3PH4N6Dr7PvvMCzjqGpUte/gg5sggONxBN8Gtzc7cWiAYPrddgFk9w1c7408
 ekHmyQeCaXn0BwAgSTVeXWJCe2yex5JeCYstsUKPLU02QQPijIg3NVlSqfEOrx7H09ES
 EeIbuZTsuF6JOcH8eIh+F4SUKx4L5x6NlO8j4D/s82RpLRZ2aKdfYykydkr4vYRXKCTR
 S0Fekv0CebP6umwQroUqV6h7hw2uHo/x3/If1we5yZ+95sK7K0mKqI6/OYFBwXTBawpR
 +9nuP/bMWlPA5anvEgW9uuRogLluVPZlYEYTZlZsP2Swcd0kowKVaOFsAtw+l5N7BQER
 v2YA==
X-Gm-Message-State: AFuF++lyErV6shv95TaXY7poI9u+ze6hH7CNuHrT8vNtM71BIPiBZSbB
 /XQCFnBUaD3R9C54VY5h9grAKPm98jO1iFSPhbl/TLYBRgFy1qjNkiws
X-Gm-Gg: AYBFou0n6MvPm5GQizt+lWC/sdwPQ3V9/nvzmgDhQbFJDpupTXW+ZXPiz9K0Z03gbpX
 EtWHFsnxr1cJ3DZ8GM9G9mUuP2Zcej8j3r2JqxXwNrqsTF1O+yMfNSiU7S8RGKlsVfpcEowbvja
 S1xQOsJDk4i6KehHfKyyTSFuJ9EbU9bcTO4OgCCKhfAcBJ/qjM/GbPLTLAldzSCr6GDWfdznMvF
 Rr6Fva6yCt5Ye1VdccCuUe0Psf59OVZ2Jg5nwQcexcZ1eu+BdxrSSm1NW4hiSKqFKb/0e4fRbYz
 /Lq0KUU7vwhWFRGsmpuyVvIFB0YnLArdLIpDq7JwHbHfPhwxSWn3CJDcXqtjkbFbik5yPQJbl7/
 XpvGA5SZfxSgOxCF2KSNC2/3aQb6W24PwneZVfFU+zjPnPud700db6v3CEZH0ultT/23lWkNw4g
 +zCUGFirXVWqKapSgjCmj5CeDA1zFiGQx9Ej20XYNIzfz7DyhPNttqlTP6b2io051Qb9E=
X-Received: by 2002:a05:6820:214:b0:6bd:cb3f:5896 with SMTP id
 006d021491bc7-6c24d39681emr1997214eaf.30.1789237351016; 
 Sat, 12 Sep 2026 11:22:31 -0700 (PDT)
Received: from [192.168.18.164] ([2600:8804:5716:d800::b712])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-47df64d89b9sm5413898fac.1.2026.09.12.11.22.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 11:22:29 -0700 (PDT)
From: Ryan Brue <ryanbrue.dev@gmail.com>
Subject: [PATCH 0/2] drm/panel: novatek-nt51021: add the BOE TV101WUM-NM0
Date: Sat, 12 Sep 2026 13:22:21 -0500
Message-Id: <20260912-add-boe-tv101wum-nm0-v1-0-3057a08e8b80@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y2O2W7CMBBFfyXycwd5nEBEhKr+B+LBy5C6xWOwH
 VMJ8e81y+ORzl1uIlPylMXU3USi6rOP3AA/OmG/Nc8E3jUWSqqN3KIC7RyYSFAqSrwuAThIcFq
 iHYZxcGYjWvSc6Oj/nrX7w4vzYn7IlkfX20h0WdpeeWnC6ExgYwi+TF0dVz0kqx5qoJz188jU7
 d4/EC5NBY5VF/oFLmuUCuGsmU4ZqgIJ2K+px63U49F8Be355NnzvIpp/hSH+/0fxNISU/sAAAA
 =
X-Change-ID: 20260912-add-boe-tv101wum-nm0-da01c4474db6
To: Nickolay Goppen <setotau@mainlining.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Ryan Brue <ryanbrue.dev@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789237347; l=1702;
 i=ryanbrue.dev@gmail.com; s=20260906; h=from:subject:message-id;
 bh=kKPzi/HLXfog7rBMUGiYLepe2mjam6b/jz1qv/PYobU=;
 b=zhgopAjqYGTLQfAWgqPnNFDJTigscCfew+z0rKaCkpyo6MuRFZd+vY+oPw5xjQIg8OP5kWijt
 UfJm8fc9c7UDq7WRF3gqj6GifalJJCWcfTHEurQeM7krhqd4d0rbQSa
X-Developer-Key: i=ryanbrue.dev@gmail.com; a=ed25519;
 pk=KsUvVaP//v/2q+ZBuacc7cLbsyEYn+AD71Sn28oZWKo=
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

This series depends on the following series:
[PATCH v2 0/3] Novatek NT51021 DSI panel IC driver
https://lore.kernel.org/all/20260911-qcom-novatek-nt51021-panels-v2-0-135e3190a7fb@mainlining.org/

The BOE TV101WUM-NM0 is a 10.1" panel present in the Amazon Fire HD 10
(2017) tablet. It differs from the BOE panels in the dependent series in
key ways:

- The pin count is 51 instead of 46
- The vendor asks for SYNC_EVENT_VDO_MODE with cont_clock=1 instead of
burst mode.
- Different timings and flags expected.

The init sequence, flags and timings are mostly adapted straight from
Amazon's vendor kernel.

Tested on the Amazon Fire HD 10 (2017) driven by mediatek-drm: 1200x1920
at 62.5 Hz across a cold boot, display off and on cycles and a
suspend/resume, with the MIPI TX PLL reading back at the intended rate
every time.

Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>
---
Ryan Brue (2):
      dt-bindings: display: panel: add the BOE TV101WUM-NM0
      drm/panel: novatek-nt51021: add the BOE TV101WUM-NM0

 .../bindings/display/panel/novatek,nt51021.yaml    |  1 +
 drivers/gpu/drm/panel/panel-novatek-nt51021.c      | 66 +++++++++++++++++++++-
 2 files changed, 65 insertions(+), 2 deletions(-)
---
base-commit: 5e036ce12de91c6fd674dad33b169c6150be2a7a
change-id: 20260912-add-boe-tv101wum-nm0-da01c4474db6
prerequisite-message-id: <20260911-qcom-novatek-nt51021-panels-v2-0-135e3190a7fb@mainlining.org>
prerequisite-patch-id: d8b58f07dc5c9e1fcf7c51a14b48eddca2e09090
prerequisite-patch-id: 79dfdac7b7fa79f7d05a5f3849909c9a7f956398
prerequisite-patch-id: 79c01de4e67563772dde152cd4c4d0c568b14d17

Best regards,
--  
Ryan Brue <ryanbrue.dev@gmail.com>

