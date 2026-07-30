Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 926C2C54FD2
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 09:23:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44CDD10E12F;
	Thu, 30 Jul 2026 09:23:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BDVaQA4r";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CEB310EE61
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 09:23:07 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-49555a0e68bso9652805e9.2
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 02:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785403386; x=1786008186; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=QEVMeO2gE5AFjmkT1VS2N07BKr0N4iKu0FoXOV951KE=;
 b=BDVaQA4r9tbzyiFb86SdMJBQaqx+V6hqqIpBg2i2uX4+f25k4loR9UuepKdLqgHOWh
 ow8HrwgTaem/OtlWomcjLE5wKwfGObM22Jc0fHfKYnojYHmLh8t9XgpW2SUH9qKsYK5l
 4v8mAlJ/uZAQFUt3jFGQUDVOxkWaRG8wLdUI2oyoc20OSgylWSBkoxYFb6+2DY7ECbVO
 Ykz+l0v/9RS2L803YdnaGt3v7wz1JqkLjqlKHFbJCOvh0fnXTJ/R08HHrgPBtdq2yzGN
 NZ/e787Es8tQZYRPPEEpuY398EuLYTBYOAxk6Pd6Of1iOrmGUZGj7IKUyLN8Sy9sJunt
 bWdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785403386; x=1786008186;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QEVMeO2gE5AFjmkT1VS2N07BKr0N4iKu0FoXOV951KE=;
 b=rWZu+5zb3n34jkQ8oIhqznJjYdwZqRGxEYs7NNW/mCBb83ChxAhTEzBDwjDOoWv1m1
 n7Kdjic/LVFBArQE+gs3L70lKzrme6sRm9fa53YSN/JIhhbCGtdA8yw5KvD45/oTnuaQ
 vnmKE+D+/uXziwQDv3WB2/usOiZD1GdiaONAJysp4FfVoGi9gWEh0Lx3mvsdeNnD6FFY
 eFiTZrpVS8LMojBVRvQkvIa5RmpATQxSxVsEwjlXHSJ+wBhhWQ7S8WtGgV5G3Gv1oa/2
 NJlcabbNgC/tLFYipoaPJzoZThaUDyF8oUGu3CknJ3ggF+aSp/FDNfJysWt86r3gluol
 RqEQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpxLgPoA/FDwsezQ0Z4C4NNgfSeJ5c26u6E/rNhbL9QqnBu/oMAvkEoTKoQUZKa2oAvbKbNa62f53k=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwsRJmG64IbygqxZ6Vg7zCbXilyLhT8i8H02hJPGJ0R5YQG+EPx
 tjJf8HcRticlHCBgkXk186anG1PKimuQPiDhWe6eobe5hpeQF1y/saY2
X-Gm-Gg: AR+sD13SBbJLdLXpi5R+kF/T5CMbP6Cn2tmeIbYVs7cbDal4Um2rm8M+g50BJsDqjB/
 6RnDZxmjz3PvXYfIIh+PLW1yT/+MVcFhGxaRURvIyQVJ/hfd5189Yj4iJdBMGp5UK3o8PRW5wSv
 r9GbhYDP62Z+w7LJxq3+Mybo32LIUMIzBqxAe/qrIKl+p5RXbz4FhYAutWL4icIGHq+yJpuQbeK
 BhHDt0wr9SY2kGgxtoi+k8YvhuR8USKoPoew4aRLjw5UksGrJ2TX08OW7uGzYmXlkxJsY2Zs9Pu
 5CMtLqYifhag1wYGVuyQ/3Uz9nF6QuLt6MWaFMSrOY9lrnbgUhfAO4sL1K+HYkZJk3gpuLK43OW
 L+9x6ZewbpjO6gL+JXahcXanQ6xh41KnWc8xvLBn6LHKaY55524V8TREiuA1d8WJIulW9z3x0hG
 cLw6eUsjIjiLiV/OLybjllz5Kft/0pXmS742Y8aBqWqkW97kQSKL2FkYHtJuoTQVm2owQoTRDRt
 UD6pQnQTEQTGvfZCs/meMpl4m8Wg/J8SQ==
X-Received: by 2002:a05:600c:548f:b0:495:4732:1eb9 with SMTP id
 5b1f17b1804b1-49800ea1e9cmr24176065e9.21.1785403385560; 
 Thu, 30 Jul 2026 02:23:05 -0700 (PDT)
Received: from fedora.tail6d6c39.ts.net ([82.77.79.56])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-47fc88e64d5sm4308425f8f.15.2026.07.30.02.23.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 02:23:05 -0700 (PDT)
From: Eduard Bostina <egbostina@gmail.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>,
 Andreas Kemnade <andreas@kemnade.info>, Conor Dooley <conor+dt@kernel.org>,
 David Airlie <airlied@gmail.com>, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Eduard Bostina <egbostina@gmail.com>,
 Kevin Hilman <khilman@baylibre.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-omap@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Rob Herring <robh@kernel.org>,
 Roger Quadros <rogerq@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Tony Lindgren <tony@atomide.com>
Cc: daniel.baluta@nxp.com, simona.toaca@nxp.com, goledhruva@gmail.com,
 m-chawdhry@ti.com
Subject: [PATCH 0/2] dt-bindings: display: ti: Convert ti,
 tpd12s015 to DT schema
Date: Thu, 30 Jul 2026 12:22:43 +0300
Message-ID: <20260730092245.52034-1-egbostina@gmail.com>
X-Mailer: git-send-email 2.54.0
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

This series converts the TI TPD12S015 HDMI level shifter and ESD
protection chip binding to DT schema, and fixes two device trees
that use it.

Patch 1 is the conversion.
Patch 2 drops the unit addresses from the TPD12S015 encoder and endpoint
nodes in am57xx-idk-common.dtsi and am5729-beagleboneai.dts.

Eduard Bostina (2):
  dt-bindings: display: ti: Convert ti,tpd12s015 to DT schema
  ARM: dts: ti: omap: Fix TPD12S015 node and endpoint names

 .../bindings/display/ti/ti,tpd12s015.txt      | 44 -----------
 .../bindings/display/ti/ti,tpd12s015.yaml     | 78 +++++++++++++++++++
 .../boot/dts/ti/omap/am5729-beagleboneai.dts  |  6 +-
 .../boot/dts/ti/omap/am57xx-idk-common.dtsi   |  6 +-
 4 files changed, 84 insertions(+), 50 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/ti/ti,tpd12s015.txt
 create mode 100644 Documentation/devicetree/bindings/display/ti/ti,tpd12s015.yaml

-- 
2.54.0

