Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38ED606A321
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 13:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zwnWfZ2p
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 316E6898F0;
	Wed, 25 Nov 2026 13:27:35 +0000 (UTC)
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com
 [74.125.224.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE9C4898F0
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 13:27:28 +0000 (UTC)
Received: by mail-yx1-f49.google.com with SMTP id
 956f58d0204a3-67db5e13b0cso5202391d50.3
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 05:27:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795613248; cv=none;
 d=google.com; s=arc-20260327;
 b=GmWgT0Nq2c+yKqS/t2A4oTA8Qcbkw69L77siF9VkbuZoK579A9gAt34wOlp6QWJwHI
 6JNFqs4VXp85vYAjqh6Kf7TQNWWe65EnPY0isAr+JgSRP/owU/eTrXna1EcXuZXGEECH
 hCUdVwUqM/XgQ56W6goCjkhSiKVKgFpiKp7gVl1CHWOkENTaygxgmkTpdBSXnUnFvTSN
 NUxFt365SmoDQz8RfgvF60AzNHFYNZoGNfHY7zIvrm1qGpXEughisghX1IBwOypL69Cn
 Wuq8Cvcvl2S+SMJ0u0k8Tz0AVm3oUA1vtrvp3RSeiWfwVQehj21uYDilx1mwSfqmKO6m
 R7sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Sl6mGgE/ttInmv/fjNmjdS4M93v/ItiESXSR1E5ekm4=;
 fh=bQY16w2PC2FrAWduyYUaypXtsGj/Cqmt3dBMT66V5qg=;
 b=sc7uQt5uWI3SD6lCAyWUquCUN9TsraCldHjk+zLtwCbLhCo+a6DSTfVcBjP+PZt8HG
 LnKEhZKN7YFb5BHFaVAwofFGSyDeWc88hwDj0gTvG4VDMaYrg/U+KD6Dr1jcEqvAbAqK
 pty4oMmVxyj5f9Z2mTk3cj6//Kf806fLgu/F2W+jucOepLRKyOJUsJy2XctjKC1DnfNQ
 FivvzIrSBjO7QFO1Iuj3mim9vJK5Nb8k6xhjwQbZwiYyX72TMSqAkebKasjly9zPLJde
 XgCkLAb6jxIVMNDFAkJHRoMtqYIa9GgkONMuRQSkydf9UYJKdgNmFlriAQ4UA2JMztAz
 ZsPQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795613248; x=1796218048; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Sl6mGgE/ttInmv/fjNmjdS4M93v/ItiESXSR1E5ekm4=;
 b=zwnWfZ2pgqG3B3rVIU0nqGWCahbx0kIW331u9oKss9lHdXxRsgIkfswumC/QhKXbL4
 aP7ytZX6yOMEW5lPu3lMAdisckL4l9XAipnlEtt9ey+dLRKaVUpbUfH30PpRAVzoPTjc
 t8f6Uag8/Tzu/0VkgBFRgINPTKXRTpy0Dk6m1qRMuxSq/ipvnpxav1WOT+3EMXy4eQ8v
 +NzYWBE4NwfLpepkouFQcBbIzbqeQckwE6aFLKruPUly0jeKcGypp99q3UGpBnx3+oTs
 hfhKOrCODJq/Qsl+QCMnxMbJTsujOw3+mdBgyzsOhTFelzGdn/gzFBjwPC0gHkMm3WYe
 FSHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795613248; x=1796218048;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Sl6mGgE/ttInmv/fjNmjdS4M93v/ItiESXSR1E5ekm4=;
 b=BmeP7kuTVB8Lf1ofRlZNDS/qU+fngBEO7M4je7OJ43lNEatE5QLld6VHsW4LOH+Y9k
 n3PXOfZVVGO9mbgljhLnqFl2uZaPL2iCYvKwiUaugDpSHrKOyGgzE3Wzymxgt6kiEyxS
 EAM/iyBZyd8Cu8Kvv57QCcTWxUWoVorWZxCgLcOPDnlRWNLrPjfHgVanYNT9cvSgrJ15
 VfntSjbe45/WuoLT4uKX52JbgOF+iEIdLj/Cg5Q/mLJdFB3FpwRkvDhg/w/xWBVGKAut
 hslXsGirM32JypVShO113GYF92ojc1GXLKyEJB3MgZZkrv/bgBHcplwa2/5WGQsE0Z9t
 bQ4A==
X-Forwarded-Encrypted: i=1;
 AL+hErGUOJZ3mDl3qY+B8avMvWKoUZypqhW6rs3R8HsDm+HazDfFU42U/fBXJA860IaqE1TRKZtfdEM+I0Q=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z//ZORx7uSZjqrKbvaXb6zF+ySCF/YfuFx/8QU4zL/2ittzm5wf
 Rut/5LzT61M0DMdY2KzYva2sjia4NVIQHxdfz8rgkL8o+23POIvzwN0xOH+q3Fk5Raj6SNT3s68
 spOdfelrmluxzvP7nO+zXVZqNwWIAaNk=
X-Gm-Gg: AZFdTZcdNUvdk9eaiYOgqO3teaHVqc1QgdxZDDlmbtqnBKTqcBlMZ8+v/KgNvQ8l99c
 ivOeKHi/Zq/D9RxOnd4E6EGqiTjVY7YdhuXOi8LI6heJ9ed+KKW8uVfBxiJYVUDLwHBEGnFfzz+
 vW9kYSuk/x8VSjTMXTna2Y/SKRCSa/IC8Z3xB6HBcxD3V2vB+8yUOhdBKndkFGou83MjrJ7JFRZ
 Ds3+3vRZLRReiMcM6+zMJfQv5lfFumMwsouzCXzQFo3KnXl/kvXqq2GCOHT+19ysFDyhgZg/KKT
 mfcrru+iXTi76plCPT7wyJ+2okmutBHiloV9cGTUFPudiWkVyHoVLt/0+gdhM/xPaYJN8zsqnDH
 awpNOM5gVBhPN8tk9DM+bEo9wHefbsnqN3Qg=
X-Received: by 2002:a05:690e:4085:b0:67d:bc4d:451c with SMTP id
 956f58d0204a3-67df450c314mr6143919d50.96.1795613247674; Wed, 25 Nov 2026
 05:27:27 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261124222812.511867-1-eduardoprocopiogomez@gmail.com>
 <114377fd4c275215e40c3991bb935b8c41aa3d36.camel@linux.intel.com>
In-Reply-To: <114377fd4c275215e40c3991bb935b8c41aa3d36.camel@linux.intel.com>
From: "Eduardo P. Gomez" <eduardoprocopiogomez@gmail.com>
Date: Wed, 25 Nov 2026 10:27:15 -0300
X-Gm-Features: Aa3M54ohoEBEf4I4DFoZVkf39MCDlQM2NZBELiCU7sMCYyv2SUs1-87mZAjoDRk
Message-ID: <CAKL2PNo7Vp7O4FRWGPV-ZuSqk60B4xh4pXUzcgYEEdqm_sUemg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] drm/ttm: fix excessive idle memory retention
To: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Cc: Natalie Vock <nat@pixelcluster.dev>,
 Arun Pravin <arunpravin.paneerselvam@amd.com>, 
 dri-devel@lists.freedesktop.org, Matthew Auld <matthew.auld@intel.com>, 
 Matthew Brost <matthew.brost@intel.com>
