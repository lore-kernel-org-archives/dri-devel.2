Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EA2606A328
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 03:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hsdgFKmY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0BEB10E223;
	Wed, 21 Oct 2026 03:33:56 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0196510E223
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 03:33:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 133E86021E;
 Wed, 21 Oct 2026 03:33:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A22B1F000C9;
 Wed, 21 Oct 2026 03:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792553628;
 bh=h9uL3bUFmsFJ4jdYyY5J7tcbz3RUdrntjKEXNV+fUxA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=hsdgFKmYIr746vJb5AVItEQ4HIw3Om+dTG00YWvXTPXt3AWrNZkk/Sb2zITmOvGfV
 7crUvAqQZPUu3MPS+Vkd+KrdqnnUEg3aq7vPNks1tSL0ZzigTgWzH04VdymlBbWoJI
 xB3qyK1sl9d2mg5YvvN4jQkbqSEV8wMwNnDkAB8fRmlo7huI3VPJ2FTeXwjXLD8NMm
 hWItyHlTEJI1E1r3j+5ug9gohOVVS6E2za9yPbvXgmZOMjvT7s88niSTE0AHKDwWuk
 4DGNinyPVfLtr4N2At44NE0U7KakY9Oh0gwiqJD0mRPlwOPlM5/WnAgRPTI1T++8ON
 TkYaH73gJeVIQ==
Date: Tue, 20 Oct 2026 22:33:47 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>, linux-tegra@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Jonathan Hunter <jonathanh@nvidia.com>, dri-devel@lists.freedesktop.org,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, David Airlie <airlied@gmail.com>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Thierry Reding <thierry.reding@kernel.org>
Subject: Re: [PATCH v3 3/7] dt-bindings: display: tegra: Document 8-bit CPU
 parallel interface
Message-ID: <179255359778.4065508.6211892525325768326.robh@kernel.org>
References: <20261019095705.91062-1-clamor95@gmail.com>
 <20261019095705.91062-4-clamor95@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261019095705.91062-4-clamor95@gmail.com>
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


On Mon, 19 Oct 2026 12:57:01 +0300, Svyatoslav Ryhel wrote:
> Document 8-bit CPU parallel MIPI DBI Type B interface provided by
> Tegra20/30 SoCs display controller.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  .../display/tegra/nvidia,tegra-dbi.yaml       | 138 ++++++++++++++++++
>  .../display/tegra/nvidia,tegra20-dc.yaml      |  15 ++
>  2 files changed, 153 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra-dbi.yaml
> 

Reorder your patches to avoid the warnings.


Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

