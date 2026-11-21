Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71C8606A32A
	for <dri-devel@archiver.kernel.org>; Sat, 21 Nov 2026 12:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sa0jDgdg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C932710E3B7;
	Sat, 21 Nov 2026 12:25:50 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC1C410E3B7
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Nov 2026 12:25:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D3D55611B0;
 Sat, 21 Nov 2026 12:25:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 090011F000CA;
 Sat, 21 Nov 2026 12:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795263943;
 bh=2xTIHmgzq00zeTm+KYjdeLWR3+4wv51SMkHMEHilZEk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Sa0jDgdglw59933Wovra2XPKfLyVfGYnAwW23yHMLQtVhCMgeTtBux+xufDx0loOG
 9kPO3efUkV8E8cERpa022RyyarkmqPSHgCjI4W2VNVbIcNfK/+m2PkHD828N09d7Bl
 k6/1crogHBRzZElaAE2DYsL5AFaAWakw6oNdwWc0CZDtmSh3sP56+5zrhVam8NoDvL
 DMeLvowx11mlyrp/+KxvAGnCBZA58HA4g4p6jjxU8mdia/V7k5+iH+NPDa+tGQrnA4
 Wleh//mNJsy4UO9q6nJtR95zH05EudZYFeO8FWhJ0EvSLqjdUouxtcIwqZT/Lcu3iz
 JAnD8YSychHOQ==
Date: Sat, 21 Nov 2026 13:25:40 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Roman Vivchar <rva333@protonmail.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Helge Deller <deller@gmx.de>, 
 dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
 devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: leds: backlight: add Kinetic KTD3137
Message-ID: <20261121-sticky-firefly-of-innovation-c4aaaa@quoll>
References: <20261117-6768-ktd3137-v3-0-b4fd957e3b00@protonmail.com>
 <20261117-6768-ktd3137-v3-1-b4fd957e3b00@protonmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261117-6768-ktd3137-v3-1-b4fd957e3b00@protonmail.com>
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
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 17, 2026 at 07:40:58PM +0200, Roman Vivchar wrote:
> Kinetic KTD3137 is an LED IC, used in various mobile devices for the
> display backlight. Add devicetree bindings documentation for this chip.
> 
> Datasheet: https://www.kinet-ic.com/uploads/KTD3137-04a.pdf
> 
> Signed-off-by: Roman Vivchar <rva333@protonmail.com>
> ---
>  .../bindings/leds/backlight/kinetic,ktd3137.yaml   | 64 ++++++++++++++++++++++
>  MAINTAINERS                                        |  5 ++
>  2 files changed, 69 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

