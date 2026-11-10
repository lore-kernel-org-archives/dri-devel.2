Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BFC60A260A
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 12:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JVGyJHKp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 151E710F5D6;
	Tue, 10 Nov 2026 12:34:03 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F9EF10F5D6
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 12:33:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8D555614A1;
 Tue, 10 Nov 2026 12:33:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 484901F008A4;
 Tue, 10 Nov 2026 12:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794314036;
 bh=GTzfLzc0u8rKgofNE0jg+z1Ua/5PCIE7H4gnXQiu5+I=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=JVGyJHKpdb//PBHZ/hVCXQVOi6jwaPWnhSIvd1Nm1q0yf2FWErBGReupwad0516H9
 iJoJpWUMoT/+yVBDZ6BtDpwq43Ei4FAdI66KXx1egujfHwknaIBFXaiqewszm0eu3I
 1yhvlRbpDuK4gMQaiXX1ynAE9Hfp+V1Q9X298w19k6VtdwWFx1+1Mcxk2HSXKBBE8J
 KoNXscXzucTOhwNIl92gagrQ+KnfHfmbwi7j0GgqN/A4F2thvipZeHJLOQk3yK8qIo
 xmGWDNmwRN1oNOb8icU7mMSoBxm5RlL7w+cTHiFDEv42n2Kx1DHpiet3AYhQhUffK8
 oD2jZROqT9l0Q==
Date: Tue, 10 Nov 2026 13:33:52 +0100
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
Subject: Re: [PATCH v2 2/3] dt-bindings: display: panel: ilitek,ili9488: add
 the PocketGo S30 panel
Message-ID: <20261110-didactic-black-polecat-517d7d@quoll>
References: <20261109160706.2272332-1-romain.tisserand@gmail.com>
 <20261109160706.2272332-3-romain.tisserand@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261109160706.2272332-3-romain.tisserand@gmail.com>
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

On Mon, Nov 09, 2026 at 05:07:05PM +0100, Romain TISSERAND wrote:
> The Miyoo PocketGo S30 handheld has a 320x480 1-lane MIPI-DSI panel
> built around an Ilitek ILI9488.
> 
> Reviewed-by: Igor Reznichenko <igor@reznichenko.net>
> Signed-off-by: Romain TISSERAND <romain.tisserand@gmail.com>
> ---
>  .../devicetree/bindings/display/panel/ilitek,ili9488.yaml        | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

