Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BABB606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 08:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=siaIhXQo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5194F10E83F;
	Tue, 10 Nov 2026 08:55:25 +0000 (UTC)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3591210EEB5
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 08:55:19 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-2eb18f4da15so6897165ad.1
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 00:55:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794300919; cv=none;
 d=google.com; s=arc-20260327;
 b=a9XV0JqbUBTLNNcCuPG4BRBdXt3F1O4k4ZQBJZhym1fsXxBKNu8bE5zhqk+BcTA1Mg
 Zi9x7dYfeBMPvIEGTqmBkT3Z/YsX6O3qNIrSvQ0l/BpOAu7HZGhidxC7pf0akYdLVBqJ
 2cfWQXvu+oqm/69PQ7aXcWhqEWo5fS2nk7aN0tuLDSbZe4X1bRnx5A25nbJTezVZsvBh
 NEQCTc9RNNdBSaTha12asbFwICIReFeXIC3+eOsDhFXtLcJ0rrhUKh2HdrLJYz8Z2Lnr
 he1rubtzGmztK/sqvImP0F7mOJCBeBg89SZdgmhjE/O7mHJfKROzu3xoGbsIGTdvFne+
 ls6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ikK0yI+E8NrhhSqddOr9Eopj67PGcdnqJnOAWTsSTGY=;
 fh=iS/BfXYifjeo1z0eltnx5TsqJb1Exq48JJHP3Kj0DmM=;
 b=b/EHDf3UenvEyHcBrRFmY2SGc/8/DtSl91tbSTsEIft7rWWnk66KWPEqGTilVC7CRl
 HaSDiZe5jFDLal/eWQ/gLpZCJXRzzJIsz4oU8CjPzoHZEmT79la+JRQk4xgzTTPW0wsC
 tVVUh4ImbqedcZm4/gV/32A7YJnn6wc/VO7SXlPOlsDo3bLrHim9cIJuvY48vIgNTGNo
 H7WdmGYS3/9RtL9+g7R3U7GI60ZS8OACPrMa1Mu/5ggWklFqYUACGKsRcaDIesDvp7eB
 19kEWULi8AmyTDJbk5eLV/YrO543QWpWcmdGmmlNQ54n6zMWeDWHHBqHjZOHc62siEFm
 WV2Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794300919; x=1794905719; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ikK0yI+E8NrhhSqddOr9Eopj67PGcdnqJnOAWTsSTGY=;
 b=siaIhXQoyBlJaBxK0vfGWPZnQAlFpPE0uIzxqjCxLkWsfIfRDDhGlPAAphZCLbUPoU
 0rBlUkWxDPvBfJE7kcL2SAAm92Y1ZMsOX86x6B393lnP21IAdsnD9gJhVOsofYQpI4dS
 W1hT8bsHxfHvNoXjcoKFIC+ljRKetDYtglQ2fyLOD/auiztpzkmS1ZSl5Z8ydDEoKwWQ
 d5kiOL2rrfQx2SwSa3jnXbR5UWULmpbixZ7dSIXjphzAINiqto8fYBIhHz9tI+FADvEh
 PfIKCgixJislba5T7mrEib0VLOwPvgdgfBuvPUkY+Goj2s0SCvO6/XazpcBT4u0MVet6
 G6hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794300919; x=1794905719;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ikK0yI+E8NrhhSqddOr9Eopj67PGcdnqJnOAWTsSTGY=;
 b=WA3ytWbPUVhGF7DYxF866sLE3jyuxnca0bP9L7XDLqZQe4JUqq0Lwy/OPszQeHndUL
 UOcTVd559FtR6C9+h8hovdlZbcEDijE1uMLzPbkTUoP+/JlBxB1qLdN180+w7pwZAblX
 v034pgG7vWmvCgE8rT9nxcM/bg1fM+iGa1v9tkBNmAHxI8+mBXhchBkeHEtTDvbHJuUj
 gNIsiWO4UCmsjcm8Buced7BVVRaVLeV9FyoErMwWw6z7PVaH2y5vpqDgTA37INkZsRFm
 FZGj+9i9YfQZj/rTLS4Qosnij+Yg262zWMhQwwO2fDEeTfZUg46P2i/yBWJw/uV3id+2
 HVXA==
X-Forwarded-Encrypted: i=1;
 AL+hErEW+92sDQf1Kd2oR7hFQi701x4gY3E8Rpv3MZyyomsf88h3AylD702gId3w/ypgT2Is/Pv+6FppJ48=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8vZVVv0P+0MXGXTW5pNO8DMiV9xELWYVuL5XOKLEdv2HFj4ezP
 oXxMGPZOWPRvMiS/+Ngzx2mUdcY8uus8aYz8qbflf+uXjhNK3vvIN+NIZTn0fqKE2CmfBy0S4h5
 nfEaWX1QT0ym9Szq/+yH4XEWpxXyh1/8=
