Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05409606A325
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 13:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g4fqi+1r
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5898010E886;
	Mon,  9 Nov 2026 13:47:10 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A687810E886
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 13:47:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CA05160D2A;
 Mon,  9 Nov 2026 13:47:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EC601F0089F;
 Mon,  9 Nov 2026 13:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794232022;
 bh=UULeg7ZwfrRSMBYNdcUvvoEFwdkhBm2Chdood5mPzUk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=g4fqi+1rJXD8n05eVPt9zgL/1cqFGPO9B3K31Qf8cik24oKlB4uZAmvF7M+JPIhM0
 kN5PNyYXjxbKyOAH9Vy+Cb4eM/tLTpjkIAo0jaMtmzKqhsFopAUK7mP2HKlmxnPp1Y
 92SdK2+rS4Lfw/XEAfOJopv477xAuZTtlNgeK1BHgzlioTiwPWhU1uHP9prf9LTnZx
 40U1F2w6m3bzbM9G1UMao+aK5L4VwlhIoofCylO9NAn1vKMORGTdzHbWDk6ZpcHa87
 DdIiFp+DeeBiTJvaQ/5029d2on2APuLgV84ikr//xnC0d0sZPE+nfENyrn8fxzlQxv
 zgH0en+eJ7saw==
Date: Mon, 9 Nov 2026 14:46:58 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 michal.simek@amd.com, deller@gmx.de, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, git@amd.com
Subject: Re: [PATCH 2/2] dt-bindings: xilinx: Remove description for
 framebuffer IP
Message-ID: <20261109-crystal-kangaroo-of-charisma-d7a8fe@quoll>
References: <20261106170902.3656809-1-radhey.shyam.pandey@amd.com>
 <20261106170902.3656809-3-radhey.shyam.pandey@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261106170902.3656809-3-radhey.shyam.pandey@amd.com>
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

On Fri, Nov 06, 2026 at 10:39:02PM +0530, Radhey Shyam Pandey wrote:
> The Xilinx framebuffer IP relies on Xilinx Platform Studio and the ISE
> Design Suite, both of which were discontinued years ago.
> 
> Driver support for the controller is removed by the preceding patch. Keep
> the bindings in sync by removing the corresponding Xilinx framebuffer
> description.
> 
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> ---
>  Documentation/devicetree/bindings/xilinx.txt | 13 -------------
>  1 file changed, 13 deletions(-)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

