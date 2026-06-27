Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECB1DC44500
	for <dri-devel@archiver.kernel.org>; Sun, 28 Jun 2026 11:43:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66EA610E5EF;
	Sun, 28 Jun 2026 11:43:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MftbYGM6";
	dkim-atps=neutral
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66EFA10E4AD
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 11:08:41 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-4631679f204so1558234f8f.0
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 04:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782558520; x=1783163320; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=ObOon2kzTgKHW6RZx9jmA2j/cHKWzfVWiGy6Z0RnmY0=;
 b=MftbYGM6h/U2MtO5PR80lxT6iV7gLqk1A62GG940Lz6Vj9D1Xu3lvrrqa3dtWA8tAW
 AFVSvUaEZq5aEnpxXhqUeYCwt1COmqaV2ip22nGPLAvwlneJfOvjWTe4hCB0IuKaa/QB
 vFMm7nyq+HJbUt2S5370OaG24JFIC/mkgZImJxJ8m7lJK9ohllrypQixzl57d5O98UPx
 Legm3TJGPwmy8RVg1IqhD4YU1zX7NTcIkb9s+QgI4DTCraRLHDccY/GN9u4+TIND7j3q
 4aofEQSdHN0ufMlh2dRVljkS6e9JtqAyfRJ0QZmjTaViF+07Cqyc0TuapSHiSf4HydS+
 acYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782558520; x=1783163320;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ObOon2kzTgKHW6RZx9jmA2j/cHKWzfVWiGy6Z0RnmY0=;
 b=RCn7RqR0bml4ca+p/tHOzQzSncwI5RoOPbCRhm+QpPx/TWPAmCRvs5sTKsO1QeRw+T
 sjZ+7Ip7vUURHO4jfje9TDLRD+K3MIMsfLZ9NuCLRrsSqPegyiLwIHW79wQk4xZsv839
 PWmOpsxdheOeBujHTXQ7w517vWQCVZZXNH8BolrTczeR/NuFaAjCA2I1NDM4ynHUdAPJ
 Z/Sp0Dkg9x7o/t13YXckn8bIoE+DZyYQhzgkBTgsqeHw6BQARSImIy+iYTmVOOYDyt4O
 cEms+V91b4NGuw+zFhaE3VbGan3lY/+/qsQ7Sp9OKp5n8JGPncKQhjVq3lD+6nyNVfl8
 lPMg==
X-Gm-Message-State: AOJu0YwSjZekQjtzKN0CN1XdiTI1eujXpKMLP0gRP2OjSGnZVo3Ydquy
 E+tosawK9xUwJoybbGr7HFZMJamCtWiRiEHZxYe6PdVOirt2m/FmBLtG
X-Gm-Gg: AfdE7cmMAK8OsH1VvoSOvsl7+2uT6YFOAZWB0qaswXN6wc/j5fpSU8vHzh3cg1snTQt
 13bmZDo13bjVwDkKBtEmMGs7JXCjaU+Vo90dr3lWxXyQBkLI1BXutiX1Lgwadnj4i/pUjcdKFgN
 9+YbEseGGY0QcBGUdZM9jtap3p9dbLD3chpmBzAl8yQgQr1UAlBi5IQ7tyxKzUz1WU3F6xcQYII
 LOFUbcimLc1+FLbRv1ERkwCIJwPJmTyUTRnIiwZowbi+6eJHR2iecdEWgnkfmNwzSzl68rAECv+
 P2qMXLsWnfPo9LOUOOTt4UMCXl0RFJJDh02f20oIAPwop8ppYW2X+aj3xJzBB1bR2fAcDhly+cL
 ZRVNpGZGERckkeESXgGvdePg9qO3SPCrhl9U6XENkwS0G/Y0BNBaE//gQsgpLTEvq2lYHNKus4G
 Zk2VwPB2sBS2rIAeUQ7bZw3adwy68TkETFBK0+ATgnkcCBxDVJvKMuIG8AMZ5gcY0=
X-Received: by 2002:a05:6000:240f:b0:46f:8082:157d with SMTP id
 ffacd0b85a97d-46f80821678mr7221733f8f.28.1782558519708; 
 Sat, 27 Jun 2026 04:08:39 -0700 (PDT)
