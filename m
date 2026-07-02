Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B6CDC43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 07:04:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A4F010F66A;
	Fri,  3 Jul 2026 07:04:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dfkTDwUI";
	dkim-atps=neutral
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com
 [209.85.217.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C8F910F528
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 17:06:30 +0000 (UTC)
Received: by mail-vs1-f50.google.com with SMTP id
 ada2fe7eead31-725cf9a923aso1169228137.0
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 10:06:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783011989; cv=none;
 d=google.com; s=arc-20260327;
 b=k7KRfBUlJzTayXFR8ldg/F5ZJXAM/6IbMIirlbTnsL1KAQpzt9I0OG935YmsEhbhdv
 wmkO9Y9AEa5ZKhDSc1aJ1DM6fTMaMrSDnFBCiiZUTP2MudpoI+R8cQZ4c6EZaxsE/2Ao
 X8welcrDClN4oBjOEkTWQyPrwPK3IDpd0Xg1Rsb2Ktr6h4eQ/BTEFPzZzDFXQHW5cwD3
 cmE/eJalxdoX7sW/KwPWdcRpm4IohwZTB3JAZhf+Hdogzc83D2u14OO0H6Jqi3BZk61B
 So7TpuoPIDTrxLZIpBhQJ8JNuoNK1F20zBqKzNhSEfDrM781MAIg5UVkqO+v0qruCves
 AHjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=KrHpjQTxpek59oqmmA39ihe3BsaTvnarGLzghSnX1ME=;
 fh=HOkJ6cAxY9aFjkZh1z1bGodPeulcgDV1H5Czbs9j3Ro=;
 b=AzkG6LQ/o56FnvCJvel95OZlgfgW5kFKl/vKgEkCRKnO69+4EMLDXGAU4Sb+i5NlIb
 S/GGDPQSqzy28Le3poxAmKjFA8+kTDVWAoVnZKSi7QrvH6yrEKciqpIrYgvczPO63Dxz
 FL8ssf1MHjNtwDn9cAeUP12YkyqimkGtpz2cVo8++feQS8ftIUmB+CrAS+SMGOvTkDnG
 w/XP0/BBoVh8+aGkhebeCNhmrqVKRZiqjrKIbJjsUjQSAfKZ8Eko59LXBesKCGVlPDhS
 YbwRsCy7z07a0GGSnL4CbCv87oNkC2ICE9b/M9zqK5hPPfXfhzhsE9IFgEClQAtIWEFF
 WYmQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783011989; x=1783616789; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=KrHpjQTxpek59oqmmA39ihe3BsaTvnarGLzghSnX1ME=;
 b=dfkTDwUIj6wW6uBg2RGiLZBABtLrEAloCm8GZd632gqIoVY/cwlHzhqxp+CNheEbTw
 WS9OhIMKTzA1fit0Gve6zhPzXGhmjNtLP+OngsxKgP+k3Y5NKkP/23XfpTdoeadbQCEP
 gSfUAKRrv0SIh9T00AGeyr6ozEUo4Ypu9Jn/y/cJe+fFXVFgQb10hw0gasnaOFECYpr1
 o+nKBDy3ZCy2kx8ta7nyTsBiqhQvt7+JA6XVDdbW3pRpaSCnF259uAXtbQePaRspQLBj
 0otG2cgzNfw6lUy1FM2alMeeyvPOAHCiz91Ivw0cKAVCT1z2A9Asha3/rrvXtSdWENG7
 rAxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783011989; x=1783616789;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KrHpjQTxpek59oqmmA39ihe3BsaTvnarGLzghSnX1ME=;
 b=Rb9t9QuhfEwD1+HbTiNQH2M36JFzaATfAWPkbE9/qh8R5gVkmWuSb4NtVE7WcrYFqp
 TbGcAuZhIQdN8TXI1ssEodRYjRpIk4eNwWJPy/FAPhvgNmBqN56ZHlCCu+YjIUX/bFrr
 Do+yYa5r3FHIcwB+zWje8OkKWiiTgJP0KOdKGXWNNz3O+RJLIleFH67xaey8369grw1k
 BOZjNyBrLJRgU+o8cYkZlg/xPIwnQYlh9StarnKr6meVqvmakCZGtfZb1mrwYOjKV0hO
 uVY6TVAAg0/ii8kJ3+nUNb0N6JqWEGx1Oh4ZIWXNc+dGgj8aXyOneS7goM97yuhQkzV+
 hI9g==
X-Forwarded-Encrypted: i=1;
 AHgh+RqG6JClvwtr6oszeMfPPX9gxRi7C9MfWCZ86Pvo6TJ82LBgss/531iUMJXXRnJtXcxydXS7iqKfftE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyNgLky4sKMYYk2xTtzhwshuArUcwFJSkg4jcL5y03lyB7cx6en
 BCIsjPs3DSry/kqfTQnAJdHc3qpG9mH1jXV+1PQRDLXe56N/e/mZjJExloaKSpInWpOlck1Q5XL
 oZYJOLa++ovR4rDpkzQGF17pyldM4cZeTqtPiPnc=
X-Gm-Gg: AfdE7cmYvM/FmjVP+0lh6qvryDo0qU0XUfOMYFHdeu5kS69YFtiDM7WrxZmiMSO95ZU
 cQN25w2eeuwbalgt+fehi4R6UXEw+97ZXbNFM0ZTGJMSqmHYVIZYGHoZpA6bS2LYAcuMMrWfeEC
 dbyp1ml62WiLbknOUn0cNHuJZF95ZdSvKMI641z0ZC63c2Xf5nyaxF+Uob98pscFDbeDWmjY2+8
 12gUBWJiqtGpLgNXaL6/9RrtZPDlrX57Ez+p5eMTP3OJLe6MbM+fWMrSwDLItcIs0Kwex8=
X-Received: by 2002:a05:6102:3e2a:b0:6c5:d55d:c093 with SMTP id
 ada2fe7eead31-73da892b930mr3558591137.8.1783011989470; Thu, 02 Jul 2026
 10:06:29 -0700 (PDT)
MIME-Version: 1.0
From: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
Date: Thu, 2 Jul 2026 22:51:15 +0545
X-Gm-Features: AVVi8Cemg_NZvmdNbnylqE5U7vhuSEkNgvUIwJBue7BnURHnMz0wfb4o1o0_9Fg
Message-ID: <CAMyXUJmmcBvydpN5r6iuAGLjuftGkiVfRjT6KbdRRGLZ74NAoA@mail.gmail.com>
Subject: [PATCH] drm/panel: samsung-s6d16d0: Power off on prepare failure
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: "Cc: Linus Walleij" <linusw@kernel.org>, 
 "Cc: Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, 
 "Cc: Maxime Ripard" <mripard@kernel.org>,
 "Cc: Thomas Zimmermann" <tzimmermann@suse.de>, 
 "Cc: David Airlie" <airlied@gmail.com>, "Cc: Simona Vetter" <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: multipart/alternative; boundary="0000000000004346700655a3d4fd"
X-Mailman-Approved-At: Fri, 03 Jul 2026 07:04:17 +0000
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

--0000000000004346700655a3d4fd
Content-Type: text/plain; charset="UTF-8"

If enabling tearing mode or exiting sleep mode fails after the
regulator is enabled, s6d16d0_prepare() returns without asserting
reset or disabling the supply. Since the DRM panel core leaves the
panel unprepared, a later unprepare call skips the driver callback
and the supply remains enabled.

Assert reset and disable the supply before returning the DSI command error.

Fixes: ac1d6d74884e ("drm/panel: Add driver for Samsung S6D16D0 panel")
Assisted-by: Codex:gpt-5
Signed-off-by: Laxman Acharya <acharyalaxman8848@gmail.com>
---
 drivers/gpu/drm/panel/panel-samsung-s6d16d0.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-samsung-s6d16d0.c
b/drivers/gpu/drm/panel/panel-samsung-s6d16d0.c
index ba1a02000..04e19b5f2 100644
--- a/drivers/gpu/drm/panel/panel-samsung-s6d16d0.c
+++ b/drivers/gpu/drm/panel/panel-samsung-s6d16d0.c
@@ -89,16 +89,22 @@ static int s6d16d0_prepare(struct drm_panel *panel)
        MIPI_DSI_DCS_TEAR_MODE_VBLANK);
  if (ret) {
  dev_err(s6->dev, "failed to enable vblank TE (%d)\n", ret);
- return ret;
+ goto err_power_off;
  }
  /* Exit sleep mode and power on */
  ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
  if (ret) {
  dev_err(s6->dev, "failed to exit sleep mode (%d)\n", ret);
- return ret;
+ goto err_power_off;
  }

  return 0;
