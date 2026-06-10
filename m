Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C811CD8CB9
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 15:19:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B6C310EA0B;
	Wed, 10 Jun 2026 15:19:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jJJFwOBH";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 181B610E636
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 15:19:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5F53C601DC;
 Wed, 10 Jun 2026 15:18:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F4051F00893;
 Wed, 10 Jun 2026 15:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781104739;
 bh=o9Ik1GACm73QYOyXh8LuD/Uz8CRsPYiYSxvMxY71LgY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=jJJFwOBHDKNWsCAr82VQW4E3e7Stp0ystBa1ttDJ2Rl9mK/bkEW2WrztSNzzNy2GY
 lCSCIJCb+14R1WSKx3n+I7SldsjFvXVCU9fS0ptPO7pdJ3Ph0go+MeMJIz/JFjL5In
 YcCUhmWZyT0TnsCrbq6z6Ru4vD5lSm06xwGEXH6fmnUV9m5q1c/p7C2Wq0Wf5OoUqE
 9FkvBGcJC4cti1aLONNp5DIUwMCk0UPyfavCU0sMkEDk96Q4l6d9c1c/DWALYu/mvP
 vw8uRJ85z4lOyzg5sKFFUP9f7XynnkPpJ7LsHm+RY8O9i9yA/CkZL6/E84WjRYtrqj
 NnJPh065VrUTA==
Message-ID: <621cc992-5de2-455b-a488-f89ed2a9a91a@kernel.org>
Date: Wed, 10 Jun 2026 10:18:57 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] accel/amdxdna: Fix mm_struct reference leak in
 aie2_populate_range()
Content-Language: en-US
To: Lizhi Hou <lizhi.hou@amd.com>, ogabbay@kernel.org,
 quic_jhugo@quicinc.com, dri-devel@lists.freedesktop.org,
 karol.wachowski@linux.intel.com
Cc: linux-kernel@vger.kernel.org, max.zhen@amd.com, sonal.santan@amd.com
References: <20260610151127.2994185-1-lizhi.hou@amd.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260610151127.2994185-1-lizhi.hou@amd.com>
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



On 6/10/26 10:11, Lizhi Hou wrote:
> aie2_populate_range() jumps back to the again label without calling
> mmput(mm), leaking a reference to the mm_struct.
> 
> Add the missing mmput() before jumping to again.
> 
> Fixes: e486147c912f ("accel/amdxdna: Add BO import and export")
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
>   drivers/accel/amdxdna/aie2_ctx.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie2_ctx.c
> index 3e21e2dabe82..e0f30dbe0238 100644
> --- a/drivers/accel/amdxdna/aie2_ctx.c
> +++ b/drivers/accel/amdxdna/aie2_ctx.c
> @@ -1041,6 +1041,7 @@ static int aie2_populate_range(struct amdxdna_gem_obj *abo)
>   
>   		if (ret == -EBUSY) {
>   			amdxdna_umap_put(mapp);
> +			mmput(mm);
>   			goto again;
>   		}
>   
> @@ -1051,11 +1052,13 @@ static int aie2_populate_range(struct amdxdna_gem_obj *abo)
>   	if (mmu_interval_read_retry(&mapp->notifier, mapp->range.notifier_seq)) {
>   		up_write(&xdna->notifier_lock);
>   		amdxdna_umap_put(mapp);
> +		mmput(mm);
>   		goto again;
>   	}
>   	mapp->invalid = false;
>   	up_write(&xdna->notifier_lock);
>   	amdxdna_umap_put(mapp);
> +	mmput(mm);
>   	goto again;
>   
>   put_mm:

