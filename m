Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C88F60A262D
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 07:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=UdMGDM4P
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31FF7112009;
	Thu, 29 Oct 2026 07:54:31 +0000 (UTC)
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1E6810E7AF
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 07:54:16 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20261029075415euoutp0185c659f8c9de1127a57dcf2a266b8273~i8OIaeROp1376213762euoutp01K;
 Thu, 29 Oct 2026 07:54:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20261029075415euoutp0185c659f8c9de1127a57dcf2a266b8273~i8OIaeROp1376213762euoutp01K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1793260455;
 bh=0x/ib8fUpEpZHz4lKpHrAV/kz/EdxwB2rIQ8auiIhVw=;
 h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
 b=UdMGDM4PG0k/eiUkxh2xBVW89112OQTd/sx8AkMGX1BdtJHhZwahEAzpdHvW/DTQb
 PIEJ0dky4Jcl0YJE4j6jyxUxhohyhpJfwdCHS872GB+xBh1NyJT0yo61cqHAP3r00l
 NiDmacGL9QgKkcrbaE2KadiP8LUDFKF62ef71bds=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20261029075415eucas1p26b5dc6a09999a8b85cbf3b7d333f74df~i8OIMgC9l2999729997eucas1p2C;
 Thu, 29 Oct 2026 07:54:15 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
 [106.210.136.40]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20261029075413eusmtip10e44d6bd1b77da0c8e347b833c9a6c94~i8OGhEBw01493914939eusmtip1X;
 Thu, 29 Oct 2026 07:54:13 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Thu, 29 Oct 2026 08:53:47 +0100
Subject: [PATCH v6 13/18] drm/bridge: inno-hdmi: Make the register clock
 source selectable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-jh7110-clean-send-v6-13-759594e43acf@samsung.com>
In-Reply-To: <20261029-jh7110-clean-send-v6-0-759594e43acf@samsung.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,  Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,  Andrzej Hajda
 <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,  Laurent Pinchart
 <Laurent.pinchart@ideasonboard.com>,  Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,  Luca Ceresoli
 <luca.ceresoli@bootlin.com>,  Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>,  Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,  Philipp Zabel
 <p.zabel@pengutronix.de>,  Emil Renner Berthing <kernel@esmil.dk>,  Hal Feng
 <hal.feng@starfivetech.com>, Heiko Stuebner <heiko@sntech.de>,  Paul
 Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,  Albert Ou
 <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,  Dominique
 Belhachemi <db@domibel.de>, Andy Yan <andyshrk@163.com>,  David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,  Yakir Yang
 <kuankuan.y@gmail.com>,  Dmitry Baryshkov
 <dmitry.baryshkov@oss.qualcomm.com>,  Michal Wilczynski
 <m.wilczynski@samsung.com>,  Conor Dooley <conor@kernel.org>, William Qiu
 <william.qiu@starfivetech.com>,  Xingyu Wu <xingyu.wu@starfivetech.com>,
 Sandy Huang <hjc@rock-chips.com>,  Manivannan Sadhasivam <mani@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-riscv@lists.infradead.org,  Marek
 Szyprowski <m.szyprowski@samsung.com>,  Maud Spierings
 <maud_spierings@murena.io>,  Graham Markall <hello@big-grey.co.uk>,  Icenowy
 Zheng <zhengxingda@iscas.ac.cn>,  Chaoyi Chen <chaoyi.chen@rock-chips.com>, 
 Joshua Peisach <jpeisach@ubuntu.com>,  =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@baylibre.com>,  Byron Stanoszek <gandalf@winds.org>,
 OOHehir <oo.hehir@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2568;
 i=m.wilczynski@samsung.com; h=from:subject:message-id;
 bh=ENbT5MqD6u1W62Oz71sCSUWLLuPe7fD1cnUumjHr39U=;
 b=owGbwMvMwCGWumv6zndzRCIZT6slMWQ9+t3DGHWilv+F5MND2Zee6nZN3sQvn3DlmSan0Rduv
 r0JLz5e6ihlYRDjYJAVU2Q5uzHaSPIfw9Py449/wcxhZQIZwsDFKQAT+XKSkeHAjODy+FZp57Y3
 PBrdZW7hV+syJZ/2zrw9ZzaD2dOziSsY/op+bTl9ie8l79fuAgm1i2mPV03/8N9OsWXzaZfIiat
 NVvADAA==
