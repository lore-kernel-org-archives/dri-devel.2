Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E4D606A32A
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 17:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a9f+nPtu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9892910E1E9;
	Sun, 22 Nov 2026 17:01:57 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15F4910E601
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 17:01:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CAD66405CF;
 Sun, 22 Nov 2026 17:01:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74B071F000C0;
 Sun, 22 Nov 2026 17:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795366910;
 bh=8CLyexFisr+loo6bQvDGwbW36TVAaUmS+iGfQnY7nTc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=a9f+nPtuAyQAL94oZ1wEVUqzWGO2nfPTX+iFKSatnP584WS9kVpUUcTodjjVVZPvv
 5uSO9nv7sJga5PadnTVro7+Y8/Llh9aCLiYbTmjrrBerHqevmnq3j/vdvFmAam7ZEQ
 B5KUrAQVwIo8eyxI98ju7kq1EBVv9U0VCQrnDE7Teo2ftDCZr7KazbaN1o9kqBcF96
 otSl42mgUtuZe/rz5Hjak6vtvSkmJycjvjVj9egU6c2fvcHH/YHcjOjjXCw8Qcdin3
 R87u3+RiYhTlVyi9zWrCSMPel80juwi75GMETbVoQJBB8+g5qT1VimKnjPolPWxBJ5
 mthIC6VrvY6UA==
Date: Sun, 22 Nov 2026 18:01:46 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Cunyuan Liu <cunyuan.liu@cixtech.com>
Cc: boris.brezillon@collabora.com, steven.price@arm.com, 
 liviu.dudau@arm.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 gary.yang@cixtech.com, fugang.duan@cixtech.com, daniel.almeida@collabora.com, 
 aliceryhl@google.com, p.zabel@pengutronix.de, daniel@fooishbar.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 cix-kernel-upstream@cixtech.com, robin.wang@cixtech.com
Subject: Re: [PATCH v3 5/7] dt-bindings: gpu: Add CIX Sky1 Mali support
Message-ID: <20261122-efficient-lobster-of-foundation-abd517@quoll>
References: <20261119123850.2994625-1-cunyuan.liu@cixtech.com>
 <20261119123850.2994625-6-cunyuan.liu@cixtech.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261119123850.2994625-6-cunyuan.liu@cixtech.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 19, 2026 at 08:38:48PM +0800, Cunyuan Liu wrote:
> Describe the Mali CSF GPU on CIX Sky1. It uses core and stacks clocks,
> an external reset and a GPU power domain.
> 
> Add the compatible string, resource requirements and an example. Require
> the system-cache allocation policies needed by the Sky1 integration.
> 
> Signed-off-by: Cunyuan Liu <cunyuan.liu@cixtech.com>
> ---
>  .../bindings/gpu/arm,mali-valhall-csf.yaml    | 55 +++++++++++++++++++
>  1 file changed, 55 insertions(+)

So what changed here exactly that you decided to drop review? I run b4
diff and there is no relevant difference.

Best regards,
Krzysztof

