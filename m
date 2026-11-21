Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2FB606A683
	for <dri-devel@archiver.kernel.org>; Sat, 21 Nov 2026 07:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A+RFDYxG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA77110E2DF;
	Sat, 21 Nov 2026 07:41:19 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66C5310E280
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Nov 2026 07:41:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 421B644762;
 Sat, 21 Nov 2026 07:41:00 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1795246860;
 b=xTmTV1e9JU8hg6am2tdW6yK3zYoR/T02K87Q9dxV46hX7rcVhjYgIFz/7/qhOs4ACQC2
 DC+7JAurKbKY1s6K51xvk7155sNmw0DHxdhrrGW+4KNOBPkVuc1QMBYUt/uRtfPZmZrFb
 tsV8SWcqkbeQz01X7/eHWPWnWrZasJeWx1tRM81y0o3XxWuMXPZZXlUz/jOzD130g0qKM
 1Ws+7UAToBojYCDFAIgmSymFhzOBBOtes76v1PRBuvPQyzTx2yAWHRS7FscQLSM8vcgda
 ZVs6RlegsWRFdYgP98zHYdqUEPMjGn2Lcqxix8IjMLSOR9fqnDL7evGkgKKQ8TJmQgQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1795246860;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=dD3U3VJ0FLwjWCOccbxRQVK0W5Z5sFcV/hEtgh6x+kc=;
 b=rY6gtoT/qcbVKg73UXWBouMpaYVZ0QK4sgFq6UB2D6xjWsieDzXK/oKKJN9+i+rJiGBJ
 tNWgwf5YYMqIpGVJ3Wm/og3kCFvoNyw/f2GKZM2F6IKDq82HbPfOefQs90fig38j6TT+F
 fK9rWlGGFcuw5J5ly07v1Z1b94aPkdf7P6IGCJzipIZwcQTEEORhetS0wduYBz6K6IUrw
 bZCTwI2g4tRsHHRVZQOjceL1etqLfIobIaxuiQtyO9q7D7vNvvWpqAwtEFC9W9e0N2PIh
 L/gyiX+9DrtXq7LBtGf8PZay/xLPe7/82gRUx9t8kTgNM2kKwVzdh+GhjC0SxHNlOVQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id B38BC1F000C4;
 Sat, 21 Nov 2026 07:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795246860;
 bh=dD3U3VJ0FLwjWCOccbxRQVK0W5Z5sFcV/hEtgh6x+kc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=A+RFDYxGX6Ebv2IlkR0hX/qZByf2M9n2xbvI8JwZHs2KVIcU5GW5h4NikapeBwU97
 Q93iIjscaGTp7/kpNcw4h6j1w6kx6l+ml0+PVLgeePdaaj8O2JujeGy9g5wNmtDFpv
 MNuzfREW4cS7PgfkbIwc25CaDM2D3TNgBKP75PK/N4RwtbctzeZAXNxEnMIZoNDMKV
 vUKx3lf2m0iYgSXk55vrOB7kOJ+bZ3QwgqGNVhTMtCD3fe8eGVDHYxGcTycroPaj7c
 VfiqPJfONaat+DrkI/uZe88s1zN/CYF1+UbQCy/JIvlz2VArami1P8lFbxpuhXslWK
 EOVcjLwZ8iOPg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id C49864BB7C;
 Sat, 21 Nov 2026 07:40:51 +0000 (UTC)
From: Cody Kang via B4 Relay <devnull+codykang.hk.gmail.com@kernel.org>
Date: Sat, 21 Nov 2026 15:40:52 +0800
Subject: [PATCH v3 13/17] MAINTAINERS: add SpacemiT K3 display driver entry
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261121-k3-display-v3-13-ec419e8e96b8@gmail.com>
References: <20261121-k3-display-v3-0-ec419e8e96b8@gmail.com>
In-Reply-To: <20261121-k3-display-v3-0-ec419e8e96b8@gmail.com>
To: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>, 
 Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Haylen Chu <heylenay@4d2.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Yao Zi <me@ziyao.cc>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
 Guodong Xu <docular.xu@gmail.com>, Icenowy Zheng <uwu@icenowy.me>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, 
 Sarah Emery <sarah.emery@canonical.com>, 
 Ze Huang <ze.huang@oss.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>
Cc: Cody Kang <codykang@vsit.ai>, dri-devel@lists.freedesktop.org, 
 linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-phy@lists.infradead.org, linux-clk@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795246844; l=1102;
 i=codykang.hk@gmail.com; s=codykang; h=from:subject:message-id;
 bh=oWc1H4pmsBmZYdMOwC23Iy029t50E36ETbDmNN8OobA=;
 b=8phbJzxo2F4pIjhm7/H/IFSNkGvHl2q5ufpXX7AW27o0KGGChs8nwpGibEUdrtI+wZQxb3qKJ
 BYJEc/LqD8hC2Xt/avWtv+biYLQ6rxBTDDwkAKF8qa/ovGe8SayHrBO
X-Developer-Key: i=codykang.hk@gmail.com; a=ed25519;
 pk=Osn6/cs9Su/mHHw4P19cmVc3v2FMQfiWahjsN0vEkuk=
X-Endpoint-Received: by B4 Relay for codykang.hk@gmail.com/codykang with
 auth_id=895
X-Original-From: Cody Kang <codykang.hk@gmail.com>
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
Reply-To: codykang.hk@gmail.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Cody Kang <codykang@vsit.ai>

Cover the Saturn DPU, the Innosilicon DP/eDP controller, the DP PHY and
their bindings.

Signed-off-by: Cody Kang <codykang@vsit.ai>

---
v3:
- add Guodong Xu as maintainer
- list Cody Kang with the vsit.ai address
v2:
- no change
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 93abbb315065d..7bba82e8cc810 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26364,6 +26364,17 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/sound/spacemit,k1-i2s.yaml
 F:	sound/soc/spacemit/k1_i2s.c
 
+SPACEMIT K3 DISPLAY DRIVER
+M:	Cody Kang <codykang@vsit.ai>
+M:	Guodong Xu <docular.xu@gmail.com>
+L:	dri-devel@lists.freedesktop.org
+L:	linux-riscv@lists.infradead.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/display/spacemit/
+F:	Documentation/devicetree/bindings/phy/spacemit,k3-inno-dp-phy.yaml
+F:	drivers/gpu/drm/spacemit/
+F:	drivers/phy/spacemit/phy-k3-inno-dp.c
+
 SPACEMIT RESET CONTROLLER DRIVER
 M:	Guodong Xu <docular.xu@gmail.com>
 L:	linux-riscv@lists.infradead.org

-- 
2.43.0


