Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F747606A319
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 08:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=VtLboRQT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BA7210E121;
	Wed, 21 Oct 2026 08:28:29 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A36FC10E121
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 08:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1792571301;
 bh=wKjtnD396Woq3DWe1OJMEf7zfBjvDYFqy6fP3r3ECXw=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=VtLboRQT65bjASJEg53VUke7m8prr1Ad80lIhheRtD6A/Qy4kcVg1ZfLhGuhnBN5y
 EClKje4l5ZpL/o7UORux9JHDMRKlq6GTaqDaMqmSWTeiuCOqqE8DZpn+aL08/QRUC5
 CESyZ7VsmJofefBpf10CIEU2sujP7I73Lkn7vXTTH27maf8yt01dxfoLVeY/Zjel8O
 wm8Q2qTMabqDuHRQErn27+ezeiB/b3knTfLdYreAqjX04d4MyjOz1TAOdXrXqvC6CK
 jGL0aZLnZbITUi4pEX5HCqx2qXi2bc+pWBCKHP+rHh9zrB82DgmAWwB3gL3xGAIt6n
 oIDVl+5AJifqQ==
Received: from fedora-21.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id B10B117E04B2;
 Wed, 21 Oct 2026 10:28:20 +0200 (CEST)
Date: Wed, 21 Oct 2026 10:28:15 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Ketil Johnsen <ketil.johnsen@arm.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Daniel Almeida
 <daniel.almeida@collabora.com>, Alice Ryhl <aliceryhl@google.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 03/12] drm/panthor: Pass drm_file instead of
 panthor_file
Message-ID: <20261021102815.2c312014@fedora-21.home>
In-Reply-To: <20261012125940.3291951-4-ketil.johnsen@arm.com>
References: <20261012125940.3291951-1-ketil.johnsen@arm.com>
 <20261012125940.3291951-4-ketil.johnsen@arm.com>
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
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 12 Oct 2026 14:59:31 +0200
Ketil Johnsen <ketil.johnsen@arm.com> wrote:

> From: Boris Brezillon <boris.brezillon@collabora.com>
> 
> Some sched helpers need info that are part of drm_file, and we will
> soon need to call drm_gem_object_lookup() from panthor_group_create().
> Let's prepare for that by passing a drm_file instead of panthor_file to
> all current helpers taking a panthor_file, so we keep things consistent.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> Co-developed-by: Ketil Johnsen <ketil.johnsen@arm.com>
> Signed-off-by: Ketil Johnsen <ketil.johnsen@arm.com>
> 
> ---
> 
> v3:
> - Fixed incorrect parameter passed to panthor_gpu_show_fdinfo()

Test bot reported a bunch of kernel docs to fix to match some of the
new prototypes.
