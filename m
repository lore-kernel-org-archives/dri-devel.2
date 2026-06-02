Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF637CD6E57
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 14:15:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F923113A41;
	Tue,  2 Jun 2026 14:15:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FzIndssp";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 138A9113A41
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 14:15:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DD3984375A;
 Tue,  2 Jun 2026 14:15:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 350351F00898;
 Tue,  2 Jun 2026 14:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780409717;
 bh=/S4uTVapdLU0sd/YpjekF5puLg0al+/sVtt11aPqiOI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=FzIndssp7qs0XOpfNQP7xODvHhiCA4sd2B8t7A4BBMUHo13opUuKf3yzyFs8gJZ//
 m+7x4nzbYuCsG422mDvp5dlrstqZ4MLGaVuYRh85lykUjzJUjnNfzGtZvWybmVGAsT
 pfE+tWx5R1Sbgt0EuykzjFHH5+q/0i5dnbeHO1Pbo8KK9xbCLeiidFh5IFfrJ5qFq9
 vp6lHUf0v0/PBQ0Igik6t7zvvkXJUdHbkx4Xt9VJZgvQsd7H5TiBkh9XbrtsjsMbAE
 NEzDGGLvkEyzZoY4iTp/m96DKBSsmofecLSW1Lim7NENPM0eXMQtqhrw+kZJyCDnmU
 OrBLiOLV/OOeA==
Message-ID: <eec37a38-39b3-4a83-9024-a0e6d916ce54@kernel.org>
Date: Tue, 2 Jun 2026 09:15:16 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] accel/amdxdna: Preserve user address when PASID is
 disabled
Content-Language: en-US
To: Lizhi Hou <lizhi.hou@amd.com>, ogabbay@kernel.org,
 quic_jhugo@quicinc.com, dri-devel@lists.freedesktop.org,
 karol.wachowski@linux.intel.com
Cc: linux-kernel@vger.kernel.org, max.zhen@amd.com, sonal.santan@amd.com
References: <20260602040624.2206774-1-lizhi.hou@amd.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260602040624.2206774-1-lizhi.hou@amd.com>
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



On 6/1/26 23:06, Lizhi Hou wrote:
> When PASID is not used, the buffer user address is set to
> AMDXDNA_INVALID_ADDR. As a result, heap buffer user address validation
> fails even though the original userspace address is available.
> 
> Preserve the userspace address regardless of PASID usage so heap buffer
> address validation works correctly.
> 
> Fixes: dbc8fd7a03cb ("accel/amdxdna: Add expandable device heap support")
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
>   drivers/accel/amdxdna/amdxdna_gem.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
> index 77e5fad08ae5..33cf5af98ceb 100644
> --- a/drivers/accel/amdxdna/amdxdna_gem.c
> +++ b/drivers/accel/amdxdna/amdxdna_gem.c
> @@ -349,8 +349,11 @@ static int amdxdna_hmm_register(struct amdxdna_gem_obj *abo,
>   	u32 nr_pages;
>   	int ret;
>   
> -	if (!amdxdna_pasid_on(abo->client))
> +	if (!amdxdna_pasid_on(abo->client)) {
> +		/* Need to set uva for heap uva validation */
> +		abo->mem.uva = addr;
>   		return 0;
> +	}
>   
>   	mapp = kzalloc_obj(*mapp);
>   	if (!mapp)

