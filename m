Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC1C2C982D0
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 20:54:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D910010E00C;
	Thu, 17 Sep 2026 20:54:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="r9kle1SH";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 562F210E00C
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 20:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=9iyGWoUGHBfrC/XiZGLAy1nsrKpP2LDB3lPa2qO4fk0=; b=r9kle1SHFddMGD8IWOf5LApGyz
 1k5E2Mq6QRXrL+fdraFZ0nCYybUsExqYk4aw9qW04wYx8OK9vYUgx+jtKPNxp+VjkWvDP/ONT1rSq
 zfz8x+eEgp309WjcH14WaCpkEQdPRjFPf3Ia9TnkfDXep4T6X+rBQRcD+0FXIGaZt59olcJV6JfNH
 74BIFHA+t7UzuJoN/EDOLLfkiDp1cFOJwSeeB9n9p1pygrWbFA9MFlPRpp/csvdlpOniFCGjhG4O+
 T8mhU/72ukXnYThvRVpMwztc2GK82hBa5D/czZekGAH9tETJotrMLQ6YmlomR0A3wA/4yCPk5AulL
 IWHEZSNQ==;
Received: from [179.105.94.163] (helo=[192.168.0.2])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1x7J7C-003eE9-3P; Thu, 17 Sep 2026 22:53:54 +0200
Message-ID: <eedc9273-ec8c-4f41-9622-6fd88cafa452@igalia.com>
Date: Thu, 17 Sep 2026 17:53:45 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/v3d: Fix indirect GEM object reference leak in
 v3d_get_cpu_indirect_csd_params()
To: Wentao Liang <vulab@iscas.ac.cn>, airlied@gmail.com
Cc: dri-devel@lists.freedesktop.org, itoral@igalia.com,
 linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, mwen@igalia.com, simona@ffwll.ch, tzimmermann@suse.de,
 stable@vger.kernel.org
References: <20260916153607.2048140-1-vulab@iscas.ac.cn>
From: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Content-Language: en-US
Autocrypt: addr=mcanal@igalia.com; keydata=
 xsBNBGcCwywBCADgTji02Sv9zjHo26LXKdCaumcSWglfnJ93rwOCNkHfPIBll85LL9G0J7H8
 /PmEL9y0LPo9/B3fhIpbD8VhSy9Sqz8qVl1oeqSe/rh3M+GceZbFUPpMSk5pNY9wr5raZ63d
 gJc1cs8XBhuj1EzeE8qbP6JAmsL+NMEmtkkNPfjhX14yqzHDVSqmAFEsh4Vmw6oaTMXvwQ40
 SkFjtl3sr20y07cJMDe++tFet2fsfKqQNxwiGBZJsjEMO2T+mW7DuV2pKHr9aifWjABY5EPw
 G7qbrh+hXgfT+njAVg5+BcLz7w9Ju/7iwDMiIY1hx64Ogrpwykj9bXav35GKobicCAwHABEB
 AAHNIE1hw61yYSBDYW5hbCA8bWNhbmFsQGlnYWxpYS5jb20+wsCRBBMBCAA7FiEE+ORdfQEW
 dwcppnfRP/MOinaI+qoFAmcCwywCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQ
 P/MOinaI+qoUBQgAqz2gzUP7K3EBI24+a5FwFlruQGtim85GAJZXToBtzsfGLLVUSCL3aF/5
 O335Bh6ViSBgxmowIwVJlS/e+L95CkTGzIIMHgyUZfNefR2L3aZA6cgc9z8cfow62Wu8eXnq
 GM/+WWvrFQb/dBKKuohfBlpThqDWXxhozazCcJYYHradIuOM8zyMtCLDYwPW7Vqmewa+w994
 7Lo4CgOhUXVI2jJSBq3sgHEPxiUBOGxvOt1YBg7H9C37BeZYZxFmU8vh7fbOsvhx7Aqu5xV7
 FG+1ZMfDkv+PixCuGtR5yPPaqU2XdjDC/9mlRWWQTPzg74RLEw5sz/tIHQPPm6ROCACFls7A
 TQRnAsMsAQgAxTU8dnqzK6vgODTCW2A6SAzcvKztxae4YjRwN1SuGhJR2isJgQHoOH6oCItW
 Xc1CGAWnci6doh1DJvbbB7uvkQlbeNxeIz0OzHSiB+pb1ssuT31Hz6QZFbX4q+crregPIhr+
 0xeDi6Mtu+paYprI7USGFFjDUvJUf36kK0yuF2XUOBlF0beCQ7Jhc+UoI9Akmvl4sHUrZJzX
 LMeajARnSBXTcig6h6/NFVkr1mi1uuZfIRNCkxCE8QRYebZLSWxBVr3h7dtOUkq2CzL2kRCK
 T2rKkmYrvBJTqSvfK3Ba7QrDg3szEe+fENpL3gHtH6h/XQF92EOulm5S5o0I+ceREwARAQAB
 wsB2BBgBCAAgFiEE+ORdfQEWdwcppnfRP/MOinaI+qoFAmcCwywCGwwACgkQP/MOinaI+qpI
 zQf+NAcNDBXWHGA3lgvYvOU31+ik9bb30xZ7IqK9MIi6TpZqL7cxNwZ+FAK2GbUWhy+/gPkX
 it2gCAJsjo/QEKJi7Zh8IgHN+jfim942QZOkU+p/YEcvqBvXa0zqW0sYfyAxkrf/OZfTnNNE
 Tr+uBKNaQGO2vkn5AX5l8zMl9LCH3/Ieaboni35qEhoD/aM0Kpf93PhCvJGbD4n1DnRhrxm1
 uEdQ6HUjWghEjC+Jh9xUvJco2tUTepw4OwuPxOvtuPTUa1kgixYyG1Jck/67reJzMigeuYFt
 raV3P8t/6cmtawVjurhnCDuURyhUrjpRhgFp+lW8OGr6pepHol/WFIOQEg==
