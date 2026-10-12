Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF52FCC6B13
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 07:54:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50EB710F5B5;
	Tue, 13 Oct 2026 07:53:24 +0000 (UTC)
Received: from mail-pj2-f3.google.com (mail-pj2-f3.google.com [74.125.227.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4F3710E60B
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 16:57:56 +0000 (UTC)
Received: by mail-pj2-f3.google.com with SMTP id
 d9443c01a7336-2e831901331so15071015ad.1
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 09:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791824276; x=1792429076; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lk3jyk+L25op/gK9ZsPi7IfvbejvW+IuaDGcTZaRnIE=;
 b=nSqubiBhsKw9vTHxbM1MBvolvRVQz8Z/I5/F9kC6io42R1tcZ2ne5el7oegpWdSbTy
 in1RwbpOGIyL80NI86FjUgK/apWQcQhsxFvkkHJRMRbU0tsFL7QYeb95Y6MJyGEekYWc
 jHYSwE0mVMKX/+6RwSAJjOeSKDAYAmNDejEZ6Gl0az1NKh/G81wUAEc3hGOLqTRFomxU
 dzoeIurGpCQV/vEStpiH0D+UtIt2zKO1lc3L7YsS3t7b9cOfd8lzNq4orABdh4hRLW4x
 J/z0GbgWOD6M3Wx4o8hVno/dogQnEaTRUQ6fRjxxKBr9fsj8wNiulKJBmtlvCnpgHyRJ
 oIXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791824276; x=1792429076;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lk3jyk+L25op/gK9ZsPi7IfvbejvW+IuaDGcTZaRnIE=;
 b=lsY007XogGwAchNaHzSGK+yXbm7hEX91tGLQworkiG2kb3OeS5E6UWEWFbCeZ0jN0I
 YunARWvFDM0EopJ0MCGti1HHrWAeLwRB+f2XrD+gjfC9eRfTeLFVQsRwMJc51gjaQq5b
 2knIIL4G1xW3WcnyIzjaIZ+23KgBnNOWMX9wYmOk1x6CpVlLl/fPE+XWHZVXeaKOBmSs
 TuBcId/E/DhJN1puO7qLBIgtEAgkU6CxFGsoykvdKHRCFpT9zEsgCA2SI087qUIcoytb
 /J02wNbkID1vjzGdAZ7JRbQ+s6jHA3I4emVImI1pqbwYSidTGZyY73jofS00mIMtoqcl
 TF4g==
X-Forwarded-Encrypted: i=1;
 AKwUvByyLJe76Gp6liuzfHtpdTZyHOgBbU36KiR5GCw+Zq+WatJg1vqu/KDp48njRsI+5Mhm4RuxbR9mBCU=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJvotVPgDc38STcXjSi+lFh//XSd+jVJI52QQbj6fpjxAZGyWiA
 zU9lfpRp46nslCzEdHavlxqaGScHe4rqy/+rnyCxvAh3c0zltNncxiQt
X-Gm-Gg: AYBFou34PomgJUsfmqGosOdDLDjuIvL9jPRZmCh6nntJkYh/n915hV4kpa4PSckhQcU
 bc+QXYSdgGiCJt853V2UvuZZgh0z/LIs8UsjO0CQAjwu27jTdGzkuD7fpJ1cnIrFUtkBAVrJTdW
 W29oeyMwgEd1kTyOPehR/1q2T4VXSJzxsCfnXeUrnWVPlKyfF4J84zn5U3p02tNCAqUNvnN4Yxk
 Og0C5mkrjCY+YN98DT5BLXY5xHxB6u4ToicbUsCTIg1sdi6BVWjEvD9GpuOl2QuriL2JXYrjqmS
 sLVyQE6c/XPx+Vtmda8vgPvLJJ75gVyQHhuvGA2dytzDYOH4o8595ssYhnnOIa+H4HtmKUtGIWa
 sSnPOpr2HwbtZiXezBK6hUkGOfnHEXxIm2CamXY1KHlSMPJH05M5RSBvcxryyhYCmYIOyDgliTW
 0vf8N1Kqy1TkkJJaxXZ+v43SpWiy4Jkc+xDZZDM9VjyH2j3G0CY6RR8z9QA5pDLQ93
X-Received: by 2002:a17:903:1b6d:b0:2db:39da:90f2 with SMTP id
 d9443c01a7336-2e84280aed6mr90426765ad.8.1791824276254; 
 Mon, 12 Oct 2026 09:57:56 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:5e::])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e8422b8dd5sm46996085ad.55.2026.10.12.09.57.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 09:57:55 -0700 (PDT)
