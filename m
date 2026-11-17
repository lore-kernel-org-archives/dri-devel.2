Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCEF606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 10:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PGOigkmq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1FC410F5EC;
	Tue, 17 Nov 2026 10:08:19 +0000 (UTC)
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com
 [74.125.224.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43D8B10F5EE
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 10:08:14 +0000 (UTC)
Received: by mail-yx1-f46.google.com with SMTP id
 956f58d0204a3-67db1f6f50eso2446767d50.0
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 02:08:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794910093; cv=none;
 d=google.com; s=arc-20260327;
 b=d0lP72LKvr6H6wpy2QCS3Wwq91OdiECHq0eaVMxrlfzSMpTQ8d64pGTSFK/mdqv8al
 /1qEcvs79hs7+jZykV+olt9jRAnK8z+9SjV71JzApALNRiw+OVrD7WM/IL9Xtyssfz41
 RhdWRT7Dx06srhcLnRcfOH2drSDm4w1fdK3mXWJ1JjVkec0Qi2XKsR+QBejYBq25yYsq
 crVJl1uMIar7LLb9MmTlfwS18dUZkdSVUhqECHSRYEQJOFidyFAiG9W66L31M1xH361o
 nTXjrsK4kdsxOPRNLQynKcKpFachcNjUlE37vIgQLIviex8K1MVlMNMEgY7sTB1sjtzy
 fBbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=H1JAymO8jobfMhForiKqBUfI88TVlIjXvzYNngzMuR0=;
 fh=ltQNfU7zcupmkR3fPE4GywNCX3070E97vNOSn4CMsEY=;
 b=mGgBIY2IaWmgauVTkBF8BE4exzn8Gu5Jrni8KEip9t18emW0yOP6szQ7+VTLTgHyDy
 1GI4bCWY7NODW4Apsrl8toY4uLWiuWeo9GmCboAzZV8aTq5AFxuNA4DKkk/051T7t+rG
 eCYgpJ6O1p3ZZXf7F47rJY2iyuNxZBjKG2yIPBZ1GZ6oEVoDYoz4LRKrzZAEXVm6ulVa
 mD/ga1/jjq1SF9qlzxFWyyEcolugHYXyFuSDwAqcXOzetXt8eZT6AtPZFAXMsX/AF17b
 50TN/gnTWit08tgR64wI2HCVmjVxyDZPbTX4ZjxPhFNHlcNm/JiP5lCqvdHf47F7v1Pv
 4zUw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794910093; x=1795514893; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=H1JAymO8jobfMhForiKqBUfI88TVlIjXvzYNngzMuR0=;
 b=PGOigkmqxfjp28HZr7tnOYnYnL6wyD33vpc+iVQ5cpFpkX103M0upRZKatAB+ew2Kr
 i1NhOZAJrFgZIr8sSL4oC8RhCapylAQtrdMz2GrVjW9QXExu2UqHYGH1F5JHftBMCoz7
 wq4rwbYiUukatdSRHbNDUxM/lIEp5dfeG11DcEP1+fC7ccFXvGMqOvd9ODvf8lp0PXIM
 5noVDkUZ3X4VIIPOj2O37xn0t1UQ+1bwXtxyNokcnTRIrLZXpxKWBBcX0UXTzEr9bQSU
 DQPxktbBinGR3EO1u2iuIMMVrYODQ0/r8xrvEUxZVNqgjL+ZquiwrV3h/YLiLoRdmFco
 Bmng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794910093; x=1795514893;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=H1JAymO8jobfMhForiKqBUfI88TVlIjXvzYNngzMuR0=;
 b=Rzllx2dHuuAVkcQHI/5rabb/g+P8AfOZzlNQo8ME7+92guZ3c8aQrGOYSVhhsVEw8W
 ZyXKk+ckKa+c9azghGwjodFdbpOlFJ0ldknA5oRC34xg4YqcqphG6Lj4x2kqoBAV8cuR
 8xdywdK0BGfYe++boycQ8mC3EWxGPHoWSj0Lfid8gCWJOFL86DwW/k+J8VTQFkuE8KdG
 LFcol2DJUuDKO4CyZNFeD9zk05s4LhyrDsehfKLqZ8y3lVAP13/qO91Sxv9OeZZJau2o
 QbqAyYU3I5n52MJO2XDS+XiFM9XRD2j2fvuAgkUFsQnMYeHFV3qEPSkF+m2FEZOnt8dX
 FBQw==
X-Forwarded-Encrypted: i=1;
 AL+hErEbut8B2wWdJvzmcLS3FcPtaW18x+suSbx8irrFtZqTU6k/4d6DYPVP9TBuS2Rvv8oYZIgTHetTDAk=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/Ekds/QWZibIAyO+AJw9L+3aiD5hwsH2x8axzDft6c9JKTG2iX
 usNERbHJcZvLlcJCbUdhVIZDNZho7pN94rDuTNOXa6zj3NIMc9+90OAYGgRelgjnA9PAJPwpjiP
 kHoBkbraPJHHnSPiQRFysxKkjYBOCTpw=
X-Gm-Gg: AZFdTZejq7QlewOgBhcoqEfoP+PxyvZXwEzqz4kmed6xrTkQlaQT83b5Rp/Lv22Jw9S
 Ozds5B5cMm8psLJneJhKrjSBrFCQuvJ0qhQNzFIYk3p/gFwn7886+Uk9j28uMiyLM7F9N0Bcgw2
 ZnJGaMnEiKleaUoj6zqjg0FNZ8BFBd/cRXTqnDcRKya9IX7pTHozjsOqUKL+XELhf9S1gaMpZzO
 lLwbTPRQiOv/WI3AImT7Y5vg/RBvcF3krt0n8Gcj8KKtWQYGh9q6VzAPkmCzazxyG171MSCytF3
 ifscdzYtqJtfa2ERl46PFxvDTYYcyy1JItFKls1sb0uPBvoZFbgxFkld9HA1OwBpYyzCtkl//2j
 inuLJMCc+oCeBmyt4CLjMBpUGxS1S13Dw52QV
X-Received: by 2002:a05:690e:c8a:b0:67d:b4d7:6351 with SMTP id
 956f58d0204a3-67db4d776aamr3071030d50.95.1794910092799; Tue, 17 Nov 2026
 02:08:12 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261011-pvr-gpuvm-immediate-v2-0-744ddc6644c3@gmail.com>
 <023177c465539fa87c8ff08ab0ea5051e75547d8.camel@imgtec.com>
In-Reply-To: <023177c465539fa87c8ff08ab0ea5051e75547d8.camel@imgtec.com>
From: Gyeyoung Baek <gye976@gmail.com>
Date: Tue, 17 Nov 2026 19:07:58 +0900
X-Gm-Features: AclHuK_Xc4sLYXi4vnQS5sQDf9bBjGKQz251A4uU8vi1uUCZgD9ldA2oQgFsg3k
Message-ID: <CAKbEznsbLiCj3tgAFdsaRvc1XbsR7f6pPs6-AWfDUJQv6JHWKA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] drm/imagination: Switch the GPUVM to immediate mode
To: Luigi Santivetti <luigi.santivetti@imgtec.com>
Cc: Alessio Belle <alessio.belle@imgtec.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Alexandru Dadu <alexandru.dadu@imgtec.com>,
 Brajesh Gupta <brajesh.gupta@imgtec.com>, 
 Frank Binns <frank.binns@imgtec.com>, 
 "imagination@lists.freedesktop.org" <imagination@lists.freedesktop.org>, 
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 LKML <linux-kernel@vger.kernel.org>
Content-Type: multipart/alternative; boundary="0000000000007c338b066076120a"
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
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--0000000000007c338b066076120a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Luigi,

