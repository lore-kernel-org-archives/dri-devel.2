Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8AA606A31B
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 03:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cUsdlhl9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E47D10E248;
	Wed, 21 Oct 2026 03:34:21 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 756C710E248
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 03:34:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id ECB08602A8;
 Wed, 21 Oct 2026 03:34:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 822AB1F000C9;
 Wed, 21 Oct 2026 03:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792553654;
 bh=fBgq8YPzeOh+YWrJzl8R4hGpHpUYFyaTH8GPM980OrE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=cUsdlhl9FgTXfrJZYINKtBIYqcQeBnsXcnj+pRK4w7NAL4VhRhJOxLQYnLpb47a6x
 vNFKte8GS4L23Ls1g5XsJwmEnXP5RIM15PCHakh7ApDuaVxLjglkCaPmdCT05RHVNV
 NHWrxThiMLiXTDjpDY1z+NkrTxIP7PAoi9/H3+B6JPXA16JvZKOKHwZ3o1WmFIIwx3
 6+JeGjxFEMD3YmR1a8SQ7ml/HknAgACi/zJ4SjJUHLdDjt+D8RjOy57AWeP6ifgdX7
 y9IAO5tToyuzgc89N6xSUDhpNLMkFmtGKTR71SCV6CnAqlzugzvLb/8q6orTDzoJv5
 ycNO9GlAmt14Q==
Date: Tue, 20 Oct 2026 22:34:13 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Jessica Zhang <jesszhan0024@gmail.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thierry Reding <thierry.reding@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Mikko Perttunen <mperttunen@nvidia.com>, linux-kernel@vger.kernel.org,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-tegra@vger.kernel.org,
 Simona Vetter <simona@ffwll.ch>, Maxime Ripard <mripard@kernel.org>,
 David Airlie <airlied@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3 5/7] dt-bindings: display: panel: Document Hitachi
 TX10D07VM0BAA and LG LH400WV3 panels
Message-ID: <179255365330.4070918.16011606066649236356.robh@kernel.org>
References: <20261019095705.91062-1-clamor95@gmail.com>
 <20261019095705.91062-6-clamor95@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261019095705.91062-6-clamor95@gmail.com>
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


On Mon, 19 Oct 2026 12:57:03 +0300, Svyatoslav Ryhel wrote:
> Document Hitachi TX10D07VM0BAA and LG LH400WV3 MIPI DBI 4" WVGA panels
> found in LG Optimus 2X P990.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  .../display/panel/hit,tx10d07vm0baa.yaml      | 58 +++++++++++++++++++
>  1 file changed, 58 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/hit,tx10d07vm0baa.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

