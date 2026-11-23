Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D7D606A31F
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 17:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F3kwWrlk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 091D410EC56;
	Mon, 23 Nov 2026 17:33:46 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE34510EC7F
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 17:33:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 91F70438A6;
 Mon, 23 Nov 2026 17:33:39 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1795455219;
 b=O3VhYw4UdVinZG9MApj+VL7kEGLTp/yh7XAF9eW7CeDjrJM4AnggPGxk5GR4VA03D2Ox
 SL6fZnffCD3F+vydEW/cfApUoKxbjYIJEH3DTI2kaK5WbedP1OdRAR7BoQ5jQlqLK0m7P
 gpk5+LBtZUbnUTj4OA6y00gqqtx6hDNGg1PBdxCG5H84cLNxLXqoRGcMWBH57nEX+OfV4
 PsRwjUamZ4vRJM5oFVoiZwTcKNva8762CCuGKG8ZK4e/zBX9w2rIgwog9TwTcpqQgHQKJ
 x+b5Q0xZojKv2O18/Ncl7z3pCKXpIFOExxwc6bJzrrzw/dFnRiwKneuZqcl00b7wDQg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1795455219;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:X-B4-Tracking:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To:
 Content-Transfer-Encoding;
 bh=URDPaglQXKS7bojwQwMsPG/Rk5Gel8tTQUM0/WVvGKU=;
 b=Aw2EmvpH0lNV5lYDEGnGFbQ7UWNZO7GOROEpycl+V+LfBZXknoEBFWvg8sWsuaTm+AKP
 bn+ewYUovybJOEXhxboxqf4Fzb4ieAVXF61Qg4sIXXyt9rS6bo5KxZxZk7YZR5ToL1MQ9
 LBYPXzRZd6MpKtJIFrcEMgPn2guprbK9RyClxwyLZ4KFhR5RqTOY/V5k4ivdpXRxOhfZU
 Rt6knv1irWqV4ggjOIigSqYa0hZq7rej9VpwRwx5dDrlli/MrTssHMKk/FkCRtD2DZd3Z
 NOwVqRBcE+EaJ4NCpll8dVsIXYUqhRnZ6imzz3PLOVQ6rIDiWJP3AXobagfPXKossGA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id B7EC21F000ED;
 Mon, 23 Nov 2026 17:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795455218;
 bh=URDPaglQXKS7bojwQwMsPG/Rk5Gel8tTQUM0/WVvGKU=;
 h=From:Date:Subject:To:Cc:Reply-To;
 b=F3kwWrlk9YB9aXOSXyEBLDwDYiLI+DQ0ms2dW2DaC4Cj+zZnqDbwMq5N9ESAkai/B
 kuN0HftO7z1nN0N24S8XJlAlvMq67zK6Fumf0bmU/oiiDl5UYPYB/YyLN+ehXdDLiR
 Ds4mSfxP5aB6JvrP790OyAs3L1fdFGR1AdDd5VjlOvlaCS6U5ylxFDLsIgLwbVigAu
 RyYtK6yPXluo2cJta6dwp0eLNv0LtC5PDTM8Lf1g0v3ce5kczGk0NnpF4ahZwthw/j
 NiMxKNO13VZbKOwVkMfXtcbWSmQxHRJQBwLuyCRZOaKU+4G5HjRCZRejN9dYXYGtrj
 4/DFaPaQL+67A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 4A5FA4C580;
 Mon, 23 Nov 2026 17:33:28 +0000 (UTC)
From: Igor Velkov via B4 Relay <devnull+iav.iav.lv@kernel.org>
Date: Mon, 23 Nov 2026 17:33:26 +0000
Subject: [PATCH v3] drm/panfrost: Enable GPU_PM_RT for RK3399
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261123-panfrost-rk3399-pm-rt-v3-1-04c7c58d1140@iav.lv>
X-B4-Tracking: v=1; b=H4sIAOV4BGsC/4XOwQ6CMAyA4VchO1uzbijWk+9hPDSwyaIC6ciiI
 by7g4OejMe/Sb92UtFJcFEdi0mJSyGGvsthN4WqW+6uDkKTWxlt9qithoE7L30cQW7WEsHwABm
 hdmx9jRXphlTeHcT58Fzd8yV3G+LYy2s9k3CZ/hMTAoKjsrQV7oipOQVO23tSC5fMl0BjfhEmE
 6X2+S1kRj58iHme34wldAD6AAAA
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Heiko Stuebner <heiko@sntech.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 Daniel Stone <daniel@fooishbar.org>, Igor Velkov <iav@iav.lv>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2865; i=iav@iav.lv;
 h=from:subject:message-id;
 bh=jVdmdH5Fy/vduyoI4gZY5e3ymBwUoj6ShIzYh5QXSJg=;
 b=owGbwMvMwCVmNH1q96v4SmbG02pJDNksFc8rdlg+iPedscv2zTeRq886bvTwXj389ETWup/Tx
 Yx0XCpfd5SyMIhxMciKKbJMOKRxK2PJ1b/+HuYPYOawMoEMYeDiFICJvNjCyLDxom9Vt/Cntm3z
 p2a3/bu646580qG17p4BC/eL/+p9a1fH8M+OY+r5VRVeDdumxLzwZV7zhZVPfseqbxx3Tm3hi2R
 78JkTAA==
