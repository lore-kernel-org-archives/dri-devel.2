Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D410CD3445
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 23:52:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82F0410E357;
	Fri,  8 May 2026 23:52:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dPVnWO9k";
	dkim-atps=neutral
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com
 [209.85.208.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E19EF10E357
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 23:52:15 +0000 (UTC)
Received: by mail-ed1-f53.google.com with SMTP id
 4fb4d7f45d1cf-6763cc8775cso6427738a12.0
 for <dri-devel@lists.freedesktop.org>; Fri, 08 May 2026 16:52:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778284334; cv=none;
 d=google.com; s=arc-20240605;
 b=K0Odu9YCVRag9eO2ah4YskdtSCiggyAdz249PBpBMas/5jTTuJguz8NDMNfs5L0CQX
 MxvMxUBCfY+mJo4U13wtePcSfWADjMTUOyzUYdS1/iue6hUeRg/uQnIPZhXy5h9XpPPt
 EczyQ98+8xf1PNXbFHj3ol/lToWjnfj/d35vPOuRjgzQo7v5beXhBuOP2jBjganNhVOB
 1YcVJfWJID6si2nkwAUL/v/zPZGZE/zCDFtLhkcKOnAI8d2X5+JsceVymYZjHCpnkyVl
 Aks7cvf9LIl53HeYtSZmpz+1kk74ife22JqG+5nLS+3GmdTwE6zbQRxcePui9BJZT7zq
 tJwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=bfUJYPElooEQ0PbhNo7iyBccMbFYGoXfO0G+smDR5u8=;
 fh=9OoQHUe+eIBMOfr2C/DwlHn8LzMIuFu+J8Njs+INvyk=;
 b=J/GAEzcMgAGkZu3Q567JcThMRjtvRB6Kokzq1yWZkDqEB27SeznZ8lIFvz8E9AzesG
 b3MjW969mMNKa04s9Ldvat6+aWJXCF+rgR0W2fTysIbs4PcJQ+Mm9b7/5nd1Wg8Xo46f
 Atiq+5utA/c2/Wo/NTzNnhsfGHWRn1TmU4ctwWStO28VX1Ay31yxaEeLK+ZhnXzQ/Vn4
 a9l1o40O+YWBujBBjmSfJ7GeC1PCgT5O38LXPG44x7WTjKz9UaBE2KKsltnEBBBpuBBp
 eVvZbcx6lf7bqXbHOaSeeXm0304WibCsOdbQcHp/rdkx1rT5VP50s9lHEb2llkt+z7Rt
 Tltw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778284334; x=1778889134; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bfUJYPElooEQ0PbhNo7iyBccMbFYGoXfO0G+smDR5u8=;
 b=dPVnWO9kruQ2zDm7mi8HPWjWWEewaqg0jWAA107jKsDe4ubOj2skUwc2OF9d2CgJVk
 RUGwc+UjlZWr1qVlyb5XRJ/5pfiyQ0WLd3zByPl5wSgqw91mU0WZ6kaSlaqJ0ljoDQ6f
 Kx+NsU09N3YdmYvWkjm48k8pnZGjnW8A0K+qfyZIi4+WdJMRh1DFxnMlOmSTMWCSHEYr
 kBJUvRNFyT4m2YoEbezKUhQJtpn+COhxO3GUYyrZR2K0jq8LTbkhR1iOnQM3UpCJbWeA
 4uuqvcbkLKv+yd5UVXxHGPinsY9LXDRATP9MNMOrbgl4tXfKCU+0iwMjvtYY4JgupIDO
 2WgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778284334; x=1778889134;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bfUJYPElooEQ0PbhNo7iyBccMbFYGoXfO0G+smDR5u8=;
 b=Mh2OBubcmJMTRo0y6vfGGPHtHDIrzdG+saaH/3ejeSeIYVX4FO7c/bQSUJGvdGXndg
 lXKHTH38YUiASH3vD+ijjMGebhkfYF2l4LrmTqUZiyac8w+NvyBRPI/C+hdMvjUeLfh/
 19FIRsHQoibtjJNED3pKQywIfjXTOrgU2mcfsM1Gz/hEa04nPTzuudiaTOWWN+dHCiXV
 Wjn4A3p01MC7ZWP8B0LnyOGWocFgWdxvbpYDPhKZBl/ygfYrlA16Jr3LHBOgTckC8E+S
 fvvq/qSSidctPdD0Y00v6/F0+o+4R3B+xH3VV8QGVLWKkzebA7sxlC3zU3Du3cBLN4fm
 q+Uw==
X-Forwarded-Encrypted: i=1;
 AFNElJ89Ev1LjA7o7bx37gsH3Ur9/0IpbRbNMhfPiKeH7KojhO9wUJwIzuZCdmUB9WPIe0xdYo5PzzP6prk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzZazTqTc9QEcX20ac4CuP9nCViRlGupaFP3oQ7j5WQQHlHzg7o
 jF3Im1bkoEsERgBtP2LJFHzRp8V90PjqbOuSxQ+nsbCvRZ07yvn39qvO6l8/5+NwLs6Ru3HTvOO
 mNKgFxtnt7+ZdPGuqARh8ML5Lm84Yww==
X-Gm-Gg: Acq92OHwIQ1qHsVJLOZrxyuT3b74QnSUgqCkB+7afgWB2VgGzgXNCSLFzgqK4CPfT15
 bLZINY1mkT76U6MU3NqtCdym9R6r3h9nZBwPg5uHbUTlTwOB4eZoYRPKE2djmCzwB6pQqfp3pye
 TTN1uuGYloK9Z8oaAB+vmHLYSBUHip5TW2y5j9eQZzh0+TACpWCR4Zb9szLNz9RDBB2Q7Ik3Hjy
 ZLmeb1b/IWJYWrczNiuqeDUrl83KEL/Hd+jDLUtKP7NkNRa+d2RYQUHlZrWu8XKQCyWbWwHz7Dq
 Lc5CRH+qzUD7zuJeSsCA+B7K+csi5q5Wrs9R
X-Received: by 2002:a17:906:9f91:b0:bc2:24f2:5b8 with SMTP id
 a640c23a62f3a-bc84cc72eeemr517401766b.6.1778284333989; Fri, 08 May 2026
 16:52:13 -0700 (PDT)
MIME-Version: 1.0
References: <da9ecab6-063f-4c29-a685-7b776234905a@suse.de>
 <c565ab8a-edcd-48fe-8ae4-e788febb4208@web.de>
In-Reply-To: <c565ab8a-edcd-48fe-8ae4-e788febb4208@web.de>
From: Myeonghun Pak <mhun512@gmail.com>
Date: Sat, 9 May 2026 08:52:02 +0900
X-Gm-Features: AVHnY4Jko-8G6U0Gb2SQ5ayGT0Spgyl8Qx_Ej1YsnV2cPioWjRwqRCCMEeUinvs
Message-ID: <CAGEsz8E7tc+GUh8vHw9ZQ3TFOvG2oD9mvGNq=yAxjhu0fNsoAw@mail.gmail.com>
Subject: Re: drm/bochs: Drop manual put on probe error path
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, 
 virtualization@lists.linux.dev, David Airlie <airlied@gmail.com>, 
 Gerd Hoffmann <kraxel@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Simona Vetter <simona@ffwll.ch>, 
 LKML <linux-kernel@vger.kernel.org>
Content-Type: multipart/alternative; boundary="00000000000009837f065157165e"
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

--00000000000009837f065157165e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Markus,

Thanks for the pointer. I will keep the Fixes tag on a single line in
future submissions.

Best regards,
Myeonghun Pak

2026=EB=85=84 5=EC=9B=94 8=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 4:43, Ma=
rkus Elfring <Markus.Elfring@web.de>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:

> =E2=80=A6
> > > Return the probe error directly and let devres own the final put.
> =E2=80=A6
> > Fixes: 04826f588682 ("drm/bochs: Allocate DRM device in struct
> > bochs_device")
> =E2=80=A6
>
> See also once more:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/process/submitting-patches.rst?h=3Dv7.1-rc2#n145
>
> Regards,
> Markus
>

--00000000000009837f065157165e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Markus,<br><br>Thanks for the pointer. I will keep the =
Fixes tag on a single line in future submissions.<br><br>Best regards,<br>M=
yeonghun Pak<br></div><br><div class=3D"gmail_quote gmail_quote_container">=
<div dir=3D"ltr" class=3D"gmail_attr">2026=EB=85=84 5=EC=9B=94 8=EC=9D=BC (=
=EA=B8=88) =EC=98=A4=ED=9B=84 4:43, Markus Elfring &lt;<a href=3D"mailto:Ma=
rkus.Elfring@web.de">Markus.Elfring@web.de</a>&gt;=EB=8B=98=EC=9D=B4 =EC=9E=
=91=EC=84=B1:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
=E2=80=A6<br>
&gt; &gt; Return the probe error directly and let devres own the final put.=
<br>
=E2=80=A6<br>
&gt; Fixes: 04826f588682 (&quot;drm/bochs: Allocate DRM device in struct <b=
r>
&gt; bochs_device&quot;)<br>
=E2=80=A6<br>
<br>
See also once more:<br>
<a href=3D"https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.g=
it/tree/Documentation/process/submitting-patches.rst?h=3Dv7.1-rc2#n145" rel=
=3D"noreferrer" target=3D"_blank">https://git.kernel.org/pub/scm/linux/kern=
el/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst=
?h=3Dv7.1-rc2#n145</a><br>
<br>
Regards,<br>
Markus<br>
</blockquote></div>

--00000000000009837f065157165e--
