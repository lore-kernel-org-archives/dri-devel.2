Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC9E2C44515
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 19:44:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AE9C10E14E;
	Mon, 20 Jul 2026 19:44:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="G4e4RkH7";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47EC410E168
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 19:44:10 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-495509b08ebso90075e9.1
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 12:44:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784576648; cv=none;
 d=google.com; s=arc-20260327;
 b=Lz8dByhtraA6OihJVK5V4Iqqe/kJPxZh+YOYvW2S1eeyLzQsWK/58W+FZLX3brnko/
 EQUlkAUhmIr2CZgGg7g+MUdzIMV6o8INS68JiVgUmN7emcj1qc01yCnxjY3fy5Gm1vcx
 JEmVJvmwuhgstWoM5ylIGrrgnOpcV9BdMREF5GrIEpnXHGUhMfEtpByo3N2bG6aM5UwL
 wUGp3iwSZl2IKWM7Tjr/V04D2QTC55tGAHSKKkBGdWQmq1hAFpTHU/cx3pwZCvQheE6t
 E18EhU3Rksu0GntkakpNcz0yXSYJMapwtdMnbEDlCkrhDLl6vu+fzJe8pi7pDBAqwG3v
 ppcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=LfC49QPlyZaqOrOjM8PszDB9lp1q3fneMjUdK0YaQRk=;
 fh=Qwztk9mP/ARWToxql7Aydq7gBFJmshkv3iBBpB8SUCo=;
 b=QasCQEzNGRecxh9dR60yW2Zq7YA6ae1NOPr01KCI85IH6uK6TwcTOJMWOnH8Nmhijr
 W+OzG37IXlymX33iBejS9y3DTSxXK82Fm8aNDCLcRRk4BSxVw3ahqYmHwcpw3fmOYFi8
 hUMbG/jKWoYXJwMpfsdGSUPrOtFT4Tvnnq+ZMOkZskzLylxGXMINXmchse2G11++iL7l
 4L4t3KyMYlAihgYRhEYJInW4nsT7fu+ojq8J0K0SqNprSqQz2VyP+H1W3Zs0978tcM73
 r3josyoNhMij5nhK5/91DLopHckEG0Q8Y071rj2NVvng0/Qc4DG/StBP+lT08EstLX3X
 0iwA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1784576648; x=1785181448;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LfC49QPlyZaqOrOjM8PszDB9lp1q3fneMjUdK0YaQRk=;
 b=G4e4RkH70uFwLAoLxZqgETbnfpBNAS13b7RHi000v+TYMSzR+9WpmXr19KzxcsPWfs
 EYgma88uwLdP64PqmtOvuflmdBDIultb3+a3H9mUtTgsgYCluxV+Jq4zO3KYmAJn/UWL
 PLZcVNgaag2FLBWtxZb/Z/Nq/4RIiw8Dq3CI+4cuknyaku7QY+HHfTEcJvKKepE3H0kl
 5i2wQMeQUjElNUPey/hRk/qwWPZaq9vA2zO90KppTYrfbcn9o7LiB4xRMoD1UQ0yncrb
 K0T4zjluFpgSoKxiQvPgDv9kSJIbAuVBbrTYkSEiBK6+x9mK0kALvUBG5oWovDWIjSCe
 /2cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784576648; x=1785181448;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LfC49QPlyZaqOrOjM8PszDB9lp1q3fneMjUdK0YaQRk=;
 b=pSbKTnlWFCiDySOHMQXr1zl9p238XyHkVK+dzOQ0/RGoWbKPVrAN3+bo3AhaJ/krGQ
 CWz71Lek19g/ywvcCR+q4sVDAKkQgRI9gZctEvisbFSrrCgi4pChAGLPWjn7nW3CZcTI
 MA6J4j5+3lOqMNV6cIJAP3SQKjlw2fQl84kOSgpufMr5hHYmuGVOOeACtPxR3/v5Ncmv
 Bd0kbOGJpt9FlLzed+2yv3YIups8g2ui7e9bYzd1fFuY7XncF1W1+8TzSSFDWuLkcUTf
 XbYvc1TNzA9o5LgYyN+8xslIIkHGNqnWkj2/gBwSZ/tvVCNiCDYnJbBYG1FfGrNqbEiL
 PFxg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpaAsBO159T4jksrds3V9NnCeglsrZ69njeUpozjocvnnaZy6sPtvVI/c7HaJYmrZi6LzItPYQ3KO0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxmKbQfNYo4skClOP05kFG60jlyzNhBC0PmDJY9TiRGwWuiFNhf
 k21/a5XORtlWUSlYYaZOUAfVVPK5YKd/dBikBxpio0KnhaUlhSdTsihlL3TCalRjQlnkkcNqoEg
 Odvn2oqcotJS8ZReCG0tTT/latuEIbD0fX0ROrqXM
