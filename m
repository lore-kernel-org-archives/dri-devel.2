Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E7B606A32C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 10:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VGhOvMqG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67E7310EEB1;
	Mon, 16 Nov 2026 10:20:24 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A67810EEB1
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 10:20:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 47A2A41A37;
 Mon, 16 Nov 2026 10:20:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09C331F02828;
 Mon, 16 Nov 2026 10:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794824417;
 bh=Vb4TTKfYqIZTN5fiptU5W4ujJwX93XnLUqZt87e8R20=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=VGhOvMqG8pJN3LVjErtGjUZUjRNRUvhkegPXckP4ZDMvLqJcfCZn4iwnlJicd1WnU
 LgWVlAt6y42O/NXch/rwOhM4RrqTqXuNNqnKbPODH2vsuhKXqqoT5ktOPSGW/e3/JM
 LH6RBHPSKGhNTNEXvrV+0QPeOk/dIIVlSMnd6n0J7CNKLR9hVMZILPjMYhIMn0xzXw
 xMF0utsRhnY2Mt84K15qVsGkl6IX12MEodyjYGeaEi7rnPe6EFbL3+P81kLL7XMPKb
 qO6fZ7qz027mVrgAPY6/NhaaM2r7lWO0TRG/hcyn6VhuGWIVk0VAFTWoo6c7hm+s8+
 qhxCe5WzrR5Xg==
Message-ID: <6648f693-ca76-4edd-99ff-9fd60e71fd15@kernel.org>
Date: Mon, 16 Nov 2026 10:20:10 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] fastrpc: fix probe-time races between rpmsg and
 userspace
To: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>,
 Srinivas Kandagatla <srini@kernel.org>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thierry Escande <thierry.escande@linaro.org>
Cc: Bharath Kumar <bkumar@qti.qualcomm.com>,
 Chenna Kesava Raju <chennak@qti.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261022-fastrpc-probe-fixes-v2-0-a6b3f6f62571@oss.qualcomm.com>
From: Srinivas Kandagatla <srini@kernel.org>
Content-Language: en-US
In-Reply-To: <20261022-fastrpc-probe-fixes-v2-0-a6b3f6f62571@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/22/26 10:08 AM, Vinayak Katoch wrote:
> ---
> base-commit: 8f7df005a7564bd7ffa75da9c3085d5b996f1e16
> change-id: 20260923-fastrpc-probe-fixes-30c1980b50e6
> prerequisite-change-id: 20260609-dup-sessions-ea2acaac1994:v6
> prerequisite-patch-id: c8b4a3873f9cf0d69beff0f608933ae83faa4c47
> prerequisite-patch-id: 05d9299adf4184e0e56d97dc063ab5bf227cc5a5
> prerequisite-patch-id: da0a3d55397a522ea4b77769e387df9faea8e024
This series is fixes and why is depending on enhacement patches? It
makes it very hard to pull fixes when you add dependencies to new
features or enhancement, Fixes should be independent and cleanly apply
on linux0-next

--srini

