Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29147606A31A
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 08:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=fK8XeHWi
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BC8310FC74;
	Wed, 21 Oct 2026 08:35:16 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3C6A10FC74
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 08:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1792571708;
 bh=UNMzNdSJ1jQYOZWHW+9R2rXUtTmKqb+0DXMYwW9GLZ8=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=fK8XeHWi1Yss47HrUDxKYtxdkcrstJ1znpAmGWlcseetbOrr+SgnNjYGB7Jq2Y0mO
 JKMtoVkXfWCl9tL5cKOt1670V9lp07bETwSVJmMJIBHI6Cop0yGXCXpuhM5GWrd4+Z
 8TG97txhE/WmTai9G+KyyYIL+dgJRdHpOiaf//g6T+ni59jQzQs72wLVo4+j8B1Zxn
 CTrC3Gf30ULT+M9eIee9K4eIBYDuJ5yRlseo80yvqcxgYlfKnN+Pzi4z25c/RtvEwG
 3DgprH13tBfS8jLI/Rqdu0n5JP80zdesRbGVsM4/OG4cJYPFHUCbVObYaS/KeoOCkb
 c5PmnxF8uOj5w==
Received: from fedora-21.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 2220417E053E;
 Wed, 21 Oct 2026 10:35:08 +0200 (CEST)
Date: Wed, 21 Oct 2026 10:35:01 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Ketil Johnsen <ketil.johnsen@arm.com>, Simona Vetter <simona@ffwll.ch>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Daniel Almeida <daniel.almeida@collabora.com>, Alice
 Ryhl <aliceryhl@google.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 08/12] drm/panthor: Refactor GEM usage flags assignment
Message-ID: <20261021103501.14368b3d@fedora-21.home>
In-Reply-To: <20261012125940.3291951-9-ketil.johnsen@arm.com>
References: <20261012125940.3291951-1-ketil.johnsen@arm.com>
 <20261012125940.3291951-9-ketil.johnsen@arm.com>
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

On Mon, 12 Oct 2026 14:59:36 +0200
Ketil Johnsen <ketil.johnsen@arm.com> wrote:

> -static void panthor_gem_debugfs_set_usage_flags(struct panthor_gem_object *bo, u32 usage_flags)
> +static void panthor_gem_debugfs_add_usage_flags(struct panthor_gem_object *bo,
> +						u32 usage_flags)

nit: Limit has been bumped to a 100 characters per line, so let's keep
the prototype on a single line.

>  {
> -	bo->debugfs.flags = usage_flags;
> -	panthor_gem_debugfs_bo_add(bo);
> +	atomic_or(usage_flags, &bo->debugfs.flags);
>  }
>  #else
> +static void panthor_gem_debugfs_bo_add(struct panthor_gem_object *bo) {}
>  static void panthor_gem_debugfs_bo_rm(struct panthor_gem_object *bo) {}
> -static void panthor_gem_debugfs_set_usage_flags(struct panthor_gem_object *bo, u32 usage_flags) {}
> +static void panthor_gem_debugfs_add_usage_flags(struct panthor_gem_object *bo,
> +						u32 usage_flags) {}

Ditto. And if we were to have multiple lines, I'd recommend:

static void panthor_gem_debugfs_add_usage_flags(structpanthor_gem_object *bo,
						u32 usage_flags)
{
}
