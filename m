Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA62606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 13:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cSOkcNF0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54DAF10E97E;
	Wed, 11 Nov 2026 13:07:46 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9850310E942
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 13:06:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 03FB563048;
 Wed, 11 Nov 2026 13:06:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AF011F00A0C;
 Wed, 11 Nov 2026 13:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794402418;
 bh=qDgJN/3uyXucx3MvWswasgproOwS7hGFjV3S9xLY8ak=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=cSOkcNF0tYQXbkEqsMOH+/P6GrQwv9MhqNLJR2ZP9Frbq8AYYJk0KSztoWiPT8K+U
 iWJXBRQ6w+YBL9CXnC39H/ty/fDojjU0WD0xHTpWyPHqdwqluEpYrBfKXoq7QpTPlU
 EozaddBxYTTpvNe1qdq6shEOQNQiBqg95HG18V6ARLBdNfe3FCtj9iFndxwU3KegWA
 szBOaD2i7iy7jz02MAfoCUhOHbKEFAyAJ5cNWeReWRnW1BzSZPIC/5JBbFjpM/n8Xv
 AKjYhCCG4YSXw02hdIDtJeeueQYvqqCVkdLQxBxnRF31u9Ab5AbUksx43NW+sT1kNM
 e5ZlZ0cWRQEDQ==
Date: Wed, 11 Nov 2026 14:06:56 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Nizat Mikayilli <nacht@dxdmail.cc>
Cc: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 2/3] dt-bindings: display: panel: Document Anapass
 ANA38407 DDIC
Message-ID: <20261111-durable-passionate-sawfly-5cb0f5@quoll>
References: <20261107-b4-ana38407-v1-0-c8b33147110a@dxdmail.cc>
 <20261107-b4-ana38407-v1-2-c8b33147110a@dxdmail.cc>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261107-b4-ana38407-v1-2-c8b33147110a@dxdmail.cc>
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

On Sat, Nov 07, 2026 at 08:47:25PM +0100, Nizat Mikayilli wrote:
> +required:
> +  - compatible
> +  - reg
> +  - vci-supply
> +  - vddio-supply
> +  - reset-gpios
> +  - port

Do not require port, unless panel driver or panel hardware requires it.

Best regards,
Krzysztof