X-Developer-Key: i=m.wilczynski@samsung.com; a=openpgp;
 fpr=CDB15B3219FE00E577C7E3FA65BA97B9EE9C1459
X-CMS-MailID: 20261029075415eucas1p26b5dc6a09999a8b85cbf3b7d333f74df
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261029075415eucas1p26b5dc6a09999a8b85cbf3b7d333f74df
X-EPHeader: CA
X-CMS-RootMailID: 20261029075415eucas1p26b5dc6a09999a8b85cbf3b7d333f74df
References: <20261029-jh7110-clean-send-v6-0-759594e43acf@samsung.com>
 <CGME20261029075415eucas1p26b5dc6a09999a8b85cbf3b7d333f74df@eucas1p2.samsung.com>
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

inno_hdmi_init_hw() drives the register interface from the system clock
on every platform, by setting v_REG_CLK_SOURCE_SYS unconditionally in
HDMI_SYS_CTRL.

That is not right everywhere. On the JH7110 a Framework 13 (fml13v01)
panel flickers continuously with the system clock selected and behaves
once the TMDS clock drives the register interface instead. Maud Spierings
found this by diffing HDMI_SYS_CTRL against the StarFive vendor kernel,
which leaves the bit clear.

Add a plat_data flag for it rather than changing the bit for everyone.
The Rockchip integrations keep the system clock, so this is a no-op for
them; only a platform that asks for it gets the TMDS clock.

Reported-by: Maud Spierings <maud_spierings@murena.io>
Closes: https://lore.kernel.org/all/e780ecb8-918f-4816-99c8-b69b10b25a18@murena.io/
Tested-by: Maud Spierings <maud_spierings@murena.io>
Tested-by: Byron Stanoszek <gandalf@winds.org>
Tested-by: OOHehir <oo.hehir@gmail.com>
Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 drivers/gpu/drm/bridge/inno-hdmi.c | 4 +++-
 include/drm/bridge/inno_hdmi.h     | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/inno-hdmi.c b/drivers/gpu/drm/bridge/inno-hdmi.c
index 42a3cd450e0f56a0b06d187645522624feb8918d..66e7e08f89813b4ddcb38a3d0b296132944f06bb 100644
--- a/drivers/gpu/drm/bridge/inno-hdmi.c
+++ b/drivers/gpu/drm/bridge/inno-hdmi.c
@@ -580,7 +580,9 @@ static void inno_hdmi_init_hw(struct inno_hdmi *hdmi)
 	usleep_range(100, 150);
 
 	msk = m_REG_CLK_INV | m_REG_CLK_SOURCE | m_POWER | m_INT_POL;
-	val = v_REG_CLK_INV | v_REG_CLK_SOURCE_SYS | v_PWR_ON | v_INT_POL_HIGH;
+	val = v_REG_CLK_INV | v_PWR_ON | v_INT_POL_HIGH;
+	val |= hdmi->plat_data->reg_clk_source_tmds ? v_REG_CLK_SOURCE_TMDS :
+						      v_REG_CLK_SOURCE_SYS;
 	hdmi_modb(hdmi, HDMI_SYS_CTRL, msk, val);
 
 	inno_hdmi_standby(hdmi);
diff --git a/include/drm/bridge/inno_hdmi.h b/include/drm/bridge/inno_hdmi.h
index 790633fcea97a6b9840da7b19a0c0b0d7271fb83..cc5099d05f641eef5de91ed5becde7337c04b013 100644
--- a/include/drm/bridge/inno_hdmi.h
+++ b/include/drm/bridge/inno_hdmi.h
@@ -32,6 +32,8 @@ struct inno_hdmi_plat_data {
 	const struct inno_hdmi_plat_ops *ops;
 	struct inno_hdmi_phy_config *phy_configs;
 	struct inno_hdmi_phy_config *default_phy_config;
+	/* Clock the register interface from the TMDS clock, not the system clock. */
+	bool reg_clk_source_tmds;
 };
 
 struct inno_hdmi *inno_hdmi_bind(struct platform_device *pdev,

-- 
2.34.1

