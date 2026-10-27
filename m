Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7A0606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 10:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fsJE9jML
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D52910F3C5;
	Tue, 27 Oct 2026 10:58:25 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E65B10E384
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 10:58:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E753B40489;
 Tue, 27 Oct 2026 10:58:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16AD01F01825;
 Tue, 27 Oct 2026 10:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793098698;
 bh=t2rRGjis0tX3mVaRPFtnMjzTG3I2WSVMvjKzLMjEe8o=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=fsJE9jMLq8OFD4KXLiAX+9c4xeC8pJCmA0DcxoyOE0E/vIUAdOGjHE/oC7pYCZj7z
 GlfD2yaO7j1Fm/xru2hu+VOCINZQk3tqcX16kriIRn2utAQwFvbtkhXw1d4UqLwFp4
 u6IPkNYa+vuk/FUKW+XrELP21x604V54XY/NNq1OR4h0Oi4/BEjf5sYuUr6RRnepZT
 X8bU2lucOR3altcjmmBPEAh6ZX4xC2IGJ53ZuEuGtWsvspjhgW8u891VRLhDccuCCR
 cpiuGVOM3lF90FzL2xc+yWTVtttmND3Fgt/Id4IIPPb6zPN3WEK34My1421KPNxyWb
 WzVvReZAaqwyA==
Date: Tue, 27 Oct 2026 11:58:15 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Olivier Louvignes <olivier@mgcrea.io>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Jessica Zhang <jesszhan0024@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Paul Cercueil <paul@crapouillou.net>, 
 "H . Nikolaus Schaller" <hns@goldelico.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, 
 linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] dt-bindings: vendor-prefixes: Add HiBy
Message-ID: <20261027-controversial-astute-leopard-5b353d@quoll>
References: <20261025191640.13592-1-olivier@mgcrea.io>
 <20261025191640.13592-2-olivier@mgcrea.io>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261025191640.13592-2-olivier@mgcrea.io>
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
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Oct 25, 2026 at 08:16:36PM +0100, Olivier Louvignes wrote:
> HiBy makes digital audio players, among them the R1.
> 
> Signed-off-by: Olivier Louvignes <olivier@mgcrea.io>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

