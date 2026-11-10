Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06620606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 07:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fGF8hM2O
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65A4A10E303;
	Tue, 10 Nov 2026 07:25:36 +0000 (UTC)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2721B10E2CB
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 07:25:30 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-2e8da6ef7ddso10129345ad.3
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 23:25:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794295530; cv=none;
 d=google.com; s=arc-20260327;
 b=liQqV+ZYhAe+/sZd/5mDMkMAgjvAJ5qkQcQKrBCPyBSBtCLDl8GCvFJ9mk5cDKjxUC
 o/qUqBF3OZoD1hw//r3mkDALlYb44g9yHwP1+ArlWxN0t1KR8vAtK0AQIwDX0LYuzx8P
 uEPoeKG8DNbKfRejCiQwhTTxWNWT1jIMrPpUnGe7PkWDEL2mGzv2jRbRtzZvhj1Up+mw
 oWuQzeVpTh3TtQY3XfLBobS80f/uJ1AUjl1naBZ1cvBtk+df7uWfaFBP1KqN6DY/fUIv
 Q+OmRTwX2cjW7Oit+RnNce2CKkDVmiXS9ZLH1Hd+++6vUKd1RJJ/1ieIhKxUzDoY8qt5
 JRdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=0M3a3AK16N9g7vxyTBB8oBG+Vu+/c6CXt8SBTSdjCyI=;
 fh=HERsDUFZCM9HfGY3csNdmKI1joZ93htveoHRbNI6wbQ=;
 b=YGWSAQopUq8YlQMd0dJq/952nOhsR4N8UI/a9du0HXDMlFHokcfdH3bzsN2FeFfeRx
 uQoRyt0QZrZVX/TDRZupTsVD5CaOKcLKq5N1lPtGuGGTSzajb52SZZoJ3rg3pxQokhqr
 hsnonyGfRpQzU21CMWV9aGwtmKeEbuqg8zkhNygUugN07kLWQtrq81xMH9fxp5wmQXDy
 fc0wXc2M1twe0dzkU5ynoqfcr5pxpv487ktd80avEK9hw/Bafxd1lkECcVSNX+XpXhCB
 KV0CShraTMLHcWfSpNjG8ing/uvjtKKuoxT7VPPoCeEXkL8I6l0LdVv9fAiUC4WmqeUi
 qQuA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794295530; x=1794900330; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=0M3a3AK16N9g7vxyTBB8oBG+Vu+/c6CXt8SBTSdjCyI=;
 b=fGF8hM2OU/2A3Kbrv+wF0T5JyOP4AS2KlNFdQ5IJ7xeWmameKNKx8A0q2js6dNRyeG
 QuVSiw4xlzafcp8imrILEmENA/W8Bl5hrGTdjJh9tahX7HOw+jNGIWnKnivEKtezIOb7
 7sqK6+k27trDIXaJEkge1EU6//7EzOoV8w+QnS9NDUEnywvpbDhTLq5xQArlYnedvaU8
 WNbdqSrt2CACXdIIhV1X3ijinYViKuOvXmjD1848SMAHZ8oBeV5WFD9hg8PLg8MkZ37C
 cYuBqG1dGMyhS0NaXd2Eef0oqnHVpdiQpv3b/kSxr/TsHlppSSQakbqr3DwkHUsYakwp
 fzhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794295530; x=1794900330;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=0M3a3AK16N9g7vxyTBB8oBG+Vu+/c6CXt8SBTSdjCyI=;
 b=hl5UEWip7gcy016B/vl2Nga3O0/9LlXb+w8dHUjF165wQi12F4jbNGf4X7/GbWoKSZ
 6S3tqwoP24ev2Vd+pxU0gT+LTq8mG5h143hO9Bf4am71DPhhkGiWsIdWxeN0mn3v/789
 hXfU773q9vyIPc6WyA5p1JoACQMt8txtyoLn3tRZOsF/t1PJpvgU2dRz23Cee3cE2yyk
 SYPAvluUmt+mnaLoTZgZqEOyXyyEgP1CmcHl2GsX6z3nFj7FDnxmBLSze69w7jd0SsOl
 SwJW8IBTWWSGmo8OgQ7NEtIo4XDo5XsmZgYz9gMcOo0DxjIYkzosMLOiswD8wpmwqLT2
 dZcg==
X-Forwarded-Encrypted: i=1;
 AL+hErHsIB4oHzeZBjB3FBLNjAB85VW8V83XnPFn2vFSz5zmBYPBVXXudDOvUYf24JXOLiwJzlil/I+lTRg=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/Edx6bmGD5qjshruB7vMujQAKO/6b3BV7c1zRxCm7BNIwhTp+1
 aD22/UsgfU1RB9XjpYfR1lwer83cWwg5QMhUs8JcLDtvx/G8g3+nWY7gBHOyc9b/JJaqPPN0mKI
 TyXhki+OfNgQ5AKkoV9h8tbaqxd+SwwI=
X-Gm-Gg: AYBFou1SZhBWUt2Eiatq+AI0CZq0H3Qw7TYNfEwR7bHkmHTEoPggJ0ItJd+5QvOqfBx
 abl55BIsp0CxrYBeJlod/sjbY58MWy+lqkCrTgZpgbo7IJUc1iJn2Q4BAWzM5asu8Z57y6D3FdI
 EFCP9noUTG6fZ6wnpev3gSEzvpN5jJALYp62IgDSlTGvf49U0Vhv5I7X9bOu0kHqEKiV3apGe7z
 TYk58JQYV9FjisugWQzIpIRXV1AfnNFB2WJ6LtLlYZyyPsOFlBf4rw4C1ZsmQhdNd9Bfpm9m2av
 X/92l12iP7YZUsjhYn18pzvA6LALk4Tbbw7q8SZgEWsVnkhJ1W+09vM9TY+t29KW497Cz9rNtPw
 AZeBynt7tWpQZ9C03SGdT4MC8T6Um+nQ0Ggs6pLVOYqMQr/oVM78UdDKlX8AiAxqd4wDY8g==
X-Received: by 2002:a17:902:f707:b0:2e9:7719:4104 with SMTP id
 d9443c01a7336-2edb8f95919mr16612175ad.8.1794295529419; Mon, 09 Nov 2026
 23:25:29 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261102094343.2086424-1-ple@baylibre.com>
In-Reply-To: <20261102094343.2086424-1-ple@baylibre.com>
From: Christian Gmeiner <christian.gmeiner@gmail.com>
Date: Tue, 10 Nov 2026 08:25:17 +0100
X-Gm-Features: AclHuK_5hLQM8yTFaomfyMAmlf2f7XVzBrcKYNu8WPR91WwUG2k1zivTO2diDxI
Message-ID: <CAH9NwWdLGt96o6Vugoi=Jj2WfbpQ6Zj5LtUgic2OBhdfJ1E+=Q@mail.gmail.com>
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

>
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

Reviewed-by: Christian Gmeiner <cgmeiner@igalia.com>

-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy
