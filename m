Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B300C53200
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 13:08:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4E6210EC14;
	Wed, 29 Jul 2026 13:08:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KAZeFytB";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 941BB10EC14
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 13:08:03 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4954b3c5cbeso504925e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 06:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785330482; x=1785935282; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Q/pbacYlJpkDaCE9RbWRQcg2zDk1XOgU/3Z2HS4A2NQ=;
 b=KAZeFytB+f/Hn8wx7CLHweV0z6IND4UBmYeiaZNKAhJI29hHYG3PIEYmSEGJcqud4W
 4Zt61CUY+cNxpxGheNdsz36JcPLNLPdjrxTLW40EC/nFKxKfZbIaLMYbrRFOXr2uYTca
 icVRtuj5Fr/TEnJn3Zc51YIzE85VHqQnRLMc37d8wQB14sta9URRZf5RaPjyZg/2dpvf
 bSaWFpiDKuEKLPHyms7HgLl7QPQt/iNzdCalbg5a5kMeYv6bqgygznKlciWPughqOdG1
 q+nUXWiA+QRJE8ez6GVA9S25B1SiCqlG/XJYSjSwbL+8Xh9CgC+oD70g+ycWn0SCB7MQ
 7g4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785330482; x=1785935282;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Q/pbacYlJpkDaCE9RbWRQcg2zDk1XOgU/3Z2HS4A2NQ=;
 b=AkCAjXSD2LpXW4gTIyNbzd6F4XRrMXHkKnRZiE7uR+kXyd1sJ+CFZKiY9lJEZxSA4/
 p//7tRpFlY3c++/U+w0u/irhZ4MRkgz51WhiIm+AceveMYevuehA8kk3ykLFa7X4IQan
 8lYtuwr76cfserT+cxJIqGxMnnvRYABXuRmBZasBicryF/uAdXhVCSZLn1ACiwMFf4K3
 Y4NcjikjyomI0GVqkmzPlp3U1m60Fpa5LfiHCRGzQFK3tGl6zWwdFrZLLueT00kfRbr4
 9pKGG8TW+Ae911mCCtzE8tXDhW/acc3cr3YVCNYe4dqLgGyz8IliG5dfAoEpSMT3BUkF
 ZYUQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrxB+flK9EPqszlwhUZKZ4v6Ex15eQo7l4tC0AMI5jZwVfY0o1+owK19jEF/2feOBMal97CfSTwBT0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxWBEkHRKepdvPlKKhJOrifO89Wt7pTtq4zQB+dWpBpM5py7cG7
 3NllAwuTrIbUl0hUNO2NgjWz3LDGzQ8DliVBS7/I4+bWfbbdgZ0z4Qvc
X-Gm-Gg: AR+sD10etNBKhAsm6kXgpmOZ8GMhnm1he2pt0zhRqOQMjlo0L9ssoL+qj/uwJJv2MVJ
 TkfIGVjJnrdKCUCvIcmRjl+0GDOwBZinwm3kcnTnj5tcNGD4llQgupovxa6eCPCeJuAbuUSCGZu
 wEXnvRFi7jJfWFO9UWK09K+dp54OoVvxfSipEitxfo4RRd8876Fg0d9UY+ADW6/IWzxgsP7KWUh
 qeuA8EekiKtcrBPMehWci4rrXPjOi8iudCIBkpDc4BXZVIIWwxs8fjpK1vz1QQjl6PRs5puWWAZ
 e8+DiOHG56ZANmLQe9cF6AKjsIEnFoinH8qJwEKli0VxwqNHkxGuuKem12nO7jETouqGNIpGvUb
 x+I3MPLOJF40i51yza/pW1xisN5kPKBTAJZgs2fdMjxiionewCdWM3ULqtC/et5ZbYvjIrmLAat
 7k85nvOBkhcO12avTfGLGjGibBeLwUrYVwgvLWWh8MOSt/Qe9pIAtgnXCk0In8vr2KZHdGrB66Y
 Du6RtyNL0HVq+h0do33L+mwWpCnlePjzTSlRm7iiWMVXy3Hmghn+WHkdzHTSg4rK0nQDg==
X-Received: by 2002:a05:600c:4583:b0:493:f42e:1b3f with SMTP id
 5b1f17b1804b1-496c6571e01mr50134555e9.3.1785330481530; 
 Wed, 29 Jul 2026 06:08:01 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B886F0027B74C8463513DA4.dsl.pool.telekom.hu.
 [2001:4c4e:1b88:6f00:27b7:4c84:6351:3da4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-497fecfccc7sm37571645e9.12.2026.07.29.06.08.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 06:08:01 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Cc: Oded Gabbay <ogabbay@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 Jiaxing Hu <gahing@gahingwoo.com>, Heiko Stuebner <heiko@sntech.de>,
 Igor Paunovic <royalnet026@gmail.com>
Subject: [PATCH v2] accel/rocket: request the core clocks by name
Date: Wed, 29 Jul 2026 15:07:43 +0200
Message-ID: <20260729130743.128876-1-royalnet026@gmail.com>
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
Reviewed-by: Jiaxing Hu <gahing@gahingwoo.com>
---
v2:
 - document that resolving by name is a behaviour change for DTs that
   do not carry all four clock-names (Jiaxing Hu)
 - collect Jiaxing's Reviewed-by
v1: https://lore.kernel.org/linux-rockchip/20260729092939.118779-1-royalnet026@gmail.com/

The same four id assignments are board-tested on RK3576 (ROCK 4D) as
part of Jiaxing's RK3576 enablement series (v2 6/8), so the change has
been exercised on two SoCs between us.

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
