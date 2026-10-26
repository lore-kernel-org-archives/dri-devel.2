Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91403606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 15:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=W/wgfmpr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 053CD10E02C;
	Mon, 26 Oct 2026 15:37:44 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E62E210E02C;
 Mon, 26 Oct 2026 15:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793029058; x=1824565058;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=ABzbBfcKkptUCHkSrV+1KuKjKwYsif+aBVWDr4ugau0=;
 b=W/wgfmprl0FBT9ye/4vBCieg5vCFcGjSNC4IFBNzi7bK7LPosgwJvpEM
 CN7BJu1DC3u4LlCbei8oj7uRRMxhtl22X0OLt3cr92BF5F/bZS8V1uxUw
 zXXwHUJyAqgAwCjzXs3FzW8AviN3YQ8HMRgNWUlZqXPsw6uUDtQoRnC7B
 U71h3fp9pjmE9IkKgN/yKD7WPQD376oclgd1caAG0t3/BOUdosfiawuXk
 J5vJF/KNhjniBahNTlFiEhvQjbB45SE97g/iyCIXBKcbpdO7PfnUQSHsx
 Fmc4E47QHYQUP4adh/Tq5IuLqIbuHiBqEbozuQLxXwqm0uHqwuPLZauGC A==;
X-CSE-ConnectionGUID: A5Pov6d0SlCKaUN6QHv7Lg==
X-CSE-MsgGUID: aq2AInAFSVa8ABEPu4S0Jg==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1711817"
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="1711817"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2026 08:37:37 -0700
X-CSE-ConnectionGUID: gJc8ZQ2uROWZbfb52Lw5uw==
X-CSE-MsgGUID: uhH7Zg1qTROBOaShTRvWmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="4802389"
Received: from kamilkon-desk.igk.intel.com (HELO localhost) ([10.211.136.201])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2026 08:37:36 -0700
Date: Mon, 26 Oct 2026 16:37:33 +0100
From: Kamil Konieczny <kamil.konieczny@linux.intel.com>
To: atipre <tipreaditya@gmail.com>
Cc: igt-dev@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 louis.chauvet@bootlin.com, Karthik B S <karthik.b.s@intel.com>,
 Swati Sharma <swati2.sharma@intel.com>
Subject: Re: [PATCH i-g-t] tests/kms_writeback: Check CRC capture survives
 writeback
Message-ID: <20261026153733.fdbw34baxoduq357@kamilkon-DESK.igk.intel.com>
Mail-Followup-To: Kamil Konieczny <kamil.konieczny@linux.intel.com>,
 atipre <tipreaditya@gmail.com>, igt-dev@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, louis.chauvet@bootlin.com,
 Karthik B S <karthik.b.s@intel.com>,
 Swati Sharma <swati2.sharma@intel.com>
References: <20261025182420.52258-1-tipreaditya@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261025182420.52258-1-tipreaditya@gmail.com>
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
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi atipre,
On 2026-10-25 at 14:24:20 -0400, atipre wrote:
> The existing writeback tests validate captured framebuffer contents, but
> do not keep pipe CRC capture active across writeback completion. This
> misses the VKMS bug where writeback cleanup disables the composer while
> CRC capture still needs it, leaving subsequent CRC reads waiting for
> samples that never arrive.
> 
> Add writeback-preserves-crc. Complete the initial modeset before starting
> capture and establish reference CRCs for separate red and blue input
> framebuffers. Keep capture open across four alternating writebacks, wait
> for each output fence, and compare three fresh CRC samples with the
> corresponding reference after each writeback. Use atomic updates without
> ALLOW_MODESET once capture starts, and release capture from the final
> fixture so a failed subtest also closes it.
> 
> Check output fence status in the shared wait helper so a signalled error
> fence cannot be treated as a successful writeback.
> 
> On ARM64 QEMU with one and two CPUs, the new subtest fails on unmodified
> mainline and passes with the local VKMS composer-user lifetime
> fix. Four existing applicable writeback subtests pass on both kernels;
> the two XRGB2101010 subtests skip because the format probe rejects them.
> 
> Signed-off-by: atipre <tipreaditya@gmail.com>

It would be preferable to have Full Name instead of nick,
should this be:
Signed-off-by: Tipre Aditya <tipreaditya@gmail.com>
?


If yes, add also same From: at beginnig or configure your git.

+cc Swati and Karthik
Cc: Karthik B S <karthik.b.s@intel.com>
Cc: Swati Sharma <swati2.sharma@intel.com>

Regards,
Kamil

