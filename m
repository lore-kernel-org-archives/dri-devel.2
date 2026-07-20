Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BA21C44515
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 20:53:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A8C810E18B;
	Mon, 20 Jul 2026 20:53:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.b="kWRD/WwS";
	dkim-atps=neutral
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2852C10E18B
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 20:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
 s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
 Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
 bh=rLkNesRCYNFOq+ZuVFxEEhkM0txhhysUwpvEFeMD4Fw=; b=kWRD/WwSdH3oQGCu/bb2MqxLFt
 GxxMAXajZYFA8mU3N1Pm9DTmh8P/j0xPt/6IE5Pei2n1jaMYNVOfrjUkv5qnofA/1mh5DxHW6vw6w
 G6xJB9AiVVAZK+u8aHNV/3Pt2rqgYDi1iqaQ5Jt98DQbpEtpuFBvr45lX/W5wsB0Shy0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
 (envelope-from <andrew@lunn.ch>)
 id 1wluz9-00DK2K-VG; Mon, 20 Jul 2026 22:53:11 +0200
Date: Mon, 20 Jul 2026 22:53:11 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Natalie Vock <nat@pixelcluster.dev>
Cc: Taehee Yoo <ap420073@gmail.com>, Alex Deucher <alexander.deucher@amd.com>,
 Alexei Starovoitov <ast@kernel.org>, amd-gfx@lists.freedesktop.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, Andrii Nakryiko <andrii@kernel.org>,
 Bill Wendling <morbo@google.com>, bpf@vger.kernel.org,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Daniel Borkmann <daniel@iogearbox.net>, David Airlie <airlied@gmail.com>,
 "David S. Miller" <davem@davemloft.net>,
 Donald Hunter <donald.hunter@gmail.com>, dri-devel@lists.freedesktop.org,
 Eduard Zingerman <eddyz87@gmail.com>,
 Emil Tsalapatis <emil@etsalapatis.com>, Eric Dumazet <edumazet@google.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Hoyeon Lee <hoyeon.rhee@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Leon Romanovsky <leon@kernel.org>, linaro-mm-sig@lists.linaro.org,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org,
 linux-rdma@vger.kernel.org, llvm@lists.linux.dev,
 Mark Bloch <mbloch@nvidia.com>, Martin KaFai Lau <martin.lau@linux.dev>,
 Michael Chan <michael.chan@broadcom.com>,
 Nathan Chancellor <nathan@kernel.org>, netdev@vger.kernel.org,
 Nick Desaulniers <ndesaulniers@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Shuah Khan <shuah@kernel.org>,
 Simona Vetter <simona@ffwll.ch>, Simon Horman <horms@kernel.org>,
 Song Liu <song@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Sumit Semwal <sumit.semwal@linaro.org>, Tariq Toukan <tariqt@nvidia.com>,
 Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [RFC PATCH net-next 08/13] drm/amdkfd: add GPU instruction
 emitter and disassembler
Message-ID: <8dfbef48-db20-4642-8f50-e37f46af6627@lunn.ch>
References: <20260719175857.4071636-1-ap420073@gmail.com>
 <20260719175857.4071636-9-ap420073@gmail.com>
 <41e73be8-242a-4e7b-b085-439375303590@pixelcluster.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41e73be8-242a-4e7b-b085-439375303590@pixelcluster.dev>
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

On Mon, Jul 20, 2026 at 10:05:33PM +0200, Natalie Vock wrote:
> On 7/19/26 19:58, Taehee Yoo wrote:
> > Add the AMD GCN (gfx9/gfx10) instruction encoder used to build the GPU
> > shaders that knod dispatches, plus a matching disassembler used for
> > debugging the generated code.
> 
> Is it really necessary to have a full-on compiler and disassembler in the
> kernel driver? This patch is massive and I'm wondering how much benefit it
> really provides. Is there really no way to move GPU compilation out of the
> kernel, one way or another? Could you get acceptable perf with a static
> shader that interprets BPF programs at runtime? Such a shader can be
> compiled beforehand and just embedded into the kernel - there's prior art
> there with the CWSR trap handler in amdkfd.
> 
> In case you really, really need to compile the BPF to native ISA, could you
> still have userspace take care of that in one way or another?

There was a long and painful discussion about P4, and offloading it to
hardware. The proponents of that wanted to do the compilation stage in
user space to produce a binary blob, but it was hard to prove that the
P4 passed to the kernel for software processing, and the binary blob
passed to the hardware actually where the same. It opened up the path
for closed source P4 where the kernel never got to see the actual P4
code. So it was not really offload, but kernel bypass.

So having a compiler in the kernel is probably the correct way to go,
if you want to be friendly to open source.

The other option is to get the GPU to do the compilation itself, so
you pass BPF byte codes to the GPU and it generates its own native
code. I've no idea if that is possible, but clang can target OpenMP,
so maybe it is possible to move this compiler into the GPU?

      Andrew
