Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43B8606A31E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 12:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r8hx3Ln2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88F1010E0BB;
	Wed, 25 Nov 2026 12:40:01 +0000 (UTC)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com
 [209.85.218.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7A2210E0BB
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 12:39:54 +0000 (UTC)
Received: by mail-ej1-f42.google.com with SMTP id
 a640c23a62f3a-c511c0e2826so653859466b.0
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 04:39:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795610393; cv=none;
 d=google.com; s=arc-20260327;
 b=cIlZdUar6IZQ1HkssbYLYbAvVBawRFdeMQjutXU/X2vPjliEkGjALZ+VZtBd3QYOWe
 HsQca+udU0Bb1GZCTtTKP4782MXGbN501uceh6TF/TPDrO4W4J4xOfjOmIqld2WTPLAP
 IyzLhs1y08n9DrDkpMDwHER9MYx+wo+g2St0l8Jlwt5O9GLhTCjwpgGGJu1ne5wSjghD
 Pa/iMfanq/HuD4/KiILGfas0vG2uGWaQBSwySZWsA9sFMb2epsmTliDU7GSVMQZs+9I5
 5gkcAGFRQQ+2zvGt57YLCmNEdDoXmTRCMGPV8eLSUSVtu92bh+NOPvkB8XP1RoLMZ609
 fGkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=2nBUpJc5iHflZDRwAMX6vbv2TQ3IkJKSBfDxCvYqDt8=;
 fh=Egz8BjGAk6xTRyjBYKJCm+LWUQctHifE81Bwl63eQQ0=;
 b=Jod9B6AD9ZRBc4INe5d0MobYGJptNYTZNfXmoEbi5B83tL/WmTO2F1gnG8DHZgKc08
 kMrJLpE6KAAogAH1CLFzCc2qT3vTkHne+CtiMFmLrWsCMo/QDTPOpTKcvE+lPpRMjAY4
 MQvR2ij906o5EF1057ILM8t0sqyJvjq/sP+tShcEVDBhky5ELKSjzyn04UZn217ZKRno
 6UCyEkctbnl8QbrZN/MTxsRfvve8sHMnAVwRQnl5C6zRuOiC/4U6eolmhCZNMsqNiF1C
 L7R2W3DbOExYaUnw4WEsWj1/0iveCVzjZ7TJzysi+RWV0OInhquZ1spL9rl7vMo5M3+k
 iWEg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795610393; x=1796215193; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=2nBUpJc5iHflZDRwAMX6vbv2TQ3IkJKSBfDxCvYqDt8=;
 b=r8hx3Ln2vA3enquiohyZo3l60LDljrdaAo80U75UV7ItUoIqy428aNkqZEBDTum7uA
 WjomydO9rBFbU9iuJF1+qLvsQa9r3BZ6u3m+ZfoZAZlcFmI0kgUD83+YKwJscXJ5aSpd
 S4k1Z9ef5S6ZhVvlHCMmEm0jAZFlR5jClxa93D2mS4cc2tRRnlJtBZddM+gCY8joc9Mk
 mQ7/kHizgIyQqOyzrc8jGpIMcD2TTndGTM04AlTuM4gJrOVb72fU0edE5lzGq6vyML6+
 M1YD/wxr+68HNh6pMebaXhtolxaqmeWxrQETzpKhXUJAfKDlJ2UpyD6mB6DwvqIh5EYP
 L9Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795610393; x=1796215193;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=2nBUpJc5iHflZDRwAMX6vbv2TQ3IkJKSBfDxCvYqDt8=;
 b=sFu63BuQk5LPrrt+JRHCKatrL9sMktdJEs2P1kQgDSCXsZpB6Zh5ZuvHGreWEFf6GZ
 mQ+eDc48eMCr93yYze38RgrRbRA8FbeIFP5RTASBdWGPruLYw4SXJsKlBlKW5q+Ed4iA
 H+U0kA/pDqu3CBAmrmqFTzwqaXQQ7oxEbZLLWuyou/cvd205VS2irNJXoduX0i3dvmUC
 ap/9Sndc0oMifKuDisKt1Zwh51QTVBNxg6+oXeHtYfHh/8JJoY+boDUYC4EGA41+SyGG
 zug0w7lSmPXFRpJwTRbZLVlyFyyHw04W+xg0HSWDgGC44xYg5L20g1Box+XcJEuddf0n
 lSyQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGRYzOt0ENFMA8jyuvFvXudZrNzTR/kGHqLYHgKVbu7Bi49twMpdqmZNSnOFhyHYNayWYOhp3KFs3E=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8IjaFVYwNsCX5DXSrl5nToa7DHqXIdlKPbMHo7mtSp+cylWRP3
 i1HUdTCqTKf0rLo7y1ZTNV/8DVttpN7uUjtPQ4C5Ym4g3X0EYs16Ajvzlr0DPj5r2n2pN5ZDbmk
 OaZM914y7dK3o/LQBZY27QtyCZHcN+W4=
X-Gm-Gg: AZFdTZendM21K5Dh8lpAWG6rEDS8dFStSkf1HLJXlizEaKJMzZnocvMItDVL1AA1LYj
 NxhZWu6JoJeXmvqq0K81fWAbnSPat+ufAUk/U3m3E7QWkq8slW83o8AvH/u/tVZACV7wOmGngAL
 Qf0HYZbRiqEsUAxryNS9Nytc+uNf5YtEFKcWUqg/BJhSDcI7zrBwvsayId96Jd/DRNv2ia720Sr
 Yzs6Q1aY4CQzYroh+BAk1ryqvljCX70ma+MxXJKrl7fAQptJpHTRDFbarWjeheVL1Sf+ke8XGbl
 iLy8vQT5dcEmSai6vm2ywcMj25xI8Xg0/WIoU4rfM17UuD67rPdUma5hY06gljY7dq9K2t141Df
 TD6XHUxR9SN02fmycL712Vm85n9/zHE7jYFWi6Db0VlRChFfdb42eeAYO+2G79EwEsjNi
X-Received: by 2002:a17:906:68db:b0:c4d:4ce5:7733 with SMTP id
 a640c23a62f3a-c513ab060aamr1110265566b.30.1795610392711; Wed, 25 Nov 2026
 04:39:52 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260514174008.4515-1-ms.bulatov7@gmail.com>
In-Reply-To: <20260514174008.4515-1-ms.bulatov7@gmail.com>
From: =?UTF-8?B?0JzQsNGA0Log0JHRg9C70LDRgtC+0LI=?= <ms.bulatov7@gmail.com>
Date: Wed, 25 Nov 2026 15:39:41 +0300
X-Gm-Features: Aa3M54ooH0fBlRnsQWPqp9LUdwyGUdym9a8GOlUrF5Dq30Z5TrH6wJZYpixCM7E
Message-ID: <CAEyM3Y07hTKVVzVehHUT34XWT5g1uMvAaJGGwshgxFzPeRbYmw@mail.gmail.com>
Subject: Re: [PATCH] drm/nouveau: handle nouveau_hw_get_clock() return value
To: Lyude Paul <lyude@redhat.com>
Cc: Danilo Krummrich <dakr@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Ben Skeggs <bskeggs@redhat.com>, 
 Dave Airlie <airlied@redhat.com>, dri-devel@lists.freedesktop.org, 
 nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: multipart/alternative; boundary="0000000000009cd7f40661191f1d"
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

--0000000000009cd7f40661191f1d
Content-Type: text/plain; charset="UTF-8"

Hi,
Gentle ping on this patch. Please let me know if any changes or further
information are needed.
Thanks,
Mark.

On Thu, 14 May 2026 at 20:41, Bulatov Mark <ms.bulatov7@gmail.com> wrote:

> From: Mark Bulatov <ms.bulatov7@gmail.com>
>
> In the nv04_update_arb() function, MClk and NVClk are passed to
> nv04_calc_arb() or nv10_calc_arb(), where they are used as divisors.
> MClk and NVClk are calculated using nouveau_hw_get_clock(), which, via
> nouveau_hw_pllvals_to_clk(), can return 0, resulting in division by 0.
>
> The result of nouveau_hw_get_pllvals() in the nouveau_hw_get_clock()
> function can also return -ENOENT, which is not checked anywhere.
>
> Fix all this by adding a check.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Fixes: 6ee738610f41 ("drm/nouveau: Add DRM driver for NVIDIA GPUs")
> Signed-off-by: Mark Bulatov <ms.bulatov7@gmail.com>
> ---
>  drivers/gpu/drm/nouveau/dispnv04/arb.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/nouveau/dispnv04/arb.c
> b/drivers/gpu/drm/nouveau/dispnv04/arb.c
> index 1d3542d6006b..2f59b8739fc1 100644
> --- a/drivers/gpu/drm/nouveau/dispnv04/arb.c
> +++ b/drivers/gpu/drm/nouveau/dispnv04/arb.c
> @@ -202,6 +202,9 @@ nv04_update_arb(struct drm_device *dev, int VClk, int
> bpp,
>         uint32_t cfg1 = nvif_rd32(device, NV04_PFB_CFG1);
>         struct pci_dev *pdev = to_pci_dev(dev->dev);
>
> +       if (MClk <= 0 || NVClk <= 0)
> +               return;
> +
>         sim_data.pclk_khz = VClk;
>         sim_data.mclk_khz = MClk;
>         sim_data.nvclk_khz = NVClk;
> --
> 2.39.5
>
>

--0000000000009cd7f40661191f1d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail-n6owBd gmail-awi2gc" style=3D"font-fam=
ily:&quot;Google Sans&quot;,Arial,sans-serif,&quot;Noto Color Emoji&quot;;f=
ont-size:16px;margin:0px;border-bottom:0px rgb(10,10,10)">Hi,</div><div cla=
ss=3D"gmail-n6owBd gmail-awi2gc" style=3D"font-family:&quot;Google Sans&quo=
t;,Arial,sans-serif,&quot;Noto Color Emoji&quot;;font-size:16px;margin:0px;=
border-bottom:0px rgb(10,10,10)">Gentle ping on this patch. Please let me k=
now if any changes or further<br style=3D"margin:0px;border-bottom:0px rgb(=
10,10,10)">information are needed.</div><div class=3D"gmail-n6owBd gmail-aw=
i2gc" style=3D"font-family:&quot;Google Sans&quot;,Arial,sans-serif,&quot;N=
oto Color Emoji&quot;;font-size:16px;margin:0px;border-bottom:0px rgb(10,10=
,10)">Thanks,<br style=3D"margin:0px;border-bottom:0px rgb(10,10,10)">Mark.=
</div></div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=
=3D"ltr" class=3D"gmail_attr">On Thu, 14 May 2026 at 20:41, Bulatov Mark &l=
t;<a href=3D"mailto:ms.bulatov7@gmail.com">ms.bulatov7@gmail.com</a>&gt; wr=
ote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">From: Mark =
Bulatov &lt;<a href=3D"mailto:ms.bulatov7@gmail.com" target=3D"_blank">ms.b=
ulatov7@gmail.com</a>&gt;<br>
<br>
In the nv04_update_arb() function, MClk and NVClk are passed to<br>
nv04_calc_arb() or nv10_calc_arb(), where they are used as divisors.<br>
MClk and NVClk are calculated using nouveau_hw_get_clock(), which, via<br>
nouveau_hw_pllvals_to_clk(), can return 0, resulting in division by 0.<br>
<br>
The result of nouveau_hw_get_pllvals() in the nouveau_hw_get_clock()<br>
function can also return -ENOENT, which is not checked anywhere.<br>
<br>
Fix all this by adding a check.<br>
<br>
Found by Linux Verification Center (<a href=3D"http://linuxtesting.org" rel=
=3D"noreferrer" target=3D"_blank">linuxtesting.org</a>) with SVACE.<br>
<br>
Fixes: 6ee738610f41 (&quot;drm/nouveau: Add DRM driver for NVIDIA GPUs&quot=
;)<br>
Signed-off-by: Mark Bulatov &lt;<a href=3D"mailto:ms.bulatov7@gmail.com" ta=
rget=3D"_blank">ms.bulatov7@gmail.com</a>&gt;<br>
---<br>
=C2=A0drivers/gpu/drm/nouveau/dispnv04/arb.c | 3 +++<br>
=C2=A01 file changed, 3 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/nouveau/dispnv04/arb.c b/drivers/gpu/drm/nouve=
au/dispnv04/arb.c<br>
index 1d3542d6006b..2f59b8739fc1 100644<br>
--- a/drivers/gpu/drm/nouveau/dispnv04/arb.c<br>
+++ b/drivers/gpu/drm/nouveau/dispnv04/arb.c<br>
@@ -202,6 +202,9 @@ nv04_update_arb(struct drm_device *dev, int VClk, int b=
pp,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t cfg1 =3D nvif_rd32(device, NV04_PFB_CF=
G1);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct pci_dev *pdev =3D to_pci_dev(dev-&gt;dev=
);<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (MClk &lt;=3D 0 || NVClk &lt;=3D 0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 sim_data.pclk_khz =3D VClk;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 sim_data.mclk_khz =3D MClk;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 sim_data.nvclk_khz =3D NVClk;<br>
-- <br>
2.39.5<br>
<br>
</blockquote></div>

--0000000000009cd7f40661191f1d--
