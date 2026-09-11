Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 376DFC88E42
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 05:17:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A3B610ED4D;
	Fri, 11 Sep 2026 05:17:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aMmIbpxI";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEAE710ED4D
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 05:17:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B574E42DBE;
 Fri, 11 Sep 2026 05:17:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DD391F000FF;
 Fri, 11 Sep 2026 05:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789103854;
 bh=MyiTj6alOlQUBpvVanvP3WSeuGMqb9NQa3cYxb5z/kE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=aMmIbpxIlWoNOpEzY53NE/GrzWX+ITjvAwiJ7k5RzH99owz9sqGHfCEeLVJPVvxvv
 fRWfuu4jGHGC1Ko9r6fwd+l4+bOy1buyVW6OEnHr8TWj4nk/LxxPj6Fex1qDUHAX5x
 +ZZE9k27z55QOAD/QshaCbFnnrRubk6JRkjIQJPK9Rw+Zkt8V+b2Gwb8YnJojhMgKQ
 8SvJUxn2oFJGW4K132CNUODpE//NcdEiY5I0E3xjInfVyGt8QTt2dbYRTVJ8781qmp
 hNdmRZLdRTQsMtt26u2Ld6uNShYjV0sR5e8h4smj/N0HGDGY5D7z7PCPBjUZYnAEZm
 TEX3nnBAlS2xg==
Date: Fri, 11 Sep 2026 07:17:25 +0200
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
Subject: Re: [PATCH v4 05/12] phy: phy-mtk-dp: Implement power_on and
 power_off PHY callbacks
Message-ID: <woh776xuf7vavnb55lrup6runersvwtw5hkauarjn3rzfuu5sx@n5b5tjt3firs>
References: <20260910092038.48291-1-angelogioacchino.delregno@collabora.com>
 <20260910092038.48291-6-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260910092038.48291-6-angelogioacchino.delregno@collabora.com>
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

On Thu, Sep 10, 2026 at 11:20:31AM +0200, AngeloGioacchino Del Regno wrote:
> Add .power_on() and .power_off() callbacks to mtk_dp_phy_dev_ops
> to be able to call those with phy_power_on() and phy_power_off()
> API in the DisplayPort driver to be able to stop using all of
> those hardcoded register writes in that external driver.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

- Mani

-- 
மணிவண்ணன் சதாசிவம்
