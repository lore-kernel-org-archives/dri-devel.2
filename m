Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC5C6C88E6F
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 18:14:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00AE210F100;
	Mon, 14 Sep 2026 18:14:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="pFKpZpZa";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DDB310F0F8
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 18:14:19 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 2F6D86022A;
 Mon, 14 Sep 2026 18:14:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CBF2DC2BCFA;
 Mon, 14 Sep 2026 18:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1789409657;
 bh=amXM8PKIKM/ToVfiVB0vQgptloCgyaQyxAlLwhGLl88=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=pFKpZpZaEMCFVSX+WdizcaK6/XRKL5FLhRv7yVwmrAPQJgjdiyxUcMDd6M12hkBVk
 M8iMA5oGAadWM9Lwox4N2kzpnPufMf2VQwKrbedk4Uf2E2316r5PEW4lj39QYWPzbv
 OpvFlJBQi2r4ryW0xOMw7XxC7Wh6t1cACHKFI1Qshv50fop1akH+LLepmlyqqkzUQ+
 iQgQvuRFNGk2sNjgSU06w2v1toeify1owwT21An0muGGqk/cycUwytSPtGKGXj37ty
 /iqQbtO0+DlhN0lNhMdrbO3DScFvOzaU4XMKobdq19DAxPDF9soiN1NG1cpHqd4rEm
 9QDnTCKOdN38A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id AB519C88E6F;
 Mon, 14 Sep 2026 18:14:17 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Mon, 14 Sep 2026 20:14:14 +0200
Subject: [PATCH v3 1/4] backlight: qcom-wled: Fix NULL pointer dereference
 in PM callbacks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-qcom-wled-backlight-v3-1-d69fe9843841@ixit.cz>
References: <20260914-qcom-wled-backlight-v3-0-d69fe9843841@ixit.cz>
In-Reply-To: <20260914-qcom-wled-backlight-v3-0-d69fe9843841@ixit.cz>
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>, 
 Kiran Gunda <quic_kgunda@quicinc.com>, 
 Marco Mattiolo <marco.mattiolo@hotmail.it>, 
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 phone-devel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Joel Selvaraj <foss@joelselvaraj.com>, David Heidelberg <david@ixit.cz>, 
 stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1308; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=+wgGNECp4AfVjE6eGXUZbwV3oC+I+6OGlHWyUvqiSrU=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBqqDl4wE0G4LCdwH1KOt8U61clGOca51ytgIZld
 bwFVgJO6baJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCaqg5eAAKCRBgAj/E00kg
 cq2qD/0aMFIPasz9Dr94KFeN+OxZvH6cPkbIhJIaEwboFgwpvYifAXOdMXNhX1s0b5O+mU4PuAC
 lnHE89ggJu+ZRaIN2k8qfpie2vfRSND14nbhZh7l5CF9kDvoVDpauI3z70Qy2Nt/7x27gFXL99L
 Td9b7Mj6mehn0nODie3NarMSA4TgsoPYE71WlSgKTMSScu8uHSa1nAFECYmn+yENhruMdFu/uNy
 J702QAjh/qVCzq2lstGHcuNdjCoWNSsvxiyAjMddfd9nhET3zF2+feFHDuMZCTSEIxn0/l2sKBP
 Va6yml3X4HMw1NGv79ALiDs3Sb+kH38WSd8exp5kbWUgImmMz3h3fwrSgD4/fg9hqX9MtNYrrK3
 nnVoeFSK8C11dsx3390zveC5DWbETJBr7N8P6BoC126OYiOzQ27ssjeSpTonBIldGk5/gpXBTi5
 5uw23oHm7a0MOqlmqDipazRf4RCElQPjsjlE/wVi6MttfVcb4BTELPLtI8Lz1fds0/TyZJECGhU
 Zti23oUC1n8snGjP/2/kp+eqwlAm/VQAsIKgw5oN3mxT1t4+RYNgeypDN0wb2D/YOlRTA8maspw
 Qzt7O/FvAOgm4WG5hF6CfRdzUEj9dzKvnhuOdNxWpx4YHg3IbhxD9jjOi1/yPdN5g6TwvV1XSAh
 wo1dKof/VZRK06A==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
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
Reply-To: david@ixit.cz
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: David Heidelberg <david@ixit.cz>

wled_probe() doesn't set the driver data for the platform device.
As a result, dev_get_drvdata() in wled_remove() will return NULL,
leading to a NULL pointer dereference afterward.

Set the platform device driver data in wled_probe().

Cc: stable@vger.kernel.org
Fixes: feeab87b3072 ("backlight: qcom-wled: Add support for short circuit handling")
Signed-off-by: David Heidelberg <david@ixit.cz>
---
 drivers/video/backlight/qcom-wled.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
index 650dd95f06ef5..a76158a298335 100644
--- a/drivers/video/backlight/qcom-wled.c
+++ b/drivers/video/backlight/qcom-wled.c
@@ -1747,16 +1747,17 @@ static int wled_probe(struct platform_device *pdev)
 
 	memset(&props, 0, sizeof(struct backlight_properties));
 	props.type = BACKLIGHT_RAW;
 	props.brightness = val;
 	props.max_brightness = wled->max_brightness;
 	bl = devm_backlight_device_register(&pdev->dev, wled->name,
 					    &pdev->dev, wled,
 					    &wled_ops, &props);
+	platform_set_drvdata(pdev, bl);
 	return PTR_ERR_OR_ZERO(bl);
 };
 
 static void wled_remove(struct platform_device *pdev)
 {
 	struct wled *wled = platform_get_drvdata(pdev);
 
 	mutex_destroy(&wled->lock);

-- 
2.55.0


