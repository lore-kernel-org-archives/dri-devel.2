Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FB5606A32D
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 11:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ljR1QnRL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07C0C10E94F;
	Thu, 12 Nov 2026 11:06:03 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9E3D10E94F
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 11:05:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B17B045844;
 Thu, 12 Nov 2026 11:05:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C33261F00A06;
 Thu, 12 Nov 2026 11:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794481556;
 bh=mXTe+OT6mzHTMHVv+nfjup1kUqTXR5f3gseQxSoH7+o=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=ljR1QnRLgzHSvEvMfu6/ddMKedwrVFT22MBaP7lJSG8fdrJ+5NK6I05rOFtaU+Wo2
 S2P4S0AJACJqphkjI2TpTcDxRcV/BVcr/4UjB7DKbCuExddYyH8BKUPR6yEgpBS2KU
 1VT9N0hcNWcu4wXfaceL/hOteLBOwfgWLAh++gi4+qLHeXKazE604RBkMeo6yOfTCc
 +DSOKDTk7sC1Y0Rqvftp/vqTdimKrCMP8BVDmONpyMNL0tfSDCzzN1kl12umaNPKGa
 7Ni19Kk77K3bCUh/ZID2MiDJdyHkSf00VwYj1WoIjHzToP+lpMuCxsjAKAklybfB+O
 0Xu2X4oKf8MRw==
Date: Thu, 12 Nov 2026 12:05:53 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Michiel van Beers <michielvanbeers@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, 
 Griffin Kroah-Hartman <griffin@kroah.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Helge Deller <deller@gmx.de>, 
 dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
 devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: backlight: lm3630a: Add
 led-max-microamp
Message-ID: <20261112-subtle-kraken-of-serenity-04ea8b@quoll>
References: <20261111-lm3630a-led-max-microamp-v2-0-aff11756e7be@gmail.com>
 <20261111-lm3630a-led-max-microamp-v2-1-aff11756e7be@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261111-lm3630a-led-max-microamp-v2-1-aff11756e7be@gmail.com>
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

On Wed, Nov 11, 2026 at 05:21:41PM +0100, Michiel van Beers wrote:
> The LM3630A has a full-scale current setting per control bank, from
> 5 mA to 28.25 mA in steps of 750 uA. Boards whose LED strings are rated
> for less than the chip default of 28.25 mA have no way to describe that
> limit.
> 
> Add the common led-max-microamp property to the led@0 and led@1 nodes,
> and reference leds/common.yaml from them, where that property is
> defined. The property is optional, so existing devicetrees remain
> valid.
> 
> Signed-off-by: Michiel van Beers <michielvanbeers@gmail.com>
> ---
>  .../devicetree/bindings/leds/backlight/lm3630a-backlight.yaml  | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

