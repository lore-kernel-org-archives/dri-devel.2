Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64EBFC54F51
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 09:30:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAAF610E15A;
	Wed, 29 Jul 2026 09:30:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="B7oaPbUZ";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B069F10E15A
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 09:30:09 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4955c545a94so564005e9.3
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 02:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785317408; x=1785922208; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=gz5V2n93NOL3hYSU9xeOl7rpcn8sNAuGMXkKaTZlLvM=;
 b=B7oaPbUZInww7151IN9ixgvcXuSiChkRVb3rhPXRrgNVg+b997zRPodrg81jrRNyWV
 43xTaxITW2Az6bT7KIVmMUHolBKSDLuI6I6vlUQ4gRi2wgWoxFDdnYlRfFK4INzmY5Lg
 ppuhNRjZHSXMQw1bWoVnQMuo1uLAOvZggybAkp+AIMswGh3TtXrbE56CPhow7RaXYqc1
 u1E3E8Y6pQ7VhiWMFxSYEziJr7/WqXmz27OsknpyMfGfjlAXAXYwPHN0NJx52V86mjgz
 Xd5mjNJ64ftQPn8HSNIBJ3gaD5/0tHIuTlv86j+nSP+z589sCFh/wWFgR3N+UrSHBou7
 84aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785317408; x=1785922208;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gz5V2n93NOL3hYSU9xeOl7rpcn8sNAuGMXkKaTZlLvM=;
 b=h5Bf2im/puPX0mmJz7K2pybHZgeEvBBFsfJf0FOE5wXO2bk3YKwQDrZIjbYReXePFL
 cvA9TAlsiJGgbnB3Z1f7YP+dNY44xNGga0FJB9CG6amLxHA8g1X0cPVr+j6qQ8J2yiHB
 riUtk7pt4Tjxoe3BovWJzcadxcgGQT7QNe+L71nBJxq/XAngeoF3ZYSiytvH3ErEVXJk
 ylSSYKWLifn5TYi55Y6PWtCdYkPmtg6QO/pe3JH9BkUhyFLR6Z9Ttzq/JPqqT1PFdSfG
 gnI3Z6xNgSPQ7DSoUeEFo99++92g5DUOsk1IGNt9TDwG6KCP8Ryl0eQTrlk6v2DZeg6Y
 5WBQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqUCm8JNPaTNDcSRIEgz8Qdc69AagodswIbMOTL1BDNTNYI+t3eTxAy7uWb/l9hBihNFlCKaQ+il1g=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YycoyWUuOpaZIHb3KJWKjDHDJf7nczeaAYn7pGPWIYkCDtYLOIZ
 9wenwlgO7+PdtICvtrEbUcjwfgIREAnz8sI7ZeY99rUQsjTII55O7uCM
X-Gm-Gg: AR+sD11DWogiO2TKdwkd9nO8692FL7R3OBGalB833woqGAkbiwq2YnvjPldUKNxv2Hq
 VDg7FhuMvYr7HJdpA+wL1Cysk3yJvd+6hZxfTGEbdMMKxFetWD1Fydn9UfDtW3M2tF5GW1WrQUm
 DvfW8QeQfF3VA+aT7S/ZpSUb4Crl+R/AJQHWRfAbp9fsHLX9rmvn6+96ssh/gmiigA6MlEKfKhk
 WxVW04RN51eQCYGPAsS1c6UsKIRZSNmPGX1FqPMa+T0+qP9ydAlUJaMFh52jsRZZ5hdJlC75mmE
 jrVzaAcsiVQ4ThNlCatNuvfPc+vmUMweC555dSEbc41Q+HxZcgbd+JRpb9FUzkPKDZ8GX/pQIn1
 jcohJzwuJVd5FVB/Lk0J2qoND30gkXZmEKkYaG68qUqHovyB1cuBjMk0PNtunStnZjSpuXMbNyC
 Dpyhf5nkUr1VblM4V8xhjVzaj30b3uceZM4KJdzITnFk1UCxNQg+tR63KUc6XnZFNLx6FtW2v3A
 +cS7C+hznAR+eUM5E1x2IcsBQ1V3xxApzIJnjcIxpUPKjAmOktT14XixWZ4OnHsfJEdqg==
X-Received: by 2002:a05:600c:c48f:b0:495:71ff:598d with SMTP id
 5b1f17b1804b1-496c6415627mr45324345e9.1.1785317407675; 
 Wed, 29 Jul 2026 02:30:07 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B886F0027B74C8463513DA4.dsl.pool.telekom.hu.
 [2001:4c4e:1b88:6f00:27b7:4c84:6351:3da4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49764d8e826sm49682835e9.8.2026.07.29.02.30.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 02:30:07 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Cc: Oded Gabbay <ogabbay@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 Jiaxing Hu <gahing@gahingwoo.com>, Igor Paunovic <royalnet026@gmail.com>
Subject: [PATCH] accel/rocket: request the core clocks by name
Date: Wed, 29 Jul 2026 11:29:39 +0200
Message-ID: <20260729092939.118779-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Fixes: ed98261b4168 ("accel/rocket: Add a new driver for Rockchip's NPU")
Signed-off-by: Igor Paunovic <royalnet026@gmail.com>
---
Sent following Tomeu's request to send fixes upfront. Jiaxing Hu's
RK3576 enablement series carries the same id assignments inside
[RFC PATCH v2 6/8] accel/rocket: add RK3576 NPU (RKNN) support
(Message-Id: <20260718031146.3368811-7-gahing@gahingwoo.com>), together
with new per-SoC match data. This standalone fix is intentionally
minimal - ARRAY_SIZE(core->clks) and the clks[4] array are left
untouched - so it rebases trivially under both the RK3576 v3 and the
RK3568 series, and can be backported.

Verified on RK3588 (Orange Pi 5 Plus): after the change clk_summary
shows one consumer handle per clock instead of four handles on aclk, the
NPU still powers up and down cleanly through runtime PM, and a
MobileNetV1 inference run via the Teflon TFLite delegate produces
bit-identical output tensors to the unpatched driver.

 drivers/accel/rocket/rocket_core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/accel/rocket/rocket_core.c b/drivers/accel/rocket/rocket_core.c
index b3b2fa9..5dd260b 100644
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