+
+err_power_off:
+ gpiod_set_value_cansleep(s6->reset_gpio, 1);
+ regulator_disable(s6->supply);
+
+ return ret;
 }

 static int s6d16d0_enable(struct drm_panel *panel)
-- 
2.51.2

--0000000000004346700655a3d4fd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br>If enabling tearing mode or exiting sleep mode fails a=
fter the<br>regulator is enabled, s6d16d0_prepare() returns without asserti=
ng<br>reset or disabling the supply. Since the DRM panel core leaves the<br=
>panel unprepared, a later unprepare call skips the driver callback<br>and =
the supply remains enabled.<br><br>Assert reset and disable the supply befo=
re returning the DSI command error.<br><br>Fixes: ac1d6d74884e (&quot;drm/p=
anel: Add driver for Samsung S6D16D0 panel&quot;)<br>Assisted-by: Codex:gpt=
-5<div>Signed-off-by: Laxman Acharya &lt;<a href=3D"mailto:acharyalaxman884=
8@gmail.com">acharyalaxman8848@gmail.com</a>&gt;<br>---<br>=C2=A0drivers/gp=
u/drm/panel/panel-samsung-s6d16d0.c | 10 ++++++++--<br>=C2=A01 file changed=
, 8 insertions(+), 2 deletions(-)<br><br>diff --git a/drivers/gpu/drm/panel=
/panel-samsung-s6d16d0.c b/drivers/gpu/drm/panel/panel-samsung-s6d16d0.c<br=
>index ba1a02000..04e19b5f2 100644<br>--- a/drivers/gpu/drm/panel/panel-sam=
sung-s6d16d0.c<br>+++ b/drivers/gpu/drm/panel/panel-samsung-s6d16d0.c<br>@@=
 -89,16 +89,22 @@ static int s6d16d0_prepare(struct drm_panel *panel)<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPI_DSI_DCS_TEAR_MODE_VBLANK);<br>=C2=A0 if (r=
et) {<br>=C2=A0 dev_err(s6-&gt;dev, &quot;failed to enable vblank TE (%d)\n=
&quot;, ret);<br>- return ret;<br>+ goto err_power_off;<br>=C2=A0 }<br>=C2=
=A0 /* Exit sleep mode and power on */<br>=C2=A0 ret =3D mipi_dsi_dcs_exit_=
sleep_mode(dsi);<br>=C2=A0 if (ret) {<br>=C2=A0 dev_err(s6-&gt;dev, &quot;f=
ailed to exit sleep mode (%d)\n&quot;, ret);<br>- return ret;<br>+ goto err=
_power_off;<br>=C2=A0 }<br>=C2=A0<br>=C2=A0 return 0;<br>+<br>+err_power_of=
f:<br>+ gpiod_set_value_cansleep(s6-&gt;reset_gpio, 1);<br>+ regulator_disa=
ble(s6-&gt;supply);<br>+<br>+ return ret;<br>=C2=A0}<br>=C2=A0<br>=C2=A0sta=
tic int s6d16d0_enable(struct drm_panel *panel)<br>--<span class=3D"gmail-A=
pple-converted-space">=C2=A0</span><br>2.51.2</div></div>

--0000000000004346700655a3d4fd--
