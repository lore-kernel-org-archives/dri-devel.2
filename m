Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F618C53219
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 14:35:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2E2210E921;
	Tue, 28 Jul 2026 14:35:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="DPK+/krd";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81B9210E941;
 Tue, 28 Jul 2026 14:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1785249315;
 bh=hi1tKX7EjWI5J4ogBRa8uDUOJpWIFZD5uMblt8+TA5k=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=DPK+/krdDGlW7ypWcXs70J7Jg8Jj6H0ImjrHo+kXM1WxxwL+PLT5nx/uEDQ37DF40
 1IH8wxxUKt6EI+kKy0MjO8C49AQVHXzDIDxFes5kCh1AjiAQ7W5U/bXJRgaX8tX5mN
 kZNmv4AhGPoy8l7KsfYTWg9ov0d/nOniJuBkXgTij2wQlUWUKYDYJG0s0WEJzQDsIA
 98CF5QL+cilwXgIa4ooFhHpv3CxgOf4Vwl9dJdZXog8W0mMKqUiE+fgRSvjmh3/QUe
 aq32xyjL9IrjIhUP3y6Qs9O6Xh2cidVT9N2W/uyLMBowLMlwJ8f3hQhz4oiKa9EF6/
 Ed/RZScjTs39A==
Received: from IcarusMOD.eternityproject.eu (unknown [100.64.1.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: kholk11)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 7321417E019E;
 Tue, 28 Jul 2026 16:35:14 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 Alessio Belle <alessio.belle@imgtec.com>, 
 Luigi Santivetti <luigi.santivetti@imgtec.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Chen-Yu Tsai <wenst@chromium.org>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 imagination@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Icenowy Zheng <zhengxingda@iscas.ac.cn>, 
 YoungJoon Lee <getfeus@gmail.com>
In-Reply-To: <20260728091804.382753-1-wenst@chromium.org>
References: <20260728091804.382753-1-wenst@chromium.org>
Subject: Re: (subset) [PATCH v4 0/5] powervr: MT8173 GPU support
Message-Id: <178524931441.575499.11268846943253988242.b4-ty@b4>
Date: Tue, 28 Jul 2026 16:35:14 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
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

On Tue, 28 Jul 2026 17:17:58 +0800, Chen-Yu Tsai wrote:
> This is v4 of my MT8173 PowerVR GPU support series.
> 
> This time around Mesa was ready for basic testing, using both vulkanmark
> and glmark2-es2-drm (with Zink). Details below.
> 
> Changes since v3 (all in the clk driver patch):
> - Changed pm_runtime_put() to pm_runtime_put_sync()
> - Added missing of_node_put() in remove function
> 
> [...]

Applied to v7.2-next/dts64, thanks!

[4/5] arm64: dts: mediatek: mt8173: Fix MFG_ASYNC power domain clock
      commit: 3549c85d4c0e942d3ac9972a6b35ce0078bd3550
[5/5] arm64: dts: mediatek: mt8173: Add GPU device nodes
      commit: 75bfd9e7cdae0ae04dbaaf8dfc487adb67b7680e

Cheers,
Angelo


