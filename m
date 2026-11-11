Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F83606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 12:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O5LU3j6A
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B90B10FB43;
	Wed, 11 Nov 2026 12:11:41 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD08610FB43
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 12:11:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 42D2661197;
 Wed, 11 Nov 2026 12:11:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3B041F00A0B;
 Wed, 11 Nov 2026 12:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794399095;
 bh=uxHaYs6gzjD/EYRdqCnmVXOY/SAjTuU2zRL4ZifLNo8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=O5LU3j6AUykozDtd1abkEmq/4Udfi6wDxcXuWeNNRmpDbsirA/Esp1xjUqAeL7h99
 47q9locMmGH9fRS+y5sA0kX3GQqQ1TkdRUSTUESoTtXdJfK6RKh4A97H6wAtp8xZI3
 rbnUimqhzfM9n7Jvgv9fIa+ffABSktTumjYDx4Q05bt+I8LqVUlK3Yr5l4LmXwPdtx
 8rFJwdjMxb36eAwnqcAaM8tiMXYnqi/uTWvUhroiBJxvVLFEYm7RGSPrl/KAw0RA1z
 Fwf1kzlAD3I7FsHfpG7NR/2AqeWFqHcySsJxHrErHTmO9GxRs6hXqj6Q3Ce7NfQshi
 40AIHSdu07Pzw==
Date: Wed, 11 Nov 2026 13:11:31 +0100
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
Subject: Re: [PATCH v2 1/2] dt-bindings: leds: backlight: add Kinetic KTD3137
Message-ID: <20261111-liberal-wakeful-flamingo-3c1f3a@quoll>
References: <20261110-6768-ktd3137-v2-0-9496c51efea4@protonmail.com>
 <20261110-6768-ktd3137-v2-1-9496c51efea4@protonmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261110-6768-ktd3137-v2-1-9496c51efea4@protonmail.com>
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

On Tue, Nov 10, 2026 at 09:38:51PM +0200, Roman Vivchar wrote:
> +  led-max-microamp:
> +    minimum: 5000
> +    maximum: 29800
> +    default: 20200
> +
> +  vin-supply: true
> +
> +required:
> +  - compatible
> +  - reg

Supply is required, device cannot operate without power.

> +
> +unevaluatedProperties: false

Best regards,
Krzysztof

