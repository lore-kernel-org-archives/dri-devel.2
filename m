Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B756606A31D
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 14:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=raspberrypi.com header.i=@raspberrypi.com header.a=rsa-sha256 header.s=google header.b=qX55Z5Aj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F9DE10FCF2;
	Wed, 28 Oct 2026 14:54:25 +0000 (UTC)
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com
 [209.85.160.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0095B10FD11
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 14:53:54 +0000 (UTC)
Received: by mail-oa1-f45.google.com with SMTP id
 586e51a60fabf-4a85c656c58so752874fac.3
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 07:53:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793199234; cv=none;
 d=google.com; s=arc-20260327;
 b=MwFf6nI+OIWa6lre11leC+LShLCM27xAOtuJhFOFAnZog3igBBE17Rby3m6Pxq+VHd
 eHarbYlxrVZtv1BViID/uox/QbFdE+uVGjNPcwttlhzBymYSyewTf1U2AuChodtzfvWl
 Lqf8vWxxtXjhDwYy+tJ/A4yfHynzARpgbKkvMeNF2tB8LZWGQnzHiNmAkBPUm1unIXUz
 gcfdGT31zkSnghTjkNP/1mKqquWCkVhMvhL8ei9ZQpQh4M7/AzlA72HmKgwoTiaANZ3h
 7t5ZG/sq7h0JK0FD4P4wCzLVWYCvZuJ/GUztvfMbSbdS0eIGozO0+OzDipAH7HHYTys8
 QLmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=d8xiOKoQDSvdpojkDy4fldRww1u+2VH02DEwdCLpEj8=;
 fh=mhx7p+VcH2bKkAv22xYUQpPSVuEytPS0KoZksnSM1rk=;
 b=rFcMXeOQYGTbekcz1V/QfawZ0rlp7KxWxrpcwCk9LH9BxHt4rhULTYEW3K079PKlvf
 DArwwBFzXk381nfi43y+bbzg5+mbiGezU1lCPBHlFa77TCRD6FAo2GAqr1GV4XzrzMLg
 DbkUl2MklvLzAPV/YmdvDfHoqxs0KY4nfG/lJCUpbIxJuQtBV8mYvV591FesQv5PszC/
 E/JbmFXrh1EaqMF43R/nGeC5pSevpDNa16wW52ze7g0tcoKTj4N6xUcFMS0JVJGbGTB5
 oaGPOMg03X7F9nbk/ifCrte81fEyHJDHl7/gSuJQ01BZFt32lJgrWk93Zsk0ooWTnOL1
 97gQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=raspberrypi.com; s=google; t=1793199234; x=1793804034;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=d8xiOKoQDSvdpojkDy4fldRww1u+2VH02DEwdCLpEj8=;
 b=qX55Z5Ajgv8iw9+FM4sQ7Mh1okwNvp/BgwiBfECgZbr0M5326MsNPedyAjiT8t37eU
 GMfk4dS7OeiDVz94SGucM6A9Aa3onefUDZR16bSU+GZX8kFwVJTPWARrhvGjaCtiupRn
 Eh/dNGwCjrQK4xkKW+lHngeKMuKtxEcporCfml/qD/jeBnzt0V+EE9HqHWust1BhQ8V+
 o6BNVb8oXNdf1x6blYGQ39I3g1vRaDHNv0097sjf2xJo12l9ehv7fGAGKhoUF867vp8P
 2geObsyFcu3Mw3lXjITxXybDaxejjcep9H1PI6VsCR24IuZmaSfCE5l+r8gAmevQxtFZ
 xV1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793199234; x=1793804034;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=d8xiOKoQDSvdpojkDy4fldRww1u+2VH02DEwdCLpEj8=;
 b=r1rA6GN8oL/zmOIEoZeXOQrRxaGj3hCtCMqhW3G5dgaqo0Xw+FQE6sTBlnyo6DmNz4
 4WTn/TVR7zBa2uoL3V08hsZqkQcXljDiCFkYjFRirCsLPXMniOwccFDbxLiyV5ZRTo0h
 HIin4JKh67tq9KiKkdsZj5YZvDmZOfGMXuA0iajOEsHPAjEa6YiUnhy7hKvDE5JoCW5v
 gZE2Csv1Pr2RDwnhVNHJEJsoS6KS4K4AUME8HrPOitj5WOSHomdmjKYClUhef7ETlbzH
 keikB/GRE+0ZTGzdKr9pe27GmMcfpF5uLiDZWDynWUamFo/TVFNccz+FwKgxSrxJkcjB
 /yZQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzYKY+KH1IE/Qo/gqyXZfYbMYSC64ksAsLYstNVaxMxU4U+0IlzWNewrO69LYsBMl4fHt/nZO6TE+M=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJoOhNASpaM/aXmszTWI3lLqpUfYxY5qtqYmT/9A4+/vMzp38th
 paDY5qnHDoKeaqUKgl6cuSawTN8GhmPxsyLVwjiLpGzfhxj8HPbfcE6YTZzE0UbHgvg8NpIOr4w
 jANuOJDl2eFXSVjaNUibbapt5Z+KZeDsIKqWfD6elKw==
X-Gm-Gg: AYBFou03M2LM/CV/uXsvXs6eijmvANs+B4lUFwrEFhKwNhi78jEdFe7tJ44+YTK5oME
 oHCJoM0V+KErNctvti5oc9omNMzi4eDldTlxMFEwriF7jIW+TNgg87Y0KvrJ5P8cs0Vi+CELlRJ
 yRnkhJkOnDJOfQDKEDrVxA7ccUQacpwwDobGrIUN9AwD7ff8ofFpq3he8znQZriutG7u8/Ut5cR
 X7QB2tazs5qxArZa4AAl/y5vR+O9WjXIEIPpcWhlJN1lixB4Ej86mVdz+3qRCpJyeV88o3VKxWU
 rKowBRv6X2pSoM91M93ZUf57sIbqe4njSLDsdOX2xzNQSsj+F36togt1BnOllfSZmxsirlZmQ4P
 FJYWllgoHDv5UPMv79gVPyyGi5Uq7NB51aybOXviQxae7TK0YtlmSnlGGHop0UCScw9Huk7OXpO
 1sdNs69MS9VBcXJqtnaS7AI7NUIw3J3snBj6gA+1WZX83oxMDdZMWJ
X-Received: by 2002:a05:6870:812e:b0:49e:4ed0:11d6 with SMTP id
 586e51a60fabf-4a8bb54635dmr1913954fac.37.1793199234106; Wed, 28 Oct 2026
 07:53:54 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261026191618.9430-1-henryzhang62@gmail.com>
 <20261026191618.9430-3-henryzhang62@gmail.com>
In-Reply-To: <20261026191618.9430-3-henryzhang62@gmail.com>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Wed, 28 Oct 2026 14:53:37 +0000
X-Gm-Features: AclHuK-yXvNbMb1wINM_sef0W5700xQE-XEO0jTPLsBShdsNppw3Y1J1uJ4AXF4
Message-ID: <CAPY8ntCBPwyZkM=F0_0EQOjMRqKO2Do_Cwum24ZGoWEofr7ETw@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] drm/vc4: dsi: Rate-limit error interrupt messages
To: Henry Zhang <henryzhang62@gmail.com>
Cc: Maxime Ripard <mripard@kernel.org>,
 =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 26 Oct 2026 at 19:16, Henry Zhang <henryzhang62@gmail.com> wrote:
