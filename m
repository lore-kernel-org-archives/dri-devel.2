Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C27606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 08:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=fYpq2ei1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B79A1121B3;
	Thu, 19 Nov 2026 08:51:35 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A12391121B3
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1795078285;
 bh=a07pApNrtARcdPXB05UrOdCPM/Guy+QmVvE6TdzbRMQ=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=fYpq2ei1hRLyj0v6LoRHCY3pAFz80RSjYR+UzA8VykW7QXIArBEgvQy508ltx6msi
 AlQtW14ws2YUSYGE7TNkXDizGgZjnsUgfVixM0Tc5TXN+yW9kOSsaHRkzchb82QUwe
 gdZriPyHJPmAvU3RIMnuvnQ6GtOnLr7LkLme0GzhzAlxzIkFvoJcJm1XdW4WuEJCb/
 /3kjmopDmylaruGmCFjeldddTXN6YssSaQfe85ETmXw+46fC5MyR+GE8UVYdIOxWna
 JmcH2FiYFqTJcn3psaFHIKzrK4RHZgs449B+hbqcejb8wb96vws59C9JeqLhHMiya0
 +iyqxAhmTl3Zw==
Received: from fedora1.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id C1CF617E0ACE;
 Thu, 19 Nov 2026 09:51:24 +0100 (CET)
Date: Thu, 19 Nov 2026 09:51:20 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Christian Gmeiner <christian.gmeiner@gmail.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Daniel Almeida
 <daniel.almeida@collabora.com>, Alice Ryhl <aliceryhl@google.com>, Lukas
 Zapolskas <lukas.zapolskas@arm.com>, Paul Toadere <paul.toadere@arm.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, Christian Gmeiner <cgmeiner@igalia.com>
Subject: Re: [PATCH v2 3/3] drm/panthor: Bump the driver version to 1.10
Message-ID: <20261119095120.1e3fc816@fedora1.home>
In-Reply-To: <20261104-panthor-fault-info-v2-v2-3-673b31f3840c@igalia.com>
References: <20261104-panthor-fault-info-v2-v2-0-673b31f3840c@igalia.com>
 <20261104-panthor-fault-info-v2-v2-3-673b31f3840c@igalia.com>
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

On Wed, 04 Nov 2026 08:52:41 +0100
Christian Gmeiner <christian.gmeiner@gmail.com> wrote:

> From: Christian Gmeiner <cgmeiner@igalia.com>
> 
> VM_GET_STATE now reports the last VM fault and GROUP_GET_STATE reports
> the fatal error of each queue. Bump the driver version so userspace
> can detect this.
> 
> Signed-off-by: Christian Gmeiner <cgmeiner@igalia.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/gpu/drm/panthor/panthor_drv.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
> index fb5fdf848dec..139654628ec4 100644
> --- a/drivers/gpu/drm/panthor/panthor_drv.c
> +++ b/drivers/gpu/drm/panthor/panthor_drv.c
> @@ -1803,6 +1803,8 @@ static void panthor_debugfs_init(struct drm_minor *minor)
>   * - 1.8 - extends DEV_QUERY_TIMESTAMP_INFO with flags
>   * - 1.9 - adds DRM_PANTHOR_DEV_QUERY_MMU_INFO query
>   *       - adds DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE flag
> + * - 1.10 - extends VM_GET_STATE with the last unhandled VM fault
> + *        - extends GROUP_GET_STATE with the fatal error of each queue
>   */
>  static const struct drm_driver panthor_drm_driver = {
>  	.driver_features = DRIVER_RENDER | DRIVER_GEM | DRIVER_SYNCOBJ |
> @@ -1816,7 +1818,7 @@ static const struct drm_driver panthor_drm_driver = {
>  	.name = "panthor",
>  	.desc = "Panthor DRM driver",
>  	.major = 1,
> -	.minor = 9,
> +	.minor = 10,
>  
>  	.gem_prime_import_sg_table = panthor_gem_prime_import_sg_table,
>  	.gem_prime_import = panthor_gem_prime_import,
> 

