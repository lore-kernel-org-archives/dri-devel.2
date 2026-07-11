Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1818DC44507
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 07:12:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF39410E82D;
	Mon, 13 Jul 2026 07:11:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZHA31VqS";
	dkim-atps=neutral
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
 [209.85.210.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 437A910E318
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Jul 2026 08:45:16 +0000 (UTC)
Received: by mail-pf1-f182.google.com with SMTP id
 d2e1a72fcca58-8485fad302bso1742985b3a.3
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Jul 2026 01:45:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783759516; cv=none;
 d=google.com; s=arc-20260327;
 b=HUEe/zamID00L/QninETLOB2ueH1deXyOfS/8H2+LkfApG1fV4Lx/ACa4u3p0xLg/s
 25b1KTRKU7K7OIdy/rQLFR4CZ35Zz9rYf6rjKjMMKagl100OWeSqx9CKcgi4D6M+8k8T
 t4xXdmi3tl2OUON0UNuu4JZbahzugwvJIKTo/hIktbYG7bzmnrj6wHE8M40NwadAMdoJ
 iWUhaEowD0YowrL4+pIi5nWOvPaM0ezhb/J1pXlMZXtzIYG5Eri0T1fJrznerXHteopM
 hey4Z7y2zOw6l4wq26HITXwk5tOO3r9TfRoSJtCCZ061o5Bhlz2XNrAP++6I/jDDWNFH
 He1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=d5f6B0smxVafC/d5W+ptxFghTcXMGQ4dtdszLH5dcD0=;
 fh=S060n98uRc3qitglJ91GafjaEKA4wE9FvJPYRWVCvv4=;
 b=ND19Q5RXNB2JqSw5Rmik17wlFynQzWd5A0xxD5PhlL9NoYJrzACIv8lc8VS2SiU6hD
 ioa7O8ZksK7vL2Vfa0X8CAzH+j5aD+ENv0efa2QUKpJlyUO6ZFH+x4fUoiF1G7j3qY9s
 usdFAc4d96nLgzWNuWc0pl9eazNpJuxaSSeQnjJS8W5cwW9c5nRTJfcfSFrbh0o2OBe9
 HGoOUGxpFJpqjbvPCo3sQZEzVbH1SnkTau0XUvuLxLLFwTnX/IC5XfXbBEctXmpPLoPJ
 6q5WgsF07V2djhwYPoxA5UmE0TCOOfhoDVVBTrwTSX5jw0DsfnWTnG7SmNBQNLhqt/Wl
 JV9A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783759516; x=1784364316; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=d5f6B0smxVafC/d5W+ptxFghTcXMGQ4dtdszLH5dcD0=;
 b=ZHA31VqSbSLFs+j9nGb/vyVT8ZXBIMKnyMIv+S7h/OhQsg4gpjdkmWfQnnoUZf4sMl
 C3cC+cb77ZpyMznObMGh5Vbf5eA6jQkX940yH5K/cOS05MFMNO/ZKbk6uqeTI6GVYIfR
 D8P1Ha8GRrtkFGUcd8PoRBMIU8/9AqFEx/a5rkwjun2I3tgiIYyMRashuFIg+eSTvXG7
 9FLEKL6+1s+jlWhXrBqJl/QgPP4cpLMUTpxH0jZ3pwx0dSoLWpkPtDMtK6DOaRilDEEg
 x0QhVYaSXFDCwJBETRrCVjNPvmS2ad6Rc/tuTpVHrFjHBe/ux/B0baraXqjcF3MQn+dR
 VvGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783759516; x=1784364316;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=d5f6B0smxVafC/d5W+ptxFghTcXMGQ4dtdszLH5dcD0=;
 b=qWsuWpKA0K1yxyVTTaQCHyn7IURqyGJTZGTN0fl7eNh58DilH8v470huzOGoFFvDuE
 1AiuZ9rTJIZdMXG7ec+awi+sa3KAYG894Fp7EpeOtGLxczU4xMeCBYOqTs1GtKAIBCTL
 xss6AmaJnoiaECrE4AMgqV0J5geP6Bg6HY2hwrEcDOonumBzA/1oKwZG27NlJ/hCk1iq
 J9MEYEqFAu8zt7WusVNN1mByFclYNVImia0MB2QKPJB9gi4rJyukX162imncWtUIuhG5
 /tQoChOVDda1Nslb86mJYVgxS+bJ2uQwmTmFlHWBG3xILJHkRCdP5OGjGk0AiSjxIBur
 xK1A==
X-Gm-Message-State: AOJu0Yyxrne9umwuv0JPXSIVSSA/hToBFSi8NBdAImGRkhfas2MxM5ZZ
 e00UsSqYB8PPjASJASDheDCGRcF3Fs75Es9IGTwhBPLESg79VSBMCs73QkzvWUHNJVEfkO/fN4I
 MYcqE2w5WW2IDW2HQBQ/4es/FVOAGkmRH0ZE8
X-Gm-Gg: AfdE7ckuMDMdYb1HeOzy7EP2KlTirusS2b6rXQFJ3NGgMqCsSdGQeJUlSrdvy7gb4GJ
 zYxuFGjX6CvpPNVC/25MeXxWbbxXFNe066dYRobeg1qHzwamzB1WmOIW5kZhz5hfIIIwwGweDWS
 fBxNNc8hP8k0XTnb8Biem/nwcjYh3E5B5YaMBUUWOmA2WQLFcDDcCvN9B2cTXUzNjEkbY3MTdwp
 ASYeLud3TLS4chqx7WpMbVI5EplBug6zt4zV4/Y8MI8c3loSmUIkdW5MOhmOG4de2XVG+/wogiL
 RwOdcxGM9Y8QjUDIqXlfQZt9K/U1
X-Received: by 2002:aa7:8891:0:b0:845:44c7:5e28 with SMTP id
 d2e1a72fcca58-84889649d8cmr2012798b3a.31.1783759515638; Sat, 11 Jul 2026
 01:45:15 -0700 (PDT)
MIME-Version: 1.0
From: Francesco <postadelmaga@gmail.com>
Date: Sat, 11 Jul 2026 10:45:02 +0200
X-Gm-Features: AUfX_mzSuKPUAnaWauxVFZ8dn-PVTnVgi02lCEG6OlYh7Rf8UL0yhrQEFIw3mPY
Message-ID: <CAHwn+vnw=DD=j7umFVdcr8-F6yUz=iM+3yfA+HcHKXJwpNrHRA@mail.gmail.com>
Subject: [PATCH 2/2] drm/nouveau/clk: don't clobber reclock status when
 restoring volt/fan
To: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Cc: lyude@redhat.com, dakr@kernel.org, kherbst@redhat.com
Content-Type: multipart/alternative; boundary="0000000000004b61c7065651e01f"
X-Mailman-Approved-At: Mon, 13 Jul 2026 07:10:39 +0000
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

--0000000000004b61c7065651e01f
Content-Type: text/plain; charset="UTF-8"

nvkm_cstate_prog() reuses 'ret' for the voltage and fan-speed restore
calls made after clock programming. As a result a clock programming
failure is silently discarded if the restore calls succeed, and
conversely a successful reclock can return an error if the final
therm/volt call fails (which is already only logged, not acted upon).

Keep the calc/prog status in 'ret' and use a local for the restore
calls, so the function reports what actually matters.

Co-Authored-By: Claude Fable 5 <noreply@anthropic.com>
Signed-off-by: Francesco Magazzu <postadelmaga@gmail.com>
---
drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c | 14 +++++++-------
1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
index 42f3709e0..4f08326f2 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
@@ -199,16 +199,16 @@ nvkm_cstate_prog(struct nvkm_clk *clk, struct
nvkm_pstate *pstate, int cstatei)
}

