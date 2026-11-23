Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A921606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 08:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kMZyWL+x
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73E9710E79C;
	Mon, 23 Nov 2026 08:59:06 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2425C10E79C
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 08:58:56 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4bb6ba3b244so28752065e9.3
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 00:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795424334; x=1796029134; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=s8y1Uqc1mwCpun1OXoOsJDUzZaLNzgAL1GBXFJFqXhk=;
 b=kMZyWL+x1rHr3UOK0/Hrt1p6zhauioCB0dUWvJxktXswJiBPQthRQJGWfxUtwsJ3sv
 As3onY1G4ThCHybWolijQ6p8MsbeBuwM5KnQEk77WVltlZNFtz86i6LOuFHP3y1WoVM8
 nIMSmSAmhrJBTqMWS/XrYYcxHtg2xabdyYG2tPOkCaKy/I31ELChBJij2kynpXFy6d7k
 uJnm5AWTrGNnvtV35+LDZt6VEN8mDMK/W4RrsmTEA28qhTYF/DJ6258/klUXDvY6NIMc
 jQWmRYIt4HavysYJKz5zh3uRG0u8Ww3+zww+tpPCuexw/mBYpnIlM+Z2/EC9fxpyDfGU
 xEbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795424334; x=1796029134;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=s8y1Uqc1mwCpun1OXoOsJDUzZaLNzgAL1GBXFJFqXhk=;
 b=siQ1PBUwrpNPmVkGqOf8rFw5GCq2luL34ld85SEViS46hAmU+uNM3JBj6GAaBU99fX
 eGh1W8j9WDi/iery4kAL4jLGdl4+WpnpF4UBwmoIfebw52JAYJBZju03mBDIKiIEEfoD
 jdrhbB2R9SKry5uVfpLEw0XK5jWZHrmqpUU4K1UVSJ9Z2A8CVVs6kY6t3GF+wlJ050oJ
 6RRPKXI5Gj83ayKuppxf92WE07jcK1Re9musNwMfg6BKc4zFXHtcNZaYY9D4hazEDt1F
 WpR1L9UZNcZBexPMfosWYm2LRMT6CF1QtNkhyJDEk4Kyy40MPVMGiVprUV85V8xQF65q
 ldRA==
X-Forwarded-Encrypted: i=1;
 AL+hErFHQD/QDYLWpvFliE9CLsEhBUnqg68t9KvdxZ64ugLspJ2IL/CPSTiqzSPdEv5i3dKJU4pjHrYRX7c=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8ES8B3KORVUrBrbXFwjZaLscG2TNYVs9ZeNWbdMJO8umvkRswz
 PUSfc59t6iDUfgD6TIM5ojVqhFJrm98oQ2in9pBEX/EG5zeINNQmtQdw
X-Gm-Gg: AZFdTZdVjU3ykXZoHlyzX5RMpsgBFqrO5MgGOEJWbgVoG+8oC1smigx8xqJqVixL/B/
 cyxJTWhC62xUvExsDjJpgOz/qmszR/GyKundDq+6M2InGzMEN8d38Zskzd37Sw1elNzzmh5rXpH
 DicDTKdxgzw3o7XIkSL4+lf7PHBkbgl5xHe9wQszYN4/+KpBv0tUpTE+uU1bomrRgbLPDygkMjO
 mgfRms1p6n5tngpsAhGhWvziwVViVngyrTi9VcJN9t77vHR7D9bUhMHvRKjLV9THTj4HluMBy9Q
 XIfWDS+JJw8U31TceOo7b9PyypYMkUzlyjF9oQ92xDiGHPA9Jgmo7ybMxQIYRIxnfBlw1hyQi3d
 jnfDyh6IfLwATawYFOLIgMV2Pds4XEpqRvH3VmunSnFRKFPTGd7Z2qavOvpNGwdn31WJ8smuJTf
 e8lQWezl2VnPCLjI3j6PTdTHuN7q6BbCD8et2eZOGjQIfcG6KEj1HleKx5NYXRJP2ygz4YacAiA
 2I0pEGuCAC/ELUKvWNsX1o9XjiGjxgw885VAxqJGoKKh1S2aGtghxLz3VGshN5pHmG3lUb+1h14
 q2k5VfDtMRaCdrlmQAzHPgZs
X-Received: by 2002:a05:600c:4514:b0:4bb:6823:3d3c with SMTP id
 5b1f17b1804b1-4bb888169d0mr234585905e9.20.1795424334315; 
 Mon, 23 Nov 2026 00:58:54 -0800 (PST)
Received: from luca-vm.lan ([154.61.61.58]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853b216esm375960755e9.12.2026.11.23.00.58.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 00:58:53 -0800 (PST)
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
To: linux-mediatek@lists.infradead.org
Cc: Luca Leonardo Scorcia <l.scorcia@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, CK Hu <ck.hu@mediatek.com>,
 Jitao shi <jitao.shi@mediatek.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/2] dt-bindings: display: mediatek: dpi: Add compatible
 for mt8167
Date: Mon, 23 Nov 2026 09:57:54 +0100
Message-ID: <20261123085840.8687-2-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261123085840.8687-1-l.scorcia@gmail.com>
References: <20261123085840.8687-1-l.scorcia@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

MediaTek mt8167 SoC has two Digital Parallel Interface (DPI) blocks,
one can be routed to a DPI display while the other is wired to the HDMI
block. They are not compatible with any other device, so add a new
compatible to describe them in the device tree.

Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
This patch is resubmitted due to the un-ACK of the previous iteration by
DT maintainers, because of the addition of undocumented aliases in the
SoC dtsi changes. Those aliases have been removed in this iteration as
they are not necessary to drive the main display pipeline.

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

