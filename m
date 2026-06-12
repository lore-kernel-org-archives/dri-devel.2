Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A24A5CD98D6
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 18:25:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FAAE10EAFD;
	Fri, 12 Jun 2026 18:25:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="O1kHwmd8";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 384C010EAFD
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 18:25:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 06ECC43705;
 Fri, 12 Jun 2026 18:25:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F13E1F00A3A;
 Fri, 12 Jun 2026 18:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781288742;
 bh=WaUf1YVYcCYJGuNoId8/t188E3/+RbJhWQtJZWB54eg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=O1kHwmd8/XDm/6WY3lxP5uVO2Ubpvz0SVTbloJqzlkCYWGNWY1CJGD3lR6J//O8cy
 S72r7IEqZr7sy5RpKMZZau6uMJ3vj3EsvKGpfV3fe61RqgZ/akE0jUdK4cOZDcCHAs
 CBVlmC00qKIABCpNQfA0VsYKijxQyRKbbpnhr+dOMyQtl4BGwJbxMkZUr22O2h4uRz
 ZwMu3xFrUFL9pz5aiRQs8xJh9BnUAZ0qfTfS54C8Wcjm2s0Zs+2TRPcMFRCICcIQr4
 ruVGqLoMKIISrRbSk9TEak5sK+gt2myOcuGqk+/YUFAynG5hL28GB+c4S0I4FMXgBt
 GCGIyGc01KgkQ==
Message-ID: <7a9d6acd-90db-4dfe-9fe5-55ba8adab577@kernel.org>
Date: Fri, 12 Jun 2026 13:25:41 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 1/3] accel/amdxdna: Fix amdxdna_client lifetime race
 during device removal
Content-Language: en-US
To: Lizhi Hou <lizhi.hou@amd.com>, ogabbay@kernel.org,
 quic_jhugo@quicinc.com, dri-devel@lists.freedesktop.org,
 karol.wachowski@linux.intel.com
Cc: linux-kernel@vger.kernel.org, max.zhen@amd.com, sonal.santan@amd.com
References: <20260611055150.3070216-1-lizhi.hou@amd.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260611055150.3070216-1-lizhi.hou@amd.com>
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



On 6/11/26 00:51, Lizhi Hou wrote:
> In amdxdna_remove(), all amdxdna_client structures are freed after
> calling drm_dev_unplug(). However, drm_dev_unplug() does not force
> existing file descriptors to be closed, so amdxdna_drm_close() may be
> called after amdxdna_remove() has completed.
> 
> As a result, accessing client->pid for debug output in
> amdxdna_drm_close() can lead to a use-after-free, since the access is
> not protected by drm_dev_enter().
> 
> Fix this by decoupling hardware teardown from client cleanup.
> amdxdna_remove() only performs hardware-related cleanup, while
> per-client resources are released from amdxdna_drm_close() when the
> corresponding file is closed.
> 
> Fixes: be462c97b7df ("accel/amdxdna: Add hardware context")
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
>   drivers/accel/amdxdna/amdxdna_pci_drv.c | 23 ++++++++++-------------
>   drivers/accel/amdxdna/amdxdna_pci_drv.h |  1 +
>   2 files changed, 11 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.c b/drivers/accel/amdxdna/amdxdna_pci_drv.c
> index 65489bb3f2b0..470bf4fc744b 100644
> --- a/drivers/accel/amdxdna/amdxdna_pci_drv.c
> +++ b/drivers/accel/amdxdna/amdxdna_pci_drv.c
> @@ -138,9 +138,11 @@ static int amdxdna_drm_open(struct drm_device *ddev, struct drm_file *filp)
>   		    xdna->dev_info->dev_heap_max_size);
>   	mutex_init(&client->mm_lock);
>   
> +	mutex_lock(&xdna->client_lock);
>   	mutex_lock(&xdna->dev_lock);
>   	list_add_tail(&client->node, &xdna->client_list);
>   	mutex_unlock(&xdna->dev_lock);
> +	mutex_unlock(&xdna->client_lock);
>   
>   	filp->driver_priv = client;
>   	client->filp = filp;
> @@ -174,18 +176,14 @@ static void amdxdna_drm_close(struct drm_device *ddev, struct drm_file *filp)
>   {
>   	struct amdxdna_client *client = filp->driver_priv;
>   	struct amdxdna_dev *xdna = to_xdna_dev(ddev);
> -	int idx;
>   
>   	XDNA_DBG(xdna, "closing pid %d", client->pid);
>   
> -	if (!drm_dev_enter(&xdna->ddev, &idx))
> -		return;
> -
> +	mutex_lock(&xdna->client_lock);
>   	mutex_lock(&xdna->dev_lock);
>   	amdxdna_client_cleanup(client);
>   	mutex_unlock(&xdna->dev_lock);
> -
> -	drm_dev_exit(idx);
> +	mutex_unlock(&xdna->client_lock);
>   }
>   
>   static int amdxdna_drm_get_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
> @@ -372,6 +370,7 @@ static int amdxdna_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   		return -ENODEV;
>   
>   	drmm_mutex_init(ddev, &xdna->dev_lock);
> +	drmm_mutex_init(ddev, &xdna->client_lock);
>   	init_rwsem(&xdna->notifier_lock);
>   	INIT_LIST_HEAD(&xdna->client_list);
>   	pci_set_drvdata(pdev, xdna);
> @@ -442,18 +441,16 @@ static void amdxdna_remove(struct pci_dev *pdev)
>   	drm_dev_unplug(&xdna->ddev);
>   	amdxdna_sysfs_fini(xdna);
>   
> +	mutex_lock(&xdna->client_lock);
>   	mutex_lock(&xdna->dev_lock);
> -	client = list_first_entry_or_null(&xdna->client_list,
> -					  struct amdxdna_client, node);
> -	while (client) {
> -		amdxdna_client_cleanup(client);
> -
> -		client = list_first_entry_or_null(&xdna->client_list,
> -						  struct amdxdna_client, node);
> +	list_for_each_entry(client, &xdna->client_list, node) {
> +		amdxdna_hwctx_remove_all(client);
> +		amdxdna_sva_fini(client);
>   	}
>   
>   	xdna->dev_info->ops->fini(xdna);
>   	mutex_unlock(&xdna->dev_lock);
> +	mutex_unlock(&xdna->client_lock);
>   
>   	amdxdna_iommu_fini(xdna);
>   }
> diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.h b/drivers/accel/amdxdna/amdxdna_pci_drv.h
> index 34271c14d359..a997d27a504d 100644
> --- a/drivers/accel/amdxdna/amdxdna_pci_drv.h
> +++ b/drivers/accel/amdxdna/amdxdna_pci_drv.h
> @@ -120,6 +120,7 @@ struct amdxdna_dev {
>   
>   	struct mutex			dev_lock; /* per device lock */
>   	struct list_head		client_list;
> +	struct mutex			client_lock; /* client_list */
>   	struct amdxdna_fw_ver		fw_ver;
>   	struct rw_semaphore		notifier_lock; /* for mmu notifier*/
>   	struct workqueue_struct		*notifier_wq;