Content-Type: multipart/alternative; boundary="000000000000c81d87066119c982"
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
X-Spam-Status: No, score=0.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000c81d87066119c982
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

(sending a copy to the mail list)

Hi Thomas,

Under memory pressure, the existing shrinker indeed worked in my unpatched
7.4-rc4 QEMU test. It reclaimed all 768 MiB, and the competing allocation
completed.

And yes, I'm actually facing out of memory freezes on my 32 GiB desktop. My
early investigations showed GPUReclaim was using most of my RAM (the test
repo is the result of my last test before creating the patch). The tests
shows GPUReclaim stayed at 12.25 GiB of 32 GiB for at least 60 seconds
after the reproducer exited. In a separate 8 GiB desktop run with v3, it
dropped to about 128 MiB by the five-second sample.

Once the allocation burst is over, what benefit do we get from keeping the
full pool until memory pressure, compared with trimming the excess after a
short window for reuse? My concern is the cost of reclaiming a pool that
large when another workload already needs the memory.

If you=E2=80=99d like to try the standalone reproducer at 8 GiB, I=E2=80=99=
d be interested
to see how long a competing allocation takes on the unpatched kernel once
it needs memory back from the pool.

Thanks,
Eduardo

--000000000000c81d87066119c982
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>(sending a copy to the mail list)<div dir=3D"auto"><=
br></div><div dir=3D"auto">Hi Thomas,</div><div dir=3D"auto"><br></div><div=
 dir=3D"auto">Under memory pressure, the existing shrinker indeed worked in=
 my unpatched 7.4-rc4 QEMU test. It reclaimed all 768 MiB, and the competin=
g allocation completed.</div><div dir=3D"auto"><br></div><div dir=3D"auto">=
And yes, I&#39;m actually facing out of memory freezes on my 32 GiB desktop=
. My early investigations showed GPUReclaim was using most of my RAM (the t=
est repo is the result of my last test before creating the patch). The test=
s shows GPUReclaim stayed at 12.25 GiB of 32 GiB for at least 60 seconds af=
ter the reproducer exited. In a separate 8 GiB desktop run with v3, it drop=
ped to about 128 MiB by the five-second sample.</div><div dir=3D"auto"><br>=
</div><div dir=3D"auto">Once the allocation burst is over, what benefit do =
we get from keeping the full pool until memory pressure, compared with trim=
ming the excess after a short window for reuse? My concern is the cost of r=
eclaiming a pool that large when another workload already needs the memory.=
</div><div dir=3D"auto"><br></div><div dir=3D"auto">If you=E2=80=99d like t=
o try the standalone reproducer at 8 GiB, I=E2=80=99d be interested to see =
how long a competing allocation takes on the unpatched kernel once it needs=
 memory back from the pool.</div><div dir=3D"auto"><br></div><div dir=3D"au=
to">Thanks,</div><div dir=3D"auto">Eduardo</div></div></div>

--000000000000c81d87066119c982--
