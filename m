Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0618FC79F9F
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 09:20:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E89610F3BC;
	Thu, 10 Sep 2026 09:20:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="U3LPU7Fq";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C28E410F3BC
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 09:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1789032042;
 bh=kOX7qxdoIaNGQlJqEVTvsO2lJxLSfimYQdTf/38st6Y=;
 h=From:To:Cc:Subject:Date:From;
 b=U3LPU7FqStDtB5+V9vaGVzVRaJJnMV+/gztlnhvBraOeJ5ARio0gSxVaS8fvoKFUx
 Ib26O6Y6fOcJWuL6ex/ERGRqSX/iKmGy9mMf52YJPm6Cnd09WkVpDJXk/76UPnThTS
 AQi69cyYEwjx72nD7iXDDJnzH80GJk6onXFMmTrgEvnvubTCF2x+hhn1G0mMHhLMax
 a0f41u1W3zvt8YGYGE9eU0cjCQ6RwjhepjaaEPkA921oUF06rFqSp44GhldlotjPyU
 P0NO8e1D7SblJQbPC5ctg0ZW156gmzc8zcHRWIlssJXYF+Uml2OcXPrWeW300w6GbG
 F8h6Rxf12Kl6g==
Received: from IcarusMOD.eternityproject.eu (unknown [100.64.1.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: kholk11)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id C168D17E0917;
 Thu, 10 Sep 2026 11:20:41 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: mani@kernel.org
Cc: chunfeng.yun@mediatek.com, vkoul@kernel.org, neil.armstrong@linaro.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 chunkuang.hu@kernel.org, p.zabel@pengutronix.de, justin.yeh@mediatek.com,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 kernel@collabora.com
Subject: [PATCH v4 00/12] PHY: MediaTek DP PHY refactor and MT8196 eDP
Date: Thu, 10 Sep 2026 11:20:26 +0200
Message-ID: <20260910092038.48291-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.55.0
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

Changes in v4:
 - Removed error checking from all regmap_(bulk_){read,write} calls
   as those are on MMIO and can't fail (Mani)
 - Changed some of the error prints in mtk_dp_phy_get_one_cal_para()
   to dev_err_probe() (Mani, Sashiko)

Changes in v3:
 - Added missing bitfield.h, pm_runtime.h includes (Sashiko)
 - Set calibration data before registering PHY (Sashiko)
 - Enable PM Runtime before creating PHY device (Sashiko)
 - Continue poweroff if some write fails, but still return failure
   as that would be a partial poweroff anyway (Sashiko)
 - Added zero driving params to fix default calibration data setting (Sashiko)
 - Added NULL check on device_Get_match_data (Sashiko)

Changes in v2:
 - Fixed register offsets for ANA phy in MT8196
 - Set/clear FORCE_VOLT_SWING_EN bit when configuring and resetting
   the voltage swing registers
 - Fixed endianness issue in call to nvmem_read_u16 (Sashiko)
 - Added early exit during lanes disablement if none are enabled to
   avoid out-of-bounds bitwise shift (Sashiko)
 - Removed useless call to pm_runtime_get_sync() in probe(), which
   also fixes issues pointed out by Sashiko
 - Fixed wrong dig vs ana register array usage in power_on/off (Sashiko)


This series performs major refactoring on the MediaTek DisplayPort PHY
driver, makes it probe with devicetree instead of getting registered
by the mtk_dp DRM driver, adds power_on/off() callbacks, and honors
the phy configure opts' set_lanes and set_voltages for, respectively,
varying the number of lanes and setting the voltage pre-emphasis and
swing on the PHY, for each lane.

This driver now also properly gets the PHY (EYE) Calibration Data from
NVMEM (eFuse array) if provided, instead of getting it (improperly)
injected by the mtk_dp driver.

Additionally, all of the driving parameters calculations and most of
the other register definitions were refactored to greatly enhance the
human readability of this code.

As a last step, this also transfers the register offsets for both the
digital and analog phy registers in arrays assigned to soc specific
data, in an effort to both introduce support for new minor revisions
of the MediaTek DisplayPort PHY and to have a clearer view of the
register related differences between those (for example, it is easily
understandable that the analog part remained exactly the same between
MT8195 and MT8196, but the digital part gets a slight update).

Speaking of which, as a last step, this also adds support for the
MT8196 SoC (and its derivatives), which uses this PHY only for its
Embedded DisplayPort (eDP) IP (spoiler: the DP one seems to be way
too different and requiring an entirely new PHY driver).

In this state, this driver can also easily support the MT8189 SoC
with a few lines of code: even though I do have clean code to add
support for this one, I was not (*yet*) able to test it on upstream
based kernels, and for this reason I decided to leave that one out
for now (but it's coming later for sure).

NOTE!
Despite all the apparently breaking changes in the refactoring, full
compatibility with older MTK_DP driver and with old devicetrees was
retained and carefully tested on multiple platforms!

P.S.: I am aware of the BUILD_DRIVING_PARAM_0( 0, 2, 4, 7) checkpatch
warning and I didn't fix it in bigger favor of human readability.

AngeloGioacchino Del Regno (12):
  dt-bindings: phy: Document MT8195 and MT8196 DisplayPort PHYs
  phy: phy-mtk-dp: Rename regs to regmap in struct mtk_dp_phy
  phy: phy-mtk-dp: Allow probing with devicetree match
  phy: phy-mtk-dp: Migrate register offsets to SoC specific pdata
  phy: phy-mtk-dp: Implement power_on and power_off PHY callbacks
  phy: phy-mtk-dp: Support set_lanes in configure and properly cleanup
  phy: phy-mtk-dp: Support setting volt swing and preemphasis values
  phy: phy-mtk-dp: Add support for digital and analog calibration
  phy: phy-mtk-dp: Rewrite and document default driving param macros
  phy: phy-mtk-dp: Add bitrate register val definitions to SoC data
  phy: phy-mtk-dp: Add PHYD Lane EN register mask to SoC data
  phy: phy-mtk-dp: Add support for MT8196 eDP PHY

 .../bindings/phy/mediatek,mt8195-dp-phy.yaml  |  77 ++
 drivers/phy/mediatek/phy-mtk-dp.c             | 832 ++++++++++++++++--
 2 files changed, 812 insertions(+), 97 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/mediatek,mt8195-dp-phy.yaml

-- 
2.55.0

