Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC738C43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 16:06:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A77D10F4C4;
	Thu,  2 Jul 2026 16:06:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DHQTcIT7";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95C4510F4C4
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 16:06:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 478ED40B5C;
 Thu,  2 Jul 2026 16:06:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05A8C1F000E9;
 Thu,  2 Jul 2026 16:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783008399;
 bh=FdiEJFtT0kqS3cyVxjbGZsrY1s23jlTrmELtXFowl7Y=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=DHQTcIT7fff9Y6gIRWfR8XGoRaEQoNmsp/gCoyqVpVxNWNlAUuADER8JPHn4G5dOo
 lnTqZPnGHPlLrWTgKwflradkQqaucyM+KJxRNV8FkXIIHLIz/DP1y0neOSHFWKXk4W
 LTd3x8UVK0E9HZVMCUPH07frmttXxv2Dm54UlG9ca9xuQ4u2MCFPsKTi38zmfIF3+H
 xdRrnKDFMAQ3oG6m9RTPs4DYqbT8FnsKyGuMSPfjvkQjrRky/dXibnk6FnS+SDzg0H
 D5pPflShQOzyh1vNOYxNNpE3AI5TRNRqlg/zAhVKNNN93jK80OVqbGikeRLCDcPW07
 66YGdHgpmV8KQ==
Date: Thu, 2 Jul 2026 11:06:38 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>
Cc: devicetree@vger.kernel.org, Joey Lu <a0987203069@gmail.com>,
 Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Simona Vetter <simona@ffwll.ch>, Conor Dooley <conor.dooley@microchip.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 David Airlie <airlied@gmail.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v2] dt-bindings: display: verisilicon,dc: make resets
 non-optional
Message-ID: <178300839743.195775.5904192106959239550.robh@kernel.org>
References: <20260702054804.164820-1-zhengxingda@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702054804.164820-1-zhengxingda@iscas.ac.cn>
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


On Thu, 02 Jul 2026 13:48:04 +0800, Icenowy Zheng wrote:
> The only variant supported by the binding now, the DC8200 controller on
> T-Head TH1520, requires three reset lines.
> 
> Add the reset properties to the required list to clarify this. The
> in-tree th1520.dtsi file isn't affected by this change because the reset
> lines are already populated there.
> 
> The driver still considers the resets optional, so if another variant
> with no reset line appears, only the binding needs tweaking.
> 
> Signed-off-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> Changes in v2:
> - Fixed wrong reset line count of TH1520 in the commit message (Thanks
>   to Sashiko).
> - Added Conor's R-b.
> 
>  Documentation/devicetree/bindings/display/verisilicon,dc.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Applied, thanks!

