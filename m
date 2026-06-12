Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22AA6CD98D2
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 18:26:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C38310EB07;
	Fri, 12 Jun 2026 18:26:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NlJAul/y";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C76DD10F604
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 18:26:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0FD12601E2;
 Fri, 12 Jun 2026 18:26:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C1D81F000E9;
 Fri, 12 Jun 2026 18:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781288774;
 bh=wOea2Ye6ENtPHQE7QpRHQxyqzhCYN0SXleObykbZXk0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=NlJAul/yiejd5UhYzPpXYQ9C0jaANZIZl/2bNjuKqjnuPldStWIJWgfv3x1txQqho
 uMbqaNArYfjZXkai+WsKWLtgGxRnptMzS66KCpf4JkriwTayL8VsM2PsP1FeL3nw+B
 xqT7MMtAKt1GDNKADcE43Lku1+nP+lvvj7LzoGE5AvgfQH9MoHY8TEw97A9UqmqvhV
 8a5eAPI6K+D2sQB7Bpvaj7JZgH8s+86HKkRX43vYhStX1clVIQ/4mY1VzKWCLix2/7
 r98nu3/00G9YS5gS5DtKPBwh0sh/ytqEjIH2xRM3QNqhccjgUf6dN89fhrYWg6j1F+
 VQUy9hPUnEnTg==
Message-ID: <3f22f651-c99e-402d-b373-329189a96863@kernel.org>
Date: Fri, 12 Jun 2026 13:26:13 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 2/3] accel/amdxdna: Fix notifier_wq lifetime race
 during device removal
Content-Language: en-US
To: Lizhi Hou <lizhi.hou@amd.com>, ogabbay@kernel.org,
 quic_jhugo@quicinc.com, dri-devel@lists.freedesktop.org,
 karol.wachowski@linux.intel.com
Cc: linux-kernel@vger.kernel.org, max.zhen@amd.com, sonal.santan@amd.com
References: <20260611055150.3070216-1-lizhi.hou@amd.com>
 <20260611055150.3070216-2-lizhi.hou@amd.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260611055150.3070216-2-lizhi.hou@amd.com>
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
> amdxdna_remove() destroys notifier_wq. If amdxdna_gem_obj_free() is
> called after device removal, it may attempt to flush notifier_wq,
> resulting in a use-after-free.
> 
> Fix the race by allocating notifier_wq with
> drmm_alloc_ordered_workqueue(), so its lifetime is managed by DRM and
> remains valid until all managed resources are released.
> 
> Fixes: e486147c912f ("accel/amdxdna: Add BO import and export")
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
>   drivers/accel/amdxdna/amdxdna_pci_drv.c | 12 ++++--------
>   1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.c b/drivers/accel/amdxdna/amdxdna_pci_drv.c
> index 470bf4fc744b..b943c06a451e 100644
> --- a/drivers/accel/amdxdna/amdxdna_pci_drv.c
> +++ b/drivers/accel/amdxdna/amdxdna_pci_drv.c
> @@ -389,9 +389,9 @@ static int amdxdna_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   	if (ret)
>   		return ret;
>   
> -	xdna->notifier_wq = alloc_ordered_workqueue("notifier_wq", WQ_MEM_RECLAIM);
> -	if (!xdna->notifier_wq) {
> -		ret = -ENOMEM;
> +	xdna->notifier_wq = drmm_alloc_ordered_workqueue(ddev, "notifier_wq", WQ_MEM_RECLAIM);
> +	if (IS_ERR(xdna->notifier_wq)) {
> +		ret = PTR_ERR(xdna->notifier_wq);
>   		goto iommu_fini;
>   	}
>   
> @@ -400,7 +400,7 @@ static int amdxdna_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   	mutex_unlock(&xdna->dev_lock);
>   	if (ret) {
>   		XDNA_ERR(xdna, "Hardware init failed, ret %d", ret);
> -		goto destroy_notifier_wq;
> +		goto iommu_fini;
>   	}
>   
>   	ret = amdxdna_sysfs_init(xdna);
> @@ -424,8 +424,6 @@ static int amdxdna_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   	mutex_lock(&xdna->dev_lock);
>   	xdna->dev_info->ops->fini(xdna);
>   	mutex_unlock(&xdna->dev_lock);
> -destroy_notifier_wq:
> -	destroy_workqueue(xdna->notifier_wq);
>   iommu_fini:
>   	amdxdna_iommu_fini(xdna);
>   	return ret;
> @@ -436,8 +434,6 @@ static void amdxdna_remove(struct pci_dev *pdev)
>   	struct amdxdna_dev *xdna = pci_get_drvdata(pdev);
>   	struct amdxdna_client *client;
>   
> -	destroy_workqueue(xdna->notifier_wq);
> -
>   	drm_dev_unplug(&xdna->ddev);
>   	amdxdna_sysfs_fini(xdna);
>   

