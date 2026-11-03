Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF4A606C591
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 11:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CGGniuzx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D24510F4F4;
	Tue,  3 Nov 2026 11:10:28 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C802310F4F4
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 11:10:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 977BE43C77;
 Tue,  3 Nov 2026 11:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF3D41F000C1;
 Tue,  3 Nov 2026 11:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793704221;
 bh=DttFhI0LxeH79eT/YhOIy6UMobLtyg9GPfkbGAxdi3s=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=CGGniuzx9iamA1AwRWMQ1/ltNGuso7AezbHqZvG0a82iiXHiwroTbFy0Yv0D2P56V
 /i8XebYAe+VzhNJoc21a+OLWcTzWVY4BArMpFynRoK/OIafQa3PAxXjLB4Yk+zcHlG
 prmDed2NkkYSSKO+ndsUIqitcgo5/TEWdZTJqYCP5oUqCTS9XNMiPy6dfbV5UjSe92
 jJWEsLg05NYuiRk6y1ILq5wze+65C5pZ1TWCYp2JmkkJBrnPFPHNVkmZoZr54t37Hf
 7uSsVgkIXTA61kgSFV0HcgG3O9l9UZ79fY+oIXA4P8X06WrasZ5jU663w/uNuuzutz
 Bly/TlxMd8lqw==
Date: Tue, 3 Nov 2026 12:10:18 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, 
 Matthias Brugger <matthias.bgg@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-mediatek@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org,
 stable@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: [PATCH] phy: mediatek: hdmi: use devm clock provider registration
Message-ID: <20261103-jumping-nostalgic-mussel-1fddcf@quoll>
References: <20261103104241.1373838-1-vulab@iscas.ac.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261103104241.1373838-1-vulab@iscas.ac.cn>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On Tue, 03 Nov 2026 10:42:41 +0000, Wentao Liang wrote:
> mtk_hdmi_phy_probe() registers the PLL clock provider with the
> deprecated of_clk_add_provider(), which takes a reference on the device
> node.  The driver has no .remove callback, so neither the node
> reference nor the provider registration is ever released; after the
> device is unbound, the global provider list still points at the freed
> hdmi_phy and at the unregistered clock.
> 
> Register the provider with devm_of_clk_add_hw_provider() and
> of_clk_hw_simple_get(), matching the sibling MIPI DSI PHY driver, so
> that it is removed when the device is unbound.
> 
> Fixes: be28b6507c46 ("drm/mediatek: separate hdmi phy to different file")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/phy/mediatek/phy-mtk-hdmi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Multiple things here:
1. Your team ignored completely previous feedback. Multiple times.

2. You use multiple identities with this email address, thus I doubt that we
   speak with an actual person.

3. Your bot does not even bother running checkpatch, right?

4. Nothing of this was reproduced nor tested.

5. Finally, the same feedback:
You sent multiple independent patches, to multiple independent
subsystems. The amount of these patches clearly suggest this was
AI generated and most likely not tested.

More importantly, you sent all this work without properly organizing
relevant patches into patchsets. This makes reviewing difficult
and might cause multiple reviewers to address the same issue.
Replying to the entire set is impossible and requires handling each
patch independently, instead of applying or discarding the set.
Maintainers also won't see the bigger picture of your work. Quite
worrying.

This is on the verge of hostile patch: bomb us with so many
contributions, we won't be able to handle them in efficient manner,
like responding ONCE to ask you to slow down.  Considering all this
is untested and LLM generated, I have even more doubts whether this
should be considered for review.

Please read kernel documentation BEFORE posting more work. It will
explain you how to identify subsystems, how to organize your work per
subsystem (so a patchset grouping multiple patches with a short cover
letter), how to document the issue discovery method and what was
or was not tested.

Best regards,
Krzysztof




