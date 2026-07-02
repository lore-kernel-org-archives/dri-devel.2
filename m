Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93255C43327
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 12:22:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 850D410E4B3;
	Thu,  2 Jul 2026 12:22:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="lN0+Boa2";
	dkim-atps=neutral
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com
 [91.218.175.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CF9E10F337
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 12:22:04 +0000 (UTC)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1782994911;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=flDoJiJgtgGf3x2zlQX9jaS5nhFTdBgmSXvfG9PiFjA=;
 b=lN0+Boa2ASIcCLc47EPvtXVMZuYaw78VJ/wVLmRpCeGudutYAguuVxwIGwqQDa2oDibvGW
 bIpbbgc5ew0Ij3QtFyyGuneAdXTOrpkXqfYfNRMzfKjFKxKgZCy8wM/iRDCenl6trdMYJz
 +LOdf87J+2yAD0n3s3yNqonkzwm6x4w=
From: Lance Yang <lance.yang@linux.dev>
To: ljs@kernel.org
Cc: akpm@linux-foundation.org, tsbogend@alpha.franken.de, maddy@linux.ibm.com,
 mpe@ellerman.id.au, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 l.stach@pengutronix.de, inki.dae@samsung.com, sw0312.kim@samsung.com,
 kyungmin.park@samsung.com, krzk@kernel.org, peter.griffin@linaro.org,
 jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
 rodrigo.vivi@intel.com, tursulin@ursulin.net, robin.clark@oss.qualcomm.com,
 lumag@kernel.org, lyude@redhat.com, dakr@kernel.org,
 tomi.valkeinen@ideasonboard.com, hjc@rock-chips.com, heiko@sntech.de,
 andy.yan@rock-chips.com, thierry.reding@kernel.org, mperttunen@nvidia.com,
 jonathanh@nvidia.com, kraxel@redhat.com, dmitry.osipenko@collabora.com,
 zack.rusin@broadcom.com, matthew.brost@intel.com,
 thomas.hellstrom@linux.intel.com, oleksandr_andrushchenko@epam.com,
 deller@gmx.de, bcrl@kvack.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
 muchun.song@linux.dev, osalvador@suse.de, david@kernel.org, ziy@nvidia.com,
 baolin.wang@linux.alibaba.com, liam@infradead.org, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
 lance.yang@linux.dev, hughd@google.com, vbabka@kernel.org, rppt@kernel.org,
 surenb@google.com, mhocko@suse.com, jannh@google.com, pfalcato@suse.de,
 kees@kernel.org, perex@perex.cz, tiwai@suse.com,
 linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, dri-devel@lists.freedesktop.org,
 etnaviv@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-tegra@vger.kernel.org, virtualization@lists.linux.dev,
 intel-xe@lists.freedesktop.org, xen-devel@lists.xenproject.org,
 linux-fbdev@vger.kernel.org, linux-aio@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-sound@vger.kernel.org
Subject: Re: [PATCH 06/13] mm/vma: convert vm_pgprot_modify() to use
 vma_flags_t and rename
Date: Thu,  2 Jul 2026 20:21:16 +0800
Message-Id: <20260702122116.65642-1-lance.yang@linux.dev>
In-Reply-To: <548ba81b2971734d4d2143237ad1465bd1b2f525.1782760670.git.ljs@kernel.org>
References: <548ba81b2971734d4d2143237ad1465bd1b2f525.1782760670.git.ljs@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
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


On Mon, Jun 29, 2026 at 08:25:29PM +0100, Lorenzo Stoakes wrote:
>Update vm_pgprot_modify() to use the new VMA flags type vma_flags_t, and
>rename to vma_pgprot_modify() accordingly.
>
>This is part of the ongoing work to convert vm_flags_t to vma_flags_t, in
>order to eliminate the arbitrary limit of the number of bits in a system
>word on available VMA flags.
>
>Update VMA userland tests accordingly, updating vma_set_page_prot() to no
>longer inline vma_pgprot_modify(), rather we can simply define
>vma_pgprot_modify() as a static inline function and the tests will pick it
>up from vma.h.
>
>No functional change intended.
>
>Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>
>---
[...]
>diff --git a/mm/vma.h b/mm/vma.h
>index bcf0c2773449..6a8abb8ae937 100644
>--- a/mm/vma.h
>+++ b/mm/vma.h
>@@ -522,9 +522,11 @@ static inline bool vma_wants_manual_pte_write_upgrade(struct vm_area_struct *vma
> }
> 
> #ifdef CONFIG_MMU
>-static inline pgprot_t vm_pgprot_modify(pgprot_t oldprot, vm_flags_t vm_flags)
>+static inline pgprot_t vma_pgprot_modify(pgprot_t oldprot, vma_flags_t vma_flags)
> {
>-	return pgprot_modify(oldprot, vm_get_page_prot(vm_flags));
>+	const pgprot_t prot = vma_get_page_prot(vma_flags);
>+
>+	return pgprot_modify(oldprot, prot);

Nit: could this just stay as a single return? something like:

return pgprot_modify(oldprot, vma_get_page_prot(vma_flags));

Otherwise, LGTM, feel free to add: 

Reviewed-by: Lance Yang <lance.yang@linux.dev>

[...]
