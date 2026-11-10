Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990B9606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 20:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aM0wUI8u
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7AFD10E162;
	Tue, 10 Nov 2026 20:07:21 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A101510E162
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 20:07:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A483A60DB4;
 Tue, 10 Nov 2026 20:07:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 222D51F0089F;
 Tue, 10 Nov 2026 20:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794341234;
 bh=bq7gVJQHWBjqS6F+14wEEAlhv/2t/NZ6mUvTScCYERA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=aM0wUI8ukQcFIWwnLH7kYFVIKM+u4kUIHKxe4DFZeS86o3iCDvERJuhE2OHADygW/
 75SPx/TGsJ9wItILS7lR2s+wdJDBFA1vYLbDB1tuRS0ITTic6aJwf3Vne8kQpgD9RE
 nlf3NGZg0U2MGqQP0cBoxsFIDvfx8spTnN+wStxzXreehGhG7t6/heXQE+0rXgsdpv
 AorWslqjlAV5KmhH7KA8+n0X2A0B9nK2FZWh2ZKQ7JaJHKn2ZAon0ua8MQTbBz1ycz
 42GSHtDZBxbkixL1remC9DVOj2Xmisu2zF1pDrsBCJgH+k3/I0c4Cn8tvQ6r/tepXG
 uSDN3vQTI8m2Q==
Date: Tue, 10 Nov 2026 14:07:10 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
Cc: Jerome Brunet <jbrunet+clk@baylibre.com>,
 Fabio Estevam <festevam@gmail.com>, imx@lists.linux.dev,
 Stephen Boyd <sboyd@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Abel Vesa <abelvesa@kernel.org>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Frank Li <Frank.Li@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 linux-arm-kernel@lists.infradead.org,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-clk@vger.kernel.org, Brian Masney <bmasney+clk@redhat.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v11 5/7] dt-bindings: clock: nxp,imx95-blk-ctl: Add LDB
 bridge child node
Message-ID: <179434122994.1702778.1936835522870745685.robh@kernel.org>
References: <20261110-dcif-upstreaming-v11-0-9e13c85ae0d8@oss.nxp.com>
 <20261110-dcif-upstreaming-v11-5-9e13c85ae0d8@oss.nxp.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110-dcif-upstreaming-v11-5-9e13c85ae0d8@oss.nxp.com>
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


On Tue, 10 Nov 2026 14:27:45 +0000, Laurentiu Palcu wrote:
> Since the BLK CTL registers, like the LVDS CSR, can be used to control the
> LVDS Display Bridge controllers, add a 'bridge' child node to handle
> these use cases.
> 
> Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
> ---
>  .../bindings/clock/nxp,imx95-blk-ctl.yaml          | 24 +++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

