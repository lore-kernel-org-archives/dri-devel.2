Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDED2CD8CB2
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 22:44:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8BEE10E3D4;
	Tue,  9 Jun 2026 22:44:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FFE3rWEv";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4D7F10E3D4
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 22:44:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0A1C240A98;
 Tue,  9 Jun 2026 22:44:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37D441F00893;
 Tue,  9 Jun 2026 22:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781045057;
 bh=LpyHzXW8GjLw4GoaJ8bmNMFISB5FIvBT1/CLylx/Vww=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=FFE3rWEv3mUR9JtRpXN5TkCXcIk7V3PMyzg8neUQ6SDbgAZA/xJqaO8A+wlfNuJMV
 STkxfvkOhPS0W5+9v5+KxRP7MV0dxp/VkQemvRHhiuNFTuhfFQGdU0dT9yHwEkQcU9
 kqQqumorEBdVWhoE9sHcrqUgRWagM9I+BPF0EdsT3PAktY6H/EPL9wpepziUWYbJiD
 ZPYY739tXI5rDwtCARMA/6dLWSGCY0iZoVKXoFt/LS+iH8EtV4qwg2O9082K+8Gaa4
 cfV7EMPnoDUeRepVDRYLUCpNEFOWM1nMiMUyZHa9So4nRuWeupAxHfbQTOfC/h52Eu
 71wkVG2e35aXw==
Message-ID: <77abee6c-922c-4079-a89d-35fa285df49a@kernel.org>
Date: Tue, 9 Jun 2026 17:44:16 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] accel/amdxdna: Clear sva pointer after unbind
To: Lizhi Hou <lizhi.hou@amd.com>, ogabbay@kernel.org,
 quic_jhugo@quicinc.com, dri-devel@lists.freedesktop.org,
 karol.wachowski@linux.intel.com
Cc: linux-kernel@vger.kernel.org, max.zhen@amd.com, sonal.santan@amd.com
References: <20260604202815.2425882-1-lizhi.hou@amd.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260604202815.2425882-1-lizhi.hou@amd.com>
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



On 6/4/26 15:28, Lizhi Hou wrote:
> Add client->sva = NULL after the unbind makes it consistent with how
> amdxdna_sva_fini() already clears the pointer after unbinding. The
> IS_ERR_OR_NULL guard in sva_fini will then correctly skip the second
> unbind.
> 
> Fixes: 3cc5d7a59519 ("accel/amdxdna: Add carveout memory support for non-IOMMU systems")
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
>   drivers/accel/amdxdna/amdxdna_pci_drv.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.c b/drivers/accel/amdxdna/amdxdna_pci_drv.c
> index 1f066ed8d236..65489bb3f2b0 100644
> --- a/drivers/accel/amdxdna/amdxdna_pci_drv.c
> +++ b/drivers/accel/amdxdna/amdxdna_pci_drv.c
> @@ -87,6 +87,7 @@ static int amdxdna_sva_init(struct amdxdna_client *client)
>   	client->pasid = iommu_sva_get_pasid(client->sva);
>   	if (client->pasid == IOMMU_PASID_INVALID) {
>   		iommu_sva_unbind_device(client->sva);
> +		client->sva = NULL;
>   		XDNA_ERR(xdna, "SVA get pasid failed");
>   		return -ENODEV;
>   	}

