Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B033606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 08:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256 header.s=2025a header.b=NKiQWi6G
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8442E112817;
	Fri, 27 Nov 2026 08:29:10 +0000 (UTC)
Received: from www.nmnhosting.com (watt.d-silva.org [119.15.109.137])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D785810E00C
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 08:13:26 +0000 (UTC)
Received: from Hawking.lan (hawking.lan [10.0.1.4])
 by www.nmnhosting.com (Postfix) with ESMTP id 2D6D74C972;
 Fri, 27 Nov 2026 19:06:49 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=d-silva.org; s=2025a; 
 t=1795766809;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=gvWBA1mhx8ibYVBggwemKsSLz8VkwDf35wvv7VpFuF4=;
 b=NKiQWi6GIrzDGR2pthCqjgdeHpEK1h48kycZnGQ7Ij9HtRGZZYqaQzFhr33YzIhXsi1wtz
 Hrb3hB6WyphdOfO4PgxapHCaxHo4CpfbhEYOPBZoKuJBa9aZNXnsV/ljO+tPh2cTY/z6px
 ZdnS0wSCDQOPZihsbANHOh0Nyb40lS3tWMWiALnJrcQsB4VydiV4h3H1rV6EuJQ1hNtuUX
 HcFoKpCA2XAkHSBIa34g6fCWIQFwDQxpX2+Jk7pqaneaEMiu9Dz6/7NlRykG5OtEE4/eN5
 wB7z1OQGZNxmcuAsT/zGrX5JHiikTexn8pVu91UgyrPGXTvlUmbMzUvjI848ow==
X-GPT-Reason: legitimate; the message is a technical software patch
 for the Linux kernel, which is consistent with the personal mailbox
 of a developer (alastair@d-silva.org); the sender domain matches
 the recipient domain; the links provided point to the well-known
 kernel.org mailing list platform; there are no markers of marketing,
 phishing, or urgency.
From: Alastair D'Silva <alastair@d-silva.org>
To: Hans de Goede <hansg@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, Alastair D'Silva <alastair@d-silva.org>
Subject: [PATCH 0/3] arm64: dts: allwinner: sun60i-a733: Add simplefb HDMI
 support
Date: Fri, 27 Nov 2026 19:06:46 +1100
Message-ID: <20261127080649.1982883-1-alastair@d-silva.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 27 Nov 2026 08:29:09 +0000
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series adds boot-time simplefb HDMI support for Allwinner A733
(sun60i-a733). U-Boot enables DE3.5, TCON_TV0, and DW-HDMI2.0 and
updates the disabled /chosen/framebuffer-hdmi node. Linux keeps the
display clocks and PCK-600 power domains active across boot.

Tested on Xunlong OrangePi 4 Pro, based on:
  [PATCH 0/3] arm64: dts: allwinner: Add Xunlong OrangePi 4 Pro support
  https://lore.kernel.org/r/20261125124407.4098345-1-alastair@d-silva.org
  [PATCH] pmdomain: sunxi: pck600: Initialize pd->pck in probe
  https://lore.kernel.org/r/20261127080625.1982574-1-alastair@d-silva.org

Alastair D'Silva (3):
  dt-bindings: display: simple-framebuffer: Add Allwinner DE3.5 HDMI
    pipeline
  arm64: dts: allwinner: sun60i-a733: Add PCK-600 power domain
    controller
  arm64: dts: allwinner: sun60i-a733: Add simplefb HDMI node

 .../bindings/display/simple-framebuffer.yaml  |  1 +
 .../arm64/boot/dts/allwinner/sun60i-a733.dtsi | 36 +++++++++++++++++++
 2 files changed, 37 insertions(+)

prerequisite-patch-id: 309a5a3ca5b216915907263dea7024263abf1d1c
prerequisite-patch-id: 55e543b9854c7ae2fa86969233d05ccadd3792e9
prerequisite-patch-id: cfcad85224e288ec2168e7f245b4a1c63e9a34a7
-- 
2.53.0

