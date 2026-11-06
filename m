Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F6E606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 14:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g11xEAwD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEB08112E10;
	Fri,  6 Nov 2026 14:17:02 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F536112E10
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 14:16:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A7BEE43D77;
 Fri,  6 Nov 2026 14:16:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 587F31F008AB;
 Fri,  6 Nov 2026 14:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793974616;
 bh=dwXHHpm3CuU/WL5LiGP9uPvStnllZcs54IcKag8FfB8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=g11xEAwDI+0oChFkS4bRa3cXnLHKP4QCFHvBnsTlh4KVSDwQzEctFtGXMpnaImf9Y
 AJzcwR+ywpe5HuPPTZ5wt4C9CgTmoUGnp4RzJKIVvu/JPxrai5QE/uB+jO0mCbTIiy
 icM4FgM9zAlSTWojIfDWFrhGu7x5Wqp4V58/CEf3RE/FEC8yJRRnsuMaVwy8jpiGI+
 2nHCnEUkJah2+3zxo6hyycPaDPd+b5NyKvreqGpAzyLHjmd4hpF1Fx+PzfLd0CZIpc
 7IY8t3s2WaKJ0RGQA1t++NFqdUbKwLvwgTWgq1jwKrvnZ+YTqmNPUQ6wQTrMZpamw4
 XoRN48wjpCcfg==
Date: Fri, 6 Nov 2026 08:16:53 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, David Airlie <airlied@gmail.com>,
 Maxime Ripard <mripard@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v6 05/10] dt-bindings: display: tegra: Document Tegra20
 DSI port
Message-ID: <179397461264.2992702.17337813112926510440.robh@kernel.org>
References: <20261105140510.165165-1-clamor95@gmail.com>
 <20261105140510.165165-6-clamor95@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105140510.165165-6-clamor95@gmail.com>
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


On Thu, 05 Nov 2026 16:05:05 +0200, Svyatoslav Ryhel wrote:
> Document the optional port node, which is required for correctly modeling
> a dual-mode panel.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  .../bindings/display/tegra/nvidia,tegra20-dsi.yaml          | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