X-Gm-Gg: AfdE7clDzQSRx+iJlWN0Sm8SJrIA73tgHide10/z6zMaodrBAVMNRIFshdBWwUY2eUo
 PEnCT9QovHdvlFKJiaIt1ylQHmfFKSz2g42rGGfmdZJmdbcYeYa44jKCOlX+2TEfFgFcFthabIq
 kfrz1n1gROiR4N5EZaVuX596WTTy1jXFaYMVQTSmSYOOpcU9zRb5FPdHmLTKyRB9nrRBRtZYPUx
 hb56KiOA4PwLlftNKHKF0LR1GVqvbxSrEQSXk2JlXlxZeyONxoMNX3PDB5dWbKzg0kER+1GSXAK
 XZpFoUzMpvojniuoGnWv3rjVlqo=
X-Received: by 2002:a05:600c:3412:b0:495:5515:3c00 with SMTP id
 5b1f17b1804b1-495643961d2mr413355e9.9.1784576647864; Mon, 20 Jul 2026
 12:44:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260719175857.4071636-1-ap420073@gmail.com>
 <20260719175857.4071636-3-ap420073@gmail.com>
In-Reply-To: <20260719175857.4071636-3-ap420073@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 20 Jul 2026 12:43:52 -0700
X-Gm-Features: AUfX_mzh-HpiMTdTmR9Mwblg1Yg1F2-k1cGWYRzG5BMePvMor3JMM2rdb0_Pak0
Message-ID: <CAHS8izMU4gQCH2v0dcOFkjP6Sxj7RUvC8=Baet=+pFXG24qh7A@mail.gmail.com>
Subject: Re: [RFC PATCH net-next 02/13] net: devmem: extend memory provider
 for knod
To: Taehee Yoo <ap420073@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Alexei Starovoitov <ast@kernel.org>, 
 amd-gfx@lists.freedesktop.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Andrii Nakryiko <andrii@kernel.org>, Bill Wendling <morbo@google.com>,
 bpf@vger.kernel.org, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, David Airlie <airlied@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>,
 Donald Hunter <donald.hunter@gmail.com>, 
 dri-devel@lists.freedesktop.org, Eduard Zingerman <eddyz87@gmail.com>, 
 Emil Tsalapatis <emil@etsalapatis.com>, Eric Dumazet <edumazet@google.com>, 
 Felix Kuehling <Felix.Kuehling@amd.com>, Hoyeon Lee <hoyeon.rhee@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jakub Kicinski <kuba@kernel.org>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>,
 Justin Stitt <justinstitt@google.com>, 
 Kees Cook <kees@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Leon Romanovsky <leon@kernel.org>, 
 linaro-mm-sig@lists.linaro.org, linux-hardening@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-media@vger.kernel.org, linux-rdma@vger.kernel.org, llvm@lists.linux.dev, 
 Mark Bloch <mbloch@nvidia.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
 Michael Chan <michael.chan@broadcom.com>, Nathan Chancellor <nathan@kernel.org>,
 netdev@vger.kernel.org, 
 Nick Desaulniers <ndesaulniers@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Saeed Mahameed <saeedm@nvidia.com>, 
 Shuah Khan <shuah@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 Simon Horman <horms@kernel.org>, 
 Song Liu <song@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
 Sumit Semwal <sumit.semwal@linaro.org>, Tariq Toukan <tariqt@nvidia.com>, 
 Yonghong Song <yonghong.song@linux.dev>
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

