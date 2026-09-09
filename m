Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86DF4C79FBF
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 17:22:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4ABB10F219;
	Wed,  9 Sep 2026 17:22:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FzZ6zHuu";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 739B110F219
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 17:22:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5B94442AD1;
 Wed,  9 Sep 2026 17:22:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E61391F000FF;
 Wed,  9 Sep 2026 17:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788974537;
 bh=TTiLgaAW8oDG8ctZ/GijkFx6Ydc/BMWX2BkNbD07Dek=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=FzZ6zHuuZr55mmH4+vSo24dCuLDTV+Favm5/kzoxEge48jXhuODYPdH5y8bEQ1l5D
 GE7FqzMWcNU7kPSglZmQeb9d8WQ4uj/x/pDYT5RFhtPs98xPNA5egwh51UQYDKWRm5
 f59ftgqJmpgIN0n2TDgmuuLGHPw9ZK5Dc0Lk1PPvk4/fur0xbMOGvxkpVpvFNr2+QJ
 o/JLBwa2e3OFVdZXYhG6JKx/w1nkV2xaAXY54cB4XjD1+n+2VhsnXrzfVTHRJ6MBFT
 p6Ic2wrme/sYDLrEfnTSsRtbS1FlMZJ9/y3Ma/4mHv+JK3fX+BQnqnrjLSTtPzdhFX
 coPAqhMgvJsdg==
Date: Wed, 9 Sep 2026 19:22:08 +0200
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
Subject: Re: [PATCH v3 09/12] phy: phy-mtk-dp: Rewrite and document default
 driving param macros
Message-ID: <ztidtis3m3g5ykkolsje2xeq7xl4gh2bbbbkxhxajorenvnkpt@yztuepbseogg>
References: <20260707154245.198361-1-angelogioacchino.delregno@collabora.com>
 <20260707154245.198361-10-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260707154245.198361-10-angelogioacchino.delregno@collabora.com>
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

On Tue, Jul 07, 2026 at 05:42:42PM +0200, AngeloGioacchino Del Regno wrote:
> Use FIELD_PREP_CONST and add nicer definitions/macros to build the
> default driving parameters for the PHY and, while at it, also add
> comments explaining what they are supposed to set in the PHY.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

- Mani

-- 
மணிவண்ணன் சதாசிவம்
