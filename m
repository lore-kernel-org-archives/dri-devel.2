Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41B2606A338
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 07:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=XNwc6StZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22BC410FE83;
	Thu, 19 Nov 2026 07:54:08 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93B2110FE9F
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 07:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1795074840;
 bh=di0FOOFE9q35E6AbXQ3gtJ/Cz8uAkbqsswRSlzs0W2Q=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=XNwc6StZlTqHvAsEOU6EcCkrKtppPA6ecjqKA5I6k0vSlk9v/rbjVFMGlTts/wTRY
 FE1wmSPBXjsWzlnbpxAz3+YIE0YQ20JYdUZ69v2o0vMQzJEc2SqFIGokD96E79vWGw
 K723Jj3Fk2M+xok1Zi8+1Z6oz5rCfxOoJU6aMxBQWIXxf3JJCW5ZrrToTy0Bu8uiMm
 lPg8h9myuTItxpNyf8kImw+0TRKpMxLF+31PN5oyY37dAmLgU8Qfx3kw+xMNFcOXUf
 r63lfm7x2icpA9j4MFYgBkVUL/LVjOID9J/6quUQpwm1ylnxyzzAtwAaYrjgQc9W37
 eg+eIpQsjr4Lw==
Received: from fedora1.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id CDE4E17E052F;
 Thu, 19 Nov 2026 08:53:59 +0100 (CET)
Date: Thu, 19 Nov 2026 08:53:56 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Karunika Choo <karunika.choo@arm.com>
Cc: dri-devel@lists.freedesktop.org, nd@arm.com, Steven Price
 <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 linux-kernel@vger.kernel.org, Akash Goel <akash.goel@arm.com>, Lukas
 Zapolskas <lukas.zapolskas@arm.com>, Chris Diamand <chris.diamand@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Subject: Re: [PATCH v3 04/10] drm/panthor: Parse and store GPU_ID fields
Message-ID: <20261119085356.42a7cb13@fedora1.home>
In-Reply-To: <20261118175332.519657-5-karunika.choo@arm.com>
References: <20261118175332.519657-1-karunika.choo@arm.com>
 <20261118175332.519657-5-karunika.choo@arm.com>
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

On Wed, 18 Nov 2026 17:53:20 +0000
Karunika Choo <karunika.choo@arm.com> wrote:

