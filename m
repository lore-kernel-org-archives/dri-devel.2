Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED44EC79FA1
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 05:15:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3ED9F10E36B;
	Fri, 11 Sep 2026 05:15:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IJUV/GsK";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3534810E36B
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 05:15:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D612A409FE;
 Fri, 11 Sep 2026 05:15:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4014D1F000FF;
 Fri, 11 Sep 2026 05:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789103735;
 bh=Re4OuRwLxErTc9uR7CpD1jNt1FFENy/RKFyXLL/LfjI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=IJUV/GsKHHvt9HrUKFv1KLSB1qHKzOiUQX8PYVGxYjP+6GKODDx7yyMP2zHhC8/SW
 pczlz20cM18LzibHOMKTJJ8JMfBfaa2hBQDetiD/d6mwq3/zOQ0fxw0D++FV7Ln9r6
 +/8mdx3vSyGNbwTtqZIV30bThMaYlkK3LpH8vX7btR4mqJJwU53jOgnmFNMp0CyvlY
 cPS5nP6kVuu7BGd5lWQx+YM8Ou8zQUPN0jwZ7XBBXaxFJ51Q/JLhf+QKzF4MpDWD2k
 zTnR69WtvBkinYcgt51aN5lJ87ZtRqhRwjJM3oyJeM4UOvtEXGa+bkzfnH+AAMXdzb
 6A53O1yu12W8Q==
Date: Fri, 11 Sep 2026 07:15:26 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: chunfeng.yun@mediatek.com, vkoul@kernel.org, neil.armstrong@linaro.org, 
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, 
 chunkuang.hu@kernel.org, p.zabel@pengutronix.de, justin.yeh@mediatek.com, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, kernel@collabora.com
Subject: Re: [PATCH v3 11/12] phy: phy-mtk-dp: Add PHYD Lane EN register mask
 to SoC data
Message-ID: <m3fpa2igwmsnsxhhxtg5hubsmxbn2vmzcpo4hwacs66z52x5ll@xrl5kac2qmtk>
References: <20260707154245.198361-1-angelogioacchino.delregno@collabora.com>
 <20260707154245.198361-12-angelogioacchino.delregno@collabora.com>
 <cydeh263kd5o2un27oeplqx2phe7vzhxvk53kr7dbvtplazafv@rs37qtkhguhj>
 <4e658914-7a17-444b-b20b-8d8b647238b5@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4e658914-7a17-444b-b20b-8d8b647238b5@collabora.com>
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

On Thu, Sep 10, 2026 at 11:05:39AM +0200, AngeloGioacchino Del Regno wrote:
> On 9/9/26 19:25, Manivannan Sadhasivam wrote:
> > On Tue, Jul 07, 2026 at 05:42:44PM +0200, AngeloGioacchino Del Regno wrote:
> > > In preparation for adding support for the eDP PHY found in newer
> > > SoCs, transfer the register mask for PHYD_TX_LN_EN to SoC specific
> > > data.
> > > 
> > > Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> > > ---
> > >   drivers/phy/mediatek/phy-mtk-dp.c | 13 +++++++++----
> > >   1 file changed, 9 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/phy/mediatek/phy-mtk-dp.c b/drivers/phy/mediatek/phy-mtk-dp.c
> > > index 4603f28d1466..f5aadc5fdc42 100644
> > > --- a/drivers/phy/mediatek/phy-mtk-dp.c
> > > +++ b/drivers/phy/mediatek/phy-mtk-dp.c
> > > @@ -220,6 +220,7 @@ struct mtk_dp_phya_imp_sel {
> > >    * @regs_ana_lane:  Register (layout) offsets for ana_lan
> > >    * @regs_dig_glb:   Register (layout) offsets for dig_glb
> > >    * @regs_dig_lane:  Register (layout) offsets for dig_lan
> > > + * @mask_dig_tx_ln: Register mask for PHYD_TX_LN_EN field
> > >    * @val_dig_bitrate:IP Version specific register values for Bit Rate setting
> > >    * @ana_bias_r:     Internal resistance "R" Selection Settings (global)
> > >    * @ana_cktx_imp:   TX Clock Impedance Selection Settings (global)
> > > @@ -239,6 +240,9 @@ struct mtk_dp_phy_pdata {
> > >   	const u8 *regs_dig_glb;
> > >   	const u8 *regs_dig_lane;
> > > +	/* Register masks */
> > 
> > Duplicate comment. With this removed,
> > 
> 
> Sorry but I think you didn't understand what the comments are there: the kerneldoc
> is used to describe the structure, of course, but the comments in between are used
> as a way to describe (and kind of enforce) the order of members.
> 
> /* Register offsets */
> u16 member1;
> u16 member2;
> ....
> 
> /* Register maps */
> const u8 *regs1;
> const u8 *regs2;
> ...
> 
> /* Register masks */
> u32 mask1;
> u32 mask2;
> ....
> 
> etc.
> 
> Does that make sense now? :-)
> 

Yes it does. Sorry for the oversight

- Mani

-- 
மணிவண்ணன் சதாசிவம்
