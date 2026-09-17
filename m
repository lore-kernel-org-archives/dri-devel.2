Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43DB9C982C1
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 08:05:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7527B10E478;
	Thu, 17 Sep 2026 08:05:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="okLQjjQS";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE1E310E45C
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 08:05:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F1A6760204;
 Thu, 17 Sep 2026 08:05:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEDD31F000FF;
 Thu, 17 Sep 2026 08:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789632350;
 bh=cxwNQuo1MwfkPiWaoqYyt95s3x3hs0Jga33AiR0XIrA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=okLQjjQS8e8XfTSw0HqPrQyGitnrCIvyz830zgR6/erIwDab0WsaWMISWK+/ZszYj
 N/g0aXJ9D33G0dLmyHzMwKAoY3CoDh0+bx86MdJKXoqeYc6GYpXO6erFukGGAzhmzg
 MJ5s8WdmHo19xXQRIQLv3qmMZWpWFdd77SY+3/pB12NETZw/vmqTYOtecIKzr5mFiU
 U3ypHdZyRULIzGY4BCdvjAsalplSb5L4JocHc4US1zAevB8qPz95ZbmdVKPsLduXbI
 0xM/nblSmwkzHGQvaNa6i5Gx46xysXtunQNB1/ZZBiI6MLz1WrBBko98xxw1eb1Ii1
 olKZLsN2rPlnA==
Date: Thu, 17 Sep 2026 10:05:46 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Leander Kieweg <kieweg.leander@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, u.kleine-koenig@baylibre.com
Subject: Re: [PATCH v4 1/2] dt-bindings: display: Add GlandaGPU binding
Message-ID: <20260917-exceptional-artificial-mackerel-0bcad7@quoll>
References: <20260913205007.118552-1-kieweg.leander@gmail.com>
 <20260913205007.118552-2-kieweg.leander@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260913205007.118552-2-kieweg.leander@gmail.com>
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

On Sun, Sep 13, 2026 at 10:50:06PM +0200, Leander Kieweg wrote:
> Add Device Tree binding documentation for GlandaGPU, a custom
> FPGA-based 2D display controller.
> 
> For hardware designs and RTL sources, see:
> https://github.com/stiangglanda/GlandaGPU
> 
> Signed-off-by: Leander Kieweg <kieweg.leander@gmail.com>
> ---
>  .../bindings/display/kieweg,gpu.yaml          | 55 +++++++++++++++++++
>  .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
>  2 files changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/kieweg,gpu.yaml

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

