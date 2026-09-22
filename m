Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A163C98306
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 08:01:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED0C910E84D;
	Tue, 22 Sep 2026 08:01:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XAE+Z9PF";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3957C10E45B
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 08:01:34 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49d1331ce1bso2265855e9.3
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 01:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790064093; x=1790668893; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hGF28/ongkg1pjDH+01IcEm6dgrPiae6qX55Ok4Xvzs=;
 b=XAE+Z9PF0GtINVZpVH7ML9447K7vbaI37mGwpThbACVpntGYiYIwGn6NxXeDtcXT+V
 Iu8NCgDpJXWTBaEroRyx93NA4QORJ6v1oC8KgyrV2qig5aB/FZbCmpJuHTFioQeqMgU2
 S/RKoV/WoQ7itF0q0bELa7S1qHWOpR8i8kStop8QSLvc6AZbKZT0zWCvupeDmePXk/W1
 UF1ekgdFadltp90ZaC14JSsH/7H7ns3fjH/UceZJ4lpqptwCAL9XLs0ntPg5msynShao
 H89WBH9rtvSk/IUsrS2LNMzYnMHjAF2vPCGO3Qg0KaZB1ihLIGuYVYUbDbxYsfXKZCvM
 VRcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790064093; x=1790668893;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hGF28/ongkg1pjDH+01IcEm6dgrPiae6qX55Ok4Xvzs=;
 b=Xxhqlmczff1GW9ATd0O78vg45s9Yw1vvcwlPKypSOB2dF1luBFdnLaRIDzMV8heGJy
 gHXkQg81Kt0JFXWR5l5bGhjPFnZihTkdZCuslUVAhs98FWBO5avkUAj3SP5pI8EU4oCd
 Ka2Q/joDV3FEWos61ucapVNKUfVk7D9EurDhnEibUTxxOqkSvqOZhoI73bTRqPhsOVi1
 5s5q5NVt+4Oc9M5mChUZ6hinf9ds18bMntXfw1SMnj58XryRBMLINRHr/g3GsdXy9QsN
 qNEdabuZaJh/q6C4D+axmAQq3TBAuxlid7BaehLknv4vUWnaZJKkplkR3iyiySOShdwL
 5SJQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxAgLUHp7PMFIKVP25AHGxK79J04VuS1ljdJeCnzMhzsvzzXZaaEnQXcTU6Bajljc/6cMKwMQpoCUM=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lkt93IokOyIwjYK+emHEkhw+LqvuAkImkc3bWjzPKdXXk9cMHR
 +Ja4CCFHdRAWTGlbVC6Jtd6OVXWuyeIiE2DhsVXDkgdqIhyUWrTla1nX
X-Gm-Gg: AYBFou00YO9prbfcs4otRI0uL16pECCwhRTVoYRNS73rUsKO2TdIfeOrlVJ7bKqT22C
 /3hak3Iw1WJvlQWY8RAfex8MZIwKc+iNIqN1qQg3zV95p/gQ9imxBOcLqOHRqC8edirCUufI0vY
 SCHb4kiu4Sv3oRcJZ1uZZEG5WsEqL2lXU9Z92lPchl0zq25Y+NtFuD591O+jY+/cXcJpCYJ5yEx
 Nuu6fJ5LvPXppIQ3bn9gJF/SRQ2ocT4GxdVp+9KDhfWmx160Th8/Syfk9sXD1m9EnSqj928Lzwr
 9epXFlMm/7P3AAGsJuuRRzsFv+vAQ5K4RSym44lS3ysMgFNJHsfeKVjBfJ1UTi3tuYDUTBLDz7C
 W0Y+EsVUR9QdHOyliNAAhiDbRAYlmYL+ZSk9km7fTsD4X6p1OMbXaUPtnM9XsuCGpiqwd02K8jX
 X6YDC1k1KmYqkOM3nWavwvE+i0S9wEhUZf0oMC2I9/4GNSDKqK7rjHEu/wGYSkfe82nDj4lVyvE
 G3b6bZXJLso5UeBW+iZtghoeSePgBKxoJZqt3F+L9fKCxupoXp4JtuxF5Z4ajZRmqrqKVtd8oqf
 fVI=
X-Received: by 2002:a05:600c:3b99:b0:49e:6683:d227 with SMTP id
 5b1f17b1804b1-49fc7bbfe4bmr199176535e9.0.1790064092385; 
 Tue, 22 Sep 2026 01:01:32 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B80530056971C6280202175.dsl.pool.telekom.hu.
 [2001:4c4e:1b80:5300:5697:1c62:8020:2175])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fdaaf97e2sm18248625e9.2.2026.09.22.01.01.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 01:01:31 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Robert Foss <rfoss@kernel.org>, Sidong Yang <sidong.yang@furiosa.ai>,
 Diederik de Haas <diederik@cknow-tech.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Jiaxing Hu <gahing@gahingwoo.com>, Nicolas Dufresne <nicolas@ndufresne.ca>,
 Jonas Karlman <jonas@kwiboo.se>, Guangshuo Li <lgs201920130244@gmail.com>,
 =?UTF-8?q?H=C3=BCseyin=20BIYIK?= <boogiepop@gmx.com>,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Igor Paunovic <royalnet026@gmail.com>