>
> The error interrupts (contention, sequence and timeout errors) are
> always enabled and each one is logged with drm_err() from the interrupt
> handler. When a peripheral leaves the data lanes in a bad state, the
> same error is raised again as soon as it is acknowledged. On a
> Raspberry Pi 4 a "data lane 0 sequence error" was seen at more than
> 50000 interrupts per second; printing every one of them, mostly to a
> serial console, starved the rest of the system to the point that the
> SD card driver timed out and the board had to be reset.
>
> Use drm_err_ratelimited() so that the errors stay visible without
> taking the system down.
>
> Signed-off-by: Henry Zhang <henryzhang62@gmail.com>

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

> ---
>  drivers/gpu/drm/vc4/vc4_dsi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_dsi.c b/drivers/gpu/drm/vc4/vc4_dsi.c
> index 5452b727a..face44a23 100644
> --- a/drivers/gpu/drm/vc4/vc4_dsi.c
> +++ b/drivers/gpu/drm/vc4/vc4_dsi.c
> @@ -1487,8 +1487,8 @@ static void dsi_handle_error(struct vc4_dsi *dsi,
>         if (!(stat & bit))
>                 return;
>
> -       drm_err(dsi->bridge.dev, "DSI%d: %s error\n", dsi->variant->port,
> -               type);
> +       drm_err_ratelimited(dsi->bridge.dev, "DSI%d: %s error\n",
> +                           dsi->variant->port, type);
>         *ret = IRQ_HANDLED;
>  }
>
> --
> 2.47.3
>
