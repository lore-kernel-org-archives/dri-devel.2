Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93DC606A31F
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 15:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=EJ/+0Trp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 110EC10EF03;
	Mon, 23 Nov 2026 15:11:13 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id A3F4410EF02
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 15:11:06 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 58E7619F0;
 Mon, 23 Nov 2026 07:11:03 -0800 (PST)
Received: from [10.57.63.212] (unknown [10.57.63.212])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7EB193F632;
 Mon, 23 Nov 2026 07:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1795446666; bh=IpSqJ4KJv0CHrLNqzVscN5CM6p8mgmVvtxNtKC0YMYI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=EJ/+0TrpY//IlNkmSNPKdVi4fCItrGqq5rKJ+9KvLZEMdtVffCGcXw3prJVD+kE9h
 25tqfBvu8sp0mkSzFHPpE9ves6yzxuyeD6rAakncFrixvPiBlMFLJbliV+KxZLJU2X
 5n5Zdjow47cEE8pZ15uufNt7C77oKdlVguc94I6w=
Message-ID: <4265cf08-2b1d-4b06-be25-5039b6bb6f42@arm.com>
Date: Mon, 23 Nov 2026 15:11:01 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 5/8] drm/panthor: Introduce sampling sessions to handle
 userspace clients
To: Lukas Zapolskas <lukas.zapolskas@arm.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Alice Ryhl <aliceryhl@google.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, nd@arm.com
References: <20261011-panthor-performance-counters-v7-0-12c32495062f@arm.com>
 <20261011-panthor-performance-counters-v7-5-12c32495062f@arm.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20261011-panthor-performance-counters-v7-5-12c32495062f@arm.com>
Content-Type: text/plain; charset=UTF-8
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
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/10/2026 18:36, Lukas Zapolskas wrote:
> To allow for combining the requests from multiple userspace clients,
> an intermediary layer between the HW/FW interfaces and userspace is
> created, containing the information for the counter requests and
> tracking of insert and extract indices. Each session starts inactive
> and must be explicitly activated via PERF_SESSION_START and
> explicitly stopped via PERF_SESSION_STOP. Userspace identifies a
> single client with its session ID and the panthor file it is
> associated with.
> 
> The SAMPLE and STOP commands both produce a single sample when called,
> and these samples can be disambiguated via the opaque user data field
> passed in the PERF_SESSION uAPI. If this functionality is not desired,
> these fields can be kept as zero, as the kernel copies this value into
> the corresponding sample without attempting to interpret it.
> 
> Currently, only manual sampling sessions are supported, providing
> samples when userspace calls PERF_CONTROL_SAMPLE, and only a single
> session is allowed at a time. Multiple sessions and periodic sampling
> will be enabled in following patches.
> 
> No protection is provided against the 32-bit hardware counter
> overflows, so for the moment it is up to userspace to ensure that
> the counters are sampled at a reasonable frequency.
> 
> Signed-off-by: Lukas Zapolskas <lukas.zapolskas@arm.com>
> ---
>  drivers/gpu/drm/panthor/panthor_perf.c | 657 ++++++++++++++++++++++++++++++++-
>  drivers/gpu/drm/panthor/panthor_perf.h |  11 +
>  2 files changed, 664 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_perf.c b/drivers/gpu/drm/panthor/panthor_perf.c
> index ba466e22c50d..76c346981150 100644
> --- a/drivers/gpu/drm/panthor/panthor_perf.c
> +++ b/drivers/gpu/drm/panthor/panthor_perf.c

[...]

> +/**
> + * panthor_perf_session_create - Create a user-visible session.
> + *
> + * @file: DRM file associated with the request.
> + * @create_args: Creation arguments passed in via ioctl.
> + * @sid: Session identifier output.
> + *
> + * Creates a new session associated with the session ID returned. When initialized, the
> + * session must explicitly request sampling to start with a successive call to PERF_SESSION_START.
> + *
> + * Return: 0 on success, negative error code on failure.
> + */
> +int panthor_perf_session_create(struct drm_file *file,
> +				struct drm_panthor_perf_session_create *create_args,
> +				unsigned long *sid)
> +{
> +	struct panthor_file *pfile = file->driver_priv;
> +	struct panthor_device *ptdev = pfile->ptdev;
> +	struct panthor_perf_bo ringbuffer = {}, control = {};
> +	const size_t slots = create_args->sample_slots;
> +	struct panthor_perf_pool *pool = pfile->sessions;
> +	struct panthor_perf_session *session;
> +	struct panthor_perf_enable_masks *em;
> +	size_t user_sample_size;
> +	u32 session_id;
> +	int ret;
> +
> +	if (!ptdev->perf)
> +		return -EOPNOTSUPP;
> +
> +	if (!pool)
> +		return -EINVAL;
> +
> +	if (!perfmon_capable())
> +		return -EACCES;

This requirement isn't mentioned in the uAPI.

I also don't see any validation of "block_set". And I think the check
the padding should be moved here rather than hidden in
panthor_ioctl_perf_session_create().

> +
> +	session = kzalloc_obj(*session);
> +	if (ZERO_OR_NULL_PTR(session))
> +		return -ENOMEM;
> +
> +	if (!is_power_of_2(slots)) {
> +		drm_err(&ptdev->base,
> +			"Number of slots is not power-of-2 aligned\n");
> +		ret = -EINVAL;
> +		goto cleanup_session;
> +	}
> +
> +	user_sample_size = ptdev->perf_info.sample_size * slots;

create_args->sample_slots (slots) is user supplied and I believe this
could overflow (on a 32 bit system). Specifically 1 << 31 (as this has
to be power-of-2).

Thanks,
Steve

