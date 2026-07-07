Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACC20C43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 17:31:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AF8210EE6E;
	Tue,  7 Jul 2026 17:31:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ez7YiLFa";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0318410EE6E
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 17:31:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 744FC4183C;
 Tue,  7 Jul 2026 17:31:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C59A51F000E9;
 Tue,  7 Jul 2026 17:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783445511;
 bh=VHdGF8VIioyNTgu3ijKz4cGYyECxyTrdgnyYVGAeAjM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=Ez7YiLFaxCK9G3ShVWXb+NlWsunhn5IIqAVWhjMhaUK8xM0WYYf8V5cJcjwxu/X98
 PTBCaWa6AHwbImA4z1YtOLO9vzIlkBDKZpHEUU4IO3rkjCkz9dcyxRRx7RmpiWKyug
 buw9B48EgcmreYqh2BNugp3wMKQMm1TKlRVf4gCRdx6oUrgJyMU3G1ht4YT1aUmkoJ
 ACuzXDU8VXa0MMa1vZhoBQ8e3yIBXYzLw+ownjWr+p+YnKqXej5qkBwQ5upDZsNIPo
 kGHs5zz7z6+WphWFGHiGAyNUFsUlGzaQ0ro7qDh6kvefawMsW13Ts0K9Ulq3Vmwczu
 s9qUeDlXLfdCQ==
Message-ID: <49f7d3cd-502d-4c4e-8166-2d1c68d792a0@kernel.org>
Date: Tue, 7 Jul 2026 12:31:49 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] accel/amdxdna: Check init_srcu_struct() return value
To: Lizhi Hou <lizhi.hou@amd.com>, ogabbay@kernel.org,
 quic_jhugo@quicinc.com, dri-devel@lists.freedesktop.org,
 karol.wachowski@linux.intel.com
Cc: linux-kernel@vger.kernel.org, max.zhen@amd.com, sonal.santan@amd.com
References: <20260707172323.539721-1-lizhi.hou@amd.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260707172323.539721-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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



On 7/7/26 12:23, Lizhi Hou wrote:
> The return value of init_srcu_struct() is currently ignored. If
> initialization fails, subsequent use of hwctx_srcu may result in invalid
> memory accesses.
> 
> Check the return value of init_srcu_struct() and propagate the error to
> the caller.
> 
> Fixes: aac243092b70 ("accel/amdxdna: Add command execution")
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
>   drivers/accel/amdxdna/amdxdna_pci_drv.c | 16 +++++++++++++---
>   1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.c b/drivers/accel/amdxdna/amdxdna_pci_drv.c
> index 86e9c230875a..bb339e641416 100644
> --- a/drivers/accel/amdxdna/amdxdna_pci_drv.c
> +++ b/drivers/accel/amdxdna/amdxdna_pci_drv.c
> @@ -109,11 +109,16 @@ static int amdxdna_drm_open(struct drm_device *ddev, struct drm_file *filp)
>   {
>   	struct amdxdna_dev *xdna = to_xdna_dev(ddev);
>   	struct amdxdna_client *client;
> +	int ret;
>   
>   	client = kzalloc_obj(*client);
>   	if (!client)
>   		return -ENOMEM;
>   
> +	ret = init_srcu_struct(&client->hwctx_srcu);
> +	if (ret)
> +		goto free_client;
> +
>   	client->pid = pid_nr(rcu_access_pointer(filp->pid));
>   	client->xdna = xdna;
>   	client->pasid = IOMMU_PASID_INVALID;
> @@ -125,13 +130,12 @@ static int amdxdna_drm_open(struct drm_device *ddev, struct drm_file *filp)
>   			XDNA_WARN(xdna, "PASID not available for pid %d", client->pid);
>   			if (!amdxdna_use_carveout(xdna)) {
>   				XDNA_ERR(xdna, "PASID unavailable and carveout not configured");
> -				kfree(client);
> -				return -EINVAL;
> +				ret = -EINVAL;
> +				goto cleanup_srcu;
>   			}
>   		}
>   	}
>   	mmgrab(client->mm);
> -	init_srcu_struct(&client->hwctx_srcu);
>   	xa_init_flags(&client->hwctx_xa, XA_FLAGS_ALLOC);
>   	xa_init_flags(&client->dev_heap_xa, XA_FLAGS_ALLOC);
>   	drm_mm_init(&client->dev_heap_mm, xdna->dev_info->dev_mem_base,
> @@ -149,6 +153,12 @@ static int amdxdna_drm_open(struct drm_device *ddev, struct drm_file *filp)
>   
>   	XDNA_DBG(xdna, "pid %d opened", client->pid);
>   	return 0;
> +
> +cleanup_srcu:
> +	cleanup_srcu_struct(&client->hwctx_srcu);
> +free_client:
> +	kfree(client);
> +	return ret;
>   }
>   
>   static void amdxdna_client_cleanup(struct amdxdna_client *client)