if (volt) {
- ret = nvkm_volt_set_id(volt, cstate->voltage,
- pstate->base.voltage, clk->temp, -1);
- if (ret && ret != -ENODEV)
- nvkm_error(subdev, "failed to lower voltage: %d\n", ret);
+ int tmp = nvkm_volt_set_id(volt, cstate->voltage,
+ pstate->base.voltage, clk->temp, -1);
+ if (tmp && tmp != -ENODEV)
+ nvkm_error(subdev, "failed to lower voltage: %d\n", tmp);
}

if (therm) {
- ret = nvkm_therm_cstate(therm, pstate->fanspeed, -1);
- if (ret && ret != -ENODEV)
- nvkm_error(subdev, "failed to lower fan speed: %d\n", ret);
+ int tmp = nvkm_therm_cstate(therm, pstate->fanspeed, -1);
+ if (tmp && tmp != -ENODEV)
+ nvkm_error(subdev, "failed to lower fan speed: %d\n", tmp);
}

return ret;
-- 
2.55.0

--0000000000004b61c7065651e01f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div dir=3D"auto">nvkm_cstate_prog() reuses &#39;ret&=
#39; for the voltage and fan-speed restore<br>calls made after clock progra=
mming.  As a result a clock programming<br>failure is silently discarded if=
 the restore calls succeed, and<br>conversely a successful reclock can retu=
