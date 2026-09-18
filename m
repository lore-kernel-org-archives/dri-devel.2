Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59633C982D8
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 17:57:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FEE810E974;
	Fri, 18 Sep 2026 17:57:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bDB6fRu/";
	dkim-atps=neutral
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com
 [74.125.225.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FCD910E215
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 17:57:49 +0000 (UTC)
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-482f6356f6bso835410f8f.2
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 10:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789754268; x=1790359068; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1OQlNCcXAkK+hbxqoynuSjH/ynOWBUHLK9W984JsgL8=;
 b=bDB6fRu/0oNbNTFGi06dHnLuyKZ5egFoiwBtFsuaaa5jA4t1uNQ8yHErxzafHVKjZa
 l8tDsMNN0QTeheytGBSqbkmnoA3IanSx70qchNYwQXfcJKTTX9ty+F/9u9/0/hHnz1vV
 p/SOi2abkrxMl1sma5/AeWQAslLPEzBoPufW7C4+FJ5QaJ7klfrMGEmvQ5HSHs6cSPYN
 j+91MefFAytTxUIiRTyK5X71Hwg4FjfuI3c5uZREfTRY4Ltcx8lhoGxRKIqMlQrfoe7H
 ihoNFqqXRr0qriK8wOahqV0JsOwcMs5Z+PWA/Hsi3YTXsS6iHRrNWOQQs1TpMEBplibt
 +Xlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789754268; x=1790359068;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1OQlNCcXAkK+hbxqoynuSjH/ynOWBUHLK9W984JsgL8=;
 b=JjTOiBKb9fNyY9amKmdC38PkgGFdqTJ7jTVQmAxhhd26ym+IsHb/Hf6a+FCIrohtNT
 xMDsvo2wSj7/1HNUjgN1H4P9CgD2IDr1K7dwhnLDQruQuVaVwymA2wJ+lHpP3F6A+NYF
 z1b7a7P+Gsf0A9TwOeuZTYAqKL46yazGzuXVyfVWDw9aoICxl4V7VylOek1xujp9liOk
 0EopFe3ZGl/M4rJhtjpN75/pHVBN99ftKUUxibz5CIu9JjFQlfbLKZ0i9wP/iU4aCVvk
 uwPVfupnhvJEXl+tvoeyfsQmvFBWafagygfFjkrjMRW3XpXqiFQ4coQtXrkXutUJjJSA
 +dfg==
X-Forwarded-Encrypted: i=1;
 AKwUvByXiZN9sZ9rtoYXe35ZrqFXmox3aCkHylHPf2wMRCnNzbOk8BvLVrG4rdDzjTuXE7l3nLBt2BJz4Zk=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lVd0qwrlCVIgdIhuJLIVpUAzZTkmvZI3nMfCkMu6C9JmaB9hmG
 IJ8P3KdML6hIjKcv4voaac+Sueh+aza5fZaFhCcWZCeKghaNMYJfkR1m
X-Gm-Gg: AYBFou1LtUZIuglMgSW7H3w3Z6eI3iTMbJ1saljz6szY0TFJ4sTfvEhrAYgRFN8UuGB
 0UA4YDQ5fEC78t8lQzMrXm+e2mUGhoT84uk1pKLYq7URtdV1Bnm2/3yy5mbZ5pP78yo/kbRKX2j
 oWQh15JMrEvb7oMoGWN/ua/Wh4vgcLjjS09o/BmX3bYD721SsArLQjjMfqbeiaNpwBES2Go6OzA
 55yBibA5sIT5nprPokunkdO1FUBsszozfCWXlO/giqVSBUDfMAzPLTckZy1dDqbajJ3YRyHvaWI
 Fk0Mbwg4QkVO1pGEu7/iK82Z7TZWxpa7JPRanPFyzHpGmPaaD+4Hy3MG2kX3sqtwv4trqZeLI6Z
 6K+K1mc3AMty0h6o5MdJNmuYeGZF/cOnGH/ekisyh+wcHenUzt3mTn0uraHfYkgm9c/WnTmyBtT
 bQnxUQWnM3/Y1Rm5Qg9o5TvkHzS6kFi6TdHsSjdT6lWR9NwkjyKLlW70cPE0sAJi8mwvM=
X-Received: by 2002:a05:6000:1785:b0:486:f282:e66b with SMTP id
 ffacd0b85a97d-4871e20f97amr7779772f8f.2.1789754267647; 
 Fri, 18 Sep 2026 10:57:47 -0700 (PDT)
Received: from luca-vm.lan ([154.61.61.58]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48724562aebsm268461f8f.14.2026.09.18.10.57.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 10:57:47 -0700 (PDT)
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
To: linux-mediatek@lists.infradead.org
Cc: Luca Leonardo Scorcia <l.scorcia@gmail.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 CK Hu <ck.hu@mediatek.com>, Jitao shi <jitao.shi@mediatek.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/4] dt-bindings: display: mediatek: dpi: Add compatible for
 mt8167
Date: Fri, 18 Sep 2026 19:55:25 +0200
Message-ID: <20260918175736.355305-2-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260918175736.355305-1-l.scorcia@gmail.com>
References: <20260918175736.355305-1-l.scorcia@gmail.com>
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

MediaTek mt8167 SoC has two Digital Parallel Interface (DPI) blocks,
one can be routed to a DPI display while the other is wired to the HDMI
block. They are not compatible with any other device, so add a new
compatible to describe them in the device tree.

Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
---
 .../devicetree/bindings/display/mediatek/mediatek,dpi.yaml       | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
index eb4f276e8dc4..6cd96a5cd4ae 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
@@ -21,6 +21,7 @@ properties:
       - enum:
           - mediatek,mt2701-dpi
           - mediatek,mt7623-dpi
+          - mediatek,mt8167-dpi
           - mediatek,mt8173-dpi
           - mediatek,mt8183-dpi
           - mediatek,mt8186-dpi
-- 
2.43.0

