Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64DD606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 08:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kE67mGVC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0DD110F3B2;
	Tue, 24 Nov 2026 08:59:33 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FAFF10F3A5;
 Tue, 24 Nov 2026 08:59:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CA10343079;
 Tue, 24 Nov 2026 08:59:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B7FB1F000D4;
 Tue, 24 Nov 2026 08:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795510766;
 bh=I/QQYp08XOoGoe+BOV5Pf8Vf4hlA64S2RL7cWLofrCE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kE67mGVCY1SNl8V1cCs2vHQPFoMC59bZH7PVSSozFVIcV/8Tylr32B3fDpHbdl/fi
 OS3Vka9dzGBFA9gqp+b8Vu8tSG/yWRuQkgjy7XDDODWj05GukAA3cvW/tt7+Dw+FWa
 aztYdeAssIkHGm/q3TGEf+bv4nIdThW1ZSpkqbQXhb+mdSZbn4BrCEZ+czOdDioUrc
 DWqkNvGQy8eQml6xMzjgRMREGDb6087kjtF4aS55fcjjuzfldL4OdC076welPv+5ny
 i+yVvbd4h6lGem8oPSbPG9hVFUS2M7+Xa/KSOSrljUkE3mg4tS2juOEF5MRd0AlWeR
 cU64JAlzmYHAQ==
Message-ID: <sashiko-outbox-230768@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amdgpu: fix string format compiler warning in
 jpeg_v2_5_sw_init
To: "Arnaud Bonnet" <abo@medichon.fr>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20261123231150.26328-1-abo@medichon.fr>
References: <20261123231150.26328-1-abo@medichon.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 08:59:25 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] drm/amdgpu: snprintf() %hd type mismatch with int i in
  jpeg_v2_5_sw_init()
--

commit bb4e12d069d5e73451e34365a02677da5fad2d5f
Author: Arnaud Bonnet <abo@medichon.fr>

drm/amdgpu: fix string format compiler warning in jpeg_v2_5_sw_init

This commit changes the snprintf() format specifier for the JPEG ring name
in jpeg_v2_5_sw_init() from %d to %hd to silence a GCC -Wformat-truncation
warning.

> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd=
/amdgpu/jpeg_v2_5.c
> index 966a8a7f28eed..e2ba58cbff5cb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> @@ -149,7 +149,7 @@ static int jpeg_v2_5_sw_init(struct amdgpu_ip_block *=
ip_block)
>  		else
>  			ring->vm_hub =3D AMDGPU_MMHUB0(0);
>  		ring->doorbell_index =3D (adev->doorbell_index.vcn.vcn_ring0_1 << 1) +=
 1 + 8 * i;
> -		snprintf(ring->name, sizeof(ring->name), "jpeg_dec_%d", i);
> +		snprintf(ring->name, sizeof(ring->name), "jpeg_dec_%hd", i);

[Severity: Medium]
Does passing int i to %hd introduce a -Wformat warning when building with
Clang?

In jpeg_v2_5_sw_init(), i is declared as int, so Clang warns that the
format specifies type short while the argument has type int, breaking
builds with CONFIG_DRM_AMDGPU_WERROR=3Dy or CONFIG_WERROR=3Dy.  Declaring i=
 as
unsigned int and using %u avoids both the GCC truncation warning and the
Clang type mismatch.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123231150.2632=
8-1-abo@medichon.fr?part=3D1
