Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8ED310F3DF1
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 14:21:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0391410E770;
	Mon, 30 Mar 2026 14:21:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hqcLGkoz";
	dkim-atps=neutral
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 767EF10E769
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 14:21:50 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-43b949bf4easo2639050f8f.0
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 07:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774880509; x=1775485309; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3gI1060qWAxguxfqLo7d74lXelCuf/bPUdPr59uzbe0=;
 b=hqcLGkozQlB0S5ZKiHvp66/WcZBWeK8LFa2e1tQ5pigfAkIznS5687VOzpaAoBigfj
 jw25qaGrFunzDYjv87CJOdxIA0QiGW+4qw/FZLG1bndohIdk/EZvKPjK43trLYRiCcrV
 AtuLauuJimBeaZximH2gNwUehph1pAeIRVvgcAyIQTcvR/GxRvv8r+Pjy/6LTuDhFTqZ
 tqRgPWjITZZfFmqjhIDecIfZ+1WvlQwZd1Q/WGbYKabfDVIKbZDRUItW728gdO7Dvk0k
 KL3Tqeo6pHeDSkOWgjn1iIAL6AbaVbrlRu6zsGJYwOab1zCim9V3/yV7LQWkJECcRSEo
 JLOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774880509; x=1775485309;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3gI1060qWAxguxfqLo7d74lXelCuf/bPUdPr59uzbe0=;
 b=PzZkEQ9IasPpKvfNG4qViOFMSz3GDH2RO/CHGbZ+adddcUt4hgfakkB6gzL8DjNgk7
 k6HoidDhz/SW5yNM8kA7IF3iJ4OVwfM1Oa7SggRFyR2dH6eADGglnHs2Q6sXFheXxjtl
 Ddfx/6o5TM6rI5scn9JnMwWkfuJoQEBX4oNyVrYN5P0H8mME/ir8qSEKuxq6J3imgnGk
 CKJsU09isyCYuVTJeJF1/ZobRIJy3eKjAa0vC/b+AAbe/fxSweGuaepspqA0kSGL0Uwr
 GT5C0J/Q0Gc9AlSwm/pnAvkAb/gLfeiSDIHLbzLivvGdlH6mSKpabncGrt8j8I0yMmwO
 WtWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDS3K323yUJQPbiyfy+Bctc08jMNAayjrEPSA2Ci+QGe4pvFGs9fipO4f9v8cNMY6E/jHvZ81qhKo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw6U0U+CQHjVwI1b+hZc/vvOwVuZ3Zs+XVcIVzw8PjIfBL1p2Lk
 XJi3mNfyeV+xL3d5byIrAcDq43rnX0ZbJv13ymq/U/+t9TCYnoYEX7yH
X-Gm-Gg: ATEYQzx8rH4fY8bSiYbdvtMgh43BVLYD8oalP/kPnGH19OkD6wQg36PqZ3xgM7s+8yt
 ACB8ujVrbuV/+p6CayVjc/D9hhHDr0R9zLsvgD+JHZsaokdIEcKkkMXB8pva9EJ3+W3lnUJtRvV
 Kb2o9t/rhWFtwBeL+BIcckcg8T+6i5ATAXhy+5uNLqf50kqdqFQU3OVTn3CWf1JNgOiMtTcKN+h
 2wJuy1p8Qxx1ZrJn3KhHPX1RTrsJhOnc0UVjQ3+sPksjZu1H0bNhApClaAZfa7QlvJlrma1r6Xd
 VAftGSbUdwdonOF0OEh0zMxzfYX90MXr2zhuysjca6H7253LYFgKB1vOu59r7UWslvdlWxD7Tk7
 9ICt7duguZIS4iEZKwsRPYQfgF0KLwjySXGDchAEGYFXLMaShKk1vPp8N6gg9XrGrOTFbCPaqz0
 Qz3fubnN0zUojDP2YI81KsUVAA9ht4nbTvKQezCYI2JJqNHkVf0Y3Fp52UWwvPFk+aSbIjtBK0
X-Received: by 2002:a05:6000:22c9:b0:43c:f1da:487d with SMTP id
 ffacd0b85a97d-43cf1da48c5mr16375164f8f.2.1774880508452; 
 Mon, 30 Mar 2026 07:21:48 -0700 (PDT)
