Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF8B6C5DF7D
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 14:01:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5599A10E035;
	Tue, 18 Aug 2026 14:01:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="F+TDY3/e";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C424110E035
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 14:01:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 69E7841A37;
 Tue, 18 Aug 2026 14:01:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AA451F000E9;
 Tue, 18 Aug 2026 14:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787061665;
 bh=tcam9AT62YS6YwTvCtrThCf5N6Kf1x7mZEg+D2g0Clw=;
 h=From:Date:Subject:To:Cc;
 b=F+TDY3/eFbCFDlMPB1EZT6r5RF4XE1Uh5igY0TlV3L/B6osmTdEdOTLwvTJE5zBKb
 QPx0FI5ZPBNHysW2DuUmh+Tn9RRXWADViHX4TOiGVaeSvzgUOCUC6WPAy1D6kGW17v
 fYti/siouq09gK6AWbAnnTftzCLo5vycd+krTmhAyCa8HAQ3M3A0EqrAxKStKXXHsj
 wAKYX5WcEpBu+pGrATQuwDQ+Jv0v7hUBmg0o9abh+PbU9YrbDFSTE/+hhV0l7CWrTO
 wMra4vBDp8lpGP5ZqlHSlaNvhn1urxs+ZFV/AfPsIgFCwCGxfjP4fLGLCMjHq2tfCp
 o5LSL863jhrPg==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Tue, 18 Aug 2026 16:00:56 +0200
Subject: [PATCH] dt-bindings: display: panel: samsung,s6e8aa5x01: Allow
 common properties
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-topic-sprout_panel_warn_fix-v1-1-ded1e8d5f121@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQrCMBBA0auUWRtoQiipVxEJaRx1RJIwk1ah9
 O6mdvn+4q8gyIQC524FxoWEcmrQpw7iM6QHKro1g+nN0DvtVM2FopLCea6+hIRv/wmc/J2+ygQ
 bxkkPbrQW2qEwtvy/X66HZZ5eGOu+hG37AXGEhsR/AAAA
X-Change-ID: 20260818-topic-sprout_panel_warn_fix-2a4a9b168944
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Yedaya Katsman <yedaya.ka@gmail.com>
Cc: Conor Dooley <conor.dooley@microchip.com>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787061659; l=1434;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=QYXoKD74+oikFgshyjS4sgMQ5zFT2wmPF+xeBeeTjIs=;
 b=7k4L8cWu6SmXI8N8jxMIO4s/M+B9VriAI+8LpHBpUSp4Qu4lWvruLY3t2+1sAEdMUQjpyKB02
 Sxh7yLcC6FgBXyuExL9pj3KBuBspgsDyjwyVOVqvOktd/uH+0OIe1A8
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
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

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Change additionalProperties to unevaluatedProperties to allow
inheriting properties from panel-common.yaml, preventing this warning:

qcom/sm6125-xiaomi-laurel-sprout.dtb: panel@0 (samsung,s6e8fc0-m1906f9): 'port' does not match any of the regexes: '^pinctrl-[0-9]+$'
        from schema $id: http://devicetree.org/schemas/display/panel/samsung,s6e8aa5x01-ams561ra01.yaml

Fixes: f3e1caef597e ("dt-bindings: display: panel: document Samsung AMS561RA01 panel with S6E8AA5X01 controller")
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 .../bindings/display/panel/samsung,s6e8aa5x01-ams561ra01.yaml           | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/panel/samsung,s6e8aa5x01-ams561ra01.yaml b/Documentation/devicetree/bindings/display/panel/samsung,s6e8aa5x01-ams561ra01.yaml
index b271de575e15..f04702de1101 100644
--- a/Documentation/devicetree/bindings/display/panel/samsung,s6e8aa5x01-ams561ra01.yaml
+++ b/Documentation/devicetree/bindings/display/panel/samsung,s6e8aa5x01-ams561ra01.yaml
@@ -34,7 +34,7 @@ required:
   - compatible
   - reg
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |

---
base-commit: e6664f2b33db9b6811eb4cec109f06cb2b4f458d
change-id: 20260818-topic-sprout_panel_warn_fix-2a4a9b168944

Best regards,
--  
Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

