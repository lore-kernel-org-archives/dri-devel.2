Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2CC606A32F
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 20:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RQ+8H9mG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7167B10E462;
	Wed, 18 Nov 2026 20:29:25 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4333C10E462
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 20:29:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CBA81435A1;
 Wed, 18 Nov 2026 20:29:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76A2A1F000C4;
 Wed, 18 Nov 2026 20:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795033758;
 bh=EwqKl+MD6unBoWGhgL4qwXB8TJabPv9ipmvcp8Dekmk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=RQ+8H9mGGATKMX6YhAA9DZO30d1QBRqJhioxtgijibt9FH/Lwy0kySws2nhtax8Qb
 wcZrmeJVNUteZglHDS0KhNZQUy9o7Y1MphQUm3BbyP3OeBBm17AcCzxFPjq+r5yqzY
 f2c6rYsfz1YibVmEyx0sMlZZp7vQvbUYgy6zxLij3gVJsJI+oj4sZgDRMiFh+hr9zm
 58kSF1ra7XvtNMF7mwrC4Sx9K7pS7O66PZvDOOOow8nAHCbVFTB8fDBHeaCeVpIGPF
 IskWVHskos6k+nItBHxbac4Ly36SvDQ2eMVvnpwvJ3LQfS3CXKudyiaiScAvkqkcV/
 A7QuBDk5peEIw==
Date: Wed, 18 Nov 2026 14:29:17 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: krzk+dt@kernel.org, Frank.Li@nxp.com, p.zabel@pengutronix.de,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 conor+dt@kernel.org
Subject: Re: [PATCH v3] dt-bindings: display: imx: Describe legacy display
 nodes
Message-ID: <179503375565.822852.3824919130625575783.robh@kernel.org>
References: <20261111203656.725823-1-festevam@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111203656.725823-1-festevam@gmail.com>
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


On Wed, 11 Nov 2026 17:36:56 -0300, Fabio Estevam wrote:
> Legacy i.MX LCD display nodes have no schema, leaving their properties
> unvalidated and causing dt-core.yaml warnings for fsl,pcr on several
> i.MX25 and i.MX27 boards:
> 
>   imx27-phytec-phycard-s-rdk.dtb: display: fsl,pcr:
>   b'\xf0\xc8\x80\x80' is not of type
>   'object', 'integer', 'array', 'boolean', 'null'
> 
> Add a display schema selected by the presence of fsl,pcr. Describe the
> panel model, framebuffer pixel depth, interface width and LCDC settings,
> and reference panel-common.yaml for common panel properties and display
> timings. Reject properties not covered by these definitions.
> 
> Keep the LCD controller schema limited to controller properties.
> 
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> ---
> Changes since v2:
> - Add a separate display-node schema selected by the presence of fsl,pcr. (Rob)
> - Describe model, bits-per-pixel, bus-width and fsl,aus-mode, and reference panel-common.yaml.
> - Reject unknown display properties with unevaluatedProperties: false.
> 
>  .../display/imx/fsl,imx-fb-display.yaml       | 73 +++++++++++++++++++
>  1 file changed, 73 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,imx-fb-display.yaml
> 

Applied, thanks!