Received: from timur-hyperion.localnet (5E1BC26F.dsl.pool.telekom.hu.
 [94.27.194.111]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43cf245ebafsm18062796f8f.21.2026.03.30.07.21.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 07:21:48 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: stable@vger.kernel.org, Rosen Penev <rosenp@gmail.com>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Bin Lan <bin.lan.cn@windriver.com>, He Zhe <zhe.he@windriver.com>,
 Vitaly Prosyak <vitaly.prosyak@amd.com>, Alex Hung <alex.hung@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Mario Limonciello <Mario.Limonciello@amd.com>, Ray Wu <ray.wu@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Roman Li <Roman.Li@amd.com>,
 Eric Yang <Eric.Yang2@amd.com>, Tony Cheng <Tony.Cheng@amd.com>,
 Mauro Rossi <issor.oruam@gmail.com>,
 "open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>,
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
 open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH for 6.12 3/9] drm/amd/display: Disable fastboot on DCE 6
 too
Date: Mon, 30 Mar 2026 16:21:46 +0200
Message-ID: <7351746.9J7NaK4W3v@timur-hyperion>
In-Reply-To: <6b15401c-1fdf-4d3b-84aa-dfc47f430895@amd.com>
References: <20260326234716.16723-1-rosenp@gmail.com>
 <2312151.9o76ZdvQCi@timur-hyperion>
 <6b15401c-1fdf-4d3b-84aa-dfc47f430895@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

On Monday, March 30, 2026 3:55:55=E2=80=AFPM Central European Summer Time C=
hristian=20
K=C3=B6nig wrote:
> On 3/30/26 15:16, Timur Krist=C3=B3f wrote:
> > On Friday, March 27, 2026 12:47:10=E2=80=AFAM Central European Summer T=
ime Rosen
> > Penev>=20
> > wrote:
> >> From: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> >>=20
> >> [ Upstream commit 7495962cbceb967e095233a5673ea71f3bcdee7e ]
> >>=20
> >> It already didn't work on DCE 8,
> >> so there is no reason to assume it would on DCE 6.
> >>=20
> >> Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> >> Reviewed-by: Rodrigo Siqueira <siqueira@igalia.com>
> >> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> >> Reviewed-by: Alex Hung <alex.hung@amd.com>
> >> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> >=20
> > This patch is incorrect and should not be backported.
> >=20
> > (Note that the error is already fixed upstream. For stable kernels IMO
> > it's
> > best to drop this one.)
>=20
> Is there some alternative which needs to be backported or should the old
> kernel just work out of the box because we never enabled some feature
> there?
>=20
> Apart from that the patch set looks good to me.
>=20

This patch had a typo and does the opposite of what it should, ie. it disab=
les=20
eDP fastboot on DCE10 and newer instead of disabling it on DCE8 and older.

The upstream fix is here:
https://lists.freedesktop.org/archives/amd-gfx/2026-February/138577.html
which disables eDP fastboot on DCE10 and older.

>=20
> >> ---
> >>=20
> >>  drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c | 6 ++----
> >>  1 file changed, 2 insertions(+), 4 deletions(-)
> >>=20
> >> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
> >> b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c index
> >> df69e0cebf78..7dc99c85b8ea 100644
> >> --- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
> >> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
> >> @@ -1910,10 +1910,8 @@ void dce110_enable_accelerated_mode(struct dc *=
dc,
> >> struct dc_state *context)
> >>=20
> >>  	get_edp_streams(context, edp_streams, &edp_stream_num);
> >>=20
> >> -	// Check fastboot support, disable on DCE8 because of blank
> >=20
> > screens
> >=20
> >> -	if (edp_num && edp_stream_num && dc->ctx->dce_version !=3D
> >=20
> > DCE_VERSION_8_0
> >=20
> >> && -		    dc->ctx->dce_version !=3D DCE_VERSION_8_1 &&
> >> -		    dc->ctx->dce_version !=3D DCE_VERSION_8_3) {
> >> +	/* Check fastboot support, disable on DCE 6-8 because of blank
> >=20
> > screens */
> >=20
> >> +	if (edp_num && edp_stream_num && dc->ctx->dce_version <
> >=20
> > DCE_VERSION_10_0)
> >=20
> >> { for (i =3D 0; i < edp_num; i++) {
> >>=20
> >>  			edp_link =3D edp_links[i];
> >>  			if (edp_link !=3D edp_streams[0]->link)




