Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 739841061B20
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 21:38:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2C7710E69D;
	Mon, 30 Mar 2026 21:38:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OidhBKRx";
	dkim-atps=neutral
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com
 [209.85.167.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A668510E69D
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 21:38:49 +0000 (UTC)
Received: by mail-lf1-f50.google.com with SMTP id
 2adb3069b0e04-59e4a04f059so5076857e87.2
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 14:38:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774906728; cv=none;
 d=google.com; s=arc-20240605;
 b=DnbrgDA3tHmydECw92UdwHSuRs+IsV62cuix88cCIatTU0Vkd8J1w8r5CLeNWwqN92
 RjFPfpZ+BjGbC/sK0HjvSAqJo7dp5G+1FYugZ1QbRIIUNyQeiZow2yq+FEY5EOq7gSMh
 C3tYW5PGjZFDrYFARhZ17U+elZRkFPDSp29IR7j5Fiz9hE/NdApiH1QhMpupLsBH7Auc
 E760wFPJU0E0PcK8PaggOfab6yPr9NkQTxxYRMBAOBnJJADZOW7Vez4c9uqAqhW7Wm0s
 zhGF7U8FRV19/LstwuOI7ju3FAz6Cop6BPzTbrfuvUbIPO8UX50wfGcPWO6UKYh4M6he
 KNTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=RyXWT6CZTRjvrBzjlgkYqR6hvQZ/LcLxcXjlYxt3yys=;
 fh=ppvvcv5lYQpPrR4yHAjAU5oBwUh32z8bGgD2/GRyqsY=;
 b=HQUjWr91lQEwGiuDWyT2oz09yD2RTmwcZUfle0tixMO4ZLQ3zwzPEGRLnecmvxSnn2
 Vve7HJ81O6TUfy8fO73U2ZRZuNvUzYwJsU8NILjK2e7Y0b8wJ7MqnVqqV2li9P3J2nXH
 BYYZfqlyJtBN+wNNAIS6apYMUeqPxuiXUtajfxt78qz0wBU4M6lDKl2cd7WWuDhv/RUo
 USCy8IuiLT5U4XohFZXPFChyz8tqM/atzo53oTcNym7k99z+0OBFzNHNl7LxdCAnMLQ0
 LIekhNQrBiZ5WQPpdOuR+/zjshxqegClWq8Nj144F0OezeUnC0cs9SsZqxFy1FlvVazc
 R88w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774906728; x=1775511528; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RyXWT6CZTRjvrBzjlgkYqR6hvQZ/LcLxcXjlYxt3yys=;
 b=OidhBKRxAd3DSjgPGVt59s5wOrzVk/A1dRr/CC2v8RvK5pp1zmJheskeMFcFwhi04P
 MPBFH0cUGGC+Tw6BKFUaXccZ63lgFXDismdiZQ04VlCrT+HdMN3cMrl0XIjV2Xs4y7N2
 nPx5Lt4hyKTg2pEKIL6NJXtOzsSfx+xXpKnTzNTKemW2yYozrKD8/ORTLPbhZEPsnTgY
 bsF8AGEWg4QcsIb/a8OqEnB/yRHDR2EefyKZYcZoZrAJlaELFYvVHOaNgM7bt0Plw3vG
 oBj25HAs2DZa/5qj1HN7eMJRUrVgEEocBh8nOcoGnTvzzdxl3JSuaf38QhYv5PiSh2fH
 JaMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774906728; x=1775511528;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RyXWT6CZTRjvrBzjlgkYqR6hvQZ/LcLxcXjlYxt3yys=;
 b=ZNTO258MYJ+5XzAgIOOWs2n3uF7D0iR1y7/zOMPnYZheqspg9DZ9r6yB7uyb/0/q42
 fTHJRXPeSk9gqBuOR7plhYrp0iNfoJGjjgXn6oiX9YAjlEWqbyEVbMo16Vqe+CkaU17E
 sCiVkoOwtpooeHiTGlgyS+TJhLH+0p1FKAPvrLonka2Q6qgbtbP7GIzwllq1AGFS+LwM
 WoRR8ZTqLtmQxneeAw1/doSKtKTTImb0HAGk8H5WWEnXyGLpOAUrLVDeK2bNeAjg+DT8
 2EfpXLZB8qdbzriCtN00QGYwnvJupMWSs0fk2fTNvWBA83Qotg87sdIT1IVv9Ax2bOgl
 08ig==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/GwwgWeJpIawjkNI00dtyOwLTTRc+UR+V7mwq9CSeC+BF1VaoaWHvxy5ZOfPiH6009SbaSN0CNYI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxmX3TV98UlC0n1crkE3MUmgSoDblcH0leq7yPWMXoI/NMMr4a2
 3Neo544UaBit3+SUrtje4HT47WKoeLWsGnG6DXcJnmwl1h/0bmxtSNedUBS16VW8sy4Xy3L7n+H
 4iXH2jHjpbKWSqfsIoo/laOaARK2IbSw=
X-Gm-Gg: ATEYQzy4Fy9Bt3h5Ug8ifXH70xjmq7Tlp8zZXboCoFyyTLAHX2DiHVuFGd9vBJ76HAm
 KDWisxwukdLNXDqggiMz7xJcBzlOcU8UODOux69bq7uirOSHWuxhuRflp75eRKxDLQI/z7gHq50
 fxLEFhKriQRPSDO88GQjKX1DLlVCAbXcI9iZ5GHepMJdfdMMgEv3js4t6eLG7kmacPweZUzbWLC
 7iw0FRAWph8IcgEJIK5NiL5AFw82UGngZMsPFAcMHujZr938TyzjzRuVTGuxu7/bJTb682IAayX
 QC+dbjogZyxJC+yBX4r0vqJ2M1EZvenzwtJhEtuSS1VJ1seby4J7lLh+4NREf4Pdb42XyFD+L3g
 IkfIUqQ==
X-Received: by 2002:a05:6512:1084:b0:5a1:4473:bb44 with SMTP id
 2adb3069b0e04-5a2ab92d9e4mr5216280e87.33.1774906727539; Mon, 30 Mar 2026
 14:38:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260326234716.16723-1-rosenp@gmail.com>
 <2312151.9o76ZdvQCi@timur-hyperion>
 <6b15401c-1fdf-4d3b-84aa-dfc47f430895@amd.com>
 <7351746.9J7NaK4W3v@timur-hyperion>
In-Reply-To: <7351746.9J7NaK4W3v@timur-hyperion>
From: Rosen Penev <rosenp@gmail.com>
Date: Mon, 30 Mar 2026 14:38:35 -0700
X-Gm-Features: AQROBzClHbQKYMQEBk1N37wHNV8JfR61-qIixPaDukv245DWUjEWx7ElX5PJJLU
Message-ID: <CAKxU2N-CRua=kMVm8gdf2AnbCFyLsLTbf=-9NZHAkhL3sJC-tw@mail.gmail.com>
Subject: Re: [PATCH for 6.12 3/9] drm/amd/display: Disable fastboot on DCE 6
 too
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: stable@vger.kernel.org,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>, 
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, 
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bin Lan <bin.lan.cn@windriver.com>, 
 He Zhe <zhe.he@windriver.com>, Vitaly Prosyak <vitaly.prosyak@amd.com>, 
 Alex Hung <alex.hung@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>, 
 Mario Limonciello <Mario.Limonciello@amd.com>, Ray Wu <ray.wu@amd.com>, 
 Wayne Lin <wayne.lin@amd.com>, Roman Li <Roman.Li@amd.com>,
 Eric Yang <Eric.Yang2@amd.com>, 
 Tony Cheng <Tony.Cheng@amd.com>, Mauro Rossi <issor.oruam@gmail.com>, 
 "open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>, 
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
 open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Mar 30, 2026 at 7:21=E2=80=AFAM Timur Krist=C3=B3f <timur.kristof@g=
mail.com> wrote:
>
> On Monday, March 30, 2026 3:55:55=E2=80=AFPM Central European Summer Time=
 Christian
> K=C3=B6nig wrote:
> > On 3/30/26 15:16, Timur Krist=C3=B3f wrote:
> > > On Friday, March 27, 2026 12:47:10=E2=80=AFAM Central European Summer=
 Time Rosen
> > > Penev>
> > > wrote:
> > >> From: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > >>
> > >> [ Upstream commit 7495962cbceb967e095233a5673ea71f3bcdee7e ]
> > >>
> > >> It already didn't work on DCE 8,
> > >> so there is no reason to assume it would on DCE 6.
> > >>
> > >> Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > >> Reviewed-by: Rodrigo Siqueira <siqueira@igalia.com>
> > >> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> > >> Reviewed-by: Alex Hung <alex.hung@amd.com>
> > >> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > >> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > >
> > > This patch is incorrect and should not be backported.
> > >
> > > (Note that the error is already fixed upstream. For stable kernels IM=
O
> > > it's
> > > best to drop this one.)
> >
> > Is there some alternative which needs to be backported or should the ol=
d
> > kernel just work out of the box because we never enabled some feature
> > there?
> >
> > Apart from that the patch set looks good to me.
> >
>
> This patch had a typo and does the opposite of what it should, ie. it dis=
ables
> eDP fastboot on DCE10 and newer instead of disabling it on DCE8 and older=
.
>
> The upstream fix is here:
> https://lists.freedesktop.org/archives/amd-gfx/2026-February/138577.html
> which disables eDP fastboot on DCE10 and older.
Not sure what the process is here. I make sure everything can be git
cherry-pick ed. In that case, both should be present.
>
> >
> > >> ---
> > >>
> > >>  drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c | 6 ++---=
-
> > >>  1 file changed, 2 insertions(+), 4 deletions(-)
> > >>
> > >> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq=
.c
> > >> b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c index
> > >> df69e0cebf78..7dc99c85b8ea 100644
> > >> --- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
> > >> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
> > >> @@ -1910,10 +1910,8 @@ void dce110_enable_accelerated_mode(struct dc=
 *dc,
> > >> struct dc_state *context)
> > >>
> > >>    get_edp_streams(context, edp_streams, &edp_stream_num);
> > >>
> > >> -  // Check fastboot support, disable on DCE8 because of blank
> > >
> > > screens
> > >
> > >> -  if (edp_num && edp_stream_num && dc->ctx->dce_version !=3D
> > >
> > > DCE_VERSION_8_0
> > >
> > >> && -                   dc->ctx->dce_version !=3D DCE_VERSION_8_1 &&
> > >> -              dc->ctx->dce_version !=3D DCE_VERSION_8_3) {
> > >> +  /* Check fastboot support, disable on DCE 6-8 because of blank
> > >
> > > screens */
> > >
> > >> +  if (edp_num && edp_stream_num && dc->ctx->dce_version <
> > >
> > > DCE_VERSION_10_0)
> > >
> > >> { for (i =3D 0; i < edp_num; i++) {
> > >>
> > >>                    edp_link =3D edp_links[i];
> > >>                    if (edp_link !=3D edp_streams[0]->link)
>
>
>
>
