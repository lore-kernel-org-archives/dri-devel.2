Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54DCBC79FBD
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 17:24:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63C2510E221;
	Wed,  9 Sep 2026 17:24:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GpMURs6m";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 914B110E221
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 17:24:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4C22D414F4;
 Wed,  9 Sep 2026 17:24:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF4D61F00893;
 Wed,  9 Sep 2026 17:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788974645;
 bh=H308Fze0XRt9N+Ri5zLt+4vWDFRB8Aw2ZkYI3hwsFW4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=GpMURs6mvtA/GGO6Qq64gTORmYhXiY0sEas28tbjcuZd7L1O2z1/TN98BsQCKtGa5
 xKJiii3dzXSjojd9xT50qH9b6BFigiOmanQlEfy3u1VIbr0UzOdXD5URi6ED0Ca0sT
 rQw6KsLXq8Xee8gKMJN71Hyx7dYBnzUpZ6wDiV+XPabmmLhcOCipNaVb9czOb757EI
 AUpP+W6nhnrG3Lclz/P+vrydIU3DnKmDfeu3vGPfeeGLWeEC0oPMZZVADj1SjsaBhy
 3fchyCWAx5BefCPvx34AaJ2PazeIg/Yuc05eblEEeKq+12JifaPo/CS2/ZCVfTYD5c
 VG+I6y30p6puQ==
Date: Wed, 9 Sep 2026 19:23:55 +0200
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
Subject: Re: [PATCH v3 10/12] phy: phy-mtk-dp: Add bitrate register val
 definitions to SoC data
Message-ID: <mmkzupat6ef423xnsd5hspcs4rzjxs223mr5n4qetpjltbeoer@sxsxpeqrd5tt>
References: <20260707154245.198361-1-angelogioacchino.delregno@collabora.com>
 <20260707154245.198361-11-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260707154245.198361-11-angelogioacchino.delregno@collabora.com>
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

On Tue, Jul 07, 2026 at 05:42:43PM +0200, AngeloGioacchino Del Regno wrote:
> In preparation for adding support for the eDP PHY found in newer
> SoCs, transfer the bitrate register value definitions to SoC
> specific data.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

- Mani

-- 
மணிவண்ணன் சதாசிவம்
