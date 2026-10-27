Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258F4606A31A
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 08:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cr4+YX5L
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CD2410E2AF;
	Tue, 27 Oct 2026 08:12:39 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B169210E2AF
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 08:12:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7BDF56020A;
 Tue, 27 Oct 2026 08:12:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D8EB1F01829;
 Tue, 27 Oct 2026 08:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793088751;
 bh=FJIy+SLFeA3/C6VIteyOfVGbwqXel75/TJmRF6auaDE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Cr4+YX5L8b+JDgLe8VqKWnOlsnffa/ODJy2Ou4qjWz8zlG9M0QIlLf+22C9+3771U
 +lLULH5+2ybGwhwHmeuHjlxqFZ25swdI8jyagdxGGnv7SFc00cYxeRrQlisKAKHcft
 42qp2aG5np/ZvNNkn25ShHrRkABsSAt/lQfhDMHroCBRkGARWJDmYrMSOfh3qEeXDo
 ClRuaOihAmU3gHRyOfQ0u4hKyf4jqKpQOZGhiYPBv4udm8A8LY/IMdUqsy7DH78qgl
 uAO/IFnCwEKuitwdmQ+dUOFJWniS/WSW+aXzuvxmR/pJEADDmLcYouLl04B2TZaFFp
 6hGnhRR9ppRaw==
Date: Tue, 27 Oct 2026 09:12:27 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Vishnu Saini <vishnu.saini@oss.qualcomm.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Arpit Saini <arpit.saini@oss.qualcomm.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, venkata.valluru@oss.qualcomm.com
Subject: Re: [PATCH] dt-bindings: display: panel: ilitek,ili7807s: Allow
 backlight property
Message-ID: <20261027-fantastic-benevolent-boobook-272a9a@quoll>
References: <20261025-dlc_backlight-v1-1-1d1c49c3e101@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261025-dlc_backlight-v1-1-1d1c49c3e101@oss.qualcomm.com>
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
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Oct 25, 2026 at 12:18:17PM +0530, Vishnu Saini wrote:
> The DLC0697 panel is lit by a separate backlight device, which is
> referenced from the panel node through the common 'backlight'
> property.
> 
> Declare 'backlight: true' so the property is explicitly allowed by the
> schema.

Why do you need to explicitly allow it? Since when?

I see no benefit of this patch and commit msg does not explain me what
that benefit would be.

Best regards,
Krzysztof

