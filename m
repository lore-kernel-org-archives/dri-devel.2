Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36984606A330
	for <dri-devel@archiver.kernel.org>; Sun,  8 Nov 2026 12:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OIRQed04
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71E8F10E7CC;
	Sun,  8 Nov 2026 12:32:52 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A83B910E759
 for <dri-devel@lists.freedesktop.org>; Sun,  8 Nov 2026 12:32:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3AB7844040;
 Sun,  8 Nov 2026 12:32:34 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794141154;
 b=H9caFES20H4CqeiVplisIblfLv/v7TRvNVYEIORlp/BRoUf9+k9RvW6YZI10tmqP1Nm4
 PpNT1FM8Fuqbkx7WyfQda2cnzLSwxhBryJlhZ15OJQrTIJpjBB+s4Vkso5pNXNUJJSU5i
 2v1LQxBFhljhf2L1kQxypcgCUOchozriL0HexZl8P88cmByhNXtqtkEtQSjAaFBrgyoD1
 9LdS2Lz1d8jtCzD4liIvhO/2qVoyI9jN4u2tYAMlswad9MrB1lKhtVBfpxRt4Kgwo9980
 Dm7ySybIY00gWeEEugskp4ZkGZ5rby0jWwewz4s/GQfOra3sLADRAuoQBA2vsOmg43Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794141154;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=dgmC1dztGkS5ovK3PLxKYTHSkB6WJWqEHS4AboD7xzs=;
 b=i0Adj+2YQh8znN1Ino3EIUnB7/XivN1gqgJUmGk/SplbghK7pgQh96ZDeY1EImc7b8Fp
 LHN42MObeCga4G2giZLb0TYB1E59OOy3M3v7VmKIKTQqZaf2m9UATk8SEmif35IAN6pHt
 Jre4X9WiBFia6dET8brsgo7VkPr+ner4S/aoVJCRaf30G2s+PBdZ2C2StrDDzqYhwOUyw
 rdMVRQo9qoNAky/f6CfNwZEPpwkfdVT55UFl6FE215CIRyeGITjxQ8NVJZdzvBla/hFRY
 UAXLYrIGXAPE1tncE4R67voUgGnAC6OGlM5mcPe7ymgR7k45g3yaJaToXQ0rUWG0mTg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id CEDD61F008A4;
 Sun,  8 Nov 2026 12:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794141154;
 bh=dgmC1dztGkS5ovK3PLxKYTHSkB6WJWqEHS4AboD7xzs=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=OIRQed04P9nFFUXPA5XJligUFFV8IkArFJqs5QUqkMbTip424fVrRrqndGcLLswq4
 GXGHQGdnTjaE2E2gjkCem7ZuJ8x4YAmFEzTObkNIAswQkOUQYdcVXFCKiTqtcKvZCo
 cA0rFTOCKuC3FwBQn66GQEpmwBEn5Z6ClYa1aNrR1+r9lAJhrPn5bOuZPdRaXvoRwV
 WwFwKHTfz0uY9yiRbL8/SXB4Bw0+Xj3C7OhWVvOVH7uLTL1hyvTS3bYH0lnPaRMhpF
 RTEKD8k+i7U0IJRHsI2XQuF14i7NO1yT9mwc20Tyh8s9Y1IvkMZfwb2VjAxcMG8ta/
 0pZgsP+ifp+3w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 53F3047F6D;
 Sun,  8 Nov 2026 12:32:32 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Sun, 08 Nov 2026 12:32:24 +0000
Subject: [PATCH v3 03/10] drm/panel: s6e3ha8: Introduce AMB577PX01 panel
 compatible
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261108-crosshatch-panel-v3-3-87dd4ec4f7cc@ixit.cz>
References: <20261108-crosshatch-panel-v3-0-87dd4ec4f7cc@ixit.cz>
In-Reply-To: <20261108-crosshatch-panel-v3-0-87dd4ec4f7cc@ixit.cz>
To: Dzmitry Sankouski <dsankouski@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Petr Vorel <petr.vorel@gmail.com>, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org, 
 David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1409; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=rCrRxpJWEkA+wgegtsEKS9XsmbU7TwkO+KtW1/Btotk=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBq8GveDbF7QshoXouh/LyZSBTuq4NEIs+zOioKc
 LJAQQPVuPCJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCavBr3gAKCRBgAj/E00kg
 cq8GEADNKdESp1A6wL4mOHYchMs/MZRUz7PXD1yIVwuMZsYRrlFfnW7Vtnty6KiZNb4fEm9RlB2
 3f02KyypqSH7ZVLgwYVO7FPNSHYo8tf0bj9mxXTTgsbEF7AbpmBxIkZLZUdM1WgRkUeftWCi9BS
 ScEZ7p8KQDV7NNtYR6FuBrs3LNM2vbdcvScqTK+yipvMrjSLOGklM0X2hDfMhe3qz8IXF7QtAGy
 H5eDcf2veq7alqn6wuraYVXKsqoOGgMOgGCCFAJPrKWv+yrSe1ZslWgfZug0423iImrM0QdxMeN
 RA49h7Zju9fZ0IdiY9W1viy+iMSnJK5ch1+L7zJsLaDjufovvK5aLxNEqOH6UT4/oA7WnIyl/Ve
 7P2WfzUwxOriP4bXvvJnxc6BtvzuThBpTR+bHD52v5ASgb07dKdfDxGw6oQZAV3uRRUMHdJtoxF
 gjq9tifNLJjqHQCv2ReAGppoJe/UdY5/kP6NOR+97u40p4MCMM7F5J5ZC/pYQnfyo+NSR1VYXw5
 hzYVpBUwYlSZkGjfInlrY0Bo0voduu3tpeAlbHUyxqH7F0c1C93SrKgi/5mCkv2Ik2+7HKZS9qb
 3ErvWkeGek9AG6bDcFoUZknsorek6orvP+7jTo+0lNvEz0LDHBEyKg505vUBh1vjBCzuZXIKzz2
 clY/HWsCfJN0Mkg==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Content-Transfer-Encoding: 7bit
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
Reply-To: david@ixit.cz
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: David Heidelberg <david@ixit.cz>

S6E3HA8 is the DDIC, while the panel used on the Samsung Galaxy S9 is
the Samsung AMB577PX01. Match on the new panel compatible, and keep
the deprecated DDIC-only one working for existing devicetrees.

Reviewed-by: Petr Vorel <petr.vorel@gmail.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: David Heidelberg <david@ixit.cz>
---
 drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c b/drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c
index 078523df48860..45b1c522b0ccf 100644
--- a/drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c
+++ b/drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c
@@ -296,17 +296,18 @@ static int s6e3ha8_amb577px01_wqhd_probe(struct mipi_dsi_device *dsi)
 		dev_err(dev, "Failed to attach to DSI host: %d\n", ret);
 		return ret;
 	}
 
 	return 0;
 }
 
 static const struct of_device_id s6e3ha8_amb577px01_wqhd_of_match[] = {
-	{ .compatible = "samsung,s6e3ha8" },
+	{ .compatible = "samsung,s6e3ha8" }, /* deprecated */
+	{ .compatible = "samsung,s6e3ha8-amb577px01" },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, s6e3ha8_amb577px01_wqhd_of_match);
 
 static struct mipi_dsi_driver s6e3ha8_amb577px01_wqhd_driver = {
 	.probe = s6e3ha8_amb577px01_wqhd_probe,
 	.driver = {
 		.name = "panel-s6e3ha8",

-- 
2.55.0


