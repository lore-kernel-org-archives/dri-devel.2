Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10166C5B572
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 22:25:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C598910E089;
	Thu, 13 Aug 2026 22:25:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Obg7/duf";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 881CF10E089;
 Thu, 13 Aug 2026 22:25:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 338BF40270;
 Thu, 13 Aug 2026 22:25:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AF3D1F00A3A;
 Thu, 13 Aug 2026 22:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786659920;
 bh=xRWXZyiVY4kiI+i8c6y4TLyCdbj69IOV5XWl+fnpwZQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Obg7/dufE/Er4DsnAKQnSNiYWVmi1+mKrSjNymukGbcRsi3NHcke+DBu/sjTozgQZ
 VyDlinsNZpDhYZu9bpfvfFjUHMgAl3KxyGlG/a+ToqXnbLMZ7lL12XAUWxW0iB8Drd
 mri4w0nqc6hpRZynJX0sFQM+BarjugMNbInR04JjRfW5hhBCvl9Ic2SZwIQEHgTys/
 8lJ3sFLtn8Q0EV8sY4xgo5SfJtk7H5fH4l6qHVTmYyi+HCVPQHuVejUkeSvlGJyqjM
 HtA7Wst6ulNP7goMNmAdmK61YzGggi6S3XDmGOEwWSIpANMnAQby1plDWKB2QYLJDv
 jJjcV6eXYpt2g==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfauth.phl.internal (Postfix) with ESMTP id BE514F40066;
 Thu, 13 Aug 2026 18:25:18 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Thu, 13 Aug 2026 18:25:18 -0400
X-ME-Sender: <xms:TkR-amNYYaen4oVaPbyoB3eBR7azEsafUR7WdiZ4si5GWXiPWW7fwg>
 <xme:TkR-avpsxTFLZ_za964kYI1o2jS8nzTqR0hbnr6y6yLevyoIBErQruq4sx-G2Z_rw
 gL4VFxsnwxqjL_xMsQRZM41LzAZDb0mysI-zOW6orJP0NSYz9qmGzc>
X-ME-Received: <xmr:TkR-aj61L-DIoRKGBo4L9QuAA4e2DRv3ZXEMWevTaVDZPHYnYwltO8rHwMQ-rJHV9SodNm9zx8p0sAUl-sHY_afc3ZGcPbGH>
X-ME-Proxy-Cause: dmFkZTGHcwBQLUX8Rq5GfMgBsfia30ILStTtI4E0m/tF5MSe6irWysrI8QNVVhGMlaa8f6
 IUBl6l5LoEUwDmEFt6VEOL70LKawbLmFu7Xdo1OMYkF2ycHEgtqXpN7JELeJNGgJA2WRMz
 7aOT3ff+0z0geK5c+tdQu0LSsSWqeT9QQ3szaLuydAjwPjXzJsR6aswoClUlSy+sRD3nCc
 FRM6VEoNpI+8UXm6LUuVHMkflHFUnYphVcbtW6AIxsgJejpKPB221Uc+3HFoj9NZHSyr5V
 sNjs2eZqSuy66v0l+/xUFwjDHB9ca1cNFENie2IBEO5P/KBoNasfLf95jG9XYhBAixrEYF
 Jqi5uMMLIDtldO4is8hRKKRpSsMSo6hdZxFALonI2EGkaOKPA3EmEhYEfw4DiDzwSKWwNB
 JUVGBDikfnsAMt6zp93dOpUyl34TR+TIEZ8dD4WUyKuM9dGF+a6wTJYr1CJABlMO2YeCwE
 XmfxC1jylt0KO9DFf8jF4C908twkBu3YYfHNmX4KJtrUq2sQljqTyMHTnmKgZuIOMQAfkA
 O7Dd5kudNVg8YEO5NOVEoAr5PQvnRrtRdqboFiYBIasGjYUn+MEiEThMIrVkSpJPVOt4cr
 qy+Yt9czc9CsbPPRigHPAa4Gt2qHWwM2SmedagSN0nvE9FSMvCzf8ufpgRjw
X-ME-Proxy: <xmx:TkR-ahp7dsc60dfs45uN-pYklyZ0ii8S-NXfU2iAxNwQn5R743Xknw>
 <xmx:TkR-apLlorJ8llXDEVPQvKpjraRvFmMTJP_8KNRwHpF9I0fXd9mCzw>
 <xmx:TkR-amiCTwouoDqUJKUFA1Iqx5rh2HSTbjxetqTtJFYTpIq8DznelQ>
 <xmx:TkR-aq-1mtZq6PedT4QRWmrFkTUXWwItvpYm30DwHtakwDcRqy0ZmQ>
 <xmx:TkR-aipMZaKusKelKdbSqoZ0sL8lT4yryflyCOAvTgUkyJCtgOjJflMY>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Aug 2026 18:25:16 -0400 (EDT)