X-Gm-Gg: AYBFou0eYyUdr8NFLK9ecZV04BclXJVD/HD5KOkmszWDhE5dMzFccxbsAhaolt0RrU9
 Am/P595fVtdQ+IBMR/DKb3SvmGOLVDrl2sAYL3GX6pNQHwki3F9fwaB/t3NaJbWpxqvDw8LpF/f
 g4KFj/Iz9hfaWJEHeK8EFETJN1NGlzrWYweytSIHczcx+IHNRkXeOWO6PUtOTlGIJNLjxDb1kk9
 7wRSN7h38Ni1wfVtQBeEnwyfhHrDyNcfW9loiFSCkVB0JdcyxO99LtI+RvvA2/OjguoTARTHlRc
 mB7R+bTkMEwUutdksssYnLB3s7Zui9sTNtOygjW6gualcCCpTB+RlYWCjfoN10p70LJtEOhS8Yw
 rFSKhQwVd0TbL2DUOv0o1wJI8ZT1YV06nCbgdBLZbmhYTRGUPQz/Cot8xaCrIrTig75AV7A==
X-Received: by 2002:a17:903:1ad0:b0:2ed:2475:e413 with SMTP id
 d9443c01a7336-2edb92f56e2mr16190845ad.74.1794300918589; Tue, 10 Nov 2026
 00:55:18 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261102094343.2086424-1-ple@baylibre.com>
In-Reply-To: <20261102094343.2086424-1-ple@baylibre.com>
From: Christian Gmeiner <christian.gmeiner@gmail.com>
Date: Tue, 10 Nov 2026 09:55:05 +0100
X-Gm-Features: AclHuK9Ncssa98Vti7yWwfg2lvo4nCJKpUdlmJv5srkUFFlMOwuYmWxJNGIk_tQ
Message-ID: <CAH9NwWd0WkkxzFMvdCgRtmAjuamxL34W-RaVeiV-ROyWnV74mA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/etnaviv: add the Allwinner T527 VIP9000 hardware
 database entry
To: Phong LE <ple@baylibre.com>
Cc: Lucas Stach <l.stach@pengutronix.de>,
 Russell King <linux+etnaviv@armlinux.org.uk>, 
 etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> Add a hardware database entry for the VIP9000 NPU found in the
> Allwinner T527, as used on the Orange Pi 4A.
>
> It's coming from allwinner BSP driver in gc_feature_database.h with
> vip9000nano-si+ IDs.
>
> Signed-off-by: Phong LE <ple@baylibre.com>
> ---
> v2:
>   - Fix minor_features6..11 masks: translate flags by name matching
>     against Linux UAPI definitions (common.xml.h) rather than raw
>     positional struct packing from the vendor gc_feature_database.h.
>
>  drivers/gpu/drm/etnaviv/etnaviv_hwdb.c | 32 ++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c b/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c
> index 32d710baf17f..54e353d61be2 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c
> @@ -292,6 +292,38 @@ static const struct etnaviv_chip_identity etnaviv_chip_identities[] = {
>                 .minor_features10 = 0x108048c0,
>                 .minor_features11 = 0x00000010,
>         },
> +       {
> +               .model = 0x9000,
> +               .revision = 0x9003,
> +               .product_id = 0x5090009,
> +               .customer_id = 0x10000016,
> +               .eco_id = 0x6000000,
> +               .stream_count = 8,
> +               .register_max = 64,
> +               .thread_count = 256,
> +               .shader_core_count = 1,
> +               .nn_core_count = 6,
> +               .vertex_cache_size = 16,
> +               .vertex_output_buffer_size = 1024,
> +               .pixel_pipes = 1,
> +               .instruction_count = 512,
> +               .num_constants = 320,
> +               .buffer_size = 0,
> +               .varyings_count = 16,
> +               .features = 0xe0287cac,
> +               .minor_features0 = 0xc1799eff,
> +               .minor_features1 = 0xfefbfadb,
> +               .minor_features2 = 0xeb9d6fbf,
> +               .minor_features3 = 0xedfffced,
> +               .minor_features4 = 0xd30dafc7,
> +               .minor_features5 = 0x7b5ac333,
> +               .minor_features6 = 0xfc8ee200,
> +               .minor_features7 = 0x03fffa6f,
> +               .minor_features8 = 0x00fe0ef0,
> +               .minor_features9 = 0x0088003c,
> +               .minor_features10 = 0x10c0c8c0,
> +               .minor_features11 = 0x00000010,
> +       },
>  };
>
>  bool etnaviv_fill_identity_from_hwdb(struct etnaviv_gpu *gpu)
> --
> 2.43.0
>

Applied to drm-misc-next.

-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy
