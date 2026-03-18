Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B475AFEDA09
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 01:50:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E77F010E04E;
	Wed, 18 Mar 2026 01:50:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="he8iuv9P";
	dkim-atps=neutral
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com
 [209.85.160.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4903B10E04E
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 01:50:23 +0000 (UTC)
Received: by mail-oa1-f52.google.com with SMTP id
 586e51a60fabf-41576c5c01cso3963706fac.3
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 18:50:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773798622; cv=none;
 d=google.com; s=arc-20240605;
 b=BuWZYPhrecYXmzI6B9kN3t5SRnzJ5Q3AiyRQr7u3wNP30/n7FT0FZIwPunAQd9oqyS
 7ZFKTzyZE4OFOsVe1o9GG30cqDa8fS/6CGd2CGn/vCvMuTF47Fz9qMCZZLe9cHo7LiE0
 xrbjkeGmoNI0dURocyflFaH7QNxetqjxnFrgD4kIwpm2GGhQDGOY4BCa6Ea06zt/iD1N
 SFmlmWnaVgx6R6B/DEACjVg2OL0VcxUuDNTLYghSanmbThB9T66DMFgpY906rQsY1lz9
 NXHlp2pmGnfki94rVnC0OANmGzf5AqjbTBMc3dZ6aNEwR45llj0ZNhBsIpzimY4ip1gl
 PIiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=2UiB8exyYF66Xj04GD4JD/Uzo6huFY9tx8CBCK67WMU=;
 fh=GZJIK2Ir+0qXME84cE5ZXIPRAOyBwoYCXXtxBQoKK6s=;
 b=eXBDXnMivVouIUXZ2US/YzNY8kafrmYYZA4rF4VT0QRFphLEu39wX0pz4LpxW9zoVt
 EPGWkXK78Vp53xNSWkHCHQ55/8oNgmxxJxfCcSBzWK/osSkYKYD/rN96I7byt5UXsAuF
 yAea14kv2QQ4SHYmGmx6RKKkpuLSQeFExe1ELRpBdmLTN4aLB1fmeLNYepWfNOJQKJQj
 AZ9mMOjL9ig2cqa4/LwfsRwratsQoteehAyhe9VxFzpftlkUtW80RBzOt4JZtP5Bvo3+
 B5BMHus+lkYrdSUW0LcwNNmM5ETgWjyaSCmSmowz/ssAER2thloeWlxicqLwwgoE75eG
 U0+Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773798622; x=1774403422; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2UiB8exyYF66Xj04GD4JD/Uzo6huFY9tx8CBCK67WMU=;
 b=he8iuv9PhWdU80Nv6gaMp+LCsWh2lQpnvZKDF4UZctFluThWDdLiWejiLMRWaChAfL
 PaBzdg4Aiqpvoor4tbb+gCiPfZUjEE9O1b456hwFlJnNzOes5iuIOrJaebl5jozUvFs7
 TvoCNpK/VV6O6YFg7ZAdiUAonGvOyn3kDDJ/FviqPh94QzPsqod7R84dwK4Oly5dDDhu
 DjRm43wrNdDhfEnzQoWHNMUkqpW8a1HUssVNbjeDfQfEOksrfXXWrosqRS+NZHcwOt2Q
 GthWoYurW8FDBC99j32DY/zWE/lc0KbpNwqiQmZ92s0+om67EwJrw7VfJcddKKtJvLOe
 ZiHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773798622; x=1774403422;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2UiB8exyYF66Xj04GD4JD/Uzo6huFY9tx8CBCK67WMU=;
 b=qEz1FVpcGxXvFiw0XDzdf8YGNKNn7iiTk+6HrUaepr0qksaC7KIFfQRnPguEciTtHE
 gxTLrkF525NZKxoPnQrCrN9hCbIjQ+5G21cDa727HKnC0ETWatiw3cuSt2p1KJGEzaZc
 RaIPCXlwuOyX0m/bCSfUpDSbj+rNHkhwqgv/4mU8Y3sJ9mpOtkbZX91arN04FyzSepnm
 CXNTTyU90hCVXYdrVKTnUwBFuahCzOmn3CISgVbz2kAha+N5qFvzwSehcngP7E8NNopO
 nUfwC3aiJbHmx+Si8Gl12sRyjfxza/T/uf1XwXG5VjudEkWgk9e6y8HU7IRzp5yWK82R
 rQVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJmxHSmJfRKgXODiOoOeNCGQ56sLzmxi9y7Q3/+BC4K1KDK9tgb3VOfAdLHkNUwOcBiOEbQhiZOsM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzcNfsDeSWtS6HjKFaND1wKk35zVgGzUfjBkw/TKMqo8g4PXamu
 Dbz5aw/glr3cgFUU/OH2JfZoiRxUqKVjKGc11lnWA6v/ZuM3mwDPG21csv8NlVKQXzOxoxAxdR2
 Q3oukq2hLwVK5axttkh6EsbAfAvQlQRofqquiscx5Cg==
X-Gm-Gg: ATEYQzxgahuiHZ/W/fp4xTWY37IcXfVU/o+MI2I/eQiB1eJg1smsmQSqfjGBxuAJ+HQ
 sc568UNfZBmBQPXEBK4626v5TnHcnPIZNL5YJYWjczEnvzURtHitdnnC/aTFSKFtrpoA+i8uqRX
 7snEixdQ2jTfmo7LMr9jW1lYZcXplQle/wJ6/9vFXHXTfku01tGafw5V9lFUlIUTBE0P1KJovAk
 3AjcrZCsuqUBXf9j5SFBqc2Iq/CTkDD9ALdjZIzca8awfP1Hs4i61ZLfuW3+9mZXFXCttw6e/H3
 iamROv4=
X-Received: by 2002:a05:6820:210b:b0:679:f16a:622b with SMTP id
 006d021491bc7-67c0da82eccmr1178628eaf.7.1773798622107; Tue, 17 Mar 2026
 18:50:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260318011426.3130333-1-shiyongbang@huawei.com>
In-Reply-To: <20260318011426.3130333-1-shiyongbang@huawei.com>
From: Xinliang Liu <xinliang.liu@linaro.org>
Date: Wed, 18 Mar 2026 09:49:46 +0800
X-Gm-Features: AaiRm508m8vhOUkDYP36TyNHvMgfsiA_onMMt8Vn7xgzeD2wWTEliuVGeY1kQW4
Message-ID: <CAKoKPby5F0WSjM75qLTVtdP2V00O+3GQvALOTiZFCWGFMjKjLw@mail.gmail.com>
Subject: Re: [PATCH for drm-misc-fixes] MAINTAINERS: add Yongbang Shi for
 drivers/gpu/drm/hisilicon matainers
To: Yongbang Shi <shiyongbang@huawei.com>
Cc: tzimmermann@suse.de, tiantao6@hisilicon.com, 
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com, 
 daniel@ffwll.ch, kong.kongxinwei@hisilicon.com, 
 dmitry.baryshkov@oss.qualcomm.com, liangjian010@huawei.com, 
 chenjianmin@huawei.com, fengsheng5@huawei.com, helin52@h-partners.com, 
 shenjian15@huawei.com, shaojijie@huawei.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Content-Type: multipart/alternative; boundary="000000000000c6292f064d42ac15"
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

--000000000000c6292f064d42ac15
Content-Type: text/plain; charset="UTF-8"

Hi,
Good to see active maintenance for hibmc driver.
I guess you guys are maintaining drivers/gpu/drm/hisilicon/hibmc.
There is a Hikey kirin driver under the hisilicon directory as well.

In case someone is not receiving unrelated emails, could you separate the
maintenance for the two drivers?
Like:
DRM DRIVERS FOR HISILICON HIBMC
You guys list here for maintainers and reviewers
...
F: drivers/gpu/drm/hisilicon/hibmc

DRM DRIVERS FOR HISILICON KIRIN
Other guys list here for maintainers and reviewers
...
F: drivers/gpu/drm/hisilicon/kirin

Thanks,
Xinliang

On Wed, 18 Mar 2026 at 09:22, Yongbang Shi <shiyongbang@huawei.com> wrote:

> drivers/gpu/drm/hisilicon/hibmc driver has almost completed feature
> development
> based on the new generation HiSilicon BMC chip. It was co-developed by
> Yongbang Shi, Baihan Li and Lin He. Going forward, this module will be
> maintained by Yongbang Shi.
>
> Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
> Acked-by: Tao Tian <tiantao6@hisilicon.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 96ea84948d76..ef3ff26ac1dc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8604,6 +8604,7 @@ T:        git
> https://gitlab.freedesktop.org/drm/misc/kernel.git
>  F:     drivers/gpu/drm/gma500/
>
>  DRM DRIVERS FOR HISILICON
> +M:     Yongbang Shi <shiyongbang@huawei.com>
>  M:     Xinliang Liu <xinliang.liu@linaro.org>
>  M:     Tian Tao  <tiantao6@hisilicon.com>
>  R:     Xinwei Kong <kong.kongxinwei@hisilicon.com>
> --
> 2.33.0
>
>

--000000000000c6292f064d42ac15
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi,<div>Good to see active maintenance fo=
r hibmc driver.</div><div>I guess you guys are maintaining=C2=A0drivers/gpu=
/drm/hisilicon/hibmc.=C2=A0</div><div>There is a Hikey kirin driver under t=
he hisilicon directory as well.</div><div><br></div><div>In case someone is=
 not receiving unrelated emails, could you separate=C2=A0the maintenance=C2=
=A0for the two drivers?</div><div>Like:=C2=A0</div><div>DRM DRIVERS FOR HIS=
ILICON HIBMC</div><div>You guys=C2=A0list here for maintainers and reviewer=
s</div><div>...</div><div>F:	drivers/gpu/drm/hisilicon/hibmc</div><div><br>=
</div><div>DRM DRIVERS FOR HISILICON KIRIN</div><div>Other guys list here f=
or maintainers and reviewers</div><div><div>...</div><div>F: drivers/gpu/dr=
m/hisilicon/kirin</div></div><div><br></div><div>Thanks,</div><div>Xinliang=
</div></div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=
=3D"ltr" class=3D"gmail_attr">On Wed, 18 Mar 2026 at 09:22, Yongbang Shi &l=
t;<a href=3D"mailto:shiyongbang@huawei.com">shiyongbang@huawei.com</a>&gt; =
wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">drivers/g=
pu/drm/hisilicon/hibmc driver has almost completed feature development<br>
based on the new generation HiSilicon BMC chip. It was co-developed by<br>
Yongbang Shi, Baihan Li and Lin He. Going forward, this module will be<br>
maintained by Yongbang Shi.<br>
<br>
Signed-off-by: Yongbang Shi &lt;<a href=3D"mailto:shiyongbang@huawei.com" t=
arget=3D"_blank">shiyongbang@huawei.com</a>&gt;<br>
Acked-by: Tao Tian &lt;<a href=3D"mailto:tiantao6@hisilicon.com" target=3D"=
_blank">tiantao6@hisilicon.com</a>&gt;<br>
---<br>
=C2=A0MAINTAINERS | 1 +<br>
=C2=A01 file changed, 1 insertion(+)<br>
<br>
diff --git a/MAINTAINERS b/MAINTAINERS<br>
index 96ea84948d76..ef3ff26ac1dc 100644<br>
--- a/MAINTAINERS<br>
+++ b/MAINTAINERS<br>
@@ -8604,6 +8604,7 @@ T:=C2=A0 =C2=A0 =C2=A0 =C2=A0 git <a href=3D"https://=
gitlab.freedesktop.org/drm/misc/kernel.git" rel=3D"noreferrer" target=3D"_b=
lank">https://gitlab.freedesktop.org/drm/misc/kernel.git</a><br>
=C2=A0F:=C2=A0 =C2=A0 =C2=A0drivers/gpu/drm/gma500/<br>
<br>
=C2=A0DRM DRIVERS FOR HISILICON<br>
+M:=C2=A0 =C2=A0 =C2=A0Yongbang Shi &lt;<a href=3D"mailto:shiyongbang@huawe=
i.com" target=3D"_blank">shiyongbang@huawei.com</a>&gt;<br>
=C2=A0M:=C2=A0 =C2=A0 =C2=A0Xinliang Liu &lt;<a href=3D"mailto:xinliang.liu=
@linaro.org" target=3D"_blank">xinliang.liu@linaro.org</a>&gt;<br>
=C2=A0M:=C2=A0 =C2=A0 =C2=A0Tian Tao=C2=A0 &lt;<a href=3D"mailto:tiantao6@h=
isilicon.com" target=3D"_blank">tiantao6@hisilicon.com</a>&gt;<br>
=C2=A0R:=C2=A0 =C2=A0 =C2=A0Xinwei Kong &lt;<a href=3D"mailto:kong.kongxinw=
ei@hisilicon.com" target=3D"_blank">kong.kongxinwei@hisilicon.com</a>&gt;<b=
r>
-- <br>
2.33.0<br>
<br>
</blockquote></div></div>

--000000000000c6292f064d42ac15--
