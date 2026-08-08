Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 212F3C5AD05
	for <dri-devel@archiver.kernel.org>; Sat,  8 Aug 2026 01:41:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3943710E49C;
	Sat,  8 Aug 2026 01:41:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="joAKtJ9a";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D31710E491
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 01:40:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D370341A3F;
 Sat,  8 Aug 2026 01:40:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3E051F000E9;
 Sat,  8 Aug 2026 01:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786153257;
 bh=NXm/SsYiv4ju2Xo/fyAJbZ1/yajU4AJnu1Qr1d7j8WA=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=joAKtJ9aDWLRW8g60N7rTz7Fk3n3zBec23EWuWHUcWd5HRqJVBkyk5WzNKzjUm85d
 9lsGEGYAKdlvH34Iw4D0SJhzT+OSm4I97ZiogX8In8C3QDlPx4sL/bJHQX8+z9I/xL
 llWdFb+5gWtBqCI6caipTdq3EJ5h0snCEe5r3v584ZLlC4dIbfsFFuGlNZ1gWMXXjG
 gPJYFRkePsgxKXugp6MgsJ6jx2YB/CLH5jYGJREspbCKJ7wNR1g4fjFpD2B6OMjnJi
 76Cubw0CLs7D2krtwFJV7n8r/JTSsAZEjTiFhC2xcn67UHTA3CEZG4Jtgx1r3vW0f4
 mcuseiKZ7WFJg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 5696B380CEE4; Sat,  8 Aug 2026 01:40:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v8 0/3] net: devmem: allow rx-buf-size > PAGE_SIZE
 per binding
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <178615321588.2493713.16495466969438230257.git-patchwork-notify@kernel.org>
Date: Sat, 08 Aug 2026 01:40:15 +0000
References: <20260805-tcpdm-large-niovs-v8-0-3e0225e2808c@meta.com>
In-Reply-To: <20260805-tcpdm-large-niovs-v8-0-3e0225e2808c@meta.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: donald.hunter@gmail.com, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 andrew+netdev@lunn.ch, kraxel@redhat.com, vivek.kasireddy@intel.com,
 sumit.semwal@linaro.org, christian.koenig@amd.com, shuah@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, linux-kselftest@vger.kernel.org,
 sdf@fomichev.me, razor@blackwall.org, daniel@iogearbox.net,
 almasrymina@google.com, matttbe@kernel.org, skhawaja@google.com,
 dw@davidwei.uk, joe@dama.to, bobbyeshleman@meta.com
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

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 05 Aug 2026 13:42:42 -0700 you wrote:
> Every devmem dmabuf binding hands the page_pool PAGE_SIZE niovs today.
> On NICs that consume one descriptor per netmem, this caps a single RX
> descriptor at PAGE_SIZE and burns CPU on buffer churn.
> 
> In this series, we add a bind-time netlink attribute,
> NETDEV_A_DMABUF_RX_BUF_SIZE, that lets userspace request a larger niov
> size (power of two >= PAGE_SIZE). Drivers must opt in via
> queue_mgmt_ops.QCFG_RX_PAGE_SIZE.
> 
> [...]

Here is the summary with links:
  - [net-next,v8,1/3] net: devmem: allow rx-page-size > PAGE_SIZE per dmabuf binding
    https://git.kernel.org/netdev/net-next/c/b27a8560eec9
  - [net-next,v8,2/3] selftests/net: ncdevmem: add -b option to set rx-page-size on bind
    https://git.kernel.org/netdev/net-next/c/3e8c9ec4eb75
  - [net-next,v8,3/3] selftests/net: devmem.py: add check_rx_large_niov
    https://git.kernel.org/netdev/net-next/c/8ac4255c1e0c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


