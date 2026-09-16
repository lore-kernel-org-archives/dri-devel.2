Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBAF8C982C9
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 17:57:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1546210ED0F;
	Wed, 16 Sep 2026 17:57:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JZjiawt7";
	dkim-atps=neutral
Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com
 [74.125.228.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E193510ED11
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 17:57:11 +0000 (UTC)
Received: by mail-pz2-f12.google.com with SMTP id
 41be03b00d2f7-cc42c773d05so94508a12.3
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 10:57:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789581431; cv=none;
 d=google.com; s=arc-20260327;
 b=eCBIwHZJvnrIkOIrnVyCS6VYYYG9QjMIO//s8myBeU70vPlAUnj4DGc9AYhrH1hkZ3
 2f+TUdhHg/JiRlqbg4r4qhbxSlw8D87LN0Ri60/qSZC9LTtrEwEkM3z1n3V/u0+7rIL7
 2D/YV1pYD7ZSBd4zMVHU2GvEZgfX6H5Ha3sA7B0mg/zMBMntckTgDNpdcuIb1+45UbJF
 YGFOmkkeLCiSyyJZhf8DQ5gispPHvBJ1OIlcsVk1SyCF8MrA/oeLeDmylbV/YAiI1gk5
 yghEmOapn1SBr8+wzNB4l6GaScR9wZ7S0WGmRL5XHJIk63AuRIy9sU+29LSHLPtyupah
 LqDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=bRhmmCrAtVPev1jQLA09AINV4vc5qQ/mpuw1U6wCpOQ=;
 fh=RjgSKQi2OcZ+JqPy8RrIN4HGHuCIeWKc4WPJdE1iIW4=;
 b=YHzgK3WF0Kqj13cpZd4MUZ+obHwsho14vm/apJ3JczcbP/Lv0FEpJEB+RECG2CO0E4
 xk2DJfSWPSKY2ss1BEbvcV2kRKwMN8KKnhJaEdtzpZKGDvF/vOHHQ570BjdpFrhS/hEK
 maU+Q9e5g/gqsk+dvaVoaGjaciFaO9i22Zf3ro+5RyrlVgUOiY5B0hz6Swu+sG71pPwD
 syUrta0A097SFCUqEgetqdz9Dtn4yaU3Db6HCjeE51WmKHqoGxRI8+snYlvntHVNlib4
 NkKS6QAox3A22pWUqKty+Rde0oQLJFtdzQXseWjlqqXLE3L2xVB85yyZeM2mWqvXLPMa
 0B7g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789581431; x=1790186231; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bRhmmCrAtVPev1jQLA09AINV4vc5qQ/mpuw1U6wCpOQ=;
 b=JZjiawt7DOi9MRWB6haEQtK8c+kiIH9iitR+NkeF2asLJbfeO9Ea69be1CI5ROcZ23
 M0Zu9DpAaNaBPSeQuTTuEhxXCX49Yaz/yk67Ix/qzOXTABIKcVUpdWSEVcslEjUyOkU0
 jTYew+AIMjmhikDo64qawIjvjtkguVcLrARD/lUKDvc46YzZoSh/PTNqUCYbGBsxfyui
 b6XZkmCZY+/6gg32DMj12VVaMjuaDgSzMbeN5elNyYV9zQbK4gnSkKHQGowtoQzucnil
 qjcmvewpUTbqf2LIvp9TthSbnWOx29R5JFa/XEGE4q9YaD2DQFC1fwQx1YA2/FHT3DAB
 pciA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789581431; x=1790186231;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bRhmmCrAtVPev1jQLA09AINV4vc5qQ/mpuw1U6wCpOQ=;
 b=IfOqfArbmfVt8V73vtIr6cgGlV8yYCCYX+VCk/TwLcgGqO8fpH2pn3wQxX/5Yw5oTH
 HIFX0WIehfzlVsTAIbJeoXjV4rroUB/bG0pz+ZEYA+TO8bUtZTeV7bnm9tzB2Wqq6G7U
 mDWc5UgTmRS4TmKEtzymGINTOYKnGkeHUYrUSf/H/EIwgCOWyFTl27CI7RKtk0WKf+J6
 7/hgvCSUf+5R1KMqXxuvr4YJFAapDekkDUVegEnmSyXgM3757WMNu8BAC6oMg9iG7T6Y
 6UIyUxb7lU8Ig5mkr4FgW/EBQJRAmCvv+t4fj8mbArGHpw8YUEPZINiOKVx0BgP7BI4u
 on5w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxzQS2HIF60RF69HXxnubo1vuGui9o3qeMQkHr2BLxHxnbjPrh9fFlUDCtvprjeUn51jh8A/YPCtYA=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m/HtkDmvkAEqog/0wYPjoCw/GGsh9KxowVJf0zC7zq2cASYc/t
 51MUYGGFzmZSgt+R9ei/UTCH6ip43SYRwJJhKav1O9BnwtaNF1wLEJRGjohVxYqmtkOj5c6upIn
 VddYlkX2ddptzmJebGWdbTs6QJ115wW4=
X-Gm-Gg: AYBFou2GCm/sCm07D3JXRISn+82YdIlomqwGHVBLGVrPfaoZhmCpPFYwe8f347Xyr3O
 dWHHhHM0DengjHl6ciwSsBNpGKC+x9dpeeOXkx2gQ9/KNEJ539G6BCGeQ3iFcopgnFvkiM8v8qh
 AQ/DHSM6muEnl0lXwGQ0RahbcEPf6TxNRXJeLzBZLV3thdNiysMqy+HIBqHaOPYKusFkZncSzLt
 rd6Dgbfiv3jrJsxx47KW1rszs71FrnyFhT8iZp/wEvDKdHPv1OXeBQtNwCkQdkdG0Q4IDQqL45+
 TZIW73lzzJjztn+Ncc404rkr/L61dQ9Fghck9lvEsb+oB5VQbBhRL8Y1XhbiOT/Mbm9qkVV4S1t
 rQD88ur581UfQNauDQ5z9ow6HaG7Ko42UOZquBAQ//daLzG4Vg6da
X-Received: by 2002:a17:90b:4c49:b0:39d:fcbe:fdd7 with SMTP id
 98e67ed59e1d1-39e1e23cff7mr5673235a91.1.1789581431294; Wed, 16 Sep 2026
 10:57:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260915201525.3530491-1-arnd@kernel.org>
In-Reply-To: <20260915201525.3530491-1-arnd@kernel.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 16 Sep 2026 13:56:58 -0400
X-Gm-Features: AcwNN1WqFxHVyo89bZ3kWQkp1b6VgBRYVdOql17xbIgcYVCDABYsam0h7bBy_4M
Message-ID: <CADnq5_MG+Yrws17OPHCCtc2Sw2yVBZUf-6ym8QCxnOW+SFKFfg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: fix unused function warnings
To: Arnd Bergmann <arnd@kernel.org>, "Wentland, Harry" <Harry.Wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Tom Chung <chiahsuan.chung@amd.com>, 
 Gaghik Khachatrian <gaghik.khachatrian@amd.com>,
 Dillon Varone <dillon.varone@amd.com>, 
 Arnd Bergmann <arnd@arndb.de>, Rodrigo Siqueira <siqueira@igalia.com>, 
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>, 
 Alex Hung <alex.hung@amd.com>, Ray Wu <ray.wu@amd.com>,
 amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

On Tue, Sep 15, 2026 at 4:21=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> When CONFIG_DRM_AMD_DC_DCE is disabled, most functions insde dce110_hwseq=
.c
> are no longer referenced, causing a lot of warnings such as
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dce110/dce110_hwseq.c:3510:=
13: error: 'dce110_enable_analog_link_output' defined but not used [-Werror=
=3Dunused-function]
>  3510 | static void dce110_enable_analog_link_output(
>       |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dce110/dce110_hwseq.c:3391:=
13: error: 'dce110_set_cursor_attribute' defined but not used [-Werror=3Dun=
used-function]
>  3391 | static void dce110_set_cursor_attribute(struct pipe_ctx *pipe_ctx=
)
>
> Replace the #ifdef with an IS_ENABLED() check that leads to an empty func=
tion
> in this configuration, so the compiler can eliminate the unused functions
> and not complain about it.
>
> Fixes: cd2cfe4d1504 ("drm/amd/display: gate DCE ASIC code behind CONFIG_D=
RM_AMD_DC_DCE")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> This still leaves an unused empty function, not sure how much harder
> we should try. Maybe the file should just be built conditionally?

I think so?  @Wentland, Harry What do you think?

Alex

> ---
>  .../gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c  | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/=
drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
> index 817f2bf736f4..a334e10eb1cd 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
> @@ -3618,7 +3618,6 @@ void dce110_disable_link_output(struct dc_link *lin=
k,
>         dc->link_srv->dp_trace_source_sequence(link, DPCD_SOURCE_SEQ_AFTE=
R_DISABLE_LINK_PHY);
>  }
>
> -#if defined(CONFIG_DRM_AMD_DC_DCE)
>  static const struct hw_sequencer_funcs dce110_funcs =3D {
>         .program_gamut_remap =3D program_gamut_remap,
>         .program_output_csc =3D program_output_csc,
> @@ -3685,9 +3684,8 @@ static const struct hwseq_private_funcs dce110_priv=
ate_funcs =3D {
>
>  void dce110_hw_sequencer_construct(struct dc *dc)
>  {
> -       dc->hwss =3D dce110_funcs;
> -       dc->hwseq->funcs =3D dce110_private_funcs;
> +       if (IS_ENABLED(CONFIG_DRM_AMD_DC_DCE)) {
> +               dc->hwss =3D dce110_funcs;
> +               dc->hwseq->funcs =3D dce110_private_funcs;
> +       }
>  }
> -
> -#endif /* CONFIG_DRM_AMD_DC_DCE */
> -
> --
> 2.53.0
>