In-Reply-To: <20260916153607.2048140-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Hi Wentao,

Your patch doesn't apply neither to drm-misc-next nor to drm-misc-fixes.
I removed v3d_setup_csd_jobs_and_bos() from
v3d_get_cpu_indirect_csd_params() a couple of months ago.

Please, use drm-misc-next or drm-misc-fixes as the base of your next
series.

Best regards,
- Maíra

On 16/09/26 12:36, Wentao Liang wrote:
> If v3d_setup_csd_jobs_and_bos() fails, the reference taken by
> drm_gem_object_lookup() on info->indirect is never dropped: the caller
> only cleans up via v3d_job_cleanup(), but the CPU job refcount is not
> initialized until v3d_job_init() runs after the extensions succeed, so
> v3d_cpu_job_free() never fires.
> 
> Release the GEM reference and clear the pointer when setting up the
> CSD jobs fails.
> 
> Fixes: 18b8413b25b7 ("drm/v3d: Create a CPU job extension for a indirect CSD job")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>   drivers/gpu/drm/v3d/v3d_submit.c | 13 ++++++++++---
>   1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
> index 3ddd53b6f437..f021ab9a69b1 100644
> --- a/drivers/gpu/drm/v3d/v3d_submit.c
> +++ b/drivers/gpu/drm/v3d/v3d_submit.c
> @@ -465,6 +465,7 @@ v3d_get_cpu_indirect_csd_params(struct drm_file *file_priv,
>   	struct v3d_dev *v3d = v3d_priv->v3d;
>   	struct drm_v3d_indirect_csd indirect_csd;
>   	struct v3d_indirect_csd_info *info = &job->indirect_csd;
> +	int ret;
>   
>   	if (!v3d_validate_cpu_job(file_priv, job))
>   		return -EINVAL;
> @@ -485,9 +486,15 @@ v3d_get_cpu_indirect_csd_params(struct drm_file *file_priv,
>   
>   	info->indirect = drm_gem_object_lookup(file_priv, indirect_csd.indirect);
>   
> -	return v3d_setup_csd_jobs_and_bos(file_priv, v3d, &indirect_csd.submit,
> -					  &info->job, &info->clean_job,
> -					  NULL, &info->acquire_ctx);
> +	ret = v3d_setup_csd_jobs_and_bos(file_priv, v3d, &indirect_csd.submit,
> +					 &info->job, &info->clean_job,
> +					 NULL, &info->acquire_ctx);
> +	if (ret) {
> +		drm_gem_object_put(info->indirect);
> +		info->indirect = NULL;
> +	}
> +
> +	return ret;
>   }
>   
>   /* Get data for the query timestamp job submission. */

