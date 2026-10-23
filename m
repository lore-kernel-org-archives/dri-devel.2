Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1719606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 17:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lUKmB19P
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6584910E6F5;
	Fri, 23 Oct 2026 17:11:27 +0000 (UTC)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com
 [209.85.208.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3EEC10E6F5
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 17:10:31 +0000 (UTC)
Received: by mail-lj1-f172.google.com with SMTP id
 38308e7fff4ca-3a1f628b1d1so8794881fa.0
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 10:10:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792775429; cv=none;
 d=google.com; s=arc-20260327;
 b=dIMnenIaNWWL4EKy1gC9N95FP5T+FP22TVYNRKHIFkuKJu5MCR8RhIbzwoSbVjwnOP
 S3pgaWL27VOTZXicJgRoQ3V+E1h/ABX4Pssz9RufSgLKNR8PJr0A1LDC6fwY4XZDWCpq
 XTNLgJorNPixEemx/Wn4nO4K6dryxchY/8BENNYtCm1m4kdjo6lv95RDaYIKjO40uUcH
 TJVcK8MTiDSlxOM2H7FTn1cTlyN8Vo1CBEKdB524HBCGZuhf5xySY3iLFuQIsx3q3Pdz
 TxsEgs92OiuqxJEmzUIB/LJjW7MzjbmuUbsn7pnhERDKe4KZ8RaTFAZGe7Msrl65sH3z
 862w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Pj8A3rSmJmNvzPlzPefmcAJjoKNzu926Z64+RZduhAM=;
 fh=hzmuAHqOfUEop5eGGGAmiqfe4sbtFIz3S3bx6cCayaM=;
 b=k6QsTQ27yMBZsORBafm4Rc530QuVicOIctecuAfnTj17ORZkCxKRahhYtEPMCSKMm0
 DQZcrnHmj1Z+6MSqgqSGMowq/WusqVTVIHB6DcLDRHLM+dOvKWY3/or4L+ebOyQiwoeA
 5GG78n+Bu+eOtqWcH2aMqwAssY+bmpWzrPu4IPoKS7zfkA2NmvdZJL+KQvAcl069Lqpc
 Nuw8yeTOFIatakhU9ylSkd2fI3QjnlTW9Kysuc/DcMi10kW1bRXoQCdSqDvfq9bBl/OG
 H1PW/x5TWURh+oENa/dvfS2c/xsM1SY7rwsEXkWZCvAxbul4Lj3qpqhWM2Efn22dcFuw
 pO3w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792775429; x=1793380229; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Pj8A3rSmJmNvzPlzPefmcAJjoKNzu926Z64+RZduhAM=;
 b=lUKmB19Pym0t8J/d4yNyMqMHuCmiCW5JKH6vGGAhS36JXyFqbfaLiZQLqVMch4id8a
 IZvBaMWaKZp1BjI7U9Uw6f3RI+k6IkFmJ/OhF6wPiYuIBlxFc7HRDfPs/OGhsisMrCUE
 6+HmOHduRLBegf4Pv5mz3U8vvzPEIjQyNrnJWvAt0cBVKw8NuAIKI9Qvmga0ya/LShNl
 XD0Slox/jZ0wuHr7G2nRJL24aI/U7dTv1mpPVNE2iV5LH/XMJP4TATZEPZJoUaczio85
 qA7h79YtR79DclWtY1vnDvde9HqOGaB7WIn17BVfCM56SGmq66/lbhjy2/ldm71rv6Gp
 +0tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792775429; x=1793380229;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Pj8A3rSmJmNvzPlzPefmcAJjoKNzu926Z64+RZduhAM=;
 b=srsZGuBy/Rrc7t3e9oiMpPkDPLmpIY1JL1rRWwwmKkB09wFeRUOwpNlSbJoQzM4Tif
 m+OP6feZL7rjC5jOQJGKaZEYNxONIO0z9j9Piu8eOKmdeGMTLCdZCf3edHscw8qB++QU
 L4Owbb1ugdvTNQ9rgvEDRiNmoR5GeBb5ot0OzDgDaGSg59+VYhrqCzypJTY3eq+JpDaf
 RtuRmjlRmRdezYaCqMnOLR8cBtBGzPKgZ8RnEZOPfkYfLojWvrrdQUX1Wkw+69vqf7JI
 BBe2CLgLOLWyWWioyJdUmVWfTBpGh0RL2jL3Hp2RDGG+641uB3eKgrFDs3heXeePvC/h
 i9oQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBypWRMF/U7M2pIEOn9OehydrtYfOYSJz6Jtbm7J2HjCdG3DvkNDt3kh3z5cBzMI/oLWD4xQPMa8tqs=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLebvptzdV0BITonvi1G9Al+u9soY5DtRmNKI/zuJtnuclMrH78
 ZNyxIOKiDFrFj6DPW0SNwCzwnxikxOS92MZX67s+g+Aee7VIglFSA0zhUWWQgmHr9TREJHifOjf
 eOxOuw+0u0popRxulNx28MNnuzmnTP8I=
X-Gm-Gg: AYBFou2EMlArfyr5KHMMbLxDEhOiSY4R/flZxDKa+Ko5dtJ0p2E12ES83zN+eofB6fY
 DYcc4soRPfLoxob8JRyIVbTSTR6pej6+1WCOAtJ3mv7MgJ48WawqhNiJVDx9OKftHe/NSUgN9oN
 +6RXBSUkJHIIjxjj4sCV/jT01uz4yUR0EWtcQokoyTT3GfWIODQ0rLhLuEMAq1QLBrn0qxbINU8
 9Gy85zeoDdtVaECpp0gEayGciqpHMO4wvahLkQxTenSH9c97lXnLPk6TNkmbR0cfIEAVR+ivprR
 nqo5DUK847GBZTPOELaDNQc5NgR0r8DPKO/3mRJu4NnonU7tDtOMteZHOmziKQb+Et3AFjrSYaZ
 4kIQP4rnQBJ1DToRSk3nH28DX1Gi4+b3YNshcFlmp+oyU6U/0JKX9/+3AMuTadhUkrYtXwerJdQ
 /RPrimioc/3xY4YJfoYkYcjXKcouctP++3ydrqtT0wC7X4EQ==
X-Received: by 2002:a2e:bc03:0:b0:3a9:d407:41f6 with SMTP id
 38308e7fff4ca-3ac6637e917mr7554071fa.26.1792775428982; Fri, 23 Oct 2026
 10:10:28 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261020-tegra-drm-yvu420-v3-0-7f19a834ba98@gmail.com>
 <20261020-tegra-drm-yvu420-v3-2-7f19a834ba98@gmail.com>
 <T1504rPqStSSyO9jl0by8w@nvidia.com>
In-Reply-To: <T1504rPqStSSyO9jl0by8w@nvidia.com>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Fri, 23 Oct 2026 12:10:16 -0500
X-Gm-Features: AclHuK_EWEzi1LRHTLo8d432RWvCE3Or3aR7BVm1bRRWxd52gg2ACpR1Zr921BI
Message-ID: <CALHNRZ8TeQ-MdnDrtDG1b0s3phrO2gega_Kj5bCxFL75o4rTrg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] drm/tegra: Support YVU formats
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: Thierry Reding <thierry.reding@kernel.org>,
 David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Jonathan Hunter <jonathanh@nvidia.com>,
 linux-tegra@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 23, 2026 at 7:10=E2=80=AFAM Mikko Perttunen <mperttunen@nvidia.=