Thanks for taking a look.

Just a heads-up: I've since posted v2 of the VM bind series, so please
review that one instead:

https://lore.kernel.org/dri-devel/20261108-pvr-vm-bind-v2-0-730103d2cc9a@gm=
ail.com/

Thanks,
Gyeyoung

2026=EB=85=84 11=EC=9B=94 17=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 6:27, =
Luigi Santivetti <luigi.santivetti@imgtec.com>=EB=8B=98=EC=9D=B4
=EC=9E=91=EC=84=B1:

> Hi Gyeyoung,
>
> Thank you for these patches, and sorry for the slowness in responding.
> These two
> seem okay to me - I also run IGT.
>
> What I can do is to kick a run of CTS with them applied while I'll look a=
t
> the
> series for adding the VM bind ioctl.
>
> Thanks,
> Luigi
>
> On Sun, 2026-10-11 at 18:45 +0900, Gyeyoung Baek wrote:
> > Switch the GPUVM to immediate mode, as a prerequisite for asynchronous
> > VM_BIND. A revised VM_BIND series will follow separately; v1 [1] is
> > linked only for context.
> >
> > The switch also fixes an issue Sashiko reported on [1]: the GPUVA lists
> > of other objects are updated without holding their reservations [2].
> >
> > Based on drm-misc-fixes (depends on 196d4d10c1b3).
> >
> > Tested on BeagleY-AI with lockdep, KASAN and failslab enabled:
> > - All IGT imagination tests pass, including pvr_vm_map [3].
> > - The fail-nth reproducer in patch 1 no longer warns.
> >
> > [1]
> https://lore.kernel.org/r/20260817-pvr-vm-bind-v1-0-0a0f21be7d38@gmail.co=
m
> > [2]
> https://sashiko.dev/#/patchset/20260817-pvr-vm-bind-v1-0-0a0f21be7d38@gma=
il.com?part=3D1
> > [3]
> https://lore.kernel.org/igt-dev/20260930125057.1837788-1-gye976@gmail.com=
/
> >
> > Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
> > ---
> > Changes in v2:
> > - Patch 1: drain the vm_bo that fini() deferred when map_init() fails.
> >   (Sashiko)
> > - Link to v1:
> https://patch.msgid.link/20261011-pvr-gpuvm-immediate-v1-0-5b298dfce4f8@g=
mail.com
> >
> > ---
> > Gyeyoung Baek (2):
> >       drm/imagination: Switch the GPUVM to immediate mode
> >       drm/imagination: Stop locking reservations around map and unmap
> >
> >  drivers/gpu/drm/imagination/pvr_vm.c | 82
> +++++++++++++-----------------------
> >  1 file changed, 30 insertions(+), 52 deletions(-)
> > ---
> > base-commit: 6ccf996a0dec1852dab94ad865f27b4904750e12
> > change-id: 20261011-pvr-gpuvm-immediate-f7ea8edc2e7f
> >
> > Best regards,
> > --
> > Gyeyoung Baek <gye976@gmail.com>
> >
>
>

