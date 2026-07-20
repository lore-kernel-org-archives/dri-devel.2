Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A34D0C44524
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 09:05:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1B9310E831;
	Mon, 20 Jul 2026 09:05:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nFf3VelS";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7596110E833
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 09:05:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BFFD960A86;
 Mon, 20 Jul 2026 09:05:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C8B61F000E9;
 Mon, 20 Jul 2026 09:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784538327;
 bh=KVmhOsXO3bKuVS2vuBCENY+jTVz8iDNtZdafOD1GtVk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nFf3VelSVlF6Q1eKH++JQKjEUmHIdGDf9QqetCiFmmfiJkIGa8juP6ko2I97nOLFL
 5COA65kyCxpbkaO+LvmbAyxej5v+WT/D3nFulSW3FxdQzZQA0uNduigvfjWo9rHAI+
 ePpzvm59y/N3itf/+mtuqVwVaTxTbQo97m/iBr/VklM6bONcpp+0CQuEQYccfsPUpY
 iaEpXWdAseBIjot2iQaHuxcImmhtnKNb1votEjvZJRn126dqwDSNAgnT9tWJ8GiF0K
 Bxg5mh0ZSXAJWIQXAzvT8zkNLjmCeUouH7yBZeA8WjXiOpOmV49FN/3AQOKOepbHRY
 6zH6MaGv9E3qw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] arm64: dts: qcom: Add INT2_GDSC to MDSS on
 Kaanapali and Glymur
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: conor+dt@kernel.org, robh@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260720-msm_gdsc2-v1-3-4687866d6cb0@oss.qualcomm.com>
References: <20260720-msm_gdsc2-v1-0-4687866d6cb0@oss.qualcomm.com>
 <20260720-msm_gdsc2-v1-3-4687866d6cb0@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 09:05:26 +0000
Message-Id: <20260720090527.2C8B61F000E9@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The patch omits `sm8750.dtsi`, failing to add the `INT2_GDSC` powe=
r domain for SM8750 despite the commit message explicitly declaring that SM=
8750 requires it.
- [High] Missing cleanup of the IRQ domain and chained handler when power d=
omain attachment fails, leading to a Use-After-Free.
--

--- Patch [3]: [PATCH 3/3] arm64: dts: qcom: Add INT2_GDSC to MDSS on Kaana=
pali and Glymur ---
commit a757d0e4c829d9c4eb6cdd0c681fb7e3459e226e
Author: Yongxing Mou <yongxing.mou@oss.qualcomm.com>

arm64: dts: qcom: Add INT2_GDSC to MDSS on Kaanapali and Glymur

Kaanapali (SM8750) and Glymur use two display power domains.
CORE_GDSC powers the main display hardware while INT2_GDSC powers
a subset of SSPP blocks (VIG2/VIG3/DMA5/DMA6).

Add DISP_CC_MDSS_CORE_INT2_GDSC alongside the existing CORE_GDSC
reference in the MDSS node on both platforms and provide matching
power-domain-names entries for the display power domains.

> Kaanapali (SM8750) and Glymur use two display power domains.
> CORE_GDSC powers the main display hardware while INT2_GDSC powers
> a subset of SSPP blocks (VIG2/VIG3/DMA5/DMA6).

[Severity: High]
The commit message explicitly states that Kaanapali (SM8750) requires the
INT2_GDSC power domain. However, the patch omits updating sm8750.dtsi.

Could this omission cause SM8750 platforms using sm8750.dtsi to fall back
to single-domain mode and fail to attach the secondary power domain, leaving
a subset of SSPP blocks (VIG2/VIG3/DMA5/DMA6) unpowered and inaccessible?

diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mdss.c
index 9087c4b290dba..63ece55c4f2ec 100644
--- a/drivers/gpu/drm/msm/msm_mdss.c
+++ b/drivers/gpu/drm/msm/msm_mdss.c
[ ... ]
@@ -421,6 +451,27 @@ static struct msm_mdss *msm_mdss_init(struct platform_=
device *pdev, bool is_mdp5
 	irq_set_chained_handler_and_data(irq, msm_mdss_irq,
 					 msm_mdss);
=20
+	/*
+	 * When two power domains are listed in DT, the core framework does not
+	 * auto-attach either of them.  Attach and manage both explicitly so
+	 * that INT2_GDSC (needed for VIG2/VIG3) is enabled alongside the main
+	 * CORE_GDSC.  Single-domain platforms are unaffected.
+	 */
+	if (of_count_phandle_with_args(pdev->dev.of_node, "power-domains",
+				       "#power-domain-cells") > 1) {
+		static const char * const mdss_pd_names[] =3D { "core", "int2" };
+		static const struct dev_pm_domain_attach_data pd_data =3D {
+			.pd_names =3D mdss_pd_names,
+			.num_pd_names =3D ARRAY_SIZE(mdss_pd_names),
+			.pd_flags =3D PD_FLAG_NO_DEV_LINK,
+		};
+
+		ret =3D devm_pm_domain_attach_list(&pdev->dev, &pd_data,
+						 &msm_mdss->pd_list);
+		if (ret < 0)
+			return ERR_PTR(ret);

[Severity: High]
Is it possible this error path leaves a dangling pointer registered in the =
IRQ
subsystem?

In msm_mdss_init(), irq_set_chained_handler_and_data() is called earlier to
install the chained handler with msm_mdss as the data pointer, and the IRQ
domain is created via irq_domain_create_linear(). If
devm_pm_domain_attach_list() fails (e.g., due to probe deferral), this block
directly returns an error without calling irq_set_chained_handler_and_data()
with NULL to clean it up, or calling irq_domain_remove().

Because msm_mdss is devres-allocated, it will be freed upon probe failure.
If a spurious or shared interrupt fires on that IRQ line, will the kernel
execute msm_mdss_irq() and dereference the freed msm_mdss pointer, causing a
use-after-free and a kernel panic?

+	}
+
 	pm_runtime_enable(&pdev->dev);
=20
 	return msm_mdss;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720-msm_gdsc2-=
v1-0-4687866d6cb0@oss.qualcomm.com?part=3D3
