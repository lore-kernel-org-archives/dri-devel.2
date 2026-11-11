Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A10606A326
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 13:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HlfnUlkj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C10C710E942;
	Wed, 11 Nov 2026 13:07:39 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D49EE10E908
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 13:07:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BADCC41E77;
 Wed, 11 Nov 2026 13:07:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1E901F00A05;
 Wed, 11 Nov 2026 13:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794402433;
 bh=hRYlFMkxE3X3h9ymxop0bmz7OPPkaLJpQ3oLl22U0eY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=HlfnUlkju7VQUoRhPAWBQsANTMKgJVZY80+9sI1fMr3e4W+LiSZqv3UYDg7FuV4cS
 IbU9dkdId/KwQeaDw1aIZD8Y10SOz3//y7n/V19V3BIpVu8qd+sxXlEdQqSsUCOU9C
 g3eDNY+37LCjcK8ViUh5SKiU3bDE7e+vyuxLHv39oQcDJpVPISOQ+61z8/yPPMVAUg
 Z4ZNXLtwefFubMdHQPyCsVzJkDw+ZbOLN3nP+ciYzn7fNBhySKSTAxQhM5iJDTpUhD
 qsPwhSggyGx2Ux0sAvOclbTV7ViOiRojZOBn/h+F/aFEBwJwZgi+Ho/xaK7FPKJT+i
 HD3NjT+CCqCnQ==
Date: Wed, 11 Nov 2026 14:07:10 +0100
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
Subject: Re: [PATCH 1/3] dt-bindings: vendor-prefixes: Add Anapass
Message-ID: <20261111-stylish-evasive-oxpecker-eacdea@quoll>
References: <20261107-b4-ana38407-v1-0-c8b33147110a@dxdmail.cc>
 <20261107-b4-ana38407-v1-1-c8b33147110a@dxdmail.cc>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261107-b4-ana38407-v1-1-c8b33147110a@dxdmail.cc>
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

On Sat, Nov 07, 2026 at 08:47:24PM +0100, Nizat Mikayilli wrote:
> Add a vendor prefix for Anapass, Inc., a display driver IC vendor.
> 
> Signed-off-by: Nizat Mikayilli <nacht@dxdmail.cc>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

