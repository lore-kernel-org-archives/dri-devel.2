Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0396C43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 15:42:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0742C10ECA2;
	Tue, 30 Jun 2026 15:42:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UTxcA1I7";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7D5E10ECA2
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 15:42:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7F659419FA;
 Tue, 30 Jun 2026 15:42:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 395241F000E9;
 Tue, 30 Jun 2026 15:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782834163;
 bh=MNzdmtI26hhlgis7iHvjkaKObdLefwf2TLs7oUsZvRI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=UTxcA1I7SlQKZVmYpdr00uTW4atY24KujaYv/R9BnjWUPKPHpwU9Ol6Wg0SxITd9r
 J509agtZkTWZzP5XZD3xrMiEQmNFUo9v1vk/DCwvSPsOhGe5IM/zEXtg1BZ+EDLZZ3
 EDCjKGltIAsxUgXBma/vlIVm50sfGoG1+7NSG+QXprcTdRCHiXYyoWBYWOWR/J4bK8
 IZv1o+DJFoaAGXviJvBxDSLQOy8s7PRIGo+PPi1+KD3i4oWJ7gOFHBzGCPtaYh38xq
 tCfpzSnX3eotaM8T4vhs8vxc+m9gvkZ+2nQ/fUNVY/gGz/tBGmiGEO01+jk6joH67l
 zKTunZlw9D7Ow==
Date: Tue, 30 Jun 2026 10:42:42 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: linux-tegra@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Maxime Ripard <mripard@kernel.org>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, David Airlie <airlied@gmail.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org,
 Thierry Reding <thierry.reding@kernel.org>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Jonathan Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH v2 1/7] dt-bindings: display: tegra: Changes to support
 Tegra264
Message-ID: <178283416214.3689764.9700887048944091225.robh@kernel.org>
References: <20260622-t264-host1x-v2-0-ff7364d9ff7b@nvidia.com>
 <20260622-t264-host1x-v2-1-ff7364d9ff7b@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622-t264-host1x-v2-1-ff7364d9ff7b@nvidia.com>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>


On Mon, 22 Jun 2026 15:57:38 +0900, Mikko Perttunen wrote:
> Add nvidia,tegra264-host1x compatible string. The Tegra264 host1x is
> similar to Tegra234, but with a different set of engines and layout.
> 
> The engine register range is no longer continuous, so two range entries
> are also needed.
> 
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>  .../display/tegra/nvidia,tegra20-host1x.yaml         | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

