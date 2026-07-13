Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 412F0C44501
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 14:17:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5104610E9D3;
	Mon, 13 Jul 2026 14:17:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="glR+f9W6";
	dkim-atps=neutral
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F7E210E9D3
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 14:17:42 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-2ccae46de39so5787555ad.3
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 07:17:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783952262; cv=none;
 d=google.com; s=arc-20260327;
 b=Ac14DjQ6Z4/I/U4+xyujJEDftmsc2e+iJOkdqqVQ1Fxtt3lRnthFq6NIWhmZLtZiJf
 ReOrM7QSSHuNkBImN3kBb37XRtflOp9HUKkd+HW+HPk9aunZZ97yc5Tw4pjFW7BvjTls
 iBfihzcJdRtmiq4egVWeBv8udEsXSQwNv7ClE35wKDwHd1DuWRnB0aka2aLICMSpMpvG
 5nnYDLWa3eKEChzZsDIcvxWk25HuPARA5gofb2CRmWg3FffVQMt+a81p8YAWRRUMqSqv
 IVJhG88k4y8M+8Figl4Gnvc9II/XVmx/Ar4CTFHsGB0+Jefv4f1wp3mYafqVaPY9nw2V
 Sf9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=uI8pYvQDTVFaBU/6757QQZt+Es90CqnPBzdo3TbBxgk=;
 fh=vxfRPQBnXcX1bn2taEsQeBwdlr6dLdrPrm4lN6gvZPc=;
 b=seG3Ruiz14hus1D+nde6bWLkUd5xYW2ojN3G7G7bFx0T/aqLbw7PLvbHiueIXNZ4Wx
 /VJzJzBkCFbrPJpfYTv2a8xHWAM51M4cs3Jjhs06AJC2j4ou1E6V/y1RG9Gnm9Kr5bFa
 m2c6UoKxoC4OWXBKU2tbrDDMGMtqa3H9/IHkwWLo8ZFhG0Od+iRGkX07RFrLaeZh1qy3
 k8w+2yel0Kou4+TyxTxcn5QaIOvmZzYpJh0brUiu4faK8nBo8CQcIsTFhRtDrgcOSW++
 ATwh33TqA5+0rGKfdgvAxJ3osJYwkgix8iguWV3U9KY5uq/5UTTQJ8kqab2caQxbEHPg
 S/jA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783952262; x=1784557062; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uI8pYvQDTVFaBU/6757QQZt+Es90CqnPBzdo3TbBxgk=;
 b=glR+f9W666PxY5mZ/E+9X9SJgdEC4M/MqbD9eZM7bsRZsRfQXiXm4qLcguvR/ZBNOS
 xeFLVR3v50G0HZmtVZZyulFXTOcvrh82ZCyrddQNPVT+XaU4URYpkPxPVVUr852ArTWN
 iqFof0KcbKTlV6I5KqyWvol/Vpfk/+k53AlON8103aWrDBZsRIuP4YfPCU6SjHshpLEL
 Cw9WJYdIzrJVOr2n072d777ERtSnExZYC6JFASEXXE+CckGPS83rFwodFb9BQL9XuvLu
 X7bIyJZMJGtXuC5DjTVceC4nfCPJCrV+e1EiUQ30mQE5KhVTe9nntkmasnNTaZOgnosR
 RXog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783952262; x=1784557062;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uI8pYvQDTVFaBU/6757QQZt+Es90CqnPBzdo3TbBxgk=;
 b=LX7Ikmx7xi6+bdBBPlDSLb8iWLzZMti9cmR+K2VoD3EOpgWAjyq7iX+X0tSGNOTmf7
 apwoHc1L8tu8bHAJI8AUu7nVzp6hVFhhy8fILqsog1qzZ/nGaHPLgP9PVrLpiS2zmUjQ
 oea06CHl/ebIXNhxXI2DHAQijkLyRHXwpoERFgKpz+cElF2a+v2VLpb9BdrJqHoyDHPN
 tiS+ZyOF7nboCXI6Qu9f3MJ/U/uQeTnKagjas4RTT4IKmUm+6EbGqVKp0qkzuHMMIsmP
 pTS4XWSL3ZGzCXMa9b9gpOGmOCokuHoJBaWmbmEI2heHO4aptXjlW0qygCM7oT4eEy9L
 FJHw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpGtsV9BbUp06WTIIv6Qfz4xD4/qEYUiJgFkVUFTYUx403FmuADDtXyG3aE2GbOtBaKdaGWnFZEIKA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwRT4mKmkEjiUiySeBGMX0gSw5mjfb6L4SJtAxrTRDXDNBqfe+8
 j+qbSslNtLOuJYvrauUio0YRG2zzbAuoljU4RMojAlPUrcn5ZOKXFdhGMm3tCYpZmzq21lUXsGZ
 ezXNTTSgJgHQqVCKKAVdQSVBt9eYKfBk=
