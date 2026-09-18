Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47D3DC982DA
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 13:54:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37BC710E8E8;
	Fri, 18 Sep 2026 13:54:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hdbCrjfY";
	dkim-atps=neutral
Received: from mail-qv2-f37.google.com (mail-qv2-f37.google.com
 [74.125.230.165])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D313E10F3A3
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 13:54:37 +0000 (UTC)
Received: by mail-qv2-f37.google.com with SMTP id
 6a1803df08f44-91235f46716so7441496d6.1
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 06:54:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789739677; cv=none;
 d=google.com; s=arc-20260327;
 b=lE8Y5c2Q/LfWUaMX9kVxfqQODBV4YMWbBCBlamZ4NknXiMWHbPs7v6pcs811rO2uK3
 LKk3+4enIpUAOPJe2XaONpoajj1PTsB0XksSzsdit74TJan6drfwY3HwZykkrNhNfzYT
 V6prhTUds/3zGULygiewzdNg2UWTT1+D6lZuMhyrAO7i7detAJQdtxrCLKZOBuAgd4zq
 uTc52n7b8N3Mo0/WxRUxFrS+LgOT2rUdjw3UGIXyiDUhwHKrzrdkCyPTHHIMUosER7iV
 GmWhj+pmXfBuVwK2A8CWbSesJw0HKL9L7co6/DJzBTP+4k2DEgY2zZYpq0zxoaBjFKHI
 0i2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=S9k8FKG4j03MJBTpWsc8b7htP2TIjKMqy+TI/78aQ4Q=;
 fh=9pDISyaFNXyxi4YeDfx2VvuNaGRKAZC69yVx5tznIFc=;
 b=nUi5wDS7FfJpPJ/8bsdQYS/udHtVVMEPF1b+RoqREhpAG2ns8Gc8koaKabOrQxfSLq
 IIC54px2e5q3w3wk5/oYisXCtva3DPKXJv2y4e6qSaXwOuoymap1vO0tPtXq9Jmjqv9c
 lrkrjZE0DHmcXZj3IQOfa3VbfkxrXVT1jnvKauwiHIh9Vidpwe+tbXHv24bWIfLlUAyn
 H32GZYMDmWh6+AXGTHGn2mVl5L73qd+yh3tWzHket0jDHREAgmrPCALYNc6Yo/BNilGh
 BFuoiECm5wunal8cEG8t1ZK0ElX3e3rZK6p1D+WkUzI94IYe1EWrt8TQ/egkii7KUKzW
 OLvw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789739677; x=1790344477; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=S9k8FKG4j03MJBTpWsc8b7htP2TIjKMqy+TI/78aQ4Q=;
 b=hdbCrjfYTdGpfpc1itz74V9eMhKLiMyM5uZKplzf/StheHVHRyTIYhCwFS31tsXq4w
 zUqRQe6cqRUdel4hJaUShC7iw+zOn12Fnoly6No+Aa2vL5vA89rCDp76/B27QXg80DOc
 MNm/R7Pc9x3kJUYZWH9TrUkgoamj6xESNmA7ryD+LzassW15Y+BZnDx3siwkIaff72U4
 hBII2/k624vg/IGxtdXkwJub+DYZuVzkSOohcBRIYT6ew86Uoim4X9U6DnX+NmXtbVqd
 rt2Uq/ylskjcgi2TMOsCq7zgOjbELNLlr+Fc89GTZvdB1vqX0GQpKs12SzRq57FUzT3k
 QtJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789739677; x=1790344477;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=S9k8FKG4j03MJBTpWsc8b7htP2TIjKMqy+TI/78aQ4Q=;
 b=wHjgwVsGdh6jJNCMEYU0PiiLFjDsYJoC83giVoJ/6wczEEg3Ez0OW6Q7LM6qjIXi4W
 KQKmo097zN+Nt4TrLjBMbMlt0IPUyLQEDQDhAHzdi2uyUOfprYkkDHkcqE0kMFBth+BX
 ZIBpR2Ie4IBbhb5xiXcfQ5J50ji3n0s2OcXANTeIoxouiv3GgzG5nCbiFR1oTeE1fm5Y
 vZeN80YkD4/TM0AIM7OsHzVnZMpTFOJTcEWGro45w21nKBSlbgC4MeYeZtk4i555C4+C
 kf1bX9WqZ/u5iozABES2U0tbcLU6Mi/jtUgss6+v3BjkpUaMP4p/MQSogBmwJUbxWPyY
 oIMg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwQgYQGCPijl8SR+g0ZLFmlAhXpZorKoLYI9XPknNfQ88FTr9eL9SUsgILkv8oSGPfMtRZL1R4ZSRo=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mZ/+fDTYlF8+D+wCFVh8z/w8oAFuuhR/2nRuRda9uDCXovhJTd
 G+r4/za0KRNqirimoZXvAQ2qoF7es2tOhjGiPFu8NhIfrZHO4SpC1xvj7/IymnLLwjq2qflAabp
 OB8zwq1VFvpAoq2qIL5nokstCfEHIxO0=
