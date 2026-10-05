Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37042CA5FCE
	for <dri-devel@archiver.kernel.org>; Mon,  5 Oct 2026 13:30:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E50510EA1D;
	Mon,  5 Oct 2026 13:30:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hKBb2mCI";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A020B10EA1D
 for <dri-devel@lists.freedesktop.org>; Mon,  5 Oct 2026 13:30:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B5FB360A6D;
 Mon,  5 Oct 2026 13:30:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45F7F1F00899;
 Mon,  5 Oct 2026 13:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791207009;
 bh=JIiq+/90VCXi0iZJ9YrPZ2Fc0DkQlo0PQTnFhrJEQEY=;
 h=Date:From:Cc:To:In-Reply-To:References:Subject;
 b=hKBb2mCIxTkUQaihj33bnpib/5DlJHP/c2mCUmpDA0DE+QdKfyU7wUqsqtmu6OVZx
 s+bxiA6G/MWUcrU4svehLkmDbV2DQev4Qvt75agrC1QumbQ2+/yDswzUC5hvI0RN0v
 rbMEFDRVl+juG3Jtwz/6JMvN5JWo+c7Eio3Xchpdczhe/AT329eJ6HHkVY1a/U6Ah4
 7BR0oCHs6kfcy2Fw9SOeRy1xEeTesC4zat2RdZTv3CEeQstV5++POW56LAxUwez8wW
 hyrsrHbpoI6/k14N6f9MToIMGvjnlVEdQs+NgL4JybXFrXFPZVvP9UPB6yh6HoXiC7
 v1OSM6eazex/A==
Date: Mon, 05 Oct 2026 08:30:08 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Mikko Perttunen <mperttunen@nvidia.com>, 
 Thierry Reding <thierry.reding@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Conor Dooley <conor+dt@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, 
 dri-devel@lists.freedesktop.org
To: Svyatoslav Ryhel <clamor95@gmail.com>
In-Reply-To: <20261004163114.181800-4-clamor95@gmail.com>
References: <20261004163114.181800-1-clamor95@gmail.com>
 <20261004163114.181800-4-clamor95@gmail.com>
Message-Id: <179120692660.84836.6687045443264440808.robh@kernel.org>
Subject: Re: [PATCH v2 3/7] dt-bindings: display: tegra: Document 8-bit CPU
 parallel interface
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


On Sun, 04 Oct 2026 19:31:10 +0300, Svyatoslav Ryhel wrote:
> Document 8-bit CPU parallel MIPI DBI Type B interface provided by
> Tegra20/30 SoCs display controller.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  .../display/tegra/nvidia,tegra-dbi.yaml       | 143 ++++++++++++++++++
>  .../display/tegra/nvidia,tegra20-dc.yaml      |   3 +
>  2 files changed, 146 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra-dbi.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/display/tegra/nvidia,tegra-dbi.example.dtb: /example-0/dc@54200000/dbi/panel: failed to match any schema with compatible: ['hit,tx10d07vm0baa']

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20261004163114.181800-4-clamor95@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

