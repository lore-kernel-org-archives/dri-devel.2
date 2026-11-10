Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3E9606A32A
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 09:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D8wYpWD3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19B8810EF2A;
	Tue, 10 Nov 2026 09:58:51 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A0AE10EF2A
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 09:58:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 439DA44E99;
 Tue, 10 Nov 2026 09:58:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D0E41F008A1;
 Tue, 10 Nov 2026 09:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794304724;
 bh=W8NrUTXS+LrVl+4LNXtC4XbJICo4rp0FZcarwaw4bxg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=D8wYpWD3mKltGhr/pqNpRPsnGHAwSeCy5CN1sj2sgX9wDCzOJCaA9BreQcDOTvZTu
 DrPaGRMF4jfQfwOg3YGiyXv5sXX4dv3qydwZQiBL9AqYlfgQyd2fj5H2fgmbAuzqua
 PxXRf/9IwelanbJxeJuHcLnw67PwjLisOy/+oUjRyBiKWeyZsP7yIfdrYY46hrLaXr
 73qiA5xGedxg5TdwBMPXPTV0yy96FefrAMOQtW9LnM0c4wNnD9xsCC0lJcA5cNAm5x
 NDGpoW+RhSsWRiNdUCOdH4sYz2CP/8bsmqXDSPXwfJwDmA8Yhvk0ftVKAhK5YZqmyO
 Ek0nM7aEhKHyg==
Date: Tue, 10 Nov 2026 10:58:40 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Olivier Louvignes <olivier@mgcrea.io>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Jessica Zhang <jesszhan0024@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Paul Cercueil <paul@crapouillou.net>, 
 "H . Nikolaus Schaller" <hns@goldelico.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/5] dt-bindings: display: Add the Ingenic X1600
 display controller
Message-ID: <20261110-annoying-classy-chinchilla-67cde0@quoll>
References: <20261109174640.96951-1-olivier@mgcrea.io>
 <20261109174640.96951-3-olivier@mgcrea.io>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261109174640.96951-3-olivier@mgcrea.io>
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

On Mon, Nov 09, 2026 at 06:46:37PM +0100, Olivier Louvignes wrote:
> The X1600's display controller fetches frames through descriptors and
> keeps its interface and timings in register blocks of their own (X1600
> programming manual, chapter 10), so it shares nothing with the
> controllers ingenic,lcd.yaml describes. Its registers are those of the
> X2000's display controller without the composer, which the X2000 and
> X2600 manuals call the DPU, as the X1600 manual does in its register and
> clock names: hence ingenic,x1600-dpu, which an X2000 binding can extend.
> 
> Signed-off-by: Olivier Louvignes <olivier@mgcrea.io>
> ---
>  .../bindings/display/ingenic,x1600-dpu.yaml   | 61 +++++++++++++++++++
>  MAINTAINERS                                   |  5 ++
>  2 files changed, 66 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/ingenic,x1600-dpu.yaml

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

