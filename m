Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59915C5CFEB
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 07:04:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 827A910E367;
	Thu, 13 Aug 2026 07:04:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="D5i0th3p";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B5B910F1A8
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 07:04:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EECED40764;
 Thu, 13 Aug 2026 07:04:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86A561F000E9;
 Thu, 13 Aug 2026 07:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786604686;
 bh=UgWct9UeMHk4UFxQ8VlRHLlm0oUzUbQW0gcOeCF6jPk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=D5i0th3pYQMKiwMgNEoa1BpFL/0SSTZCFcvB9XduSctmIHD/XE/DkxQV4Hb7t7a3O
 jcxUPx+tHbFnXa51HVopZLAEfDmBsjpBtNo3qvptbCeOEEgvKGX2MwwGT9+/1Rwo1r
 Q+J+xq4+PAlB/1EFWPzaSKkl4bQoY0zvPu9cHv8wDrkV0FU/JNZpAUWOkf3jjPHX+x
 sv5BgEshyQkr4CuXPXvHydzBfpfl0ZvKdkoLFhbTS8o4N2AZyciqNqqPqU7GsZ5jAG
 UpJf5rlnBsuOyUvognZ0TKCPqnHlFtH7r9mXCA/fhoukVVrA2FcnkbYsxZXIXRrltP
 bRrcKN9+xOjKg==
Date: Thu, 13 Aug 2026 09:04:37 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jiaxing Hu <gahing@gahingwoo.com>
Cc: tomeu@tomeuvizoso.net, heiko@sntech.de, robh@kernel.org, 
 krzk+dt@kernel.org, conor+dt@kernel.org, joro@8bytes.org, will@kernel.org, 
 robin.murphy@arm.com, ulfh@kernel.org, p.zabel@pengutronix.de,
 ogabbay@kernel.org, 
 zhangqing@rock-chips.com, royalnet026@gmail.com, alchark@flipper.net, 
 chaoyi.chen@rock-chips.com, diederik@cknow-tech.com,
 dri-devel@lists.freedesktop.org, 
 linux-rockchip@lists.infradead.org, iommu@lists.linux.dev,
 linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 02/10] dt-bindings: npu: rockchip: add
 rockchip,rk3576-rknn-core
Message-ID: <20260813-apricot-bat-of-vigor-65ba20@quoll>
References: <20260812094106.1391698-1-gahing@gahingwoo.com>
 <20260812094106.1391698-3-gahing@gahingwoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260812094106.1391698-3-gahing@gahingwoo.com>
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

On Wed, Aug 12, 2026 at 09:40:57PM +1200, Jiaxing Hu wrote:
> The RK3576 NPU has two cores of the same RKNN block the RK3588 binding
> already describes, but it wires them up differently: two extra CBUF
> clocks, two power domains per core, and a single reset instead of two.
> It also has no NPU SRAM supply.
> 
> Widen the property ranges to cover both, then pin each SoC back to its
> own shape in allOf so nothing loosens for RK3588, and keep sram-supply
> required for rockchip,rk3588-rknn-core only.
> 
> Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
> ---
>  .../npu/rockchip,rk3588-rknn-core.yaml        | 47 +++++++++++++++++--
>  1 file changed, 44 insertions(+), 3 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