Date: Mon, 12 Oct 2026 09:57:50 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, David Wei <dw@davidwei.uk>, 
 Pavel Begunkov <asml.silence@gmail.com>, Taehee Yoo <ap420073@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Paolo Abeni <pabeni@redhat.com>, 
 Kaiyuan Zhang <kaiyuanz@google.com>, Bobby Eshleman <bobbyeshleman@meta.com>,
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
 Daniel Borkmann <daniel@iogearbox.net>,
 Nikolay Aleksandrov <razor@blackwall.org>, 
 Tariq Toukan <tariqt@nvidia.com>, Kaifeng Wang <kaifengw@google.com>
Subject: Re: [PATCH net v1 2/4] net: devmem: detach TX bindings on
 NETDEV_UNREGISTER
Message-ID: <as0LL7IcZas6IPY2@devvm7509.cco0.facebook.com>
References: <20261010025532.839559-1-almasrymina@google.com>
 <20261010025532.839559-3-almasrymina@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261010025532.839559-3-almasrymina@google.com>
X-Mailman-Approved-At: Tue, 13 Oct 2026 07:52:59 +0000
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

On 10/10, Mina Almasry wrote:
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
> Add net_devmem_dev_unregister() called on NETDEV_UNREGISTER:
> - When binding->dev (the physical DMA-capable device) unregisters,
>   erase the binding ID, clear both binding->dev and binding->vdev, wait
>   for in-flight RCU/TX readers via synchronize_net(), and unmap the
>   dma_buf under binding->lock.
> - When only binding->vdev (virtual device) unregisters while
>   binding->dev lives, only clear binding->vdev so no new TX sends match
>   the virtual device while allowing in-flight TX packets on binding->dev
>   to finish DMA safely.
> 
> Fixes: bd61848900bf ("net: devmem: Implement TX path")
> Fixes: 1abe839b34ae ("net: devmem: support TX over NETMEM_TX_NO_DMA devices")
> Cc: Kaiyuan Zhang <kaiyuanz@google.com>
> Cc: Stanislav Fomichev <sdf@fomichev.me>
> Cc: Bobby Eshleman <bobbyeshleman@meta.com>
> Cc: Tariq Toukan <tariqt@nvidia.com>
> Cc: Kaifeng Wang <kaifengw@google.com>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> ---
>  net/core/devmem.c      | 45 ++++++++++++++++++++++++++++++++++++++++++
>  net/core/devmem.h      |  5 +++++
>  net/core/netdev-genl.c |  1 +
>  3 files changed, 51 insertions(+)
> 
> diff --git a/net/core/devmem.c b/net/core/devmem.c
> index 5e4070b82df44..da7b3e8abaa13 100644
> --- a/net/core/devmem.c
> +++ b/net/core/devmem.c
> @@ -169,6 +169,51 @@ void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
>  	percpu_ref_kill(&binding->ref);
>  }
>  
> +void net_devmem_dev_unregister(struct net_device *dev)
> +{
> +	struct net_devmem_dmabuf_binding *binding;
> +	unsigned long xa_idx;
> +

[..]

> +	rcu_read_lock();
> +	xa_for_each(&net_devmem_dmabuf_bindings, xa_idx, binding) {
> +		if (!percpu_ref_tryget(&binding->ref))
> +			continue;
> +		rcu_read_unlock();

You use net_devmem_dmabuf_binding_put below but do not use
net_devmem_dmabuf_binding_get here.

Also, I feel like rcu_read_lock/rcu_read_unlock dance is confusing. bindings
are not following rcu lifetimes. Can we race with __net_devmem_dmabuf_binding_free
here? (xa_for_each returns a valid binding, then before we do try_get it
gets kfree'd)
