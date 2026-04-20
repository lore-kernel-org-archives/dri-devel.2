Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12594F327B3
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 07:10:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A930010EB91;
	Tue, 21 Apr 2026 07:10:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="maxC/etm";
	dkim-atps=neutral
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com
 [209.85.210.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7549110E4E4
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 11:06:11 +0000 (UTC)
Received: by mail-ot1-f47.google.com with SMTP id
 46e09a7af769-7dbcd61429cso1454095a34.2
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 04:06:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776683170; cv=none;
 d=google.com; s=arc-20240605;
 b=Lmrd/RxrFgYqEci4uSuDo7DXgVYfVACmOMVoRUlgjhOWO1uaufJEzyzf6/3YWf0fc+
 rEdTUUcnGPr7mf8hsmh+wCl4Wk2y9IK5bHUyPtfJboZhwNOESSoi3+TZGNoQSuVc3HfQ
 UHrytOlbjqIf2wTsvPkTQ+5v9rkn8A5QWDzkuNtu+ulNpE9ooLjLHRaM4NoailG3FyhU
 dE2V3kBMu6iWml6o7DsGvivBYJgza9KxvS/r82IB9j73IgP880bWJpGkqXHCFN8chIPk
 frWpIFagu12d+0TyGdOPG7fQ9T1xeB+SRJ7hwjXTTrvq8Ii8RJIVH/p8CcskduGgdDwU
 C50w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=xSGl+dRNlq8AXEBpVGZXuh/47/XTWNWLR0KCU9fa9UU=;
 fh=aeNlINh2qw2zV9nydrlC4tko9gwRkLVQ3QpafPf1WFE=;
 b=cFccVlPBUDcieP5uRRHTrbBcvSePcTO58YMmqytusf+lX8b9l6Wp4d3DewuL6OQZWe
 hRyVdfO5fZv08KqSLaxXjtJUZzuAAuBAKazJtdrgrbWnV0qeFFeUeLuLbLEEEGzh34hu
 /+/EI235aDRGx8LnsFSLQ/+lzZsdh2FIjLoNDJA1KFaT9h8guvJFVsh/KnAT/6qtA2th
 bljwEumchm6pLfJZGT4urRLku5GcQTHhAmt7T62O53lVM/E1XJFnqfjk5IiHSdArGkgs
 dksASB3VnTOqmjMOakl8kQZTQ8zAzfN7Pvd5iTczgvgYYLJAnU+yUmsF9YkpxUvnAgKj
 IPHw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776683170; x=1777287970; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xSGl+dRNlq8AXEBpVGZXuh/47/XTWNWLR0KCU9fa9UU=;
 b=maxC/etmgzXYhujXNlLItu7DjYFZqMvbaKv2Rj+aB53Zcgj3Vqu5M2amNg5P3mx34P
 JTgpDIlNBK41/ns/jAxVPNILLHiPfwGuQzMEs26tzfJ5FNkkKN+0RNbz7yu2FTwrMpw4
 0kQUijMijnTxuKrGuEEZf5EgP+EImA9eMTSrMIhb5aI1FreRcLP3hN6Mo27ooi9mf7fb
 vjb5XwCAjWrZCqYBd1uPtn6FiMWCudYJvxj6yuy+sOXkE6Rx83iMdIE0gTk1HNA2Ypb2
 Fj/Gr+abVuoI2vAJr+ZfynNQq20o5ZlacNtYyp8YRGal6IWP7D5laqmI2NIoEXTOn8w6
 URmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776683170; x=1777287970;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xSGl+dRNlq8AXEBpVGZXuh/47/XTWNWLR0KCU9fa9UU=;
 b=Oo0Rp3Dmmv/Xz7ADQ4zer2KemknQo80WRxfDOjIuE2Kh46prLN2+B4GmdRGLGTUdiS
 2WLsCq3GetaiYRoNR62SZ1kJuNVpoeZu11PDuYLGCdsMpUaw7dSwt3ZyGWjUKy4p16Fe
 C/y0MpmFMjVNmk+xYLPDX6vFaHT/j+Is2PKUYmTYcwxXOvmiJ1jgFK5HCEG4Qs/w7egh
 YYr9vzXXm34CtQpVMQNmhCGgvH43tgms6jbcNXtbZ8+Yt/q/gUHVYWhvBNnj52k8GBSb
 KrnkE/piSLvhRJlKWc/nr2xk4NzgagZ+iEjCBGZ0nsF2RmSFpis+VRDSHMdhU6kOODhv
 AkFw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+M7DLg87vRR5n/0+IP6mq6J8Jq/A+N6d29+DXgpS7hfMpjaKrCYbkX6+mKLQB0tgvgC6+OKxnGxC8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzgDM8xd5DGbM6gzbtxcAT3ux9RY1LlRxf5Hbi0EbvRZi54ZhH8
 eM++MJ+1oDsU1PV2FsXX+dLjesi42lK3wNb0eYBmBZkyW+xYMt0PiEAsFN5hRtceXUMuLHjCm2y
 hN289CyaVQYFfpgsHzWotDi65gd3KSAQ=
X-Gm-Gg: AeBDieskhv7xQvLeRxXFiECbeR3osgHzsbXCR+vhf7oh4JriNr8dBFQVbDYCftV6c2G
 wFkOoeHZL51mYXXu7BMtkcIIckNhW93wKx4maop2k8fU/r8hPKRiiM7nLDbvJihKjbC8uGJZQxV
 EMFODwLs48nuRivEDBNgLIiraW0LEz9rvSgYB9cttmQcXsclI0DCj9WXqKIa2OmCyC4Pwzx/jDf
 7b0AIM06y5lfXpNVkm4k2C9lFYc6fCiVDkxu7vwLnIQlljDfp6CnQ4Ahcfe2fsfzCHRwcKAXou6
 mz6AVkFfm8uar8faoA==
X-Received: by 2002:a4a:ee0e:0:b0:685:9910:eb89 with SMTP id
 006d021491bc7-69462f54c42mr6775176eaf.58.1776683170488; Mon, 20 Apr 2026
 04:06:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260420061644.1251070-1-syyang@lontium.com>
 <CAO9ioeVFHn3ARCqL0NJ9jRCJV2P9-Ky2c105iF7EwLUG-cV-QQ@mail.gmail.com>
In-Reply-To: <CAO9ioeVFHn3ARCqL0NJ9jRCJV2P9-Ky2c105iF7EwLUG-cV-QQ@mail.gmail.com>
From: =?UTF-8?B?5p2o5a2Z6L+Q?= <yangsunyun1993@gmail.com>
Date: Mon, 20 Apr 2026 19:05:58 +0800
X-Gm-Features: AQROBzAoBA3jxkjqKnQpkQI-X3GJIp9P5sDn9NIrms1IC8GwHjSrtXwSlOK4RmU
Message-ID: <CAFQXuNZd8B0spcF2HNNRdF6a3UxELaEriGssFXL+se5dhoLj5w@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Add LT9611C(EX/UXD) DRM bridge driver and device
 tree
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: syyang@lontium.com, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, andrzej.hajda@intel.com, neil.armstrong@linaro.org, 
 maarten.lankhorst@linux.intel.com, rfoss@kernel.org, mripard@kernel.org, 
 Laurent.pinchart@ideasonboard.com, tzimmermann@ideasonboard.com, 
 jonas@kwiboo.se, jernej.skrabec@gmail.com, devicetree@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 xmzhu@lontium.corp-partner.google.com
Content-Type: multipart/alternative; boundary="00000000000041652b064fe24987"
X-Mailman-Approved-At: Tue, 21 Apr 2026 07:09:47 +0000
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

--00000000000041652b064fe24987
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> =E4=BA=8E2026=E5=B9=B4=
4=E6=9C=8820=E6=97=A5=E5=91=A8=E4=B8=80 18:45=E5=86=99=E9=81=93=EF=BC=9A

> On Mon, 20 Apr 2026 at 09:16, <syyang@lontium.com> wrote:
> >
> > From: Sunyun Yang <syyang@lontium.com>
> >
> > This series adds support for the Lontium LT9611C(EX/UXD) MIPI DSI to HD=
MI
> > chip:
> >
> > -dt-bindings: bridge: This patch adds new content to the
> lontium,lt9611.yaml
> >  binding file.
> > -drm/bridge: This patch add new DRM bridge driver for LT9611C(EX/UXD)
> chip.
> >
> > Signed-off-by: Sunyun Yang<syyang@lontium.com>
>
> Once again. Your messages are not reaching the dri-devel mailing list.
> Please fix your SMTP configuration or start using B4 tool and B4 Web
> Relay for sending patches.
> Most developers wouldn't even see these emails as they haven't reached
> dri-devel.
>

   is it dri-devel@lists.freedesktop.org ?
   I only received one notification regarding the incorrect address of
tzimmermann@ideasonboard.com;
   Because his correct email address is tzimmermann@suse.de.

>
> > ---
> > Changes in v3:
> > -dt-binding:
> >  1. lt9611c(ex/uxd) content merged into lontium,lt9611.yaml
> > -drm/bridge:
> >  1. Drop the licence text, only use SPDX header
> >  2. Sort the headers
> >  3. Use library functions for crc8
> >  4. Drop i2c_read_byte and i2c_write_byte
> >  5. Lowercase all hex values
> >  6. Use paged writes as implemented for LT9611C(EX/UXD)
> >  7. Drop dev_info, use dev_dbg
> >  8. Modify lt9611c_get_edid_block, don't store EDID in the long-term
> structures
> >  9. Use HDMI audio helpers.
> >  10.Remove unnecessary flags,Implement proper cleanup path, unwinding
> resources
> >     one by one.
> >  11.Replace devm_kzalloc with devm_drm_bridge_alloc.
> >  12.Remove extra kthread.
> > -Link to v1:
> https://lore.kernel.org/lkml/20250903123825.1721443-1-syyang@lontium.com/
> >
> > Changes in v2:
> >  1. Forget modify code, operation error, Please disregard this submit.
> >
> > Changes in v1:
> > -dt-binding:
> >  1. Submit the first version of the code.
> > -drm/bridge:
> >  1. Submit the first version of the code.
> >
> > ---
> > Sunyun Yang (2):
> >   dt-bindings: bridge: This patch adds new content to the
> >     lontium,lt9611.yaml binding file
> >   drm/bridge: This patch add new DRM bridge driver for LT9611C chip
> >
> >  .../display/bridge/lontium,lt9611.yaml        |    8 +-
> >  drivers/gpu/drm/bridge/Kconfig                |   18 +
> >  drivers/gpu/drm/bridge/Makefile               |    1 +
> >  drivers/gpu/drm/bridge/lontium-lt9611c.c      | 1365 +++++++++++++++++
> >  4 files changed, 1390 insertions(+), 2 deletions(-)
> >  create mode 100755 drivers/gpu/drm/bridge/lontium-lt9611c.c
> >
> > --
> > 2.34.1
> >
>
>
> --
> With best wishes
> Dmitry
>

--00000000000041652b064fe24987
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">Dmitry Baryshko=
v &lt;<a href=3D"mailto:dmitry.baryshkov@oss.qualcomm.com">dmitry.baryshkov=
@oss.qualcomm.com</a>&gt; =E4=BA=8E2026=E5=B9=B44=E6=9C=8820=E6=97=A5=E5=91=
=A8=E4=B8=80 18:45=E5=86=99=E9=81=93=EF=BC=9A<br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">On Mon, 20 Apr 2026 at 09:16, &lt;<a href=3D"=
mailto:syyang@lontium.com" target=3D"_blank">syyang@lontium.com</a>&gt; wro=
te:<br>
&gt;<br>
&gt; From: Sunyun Yang &lt;<a href=3D"mailto:syyang@lontium.com" target=3D"=
_blank">syyang@lontium.com</a>&gt;<br>
&gt;<br>
&gt; This series adds support for the Lontium LT9611C(EX/UXD) MIPI DSI to H=
DMI<br>
&gt; chip:<br>
&gt;<br>
&gt; -dt-bindings: bridge: This patch adds new content to the lontium,lt961=
1.yaml<br>
&gt;=C2=A0 binding file.<br>
&gt; -drm/bridge: This patch add new DRM bridge driver for LT9611C(EX/UXD) =
chip.<br>
&gt;<br>
&gt; Signed-off-by: Sunyun Yang&lt;<a href=3D"mailto:syyang@lontium.com" ta=
rget=3D"_blank">syyang@lontium.com</a>&gt;<br>
<br>
Once again. Your messages are not reaching the dri-devel mailing list.<br>
Please fix your SMTP configuration or start using B4 tool and B4 Web<br>
Relay for sending patches.<br>
Most developers wouldn&#39;t even see these emails as they haven&#39;t reac=
hed<br>
dri-devel.<br></blockquote><div><br></div><div><span style=3D"font-family:&=
quot;Google Sans&quot;,Roboto,RobotoDraft,Helvetica,Arial,sans-serif;font-s=
ize:14px;font-variant-ligatures:no-contextual">=C2=A0 =C2=A0is it <a href=
=3D"mailto:dri-devel@lists.freedesktop.org">dri-devel@lists.freedesktop.org=
</a> ?</span>=C2=A0</div><div>=C2=A0 =C2=A0I only received one notification=
 regarding the incorrect address of <a href=3D"mailto:tzimmermann@ideasonbo=
ard.com">tzimmermann@ideasonboard.com</a>;=C2=A0</div><div>=C2=A0 =C2=A0Bec=
ause his correct email address is <a href=3D"mailto:tzimmermann@suse.de">tz=
immermann@suse.de</a>.</div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">
<br>
&gt; ---<br>
&gt; Changes in v3:<br>
&gt; -dt-binding:<br>
&gt;=C2=A0 1. lt9611c(ex/uxd) content merged into lontium,lt9611.yaml<br>
&gt; -drm/bridge:<br>
&gt;=C2=A0 1. Drop the licence text, only use SPDX header<br>
&gt;=C2=A0 2. Sort the headers<br>
&gt;=C2=A0 3. Use library functions for crc8<br>
&gt;=C2=A0 4. Drop i2c_read_byte and i2c_write_byte<br>
&gt;=C2=A0 5. Lowercase all hex values<br>
&gt;=C2=A0 6. Use paged writes as implemented for LT9611C(EX/UXD)<br>
&gt;=C2=A0 7. Drop dev_info, use dev_dbg<br>
&gt;=C2=A0 8. Modify lt9611c_get_edid_block, don&#39;t store EDID in the lo=
ng-term structures<br>
&gt;=C2=A0 9. Use HDMI audio helpers.<br>
&gt;=C2=A0 10.Remove unnecessary flags,Implement proper cleanup path, unwin=
ding resources<br>
&gt;=C2=A0 =C2=A0 =C2=A0one by one.<br>
&gt;=C2=A0 11.Replace devm_kzalloc with devm_drm_bridge_alloc.<br>
&gt;=C2=A0 12.Remove extra kthread.<br>
&gt; -Link to v1: <a href=3D"https://lore.kernel.org/lkml/20250903123825.17=
21443-1-syyang@lontium.com/" rel=3D"noreferrer" target=3D"_blank">https://l=
ore.kernel.org/lkml/20250903123825.1721443-1-syyang@lontium.com/</a><br>
&gt;<br>
&gt; Changes in v2:<br>
&gt;=C2=A0 1. Forget modify code, operation error, Please disregard this su=
bmit.<br>
&gt;<br>
&gt; Changes in v1:<br>
&gt; -dt-binding:<br>
&gt;=C2=A0 1. Submit the first version of the code.<br>
&gt; -drm/bridge:<br>
&gt;=C2=A0 1. Submit the first version of the code.<br>
&gt;<br>
&gt; ---<br>
&gt; Sunyun Yang (2):<br>
&gt;=C2=A0 =C2=A0dt-bindings: bridge: This patch adds new content to the<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0lontium,lt9611.yaml binding file<br>
&gt;=C2=A0 =C2=A0drm/bridge: This patch add new DRM bridge driver for LT961=
1C chip<br>
&gt;<br>
&gt;=C2=A0 .../display/bridge/lontium,lt9611.yaml=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A0 8 +-<br>
&gt;=C2=A0 drivers/gpu/drm/bridge/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A018 +<br>
&gt;=C2=A0 drivers/gpu/drm/bridge/Makefile=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 1 +<br>
&gt;=C2=A0 drivers/gpu/drm/bridge/lontium-lt9611c.c=C2=A0 =C2=A0 =C2=A0 | 1=
365 +++++++++++++++++<br>
&gt;=C2=A0 4 files changed, 1390 insertions(+), 2 deletions(-)<br>
&gt;=C2=A0 create mode 100755 drivers/gpu/drm/bridge/lontium-lt9611c.c<br>
&gt;<br>
&gt; --<br>
&gt; 2.34.1<br>
&gt;<br>
<br>
<br>
-- <br>
With best wishes<br>
Dmitry<br>
</blockquote></div></div>

--00000000000041652b064fe24987--
