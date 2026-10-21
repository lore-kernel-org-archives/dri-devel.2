Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D06606A319
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 08:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=Ni7P0SV6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC28510FCDA;
	Wed, 21 Oct 2026 08:53:50 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 054B210FCDA
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 08:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1792572817;
 bh=PkwlSzbz8P6ZSz8WrazPkXGKVJqW6KJvPomjVLz2kv0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Ni7P0SV6aQjnauvZivtCIzkrLsxC/E0m4S597C9IJ2s5NRxKBt0cB3tJHjEZbkQMe
 bRqF8jLxJQH9JAHgBXBZ8UCf2/VL1PlsDxYVNH192hA0Iq81qofhok8BzHnGZgohvT
 c86zL37WUXWrMaAaFwmO8+ph6hbd6hdFdISQnyY48uXaRwZXuot46YxuX060REHvAM
 CBcdd3XOMSlhZdiB5Gt9eI66jY/6t2u1m4vvBdjlZczWlNcF/gtFTTh3jdqEYClsZg
 WNo/5dJWNsrosZYu9kFMwaWIqwVJSMBcyvPxUZJPDux4FQ8cQQVAXrKOPiyyVPHTCU
 lTZm2/XSyVC5g==
Received: from fedora-21.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id A2D1F17E053E;
 Wed, 21 Oct 2026 10:53:36 +0200 (CEST)
Date: Wed, 21 Oct 2026 10:53:31 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Ketil Johnsen <ketil.johnsen@arm.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Daniel Almeida
 <daniel.almeida@collabora.com>, Alice Ryhl <aliceryhl@google.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 10/12] drm/panthor: Support FW init of protm
Message-ID: <20261021105331.1e43030f@fedora-21.home>
In-Reply-To: <20261012125940.3291951-11-ketil.johnsen@arm.com>
References: <20261012125940.3291951-1-ketil.johnsen@arm.com>
 <20261012125940.3291951-11-ketil.johnsen@arm.com>
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
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 12 Oct 2026 14:59:38 +0200
Ketil Johnsen <ketil.johnsen@arm.com> wrote:

> +int panthor_fw_protm_init(struct drm_file *file,
> +			  struct drm_panthor_protm_init *args)
> +{
> +	struct panthor_file *pfile = file->driver_priv;
> +	struct panthor_device *ptdev = pfile->ptdev;
> +	struct panthor_fw_section *protm_section = ptdev->fw->protm_section;
> +	struct drm_gem_object *obj;
> +	u32 vm_map_flags;
> +	int cookie, ret = 0;
> +
> +	if (!capable(CAP_SYS_MODULE))
> +		return -EPERM;
> +
> +	if (args->pad)
> +		return -EINVAL;
> +
> +	if (!protm_section || !protm_section->size)
> +		return -EINVAL;
> +
> +	guard(mutex)(&ptdev->fw->protm_init_lock);
> +
> +	/* Thread safe access so other readers do not need protm_init_lock */
> +	if (smp_load_acquire(&ptdev->protm.info.state) &
> +	    DRM_PANTHOR_PROTM_INITIALIZED)
> +		return 0;

Why not force the query to be done with the lock held instead? Querying
the PROTM state is not a hot path, so the lockless approach feels
overkill to me. If the problem is that the lock is not visible from
ptdev, then I'd argue the ptdev->protm.info shouldn't be either,
because it's not initialized at probe time. What we should have instead
is a panthor_fw_query_protm_info() helper return/filling
drm_panthor_protm_info.

> +
> +	if (!drm_dev_enter(&ptdev->base, &cookie))
> +		return -ENODEV;
> +
> +	obj = drm_gem_object_lookup(file,
> +				    args->fw_protected_sections_bo_handle);
> +	if (!obj) {
> +		ret = -ENOENT;
> +		goto out_dev_exit;
> +	}
> +
> +	if (obj->size < ptdev->protm.info.fw_protected_sections_size) {
> +		ret = -EINVAL;
> +		goto out_gem_put;
> +	}
> +
> +	vm_map_flags = section_vm_map_flags(protm_section);
> +
> +	protm_section->mem = panthor_kernel_bo_create_from_gem(
> +		ptdev, panthor_fw_vm(ptdev), to_panthor_bo(obj), vm_map_flags,
> +		protm_section->va, protm_section->size);
> +	if (IS_ERR(protm_section->mem)) {
> +		ret = PTR_ERR(protm_section->mem);
> +		protm_section->mem = NULL;
> +		goto out_gem_put;
> +	}
> +
> +	/* Make sure all above is completed before we update state */
> +	smp_store_release(&ptdev->protm.info.state,
> +			  DRM_PANTHOR_PROTM_INITIALIZED);
> +
> +out_gem_put:
> +	drm_gem_object_put(obj);
> +
> +out_dev_exit:
> +	drm_dev_exit(cookie);
> +	return ret;
> +}
