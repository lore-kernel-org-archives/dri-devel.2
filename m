Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6180107BCE6
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 23:06:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D8AF10E028;
	Fri, 13 Mar 2026 23:06:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Jt2I9UnZ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43BDA10E028
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 23:06:32 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 6A54960132;
 Fri, 13 Mar 2026 23:06:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED1AAC19421;
 Fri, 13 Mar 2026 23:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773443191;
 bh=yFVSBh4WIS/NwxjvqQ8QJjFjOyTSxSn7QLtwu40ICpg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Jt2I9UnZ2kDKSz/mk7fs/bJcvr7jO5ba3GhlsVjWsZKxKnz+Mi5/wklcExgENbE0w
 hPsMhYavxA4/Ii3mKP8MxniNHhQx5gBjDs3C2TLn61IuVVhJwW5sAH3qjrGKXao+M5
 KVlpVwH9xej7Bczoui+2oyTP8pLjAoAHmohs9xSiZQFf4qtSaeleG65oJ9dBaNMG2r
 w0P3Vvwc99eHe//v5RRFJP1t6Oxwo7YfHhVRjCwg3/sbqN7eg6WnOmaUA3lzASbaaQ
 wKMC3VLWgyT2l5v95CGEo6Jf+yK1w2fJtEGgVP80Toc/pboqWhkx9R+MBovmhfyGL6
 NVi4he/PVvSQQ==
Date: Fri, 13 Mar 2026 18:06:29 -0500
From: Rob Herring <robh@kernel.org>
To: Albert Esteve <aesteve@redhat.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>,
 "T.J. Mercier" <tjmercier@google.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Saravana Kannan <saravanak@kernel.org>,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 iommu@lists.linux.dev, devicetree@vger.kernel.org,
 mripard@redhat.com, echanude@redhat.com
Subject: Re: [PATCH v3 3/6] of_reserved_mem: add a helper for rmem
 device_init op
Message-ID: <20260313230629.GA3603067-robh@kernel.org>
References: <20260306-b4-dmabuf-heap-coherent-rmem-v3-0-3d00d36c9bc4@redhat.com>
 <20260306-b4-dmabuf-heap-coherent-rmem-v3-3-3d00d36c9bc4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306-b4-dmabuf-heap-coherent-rmem-v3-3-3d00d36c9bc4@redhat.com>
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

On Fri, Mar 06, 2026 at 11:36:34AM +0100, Albert Esteve wrote:
> Add a helper function wrapping internal reserved memory
> device_init call and expose it externally.

Why?

The diff tells us what. The commit msg needs to tell us why. Maybe the 
rest of the series explains it, but this commit needs to stand on its 
own.

> 
> Use the new helper function within of_reserved_mem_device_init_by_idx().
> 
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> ---

Version history?

>  drivers/of/of_reserved_mem.c    | 68 ++++++++++++++++++++++++++---------------
>  include/linux/of_reserved_mem.h |  8 +++++
>  2 files changed, 52 insertions(+), 24 deletions(-)
