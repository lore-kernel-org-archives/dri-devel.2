Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0061FC79FB6
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 16:52:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45EC310E1E9;
	Wed,  9 Sep 2026 16:52:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KkhMoR6G";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FB9410E1E9
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 16:52:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 86590600CB;
 Wed,  9 Sep 2026 16:52:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B32791F000FF;
 Wed,  9 Sep 2026 16:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788972775;
 bh=GmlMljZT/6fO26V/fEoR8ernMpnUFy1iAPY7wr0dQNs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=KkhMoR6Gs7IooOaJd6DKs7tUqWc1jCblWwWBcebrdQphPcJfx9IHywVG0VVdPQcZr
 Ujc+1ZiZDZsZBo0BrfVxc7W0Z7wbJxsVToSLW6b854TSdi/sJPu6STLcXEmkiKy4TS
 3nkPhpQ1Bl7Z4P9RYdUWzulpKKMbSG40E8yaol2K0HHfVSpDN1gMbN6cbgpBTs9QIy
 VDePMdyerGmnffIQvv6WecoqTTaLEzerfhfu6+Vu58/WBqIxA/6IEgxAWNKrGKLnDG
 JgHQbPwgWlMwEFPoMtfE1bMTTELWNN7XggB/FHAP+91OztVhKa6hS689YxKChFNb7r
 SkgQHw+GkfxQA==
Date: Wed, 9 Sep 2026 18:52:45 +0200
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
Subject: Re: [PATCH v3 02/12] phy: phy-mtk-dp: Rename regs to regmap in
 struct mtk_dp_phy
Message-ID: <wvjid3xethoskbttbgy3oy3j7fxnonrnzqg7pqndn32skzp4bt@2q7svyz6ojr7>
References: <20260707154245.198361-1-angelogioacchino.delregno@collabora.com>
 <20260707154245.198361-3-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260707154245.198361-3-angelogioacchino.delregno@collabora.com>
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

On Tue, Jul 07, 2026 at 05:42:35PM +0200, AngeloGioacchino Del Regno wrote:
> In preparation to perform further cleanups and to extend the
> driver to support more SoCs, rename the `regs` member to `regmap`
> to improve readability, as this is a common name across many
> kernel drivers for a struct regmap.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

- Mani

-- 
மணிவண்ணன் சதாசிவம்
