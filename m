Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB315606A6A6
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 18:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hDFveC+N
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BA8B10FE2E;
	Wed, 25 Nov 2026 18:13:16 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA77D10FEA4
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 18:13:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8E49344F41;
 Wed, 25 Nov 2026 18:13:03 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1795630383;
 b=zkcDvbWnkIW6qb6ZD+B93V09xLVJYxZwQu0Ky5ZRKJbmBv72NDYpO5Pdm2STt4et+CJx
 Nq+gL73fRJM03Wa8m/qtnU+aJ2q8ypUROCf+7UxRLW3sZTpSWisFjg8tXA4tq0JgbMdJe
 h1hdFoQ0JSTyIEjm0x5XJe4lw/4hM7mnvEyHhxFJnmkJeKXZ2MUA293DCYDH+HpCC/sdt
 NVOeY7ypkCxQiBt1/bpjGWimF7YbbjCypCP0Ah3N3HYR1DahvsnNjZbocjNBgzSUsGa23
 lSYlmDW8t2aCd1G+hO3bEmOtkEKcmDh+peSDr7EIfXp1zmk+cENF0e0td5uj9DqeuFw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1795630383;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=dgmC1dztGkS5ovK3PLxKYTHSkB6WJWqEHS4AboD7xzs=;
 b=ac5D9tUgQNto4lvJs0gKOtjnit7jZjHhY0KhGZKqyQcM9qumwZ7B6urp0mj49ggVmxzg
 2W1LbEvyT0skKhMdqlOQKTJy39A/X4ES50A1TC1mwflWy/DnUq0Ap+t22BKJXuCjqv07Y
 z1nrHeHeBAV+12wpJbepHS0M0cyJxmVs39XsKN/cTGC+Rfo0toQsT/VfRpPGqcqmVSNCG
 wQL1pgyRo/rnAz4+mo+ZzABn3dN5yPpwXQyG+5/f8GlbF0FL0l/yTbEjSMzdpceA3yjNr
 mBk03J/WiHsytYzAuce90IhBkvEFFvO3TBbgLbXKCBQIS0LIuSClVwmnQ1mqQ11VHGw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 31F2E1F000D0;
 Wed, 25 Nov 2026 18:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795630383;
 bh=dgmC1dztGkS5ovK3PLxKYTHSkB6WJWqEHS4AboD7xzs=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=hDFveC+NISmv6XlGbQvoRHtn369tJupfmWWWH9VcZTLpQYtS6+K6WCFR+bJ/CTMXn
 6uF1bm+zk3IGgS56SiSujn4Y4n9r/1yZrkgsY8ijGyAt9Cq6e75SnAj198Un0Itnbg
 5K2ZzabNlC8cxTWDyXhEQ7GxX4qwpC9oBmRrVs1p9BWLoAFidKdB3LAaVHbQaP2GxG
 utrVbq+kElo19wyWx4nVUooNqs8Yqu3en8eokB6M+c5LfFc53HJZf/myIGd4cttVsR
 sSZRK2v5bUb0AWZw8ALX/LcLHvIkq6n4X7fJRvBCR+8+1MC5PhLcNIPlbT4aXmeEVT
 RJApAjTCcBJTA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id B01E64CFA8;
 Wed, 25 Nov 2026 18:12:48 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Wed, 25 Nov 2026 19:12:47 +0100
Subject: [PATCH v4 3/9] drm/panel: s6e3ha8: Introduce AMB577PX01 panel
 compatible
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261125-crosshatch-panel-v4-3-120adc58e737@ixit.cz>
References: <20261125-crosshatch-panel-v4-0-120adc58e737@ixit.cz>
In-Reply-To: <20261125-crosshatch-panel-v4-0-120adc58e737@ixit.cz>
To: Dzmitry Sankouski <dsankouski@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>
Cc: Marco Mattiolo <marco.mattiolo@hotmail.it>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Petr Vorel <petr.vorel@gmail.com>, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org, 
 David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1409; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=rCrRxpJWEkA+wgegtsEKS9XsmbU7TwkO+KtW1/Btotk=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBrByUeIgC46JvhQIPnYQYYYCamNwpmw3jNpsU3R
 MESU5BsDn+JAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCawclHgAKCRBgAj/E00kg
 cplHD/wO5o+nxQl76HIHS0/qGCfgHjQrPeaFdECMubs4ag1CtwpMgHSWR7ELr/JdsGwtIB3h2nV
 vnY7GN6gfF9ffSawtLY+NlSHX0HeeiJM4Z/GhCvkpGeiqLpRGgFDCU8/r26lZGYaxCGLjdgtUJl
 fILya80imza0R0jxaCIjgnzx8uTB8f5c5AYScFav8rhqQSK8+NFeGiFNdRq/XDD8luXIoYDaJuq
 vtjRHt9s3/12rOFWw4rlSowGM1Ukgd726hprQ1W1Ev2njidSP6IrvyWNuJjPrNtqzIhbBU9kt5A
 lrdvUnlTjeqWMNLpjG1makuBH+qGEiOE3P/LKhboqFg5hyqJWCbSQ5RGfrIx7ZEa5/ZqWsokxIV
 54k4kAnQyU6/ZB5d+CD5TIl06/UW0OLtkL65HL3vP4IVZzVV/KQrgVODFvrg5r3FD18dH+5fB8y
 6Piy4tYQ0ujHlr6JUffGFGkoV6XOLsBP+qEdWi/ccD1MvXoKt4SITBTyKq5AZqzt5e4HIkQDoDO
 G8tzW3/O3LqxOqR0b+H8w0LMpo1Y/PzLg3XYz2f1afZ3F8zZ5CH/3PO6Ai/aiPSYfYoTNk2egq6
 b6sX/bKOGY6L0ZXET9+6P+G3bJdFqvpAmDgf33GgtrJPtq0my9GRg6gmXfC3kQd0unWKC0duTb6
 bu69lntBqDHdyug==
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
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


