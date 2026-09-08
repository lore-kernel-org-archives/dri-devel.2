Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B90D7C79F9E
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 14:59:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E74A010E11E;
	Tue,  8 Sep 2026 14:59:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QvGYzZvW";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B03910E11E
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 14:59:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 56357601FD;
 Tue,  8 Sep 2026 14:59:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B47B31F00A3A;
 Tue,  8 Sep 2026 14:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788879589;
 bh=mjLxlDjwVMKv9IYIkt+Ko/Nyuaq1pNIEbnWW+mI79fE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=QvGYzZvW6Biq/bKb+ElGh8jCXJmgfMxoVL0Otn2vzu3W/Xmg9Bv+JC3DvUD+LuWy4
 5zHSOarYcP9CaGN7JAmEgbOcuiq5k4yqeVAeBse1GJx2ytaLCk7BgTyJ9K90260SkQ
 +QqOg36QieaIouCcAp5vjxWrkrJVoBQmG3a7dNypT5QdKVWri9HRkytxVHW5G0Sh9K
 cUTG68rmgshSn7vU79mx+3naUuCrNIHt8nqtZFbsEmVDRSI8g4TNkpBD5lsw00gxQq
 FgKaSVtHrOlKhSwHL37yeayu9D9QlIaagzVnoJAVY9TyBXnfhIJfBQT4BlKyzMoCSa
 ZC8kDVt3Wo8hQ==
Date: Tue, 8 Sep 2026 09:59:29 -0500
From: Rob Herring <robh@kernel.org>
To: Thierry Reding <thierry.reding@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Sowjanya Komatineni <skomatineni@nvidia.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Mikko Perttunen <mperttunen@nvidia.com>, Yury Norov <yury.norov@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Russell King <linux@armlinux.org.uk>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>,
 "T.J. Mercier" <tjmercier@google.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Chun Ng <chunn@nvidia.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Saravana Kannan <saravanak@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux.dev, linaro-mm-sig@lists.linaro.org,
 linux-trace-kernel@vger.kernel.org, Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH v6 06/12] of: Export of_node_to_nid()
Message-ID: <20260908145929.GB3123582-robh@kernel.org>
References: <20260904-tegra-vpr-v6-0-79042cfa8de5@nvidia.com>
 <20260904-tegra-vpr-v6-6-79042cfa8de5@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904-tegra-vpr-v6-6-79042cfa8de5@nvidia.com>
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

On Fri, Sep 04, 2026 at 12:44:57PM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Drivers buildable as a module may want to use this, so export it.

We need a specific reason/driver. Otherwise, that's every API function. 

It doesn't look to me like the VPR driver ever actually uses the NID.

> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  drivers/of/of_numa.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/of/of_numa.c b/drivers/of/of_numa.c
> index 230d5f628c1b..da2e9bd1717c 100644
> --- a/drivers/of/of_numa.c
> +++ b/drivers/of/of_numa.c
> @@ -171,6 +171,7 @@ int of_node_to_nid(struct device_node *device)
>  
>  	return NUMA_NO_NODE;
>  }
> +EXPORT_SYMBOL(of_node_to_nid);

Assuming this is still needed, EXPORT_SYMBOL_GPL.

Rob
