Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B12DCA5FAC
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 11:51:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7742B10F346;
	Wed, 30 Sep 2026 11:51:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="h6TAJnvg";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D39EE10F339
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 11:51:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 98EAA401CA;
 Wed, 30 Sep 2026 11:51:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49A561F00893;
 Wed, 30 Sep 2026 11:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790769070;
 bh=MsKu2QvMYXznsid/PbO/r1U6EfT+lLwdNFVx4O4bgtQ=;
 h=Date:From:Cc:To:In-Reply-To:References:Subject;
 b=h6TAJnvg38T8ZGN/EIwoqqtBiFlnbXRa0lWOxh6p0B5Rpz4tK31to/oI6kFWQvxI1
 v6f6jmZWVdVISWWG2sdyxHsdlXI8u1jmO7xF0C8AbqEw6fmEoltjsZVihxBMBrqjUh
 2TTDD6DxikCq1b84Xpl5Vyv0FgPg/pqf4alQr5pFh0W6KNJNy1i5nuc2d1aZgnlduQ
 SXZLrAvrmCfIeg/deQ2TB6tMN+IxBn0Rd8cw9C/hoMXqRQLR2Bf59fMJRKNIbNk9dB
 +wkoGu+0eHOOzpw3kxLyDo4mxXj9pA/bd5yqIvh+1v7Nm4rvIH6LBxC5I5DpheZEN5
 XFJkNcwN4s4pA==
Date: Wed, 30 Sep 2026 06:51:09 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-tegra@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, devicetree@vger.kernel.org, 
 Mikko Perttunen <mperttunen@nvidia.com>, linux-kernel@vger.kernel.org, 
 Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Thierry Reding <thierry.reding@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Conor Dooley <conor+dt@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
In-Reply-To: <20260930070535.47130-4-clamor95@gmail.com>
References: <20260930070535.47130-1-clamor95@gmail.com>
 <20260930070535.47130-4-clamor95@gmail.com>
Message-Id: <179076815642.2155434.13248975463672729099.robh@kernel.org>
Subject: Re: [PATCH v1 3/6] dt-bindings: display: tegra: Document 8-bit CPU
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


On Wed, 30 Sep 2026 10:05:32 +0300, Svyatoslav Ryhel wrote:
> Document 8-bit CPU parallel MIPI DBI Type B interface provided by
> Tegra20/30 SoCs display controller.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  .../display/tegra/nvidia,tegra-8bit-cpu.yaml  | 138 ++++++++++++++++++
>  1 file changed, 138 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra-8bit-cpu.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/display/tegra/nvidia,tegra-8bit-cpu.example.dtb: /example-0/dbi-bridge/panel: failed to match any schema with compatible: ['hit,tx10d07vm0baa']

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260930070535.47130-4-clamor95@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

