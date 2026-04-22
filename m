Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A82CFF99344
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 08:51:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77CE010EFD5;
	Thu, 23 Apr 2026 08:51:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MwxplqEF";
	dkim-atps=neutral
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com
 [74.125.82.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47DF210E9E7
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 15:08:05 +0000 (UTC)
Received: by mail-dy1-f170.google.com with SMTP id
 5a478bee46e88-2d832f2f44cso5107366eec.0
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 08:08:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776870484; cv=none;
 d=google.com; s=arc-20240605;
 b=UPBmN1nfA8pRmlubDkEBKLTeNeG6odB9bkxPZxOAdy/rd5FuMpwNzOTBufb0a7fX9y
 /hIu1F4uSFTqQEpmXixnRP6dmEawTLoCmZhVIgPxoEsfbjaGWihkjJD7WHav3+BSYlfc
 6hcU+6wfFUpYc852WahrMFZbIatz89o3JBSy9TZScDnFB3+xmkVLbuPg7zJPSwZZHjYf
 kbr/SM69yBUZ/SgHHU9djpFCLQejAUX2xSJAu7WlewEdsuPMfUt7bhNynn98zIUNmq+W
 9XBAoWZqd1t5uv4aXXEmQHoHWJU8N9qbCOl1B+r9jm8mQIVpWk6lTd9N+/U4nhTGN3DF
 gE+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=tKKuRiL9pZeGqtRhDJ+0Iftjn5ibFXpa0nN+Iza8sOo=;
 fh=BzayvTRYfzTlH3oCOcSWSE+nXUygMVRCfpTUD4uZhuw=;
 b=af3qGX3rj/05osvEE1D91zODwSkXvfYRpxp8LuWw5uO2hN7/+ZK5zzmgi1QkHjUVjR
 lxNTRGJsBSa4z54nlg3DGg5mQqGCGz25Q0YMuxOyYXhJdB6YdhxQELUPYbkMRgJi2a2M
 6Vy5lgU3pNlzOoUS6GxixerAOQtx0KyBXUtVNuBYtrzpffyJJPVFMoEiUnmNiIlxdu1h
 n5uwePZPr6Euomu9GCUdT7h+kjs7CRmgi/vwnUqD+qIFeaG+eV7vudLyNEYLmGHQtWTL
 bkGrE9H0kiZh7dM3T0JKRx3eecEOY14mFcSjj8JbsyuMtUM1IXWTBAUKbwiWUj+OLoAg
 183g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776870484; x=1777475284; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tKKuRiL9pZeGqtRhDJ+0Iftjn5ibFXpa0nN+Iza8sOo=;
 b=MwxplqEFrOtHFU4OD65T17NDjWLTdALCHDNw+9BwpgjZGEWgQ9tAsNg8nnceiJE52w
 WhCy1eemIWzz7vm4+1t3uDCV4sszLWwFMfN5g23pYwedwumuD5SqQGVsrDDiHVvyR6hx
 Dq7u/DxjBYfz2GvKpJ8mrJX+dL46ROplps79Vx2IieTnIjc8mckbsvdxC7ZRHf9M2eeo
 oKYeD589MKnhC8RfxVAjPG3MSaIyWUM6ofAzHg7sGQY37BQYwOuuxoa6gt6dHqsdS86k
 CBOwVy021XR6vfnMFYlcA3TLbryabfb+hfJ74DZ9bTwBoGu4ToHcnSUUyzIAwU+WiskD
 5uCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776870484; x=1777475284;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tKKuRiL9pZeGqtRhDJ+0Iftjn5ibFXpa0nN+Iza8sOo=;
 b=DP+iJ+zXWbOqQOSgK2xCanEw6Omw1RwIo0S9mydKvna7Kei5Y4bgcBrRWnybpMTrSY
 ap1sy3m+fpXJWcL8aXKz8DpgH/WEvxvAnUscPtj2zcZy4aW1h1PLjBl2EVrKuQywYgfh
 4mrvTSGB+iLiM+yPFXJXDk3rymEDFsgB3fb9uwzhLnPWvQi+g2+diPpkWs2L8U27/xiN
 6zf1at4OOm6t0hio7uLdCEW4uAiuEvzZPL9pOsYZ2hBPmQ7Ff/9pQUa0wKMRPkzCxxD+
 yIioOow+gfYSGCYrE2anNwOYfahFGH8Xpm0KAx3docmDsOw4yxXZ0w/WROc2qTT5Jqhl
 /xkA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/9JFCumWkaipemQUs0cftGPhxDw7PVhz4e39WK3plTlueGdd0kPyw/nh2QM9Qvo9VOEC21pREgFf4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwJ+G9bwA4ilmi+qfpq08wuOTWpsR9dX2Oni/koaQlpz4FzbN8h
 sMDhiooEqx5rDl6KgTEd0326dZaxFOomXDuaSQLxci/dhwHEZxwmLe27rFfYyfNBUgeHv94vWlJ
 eqUe2jUkIhH2cVu16LZKwRUIwLeSWKpo=
X-Gm-Gg: AeBDievb+wq4dGj5jvQBR+SkGJil6lEkeKwistzFJZkhLDfeV7fjau9TCnUQwbsrgoC
 uCOZseZLLcvYiDM5xJ37UVMFpmhFESyn7ZB/DZpQlapTELfPsdqCPQipapfeKQo+JBPqc9V87iS
 2F17EGd0rv+zKrRc57VhbvKbThqmJdraMRqiDdXLqqatsGyDRnZYx6xZeau235Nq5+i1JsBbmFh
 utzh0PvNwCgrZdauiK6wegohxzBjUN5zxvAibcuKA4+8HEkD+Z8sszUfF/BFOx6YwWq9mo9rSCI
 AmaW6JIgyttL9D5w2Y3gLdvgebUti3mASbMgHLsCoDdRtsWq370=
X-Received: by 2002:a05:693c:3007:b0:2d9:6373:ad0a with SMTP id
 5a478bee46e88-2e46538fd04mr11320322eec.11.1776870484193; Wed, 22 Apr 2026
 08:08:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260420134424.77494-1-amit.barzilai22@gmail.com>
 <20260420134424.77494-2-amit.barzilai22@gmail.com>
 <404ec984-0486-442e-a108-4c5bad700248@gmx.de>
In-Reply-To: <404ec984-0486-442e-a108-4c5bad700248@gmx.de>
From: Amit Barzilai <amit.barzilai22@gmail.com>
Date: Wed, 22 Apr 2026 18:07:53 +0300
X-Gm-Features: AQROBzBeAfQymMn3-OspNSFT9i3Jc-DBT869Lzio_L7oER-_0lbe7HJBcj1uFO0
Message-ID: <CAOEgbErWghDHw0XPajoQnBtcz74FpkfdsUV6Yz1Q15hg16pbdg@mail.gmail.com>
Subject: Re: [PATCH 1/3] fbdev: cobalt_lcdfb: Request memory region
To: Helge Deller <deller@gmx.de>
Cc: thomas.zimmermann@suse.de, linux-fbdev@vger.kernel.org, 
 dri-devel@lists.freedesktop.org
Content-Type: multipart/alternative; boundary="00000000000005b51a06500de65e"
X-Mailman-Approved-At: Thu, 23 Apr 2026 08:51:37 +0000
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

--00000000000005b51a06500de65e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Helge,
Yes, I wrote all three patches and I am OK with the added Signed-off-by
line.
Sorry for the oversight, I'll make sure to include it in future submissions=
.

Thanks,
Amit

On Wed, Apr 22, 2026 at 5:50=E2=80=AFPM Helge Deller <deller@gmx.de> wrote:

> Hi Amit,
>
> On 4/20/26 15:44, Amit Barzilai wrote:
> > Use devm_platform_get_and_ioremap_resource() instead of open-coding
> > platform_get_resource() and devm_ioremap() separately. The helper
> > requests the memory region before mapping it, which registers the range
> > in /proc/iomem and prevents another driver from mapping the same
> > registers.
> >
> > Assisted-by: Claude:claude-sonnet-4-6
>
> You missed your signed-off line, which I added while applying patches #1
> and #2:
> Signed-off-by: Amit Barzilai <amit.barzilai22@gmail.com>
>
> Amit, please confirm that you wrote patches #2 and #3 and that you
> are OK with the added Signed-off-by line, otherwise I need to drop the
> patches.
>
> Helge
>
> > ---
> >   drivers/video/fbdev/cobalt_lcdfb.c | 12 +++---------
> >   1 file changed, 3 insertions(+), 9 deletions(-)
>
>

--00000000000005b51a06500de65e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Helge,</div>Yes, I wrote all three patches and I a=
m OK with the added Signed-off-by line.<div>Sorry for the oversight, I&#39;=
ll make sure to include it in future submissions.</div><div><br></div><div>=
Thanks,</div><div>Amit</div></div><br><div class=3D"gmail_quote gmail_quote=
_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Apr 22, 2026 at 5=
:50=E2=80=AFPM Helge Deller &lt;<a href=3D"mailto:deller@gmx.de">deller@gmx=
.de</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">Hi Amit,<br>
<br>
On 4/20/26 15:44, Amit Barzilai wrote:<br>
&gt; Use devm_platform_get_and_ioremap_resource() instead of open-coding<br=
>
&gt; platform_get_resource() and devm_ioremap() separately. The helper<br>
&gt; requests the memory region before mapping it, which registers the rang=
e<br>
&gt; in /proc/iomem and prevents another driver from mapping the same<br>
&gt; registers.<br>
&gt; <br>
&gt; Assisted-by: Claude:claude-sonnet-4-6<br>
<br>
You missed your signed-off line, which I added while applying patches #1 an=
d #2:<br>
Signed-off-by: Amit Barzilai &lt;<a href=3D"mailto:amit.barzilai22@gmail.co=
m" target=3D"_blank">amit.barzilai22@gmail.com</a>&gt;<br>
<br>
Amit, please confirm that you wrote patches #2 and #3 and that you<br>
are OK with the added Signed-off-by line, otherwise I need to drop the patc=
hes.<br>
<br>
Helge<br>
<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0drivers/video/fbdev/cobalt_lcdfb.c | 12 +++---------<br>
&gt;=C2=A0 =C2=A01 file changed, 3 insertions(+), 9 deletions(-)<br>
<br>
</blockquote></div>

--00000000000005b51a06500de65e--
