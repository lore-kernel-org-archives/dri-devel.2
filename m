Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C7F606D806
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 08:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Go5owOop
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91DAC10F41A;
	Tue,  3 Nov 2026 08:10:14 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2E7510F41A
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 08:10:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E972360609;
 Tue,  3 Nov 2026 08:10:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C4981F00919;
 Tue,  3 Nov 2026 08:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793693407;
 bh=W+rCt5JffqT9igP/FHJlTjxb2JKgyvGadn6kqlftxyg=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=Go5owOop+lJsQUqur9qbyUb79jlZHreekfAOVjWqHl5+PJSLH1/IDqLr2vU1qMsTq
 e/gTUjOte224eNmE672iD7k8DECG4jgF0Gk8pekN/K6BMi2JfOCScPPbnYYeFfwEWu
 DfSJI/MOhZ6qWKJK6tbrwvjar3Pwvh2VZp8aU4l6AOInYQKoI4MZu4rJSdQwdO0T6F
 zJ4M7T3o9JXVLoCZooDnbpyFrq2efF0JUPzHn/Jm+7Kt6bCgkU7JtLbiDZnQEVhQ43
 KsooIqJXse7U6T9Pzv7KTXa2nkNdsJF3T8sgwj1GMLlwXCQdg4DBxONRmMaE5lNVK9
 dUvRwZ1BZKQHw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 7D39A380823A; Tue,  3 Nov 2026 08:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v5 0/4] net: devmem: fix RX and TX binding teardown on
 device unregistration
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <179369340630.929695.14145463061574872626.git-patchwork-notify@kernel.org>
Date: Tue, 03 Nov 2026 08:10:06 +0000
References: <20261030083539.777877-1-almasrymina@google.com>
In-Reply-To: <20261030083539.777877-1-almasrymina@google.com>
To: Mina Almasry <almasrymina@google.com>
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
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 30 Oct 2026 08:35:34 +0000 you wrote:
> Fix two device-unregistration lifecycle bugs in devmem TCP bindings and
> add netdevsim support plus selftests covering both RX and TX device
> unregistration. These issues were found via LLM-assisted code review
> (Sashiko) and reproduced and verified with the new nl_netdev.py
> selftests on netdevsim (not tested on real hardware):
> 
> 1. net: devmem: unmap dma_buf synchronously on queue uninstall
>    Synchronously unmap and detach binding->attachment under binding->lock
>    when the last RX queue is uninstalled in mp_dmabuf_devmem_uninstall()
>    or closed in net_devmem_unbind_dmabuf(), and unmap remaining unbound RX
>    bindings on NETDEV_UNREGISTER, preventing slab-use-after-free in
>    dma_unmap_sg_attrs() when the binding is freed after dma_dev. Factor
>    out net_devmem_lock_dev() and net_devmem_unlock_dev() to synchronize
>    netdev_nl_sock_priv_destroy() and __net_devmem_dmabuf_binding_free()
>    against NETDEV_UNREGISTER.
> 
> [...]

Here is the summary with links:
  - [net,v5,1/4] net: devmem: unmap dma_buf synchronously on queue uninstall
    https://git.kernel.org/netdev/net-next/c/c4466d2c3e77
  - [net,v5,2/4] net: devmem: detach TX bindings on NETDEV_UNREGISTER
    https://git.kernel.org/netdev/net-next/c/ede1618064a9
  - [net,v5,3/4] netdevsim: support devmem RX and TX bindings
    https://git.kernel.org/netdev/net-next/c/c153da399354
  - [net,v5,4/4] selftests: net: add devmem RX and TX netdev unregister tests
    https://git.kernel.org/netdev/net-next/c/121ba2ac7968

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


