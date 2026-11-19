Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A82260A2611
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 16:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hPXLV/Ym
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8EA210E648;
	Thu, 19 Nov 2026 16:24:13 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83DEC10E648
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 16:24:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3D5D24562E;
 Thu, 19 Nov 2026 16:24:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D1111F000D0;
 Thu, 19 Nov 2026 16:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795105447;
 bh=odcg3p3L88lG9gCK3IAVBvbz/Hl37jfw4+T+d2IH0/s=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date;
 b=hPXLV/Ymhknnr1TC7THKSqp3McWXOOo/qQTtfkertJ8eIcnURYDPElWxrxFRsCHQv
 VKAD2si8hxOHsz4CRAbUluwBBa3tTp4qGvswqDr/znt5Ci9Ruj47fNRmik0t48gQ4U
 NJXlA+Nesgswxp+BvbR/HVrPHaB3/gGtq6XAfxIQugNlsV+7vklvN2qnNpAZrMU2yK
 og3FJAuNOHYnUNLBDXIo7wc0ok4Yd+8yL/BPTSI56RxZhVHf418yxjac95cGD+0iKw
 2F5UCaJGlG7cZTK0O4U0Qk/KzPBI9Di3h2WOmWV3rVOTxrvoCzck7IGcjW1MK09Ds6
 /hNMLPg/HITAA==
From: Vinod Koul <vkoul@kernel.org>
To: chunkuang.hu@kernel.org, p.zabel@pengutronix.de, 
 neil.armstrong@linaro.org, mani@kernel.org, matthias.bgg@gmail.com, 
 angelogioacchino.delregno@collabora.com, 
 Sreeraj S Kurup <sreekuttan2156239@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261102072139.3588-1-sreekuttan2156239@gmail.com>
References: <20261102072139.3588-1-sreekuttan2156239@gmail.com>
Subject: Re: [PATCH] phy: mediatek: mt8195: Check PLL driver setting return
 value
Message-Id: <179510544374.1370333.8388939289479267591.b4-ty@kernel.org>
Date: Thu, 19 Nov 2026 21:54:03 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On Mon, 02 Nov 2026 07:21:39 +0000, Sreeraj S Kurup wrote:
> The mtk_hdmi_pll_drv_setting() function can return -EINVAL when
> the requested pixel clock is outside its supported range.
> 
> Currently, mtk_hdmi_pll_prepare() ignores this return value and
> continues with PLL initialization even when the driver settings
> fail.
> 
> [...]

Applied, thanks!

[1/1] phy: mediatek: mt8195: Check PLL driver setting return value
      commit: 5597a97e4842f3c67689093e9bf1215902babf08

Best regards,
-- 
~Vinod


