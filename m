Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7786CD37B6
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 09:11:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 071C510E081;
	Wed, 13 May 2026 09:11:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="m16X3rUK";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59EE010E081
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 09:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1778663466;
 bh=KuytWSoRv9Q3HvHRXkMcwSkU+/Wx/XKT+BUWEq1VXAw=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=m16X3rUK6vMFErBTWdgRjvwrFMn9HSjD0c1yqLbEm6dyE5y0a4D1Vw2k+G1DpiggC
 tbJjapb9UsDk3Sw1Nboh+uw7Y6lsPgPfU3yA6BSHoNEfgLXMYwgZ7n0jdREZvNOV5Z
 4LA8Vko4npjFU2cLOIjdbqWq2OIP4Kk2g1Fwpit9D3Gp4aitIy6n2y/8lhcNG2AmV4
 tkLyL0J5RGAqwxGhzfsKr9AqII4qnGHDA9uZwWPk2lVc2ujBRl5BKBokFzQosxwhWD
 ysCum7roetRzZ9yk4T3rc906vWZjuIEMCm3RbRWQJ5DEYvfQBBTwzqOzxtig4oizCM
 fgZqiyUM/UBLQ==
Received: from fedora (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 94F2217E1537;
 Wed, 13 May 2026 11:11:05 +0200 (CEST)
Date: Wed, 13 May 2026 11:11:00 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Chia-I Wu via B4 Relay <devnull+olvaffe.gmail.com@kernel.org>
Cc: olvaffe@gmail.com, Steven Price <steven.price@arm.com>, Liviu Dudau
 <liviu.dudau@arm.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Rob Clark <robin.clark@oss.qualcomm.com>
Subject: Re: [PATCH] drm/panthor: set __GFP_SKIP_KASAN
Message-ID: <20260513111100.3b2e080d@fedora>
In-Reply-To: <20260512-panthor-kasan-v1-1-d8d3e275d71b@gmail.com>
References: <20260512-panthor-kasan-v1-1-d8d3e275d71b@gmail.com>
Organization: Collabora
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Tue, 12 May 2026 10:36:28 -0700
Chia-I Wu via B4 Relay <devnull+olvaffe.gmail.com@kernel.org> wrote:

> From: Chia-I Wu <olvaffe@gmail.com>
> 
> Pages that can be swapped out should be allocated with __GFP_SKIP_KASAN.
> Rather than setting the flag directly, replace GFP_HIGHUSER by
> (GFP_HIGHUSER_MOVABLE & ~__GFP_MOVABLE) instead, which should match the
> preceding comment better.

I'm not too sure GFP_HIGHUSER_MOVABLE & ~__GFP_MOVABLE is clearer than
GFP_HIGHUSER (without MOVABLE in the name) to reflect we don't want the
MOVABLE property.

> 
> On a CONFIG_KASAN_HW_TAGS=y system, without __GFP_SKIP_KASAN, the page
> allocator assigns a valid tag to both the kernel mapping and MTE,
> instead of assigning the match-all KASAN_TAG_KERNEL tag to the kernel
> mapping. If userspace also maps the page with PROT_MTE and modifies the
> MTE tag, accessing the page via the kernel mapping results in KASAN
> invalid-access, such as
> 
>   BUG: KASAN: invalid-access in swap_writepage+0xb0/0x21c
>   Read at addr f5ffff81aa71dff8 by task WM.task-4/6956
>   Pointer tag: [f5], memory tag: [f9]
> 
> While userspace cannot map drm gem objects with PROT_MTE, the problem is
> shmem_swapin_cluster. When it swaps in a cluster of pages using our gfp
> flags, some of the pages might belong to other mappings that have
> PROT_MTE.

Okay, let me see if I get this right. The gfp flags we set right now
do what we want for out GEM mappings, it's only when swap readahead is
involved that this becomes problematic:

1. swapin folio for GEM inode X
2. shmem layer optimistically does a readahead on the global swap, with
   our GEM gfp flags
3. the next swap entry belongs to some other tmpfs/anonymous mapping
   (not even something on the same GEM mountpoint actually)
4. because it's our gfp flags that get used for the folio allocation,
  the KASAN poisoning takes place, thus messing up with the original
  user-request PROT_MTE

To me, this looks like a bad isolation of the readahead logic: we
shouldn't cross the inode boundary, because gfp flags for one inode
might be completely different from gfp flags for a different inode.
Let alone the fact the boundary being crossed here is not just inode,
it's basically the entire tmpfs mountpoint.

TLDR; I strongly believe we're papering over some more fundamental
issue in the shmem swap readahead logic: with MTE, we can no longer
assume gfp flags are interchangeable, they have to be enforced and
match exactly what the user of the swap entry expects, meaning
readahead should be constrained by the inode boundary.

> 
> Signed-off-by: Chia-I Wu <olvaffe@gmail.com>
> ---
> The latest snapdragons appear to have MTE support. drm/msm might need
> the same treatment.
> ---
>  drivers/gpu/drm/panthor/panthor_gem.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_gem.c b/drivers/gpu/drm/panthor/panthor_gem.c
> index 13295d7a593df..08c03aa0db2f7 100644
> --- a/drivers/gpu/drm/panthor/panthor_gem.c
> +++ b/drivers/gpu/drm/panthor/panthor_gem.c
> @@ -1013,7 +1013,8 @@ panthor_gem_create(struct drm_device *dev, size_t size, uint32_t flags,
>  	 * going to pin these pages.
>  	 */
>  	mapping_set_gfp_mask(bo->base.filp->f_mapping,
> -			     GFP_HIGHUSER | __GFP_RETRY_MAYFAIL | __GFP_NOWARN);
> +			     (GFP_HIGHUSER_MOVABLE & ~__GFP_MOVABLE) |
> +				     __GFP_RETRY_MAYFAIL | __GFP_NOWARN);
>  
>  	ret = drm_gem_create_mmap_offset(&bo->base);
>  	if (ret)
> 
> ---
> base-commit: 6101f78b684895d5860a96322e607e0f46f433ad
> change-id: 20260512-panthor-kasan-10477239bad1
> 
> Best regards,
> --  
> Chia-I Wu <olvaffe@gmail.com>
> 
> 