On Sun, Jul 19, 2026 at 11:03=E2=80=AFAM Taehee Yoo <ap420073@gmail.com> wr=
ote:
>
> Extend the devmem memory-provider path so a knod accelerator can back a
> NIC page_pool with accelerator-exported memory (dma-buf), letting the
> NIC DMA received packets directly into accelerator memory.
>
> Signed-off-by: Taehee Yoo <ap420073@gmail.com>

Changes look fine in general but I do not understand in the design how
the page_pool not bound to rx queue would be used. Maybe elaborate on
the design in the commit message or cover letter in the next
iteration.

> (cherry picked from commit d511a8cb3e229f8f5cf060985880d45bd384db87)

I guess remove unintended cherry-pick tag.

> ---
>  include/net/devmem.h                    |  58 +++++++++++++
>  include/net/netmem.h                    |   9 +++
>  include/net/page_pool/memory_provider.h |   4 +
>  include/net/page_pool/types.h           |  23 +++++-
>  net/core/devmem.c                       | 103 +++++++++++++++++++-----
>  net/core/devmem.h                       |   7 +-
>  net/core/page_pool.c                    |  22 ++++-
>  7 files changed, 198 insertions(+), 28 deletions(-)
>  create mode 100644 include/net/devmem.h
>
> diff --git a/include/net/devmem.h b/include/net/devmem.h
> new file mode 100644
> index 000000000000..f1c3895d7833
> --- /dev/null
> +++ b/include/net/devmem.h

Try to keep only include/net/netmem.h and net/core/devmem.h rather
than add an include/net/devmem.h

