Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E958E606A831
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 11:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lankhorst.se header.i=@lankhorst.se header.a=rsa-sha256 header.s=default header.b=jd2xHX5Z
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A243910F515;
	Tue,  3 Nov 2026 11:21:35 +0000 (UTC)
Received: from lankhorst.se (unknown [141.105.120.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEFD510F512;
 Tue,  3 Nov 2026 11:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
 s=default; t=1793704886;
 bh=WsecBn/49e7uFyfqCo1gbvGorAO+WAvATYilIhVU0do=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=jd2xHX5ZE2f2SxpSjFFacchwNbUt1xmsp9KsjBIabSum0Nn0NalBpOZd/WdLcp5+f
 AkqXC4N/LDODtoiDbvHJByML9slvFytsVc5uXdeG1gocaUTPshjsG+OERyEnp5mqwL
 6M/EhvOB06Gy2ruu9Ub86GuBd2MU7mv8orIAygxNR7Q0vaiAszZrzfz6Zkhfgt2Jfh
 olYslm687tgXuk2dwbqnWlX1U5/VUewQrxy+3ZqpWVjUevuI9RzzuUJOZYlD5RHtfs
 kvWCR+cxMPIj4lb3t2VX9oXXdSzpSQxMangaMJwf2iEjc+nlzQ51AkpQezboYhRHvI
 zIE0JP9atqCwA==
Message-ID: <ec59fe20-1e22-4009-89b9-af5b3d37fcee@lankhorst.se>
Date: Tue, 3 Nov 2026 12:22:22 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/xe/gsc: warn about GSC stolen memory usage on RT
 kernels
To: Junxiao Chang <junxiao.chang@intel.com>, jani.nikula@linux.intel.com,
 rodrigo.vivi@intel.com, matthew.brost@intel.com,
 thomas.hellstrom@linux.intel.com, airlied@gmail.com, simona@ffwll.ch,
 bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
References: <20261104032732.30681-1-junxiao.chang@intel.com>
 <20261104032732.30681-3-junxiao.chang@intel.com>
Content-Language: en-US
From: Maarten Lankhorst <dev@lankhorst.se>
In-Reply-To: <20261104032732.30681-3-junxiao.chang@intel.com>
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

On 11/4/26 04:27, Junxiao Chang wrote:
> The GSC microcontroller requires stolen memory, which can introduce
> latency spikes and negatively impact real-time performance.
> 
> Print a warning on CONFIG_PREEMPT_RT kernels to inform the user that GSC
> is active and that RT performance can be improved by disabling the GSC
> firmware (e.g., by setting the module parameter xe.gsc_firmware_path="").
> 
> Signed-off-by: Junxiao Chang <junxiao.chang@intel.com>
> ---
>  drivers/gpu/drm/xe/xe_gsc.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/xe/xe_gsc.c b/drivers/gpu/drm/xe/xe_gsc.c
> index aab59dc647fbd..3d06ab6fecbe0 100644
> --- a/drivers/gpu/drm/xe/xe_gsc.c
> +++ b/drivers/gpu/drm/xe/xe_gsc.c
> @@ -427,6 +427,11 @@ int xe_gsc_init(struct xe_gsc *gsc)
>  	else if (ret)
>  		goto out;
>  
> +	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
> +		xe_gt_warn(gt, "RT performance might be impacted by GSC stolen memory usage\n");
> +		xe_gt_warn(gt, "Consider disabling GSC (xe.gsc_firmware_path=\"\") to improve it\n");
> +	}
Is this a problem on discrete as well, or only on integrated?

Kind regards,
~Maarten Lankhorst> +
>  	ret = xe_gsc_proxy_init(gsc);
>  	if (ret && ret != -ENODEV)
>  		goto out;

