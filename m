Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5031FCD4F5E
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 07:22:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A220E10E08D;
	Wed, 20 May 2026 07:22:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="EMVF/5TY";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E726810E08D
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 07:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779261739;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xx2spnpzWhoLag/qhNvFLWpyojrRWUzv888prY2ah/g=;
 b=EMVF/5TY9Z+ov2XErYebG2/YTaGwrc1Nd9r8MMGS/RN6tuGHGOMovsMGKyogf7ENieQ7i7
 /iE0y6TGN+fmY3TzxArCSnMOx91cdYhNPW8is5IspVIEagpFM8eOe3U1ifHLN8cTwBNTaC
 ECRRBG/vA+ROaOP3EiSTcN87Kbfv7Sk=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-C0ICbGcxMpewwPamQHi4OQ-1; Wed, 20 May 2026 03:22:17 -0400
X-MC-Unique: C0ICbGcxMpewwPamQHi4OQ-1
X-Mimecast-MFC-AGG-ID: C0ICbGcxMpewwPamQHi4OQ_1779261737
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-7cfea0b5b7cso24461947b3.0
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 00:22:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779261737; x=1779866537;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Xx2spnpzWhoLag/qhNvFLWpyojrRWUzv888prY2ah/g=;
 b=PgmP6Xph0K+0qgB9UcsVGxx2IuUqXgH/vXnH9Fuf76vHYScz6BfKskNqlbBjuf0E6D
 ggnidPFU/38eq7A9IqGPCcN+bbvUUpJ0Z1+Ah3i1aRlSEu6Crj5TjIETQ+0Nv62K9NjB
 lmmJqm2kEDJ+5P6kqM3GMhxfiwGPNXx68wIVaTU/vM2JmX5K6H4Io6mRE4Ah2g5ePxxK
 ByS0uqH5XPPEVGrSeDHgHYSzey636jVWRh6JrcBFSeXA37MqESKk4AzHy96e06AYpCHY
 qBGKB1VvLE/wMmAj5SCUx4dHvEyQN76Tqc6e7nZ4JKlX9bv/pfgrcDoxG3XybprTryjY
 5ZQA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/DZD4nBAblhL6NlGYkDfaJDKoH2y22aqZkQGICENL05kd16VgDYjqWgOBGidPuhodivR1UVow4YxE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy+/bwucrskOLvBIlXOXBmv7XdW3OiZqx2yeemZjfKoMbW1HFKq
 S4T1ijpxidblmDWvyQQRzTc5lhxaMB8jw1DEQkTnieta87flvAN9FxcodRT3VQtYsOFMwh/tOyP
 lzM9rxNtrmDUC1ele1uJ8OWj+A3ns4TAu3I3vzCweeE5VxfeT3IA9KmyCZjtsvB/z1yzUzpnG56
 vsmMGtth6KYsU8IjI+vyyToBdksRhUpEYZtACu4cUBST+J
X-Gm-Gg: Acq92OFLqD+4SW1C585qSj1BIa4EGX62/oNYK0soNcVhXx/ozhUkxD5Kd0WglL5SmeQ
 zIOc/rEI2I6DDaTimNuCWMbtUiBiCnEGENydqFeg42Q2KdZZL9jeuB8KjHnC6eHD9/PrcscAIZT
 ICfZcYf3JVgYs2BY37JiJ+gutzW+tMMfDwb+Y0GgZIovUUhK6oNLRttZ2cL79fItBVinklhKuPx
 0Io1Q==
X-Received: by 2002:a05:690c:84:b0:7b5:88ec:91b0 with SMTP id
 00721157ae682-7c95d1d9e08mr253826657b3.48.1779261736931; 
 Wed, 20 May 2026 00:22:16 -0700 (PDT)
