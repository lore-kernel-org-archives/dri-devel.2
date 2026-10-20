Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869D9606A33E
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 15:12:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8EC510F65D;
	Tue, 20 Oct 2026 15:12:47 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DD7710F65D
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 15:12:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6E34060220;
 Tue, 20 Oct 2026 15:12:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 081971F000C4;
 Tue, 20 Oct 2026 15:12:44 +0000 (UTC)
Date: Tue, 20 Oct 2026 10:12:44 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, linux-tegra@vger.kernel.org, 
 Simona Vetter <simona@ffwll.ch>, Jonathan Hunter <jonathanh@nvidia.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 David Airlie <airlied@gmail.com>, Conor Dooley <conor+dt@kernel.org>, 
 dri-devel@lists.freedesktop.org, Mikko Perttunen <mperttunen@nvidia.com>, 
 devicetree@vger.kernel.org, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thierry Reding <thierry.reding@kernel.org>, linux-kernel@vger.kernel.org, 
 Maxime Ripard <mripard@kernel.org>, Jessica Zhang <jesszhan0024@gmail.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
In-Reply-To: <20261019095705.91062-4-clamor95@gmail.com>
References: <20261019095705.91062-1-clamor95@gmail.com>
 <20261019095705.91062-4-clamor95@gmail.com>
Message-Id: <179250894267.3309780.15694845491721120765.robh@kernel.org>
Subject: Re: [PATCH v3 3/7] dt-bindings: display: tegra: Document 8-bit CPU
 parallel interface
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
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

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/display/tegra/nvidia,tegra-dbi.example.dtb: /example-0/dbi/panel: failed to match any schema with compatible: ['hit,tx10d07vm0baa']

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20261019095705.91062-4-clamor95@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

