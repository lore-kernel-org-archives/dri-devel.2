Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25579C5DF76
	for <dri-devel@archiver.kernel.org>; Sun, 16 Aug 2026 14:05:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D8C010E2EA;
	Sun, 16 Aug 2026 14:05:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=protonmail.com header.i=@protonmail.com header.b="SDzZijdI";
	dkim-atps=neutral
Received: from mail-244103.protonmail.ch (mail-244103.protonmail.ch
 [109.224.244.103])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 631FA10F66F;
 Fri, 14 Aug 2026 15:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1786720444; x=1786979644;
 bh=ebHvG8J7OHD1DkAFZuYCk4KhWJsTkQYIAAPyBGxbFw8=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=SDzZijdIUQ8nCxCsFGdVcVfY7Di3O4mgbnUwZeqEoW7YM2Wy6I82CYnItojdFIZgz
 FA0FOmOXQeS9Iuh7ooFC2qUgjhEZnRUaHompUumGCQxNFzvze56JkmxF8bo8ELPy9+
 hzqgkCkbxFFEWuPDePKy853hcyGsi1ksF3TUOnSBEh6m/DhUtXFmZf8oUBHC+6NqFj
 4fxW2NmKtYYQrvnnkCNlg7Lny3+6RELyRrXhuxFbmxppB87pFg/OuRCX8UxaCBUh53
 03S7lUhtuOHWyVt34lStnDR7tE5ObtnrkHrtlrej53Q8XT0v0/YEVxdgiTqRLtJOQh
 mdTDGYxmrqLag==
Date: Fri, 14 Aug 2026 15:14:00 +0000
To: Boqun Feng <boqun@kernel.org>
From: Umio-Yasuno - coelacanth_dream <coelacanth_dream@protonmail.com>
Cc: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org,
 Mark Janes <mjanes@netflix.com>, Kenneth Feng <kenneth.feng@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?utf-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Lijo Lazar <lijo.lazar@amd.com>, Asad Kamal <asad.kamal@amd.com>,
 Yang Wang <kevinyang.wang@amd.com>, Priya Hosur <Priya.Hosur@amd.com>,
 mythilam <mythilam@amd.com>, Mario Limonciello <mario.limonciello@amd.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/amd/pm: Fix incorrect avg vcn utilization in
 gpu_metrics
Message-ID: <rTEGWQn-uThfLOzKzIsvt-Dk_dm9_L0dNXzRGAQd0qYSQbMVpvB5cd_zC5CuMFkC-u2o3KjqDjh_J4jcYWUtXR8O9KEL4suMEV8lJQCOvXA=@protonmail.com>
In-Reply-To: <an5ESxy8-OMYvD4d@tardis.local>
References: <20260805140227.44868-1-boqun@kernel.org>
 <an44yIv7WG7vqTqQ@tardis.local>
 <CADnq5_PLV1rDw8DSawdHfQxyk8XgPp94TQa0HuFVdZVvZo+zmQ@mail.gmail.com>
 <an5ESxy8-OMYvD4d@tardis.local>
Feedback-ID: 19510729:user:proton
X-Pm-Message-ID: a65a74b293661b0e75435d7cb352b25804818840
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sun, 16 Aug 2026 14:05:11 +0000
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

Apologies, I forgot to set the CC. Below is my opinion that I wrote outside=
 the thread.

---
amdgpu_top already divides average_vcn_activity in gpu_metrics_v3_0 by 100,=
 so this patch would unfortunately end up affecting user-space applications=
.

In my view, if users want to obtain media engine usage that is properly cor=
rected based on the firmware (or firmware version) in the AMDGPU driver, th=
e best option is to use the vcn_busy_percent sysfs interface.
However, that adds extra reading cost.

Alternatively, since gpu_metrics is designed as an interface that provides =
raw data[^1] (but undocumented it[^2]), it would be better to have the corr=
ection applied on the user-space.

[^1]: https://gitlab.freedesktop.org/drm/amd/-/work_items/3251#note_2904104
[^2]: https://www.kernel.org/doc/html/latest/gpu/amdgpu/thermal.html#gpu-me=
trics
---

On Friday, August 14th, 2026 at 7:25, Boqun Feng <boqun@kernel.org> wrote:

> On Thu, Aug 13, 2026 at 06:01:47PM -0400, Alex Deucher wrote:
> > On Thu, Aug 13, 2026 at 5:36=E2=80=AFPM Boqun Feng <boqun@kernel.org> w=
rote:
> > >
> > > On Wed, Aug 05, 2026 at 07:02:21AM -0700, Boqun Feng wrote:
> > > > In a Strix Halo system, a >100 average_vcn_activity in gpu_metrics =
can
> > > > be observed by running the following command:
> > > >
> > > >     ffmpeg -hwaccel vappi -vappi_device /dev/dri/renderD128 -i \
> > > >     ~/sample-10s.mp4 -vf hwupload,scale_vappi=3Dformat=3Dnv12 -c:v =
\
> > > >     h264_vappi /tmp/output.mp4
> > > >
> > > > This is incorrect because the value is supposed to be in [0-100] ra=
nge.
> > > >
> > > > The cause of the issue is that the metrics.VcnActivity reported by
> > > > smu_cmn_get_metrics_table() is a permyriad value instead of a perce=
ntage
> > > > value (e.g. smu_v14_0_0_get_smu_metrics_data() has a division by 10=
0 to
> > > > report the vcn_busy_percent). Therefore fix this by applying the sa=
me
> > > > division in smu_v14_0_0_get_gpu_metrics().
> >
> > I think this is correct as is.  smu_v14_0_0_get_smu_metrics_data() is
> > used to fetch data for standardized formats like hwmon while
> > smu_v14_0_0_get_gpu_metrics() is for dumping the raw metrics data.
> >
>=20
> Well, then kgd_pp_interface.h needs some help?
>=20
> struct gpu_metrics_v3_0 {
> =09...
> =09/* Utilization */
> =09/* time filtered GFX busy % [0-100] */
> =09uint16_t=09=09=09average_gfx_activity;
> =09/* time filtered VCN busy % [0-100] */
> =09uint16_t=09=09=09average_vcn_activity;
> =09...
> }
>=20
> Clearly it's not true.
>=20
> [Cc amdgpu_top]
>=20
> Regards,
> Boqun
>=20
> > Alex
> >
> > > >
> > > > Reported-by: Mark Janes <mjanes@netflix.com>
> > > > Signed-off-by: Boqun Feng <boqun@kernel.org>
> > >
> > > Ping?
> > >
> > > Regards,
> > > Boqun
> > >
> > > > ---
> > > >  drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c b=
/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> > > > index 568665265a13..1058338344b0 100644
> > > > --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> > > > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> > > > @@ -566,7 +566,8 @@ static ssize_t smu_v14_0_0_get_gpu_metrics(stru=
ct smu_context *smu,
> > > >       gpu_metrics->temperature_skin =3D metrics.SkinTemp;
> > > >
> > > >       gpu_metrics->average_gfx_activity =3D metrics.GfxActivity;
> > > > -     gpu_metrics->average_vcn_activity =3D metrics.VcnActivity;
> > > > +     /* metrics.VcnActivity is permyriad, convert it to percentage=
. */
> > > > +     gpu_metrics->average_vcn_activity =3D metrics.VcnActivity / 1=
00;
> > > >       memcpy(&gpu_metrics->average_ipu_activity[0],
> > > >               &metrics.IpuBusy[0],
> > > >               sizeof(uint16_t) * 8);
> > > > --
> > > > 2.50.1 (Apple Git-155)
> > > >
> 
