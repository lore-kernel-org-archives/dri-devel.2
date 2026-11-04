Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90330606A326
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 16:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Z/e2E/kb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF2E610FD6A;
	Wed,  4 Nov 2026 16:51:34 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id A3FCD10FD6B
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 16:51:28 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1CED81BB2;
 Wed,  4 Nov 2026 08:51:25 -0800 (PST)
Received: from [10.57.59.2] (unknown [10.57.59.2])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 206463F632;
 Wed,  4 Nov 2026 08:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1793811088; bh=Lh7rDkvouK/vuqSyInprWh4+ip8k75YEg2GCpLVMSR0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Z/e2E/kbvH8rD82LZ27OkDjGmeFEObgHYyFGg5USS+L1JFhcAjFec7AH5gnic7XwY
 L/NL8ozwFwAKVxvCIlmc01QETyl5NRVP4ywB6ZDuZ/X0ZqCOzSUpZpLUTFCJquK6/R
 cybc2Hl88uXmosAHfq/MgXC0DQt7HGuMVHZt5V20=
Message-ID: <731e4ce0-91df-4b50-8834-d8c9e0fc43a3@arm.com>
Date: Wed, 4 Nov 2026 16:51:25 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] drm/panfrost: Fix race when restoring reset state
 in perfcnt
To: =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Rob Herring <robh@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20261103-panfrost-reset-races-fixes-v2-0-454207b1d4e3@collabora.com>
 <20261103-panfrost-reset-races-fixes-v2-2-454207b1d4e3@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20261103-panfrost-reset-races-fixes-v2-2-454207b1d4e3@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

On 03/11/2026 20:36, Adrián Larumbe wrote:
> struct panfrost_perfcnt::state should always be updated atomically, both
> in the dump ioctl and the reset sequence.
> 
> Fixes: 9944dd07f3cf ("drm/panfrost: Fix races between perfcnt and reset sequence")
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>  drivers/gpu/drm/panfrost/panfrost_perfcnt.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> index b26da057a1a0..d50b6cc2ecfa 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> @@ -148,18 +148,17 @@ static int panfrost_perfcnt_dump_locked(struct panfrost_device *pfdev, u32 *stat
>  	 */
>  	ret = wait_for_completion_interruptible_timeout(&pfdev->perfcnt->dump_comp,
>  							msecs_to_jiffies(1000));
> -
>  	if (!ret)
>  		ret = -ETIMEDOUT;
>  
> -	/* We need to restore perfcnt state so the next successful dump can relay it to UM */
> -	if (ret < 0) {
> -		perfcnt->state |= *state;
> -		*state = 0;
> -		return ret;
> -	}
> -
>  	scoped_guard(rwsem_read, &pfdev->reset.lock) {
> +		/* Restore perfcnt state so the next successful dump can relay it to UM */
> +		if (ret < 0) {
> +			perfcnt->state |= *state;
> +			*state = 0;
> +			return ret;
> +		}
> +
>  		*state |= perfcnt->state;
>  
>  		/* UM must re-enable their session before requesting new dumps. */
> 

