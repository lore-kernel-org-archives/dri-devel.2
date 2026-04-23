Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 168C5FB44C8
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 07:44:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1831E10F341;
	Fri, 24 Apr 2026 07:44:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="sLxkb1tf";
	dkim-atps=neutral
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com
 [209.85.208.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1700010E508
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 11:23:33 +0000 (UTC)
Received: by mail-ed1-f49.google.com with SMTP id
 4fb4d7f45d1cf-6715594a4c2so7706236a12.1
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 04:23:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776943411; cv=none;
 d=google.com; s=arc-20240605;
 b=davB3/CbbBBMnmW5/oJRxtPDbiYjbbAOd92+PaeUdS96j9U88C77KgTS+Y/T21+YC2
 W3iThxltY4fGi+hFYWnsrHa0zkd3fTsWeLS7bRlCu54e+6BjY9XvU68FQAUA6v41qYIZ
 82gxmq+QAqA4dX6CUMMqHGJXBeilzSSiIIbc8aJ/Yy9YUkKDdePkNGFRxtXBo8Iv+Gnx
 yCyoGW7jDR/V6gVwMOYSQilnLh3/GFyxpxipewwDwkAJJzsAnvz+MXW3osrj3Y6GjfUC
 8qLvhhrhPHukCcMXEfZrO0L/6TTLGgTmR1C03CnOobZHjdZTBZQK62kR+mAWqvFiv3BV
 N+dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=0OkEIbGlB3GcNFg5Q+iZeLsoIkULwvess9FRksH0T9s=;
 fh=lcqRZqUhitNeGjPDOQGHfeUmJJkrClX6ISpDs50fVtc=;
 b=Pd83gFqZprvCOxOZ0pBFkEQFbf79kDLfauwMD8+5Cdj49ja78PSmF9Z8Cev/jrfGpF
 OZTcCVt2kl3fbXVnd4UFe/WYNv4gy6nFnMyfMOYwIuh34lbEGFzUJiqqSAjMdHeX+W+Y
 +g2tE7YfAFLDq8SZGPL+mmDjGWDo2c29F02YXMGE9IQLd1HxFUVRXBxlSLCY1syI+yZl
 UOzPKr+R5Dw0o/lJJeUcLu7aba/OnYkmLsObSBYcbl6fDolb5ezpMZsFND3HjEL8ys96
 oX5LVNfK7RD3SdoMflja7sPs+WohNEdoPuMSFMO+QQKZVWQ6fprFzw1muBayD+znSZXs
 RUwA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776943411; x=1777548211; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0OkEIbGlB3GcNFg5Q+iZeLsoIkULwvess9FRksH0T9s=;
 b=sLxkb1tfTfsu73d8oYqzAoHluFlO2ZlljV6BcKxGy6ZSsJMoja5mjwup39o1ELQbkl
 cyCeHkQwQr8ENLzC4/Lj35Y2bmbEpmGfmAFETxok1KjklT7v9OqKTEJdKcBaFTLFh4J0
 g7UaETPnQD2W8iZR35HGoQ7ryr/1VOIGclW+igkl/Yydm2R86pdZ0LQPLJdoOA7prv2C
 YNNs8k+8kx1y9ak3U9URaVo3HYvHe2rIcSSgDBNC+b7rgJPvDZD8YPqHQ29aMLyh3HPZ
 +ZIVxv4MOTfj/LzxmcrcerCkWprlzAbzv/ZYfQ7sLAYn0sNmHeqgyqtChf8KBhDDs4vI
 1ivA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776943411; x=1777548211;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0OkEIbGlB3GcNFg5Q+iZeLsoIkULwvess9FRksH0T9s=;
 b=RFTO7ULUCyUwRQ1Dx1Why8yS6tLSlVPdmSlXy0drWsU/ITIsYJNAv13os7DT9zhLd/
 uHf/r2ctmY+Qo5CKXa86mPW+bJSPRZPzb5dG0dEYYl0VkLgaUY4v/RAFEeClCk7WhUVs
 SxukZDF66ZdODGk6ptuV3BCLqCkga18qN6KogRWygnOqnNTKKJA1NJUEk2K3L3vx9paX
 JFpONMdCs5dMqc1jdfAh5cXJmKxkYT7RbNbAZrpMPuzTaS1irrkwqxP+NeOj5bogL0Gp
 EQ8tocuf9hgJoyCL1V9Ghuo/Za8e8pxyYPv+N+iMlGxOr7BH+T74ULdX7cwrbmGrhDzk
 HO4Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ82Q+8OjRsWGLJM2MWvxrDit+PUPhg66XFpCWhkDHlNsl/fxpHrK/tE6WdPcAgA74x7IAd2APwaZn4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzGtqVDVvyCLf+oSAE3N0+iKFmO9YODt9MeSsqCliLz8gPxuEcp
 m04P6jmy6F/fv/ZTZXWjXJQ/jLntSeHEuHQNPF38g3rjriK472BpPwWA05z/+g7uW2NtyYOT2zG
 Dm/0fiX0oe86TF62S1AtllSGx979bjg==
X-Gm-Gg: AeBDiev2MCgjuz8UHJqnUQDu7+f98qWjwNZeMgiZ0WV4lOme4mA9zSgtfAJJRE/tkUL
 vjAmcd92hiocCf5VwgLe73g0QpNXQbDNKGP9nr+KJA+OtX84fIFQgfXbRSxqwoj9ca+VClUJIsH
 1c6Uheb2OkZCFc6rvAlrcT16JYIf4WrPRPYDjiiIBvd/QXZYEqXEjJ/0oDDbT+bNsJNWTRTkiZN
 uKOhJZai4vn6ipd3yApri8Wt8MXaCCLENnVNuJkwaIFf77sZCbUOjbeURl0siTKuOh/mYAa1TVG
 fwgkjeeSDXaMBhDiNEceA553gWn4iCMqAMTh/K6dNapAUqu6yANSQU7KKw==
X-Received: by 2002:a05:6402:1ecd:b0:674:c412:6f8a with SMTP id
 4fb4d7f45d1cf-674c4127d49mr8483895a12.26.1776943411076; Thu, 23 Apr 2026
 04:23:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260420065305.8781-1-mhun512@gmail.com>
 <wdowo2jgsbs2dlz3rgzmufhernybag67vovoyfg66byszseur3@mbqgtbbh2rfi>
In-Reply-To: <wdowo2jgsbs2dlz3rgzmufhernybag67vovoyfg66byszseur3@mbqgtbbh2rfi>
From: Myeonghun Pak <mhun512@gmail.com>
Date: Thu, 23 Apr 2026 20:23:16 +0900
X-Gm-Features: AQROBzDui77hYAXdzkMpjLahYpCmYI-f6zn0J6BBCyLFeHbDovywTFobIhiBCH8
Message-ID: <CAGEsz8Gsv7u_sgfwgjqT0rtULSVLFRvM_30AvaZ0-e+RKbvwYQ@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: jdi-fhd-r63452: remove panel on DSI attach
 failure
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Ijae Kim <ae878000@gmail.com>, Taegyu Kim <tmk5904@psu.edu>,
 Yuho Choi <dbgh9129@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000cda35506501ee06c"
X-Mailman-Approved-At: Fri, 24 Apr 2026 07:44:43 +0000
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

--000000000000cda35506501ee06c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dmitry,

Thank you for the review.

As you pointed out, I will group the similar patches into a single series
for submission.

I also agree that using devm_drm_panel_add() is a better approach for
cleaning up the code. I will re-work the next version to apply this managed
resource API.

Thanks,

Myeonghun Pak


2026=EB=85=84 4=EC=9B=94 23=EC=9D=BC (=EB=AA=A9) =EC=98=A4=EC=A0=84 4:25, D=
mitry Baryshkov <
dmitry.baryshkov@oss.qualcomm.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:

> On Mon, Apr 20, 2026 at 03:52:15PM +0900, Myeonghun Pak wrote:
> > The probe path calls drm_panel_add() before mipi_dsi_attach().
> >
> > If mipi_dsi_attach() fails, the driver returns without calling
> >
> > drm_panel_remove(), leaving the panel registered in the global DRM
> > panel list. The driver's .remove() callback does not handle this case
> > because failed probe does not transition through the normal bound-devic=
e
> > removal path.
> >
> > Fix this by unwinding drm_panel_add() when mipi_dsi_attach() fails.
> >
> > Co-developed-by: Ijae Kim <ae878000@gmail.com>
> > Signed-off-by: Ijae Kim <ae878000@gmail.com>
> > Co-developed-by: Taegyu Kim <tmk5904@psu.edu>
> > Signed-off-by: Taegyu Kim <tmk5904@psu.edu>
> > Co-developed-by: Yuho Choi <dbgh9129@gmail.com>
> > Signed-off-by: Yuho Choi <dbgh9129@gmail.com>
> > Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> > ---
> >  drivers/gpu/drm/panel/panel-jdi-fhd-r63452.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
>
> Please group similar pathces in a single series. There is
> devm_drm_panel_add() in drm-misc-next.
>
> --
> With best wishes
> Dmitry
>

--000000000000cda35506501ee06c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div role=3D"listitem" class=3D"gmail-NA2Vme" style=3D"dis=
play:flex;color:rgb(208,194,168);font-family:&quot;Google Sans&quot;,Roboto=
,Arial,sans-serif;font-size:15.75px"><div dir=3D"auto" class=3D"gmail-pA4Vn=
f" style=3D"font-variant-ligatures:no-contextual;font-feature-settings:&quo=
t;liga&quot; 0;display:flex;word-break:break-word;font-size:0.875rem;letter=
-spacing:0px;line-height:1.5rem"><div><div><span class=3D"gmail-rnc2Gd" sty=
le=3D"mask-repeat: no-repeat;">Dmitry,</span><div class=3D"gmail-gWqWw gmai=
l-rnc2Gd" style=3D"mask-repeat: no-repeat;"><br></div><span class=3D"gmail-=
rnc2Gd" style=3D"mask-repeat: no-repeat;">Thank you for the review.</span><=
div class=3D"gmail-gWqWw gmail-rnc2Gd" style=3D"mask-repeat: no-repeat;"><b=
r></div><span class=3D"gmail-rnc2Gd" style=3D"mask-repeat: no-repeat;">As y=
ou pointed out, I will group the similar patches into a single series for s=
ubmission.</span><div class=3D"gmail-gWqWw gmail-rnc2Gd" style=3D"mask-repe=
at: no-repeat;"><br></div><span class=3D"gmail-rnc2Gd" style=3D"mask-repeat=
: no-repeat;">I also agree that using=C2=A0</span><code class=3D"gmail-dfqO=
Jc" style=3D"display:inline-block;background-color:rgb(65,62,55);border-rad=
ius:4px;color:rgb(186,173,149);padding:1px 4px;font-size:0.75rem;letter-spa=
cing:0.00625rem;line-height:1rem;font-family:&quot;Google Sans Mono&quot;,m=
onospace;white-space:pre-wrap;margin:unset">devm_drm_panel_add()</code><spa=
n class=3D"gmail-rnc2Gd" style=3D"mask-repeat: no-repeat;">=C2=A0is a bette=
r approach for cleaning up the code. I will re-work the next version to app=
ly this managed resource API.</span><div class=3D"gmail-gWqWw gmail-rnc2Gd"=
 style=3D"mask-repeat: no-repeat;"><br></div><span class=3D"gmail-rnc2Gd" s=
tyle=3D"mask-repeat: no-repeat;">Thanks,</span><div class=3D"gmail-gWqWw gm=
ail-rnc2Gd" style=3D"mask-repeat: no-repeat;"><br></div><span class=3D"gmai=
l-rnc2Gd" style=3D"mask-repeat: no-repeat;">Myeonghun Pak</span></div></div=
></div><div class=3D"gmail-im7IW" style=3D"display:flex;padding:8px 0px"><d=
iv class=3D"gmail-fnyTGe" style=3D"display:flex;white-space:nowrap"><button=
 class=3D"gmail-mUIrbf-I gmail-mUIrbf-I-ql-JX-O gmail-mUIrbf-bHf-YYd4I-Zb g=
mail-mUIrbf-kSE8rc-FoKg4d-a2N-YoZ4jf gmail-MSXFwe" style=3D"display:inline-=
flex;border-width:medium;border-style:none;border-color:currentcolor;outlin=
e:none;background-image:initial;background-position:initial;background-size=
:initial;background-repeat:initial;background-origin:initial;background-cli=
p:initial;line-height:inherit;vertical-align:middle;margin:0px"></button><b=
utton class=3D"gmail-mUIrbf-I gmail-mUIrbf-I-ql-JX-O gmail-mUIrbf-bHf-YYd4I=
-Zb gmail-mUIrbf-kSE8rc-FoKg4d-a2N-YoZ4jf gmail-MSXFwe" style=3D"display:in=
line-flex;border-width:medium;border-style:none;border-color:currentcolor;o=
utline:none;background-image:initial;background-position:initial;background=
-size:initial;background-repeat:initial;background-origin:initial;backgroun=
d-clip:initial;line-height:inherit;vertical-align:middle;margin:0px"></butt=
on><div class=3D"gmail-tB5Jxf-M-X-ql-Jf" style=3D"overflow:visible"><div><b=
utton class=3D"gmail-pYTkkf-JX-I gmail-pYTkkf-JX-I-ql-ay5-ays gmail-wGrQ1e"=
 aria-label=3D"=EC=B6=94=EA=B0=80 =EC=98=B5=EC=85=98" style=3D"background-i=
mage:initial;background-position:initial;background-size:initial;background=
-repeat:initial;background-origin:initial;background-clip:initial;border-wi=
dth:medium;border-style:none;border-color:currentcolor;display:flex;line-he=
ight:inherit;outline:none;color:rgb(186,173,149)"></button></div><div></div=
></div></div><div class=3D"gmail-QFhkkc" style=3D"display:flex"><button cla=
ss=3D"gmail-pYTkkf-JX-I gmail-pYTkkf-JX-I-ql-ay5-ays gmail-wGrQ1e" aria-lab=
el=3D"=EB=B6=88=EB=A7=8C=EC=A1=B1=EC=8A=A4=EB=9F=AC=EC=9A=B4 =EB=8C=80=EB=
=8B=B5" style=3D"background-image:initial;background-position:initial;backg=
round-size:initial;background-repeat:initial;background-origin:initial;back=
ground-clip:initial;border-width:medium;border-style:none;border-color:curr=
entcolor;display:flex;line-height:inherit;outline:none;color:rgb(186,173,14=
9)"><br></button></div></div></div></div><br><div class=3D"gmail_quote gmai=
l_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">2026=EB=85=84 4=EC=
=9B=94 23=EC=9D=BC (=EB=AA=A9) =EC=98=A4=EC=A0=84 4:25, Dmitry Baryshkov &l=
t;<a href=3D"mailto:dmitry.baryshkov@oss.qualcomm.com">dmitry.baryshkov@oss=
.qualcomm.com</a>&gt;=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">On Mon, Apr 20, 2026 at 03:52:1=
5PM +0900, Myeonghun Pak wrote:<br>
&gt; The probe path calls drm_panel_add() before mipi_dsi_attach().<br>
&gt; <br>
&gt; If mipi_dsi_attach() fails, the driver returns without calling<br>
&gt; <br>
&gt; drm_panel_remove(), leaving the panel registered in the global DRM<br>
&gt; panel list. The driver&#39;s .remove() callback does not handle this c=
ase<br>
&gt; because failed probe does not transition through the normal bound-devi=
ce<br>
&gt; removal path.<br>
&gt; <br>
&gt; Fix this by unwinding drm_panel_add() when mipi_dsi_attach() fails.<br=
>
&gt; <br>
&gt; Co-developed-by: Ijae Kim &lt;<a href=3D"mailto:ae878000@gmail.com" ta=
rget=3D"_blank">ae878000@gmail.com</a>&gt;<br>
&gt; Signed-off-by: Ijae Kim &lt;<a href=3D"mailto:ae878000@gmail.com" targ=
et=3D"_blank">ae878000@gmail.com</a>&gt;<br>
&gt; Co-developed-by: Taegyu Kim &lt;<a href=3D"mailto:tmk5904@psu.edu" tar=
get=3D"_blank">tmk5904@psu.edu</a>&gt;<br>
&gt; Signed-off-by: Taegyu Kim &lt;<a href=3D"mailto:tmk5904@psu.edu" targe=
t=3D"_blank">tmk5904@psu.edu</a>&gt;<br>
&gt; Co-developed-by: Yuho Choi &lt;<a href=3D"mailto:dbgh9129@gmail.com" t=
arget=3D"_blank">dbgh9129@gmail.com</a>&gt;<br>
&gt; Signed-off-by: Yuho Choi &lt;<a href=3D"mailto:dbgh9129@gmail.com" tar=
get=3D"_blank">dbgh9129@gmail.com</a>&gt;<br>
&gt; Signed-off-by: Myeonghun Pak &lt;<a href=3D"mailto:mhun512@gmail.com" =
target=3D"_blank">mhun512@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 drivers/gpu/drm/panel/panel-jdi-fhd-r63452.c | 1 +<br>
&gt;=C2=A0 1 file changed, 1 insertion(+)<br>
&gt; <br>
<br>
Please group similar pathces in a single series. There is<br>
devm_drm_panel_add() in drm-misc-next.<br>
<br>
-- <br>
With best wishes<br>
Dmitry<br>
</blockquote></div>

--000000000000cda35506501ee06c--
