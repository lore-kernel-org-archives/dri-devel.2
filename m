Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AF20C5CFCF
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 02:24:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB87610E0BC;
	Fri, 14 Aug 2026 02:24:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="B/KVoQLg";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A07B410E06E;
 Fri, 14 Aug 2026 02:24:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A8F0D600AF;
 Fri, 14 Aug 2026 02:24:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3D0C1F00A3A;
 Fri, 14 Aug 2026 02:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786674283;
 bh=S8iDmpYWqJ9fssIS5x49yt0+9haPBBRkWdqdJJSzLqs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=B/KVoQLgRrB/buesTvftEZnMjXcwYwjksivF6DK2tvOloLG1j0VIN/A0EpSxdFpir
 VOxyy727q2B7Wb0z+iboUX9Z8FddkQsBD6+l33O8K9oAdVNRptdz6ZIvutPgjXe6ar
 LqVjKQ4vbUIZnqzBTgONgwu1exwwwwaW882VLhDdJq+nb/jPAyBJWtrAF3rORGqGiw
 kqh2gJwvgUX0WgHCUdjPBggVv3lHc+D5lsyzpvofGdX8t9Csav+lEsBZ+Vk+nEzHRa
 k5LhdE0GoCmVexNc3W7k7oDwLuw+TQyTJZzZfue6JzK3UqHnRSPn/klOU2glYjAzIi
 J94p/TDIcTCcA==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfauth.phl.internal (Postfix) with ESMTP id 05384F40067;
 Thu, 13 Aug 2026 22:24:42 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Thu, 13 Aug 2026 22:24:42 -0400
X-ME-Sender: <xms:aXx-aoKgl6vmsjM7McXCFY-YDjquvonGDXQZBne5So4flGeEuqJp5w>
 <xme:aXx-aibWWwpG0KuKcYz4m415xBWsE_W5xeNfnCeRvmBwcEZutAJNzZM--pShSdvTy
 HDDhqnmDco-3C8uV1dMTiY2JiD0im9Rhl6erXR0VgjI5gMRCHc7n80>
X-ME-Received: <xmr:aXx-auLtsOfTLVX0uT8Yz1glq4w-kRjr7sAM3I5DK7SwwheLBjVVcz4b-mX3p4mTtjfoogrIBHrG1Dg6er_TwJTvxmNXrxWO>
X-ME-Proxy-Cause: dmFkZTEOQs8uEuqnyQymEazKhkuTGFexvRmicbhHAah0/SEneWkhd+bcFnCrMX5UtpLklE
 suesYSRchahrkulqnCmHav1k+FczgBKwpZLnPHLgeGSQIrMQdvI3f3gv84ZiAmt49r+Wnt
 Wm0HqBZV/B09DnLujXwXYTYm9mKJTi208tQYo5gIRpjbWXTMqDCE4yvcKi1W9+icjr+Ftd
 jyA4iyBJjKLo7xG1ZZ9v1vH9Cz4+iqsQAOp8d24DwpaQU3YWfrcHIZLJEE88lV9Qrf7nAJ
 0z9NfxquJEMDO2ArF0cmKaIqP+3tiWXnIv5lh7Vp769g3uIjpHPYj6Y3bIn7urU8EJmJmZ
 YsNklKwkMJp5JCzEYgqiUjrJtyMYm4V4c0C3wADGVeYtmMQBubmJIoR/FIBNlQgvFnqPBD
 0dKXuBCi/D49O3YRgasEZzob5SWcvbOkFhrLFT0M2cLav9OQ0BFO5uzsN2Sef6qsLo9iYL
 z4jcyFX8IDzREAerP5GtiY3uD+3vx7ry0ZpMxxZawk8c/PjCfTU4mozDOQEnQ+WdlEGG3V
 vlVEtIcAd83O8GvyG72K3eftagY1cagFXf66zFTMQU+vA47sRaRoH9/otk3MnjH6vumioQ
 oEfJtCE0zMWYo8sDhIgzHqTK+1edPXzn4cGg2FRvST3qObp5AQh2FDHzjPNg
X-ME-Proxy: <xmx:aXx-arp0BS_7p6N1W6b8BYgFaGVsmGnPTEwZ14YjMavXzWukA33wvw>
 <xmx:anx-anBmxDUbXIRAlDVLbVJW_Io9JI4-trTp1fYPqpS-22GxOKaiPQ>
 <xmx:anx-ahf9noNu1UzjQmnwvYs3lzq7IYaVT5hehaq8FRqNIpTsN-Ve6g>
 <xmx:anx-anIjPylu3TjVmLoVjEuH-9si-myx7OHQsREKwwABjK4FsIL-WA>
 <xmx:anx-ahuNeOjdf4_ctGwwkvyTCf0BdgWp7c9zIPeBf9RBnHOkgUmiykcK>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Aug 2026 22:24:41 -0400 (EDT)
