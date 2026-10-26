Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2F8606A32D
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 07:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hII2J8Ib
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07C1510EC09;
	Mon, 26 Oct 2026 07:23:35 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 436A210E9FC
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 07:23:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F353443FAE;
 Mon, 26 Oct 2026 07:23:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A62541F031E2;
 Mon, 26 Oct 2026 07:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792999408;
 bh=UxKIXTn00rkZRgxxGWUIqRdP+K6EsksHgWkUSDGuqd8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=hII2J8Ibv/oeI48zJD+qUlLTBkltaTBweje6N9K6Zjw2O6X7WLQglg/WQw6TJZlH+
 K5AmrJlk/mlWSqAC3BIZjC0YrSlgOvOOOUUkOCm0fjnDHl8JC/oiCgfZmmW8b++6ij
 RaXMVPlgnerad18YbCr111R0krGU2f7TU4Kq5fRaTPqg60jrGTfVvJVwasOHdQxfZ2
 hWl8vfal76xs5Vrx3b19OTXqOX0aIGOhSAarGxkDUvEN3K831LuyZcK4MKFGSgiZ4o
 EavcWN4XzE02iTaMN8ow55/wYa5+wB403zFCWrj5Oubzyy/jijQMggWktRZeh0i26S
 zViXZ+B+dnaHA==
Date: Mon, 26 Oct 2026 08:23:25 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Lars Rask <lars.rask@axis.com>
Cc: Marcus Folkesson <marcus.folkesson@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, kernel@axis.com
Subject: Re: [PATCH 1/2] drm/sitronix/st7571-spi: Add support for ST75156
 controller
Message-ID: <20261026-dancing-beneficial-tuatara-d70263@quoll>
References: <20261022-add_st75156_support-v1-0-582525a39a39@axis.com>
 <20261022-add_st75156_support-v1-1-582525a39a39@axis.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261022-add_st75156_support-v1-1-582525a39a39@axis.com>
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

On Thu, Oct 22, 2026 at 05:31:05PM +0200, Lars Rask wrote:
> From: Lars Rask <lars.rask@axis.com>
> 
> Made additions to st7571 display driver to support st75156.
> 
> Signed-off-by: Lars Rask <lars.rask@axis.com>
> ---

Please organize the patch documenting the compatible (DT bindings)
before the patch using that compatible.
See also: https://elixir.bootlin.com/linux/v6.14-rc6/source/Documentation/devicetree/bindings/submitting-patches.rst#L46

>  drivers/gpu/drm/sitronix/st7571-spi.c | 118 +++++++++-
>  drivers/gpu/drm/sitronix/st7571.c     | 420 +++++++++++++++++++++++++++++++++-
>  drivers/gpu/drm/sitronix/st7571.h     |  20 ++
>  3 files changed, 549 insertions(+), 9 deletions(-)

...

> +
>  static int st7571_spi_probe(struct spi_device *spi)
>  {
>  	struct st7571_device *st7571;
>  	struct regmap *regmap;
> +	struct spi_device_data *spi_data;
> +
> +	spi_data = devm_kzalloc(&spi->dev, sizeof(*spi_data), GFP_KERNEL);
> +	if (IS_ERR(spi_data))
> +		return dev_err_probe(&spi->dev, PTR_ERR(regmap),
> +				     "Failed to initialize spi data\n");

I do not see how you initialize spi data here, so this is just incorrect
error message. Regardless, driver NEVER prints error messages for
allocation.


Best regards,
Krzysztof