> ---
>  tests/kms_writeback.c | 62 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
> 
> diff --git a/tests/kms_writeback.c b/tests/kms_writeback.c
> index 7c30e8e..71317cf 100644
> --- a/tests/kms_writeback.c
> +++ b/tests/kms_writeback.c
> @@ -64,6 +64,10 @@
>   *
>   * SUBTEST: writeback-pixel-formats
>   * Description: Check the writeback format
> + *
> + * SUBTEST: writeback-preserves-crc
> + * Description: CRC capture remains active across completed writebacks
> + * Driver requirement: i915, xe, vkms
>   */
>  
>  IGT_TEST_DESCRIPTION(
> @@ -317,6 +321,7 @@ static void get_and_wait_out_fence(igt_output_t *output)
>  
>  	ret = sync_fence_wait(output->writeback_out_fence_fd, 1000);
>  	igt_assert_f(ret == 0, "sync_fence_wait failed: %s\n", strerror(-ret));
> +	igt_assert_eq(sync_fence_status(output->writeback_out_fence_fd), 1);
>  	close(output->writeback_out_fence_fd);
>  	output->writeback_out_fence_fd = -1;
>  }
> @@ -537,6 +542,7 @@ int igt_main_args("b:c:f:dl", long_options, help_str, opt_handler, NULL)
>  	igt_output_t *output;
>  	igt_plane_t *plane;
>  	igt_fb_t input_fb, input_fb_10bit;
> +	static igt_pipe_crc_t *pipe_crc;
>  	drmModeModeInfo mode;
>  	unsigned int fb_id;
>  	int ret;
> @@ -709,7 +715,63 @@ int igt_main_args("b:c:f:dl", long_options, help_str, opt_handler, NULL)
>  		igt_remove_fb(display.drm_fd, &output_fb);
>  	}
>  
> +	igt_describe("CRC capture remains active across completed writebacks");
> +	igt_subtest("writeback-preserves-crc") {
> +		igt_fb_t blue_fb, output_fb;
> +		igt_fb_t *colors[] = { &input_fb, &blue_fb };
> +		igt_crc_t reference[2], crc;
> +		int i, j;
> +
> +		igt_skip_on(data.dump_check || data.list_modes);
> +		igt_require(data.supported_colors & XRGB8888);
> +		igt_require_pipe_crc(display.drm_fd);
> +
> +		igt_create_color_fb(display.drm_fd, mode.hdisplay, mode.vdisplay,
> +				    DRM_FORMAT_XRGB8888, DRM_FORMAT_MOD_LINEAR,
> +				    0.0, 0.0, 1.0, &blue_fb);
> +		igt_create_fb(display.drm_fd, mode.hdisplay, mode.vdisplay,
> +			      DRM_FORMAT_XRGB8888, DRM_FORMAT_MOD_LINEAR,
> +			      &output_fb);
> +		fill_fb(&input_fb, 0x00ff0000);
> +		igt_plane_set_fb(plane, &input_fb);
> +		igt_output_set_writeback_fb(output, NULL);
> +		igt_display_commit_atomic(&display, DRM_MODE_ATOMIC_ALLOW_MODESET, NULL);
> +
> +		/* Finish the modeset before starting continuous CRC capture. */
> +		pipe_crc = igt_pipe_crc_new(display.drm_fd, output->config.crtc_index,
> +					    IGT_PIPE_CRC_SOURCE_AUTO);
> +		igt_pipe_crc_start(pipe_crc);
> +
> +		/* Establish both references before writeback can affect capture. */
> +		for (i = 0; i < ARRAY_SIZE(colors); i++) {
> +			igt_plane_set_fb(plane, colors[i]);
> +			igt_display_commit_atomic(&display, 0, NULL);
> +			igt_pipe_crc_get_current(display.drm_fd, pipe_crc, &reference[i]);
> +		}
> +
> +		for (i = 0; i < 4; i++) {
> +			int color = i % ARRAY_SIZE(colors);
> +
> +			igt_plane_set_fb(plane, colors[color]);
> +			igt_output_set_writeback_fb(output, &output_fb);
> +			igt_display_commit_atomic(&display, 0, NULL);
> +			get_and_wait_out_fence(output);
> +
> +			/* Require fresh frames without stopping or restarting capture. */
> +			for (j = 0; j < 3; j++) {
> +				igt_pipe_crc_get_current(display.drm_fd, pipe_crc, &crc);
> +				igt_assert_crc_equal(&reference[color], &crc);
> +			}
> +		}
> +
> +		igt_plane_set_fb(plane, &input_fb);
> +		igt_display_commit_atomic(&display, 0, NULL);
> +		igt_remove_fb(display.drm_fd, &blue_fb);
> +		igt_remove_fb(display.drm_fd, &output_fb);
> +	}
> +
>  	igt_fixture() {
> +		igt_pipe_crc_free(pipe_crc);
>  		cleanup_writeback(&display, output);
>  		igt_remove_fb(display.drm_fd, &input_fb);
>  
> 
> base-commit: bb76404eac7032ba85c53eac15b76e4fadaff0de
> -- 
> 2.50.1 (Apple Git-155)
> 
