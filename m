Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24309D35179
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 12:25:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88F4010E16B;
	Wed,  1 Apr 2026 12:25:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=fooishbar.org header.i=@fooishbar.org header.b="DCGm6z+t";
	dkim-atps=neutral
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com
 [209.85.219.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13BDA10ED2B
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 12:25:45 +0000 (UTC)
Received: by mail-qv1-f54.google.com with SMTP id
 6a1803df08f44-8a3b0242631so19130896d6.3
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 05:25:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775046344; cv=none;
 d=google.com; s=arc-20240605;
 b=PkAdtCdKqXd5vlB93lg0oVVr5WP2iF+3YyGLEzbleBKYw+TsPXHfySPc5p57FAHmSW
 afO/I0aQApusVYayAcnhPNk+qtEiwPWS2rpLXV8FQOdUybKLVOOaS0Yl6DClTPQEIoLM
 m3tPW3i4TFZ+7McswpygyH30+GBWwBT/WtZXqYr8KboRq3SrXc/mpgZIXClazff7i9JL
 WAeeSghiYj/XwAR11s25jVPBsGqMWi92GhtmLT5rAgtWErkmAw9CjUMTQc1qXla1M716
 XHf7Q4a3JoAtZHoVSgyYDyOdZCXcmZP+6TgWWLCwEsyU/I8moqe6UxrO5Vl7wAR44JQL
 EUgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=eU+zz3OLuWk12Q4NR58R8+sU9sxDECloo/YZ57DpO3s=;
 fh=/+s2O3szDcT0xBV46dFpTilO246fA9QR5bB6FrGrHOM=;
 b=K+xjxHX/AiNR+VBMzhwHuIV4EQUg/IXH/wSqxdJ+b8y7n53x9/ozZEtsyzteubFt3/
 DUcDQM8ktlAeClSKkxNuRxAdx3hOZTLmMlFFs8f2t5/U+U/pMgT/buFZUhptJAdqpKOR
 wrN1oQBdrP303rwE1JCzWFCn+IL0pK0P7hD5FV4ZDBSepUs+CrZgmEHnwxhZqmP0HT72
 uBtUVUpr0XdyxL6+S3ZVZWrpMevWHK9ueXRuKKM8Kg7kxc/femZvE3Ub4TfsZloC+ME5
 1O+AgkIk6ZFj++LLyM3Fn7HUYxf2Cufz7GObDzj7lpooQGVjCqL1wXnXCNg3ik4a9ahM
 s3kw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar.org; s=google; t=1775046344; x=1775651144;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eU+zz3OLuWk12Q4NR58R8+sU9sxDECloo/YZ57DpO3s=;
 b=DCGm6z+tWZ0eKNsiMDB79pgYQYgh2/2vdLsDddGBiUsoLSbtPrWlcMaWxqCQZgYxDd
 e/EFxocRise1qVgiGowofwd+xifsP0QTYJypEJeGUEt1r6Phqin5HRN2+gH+Ai8o238/
 5NvU32BjaElWeYKEilDNLTshhSys+K18KFwuhIGS6MZf7RnksCBAKDH5q4ZHGG1aeBkF
 0QWMybdQG0eo7H+ZrpIQ6UZ08ifgbaXBqfh/Mcy05fUzywU4V0JTaKQDwkACw9iljdFk
 kUFJz8SmpcA1cj9zA4Qt/TRn3AeV2eNCGs/xntM6ycuseeUS8YszTwz9F7vbSKmFJPax
 qcWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775046344; x=1775651144;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eU+zz3OLuWk12Q4NR58R8+sU9sxDECloo/YZ57DpO3s=;
 b=IxNo8f4IrJeXq02jmYn1e6AFXRDwjy+KumFYmV4P0hX3De16poCHHbJzsSbBIIQKCE
 eQgbSzpxWCCfbcd3Z7FYpz8POBYgdycOD4SD6BnqnBQNbOkkvi0Ip9gHlAYdIyOwUSBn
 tNI8Jwpc22Wgn+h6v5wM8/oRmIhwlAq0Znve2WIkRvL2EWnoAS+eA60PeDgUaLKyefwr
 Kdju6nKruHQs5iLIPUHBCEc4XG1Fizt9W0b0k/bC2uBN/F0MWha8RqJ6OV5qiVIEyiqh
 IG1XNgmthpTE3K3sCrjn/8KoC4WUAazVsmOZ8B0uMYnBlTOeU34p74ssnmpm2o2eSj3V
 e1jg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8rFAzfHuiGTMp1nfTfe6/0v8pbavxD6le5+uZP9h2aU+esUBGaF//sx5pbFcDksgROagpg6jOZqc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw/KaIXUla9KWKvJ5T+JOhxh31lncFMxuKy18etF9K4K1FECWal
 vsXj9ExYnZfwpTlPAM3shYofF7tV8dDOvtkEAV0+AnF9reJdXUgcoYD3AQUi4hBmHMvMf/9pV/R
 JrXMooS0UEoqTxUQgTt72jZnZNbZ9SDKCcp21j1+x2A==
X-Gm-Gg: ATEYQzxC9lvUD2ljRGb5t9nZvoCg1tQhJHjR4JjE7KidyfXYNiUTeNJSTXU2GNxeNOq
 CBAPZSV/ezHomwO9/Wj06ifZ4rO0zZraC9KMXdvgwuV/gtYnyvyA93uZrMvoVPAC2UELzw9EgpG
 4DScVi2778HLjQItVuoY70un5Z5LwQJf1Fk+T2flsemRC+Vz8B44PMbRW9m76bWaz6LXO/fxa54
 hNzgVBFgKUfxa3KTx0yyg01zFzmT6bcM5dagl2I0iEy4iUURzAKKz/LhdSctG6XKwZr2Okjl7pe
 e70yF3altcg2hS02PUT9RMdnSMZxM5/hmGYfML6Dgw==
X-Received: by 2002:a05:6214:dac:b0:89c:e7d8:989a with SMTP id
 6a1803df08f44-8a43a27285emr46661276d6.35.1775046343938; Wed, 01 Apr 2026
 05:25:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260319-link-bpc-v5-0-5306cd04a708@collabora.com>
 <CAFZQkGzxfGP4E18owJf5d6L4n25-nvYn0TG=rTLCzjpj1Hk23w@mail.gmail.com>
 <ac0LYoemprz5-dDq@intel.com>
In-Reply-To: <ac0LYoemprz5-dDq@intel.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Wed, 1 Apr 2026 13:25:31 +0100
X-Gm-Features: AQROBzCCN0NAl8sVFUTNdPlCD4ae-2ORt2gK2m_u_f-UZ_1uO6MvhoYtxuTB6QM
Message-ID: <CAPj87rN6v8qsdRkALZXjxj+zSXdo-BnFcX8tM2M4-xawkn=Xyw@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] Add "link bpc" DRM property
To: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: Xaver Hugl <xaver.hugl@kde.org>, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Daniel Stone <daniels@collabora.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
 kernel@collabora.com, Derek Foreman <derek.foreman@collabora.com>, 
 Marius Vlad <marius.vlad@collabora.com>, wayland-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, 1 Apr 2026 at 13:11, Ville Syrj=C3=A4l=C3=A4
<ville.syrjala@linux.intel.com> wrote:
> I think the idea of some kind of feedback properties in the atomic
> commit has come up before, but no one has ever tried to implement them.

Yeah, if you're looking for context on these, the last place I
remember it coming up was wanting to know which other objects would
potentially be dragged into a commit. For example, on ye olde (?)
Intel platforms, if programming a different mode is actually
stop-the-world where all other CRTCs get affected by a CDCLK change,
being able to know that those other CRTCs would be affected before it
happens, rather than random -EBUSY after the fact.

Cheers,
Daniel
