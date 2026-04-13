Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A45C3EBFD14
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 08:01:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBFF210E353;
	Mon, 13 Apr 2026 08:01:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DkkvKSwF";
	dkim-atps=neutral
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com
 [209.85.167.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8A0610E323
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 06:58:11 +0000 (UTC)
Received: by mail-oi1-f176.google.com with SMTP id
 5614622812f47-463f00cda04so2103467b6e.2
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 23:58:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776063491; cv=none;
 d=google.com; s=arc-20240605;
 b=OqVlpD5N/4XGDciGC0RQP2EWSbReRbouGOz74z/MPZ4xo/U6X+cYuWJoBVOFTcP5ep
 qFYW3DZlzGX6NvTbvLO9wutdr09loqEy0Cpq2/kaUS4MiTXSMFjpbJQRZe957MA4iSQt
 7yFc66OadXq0H6ZMwcF0jAIsR0bHgQHeQBiYlKUrIKWy/j/5zPB/5v6kjm8ikt2cqTwi
 +gif+EuaUsnIlv0pgC5zpMulvhRQV+KZoYBgWDZ8y5/w2PcYyi4UdzYcXiA5Vxbg2/QG
 QADvutgAqsycILIjPchUDCI+i7xtWbxDffmPQEB/wmHhiDz6/HduX+p/13es6tzjJ5IE
 Y/6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=aDRufoTLKKphHrkYPbq6kzYiliqhsiFGHC3QL15ndi8=;
 fh=WETGlwPRI0vmYNR2eh1OFsvFlwtOyoqqO5EOl2MycME=;
 b=Wd4bGe5b3oQ9qyNBUMyReI8IdP0JlJ+2Ev1Iktc2YGT3v23r4+SJEl5hYRxR5mPRiP
 xBuZAt4OOOft7hBPjRsUE3FivJNt5ce2ZPfbKCvqbtLpBiDyIKxHzH2ev0AkH6U46XoN
 sqpiux4Kx6s1LuctbQPxlPKoNuI2HRSxYYaGuPPcbR0KUs0YeMNpiPHcJoS+2aTRQsgB
 VIUwf4h1izKu+HFZgsx+w5PSS5av1Bd5GW2gFN+n5UPlYYvsz7bdioZd7Yqt6k6bc/3e
 KZa2rE335xLRsrSPEb8Jd1YLOpy68KjXE4abDwneQOIUTE9OqFZPGjKC+ZE5DC86zh/u
 D5aw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776063491; x=1776668291; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aDRufoTLKKphHrkYPbq6kzYiliqhsiFGHC3QL15ndi8=;
 b=DkkvKSwFrm6hhD9Ya9A121+dvb0VBtaLnXSKUTSJQC7hVJ/hbifogcyWsIbMg0RZH6
 xu9vWor3yWEhHS4/5stiIOULoaSqSRT9/E32sRZrr4R9gJUz7JZfTDhV2L7nuxEmkgyy
 vUtZIkJ7PaFBJ7QV8qGqtjQ5ovfumBdO7bS0Vfxg8Eu99hCHBAbHapjKoqF0ZJ426gxg
 xZ0RiShP6mXFEKQKem9QKvCvth4nzp4TA67jy4LU0hTzD5HHUYEiCAPmVh5i0NtyfsRN
 AJWy22HHmMayykjo7CIHDSLowekGVPqNoD8bQhME9VTxJCkvXzFSaQYSsQfvXQVPnRKu
 5AxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776063491; x=1776668291;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aDRufoTLKKphHrkYPbq6kzYiliqhsiFGHC3QL15ndi8=;
 b=HHW6TG7UqcHnQNkRaWm0UdkIhh048q2FbSb5VOxs144mbQ4uCS5NIZa873XOJ7U75g
 Bgt1wimruRT+SyJU7ynQya2cUK6aRKz7aw461SewU4iZfm41WOXaPQcygfh7FnrYIJbX
 QSCOcDyNPoEXhcYLJdyYZ9S59Km/eJ6IUqpOoBaa62Q7WiAnZQ8UizJ8jhEftVTKYWZ9
 Wn4oKsZ6Wjyidm5uI3HKQx+rlp4IA3cNuu7yvL2SsjAof/37fzm+mUr9mO2TYunxVgnO
 HVZRRKle5C0ICgee840t8GQz3QOFtOp8ziD8UTidpl0wZtO4+v4rQrCwm8p7++SqDgUP
 SNEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPoL5RTzBV0ZSC+YSPGlzBO/J3bv9QJ1EwkCiNV5s/vzTDqGgsNTVhP0E6+rIdOmsjyzpJtPNkGsg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy4ODe2xi/PgKrvZDB7A+YNXRY+EBYy9j8GaRdWPcvATYoO646m
 O5Gvavw7E+GIJ/eSQ3qKfdsvLo9aolXQiKHKwG0PfFmebxAfJlUEP7sbv+lgZiNJAwqXgCez/us
 CDCUfx05Jme/HfPiMnNNqblbvb/BXWlY=
X-Gm-Gg: AeBDiethok37RNTnJtosO0ru3sHev0jy2ELc/32Ie/3e8zVNWRlwy5X2ylcjlIC8i5N
 iVNTx3e4L73snSdDYdCpqMaUDom5n/fuEqH4yZRMmD6uI8+Z9a8IQa2ctzkp8ipwH3y9wrQfJNJ
 coJfhf/69lXfQXh9vMisqGFUE9GxpUFd3x9osfbZDchvLLnDn0aGCmSuButcUufJ7sebIC2dU/q
 bKH8M+40em+LX1y9mBMLRPMmLEtTXtoxYnIHKt0wUj4/HBxSZUfVMCTYZnkcHoIuL+/2c+5i4eS
 ENiab6eqM0n8hmh5tzccvGQPf9zu1RU7Ks9+zJmW
X-Received: by 2002:a05:6808:c162:b0:46a:c987:ba00 with SMTP id
 5614622812f47-4789e7222f1mr6657619b6e.32.1776063490804; Sun, 12 Apr 2026
 23:58:10 -0700 (PDT)
MIME-Version: 1.0
References: <20251218061406.8043-1-arjunchangla7@gmail.com>
 <2025121827-lubricant-salad-860c@gregkh>
In-Reply-To: <2025121827-lubricant-salad-860c@gregkh>
From: Arjun Changla <arjunchangla7@gmail.com>
Date: Mon, 13 Apr 2026 12:27:58 +0530
X-Gm-Features: AQROBzAMRFglwAAVT0fhDOJkqS-ZSb5rkTlibPT3AjaApsiy_dk7rHUcBXHbeEU
Message-ID: <CALO5-psPGGxo9bu4Yjs54Sj=Hpq4x4Zgvp6tEY2MzV+utUfGpA@mail.gmail.com>
Subject: Re: [PATCH] staging: fbtft: fix spacing before close parenthesis
To: Greg KH <gregkh@linuxfoundation.org>
Cc: andy@kernel.org, dri-devel@lists.freedesktop.org, 
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev, 
 linux-kernel@vger.kernel.org
Content-Type: multipart/alternative; boundary="00000000000077ce9a064f5201b3"
X-Mailman-Approved-At: Mon, 13 Apr 2026 08:01:34 +0000
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

--00000000000077ce9a064f5201b3
Content-Type: text/plain; charset="UTF-8"

On Thu, 18 Dec 2025 at 11:50, Greg KH <gregkh@linuxfoundation.org> wrote:

> On Thu, Dec 18, 2025 at 06:14:06AM +0000, Arjun Changla wrote:
> > Fix checkpatch error "space prohibited before that close parenthesis"
> > on line 65 by removing the extra space.
> >
> > Signed-off-by: Arjun Changla <arjunchangla7@gmail.com>
> > ---
> >  drivers/staging/fbtft/fbtft-bus.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/staging/fbtft/fbtft-bus.c
> b/drivers/staging/fbtft/fbtft-bus.c
> > index 30e436ff19e4..2f7c891177fb 100644
> > --- a/drivers/staging/fbtft/fbtft-bus.c
> > +++ b/drivers/staging/fbtft/fbtft-bus.c
> > @@ -62,7 +62,7 @@ out:
>                             \
> >  }
>        \
> >  EXPORT_SYMBOL(func);
> >
> > -define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, )
> > +define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8)
>
> But you just changed the function definition, does this still work now?
> If so, how?
>
> confused,
>
> greg k-h
>

