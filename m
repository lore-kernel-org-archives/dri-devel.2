Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF19606A31D
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 19:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gQa6/Cle
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1006910EFB5;
	Tue, 20 Oct 2026 19:16:14 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8385E10EFB5
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 19:16:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4FDE043CC8;
 Tue, 20 Oct 2026 19:16:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 671BA1F000C9;
 Tue, 20 Oct 2026 19:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792523767;
 bh=UjcRWvdL2BC3TrFlxjVScdtXMjuSFx/nZAKVfJjRpTY=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=gQa6/CleNS3xUJ8mhSgRJbW9WzgAGva4e2f9agAcAvBfEFQE2JEz6PDfO89WvSqVh
 fAAVaYQWrFHxzd1XRWwoZIGtusEmqs1DNrP3Npu8l3bL0vYrAzCNX7vUQkhC3xSTYd
 GOFG50rIu7R+tAOdysAuiFYu5k7fPUNKF6QX8SdbLDoNRHa1p4xwSeQpJTqgiy5Qos
 9TlOdWlF9sCuhLDcfbvlMhR8HAa23s8gZEGcbUFhqxP/QqESUeNUqlFkOnkOWCj2rT
 B1rTqwHLpLgd2HhfBrOQA6oLAR14kzmq/hC8/91NDgd870bVzab5XrK4b3/PrXlwvI
 LOgnGEnsnkZnA==
Date: Tue, 20 Oct 2026 12:16:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>,
 Stanislav Fomichev <sdf@fomichev.me>, Taehee Yoo <ap420073@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>, Kaiyuan Zhang <kaiyuanz@google.com>, Bobby
 Eshleman <bobbyeshleman@meta.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon Horman
 <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, Sumit Semwal
 <sumit.semwal@linaro.org>, "Christian =?UTF-8?B?S8O2bmln?="
 <christian.koenig@amd.com>, Dragos Tatulea <dtatulea@nvidia.com>, Nikolay
 Aleksandrov <razor@blackwall.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Tariq Toukan <tariqt@nvidia.com>, Kaifeng Wang <kaifengw@google.com>
Subject: Re: [PATCH net v4 0/4] net: devmem: fix RX and TX binding teardown
 on device unregistration
Message-ID: <20261020121605.2e0004cd@kernel.org>
In-Reply-To: <20261015163915.1166043-1-almasrymina@google.com>
References: <20261015163915.1166043-1-almasrymina@google.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 15 Oct 2026 16:39:11 +0000 Mina Almasry wrote:
> Fix two device-unregistration lifecycle bugs in devmem TCP bindings and
> add netdevsim support plus selftests covering both RX and TX device
> unregistration:

This seems to conflict with something in net-next.
Please wait for net-next -> net merge during this merge window,
rebase and repost. I'm assuming this is based on an LLM report
and not something you're hitting in real life? (cover letter
should state how you discovered the issue)
-- 
pw-bot: cr
