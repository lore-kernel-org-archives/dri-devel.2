Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DF61CD37AF
	for <dri-devel@archiver.kernel.org>; Sun, 10 May 2026 10:17:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 720EA10E0F2;
	Sun, 10 May 2026 10:17:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LjJ8fRZC";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0B1910E0F2
 for <dri-devel@lists.freedesktop.org>; Sun, 10 May 2026 10:17:55 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 8E23342AA5;
 Sun, 10 May 2026 10:17:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5861C2BCB8;
 Sun, 10 May 2026 10:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778408275;
 bh=XZsDjQQPi2HUE3hC2AtJyS9EK9Buo3smRbbjHi0dDEM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=LjJ8fRZC+0tDaifneY6OTi/OkJWVQHW4sAB6uK3/77U8k5jom7BIm3ilGlIoIeKax
 qPfFfbxP/LUPY+ovj1zwpyJa+my8Fd/RnrHJMUQeygopBfQQBINBRSK7aL8ai2XBCp
 PJ2CozH8xdYfzSUTgoisKi7BvM8szPT9ADlGyl2GIO5GTOkQS1djX0JjMvbekdwwfX
 2jsA8zYB737XWnZtU7Lnc3Px9W2F5hekpu1tPHFvQ1fSXwNJnjSO8cIbGiacUVJKnh
 KWO2djTc+sVdOhMoZBGdWdlQbq+rHQ3fVJwzKsyst0ACh346qNUdzXPLDHEdS4kpm0
 eL2biA3i8i8ig==
Date: Sun, 10 May 2026 15:47:51 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Brian Masney <bmasney@redhat.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH v3 13/15] phy: mediatek: phy-mtk-hdmi-mt2701: use
 clk_determine_rate_noop()
Message-ID: <agBbT6YF0qXhizpQ@vaman>
References: <20260505-clk-determine-rate-noop-v3-0-f3f829fbacdf@redhat.com>
 <20260505-clk-determine-rate-noop-v3-13-f3f829fbacdf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505-clk-determine-rate-noop-v3-13-f3f829fbacdf@redhat.com>
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

On 05-05-26, 20:49, Brian Masney wrote:
> Drop the driver-specific empty determine_rate() function and use the new
> shared clk_determine_rate_noop() helper.

Acked-by: Vinod Koul <vkoul@kernel.org>


-- 
~Vinod