X-Gm-Gg: AfdE7ckyxjx8PieZNqntqK/UC/fBQmmNzhkHA2LVNNkLuKD/liEJY4j6COTHaaO36A4
 /E2/MB0ydKlLZrPH9ZZRw3WeEM/rgxtbv7mpIScnKn3zeQw/DempXimZXsUBNW2K+ZS97UTh6t7
 jgogkIRdCQZM/InzBi2aeFCv71LUOiRtOaaQOw0zmk5AIONME176cR7iodf8FJAEnq9KJvJXqrU
 nSFb9XXNBzD81CZM4Rme8aE7zdcnOZ0kEnkfczR0ElbX1GbsrjNcRj328Wf1XK5INBiIf2xDlL+
 0f9qvK56JffaN92pKjpmN99flLRtRGm6tubP9VROIIeVK+VPqpmHx322c+q63l6LU52kHw==
X-Received: by 2002:a17:902:fdab:b0:2cc:df15:91e2 with SMTP id
 d9443c01a7336-2ce9f1838d2mr77380885ad.7.1783952261799; Mon, 13 Jul 2026
 07:17:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAOidqQDq6khYfEjSz8=FHNBnR_nd17WYZDn7OdWOPG4BgPtTwQ@mail.gmail.com>
In-Reply-To: <CAOidqQDq6khYfEjSz8=FHNBnR_nd17WYZDn7OdWOPG4BgPtTwQ@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 13 Jul 2026 10:17:30 -0400
X-Gm-Features: AVVi8CfQIS4rEL1wc5ky61QejnpfLIm4aqhKsrQowe1QPdHtP2twCTzHwUMyN5Y
Message-ID: <CADnq5_Oga9bvHFdYgnq47h+-xznkcOOsi5U18CCaApLg9rSu9w@mail.gmail.com>
Subject: Re: [PATCH drm-amd] drm/amd/display: dce100: skip non-DP stream
 encoders for DP MST
To: Andriy Korud <a.korud@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 mario.limonciello@amd.com, dri-devel@lists.freedesktop.org
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

On Sun, Jul 12, 2026 at 11:39=E2=80=AFAM Andriy Korud <a.korud@gmail.com> w=
rote:
>
> From d37cbde6a3b3e57a5dc794514e77fc66e7fa8943 Mon Sep 17 00:00:00 2001
> From: Andriy Korud <a.korud@gmail.com>
> Date: Fri, 10 Jul 2026 12:36:59 +0200
> Subject: [PATCH drm-amd] drm/amd/display: dce100: skip non-DP stream enco=
ders
> for DP MST
>
> On DCE8-class ASICs (e.g. Bonaire), the resource pool contains digital
> DIG stream encoders plus one analog DAC encoder. When assigning a stream
> encoder for a second DisplayPort MST stream, if the preferred digital
> encoder is already acquired, dce100_find_first_free_match_stream_enc_for_=
link()
> falls back to the first free pool entry. That entry may be the analog
> encoder, whose funcs table lacks DP hooks such as dp_set_stream_attribute=
.
> The subsequent atomic commit then dereferences NULL function pointers in
> link_set_dpms_on() and crashes.
>
> Skip encoders without dp_set_stream_attribute when the stream uses a DP
> signal (including MST). Use dc_is_dp_signal(stream->signal) for the MST
> fallback path instead of checking only the link connector signal.
>
> Tested on:
> - GPU: AMD Radeon R7 260X (Bonaire / DCE8)
> - Board: Supermicro C9X299-PG300
> - Setup: DP MST daisy chain, hotplug second monitor or have it connected =
on boot
> - Kernel: 7.1.3 (issue observed since 6.19)
> - Result: kernel oops without patch; dual monitors stable with patch
>
> Signed-off-by: Andriy Korud <a.korud@gmail.com>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5162

I've manually fixed this up, but please use git send email in the
future to avoid having the patch get mangled.

Thanks!

Alex

> ---
> .../drm/amd/display/dc/resource/dce100/dce100_resource.c | 9 ++++++++-
> 1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resour=
ce.c
> b/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
> index b92d4f378d60..beaf2e654672 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
> @@ -29,6 +29,7 @@
> #include "stream_encoder.h"
>
> #include "resource.h"
> +#include "signal_types.h"
> #include "clk_mgr.h"
> #include "include/irq_service_interface.h"
> #include "dio/virtual/virtual_stream_encoder.h"
> @@ -992,6 +993,12 @@ struct stream_encoder
> *dce100_find_first_free_match_stream_enc_for_link(
>        for (i =3D 0; i < pool->stream_enc_count; i++) {
>                if (!res_ctx->is_stream_enc_acquired[i] &&
>                                pool->stream_enc[i]) {
> +                       /* DP/MST needs a digital encoder; skip
> analog/no-DP encoders */
> +                       if (dc_is_dp_signal(stream->signal) &&
> +                           (!pool->stream_enc[i]->funcs ||
> +
> !pool->stream_enc[i]->funcs->dp_set_stream_attribute))
> +                               continue;
> +
>                        /* Store first available for MST second display
>                         * in daisy chain use case
>                         */
> @@ -1014,7 +1021,7 @@ struct stream_encoder
> *dce100_find_first_free_match_stream_enc_for_link(
>         * required for non DP connectors.
>         */
>
> -       if (j >=3D 0 && link->connector_signal =3D=3D SIGNAL_TYPE_DISPLAY=
_PORT)
> +       if (j >=3D 0 && dc_is_dp_signal(stream->signal))
>                return pool->stream_enc[j];
>
>        return NULL;
> --
> 2.55.0
