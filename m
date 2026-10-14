Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C011CC6B2F
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 07:57:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86424112178;
	Thu, 15 Oct 2026 07:57:18 +0000 (UTC)
Received: from mail-pz2-f6.google.com (mail-pz2-f6.google.com [74.125.228.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D05210FE71
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 16:33:59 +0000 (UTC)
Received: by mail-pz2-f6.google.com with SMTP id
 41be03b00d2f7-cc790c60953so252205a12.1
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 09:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791995639; x=1792600439; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Gzw9aMKz/xODwzz6jPerfVV+ZDaTeiwtt+GIjli64uI=;
 b=fUwDtlfh5wEup5st69Y0l+LI4vrZZ3SDt8TGGZTFdRkSdygCbmgwqBNzJp6WRbcrIj
 nKmoBFG3m3nuOefJSuwJGcQE8ye7eQlMVsg/xjRQerlQ6PmHeGXaIr733PNBtWug1Qaf
 LhbWrEVqlYbtBga6xX1nCYMKGcLHXmQ5KpeUjD/Jk9woftnqhrh39eoagjCQo7Ektmfr
 rJHhaIHfJTlJPu0uuzRdnvchzzF1iDDd6DJUkEY1FUbMv7w8xC2T5WZqudgKDzfMAe2v
 jBoBKZCjopNvji18XxKJ/C72AgZ0I5u70aCIhiLtf17/Uw9r1JvzyDGIZ7jfBuopnVgT
 gcPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791995639; x=1792600439;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Gzw9aMKz/xODwzz6jPerfVV+ZDaTeiwtt+GIjli64uI=;
 b=BG66uYOYuLFW8nS3Z1h7REGcPYNMEbJCBhJ7muD99ADuC1Y4kCvnU/exRn6gAI/JsQ
 qVS4v9xqPOGOdEupobItBZ0pxXSeAMmEW/Z5BHKTJiqDeR4twIWgblv+EXjd0sEVqw8W
 u3x9xslIJOwqLOwLOnwiedB8UNtCRKVsGU0HW8HtwciU7Jo0b4KyM0m5tS6jwUIpjO8i
 8Vl3gLGTChP1UGMlKmqXwovd6P1ZU5qzN5lIYOch2ytbFjc4R40InL1m0YZ4+/JEMs7h
 sFnZ771cqjEUBDIUAZGjcd+jRdGH+ZfVdrLYPHwAiF+BBIJJvqoKgZ+KcJgaGUvqZjfo
 3bAg==
X-Forwarded-Encrypted: i=1;
 AKwUvBz5IGaZEQVgEberiUuuLHtXoagVabFbcDFonTlqgnWtgMSZqFusV41P7uFZovgoVrrF3UVpYznTACg=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYICT2vPZOmo0JW72pFAHyAAIWUgDm5p6bfBr2Z1F2nJLHfP/d+6
 yYhVSap4dHNxEY1S93ImmdJZdJ7ULLvGa9/tybqAIwR44EYCYeJFiGH6
X-Gm-Gg: AYBFou2LySTobm2426uNWnFINWyllDXU2SotA6ZF7ELH4rFVmBidjhgkgR1Fg+ZH5qx
 n/K+Nekxvsq8KM/E23nGlmMmNQBxDiqPQmBQWxQygc8xtbvodVrSQGsRMdCM30UZKVhhOCjS13n
 139ogd9WXFT7+TTXxTiIVJCeBK8P45MQuRz4kgIqB5aSCOtdGKYU9/r0eAi7X4SYa8h5g/sDSxK
 9JUAHfLpggadYHXJkoSSyxBRQwNHNcFj22M1fmkMvtTNLiOfqSrqDXVZxsqX/th5cNwmU/NzZYx
 GHmMo8/pnqqTw9H5LrjpRkk1TU3ic84LUzJ9j8+2WbwthHunZyVb2K3A4yMukxr3bEXpy94jDga
 IPYrpZRjHSMVfEl5ldx9kUI0PB+RJZGQNwz5HqDZwm1NhLj24zF7oa+1cZs5sCAQQX1xaeoCKHX
 f8osIow64W6D2CaR/UCd32d7HJtKPrMUBxzY66R2qU/k/qPqdl5vcyEendsLZY3vLe
X-Received: by 2002:a05:6a00:8c4:b0:891:a63c:df97 with SMTP id
 d2e1a72fcca58-897c6443681mr15560946b3a.15.1791995639007; 
 Wed, 14 Oct 2026 09:33:59 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:59::])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-89d80511d47sm1291926b3a.54.2026.10.14.09.33.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 09:33:58 -0700 (PDT)
