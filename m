Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B90D606A33B
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 08:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CygY3BNQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F14C10EB88;
	Wed, 18 Nov 2026 08:42:56 +0000 (UTC)
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com
 [74.125.82.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF29E10EB88
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 08:42:49 +0000 (UTC)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-381d542bc29so1438449eec.1
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 00:42:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794991369; cv=none;
 d=google.com; s=arc-20260327;
 b=N/vCun0UYeeGU4e8SZI81bW3qnFVNR/AaSf6JFveKMwzfcypt+tKJXm3TSzW8oROhq
 MUmhlOPnVOzHU9MUxfdzLEkvtXqzuExl/hp5Qf4ZUQZSpPrBjeTz1XmaQlNR7kp0W1Ef
 lKxAVjjITlD35pLgS7pOp4qFwLG4pj1olpgzTWbB7CXUMJAyT/4IhIqhMNc5bN9/i1Zg
 h5nzPW0SRJOUhgeSPozOUvGoHOC7Vf918Kl1HCkdrQtN6SA6Ob2XGRTJshAI5OOkMRyl
 ZXcLhG2s/LxWCRQL8vosw84PNJKwkr6LMSyjtfftkZ585v85m/Ft5Z6IrY69Sb7Ilfr+
 EHCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=nQa9Ic+T3I7zvF7zGvK+FXBolcSue1wz7E0rEL5qz+k=;
 fh=7BAG3lOJGryTZBqsnEQbzrM3j3IL9jnWXBHIfSyAmJI=;
 b=UcyB7UcXbE0uJVCficEZvybHmzluM/9Wz2ktXw1e5aB1OEFn3D5GWI7a93MSqH9DWc
 TraJ9nIWFsab9nzMl/uX9Wiaa0mtbHpcHpKDyaPSWsH8qbSvIMFjzrWLTypsILcUv/Hy
 V1wiWEZnRSkVwnZh6zeSslyS4ysLdAIOK6GnQLQgTmk038Rim847fw4yMAe2SICdnAJY
 PLJFpCDwyuvNF5dP/0NF9TZuQf9xoVQeRsKeKG7JUD3x56bao1+w0iysm6WmJObT6Oyt
 th4UTL5cNt7VGyJGmITXyBrSdSPKaQpUgkA8SDIJCuzKloJ8chqXXThvpK8pUxRFKcV3
 WiZA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794991369; x=1795596169; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nQa9Ic+T3I7zvF7zGvK+FXBolcSue1wz7E0rEL5qz+k=;
 b=CygY3BNQKGNjGWOlcebWVuyZ5CSHZAJvivPvsCGE+XM73n2yPwYuZvD7WQSyYNwqBl
 xnFunMM3cFkW/Qw3e7mP26T6ctMw0NVoe60svZmixeVQytzSEwCJ6I2o6Sj5NjTl97zs
 cYZNuY6h1qw4td1s6r4gso70NvgpQIe0+AOImBDjV2RRFbcGAXtP9n7di1HflD0jLuC+
 hYfZIInODSAPTTFkafz6txDmHST8acX6vkj7M+r0PFR6BJwPygDcvYeivLYbFNzqXkVb
 mMyogDFoEZmapHvDozQrCnwZbuRq6vbFw00EbAU+1H/R9bnrfRAkHy2Dxxitr8lyNWLJ
 A2jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794991369; x=1795596169;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=nQa9Ic+T3I7zvF7zGvK+FXBolcSue1wz7E0rEL5qz+k=;
 b=YR74vhP7imSE2a/NfUi2aTFeYYg3lpP7BuiPitv3uG1zbP3sIz5NxTPhjG+MSKLzBv
 4Vd/2vsDyqBuESA4gdMNDVFi1ZmqyYCDRu+R6waHEqhwUFzNSHSVtMiM2PyCx/4bbGMT
 PPp06YfSGyYUgjq0V3iMWynsVkVmRFI7rPnbrK+lB9kDgDLAy3NDR43CL4wu8JIHJ9X7
 hINs8rpyIjxSirn6p/P/6PzkQZNZCvQ9zd8ppvQbzFZYN8x4Z0bddYwrU6RzIB5Q4JRa
 oD2KZ7YlXx/XkGCdq1yWoHlpMA1WJO4JndhSmiCQYhdPVomgQ+NPjzeq37oyxnlgvAaN
 vkrg==
X-Forwarded-Encrypted: i=1;
 AL+hErFhe2Cdh4yIuT5Ndfdunq/WDqJtep8sI3CE+w5Ag2KEIjrVICvgceSKFZ0VE5E1mJGcK+FMLAuTmHs=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9onjGIr+FIds1EysIO2+d3uQ2yWtqIMnLt+q/s91/DjRcvFgN0
 ob6jKa5niGzohlIqsYLRITJVmEGz7Pq3hAhS7cdOBDkysnURwWnd0YBicXLwi1bwIf7PgC1reLW
 7ZDe5gfvwvM02aKZt1Ei/MDh7M9DHb/s=
X-Gm-Gg: AZFdTZe+E0xXz52DKL3e1dokb1Pl4t6AAG9XKpncSyVm/8Ny1RiVGREGim7xaVQOXqZ
 X6n/mvCfZ0UYztnttzeLLNMH2cM9FE2lVFZBj5RPxLfcnLoArgdrN2qVFWCQban3ynFKFj4CCxX
 1scNI0YDhMKymTGYV1fvN0oXP0eP/OfnhWaU2rKWkdTUzgzuFWYIdCkhivGavlLR7g4hvYdTKom
 /NVz4/j7jbIq5NtR9BiW7Ic2FH1Mp2rqEwaP9O9K7s9Fomfmo8KUgR/SHoiJcWt08lUcA+imnUC
 H4+ZGXxTKhY2MwqHnR5MKsQurJMJ1ILqGngovzUolSGRsS1dfUXAUzbNlvhAmrhKjB+Q8Cz20w9
 tKmcbQreTkmjYyy1MBT2ySqx9KFjLALr2987X4Q2rFVyWrVRcRNa/ySeDZDxv75E4LKaLpyvO5+
 QtI73W7ZfUXd3ibEu4FB7EmYBYM9n7UQ==
X-Received: by 2002:a05:7300:8342:b0:383:50b7:1d78 with SMTP id
 5a478bee46e88-38350b7232amr298181eec.40.1794991368752; Wed, 18 Nov 2026
 00:42:48 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261107-batch1-b1-host1x-wait-v1-0-8c8198adf600@tubot.lat>
 <L2SDRXLsTSiAzYTWAeJY9A@nvidia.com>
 <20261118000633.2701912-1-DelaySystem@tubot.lat>
In-Reply-To: <20261118000633.2701912-1-DelaySystem@tubot.lat>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Wed, 18 Nov 2026 10:42:36 +0200
X-Gm-Features: Aa3M54oJnvez2Jo2earpAtXkYE-48LqgK6b7DZunq-ZxRfACQZMnFvW3Vkj6gxI
Message-ID: <CAPVz0n2WPq4Pd1sh-km0aVDmnf=C+rG+FeyvHMzckshy7WUwJw@mail.gmail.com>
Subject: Re: [PATCH RFC 0/2] Uninterruptible host1x syncpoint wait for Tegra
 video capture
To: Maximo Manriquez Lizarraga <DelaySystem@tubot.lat>
Cc: Mikko Perttunen <mperttunen@nvidia.com>,
 Thierry Reding <thierry.reding@kernel.org>, 
 linux-staging@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 luca.ceresoli@bootlin.com, gregkh@linuxfoundation.org, mchehab@kernel.org, 
 linux-kernel@vger.kernel.org, jonathanh@nvidia.com, 
 linux-tegra@vger.kernel.org, skomatineni@nvidia.com, 
 linux-media@vger.kernel.org
Content-Type: multipart/alternative; boundary="000000000000e8d195066088feec"
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=1.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_IMAGE_ONLY_20,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000e8d195066088feec
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=81=D1=80, 18 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 02:0=
6 Maximo Manriquez Lizarraga
<DelaySystem@tubot.lat> =D0=BF=D0=B8=D1=88=D0=B5:

> Hi Mikko,
>
> Thanks for looking at the RFC.
>
> My name is Maximo Manriquez Lizarraga -- I previously posted as
> "DelaySystem", apologies for the confusion. Future mail will use my
> real name.
>
> Your nak is noted, but with no rationale I don't know what sank it:
> is it the _uninterruptible() API shape, the tegra20-only scope, the
> approach itself, or something else? If you can spare a line on what
> needs to change, I will revise the series or drop it accordingly.
>
> Sorry for the noise either way.
>
> Best regards,
> Maximo
>

Quote:

> The tegra20.c change itself has no compile coverage here: that object
> builds only for 32-bit ARM (ARCH_TEGRA_2x_SOC/_3x_SOC) and no ARM
> toolchain is available, and there is no Tegra hardware for runtime
> testing. Hardware testing help is needed before any final series.

--000000000000e8d195066088feec
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><span style=3D"background-color:transpare=
nt">=D1=81=D1=80, 18 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE =
02:06 Maximo Manriquez Lizarraga &lt;DelaySystem@tubot.lat&gt; =D0=BF=D0=B8=
=D1=88=D0=B5:</span></div><div class=3D"gmail_quote gmail_quote_container">=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex"><div> <img style=3D"displ=
ay: none;" src=3D"https://bbcihfgh.r.af.d.sendibt2.com/tr/op/qucurBjVdKbllN=
CmOBcNXsRnOpVMYLDOeBXj7Et1D-STS2zfHES9QFoMuFoow5QhWBtS9i-8KsOY_dk4XCTsuSVDY=
GalAL0Ru_fbTxjkBfatneuIAi-eAAB6LGH7NHZLT7kqx1c7QyTVzmhb_6bj7kwGRU79MjqbYfCq=
qLTb4Y5hkkHaKf0rJVKvuemsyAPQoz-RGd_awvb3I2cZmJQ_65rFoyM"> Hi Mikko,<br><br>=
Thanks for looking at the RFC.<br><br>My name is Maximo Manriquez Lizarraga=
 -- I previously posted as<br>&quot;DelaySystem&quot;, apologies for the co=
nfusion. Future mail will use my<br>real name.<br><br>Your nak is noted, bu=
t with no rationale I don&#39;t know what sank it:<br>is it the _uninterrup=
tible() API shape, the tegra20-only scope, the<br>approach itself, or somet=
hing else? If you can spare a line on what<br>needs to change, I will revis=
e the series or drop it accordingly.<br><br>Sorry for the noise either way.=
<br><br>Best regards,<br>Maximo<br></div></blockquote><div><br></div><div>Q=
uote:</div><div><br></div>&gt; The tegra20.c change itself has no compile c=
overage here: that object<br>&gt; builds only for 32-bit ARM (ARCH_TEGRA_2x=
_SOC/_3x_SOC) and no ARM<br>&gt; toolchain is available, and there is no Te=
gra hardware for runtime<br><div><span style=3D"background-color:transparen=
t">&gt; testing. Hardware testing help is needed before any final series.</=
span>=C2=A0</div></div></div>

--000000000000e8d195066088feec--
