Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECA29F3ED4B
	for <dri-devel@archiver.kernel.org>; Sat, 11 Apr 2026 12:29:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BEA410E1D9;
	Sat, 11 Apr 2026 12:29:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kxQTGpAD";
	dkim-atps=neutral
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com
 [74.125.224.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C2F410E9DE
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 22:06:47 +0000 (UTC)
Received: by mail-yx1-f41.google.com with SMTP id
 956f58d0204a3-6507a7d2eccso2653603d50.0
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 15:06:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775858806; cv=none;
 d=google.com; s=arc-20240605;
 b=lYnpAaHIU6teyoCvwBFjJ1c/d9IIWzPG4SI75aya10WCMHSoAi7FN0sVcbbe/Okv/Y
 U4Iyo5uAD5GISuxix1yrC1Tm1RvJUYqHSPfdgvKw7T2t50/zGrCO2z8QskS1FX4lFl28
 RpdjoAxv62pUhsGvahkxzZGdWbSMRGhU1dcqHAP2osMgVevoEWgxCO8P4biqIPbhDJ0I
 hkkGpjk5DuEDl4KRgRFagKxvBxn9sAKiPXz2rjqNfKp6QfLiyhbmGWVPMpcR1sVIAhkv
 bMAYlmHp3WYX9Et1BkcpVUTCkv75XaQ8uAWSEQ//J4E+j4RSnceEA4lUKmhrRX/LQT2k
 VEKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ArZz7/S+V745dQ4Yy4Lak9c8cluwIi2/J/yrlD0XPGI=;
 fh=RSrNcht316yjWi5hHhFUwpm3BVzMCuLzkARSkDoQiJ4=;
 b=fP/2aSq0Vaypg+8NW5wuisaa70oIlJXfXJWbc1YhMU3b+/ScH9tr73zeG1cDT3S3gn
 xS2kzdTMMNhNnzVd7niPbu1y3bT9SkVF3iFU0jzMRzjo42F44Ihh/c2fpYgqdhzfX2ye
 uEsBth2+89TfJ4gpMw7C9oKOpcRKFFAiXAGCx9Pw5hCjYGycgYHXjj+0V26pwXgRsu5a
 blMkAuXSmnadspsIdB9taXpsoloOfOj2IN5zxVBnXKmmhnvhmSnvn1o1sd0ciCCqrzfJ
 N9WOtx6eCo4d9KYz/oMjjhH7o11WCu+kKay/GXfDyYqzfyn/n0bQ7w36fAc2EKlQoHoZ
 LH0g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775858806; x=1776463606; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ArZz7/S+V745dQ4Yy4Lak9c8cluwIi2/J/yrlD0XPGI=;
 b=kxQTGpADqXvYkfe4Zb6p0spf8SIIX0iqYkAM4AOAECgG2IvEO/E0lSlvvEvuHReaDf
 0ogLfIbjkXPV895SF6+e3IeyEI1sk1AaAHsO+KTTO3r4HLoLyqtKCGRV+y+cUFGxPZMU
 4kK6fadpyG1cpPNuOVRVhQdFsjRtquAnaeNFMsUWX+HmRZGSE8aaICMGUr+9Vdz60CiL
 BaKuFGRpJo3+yNaNhM6iD498mSWOZN68JjtIVEBzCJxz4ho9j2HYaHG01h+yTd38rIPW
 tO3r1E12otn0yAfC07x9WEUPnVANi9RIIn9k9NeowgopV1SafMQ0KFhUxHbvUWqsHOKg
 93LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775858806; x=1776463606;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ArZz7/S+V745dQ4Yy4Lak9c8cluwIi2/J/yrlD0XPGI=;
 b=A9eAXkxJYQZkpbmL1B3XqiNTK4moDWI9GGXTpkoJTLtjnpu6vgd8jIodr5H6No92Yl
 JiWeNd1BDI5VI7w69XevTlbWjh3w6njuuGOilHgoFJNIzBTFYJYFjYNv8xlDi6/yZxkQ
 wKQzyMDaPHWBbiTOmX1bIGuBSjeiBcnCT9QkVXwC4afP8vunwABcNAFfEQKbVXWIUrIp
 gRQFsCVm7UBa/lKB+itJCwzGip4fwJRsaR6R12gPQ4hX0ghQa9HRpQRDEtUeRhqu1eyp
 vKby0YjjBVuz9dlqEg6Nep12aTefC6SNXxmHRjLsVVaaDf8R9RWzYL+rLtUujLmZtcNL
 m0vQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV16gxpX5ghYfO0nwsABTaojrwOOpuffF6dQ1z1pEV2XmRL5sp0uYVQArN5ZbMGzFDcaS7eFlMXPdQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxPDVCKnxA7GH2MJ6J3+matE7Mpg9eUDXPLxDwHoC0d2hLmE6bn
 fCCLF4rUqrLtJomEpdcGIVIqT7eRFQBrpvkBTywzxs9ugmarRV+TU+SZ98skF+8w0PEXY5ncqBj
 65+towG/2qACDCOTQj0vkvSPTJaD8MvA=
X-Gm-Gg: AeBDieuRhIZNh8jctbllgGLQh+KbfEQRzhg2XMhMr4vDnqzU27c3ug33sUSo1UyKgsv
 hU4xnSNK5u62aoMaMdIHQooZD3rGuvGe8ZA2N76W1R8XR0IVVsboBIpzIM/OsRtS9namNdKLMnx
 V3CjungzIZGB/pA72qCsaTxoFkltnhfBoKnkHHyQqKIDB72aWa1l7JJUH3k6sA79Baqim7Xs69E
 dgNLa0ukGI/gzGCTN8tCi2K7lTBxyLnArDPxwBR2qV4s0eChYO3yx6TlQ6+PgwR8GDnWEwP8J5d
 DbhMLDDrsfpHcAMd8D6Nb6y7rAV11XMN01h8bpsmmA==
X-Received: by 2002:a53:bb8c:0:b0:650:3431:24c7 with SMTP id
 956f58d0204a3-65198b4280emr2993330d50.34.1775858806402; Fri, 10 Apr 2026
 15:06:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260409164156.2235189-1-ashutoshdesai993@gmail.com>
 <a4f659636fbf9558252197ec3b89ee0dab8290c7@intel.com>
In-Reply-To: <a4f659636fbf9558252197ec3b89ee0dab8290c7@intel.com>
From: ashutosh desai <ashutoshdesai993@gmail.com>
Date: Fri, 10 Apr 2026 15:06:33 -0700
X-Gm-Features: AQROBzDNWl4g-0tZUOfww7RJ8KkrbY9Ijd37duA8uGsEd8AxUA0LXt7eyR9O-nA
Message-ID: <CAKapqN=__RuyH5=0tXfMA7egWBAE_ye2es6NMJ-gL+fq45qr4Q@mail.gmail.com>
Subject: Re: [PATCH] drm/gem: Fix inconsistent plane dimension calculation in
 drm_gem_fb_init_with_funcs()
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: multipart/alternative; boundary="00000000000053b166064f225910"
X-Mailman-Approved-At: Sat, 11 Apr 2026 12:29:27 +0000
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

--00000000000053b166064f225910
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jani,

Thank you for your question. It is a valid one. I have used AI to a small
extent to help me understand the subsystem because it was something new for
me. I haven't used AI to identify any bugs or create patches. This type of
bug is something that I am always on the lookout for (size checking and
boundary checks). So, these became evident during my review. Since AI
wasn=E2=80=99t used for code generation, I didn=E2=80=99t think attribution=
 was required,
but please let me know if you=E2=80=99d prefer otherwise.

Would be happy to walk through any of the patches if it is helpful.

Best regards,
Ashutosh

On Fri, Apr 10, 2026 at 1:26=E2=80=AFAM Jani Nikula <jani.nikula@linux.inte=
l.com>
wrote:

> On Thu, 09 Apr 2026, Ashutosh Desai <ashutoshdesai993@gmail.com> wrote:
> > drm_gem_fb_init_with_funcs() computes sub-sampled plane dimensions
> > using plain integer division:
> >
> >   unsigned int width  =3D mode_cmd->width  / (i ? info->hsub : 1);
> >   unsigned int height =3D mode_cmd->height / (i ? info->vsub : 1);
> >
> > However, the ioctl-level framebuffer_check() in drm_framebuffer.c uses
> > drm_format_info_plane_width/height() which round up dimensions via
> > DIV_ROUND_UP(). This inconsistency corrupts the subsequent GEM object
> > size check for certain pixel format and dimension combinations.
> >
> > For example, with NV12 (vsub=3D2) and a 1-pixel-tall framebuffer the
> > GEM size validation path sees height=3D0 instead of height=3D1. The
> > expression (height - 1) then wraps to UINT_MAX as an unsigned int,
> > causing min_size to overflow and wrap back to a small value. A tiny
> > GEM object therefore passes the size guard, yet when the GPU accesses
> > the chroma plane it will read or write memory beyond the object's
> > bounds.
> >
> > Fix by replacing the open-coded divisions with
> drm_format_info_plane_width()
> > and drm_format_info_plane_height(), which use DIV_ROUND_UP() and match
> > the calculation already used in framebuffer_check().
> >
> > Signed-off-by: Ashutosh Desai <ashutoshdesai993@gmail.com>
>
> Hello Ashutosh -
>
> Receiving a handful of highly polished patches in quick succession on
> various parts of the drm subsystem from someone who has no commits in
> the kernel and has no previous interactions on the mailing lists is
> virtually unheard of.
>
> I have to ask, did you use AI coding assistants? Please read the kernel
> documentation on AI coding assistants and attribution [1].
>
>
> BR,
> Jani.
>
>
> [1] https://docs.kernel.org/process/coding-assistants.html
>
>
> > ---
> >  drivers/gpu/drm/drm_gem_framebuffer_helper.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/drm_gem_framebuffer_helper.c
> b/drivers/gpu/drm/drm_gem_framebuffer_helper.c
> > index 9166c353f..88808e972 100644
> > --- a/drivers/gpu/drm/drm_gem_framebuffer_helper.c
> > +++ b/drivers/gpu/drm/drm_gem_framebuffer_helper.c
> > @@ -172,8 +172,8 @@ int drm_gem_fb_init_with_funcs(struct drm_device
> *dev,
> >       }
> >
> >       for (i =3D 0; i < info->num_planes; i++) {
> > -             unsigned int width =3D mode_cmd->width / (i ? info->hsub =
:
> 1);
> > -             unsigned int height =3D mode_cmd->height / (i ? info->vsu=
b :
> 1);
> > +             unsigned int width =3D drm_format_info_plane_width(info,
> mode_cmd->width, i);
> > +             unsigned int height =3D drm_format_info_plane_height(info=
,
> mode_cmd->height, i);
> >               unsigned int min_size;
> >
> >               objs[i] =3D drm_gem_object_lookup(file,
> mode_cmd->handles[i]);
>
> --
> Jani Nikula, Intel
>

--00000000000053b166064f225910
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Jani,<br><br>Thank you for your questi=
on. It is a valid one. I have used AI to a small extent to help me understa=
nd the subsystem because it was something new for me. I haven&#39;t used AI=
 to identify any bugs or create patches. This type of bug is something that=
 I am always on the lookout for (size checking and boundary checks). So, th=
ese became evident during my review.=C2=A0Since AI wasn=E2=80=99t used for =
code generation, I didn=E2=80=99t think attribution was required, but pleas=
e let me know if you=E2=80=99d prefer otherwise.<br><br>Would be happy to w=
alk through any of the patches if it is helpful.<br><br>Best regards,<br>As=
hutosh</div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=
=3D"ltr" class=3D"gmail_attr">On Fri, Apr 10, 2026 at 1:26=E2=80=AFAM Jani =
Nikula &lt;<a href=3D"mailto:jani.nikula@linux.intel.com">jani.nikula@linux=
.intel.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">On Thu, 09 Apr 2026, Ashutosh Desai &lt;<a href=3D"mailto:ashuto=
shdesai993@gmail.com" target=3D"_blank">ashutoshdesai993@gmail.com</a>&gt; =
wrote:<br>
&gt; drm_gem_fb_init_with_funcs() computes sub-sampled plane dimensions<br>
&gt; using plain integer division:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0unsigned int width=C2=A0 =3D mode_cmd-&gt;width=C2=A0 / (i=
 ? info-&gt;hsub : 1);<br>
&gt;=C2=A0 =C2=A0unsigned int height =3D mode_cmd-&gt;height / (i ? info-&g=
t;vsub : 1);<br>
&gt;<br>
&gt; However, the ioctl-level framebuffer_check() in drm_framebuffer.c uses=
<br>
&gt; drm_format_info_plane_width/height() which round up dimensions via<br>
&gt; DIV_ROUND_UP(). This inconsistency corrupts the subsequent GEM object<=
br>
&gt; size check for certain pixel format and dimension combinations.<br>
&gt;<br>
&gt; For example, with NV12 (vsub=3D2) and a 1-pixel-tall framebuffer the<b=
r>
&gt; GEM size validation path sees height=3D0 instead of height=3D1. The<br=
>
&gt; expression (height - 1) then wraps to UINT_MAX as an unsigned int,<br>
&gt; causing min_size to overflow and wrap back to a small value. A tiny<br=
>
&gt; GEM object therefore passes the size guard, yet when the GPU accesses<=
br>
&gt; the chroma plane it will read or write memory beyond the object&#39;s<=
br>
&gt; bounds.<br>
&gt;<br>
&gt; Fix by replacing the open-coded divisions with drm_format_info_plane_w=
idth()<br>
&gt; and drm_format_info_plane_height(), which use DIV_ROUND_UP() and match=
<br>
&gt; the calculation already used in framebuffer_check().<br>
&gt;<br>
&gt; Signed-off-by: Ashutosh Desai &lt;<a href=3D"mailto:ashutoshdesai993@g=
mail.com" target=3D"_blank">ashutoshdesai993@gmail.com</a>&gt;<br>
<br>
Hello Ashutosh -<br>
<br>
Receiving a handful of highly polished patches in quick succession on<br>
various parts of the drm subsystem from someone who has no commits in<br>
the kernel and has no previous interactions on the mailing lists is<br>
virtually unheard of.<br>
<br>
I have to ask, did you use AI coding assistants? Please read the kernel<br>
documentation on AI coding assistants and attribution [1].<br>
<br>
<br>
BR,<br>
Jani.<br>
<br>
<br>
[1] <a href=3D"https://docs.kernel.org/process/coding-assistants.html" rel=
=3D"noreferrer" target=3D"_blank">https://docs.kernel.org/process/coding-as=
sistants.html</a><br>
<br>
<br>
&gt; ---<br>
&gt;=C2=A0 drivers/gpu/drm/drm_gem_framebuffer_helper.c | 4 ++--<br>
&gt;=C2=A0 1 file changed, 2 insertions(+), 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/drm_gem_framebuffer_helper.c b/drivers/gp=
u/drm/drm_gem_framebuffer_helper.c<br>
&gt; index 9166c353f..88808e972 100644<br>
&gt; --- a/drivers/gpu/drm/drm_gem_framebuffer_helper.c<br>
&gt; +++ b/drivers/gpu/drm/drm_gem_framebuffer_helper.c<br>
&gt; @@ -172,8 +172,8 @@ int drm_gem_fb_init_with_funcs(struct drm_device *=
dev,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; info-&gt;num_planes; i+=
+) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int width =
=3D mode_cmd-&gt;width / (i ? info-&gt;hsub : 1);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int height =
=3D mode_cmd-&gt;height / (i ? info-&gt;vsub : 1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int width =
=3D drm_format_info_plane_width(info, mode_cmd-&gt;width, i);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int height =
=3D drm_format_info_plane_height(info, mode_cmd-&gt;height, i);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int min=
_size;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0objs[i] =3D drm_=
gem_object_lookup(file, mode_cmd-&gt;handles[i]);<br>
<br>
-- <br>
Jani Nikula, Intel<br>
</blockquote></div></div>

--00000000000053b166064f225910--
