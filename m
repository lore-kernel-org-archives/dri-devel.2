Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C3B6C982E1
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 10:21:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58BA010E05D;
	Mon, 21 Sep 2026 10:21:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="m01RtQig";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33D9F10E4BB
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 10:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1789986071;
 bh=uw5pdRN2Q9JJj2+CbK1XOe8tJnBuwe3/GQzFs3S+ECE=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=m01RtQigaCGmATt3Z2RO+l2X3jp6emasy4I7DqrplE+e2RosUCFD10dMp2AviNqgF
 CgRL9VAzG34cRLpnhKETmKpvh7tqDrrWrklo486vc8A7FcQFsR/A2WqIvW11KZnPLR
 QZvz89UsDAdHgnB80XALmbEbX6MZAkmC8aT2ymc+lHhK2C8NRUBS9sUL4lKZG4aiAD
 o+f09zXHEypzLxAYdSFPm73tA8UiDgFytinUCifu7xAggNaqcCEgLHIHkOgyeEVM6L
 QeY8HY3C5i5Q+FujPosjf7l9UxTcLI4Sb9jBfuZ04qFfrVXKLcTEbzi+Jtkw5a8n0P
 vEtd2aLg3S1Wg==
Received: from IcarusMOD.eternityproject.eu (unknown [100.64.1.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: kholk11)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 49F6217E03B6;
 Mon, 21 Sep 2026 12:21:10 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: linux-mediatek@lists.infradead.org, 
 Luca Leonardo Scorcia <l.scorcia@gmail.com>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, CK Hu <ck.hu@mediatek.com>, 
 Jitao shi <jitao.shi@mediatek.com>, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org
In-Reply-To: <20260918175736.355305-1-l.scorcia@gmail.com>
References: <20260918175736.355305-1-l.scorcia@gmail.com>
Subject: Re: (subset) [PATCH 0/4] Add support for the mt8167 display pipeline
Message-Id: <178998607025.21155.9680834242820851509.b4-ty@b4>
Date: Mon, 21 Sep 2026 12:21:10 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0
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

On Fri, 18 Sep 2026 19:55:24 +0200, Luca Leonardo Scorcia wrote:
> This series adds support for (almost) all display blocks of mt8167.
> This SoC supports a DSI or DPI display and has HDMI output via a second
> DPI block wired to the HDMI phy.
> 
> All the hard work was already upstreamed in the past, now all that's left
> is some glue. In the first two patches we add support for the DPI output
> blocks. In the third one we describe all the possible combinations of the
> SoC display pipeline and in the last one we add the required nodes to the
> SoC dtsi.
> 
> [...]

Applied to v7.3-next/soc, thanks!

[3/4] soc: mediatek: mt8167-mmsys: add routes for all display paths
      commit: ae0968038f994d6e275f5dc94a27325ee751fe58

Cheers,
Angelo


