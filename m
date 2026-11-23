Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96480606A327
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 14:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=DxjhmWRd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B281610EE82;
	Mon, 23 Nov 2026 14:31:04 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id A775D10EE82
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 14:30:58 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 28A01143D;
 Mon, 23 Nov 2026 06:30:55 -0800 (PST)
Received: from [10.57.63.212] (unknown [10.57.63.212])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A9A903F632;
 Mon, 23 Nov 2026 06:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1795444258; bh=xOUAg1fyT1SZ0PS2uIQRQByBhSfnOvlInpF7l4hI1f4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=DxjhmWRdLEzvpWkMv9DOWhOqgMMYGGjw8eHCCUWWwsXZGmVOkHsmx7Gp59N4PQDKB
 qxUIDP+YlvbZGO+NnobexxUAAtX3yAip/YYuxj2vsOUjxxtGh0zp2lUE+Cbfk+NWUq
 /M3IyxSnPZjqcZocZw4fvObjTbDuI8hUqWlCmpgc=
Message-ID: <9906d872-8e9c-46cf-b365-9f2d6ff0d61d@arm.com>
Date: Mon, 23 Nov 2026 14:30:51 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/8] drm/panthor: Add performance counter uAPI
To: Lukas Zapolskas <lukas.zapolskas@arm.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Alice Ryhl <aliceryhl@google.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 nd@arm.com, Mihail Atanassov <mihail.atanassov@arm.com>
References: <20261011-panthor-performance-counters-v7-0-12c32495062f@arm.com>
 <20261011-panthor-performance-counters-v7-1-12c32495062f@arm.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20261011-panthor-performance-counters-v7-1-12c32495062f@arm.com>
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
> This patch extends the DEV_QUERY ioctl to return information about the
> performance counter setup for userspace, and introduces the new
> DRM_PANTHOR_PERF_SESSION ioctls in order to allow for the sampling of
> performance counters.
> 
> The new design is inspired by the perf aux ringbuffer [0], with the
> insert and extract indices being mapped to userspace, allowing
> multiple samples to be exposed at any given time. The buffer is
> annotated to include sample metadata and block metadata inline with
> the elements they describe.
> 
> Userspace is responsible for passing in resources for samples to be
> exposed, including the event file descriptor for notification of new
> sample availability, the ringbuffer BO to store samples, and the
> control BO.
> 
> [0]: https://docs.kernel.org/userspace-api/perf_ring_buffer.html
> 
> Co-developed-by: Mihail Atanassov <mihail.atanassov@arm.com>
> Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
> Signed-off-by: Lukas Zapolskas <lukas.zapolskas@arm.com>

I think we need a little more documentation on how these new ioctls
work. Ideally you shouldn't need to dig through the code to figure this out.

E.g. DRM_PANTHOR_PERF_SESSION_CREATE apparently returns a session handle
- but that's not mentioned anywhere here. There's also no information on
the range that session handles can take. Again digging through the code
it appears that <0 is an error but >=0 is valid. Although digging harder
it seems like in the current implementation only 0 is actually returned?

You also have a shared "control BO" but there's no information about
memory barriers. It would be good to document what user space is
required to do between reading the insert_idx, reading the samples and
writing extract_idx.

One more minor point below...

> ---
>  include/uapi/drm/panthor_drm.h | 370 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 370 insertions(+)
> 
> diff --git a/include/uapi/drm/panthor_drm.h b/include/uapi/drm/panthor_drm.h
> index a2ff0f4ec691..e45f75b76245 100644
> --- a/include/uapi/drm/panthor_drm.h
> +++ b/include/uapi/drm/panthor_drm.h

[...]

> +/**
> + * struct drm_panthor_perf_session_create - Arguments passed to DRM_PANTHOR_PERF_SESSION_CREATE.
> + */
> +struct drm_panthor_perf_session_create {
> +	/**
> +	 * @block_set: Set of performance counter blocks, member of
> +	 *             enum drm_panthor_perf_counter_set.
> +	 *
> +	 * This is a global configuration and only one set can be active at a time. If
> +	 * another client has already requested a counter set, any further requests
> +	 * for a different counter set will fail and return an -EBUSY.
> +	 *
> +	 * If the requested set does not exist, the request will fail and return an -EINVAL.
> +	 *
> +	 * Some sets have additional requirements to be enabled, and the setup request will
> +	 * fail with an -EACCES if these requirements are not satisfied.
> +	 */
> +	__u8 block_set;
> +
> +	/** @pad: MBZ. */
> +	__u8 pad[7];
> +
> +	/** @fd: eventfd for signalling the availability of a new sample. */
> +	__u32 fd;
> +
> +	/** @ringbuf_handle: Handle to the BO to write perf counter sample to. */
> +	__u32 ringbuf_handle;
> +
> +	/**
> +	 * @control_handle: Handle to the BO containing a contiguous 16 byte range, used for the
> +	 * insert and extract indices for the ringbuffer.
> +	 */
> +	__u32 control_handle;
> +
> +	/**
> +	 * @sample_slots: The number of slots available in the userspace-provided BO. Must be
> +	 * a power of 2.
> +	 *
> +	 * If sample_slots * sample_size does not match the BO size, the setup request will fail.

Actually the BO size must be PFN_ALIGN(sample_slots * sample_size) -
i.e. rounded up to the nearest page size. I also wonder if this will
come back to bite us if we ever have to deal with multiple page sizes.
Is there a reason to enforce exact sizing rather than just 'big enough'?

Thanks,
Steve