> @@ -0,0 +1,58 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Device memory TCP support
> + *
> + * Authors:    Mina Almasry <almasrymina@google.com>
> + *             Willem de Bruijn <willemb@google.com>
> + *             Kaiyuan Zhang <kaiyuanz@google.com>
> + *
> + */
> +#ifndef _NET_DEVMEM_H
> +#define _NET_DEVMEM_H
> +
> +#include <linux/dma-direction.h>
> +#include <linux/err.h>
> +#include <linux/types.h>
> +
> +struct device;
> +struct dma_buf;
> +struct dma_buf_attach_ops;
> +struct net_device;
> +struct net_devmem_dmabuf_binding;
> +struct netlink_ext_ack;
> +
> +#if defined(CONFIG_NET_DEVMEM)
> +struct net_devmem_dmabuf_binding *
> +__net_devmem_binding_create(struct net_device *dev, struct device *dma_d=
ev,
> +                           struct dma_buf *dmabuf,
> +                           enum dma_data_direction direction,
> +                           const struct dma_buf_attach_ops *importer_ops=
,
> +                           struct netlink_ext_ack *extack);
> +int net_devmem_bind_dmabuf_to_queue_direct(struct net_device *dev, u32 r=
xq_idx,
> +                                          struct net_devmem_dmabuf_bindi=
ng *binding);
> +void net_devmem_unbind_dmabuf_direct(struct net_devmem_dmabuf_binding *b=
inding);
> +#else
> +static inline struct net_devmem_dmabuf_binding *
> +__net_devmem_binding_create(struct net_device *dev, struct device *dma_d=
ev,
> +                           struct dma_buf *dmabuf,
> +                           enum dma_data_direction direction,
> +                           const struct dma_buf_attach_ops *importer_ops=
,
> +                           struct netlink_ext_ack *extack)
> +{
> +       return ERR_PTR(-EOPNOTSUPP);
> +}
> +
> +static inline int
> +net_devmem_bind_dmabuf_to_queue_direct(struct net_device *dev, u32 rxq_i=
dx,
> +                                      struct net_devmem_dmabuf_binding *=
binding)
> +{
> +       return -EOPNOTSUPP;
> +}
> +
> +static inline void
> +net_devmem_unbind_dmabuf_direct(struct net_devmem_dmabuf_binding *bindin=
g)
> +{
> +}
> +#endif
> +
> +#endif /* _NET_DEVMEM_H */
> diff --git a/include/net/netmem.h b/include/net/netmem.h
> index bccacd21b6c3..3ddfbd37500f 100644
> --- a/include/net/netmem.h
> +++ b/include/net/netmem.h
> @@ -127,6 +127,15 @@ static inline void net_iov_init(struct net_iov *niov=
,
>         niov->type =3D type;
>  }
>
> +/* Global page index within the dma-buf, accounting for multi-chunk
> + * scatter-gather layouts where each chunk owner's niovs start at 0.
> + */
> +static inline unsigned int net_iov_binding_idx(const struct net_iov *nio=
v)
> +{
> +       return (net_iov_owner(niov)->base_virtual >> PAGE_SHIFT) +
> +              net_iov_idx(niov);
> +}
> +
>  /* netmem */
>
>  /**
> diff --git a/include/net/page_pool/memory_provider.h b/include/net/page_p=
ool/memory_provider.h
> index 255ce4cfd975..4b58a9702fb7 100644
> --- a/include/net/page_pool/memory_provider.h
> +++ b/include/net/page_pool/memory_provider.h
> @@ -23,6 +23,10 @@ bool net_mp_niov_set_dma_addr(struct net_iov *niov, dm=
a_addr_t addr);
>  void net_mp_niov_set_page_pool(struct page_pool *pool, struct net_iov *n=
iov);
>  void net_mp_niov_clear_page_pool(struct net_iov *niov);
>
> +void page_pool_provider_set_netmem(struct page_pool *pool, netmem_ref ne=
tmem,
> +                                  dma_addr_t addr);
> +void page_pool_clear_pp_info(netmem_ref netmem);
> +
>  int netif_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
>                       const struct pp_memory_provider_params *p,
>                       struct netlink_ext_ack *extack);
> diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.=
h
> index 03da138722f5..3e866f249768 100644
> --- a/include/net/page_pool/types.h
> +++ b/include/net/page_pool/types.h
> @@ -31,8 +31,16 @@
>   */
>  #define PP_FLAG_ALLOW_UNREADABLE_NETMEM BIT(3)
>
> +/* Driver-managed pool with a directly-supplied memory provider, not bou=
nd to a
> + * netdev rx queue. Setting this flag requires page_pool_params.mp_ops a=
nd
> + * .mp_priv to both be set.
> + */
> +#define PP_FLAG_CUSTOM_MEMORY_PROVIDER BIT(4)
> +
>  #define PP_FLAG_ALL            (PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV |=
 \
> -                                PP_FLAG_SYSTEM_POOL | PP_FLAG_ALLOW_UNRE=
ADABLE_NETMEM)
> +                                PP_FLAG_SYSTEM_POOL | \
> +                                PP_FLAG_ALLOW_UNREADABLE_NETMEM | \
> +                                PP_FLAG_CUSTOM_MEMORY_PROVIDER)
>
>  /* Index limit to stay within PP_DMA_INDEX_BITS for DMA indices */
>  #define PP_DMA_INDEX_LIMIT XA_LIMIT(1, BIT(PP_DMA_INDEX_BITS) - 1)
> @@ -54,11 +62,11 @@
>   * would have to take a slower code path.
>   */
>  #if PAGE_SIZE >=3D SZ_64K
> -#define PP_ALLOC_CACHE_REFILL  4
> +#define PP_ALLOC_CACHE_REFILL  256
>  #elif PAGE_SIZE >=3D SZ_16K
> -#define PP_ALLOC_CACHE_REFILL  16
> +#define PP_ALLOC_CACHE_REFILL  1024
>  #else
> -#define PP_ALLOC_CACHE_REFILL  64
> +#define PP_ALLOC_CACHE_REFILL  4096
>  #endif
>

