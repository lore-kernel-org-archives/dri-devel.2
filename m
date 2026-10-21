Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED11606A321
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 03:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CKwBcAxE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 140C910F8E6;
	Wed, 21 Oct 2026 03:37:31 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 852A810E28C
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 03:37:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E2A8560534;
 Wed, 21 Oct 2026 03:37:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72FC81F000C9;
 Wed, 21 Oct 2026 03:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792553844;
 bh=Qr31YWWG46E37l6UZYR2FUMOs+UNFYnsINuMkMnDBXM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=CKwBcAxEK0FlqonH9i3F9j186IPNiPyiGjtvctSlnpB47FDU+qUUCvaPlO2QkLq7i
 e8sCp9tLAegrSMoFbXXPdGxqv8m3dHAb/5evnWulq/mgO/vxha0CamzcM+tl5uAp9t
 86dZb6M3f8yDSLlN0k31kl3KYh1C/vbwfCT1pLmpwai9YAL8EzC1G56fc0tP2wgLJu
 9LjifsAi0zpl3yGv/qIJYthlX4g5eQaOg+llstcB2TgOwYSFTYmp5jcYWhBOaEWBTD
 MyQO6D813GlBaBBKgPm7FfXcalks49GWmrsL7wRz7mMlEw5W0689Dc8dR4oliXPecx
 cQwSJJoRzylog==
Date: Tue, 20 Oct 2026 22:37:23 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Devarsh Thakkar <devarsht@ti.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org, Conor Dooley <conor+dt@kernel.org>,
 linux-arm-kernel@lists.infradead.org,
 Tero Kristo <kristo@kernel.org>, David Airlie <airlied@gmail.com>,
 LiangCheng Wang <zaq14760@gmail.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
 devicetree@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
 Simona Vetter <simona@ffwll.ch>
Subject: Re: [PATCH v3 03/14] dt-bindings: display: solomon,ssd16xx: Add
 Solomon SSD1677 controller
Message-ID: <179255384325.4089175.11513181876528998928.robh@kernel.org>
References: <20261019213726.4145532-1-devarsht@ti.com>
 <20261019213726.4145532-4-devarsht@ti.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261019213726.4145532-4-devarsht@ti.com>
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


On Tue, 20 Oct 2026 03:07:15 +0530, Devarsh Thakkar wrote:
> Add solomon,ssd1677 as a compatible controller string.
> 
> The SSD1677 supports displays up to 960x680 pixels with 10-bit
> pixel-level X/Y RAM addressing. It shares the same command address
> space and GPIO interface as the SSD1683 but differs in addressing
> model, deep sleep behaviour, and initialisation sequence.
> 
> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
> ---
> Changes in v3:
> - Only add the solomon,ssd1677 branch, as the previous patch now already
>   uses oneOf for compatible
> ---
>  Documentation/devicetree/bindings/display/solomon,ssd1683.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