X-Received: by 2002:a05:690c:84:b0:7b5:88ec:91b0 with SMTP id
 00721157ae682-7c95d1d9e08mr253826267b3.48.1779261736472; Wed, 20 May 2026
 00:22:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260519-cgroup-dmem-memcg-double-charge-v2-0-db4d1407062b@redhat.com>
 <20260519-cgroup-dmem-memcg-double-charge-v2-1-db4d1407062b@redhat.com>
In-Reply-To: <20260519-cgroup-dmem-memcg-double-charge-v2-1-db4d1407062b@redhat.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Wed, 20 May 2026 09:22:02 +0200
X-Gm-Features: AVHnY4KBhaLJ6-NKlQm0NilZQ57LVIjKu_pC_jcyJuZg3rPObvW4KXxjSx93n3c
Message-ID: <CADSE00L4R6PGtP6yGTZ6Ym=tvOZEYHRbuEtEu0BKX294HN6qXQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mm/memcontrol: add dmem charge/uncharge functions
To: Eric Chanudet <echanude@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, 
 Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>,
 Maarten Lankhorst <dev@lankhorst.se>, Maxime Ripard <mripard@kernel.org>, 
 Natalie Vock <natalie.vock@gmx.de>, Tejun Heo <tj@kernel.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 cgroups@vger.kernel.org, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, "T.J. Mercier" <tjmercier@google.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Maxime Ripard <mripard@redhat.com>, Dave Airlie <airlied@gmail.com>,
 linux-doc@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Z6YaQoaPngU41ik3EfZXi9_xT8muoEh6DKfOCPlcVR8_1779261737
X-Mimecast-Originator: redhat.com
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

On Tue, May 19, 2026 at 6:01=E2=80=AFPM Eric Chanudet <echanude@redhat.com>=
 wrote:
>
> Add mem_cgroup_dmem_charge() and mem_cgroup_dmem_uncharge() to allow
> dmem pool allocations to optionally be double-charged against the memory
> controller. Take the struct cgroup from the dmem pool's css as there is
> no convenient object exported to represent these allocations. These will
> resolve the effective memory css from that cgroup and perform the
> charge.
>
> Introduce a MEMCG_DMEM stat counter to memory.stat to make the cgroup's
> dmem charge visible.
>
> Signed-off-by: Eric Chanudet <echanude@redhat.com>

Reviewed-by: Albert Esteve <aesteve@redhat.com>