X-Gm-Gg: AYBFou1N9wvyb+cNewx19BZOCX7HMIz8owGUnAwXO06e5upDRZa4ZnNDFFVfxqzesNR
 /9XwTsxP6/flm3W5XF2PyHJSmzpupTSrRmnC8IZr1+Jdv13kkdGhMACYTBwqhVUdsQgut/g+4UK
 DiZ+5RTnRIV28vHVh54AgkSCNv3j1IPJA8re7GHls6vfAy1BSH/7bkehtQM2HkutUW37/eWzD7O
 8YEp3awXIcjHriWXIZN2+Acc7rpmJuwTAyKgMty0An3RhAoBo8WNbkdr+6h6yf86t0W9h6cF1CF
 bjvo+kG4n971nTdWYIG7p9sCH1bw1o0kgPCCTRA3W1uUp/p4nB7g4anNSWFsjalaI9wS/lVN3ph
 ftgBpH1Q27UFjVcJNpA==
X-Received: by 2002:ad4:5c69:0:b0:912:517b:918 with SMTP id
 6a1803df08f44-91254cf9991mr42645216d6.55.1789739676490; Fri, 18 Sep 2026
 06:54:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260905142500.17666-1-zhoulol888@gmail.com>
 <20260915064200.23171-1-zhoulol888@gmail.com>
 <69d0f3f3566521e516e439e818a619766561567c@intel.com>
 <CAEnyS7FrjPdkErjnNO5bOkEvrRdGfWYNB-GnhjpB2iKYFMJx5g@mail.gmail.com>
In-Reply-To: <CAEnyS7FrjPdkErjnNO5bOkEvrRdGfWYNB-GnhjpB2iKYFMJx5g@mail.gmail.com>
From: Activate Windows <zhoulol888@gmail.com>
Date: Fri, 18 Sep 2026 21:54:24 +0800
X-Gm-Features: AcwNN1WIs6CkWfPv2-lF5nz3B4wj_E4yv2c-VP8ml3oZP8t0e1qvS-gWSEP-GOc
Message-ID: <CAEnyS7GUNiOCReMzVrOqutxbpaOPX+AxJ5AueTvQbgODyVweWA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/xe/display: Remove invalid initial plane PTE check
 for iGPU
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Matthew Brost <matthew.brost@intel.com>, 
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, ville.syrjala@linux.intel.com, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Content-Type: multipart/alternative; boundary="000000000000a85d1e065bc23d7f"
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

--000000000000a85d1e065bc23d7f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Please drop this. Removing the check changes nothing, so the PTE check
isn't the cause. Sorry for the noise.

On Tue, Sep 15, 2026 at 9:59=E2=80=AFPM Activate Windows <zhoulol888@gmail.=
com>
wrote:

