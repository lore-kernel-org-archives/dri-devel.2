Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13001FB44CA
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 07:45:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E6C410F399;
	Fri, 24 Apr 2026 07:44:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PoZ+q6Ba";
	dkim-atps=neutral
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com
 [209.85.218.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA6F410E508
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 11:25:16 +0000 (UTC)
Received: by mail-ej1-f53.google.com with SMTP id
 a640c23a62f3a-b932fe2e1a7so82687166b.1
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 04:25:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776943515; cv=none;
 d=google.com; s=arc-20240605;
 b=V1fdHCSWOCcTe01fgM/8h9nS0ZZ2laIQZ0/5+d1zdXET0rJsHy0EqCeLuc5G/YT2OI
 sn6gKkYYsH7h5ooGPHSVBU8tsAzTegoJCAeD3aqgJz3eeLTkN6v1CiFubB5rrBKnoouC
 82m5Vd/zj/Ryn3L7H4bK4QIV7+/PKdmtDceFQxAukh1YMQNaMCOwQVy5wbivT2MQ9dey
 PXHAyE23h9Y29NC1AUuulTmVRie+HWXGhmW3QvGh/PrP+5egTP8nIe7/XMmaSUnB4W5M
 FzFrxRku+JRTeY4oM3YaEyL62HkHO99qC0jZTJoBz9OW/oWuAfJY3Iv8B8uRxm6exg3h
 vQhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=VhHwF8uTe87PcS3rN02SDEGAKym5cX+QHbfVkZ05VKM=;
 fh=cXSKyNO6Q6cKfSFR5jIopy/9FqZHqXteGyVIjbUfbGw=;
 b=V1FuabyafuILtTC28vcOg7U8mnx6GLjgDDMQPUIw6PhYMiaNTNqbo7MPDUZVieJqat
 TXtrrkz0guEAkRIuEWq9E45P+jIRtqpl1XN2uFp57E2LWUJjjed6iQ3QYVPyOLOT82K3
 kIUqGgdtM5UqQ1Tyzab8aGj3qQKE/Y+Y/a4j5/fu+3fgTA92qBPkV+Vz0wSU/q+zsa4J
 MA2CzyrEB0LcC9bIy+Bqr8EXIthGfiYLjO2ha+IdnXrhqvZhPsltcsLNW21UzYODH/L+
 7J1ZfKrdUEXiK4Gfj9TDlaZ6xfr3OIggHznzmd5wKG0vv/FdwlCafIv3WAQ66Vx6tP2q
 UZNg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776943515; x=1777548315; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VhHwF8uTe87PcS3rN02SDEGAKym5cX+QHbfVkZ05VKM=;
 b=PoZ+q6BauHBVvVVvpGlwpKnOfCXpetQaQqsvJU2y82XZvR4BpEIFNyDnP2eX2NrUXj
 JsKMpDJ/dcVp9nVfEi/QFJGHwl7j4XUxp4pRhGOTcU2S7hM0PmRKq5J2IlaDDkziwNTI
 56lBuT4BrNuMB9fo7lLk5Hzxg+OFRxjdMidvj7C9XjXAbwSSJfo7izcrsWuQA5/CNqnY
 sCMwJfgrv8CmX4b7qZ502t9EmbGWAMNbDK9dJREjcpj/vrC8mhh06uaXfbv5x/vTzTj5
 OEBdvuG3HLLvNfT0g3yDVUBgBetNY7dSWtSokZD2klpqGj1hQ0VEVu1eKBe6LkVtEs+j
 NbQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776943515; x=1777548315;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VhHwF8uTe87PcS3rN02SDEGAKym5cX+QHbfVkZ05VKM=;
 b=P/jacUYx8OlrqPttynZHNfM4raRxL+qBiomGiTpv4iThq37bpiJzoITCq+1zq0RBrQ
 jkTCaQ4IhPrLYX9L3BzkCEevcNuxpPnIQg3BsLvIffWO1C54Nii9jktbHkyXjFob1N2Z
 7VL5aUJUfGtAsMFv8+JtgcbJrAaIAfX6GpZD22JGgmY0fBPoAjWvs5jCERRtr3/MKgro
 cDaAqHVQpU60Jy21oes8PBRbDppcVZIvam9djkfyElU3n34rOj08Vtnx5LiCM9xJ0RNO
 gWLhhd4PGUy7Fqjo15B6mHZXrGg1iU1wOPBZiwDt0ZiYAeajZcBDhdYlZ9tacMq0NAbp
 ufug==
X-Forwarded-Encrypted: i=1;
 AFNElJ+WXaN/mQfvjUwFese5qI5uFko3X7cQXKGDTPv6hrza9CKBQBwvrdjMstZLGHBZUsuVKizmsgFMwn8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy6fJlSA3cGdBxL5GsSg3E8LprTCrkpEVsfx7mRe5fYdlCYwNSA
 AlX8JZCoPhYVHxMdoDo2CpuHtdo6aL01GirVq40xlQQIUFMUyTUNqkfUvwbUkFUZzay+eS5FkG8
 BAl+rg8xFEB6Z6AwnwWejxxhnFM1YCA==
X-Gm-Gg: AeBDievrbC3RQy67/IQd8Vfanl1VIYiPGm7LjNbGhldEZSPtwyE4dGM93FacIIs43FF
 BcQqs9LKcZrQHplepecAi0VaLLxaKsyiKK5gfpHATLkMIRNbqVQBLQWjSET71XQO/05Ci2nOHso
 OtRP48WAtR4tgCC6S1qd1xWIbcvWE1plQjjGE/bjDtAxmBevbbVAt2t/04IbBrQVwgkTUtWltQs
 NzsugU5t7OcnqcK7bNMZH5UYh8kFdjntvhNSFqgfNpdkxNp2Lqy+zs5WNPlHkJicWIEq+fG3YWR
 +6llLJ3jT8OD80Xl6GUWAfju6NjUBHf2E58GSbFiBjA+udo=
X-Received: by 2002:a17:907:72c5:b0:ba5:bef2:2aa9 with SMTP id
 a640c23a62f3a-ba5bef2333fmr1114513566b.35.1776943515065; Thu, 23 Apr 2026
 04:25:15 -0700 (PDT)
MIME-Version: 1.0
References: <casey.connolly@linaro.org>
 <20260420073945.65849-1-mhun512@gmail.com>
 <3ihxcwja3unx2257xbbk2e2aeiptb42bjkti6xnipwnvzrigw5@mhjhwckbyr2s>
In-Reply-To: <3ihxcwja3unx2257xbbk2e2aeiptb42bjkti6xnipwnvzrigw5@mhjhwckbyr2s>
From: Myeonghun Pak <mhun512@gmail.com>
Date: Thu, 23 Apr 2026 20:25:03 +0900
X-Gm-Features: AQROBzBC1fFL9FaIZnJVFPFemTRJQcxejs8oYq-k1APp1i7H7nRb2Tl3rnK5n-A
Message-ID: <CAGEsz8EH6RoSh-OGzSkFse=saaupH2vbSB=VsQd0ZvVb7VO3jw@mail.gmail.com>
Subject: Re: [PATCH v1] drm/panel: lg-sw43408: remove panel on DSI attach
 failure
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Ijae Kim <ae878000@gmail.com>, Taegyu Kim <tmk5904@psu.edu>,
 Yuho Choi <dbgh9129@gmail.com>
Content-Type: multipart/alternative; boundary="00000000000000617d06501ee7f5"
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

--00000000000000617d06501ee7f5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dmitry, Understood. I will apply devm_drm_panel_add() to this patch as well
in the next version, which will be submitted as part of the series. Thanks,
Myeonghun Pak

2026=EB=85=84 4=EC=9B=94 23=EC=9D=BC (=EB=AA=A9) =EC=98=A4=EC=A0=84 4:24, D=
mitry Baryshkov <
dmitry.baryshkov@oss.qualcomm.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:

> On Mon, Apr 20, 2026 at 04:38:27PM +0900, Myeonghun Pak wrote:
> > The probe path registers the panel by calling drm_panel_add() in
> > sw43408_add(), then returns the result of mipi_dsi_attach() directly
> > from sw43408_probe().
> >
> > If mipi_dsi_attach() fails, the probe path exits without calling
> > drm_panel_remove(), leaving the panel registered in the global DRM
> > panel list. The .remove() callback does not cover this case because
> > it is only invoked after a successful probe.
> >
> > Fix this by unwinding the panel registration with drm_panel_remove()
> > when mipi_dsi_attach() fails.
> >
> > Co-developed-by: Ijae Kim <ae878000@gmail.com>
> > Signed-off-by: Ijae Kim <ae878000@gmail.com>
> > Co-developed-by: Taegyu Kim <tmk5904@psu.edu>
> > Signed-off-by: Taegyu Kim <tmk5904@psu.edu>
> > Co-developed-by: Yuho Choi <dbgh9129@gmail.com>
> > Signed-off-by: Yuho Choi <dbgh9129@gmail.com>
> > Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> > ---
> >  drivers/gpu/drm/panel/panel-lg-sw43408.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
>
> You can also switch to devm_drm_panel_add().
>
> --
> With best wishes
> Dmitry
>

--00000000000000617d06501ee7f5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><span style=3D"color:rgb(31,31,31);font-family:&quot;Googl=
e Sans&quot;,Roboto,Arial,sans-serif;font-size:18px;font-variant-ligatures:=
no-contextual;white-space:pre-wrap">Dmitry,

Understood. I will apply devm_drm_panel_add() to this patch as well in the =
next version, which will be submitted as part of the series.

Thanks,

Myeonghun Pak</span></div><br><div class=3D"gmail_quote gmail_quote_contain=
er"><div dir=3D"ltr" class=3D"gmail_attr">2026=EB=85=84 4=EC=9B=94 23=EC=9D=
=BC (=EB=AA=A9) =EC=98=A4=EC=A0=84 4:24, Dmitry Baryshkov &lt;<a href=3D"ma=
ilto:dmitry.baryshkov@oss.qualcomm.com">dmitry.baryshkov@oss.qualcomm.com</=
a>&gt;=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">On Mon, Apr 20, 2026 at 04:38:27PM +0900, Myeo=
nghun Pak wrote:<br>
&gt; The probe path registers the panel by calling drm_panel_add() in<br>
&gt; sw43408_add(), then returns the result of mipi_dsi_attach() directly<b=
r>
&gt; from sw43408_probe().<br>
&gt; <br>
&gt; If mipi_dsi_attach() fails, the probe path exits without calling<br>
&gt; drm_panel_remove(), leaving the panel registered in the global DRM<br>
&gt; panel list. The .remove() callback does not cover this case because<br=
>
&gt; it is only invoked after a successful probe.<br>
&gt; <br>
&gt; Fix this by unwinding the panel registration with drm_panel_remove()<b=
r>
&gt; when mipi_dsi_attach() fails.<br>
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
&gt;=C2=A0 drivers/gpu/drm/panel/panel-lg-sw43408.c | 8 +++++++-<br>
&gt;=C2=A0 1 file changed, 7 insertions(+), 1 deletion(-)<br>
&gt; <br>
<br>
You can also switch to devm_drm_panel_add().<br>
<br>
-- <br>
With best wishes<br>
Dmitry<br>
</blockquote></div>

--00000000000000617d06501ee7f5--
