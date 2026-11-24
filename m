Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B64606A33C
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 16:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JvFh3slm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B85710EA56;
	Tue, 24 Nov 2026 16:53:43 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F4DD10EA56;
 Tue, 24 Nov 2026 16:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795539218; x=1827075218;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=5vzMqQTW9bipIuVLCxmsZr0kbn/k+9A1BtzY6Fdtqo4=;
 b=JvFh3slmytUdRz4tboEDVhCWAXTJr5Syf+QDq686XCxCx8DvMHQo9MDg
 ljM3qi+ELmrp3glVDTgiNLhgaY+t8EIDMO6b/bLaIccneT/Fx/0LTtcQJ
 Vq7PxL2XOHuMYeQFCHxQvD9LSdMr0hAk9llX3VKmeYVwzU80FXIKNcKH4
 c7sgEGe4bh3csEnGwcJeNsPMX+9DXvzqW8FSS53i1HllYsCPgWnVtpTDg
 RtuygqOYuuV8pZD/tROTfiXTdAmjQmx+Jc2xGJjDvKa1EXljBpg2d8c/w
 OseMS7qOwItGOL0VJnGYG2/Jz7qBU0ESRZfpQFgozmF0XlY5goqCZskD1 g==;
X-CSE-ConnectionGUID: XMA4xo7mROK6CaL43gaWpg==
X-CSE-MsgGUID: 9GgQ3UTmT+euLyMgtInv5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4254610"
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="4254610"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 08:53:35 -0800
X-CSE-ConnectionGUID: dcKPpqidQ/WRU7ICMnnWCw==
X-CSE-MsgGUID: of9u7HhARHy8litZ04JFTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; d="scan'208";a="11624124"
Received: from kamilkon-desk.igk.intel.com (HELO localhost) ([10.211.136.201])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 08:53:33 -0800
Date: Tue, 24 Nov 2026 17:53:30 +0100
From: Kamil Konieczny <kamil.konieczny@linux.intel.com>
To: Aditya Tipre <tipreaditya@gmail.com>
Cc: igt-dev@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 louis.chauvet@bootlin.com, sowmiya.s@intel.com, karthik.b.s@intel.com, 
 swati2.sharma@intel.com
Subject: Re: [PATCH i-g-t v3 1/2] tests/kms_writeback: Wait for the valid FB
 ID writeback
Message-ID: <noadhonrzbrwqcxwslspwqbib7q3s2e2pawxjbg7crid6rap7x@ot6y72stxm5f>
Mail-Followup-To: Kamil Konieczny <kamil.konieczny@linux.intel.com>, 
 Aditya Tipre <tipreaditya@gmail.com>, igt-dev@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, 
 louis.chauvet@bootlin.com, sowmiya.s@intel.com, karthik.b.s@intel.com, 
 swati2.sharma@intel.com
References: <PH7PR11MB6796FA8DDA56651E65E018D2E5682@PH7PR11MB6796.namprd11.prod.outlook.com>
 <20261105225628.4123-1-tipreaditya@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261105225628.4123-1-tipreaditya@gmail.com>
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Aditya,
On 2026-11-05 at 17:56:27 -0500, Aditya Tipre wrote:
> The positive WRITEBACK_FB_ID test submits a writeback to the common input
> framebuffer without requesting or waiting for its completion fence. A
> blocking atomic commit does not imply that writeback has finished.
> 
> The following pixel-output test fills the same buffer with its reference
> color. The earlier writeback can still be modifying it, leaving a mixture
> of the old and new contents and causing intermittent checksum failures.
> On ARM64 VKMS, a diagnostic run observed the prior fence still unsignalled
> and a black row in both the input and the captured output after the input
> had been filled red.
> 
> Request a fence for the successful FB ID writeback and wait for it before
> returning. Only require the returned fence descriptor to be -1 when the
> commit fails, so the shared commit helper also accepts this successful
> fenced operation. Keep all invalid-parameter checks intact.
> 
> Signed-off-by: Aditya Tipre <tipreaditya@gmail.com>

Please rebase on current top and also use a cover letter with
a different subject for series, for example:

[PATCH i-g-t v4 0/2] kms_writeback: check crc survivies writeback

and then resend this series, also please make it a new series (do
not use reply-to any msg-ids linking it) so our patchwork could
take it properly and then CI could test it. If you want, you can give
a links to previous series to lore.kernel.org (there is igt-dev
mirror) in cover letter.

One more nit at end.

> ---
> New prerequisite in v3:
> - Wait for the existing valid FB ID writeback before its target buffer is
>   reused as input by the next subtest.
> 
> A diagnostic run observed the prior fence still unsignalled and a row of
> old black pixels replacing red input pixels. Waiting for the fence removes
> this race. The standalone fix passes the four applicable existing subtests
> on unfixed and fixed VKMS kernels with one and two CPUs; both XRGB2101010
> cases skip.
> 
>  tests/kms_writeback.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/kms_writeback.c b/tests/kms_writeback.c
> index 7c30e8e..550d603 100644
> --- a/tests/kms_writeback.c
> +++ b/tests/kms_writeback.c
> @@ -228,7 +228,7 @@ static int do_writeback_test(igt_output_t *output, uint32_t fb_id,
>  
>  	ret = igt_display_try_commit_atomic(display, DRM_MODE_ATOMIC_ALLOW_MODESET, NULL);
>  
> -	if (ptr_valid)
> +	if (ptr_valid && ret)
>  		igt_assert(*out_fence_ptr == -1);
>  
>  	/* WRITEBACK_FB_ID must always read as zero */
> @@ -288,8 +288,12 @@ static void writeback_fb_id(igt_output_t *output, igt_fb_t *valid_fb, igt_fb_t *
>  	igt_assert_eq(ret, 0);
>  
>  	/* Valid output buffer */
> -	ret = do_writeback_test(output, valid_fb->fb_id, NULL, false);
> +	ret = do_writeback_test(output, valid_fb->fb_id,
> +				&output->writeback_out_fence_fd, true);
>  	igt_assert_eq(ret, 0);
> +
> +	/* The next subtest may reuse this buffer as input. */
> +	igt_get_and_wait_out_fence(output);
>  }
>  
>  static void fill_fb(igt_fb_t *fb, uint32_t pixel)
> 
> base-commit: 454657e58fbcfd6fa8a9db0830aa1652fe6364c2

Can you not use these 'base-commit' line? Or at least rebase on
current top.

Thanks!

Regards,
Kamil

> -- 
> 2.50.1 (Apple Git-155)
> 