I'm guessing this is just a workaround/optimization. You need a proper
change for this, maybe make it configurable arguments when creating a
pp or something.

>  #define PP_ALLOC_CACHE_SIZE    (PP_ALLOC_CACHE_REFILL * 2)
> @@ -67,6 +75,8 @@ struct pp_alloc_cache {
>         netmem_ref cache[PP_ALLOC_CACHE_SIZE];
>  };
>
> +struct memory_provider_ops;
> +
>  /**
>   * struct page_pool_params - page pool parameters
>   * @fast:      params accessed frequently on hotpath
> @@ -83,6 +93,9 @@ struct pp_alloc_cache {
>   * @queue_idx: queue idx this page_pool is being created for.
>   * @flags:     PP_FLAG_DMA_MAP, PP_FLAG_DMA_SYNC_DEV, PP_FLAG_SYSTEM_POO=
L,
>   *             PP_FLAG_ALLOW_UNREADABLE_NETMEM.
> + * @mp_ops:    driver-supplied memory provider for a pool not bound to a
> + *             netdev rx queue (NULL to use rxq->mp_params instead)
> + * @mp_priv:   context passed to @mp_ops
>   */
>  struct page_pool_params {
>         struct_group_tagged(page_pool_params_fast, fast,
> @@ -99,6 +112,8 @@ struct page_pool_params {
>                 struct net_device *netdev;
>                 unsigned int queue_idx;
>                 unsigned int    flags;
> +               const struct memory_provider_ops *mp_ops;
> +               void *mp_priv;
>  /* private: used by test code only */
>                 void (*init_callback)(netmem_ref netmem, void *arg);
>                 void *init_arg;
> diff --git a/net/core/devmem.c b/net/core/devmem.c
> index 957d6b96216b..9e21cffc9643 100644
> --- a/net/core/devmem.c
> +++ b/net/core/devmem.c
> @@ -121,12 +121,9 @@ void net_devmem_free_dmabuf(struct net_iov *niov)
>         gen_pool_free(binding->chunk_pool, dma_addr, PAGE_SIZE);
>  }
>
> -void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
> +static void
> +net_devmem_binding_unpublish(struct net_devmem_dmabuf_binding *binding)
>  {
> -       struct netdev_rx_queue *rxq;
> -       unsigned long xa_idx;
> -       unsigned int rxq_idx;
> -
>         xa_erase(&net_devmem_dmabuf_bindings, binding->id);
>
>         /* Ensure no tx net_devmem_lookup_dmabuf() are in flight after th=
e
> @@ -136,6 +133,15 @@ void net_devmem_unbind_dmabuf(struct net_devmem_dmab=
uf_binding *binding)
>
>         if (binding->list.next)
>                 list_del(&binding->list);
> +}
> +
> +void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
> +{
> +       struct netdev_rx_queue *rxq;
> +       unsigned long xa_idx;
> +       unsigned int rxq_idx;
> +
> +       net_devmem_binding_unpublish(binding);
>
>         xa_for_each(&binding->bound_rxqs, xa_idx, rxq) {
>                 const struct pp_memory_provider_params mp_params =3D {
> @@ -151,6 +157,47 @@ void net_devmem_unbind_dmabuf(struct net_devmem_dmab=
uf_binding *binding)
>         percpu_ref_kill(&binding->ref);
>  }
>
> +/* Bind/unbind variants for in-kernel offload importers that drive the r=
x
> + * queue lifecycle themselves. The mp_params are poked directly, without=
 the
> + * tcp-data-split/XDP guards or the queue reconfigure that the netlink c=
ontrol
> + * plane applies through netif_mp_open_rxq()/netif_mp_close_rxq().
> + */
> +int net_devmem_bind_dmabuf_to_queue_direct(struct net_device *dev, u32 r=
xq_idx,
> +                                          struct net_devmem_dmabuf_bindi=
ng *binding)
> +{

The LLM says in this function you need to check if the queue is
already bound to a devmem tcp memory provider.

--=20
Thanks,
Mina
