Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CD9606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 07:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=b8wh1A5q
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66D5D10FE1D;
	Thu, 19 Nov 2026 07:53:02 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EDDD10FDBD
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 07:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1795074746;
 bh=z3gDAv4QNYmxE66TTQpSpU4usvXBzFzl9h/ykF/+X9w=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=b8wh1A5qYU6sryQ73tQQyo3/FpagnSEyevlpSIe8MMJKez3aibJCdFH7jhxeZo/5D
 zly8Y7JQf5EbH4z2pMxA139eMtG2a69QU5Ip5DF+Q9QQYFVTFUshkwBKHpdBsLiCJ8
 v+lRRXzwGjlo17jvirXYqLq3fx1fUojMwE6X1btc7WDzuTHZA9lf+g7zl2NkkNVz+N
 qc5utInd8dGVdOXtWum+9yt8yykUVjfca0IEMWcD/EbRBgRb6k1UgffJeKY/1RUBD8
 Y3ijeBniXES7nm+5AN15uu3eZ+PlpR1bi28rPUYC0aGvppcwZ8DERt+d7YBsms9MVC
 y3DffkcRb5T0Q==
Received: from fedora1.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 5E37817E00E8;
 Thu, 19 Nov 2026 08:52:26 +0100 (CET)
Date: Thu, 19 Nov 2026 08:52:20 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Karunika Choo <karunika.choo@arm.com>
Cc: dri-devel@lists.freedesktop.org, nd@arm.com, Steven Price
 <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 linux-kernel@vger.kernel.org, Akash Goel <akash.goel@arm.com>, Lukas
 Zapolskas <lukas.zapolskas@arm.com>, Chris Diamand <chris.diamand@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Subject: Re: [PATCH v3 02/10] drm/panthor: Rename neural accelerator feature
 macro to NX
Message-ID: <20261119085220.033b47d5@fedora1.home>
In-Reply-To: <20261118175332.519657-3-karunika.choo@arm.com>
References: <20261118175332.519657-1-karunika.choo@arm.com>
 <20261118175332.519657-3-karunika.choo@arm.com>
Organization: Collabora
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 18 Nov 2026 17:53:18 +0000
Karunika Choo <karunika.choo@arm.com> wrote:

> Rename GPU_FEATURES_NEURAL_ENGINE to GPU_FEATURES_NX.
> Update the panthor_hw helper to use the new name.
> 
> Signed-off-by: Karunika Choo <karunika.choo@arm.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/gpu/drm/panthor/panthor_gpu_regs.h | 2 +-
>  drivers/gpu/drm/panthor/panthor_hw.h       | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_gpu_regs.h b/drivers/gpu/drm/panthor/panthor_gpu_regs.h
> index 5340966caef37..c7581b6d4c5be 100644
> --- a/drivers/gpu/drm/panthor/panthor_gpu_regs.h
> +++ b/drivers/gpu/drm/panthor/panthor_gpu_regs.h
> @@ -67,7 +67,7 @@
>  
>  #define GPU_FEATURES					0x60
>  #define   GPU_FEATURES_RAY_INTERSECTION			BIT(2)
> -#define   GPU_FEATURES_NEURAL_ENGINE			BIT(4)
> +#define   GPU_FEATURES_NX				BIT(4)
>  #define   GPU_FEATURES_RAY_TRAVERSAL			BIT(5)
>  
>  #define GPU_TIMESTAMP_OFFSET				0x88
> diff --git a/drivers/gpu/drm/panthor/panthor_hw.h b/drivers/gpu/drm/panthor/panthor_hw.h
> index eeca936f44bae..f770dc40e6216 100644
> --- a/drivers/gpu/drm/panthor/panthor_hw.h
> +++ b/drivers/gpu/drm/panthor/panthor_hw.h
> @@ -64,7 +64,7 @@ static inline bool panthor_hw_has_pwr_ctrl(struct panthor_device *ptdev)
>  static inline bool panthor_hw_has_neural(struct panthor_device *ptdev)
>  {
>  	return (GPU_ARCH_MAJOR(ptdev->gpu_info.gpu_id) >= 14 &&
> -		ptdev->gpu_info.gpu_features & GPU_FEATURES_NEURAL_ENGINE);
> +		ptdev->gpu_info.gpu_features & GPU_FEATURES_NX);
>  }
>  
>  #endif /* __PANTHOR_HW_H__ */

