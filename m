Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91436C88E50
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 10:14:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6A9810EC51;
	Mon, 14 Sep 2026 10:14:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="a5NLQ/Od";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD9E110E191
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 10:14:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C4327601EF;
 Mon, 14 Sep 2026 10:14:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E9BB1F000FF;
 Mon, 14 Sep 2026 10:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789380856;
 bh=50Ab5hgRM3J+T1RQ+KqVdIaeqjJu0Jhurl0zuN8lli4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=a5NLQ/Od9aoxLSn7RFt6Rh4GdF+QEP9wSGi7MiaVvDuVs1p0VVbK1KLEAnGmeDHeI
 y+RZXoaGQt/Jied7/1sMcrVfyv92ByAWk9d1v06Pqs7YjR7TMHeBiUv9FUyWZvLEBh
 20wT0IvMCpbm/U6v1ptX9x69kRMWA+4YNav8yH2uz6dXRmUsou2RhLp65dgNGw1gI/
 MgmsPMnN3VnmRS54wtnztO7i9bysAs6R0EF6kuGj0hB3oTk83+tQVYsVg20btgIMbB
 ps+dFjQ9LXFjzy1XwlKRf3wkNVU9bQGFbgw+YEX6G9HFQYk5GJijzyqOHSTH9aOTuK
 UcRzxTkGAOfeg==
Date: Mon, 14 Sep 2026 12:14:12 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Alexey Minnekhanov <alexeymin@minlexx.ru>
Cc: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Sumit Semwal <sumit.semwal@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 David Heidelberg <david@ixit.cz>, Joel Selvaraj <foss@joelselvaraj.com>, 
 Chintan Patel <chintanlike@gmail.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, phone-devel@vger.kernel.org
Subject: Re: [PATCH 1/9] dt-bindings: vendor-prefixes: Add Shenzhen TXD
 Technology Co., Ltd.
Message-ID: <20260914-venerable-accelerated-seagull-acdb8d@quoll>
References: <20260913-nt36672a-panels-v1-0-ce097402c6ea@minlexx.ru>
 <20260913-nt36672a-panels-v1-1-ce097402c6ea@minlexx.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260913-nt36672a-panels-v1-1-ce097402c6ea@minlexx.ru>
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

On Sun, Sep 13, 2026 at 08:36:33AM +0300, Alexey Minnekhanov wrote:
> Add prefix for Shenzhen TXD Technology Co., Ltd., manufacturer of
> medium sized LCD and camera modules for mobile phones, tablets and
> automotive.
> 
> [1] https://en.txdkj.com/
> 
> Signed-off-by: Alexey Minnekhanov <alexeymin@minlexx.ru>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index ba20029693734..86c502d8d1d5f 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -1771,6 +1771,8 @@ patternProperties:
>      description: Turing Machines, Inc.
>    "^tuxedo,.*":
>      description: TUXEDO Computers GmbH
> +  "^txd,.*":

So prefix is "txdkj"

Best regards,
Krzysztof

