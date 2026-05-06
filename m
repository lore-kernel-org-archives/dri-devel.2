Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D34A4CD3424
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 07:40:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41FEF10E185;
	Wed,  6 May 2026 07:40:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qvMiNVma";
	dkim-atps=neutral
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com
 [209.85.208.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B92B10E185
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 07:40:07 +0000 (UTC)
Received: by mail-ed1-f47.google.com with SMTP id
 4fb4d7f45d1cf-67b8d9c26bbso8753258a12.2
 for <dri-devel@lists.freedesktop.org>; Wed, 06 May 2026 00:40:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778053206; cv=none;
 d=google.com; s=arc-20240605;
 b=jOuKO97wmNuj3Eq07sEZz9oqI3ucx5ZpVG0QSpHTc4AhWy1yI38Py0O4ZkokkhDpol
 0pixThOCgYmwkEw5kMfqfTw1jGQsbsA5+FhY1UsoznBVmX5/y+teDtgJmHhOLlRZWAqf
 ziT5qCHrTimSrx/DQbeUll78801xUpxVWQe96V7th3hC4jw/zaROI0UgJ/nazqZmpFRp
 1v6B7TWug5fOCStRbQJBiaKJBxR7aGPQOHKYXFSvDA7dAKDbd3BvcXX511JYXMW1X3ln
 hAwmb34NMiixv4/XGra4o39G3YxVCiZER046YMXxc6javrof7gBl2R0RXWBaCOyCo/rv
 E6mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=tXVlFNiySvQK4J5YoU1UIUrYaUeFLiQ4Kso4pCitG60=;
 fh=KJ7z+C/Ucoh+8YirCLdnG/FJqSdG8vj7ihPrJavC0t4=;
 b=hhG/PHgHnLQ+D9lpKJU5yVwg93+hK+CiFJi6xfz2SjP+y5x18OdceH+a2WAKfXqSwO
 lg4EbRSDYhkM5RZByUcj25Tnszl+RkOFqO5VD+5cFXRT9PgHsqw6PdZnFTkMn54Y6UC6
 IaGZTzeBQgXo52zjrYTT7VtK4CyBW8itWmD6DXKWahnL+ThX1llmpAUONLWZSf3kWA4w
 5vGMu1D7U6bL73NVi1qT9ucHV3acHJAOMCdJZnyb/NgyEp4pVeU5e4qyWB8dmI5V1Ttn
 n0ggl1kdENBTTNG9qDkCW0hQEEpg1CAV2+NPGrIQpp5G9gzQbC4HJYQCVrHjhup8E94A
 uFtw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778053206; x=1778658006; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tXVlFNiySvQK4J5YoU1UIUrYaUeFLiQ4Kso4pCitG60=;
 b=qvMiNVmaNvF8jM9ps5EMJeeBcawAqxwPEd9MwKgb7UEtT69wXaHXI+1+QtV0EdTT2L
 c94DzfkktoQ4E6zuTdoZgdMfC4MHk8br5Yoz+/v3ZpRp/XoCz6vg0ITNfSP9xQ5uGZ1i
 t+gKA7wehoBEsDSw7pqo6aFX+QmsMZMHaRAtSJT2ypAM69Yotx6nZBv6SHilvrDxmORz
 AmQdz4iOQd5/G1wYYB9nkj2wNBz2VNTx6d84igFSwjyQAK69a79kHVoR2Yn3nvsL9O1D
 MnavSxGkBi3mfL0Ku5ozLw2EOjfLDpGvJAd0kKDJK6xm9Dc/Kn2LPm5KJRG48HEsMUSj
 uHhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778053206; x=1778658006;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tXVlFNiySvQK4J5YoU1UIUrYaUeFLiQ4Kso4pCitG60=;
 b=fKBJNMewcExax2VhxrPqo8TfR2F2tPdtYIIPvSvfFuttEVdlYVop1nwijf4VlI+9BZ
 3Wi8N71zTUcviIh6prxvuyVKdsXPr3OL5pGNfsGxjAKX01azIg2hSRmdQYrwg3E9lok/
 xcdFmvjKzPgeQvVK/+LY0D525R+orrVNprDLBTTLwxTl5lgjRIWmax0+bI2v+Piq3Yi8
 s0RNNNnynN/VKict6onxLWivdDmaISDZnS+6MiAwwPKVgUG0IohDJup1wp/gmlvnv2xQ
 ODMfJUqzzXRV1N17/tnGnd9fhk7VnDKPIEreocH8gkbT2GhMkFh/mGyZLlHSt9nTjOTr
 uLPQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+lvV3rcnqlCsxWxi6ITry+bwziRWLaKa19qqomwAlIB6dSNWfs7eMQqgiQsxdzB15Gg62+alzQ1Q0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxyaDFLPClpSZz2TJHFyl07W3ApLMLv9w/3c8pK0oM1AgNU797q
 ygLlHK+Zqzza5ooGF2tcNKP48qRzpzrDER79umgM/5fywuWsmagWvGu7rpcjwCp8tGoLvkrjXFA
 JzQDnlwiwkS75p9WqvEOWROFiP2jKrw==
X-Gm-Gg: AeBDietWnJv40yqfbrjNwlOLcBxkacWUCVZ+hqBw7hrWMo4iZC/tcPDTM6ql7o4xCHt
 rt3R8bQGyaXy4hZ3BecRPE45wSQwZUiB7voMT3HBdg4WTuWxy6xDbqnmMCJC6mMrNCBOM4lpBip
 86tZPVnthyvCsrD/aYLYodwZIC1GEAw0ojGEQZVPQOSLfhmqzZljZvGjYY1IQHJj8fOeREzBXyp
 pQPDAd4cUM7BM1SWTNTVdrdqOXBWGatgC++Dx5skyiTLIMT9cg1Bjs+IZ7sjgTM7cdHV9Kn+lX4
 T7SaZXf/eHS7oYmJS4cSZ0YJZKi/vdrXp6TNEdxjRVsUQ/w=
X-Received: by 2002:a05:6402:21d3:b0:671:a18b:32b8 with SMTP id
 4fb4d7f45d1cf-67d6201ec96mr871799a12.0.1778053205490; Wed, 06 May 2026
 00:40:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260424124118.38649-1-mhun512@gmail.com>
 <CAD++jLnqJvtx7H3YDfcuqfGHSg_9_xzUJMaLSC+N34J7R18eRw@mail.gmail.com>
In-Reply-To: <CAD++jLnqJvtx7H3YDfcuqfGHSg_9_xzUJMaLSC+N34J7R18eRw@mail.gmail.com>
From: Myeonghun Pak <mhun512@gmail.com>
Date: Wed, 6 May 2026 16:39:54 +0900
X-Gm-Features: AVHnY4IN47NkKa10Dqgb6vjs-dcsWin0uh4NpU8yD2Ca2xRfbPxYqyEK4Yvmi0c
Message-ID: <CAGEsz8HaMCsG0tU2CzwoVo5YqeQivEHPyCfDUgXkCvfgPDP4fQ@mail.gmail.com>
Subject: Re: [PATCH] drm/tve200: Fix probe cleanup after register failure
To: Linus Walleij <linusw@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: multipart/alternative; boundary="000000000000b47ea306512145c4"
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

--000000000000b47ea306512145c4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Linus,

Thank you for applying the patch to drm-misc-next.

Best regards,
Myeonghun Pak

2026=EB=85=84 5=EC=9B=94 5=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 6:18, Li=
nus Walleij <linusw@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:

> On Fri, Apr 24, 2026 at 2:41=E2=80=AFPM Myeonghun Pak <mhun512@gmail.com>=
 wrote:
>
> > tve200_modeset_init() creates a panel bridge and initializes the DRM
> > mode config before tve200_probe() registers the DRM device. If
> > drm_dev_register() fails, probe returns an error and the driver's remov=
e
> > callback is not called, so those modeset resources are left behind.
> >
> > Unwind the panel bridge and mode config on that failure path before
> > disabling the clock and dropping the DRM device reference.
> >
> > Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
>
> Patch applied to drm-misc-next.
>
> Yours,
> Linus Walleij
>

--000000000000b47ea306512145c4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><span class=3D"gmail-rnc2Gd" style=3D"col=
or:rgb(31,31,31);font-family:&quot;Google Sans&quot;,Roboto,Arial,sans-seri=
f;font-size:15.75px;font-variant-ligatures:no-contextual">Dear Linus,</span=
><div class=3D"gmail-gWqWw gmail-rnc2Gd" style=3D"color:rgb(31,31,31);font-=
family:&quot;Google Sans&quot;,Roboto,Arial,sans-serif;font-size:15.75px;fo=
nt-variant-ligatures:no-contextual"><br></div><span class=3D"gmail-rnc2Gd" =
style=3D"color:rgb(31,31,31);font-family:&quot;Google Sans&quot;,Roboto,Ari=
al,sans-serif;font-size:15.75px;font-variant-ligatures:no-contextual">Thank=
 you for applying the patch to drm-misc-next.</span><div class=3D"gmail-gWq=
Ww gmail-rnc2Gd" style=3D"color:rgb(31,31,31);font-family:&quot;Google Sans=
&quot;,Roboto,Arial,sans-serif;font-size:15.75px;font-variant-ligatures:no-=
contextual"><br></div><span class=3D"gmail-rnc2Gd" style=3D"color:rgb(31,31=
,31);font-family:&quot;Google Sans&quot;,Roboto,Arial,sans-serif;font-size:=
15.75px;font-variant-ligatures:no-contextual">Best regards,</span><div clas=
s=3D"gmail-gWqWw gmail-rnc2Gd" style=3D"color:rgb(31,31,31);font-family:&qu=
ot;Google Sans&quot;,Roboto,Arial,sans-serif;font-size:15.75px;font-variant=
-ligatures:no-contextual">Myeonghun Pak</div></div><br><div class=3D"gmail_=
quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">2026=EB=
=85=84 5=EC=9B=94 5=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 6:18, Linus Wal=
leij &lt;<a href=3D"mailto:linusw@kernel.org">linusw@kernel.org</a>&gt;=EB=
=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">On Fri, Apr 24, 2026 at 2:41=E2=80=AFPM Myeonghun Pak &=
lt;<a href=3D"mailto:mhun512@gmail.com" target=3D"_blank">mhun512@gmail.com=
</a>&gt; wrote:<br>
<br>
&gt; tve200_modeset_init() creates a panel bridge and initializes the DRM<b=
r>
&gt; mode config before tve200_probe() registers the DRM device. If<br>
&gt; drm_dev_register() fails, probe returns an error and the driver&#39;s =
remove<br>
&gt; callback is not called, so those modeset resources are left behind.<br=
>
&gt;<br>
&gt; Unwind the panel bridge and mode config on that failure path before<br=
>
&gt; disabling the clock and dropping the DRM device reference.<br>
&gt;<br>
&gt; Signed-off-by: Myeonghun Pak &lt;<a href=3D"mailto:mhun512@gmail.com" =
target=3D"_blank">mhun512@gmail.com</a>&gt;<br>
<br>
Patch applied to drm-misc-next.<br>
<br>
Yours,<br>
Linus Walleij<br>
</blockquote></div></div>

--000000000000b47ea306512145c4--
