Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C376C79F82
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 13:09:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0944710E358;
	Fri,  4 Sep 2026 13:09:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FbRv5WQI";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C93F10E1B5
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 13:09:25 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4957799b92fso428365e9.1
 for <dri-devel@lists.freedesktop.org>; Fri, 04 Sep 2026 06:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788527364; x=1789132164; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=t7o7pGTYJ1j9htjyKompyXPu5oGlEszk3L/eQl+FLhg=;
 b=FbRv5WQIEdMCzzNKnqn1ZoBHbrDrNwZqjdo5LH/D1101RFNPMfC/aGoAl+TW2mKDYR
 HkjMUhJqfW+9aPr30puf2DKE5Q9qRtR5gYY+bTqjYWJI7G2vN8kWr6+Q2tNdwJspDXxr
 O51KwJs8xa3r0Ev73kzaNJUXb55UnmUNaMJRLW4Lc6I+U6VbCLb4y5/9jHOgtABkioZl
 VqsBxgVfdTYeCbqSWrnxi8dbOIiF+GWEtdhMeXoUQbQM+UBA5pXjvh7+vH/8NaUIuAP3
 IaFCnmpCQFIpGB3QKqoERyEF2y5ogfvYt40DUzmiCkPylbUHYtM+6MkA4LsVabr7Uf2H
 H5dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788527364; x=1789132164;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=t7o7pGTYJ1j9htjyKompyXPu5oGlEszk3L/eQl+FLhg=;
 b=IhnfzfRw/Fb7L7pPsZ9Mq7L8WX6RpiiqBTZfmFPSNeRtB7B64y+j/H/d6rUtwAvftA
 WxlCUdhD7QSRZgVCLY6pFjgZdZ1weIaH8XSucMIeeiKyYpH/4XFr4ux18MP+56wWp5EZ
 +7xOi28IDgopz/gKX4bh+/m0J6QAeW+kl/2y9ltoJeE3Q4dWEiTf4YZFUTwckgSh0e1i
 cN5bzMU/ZpsFQGrX6WtV1f4LXGXZ6H2E/53NXomHgpsWd3GSIqp9DtDZmkxnXmfCnDAc
 4058ifGFx48r+oKY+F+J1mSJJB43kbDKCVu24dqb/8CQIsgruqhnqAYW5liA13icgBX/
 5iwA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzB9ce/imSMya8YnJ/ay3EpphMOv7Ow26DHvoa4DXZHFbS1h2KLbW1tR93WAOfV/mx/MWvMVaIrbaU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kA9dTpVs6IzubvHAABshwgM8oM88fDHOiOtz5VI2DuEYIpHNj8
 ovhpIQAhCVtEZbh9nsOmfNq2gIU9I3gktoOj/LjryAd1hsGKF3fYK1yh
X-Gm-Gg: AYBFou0ECvpjiHjTvqwKTXapwZIxNvs2OCbT+156ZaP7KtRs5cy4itb1WMjf7HmnDzp
 9BwQo9LnvlulzFy04iQLPKd0jGHCBZwclWuYannGCwmL2uIBaKcFkwFjBr+oaT5G1uUUTOau5Oz
 /dfflPNnIH5VvsMSWjSE1xh3FGcEEEvdNdjgDPKuJHdGPhZ8WRQy1hV2b7rAX2i8x7mOg7S8B4C
 R2irml608eefLxv2/xoMkrLmr1FP0ZNL8EkE1sD/makoTyYhY6j195X5x4Veq/5YrJqRcfxv+7g
 sUMEWv9tKrBn99kmEnbwuBvsW2uO+F6tiAS0PFu48y3HXrHH48TAYaemjGdkNHdV8vAmGknecH3
 D6idfV0UEjyz6aD1J1lhEDBFOvC2hic7HJiRdfvWkcsvwK6KCqdNiOEjCmfBU+vu1tPFRNN5aJP
 lBx0ULS6+0i6iAxyeC+4RpS3rK4dDf/j+wgmCK25gGuewcCDUQ8Lh9x3Zfwe2eKjKw9KR7ShFR2
 PH7GJnATfaVfYBE7tgYpGoukazpNnRvZHIC1w6Ro4/bo+PepUX4VNBCutn+vhJ+rw7QUtaTijwZ
 fgw=
X-Received: by 2002:a05:600c:8b6d:b0:49c:e363:c66e with SMTP id
 5b1f17b1804b1-49cf82420afmr41030795e9.1.1788527363631; 
 Fri, 04 Sep 2026 06:09:23 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B871500CB6EF488A18F9C42.dsl.pool.telekom.hu.
 [2001:4c4e:1b87:1500:cb6e:f488:a18f:9c42])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce554d52esm135575435e9.3.2026.09.04.06.09.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 06:09:23 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Sidong Yang <sidong.yang@furiosa.ai>,
 Diederik de Haas <diederik@cknow-tech.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Jiaxing Hu <gahing@gahingwoo.com>, Nicolas Dufresne <nicolas@ndufresne.ca>,
 Jonas Karlman <jonas@kwiboo.se>, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Igor Paunovic <royalnet026@gmail.com>
Subject: [PATCH 1/7] accel/rocket: request the core clocks by name
Date: Fri,  4 Sep 2026 15:08:52 +0200
Message-ID: <20260904130858.27803-2-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904130858.27803-1-royalnet026@gmail.com>
References: <20260904130858.27803-1-royalnet026@gmail.com>
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
Signed-off-by: Igor Paunovic <royalnet026@gmail.com>
Tested-by: Sidong Yang <sidong.yang@furiosa.ai>
Tested-by: Diederik de Haas <diederik@cknow-tech.com>  # NanoPC-T6 LTS, NanoPC-T6 Plus
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Reviewed-by: Jiaxing Hu <gahing@gahingwoo.com>
Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
---
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

