Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C312BC5CFC1
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 10:36:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3280E10E54E;
	Fri, 14 Aug 2026 10:36:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="j5nndVoo";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FAA410E54E
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 10:36:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2B5D940C24;
 Fri, 14 Aug 2026 10:36:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 806D11F000E9;
 Fri, 14 Aug 2026 10:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786703815;
 bh=TLTSMt3dVlaVBE5gQDt5OMCyAy0P0M4s4BwBgAereRQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=j5nndVoout99Q2akG6iExCML91Yf79Dv7l30g1bbaAW+mQKMTCyS7+Fq1ZO/cjbsh
 Kc7B5D3KjEWftsTEsACxy4m6a4T88gdZn4uTkad6LpK7DQSIezrXlrDHWiZIfrgVVG
 DQHG3yYUrS3fgsoKMNXYG58SwvsOj5TQq+8B6lk99BPbAFz9Wn75jkph0SeXbjIFZq
 KRLsgBByhSPsvgupVYjH8g2Sd83ehnFm51cPdGSJQ5jlZQh1R64rV97FoPv1DkHv2N
 As08vf9z0a+wXw6HAw/GXFI1ux+Svrt8Y0UBcWAZNO6k8FfGMevvymh2HiEZ/kInK5
 KHupuu18DkRNA==
Date: Fri, 14 Aug 2026 12:36:45 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Roman Vivchar <rva333@protonmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Heiko Stuebner <heiko@sntech.de>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: gpu: arm,mali-utgard: add mt6572
Message-ID: <20260814-portable-premium-avocet-eafbe2@quoll>
References: <20260810-6572-dt-mali-v1-1-fb908627bf23@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260810-6572-dt-mali-v1-1-fb908627bf23@protonmail.com>
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

On Mon, Aug 10, 2026 at 11:16:19PM +0300, Roman Vivchar wrote:
> Add a compatible string for the mt6572 Mali-400 MP1 GPU.
> 
> Signed-off-by: Roman Vivchar <rva333@protonmail.com>

Does not come with resets?

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

