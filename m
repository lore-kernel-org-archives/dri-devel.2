Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC52EFF885A
	for <dri-devel@archiver.kernel.org>; Mon,  4 May 2026 04:01:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5509710E0B1;
	Mon,  4 May 2026 04:01:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="K/thZJr8";
	dkim-atps=neutral
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com
 [209.85.222.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 920B210E0B1
 for <dri-devel@lists.freedesktop.org>; Mon,  4 May 2026 04:01:47 +0000 (UTC)
Received: by mail-qk1-f171.google.com with SMTP id
 af79cd13be357-8d736211595so245553785a.0
 for <dri-devel@lists.freedesktop.org>; Sun, 03 May 2026 21:01:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777867306; cv=none;
 d=google.com; s=arc-20240605;
 b=O1ciKq1gaYRbVyeZor1x24Sd3udKUskVHLrQDjIYq9aoDyX/pl/uHLGPgjKLDnw0hR
 /FqK2G9FvN7gNbHroG45wi9gXIwHiTGgLBTg7RxZZ1/7JW2g9K5zdqwtoZgNHUtzauZp
 RXFFRENvHNQ9PZjbTpsWtmzv7qZucUtgBEBN3LUT4bdZhXi5kcvTyiJ5hdly1FVSO4w4
 lO9QcdFMqkUbc/PvsmWxGMRd8Wnf740xESxKlwSUCiBn37YOac4F9WlJ0q3OQLgVew9A
 wVCe+5GKa5TG9lLEODlM6lIlPT5vQniQCQ0DEEVBD98EGIhRpfPzy5ozuQNNBBtSIDVb
 QlZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=oGlVUVNCo7t578SnF0/FJlFOI+mo4qIG1hmcAiuexlk=;
 fh=VtjbJCOUzZdHzaQQ7FLxMiSEAlpMX6+W7+4vmfDqmRQ=;
 b=Wyqczfs3d1K40EeQAqX5Ixz9owcdAxKX3nBksagw2rDuQVd2hVs7Wg5wpqhR3no27c
 ppzPu0SJDojQ1wGWqcpJmjVZN8ckDanH04dwik/WxPsyowsNmCYeqyLN75PoEgGSPv7p
 xjlON3GNxmNgOS6a67P7Gpb8k++4JyGlign7LywGcC7roXB8jC8IjcCknYY1TpSgB/PY
 GF58ztde+L8dgUbKLX+1/KW1KbUZelUwaXhcD23pg+wq4Q1iotB5+qdvYwjHpMXz+Dkh
 3kBV25VGmZYCEhrfZBuOGIB/gKNT1N2boa0MwtniufSXiLPPrWb7yLPzLoeRrbbtf+ot
 SbTw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777867306; x=1778472106; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oGlVUVNCo7t578SnF0/FJlFOI+mo4qIG1hmcAiuexlk=;
 b=K/thZJr8LMDez1Ul+LA5Zc0zpDI1vIDQALvtTRNa++AZAVGRHcjkTv1yswIRIAArOD
 ug+7KSz6R4MMgAsoUzRmN0i3LR2YvlcuqjHFpzq03yAIbUmzIRloBvtzbFtaVc7wcljD
 kb8mdGCWC7aawdYy+kL3o8kGxgepOnC8/2/68kBfxLjmmHoOS+bePsXefCZ9EL+aeHts
 YQFVkh+j6nCuUrxaYKBDe1zR1+7oaIN/wpwEWNJC/lzn2nZTdmN2vimUkNAscJXfFe0L
 tLjGc0aujL9qrqbselwYwta9eQjEPjYII5BpJa0p8K5qPGd490+LyD7hBnBGyLElkjnP
 P7bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777867306; x=1778472106;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oGlVUVNCo7t578SnF0/FJlFOI+mo4qIG1hmcAiuexlk=;
 b=j0xKlpLIQLsFD3Iecx89V7AOyov2ZgcpQ00gbrblKAAcyfKceUjoEmsjAW+xeAWUh7
 XUKtbUfU9QR39DJ0dEpQaVTq/Mzekk2Km3LOqX8nbKHFnXLdFUChl17qOAp8KA6LeNXW
 NKa44FLuxRRrMxI71lwURpniyHQcgbVoBp4to9ckC4rzrfsxqd4pY83YJ5+AZwA4FwQv
 0XYVj1rVwQiKfePCz10NHkrulyzE2DLYL7A3XtHnhAVR+vv7V2TX6scD8HAL/NfLK9s8
 IKN95oJc+jOwDGz+BW/uVuwYoeUjrq8WmW+lP4WIYHJizat2/LWTgW49t/0ac57Md9nq
 FEpQ==
X-Gm-Message-State: AOJu0Yw1uO9+Kos5HLgVRJiUZ3WYsByRRBS1W4IBUUZfcsMrtCMfxKll
 YTM7w7P9cnjf1imm9ay7uPMaY1aywU1BLDbOWex7MfnctzqEmQgN40KpJ6qGK0JxLwVX+rujbiQ
 wALMpGUxp6JdE5F9akUasH/lgwZRE/as=
X-Gm-Gg: AeBDieuooOeJYjuYiusF+6zkvwrhLCPEMdPkjWNINojcoRYYRvxTpplNNmSLVLFhRge
 6s18yOEAD4QdGjKXmeijUghlo8Y9DB1bpTqvdeaI8JxqGlbd1ezT8tr9W5MJTSQRVayFmotx7PH
 2Kf5d03q8nWjKpw0fft2uirReZiLbOnLs6kPCddlcFjdfRJ/kUHGeeGr3xXlWnVCqhj32W3sm8i
 zQAT0DbzuBsGOPNDCmSCJsDBhMvX3GL/qCDFynOsSBRBG8kdlYLMfuaNeZoaioCKD8qt9vPLiMq
 jko4BXuPcx57E3VCqcm/KiqtTjeIrNbkVs9mcm2L4lt6knNMcSrNESaHEsMUOQAMlS2Kn7vkmFi
 xVw==
X-Received: by 2002:a05:620a:708a:b0:8f1:5e8f:fff3 with SMTP id
 af79cd13be357-8fd16c9964fmr1319335285a.26.1777867306422; Sun, 03 May 2026
 21:01:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260501215856.840898-1-lyude@redhat.com>
In-Reply-To: <20260501215856.840898-1-lyude@redhat.com>
From: Dave Airlie <airlied@gmail.com>
Date: Mon, 4 May 2026 14:01:35 +1000
X-Gm-Features: AVHnY4LmcMo5jkCCXrsqxOpC_hYtr1-nSy7Wtvdm85s7TmkVILKxYJXd3dyZi5U
Message-ID: <CAPM=9tyVOHU4KZxpGeKn=V3zhGnBwq4v5QfXvzdUE4QPQ2zMOA@mail.gmail.com>
Subject: Re: [PATCH] drm/nouveau/kms/nvd9-: Use contiguous memory for CRC
 notifier context
To: Lyude Paul <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>, 
 Dave Airlie <airlied@redhat.com>, Timur Tabi <ttabi@nvidia.com>, 
 Suraj Kandpal <suraj.kandpal@intel.com>, James Jones <jajones@nvidia.com>, 
 Faith Ekstrand <faith.ekstrand@collabora.com>, stable@vger.kernel.org, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Ben Skeggs <bskeggs@nvidia.com>, 
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Maxime Ripard <mripard@kernel.org>
Content-Type: text/plain; charset="UTF-8"
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

On Sat, 2 May 2026 at 07:59, Lyude Paul <lyude@redhat.com> wrote:
>
> It looks like CRC read back has been slightly broken for a while now, in
> particular on GPUs using GSP. On my test machines, it's worked normally
> when attempting to use it from fbcon. After gnome-shell gets started
> however, attempting to read /sys/kernel/debug/dri/$CARD/$CRTC/crc/data just
> returns -EINVAL.
>
> It turns out what's been happening is that since we've been using
> nvif_mem_ctor_map() to both allocate and map the CRC notifier region - we
> haven't actually asked for a contiguous allocation, and simply ask for
> whatever type of memory allocation nouveau can find first. This doesn't
> work because the CRC engine on nvidia GPUs doesn't support non-contiguous
> allocations, which also causes us to fail setting up the kmsCrcNtfyCtxDma
> object on pre-blackwell platforms since we don't have a single memory
> address we can point nvif_object_ctor() to. Instead, ctx->mem.addr gets set
> to ~0ULL.
>
> It does however, seem to work when fbcon is running. The only reason I can
> think of this is that before we start up a display environment, there is
> pretty much nothing allocated in our VRAM that wasn't allocated by nouveau
> itself - making it dramatically more likely that we end up finding a
> contiguous allocation by default.
>
> So, fix this by manually requesting a contiguous allocation when we
> allocate our context notifiers.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Fixes: 12885ecbfe62 ("drm/nouveau/kms/nvd9-: Add CRC support")
> Cc: Lyude Paul <lyude@redhat.com>
> Cc: Dave Airlie <airlied@gmail.com>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: Dave Airlie <airlied@redhat.com>
> Cc: Timur Tabi <ttabi@nvidia.com>
> Cc: Suraj Kandpal <suraj.kandpal@intel.com>
> Cc: James Jones <jajones@nvidia.com>
> Cc: Faith Ekstrand <faith.ekstrand@collabora.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: nouveau@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v5.9+
> ---
>  drivers/gpu/drm/nouveau/dispnv50/crc.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/nouveau/dispnv50/crc.c b/drivers/gpu/drm/nouveau/dispnv50/crc.c
> index deb6af40ef328..5817f39934a8b 100644
> --- a/drivers/gpu/drm/nouveau/dispnv50/crc.c
> +++ b/drivers/gpu/drm/nouveau/dispnv50/crc.c
> @@ -10,6 +10,7 @@
>  #include <nvif/class.h>
>  #include <nvif/cl0002.h>
>  #include <nvif/timer.h>
> +#include <nvif/if900b.h>
>
>  #include <nvhw/class/cl907d.h>
>
> @@ -499,16 +500,24 @@ nv50_crc_raster_type(enum nv50_crc_source source)
>   * notifier needs it's own handle
>   */
>  static inline int
> -nv50_crc_ctx_init(struct nv50_head *head, struct nvif_mmu *mmu,
> +nv50_crc_ctx_init(struct drm_device *dev, struct nv50_head *head, struct nvif_mmu *mmu,
>                   struct nv50_crc_notifier_ctx *ctx, size_t len, int idx)
>  {
> -       struct nv50_core *core = nv50_disp(head->base.base.dev)->core;
> +       struct nv50_core *core = nv50_disp(dev)->core;
>         int ret;
>
> -       ret = nvif_mem_ctor_map(mmu, "kmsCrcNtfy", NVIF_MEM_VRAM, len, &ctx->mem);
> +       /* The display engine requires a contiguous region of memory for the CRC notifier context */
> +       ret = nvif_mem_ctor(mmu, "kmsCrcNtfy", mmu->mem, NVIF_MEM_VRAM | NVIF_MEM_MAPPABLE, 0, len,
> +                           &(struct gf100_mem_v0) {
> +                               .contig = true,
> +                           }, sizeof(struct gf100_mem_v0), &ctx->mem);

I don't think you can just throw gf100_mem_v0 in here like that, I
think you should maybe make nvif_mem_ctor_map deal with this since you
want a kernel mappable vram region it needs contig.

Dave.
