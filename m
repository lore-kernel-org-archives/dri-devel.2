Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7218ECCA48F
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 07:36:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CDC311266C;
	Fri, 16 Oct 2026 07:35:43 +0000 (UTC)
Received: from mail-pj2-f4.google.com (mail-pj2-f4.google.com [74.125.227.132])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80C401124BE
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 21:34:58 +0000 (UTC)
Received: by mail-pj2-f4.google.com with SMTP id
 d9443c01a7336-2e96b8bfb43so2543765ad.0
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 14:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792100098; x=1792704898; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6tf5XWfDn7dzpD6pWKJEv/C/OLuu0jZ+hahvmMgLmFI=;
 b=CiDJtXv9jSIoFJxvWrwY8zpEkwBPZ3N8WK7hZB9uZCioFoU5YRLNLemQxuc45eMDp4
 uNhyv4Q+Q4AJGLPXNgJdzEzVaI/Xr7qgMM4hXcd3q83vyRbyjc7Mg6SXmyZanNB2i7o1
 36YdojxvCH5dLSyYOPYEbLjl5cxrF8c8XlbBnTGmcPDsHD928T13x79UaWOV2QqZH6Zk
 XSqKBMDJ9Ouypyg2Tb205lQ0Psr5syUM9MEsYRGxCUCd2/KTe27KPhddnxxey0YMGc+G
 RxqumYQKmShPuqCuMya2RIISS6fRnKPmR8wwSV9It1+VnkDv/KnQ56Uw6imxCH3ElKWg
 6ARQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792100098; x=1792704898;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6tf5XWfDn7dzpD6pWKJEv/C/OLuu0jZ+hahvmMgLmFI=;
 b=fb6A2s3kJaSuAHkjBsezM0HM+OHG1ZNx854QV1n60nQzp6aurjzf+UjwS35xREijxK
 iSDDkaC9s/dllMxfnPPj5kh1U1bvgLz2WHwBYQO6Ag3BJsdvLY21EQseKZqTGzCn3EiO
 ywo8TFu3d4ySx2GCYc/3IGVW0ZhNEHyCHnUaxSwweIynZaMg9eDWJ0V265kOvGwfoUL/
 LAWzmJMUrnr5TMKQ4aZzPK2KnHmC8Kc/vTZsWlJ+zD2UWRzxlLFLU+pWAfyspcrvn397
 ka1HDpa7JC4r8/hmsTMwRlrRa+T3lxnD4/ROQi7jk270vBL9HxJulRuB2yDftjzx1Kon
 qoAg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwJSQFaP3U54qua35smHdtAxzFJqMMY/1ZcjaKJh+FqlmMaHpd8/doWQSrYEGo7wMKBBEmOGkEvGSc=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLn4/5XYYKM1LZfUtetNkBDkRwaC+cfHe4OsNa5aI/+DblBFm2j
 quOezapHDgqhngm8AxEe2Og5kge4GjE/dgixuOT07EUXE0DW4MIECL4u
X-Gm-Gg: AYBFou0p8QpIA+EvtQohKbZ1hxqWqU3FS6PEvwXLycCDf0MkWfTT9QdddhnNFFtOt4q
 m5gSBcJnuc4njSW23eQ5GroG6yYWrmhRciqtcpPF33LdyZXq9EPGCZcjPeX5fATffzEdnLK3ce/
 B6UrAyP9MUBDYTx3UTISMZCLLP35ElzD9TEhniTsOPLsWBKhxyzxSn7TzGEgMRWaF4+JlAJVwsV
 07gjNA2VplcawcI7yQXgXUSEAGxaqo4GTH///iDvV0Rhh1L1BB+cx8DPEiqoKS5FXVD0OxecZPJ
 5Ca8b4MLcPiq1+XEf3mEZfZTq5f1KdDKRSQ4YtwGd1cYSfgzMIKN9Uz+e16cVkOVUagvlOIqyCA
 x9E27KJtYQ7zMIFsNKd6OmqKcSwbiAH1GSgWICFrXtXCR7KX0ZK+A3fMuSkivNdQjb+sazZfS/+
 GO8n6AOh1Fs01zHWrJa34ie3aIqkXwoxOqYj3l3/86BIx2Ft8LlCM9qJ6f55l2TFlpEQG2ca9wB
 2c=
X-Received: by 2002:a17:90b:134c:b0:3a8:92a3:8baa with SMTP id
 98e67ed59e1d1-3ab3a953bd3mr17162889a91.27.1792100097999; 
 Thu, 15 Oct 2026 14:34:57 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:58::])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3acc4991b8asm847025a91.16.2026.10.15.14.34.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 14:34:57 -0700 (PDT)
Date: Thu, 15 Oct 2026 14:34:36 -0700
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
Subject: Re: [PATCH net v4 3/4] netdevsim: support devmem RX and TX bindings
Message-ID: <atFG5qCMA4PugjFj@devvm7509.cco0.facebook.com>
References: <20261015163915.1166043-1-almasrymina@google.com>
 <20261015163915.1166043-4-almasrymina@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261015163915.1166043-4-almasrymina@google.com>
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
> Set a 64-bit DMA mask on nsim_bus_dev, enable NETMEM_TX_DMA on the
> netdevsim net_device, and configure page_pool instances with
> PP_FLAG_ALLOW_UNREADABLE_NETMEM and queue_idx, plus PP_FLAG_DMA_MAP |
> PP_FLAG_DMA_SYNC_DEV when CONFIG_HAS_DMA is set, so devmem bind-rx and
> bind-tx netlink operations can be tested against netdevsim in software
> selftests.
> 
> The pp_hold debugfs file allocates pages from the queue 0 page pool, so
> refuse it when that pool is backed by a memory provider, and take the
> netdev instance lock there so a concurrent bind-rx cannot swap the pool
> in between. The software PSP path checksums the payload when the peer
> does not decapsulate, so drop unreadable skbs there.
> 
> Cc: Tariq Toukan <tariqt@nvidia.com>
> Cc: Kaifeng Wang <kaifengw@google.com>
> Assisted-by: LLM
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
