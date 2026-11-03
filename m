Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DA1606BF97
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 10:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lankhorst.se header.i=@lankhorst.se header.a=rsa-sha256 header.s=default header.b=lAvy7fRJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9173710F4D6;
	Tue,  3 Nov 2026 10:44:20 +0000 (UTC)
Received: from lankhorst.se (unknown [141.105.120.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C76810F4CD;
 Tue,  3 Nov 2026 10:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
 s=default; t=1793702652;
 bh=OpaMivqe7d52iZ6lcLVckz/GCFD53etTQkNAD34bc3Y=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=lAvy7fRJQZnPLS+Zr0eLEK2EhRjwIRQSLMqAuApIDK9LLU4oxAQCVFAnZcEApRmem
 WEVMoGhKjBx1u6vahgm8LYOWb+UceXTsjW4YsEeQH+iTVNQYUFE0qG+WVCRjPkXhTM
 EAyFhfcwsmsBYeXiTpWlLYjqSCGxKyp/DirExcAK1qM70CjHUA8lNWFR27ayHPU93L
 4Gokx+rasSYRPQtITskOheVxbq1Jb881G0oIMmSb7dwc3Dgv8qdPLXxKEYmStqwi9T
 SXKM4HEwTFt0EWRnYWcRjsU70u2kRR095CqTlQuW/8q0ObhGcam2Ft0nKgGskNWf6V
 JLkzP8hw/4JkA==
Message-ID: <65fae402-e053-4a4f-ba55-6b5b51690eba@lankhorst.se>
Date: Tue, 3 Nov 2026 11:45:09 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/xe/display: Skip initial plane allocation from
 stolen memory on RT
To: Junxiao Chang <junxiao.chang@intel.com>, jani.nikula@linux.intel.com,
 rodrigo.vivi@intel.com, matthew.brost@intel.com,
 thomas.hellstrom@linux.intel.com, airlied@gmail.com, simona@ffwll.ch,
 bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
References: <20261104032732.30681-1-junxiao.chang@intel.com>
 <20261104032732.30681-2-junxiao.chang@intel.com>
Content-Language: en-US
From: Maarten Lankhorst <dev@lankhorst.se>
In-Reply-To: <20261104032732.30681-2-junxiao.chang@intel.com>
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hey,

Is a single performance hit during boot allowed?
If so, this is a better solution, as it helps on !PREEMPT_RT as well:

https://patchwork.freedesktop.org/series/170759/

The first patch in that series is a better solution than unconditionally disabling
stolen memory, as I from what I understand the problem only exists when media gt is enabled.

If not, we should probably unconditionally disable stolen framebuffer all the time.

But with the series, we preserve the initial framebuffer contents and ensure a smooth
handover, even without stolen.

The warning in 2/2 is probably fine.

Kind regards,
~Maarten Lankhorst

On 11/4/26 04:27, Junxiao Chang wrote:
> CPU access to stolen memory ranges can introduce latency spikes that
> compromise real-time (RT) guarantees on PREEMPT_RT kernels.
> 
> On PREEMPT_RT configurations, bypass retrieving the initial plane's
> framebuffer from stolen memory. This forces the driver to fall back to
> standard allocations, preventing RT latency degradation at the expense
> of seamless boot display takeover.
> 
> Signed-off-by: Junxiao Chang <junxiao.chang@intel.com>
> ---
>  drivers/gpu/drm/xe/display/xe_initial_plane.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/xe/display/xe_initial_plane.c b/drivers/gpu/drm/xe/display/xe_initial_plane.c
> index 0f86b73036d03..fd0e2962412dd 100644
> --- a/drivers/gpu/drm/xe/display/xe_initial_plane.c
> +++ b/drivers/gpu/drm/xe/display/xe_initial_plane.c
> @@ -87,6 +87,12 @@ initial_plane_bo(struct xe_device *xe,
>  		struct ttm_resource_manager *stolen;
>  		u64 pte;
>  
> +		if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
> +			drm_dbg_kms(&xe->drm,
> +				    "Skipping FB allocation from stolen mem due to PREEMPT_RT\n");
> +			return NULL;
> +		}
> +
>  		stolen = ttm_manager_type(&xe->ttm, XE_PL_STOLEN);
>  		if (!stolen) {
>  			drm_dbg_kms(&xe->drm, "No stolen for initial FB\n");

