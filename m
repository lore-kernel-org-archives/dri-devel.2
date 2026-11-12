Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80823606A32D
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 11:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EgQF/Ety
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEFA410E56C;
	Thu, 12 Nov 2026 11:15:23 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CED1110E56C
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 11:15:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E1D3360267;
 Thu, 12 Nov 2026 11:15:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E133F1F00A05;
 Thu, 12 Nov 2026 11:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794482116;
 bh=/qMJHEvjaVSYBra9NbQuR3MV9CtSgvDCK4Vtml0tu1o=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=EgQF/EtyDrngE5ccMAcJ/aBqCCoLdd593celJeL57BNSu/1cRYxI51lfwU54iVE+x
 TQZratkXzTdKsSSNkJUzXDjy9vei5PBD7Q278E6IWBD7pKzjxDI/I4QVvEDa/Lo8mG
 TGmQWz7sgCbxteYFjw1eW91pkYQ/Qca2kczZir4ZoMVvkNSGtDsilB+MB/u6ZcS87s
 kH69YdlC5vbmEM4KcPfLmbInSCTiH0kJefaUTNgZo5m3uPKMAtL0ix0ECPYewUUak9
 Cd9QxGYwOYj31FonX/B0iJKnajfih+tmU5JX+Gos49oQYbOf6JLqEp7GZIn1QHeMqV
 tz6PHjgF2tVqQ==
Date: Thu, 12 Nov 2026 12:15:13 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: devicetree@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Bakker <xc-racer2@live.ca>, 
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] dt-bindings: display: panel: samsung,s6e63m0: Describe
 ESD interrupt
Message-ID: <20261112-resilient-keen-chupacabra-d3de9b@quoll>
References: <20261108-b4-samsung-s6e63m0-esd-v1-1-ab5c252c9646@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261108-b4-samsung-s6e63m0-esd-v1-1-ab5c252c9646@kernel.org>
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

On Sun, Nov 08, 2026 at 01:41:00AM +0100, Linus Walleij wrote:
> The Samsung Golden device tree wires the panel electrostatic discharge
> (ESD) indication to GPIO82 and names the interrupt "esd". The binding
> does not describe these properties, so CHECK_DTBS=1 reports them as
> unexpected.
> 
> Describe the optional interrupt and its existing name, and expand ESD
> in the property description.
> 
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---
> Describe the optional electrostatic discharge (ESD) detection interrupt
> already used by the Samsung Golden device tree.
> ---
>  .../devicetree/bindings/display/panel/samsung,s6e63m0.yaml        | 8 ++++++++
>  1 file changed, 8 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

