Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E96D606A322
	for <dri-devel@archiver.kernel.org>; Sat, 24 Oct 2026 09:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256 header.s=default header.b=AJgcN3Qn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3E6010E702;
	Sat, 24 Oct 2026 09:54:19 +0000 (UTC)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 298CD10E702
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 09:54:12 +0000 (UTC)
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 4015A1FA9B;
 Sat, 24 Oct 2026 11:54:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1792835650;
 bh=wd5WneJ3yT2t5uYaf+vnpFTb/wh6DgL3x1P6eVcBx78=; h=From:To:Subject;
 b=AJgcN3QnNjtN+OdFQ2zyIUxTxNLFrO6u09lpcfcgnB5VJvCklXGv6zbM6eQK8pBYk
 EEfPLvb1/rcpYR4UkWbGpbhORgSQQgO2M10dJjANSjacJj4qM7ywDgztGQVbE8RLBu
 me2C2CicBux3wlq357TDdbxH/iczARZ7u2mGi8IBPJTj3eEeMZ0ZQlqwofbtWTxekT
 cp8FPwq/pS6BICUajhxa6Koh98I5BAQV2ai27145IQfd1BXnrlPh8G/JnVQAH3hf6S
 sjGMla4AZKSVgyPldzvX2xJc4e0Tq7WtmNH1v2pr7OAF2wGQ7JpZfMcP0g4cvcV1lx
 eA3xDXkU7icSA==
Date: Sat, 24 Oct 2026 11:54:05 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Ernest Van Hoecke <ernestvanhoecke@gmail.com>
Cc: tessolveupstream@gmail.com, andrzej.hajda@intel.com,
 neil.armstrong@linaro.org, rfoss@kernel.org,
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, marex@denx.de, valentin@compulab.co.il,
 philippe.schenker@toradex.com, alexander.stein@ew.tq-group.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] drm: bridge: ti-sn65dsi83: Fix DSI mode flags for
 stable LVDS output
Message-ID: <20261024095405.GA5692@francesco-nb>
References: <c4c33f14-0da0-447a-ab82-2e2f65c09c07@gmail.com>
 <7056b23b-ed81-4d79-b782-5cfcb0102ef7@gmail.com>
 <60a24977-b181-40e4-bcf6-38b65af293e2@gmail.com>
 <DI18PL73UQKR.2YZVZ21V69H7O@bootlin.com>
 <e88af0b7-388d-4b0a-8eb2-a367e24e84fb@gmail.com>
 <DIMMKNT9RHYM.1BRF1S1V5SIKI@bootlin.com>
 <1716be56-ac43-440b-a5df-58cbf571ba95@gmail.com>
 <DINH3J2SM26P.3KE6GE9VPB1OC@bootlin.com>
 <3hfae2i2i2toxbo7hg2if6pztaswgnfj65xfm2c4ofljc6jhua@slaqoewn4mxq>
 <DLATMIFKDMHV.24XNMCRI2ZKBI@bootlin.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DLATMIFKDMHV.24XNMCRI2ZKBI@bootlin.com>
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello Luca, Ernest,

On Wed, Sep 09, 2026 at 03:30:53PM +0200, Luca Ceresoli wrote:
> On Fri Sep 4, 2026 at 2:02 PM CEST, Ernest Van Hoecke wrote:
> >> > Also, from our testing, when using:
> >> >
> >> > dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST |
> >> >           MIPI_DSI_MODE_VIDEO_NO_HSA | MIPI_DSI_MODE_NO_EOT_PACKET;
> >> >
> >> > we are not able to get display output.
> >>
> >> This is the case for the panel I worked on as well. In the practice we both
> >> observe that non-burst mode is what fixes the panel, but there is no clear
> >> explanation of the reason in the docs (that's what I hope to discover from
> >> TI).
> >>
> > I am testing a DSI panel on our Verdin iMX8MP module, and noticed that
> > this caused a regression.

[...]

> > I think we'll need to either revert this and later apply both together
> > when ready, or apply the second patch now as well. Right now, it broke
> > the DSI panel behind a TI sn65dsi83 bridge on v7.3-rc1.
> 
> Reverting is surely the last resort. If you can answer the above questions
> it would be good, maybe we find out reverting is not necessary, and worst
> case we'll revert with better understanding on what went wrong, and maybe
> come up with a new fix that doesn't regress.

What's the status of this regression?

Francesco