Date: Thu, 13 Aug 2026 19:24:40 -0700
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
Message-ID: <an58aOZBy-iEbrc9@tardis.local>
References: <20260805140227.44868-1-boqun@kernel.org>
 <an44yIv7WG7vqTqQ@tardis.local>
 <CADnq5_PLV1rDw8DSawdHfQxyk8XgPp94TQa0HuFVdZVvZo+zmQ@mail.gmail.com>
 <an5ESxy8-OMYvD4d@tardis.local>
 <CADnq5_PQgYboc8pPCRYimpf7fALgSPid-GGJzNsA+TuODsa8gA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADnq5_PQgYboc8pPCRYimpf7fALgSPid-GGJzNsA+TuODsa8gA@mail.gmail.com>
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

On Thu, Aug 13, 2026 at 08:51:22PM -0400, Alex Deucher wrote:
> On Thu, Aug 13, 2026 at 6:25 PM Boqun Feng <boqun@kernel.org> wrote:
> >
> > On Thu, Aug 13, 2026 at 06:01:47PM -0400, Alex Deucher wrote:
> > > On Thu, Aug 13, 2026 at 5:36 PM Boqun Feng <boqun@kernel.org> wrote:
> > > >
> > > > On Wed, Aug 05, 2026 at 07:02:21AM -0700, Boqun Feng wrote:
> > > > > In a Strix Halo system, a >100 average_vcn_activity in gpu_metrics can
> > > > > be observed by running the following command:
> > > > >
> > > > >     ffmpeg -hwaccel vappi -vappi_device /dev/dri/renderD128 -i \
> > > > >     ~/sample-10s.mp4 -vf hwupload,scale_vappi=format=nv12 -c:v \
> > > > >     h264_vappi /tmp/output.mp4
> > > > >
> > > > > This is incorrect because the value is supposed to be in [0-100] range.
> > > > >
> > > > > The cause of the issue is that the metrics.VcnActivity reported by
> > > > > smu_cmn_get_metrics_table() is a permyriad value instead of a percentage
> > > > > value (e.g. smu_v14_0_0_get_smu_metrics_data() has a division by 100 to
> > > > > report the vcn_busy_percent). Therefore fix this by applying the same
> > > > > division in smu_v14_0_0_get_gpu_metrics().
> > >
> > > I think this is correct as is.  smu_v14_0_0_get_smu_metrics_data() is
> > > used to fetch data for standardized formats like hwmon while
> > > smu_v14_0_0_get_gpu_metrics() is for dumping the raw metrics data.
> > >
> >
> > Well, then kgd_pp_interface.h needs some help?
> >
> > struct gpu_metrics_v3_0 {
> >         ...
> >         /* Utilization */
> >         /* time filtered GFX busy % [0-100] */
> >         uint16_t                        average_gfx_activity;
> >         /* time filtered VCN busy % [0-100] */
> >         uint16_t                        average_vcn_activity;
> >         ...
> > }
> >
> > Clearly it's not true.
> 
> That was likely copy and pasted from the firmware interface
> (smu14_driver_if_v14_0_0.h):
> uint16_t VcnActivity;                //Time filtered VCN busy % [0-100]
> 
> Other generations seem to do the same thing (raw data in metrics table
> and % in the hwmon type interfaces). E.g., smu_v13_0_4_ppt.c:
> smu_v13_0_4_get_gpu_metrics()
> gpu_metrics->average_mm_activity = metrics.UvdActivity;
> vs smu_v13_0_4_get_smu_metrics_data():
> *value = metrics->UvdActivity / 100;
> 

Could you help fix the document while you're at it? I cannot confirm by
myself the valid range of that raw data. Thanks!

Regards,
Boqun

> Alex
> 
> >
> > [Cc amdgpu_top]
> >
> > Regards,
> > Boqun
> >
> > > Alex
> > >
> > > > >
> > > > > Reported-by: Mark Janes <mjanes@netflix.com>
> > > > > Signed-off-by: Boqun Feng <boqun@kernel.org>
> > > >
> > > > Ping?
> > > >
> > > > Regards,
> > > > Boqun
> > > >
> > > > > ---
> > > > >  drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c | 3 ++-
> > > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> > > > > index 568665265a13..1058338344b0 100644
> > > > > --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> > > > > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> > > > > @@ -566,7 +566,8 @@ static ssize_t smu_v14_0_0_get_gpu_metrics(struct smu_context *smu,
> > > > >       gpu_metrics->temperature_skin = metrics.SkinTemp;
> > > > >
> > > > >       gpu_metrics->average_gfx_activity = metrics.GfxActivity;
> > > > > -     gpu_metrics->average_vcn_activity = metrics.VcnActivity;
> > > > > +     /* metrics.VcnActivity is permyriad, convert it to percentage. */
> > > > > +     gpu_metrics->average_vcn_activity = metrics.VcnActivity / 100;
> > > > >       memcpy(&gpu_metrics->average_ipu_activity[0],
> > > > >               &metrics.IpuBusy[0],
> > > > >               sizeof(uint16_t) * 8);
> > > > > --
> > > > > 2.50.1 (Apple Git-155)
> > > > >
