Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D419CC88E42
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 05:18:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1038B10F282;
	Fri, 11 Sep 2026 05:18:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aqvcKu/5";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BD2410F4E6
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 05:18:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4928740C34;
 Fri, 11 Sep 2026 05:18:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7C881F000FF;
 Fri, 11 Sep 2026 05:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789103889;
 bh=brPo4LHaJaLSQ5NoCpOmZMudeFP07TbwWeUS06ea0xk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=aqvcKu/50z0Q96RozxSVN2FCdJdj60wTAr+738VbyA9chsWD71lUxzKnIs+yoGY7S
 lEWPR/C7GNFg0HSkz8sLhVy1OiVP6ONFn13ib8TbMVnWooQ+p8iSvpLP7HPu2LQ0Ao
 q1hOxnrFscLx1AXpKtk88OpR8hFFc1nrfhhMp5Tzpy3FuLjCrQMPVUpvcEQ/lvjbtH
 vtjBbWr99tOWxAToIVCJsWuiIduPaPmKfM4SSmd6WDu2tgu0B0YxSd1ivFCAryqHsX
 jlzL5ItD249IblNuD1iFSky513g56hkWiQHujSEmwKf+lCKcDiluSw6XSjxIJxI01m
 pY0oEvzAZJ23A==
Date: Fri, 11 Sep 2026 07:17:59 +0200
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
Subject: Re: [PATCH v4 06/12] phy: phy-mtk-dp: Support set_lanes in configure
 and properly cleanup
Message-ID: <d3qbwzwoqshalixhg2t32zuecstiy6uingyc4b4r6wmwcg6ggj@z2movep2kk52>
References: <20260910092038.48291-1-angelogioacchino.delregno@collabora.com>
 <20260910092038.48291-7-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260910092038.48291-7-angelogioacchino.delregno@collabora.com>
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

On Thu, Sep 10, 2026 at 11:20:32AM +0200, AngeloGioacchino Del Regno wrote:
> Add support for enabling a specifically requested number of lanes
> in the .configure() callback and disable all lanes in power off
> and reset callbacks for proper hardware cleanup.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

- Mani

-- 
மணிவண்ணன் சதாசிவம்
