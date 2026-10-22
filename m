Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCEF606A319
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 12:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=X+tIRYLu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA754112534;
	Thu, 22 Oct 2026 12:15:31 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id A2582112534
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 12:15:25 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DDE0B2ECB
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 05:15:21 -0700 (PDT)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 C2F863F7B4
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 05:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1792671325; bh=BwJWT+22mrQR1yWB5Xgl/7uwWq/Yh+H3GpcLyKV/Wsg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=X+tIRYLucp9njILuMchZwr1lyhxYZE6/yOJllMoRzKhIiq4FETWJCm8hBWs7ejJD/
 /V6Nbb4Yc8ZFNuCUhgFURnBrpX19hdK5gPtPoxZaiiXJIm5TJC489cAPCyxkbr1ctk
 LvnMUMuOIjq3y7qkR5Zo0JtbYrDY6cWj/YjJO4yg=
Date: Thu, 22 Oct 2026 13:15:13 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Lukas Zapolskas <lukas.zapolskas@arm.com>
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
 Alice Ryhl <aliceryhl@google.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 nd@arm.com, Mihail Atanassov <mihail.atanassov@arm.com>
Subject: Re: [PATCH v7 1/8] drm/panthor: Add performance counter uAPI
Message-ID: <atn-Ue5pr6PrbMQW@e142607>
References: <20261011-panthor-performance-counters-v7-0-12c32495062f@arm.com>
 <20261011-panthor-performance-counters-v7-1-12c32495062f@arm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261011-panthor-performance-counters-v7-1-12c32495062f@arm.com>
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
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Oct 11, 2026 at 06:36:48PM +0100, Lukas Zapolskas wrote:
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
> ---
>  include/uapi/drm/panthor_drm.h | 370 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 370 insertions(+)
> 
> diff --git a/include/uapi/drm/panthor_drm.h b/include/uapi/drm/panthor_drm.h
> index a2ff0f4ec691..e45f75b76245 100644
> --- a/include/uapi/drm/panthor_drm.h
> +++ b/include/uapi/drm/panthor_drm.h
> @@ -154,6 +154,23 @@ enum drm_panthor_ioctl_id {
>  	 * This is useful for imported BOs.
>  	 */
>  	DRM_PANTHOR_BO_QUERY_INFO,
> +
> +	/** @DRM_PANTHOR_PERF_SESSION_CREATE: Create a performance counter session. */
> +	DRM_PANTHOR_PERF_SESSION_CREATE,
> +
> +	/** @DRM_PANTHOR_PERF_SESSION_START: Start a performance counter session. */
> +	DRM_PANTHOR_PERF_SESSION_START,
> +
> +	/** @DRM_PANTHOR_PERF_SESSION_SAMPLE: Request a manual sample on a performance counter
> +	 * session.
> +	 */
> +	DRM_PANTHOR_PERF_SESSION_SAMPLE,
> +
> +	/** @DRM_PANTHOR_PERF_SESSION_STOP: Stop a performance counter session. */
> +	DRM_PANTHOR_PERF_SESSION_STOP,
> +
> +	/** @DRM_PANTHOR_PERF_SESSION_DESTROY: Destroy a performance counter session. */
> +	DRM_PANTHOR_PERF_SESSION_DESTROY,
>  };
>  
>  /**
> @@ -256,6 +273,9 @@ enum drm_panthor_dev_query_type {
>  
>  	/** @DRM_PANTHOR_DEV_QUERY_MMU_INFO: Query MMU information. */
>  	DRM_PANTHOR_DEV_QUERY_MMU_INFO,
> +
> +	/** @DRM_PANTHOR_DEV_QUERY_PERF_INFO: Query performance counter interface information. */
> +	DRM_PANTHOR_DEV_QUERY_PERF_INFO,
>  };
>  
>  /**
> @@ -517,6 +537,93 @@ struct drm_panthor_group_priorities_info {
>  	__u8 pad[3];
>  };
>  
> +/**
> + * enum drm_panthor_perf_block_type - Performance counter supported block types.
> + */
> +enum drm_panthor_perf_block_type {
> +	/** @DRM_PANTHOR_PERF_BLOCK_METADATA: Internal use only. */
> +	DRM_PANTHOR_PERF_BLOCK_METADATA = 0,
> +
> +	/** @DRM_PANTHOR_PERF_BLOCK_FW: The FW counter block. */
> +	DRM_PANTHOR_PERF_BLOCK_FW,
> +
> +	/** @DRM_PANTHOR_PERF_BLOCK_CSHW: The CSHW counter block. */
> +	DRM_PANTHOR_PERF_BLOCK_CSHW,
> +
> +	/** @DRM_PANTHOR_PERF_BLOCK_TILER: The tiler counter block. */
> +	DRM_PANTHOR_PERF_BLOCK_TILER,
> +
> +	/** @DRM_PANTHOR_PERF_BLOCK_MEMSYS: A memsys counter block. */
> +	DRM_PANTHOR_PERF_BLOCK_MEMSYS,
> +
> +	/** @DRM_PANTHOR_PERF_BLOCK_SHADER: A shader core counter block. */
> +	DRM_PANTHOR_PERF_BLOCK_SHADER,
> +
> +	/** @DRM_PANTHOR_PERF_BLOCK_FIRST: Internal use only. */
> +	DRM_PANTHOR_PERF_BLOCK_FIRST = DRM_PANTHOR_PERF_BLOCK_FW,
> +
> +	/** @DRM_PANTHOR_PERF_BLOCK_LAST: Internal use only. */
> +	DRM_PANTHOR_PERF_BLOCK_LAST = DRM_PANTHOR_PERF_BLOCK_SHADER,
> +
> +	/** @DRM_PANTHOR_PERF_BLOCK_MAX: Internal use only. */
> +	DRM_PANTHOR_PERF_BLOCK_MAX = DRM_PANTHOR_PERF_BLOCK_LAST + 1,
> +};
> +
> +/**
> + * struct drm_panthor_perf_info - Performance counter interface information
> + *
> + * Structure grouping all queryable information relating to the performance counter
> + * interfaces.
> + */
> +struct drm_panthor_perf_info {
> +	/**
> +	 * @counters_per_block: The number of 8-byte counters available in a block.
> +	 */
> +	__u32 counters_per_block;
> +
> +	/**
> +	 * @sample_header_size: The size of the header struct available at the beginning
> +	 * of every sample.
> +	 */
> +	__u32 sample_header_size;
> +
> +	/**
> +	 * @block_header_size: The size of the header struct inline with the counters for a
> +	 * single block.
> +	 */
> +	__u32 block_header_size;
> +
> +	/**
> +	 * @sample_size: The size of a fully annotated sample, starting with a sample header
> +	 *               of size @sample_header_size bytes, and all available blocks for the current
> +	 *               configuration, each comprised of @counters_per_block 64-bit counters and
> +	 *               a block header of @block_header_size bytes.
> +	 *
> +	 *               The user must use this field to allocate size for the ring buffer. In
> +	 *               the case of new blocks being added, an old userspace can always use
> +	 *               this field and ignore any blocks it does not know about.
> +	 */
> +	__u32 sample_size;
> +
> +	/** @fw_blocks: Number of FW blocks available. */
> +	__u32 fw_blocks;
> +
> +	/** @cshw_blocks: Number of CSHW blocks available. */
> +	__u32 cshw_blocks;
> +
> +	/** @tiler_blocks: Number of tiler blocks available. */
> +	__u32 tiler_blocks;
> +
> +	/** @memsys_blocks: Number of memsys blocks available. */
> +	__u32 memsys_blocks;
> +
> +	/** @shader_blocks: Number of shader core blocks available. */
> +	__u32 shader_blocks;
> +
> +	/** @pad1: MBZ. */
> +	__u32 pad1;
> +};
> +
>  /**
>   * struct drm_panthor_dev_query - Arguments passed to DRM_PANTHOR_IOCTL_DEV_QUERY
>   */
> @@ -1270,6 +1377,259 @@ struct drm_panthor_bo_query_info {
>  	__u32 pad;
>  };
>  
> +/**
> + * DOC: Performance counter decoding in userspace.
> + *
> + * Each sample will be exposed to userspace in the following manner:
> + *
> + * +--------+--------+------------------------+--------+-------------------------+-----+
> + * | Sample | Block  |        Block           | Block  |         Block           | ... |
> + * | header | header |        counters        | header |         counters        |     |
> + * +--------+--------+------------------------+--------+-------------------------+-----+
> + *
> + * Each sample starts with a &struct drm_panthor_perf_sample_header containing
> + * timestamps, sample flags and the command's user data.
> + *
> + * Each block starts with a &struct drm_panthor_perf_block_header identifying its
> + * type and index, followed by counters_per_block 64-bit counters, as reported by
> + * &struct drm_panthor_perf_info.
> + */
> +
> +/**
> + * struct drm_panthor_perf_block_header - Header present before every block in the
> + * sample ringbuffer.
> + */
> +struct drm_panthor_perf_block_header {
> +	/** @block_type: Type of the block. */
> +	__u8 block_type;
> +
> +	/** @block_idx: Block index. */
> +	__u8 block_idx;
> +
> +	/** @pad0: MBZ. */
> +	__u8 pad0[6];
> +};
> +
> +/**
> + * enum drm_panthor_perf_sample_flags - Sample-wide events that occurred over the sampling
> + * period.
> + */
> +enum drm_panthor_perf_sample_flags {
> +	/**
> +	 * @DRM_PANTHOR_PERF_SAMPLE_OVERFLOW: This sample contains overflows due to the duration
> +	 * of the sampling period.
> +	 */
> +	DRM_PANTHOR_PERF_SAMPLE_OVERFLOW = 1 << 0,
> +};
> +
> +/**
> + * struct drm_panthor_perf_sample_header - Header present before every sample.
> + */
> +struct drm_panthor_perf_sample_header {
> +	/**
> +	 * @timestamp_start_ns: Earliest timestamp that values in this sample represent, in
> +	 * nanoseconds. Derived from CLOCK_MONOTONIC_RAW.
> +	 */
> +	__u64 timestamp_start_ns;
> +
> +	/**
> +	 * @timestamp_end_ns: Latest timestamp that values in this sample represent, in
> +	 * nanoseconds. Derived from CLOCK_MONOTONIC_RAW.
> +	 */
> +	__u64 timestamp_end_ns;
> +
> +	/** @flags: Current sample flags, combination of drm_panthor_perf_sample_flags. */
> +	__u32 flags;
> +
> +	/** @pad: MBZ. */
> +	__u32 pad;
> +
> +	/**
> +	 * @user_data: User data provided as part of the command that triggered this sample.
> +	 */
> +	__u64 user_data;
> +};
> +
> +/**
> + * enum drm_panthor_perf_counter_set - The counter set to be requested from the hardware.
> + *
> + * The hardware supports a single performance counter set at a time, so requesting any set other
> + * than the primary may fail if another process is sampling at the same time.
> + *
> + * If in doubt, the primary counter set has the most commonly used counters and requires no
> + * additional permissions to open.
> + */
> +enum drm_panthor_perf_counter_set {
> +	/**
> +	 * @DRM_PANTHOR_PERF_SET_PRIMARY: The default set configured on the hardware.
> +	 *
> +	 * This is the only set for which all counters in all blocks are defined.
> +	 */
> +	DRM_PANTHOR_PERF_SET_PRIMARY,
> +
> +	/** @DRM_PANTHOR_PERF_SET_SECONDARY: The secondary performance counter set. */
> +	DRM_PANTHOR_PERF_SET_SECONDARY,
> +
> +	/** @DRM_PANTHOR_PERF_SET_TERTIARY: The tertiary performance counter set.*/
> +	DRM_PANTHOR_PERF_SET_TERTIARY,
> +};
> +
> +/**
> + * struct drm_panthor_perf_ringbuf_control - Struct used to map in the ring buffer control indices
> + *                                           into memory shared between user and kernel.
> + *
> + */
> +struct drm_panthor_perf_ringbuf_control {
> +	/**
> +	 * @extract_idx: Number of samples consumed or discarded by userspace. Only
> +	 *               modifiable by userspace.
> +	 */
> +	__u64 extract_idx;

Then it should be made const?

> +
> +	/**
> +	 * @insert_idx: Number of samples emitted by the kernel. Only modifiable by
> +	 *              the kernel.
> +	 */
> +	__u64 insert_idx;
> +};
> +
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

