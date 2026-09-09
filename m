Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2548C79FBD
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 17:06:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E486210F1E6;
	Wed,  9 Sep 2026 17:06:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="I05C/y3R";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D29810F1E6
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 17:06:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CA377601EF;
 Wed,  9 Sep 2026 17:06:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3355E1F000FF;
 Wed,  9 Sep 2026 17:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788973596;
 bh=tEGujVrnh45aRHa6TGYv0vK65BrEMTGrkS+B+KBLQdY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=I05C/y3RGAUYs8rLS+AVasAowNXB0L71hpYAq6erADUXn5hHQkhD+0+xtK7cpCsFX
 Tlg4o87zyOadC7pg8Zqfvrpa4NWWwtzsEjHVzbJvRHmZ3589sP1HNv4m90tU5iPCVc
 gB8dR2YKj9bZRHjqnSn44gva1V3e5jNI1wf4Z/VMyno3eylGdGRwsNncBxZXN+//yw
 15YtQvmp0YemRPV6GYgQ5SjxP5ZGE13+YXTRvm1urVIwEg97CY6xYzzTqRKeDQioUe
 eP26eJBDjf1MDrLEkTNvR/RTG6pdANv7Nzs/s3fCwGgeyalvTl+kQrZOd757ld1QFn
 LzyeefD/yNBHQ==
Date: Wed, 9 Sep 2026 19:06:27 +0200
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
Subject: Re: [PATCH v3 04/12] phy: phy-mtk-dp: Migrate register offsets to
 SoC specific pdata
Message-ID: <42rp4gtodsf35nqkabudeskzxxdfsrhvsyug74i536cuyrhjfz@puo46jjfbnf7>
References: <20260707154245.198361-1-angelogioacchino.delregno@collabora.com>
 <20260707154245.198361-5-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260707154245.198361-5-angelogioacchino.delregno@collabora.com>
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

On Tue, Jul 07, 2026 at 05:42:37PM +0200, AngeloGioacchino Del Regno wrote:
> In preparation for adding support for newer SoCs and for adding
> more capabilities to this driver in an efficient manner, migrate
> all of the hardcoded register offsets to SoC specific pdata and
> assign that for both DT and platform probing.
> 
> While at it also cleanup writing the driving parameters to the PHY
> by iterating through all lanes with a loop instead: note that for
> that to happen the default 0/1/2 driving parameters were added,
> those are really just zero.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

- Mani

-- 
மணிவண்ணன் சதாசிவம்
