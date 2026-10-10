Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3D18CA6017
	for <dri-devel@archiver.kernel.org>; Sat, 10 Oct 2026 14:02:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEAA610E062;
	Sat, 10 Oct 2026 14:02:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MH8mXCGt";
	dkim-atps=neutral
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35F2610E062
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 14:02:32 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-48af27fe287so533135f8f.0
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 07:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791640950; x=1792245750; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=7F23FNsErj3fpOWKD/UF72cX4yQCCC/yv71F53gfj74=;
 b=MH8mXCGtGxluFS5ZrcD2cPJgdJ9uZ2rjipaFLGGg0e5Ntf7tSAOxLIM3zr8pO9+ghu
 sh97r+3KmJi0eSLbKVChw+T0EFYZUJLNx5Ke4uGqTxusR9GNhfxK73KkFO+/VdyONcyv
 Fas0jCy2fAhV/YqIOOGqd/2oVK0pzbmTdfQ6YDhgW60d+WHiG4JujuPHub3jrcQKVfgg
 mZDumd2rbhi2HH3zuQgzSTyh8CxupkW1KAR7Aqwm4NHg+cjYwRRXfxfbYXn+L77AcqOC
 OGRc5o00vnU4LkbutZ7EYswZPCtfOBU3P5VvIAjPjP4Fx5MWenwL8a1jbWQm4wygInR1
 J3uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791640950; x=1792245750;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7F23FNsErj3fpOWKD/UF72cX4yQCCC/yv71F53gfj74=;
 b=o/CYIdlgsOKwj1vQfkd/q7mNc2WRD0ktIt9q7lbaq0L5vg0qUP+l2vmy1v8s9/Y1zS
 1Ei/DKq8HX6Ug62oiB8xHU5NaluAXHcTyq0C5fEfNOjFy6rYYgMYHBnF+QAeKNNlaOgC
 Rf7fotGq/pqZ12dN2XnRi+QuTeVYhjhNx6i2kYEk0QvlFgQ6eDCXFxOhA2YQu9k82JPa
 OgdrMgxMmh6qZwCS+Hz7iPAatFAlaBD9VteanWyTTN79Wsre1kNOW8lfgr+UAoIVrpu1
 XOy/Q+k20+NkKBYv6V9NtavAWdZM2gMJgYy80BcNQMxOQeswKihi/DrY/bzHqM1f1PSU
 WlAQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxmAfFxTvphZmqIgO9fN3ftgCBSuoINs+JAUw7raWaA6i2i7S0pl04JQMBYnkH4CrnTnnRnkuE7C6U=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIiApCxHIfHtpE/tddtrWrRDMYfGj45Vab/V3giGM+D0HN0AuBA
 K6OW4Rv0G9DNzSLn/pYIYDgpPqlY9Ayg9ZjspsfJAPzNwkadb39D4F5o
X-Gm-Gg: AYBFou03QBiLCtxknGzGQjfEQgxEGcrlUX/7S1C0ri/QKDK/Se6jfcEWrEjsDquxtTZ
 y3YmdFbceMt8UaWSTQ3rX8FJtEMB71VHFTy8+bFz+ZDaweZCzAR6GQ9PH7IZyMVrg0/daOk4jZq
 jHlQCagGHNV+EMIPFsosOz6PwZ80hWjt/VxjzNCQXDD0hkKUv/vgf1pBjB5neJYVJeijufT/KWE
 SpnmfVC1f651bnf2BMhNYqNwMs07XWGI0alVPpd2ePeAoWZhCzgP8j52SzB4TDgR60lueaQ0pLr
 bj7j3cPEeOlnVk8dnU++vJ8ZGhGU5z9DyXgWGVZGcnB2uwTk6B5fh53ogvEUPvGfVuKIC2wKFQQ
 2KR1E9R+v6qkh7O2WbtqSimwQv1vf77+s/WzgnB91PckmXAhu1WKsvjciTs8jgqT3sv0ZOxX6a7
 px/Y/EdSuTgwRnofk9cu0TL6lcqW9vDJMBKlLsSt89MSYKFtGOm+WpHdJ/MhGsYk8GvWp4g41yW
 2e0u6RGGzCfFzpwj00qQBL1Gc8fJAhnKWeCPu56IPfcqW3tuc91ZyGivmCGbuLH46mNK4/x/WE0
 Y+BSAA55q1TQkMBV8SeqJCljQpIuWv7LirZyaOe+ZOq7jESy
X-Received: by 2002:a5d:6992:0:b0:48c:49bd:62df with SMTP id
 ffacd0b85a97d-48dba77d1ddmr7509477f8f.1.1791640950478; 
 Sat, 10 Oct 2026 07:02:30 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c?
 ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db9463499sm8727077f8f.3.2026.10.10.07.02.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 Oct 2026 07:02:29 -0700 (PDT)
Message-ID: <12d8d2fc-6b3a-432f-b27d-e27bea01d697@gmail.com>
Date: Sat, 10 Oct 2026 15:02:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1 1/4] net: devmem: unmap dma_buf synchronously on
 queue uninstall
To: Mina Almasry <almasrymina@google.com>, Jakub Kicinski <kuba@kernel.org>,
 David Wei <dw@davidwei.uk>, Taehee Yoo <ap420073@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Paolo Abeni <pabeni@redhat.com>,
 Kaiyuan Zhang <kaiyuanz@google.com>, Bobby Eshleman
 <bobbyeshleman@meta.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Nikolay Aleksandrov <razor@blackwall.org>, Tariq Toukan <tariqt@nvidia.com>,
 Kaifeng Wang <kaifengw@google.com>
References: <20261010025532.839559-1-almasrymina@google.com>
 <20261010025532.839559-2-almasrymina@google.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20261010025532.839559-2-almasrymina@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 10/10/26 03:55, Mina Almasry wrote:
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
>    BUG: KASAN: slab-use-after-free in dma_unmap_sg_attrs+0x76/0x2b0
>    Read of size 8 at addr ffff88810fae64b0 by task kworker/3:1/53
>    Workqueue: events __net_devmem_dmabuf_binding_free
>    Call Trace:
>     dma_unmap_sg_attrs+0x76/0x2b0
>     unmap_udmabuf+0x8e/0x100
>     dma_buf_unmap_attachment+0x145/0x330
>     dma_buf_unmap_attachment_unlocked+0x96/0x130
>     __net_devmem_dmabuf_binding_free+0x156/0x2e0
>    Freed by task 9:
>     kfree+0x1b8/0x550
>     nsim_bus_dev_release+0xe/0x60
>     device_release+0xcf/0x250
> 
> Add net_devmem_dmabuf_binding_unmap() serialized under binding->lock
> and null out binding->sgt and binding->attachment after unmapping so
> unmapping is idempotent across queue uninstall and deferred binding
> destruction. Call it synchronously when the last bound RX queue is
> uninstalled in mp_dmabuf_devmem_uninstall().
> 
> Fixes: f8350a4358fc ("net: page_pool: add a mp hook to unregister_netdevice*")

It looks more like 170aafe35cb98e0f3fbacb446ea86389fbce22ea
("netdev: support binding dma-buf to netdevice"). The one in the
tag didn't do anything interesting.

The fix looks good as well, might be a good idea to clear
net_iov's dma_addr as well.

Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>

-- 
Pavel Begunkov