> ---
>  include/linux/memcontrol.h | 16 ++++++++++++
>  mm/memcontrol.c            | 65 ++++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 81 insertions(+)
>
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index dc3fa687759b45748b2acee6d7f43da325eb50c1..8e1d49b87fb64e6114f3eb920=
293e14920290fe7 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -39,6 +39,7 @@ enum memcg_stat_item {
>         MEMCG_ZSWAP_B,
>         MEMCG_ZSWAPPED,
>         MEMCG_ZSWAP_INCOMP,
> +       MEMCG_DMEM,
>         MEMCG_NR_STAT,
>  };
>
> @@ -1872,6 +1873,21 @@ static inline bool mem_cgroup_zswap_writeback_enab=
led(struct mem_cgroup *memcg)
>  }
>  #endif
>
> +#if defined(CONFIG_MEMCG) && defined(CONFIG_CGROUP_DMEM)
> +bool mem_cgroup_dmem_charge(struct cgroup *cgrp, unsigned int nr_pages,
> +                           gfp_t gfp_mask);
> +void mem_cgroup_dmem_uncharge(struct cgroup *cgrp, unsigned int nr_pages=
);
> +#else
> +static inline bool mem_cgroup_dmem_charge(struct cgroup *cgrp,
> +                                         unsigned int nr_pages, gfp_t gf=
p_mask)
> +{
> +       return true;
> +}
> +static inline void mem_cgroup_dmem_uncharge(struct cgroup *cgrp,
> +                                           unsigned int nr_pages)
> +{
> +}
> +#endif
>
>  /* Cgroup v1-related declarations */
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index c03d4787d466803db49cdaa90e6d6ba426b7afe2..91a7ac16b6eac2d6c3700b688=
5a068bf8b640706 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -433,6 +433,7 @@ static const unsigned int memcg_stat_items[] =3D {
>         MEMCG_ZSWAP_B,
>         MEMCG_ZSWAPPED,
>         MEMCG_ZSWAP_INCOMP,
> +       MEMCG_DMEM,
>  };
>
>  #define NR_MEMCG_NODE_STAT_ITEMS ARRAY_SIZE(memcg_node_stat_items)
> @@ -1606,6 +1607,9 @@ static const struct memory_stat memory_stats[] =3D =
{
>  #ifdef CONFIG_NUMA_BALANCING
>         { "pgpromote_success",          PGPROMOTE_SUCCESS       },
>  #endif
> +#ifdef CONFIG_CGROUP_DMEM
> +       { "dmem",                       MEMCG_DMEM              },
> +#endif
>  };
>
>  /* The actual unit of the state item, not the same as the output unit */
> @@ -5909,6 +5913,67 @@ static struct cftype zswap_files[] =3D {
>  };
>  #endif /* CONFIG_ZSWAP */
>
> +#ifdef CONFIG_CGROUP_DMEM
> +/**
> + * mem_cgroup_dmem_charge - charge memcg for a dmem pool allocation
> + * @cgrp: cgroup of the dmem pool
> + * @nr_pages: number of pages to charge
> + * @gfp_mask: reclaim mode
> + *
> + * Charges @nr_pages to @memcg. Returns %true if the charge fit within
> + * @memcg's configured limit, %false if it doesn't.
> + */
> +bool mem_cgroup_dmem_charge(struct cgroup *cgrp, unsigned int nr_pages,
> +                           gfp_t gfp_mask)
> +{
> +       struct cgroup_subsys_state *mem_css;
> +       struct mem_cgroup *memcg;
> +
> +       /* CGROUP_DMEM and MEMCG guarantees this cannot be NULL. */
> +       mem_css =3D cgroup_get_e_css(cgrp, &memory_cgrp_subsys);
> +
> +       /* Use the memcg, if any, of the dmem cgroup. */
> +       memcg =3D mem_cgroup_from_css(mem_css);
> +       if (!memcg || mem_cgroup_is_root(memcg)) {
> +               css_put(mem_css);
> +               return false;
> +       }
> +
> +       if (try_charge_memcg(memcg, gfp_mask, nr_pages)) {
> +               css_put(mem_css);
> +               return false;
> +       }
> +
> +       mod_memcg_state(memcg, MEMCG_DMEM, nr_pages);
> +       css_put(mem_css);
> +       return true;
> +}
> +
> +/**
> + * mem_cgroup_dmem_uncharge - uncharge memcg from a dmem pool allocation
> + * @cgrp: cgroup of the dmem pool
> + * @nr_pages: number of pages to uncharge
> + */
> +void mem_cgroup_dmem_uncharge(struct cgroup *cgrp, unsigned int nr_pages=
)
> +{
> +       struct cgroup_subsys_state *mem_css;
> +       struct mem_cgroup *memcg;
> +
> +       /* CGROUP_DMEM and MEMCG guarantees this cannot be NULL. */
> +       mem_css =3D cgroup_get_e_css(cgrp, &memory_cgrp_subsys);
> +
> +       memcg =3D mem_cgroup_from_css(mem_css);
> +       if (!memcg || mem_cgroup_is_root(memcg)) {
> +               css_put(mem_css);
> +               return;
> +       }
> +
> +       mod_memcg_state(memcg, MEMCG_DMEM, -nr_pages);
> +       refill_stock(memcg, nr_pages);
> +       css_put(mem_css);
> +}
> +#endif /* CONFIG_CGROUP_DMEM */
> +
>  static int __init mem_cgroup_swap_init(void)
>  {
>         if (mem_cgroup_disabled())
>
> --
> 2.52.0
>

