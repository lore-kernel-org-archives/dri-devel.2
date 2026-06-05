Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50233CD8C8B
	for <dri-devel@archiver.kernel.org>; Sat,  6 Jun 2026 07:19:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40B8010E281;
	Sat,  6 Jun 2026 07:19:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kE6TX/+e";
	dkim-atps=neutral
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com
 [209.85.210.196])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1782112BE2
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 15:35:34 +0000 (UTC)
Received: by mail-pf1-f196.google.com with SMTP id
 d2e1a72fcca58-8422c327755so1156736b3a.2
 for <dri-devel@lists.freedesktop.org>; Fri, 05 Jun 2026 08:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780673734; x=1781278534; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XoDRJzQHz7VdEkd5BqZ67I7g6IeSlqxM9mM4zX/QtD0=;
 b=kE6TX/+eJemwKAqDC6vxLa0sTMjgRHgIN+3D7PYw704C4RcW8Fcd4IQ4f3Y5v4zQgM
 48fIFBBFr36PhSzXIjsCGW6mSENg5Xd/MigWPwHcza+M1v+3uEVNet3Dd5I2C2Wf12/s
 /pgTFWNvcJ4QHgrk3Ea0zbzlvvZJ5iWNjGGhjaf4n1yEw/iQCFqvA1zwkQ1mdW2/1nFh
 8E7yxaa8A5zbygWHM2o3l9NbVsvYrIao17eHrQwj3AnkaMjEjgh7EWHEg45GLCBOCNdL
 X80qcdfnHAyodLE5WMjRytGBjGo9gpLOWCYb++v8bnn34QJiFqP0ddvgfeDubsx5yab8
 DM3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780673734; x=1781278534;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XoDRJzQHz7VdEkd5BqZ67I7g6IeSlqxM9mM4zX/QtD0=;
 b=VIgkYTRxubU5s/PhMLSwTUn0sq2SMEjP7zG2vybIVCHvPhxws0BTpENgw/jyHiAfv/
 NNtHe2L4GJqryWqRjTlRsv/4o2X84TlWNbY+AW6Cb0gcT8pbCY+qBAVxMFIxwq45B4be
 DfSyljFEwodmBRIZ31rNM7yv1lJF6JWDdxjssnL8XY7955r4NS23wP1VvMJurNWwsHrJ
 6Jw3V40ggorbA9oKH5s0nxnaSBvTCddDFRqcefmBqPuVs5q6c+q2vHTR47rUNT6DHQ2F
 wCA8/8raS8jEHz31eIMJtn2mvfpA2ZX+dKp2MZDX3/aRUR3/n1PxvVIuqkJ3nRz1l4x+
 5zBA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9m7GogEYWY8nPJEC2FyUGwGdDALchFXdd8KrnNs2HSoV6pQr8wBd1n2e7znEUaPZxtUBGjZ3IFEuA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxhLErSv2X6O61OVJOzkPg3S4+WYAew1mKXfMAj7NOMKN5O9NSH
 uax7ZH3oeQ74VhSCDbaj+uueeUv2sV6FT91XWP+KoyaxmlF5pddQZH64
X-Gm-Gg: Acq92OHCCnInHxMkCOa0mRDfSyULNpy5yQR205pXtEMKt8G31u3D2CCCOt7tD42CV16
 ftsxLSyRspxsNGi7OrWixmpr9m6G/7JUKyWGm8QQnaYr8BVaHRB4xCS31sokDqdskaHGGaYt/Kc
 pi23YkQX6qObJcUxOciwHdMUUhdwpiEoChEfi/Y0nx0jr3wlQn17189V2DKCd/pHQKlIJj09thA
 gsRfCkzD8NWc8vCjSSc3U2dXn17lptOn+QVdEJmmUgrtGHgufdqHAYujanxSH9nvxrY6cVZiBeJ
 a3pQ1kjyl3eOVdcUyPXmSLW5Xa/bTHmrY4jSwT9gTufirsKrzX6pOq3GU0W9QnP7SW7w8U9NDM4
 D/IR6DjsK8WQd/npkbSZ6jSHj+5lF3OmGIabW3TKbhMdSUhQU9J/JpiHbQGo4jQUTEtiawuM99z
 OiDvmT2Yeqkj/9/QA05eRvdw49DXQ=
X-Received: by 2002:a05:6a20:9383:b0:3a0:b781:4c80 with SMTP id
 adf61e73a8af0-3b4cccff825mr4945669637.4.1780673734235; 
 Fri, 05 Jun 2026 08:35:34 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:57::])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c85df0a4afdsm10022248a12.19.2026.06.05.08.35.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2026 08:35:33 -0700 (PDT)
