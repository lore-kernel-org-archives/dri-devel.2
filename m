Received: from smtp.lore.kernel.org (ip-10-30-226-214.us-west-2.compute.internal [10.30.226.214])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F8B606A325
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 14:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JuqN/98G
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A41C9CCF2E6
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 14:52:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDE1610E60F;
	Mon, 19 Oct 2026 14:52:37 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECDE510E60F
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 14:52:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2781C60220;
 Mon, 19 Oct 2026 14:52:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82EC01F000C4;
 Mon, 19 Oct 2026 14:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792421550;
 bh=yl5NxpV3qhtDFSqHpsAuI8SmOIpcijjYdi5raaMOrlE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=JuqN/98GnVi9GPTKHHeS3PyF/YFglS79m2gP3Oqx3z7Wsz+K773raqauih4NT1LTq
 kK9an1otIy5yhzDUBaNhtXsSeichOPK7WAgVCWSOKUatp89Arb8Mj3KA+2sHy1+5OE
 Yk/YsP31OlMHxgcnpk6PgzYyfkRYF7w4jxVNxNYpRIL9I4G6Ybtvq3v7CDExEC7/6y
 n/BLfEq/qK882dg3luWHblrugtg/F4ZREuiJOybtpuFBL8pUYXv6Ziqa3lYRNluGww
 vBSZ9v0j8VdmpCJk6K4CvbCA7lg9r2TkUmLetEwvlRuEj8Wzayr8Xu96v7tS9wfGof
 5W9Sp3vsKYFWg==
Date: Mon, 19 Oct 2026 15:52:24 +0100
From: Lee Jones <lee@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, linux-leds@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 mfd@lists.linux.dev, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3 1/4] dt-bindings: mfd: Document Skyworks AAT2870
Message-ID: <179198322819.839288.5272985130898382430@kernel.org>
References: <20261013180933.487013-1-clamor95@gmail.com>
 <20261013180933.487013-2-clamor95@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013180933.487013-2-clamor95@gmail.com>
X-AI-Review-Draft: <20261013180933.487013-2-clamor95@gmail.com>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_NONE autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Wrong subject line.

> Document Skyworks AAT2870 LED Backlight Driver and Multiple LDO Lighting
> Management Unit.
>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  .../bindings/leds/skyworks,aat2870.yaml       | 124 ++++++++++++++++++
>  1 file changed, 124 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/skyworks,aat2870.yaml

[...]

-- 
Lee Jones
