Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F338CD342C
	for <dri-devel@archiver.kernel.org>; Mon,  4 May 2026 10:18:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A8DA10E3C1;
	Mon,  4 May 2026 10:18:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EzpCTpPr";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F07110E3C1
 for <dri-devel@lists.freedesktop.org>; Mon,  4 May 2026 10:18:45 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id B5D27435DD;
 Mon,  4 May 2026 10:18:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06A7EC2BCF4;
 Mon,  4 May 2026 10:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777889924;
 bh=iTf7A919EfkWk9helc4UbhGI96LKBoYsGAAsbdPvufk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=EzpCTpPrKoPtROZOxYw1Sod9uFtmO0Yksc8O6pQu34LkM/bGgA9+XXXO28FZONZLz
 ZPv1Fcw7nMZSbuVOwmPfko6YGunADHOKmE10yfUMajffgLYPxslMN1cfTIFqktCSbg
 KT/ymIG2BtyEg/MytZyhjOK3jAhfs2Uyy+gMnWb+1OoziIGlgT0ltgaCv7vOTQ6vR5
 OM1bXaJZIH13gAxoNUQoJBx+ZOH0sLGEhdDoxtMSn2PjjrZlGODJJ+WOuAypAeXobY
 Jww5gmFniwFIMtwX8m++d4lW7RXeO9ewtXXlSPC99MP8oni5K+Hi7iqAyf5i4i/XjN
 y2to9bucxnWcw==
Date: Mon, 4 May 2026 12:18:42 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Devarsh Thakkar <devarsht@ti.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, 
 praneeth@ti.com, vigneshr@ti.com, s-jain1@ti.com, s-wang12@ti.com, 
 r-donadkar@ti.com, r-sharma3@ti.com, afd@ti.com
Subject: Re: [PATCH 1/6] dt-bindings: vendor-prefixes: Add Dalian Good
 Display Co., Ltd.
Message-ID: <20260504-imported-bullfinch-of-drama-4bc7b1@quoll>
References: <20260430183311.2978142-1-devarsht@ti.com>
 <20260430183311.2978142-2-devarsht@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260430183311.2978142-2-devarsht@ti.com>
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

On Fri, May 01, 2026 at 12:03:06AM +0530, Devarsh Thakkar wrote:
> Add vendor prefix 'gooddisplay' for Dalian Good Display Co., Ltd., a
> manufacturer of e-paper display panels and modules.
> 
> This prefix will be used for the GDEY042T81 e-paper display panel in
> the solomon,ssd16xx binding.
> 
> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

