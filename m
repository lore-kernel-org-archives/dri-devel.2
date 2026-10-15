Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B858CCA462
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 07:36:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0218411266B;
	Fri, 16 Oct 2026 07:35:43 +0000 (UTC)
Received: from mail-pj2-f11.google.com (mail-pj2-f11.google.com
 [74.125.227.139])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 815E71124D4
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 21:34:59 +0000 (UTC)
Received: by mail-pj2-f11.google.com with SMTP id
 98e67ed59e1d1-398a0a87595so1177222a91.1
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 14:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792100099; x=1792704899; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pQimVVD9drWSngFOzWOAmVd128tPGcg8NvVnNLLNcbY=;
 b=DEAShjIzUVHOVEJFgJQgEhbKNwg8UcJcdf8Jcr8g9JqsNmgaqz9F0Z3mbUTpUa2Mmm
 KHKJsEs9dh+kjyRFQdXqupWCgNUGoyFx5rgVmNQ6kCJEihXrBPjOqfBW/SBbs9lUELM6
 HUxWRcJBRyaJlRNl8IEbaxtxMilcDmLcuzk/22wdVc4cuHNAkb69mOl0G1zfiCQxBrOD
 NE/EiOzW2akBmzuTf87/w79Y/ArNcjVrxuiXYWl2OFvt8yQYLimK6hJrEtT5WGc3+Atz
 JxO8zzbaFuYHpKk4/2eeb8/vvcNiQu4M8HicVtROU+sSgdNoHGkxi4616LyA73Akdw4p
 /www==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792100099; x=1792704899;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pQimVVD9drWSngFOzWOAmVd128tPGcg8NvVnNLLNcbY=;
 b=Sdvbc9vAmUoS8ZTXLlmDLGlzEQt/l2ckce6laS9pa0XpcBj8Zy2Vdi9JtGEXe7lNUL
 W3C9qSReb+B5BEile1MyO3jNEnZJVsHiQr9RKxvaN0YPSbQrtTdVRBoVLUxMQ34P02oa
 puaww6FPhaestz4Wr/tupzdIcZ13kMCeIaX0MhEZdEMcMJNh0ngpIO8/lN6h+fTO2KiS
 8SzF7T9JQtdCDk6OyrvAN7uy4/FZdgqHI8+Wrjczobf3qcqytalYMHcfIOr70xLwHP5I
 t9eAGCm2dlHZazLVqBpNItG5KrJFBPwaDKjgeYtjiiJNcVRVeB4P0FL59qa+pyvXn7Ct
 V3AQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxZLHAvHb3ZT3+go841AycS7uonIqY/ONxFGTwRr7keJyzgax2izslGLCN68lP3FcxUsOXSwB/FKQ8=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJaC9M/59aXhBsWTHN0DDC+v4U1icBWnyxzYr2I5UVfaWziHuHe
 gOsNJeYKa/A3fqKnzfUVwFqT6GuvBhVEp+RCjsEmEmOpl0YJKPGTMjqh
X-Gm-Gg: AYBFou2f4d+4eN+cBfzNH2rGtpDDMSQyelL9sC+aAccqJKnerX5xaCduNOUFYwThCCq
 OnDdtLlT+7c0T68lm6CKM+rT7pGEICLtcIv/qn7t3ngIeYMrvIMfEi9ibUpH3uOnS9EyFxECGWb
 1mpgIRH+tnkjxW8+oOz/2DsdQtLlSzIn/ALoFHTzWwv58K0IAYQs0yUUGqFm7hQMwwvRJZfsqsJ
 5ccrkosWfMzukElcyrX+Csxr5D9SBkGlHRhcxK14AtUFBP4va4i7/pMdfgxttiLvpaj2Zsbihej
 kqA+WcPuJL82/BE9DQItoNhHYXC+2uNt4cVoubDfs8676+GiauY6WNNZscJUqyBOTv8esJl45Ea
 hzOO+MXPYUB66eRjJEMTLg881nhqX4Hrz7tBKgiXErd9tADpFOqLaMERFYTtQYEU102AJMVjng4
 PfimEgXg3dBcr95Q5COItNvc1Dwy/OmvFYKghsk39kLUBbp0mu31O5wvRMOl1JgMZ7sA==
X-Received: by 2002:a17:90a:ec8c:b0:3ab:24b2:9016 with SMTP id
 98e67ed59e1d1-3ab3a9a8d8dmr19267667a91.25.1792100098937; 
 Thu, 15 Oct 2026 14:34:58 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:5a::])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cd6549f175bsm119893a12.21.2026.10.15.14.34.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 14:34:58 -0700 (PDT)
Date: Thu, 15 Oct 2026 14:34:45 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, 
 Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>,
 Stanislav Fomichev <sdf@fomichev.me>, 
 Taehee Yoo <ap420073@gmail.com>, Paolo Abeni <pabeni@redhat.com>, 
 Kaiyuan Zhang <kaiyuanz@google.com>, Bobby Eshleman <bobbyeshleman@meta.com>,
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
 Dragos Tatulea <dtatulea@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Tariq Toukan <tariqt@nvidia.com>, 
 Kaifeng Wang <kaifengw@google.com>
Subject: Re: [PATCH net v4 4/4] selftests: net: add devmem RX and TX netdev
 unregister tests
Message-ID: <atFG77ZcuGHOsKgW@devvm7509.cco0.facebook.com>
References: <20261015163915.1166043-1-almasrymina@google.com>
 <20261015163915.1166043-5-almasrymina@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261015163915.1166043-5-almasrymina@google.com>
X-Mailman-Approved-At: Fri, 16 Oct 2026 07:35:41 +0000
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

On 10/15, Mina Almasry wrote:
> Add devmem_bind_rx_unregister_check and devmem_bind_tx_unregister_check
> to nl_netdev.py to verify that unregistering a netdevsim device while a
> netlink socket holds an active RX or TX devmem binding synchronously
> detaches the dma_buf attachment and cleanly closes the netlink socket
> without use-after-free or page faults.
> 
> Add the dma-buf, udmabuf and devmem options the tests need to
> tools/testing/selftests/net/config.
> 
> Cc: Tariq Toukan <tariqt@nvidia.com>
> Cc: Kaifeng Wang <kaifengw@google.com>
> Assisted-by: LLM
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
