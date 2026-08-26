Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1BE8C61DB9
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 09:46:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90AFB10EF81;
	Thu, 27 Aug 2026 09:46:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GAOODK1/";
	dkim-atps=neutral
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com
 [209.85.128.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F045410E9B0
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 18:02:48 +0000 (UTC)
Received: by mail-yw1-f172.google.com with SMTP id
 00721157ae682-836c4474028so14415887b3.0
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 11:02:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787767368; cv=none;
 d=google.com; s=arc-20260327;
 b=Zau5gYNb8KJ1JaaNLxePPf9R85XaCMe8oJOe24d4wW8DzH3TU9I6OLt6tgOTGcPj/1
 dfHGy/+MAj4ipQ+K/04OGBipGpsvVeaMJnqIihVHZDLPVCtWSpcuTJ1g3pPKXOwyXzVQ
 8aCfFRohw39KUpgZEW7dspASehVDCo9kz3IqwMVHtwslxHAc6umgYNi9JA+DJqeo9TJI
 uRtW4g27CWXAPShhi/ye0vYlSxrgi/MuoDbWc5sVpqy3yBGx+z4f6F+Xyvk9q370u1xd
 Xh6xyujVSy2HrtYJnOf7CQkPcBqcwDYntvmRWmjkcezKaPLuJaQQGY7ohLsX+A1t5W8f
 gsHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ufqJcA4GLe7bKYSt4VuOA7LyG7GHrT+0lE+aWzUukb0=;
 fh=kRoc/2KcYkmALHiDjooNCy967eYxeVuy74hhpYdLNjM=;
 b=WTIYI4+/KIEeO4C4urTNfoD/K5KWfD7DrDaewW5+c06tlw1923gllwPRf9mqz7rs3V
 s5iUbQC97iQz3GLdLsLhc5bzb0qw/vAu9lRoRdJJSiaPprg6jvN6KHng8vxgeGXTKGxY
 tkpF/Ps15NxGXfu4mazSGZ1ro14JatR9qaM4InglJjW4NWPsBB7VKBCdqfSkuF0xo9eC
 U/1w4it7By6O9ZczCpWneItXMKLXvo7ylu74tx3MviPKUfaxnqTAMCn9/wrL9cmzJxbr
 8d1LMpOF8p95dqQgKsNq4ql0vB1aCM/q0GGVuyFEdKBG7xX7mofYCLXVQO/tHJGPsPgf
 kOMQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787767367; x=1788372167; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ufqJcA4GLe7bKYSt4VuOA7LyG7GHrT+0lE+aWzUukb0=;
 b=GAOODK1/a1CbYedXewMuoe0+/NalFMEJH+S05Z7nurzQ1dLW7PN6PF/pEGgLrCCwow
 v46Lr/GRcblxrpPPgIBnl6iURXjuFbER/xbhev/yM8k89yNDuHO8p4Y78hpdaJdx1bra
 VbMl3v9+dMR19OADSobH3NIuaJPojSBsQt6jVFmqUz4/OMD6FVvEaCRjCyxdaM+ooJFj
 1XieLfNxxvSwbY0wsV7UPIERoEq7FEwtQE4CWNnhBa8jBmO4cko/FpjifwB4bvRku83b
 xzhO1kvxpTXqZM7BOaG9UN852n73HtXUj3ucLrBil3NbBala2++6xCh3LwFcExA51hdO
 0dnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787767368; x=1788372168;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ufqJcA4GLe7bKYSt4VuOA7LyG7GHrT+0lE+aWzUukb0=;
 b=SC1RO0GJKNQfvX9PJQgCBYcxIhnoA4XoP3pzOYYX+oPTra6x/00bPQLyQUnr5k8oWS
 AH31/bZe41iHRQONt1jat2l18XSYfW6k8hpkTuRodSeyrIjWcla6lNp0rzXJMbBX+ZGt
 e4jXJw8MiJF94j6cidAt+lHFFySaVdBauErpiZs2gH8hydtywnFdGjMUOtVDa/U7o5CA
 rFrBIWdHBRzkqAV8rIyZntOzFNhvlsPxe0GVkWF3CaLXTPlxpSqWz99GB5Uvt4PeeKOG
 GP7HORVK72FwC83WqpsEz2yKfsbmVr610O26G/kA9+3XUQCZtwf9U2zCsDTHwjMaXIOB
 iFFw==
X-Gm-Message-State: AFuF++mhbxRlcLBEBrTx8OrHLEgvcnIt68hEeSe5HZEMoIB1jHi2zUwH
 ceswgxwbrSOmn/0CS6ycSq+dl8EXBrRBHM7oz7l8rMRbTndalnXPLuXd+7OB4v/PcYcXY/tvOGw
 Oa12MZmw9yXwZr0YGlfCEHR3MducZT2o=
X-Gm-Gg: AR+sD13BoiZ9rQo7heDvo8ISG+RJ8wRzZDZem6DapW9Ml0It3ru5Kf4HQ1K3fuVanx8
 Y4kH+Q5yahkO09sSsyLgSu6uorvhznXi5xoGBQV8XnJtD5DQ45mUGghDuuTz3gqtqorgwdRSXqa
 7k3tLMr6S8t9/hw5Eddsn8xUurORF5WN8p1Cb7SMn+7SgK62bOFzkRgF2GzPky3y+EF+yifxCi2
 jQu+bH7R82cGcCavJnEGN4AM+pbKL51vElgGvRcSgzfCZuEU91+2qar/tsaGk/AdyIoDkA5r8oE
 7275IJ/IanmoSlf/7pgvg/KDTbijwRmkSa7AWcskMZdb
X-Received: by 2002:a05:690e:1c09:b0:667:b645:5303 with SMTP id
 956f58d0204a3-66d25760bd1mr3181148d50.33.1787767367406; Wed, 26 Aug 2026
 11:02:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260810214247.21416-1-asiyee994@gmail.com>
In-Reply-To: <20260810214247.21416-1-asiyee994@gmail.com>
From: =?UTF-8?B?QXNpeWUgU2FyxLF5xLFsZMSxeg==?= <asiyee994@gmail.com>
Date: Wed, 26 Aug 2026 19:02:35 +0100
X-Gm-Features: AcwNN1UgVU2OJU0Ndh5gFopwbB5Zne-wNYn2HQhiFLBY_r0ZLdpgNTzIBOLm2KA
Message-ID: <CAK77STDMnTrD9E6-N6+te9EZQ0gZTHd-qUZY5Lv1i=M1mm9oDg@mail.gmail.com>
Subject: Re: [PATCH] drm/nouveau/clk/gk20a: fix undefined behaviour in signed
 left shift
To: lyude@redhat.com, dakr@kernel.org
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Content-Type: multipart/alternative; boundary="000000000000e01da80659f70697"
X-Mailman-Approved-At: Thu, 27 Aug 2026 09:44:45 +0000
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

--000000000000e01da80659f70697
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi just pinging to see if anyone has had a chance to review this patch.
Thanks

10 A=C4=9Fu 2026 Pzt 22:42 tarihinde Muhammed Sariyildiz <asiyee994@gmail.c=
om>
=C5=9Funu yazd=C4=B1:

> MASK(w) expands as ((1 << (w)) - 1), and GPC2CLK_OUT_SDIV14_INDIV4_MODE
> is defined as plain 1. Both are used, via GPC2CLK_OUT_INIT_MASK and
> GPC2CLK_OUT_INIT_VAL in gk20a_clk_prog() (and reused by gm20b, which
> includes gk20a.h), to compute:
>
>         1 << 31
>
> Left-shifting a signed int into its sign bit is undefined behaviour
> per the C standard (ISO C11 6.5.7p4), and is flagged by UBSan and
> static analysis tools such as cppcheck (shiftTooManyBitsSigned). Make
> the shifted operand unsigned to fix it, matching the pattern used
> elsewhere in the kernel for register bitfield masks.
>
> No functional change intended.
>
> Found via static analysis (cppcheck --enable=3Dportability) while
> auditing nvkm/subdev/clk for correctness issues.
>
> Signed-off-by: Muhammed Sariyildiz <asiyee994@gmail.com>
> ---
>  drivers/gpu/drm/nouveau/nvkm/subdev/clk/gk20a.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/gk20a.h
> b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/gk20a.h
> index ea5b0ba..7a93f9f 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/gk20a.h
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/gk20a.h
> @@ -27,7 +27,7 @@
>  #define KHZ (1000)
>  #define MHZ (KHZ * 1000)
>
> -#define MASK(w)        ((1 << (w)) - 1)
> +#define MASK(w)        ((1U << (w)) - 1)
>
>  #define GK20A_CLK_GPC_MDIV 1000
>
> @@ -79,7 +79,7 @@
>  #define GPC2CLK_OUT                    (SYS_GPCPLL_CFG_BASE + 0x250)
>  #define GPC2CLK_OUT_SDIV14_INDIV4_WIDTH        1
>  #define GPC2CLK_OUT_SDIV14_INDIV4_SHIFT        31
> -#define GPC2CLK_OUT_SDIV14_INDIV4_MODE 1
> +#define GPC2CLK_OUT_SDIV14_INDIV4_MODE 1U
>  #define GPC2CLK_OUT_VCODIV_WIDTH       6
>  #define GPC2CLK_OUT_VCODIV_SHIFT       8
>  #define GPC2CLK_OUT_VCODIV1            0
> --
> 2.43.0
>
>

--000000000000e01da80659f70697
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hi just pinging to see if anyone has had a chance to revi=
ew this patch. Thanks</div><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">10 A=C4=9Fu 2026 Pzt 22:42 tarih=
inde Muhammed Sariyildiz &lt;<a href=3D"mailto:asiyee994@gmail.com">asiyee9=
94@gmail.com</a>&gt; =C5=9Funu yazd=C4=B1:<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex">MASK(w) expands as ((1 &lt;&lt; (w)) - 1), and GPC2CLK_OUT_SDIV14_I=
NDIV4_MODE<br>
is defined as plain 1. Both are used, via GPC2CLK_OUT_INIT_MASK and<br>
GPC2CLK_OUT_INIT_VAL in gk20a_clk_prog() (and reused by gm20b, which<br>
includes gk20a.h), to compute:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 1 &lt;&lt; 31<br>
<br>
Left-shifting a signed int into its sign bit is undefined behaviour<br>
per the C standard (ISO C11 6.5.7p4), and is flagged by UBSan and<br>
static analysis tools such as cppcheck (shiftTooManyBitsSigned). Make<br>
the shifted operand unsigned to fix it, matching the pattern used<br>
elsewhere in the kernel for register bitfield masks.<br>
<br>
No functional change intended.<br>
<br>
Found via static analysis (cppcheck --enable=3Dportability) while<br>
auditing nvkm/subdev/clk for correctness issues.<br>
<br>
Signed-off-by: Muhammed Sariyildiz &lt;<a href=3D"mailto:asiyee994@gmail.co=
m" target=3D"_blank" rel=3D"noreferrer">asiyee994@gmail.com</a>&gt;<br>
---<br>
=C2=A0drivers/gpu/drm/nouveau/nvkm/subdev/clk/gk20a.h | 4 ++--<br>
=C2=A01 file changed, 2 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/gk20a.h b/drivers/gpu/=
drm/nouveau/nvkm/subdev/clk/gk20a.h<br>
index ea5b0ba..7a93f9f 100644<br>
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/gk20a.h<br>
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/gk20a.h<br>
@@ -27,7 +27,7 @@<br>
=C2=A0#define KHZ (1000)<br>
=C2=A0#define MHZ (KHZ * 1000)<br>
<br>
-#define MASK(w)=C2=A0 =C2=A0 =C2=A0 =C2=A0 ((1 &lt;&lt; (w)) - 1)<br>
+#define MASK(w)=C2=A0 =C2=A0 =C2=A0 =C2=A0 ((1U &lt;&lt; (w)) - 1)<br>
<br>
=C2=A0#define GK20A_CLK_GPC_MDIV 1000<br>
<br>
@@ -79,7 +79,7 @@<br>
=C2=A0#define GPC2CLK_OUT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 (SYS_GPCPLL_CFG_BASE + 0x250)<br>
=C2=A0#define GPC2CLK_OUT_SDIV14_INDIV4_WIDTH=C2=A0 =C2=A0 =C2=A0 =C2=A0 1<=
br>
=C2=A0#define GPC2CLK_OUT_SDIV14_INDIV4_SHIFT=C2=A0 =C2=A0 =C2=A0 =C2=A0 31=
<br>
-#define GPC2CLK_OUT_SDIV14_INDIV4_MODE 1<br>
+#define GPC2CLK_OUT_SDIV14_INDIV4_MODE 1U<br>
=C2=A0#define GPC2CLK_OUT_VCODIV_WIDTH=C2=A0 =C2=A0 =C2=A0 =C2=A06<br>
=C2=A0#define GPC2CLK_OUT_VCODIV_SHIFT=C2=A0 =C2=A0 =C2=A0 =C2=A08<br>
=C2=A0#define GPC2CLK_OUT_VCODIV1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
0<br>
-- <br>
2.43.0<br>
<br>
</blockquote></div>

--000000000000e01da80659f70697--
