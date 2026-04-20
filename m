Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E103F588C3
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 13:13:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B46DC10E5C6;
	Mon, 20 Apr 2026 13:13:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="qm1spSU+";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B81110E5CD
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 13:13:54 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 49D492688;
 Mon, 20 Apr 2026 15:12:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1776690736;
 bh=+ZX5e3iV5znp3+mDckn1TlQ8dB2YditYBVMIdfVkcSg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=qm1spSU+05ciZuW48R0ul3YH6iD0Ci6CrLgrzBfo6fUVgnToTUPwhQl4k4YAjx9xb
 wtfprfr+H6uJ1VTPQJAX0Teyk2B0lFQX9cjXMIcPMDqpF7I9kYmuznDD+1KWQz9gv3
 UdI5tcwiiFquje4laGW0BwKP+IxzZpSKw11BA2DA=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Mon, 20 Apr 2026 16:13:35 +0300
Subject: [PATCH 1/2] dt-bindings: display: simple: Add Raspberry Pi 7" DSI
 Display module panel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260420-rpi-7inch-v1-1-e68d5c9c44bc@ideasonboard.com>
References: <20260420-rpi-7inch-v1-0-e68d5c9c44bc@ideasonboard.com>
In-Reply-To: <20260420-rpi-7inch-v1-0-e68d5c9c44bc@ideasonboard.com>
To: Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1183;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=+ZX5e3iV5znp3+mDckn1TlQ8dB2YditYBVMIdfVkcSg=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBp5iaOMQC9iebaQi5IfDKU5u34WNTBLV2jKrTRa
 vOWAcQ9T36JAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCaeYmjgAKCRD6PaqMvJYe
 9ZL4D/4uAdqadFN6ZukOFmXOq4EMESGoDm+MEXyEA8NYxZB9Q1ad/EIYb74ivKBvh/0dTTUnzNO
 +GWX2L79kiPCvliffIz7NJPzlG6KYui1IT8iypn7AzT0o1c9L0ZWGjQz74w/Y+C0peyUwF9oOJX
 4QpUbx+FGjtQfWYazN0dnL90Nv2TBS/OYYjKqzkYj3sFgANVYJVdQNFnzBJ0ANkwI1UCrrj5k8z
 6jjmSgvHqqpLum0hFLoJy3Ps4t4Yhsr5ukaa1UZTMap6BKKYuS4PtKBqe4j4ylH3Dzu/h/M/b4R
 KRN9PyNYQG1bac8XivQ8KfCHLz4QjJ24j4ioZEW0lb0mSilsFVfx6jVuvffwPqkgErGZYTVi6gF
 mJb2XpiRSbTXJmQM1LdtkqvLXxRYm2OupepgalOJlyutZNkl/iYfEtw+5zObYUn7mck/iwfs17A
 vQ1mQDJPl46doAA611F5m1SkZP5OecXs58w7gZ2zz4rXKYDSOzQQum+BICVVAq7cl3QMPyUj0Jc
 ohE4J2VLuL9XyuJTEpVbb5x0n6Ncjc/7qk6fkQXjTZbv64Sq1xmbPETKhYTIS+vNf+ReSRJudCy
 12i1qP0YltjfBWEAZnCRXaBfS3/IkdVCVlGfx+tW5RrjBXhwe5byhvtWFWp6p6VJqdrg9F1Ctzu
 tNEIthHhDM4VISA==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5
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

Add compatible string for panel used in Raspberry Pi 7" DSI Display
module. The different display module versions have panels from multiple
undisclosed vendors.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 Documentation/devicetree/bindings/display/panel/panel-simple.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index 868edb04989a..a71578a99ccc 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -274,6 +274,8 @@ properties:
       - qiaodian,qd43003c0-40
         # Shenzhen QiShenglong Industrialist Co., Ltd. Gopher 2b 4.3" 480(RGB)x272 TFT LCD panel
       - qishenglong,gopher2b-lcd
+        # Raspberry Pi 7" DSI Display module panel (multiple undisclosed vendors)
+      - raspberrypi,7inch-dsi
         # Raystar Optronics, Inc. RFF500F-AWH-DNN 5.0" TFT 840x480
       - raystar,rff500f-awh-dnn
         # Rocktech Displays Ltd. RK101II01D-CT 10.1" TFT 1280x800

-- 
2.43.0