--0000000000007c338b066076120a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>Hi Luigi,</div><div dir=3D"auto"><br></div><div dir=
=3D"auto">Thanks for taking a look.</div><div dir=3D"auto"><br></div><div d=
ir=3D"auto">Just a heads-up: I&#39;ve since posted v2 of the VM bind series=
, so please review that one instead:</div><div dir=3D"auto"><br></div><div =
dir=3D"auto"><a href=3D"https://lore.kernel.org/dri-devel/20261108-pvr-vm-b=
ind-v2-0-730103d2cc9a@gmail.com/">https://lore.kernel.org/dri-devel/2026110=
8-pvr-vm-bind-v2-0-730103d2cc9a@gmail.com/</a></div><div dir=3D"auto"><br><=
/div><div data-smartmail=3D"gmail_signature"><div dir=3D"ltr"><div>Thanks,<=
/div><div>Gyeyoung</div></div></div></div><br><div class=3D"gmail_quote gma=
il_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">2026=EB=85=84 11=
=EC=9B=94 17=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 6:27, Luigi Santivetti=
 &lt;<a href=3D"mailto:luigi.santivetti@imgtec.com">luigi.santivetti@imgtec=
.com</a>&gt;=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pa=
dding-left:1ex">Hi Gyeyoung,<br>
<br>
Thank you for these patches, and sorry for the slowness in responding. Thes=
e two<br>
seem okay to me - I also run IGT.<br>
<br>
What I can do is to kick a run of CTS with them applied while I&#39;ll look=
 at the<br>
