Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4245CC43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 07:11:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF09D10E7C3;
	Mon, 13 Jul 2026 07:10:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cPCGy2s1";
	dkim-atps=neutral
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com
 [209.85.215.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00BA010E318
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Jul 2026 08:45:04 +0000 (UTC)
Received: by mail-pg1-f178.google.com with SMTP id
 41be03b00d2f7-c96bfabc8d4so1111945a12.3
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Jul 2026 01:45:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783759504; cv=none;
 d=google.com; s=arc-20260327;
 b=AiDS8qq/A4rWkmdUg9jtok39LlGZAgY8NdYuYYB8kr1kTdzgvcR2P+PJqtSvolcdbU
 9qkpuoiKkhREV29BDnBTJTkbJgiWHF5DUXmfPl+wqvB1W2HAr/YuXyIWVoIhE4mGPdN2
 JE3JWkuCnDccb1TMoLCpMrPzL/9dSfa+/UPolPGHJYV5z2Sc1c/mMbVb98mtkzWZYNkk
 zGG7TxCtj+x1KA1ghWriT7c/d4GWS4WILhiq9BmzWdO+NRojcFqLrO9gJqtUTQZGDRCE
 hC6/7j4NxXYPGiwUfCPOFCYbRT3jDjqqx29haQEf5BGIXNmYPEiU4p+JSqbhA2RxNSSm
 AMug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=dOtkU4x9PdYj+8HW6RC7BqjcU55iCa0C1SdNdtAVTLU=;
 fh=S060n98uRc3qitglJ91GafjaEKA4wE9FvJPYRWVCvv4=;
 b=b38HbPa4xKs8iBJYUs0B4Ak7i8akOQV20IV308fFPTRwEnTVSn2BUWGm77rnnCuIjE
 xzw1nl0eSGDDZW37aU5ODC2Gdc7BC3nKbuatZP+3Ej/ykDIX+ZtRdwmuubpCHhsNcS57
 Z6nmZoZsGFNOkshlDHa7AKk8fsjCl1dfzwF7YmL17E4eer90nk6AeVehMOjyod0/calk
 DHQ+W6ph96jxjuK3uGxHZ+VUJMFId18NsZFk2V98MgAn4tjAwA93U/rQiXFJAQVanj0K
 9KLAZ/w2VJ1cIVS00YPb8QtK/rlvUutgdPzDFxQftugw/d7+HJrIccVswYz9IUeHgdRt
 74tg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783759504; x=1784364304; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=dOtkU4x9PdYj+8HW6RC7BqjcU55iCa0C1SdNdtAVTLU=;
 b=cPCGy2s1lCFs7rFHsGyV6GYaCvHy941i3VryL3C1pq7So334UTyBLHcFc6ChfDIU8M
 kwc45O+OVPH+o/KorJ1UNi67MkYboz9TkO8f9rJtGu74oZYo+na9lqZqVzMZVimpAYZe
 FyMs9LV8dNarH7zhRjPeOOfjn1BJGT/xZOYgCcd0eRlAuNPNkdir/QbbPMGjr7b3E5SA
 9jgAciugPRvc/D1nnPqJTYytjAVj35uFNU256eldctfL6T+Gs7a5J50f8kkn2FErDdXT
 9Ck3j6dkv7Dr6U+WKWCXBJIHpuEvYagZZw3gJwxIjb8BFbl5JD9jIXTjFk7QA3urmIl5
 ukEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783759504; x=1784364304;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=dOtkU4x9PdYj+8HW6RC7BqjcU55iCa0C1SdNdtAVTLU=;
 b=Ls0biCdX7xWDsp5xfVeLAK5mZNc39U8+5hpUqU5eQYDdLXG+9Jz1m36Japp8ifGERK
 P/gLkhysNICVfCnnLP5YDKnaG4zQx8dX6qfNYXtii8Kkiek6FGDXSsxr/brisSSGR5gF
 XhnYqtzzxRX5IrzWbnTaGIeTsWpKbj4mIuP607z9xPE+nIIjikTL8g6a4/3FkAQYM+jc
 wPWxGrox6BGnrs9r3LQEqIQYwirI0eahoUbY/7iYZvkoPokjgQahJeJmgSF6ZHH/UdVo
 zFiabKt8CN0LcMxpzUUE0EANajE8iMqbIxRXnNXAX5+qd1st+BksG1twSZE5ksM/n8V/
 Co0Q==
X-Gm-Message-State: AOJu0YyWgDy29nXgZJ2Vwpo30c0XzKOY+QaRqeRd0mdW3HHIr63B51S4
 vszegJWs0DAkCXG07p8GL9JGezjD+v/fQbEn7JGWaMG0/UeDZZx3NmoYro2DBVA/zEQLr7GRS+J
 WsTAvtxbXTrHeurBjKuLxvze+SUx5EE9UBfIC
X-Gm-Gg: AfdE7cn34C9YHfE0vZKJIP5HZkeBTeIi18szbR+H7IaKBzNT/8rI8A0C/fYym6qMXUE
 04LHL04xtPT4y/MfeecSNr1tow68bQN482AbHDgb39tnV56QXUkdrEeDCNpxE+vWEZoxTYwnEOu
 rPWdwzyqSCa6Gp6VmwKPQ71rpA+NKXasFR3fcJ+fwnEiF9kBKAwaJjKA2KbcKmwXbEFM24Th0q+
 fZ+iCXKmrcj0tZg+60TAG+uI1W6L5UwTI/tvKVXvSjLZeShXOjFoNea+Qg79eTIbOmCrIEV3PV0
 E9Vh4Cyef2lfmt/BI8+f/oqUYASB
X-Received: by 2002:a05:6a00:3d4b:b0:845:e3af:dde9 with SMTP id
 d2e1a72fcca58-848897d301emr2123925b3a.38.1783759504399; Sat, 11 Jul 2026
 01:45:04 -0700 (PDT)
MIME-Version: 1.0
From: Francesco <postadelmaga@gmail.com>
Date: Sat, 11 Jul 2026 10:44:52 +0200
X-Gm-Features: AUfX_mxh-8mbQqBqE9heeoRHEh4TRnjFx2WiI2YPMUUIOodX-uUwuItU51FO51A
Message-ID: <CAHwn+vnP4eGFW3Z0g_YHT6PW7beOvrOD833Gyy6LwL05mj6Whg@mail.gmail.com>
Subject: [PATCH 1/2] drm/nouveau/clk: fix list cursor use after loop in
 nvkm_clk_ustate_update
To: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Cc: lyude@redhat.com, dakr@kernel.org, kherbst@redhat.com
Content-Type: multipart/alternative; boundary="0000000000009fe9d8065651df81"
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

--0000000000009fe9d8065651df81
Content-Type: text/plain; charset="UTF-8"

If the requested pstate id is not present in the state list (or the
list is empty, e.g. broken/missing perf tables), the list_for_each_entry
cursor runs off the end of the list and the subsequent
pstate->pstate != req check dereferences the list head cast to a
struct nvkm_pstate, which is an out-of-bounds read.

Track whether the entry was actually found instead of inspecting the
cursor after the loop.

Co-Authored-By: Claude Fable 5 <noreply@anthropic.com>
Signed-off-by: Francesco Magazzu <postadelmaga@gmail.com>
---
drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c | 8 ++++++--
1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
index 572e63846..42f3709e0 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
@@ -479,13 +479,17 @@ nvkm_clk_ustate_update(struct nvkm_clk *clk, int req)
return -ENOSYS;

if (req != -1 && req != -2) {
+ bool found = false;
+
list_for_each_entry(pstate, &clk->states, head) {
- if (pstate->pstate == req)
+ if (pstate->pstate == req) {
+ found = true;
break;
+ }
i++;
}

- if (pstate->pstate != req)
+ if (!found)
return -EINVAL;
req = i;
}

base-commit: a284476db2653ae893f46cbea408eb412db54eb0
-- 
2.55.0

--0000000000009fe9d8065651df81
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div dir=3D"auto">If the requested pstate id is not p=
resent in the state list (or the<br>list is empty, e.g. broken/missing perf=
 tables), the list_for_each_entry<br>cursor runs off the end of the list an=
d the subsequent<br>pstate-&gt;pstate !=3D req check dereferences the list =
head cast to a<br>struct nvkm_pstate, which is an out-of-bounds read.<br><b=
r>Track whether the entry was actually found instead of inspecting the<br>c=
ursor after the loop.<br><br>Co-Authored-By: Claude Fable 5 &lt;<a href=3D"=
mailto:noreply@anthropic.com" target=3D"_blank">noreply@anthropic.com</a>&g=
t;<br>Signed-off-by: Francesco Magazzu &lt;<a href=3D"mailto:postadelmaga@g=
mail.com" target=3D"_blank">postadelmaga@gmail.com</a>&gt;<br>---<br> drive=
rs/gpu/drm/nouveau/nvkm/subdev/clk/base.c | 8 ++++++--<br> 1 file changed, =
6 insertions(+), 2 deletions(-)<br><br>diff --git a/drivers/gpu/drm/nouveau=
/nvkm/subdev/clk/base.c b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c<br=
>index 572e63846..42f3709e0 100644<br>--- a/drivers/gpu/drm/nouveau/nvkm/su=
bdev/clk/base.c<br>+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c<br>=
@@ -479,13 +479,17 @@ nvkm_clk_ustate_update(struct nvkm_clk *clk, int req)=
<br> 		return -ENOSYS;<br> <br> 	if (req !=3D -1 &amp;&amp; req !=3D -2) {<=
br>+		bool found =3D false;<br>+<br> 		list_for_each_entry(pstate, &amp;clk=
-&gt;states, head) {<br>-			if (pstate-&gt;pstate =3D=3D req)<br>+			if (ps=
tate-&gt;pstate =3D=3D req) {<br>+				found =3D true;<br> 				break;<br>+		=
	}<br> 			i++;<br> 		}<br> <br>-		if (pstate-&gt;pstate !=3D req)<br>+		if =
(!found)<br> 			return -EINVAL;<br> 		req =3D i;<br> 	}<br><br>base-commit:=
 a284476db2653ae893f46cbea408eb412db54eb0<br>-- <br>2.55.0<br></div></div><=
/div>

--0000000000009fe9d8065651df81--