Received: from ehlo.thunderbird.net (046125148194.public.t-mobile.at.
 [46.125.148.194]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c2279b85csm30711373f8f.28.2026.06.27.04.08.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 27 Jun 2026 04:08:38 -0700 (PDT)
Date: Sat, 27 Jun 2026 13:08:37 +0200
From: Diogo <diogompaissilva@gmail.com>
To: =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>,
 Chen-Yu Tsai <wens@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Samuel Holland <samuel@sholland.org>
CC: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/sun4i: Remove dependency on DRM simple helpers
User-Agent: Thunderbird for Android
In-Reply-To: <PMdb9FVETQuPUnyh12NM2Q@gmail.com>
References: <20260623-sun4i_simple-v1-1-fa6696df1fad@gmail.com>
 <PMdb9FVETQuPUnyh12NM2Q@gmail.com>
Message-ID: <E55CF3A9-BBCC-4F76-A070-FD64E71002FE@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary=----BVVO9ZOEX9VOSGAV1PTRJN88O58JW4
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Sun, 28 Jun 2026 11:42:36 +0000
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

------BVVO9ZOEX9VOSGAV1PTRJN88O58JW4
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hey,

I saw the task to open-code the drm_simple_encoder_init in the DRM tasks, =
and thought that sending individual patches for each platform would be the =
easiest=2E
Thomas Zimmermann, is it ok if I do all drivers at once as a patch series?

BR,
Diogo

On 27 June 2026 08:55:04 CEST, "Jernej =C5=A0krabec" <jernej=2Eskrabec@gma=
il=2Ecom> wrote:
>Dne torek, 23=2E junij 2026 ob 22:34:40 Srednjeevropski poletni =C4=8Das =
je Diogo Silva napisal(a):
>> Simple KMS helper are deprecated since they only add an intermediate
>> layer between drivers and the atomic modesetting=2E
>> This patch removes the dependency on drm simple helpers from sun4i
>> DRM drivers=2E
>>=20
>> Signed-off-by: Diogo Silva <diogompaissilva@gmail=2Ecom>
>
>This doesn't look as useful change=2E Is this tree-wide attempt? If so, i=
t
>should be done in one go in one patch series, coordinated with DRM
>maintainers=2E
>
>Best regards,
>Jernej
>
>

------BVVO9ZOEX9VOSGAV1PTRJN88O58JW4
Content-Type: text/html;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head></head><body><div dir=3D"auto">Hey,<br><br>I saw the task to op=
en-code the drm_simple_encoder_init in the DRM tasks, and thought that send=
ing individual patches for each platform would be the easiest=2E<br>Thomas =
Zimmermann, is it ok if I do all drivers at once as a patch series?<br><br>=
BR,<br>Diogo</div><br><br><div class=3D"gmail_quote"><div dir=3D"auto">On 2=
7 June 2026 08:55:04 CEST, "Jernej =C5=A0krabec" &lt;jernej=2Eskrabec@gmail=
=2Ecom&gt; wrote:</div><blockquote class=3D"gmail_quote" style=3D"margin: 0=
pt 0pt 0pt 0=2E8ex; border-left: 1px solid rgb(204, 204, 204); padding-left=
: 1ex;">
<pre class=3D"net-thunderbird-android__plain-text-message-pre"><div dir=3D=
"auto">Dne torek, 23=2E junij 2026 ob 22:34:40 Srednjeevropski poletni =C4=
=8Das je Diogo Silva napisal(a):<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin-bottom: 1ex; --net-thunderbird-android__blockquote-default=
-border-color: #729fcf;"><div dir=3D"auto">Simple KMS helper are deprecated=
 since they only add an intermediate<br>layer between drivers and the atomi=
c modesetting=2E<br>This patch removes the dependency on drm simple helpers=
 from sun4i<br>DRM drivers=2E<br><br>Signed-off-by: Diogo Silva &lt;diogomp=
aissilva@gmail=2Ecom&gt;<br></div></blockquote><div dir=3D"auto"><br>This d=
oesn't look as useful change=2E Is this tree-wide attempt? If so, it<br>sho=
uld be done in one go in one patch series, coordinated with DRM<br>maintain=
ers=2E<br><br>Best regards,<br>Jernej<br><br><br></div></pre></blockquote><=
/div></body></html>
------BVVO9ZOEX9VOSGAV1PTRJN88O58JW4--