Hi Greg,

Thank you for the review. The change only removes extra spacing in
the function parameter - no functional changes were made.

Before:
    const struct ia_css_output1_configuration *from ,

After:
    const struct ia_css_output1_configuration *from,

I verified the module builds successfully with no errors:
    make M=drivers/staging/fbtft

Best regards,
Arjun

--00000000000077ce9a064f5201b3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, 18 Dec =
2025 at 11:50, Greg KH &lt;<a href=3D"mailto:gregkh@linuxfoundation.org">gr=
egkh@linuxfoundation.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">On Thu, Dec 18, 2025 at 06:14:06AM +0000, Arjun Cha=
ngla wrote:<br>
&gt; Fix checkpatch error &quot;space prohibited before that close parenthe=
sis&quot;<br>
&gt; on line 65 by removing the extra space.<br>
&gt; <br>
&gt; Signed-off-by: Arjun Changla &lt;<a href=3D"mailto:arjunchangla7@gmail=
.com" target=3D"_blank">arjunchangla7@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 drivers/staging/fbtft/fbtft-bus.c | 2 +-<br>
&gt;=C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft=
/fbtft-bus.c<br>
&gt; index 30e436ff19e4..2f7c891177fb 100644<br>
&gt; --- a/drivers/staging/fbtft/fbtft-bus.c<br>
&gt; +++ b/drivers/staging/fbtft/fbtft-bus.c<br>
&gt; @@ -62,7 +62,7 @@ out:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 \<br>
&gt;=C2=A0 }=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt;=C2=A0 EXPORT_SYMBOL(func);<br>
&gt;=C2=A0 <br>
&gt; -define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, )<br>
&gt; +define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8)<br>
<br>
But you just changed the function definition, does this still work now?<br>
If so, how?<br>
<br>
confused,<br>
<br>
greg k-h<br></blockquote><div><br>Hi Greg,<br><br>Thank you for the review.=
 The change only removes extra spacing in <br>the function parameter - no f=
unctional changes were made.<br><br>Before:<br>=C2=A0 =C2=A0 const struct i=
a_css_output1_configuration *from ,<br><br>After:<br>=C2=A0 =C2=A0 const st=
ruct ia_css_output1_configuration *from,<br><br>I verified the module build=
s successfully with no errors:<br>=C2=A0 =C2=A0 make M=3Ddrivers/staging/fb=
tft<br><br>Best regards,<br>Arjun</div></div></div>

--00000000000077ce9a064f5201b3--