Date: Wed, 14 Oct 2026 09:33:38 -0700
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
 Nikolay Aleksandrov <razor@blackwall.org>,
 Daniel Borkmann <daniel@iogearbox.net>, 
 Tariq Toukan <tariqt@nvidia.com>, Kaifeng Wang <kaifengw@google.com>
Subject: Re: [PATCH net v2 1/4] net: devmem: unmap dma_buf synchronously on
 queue uninstall
Message-ID: <as-uBvRisS7HxLHJ@devvm7509.cco0.facebook.com>
References: <20261012174300.2338784-1-almasrymina@google.com>
 <20261012174300.2338784-2-almasrymina@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261012174300.2338784-2-almasrymina@google.com>
X-Mailman-Approved-At: Thu, 15 Oct 2026 07:56:36 +0000
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

On 10/12, Mina Almasry wrote:
> When a bound net_device is unregistered while userspace still holds a
> netlink or TCP socket reference on a devmem binding,
> mp_dmabuf_devmem_uninstall() clears binding->dev to NULL so
> netdev_nl_sock_priv_destroy() will not touch the unregistered
> net_device, but leaves the dma_buf attachment mapped until
> __net_devmem_dmabuf_binding_free() runs later on socket close.
> 
> Because dma_buf_attach() does not take a reference on dma_dev, device
> removal frees dma_dev while the attachment is still mapped. Closing the
> netlink socket afterwards triggers a slab use-after-free in
> dma_unmap_sg_attrs():
> 
>   BUG: KASAN: slab-use-after-free in dma_unmap_sg_attrs+0x76/0x2b0
>   Read of size 8 at addr ffff88810fae64b0 by task kworker/3:1/53
>   Workqueue: events __net_devmem_dmabuf_binding_free
>   Call Trace:
>    dma_unmap_sg_attrs+0x76/0x2b0
>    unmap_udmabuf+0x8e/0x100
>    dma_buf_unmap_attachment+0x145/0x330
>    dma_buf_unmap_attachment_unlocked+0x96/0x130
>    __net_devmem_dmabuf_binding_free+0x156/0x2e0
>   Freed by task 9:
>    kfree+0x1b8/0x550
>    nsim_bus_dev_release+0xe/0x60
>    device_release+0xcf/0x250
> 
> Add net_devmem_dmabuf_binding_unmap() serialized under binding->lock
> and null out binding->sgt and binding->attachment after unmapping so
> unmapping is idempotent across queue uninstall and deferred binding
> destruction. Call it synchronously when the last bound RX queue is
> uninstalled in mp_dmabuf_devmem_uninstall(), except when a leased
> queue is unleased: the physical device is still registered and, if
> restarting its queue failed, may still be using the binding.
> 
> The same use-after-free happens when the netlink socket is closed
> before the device is removed but RX tokens or the pending release work
> keep the binding alive. Such bindings are no longer installed on any
> queue and were already erased from net_devmem_dmabuf_bindings. Keep
> bindings in net_devmem_dmabuf_bindings until they are freed, hide
> unbound ones from TX lookups with an xarray mark, and on
> NETDEV_UNREGISTER clear binding->dev of unbound RX bindings for the
> device and unmap them, unless the device is a virtual device leasing

[..]

> queues, for the same reason as above. net_devmem_lock serializes that
> walk with the final free.

Can you explain net_devmem_lock a bit more? In
net_devmem_dev_unregister, why can you not net_devmem_lookup_dmabuf and
then rely on the binding->lock? The rest looks good, but the
new lock seems a bit excessive?
