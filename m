Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A89606A697
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 21:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=Y7+pEitH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E612110E38E;
	Fri, 20 Nov 2026 21:31:25 +0000 (UTC)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43F0410E38E
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 21:31:19 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-7086-3000--a06.rev.dnainternet.fi [IPv6:2001:14ba:7086:3000::a06])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6FA714E6;
 Fri, 20 Nov 2026 22:28:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1795210127;
 bh=M7Qcq8V3Jr2gLoOzs+ayK8dikX5kJkrE/bo1yp+s4tA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Y7+pEitHa7rz0OLH9JT3Q9uw0F6+sdkuHT9Va5Ttw9M7zug6ogtix7wCXpSlsVxCG
 NHanSRRXOK5a+B19zRjoYv+jA1z9LQvpvNAX6SSyN9Yzpd/EtJGvqYv9+kyTipz/Ck
 xjilVepncVyQs3BTnJRFx+9YYuNn0i87hLlfnmmw=
Date: Fri, 20 Nov 2026 23:31:16 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Sowjanya Komatineni <skomatineni@nvidia.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 Hans Verkuil <hverkuil+cisco@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Cong Nguyen <congnt264@gmail.com>,
 Faisal Mukhtar <mukhtarfaisal03@gmail.com>,
 Dan Carpenter <error27@gmail.com>, Hungyu Lin <dennylin0707@gmail.com>,
 Hao-Qun Huang <alvinhuang0603@gmail.com>, Yury Norov <ynorov@nvidia.com>,
 Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 linux-media@vger.kernel.org, linux-tegra@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v1 01/10] staging: media: tegra-video: Move driver to
 media/platform/nvidia
Message-ID: <20261120213116.GB2472094@killaraus.ideasonboard.com>
References: <20261113161819.36847-1-clamor95@gmail.com>
 <20261113161819.36847-2-clamor95@gmail.com>
 <20261120143147.GA2466366@killaraus.ideasonboard.com>
 <CAPVz0n3u3oe1+H_w9jE2afb9PQT0VLtYVqfHeVNc3D+tLN6NDQ@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPVz0n3u3oe1+H_w9jE2afb9PQT0VLtYVqfHeVNc3D+tLN6NDQ@mail.gmail.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 20, 2026 at 05:31:17PM +0200, Svyatoslav Ryhel wrote:
> пт, 20 лист. 2026 р. о 16:31 Laurent Pinchart пише:
> > On Fri, Nov 13, 2026 at 06:18:10PM +0200, Svyatoslav Ryhel wrote:
> > > The Tegra Video Input drivers are mature and developed enough to be moved
> > > from staging into the media subsystem. No other changes are introduced.
> >
> > The driver should at least be converted to be MC-centric before being
> > moved out of staging. I haven't checked if other changes would also be
> > needed.
> 
> Does the media subsystem deny video-centric devices from even being
> moved into it? I have not seen this restriction imposed; could you
> please point me to where this is stated in the media subsystem
> documentation?

There's a consensus that devices that require control of camera sensors
(i.e. "MIPI" cameras) must be MC-centric. That's not documented, we
should probably fix that.

> I would like to convert this device, but that may take quite some time
> and may case regressions if not done carefully. This patchset apart
> from moving to media is mostly fixes to work correctly with mt9m114
> and tegra114 bring-up which is quite simple and straight forward
> change.

Converting to the MC API will require some changes in userspace. That's
why it's important to make this change before destaging the driver.

> BTW, may you ack mt9m114 get_fwnode_pad change[1]. I have updated it
> to your liking, Sakari seems to ignore it.
> 
> [1] - https://lore.kernel.org/lkml/20261006153619.304520-1-clamor95@gmail.com/

In the review of v1, I wrote in my last message
(https://lore.kernel.org/linux-media/20260721103845.GJ50424@killaraus.ideasonboard.com/)
that the issue seems to come from a bug in the VI driver. Let's continue
the discussion there.

> > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > ---
> > >  drivers/media/platform/nvidia/Kconfig                           | 2 ++
> > >  drivers/media/platform/nvidia/Makefile                          | 1 +
> > >  .../media => media/platform/nvidia}/tegra-video/Kconfig         | 0
> > >  .../media => media/platform/nvidia}/tegra-video/Makefile        | 0
> > >  .../{staging/media => media/platform/nvidia}/tegra-video/TODO   | 0
> > >  .../{staging/media => media/platform/nvidia}/tegra-video/csi.c  | 0
> > >  .../{staging/media => media/platform/nvidia}/tegra-video/csi.h  | 0
> > >  .../media => media/platform/nvidia}/tegra-video/tegra20.c       | 0
> > >  .../media => media/platform/nvidia}/tegra-video/tegra210.c      | 0
> > >  .../{staging/media => media/platform/nvidia}/tegra-video/vi.c   | 0
> > >  .../{staging/media => media/platform/nvidia}/tegra-video/vi.h   | 0
> > >  .../media => media/platform/nvidia}/tegra-video/video.c         | 0
> > >  .../media => media/platform/nvidia}/tegra-video/video.h         | 0
> > >  .../{staging/media => media/platform/nvidia}/tegra-video/vip.c  | 0
> > >  .../{staging/media => media/platform/nvidia}/tegra-video/vip.h  | 0
> > >  drivers/staging/media/Kconfig                                   | 2 --
> > >  drivers/staging/media/Makefile                                  | 1 -
> > >  17 files changed, 3 insertions(+), 3 deletions(-)
> > >  rename drivers/{staging/media => media/platform/nvidia}/tegra-video/Kconfig (100%)
> > >  rename drivers/{staging/media => media/platform/nvidia}/tegra-video/Makefile (100%)
> > >  rename drivers/{staging/media => media/platform/nvidia}/tegra-video/TODO (100%)
> > >  rename drivers/{staging/media => media/platform/nvidia}/tegra-video/csi.c (100%)
> > >  rename drivers/{staging/media => media/platform/nvidia}/tegra-video/csi.h (100%)
> > >  rename drivers/{staging/media => media/platform/nvidia}/tegra-video/tegra20.c (100%)
> > >  rename drivers/{staging/media => media/platform/nvidia}/tegra-video/tegra210.c (100%)
> > >  rename drivers/{staging/media => media/platform/nvidia}/tegra-video/vi.c (100%)
> > >  rename drivers/{staging/media => media/platform/nvidia}/tegra-video/vi.h (100%)
> > >  rename drivers/{staging/media => media/platform/nvidia}/tegra-video/video.c (100%)
> > >  rename drivers/{staging/media => media/platform/nvidia}/tegra-video/video.h (100%)
> > >  rename drivers/{staging/media => media/platform/nvidia}/tegra-video/vip.c (100%)
> > >  rename drivers/{staging/media => media/platform/nvidia}/tegra-video/vip.h (100%)
> >
> > --
> > Regards,
> >
> > Laurent Pinchart

-- 
Regards,

Laurent Pinchart
