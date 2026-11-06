Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7353606A329
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 12:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bUF+clmx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EDBF10E400;
	Fri,  6 Nov 2026 12:58:13 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06CF610E400
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 12:58:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F1815605D7;
 Fri,  6 Nov 2026 12:58:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2B8B1F0089F;
 Fri,  6 Nov 2026 12:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793969885;
 bh=sxXe+GvkQh1xmVF/fKR+0ndQLjKjrvqGNJZAq6NZqcU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=bUF+clmxKVm/xlk6EhYYDQ9fPSzkeEfppKDprBr30uWIBS+fTHM1uqm8veGa+8VIL
 urF8A+YRSqqvi/HQp4nEr7ZzoGPlcBv3J90nLzVOG9SOmYQS/PiHyY4CjzpYayNTk4
 sDiZVM14ROVI7KP3u3aNLnW/hgHOpy8xk2Yh6xFjVQKcPZqdHq5dyOfJPfnY/y8h0t
 ns+2z/ndqmP6PFhZLqO1hfsVJMOiS8/y2vWYGvSRFpyALfu3f5AYc1EwHXsw7kKnT+
 yiDIv62EitLzTDzI9kbtLjdt2gkbX5w4L4cm7EidKtCnrNquO9R+Yy30vLr1w+fPlr
 uoloAf1vt5kqw==
Date: Fri, 6 Nov 2026 13:58:02 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Romain TISSERAND <romain.tisserand@gmail.com>
Cc: Igor Reznichenko <igor@reznichenko.net>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH 1/4] dt-bindings: vendor-prefixes: add PocketGo
Message-ID: <20261106-gentle-shrimp-of-weather-dde4f4@quoll>
References: <20261103110524.2812831-1-romain.tisserand@gmail.com>
 <20261103110524.2812831-2-romain.tisserand@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261103110524.2812831-2-romain.tisserand@gmail.com>
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 03, 2026 at 12:05:21PM +0100, Romain TISSERAND wrote:
> PocketGo is the brand of handheld game consoles such as the PocketGo S30

Vendor prefixes are for companies and I cannot find anything about
PocketGo, except it is a brand. What's the website?

> (Allwinner A33).

Best regards,
Krzysztof

