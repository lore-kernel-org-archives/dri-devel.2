Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B239DCD98D2
	for <dri-devel@archiver.kernel.org>; Sat, 13 Jun 2026 12:22:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C70E110E521;
	Sat, 13 Jun 2026 12:22:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YzneGPgH";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3033810E521
 for <dri-devel@lists.freedesktop.org>; Sat, 13 Jun 2026 12:22:28 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-490b9318997so13342005e9.2
 for <dri-devel@lists.freedesktop.org>; Sat, 13 Jun 2026 05:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781353347; x=1781958147; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PLEQjlHPyxb7qmLXVpiD2viGlLngNz3OwPerweNOL9c=;
 b=YzneGPgHPZtQyCWh0MRiqTx5eCP90T7dAqOjjyJvwA2FVt4vbvXI+NR/2fUi7afafM
 73QePLJu/w/xANgqtCzqXvELltMW0Ams436hkIlbQbyDBEims5B5ic+L8x+/1UsVJFCM
 LCHIeWZZtwO+dl/dJujBdQ1u5ThZY+zwWzkDNWAGvnKbb5NLPjRgdZW2l/6ZBNjsVIIa
 MThFSfouN9ZFjqQ/PCIXJznEfTLNwGFqIH7CZoBVO4UVMweAdRWUMFoHf0OvazxkkDvt
 N//APXykLMnJyAzbyE9x3Lv8o4CMYzQtAb5pDV23qsRMJXgOVVu5SBz8+Etgxf04FaUs
 0iig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781353347; x=1781958147;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PLEQjlHPyxb7qmLXVpiD2viGlLngNz3OwPerweNOL9c=;
 b=FVqvgnq1+hwgme8HB23cwfgjlgN4z+aZ8nhwt7T+N19PBd4CwfGdD8jcOFeqqn6MjN
 u2BUPQmqQwPaek3rKbMssgG92PCvNVcKfK6Nb2Ban5p6xMc2HjMcbKDtPu6OpliXJgKJ
 rzBkQ0iMFP8twVxkmjssQFIBCFDyFdBCXI/1tpETuNt2nAmxJ8DxirHocN1cO+I0dGhj
 QXAl546j4Eifu//UMQXjMUX5M4k1NViAeVAR3Ml683x7DKb38tCsN2PGuukbnYNjjMur
 xlrXTY8AxhuVaq7yXRr2qrdC1Hy1Fom9Zlm+ip1CGt1shaaw7MfvXCAAWzdTQpJZTBoM
 026g==
X-Forwarded-Encrypted: i=1;
 AFNElJ/K6htrIMwdDsujv/5z89TtbP3Wj1ZXn6e9LT2cTbz6LlPSeI7tUVZgazdSNT1F0RgBms/NPzNgSX4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwIAkH6O3Jwt5do6hFFl7jP0l90aLF9FFnbU5JPV+l/MdbVyVJr
 jz+ThSHnrUgI5C8dAyU6teQYOYlGxQvgeSHG5ipZ7UO4eP6+FUPRJYpC
X-Gm-Gg: Acq92OHsbmJ0/7rRcUVya2B36shTVdORV0lKEZPmuoYsT37zDBeTcguJA3yZxrfPCjF
 q7EEMNhPNsMJpsyB3AINnlGLmQEtwTKkdyyqLnldBKnoJDSSrbUuunxjfen+2fXI2+yFbN+F0+j
 piTT2OQD9YuQN/16uxGcpNUFuxprWLicv2r6T+PR1Tx9HoPT3jrDixEjQbomQStGdeGjnsO3SDp
 abSf3kFpehAMprMTtxqwmm/52hMcc4rGXwAqHFzj0UnIxbARZGARtbkg8XiJGa4JLL85dH9edQ3
 xU3aFh2kWOgmvOkZ/UhFUvEY0Eix7uCRfghrB3Uv1ae5ghQItjwiv6JmkI1Qec3rzstIac/46hQ
 Fe2OpGzat21GStz0WgncEo4FWMs+oMgtyBQYA1ttkcg/3a5wiXynSwhk09h1LxCzB0gkoZhjR6D
 NlurM42dzOmzGnrzPtN1fXsBsBGa7zjsnHtU5JBL+ldIfBKkM/oM8GPG4mFmFU2cYAX0z124Zvy
 onDpaqYMo4nGsUYOpxJB//aOKy9+Q==
X-Received: by 2002:a7b:c017:0:b0:48e:6db3:ff2e with SMTP id
 5b1f17b1804b1-49220093459mr29113745e9.15.1781353346482; 
 Sat, 13 Jun 2026 05:22:26 -0700 (PDT)
Received: from timur-max.localnet
 (20014C4E24EDFA00ACE56DB4A62D1E35.dsl.pool.telekom.hu.
 [2001:4c4e:24ed:fa00:ace5:6db4:a62d:1e35])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f26434dsm15521120f8f.1.2026.06.13.05.22.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Jun 2026 05:22:25 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>, 
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Harry Wentland <harry.wentland@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Kees Cook <kees@kernel.org>,
 Leo Li <sunpeng.li@amd.com>, Mario Limonciello <mario.limonciello@amd.com>,
 Ray Wu <ray.wu@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Rong Zhang <i@rong.moe>, Simona Vetter <simona@ffwll.ch>,
 Tom Chung <chiahsuan.chung@amd.com>, Markus Elfring <Markus.Elfring@web.de>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] drm/amd/display: More efficient data output in four
 functions
Date: Sat, 13 Jun 2026 13:05:54 +0200
Message-ID: <2796386.vuYhMxLoTh@timur-max>
In-Reply-To: <e0689a10-9cd6-4d74-a276-99f8f01c83fa@web.de>
References: <e0689a10-9cd6-4d74-a276-99f8f01c83fa@web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

On 2026. j=C3=BAnius 5., p=C3=A9ntek 13:30:13 k=C3=B6z=C3=A9p-eur=C3=B3pai =
ny=C3=A1ri id=C5=91 Markus Elfring=20
wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 5 Jun 2026 13:00:03 +0200
>=20
> A few update suggestions were taken into account
> from static source code analysis.

The series looks good to me. Thank you!

Reviewed-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>

>=20
> Markus Elfring (3):
>   Simplify data output in psr_capability_show()
>   Simplify data output in ips_status_show()
>   Use seq_putc() in three functions
>=20
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c   | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)