rn an error if the final<br>therm/volt call fails (which is already only lo=
gged, not acted upon).<br><br>Keep the calc/prog status in &#39;ret&#39; an=
d use a local for the restore<br>calls, so the function reports what actual=
ly matters.<br><br>Co-Authored-By: Claude Fable 5 &lt;<a href=3D"mailto:nor=
eply@anthropic.com" target=3D"_blank">noreply@anthropic.com</a>&gt;<br>Sign=
ed-off-by: Francesco Magazzu &lt;<a href=3D"mailto:postadelmaga@gmail.com" =
target=3D"_blank">postadelmaga@gmail.com</a>&gt;<br>---<br> drivers/gpu/drm=
/nouveau/nvkm/subdev/clk/base.c | 14 +++++++-------<br> 1 file changed, 7 i=
nsertions(+), 7 deletions(-)<br><br>diff --git a/drivers/gpu/drm/nouveau/nv=
km/subdev/clk/base.c b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c<br>in=
dex 42f3709e0..4f08326f2 100644<br>--- a/drivers/gpu/drm/nouveau/nvkm/subde=
v/clk/base.c<br>+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c<br>@@ =
-199,16 +199,16 @@ nvkm_cstate_prog(struct nvkm_clk *clk, struct nvkm_pstat=
e *pstate, int cstatei)<br> 	}<br> <br> 	if (volt) {<br>-		ret =3D nvkm_vol=
t_set_id(volt, cstate-&gt;voltage,<br>-				       pstate-&gt;base.voltage, =
clk-&gt;temp, -1);<br>-		if (ret &amp;&amp; ret !=3D -ENODEV)<br>-			nvkm_e=
rror(subdev, &quot;failed to lower voltage: %d\n&quot;, ret);<br>+		int tmp=
 =3D nvkm_volt_set_id(volt, cstate-&gt;voltage,<br>+					   pstate-&gt;base=
.voltage, clk-&gt;temp, -1);<br>+		if (tmp &amp;&amp; tmp !=3D -ENODEV)<br>=
+			nvkm_error(subdev, &quot;failed to lower voltage: %d\n&quot;, tmp);<br>=
 	}<br> <br> 	if (therm) {<br>-		ret =3D nvkm_therm_cstate(therm, pstate-&g=
t;fanspeed, -1);<br>-		if (ret &amp;&amp; ret !=3D -ENODEV)<br>-			nvkm_err=
or(subdev, &quot;failed to lower fan speed: %d\n&quot;, ret);<br>+		int tmp=
 =3D nvkm_therm_cstate(therm, pstate-&gt;fanspeed, -1);<br>+		if (tmp &amp;=
&amp; tmp !=3D -ENODEV)<br>+			nvkm_error(subdev, &quot;failed to lower fan=
 speed: %d\n&quot;, tmp);<br> 	}<br> <br> 	return ret;<br>-- <br>2.55.0<br>=
</div></div></div>

--0000000000004b61c7065651e01f--