Date: Thu, 13 Aug 2026 15:25:15 -0700
From: Boqun Feng <boqun@kernel.org>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Mark Janes <mjanes@netflix.com>,
 Kenneth Feng <kenneth.feng@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Lijo Lazar <lijo.lazar@amd.com>, Asad Kamal <asad.kamal@amd.com>,
 Yang Wang <kevinyang.wang@amd.com>,
 Priya Hosur <Priya.Hosur@amd.com>, mythilam <mythilam@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Umio Yasuno <coelacanth_dream@protonmail.com>
Subject: Re: [PATCH] drm/amd/pm: Fix incorrect avg vcn utilization in
 gpu_metrics
Message-ID: <an5ESxy8-OMYvD4d@tardis.local>
References: <20260805140227.44868-1-boqun@kernel.org>
 <an44yIv7WG7vqTqQ@tardis.local>
 <CADnq5_PLV1rDw8DSawdHfQxyk8XgPp94TQa0HuFVdZVvZo+zmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADnq5_PLV1rDw8DSawdHfQxyk8XgPp94TQa0HuFVdZVvZo+zmQ@mail.gmail.com>
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

On Thu, Aug 13, 2026 at 06:01:47PM -0400, Alex Deucher wrote:
> On Thu, Aug 13, 2026 at 5:36 PM Boqun Feng <boqun@kernel.org> wrote:
> >
> > On Wed, Aug 05, 2026 at 07:02:21AM -0700, Boqun Feng wrote:
> > > In a Strix Halo system, a >100 average_vcn_activity in gpu_metrics can
> > > be observed by running the following command:
> > >
> > >     ffmpeg -hwaccel vappi -vappi_device /dev/dri/renderD128 -i \
> > >     ~/sample-10s.mp4 -vf hwupload,scale_vappi=format=nv12 -c:v \
> > >     h264_vappi /tmp/output.mp4
> > >
> > > This is incorrect because the value is supposed to be in [0-100] range.
> > >
> > > The cause of the issue is that the metrics.VcnActivity reported by
> > > smu_cmn_get_metrics_table() is a permyriad value instead of a percentage
> > > value (e.g. smu_v14_0_0_get_smu_metrics_data() has a division by 100 to
> > > report the vcn_busy_percent). Therefore fix this by applying the same
> > > division in smu_v14_0_0_get_gpu_metrics().
> 
> I think this is correct as is.  smu_v14_0_0_get_smu_metrics_data() is
> used to fetch data for standardized formats like hwmon while
> smu_v14_0_0_get_gpu_metrics() is for dumping the raw metrics data.
> 

Well, then kgd_pp_interface.h needs some help?

struct gpu_metrics_v3_0 {
	...
	/* Utilization */
	/* time filtered GFX busy % [0-100] */
	uint16_t			average_gfx_activity;
	/* time filtered VCN busy % [0-100] */
	uint16_t			average_vcn_activity;
	...
}

Clearly it's not true.

[Cc amdgpu_top]

Regards,
Boqun

> Alex
> 
> > >
> > > Reported-by: Mark Janes <mjanes@netflix.com>
> > > Signed-off-by: Boqun Feng <boqun@kernel.org>
> >
> > Ping?
> >
> > Regards,
> > Boqun
> >
> > > ---
> > >  drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> > > index 568665265a13..1058338344b0 100644
> > > --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> > > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> > > @@ -566,7 +566,8 @@ static ssize_t smu_v14_0_0_get_gpu_metrics(struct smu_context *smu,
> > >       gpu_metrics->temperature_skin = metrics.SkinTemp;
> > >
> > >       gpu_metrics->average_gfx_activity = metrics.GfxActivity;
> > > -     gpu_metrics->average_vcn_activity = metrics.VcnActivity;
> > > +     /* metrics.VcnActivity is permyriad, convert it to percentage. */
> > > +     gpu_metrics->average_vcn_activity = metrics.VcnActivity / 100;
> > >       memcpy(&gpu_metrics->average_ipu_activity[0],
> > >               &metrics.IpuBusy[0],
> > >               sizeof(uint16_t) * 8);
> > > --
> > > 2.50.1 (Apple Git-155)
> > >