X-Developer-Key: i=iav@iav.lv; a=openpgp;
 fpr=90C228DA68A4D5FD4F4837E03297958BEA5F7903
X-Endpoint-Received: by B4 Relay for iav@iav.lv/default with auth_id=1060
X-Original-From: Igor Velkov <iav@iav.lv>
Content-Transfer-Encoding: 7bit
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
Reply-To: iav@iav.lv
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Igor Velkov <iav@iav.lv>

The RK3399 Mali-T860 matches arm,mali-t860 and gets default_data, so
panfrost enables aclk_gpu at probe and keeps it enabled until unbind;
runtime suspend powers the GPU off but leaves the clock on.

On ROCK Pi 4A restore from hibernation hangs in genpd_restore_noirq()
of the GPU when the hibernated kernel had panfrost bound and the
kernel that loads the image does not. There clk_disable_unused()
gates aclk_gpu, while the restored image still holds an enable count
on it, so powering the GPU domain back on does not ungate the clock.
With the clock gated in runtime suspend, as on the Allwinner H616 and
the Renesas RZ/G3L and RZ/G3E, restore completes.

Match rockchip,rk3399-mali to default_pm_rt_data, which differs from
default_data only in GPU_PM_RT.

Reviewed-by: Steven Price <steven.price@arm.com>
Signed-off-by: Igor Velkov <iav@iav.lv>
---
Tested on ROCK Pi 4A, drm-misc-next c408466a4dfa with the rkvdec fix [1]
applied: hibernation restores 9 of 9 with this patch (3 with an HDMI
mode held, 3 right after glmark2-es2-drm, 3 idle), and the GPU renders
after restore. With the GPU node left with arm,mali-t860 only, restore
hangs 2 of 2, in genpd_restore_noirq() of the GPU.
[1] fixes the same kind of hang in rkvdec, which otherwise hits first;
this patch applies and builds without it.

[1] https://lore.kernel.org/r/20261030-rkvdec-runtime-pm-clocks-v2-1-8ff510a231de@iav.lv

Changes in v3:
- Retitle as Steven suggested, say what GPU_PM_RT changes
- Add Steven's Reviewed-by, given on v1 (same code)
- Link to v2: https://lore.kernel.org/r/20261122-panfrost-rk3399-pm-rt-v2-1-40f1791aa1a8@iav.lv

Changes in v2:
- Name the SoCs that already use default_pm_rt_data
- Say why restore hangs
- Rebase onto drm-misc-next
- Link to v1: https://lore.kernel.org/r/20261030-panfrost-rk3399-pm-rt-v1-1-e94437159a9d@iav.lv
---
 drivers/gpu/drm/panfrost/panfrost_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index eeda113037fe..91acfa13ef42 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -983,6 +983,7 @@ static const struct of_device_id dt_match[] = {
 	  .data = &amlogic_data, },
 	{ .compatible = "renesas,r9a08g046-mali", .data = &default_pm_rt_data },
 	{ .compatible = "renesas,r9a09g047-mali", .data = &default_pm_rt_data },
+	{ .compatible = "rockchip,rk3399-mali", .data = &default_pm_rt_data },
 	{ .compatible = "arm,mali-t604", .data = &default_data, },
 	{ .compatible = "arm,mali-t624", .data = &default_data, },
 	{ .compatible = "arm,mali-t628", .data = &default_data, },

---
base-commit: c408466a4dfaee4b12587e926c5b85e68c8b3c40
change-id: 20261030-panfrost-rk3399-pm-rt-cea3fc1790d9

Best regards,
-- 
Igor Velkov <iav@iav.lv>


