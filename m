Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC590606A32D
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 08:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cqrQ97ra
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BDFF10E7AB;
	Mon, 23 Nov 2026 08:59:01 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC73E10E7CE
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 08:58:54 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4a210470b49so28273155e9.2
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 00:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795424333; x=1796029133; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Fw/YKdGx/bEJxv6m8dJuQDKu0hTKbF1u6pYTLgihK3c=;
 b=cqrQ97ra1N93dx5JmBmFIFKx3Qjl1QxqjFdBpNdkkCdZIXfB6AfAKHN0akF8rthCXg
 Qhus+EflmgF4QXgzlRed5Zq9Jr9SNLcmaHuYVNvlDEQkZtNEdbcjxc2doippiPD+ii+O
 BcAT9eqt3vA/XQ9FIXZFfMCAzdzSROmyAmdf2NCVCkr1zkOP3r3b9NoI+wIV8Tdkmwyb
 ycLofz92sdfcOwNA1pStM4kgOhrXRFzpkRVFAu+nsh+EnioV4fqBkvglmHJVKSUrynT6
 GcytKfpYkY08ZnXkA0YgzYEXVQ7sq8ELm25DoMftzaxAcmKDuiolbyn9AR2+cP7LLgPI
 P3iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795424333; x=1796029133;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Fw/YKdGx/bEJxv6m8dJuQDKu0hTKbF1u6pYTLgihK3c=;
 b=Iro+3eauaYEnkqAf3vKaX0ny1zBhkLx+c9wF/3HPG4Lejle1T+CpMl2qwnx5vnt/KZ
 1KnCn+BP7FS9URGMlJCDZd/6XlqQaJDJqTsP1mIAXlu61zmrZHxztoCj2D/iF5q2vNNd
 SN0Sx6YLUqO4aWMnh6aV4uyJ2CD+mmWQIb5PtGd6i9BraBzm3SGMpopW9qOb2trA9vwM
 +Xv7c0Nb9VHXLgR1O43nW1K5FljgJdUUsi54hqLAVzTvBP5r5Y558LAK+8OLPlFDdvZG
 ZGF0DmEjJbsWOdikCs5s23PlwAhMpdV+Zo4dtNlPsa+y2miF/4UqMt0ZKz591PsMfPMp
 IXMw==
X-Forwarded-Encrypted: i=1;
 AL+hErG+ETeWqFJaS5JwItpcm4OehQG3WRMWIi8riCzW2JOrlic0xIyvVVPwP4TR55fEQ+QE8WriCaireGo=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/qpqy5w2NUiMqwuXkfj5aEUfSE3d+ra/iNUqPD60hzVb5gFfLQ
 +VLN9cFhR6c8H1Lvb6RsPPFHXG89U/GY+XxZI0JbNcGT8TuMpP2qGid7
X-Gm-Gg: AZFdTZcSEGghMcZaOOnOkyARt1idOkhfMuvNKwg176GOzclfuv3zyRmfchxzj0dMsD2
 bgviCpplQAb6Ee9ZGJrXgEq+D9mCjssXMzaxo8qYOCiVC7u+jMIG8dOABo3aEuyBYRYIqSKtJFf
 x7HeNmcwNfQLDlHZV/9hddRul5ggJQazE0Ha1kRXxQ7Qz3u427neRq11fIPckQMbxiUcpNgivjm
 QLLvlQQQc+tl/ih2A3nDctVbc3vHOb/U+vPot4Hp+1gr32VPuKHWhkL50bVLFlMXaZqWdn4OQ6X
 pROC32OOIdpzXSHDJXqqGXwn6y4d/EpTHCmFzqTybMlkM7HSksnZETwLRVmhODp1iTNB1dlvuxS
 fQV9XudCrOZCp7+GqMpHpdkvnwuXnRbjaLYKBK8Low8NVyBplnSf9u2SZOh80h/vhz0+xA1q2Pi
 kOzMYbGdPr/o63rwnCcCCqVXhpnxwCN1n4UWMEQi5TvNH72Veti/R6i945HqV3fmEa5qBKtqnoF
 rq8M2lUiOHjpJyxDdSIdBeir8d8RuSRLzvABS/nTrVYAfasQjanbNWpX5+kf5DYU8kwXegswdnl
 7nWpInZEanviiWPxRQEOzhHFgg==
X-Received: by 2002:a05:600c:190d:b0:4ba:2bfc:c8b5 with SMTP id
 5b1f17b1804b1-4bb888267aemr217464265e9.10.1795424332866; 
 Mon, 23 Nov 2026 00:58:52 -0800 (PST)
Received: from luca-vm.lan ([154.61.61.58]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853b216esm375960755e9.12.2026.11.23.00.58.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 00:58:52 -0800 (PST)
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
To: linux-mediatek@lists.infradead.org
Cc: Luca Leonardo Scorcia <l.scorcia@gmail.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 CK Hu <ck.hu@mediatek.com>, Jitao shi <jitao.shi@mediatek.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/2] arm64: dts: mediatek: mt8167: Add DRM nodes
Date: Mon, 23 Nov 2026 09:57:53 +0100
Message-ID: <20261123085840.8687-1-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series adds support for the main display pipeline on the MediaTek
mt8167 SoC.

The driver bits have already been applied in CK Hu drm-next branch,
together with the first patch of this series regarding the DPI block DT
binding. I am including the latter again in this series because it was
un-acked by DT maintainers last week due to the addition of un-documented
alias section [1]. Those aliases are currently required by the driver to
drive the secondary (external) display pipeline, but the main display
pipeline does not require them and they can be safely omitted.

In version v2 I removed the nodes related to the secondary display pipeline
to add display support for 90% of the devices that only use the main
display pipeline while an acceptable alternative to aliases is devised.

The series has been tested on Xiaomi Mi Smart Clock (X04G), Lenovo Smart
Clock 2 (CD-24502F), Lenovo Tab Essential 7 (TB-7104F).

Changes in v2:
- Removed the secondary pipeline nodes (rdma1, dpi1);
- Removed the aliases block;
- Implemented the complete OF graph for the main pipeline, using the same
  path that is currently hardcoded fallback in DRM driver code (output to
  DSI display). This improves backward compatibility for the upstream
  mt8167 Pumpkin board.

v1: [2]

[1] https://lore.kernel.org/linux-mediatek/bbefcf0b-b31e-4f74-bf79-b0ccc983f62b@kernel.org/
[2] https://lore.kernel.org/linux-mediatek/20261117122802.728987-1-l.scorcia@gmail.com/

Luca Leonardo Scorcia (2):
  dt-bindings: display: mediatek: dpi: Add compatible for mt8167
  arm64: dts: mediatek: mt8167: Add DRM nodes for primary display path

 .../display/mediatek/mediatek,dpi.yaml        |   1 +
 arch/arm64/boot/dts/mediatek/mt8167.dtsi      | 297 ++++++++++++++++++
 2 files changed, 298 insertions(+)

-- 
2.43.0

