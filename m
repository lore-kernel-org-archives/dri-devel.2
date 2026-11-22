Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73281606A320
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 01:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jZOpHG8V
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF58E10E3B6;
	Sun, 22 Nov 2026 01:28:26 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F51B10E3B6
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 01:28:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 671BA60232;
 Sun, 22 Nov 2026 01:28:19 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1795310899;
 b=c5LPd7RS4VfTz3/iB09DOWTpru1dbVqLQr3FAbcPnt61TkJnr+pbSF5HUeSnA+eiVtcz
 7i49k4dmmlylJt4fNNOaFDMsiZ+3Oy/N8lSGiaM18SmArb21Vzk5o/ywbrSKDXzfHBh7+
 CE5DHmIyKlMug0Mh1Bag2G76FKBvnkz5fgiA/0j1grFVk9DUsiLtP9pqSI9VgaKzWe1Wt
 7urxhPmaL8jNCFEt3lRV7RCRrKZsXXNWFBDRQtj8UUTUYSWS1naWJEuTzR20T6sG/YVk4
 qr/lu1g7gh6Og9oAOp5HwOB/g4QTu4eb7V9ug4UZh7X6INGM7Cf7e+zSrU0I2jdMBJQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1795310899;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:X-B4-Tracking:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To:
 Content-Transfer-Encoding;
 bh=4qUOVGLfHGTdLP72SoQt9x1onQjawb60zHgKVe5je7s=;
 b=aBS2N0Hxx9Ygn4hmNTFLhZswB7Y+lJ3kcqQtdK3npQ4I2oYiKHn5R0G+BSC66yjX8y6o
 VWEqsU1/4N3tpFUc47EDTW4eWlnbZRvAWMvh+0VsRqxcRGFj0Y+DHpBSBtqvXA+4SU27o
 wXANVX9DOs8qfXvAi8lf1AXmbSmVyM3avSmW1Ogb8IDdNIdEV7Th33Sxi4XXWrr3X0DzU
 pt7mlx8B/44ot5N1fICHRXQ5thU7BAaSIjlpi4IzC12fDd/I/dnL4pEgaOXng4GMuOraq
 0icJKA/C+CvH26Sds0nAOuI2pXqJRImXrydjWY2M1rCRmANfvm+dedCbjy603FGLJoQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id A4BFF1F000C0;
 Sun, 22 Nov 2026 01:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795310899;
 bh=4qUOVGLfHGTdLP72SoQt9x1onQjawb60zHgKVe5je7s=;
 h=From:Date:Subject:To:Cc:Reply-To;
 b=jZOpHG8Vtd6qKper50Sr5tlnB8/+ft/UDVgVlzsnbPiJdZHEJRlVyvtZ43licZfKr
 4v0zcDJmB9NiT+DNNJTvhA+dlqUiX5b0mTksLV9BZmqS2vJfRUOcXTPIM94myKr8WD
 IQw0g5lqaWwfSx2IL0kPZT/qODRticAUrjljHfeH7qrNIhFE9AVGruGKHx9F29tf3P
 chdVgj4hedCPpB8dtmvg3cBxAMkRLuawxoN2ZNYBaTpWhKoCx6SWz8GIsU6x/+MG5y
 n/OwZrM2TpSmuI/OMLjQuKuumhClWy9fBi0ve1J5WCz/lE/JxvawIbCyJR4AIIwVMv
 xXiGEGpzKRuSQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 08E504BEA2;
 Sun, 22 Nov 2026 01:28:18 +0000 (UTC)
From: Igor Velkov via B4 Relay <devnull+iav.iav.lv@kernel.org>
Date: Sun, 22 Nov 2026 03:28:04 +0200
Subject: [PATCH v2] drm/panfrost: Gate the RK3399 GPU clock in runtime suspend
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261122-panfrost-rk3399-pm-rt-v2-1-40f1791aa1a8@iav.lv>
X-B4-Tracking: v=1; b=H4sIACNFAmsC/4WNQQ6CMBBFr0Jm7ZiWomRceQ/DoilTmahApqTRE
 O5u5QIu30v++yskVuEEl2oF5SxJprFAfaggDH68M0pfGGpTn61xBmc/Rp3SgvpwjgjnF+qCgb2
 LwbZkeoKynZWjvPfurSs8SFom/ew32f7sv2K2aJGpaVxrT+Spv4rPx2eGbtu2L9QCNTu3AAAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2536; i=iav@iav.lv;
 h=from:subject:message-id;
 bh=umYgCRkWKn6+vJ3cIJXDRixn24OfpDYOCpQZFsANalM=;
 b=owGbwMvMwCVmNH1q96v4SmbG02pJDNlMroat6+Z90PcJ+3l1pcTdh/Frzuuo7PfaaDvV7GCc4
 HPTqiS5jlIWBjEuBlkxRZYJhzRuZSy5+tffw/wBzBxWJpAhDFycAjCRbE1Ghlu3NLbpc05mkjZo
 8VFX/Jte8Un5/KfVS4J7Yy7dTi+O9mVkOHpv5s8/M3b1dwpsXvhv9y+2DypH1WYYBy5jytL6N4H
 xNRcA
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

Match rockchip,rk3399-mali to default_pm_rt_data.

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


