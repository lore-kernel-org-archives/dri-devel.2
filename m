Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1851C61DE2
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 09:05:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04E6610E780;
	Mon, 31 Aug 2026 09:05:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Z9wMnEAg";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AA8E10E79C
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 09:05:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D24A360120;
 Mon, 31 Aug 2026 09:05:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE8F91F000E9;
 Mon, 31 Aug 2026 09:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788167140;
 bh=lkFnYsQr7htHEOaaPnp8C+GnUFJy0U347AxVeU6TSes=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Z9wMnEAgOQfc1dL66JxFc/2TGbb9YSV2AT3P0+nKicGai1qB8RClIB0ZrU/dwdsDg
 H8L8otRT7Lwyjyw9iPCna3nxemYNZ5vd5wulF6azKV/yPrnRxxXHXCcdTZKZRisi8O
 YXvHesMBQYtdaQALZmlwZF3LUnjonEdIgQsK1mnj70lN5Aea+NN1xS1H4yucNAlpFt
 CB9uHNyqF8mYmItc5DOBkAp0h+r//FCqJRNFlCVzdX8w+s20cmvI+Kag36klz99Sti
 qD7d4/40m82mWj5AfWsxCFydKFl6etrBuQGyP8uKnfw8wPtEjPROrGSiQk6GDTlnJi
 t4uCBnAww2s8w==
Date: Mon, 31 Aug 2026 11:05:36 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: =?utf-8?Q?Nicol=C3=A1s?= Antinori <nico.antinori.7@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Brigham Campbell <me@brighamcampbell.com>, Jori Koolstra <jkoolstra@xs4all.nl>,
 Shuah Khan <skhan@linuxfoundation.org>, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v3 1/3] dt-bindings: display: add Chipwealth CH1115 OLED
 Controller
Message-ID: <20260831-brawny-original-curassow-8fa9dc@quoll>
References: <cover.1787973729.git.nico.antinori.7@gmail.com>
 <5e1a01043e1935d59d48630dc6211652e64b108a.1787973729.git.nico.antinori.7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <5e1a01043e1935d59d48630dc6211652e64b108a.1787973729.git.nico.antinori.7@gmail.com>
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

On Sat, Aug 29, 2026 at 03:32:13AM -0300, Nicol=C3=A1s Antinori wrote:
> Chipwealth CH1115 is a controller for monochrome dot matrix OLED panels.
>=20
> Signed-off-by: Nicol=C3=A1s Antinori <nico.antinori.7@gmail.com>
> ---
> NOTE: patch series based in kernel v7.2
>=20
>  .../bindings/display/chipwealth,ch1115.yaml   | 81 +++++++++++++++++++
>  .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
>  2 files changed, 83 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/chipwealth,=
ch1115.yaml

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

