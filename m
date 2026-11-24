Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBCD606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 14:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.a=rsa-sha256 header.s=google header.b=EpKfecDk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EEEC10F65D;
	Tue, 24 Nov 2026 14:28:43 +0000 (UTC)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FD9E10F65D
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 14:28:36 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-2f06ff94acfso16826295ad.0
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 06:28:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795530516; cv=none;
 d=google.com; s=arc-20260327;
 b=f55fjLUeAMP6WjIMRt6DazEq2uC9ZIJ1mSzDeVxnOZdtbtcyYXMWlBbY2fYf+6kOzF
 A98shAafndj6nQ019SxCbPeM2Za/X1l/bILsyjouchVozqeOCCS2ZrmzVWvUTfV9DTV6
 /JeVr0vRWWQfyHXhGc87CKI0g59wrUPnUcZLiXVwAetFP84v3XdAcxD4NMgcPXl4+wZD
 t2341h1+EPK4cCuyRbmpYI6tOOBmN7V8Am+tfGM+8oxCRjbfLwDxw/YoO1IM/4e+Fc2p
 dn+B2x5dj0ia9asGxouLTRVE/i/f4Ea2TIgNQ7/R6NgGhEpiQcRY2NgFSYQsGdtXDhcC
 +NkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=mQ2JTBOODXVLExMT4lau5wcd1i8TygMCNsmKX6gW1YI=;
 fh=R/XRAHhf+ZxZW7bGzLq53rzjNHxbgMXkidm58X/V78g=;
 b=WQsLZeWPQT63jM+ea+Pz7Nd4X/RrZIATGgUIPNpDzu1+JwnBIvrs9KfnDaDF1RKowv
 khevhN3K6AV0d5GQW6Tg6eNx8Lgn6CG9XqQiDtvMRpVLour8zlXe9iHASDp711YyPDlR
 16VUaWmrMTM+iQMx4F8p+jEpCBhKspKUnFcq5AWGbVn5jw3lhdTR7qSE/6Ro+/4Fo2/D
 8d2HUidpbunnH1oQ0T08h3DTHdrdVa2cO7njHYOrfCEfzFnBZJon8urAm8bAtwJ9Bx18
 V1EFJddPIRlwLDt9Flzj6dL7iw119R8NjHVcrJ2BqGSmeIRO8dKxWqB88Cue/YLyDpFU
 4U0w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar.org; s=google; t=1795530516; x=1796135316;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=mQ2JTBOODXVLExMT4lau5wcd1i8TygMCNsmKX6gW1YI=;
 b=EpKfecDkF0P5VqtbhxYmZJwiHq4wU1B92QzN+9m3qz2+at6RWuX6o8kkh9JpbMdpZE
 lho+jL7rnJQI6nqJ6NXbl7cNxK/OgWW5a3gQPtp+3Ji/oQzR3F7TsrYzpNGLNpeZNV9G
 RVQNwKxAkYNGL1wtluUsclc/5nV3K4yZzB44lC+XmpKiuf5kHON70GMDfbdCNnBf+9hI
 VUYpEnxI73s9oCpVDvR72FS4blXqHuwj1ULLu85lhHwpaeUgzP/stpwAZTrBkdGyAOi0
 pzShWgxB/YzR7hFgV3kLLR5czywtc+FyYBQfCf43pEnHzgfyq14lwR+Aoguuz5ycvYhy
 EhHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795530516; x=1796135316;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=mQ2JTBOODXVLExMT4lau5wcd1i8TygMCNsmKX6gW1YI=;
 b=LOzGfl3lX8uyawLwf6aILq01OJfoj1i7//Y+UobkwMX79NWnmfzpDMEZjSqmvaOjcs
 DX+TSoaVcdbCanRjgztGhGdVChU/sjJuTL/6RpzLdRX4yWEoXYqPDxfDxZPWC/RS2ML+
 1WbHnAhjyBboCrjGV7NgFxUYxMxip3ca/VJei2/Uq0QC689JoKtwnfupwoukjW7KuZAW
 YJGvwdBtWBcV1xjJ8Yp83OP8eUDsGnQbNluJu8yC4GugQ7njaqKNNl8NeWTJqz7jk4lA
 oYS7xtBE+RbwRpFzTbaVyWY+Q/9WpALKII3y2dgT6bR4qmApp48zouyHLavWZxOIv3rt
 Y9XA==
