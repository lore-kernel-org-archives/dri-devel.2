Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DB7606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 15:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=YITMaOzE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27412112B8E;
	Fri, 27 Nov 2026 15:15:51 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C35E112B93
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 15:15:45 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 3183E4E417C5;
 Fri, 27 Nov 2026 15:15:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id E81C86049C;
 Fri, 27 Nov 2026 15:15:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 83EF011E90B55; Fri, 27 Nov 2026 16:15:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795792537; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=K/F58fTzeymXPtAhbnqmB/CVuNXYDU2P7HmmINGKBoo=;
 b=YITMaOzEHoFT8Vw3PeTkE4bw3pS1fynbk/EHTRHYCmd2eGK6trTuao71I+BwgclPKtBf2o
 sXhYc+lTt7gkgm0WPbFiSBV3G0Yi0tjt3He5CnRIZzNZmZyaI81slENa8dMNr2AjL5nevD
 C8NRIjLqsiFuBtaDTZxyYTIIu9YQObpVyxiT3YZKPkrVOI5YZDW5mB9CjxsCTITBcTKuz9
 zj62EQanPs5MxrFTpq6InG1/a7X+xnrI936IdtvhfeYKAi6uyRM43waRUE/mI9BMw+KnMv
 j9epb+hFf8w3sljp/duVbQHoFU6i/rULR5AuoYFV6VTl55jUK/wRkxaJBsgJ7Q==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Nov 2026 16:15:28 +0100
Message-Id: <DN63BMGBI07A.1IC73REGZ7NXZ@bootlin.com>
Subject: Re: [PATCH v13 0/5] Add support for i.MX94 DCIF
Cc: <linux-clk@vger.kernel.org>, <imx@lists.linux.dev>,
 <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>
To: "Laurentiu Palcu" <laurentiu.palcu@oss.nxp.com>, "Abel Vesa"
 <abelvesa@kernel.org>, "Peng Fan" <peng.fan@nxp.com>, "Stephen Boyd"
 <sboyd@kernel.org>, "Brian Masney" <bmasney+clk@redhat.com>, "Jerome
 Brunet" <jbrunet+clk@baylibre.com>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Frank Li" <Frank.Li@nxp.com>, "Sascha Hauer"
 <s.hauer@pengutronix.de>, "Pengutronix Kernel Team"
 <kernel@pengutronix.de>, "Fabio Estevam" <festevam@gmail.com>, "Philipp
 Zabel" <p.zabel@pengutronix.de>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Luca Ceresoli"
 <luca.ceresoli@bootlin.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.22.0
References: <20261120-dcif-upstreaming-v13-0-966ac248773f@oss.nxp.com>
 <awmGCp4e2pgtxsqr@vm>
In-Reply-To: <awmGCp4e2pgtxsqr@vm>
X-Last-TLS-Session-Version: TLSv1.3
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

On Fri Nov 27, 2026 at 2:41 PM CET, Laurentiu Palcu wrote:
> Hi Luca, Frank,
>
> All patches in v13 now have review tags. Since we are approaching -rc6,
> would it be possible to pick this up for 7.5?
>
> Luca: could you apply 1/5 and 2/5 to drm-misc-next?

I plan to apply these next week. I ususally leave at least 1w after a patch
is reviewed before applying it, in case someone has objections.

> Frank: could 3/5-5/5 go through i.MX tree?

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
