Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68C5606A325
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 16:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mpaO/wDu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D9C410E81E;
	Thu, 19 Nov 2026 16:28:10 +0000 (UTC)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com
 [209.85.208.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCD9411208E
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 11:23:07 +0000 (UTC)
Received: by mail-lj1-f178.google.com with SMTP id
 38308e7fff4ca-3acff56a300so21993291fa.2
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 03:23:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795087386; cv=none;
 d=google.com; s=arc-20260327;
 b=MDGjfmoiQpioLKpzDSQwUIba6/kI/sfpErQQVjhmjehGJjgEJqSVdoc/+Kmu8zFJaI
 EmHIadYGzZ98PYonvrlhLNPU4OHeDP8BBeINO5c36g5FUUIqCjKnYBpSVhgZNufx6cQj
 08xQ+k/JMgxflnARDgFJPbdkyLt5QW7Cta+ZV4cjY5uubGAO2DcqjbWDyJ9GqtQOTR9m
 nUV5xTS/9SWxLxEs+8VKW41TX6w2qPG0vI0JnkS6WljjzWFx9iLh/jYvBw4OAINzLz2F
 x4JKE5mp9GQKMWthq9emtpykCUmlMPgyQD93tGiXeTZBmwguERuWq2tluTYVUFFwTMQN
 i0eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=pFtj1pH66GAB0IHq5Y/42cP0eApJlLknwjxX2LnhOik=;
 fh=p3ukI353C7wEbP2dCHZQsYlFUzugmCyd+/lvrZKMLOw=;
 b=Wy7/1zJxblEt/mDmDbYNlACU6xeeUyybVRpLArwyruCArNtw7Bw0aCj/RWUXMguhqV
 TK4wTf8hIP4dSQdg69DE8EG1hDe0qAFeYnTpLGBo5qUs2wjvjd8I2M+cIhZydduvbX8W
 DNzTjRPuJPPWbmSss1uimH1CHu7cDdDWBL2Y8KiaI8NCiwfu0hLWvp6QO/vNnd8dX9WZ
 8hbebdz0IKDdO2zUSajApnAGk6igN+p+LB4cVC/KQXXofBwnvis/uvdjIHSdc4owG1dN
 lshrfqNAGn2z5ljs3eqMEEnuhL0COFsAKtjict0nn6iQwJsCfLSZo49DZBwuWMPcAt/C
 rp3Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795087386; x=1795692186; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=pFtj1pH66GAB0IHq5Y/42cP0eApJlLknwjxX2LnhOik=;
 b=mpaO/wDu7kE26bV44JgD16QhnzPpChJoDjE63sp4TmRV56PMPYUfodK/0MomPt5OaA
 Dev95uTgny0VvKATmpACaeQb8iozszND/hFuTuNBC6a8So10QxhClpoWZP2kUKd3LK4u
 O2pepPIKisXVPMhNAthMFOxS6KFaCStOyfg3pxL9q5LIjT/HRUnu+L7/VWvg/C9RFQ8q
 SleoMs2ZASMITNlw+82l37rddi8ZWRpGL3GOPyRs83zFGaMZ4CuljFek4QnrMGSqPKE3
 bTwRW/fqH6dJAycBCZOIyl/lLFfvuP3gV9BSstzYVHHQByp1W1K26NNrZsckjTwwI++L
 Vj/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795087386; x=1795692186;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=pFtj1pH66GAB0IHq5Y/42cP0eApJlLknwjxX2LnhOik=;
 b=cKc4NE5OBG3eqQ6s5L5ifwquXEillLxOi3QR0TiXxqkGgnRpTojKx1tEeyclgdaVMd
 JDOs/a33Z6qj0tV5v7juBHZ0HO5k5lRWKjKKC+XzZvmDireQWdY9OLu7fx7xbRZ3x/hE
 9+INzbxRO6iHMJsEkyvNvnZecUPnMD+ftiTHCh3NTlH3zlFNeyO53ynEUvcjJBDFLK/b
 YHWi9xzxfqQpYCsFoPbHe9ntbdLKnb7SnLyZAq9t86dB12tKCArKgHgj+LyLVejdJplW
 PWo8XxvJVZoB3ZK3FhHZUgS2YiOXm+zAFF7qF9lyH7riz7bBNbhesaZ2M/EZidFgQ/Qx
 Tlcg==
X-Forwarded-Encrypted: i=1;
 AL+hErHWx63Tq/MjcLQ3+lbixnDdboFRRvgv9glz14LESV1b0QrKCRbdQmAiXZo1JzkYlYjPpi0NAf+oyvw=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9izmGZb13D0oYsNzAe19B2n2VxqD1NHcoTyADrgknbre8NoDD3
 Z29FM8YdINbJliZbam0d5nOPV1J9GvaVaTE21WQuEwonedgx4FPqhI3jT3IefnTEwOTKyFVBVWy
 cAAP2jqxlLfe0g+NVmrjqKTfKmBsFKpc=
X-Gm-Gg: AYBFou34wOfe9CGrCe/sNx/bCt4vcp0NKPhLvfFxD/k/OzydduQn47/ADSz2fznfR21
 I+gLH1wFvFJknFdwX/ouCgo15WJGQLaj9RoTQy41xjUaRVtGYoK/LqSKRt6m3Y6KZ6unzxsHgGC
 YVqaS6aFBXon014BevcUw2TqEMf9kucPapEw7P/r/VWGhwVAfBQBWm6TJSqRZNyrww7VrD0Od2e
 y0rAGaKiD6BgQ8tbwf2m34FrFd01hEMaqcSeaRtKIAn0wLA/ObpO0ezPoj/LKO7eIsFd+WmG73k
 kTCVbiKEg+EwHAKKnvWCkb7/CPLwp9u9UQmpUttuCue2MkiGUwSibAo4eNc7SgJSZ8bip7Azf4F
 g244SbQznzBz9N4gst4h6ndrO5pX6/RmKnIb89oQXyZh6XGK/yfQ13pduhjSp6ph6jpBIAWiggQ
 NCIj+BP9wxLhPY0KU25GJyC6oSvftV7+/Axa9e3/eF67odhVPu4UVTgJTOXLT20+dJg1OsxE5Uc
 UhdDAQF
X-Received: by 2002:a05:651c:a1a1:b0:3ae:bb4:ce29 with SMTP id
 38308e7fff4ca-3ae670bdde8mr17806021fa.6.1795087385337; Thu, 19 Nov 2026
 03:23:05 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261105-kdoc-host1x-bo-ops-v1-1-cc171c9e36a0@gmail.com>
 <OqAlWBYrRWy6u2pwKwlOkQ@nvidia.com>
In-Reply-To: <OqAlWBYrRWy6u2pwKwlOkQ@nvidia.com>
From: "Mr. Patole Amit Samson" <amit.patole@gmail.com>
Date: Thu, 19 Nov 2026 06:22:53 -0500
X-Gm-Features: AclHuK--XgXBE6JaAvDV_M-lobkxQL-RTS7xH7BPMLQN3MmiWwcE4FQkfwCboHU
Message-ID: <CAOorTqFJs2fhkeXqtpYQ2JqoJdPCZ61Wk9gWXM474Emz=p5YtQ@mail.gmail.com>
Subject: Re: [PATCH] gpu: host1x: document the remaining host1x_bo_ops
 callbacks
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: Thierry Reding <thierry.reding@kernel.org>, linux-tegra@vger.kernel.org, 
 Thierry Reding <treding@nvidia.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Content-Type: multipart/alternative; boundary="000000000000f1a45d06609f5976"
X-Mailman-Approved-At: Thu, 19 Nov 2026 16:27:44 +0000
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
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_NAME_FM_MR_MRS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000f1a45d06609f5976
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mikko,

Thank you for the review.




Regards,
Amit S Patole
*"The tragedy of life doesn't lie in not reaching your goal. The tragedy
lies in having no goal to reach"* <http:///>
https://amitpatole.github.io/


On Thu, Nov 19, 2026 at 2:08=E2=80=AFAM Mikko Perttunen <mperttunen@nvidia.=
com>
wrote:

> On Thursday, November 5, 2026 11:01=E2=80=AFPM Amit Patole wrote:
> > Commit 3cbf5e3c46e6 ("gpu: host1x: Allow entries in BO caches to be
> > freed") added a kernel-doc comment for struct host1x_bo_ops that only
> > describes the .pin and .unpin callbacks. Since include/linux/host1x.h
> > is pulled into Documentation/gpu/tegra.rst, this produces four
> > kernel-doc warnings during the htmldocs build:
> >
> >   include/linux/host1x.h:159 struct member 'get' not described in
> 'host1x_bo_ops'
> >   include/linux/host1x.h:159 struct member 'put' not described in
> 'host1x_bo_ops'
> >   include/linux/host1x.h:159 struct member 'mmap' not described in
> 'host1x_bo_ops'
> >   include/linux/host1x.h:159 struct member 'munmap' not described in
> 'host1x_bo_ops'
> >
> > Describe .get, .put, .mmap and .munmap, based on how they are used by
> > host1x_bo_get(), host1x_bo_put(), host1x_bo_mmap() and
> > host1x_bo_munmap(), and on the Tegra DRM implementations in
> > drivers/gpu/drm/tegra/gem.c.
> >
> > The warnings were found by running scripts/kernel-doc over the headers
> > pulled into the htmldocs build. An AI coding assistant (Claude Opus
> > 5.5) was used to locate the warnings and draft this change; it was
> > verified with scripts/kernel-doc (no warnings left) and checkpatch.
> >
> > Fixes: 3cbf5e3c46e6 ("gpu: host1x: Allow entries in BO caches to be
> freed")
> > Signed-off-by: Amit Patole <amit.patole@gmail.com>
> > ---
> > Comment-only change. Built with W=3D1 on x86_64 (drivers/gpu/host1x/,
> > COMPILE_TEST) with no new warnings.
> > ---
> >  include/linux/host1x.h | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/include/linux/host1x.h b/include/linux/host1x.h
> > index e7ba601b2afb..7027adb9bff5 100644
> > --- a/include/linux/host1x.h
> > +++ b/include/linux/host1x.h
> > @@ -146,8 +146,12 @@ static inline struct host1x_bo_mapping
> *to_host1x_bo_mapping(struct kref *ref)
> >  /**
> >   * struct host1x_bo_ops - operations implemented by a host1x_bo provid=
er
> >   *
> > + * @get: take a reference to the bo and return it.
> > + * @put: drop a reference to the bo.
> >   * @pin: create a DMA mapping. Implementation must not touch the bo's
> refcount.
> >   * @unpin: destroy a DMA mapping. Implementation must not touch the
> bo's refcount.
> > + * @mmap: map the bo into the kernel's address space and return the
> address.
> > + * @munmap: unmap a kernel mapping previously returned by @mmap.
> >   */
> >  struct host1x_bo_ops {
> >       struct host1x_bo *(*get)(struct host1x_bo *bo);
> >
> > ---
> > base-commit: 05441d697f7f9a927264f4058cbbc6a03dfcac9d
> > change-id: 20261105-kdoc-host1x-bo-ops-7ae7a3554fb1
> >
> > Best regards,
> > --
> > Amit Patole <amit.patole@gmail.com>
> >
> >
>
> I don't know if I would say 3cbf5e3c46e6 was broken per se, but this
> does look correct;
>
> Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>
>
>
>
>

--000000000000f1a45d06609f5976
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<span class=3D"smart_draft_text">Hi Mikko,<br><br>Thank you for the review.=
<br><br></span><div><br></div><div><br clear=3D"all"><br clear=3D"all"><div=
><div dir=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"gmail_signatu=
re"><div dir=3D"ltr"><div><div dir=3D"ltr"><font face=3D"monospace" style=
=3D"font-family:monospace;color:rgb(0,0,0)">Regards,</font></div><div dir=
=3D"ltr"><font face=3D"monospace" style=3D"font-family:monospace;color:rgb(=
0,0,0)"><a href=3D"http:///" target=3D"_blank" style=3D"font-family:monospa=
ce">Amit S Patole<br><b style=3D"font-size:small;font-family:monospace"><i =
style=3D"font-family:monospace"><font size=3D"1" style=3D"font-family:monos=
pace;color:rgb(255,153,0)">&quot;The tragedy of life doesn&#39;t lie in not=
 reaching your goal. The tragedy lies in having no goal to reach&quot;</fon=
t></i></b></a><br></font></div></div><div dir=3D"ltr"><font face=3D"monospa=
ce" style=3D"font-family:monospace;color:rgb(0,0,0)"><a href=3D"https://ami=
tpatole.github.io/" target=3D"_blank" style=3D"font-family:monospace">https=
://amitpatole.github.io/</a></font><b style=3D"font-size:small"><i><font si=
ze=3D"1" style=3D"color:rgb(255,153,0)"></font></i></b></div><div dir=3D"lt=
r"><br></div></div></div></div></div><div><br><div class=3D"gmail_quote gma=
il_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Nov 19, 2=
026 at 2:08=E2=80=AFAM Mikko Perttunen &lt;<a href=3D"mailto:mperttunen@nvi=
dia.com">mperttunen@nvidia.com</a>&gt; wrote:<br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">On Thursday, November 5, 2026 11:01=E2=80=AFP=
M Amit Patole wrote:<br>
&gt; Commit 3cbf5e3c46e6 (&quot;gpu: host1x: Allow entries in BO caches to =
be<br>
&gt; freed&quot;) added a kernel-doc comment for struct host1x_bo_ops that =
only<br>
&gt; describes the .pin and .unpin callbacks. Since include/linux/host1x.h<=
br>
&gt; is pulled into Documentation/gpu/tegra.rst, this produces four<br>
&gt; kernel-doc warnings during the htmldocs build:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0include/linux/host1x.h:159 struct member &#39;get&#39; not=
 described in &#39;host1x_bo_ops&#39;<br>
&gt;=C2=A0 =C2=A0include/linux/host1x.h:159 struct member &#39;put&#39; not=
 described in &#39;host1x_bo_ops&#39;<br>
&gt;=C2=A0 =C2=A0include/linux/host1x.h:159 struct member &#39;mmap&#39; no=
t described in &#39;host1x_bo_ops&#39;<br>
&gt;=C2=A0 =C2=A0include/linux/host1x.h:159 struct member &#39;munmap&#39; =
not described in &#39;host1x_bo_ops&#39;<br>
&gt; <br>
&gt; Describe .get, .put, .mmap and .munmap, based on how they are used by<=
br>
&gt; host1x_bo_get(), host1x_bo_put(), host1x_bo_mmap() and<br>
&gt; host1x_bo_munmap(), and on the Tegra DRM implementations in<br>
&gt; drivers/gpu/drm/tegra/gem.c.<br>
&gt; <br>
&gt; The warnings were found by running scripts/kernel-doc over the headers=
<br>
&gt; pulled into the htmldocs build. An AI coding assistant (Claude Opus<br=
>
&gt; 5.5) was used to locate the warnings and draft this change; it was<br>
&gt; verified with scripts/kernel-doc (no warnings left) and checkpatch.<br=
>
&gt; <br>
&gt; Fixes: 3cbf5e3c46e6 (&quot;gpu: host1x: Allow entries in BO caches to =
be freed&quot;)<br>
&gt; Signed-off-by: Amit Patole &lt;<a href=3D"mailto:amit.patole@gmail.com=
" target=3D"_blank">amit.patole@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt; Comment-only change. Built with W=3D1 on x86_64 (drivers/gpu/host1x/,<=
br>
&gt; COMPILE_TEST) with no new warnings.<br>
&gt; ---<br>
&gt;=C2=A0 include/linux/host1x.h | 4 ++++<br>
&gt;=C2=A0 1 file changed, 4 insertions(+)<br>
&gt; <br>
&gt; diff --git a/include/linux/host1x.h b/include/linux/host1x.h<br>
&gt; index e7ba601b2afb..7027adb9bff5 100644<br>
&gt; --- a/include/linux/host1x.h<br>
&gt; +++ b/include/linux/host1x.h<br>
&gt; @@ -146,8 +146,12 @@ static inline struct host1x_bo_mapping *to_host1x=
_bo_mapping(struct kref *ref)<br>
&gt;=C2=A0 /**<br>
&gt;=C2=A0 =C2=A0* struct host1x_bo_ops - operations implemented by a host1=
x_bo provider<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; + * @get: take a reference to the bo and return it.<br>
&gt; + * @put: drop a reference to the bo.<br>
&gt;=C2=A0 =C2=A0* @pin: create a DMA mapping. Implementation must not touc=
h the bo&#39;s refcount.<br>
&gt;=C2=A0 =C2=A0* @unpin: destroy a DMA mapping. Implementation must not t=
ouch the bo&#39;s refcount.<br>
&gt; + * @mmap: map the bo into the kernel&#39;s address space and return t=
he address.<br>
&gt; + * @munmap: unmap a kernel mapping previously returned by @mmap.<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt;=C2=A0 struct host1x_bo_ops {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct host1x_bo *(*get)(struct host1x_bo *b=
o);<br>
&gt; <br>
&gt; ---<br>
&gt; base-commit: 05441d697f7f9a927264f4058cbbc6a03dfcac9d<br>
&gt; change-id: 20261105-kdoc-host1x-bo-ops-7ae7a3554fb1<br>
&gt; <br>
&gt; Best regards,<br>
&gt; --=C2=A0 <br>
&gt; Amit Patole &lt;<a href=3D"mailto:amit.patole@gmail.com" target=3D"_bl=
ank">amit.patole@gmail.com</a>&gt;<br>
&gt; <br>
&gt; <br>
<br>
I don&#39;t know if I would say 3cbf5e3c46e6 was broken per se, but this <b=
r>
does look correct;<br>
<br>
Reviewed-by: Mikko Perttunen &lt;<a href=3D"mailto:mperttunen@nvidia.com" t=
arget=3D"_blank">mperttunen@nvidia.com</a>&gt;<br>
<br>
<br>
<br>
</blockquote></div></div>

--000000000000f1a45d06609f5976--
