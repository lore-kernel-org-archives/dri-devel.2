Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29D2606A339
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 16:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=HFo2P2Fd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 542C110E140;
	Tue, 20 Oct 2026 16:11:57 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3238B10E140
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 16:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1792512709;
 bh=Q0MQtpNvKhTdiak4Qcjs/BaXrpGN3n3rOuZvvFZbMX4=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=HFo2P2FdNEkweM8VltiK6p8zl6mdlrSK6sjVjVYkOlbJn3D/hopbhz/YlkTq2xHF9
 g/ujnwmrqSYzF8kzghyKumW2ZEeml2ZlegvMqMJVUnNmtOCeZA4JKNK3xrOWLgtC7a
 /QVj9z+SPlzyop10XY8jA6F7MIpXRDXX5DOqzTurecE0lZiOejTBV6MugW/DQgfO8t
 HlGfc3Tzn7CQqsf483onpggiCHU/O1KXe/kGCy/vvoXwD5CZgBdVYWn1hlk235FGmy
 0QsI+Q888ofsrEBcHtbLd4zZ7tN2EOyHNmaqyJxv/2+8qEBzle1H/Il15LGzUSG4Gp
 OVG2OB/N0no9w==
Received: from fedora-21.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 11E7F17E0048;
 Tue, 20 Oct 2026 18:11:49 +0200 (CEST)
Date: Tue, 20 Oct 2026 18:11:44 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Ketil Johnsen <ketil.johnsen@arm.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Daniel Almeida
 <daniel.almeida@collabora.com>, Alice Ryhl <aliceryhl@google.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Florent
 Tomasin <florent.tomasin@arm.com>, Paul Toadere <paul.toadere@arm.com>,
 Samuel Percival <samuel.percival@arm.com>
Subject: Re: [PATCH v4 05/12] drm/panthor: Add support for entering and
 exiting protected mode
Message-ID: <20261020181144.2c8aa6ff@fedora-21.home>
In-Reply-To: <20261012125940.3291951-6-ketil.johnsen@arm.com>
References: <20261012125940.3291951-1-ketil.johnsen@arm.com>
 <20261012125940.3291951-6-ketil.johnsen@arm.com>
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

On Mon, 12 Oct 2026 14:59:33 +0200
Ketil Johnsen <ketil.johnsen@arm.com> wrote:

> +void panthor_mmu_protm_exit_event(struct panthor_device *ptdev)
> +{
> +	/* We left protected mode and scheduler is about to resume normal
> +	 * scheduling. Do the necessary cache operation so any page table
> +	 * updates we might have done during protm is correctly visible
> +	 * to the GPU.
> +	 */
> +	int ret;
> +
> +	guard(mutex)(&ptdev->mmu->as.slots_lock);
> +
> +	ptdev->mmu->as.delay_update_mask = 0;
> +
> +	if (!ptdev->mmu->as.delayed_update_mask)
> +		return;
> +
> +	ret = panthor_gpu_flush_caches(ptdev, CACHE_CLEAN | CACHE_INV,
> +				       CACHE_CLEAN | CACHE_INV, CACHE_INV);

I've been thinking about this a bit more, and I don't get why we need
to flush the caches here. If we assume that only one PROTM group is
resident when PROTM is entered, that means the other resident VMs are
idle until the other groups are resumed. My understanding is that we
have an automatic cache reset at the PROTM section boundaries to avoid
data leaks (invalidation of all caches), so why do we need an extra
flush here?

Tangentially to this, now that only one group is active in PROTM,
what's the benefit of keeping VMs on slot. Things don't get resumed
automatically, and I doubt the as_enable() is what takes time when
resuming the groups. If this new limitation stands (one group resident
when in PROTM), I'd rather simplify things to take advantage of this.


> +	if (ret)
> +		panthor_device_schedule_reset(ptdev);
> +}
