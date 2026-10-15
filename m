Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 354CDCCA48B
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 07:35:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BEEA112654;
	Fri, 16 Oct 2026 07:35:42 +0000 (UTC)
Received: from mail-pz2-f6.google.com (mail-pz2-f6.google.com [74.125.228.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A44031124AC
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 21:34:57 +0000 (UTC)
Received: by mail-pz2-f6.google.com with SMTP id
 41be03b00d2f7-cc75f2924abso4014151a12.1
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 14:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792100097; x=1792704897; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KDrSDxpyrWFU5Ei8Mpj2JURPZsUs0EKdCv3HOvYAEoE=;
 b=Sr4XP8aQvWfpIhHCe3Hdsqzaq/ixn+x7jZac93qkLcPTw+mWDWFJtx9vY1medApg7U
 azEKcp5Mhkim7tgQBA0AWYOzSSOqT/9UDwhUQbEba1abchSoL+bYtevrLlCVZtbntmbo
 uwQEO2SsZiRUcZ7RGMsi4XyE+9jkvBuuw7JwFT4mPgiPpjX5d5FXjATPUHkISUyEQAWK
 d+1ME4znmWdpiCzD19TJmBv1qmZy8/dP0alZW4JdQD67JBoIjtd1a14GpLXyfSsrUsAp
 3/QNF1BdNaIn6lFrUAA/yYx9E4DPnPD0n/k6e8avWpkqBTUWnYE3aWLXndjrRf39l0+0
 WjiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792100097; x=1792704897;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KDrSDxpyrWFU5Ei8Mpj2JURPZsUs0EKdCv3HOvYAEoE=;
 b=hscn74F7xOcCmY36muuWu8cXt+CxqrfqqFF0Sn5S2IHs+GnbDO5E/9+Y+cxsU1k2z4
 rySjjzpMVd47njPZUrDhCP8t3dBpRV2+0gvRCPw4jCjyLkVQMDBFdJhogLQ/xWcugLCo
 p+z2jgZwDGeeKhnyUPhcjSV3x9BUZhxHu6D1bC1IVONLcnGfC4zZIaj0DQ1gPNccCJQG
 13UQJDfpafjP/gksn2eLZi77vdAFY2w7BSp1XHckLbHHmIVh3P5oatjv+UGtDwQ7vQvF
 Z/fE6Y+KrvdPBzdmNeezr7ZRSFqGyHWWqqhsL4xEfHV9QlKQ75SA1Hq+LCK1pFot7PAs
 sg2g==
X-Forwarded-Encrypted: i=1;
 AKwUvByfEG377CX0qpto2KNUIBpN1LHVVq4XXQSlqWyiX1WHQ4JLJh0uur+/TqmfRmvwQfr4a/mvvlAmF18=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYISX5o/WB7BGgJSQgICpQQkCehlepe3nJ35+TbmVASE+ida6lpU
 p9J952p4T267JwivgjXGCYS7utq/gx3dV8jS4fo4WW/U4AEbi7uZl1WK
X-Gm-Gg: AYBFou1oZpk2Elik9oa7PCeOba5l2IIbfk61eS1CQ8yh9vX9g8zxwq1+98lN9WocPso
 q9nav+0QWLHSh0zJqDrtpY3Hdm3031bi7nziERh1abuZP/QBNEzVJMZyevGAafqIHgZYyYuNtXy
 W3TT1z0Enu5JYl0XGgMFD68qFG166v/jDjf7EtQzXGu6X/MsSn+W0TPcdb13+81k7KXiCq3KzKP
 FzPtEH9slGc6qBxXcCfYK/cAuqNBS0GYeOZGzm05PUIc+erBLV2po1oHL9Spmwy6d6jvmuTKOMB
 6jWbI/WQHQml04tRZTRqD14sT2Z2wQEXlFuAd03RV+PE6ynsSXoyjdk4TtdmWnfxZveguZ9PxtO
 ylUnxBUCDz7YLghy1hHbeTrk95S69JVzy4H27cHJpdRwZmeV84/hS4BwN8LfZMGId/tmmaK4kMn
 AZnLrwiOO+qDsbb+lxYq+I1s2IH2P1r9yqUJLB+tSPzdecRvQtwMQOOFZKM2WJKtJPrYITzM1tT
 rU=
X-Received: by 2002:a05:6a00:4fd0:b0:891:1caa:3f72 with SMTP id
 d2e1a72fcca58-897c81b54bfmr17760273b3a.57.1792100097031; 
 Thu, 15 Oct 2026 14:34:57 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:45::])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-89f579479f8sm157301b3a.38.2026.10.15.14.34.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 14:34:56 -0700 (PDT)