series for adding the VM bind ioctl.<br>
<br>
Thanks,<br>
Luigi<br>
<br>
On Sun, 2026-10-11 at 18:45 +0900, Gyeyoung Baek wrote:<br>
&gt; Switch the GPUVM to immediate mode, as a prerequisite for asynchronous=
<br>
&gt; VM_BIND. A revised VM_BIND series will follow separately; v1 [1] is<br=
>
&gt; linked only for context.<br>
&gt; <br>
&gt; The switch also fixes an issue Sashiko reported on [1]: the GPUVA list=
s<br>
&gt; of other objects are updated without holding their reservations [2].<b=
r>
&gt; <br>
&gt; Based on drm-misc-fixes (depends on 196d4d10c1b3).<br>
&gt; <br>
&gt; Tested on BeagleY-AI with lockdep, KASAN and failslab enabled:<br>
&gt; - All IGT imagination tests pass, including pvr_vm_map [3].<br>
&gt; - The fail-nth reproducer in patch 1 no longer warns.<br>
&gt; <br>
&gt; [1] <a href=3D"https://lore.kernel.org/r/20260817-pvr-vm-bind-v1-0-0a0=
f21be7d38@gmail.com" rel=3D"noreferrer noreferrer" target=3D"_blank">https:=
//lore.kernel.org/r/20260817-pvr-vm-bind-v1-0-0a0f21be7d38@gmail.com</a><br=
>
&gt; [2] <a href=3D"https://sashiko.dev/#/patchset/20260817-pvr-vm-bind-v1-=
0-0a0f21be7d38@gmail.com?part=3D1" rel=3D"noreferrer noreferrer" target=3D"=
_blank">https://sashiko.dev/#/patchset/20260817-pvr-vm-bind-v1-0-0a0f21be7d=
38@gmail.com?part=3D1</a><br>
&gt; [3] <a href=3D"https://lore.kernel.org/igt-dev/20260930125057.1837788-=
1-gye976@gmail.com/" rel=3D"noreferrer noreferrer" target=3D"_blank">https:=
//lore.kernel.org/igt-dev/20260930125057.1837788-1-gye976@gmail.com/</a><br=
>
&gt; <br>
&gt; Signed-off-by: Gyeyoung Baek &lt;<a href=3D"mailto:gye976@gmail.com" t=
arget=3D"_blank" rel=3D"noreferrer">gye976@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt; Changes in v2:<br>
&gt; - Patch 1: drain the vm_bo that fini() deferred when map_init() fails.=
<br>
&gt;=C2=A0 =C2=A0(Sashiko)<br>
&gt; - Link to v1: <a href=3D"https://patch.msgid.link/20261011-pvr-gpuvm-i=
mmediate-v1-0-5b298dfce4f8@gmail.com" rel=3D"noreferrer noreferrer" target=
=3D"_blank">https://patch.msgid.link/20261011-pvr-gpuvm-immediate-v1-0-5b29=
8dfce4f8@gmail.com</a><br>
&gt; <br>
&gt; ---<br>
&gt; Gyeyoung Baek (2):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0drm/imagination: Switch the GPUVM to immedia=
te mode<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0drm/imagination: Stop locking reservations a=
round map and unmap<br>
&gt; <br>
&gt;=C2=A0 drivers/gpu/drm/imagination/pvr_vm.c | 82 +++++++++++++---------=
--------------<br>
&gt;=C2=A0 1 file changed, 30 insertions(+), 52 deletions(-)<br>
&gt; ---<br>
&gt; base-commit: 6ccf996a0dec1852dab94ad865f27b4904750e12<br>
&gt; change-id: 20261011-pvr-gpuvm-immediate-f7ea8edc2e7f<br>
&gt; <br>
&gt; Best regards,<br>
&gt; --=C2=A0 <br>
&gt; Gyeyoung Baek &lt;<a href=3D"mailto:gye976@gmail.com" target=3D"_blank=
" rel=3D"noreferrer">gye976@gmail.com</a>&gt;<br>
&gt; <br>
<br>
</blockquote></div>

--0000000000007c338b066076120a--
