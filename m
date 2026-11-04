Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C53606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 09:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UySFYRGM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D22B112C46;
	Fri,  6 Nov 2026 09:18:53 +0000 (UTC)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com
 [209.85.217.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAFE810E00D
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 20:46:46 +0000 (UTC)
Received: by mail-vs1-f45.google.com with SMTP id
 ada2fe7eead31-7cc53938a8fso653187137.2
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 12:46:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793825205; cv=none;
 d=google.com; s=arc-20260327;
 b=iCrjphwsbL2zuxKNHkk9nlJZG+jatMyYgWgkZPbIDkidhmSXewM2wXlgSxYJPPQc9/
 KCguJPt75pYCiBplm8CsUdSiaL+/KI3jZUm2S5MX84r+cAg6jrJIZpPJ1U+uAR5Pco00
 OXYHgMBXN194uKgpYIWxQO++MWBMY3SWVAAv20+JL26/IJlBFEQnz0hfgYizZxGqvqdQ
 qJTvMU3rd8QOxmiXEKQEuQytdOdegL7B538tQFUsSdcz4bddy/odb6XLPzva0or0k/Ta
 d89rE2c4PIX3+raN5tuOwmmSa2uKNboL80ACN/L86IZbhlHlQC/KCw2WrXBzzCu4jiHS
 SJzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=m8gHadm5PdcNoMwQ76NDCV1To5YmgckLuBuIsDxrpPQ=;
 fh=on46GUn1pOeAGIMNz1yAHb9HOnDj3Q6wcBJXj9aDGXY=;
 b=k+yFlezfAGv5BCarDjZvhlQjdEL8RguksH3Xea5FxLQRp4l7qEs1iq0QAq98xjOq/L
 mq8WPm0Nq4FGS0HD91OzLinqkx8Bu2T58WH9f/7llzWTu4bZCIuRfWbssTArbNkPMD6e
 dPGr0xSs4obHcwZLoMJWIuBOgkRKhYBHGA4WpUybPHroAv39BvSiA1poZcucmu0qqQQW
 CRe66lDGXAgT9sQ/QRg2iXwWlACmOEHx6RbzqA8GNpUFHWUs7/MwSLeO4F+KftOyAZhZ
 Lp0i0Z+NdgmvJAbS4L/mEXCWx76xdKa40a9z62oqUCIA0IV5eWdDUP8jzRumwZLUKUXa
 UjGg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793825205; x=1794430005; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=m8gHadm5PdcNoMwQ76NDCV1To5YmgckLuBuIsDxrpPQ=;
 b=UySFYRGMrhheX3nRTcgfQ8KuU3inVHF2ppnHs4ivZsY2S2ZO/lSqVu9OZkEVWoWlsh
 twiZfNHMf5CYGK4DAS2tW//BgJuvIYrc6v2DdLu5GfdyWyFPEVMl+y5+QmrGYG4+tn9L
 +lWTFayF8nZMuzzYqicZOVvVgIFkW3J2LFI8jBGmSBWq64LD/g4lBJ0PCKvBeLubOoAt
 TC2xtRX+DIVBtJJQ5rLFsehePiInGXqpOLk6dmPPUf7jL6cMSZipRitNvlgMJCgeGupO
 AYJs1tbhpr/A9FVjDMwdI4xlDE6z8leQKFnplE8wiIdI9UvS/G7on1db2eNTUWc1X7Hu
 Ik/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793825205; x=1794430005;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=m8gHadm5PdcNoMwQ76NDCV1To5YmgckLuBuIsDxrpPQ=;
 b=ZKZCkQaJFKbhqnFosoNKIW4lvFRhrdY67nCSuf2Q3BLQ5Xe5xD8vTtg0DwXhS1nEQZ
 ygBhQlOAOTh6uAXuZAWiOFtJfr+mzucv6sngalonoFBMXuPnim4cTOfutFUov5Vk7x3T
 Ma+vJ5KtOLGUKVfRbipRX/qlqJovfHqDIFqrpZchCFKAm7879EOGMOXtYnNCpIZsjm+E
 uffWRGYRBM7QOliNR7byl/LBvPf8q6u5lnzKW0D9kK91UdDevXjNlhN2kiCiz5ih2WgV
 Sj0a+KATHcfapY45AUUSFxioAJUbMv4Z0M8CtwsWO/aUMPXobM/ybGFINkjYIbbZXxwx
 KlAQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBylmDkiqOoiSL4KQgxDVd1Lop/dBwRgWzE0YgT8n7Mnr5+rmZXPqf5apRmTP4/21TKNKxcGefw7+YI=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+k9ZWWCP/waeaRAjirdVa2x3RF5fSk60AxRGseBYRsmngty94X
 TYJcu7EfPjXGQk7Od0TexTmRtWYb6OHi+ZViuQ9KdgOXJTKxk0vXWC3mmSJmS4n+XFIothu/ws9
 uSp3V/mJ92uwmDbxFwAbcw71ogQmKDD8=
X-Gm-Gg: AYBFou3scofmeK2oMjP0BGxWY4OaNcJeZfdfkwm1PZfKEUVKrQeSQmw8L1oe9oIf5jC
 jE/cfrTZ2+lcJPx9sqVEc73J6HsslSHVy+WobfZfArzBtmk8uCpoQnYCyKAigil9HpW53uhACfd
 uwtzmpc1T0jDTZIQaXCEU0m1p+jBftbwk7iB+vKFb5CZnMKdz4XGhzVTF258iRONVjZh7D/kRUU
 g8gHXVN743EG0UqetJiw4/rdP3B3hmzsdAkgb2Qb1a/hH3esmkbFVIV+CsvnFXY37opOQhWVSYP
 D5GOZRbSwpEeb9+97tk3VMCikRpapGAh4JiF4YFAIKmT9y0xQTv5V0qP1okyYEyTap+PzQ7Sahk
 ssxqoBMUFW42KnGlguC5GPWA98EZkFq/W+oI=
X-Received: by 2002:a05:6102:160b:b0:7c3:1898:e8e2 with SMTP id
 ada2fe7eead31-7d072bb37efmr7640980137.13.1793825205431; Wed, 04 Nov 2026
 12:46:45 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <CAM0DsqVFH-wt+q8yZdq67unXAzXRAq90KDDLoRY5d-X87DNxeQ@mail.gmail.com>
 <60EDF3E4-FBB7-47A8-AF91-986049AC6FFD@linux.dev>
In-Reply-To: <60EDF3E4-FBB7-47A8-AF91-986049AC6FFD@linux.dev>
From: Giulio Malitesta <atsetilam@gmail.com>
Date: Wed, 4 Nov 2026 21:46:33 +0100
X-Gm-Features: AclHuK9plpAuxULFzKqny77x8KBOp8smxzkBbxtuvgVZxWNRg4eIaZQRf0wUc-k
Message-ID: <CAM0DsqW1K=xRXWcvepuZWG84CiG2WaTSO9sBDjgwUhnBkWsn6Q@mail.gmail.com>
Subject: Re: drm/appletbdrm: kvzalloc'd request buffer can be rejected by USB
 DMA mapping
To: Aditya Garg <aditya.garg@linux.dev>
Cc: admin@kodeit.net, dri-devel@lists.freedesktop.org, tzimmermann@suse.de, 
 k@chaosmail.tech
Content-Type: multipart/alternative; boundary="00000000000028b246065f797aab"
X-Mailman-Approved-At: Fri, 06 Nov 2026 09:18:40 +0000
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
X-Spam-Status: No, score=0.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--00000000000028b246065f797aab
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Aditya,

Thanks for looking into it. On Arch, the newest kernel in the t2linux
repository is 7.2.11, which is what I'm running, so I can't test 7.3.1
without building it myself. The t2bce stack comes bundled with that kernel,
so it's the same version too. Please correct me if I'm wrong.

I can build 7.3.1 with the t2linux patches and run it for a few days. The
warning only showed up after the memory had been in use for a while, so a
short test wouldn't prove much. However, I don't think I can do it before
late December. I have work commitments, and I need to keep this computer
stable and working in the meantime.

Another option is a patch from you, for instance replacing kvzalloc() with
kzalloc() for that buffer. I can run it here and tell you if the errors
stop.

Let me know which of the two is more useful.

Giulio


Il giorno mer 4 nov 2026 alle 14:42 Aditya Garg <aditya.garg@linux.dev> ha
scritto:

> Hi
>
> I am unable to reproduce this on my Ubuntu 26.04 Linux kernel 7.3.1 with
> latest t2bce stack. Could you test with the latest kernel and t2bce stack
> pls?
>
> > On 4 Nov 2026, at 7:39=E2=80=AFAM, Giulio Malitesta <atsetilam@gmail.co=
m> wrote:
> >
> > =EF=BB=BFHello,
> >
> > I'm not a developer, so please take this as a user report. The problem
> > was found and analysed by Claude (an AI assistant) on my machine: it
> > read my kernel log and the driver source, and I'm passing on what it
> > found in case it's useful. I can't judge the code myself, and no fix
> > has been tested.
> >
> > Hardware: MacBookPro16,1 (2019, T2).
> > Kernel: 7.2.11 from t2linux (linux-t2 on Arch). It is tainted: it uses
> > the out-of-tree t2bce USB stack, and my own modified amdgpu and
> > apple-gmux modules. The trace below goes through t2bce, so I can't
> > rule out that it plays a part.
> >
> > On each of the last four boots that lasted more than a few minutes,
> > the log shows this warning once:
> >
> >  t2bce_core 0000:04:00.1: rejecting DMA map of vmalloc memory
> >  WARNING: ./include/linux/dma-mapping.h:523 at
> >    usb_hcd_map_urb_for_dma+0x524/0x580, CPU#0: listello-core/1983
> >  Call Trace:
> >   usb_hcd_submit_urb+0x321/0xad0
> >   usb_start_wait_urb+0x9f/0x230
> >   appletbdrm_send_request+0x67/0xb0 [appletbdrm]
> >   appletbdrm_primary_plane_helper_atomic_update+0x2d8/0x350 [appletbdrm=
]
> >   drm_atomic_helper_commit_planes+0x114/0x330
> >   ...
> >   drm_atomic_helper_dirtyfb+0x221/0x320
> >   drm_mode_dirtyfb_ioctl+0x1ef/0x240
> >
> > and then, repeatedly:
> >
> >  appletbdrm 7-6:2.1: [drm] *ERROR* Failed to send message (-11)
> >
> > That error appeared 5274 times during one session of about 11 days, in
> > short bursts of up to about 20 per minute. Only the first occurrence
> > produces the warning, since it is a WARN_ONCE, so it's an assumption
> > that the later errors have the same cause.
> >
> > The likely cause: commit aaaa684bab1f ("drm/appletbdrm: Use kvzalloc
> > for big allocations") allocates the request buffer with kvzalloc().
> > When memory is fragmented, this can fall back to vmalloc, and that
> > buffer then goes to usb_bulk_msg(), whose DMA mapping refuses vmalloc
> > addresses. The same concern was raised by an automated review of that
> > patch in April, and I couldn't find a reply to it:
> >
> https://lore.gitlab.freedesktop.org/drm-ai-reviews/302f22e3-5390-4c0a-aa0=
6-bfd02a3175c0@suse.de/t/
> >
> > The kvzalloc() call is still present in current mainline (7.4-rc1), in
> > appletbdrm_primary_plane_helper_begin_fb_access(). I haven't run
> > mainline on this machine.
> >
> > The impact seems small: I haven't noticed anything on the Touch Bar,
> > and the machine stays stable. Presumably a frame is lost when this
> > happens, so the bar could show stale content until its next redraw.
> >
> > That automated review suggested kzalloc() with __GFP_RETRY_MAYFAIL, or
> > usb_alloc_coherent(), as alternatives. I can't say whether either is
> > right, but I can test a patch on this machine if that helps. I may
> > need some guidance, and I'd also be using Claude for that.
> >
> > Thanks for your work on this driver,
> > Giulio Malitesta
>

--00000000000028b246065f797aab
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div><div style=3D"font-size:inherit"><p style=3D"font-size:inherit"><div s=
tyle=3D"font-size:inherit"><p style=3D"font-size:inherit">Hi Aditya,</p>
<p style=3D"font-size:inherit" dir=3D"auto">Thanks for looking into it. On =
Arch, the newest kernel in the t2linux repository is 7.2.11, which is what =
I&#39;m running, so I can&#39;t test 7.3.1 without building it myself. The =
t2bce stack comes bundled with that kernel, so it&#39;s the same version to=
o. Please correct me if I&#39;m wrong.</p>
<p style=3D"font-size:inherit">I can build 7.3.1 with the t2linux patches a=
nd run it for a few days. The warning only showed up after the memory had b=
een in use for a while, so a short test wouldn&#39;t prove much. However, I=
 don&#39;t think I can do it before late December. I have work commitments,=
 and I need to keep this computer stable and working in the meantime.</p>
<p style=3D"font-size:inherit">Another option is a patch from you, for inst=
ance replacing kvzalloc() with kzalloc() for that buffer. I can run it here=
 and tell you if the errors stop.</p>
<p style=3D"font-size:inherit">Let me know which of the two is more useful.=
</p>
<p style=3D"font-size:inherit">Giulio</p></div></p>
</div><br></div><div><br><div class=3D"gmail_quote gmail_quote_container"><=
div dir=3D"ltr" class=3D"gmail_attr">Il giorno mer 4 nov 2026 alle 14:42 Ad=
itya Garg &lt;<a href=3D"mailto:aditya.garg@linux.dev">aditya.garg@linux.de=
v</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">Hi<br>
<br>
I am unable to reproduce this on my Ubuntu 26.04 Linux kernel 7.3.1 with la=
test t2bce stack. Could you test with the latest kernel and t2bce stack pls=
?<br>
<br>
&gt; On 4 Nov 2026, at 7:39=E2=80=AFAM, Giulio Malitesta &lt;<a href=3D"mai=
lto:atsetilam@gmail.com" target=3D"_blank">atsetilam@gmail.com</a>&gt; wrot=
e:<br>
&gt; <br>
&gt; =EF=BB=BFHello,<br>
&gt; <br>
&gt; I&#39;m not a developer, so please take this as a user report. The pro=
blem<br>
&gt; was found and analysed by Claude (an AI assistant) on my machine: it<b=
r>
&gt; read my kernel log and the driver source, and I&#39;m passing on what =
it<br>
&gt; found in case it&#39;s useful. I can&#39;t judge the code myself, and =
no fix<br>
&gt; has been tested.<br>
&gt; <br>
&gt; Hardware: MacBookPro16,1 (2019, T2).<br>
&gt; Kernel: 7.2.11 from t2linux (linux-t2 on Arch). It is tainted: it uses=
<br>
&gt; the out-of-tree t2bce USB stack, and my own modified amdgpu and<br>
&gt; apple-gmux modules. The trace below goes through t2bce, so I can&#39;t=
<br>
&gt; rule out that it plays a part.<br>
&gt; <br>
&gt; On each of the last four boots that lasted more than a few minutes,<br=
>
&gt; the log shows this warning once:<br>
&gt; <br>
&gt;=C2=A0 t2bce_core 0000:04:00.1: rejecting DMA map of vmalloc memory<br>
&gt;=C2=A0 WARNING: ./include/linux/dma-mapping.h:523 at<br>
&gt;=C2=A0 =C2=A0 usb_hcd_map_urb_for_dma+0x524/0x580, CPU#0: listello-core=
/1983<br>
&gt;=C2=A0 Call Trace:<br>
&gt;=C2=A0 =C2=A0usb_hcd_submit_urb+0x321/0xad0<br>
&gt;=C2=A0 =C2=A0usb_start_wait_urb+0x9f/0x230<br>
&gt;=C2=A0 =C2=A0appletbdrm_send_request+0x67/0xb0 [appletbdrm]<br>
&gt;=C2=A0 =C2=A0appletbdrm_primary_plane_helper_atomic_update+0x2d8/0x350 =
[appletbdrm]<br>
&gt;=C2=A0 =C2=A0drm_atomic_helper_commit_planes+0x114/0x330<br>
&gt;=C2=A0 =C2=A0...<br>
&gt;=C2=A0 =C2=A0drm_atomic_helper_dirtyfb+0x221/0x320<br>
&gt;=C2=A0 =C2=A0drm_mode_dirtyfb_ioctl+0x1ef/0x240<br>
&gt; <br>
&gt; and then, repeatedly:<br>
&gt; <br>
&gt;=C2=A0 appletbdrm 7-6:2.1: [drm] *ERROR* Failed to send message (-11)<b=
r>
&gt; <br>
&gt; That error appeared 5274 times during one session of about 11 days, in=
<br>
&gt; short bursts of up to about 20 per minute. Only the first occurrence<b=
r>
&gt; produces the warning, since it is a WARN_ONCE, so it&#39;s an assumpti=
on<br>
&gt; that the later errors have the same cause.<br>
&gt; <br>
&gt; The likely cause: commit aaaa684bab1f (&quot;drm/appletbdrm: Use kvzal=
loc<br>
&gt; for big allocations&quot;) allocates the request buffer with kvzalloc(=
).<br>
&gt; When memory is fragmented, this can fall back to vmalloc, and that<br>
&gt; buffer then goes to usb_bulk_msg(), whose DMA mapping refuses vmalloc<=
br>
&gt; addresses. The same concern was raised by an automated review of that<=
br>
&gt; patch in April, and I couldn&#39;t find a reply to it:<br>
&gt; <a href=3D"https://lore.gitlab.freedesktop.org/drm-ai-reviews/302f22e3=
-5390-4c0a-aa06-bfd02a3175c0@suse.de/t/" rel=3D"noreferrer" target=3D"_blan=
k">https://lore.gitlab.freedesktop.org/drm-ai-reviews/302f22e3-5390-4c0a-aa=
06-bfd02a3175c0@suse.de/t/</a><br>
&gt; <br>
&gt; The kvzalloc() call is still present in current mainline (7.4-rc1), in=
<br>
&gt; appletbdrm_primary_plane_helper_begin_fb_access(). I haven&#39;t run<b=
r>
&gt; mainline on this machine.<br>
&gt; <br>
&gt; The impact seems small: I haven&#39;t noticed anything on the Touch Ba=
r,<br>
&gt; and the machine stays stable. Presumably a frame is lost when this<br>
&gt; happens, so the bar could show stale content until its next redraw.<br=
>
&gt; <br>
&gt; That automated review suggested kzalloc() with __GFP_RETRY_MAYFAIL, or=
<br>
&gt; usb_alloc_coherent(), as alternatives. I can&#39;t say whether either =
is<br>
&gt; right, but I can test a patch on this machine if that helps. I may<br>
&gt; need some guidance, and I&#39;d also be using Claude for that.<br>
&gt; <br>
&gt; Thanks for your work on this driver,<br>
&gt; Giulio Malitesta<br>
</blockquote></div></div>

--00000000000028b246065f797aab--