> Thank you.
> Follow-up: reading 0d5d5d0c2c72, the check assumes GRAPHICS_VERx100(xe)
> >=3D 1270 stands in for "MTL+ with LMEMBAR". On the PTL I hit this on, th=
e
> initial plane is rejected.
>
> I'm working out whether the BIOS PTE actually lacks XE_GGTT_PTE_DM there
> -- I'll follow up with a proper v2. I don't have the machine in front of =
me
> for a few days.
>
> On Tue, Sep 15, 2026 at 4:40=E2=80=AFPM Jani Nikula <jani.nikula@linux.in=
tel.com>
> wrote:
>
>> On Tue, 15 Sep 2026, Andrew Zhou <zhoulol888@gmail.com> wrote:
>> > Pantherlake integrated graphics can have the XE_GGTT_PTEDM bit set in
>> > the BIOS-initialised framebuffer PTE. The validation rejects this and
>> > fails to create the initial framebuffer, resulting in static.
>> >
>> > Remove the too-strict validation. Since this was the only caller of
>> > need_pte_local() outside the DGFX path, the helper is now
>> > unconditionally true there; fold the check and drop the dead
>> > need_pte_local() and has_lmembar() helpers.
>> >
>> > Signed-off-by: Andrew Zhou <zhoulol888@gmail.com>
>> > Tested-by: Andrew Zhou <zhoulol888@gmail.com>
>> > Tested-on: Intel Core Ultra X7 358H, integrated graphics, B0 stepping
>>
>> This is basically a revert of 0d5d5d0c2c72 ("drm/xe: Check the PTE local
>> memory bit for initial FB in stolen"). You'd do well to dig a bit of git
>> blame and see what changed, why, and by whom.
>>
>> Cc: Ville, Maarten, Matthew
>>
>>
>> BR,
>> Jani.
>>
>> > ---
>> > v1 -> v2:
>> > - Drop need_pte_local() and has_lmembar(), now dead after removing the
>> >   iGPU validation (sashiko)
>> > ---
>> >  drivers/gpu/drm/xe/display/xe_initial_plane.c | 20 +-----------------=
-
>> >  1 file changed, 1 insertion(+), 19 deletions(-)
>> >
>> > diff --git a/drivers/gpu/drm/xe/display/xe_initial_plane.c
>> b/drivers/gpu/drm/xe/display/xe_initial_plane.c
>> > index 0f86b7303..3484b3033 100644
>> > --- a/drivers/gpu/drm/xe/display/xe_initial_plane.c
>> > +++ b/drivers/gpu/drm/xe/display/xe_initial_plane.c
>> > @@ -27,16 +27,6 @@ static bool is_pte_local(u64 pte)
>> >       return pte & XE_GGTT_PTE_DM;
>> >  }
>> >
>> > -static bool has_lmembar(struct xe_device *xe)
>> > -{
>> > -     return GRAPHICS_VERx100(xe) >=3D 1270;
>> > -}
>> > -
>> > -static bool need_pte_local(struct xe_device *xe)
>> > -{
>> > -     return IS_DGFX(xe) || has_lmembar(xe);
>> > -}
>> > -
>> >  static struct xe_bo *
>> >  initial_plane_bo(struct xe_device *xe,
>> >                struct intel_initial_plane_config *plane_config)
>> > @@ -60,7 +50,7 @@ initial_plane_bo(struct xe_device *xe,
>> >       if (IS_DGFX(xe)) {
>> >               u64 pte =3D xe_ggtt_read_pte(tile0->mem.ggtt, base);
>> >
>> > -             if (is_pte_local(pte) !=3D need_pte_local(xe)) {
>> > +             if (!is_pte_local(pte)) {
>> >                       drm_err(&xe->drm, "Initial plane PTE has bad
>> local memory bit\n");
>> >                       return NULL;
>> >               }
>> > @@ -85,7 +75,6 @@ initial_plane_bo(struct xe_device *xe,
>> >                           &phys_base);
>> >       } else {
>> >               struct ttm_resource_manager *stolen;
>> > -             u64 pte;
>> >
>> >               stolen =3D ttm_manager_type(&xe->ttm, XE_PL_STOLEN);
>> >               if (!stolen) {
>> > @@ -93,13 +82,6 @@ initial_plane_bo(struct xe_device *xe,
>> >                       return NULL;
>> >               }
>> >
>> > -             pte =3D xe_ggtt_read_pte(tile0->mem.ggtt, base);
>> > -
>> > -             if (is_pte_local(pte) !=3D need_pte_local(xe)) {
>> > -                     drm_err(&xe->drm, "Initial plane PTE has bad
>> local memory bit\n");
>> > -                     return NULL;
>> > -             }
>> > -
>> >               phys_base =3D base;
>> >               flags |=3D XE_BO_FLAG_STOLEN;
>>
>> --
>> Jani Nikula, Intel
>>
>

--000000000000a85d1e065bc23d7f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Please drop this. Removing the check changes nothing, so t=
he PTE check isn&#39;t the cause. Sorry for the noise.</div><br><div class=
=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr=
">On Tue, Sep 15, 2026 at 9:59=E2=80=AFPM Activate Windows &lt;<a href=3D"m=
ailto:zhoulol888@gmail.com">zhoulol888@gmail.com</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div dir=
=3D"ltr">Thank you.<br><span>Follow-up: reading 0d5d5d0c2c72, the check ass=
umes </span><code>GRAPHICS_VERx100(xe) &gt;=3D 1270</code><span> stands in =
for &quot;MTL+ with LMEMBAR&quot;. On the PTL I hit this on, the initial pl=
ane is rejected.=C2=A0<br><br>I&#39;m working out whether the BIOS PTE actu=
ally lacks XE_GGTT_PTE_DM there -- I&#39;ll follow up with a proper v2. I d=
on&#39;t have the machine in front of me for a few days.</span></div><br><d=
iv class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep =
15, 2026 at 4:40=E2=80=AFPM Jani Nikula &lt;<a href=3D"mailto:jani.nikula@l=
inux.intel.com" target=3D"_blank">jani.nikula@linux.intel.com</a>&gt; wrote=
:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Tue, 15 Sep=
 2026, Andrew Zhou &lt;<a href=3D"mailto:zhoulol888@gmail.com" target=3D"_b=
lank">zhoulol888@gmail.com</a>&gt; wrote:<br>
&gt; Pantherlake integrated graphics can have the XE_GGTT_PTEDM bit set in<=
br>
&gt; the BIOS-initialised framebuffer PTE. The validation rejects this and<=
br>
&gt; fails to create the initial framebuffer, resulting in static.<br>
&gt;<br>
&gt; Remove the too-strict validation. Since this was the only caller of<br=
>
&gt; need_pte_local() outside the DGFX path, the helper is now<br>
&gt; unconditionally true there; fold the check and drop the dead<br>
&gt; need_pte_local() and has_lmembar() helpers.<br>
&gt;<br>
&gt; Signed-off-by: Andrew Zhou &lt;<a href=3D"mailto:zhoulol888@gmail.com"=
 target=3D"_blank">zhoulol888@gmail.com</a>&gt;<br>
&gt; Tested-by: Andrew Zhou &lt;<a href=3D"mailto:zhoulol888@gmail.com" tar=
get=3D"_blank">zhoulol888@gmail.com</a>&gt;<br>
&gt; Tested-on: Intel Core Ultra X7 358H, integrated graphics, B0 stepping<=
br>
<br>
This is basically a revert of 0d5d5d0c2c72 (&quot;drm/xe: Check the PTE loc=
al<br>
memory bit for initial FB in stolen&quot;). You&#39;d do well to dig a bit =
of git<br>
blame and see what changed, why, and by whom.<br>
<br>
Cc: Ville, Maarten, Matthew<br>
<br>
<br>
BR,<br>
Jani.<br>
<br>
&gt; ---<br>
&gt; v1 -&gt; v2:<br>
&gt; - Drop need_pte_local() and has_lmembar(), now dead after removing the=
<br>
&gt;=C2=A0 =C2=A0iGPU validation (sashiko)<br>
&gt; ---<br>
&gt;=C2=A0 drivers/gpu/drm/xe/display/xe_initial_plane.c | 20 +------------=
------<br>
&gt;=C2=A0 1 file changed, 1 insertion(+), 19 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/xe/display/xe_initial_plane.c b/drivers/g=
pu/drm/xe/display/xe_initial_plane.c<br>
&gt; index 0f86b7303..3484b3033 100644<br>
&gt; --- a/drivers/gpu/drm/xe/display/xe_initial_plane.c<br>
&gt; +++ b/drivers/gpu/drm/xe/display/xe_initial_plane.c<br>
&gt; @@ -27,16 +27,6 @@ static bool is_pte_local(u64 pte)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return pte &amp; XE_GGTT_PTE_DM;<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; -static bool has_lmembar(struct xe_device *xe)<br>
&gt; -{<br>
&gt; -=C2=A0 =C2=A0 =C2=A0return GRAPHICS_VERx100(xe) &gt;=3D 1270;<br>
&gt; -}<br>
&gt; -<br>
&gt; -static bool need_pte_local(struct xe_device *xe)<br>
&gt; -{<br>
&gt; -=C2=A0 =C2=A0 =C2=A0return IS_DGFX(xe) || has_lmembar(xe);<br>
&gt; -}<br>
&gt; -<br>
&gt;=C2=A0 static struct xe_bo *<br>
&gt;=C2=A0 initial_plane_bo(struct xe_device *xe,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct intel_in=
itial_plane_config *plane_config)<br>
&gt; @@ -60,7 +50,7 @@ initial_plane_bo(struct xe_device *xe,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (IS_DGFX(xe)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u64 pte =3D xe_g=
gtt_read_pte(tile0-&gt;mem.ggtt, base);<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (is_pte_local(pte)=
 !=3D need_pte_local(xe)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!is_pte_local(pte=
)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0drm_err(&amp;xe-&gt;drm, &quot;Initial plane PTE has bad local=
 memory bit\n&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0return NULL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; @@ -85,7 +75,6 @@ initial_plane_bo(struct xe_device *xe,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;phys_base);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct ttm_resou=
rce_manager *stolen;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u64 pte;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0stolen =3D ttm_m=
anager_type(&amp;xe-&gt;ttm, XE_PL_STOLEN);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!stolen) {<b=
r>
&gt; @@ -93,13 +82,6 @@ initial_plane_bo(struct xe_device *xe,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0return NULL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pte =3D xe_ggtt_read_=
pte(tile0-&gt;mem.ggtt, base);<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (is_pte_local(pte)=
 !=3D need_pte_local(xe)) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0drm_err(&amp;xe-&gt;drm, &quot;Initial plane PTE has bad local memor=
y bit\n&quot;);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return NULL;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; -<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0phys_base =3D ba=
se;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0flags |=3D XE_BO=
_FLAG_STOLEN;<br>
<br>
-- <br>
Jani Nikula, Intel<br>
</blockquote></div></div>
</blockquote></div>

--000000000000a85d1e065bc23d7f--
