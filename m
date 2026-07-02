Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F938C44500
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 07:04:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F67010F665;
	Fri,  3 Jul 2026 07:04:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="c9ffWLnU";
	dkim-atps=neutral
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com
 [209.85.217.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B76C10E513
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 16:47:28 +0000 (UTC)
Received: by mail-vs1-f46.google.com with SMTP id
 ada2fe7eead31-73b7c3791dbso995777137.1
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 09:47:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783010847; cv=none;
 d=google.com; s=arc-20260327;
 b=dQxpznuhkOj4usE3Hi3qKFE3zRmcnw6ECQ0Nk0HiaXAvyUw8bcAejBhyX2Ozf1TXGT
 KcqhjEiFzxmVTjCkNcN7NXsMvi+fHq2/0naKC5ma1YqFLhy9bayZGo7si/v6iwqiTVvG
 vahQdX+/nTvIxyJ0YMGjbYl5K67w3Q5C3iRfS1VpX+ZkqWQZDb34jqmlRoEXlcB4vViv
 07UiDBywDF3HPl8hA2orIrsrUHAYW8lyIdXEf4252FmCtwM9+AChJvpDf1YyTWQRHpn8
 GdK1QXDAcf0ttAKNj/9JpqrYpyOnifFDn+6k7SpIekJrJOLJW+SIlIsxorCh67ugjoAO
 Vpxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=ie81aLVv5rplvRbk1tFHNU5us0g7vXN2hC9pBjGPXyg=;
 fh=a/gwJS66QQP3ThnQVnFRh735tk7h5TL3YBUj46xN22E=;
 b=pt5rWBuUwQ4bXJRG06ZiO2dls+umJOrLhKA7nNXc7Xs3ImSAuHHqhTx/JfY3VK92wT
 VFvDduJX8m00o5S0YXr8v742V9LlrcoFdoRC1/zzziXH8ZhkFLcmk44zByxTc8f2rqmg
 R+LlZrf03jA7sqzXF8TvZZUkbG/vVH9VNs8O/LxAorGkYrUvFbZgUfAOzVuW/V/V5oCV
 DYu6DyGUGt+8UG1pnmB0emg4wJvi5eXONg+atsXo46xEOj0CopfGpqGGbls03rMER9Fd
 By1yxHZV9uoDOL04YKGNA5cwspK0Towhqf6opunOHBoLBQY1w9S67WIXGQwG4BGyRa0v
 gcmQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783010847; x=1783615647; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=ie81aLVv5rplvRbk1tFHNU5us0g7vXN2hC9pBjGPXyg=;
 b=c9ffWLnUGJtbz5bn/sF+2FSGGfiSs6ArHy6TJRWs+eBYukDaTN8twhH7aBoVibsgvf
 P9gdn0bBt4M+/HbJ4CIGjk5yk+YJf5OP2tCbbcf/74tMtEFnqrnK/Z+jtMW5YdbljM1z
 AUrUMJgh09l7/0bsp4dLgXXYGGdfnjWZQlk2Yh+l1LCJRyRt77CHKkwGJTYbNbUXSVR8
 BffiTbWbgjeUQ2Z/6Vf/pyYgxE2EHYLrHwIJRtItMXPTVAYq+rDF5JazGp0BPF5QT7vY
 4u69gy0tFNDv/29EQjIZ4ig0Nvi3RwxgOStTI159jZYZEdYY1tNQtEcOPDf+sJlxV2wm
 edhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783010847; x=1783615647;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ie81aLVv5rplvRbk1tFHNU5us0g7vXN2hC9pBjGPXyg=;
 b=d2HIB3qa8u8P21lQaCYNKNcF3OAnHkTAB5GqRBp4rZZkEW7TT3J/kQ5nawstkOoDsD
 0m4nHdOvIEnPxYbHIodEutKrazw9kY69u0y+GweAWiyQk2FCYfuPdd7w2uhHSJp1LMPO
 V2ochBNGuETeIfaKEjaJfCRc9rHKzpcKzV4b+R0zML4XwNOLEQ3ZxPpbbwomRzpsIsMO
 tHlmtNCycxuzX4zPT7CoEhXvBWY58CixegROg0E5KeDIFtUlTkMCf2QL8qUtBLmMJTmR
 fC1+tvAlso0V7NxGKCZn5PntVfhKKpGdhdYSZqFetIYjcReYGgkNZzEi2uMzHa3jYh1g
 3zcA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpy4fESStO+ICAi+2NIpqutm+7d8RqIjDNir6ta0PIme5c66x7GdTSMhpNX6BK65/m3KgPvjuiZbIo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzM2rYvnYmovk1IHrCCnga5cDtEHatxSo3tbYWc2q+Ut7t8tNPs
 nNwXO7QbVdEqdpAUSWI8gF9IrSGotNM6qgcv3wD6bo3Vdk8zIPjGilxl364jsFv4OKkw8HhCVHV
 HKexacpg0HC10RffG0bH0t4H6fYim5Jk=
X-Gm-Gg: AfdE7cliE/xzCMigd6+/MktbB2JUPtjII4m4Z1fZh/djbxn6L8gRizagE/ZiT3VM2tT
 loLWwv2Vua6/G3SLG7v934fjOF0ticdV+sLde9cNNl/Q+fW3ZSMfwFDr8JhrpfoTylkTUx/JsuX
 xquxpttW6xcNuf1f07w83MCv8VfGEPyjgUFH2sDCvdjIuMapCRDIGdeGntIyhQDeE1vjDCJizuG
 BVhSW3m12Ft51xvYuH4oZkwY00Yf9a84SlcUkH6YApkFgV2yWJy7DUQfvEnmI+deHzk2KA=
X-Received: by 2002:a05:6102:3746:b0:631:2624:e5e7 with SMTP id
 ada2fe7eead31-73da95b0c21mr3024647137.14.1783010847014; Thu, 02 Jul 2026
 09:47:27 -0700 (PDT)
MIME-Version: 1.0
From: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
Date: Thu, 2 Jul 2026 22:32:15 +0545
X-Gm-Features: AVVi8CeRylz-oDkHxsCwGBMgPGrq0oECdovFWqUnWEMqcrKiSG-gl24s856m9lA
Message-ID: <CAMyXUJmSvWv0WoBqvBScEXHnz70Nn_WUcu371s64j6HrB-6c9A@mail.gmail.com>
Subject: [PATCH] drm/panel: samsung-s6d16d0: Power off on prepare failure
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: inus Walleij <linusw@kernel.org>, dri-devel@lists.freedesktop.org, 
 inux-kernel@vger.kernel.org, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Content-Type: multipart/alternative; boundary="0000000000002ac27b0655a39089"
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

--0000000000002ac27b0655a39089
Content-Type: text/plain; charset="UTF-8"

If enabling tearing mode or exiting sleep mode fails after the
regulator is enabled, s6d16d0_prepare() returns without asserting
reset or disabling the supply. Since the DRM panel core leaves the
panel unprepared, a later unprepare call skips the driver callback
and the supply remains enabled.

Assert reset and disable the supply before returning the DSI command error.

Fixes: ac1d6d74884e ("drm/panel: Add driver for Samsung S6D16D0 panel")
Assisted-by: Codex:gpt-5
Signed-off-by:acharyalaxman8848@gmail.com
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

--0000000000002ac27b0655a39089
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">If enabling tearing mode or exiting sleep mode fails after=
 the<br>regulator is enabled, s6d16d0_prepare() returns without asserting<b=
r>reset or disabling the supply. Since the DRM panel core leaves the<br>pan=
el unprepared, a later unprepare call skips the driver callback<br>and the =
supply remains enabled.<br><br>Assert reset and disable the supply before r=
eturning the DSI command error.<br><br>Fixes: ac1d6d74884e (&quot;drm/panel=
: Add driver for Samsung S6D16D0 panel&quot;)<br>Assisted-by: Codex:gpt-5<d=
iv><a href=3D"mailto:Signed-off-by%3Aacharyalaxman8848@gmail.com">Signed-of=
f-by:acharyalaxman8848@gmail.com</a><br>---<br>=C2=A0drivers/gpu/drm/panel/=
panel-samsung-s6d16d0.c | 10 ++++++++--<br>=C2=A01 file changed, 8 insertio=
ns(+), 2 deletions(-)<br><br>diff --git a/drivers/gpu/drm/panel/panel-samsu=
ng-s6d16d0.c b/drivers/gpu/drm/panel/panel-samsung-s6d16d0.c<br>index ba1a0=
2000..04e19b5f2 100644<br>--- a/drivers/gpu/drm/panel/panel-samsung-s6d16d0=
.c<br>+++ b/drivers/gpu/drm/panel/panel-samsung-s6d16d0.c<br>@@ -89,16 +89,=
22 @@ static int s6d16d0_prepare(struct drm_panel *panel)<br>=C2=A0				 =C2=
=A0 =C2=A0 =C2=A0 MIPI_DSI_DCS_TEAR_MODE_VBLANK);<br>=C2=A0	if (ret) {<br>=
=C2=A0		dev_err(s6-&gt;dev, &quot;failed to enable vblank TE (%d)\n&quot;, =
ret);<br>-		return ret;<br>+		goto err_power_off;<br>=C2=A0	}<br>=C2=A0	/* =
Exit sleep mode and power on */<br>=C2=A0	ret =3D mipi_dsi_dcs_exit_sleep_m=
ode(dsi);<br>=C2=A0	if (ret) {<br>=C2=A0		dev_err(s6-&gt;dev, &quot;failed =
to exit sleep mode (%d)\n&quot;, ret);<br>-		return ret;<br>+		goto err_pow=
er_off;<br>=C2=A0	}<br>=C2=A0<br>=C2=A0	return 0;<br>+<br>+err_power_off:<b=
r>+	gpiod_set_value_cansleep(s6-&gt;reset_gpio, 1);<br>+	regulator_disable(=
s6-&gt;supply);<br>+<br>+	return ret;<br>=C2=A0}<br>=C2=A0<br>=C2=A0static =
int s6d16d0_enable(struct drm_panel *panel)<br>-- <br>2.51.2<br><div><br></=
div></div></div>

--0000000000002ac27b0655a39089--
