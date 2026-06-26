Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4682C43327
	for <dri-devel@archiver.kernel.org>; Sun, 28 Jun 2026 11:43:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC81D10E5E8;
	Sun, 28 Jun 2026 11:43:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="tLRIJyJq";
	dkim-atps=neutral
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com
 [209.85.222.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0B4210E387
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 12:14:25 +0000 (UTC)
Received: by mail-ua1-f49.google.com with SMTP id
 a1e0cc1a2514c-966c8dcceedso366341241.2
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 05:14:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782476064; cv=none;
 d=google.com; s=arc-20260327;
 b=ZsxWbIijiwdOev8dttkAwLsBHNqzXSv4+MqODvIMYarix993FzX7YSP9wxIFCxol3U
 33FGTp2IuicGa+voHRW8rl8iytY82AEHBAxvJBCONt3+7JUyf9rjTEPeDlsqh61FziB2
 ZOcJw8R+lV/t+6s7xyRtL0WaFWMvxBmbCUzRId/dNwWu2u1LeUW3P9l71PJ752WSGIGN
 Enw2V5ixQHA6pPxOmbe/UwYMOzao7HicJB8wnepOx+T/w/70G41oZGeyL5Tk8b1DrWF6
 ocQa7gQZC6U3NxkWDT3UU3KaVc49aHghHdC2AI4tZe4P7XCSqtlMEQO/oDRCTaPghj13
 iPUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=osdSAQ+mms85Dqm0GLNP4GMom5P8y3+fofwcrD76FIA=;
 fh=bN3WHTlzXcVIr2RkgMpk3NXK/DwXOefqRaFpMbeYf7s=;
 b=ma66tl8EJTuQimltKzSjrQOuxzXaIzE4/1DQa3PUpKzfK1vzDoTIOuVeXbyye+MufW
 jrrjKA1YglLTrhANoqZnttO5qsFY0U89g/A1RWvjmXewrG0sMWjjVIMvV8rpVmAWZXEk
 WvBhbM2gLWrDwxzM1xc4PEL1p3ADeXMDU32oX9B6TxSfq/KnRAsrE1HwS7hvfxDz77wi
 wB4eJcnHc4fpMwCBeyDPWSz5e/f014C23Q9puo9+FAc+IxLPJh8AyiWSLvcD4VQynz2a
 w/2ZdLj36CwirfMahw68PX2UUWhxvWcYK1rFIiPD77fAaarF1xCkhUW7Dou1D1vvbr/H
 gl0Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782476064; x=1783080864; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=osdSAQ+mms85Dqm0GLNP4GMom5P8y3+fofwcrD76FIA=;
 b=tLRIJyJqaf8lenFckWb3YFsBFhoPWUMI8agWH4/af3xiH776T/7MBmPpBpHEpOL69M
 WhwOhWb/v+fM2Yoj5K5ERtH3eackUfVWosa4PAaBT6tVwugMOVm+lQ0e1DUQE9h0wHdS
 RzkOVVq7R6keXeAen81fdSII2S4xPxOtEUOep83cnqykpYNcM2N9cDs+1V1X4rDb604c
 hz3hn+oxP3PUTuZnFS+8+MKE+SRll6XsbJf2f2+C/KtRkcsD4pzyIpy9EhEjdhIkkTya
 FUlrcXG5hy88kxQzdKUrZW9SmjQSDT32Miwaox4FYBHQS4LS69wmXdYiCCw+yfTRXG7i
 juQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782476064; x=1783080864;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=osdSAQ+mms85Dqm0GLNP4GMom5P8y3+fofwcrD76FIA=;
 b=pVBLk+h0qtLbS4+W1Hpf09MqbMCB/dOwB0NfsnYhtI5kefRc+/EkXAf8PAqHlgRI6s
 lzcLqiiU2ZOtzFpFFcrXoquqpnENTVT7vzNo81oYBdRXTAOaNYyfyoo3/McZtmotJ+AY
 Wsan8VMpp8U55sYEB186T3GeoHI0FH1wLYQwacVY0MKkg257MTVAtMS6Uh3iJYaZqi70
 C4ls/3Bww7NWh5Y8nZzjopW81fJkYzCRqDae1VuqJkOjcM4JbMuuHBjQX4i6/Hxg4jE1
 Ng45dzOADJDDTdg5OvqhJSn5lq3Hacu+NpN6zPSNqlFk8StwmTnNBNHXdQw8EQ72mFQj
 DIEA==
X-Gm-Message-State: AOJu0Yy+WoYTIawtlfDOyFB/UQ/9rkwfj7ZaTQeHXA1RFGMOmRVPfIbk
 ENAwHbB/yvttT1s1AnkDcPjS4dQOqhY1T69/zP+c/iBxhEIquDYloxjcDmIubLi/pKae1l3jlEn
 mb7uX2F8pFIjdoDkxlR6BUdHuBzG88ME=
X-Gm-Gg: AfdE7cnDuvIHdt1zO93UYGV7GxwMFJ1AR8Vu2kjnNXTdfukEz1CR88bB2zTy0yh22zf
 kmc3+Uydr+W31witjGhvbULl+aex/N17jrUyXPRzCSjCmVTC3fwWh4FhYuRYKDLjjNq5+YGlPOz
 o2v7B7ZqzUEOWraHSMc0tmDZdUVuzpNFEgofF5aAk57v76fuy9gYgr7kFoqfpcUYtt29ph2CLb/
 u4KrV6f+v2ahgvI7AUGVySaG89ccSaf0a4jjlJQathmluXiL45uofJzIDa8mrRKCrLM5XMV3zhf
 SF3LRYPg1KMnOyXeof0JN/TbGigYOnGga/88N5vn7B7YlshcQTnOVK7BC9FvkUZq0g8+ETQeDq1
 xaQ+KpnkkBJvJrPI=
X-Received: by 2002:a05:6102:2c0c:b0:631:37cb:1e64 with SMTP id
 ada2fe7eead31-73433e3a95cmr3670354137.4.1782476064424; Fri, 26 Jun 2026
 05:14:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260626112638.2042298-1-achillezongo07@gmail.com>
 <20260626114043.8F9D21F00A3E@smtp.kernel.org>
In-Reply-To: <20260626114043.8F9D21F00A3E@smtp.kernel.org>
From: achille zongo <achillezongo07@gmail.com>
Date: Fri, 26 Jun 2026 12:14:13 +0000
X-Gm-Features: AVVi8Cf1JuXaaddv6RWGBKgIFK_44IEg46UO5vzRKUuMOgYHHRqW2mj52MjNUsE
Message-ID: <CAA07Ah1uOyrMfC0SMsApO68ZScWBZbXqZ4O8SN+fjoo3aJ-T=A@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/xe: count UMA shrinkable BOs as reclaimable
 without swap
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
Content-Type: multipart/alternative; boundary="000000000000a4065a0655270cc6"
X-Mailman-Approved-At: Sun, 28 Jun 2026 11:42:36 +0000
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

--000000000000a4065a0655270cc6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Subject: Re: [PATCH 1/2] drm/xe: count UMA shrinkable BOs as reclaimable
without swap
I'm withdrawing this patch , approach is wrong
Signed-off-by: aquiles <achillezongo07@gmail.com>


On Fri, Jun 26, 2026 at 11:40=E2=80=AFAM <sashiko-bot@kernel.org> wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider:
> - [High] xe_shrinker_count() reports shrinkable UMA BOs regardless of
> __GFP_FS, but xe_shrinker_scan() bails out without scanning them when
> __GFP_FS is missing.
> - [High] Bypassing ttm_backup_bytes_avail() for UMA shrinkable BOs falsel=
y
> assumes they can be freed without swap space, causing useless CPU overhea=
d
> yielding zero net memory reclamation.
> --
>
> commit eb93ae097c20ae5f357e41557ba0c3d785cb142c
> Author: aquiles <achillezongo07@gmail.com>
>
> drm/xe: count UMA shrinkable BOs as reclaimable without swap
>
> This commit modifies the xe shrinker count logic to unconditionally repor=
t
> UMA shrinkable buffer objects as reclaimable, even without swap space. It
> subtracts UMA shrinkable pages from the ttm backup limit check and adds
> them back unconditionally.
>
> > diff --git a/drivers/gpu/drm/xe/xe_shrinker.c
> b/drivers/gpu/drm/xe/xe_shrinker.c
> > index 83374cd576608..3ca2de342dcd6 100644
> > --- a/drivers/gpu/drm/xe/xe_shrinker.c
> > +++ b/drivers/gpu/drm/xe/xe_shrinker.c
> [ ... ]
> > @@ -140,16 +140,22 @@ xe_shrinker_count(struct shrinker *shrink, struct
> shrink_control *sc)
> >  {
> >       struct xe_shrinker *shrinker =3D to_xe_shrinker(shrink);
> >       unsigned long num_pages;
> > +     long uma_reclaimable_pages;
> >       bool can_backup =3D !!(sc->gfp_mask & __GFP_FS);
> > +     bool is_uma =3D !IS_DGFX(shrinker->xe);
> >
> >       num_pages =3D ttm_backup_bytes_avail() >> PAGE_SHIFT;
> >       read_lock(&shrinker->lock);
> >
> > +     uma_reclaimable_pages =3D is_uma ? shrinker->shrinkable_pages : 0=
;
> > +
> >       if (can_backup)
> > -             num_pages =3D min_t(unsigned long, num_pages,
> shrinker->shrinkable_pages);
> > +             num_pages =3D min_t(unsigned long, num_pages,
> > +                               shrinker->shrinkable_pages -
> uma_reclaimable_pages);
>
> [Severity: High]
> Does bypassing the ttm_backup_bytes_avail() limit for UMA shrinkable BOs
> result in zero net memory reclamation without swap?
>
> On UMA systems without swap, the shrinker uses ttm_bo_shrink() which
> backs up the BO by copying its pages to a shmem file. Because no swap spa=
ce
> is available, the newly allocated shmem backup pages cannot be swapped to
> disk and remain permanently pinned in physical memory.
>
> This deceives the core MM into trying to reclaim these pages, burning CPU
> cycles on copying memory that yields zero net free physical memory.
>
> >       else
> >               num_pages =3D 0;
> >
> > +     num_pages +=3D uma_reclaimable_pages;
>
> [Severity: High]
> Can unconditionally returning uma_reclaimable_pages cause an infinite
> reclaim retry loop when __GFP_FS is missing?
>
> When the shrinker is invoked with __GFP_FS missing (e.g., direct reclaim =
in
> the filesystem or block layer), can_backup is false, but this code adds
> uma_reclaimable_pages to the returned count anyway.
>
> Looking at xe_shrinker_scan() in the same file, the scan loop explicitly
> bails out if !can_backup before it ever attempts to scan non-purgeable
> (shrinkable) pages:
>
>         if (nr_scanned >=3D nr_to_scan || !can_backup)
>                 goto out;
>
>         /* ... */
>         shrink_flags.purge =3D false;
>
> The shrinker API strictly requires the count to accurately reflect only t=
he
> objects that the scan function will attempt to free under the given
> gfp_mask.
> Returning a falsely high count for objects that the scan function
> explicitly
> skips breaks the VM reclaim feedback loop, causing infinite reclaim loops=
.
>
> >       num_pages +=3D shrinker->purgeable_pages;
> >       read_unlock(&shrinker->lock);
> >
>
> --
> Sashiko AI review =C2=B7
> https://sashiko.dev/#/patchset/20260626112638.2042298-1-achillezongo07@gm=
ail.com?part=3D1
>

--000000000000a4065a0655270cc6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Subject: Re: [PATCH 1/2] drm/xe: count UMA shrinkable BOs =
as reclaimable without swap<br>I&#39;m withdrawing this patch , approach is=
 wrong<br>Signed-off-by: aquiles &lt;<a href=3D"mailto:achillezongo07@gmail=
.com">achillezongo07@gmail.com</a>&gt;<br><br></div><br><div class=3D"gmail=
_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri,=
 Jun 26, 2026 at 11:40=E2=80=AFAM &lt;<a href=3D"mailto:sashiko-bot@kernel.=
org">sashiko-bot@kernel.org</a>&gt; wrote:<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">Thank you for your contribution! Sashiko AI revi=
ew found 2 potential issue(s) to consider:<br>
- [High] xe_shrinker_count() reports shrinkable UMA BOs regardless of __GFP=
_FS, but xe_shrinker_scan() bails out without scanning them when __GFP_FS i=
s missing.<br>
- [High] Bypassing ttm_backup_bytes_avail() for UMA shrinkable BOs falsely =
assumes they can be freed without swap space, causing useless CPU overhead =
yielding zero net memory reclamation.<br>
--<br>
<br>
commit eb93ae097c20ae5f357e41557ba0c3d785cb142c<br>
Author: aquiles &lt;<a href=3D"mailto:achillezongo07@gmail.com" target=3D"_=
blank">achillezongo07@gmail.com</a>&gt;<br>
<br>
drm/xe: count UMA shrinkable BOs as reclaimable without swap<br>
<br>
This commit modifies the xe shrinker count logic to unconditionally report<=
br>
UMA shrinkable buffer objects as reclaimable, even without swap space. It<b=
r>
subtracts UMA shrinkable pages from the ttm backup limit check and adds<br>
them back unconditionally.<br>
<br>
&gt; diff --git a/drivers/gpu/drm/xe/xe_shrinker.c b/drivers/gpu/drm/xe/xe_=
shrinker.c<br>
&gt; index 83374cd576608..3ca2de342dcd6 100644<br>
&gt; --- a/drivers/gpu/drm/xe/xe_shrinker.c<br>
&gt; +++ b/drivers/gpu/drm/xe/xe_shrinker.c<br>
[ ... ]<br>
&gt; @@ -140,16 +140,22 @@ xe_shrinker_count(struct shrinker *shrink, struc=
t shrink_control *sc)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct xe_shrinker *shrinker =3D to_xe_shrin=
ker(shrink);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long num_pages;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0long uma_reclaimable_pages;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bool can_backup =3D !!(sc-&gt;gfp_mask &amp;=
 __GFP_FS);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0bool is_uma =3D !IS_DGFX(shrinker-&gt;xe);<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0num_pages =3D ttm_backup_bytes_avail() &gt;&=
gt; PAGE_SHIFT;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0read_lock(&amp;shrinker-&gt;lock);<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 =C2=A0uma_reclaimable_pages =3D is_uma ? shrinker-&gt;s=
hrinkable_pages : 0;<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (can_backup)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0num_pages =3D min_t(u=
nsigned long, num_pages, shrinker-&gt;shrinkable_pages);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0num_pages =3D min_t(u=
nsigned long, num_pages,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0shrinker-&gt;shrinkable_pages - u=
ma_reclaimable_pages);<br>
<br>
[Severity: High]<br>
Does bypassing the ttm_backup_bytes_avail() limit for UMA shrinkable BOs<br=
>
result in zero net memory reclamation without swap?<br>
<br>
On UMA systems without swap, the shrinker uses ttm_bo_shrink() which<br>
backs up the BO by copying its pages to a shmem file. Because no swap space=
<br>
is available, the newly allocated shmem backup pages cannot be swapped to<b=
r>
disk and remain permanently pinned in physical memory.<br>
<br>
This deceives the core MM into trying to reclaim these pages, burning CPU<b=
r>
cycles on copying memory that yields zero net free physical memory.<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0num_pages =3D 0;=
<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 =C2=A0num_pages +=3D uma_reclaimable_pages;<br>
<br>
[Severity: High]<br>
Can unconditionally returning uma_reclaimable_pages cause an infinite<br>
reclaim retry loop when __GFP_FS is missing?<br>
<br>
When the shrinker is invoked with __GFP_FS missing (e.g., direct reclaim in=
<br>
the filesystem or block layer), can_backup is false, but this code adds<br>
uma_reclaimable_pages to the returned count anyway.<br>
<br>
Looking at xe_shrinker_scan() in the same file, the scan loop explicitly<br=
>
bails out if !can_backup before it ever attempts to scan non-purgeable<br>
(shrinkable) pages:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (nr_scanned &gt;=3D nr_to_scan || !can_backu=
p)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* ... */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 shrink_flags.purge =3D false;<br>
<br>
The shrinker API strictly requires the count to accurately reflect only the=
<br>
objects that the scan function will attempt to free under the given gfp_mas=
k.<br>
Returning a falsely high count for objects that the scan function explicitl=
y<br>
skips breaks the VM reclaim feedback loop, causing infinite reclaim loops.<=
br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0num_pages +=3D shrinker-&gt;purgeable_pages;=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0read_unlock(&amp;shrinker-&gt;lock);<br>
&gt;<br>
<br>
-- <br>
Sashiko AI review =C2=B7 <a href=3D"https://sashiko.dev/#/patchset/20260626=
112638.2042298-1-achillezongo07@gmail.com?part=3D1" rel=3D"noreferrer" targ=
et=3D"_blank">https://sashiko.dev/#/patchset/20260626112638.2042298-1-achil=
lezongo07@gmail.com?part=3D1</a><br>
</blockquote></div>

--000000000000a4065a0655270cc6--
