Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15356CA9EC0
	for <dri-devel@archiver.kernel.org>; Sat, 10 Oct 2026 11:55:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C57E10E2BB;
	Sat, 10 Oct 2026 11:55:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EGsEHXmv";
	dkim-atps=neutral
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DCD210E2BB
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 11:55:54 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-48b0ef9c76eso449671f8f.0
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 04:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791633353; x=1792238153; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yWSkHUKka7QH4eH23AR+aM1Gs2nsmpiVfZDP2dicIho=;
 b=EGsEHXmvjis2NxeJuxcE1LXJBnFs22rZhTLhirrZ2pl3n4FN0z8K+fdvaIhrMHyvB4
 dATrEiz9xUNdWjKMnVCOwhRi6CEK908XYJy0OpPXlDurYNXbe77cQUr8NovwHLw4Rd4o
 cbqn3vwUVx/mIAlB4Onz6BjOJBFfTIGegruiF/3ngQ3xyE7B5/X5AKMBYhNIICkUAFr+
 E4GL5VXrPvVEd8IFZPTWH7BoUXaUHJynFQn9tfZtPlcvp+ti0HkBZl+4GxPVgr1oCv0E
 QE/OljXPDPxhlIHCAFzhTjgwnmCgJ1keJb43fLnvLAkUmfJfEEOb7vVVvrl/EnZRAAa4
 QHzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791633353; x=1792238153;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yWSkHUKka7QH4eH23AR+aM1Gs2nsmpiVfZDP2dicIho=;
 b=A40EfplLxn3mzWsfVxFGk9X224ZnyVlSmfJU0NhGvKqGRTMqeKRTRKQsbFEX7FVCgU
 XutlB4D9xzUiLeBuQI4A3YCQMzXJjYM3Qcq5hd3H6l0kZiFxhjVcuVR6n5oh68t+oney
 OKf+x8mCRvvevpLf8nS0j6p1HCH8Do41ibzYmxkwhF2DSEOjSm7PoznebYbz5Ahx/LDW
 8EvIA4J/fblic+/I6+j091boZ7JVfTyeTwAbi1RuK2AmPqBTJTXoiEp6lsKo0XZd+3WE
 68tl2oB9z9zUNmHhYl1ksxgeGezcDDjEMfQFw0OMEmNp3ldXQ2c/fG2tg4TUtN0a0fs5
 qjHQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwE4JW3QyyleQjJ+VjLpL3iVJBwKw13m2/CiF8szz4v1lG7b+Po8mHquanL2z8SqIGzf2ro9UEsgYc=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJJ4H7DY+P7jBu2WwJHMHy63aDhaKUDLvtrGJrrw0Jad0NwrgDf
 5ntMg/HINuB2s3ouAsU2BvXSsoeRNKjYAwsvb9E1+fSbOTI3wJuHuFAB
X-Gm-Gg: AYBFou1HfMhcFWDHjxJtjqoKOQe0vhSbkR18WGrMsK0hv8VaDytSa7f5eO+INHMFqfX
 diNPV3ANBoIh/HpJ8rQsEdaSf6+63i25ykYB93GnJfFS4/GiL8bzJ42sfw28OAQP9OsZ3XOlT9F
 wxvL2BvWEwT+DP+dlfHdCr5EXm0Uw/QVhJSkH//Xd85VSotyCEkS2VaFkcIcxa3H345KIPhZs1l
 XXt0wXyjLM2aP1CTnoBZXUHiiivijYBD63vRxR2P++SALZQZayT17R8fQ9cTe4PURMT0nsQmCjH
 q4gaAzTYwKGO+hB9COMFLO6dpRnC5gOIIgoo+SJ06xc6G0LgThw+PqtV9SPCbx8isQnoCUkr3Jo
 qDKVAz87uyHS5RyLDChI3rRY7UwKloeWeygmULjLIdMxDy8WS4QE1loDZJ4MfB6gwaZ7HvV+bUR
 GZUZCuacnsI5kZRkiEE8A+ul9dB32pkuAL1I1kLoiqNTmcWC4aZc6sLwA3d3UyMpLFiA==
X-Received: by 2002:a5d:444d:0:b0:48b:fdd:fbe4 with SMTP id
 ffacd0b85a97d-48dba9c7d29mr7028135f8f.21.1791633352509; 
 Sat, 10 Oct 2026 04:55:52 -0700 (PDT)
Received: from luca-vm.lan ([154.61.61.58]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db9aca657sm8746340f8f.43.2026.10.10.04.55.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2026 04:55:52 -0700 (PDT)
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
To: linux-mediatek@lists.infradead.org
Cc: Luca Leonardo Scorcia <l.scorcia@gmail.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>, Vinod Koul <vkoul@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Chen-Yu Tsai <wenst@chromium.org>, Fabien Parent <fparent@baylibre.com>,
 CK Hu <ck.hu@mediatek.com>, chunhui dai <chunhui.dai@mediatek.com>,
 linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 1/7] dt-bindings: mediatek: hdmi-phy: Add compatible for mt8167
Date: Sat, 10 Oct 2026 13:54:01 +0200
Message-ID: <20261010115539.9237-2-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261010115539.9237-1-l.scorcia@gmail.com>
References: <20261010115539.9237-1-l.scorcia@gmail.com>
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

The hdmi-phy for the MediaTek mt8167 SoC is not compatible with any of
the existing hdmi-phy. Add a separate compatible to describe it.

Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
---
 Documentation/devicetree/bindings/phy/mediatek,hdmi-phy.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/phy/mediatek,hdmi-phy.yaml b/Documentation/devicetree/bindings/phy/mediatek,hdmi-phy.yaml
index ac93069f4801..f0c8ea2c72b1 100644
--- a/Documentation/devicetree/bindings/phy/mediatek,hdmi-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/mediatek,hdmi-phy.yaml
@@ -31,6 +31,7 @@ properties:
               - mediatek,mt8188-hdmi-phy
           - const: mediatek,mt8195-hdmi-phy
       - const: mediatek,mt2701-hdmi-phy
+      - const: mediatek,mt8167-hdmi-phy
       - const: mediatek,mt8173-hdmi-phy
       - const: mediatek,mt8195-hdmi-phy
 
-- 
2.43.0

