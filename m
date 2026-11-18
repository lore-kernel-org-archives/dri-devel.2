Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3121606A330
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 16:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin.net header.i=@ursulin.net header.a=rsa-sha256 header.s=google header.b=HQygc74O
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03C9A10E0DB;
	Wed, 18 Nov 2026 16:42:33 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAE4610E0DB
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 16:42:26 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-49d64a88222so1514456f8f.1
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 08:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1795020145; x=1795624945; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Qo/P/wbaNkEjPm8HGz4npHC5JZBaCO0dOmWlqnF5GUA=;
 b=HQygc74ORi2Y2Xw1xC2ih+/Pgw5aOZXTNiceRdFCq8JprrGgAXBU7cetYzj7sDjRJi
 Q2eJY2uYWaMebE6mdq19Qom/Nfrfb4jIi52ECGu8gkGBdYoSQGx/GqGGoLTEu22TVZcz
 6LQQ39n8UsVLyxFhvuchaBRQLuMVBb6N8K/76xu00/HMizlWdqJ67IGx3L0LOUh7Sxgy
 ATElXkc4Z2BJpLW0/dcJAUhkRt0MBqa+12h7Ik7GWWMf0qhhNMG107WUBXC7/4zkIANE
 WHVrlP4YWrbvNbNL2bG+E/svjHVTBT9N1vgOBxz/66A/WfTcNgmcxLmOrgJNN0/HAhan
 M7bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795020145; x=1795624945;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Qo/P/wbaNkEjPm8HGz4npHC5JZBaCO0dOmWlqnF5GUA=;
 b=avaNyoONnMCWCcWP3w+TmM3EIK0JovRyJ7/TcE8ItwEYCdM+4w2EHvUI2GGOZSjOWb
 q6x3qMxzMoH4du7Npjwh7B7TBJ/5o9s8YcO/P+E1DFU9xcSYuVav2IWO1vRW5ZYcXqV8
 r/W4lbUW3RRcpbCOBoRFPkPJ3IEOiTpfP5np979N3H3t5/ljnQOP7fttCNjbJ37vbHkT
 HZIwhnF6mtl32IxA9oJveIb2VNSw6EM63psoud2SCF9eeSfDRcL+MX6a5HtTW9Y3lprs
 TN89TYFQBbjdfuA7pMKt1LxJXCSOQqJ+iPEpSlbF3ASSlGr+QO5YHlmdj21IFkuzIjTF
 K+Yg==
X-Forwarded-Encrypted: i=1;
 AL+hErHzWIoBXnTv24smbCKeRm1yZL0kt1FvGl3zR5qL7qkGGvzBjawkfoEKnI6lGsmQljF1rEl4LEo8ePo=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z96CxBinC9pKDoTurX66AZ2LlB/gdVr+gErylioHxhGfM/RxAMd
 ol7OS9oGBRQt7IL9/+j57hM2Oce2vQpyFAkaG2k2P4ysdx8hiOCj9qKwK30BlCkPk2U=
X-Gm-Gg: AZFdTZfNZ3kuj3BbNyg64WA9dErQ2GkLRZ0XPEYBA89uHhA1PGYDueKzkY4s0MUUegD
 lrh4Sg9s+R6VRgVv9DO2DsTVeJalzByEEVbV/cUwizZmTj+z8SlT3Vi+LuUOrTL2i5aoLjWAzba
 qPQJjnSS+7lpbEn8lXoAYwx2WfxaSA73MWGAiHi8xVlS//MVWibR6W2zM09WQcB6kknVBx0NiTx
 tC3vOkxB3yKW+qMdL+EtCkwlGJT7nWLdn7VV2pbYrcUujL7FQ8oHMnvsiFE+vf1ERzrleDVDEMR
 8RNWncHFwCq9C31OWa2Srg00JLioI6BwCmrbGy+r0FnAUS2QbBMQeU5aJfaYkdn4+HspQh+KRqM
 l0m5pNdHxKojeWTXmbe+1CWNSCW3bGOJ2v9LWOYWHILKhhHTKNGJUoBWc7F6IJMHJMboLpHpGjx
 SZxXoDpbvZ14KGfBTvAwaJ7HcooBvu+RGVn4cgBDHsibTBi6wgT9RyZHTO/glAI7pDWIB2gPCnY
 JxUCjGbVw8k4a0Ss+SgOCc1xwLc9D7ChxY/SuPQE/V65I0XarJ+U2ZFrHP3aD/pYt9IJUV8yDTE
 ZWcO6Ts1cXIvBmIrPRSe/adfLAHK3FWfApxRvNNxczOQ4w==
X-Received: by 2002:a05:6000:220d:b0:498:6171:c074 with SMTP id
 ffacd0b85a97d-4a8e39ae958mr149841f8f.3.1795020145028; 
 Wed, 18 Nov 2026 08:42:25 -0800 (PST)
Received: from [192.168.0.116] ([81.79.79.1]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a64b60940csm5630286f8f.0.2026.11.18.08.42.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Nov 2026 08:42:24 -0800 (PST)
Message-ID: <cfb252a5-da73-4f0f-87d0-565797982e3a@ursulin.net>
Date: Wed, 18 Nov 2026 16:42:23 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] accel/rocket: Report NPU usage through fdinfo
To: Sidong Yang <sidong.yang@furiosa.ai>, Tomeu Vizoso
 <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>,
 Philipp Stanner <phasta@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>, ckoenig.leichtzumerken@gmail.com