Date: Thu, 15 Oct 2026 14:34:27 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, 
 Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>,
 Stanislav Fomichev <sdf@fomichev.me>, 
 Taehee Yoo <ap420073@gmail.com>, Paolo Abeni <pabeni@redhat.com>, 
 Kaiyuan Zhang <kaiyuanz@google.com>, Bobby Eshleman <bobbyeshleman@meta.com>,
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
 Dragos Tatulea <dtatulea@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Tariq Toukan <tariqt@nvidia.com>, 
 Kaifeng Wang <kaifengw@google.com>
Subject: Re: [PATCH net v4 2/4] net: devmem: detach TX bindings on
 NETDEV_UNREGISTER
Message-ID: <atFG1wz_26sNn18O@devvm7509.cco0.facebook.com>
References: <20261015163915.1166043-1-almasrymina@google.com>
 <20261015163915.1166043-3-almasrymina@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261015163915.1166043-3-almasrymina@google.com>
X-Mailman-Approved-At: Fri, 16 Oct 2026 07:35:41 +0000
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

On 10/15, Mina Almasry wrote:
> TX devmem bindings (NETDEV_CMD_BIND_TX) have no bound RX queues, so
> mp_dmabuf_devmem_uninstall() never runs when binding->dev or
> binding->vdev unregisters. As a result, binding->dev and binding->vdev
> dangle pointing to freed struct net_device memory, and the dma_buf
> remains attached and mapped after device removal.
> 
> Closing the netlink socket after netdev unregistration dereferences the
> freed struct net_device in netdev_nl_sock_priv_destroy():
> 
>   BUG: unable to handle page fault for address: ffff88824ca9b000
>   Oops: Oops: 0000 [#1] SMP KASAN NOPTI
>   RIP: 0010:netdev_nl_sock_priv_destroy+0xbd/0x1e0
>   Call Trace:
>    genl_release+0xf5/0x190
>    netlink_release+0xd01/0x18d0
>    __sock_release+0xb0/0x270
>    sock_close+0x18/0x20
> 
> Extend net_devmem_dev_unregister() to TX bindings, including ones
> whose netlink socket is already closed but which TCP retransmits keep
> alive:
> - When binding->dev (the physical DMA-capable device) unregisters,
>   clear the binding's NET_DEVMEM_BINDING_LIVE mark and both
>   binding->dev and binding->vdev, and unmap the dma_buf under
>   binding->lock. No grace period is needed: the device is already
>   closed, so nothing hands the DMA addresses to the hardware anymore,
>   and concurrent senders only compare against binding->dev.
> - When only binding->vdev (virtual device) unregisters while
>   binding->dev lives, only clear binding->vdev so no new TX sends match
>   the virtual device while allowing in-flight TX packets on binding->dev
>   to finish DMA safely.
> 
> Fixes: bd61848900bf ("net: devmem: Implement TX path")
> Fixes: 1abe839b34ae ("net: devmem: support TX over NETMEM_TX_NO_DMA devices")
> Suggested-by: Stanislav Fomichev <sdf@fomichev.me>
> Cc: Kaiyuan Zhang <kaiyuanz@google.com>
> Cc: Bobby Eshleman <bobbyeshleman@meta.com>
> Cc: Tariq Toukan <tariqt@nvidia.com>
> Cc: Kaifeng Wang <kaifengw@google.com>
> Assisted-by: LLM
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> ---
> v4:
> - Detach and unmap TX bindings directly from the xarray walk, without a
>   grace period or a second pass (Stanislav).

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