Subject: [PATCH v2 05/11] accel/rocket: request the core clocks by name
Date: Tue, 22 Sep 2026 10:01:08 +0200
Message-ID: <20260922080114.44662-6-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922080114.44662-1-royalnet026@gmail.com>
References: <20260922080114.44662-1-royalnet026@gmail.com>
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

rocket_core_init() hands core->clks to devm_clk_bulk_get() without ever
setting the .id members. The rocket_core array is allocated with
devm_kcalloc() in rocket_device_init(), and rocket_probe() only fills in
.rdev, .dev and .index, so all four clk_bulk_data entries are requested
with a NULL con_id (unlike core->resets, whose ids are set a few lines
above).

clk_get(dev, NULL) ends up in of_clk_get_hw(np, 0, NULL), and
of_parse_clkspec() only consults "clock-names" when a name was passed,
so the index stays 0 for all four entries. Every entry therefore ends up
holding a handle to the *first* clock of the DT "clocks" property, i.e.
ACLK_NPUn. Nothing fails: probe succeeds and the driver believes it owns
four different clocks.

The consequence is that rocket_device_runtime_resume() prepares and
enables the AXI clock four times, while hclk, pclk and - most
importantly - the NPU compute clock ("npu", SCMI_CLK_NPU on RK3588) are
never prepared or enabled by this driver at all. The NPU still works
only because the Rockchip power-domain driver sets GENPD_FLAG_PM_CLK and
its attach_dev() callback walks the device node with of_clk_get() and
adds every clock to the pm_clk list, so genpd happens to keep the
remaining clocks running. The bug is therefore latent today, but it
means the driver holds no reference to the clock that actually feeds the
NPU, which stands in the way of any future frequency scaling
(OPP/devfreq) work.

Found on an Orange Pi 5 Plus (RK3588) by reading the live clock tree:
/sys/kernel/debug/clk/clk_summary shows four "fdab0000.npu" consumer
handles on aclk_npu0 (and likewise on aclk_npu1/aclk_npu2 for the other
two cores), while hclk_npu0, pclk_npu_root and scmi_clk_npu have no
"fdab0000.npu" consumer at all - their only consumers are the
"npu@fdab0000" handles created by the power-domain driver via
of_clk_get().

Set the ids explicitly, in the order mandated by the binding
(Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yaml):
aclk, hclk, npu, pclk. After the change the driver holds one handle per
distinct clock and clk_bulk_prepare_enable() covers all four.

Note that this is a user-visible tightening for out-of-tree DTs: the
old NULL-id requests resolved by index and succeeded no matter what
"clock-names" contained, while the named requests fail probe with
-ENOENT when one of the four names is missing. That is the right
outcome for in-tree users - the binding requires exactly these four
clock-names and rk3588-base.dtsi carries them on all three cores - but
a DT that relied on the permissive lookup goes from silently running on
the wrong clock handles to not probing at all, so record the change
here where git log will find it.

Fixes: ed98261b4168 ("accel/rocket: Add a new driver for Rockchip's NPU")
Assisted-by: LLM sparse checkpatch
Signed-off-by: Igor Paunovic <royalnet026@gmail.com>
Tested-by: Sidong Yang <sidong.yang@furiosa.ai>
Tested-by: Diederik de Haas <diederik@cknow-tech.com>  # NanoPC-T6 LTS, NanoPC-T6 Plus
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Reviewed-by: Jiaxing Hu <gahing@gahingwoo.com>
---
Same diff and the same message text (his copy re-wraps the lines) as
01/14 of Jiaxing Hu's RK3576 series, which carries this patch as well;
whichever lands first, the other drops it. The trailers differ: Jiaxing
asked me to drop his Signed-off-by from my own posting of it, as he did
not pass this copy along, and Assisted-by is added because an LLM helped
with the checks on this v2.

 drivers/accel/rocket/rocket_core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/accel/rocket/rocket_core.c b/drivers/accel/rocket/rocket_core.c
index b3b2fa9ba645a..5dd260bacbff6 100644
--- a/drivers/accel/rocket/rocket_core.c
+++ b/drivers/accel/rocket/rocket_core.c
@@ -28,6 +28,10 @@ int rocket_core_init(struct rocket_core *core)
 	if (err)
 		return dev_err_probe(dev, err, "failed to get resets for core %d\n", core->index);
 
+	core->clks[0].id = "aclk";
+	core->clks[1].id = "hclk";
+	core->clks[2].id = "npu";
+	core->clks[3].id = "pclk";
 	err = devm_clk_bulk_get(dev, ARRAY_SIZE(core->clks), core->clks);
 	if (err)
 		return dev_err_probe(dev, err, "failed to get clocks for core %d\n", core->index);
-- 
2.43.0