X-Forwarded-Encrypted: i=1;
 AL+hErHjPMaT1tk3ONztZWFtqxZEQNEv5+L/GdUG4rjfggAjnhsyZRHe2OelrodB74XbRWy/AVqJWDZsdag=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8B6BYyOnRMcQJnGYeioS0jahfn2VEMosN4JSTVEi7qVt7Ub/Zr
 12W4lLe7ywN7kFWUNIfZz7fvag2i+QZsp+C61LgMCoZkCpoFCCl3s1eClDwFJbZ5iEkt9yf5zBu
 FU8hgkNvJA3j9Zfy68f6p5vegYWml/vX4ntSUN8AIzw==
X-Gm-Gg: AZFdTZe5uYkQGlidsbVMAg4vs1NBX26GjNYETLFqmucTcbPhUeeLNbDYktI39GipcfS
 giPfWESr3IcuYlR5P/piOoHmS80bHy+b315BQnm4FOJlyF/Kq0qZ6e7dMOJhP+Ohauo2MfrzmkK
 AXf14HZa0E7AX1lMPXbt4yRBoGYkbqqh8u+6fyKhLvjAbr1QsKor7I2lcLvYpvdLpbjauOfPYfK
 jRMurNkwk2uKxlgOx/gg2CPijxRJTFwj5jAp6Ax1Q6PzbhfFXRewntv3KbMn0pB3R+8sqTZAghj
 gdL33FqPNeGSSnEDu1GvUzguynfAiarCPhbDvw+QaM45tnTZsB1o1qBj4CN4WZAjxF3mxwwn8WQ
 PxZuWKPifz510b7H0eOEksFneMFK+5xkqKQ==
X-Received: by 2002:a17:903:19cb:b0:2e9:9a19:c5b with SMTP id
 d9443c01a7336-2f03f16d710mr139233565ad.47.1795530515765; Tue, 24 Nov 2026
 06:28:35 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260714114414.184512-1-angelogioacchino.delregno@collabora.com>
 <20260714114414.184512-34-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20260714114414.184512-34-angelogioacchino.delregno@collabora.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Tue, 24 Nov 2026 14:28:23 +0000
X-Gm-Features: Aa3M54rrDo3X7VrfTe9b69h24tjA9EEIAxDaPhgJEX5YWMApMtqcKA6bBO6NIJU
Message-ID: <CAPj87rO9saEC34+5NiYK8xyZiNytrVgOcszoY5uc7BpL=M4WTg@mail.gmail.com>
Subject: Re: [PATCH v2 33/46] drm/mediatek: Add support for Display Controller
 exDMA component
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@gmail.com, 
 simona@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
 tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 matthias.bgg@gmail.com, dri-devel@lists.freedesktop.org, 
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 justin.yeh@mediatek.com, jason-jh.lin@mediatek.com, kernel@collabora.com
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On Tue, 14 Jul 2026 at 12:45, AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
> +void mtk_exdma_layer_config(struct device *dev, unsigned int idx,
> +                                struct mtk_plane_state *state,
> +                                struct cmdq_pkt *cmdq_pkt)
> +{
> +       struct mtk_disp_exdma *priv = dev_get_drvdata(dev);
> +       struct mtk_plane_pending_state *pending = &state->pending;
> +       const struct drm_format_info *fmt_info = drm_format_info(pending->format);
> +       const u32 blend_mode = mtk_ovl_get_blend_mode(state, MTK_OVL_SUPPORT_BLEND_MODES);
> +       const bool csc_enable = (fmt_info) ? fmt_info->is_yuv : false;
> +       u32 val;
> +
> +       if (!pending->enable || pending->height == 0 || pending->width == 0 ||
> +           pending->x > OVL_EXDMA_MAX_SIZE || pending->y > OVL_EXDMA_MAX_SIZE) {

Definitely don't do this please. If exdma is asked to do something it
can't (and I'm assuming that these last two checks are intended to be
on w/h rather than x/y?), then you need to reject that in
atomic_check. Getting here with pending->enable == true and then not
enabling it, is not OK.

Relatedly, most of mtk_plane_pending_state should be deleted as
duplicative of drm_plane_state and it would be great to see a patch
series very soon to clean that up. It's been that way for the last 10
years, with seemingly no discussion ever of why it exists (my guess is
that it's a holdover from pre-atomic code), but no reason to
perpetuate the badness.

Same comment applies for the blender.

Cheers,
Daniel