Cc: mcanal@igalia.com, Heiko Stuebner <heiko@sntech.de>,
 Gyeyoung Baek <gye976@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261112171144.3151554-1-sidong.yang@furiosa.ai>
 <20261112171144.3151554-3-sidong.yang@furiosa.ai>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20261112171144.3151554-3-sidong.yang@furiosa.ai>
Content-Type: text/plain; charset=UTF-8; format=flowed
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


On 12/11/2026 17:11, Sidong Yang wrote:
> There is no way to tell how much of the NPU a client uses. Implement the
> DRM usage stats: report the runtime of the client's scheduler entity as
> drm-engine-npu, along with drm_show_memory_stats() for the BOs.
> 
> The cores are identical, so they are reported as a single engine with
> drm-engine-capacity-npu set to rdev->max_cores, the number of core
> slots.
> 
> Document the keys in the rocket driver documentation.
> 
> Signed-off-by: Sidong Yang <sidong.yang@furiosa.ai>
> ---
>   Documentation/accel/rocket/index.rst  | 28 +++++++++++++++++++++++++++
>   Documentation/gpu/drm-usage-stats.rst |  1 +
>   drivers/accel/rocket/rocket_drv.c     | 21 +++++++++++++++++++-
>   3 files changed, 49 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/accel/rocket/index.rst b/Documentation/accel/rocket/index.rst
> index 70f97bccf100..8ae785b65a53 100644
> --- a/Documentation/accel/rocket/index.rst
> +++ b/Documentation/accel/rocket/index.rst
> @@ -17,3 +17,31 @@ project.
>   Hardware currently supported:
>   
>   * RK3588
> +
> +.. _rocket-usage-stats:
> +
> +Rocket DRM client usage stats implementation
> +============================================
> +
> +The accel/rocket driver implements the DRM client usage stats specification as
> +documented in :ref:`drm-client-usage-stats`.
> +
> +The NPU cores are reported as a single engine, npu, with a capacity equal to the
> +number of cores. The time is summed over all cores and is accounted by the DRM
> +GPU scheduler, from when a job is handed to a core until its fence signals.
> +
> +Example of the output showing the implemented key value pairs:
> +
> +::
> +
> +        pos:	0
> +        flags:	02400002
> +        mnt_id:	33
> +        ino:	755
> +        drm-driver:	rocket
> +        drm-client-id:	263
> +        drm-engine-npu:	2384122043 ns
> +        drm-engine-capacity-npu:	3
> +        drm-total-memory:	24216 KiB
> +        drm-shared-memory:	0
> +        drm-active-memory:	3000 KiB
> diff --git a/Documentation/gpu/drm-usage-stats.rst b/Documentation/gpu/drm-usage-stats.rst
> index 70b7cfcc194f..288764730d23 100644
> --- a/Documentation/gpu/drm-usage-stats.rst
> +++ b/Documentation/gpu/drm-usage-stats.rst
> @@ -218,3 +218,4 @@ Driver specific implementations
>   * :ref:`panthor-usage-stats`
>   * :ref:`xe-usage-stats`
>   * :ref:`amdxdna-usage-stats`
> +* :ref:`rocket-usage-stats`
> diff --git a/drivers/accel/rocket/rocket_drv.c b/drivers/accel/rocket/rocket_drv.c
> index 5d7805c41dc3..351be60b1228 100644
> --- a/drivers/accel/rocket/rocket_drv.c
> +++ b/drivers/accel/rocket/rocket_drv.c
> @@ -3,8 +3,10 @@
>   
>   #include <drm/drm_accel.h>
>   #include <drm/drm_drv.h>
> +#include <drm/drm_file.h>
>   #include <drm/drm_gem.h>
>   #include <drm/drm_ioctl.h>
> +#include <drm/drm_print.h>
>   #include <drm/rocket_accel.h>
>   #include <linux/clk.h>
>   #include <linux/err.h>
> @@ -139,7 +141,23 @@ static const struct drm_ioctl_desc rocket_drm_driver_ioctls[] = {
>   	ROCKET_IOCTL(FINI_BO, fini_bo),
>   };
>   
> -DEFINE_DRM_ACCEL_FOPS(rocket_accel_driver_fops);
> +static void rocket_show_fdinfo(struct drm_printer *p, struct drm_file *file)
> +{
> +	struct rocket_device *rdev = to_rocket_device(file->minor->dev);
> +	struct rocket_file_priv *rocket_priv = file->driver_priv;
> +
> +	drm_printf(p, "drm-engine-npu:\t%llu ns\n",
> +		   drm_sched_entity_get_runtime(&rocket_priv->sched_entity));
> +	drm_printf(p, "drm-engine-capacity-npu:\t%u\n", rdev->max_cores);
> +
> +	drm_show_memory_stats(p, file);
> +}
> +
> +static const struct file_operations rocket_accel_driver_fops = {
> +	.owner = THIS_MODULE,
> +	DRM_ACCEL_FOPS,
> +	.show_fdinfo = drm_show_fdinfo,
> +};
>   
>   /*
>    * Rocket driver version:
> @@ -150,6 +168,7 @@ static const struct drm_driver rocket_drm_driver = {
>   	.open			= rocket_open,
>   	.postclose		= rocket_postclose,
>   	.gem_create_object	= rocket_gem_create_object,
> +	.show_fdinfo		= rocket_show_fdinfo,
>   	.ioctls			= rocket_drm_driver_ioctls,
>   	.num_ioctls		= ARRAY_SIZE(rocket_drm_driver_ioctls),
>   	.fops			= &rocket_accel_driver_fops,

Not knowing rocket, so on a glance, it looks good to me.

For the adherence to DRM fdinfo spec at least, which looks completely fine:

Acked-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Regards,

Tvrtko