> Prepare for Mali v15, where GPU_ID expands to 64 bits and its field
> layout changes.
> 
> Introduce a small panthor_gpu_id structure and parse the GPU_ID fields
> once during hardware initialization. Convert existing users to consume
> the cached fields instead of extracting them repeatedly from the raw
> register value.
> 
> This centralizes GPU_ID decoding and makes it easier to support both the
> existing and v15 formats.
> 
> Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
> Signed-off-by: Karunika Choo <karunika.choo@arm.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
> v2:
> - Picked up R-b from Liviu
> - Avoid modifying the printed id field for existing GPUs.
> - Link: https://lore.kernel.org/all/20260922205659.3C4F21F000FF@smtp.kernel.org/
> v1:
> - changed struct panthor_gpu_id into a flat structure instead of
>   inconsistent groupings.
> 
>  drivers/gpu/drm/panthor/panthor_device.h | 29 ++++++++++++++++++++++++
>  drivers/gpu/drm/panthor/panthor_fw.c     |  4 ++--
>  drivers/gpu/drm/panthor/panthor_gpu.c    |  2 +-
>  drivers/gpu/drm/panthor/panthor_hw.c     | 24 ++++++++++++++------
>  drivers/gpu/drm/panthor/panthor_hw.h     |  4 ++--
>  5 files changed, 51 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
> index 4add31b12cfd7..f0a96ff0f13da 100644
> --- a/drivers/gpu/drm/panthor/panthor_device.h
> +++ b/drivers/gpu/drm/panthor/panthor_device.h
> @@ -111,6 +111,32 @@ struct panthor_irq {
>  	enum panthor_irq_state state;
>  };
>  
> +/**
> + * struct panthor_gpu_id - Parsed GPU_ID fields
> + */
> +struct panthor_gpu_id {
> +	/** @arch_major: Architecture major revision */
> +	u8 arch_major;
> +
> +	/** @arch_minor: Architecture minor revision */
> +	u8 arch_minor;
> +
> +	/** @arch_rev: Architecture patch revision */
> +	u8 arch_rev;
> +
> +	/** @prod_major: Product identifier */
> +	u8 prod_major;
> +
> +	/** @ver_major: Major release version number */
> +	u8 ver_major;
> +
> +	/** @ver_minor: Minor release version number */
> +	u8 ver_minor;
> +
> +	/** @ver_status: Status of GPU release */
> +	u8 ver_status;
> +};
> +
>  /**
>   * enum panthor_device_profiling_mode - Profiling state
>   */
> @@ -170,6 +196,9 @@ struct panthor_device {
>  	/** @mmu_info: MMU info */
>  	struct drm_panthor_mmu_info mmu_info;
>  
> +	/** @gpu_id: Parsed GPU_ID fields */
> +	struct panthor_gpu_id gpu_id;
> +
>  	/** @hw: GPU-specific data. */
>  	struct panthor_hw *hw;
>  
> diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
> index 4f1fab66a13bf..13efed3a2ea72 100644
> --- a/drivers/gpu/drm/panthor/panthor_fw.c
> +++ b/drivers/gpu/drm/panthor/panthor_fw.c
> @@ -809,8 +809,8 @@ static int panthor_fw_load(struct panthor_device *ptdev)
>  	int ret;
>  
>  	snprintf(fw_path, sizeof(fw_path), "arm/mali/arch%d.%d/%s",
> -		 (u32)GPU_ARCH_MAJOR(ptdev->gpu_info.gpu_id),
> -		 (u32)GPU_ARCH_MINOR(ptdev->gpu_info.gpu_id),
> +		 (u32)ptdev->gpu_id.arch_major,
> +		 (u32)ptdev->gpu_id.arch_minor,
>  		 CSF_FW_NAME);
>  
>  	ret = request_firmware(&fw, fw_path, ptdev->base.dev);
> diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/panthor/panthor_gpu.c
> index b8df5663f04e4..c5c37f22993d6 100644
> --- a/drivers/gpu/drm/panthor/panthor_gpu.c
> +++ b/drivers/gpu/drm/panthor/panthor_gpu.c
> @@ -74,7 +74,7 @@ static void panthor_gpu_l2_config_set(struct panthor_device *ptdev)
>  	if (!data || !data->asn_hash_enable)
>  		return;
>  
> -	if (GPU_ARCH_MAJOR(ptdev->gpu_info.gpu_id) < 11) {
> +	if (ptdev->gpu_id.arch_major < 11) {
>  		drm_err(&ptdev->base, "Custom ASN hash not supported by the device");
>  		return;
>  	}
> diff --git a/drivers/gpu/drm/panthor/panthor_hw.c b/drivers/gpu/drm/panthor/panthor_hw.c
> index 34dc4b9d9dc09..854874a9f322a 100644
> --- a/drivers/gpu/drm/panthor/panthor_hw.c
> +++ b/drivers/gpu/drm/panthor/panthor_hw.c
> @@ -119,9 +119,9 @@ void panthor_hw_power_status_unregister(void)
>  
>  static char *get_gpu_model_name(struct panthor_device *ptdev)
>  {
> -	const u32 gpu_id = ptdev->gpu_info.gpu_id;
> -	const u32 product_id = GPU_PROD_ID_MAKE(GPU_ARCH_MAJOR(gpu_id),
> -						GPU_PROD_MAJOR(gpu_id));
> +	const struct panthor_gpu_id *gpu_id = &ptdev->gpu_id;
> +	const u32 product_id = GPU_PROD_ID_MAKE(gpu_id->arch_major,
> +						gpu_id->prod_major);
>  	const bool ray_intersection = !!(ptdev->gpu_info.gpu_features &
>  					 GPU_FEATURES_RAY_INTERSECTION);
>  	const u8 shader_core_count = hweight64(ptdev->gpu_info.shader_present);
> @@ -245,9 +245,9 @@ static int panthor_hw_info_init(struct panthor_device *ptdev)
>  	if (ret)
>  		return ret;
>  
> -	major = GPU_VER_MAJOR(ptdev->gpu_info.gpu_id);
> -	minor = GPU_VER_MINOR(ptdev->gpu_info.gpu_id);
> -	status = GPU_VER_STATUS(ptdev->gpu_info.gpu_id);
> +	major = ptdev->gpu_id.ver_major;
> +	minor = ptdev->gpu_id.ver_minor;
> +	status = ptdev->gpu_id.ver_status;
>  
>  	drm_info(&ptdev->base,
>  		 "%s id 0x%x major 0x%x minor 0x%x status 0x%x",
> @@ -273,7 +273,7 @@ static int panthor_hw_info_init(struct panthor_device *ptdev)
>  static int panthor_hw_bind_device(struct panthor_device *ptdev)
>  {
>  	struct panthor_hw *hdev = NULL;
> -	const u32 arch_major = GPU_ARCH_MAJOR(ptdev->gpu_info.gpu_id);
> +	const u32 arch_major = ptdev->gpu_id.arch_major;
>  	int i = 0;
>  
>  	for (i = 0; i < ARRAY_SIZE(panthor_hw_match); i++) {
> @@ -295,10 +295,20 @@ static int panthor_hw_bind_device(struct panthor_device *ptdev)
>  
>  static int panthor_hw_gpu_id_init(struct panthor_device *ptdev)
>  {
> +	struct panthor_gpu_id *gpu_id = &ptdev->gpu_id;
>  	ptdev->gpu_info.gpu_id = gpu_read(ptdev->iomem, GPU_ID);
> +
>  	if (!ptdev->gpu_info.gpu_id)
>  		return -ENXIO;
>  
> +	gpu_id->arch_major = GPU_ARCH_MAJOR(ptdev->gpu_info.gpu_id);
> +	gpu_id->arch_minor = GPU_ARCH_MINOR(ptdev->gpu_info.gpu_id);
> +	gpu_id->arch_rev = GPU_ARCH_REV(ptdev->gpu_info.gpu_id);
> +	gpu_id->prod_major = GPU_PROD_MAJOR(ptdev->gpu_info.gpu_id);
> +	gpu_id->ver_major = GPU_VER_MAJOR(ptdev->gpu_info.gpu_id);
> +	gpu_id->ver_minor = GPU_VER_MINOR(ptdev->gpu_info.gpu_id);
> +	gpu_id->ver_status = GPU_VER_STATUS(ptdev->gpu_info.gpu_id);
> +
>  	return 0;
>  }
>  
> diff --git a/drivers/gpu/drm/panthor/panthor_hw.h b/drivers/gpu/drm/panthor/panthor_hw.h
> index f770dc40e6216..c4a490bc39de6 100644
> --- a/drivers/gpu/drm/panthor/panthor_hw.h
> +++ b/drivers/gpu/drm/panthor/panthor_hw.h
> @@ -58,12 +58,12 @@ static inline void panthor_hw_l2_power_off(struct panthor_device *ptdev)
>  
>  static inline bool panthor_hw_has_pwr_ctrl(struct panthor_device *ptdev)
>  {
> -	return GPU_ARCH_MAJOR(ptdev->gpu_info.gpu_id) >= 14;
> +	return ptdev->gpu_id.arch_major >= 14;
>  }
>  
>  static inline bool panthor_hw_has_neural(struct panthor_device *ptdev)
>  {
> -	return (GPU_ARCH_MAJOR(ptdev->gpu_info.gpu_id) >= 14 &&
> +	return (ptdev->gpu_id.arch_major >= 14 &&
>  		ptdev->gpu_info.gpu_features & GPU_FEATURES_NX);
>  }
>  

