Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFBA5106FD9D
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 08:25:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0665F10EB21;
	Fri, 13 Mar 2026 08:25:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=pm.me header.i=@pm.me header.b="nPcpJoWH";
	dkim-atps=neutral
Received: from mail-43100.protonmail.ch (mail-43100.protonmail.ch
 [185.70.43.100])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EF8110E363
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Mar 2026 18:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
 s=protonmail3; t=1773339549; x=1773598749;
 bh=XPi7N6rAJfXojvM7KpS5aTU2qRvg2YrP9Z2KMTkPGos=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=nPcpJoWHpUQzGQ0d6PgYXTc9dfde95ZEa67WQdQMvzQUr2Q31JxZaKRqOSXyw6mwP
 Xe3MnSuUNiiXr5NyPdtZldLyw92XvTEKlxQ4940HKn0IN4Uws6qDtQDTGjodgRWwo4
 GvD2QJpLX2Gugc3rjI8y7Dlsm0nCZFLNGxoWM6Qb6JtyNA9pHyCVf1WV7dTJ2lqBr3
 NBnFSs1kachz7dNw54akQA7Hor1EXPm/VoPwxn8Vu/k28mRnsSx1DLnwMCa8zAMoZX
 2S66xOsRxV0gHYZwRVD1N7VzqMohF62rjtzZc/H0maoOyb/YDBkCSr7zqtIcVP0qFg
 9JLLCE8BJVLDg==
Date: Thu, 12 Mar 2026 18:18:59 +0000
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
From: Alexander Koskovich <akoskovich@pm.me>
Cc: Junjie Cao <caojunjie650@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>,
 Antonino Maniscalco <antomani103@gmail.com>,
 Jonathan Marek <jonathan@marek.ca>, Eugene Lepshy <fekz115@gmail.com>,
 Jun Nie <jun.nie@linaro.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
Subject: Re: [PATCH 2/3] drm/msm/dsi: support DSC configurations with
 slice_per_pkt > 1
Message-ID: <abL8qtbnNzspJMGC@prism>
Feedback-ID: 37836894:user:proton
X-Pm-Message-ID: 09c56c36f25158d50c25def04b7467015a9e174d
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 13 Mar 2026 08:25:02 +0000
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

On Mon, Oct 13, 2025 at 05:34:06PM +0300, Dmitry Baryshkov wrote:
> On Mon, Oct 13, 2025 at 09:17:04PM +0800, Junjie Cao wrote:
> > Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> =E4=BA=8E2025=
=E5=B9=B410=E6=9C=8813=E6=97=A5=E5=91=A8=E4=B8=80 20:31=E5=86=99=E9=81=
=93=EF=BC=9A
> > > On Mon, Oct 13, 2025 at 07:04:43PM +0800, Junjie Cao wrote:
> > > > Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> =E4=BA=8E2025=
=E5=B9=B410=E6=9C=8813=E6=97=A5=E5=91=A8=E4=B8=80 17:39=E5=86=99=E9=81=
=93=EF=BC=9A
> > > > > On 13/10/2025 04:52, =E6=9B=B9=E4=BF=8A=E6=9D=B0 wrote:
> > > > > >  >Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com
> > > > > > <mailto:dmitry.baryshkov@oss.qualcomm.com>> =E4=BA=8E2025=
=E5=B9=B410=E6=9C=882=E6=97=A5=E5=91=A8=E5=9B=9B 10:04=E5=86=99=E9=81=93=
=EF=BC=9A
> > > > > >  >On Wed, Oct 01, 2025 at 09:59:13PM +0800, Junjie Cao wrote:
> > > > > >  >> From: Jun Nie <jun.nie@linaro.org <mailto:jun.nie@linaro.or=
g>>
> > > > > >  >>
> > > > > >  >> Some panels support multiple slice to be sent in a single D=
SC
> > > > > > packet. And
> > > > > >  >> this feature is a must for specific panels, such as JDI LPM=
026M648C.
> > > > > > Add a
> > > > > >  >> dsc_slice_per_pkt member into struct mipi_dsi_device and su=
pport the
> > > > > >  >> feature in msm mdss driver.
> > > > > >  >>
> > > > > >  >> Co-developed-by: Jonathan Marek <jonathan@marek.ca
> > > > > > <mailto:jonathan@marek.ca>>
> > > > > >  >> Signed-off-by: Jonathan Marek <jonathan@marek.ca
> > > > > > <mailto:jonathan@marek.ca>>
> > > > > >  >> Signed-off-by: Jun Nie <jun.nie@linaro.org <mailto:jun.nie@=
linaro.org>>
> > > > > >  >> Signed-off-by: Junjie Cao <caojunjie650@gmail.com
> > > > > > <mailto:caojunjie650@gmail.com>>
> > > > > >  >> ---
> > > > > >  >>  drivers/gpu/drm/msm/dsi/dsi_host.c | 25 ++++++++++--------=
-------
> > > > > >  >>  include/drm/drm_mipi_dsi.h         |  2 ++
> > > > > >  >>  2 files changed, 12 insertions(+), 15 deletions(-)
> > > > > >  >
> > > > > >  >Please extract the generic part, so that it can be merged thr=
ough a
> > > > > >  >generic tree.
> > > > > >  >
> > > > > >
> > > > > > Sorry, I don't get it.  The generic part, generic tree? Do you =
mean
> > > > > > the drm tree? `slice_per_pkt >=3D 2` is seen on the panels of t=
hese
> > > > > > tablets that are equipped with qcom chips. I don't know if thes=
e
> > > > > > panels are used on other platforms, and if it is necessary to d=
o it
> > > > > > in drm.
> > > > >
> > > > > There are two changes here:
> > > > > - MIPI DSI header change
> > > > > - msm DSI driver
> > > > >
> > > > > I've asked to split it to those two commits so that he change for
> > > > > drm_mipi_dsi.h is more obvious for reviewers and so that it can b=
e
> > > > > merged through a drm-misc tree (or through drm-msm tree provided =
it gets
> > > > > a necessary ack).
> > > > >
> > > >
> > > > Thanks for your clear explanation.
> > > >
> > > > I don't mind to add the field separately. But should I submit it
> > > > with the panel driver together? Otherwise, this field is unused
> > > > for a while.
> > > >
> > > > However, as you mentioned, this is not a part of standard, neither
> > > > mipi dsi nor VESA DSC. Recently, only Qualcomm devices require it
> > > > to calculate parameters, then we use them to program registers. Why
> > > > don't we parse the field from devicetree?
> > >
> > > Because the value is uniquelly identified by the panel's compat strin=
g.
> > >
> >=20
> > Yes, it is panel specified.
> > But can we set it for every panel like
> >=20
> > &mdss_dsi0 {
> >     qcom,mdss-dsc-slice-per-pkt =3D <2>;
> >=20
> >     status =3D "okay";
> >=20
> >     panel: panel@0 {
> >         compatible =3D "foo,bar";
> >         reg =3D <0>;
> >     };
> > };
> >=20
> > or moving the property to panel node? We access it from child node.
>=20
> Why do you need it in DT if the panel driver can provide this
> information.

Hello, I need this patch for the Tianma TA066VVHM03 on the ASUS ROG Phone 3=
. Is
the only change required at this point to split the generic part, and is a =
v2
in the works to address this?

>=20
> --=20
> With best wishes
> Dmitry

Thanks,
Alex

