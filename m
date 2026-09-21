Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49DF3C982ED
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 11:39:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CA7D10E404;
	Mon, 21 Sep 2026 11:39:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GyOpsBhq";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EAB610E39D
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 11:39:29 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49b912d822dso19700695e9.2
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 04:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789990767; x=1790595567; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AqNF5JZ6UPtOMyOPCzIVZh05aJF/SoOQw4MLana8W40=;
 b=GyOpsBhqKcXvtKHvU/57UA714D+5m6FNY7l/swTdaY2nrHKKLNPZBiimbld0M8fsu7
 kg4hRf+gjwepN/Lsx66M6IxO3z959Oy6R7+yc7kchvJZO22H+iqX8T7njNW/27evd/MQ
 J3Z/2skuP3KGI33UDm1cTPpjHZYX00w3RTfFyYa7t07ULeuKz9UBA2yvrmhVEMMPTVPz
 KKYgHsvD2z+CinReXUFg1L35kdZSrpzNJet+qo4cN5TpQAmlcIT80OeNEXDjK/oMb+Gp
 4KZeSdmaJmiQ+8VGapi0Tx5NfuKmvOG/ItyP6efwbY23PSz6e4V8pqOVLdSTaDIJngtU
 idaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789990767; x=1790595567;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=AqNF5JZ6UPtOMyOPCzIVZh05aJF/SoOQw4MLana8W40=;
 b=xW/8SmocrlXR2CC80u530KXGoB5TiHRg0wbYxea+WdVyzB3fQnkkOcbnfpS/hE6fTz
 kJsg3+V/Gy9t5hpEZBvkKxgQnUGAPgTzS2Y8trjBVSPUMKIuPX8ajkptcZl9mNXkb1Za
 xrvlC/jphrEL/8GeX0nsDkdGmss5sMCw/UvknP2oFHnczcNsZ9o5YaLLo2dbOSkQ0L7H
 pIA7HQd7BKDI1kctHdquI5R9KfFW1ePFu4TSNTReAXK7KxTIoQIPu7QaqWNG7GtLZnWm
 rotmFpKed9RpyDlMhJTA2jISWasLrR4v7ho5/BC5fv1D62nxEF22ZvZrJnlrZFb4bolS
 saXw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzRdrKxtVujgRlkhve1E2CwgFe4fr8Yfn9p31lvle09Trv1MMuaiqxrxFMH0jjjrMZs4Vn6Z/JhTG4=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nItLvprs4kDnC0zAAU+g1v0pPLP+AGAaXJf4ga8uzbZOo45C1i
 CQO9mqanhj4CXfTvlaeiL1YHFTzkMTEXmxVQLZuRV7u+F5wKlxEeoPHa
X-Gm-Gg: AYBFou3jUCaH7pFvYS++Om7JibgYVQzGdrJIROet9Q0UknSYj3ggvV2Vr9qr0cFSW1X
 Ju21vhj9b8IZZISOmWrjO9wu3gp4rtuX5Nn4UF4Wi9DEVToG5OT5ZOXoaawnGBe3Z9PhZNi+ANI
 kdCxDwhWtsPw/jkN9MVv/2ls+qnzBn7BHUHt6vfLs2YmG/WGJPyWjdlpT0R74LzQzVkIG6hWBZM
 vToo5Z+VLE9ULFKNvIC1e8rsBXftUMOGuS043bgFdiltLN5L1VT2JwJGu7VNqdTj0vcfV+vvoBJ
 sEoXpmfI7ZDPmywNFtyO+i6r0VVx/qc0EFdg3Pp4UXvPGcH/ZUPK5DCl+xTZ9DFrxlt5tt3u9Ey
 8/qGEkkjt6sBugTMvIek8+nEVVe+NUW5Z87zFfvl9Gf4UfAOOgGZK8t4qmU0lat/afnhD2iQtFu
 8d0gYSib4lv3rwNkPm1i+9kMvQ+4AuyVfl+33dx7mmc8cWl9qffOa2Mu79y5HmvjYliW8=
X-Received: by 2002:a05:600c:1c05:b0:49c:edfa:15a with SMTP id
 5b1f17b1804b1-49fc56af038mr172418205e9.13.1789990767340; 
 Mon, 21 Sep 2026 04:39:27 -0700 (PDT)
Received: from luca-vm.lan ([154.61.61.58]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fc57547easm244273865e9.3.2026.09.21.04.39.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 04:39:26 -0700 (PDT)
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
To: linux-mediatek@lists.infradead.org
Cc: Luca Leonardo Scorcia <l.scorcia@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, CK Hu <ck.hu@mediatek.com>,
 Jitao shi <jitao.shi@mediatek.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/4] dt-bindings: display: mediatek: dpi: Add compatible
 for mt8167
Date: Mon, 21 Sep 2026 13:38:55 +0200
Message-ID: <20260921113914.779393-2-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260921113914.779393-1-l.scorcia@gmail.com>
References: <20260921113914.779393-1-l.scorcia@gmail.com>
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
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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

