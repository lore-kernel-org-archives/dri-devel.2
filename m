Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E9A9F8E48B
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 22:46:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F9DF10E243;
	Thu, 16 Apr 2026 22:46:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RqVzKkuh";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9587810E243
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 22:46:05 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id C5EDD6012B;
 Thu, 16 Apr 2026 22:46:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10DDBC2BCAF;
 Thu, 16 Apr 2026 22:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776379564;
 bh=toFQ5MEaMuNnsmV2mgoZVE1Hdneebn4aDRb7hpWdMnk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=RqVzKkuhIEsNJfUtSMs118ZKuIMcm6qUq1wWA4yvFpHRqDoihblVaF6oW+1nPQV4l
 v+iEZBdU0Qps3oV9tki7NJtzPUhVoFiEUGRaiUyocHA/99Uk9aB2S0dbuKAok0j5pe
 MMkPpGO8fyrclpeXyqM63ljzjtl/u1BX2CFesGiAPDlS51aNnX3KD6zcLICAxFMaMt
 mCXJLjnwhjQxSdjuePgGkk/t2k3cwrZOMPqrD//n6FYr38oVWsi9NyjEn00h0f9m0Q
 PQrzrBn2K7s0+VNUoRti0kcMjx0eG7t0vEMis/wIghzDiRuXxlfdLS6+37J3sNlpto
 jnlvCITqpkRiw==
Message-ID: <be49ee67-ff32-4cbe-9fa8-6a3c626a948d@kernel.org>
Date: Thu, 16 Apr 2026 17:46:00 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] accel/amdxdna: Guard management mailbox channel
 cleanup against NULL pointer
Content-Language: en-US
To: Lizhi Hou <lizhi.hou@amd.com>, ogabbay@kernel.org,
 quic_jhugo@quicinc.com, dri-devel@lists.freedesktop.org,
 maciej.falkowski@linux.intel.com
Cc: Max Zhen <max.zhen@amd.com>, linux-kernel@vger.kernel.org,
 sonal.santan@amd.com
References: <20260416201106.1046072-1-lizhi.hou@amd.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260416201106.1046072-1-lizhi.hou@amd.com>
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



On 4/16/26 15:11, Lizhi Hou wrote:
> From: Max Zhen <max.zhen@amd.com>
> 
> The management mailbox channel cleanup helpers can be called from
> error handling paths when mgmt_chann has already been destroyed.
> 
> Add NULL checks to xdna_mailbox_free_channel() and
> xdna_mailbox_stop_channel() so the cleanup path safely returns instead
> of dereferencing a NULL mailbox channel pointer.
> 
> Fixes: b87f920b9344 ("accel/amdxdna: Support hardware mailbox")
> Signed-off-by: Max Zhen <max.zhen@amd.com>
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> ---
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
>   drivers/accel/amdxdna/amdxdna_mailbox.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/accel/amdxdna/amdxdna_mailbox.c b/drivers/accel/amdxdna/amdxdna_mailbox.c
> index 336e5e77f18a..37771bdb24a1 100644
> --- a/drivers/accel/amdxdna/amdxdna_mailbox.c
> +++ b/drivers/accel/amdxdna/amdxdna_mailbox.c
> @@ -496,6 +496,9 @@ struct mailbox_channel *xdna_mailbox_alloc_channel(struct mailbox *mb)
>   
>   void xdna_mailbox_free_channel(struct mailbox_channel *mb_chann)
>   {
> +	if (!mb_chann)
> +		return;
> +
>   	destroy_workqueue(mb_chann->work_q);
>   	kfree(mb_chann);
>   }
> @@ -542,6 +545,9 @@ void xdna_mailbox_stop_channel(struct mailbox_channel *mb_chann)
>   	struct mailbox_msg *mb_msg;
>   	unsigned long msg_id;
>   
> +	if (!mb_chann)
> +		return;
> +
>   	/* Disable an irq and wait. This might sleep. */
>   	free_irq(mb_chann->msix_irq, mb_chann);
>   