What's the reason for this large pad at the beginning of the struct?

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
> +	 */
> +	__u32 sample_slots;
> +
> +	/**
> +	 * @fw_enable_mask: Bitmask of counters to request from the FW counter block. Any bits
> +	 * past the first drm_panthor_perf_info.counters_per_block bits will be ignored. Bit 0
> +	 * corresponds to counter 0.
> +	 */
> +	__u64 fw_enable_mask[2];
> +
> +	/**
> +	 * @cshw_enable_mask: Bitmask of counters to request from the CSHW counter block. Any bits
> +	 * past the first drm_panthor_perf_info.counters_per_block bits will be ignored. Bit 0
> +	 * corresponds to counter 0.
> +	 */
> +	__u64 cshw_enable_mask[2];
> +
> +	/**
> +	 * @tiler_enable_mask: Bitmask of counters to request from the tiler counter block. Any
> +	 * bits past the first drm_panthor_perf_info.counters_per_block bits will be ignored. Bit
> +	 * 0 corresponds to counter 0.
> +	 */
> +	__u64 tiler_enable_mask[2];
> +
> +	/**
> +	 * @memsys_enable_mask: Bitmask of counters to request from the memsys counter blocks. Any
> +	 * bits past the first drm_panthor_perf_info.counters_per_block bits will be ignored. Bit 0
> +	 * corresponds to counter 0.
> +	 */
> +	__u64 memsys_enable_mask[2];
> +
> +	/**
> +	 * @shader_enable_mask: Bitmask of counters to request from the shader core counter blocks.
> +	 * Any bits past the first drm_panthor_perf_info.counters_per_block bits will be ignored.
> +	 * Bit 0 corresponds to counter 0.
> +	 */
> +	__u64 shader_enable_mask[2];
> +};
> +
> +/**
> + * struct drm_panthor_perf_session_start - Arguments passed to DRM_PANTHOR_PERF_SESSION_START.
> + */
> +struct drm_panthor_perf_session_start {
> +	/** @handle: Performance counter session handle. */
> +	__u32 handle;
> +
> +	/** @pad0: MBZ. */
> +	__u32 pad0;
> +
> +	/**
> +	 * @user_data: User provided data that will be attached to automatic samples collected
> +	 * until the next DRM_PANTHOR_PERF_SESSION_SAMPLE.
> +	 */
> +	__u64 user_data;
> +};
> +
> +/**
> + * struct drm_panthor_perf_session_sample - Arguments passed to DRM_PANTHOR_PERF_SESSION_SAMPLE.
> + */
> +struct drm_panthor_perf_session_sample {
> +	/** @handle: Performance counter session handle. */
> +	__u32 handle;
> +
> +	/** @pad0: MBZ. */
> +	__u32 pad0;
> +
> +	/** @user_data: User provided data that will be attached to the sample.*/
> +	__u64 user_data;
> +};
> +
> +/**
> + * struct drm_panthor_perf_session_stop - Arguments passed to DRM_PANTHOR_PERF_SESSION_STOP.
> + */
> +struct drm_panthor_perf_session_stop {
> +	/** @handle: Performance counter session handle. */
> +	__u32 handle;
> +
> +	/** @pad0: MBZ. */
> +	__u32 pad0;
> +
> +	/**
> +	 * @user_data: User provided data that will be attached to the automatic sample collected
> +	 * at the end of this sampling session.
> +	 */
> +	__u64 user_data;
> +};
> +
> +/**
> + * struct drm_panthor_perf_session_destroy - Arguments passed to DRM_PANTHOR_PERF_SESSION_DESTROY.
> + */
> +struct drm_panthor_perf_session_destroy {
> +	/** @handle: Performance counter session handle. */
> +	__u32 handle;
> +
> +	/** @pad0: MBZ. */
> +	__u32 pad0;
> +};
> +
>  /**
>   * DRM_IOCTL_PANTHOR() - Build a Panthor IOCTL number
>   * @__access: Access type. Must be R, W or RW.
> @@ -1320,6 +1680,16 @@ enum {
>  		DRM_IOCTL_PANTHOR(WR, BO_SYNC, bo_sync),
>  	DRM_IOCTL_PANTHOR_BO_QUERY_INFO =
>  		DRM_IOCTL_PANTHOR(WR, BO_QUERY_INFO, bo_query_info),
> +	DRM_IOCTL_PANTHOR_PERF_SESSION_CREATE =
> +		DRM_IOCTL_PANTHOR(WR, PERF_SESSION_CREATE, perf_session_create),
> +	DRM_IOCTL_PANTHOR_PERF_SESSION_START =
> +		DRM_IOCTL_PANTHOR(WR, PERF_SESSION_START, perf_session_start),
> +	DRM_IOCTL_PANTHOR_PERF_SESSION_SAMPLE =
> +		DRM_IOCTL_PANTHOR(WR, PERF_SESSION_SAMPLE, perf_session_sample),
> +	DRM_IOCTL_PANTHOR_PERF_SESSION_STOP =
> +		DRM_IOCTL_PANTHOR(WR, PERF_SESSION_STOP, perf_session_stop),
> +	DRM_IOCTL_PANTHOR_PERF_SESSION_DESTROY =
> +		DRM_IOCTL_PANTHOR(WR, PERF_SESSION_DESTROY, perf_session_destroy),
>  };
>  
>  #if defined(__cplusplus)
> 
> -- 
> 2.43.0
> 

Best regards,
Liviu


-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
