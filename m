Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B26C606A32F
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 23:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=avxvdOrw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6C2910EADA;
	Sun,  1 Nov 2026 23:01:34 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C8F210EADD
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 23:01:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1F2426061C;
 Sun,  1 Nov 2026 23:01:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D3071F000C1;
 Sun,  1 Nov 2026 23:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793574087;
 bh=t2MxZtB2T9Bz2tg5DIt4j1dXYuKYbfcmPZ03Fr/VSko=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=avxvdOrwTRHGrZq0iN80QYgJ56/4BguQdjjbV8AQlXIj9kslbw7j1K/EgI2SnSy1Z
 OrLwaVBYKoOBqB6oYBUuiNTW1ysAC2jWgZVIteuXetmmSGnp+DwaN4zOYE4CwhcMSn
 Ipu9cicjz3lSLSmITRtZ1ojXclq2ZEI3gyrGbc26x8yBkjQqz370PStx0m2Ys1Gf+F
 Nw/MrUWeasTOBcDeQFr0dXUqOLiaXicOSR6LF475ZOy395qWm2wtP6FvRj/qXbz7iR
 RaT9FHpjc8bVHIvt2oP3XnoLozkgZOL2f5DWUv3vPlihT1ackXnhwXsVP2pe6JmxJf
 /46WCm8kf8HPg==
Subject: Re: [PATCH net v5 3/4] netdevsim: support devmem RX and TX bindings
From: netdev-bot+sashiko@kernel.org
To: almasrymina@google.com
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, pabeni@redhat.com, sdf@fomichev.me,
 kaiyuanz@google.com, kuba@kernel.org, bobbyeshleman@meta.com,
 asml.silence@gmail.com, dw@davidwei.uk, ap420073@gmail.com,
 davem@davemloft.net, edumazet@kernel.org, horms@kernel.org, shuah@kernel.org, 
 sumit.semwal@linaro.org, christian.koenig@amd.com, phasta@kernel.org,
 andrew+netdev@lunn.ch, sdf.kernel@gmail.com, hawk@kernel.org,
 ilias.apalodimas@linaro.org, daniel@iogearbox.net, razor@blackwall.org,
 tariqt@nvidia.com, kaifengw@google.com, dtatulea@nvidia.com
Date: Sun, 01 Nov 2026 23:01:25 +0000
Message-ID: <179357408589.3131.13149073708335764140@kernel.org>
In-Reply-To: <20261030083539.777877-4-almasrymina@google.com>
References: <20261030083539.777877-4-almasrymina@google.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] Not a bug (baseline: false positive).

--

netdevsim: support devmem RX and TX bindings

This patch sets a 64-bit DMA mask on the netdevsim bus device and turns on
NETMEM_TX_DMA on the netdevsim net_device. It also sets up the page pools
so they can be backed by unreadable netmem, which lets the devmem bind-rx
and bind-tx netlink operations be tested against netdevsim. pp_hold is
refused on memory-provider backed pools, and unreadable or net_iov skbs
are dropped in nsim_start_xmit().

> diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
> index eebc02ccc4a92..0372a9bd63bbb 100644
> --- a/drivers/net/netdevsim/netdev.c
> +++ b/drivers/net/netdevsim/netdev.c
> @@ -133,6 +133,10 @@ static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
>  	int dr;
>  
>  	rcu_read_lock();
> +	if (!skb_frags_readable(skb) ||
> +	    (skb_shinfo(skb)->nr_frags &&
> +	     skb_frag_is_net_iov(&skb_shinfo(skb)->frags[0])))
> +		goto out_drop_any;
>  	if (!nsim_ipsec_tx(ns, skb))
>  		goto out_drop_any;
>  

[ ... ]

> @@ -1059,6 +1078,8 @@ static int nsim_init_netdevsim(struct netdevsim *ns)
>  	ns->netdev->netdev_ops = &nsim_netdev_ops;
>  	ns->netdev->stat_ops = &nsim_stat_ops;
>  	ns->netdev->queue_mgmt_ops = &nsim_queue_mgmt_ops;
> +	if (ns->nsim_bus_dev->dev.dma_mask)
> +		ns->netdev->netmem_tx = NETMEM_TX_DMA;

[Severity: Low]
This isn't a bug, but the docs and the driver don't quite match here.
Documentation/networking/netmem.rst describes the mode as:

    NETMEM_TX_DMA: for physical devices that perform DMA.

nsim_init_netdevsim() sets NETMEM_TX_DMA, but nsim_start_xmit() above
drops every unreadable or net_iov skb.

As I understand it, NETMEM_TX_NO_DMA would not work for this test. That
is because netdev_find_netmem_tx_dev() only resolves a NO_DMA device by
following leased RX queues to a physical NETMEM_TX_DMA device:

net/core/netdev-genl.c:netdev_find_netmem_tx_dev() {
    ...
	if (dev->netmem_tx == NETMEM_TX_DMA)
		return dev;

	if (dev->netmem_tx != NETMEM_TX_NO_DMA)
		return NULL;
    ...
}

Traffic also behaves the same as before. Under NETMEM_TX_NONE,
validate_xmit_unreadable_skb() already freed these skbs. Now the driver
drops them and counts them through dev_dstats_tx_dropped().

Would it help to add a short comment next to this assignment? It could
say that netdevsim advertises NETMEM_TX_DMA only so the bind-tx control
path works, and that devmem TX data is dropped in nsim_start_xmit().

>  	netdev_lockdep_set_classes(ns->netdev);
>  
>  	err = nsim_udp_tunnels_info_create(ns->nsim_dev, ns->netdev);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261030083539.777877-1-almasrymina%40google.com
