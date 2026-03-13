Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39305107BCCC
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 16:57:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 993FC10ECD2;
	Fri, 13 Mar 2026 16:57:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="iDXYktlF";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20C2010ECF3
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 16:57:16 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id D3F1C1A2E1B;
 Fri, 13 Mar 2026 16:57:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id A5CA860027;
 Fri, 13 Mar 2026 16:57:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 7987E10369F5C; Fri, 13 Mar 2026 17:57:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1773421031; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=8M/S3Ow+8SDfw7oljSFsAVcymgOGfa8sayY3tQjb990=;
 b=iDXYktlFW9ZuKZk+0BIDSBqa+MpQofvVxbMjOGZn8Hh/3TqJVHUdnr4Wc+X44uOOewF2jX
 +q30YT0lVnM2MS0MkOPSerMb3OPv6oHuoaSJzffSlzPf1/f90F60GLkeTzk4JBCZWn42kT
 jhlu+za7Y/0Dv3/X3Au+IZx0xmCpb3govZHK1Bh9MulODok4v/iS+GJHkfxKE3iqGFaZxs
 5vZo+NWR+oh+NxsRnFhUbGN0BUNtbmquepvOr74hN1pkKMIs3C+IWVRh6zuPD+Ynyycfwu
 vqe5Soc7dixDCQsH3UPXJiFZYc7RkQ3KzmWYjvdVofFyxp8CL9wTSCyEOjl4/g==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 13 Mar 2026 17:57:00 +0100
Message-Id: <DH1TA9U2BXUU.2Z470IEKJH0SQ@bootlin.com>
Subject: Re: [PATCH] drm/tilcdc: Remove tilcdc_panel driver reintroduced by
 a merge
Cc: "Bajjuri Praneeth" <praneeth@ti.com>, <thomas.petazzoni@bootlin.com>,
 "Jyri Sarha" <jyri.sarha@iki.fi>, "Tomi Valkeinen"
 <tomi.valkeinen@ideasonboard.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Thomas Zimmermann"
 <tzimmermann@suse.de>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>
To: "Kory Maincent" <kory.maincent@bootlin.com>, "Maxime Ripard"
 <mripard@kernel.org>, <linux-kernel@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.20.1
References: <20260305155921.659550-1-kory.maincent@bootlin.com>
In-Reply-To: <20260305155921.659550-1-kory.maincent@bootlin.com>
X-Last-TLS-Session-Version: TLSv1.3
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

On Thu Mar 5, 2026 at 4:59 PM CET, Kory Maincent wrote:
> From: "Kory Maincent (TI)" <kory.maincent@bootlin.com>
>
> The tilcdc_panel driver was removed by commit 8f1e1ab9c794 ("drm/tilcdc:
> Remove tilcdc panel driver"), but was inadvertently reintroduced by the
> merge commit 8b85987d3cf5 ("Merge drm/drm-next into drm-misc-next").
>
> The regression went unnoticed because standard git commands such as
> 'git show' do not expose the change. It was only spotted via
> 'git show --stat':
>
>   git show --stat 8b85987d3cf5 | grep tilcdc
>   drivers/gpu/drm/tilcdc/tilcdc_panel.c | 408 +
>
>   git show 8b85987d3cf5 | grep tilcdc
>   (no output)
>
> Remove tilcdc_panel.c again to restore the previously intended state.
>
> Fixes: 8b85987d3cf5 ("Merge drm/drm-next into drm-misc-next")
> Signed-off-by: Kory Maincent (TI) <kory.maincent@bootlin.com>

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