Date: Fri, 5 Jun 2026 08:33:04 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Donald Hunter <donald.hunter@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Gerd Hoffmann <kraxel@redhat.com>, 
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, 
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-media@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org, linux-kselftest@vger.kernel.org,
 sdf@fomichev.me, 
 razor@blackwall.org, daniel@iogearbox.net, almasrymina@google.com,
 matttbe@kernel.org, 
 skhawaja@google.com, dw@davidwei.uk, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next 1/4] net: devmem: allow rx-buf-size > PAGE_SIZE
 per dmabuf binding
Message-ID: <aiLrsLM8N0VzrNMe@devvm7509.cco0.facebook.com>
References: <20260603-tcpdm-large-niovs-v1-0-f37a4ac6726c@meta.com>
 <20260603-tcpdm-large-niovs-v1-1-f37a4ac6726c@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260603-tcpdm-large-niovs-v1-1-f37a4ac6726c@meta.com>
X-Mailman-Approved-At: Sat, 06 Jun 2026 07:19:14 +0000
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

On 06/03, Bobby Eshleman wrote:
> From: Bobby Eshleman <bobbyeshleman@meta.com>
> 
> Every devmem dmabuf binding today hands the page_pool PAGE_SIZE niovs.
> This caps a single RX descriptor at PAGE_SIZE, burning CPU on buffer
> churn for large flows.
> 
> Add a bind-time netlink attribute, NETDEV_A_DMABUF_RX_BUF_SIZE, that
> lets userspace request a larger niov size. The value must be a power of
> two >= PAGE_SIZE.
> 
> Measurements
> ------------
> Setup: kperf in devmem RX/TX cuda mode, 4 flows, 64 MB messages, 60s,
> dctcp, num-rx-queues=4, dmabuf-rx/tx-size-mb=2048, 10 runs per niov
> size, mlx5.
> 
> CPU Util:
> 
>    niov        net sirq %        net idle %         app sys %        app idle %
>   -----  ----------------  ----------------  ----------------  ----------------
>      4K   62.38 +/-  8.27   33.40 +/-  7.51   54.15 +/- 10.23   43.67 +/- 10.53
>     16K   58.91 +/-  5.35   35.23 +/-  5.88   41.05 +/-  8.87   56.42 +/-  9.24
>     32K   64.12 +/-  0.68   31.09 +/-  1.48   44.54 +/-  3.51   52.63 +/-  3.65
>     64K   54.69 +/-  5.54   39.67 +/-  5.81   35.47 +/-  3.11   61.97 +/-  3.27
> 
> RX app sys % drops ~19% from 4K to 64K.
> 
> Throughput:
> 
>    niov       RX dev Gbps   RX flow avg Gbps
>   -----  ----------------  -----------------
>      4K  300.63 +/- 53.21    75.16 +/- 13.30
>     16K  321.35 +/- 28.20    80.34 +/-  7.05
>     32K  347.63 +/-  2.20    86.91 +/-  0.55
>     64K  332.11 +/- 14.26    83.03 +/-  3.56
> 
> Throughput seems to increase, but the stdev is pretty wide so could just
> be noise.
> 
> kperf support (not yet merged):
> https://github.com/facebookexperimental/kperf/commit/8837577f920876bce6986ec18869ac04439ebcd2
> 
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> ---
>  Documentation/netlink/specs/netdev.yaml |  8 +++++
>  include/uapi/linux/netdev.h             |  1 +
>  net/core/devmem.c                       | 52 +++++++++++++++++++--------------
>  net/core/devmem.h                       | 13 ++++++---
>  net/core/netdev-genl-gen.c              |  5 ++--
>  net/core/netdev-genl.c                  | 18 ++++++++++--
>  tools/include/uapi/linux/netdev.h       |  1 +
>  7 files changed, 68 insertions(+), 30 deletions(-)
> 
> diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
> index a1f4c5a561e9..063119907983 100644
> --- a/Documentation/netlink/specs/netdev.yaml
> +++ b/Documentation/netlink/specs/netdev.yaml
> @@ -591,6 +591,13 @@ attribute-sets:
>          type: u32
>          checks:
>            min: 1
> +      -
> +        name: rx-buf-size
> +        doc: |
> +          Size in bytes of each RX buffer the NIC writes into from the bound
> +          dmabuf. Must be a power of two and >= PAGE_SIZE; defaults to
> +          PAGE_SIZE.
> +        type: u32
>  
>  operations:
>    list:
> @@ -805,6 +812,7 @@ operations:
>              - ifindex
>              - fd
>              - queues
> +            - rx-buf-size
>          reply:
>            attributes:
>              - id
> diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
> index 7df1056a35fd..180a4ffffd60 100644
> --- a/include/uapi/linux/netdev.h
> +++ b/include/uapi/linux/netdev.h
> @@ -217,6 +217,7 @@ enum {
>  	NETDEV_A_DMABUF_QUEUES,
>  	NETDEV_A_DMABUF_FD,
>  	NETDEV_A_DMABUF_ID,
> +	NETDEV_A_DMABUF_RX_BUF_SIZE,
>  
>  	__NETDEV_A_DMABUF_MAX,
>  	NETDEV_A_DMABUF_MAX = (__NETDEV_A_DMABUF_MAX - 1)
> diff --git a/net/core/devmem.c b/net/core/devmem.c
> index 957d6b96216b..5a1c0d7984a8 100644
> --- a/net/core/devmem.c
> +++ b/net/core/devmem.c
> @@ -46,7 +46,7 @@ static dma_addr_t net_devmem_get_dma_addr(const struct net_iov *niov)
>  
>  	owner = net_devmem_iov_to_chunk_owner(niov);
>  	return owner->base_dma_addr +
> -	       ((dma_addr_t)net_iov_idx(niov) << PAGE_SHIFT);
> +	       ((dma_addr_t)net_iov_idx(niov) << owner->binding->niov_shift);
>  }
>  
>  static void net_devmem_dmabuf_binding_release(struct percpu_ref *ref)
> @@ -93,13 +93,14 @@ net_devmem_alloc_dmabuf(struct net_devmem_dmabuf_binding *binding)
>  	ssize_t offset;
>  	ssize_t index;
>  
> -	dma_addr = gen_pool_alloc_owner(binding->chunk_pool, PAGE_SIZE,
> +	dma_addr = gen_pool_alloc_owner(binding->chunk_pool,
> +					1UL << binding->niov_shift,
>  					(void **)&owner);
>  	if (!dma_addr)
>  		return NULL;
>  
>  	offset = dma_addr - owner->base_dma_addr;
> -	index = offset / PAGE_SIZE;
> +	index = offset >> binding->niov_shift;
>  	niov = &owner->area.niovs[index];
>  
>  	niov->desc.pp_magic = 0;
> @@ -113,12 +114,13 @@ void net_devmem_free_dmabuf(struct net_iov *niov)
>  {
>  	struct net_devmem_dmabuf_binding *binding = net_devmem_iov_binding(niov);
>  	unsigned long dma_addr = net_devmem_get_dma_addr(niov);
> +	size_t niov_size = 1UL << binding->niov_shift;
>  
>  	if (WARN_ON(!gen_pool_has_addr(binding->chunk_pool, dma_addr,
> -				       PAGE_SIZE)))
> +				       niov_size)))
>  		return;
>  
> -	gen_pool_free(binding->chunk_pool, dma_addr, PAGE_SIZE);
> +	gen_pool_free(binding->chunk_pool, dma_addr, niov_size);
>  }
>  
>  void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
> @@ -163,6 +165,9 @@ int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
>  	u32 xa_idx;
>  	int err;
>  
> +	if (binding->niov_shift != PAGE_SHIFT)
> +		mp_params.rx_page_size = 1U << binding->niov_shift;
> +
>  	err = netif_mp_open_rxq(dev, rxq_idx, &mp_params, extack);
>  	if (err)
>  		return err;
> @@ -184,14 +189,16 @@ struct net_devmem_dmabuf_binding *
>  net_devmem_bind_dmabuf(struct net_device *dev, void *vdev,
>  		       struct device *dma_dev,
>  		       enum dma_data_direction direction,
> -		       unsigned int dmabuf_fd, struct netdev_nl_sock *priv,
> +		       unsigned int dmabuf_fd, unsigned int niov_shift,
> +		       struct netdev_nl_sock *priv,
>  		       struct netlink_ext_ack *extack)
>  {
>  	struct net_devmem_dmabuf_binding *binding;
> +	size_t niov_size = 1UL << niov_shift;
>  	static u32 id_alloc_next;
> +	unsigned int sg_idx, i;
>  	struct scatterlist *sg;
>  	struct dma_buf *dmabuf;
> -	unsigned int sg_idx, i;
>  	unsigned long virtual;
>  	int err;
>  
> @@ -213,6 +220,7 @@ net_devmem_bind_dmabuf(struct net_device *dev, void *vdev,
>  
>  	binding->dev = dev;
>  	binding->vdev = vdev;
> +	binding->niov_shift = niov_shift;
>  	xa_init_flags(&binding->bound_rxqs, XA_FLAGS_ALLOC);
>  
>  	err = percpu_ref_init(&binding->ref,
> @@ -248,18 +256,14 @@ net_devmem_bind_dmabuf(struct net_device *dev, void *vdev,
>  			goto err_unmap;
>  		}
>  		binding->tx_vec = kvmalloc_objs(struct net_iov *,
> -						dmabuf->size / PAGE_SIZE);
> +						dmabuf->size >> niov_shift);
>  		if (!binding->tx_vec) {
>  			err = -ENOMEM;
>  			goto err_unmap;
>  		}
>  	}
>  
> -	/* For simplicity we expect to make PAGE_SIZE allocations, but the
> -	 * binding can be much more flexible than that. We may be able to
> -	 * allocate MTU sized chunks here. Leave that for future work...
> -	 */
> -	binding->chunk_pool = gen_pool_create(PAGE_SHIFT,
> +	binding->chunk_pool = gen_pool_create(niov_shift,
>  					      dev_to_node(&dev->dev));
>  	if (!binding->chunk_pool) {
>  		err = -ENOMEM;
> @@ -273,9 +277,11 @@ net_devmem_bind_dmabuf(struct net_device *dev, void *vdev,
>  		size_t len = sg_dma_len(sg);
>  		struct net_iov *niov;
>  
> -		if (!IS_ALIGNED(len, PAGE_SIZE)) {
> +		if (!IS_ALIGNED(dma_addr, niov_size) ||
> +		    !IS_ALIGNED(len, niov_size)) {
>  			err = -EINVAL;
> -			NL_SET_ERR_MSG(extack, "dma-buf SG length must be PAGE_SIZE aligned");
> +			NL_SET_ERR_MSG(extack,
> +				       "dmabuf sg entry not aligned to niov size");

nit: should we NL_SET_ERR_MSG_FMT here and export chunk len and expected
alignment?

>  			goto err_free_chunks;
>  		}
>  
> @@ -288,7 +294,7 @@ net_devmem_bind_dmabuf(struct net_device *dev, void *vdev,
>  
>  		owner->area.base_virtual = virtual;
>  		owner->base_dma_addr = dma_addr;
> -		owner->area.num_niovs = len / PAGE_SIZE;
> +		owner->area.num_niovs = len >> niov_shift;
>  		owner->binding = binding;
>  
>  		err = gen_pool_add_owner(binding->chunk_pool, dma_addr,
> @@ -313,7 +319,7 @@ net_devmem_bind_dmabuf(struct net_device *dev, void *vdev,
>  			page_pool_set_dma_addr_netmem(net_iov_to_netmem(niov),
>  						      net_devmem_get_dma_addr(niov));
>  			if (direction == DMA_TO_DEVICE)
> -				binding->tx_vec[owner->area.base_virtual / PAGE_SIZE + i] = niov;
> +				binding->tx_vec[(owner->area.base_virtual >> niov_shift) + i] = niov;
>  		}
>  
>  		virtual += len;
> @@ -430,13 +436,15 @@ struct net_iov *
>  net_devmem_get_niov_at(struct net_devmem_dmabuf_binding *binding,
>  		       size_t virt_addr, size_t *off, size_t *size)
>  {
> +	size_t niov_size = 1UL << binding->niov_shift;
> +
>  	if (virt_addr >= binding->dmabuf->size)
>  		return NULL;
>  
> -	*off = virt_addr % PAGE_SIZE;
> -	*size = PAGE_SIZE - *off;
> +	*off = virt_addr & (niov_size - 1);
> +	*size = niov_size - *off;
>  
> -	return binding->tx_vec[virt_addr / PAGE_SIZE];
> +	return binding->tx_vec[virt_addr >> binding->niov_shift];
>  }
>  
>  /*** "Dmabuf devmem memory provider" ***/
> @@ -454,8 +462,8 @@ int mp_dmabuf_devmem_init(struct page_pool *pool)
>  	pool->dma_sync = false;
>  	pool->dma_sync_for_cpu = false;
>  
> -	if (pool->p.order != 0)
> -		return -E2BIG;
> +	if (pool->p.order != binding->niov_shift - PAGE_SHIFT)
> +		return -EINVAL;

Any specific reason you change E2BIG to EINVAL?
