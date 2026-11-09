Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE73606A33F
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 18:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ofj2ioGg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1809B10E8BA;
	Mon,  9 Nov 2026 18:50:08 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B481910F4C2
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 18:50:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 728D84088E;
 Mon,  9 Nov 2026 18:50:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 696021F008A1;
 Mon,  9 Nov 2026 18:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794250201;
 bh=eNp1Wnd7c4jN3oPa7QIZpI0WRmhIRL8VX/H8V1tIkCc=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=ofj2ioGgh6SnMMTdAbmtSrXMvkdlQMrjoWzlyBnquYH/PHlS6Xud8JU49Zfk6/cpn
 ZiY+TtKqwlpRyOlXJ4lEffLdMKX0KTEz+2u6joa5gjS4kjEi+h4tzExCAb0y2ZtPEc
 l3eNS9EXxO4soY1p3zcovYxD7Qgj8ABe7e6R3jpJ7Flv/ralgOtb+0FHEthonSqa7I
 etxgWrgaRINs3IuWU2M8D4hqZJxA5hPDMyyZHePLQQjJbqseXwZ5gb5S4Frg9WV4u/
 REzp1s9jzpRZipnx4HiNF+Ttbn1BFa1QcpmVOV7PVfah9f6kt3ifNrLCJyMQSsB3zG
 qhSfs+BcazzQg==
Date: Mon, 9 Nov 2026 10:49:59 -0800
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
 <sumit.semwal@linaro.org>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, Dragos Tatulea <dtatulea@nvidia.com>, Nikolay
 Aleksandrov <razor@blackwall.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Tariq Toukan <tariqt@nvidia.com>, Kaifeng Wang <kaifengw@google.com>
Subject: Re: [PATCH net v4 3/4] netdevsim: support devmem RX and TX bindings
Message-ID: <20261109104959.181a3b35@kernel.org>
In-Reply-To: <CAHS8izNTbs8ONvjhiw+6cRkZQq+cX3t=BZK9aCr39JNkVbY9gA@mail.gmail.com>
References: <20261015163915.1166043-1-almasrymina@google.com>
 <20261015163915.1166043-4-almasrymina@google.com>
 <20261020121858.3b9107c5@kernel.org>
 <CAHS8izPwWT+vbgAe49m5vXsRxT3unbfjLTkVZBScgAPdQTo2dQ@mail.gmail.com>
 <20261021132304.23e0a4e7@kernel.org>
 <CAHS8izNTbs8ONvjhiw+6cRkZQq+cX3t=BZK9aCr39JNkVbY9gA@mail.gmail.com>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, 7 Nov 2026 22:21:48 -0800 Mina Almasry wrote:
> So I started looking into whether we can improve test and fuzz
> coverage with an improved netdevsim. My LLM prototyped full datapath
> (with devmem) and offload support in netdevsim so the hardware
> selftests and packetdrill run and pass in a plain VM without physical
> NICs. I posted the branch at:
> 
> https://github.com/mina/linux/tree/nsim-devmem-rx-tx
> 
> The main problem is the total LLM generated diff to netdevsim: 62
> files changed with 5,525 additions and 672 deletions :( So it's a big
> change.

Great! Please keep that slop to yourself, tho.
Upstream isn't built to host people weekend slop.