com> wrote:
>
> On Tuesday, October 20, 2026 5:10=E2=80=AFPM Aaron Kling via B4 Relay wro=
te:
> > From: Aaron Kling <webgeek1234@gmail.com>
> >
> > YVU420 is used by AOSP for video playback among other things. YVU422 an=
d
> > YVU444 can be trivially supported in the same manner, so add them as
> > well.
> >
> > Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> > ---
> >  drivers/gpu/drm/tegra/dc.c    |  7 +++++++
> >  drivers/gpu/drm/tegra/hub.c   |  2 ++
> >  drivers/gpu/drm/tegra/plane.c | 24 ++++++++++++++++++++++++
> >  3 files changed, 33 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
> > index 39c2e920d76a6..be913f2609077 100644
> > --- a/drivers/gpu/drm/tegra/dc.c
> > +++ b/drivers/gpu/drm/tegra/dc.c
> > @@ -1282,6 +1282,8 @@ static const u32 tegra20_overlay_formats[] =3D {
> >       DRM_FORMAT_YUYV,
> >       DRM_FORMAT_YUV420,
> >       DRM_FORMAT_YUV422,
> > +     DRM_FORMAT_YVU420,
> > +     DRM_FORMAT_YVU422,
> >  };
> >
> >  static const u32 tegra114_overlay_formats[] =3D {
> > @@ -1309,6 +1311,8 @@ static const u32 tegra114_overlay_formats[] =3D {
> >       DRM_FORMAT_YUYV,
> >       DRM_FORMAT_YUV420,
> >       DRM_FORMAT_YUV422,
> > +     DRM_FORMAT_YVU420,
> > +     DRM_FORMAT_YVU422,
> >       /* semi-planar formats */
> >       DRM_FORMAT_NV12,
> >       DRM_FORMAT_NV21,
> > @@ -1349,6 +1353,9 @@ static const u32 tegra124_overlay_formats[] =3D {
> >       DRM_FORMAT_YUV420, /* YU12 */
> >       DRM_FORMAT_YUV422, /* YU16 */
> >       DRM_FORMAT_YUV444, /* YU24 */
> > +     DRM_FORMAT_YVU420, /* YV12 */
> > +     DRM_FORMAT_YVU422, /* YV16 */
> > +     DRM_FORMAT_YVU444, /* YV24 */
> >       /* semi-planar formats */
> >       DRM_FORMAT_NV12,
> >       DRM_FORMAT_NV21,
> > diff --git a/drivers/gpu/drm/tegra/hub.c b/drivers/gpu/drm/tegra/hub.c
> > index 5a86f8260f136..ac4542e54d7dd 100644
> > --- a/drivers/gpu/drm/tegra/hub.c
> > +++ b/drivers/gpu/drm/tegra/hub.c
> > @@ -51,6 +51,8 @@ static const u32 tegra_shared_plane_formats[] =3D {
> >       DRM_FORMAT_YUYV,
> >       DRM_FORMAT_YUV420,
> >       DRM_FORMAT_YUV422,
> > +     DRM_FORMAT_YVU420,
> > +     DRM_FORMAT_YVU422,
> >  };
>
> Well, I just tested this and it looks like the nvdisplay/hub.c based
> display controllers don't support planar YUV422. So that's an existing
> bug in the driver but I think anyway we shouldn't advertise YVU422.. :)
>
> Could you respin one more time and drop YVU422 from hub.c? You can add a
> patch to drop YUV422 as well or I can follow up with one, either way is
> fine by me.

I can send a new revision, sure. Dropping yuv422 from nvdisplay seems
out of scope of the series, though. I'd think it would make more sense
to make that standalone with a fixes tag so it can move more quickly.

Aaron

> Thanks
> Mikko
>
> >
> >  static const u64 tegra_shared_plane_modifiers[] =3D {
> > diff --git a/drivers/gpu/drm/tegra/plane.c b/drivers/gpu/drm/tegra/plan=
e.c
> > index 757bc552809fe..79ef5fc1b3678 100644
> > --- a/drivers/gpu/drm/tegra/plane.c
> > +++ b/drivers/gpu/drm/tegra/plane.c
> > @@ -433,14 +433,38 @@ int tegra_plane_format(u32 fourcc, u32 *format, u=
32 *swap, bool *swap_uv)
> >               *format =3D WIN_COLOR_DEPTH_YCbCr420P;
> >               break;
> >
> > +     case DRM_FORMAT_YVU420:
> > +             if (!swap_uv)
> > +                     return -EINVAL;
> > +
> > +             *format =3D WIN_COLOR_DEPTH_YCbCr420P;
> > +             *swap_uv =3D true;
> > +             break;
> > +
> >       case DRM_FORMAT_YUV422:
> >               *format =3D WIN_COLOR_DEPTH_YCbCr422P;
> >               break;
> >
> > +     case DRM_FORMAT_YVU422:
> > +             if (!swap_uv)
> > +                     return -EINVAL;
> > +
> > +             *format =3D WIN_COLOR_DEPTH_YCbCr422P;
> > +             *swap_uv =3D true;
> > +             break;
> > +
> >       case DRM_FORMAT_YUV444:
> >               *format =3D WIN_COLOR_DEPTH_YCbCr444P;
> >               break;
> >
> > +     case DRM_FORMAT_YVU444:
> > +             if (!swap_uv)
> > +                     return -EINVAL;
> > +
> > +             *format =3D WIN_COLOR_DEPTH_YCbCr444P;
> > +             *swap_uv =3D true;
> > +             break;
> > +
> >       case DRM_FORMAT_NV12:
> >               *format =3D WIN_COLOR_DEPTH_YCbCr420SP;
> >               break;
> >
> > --
> > 2.54.0
> >
> >
> >
>
>
>
>
