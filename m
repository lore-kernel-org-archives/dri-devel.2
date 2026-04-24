Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2E12FED3C9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 13:30:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F0FD10F594;
	Fri, 24 Apr 2026 13:30:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KHv26dpB";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35AF310F594
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 13:30:22 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 7C05A6001A;
 Fri, 24 Apr 2026 13:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78A69C19425;
 Fri, 24 Apr 2026 13:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777037421;
 bh=6xx/cqSPmGGq5SiVIeMj63/5yGyjb6+6H5Qsk2Hj8Ew=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=KHv26dpBitAOieQFueRFmWncLQ61m6IeEZIKgZGW5cfMLFC2FizUtSyVSr3J3+joD
 ORGEljE9Gy63Lpy9zlbW9maKXl06uhKwbAcivaIho1Tj85lhrCFx5Xkum1u/gqbEYp
 H+0ljf9900HdWdmDHVeujr5AI5FwllkyXy8jFgVnEP88VUm4rjGaR4+Lsw0QvsQEZZ
 K9h7gX7yMcNJWfPw5AnshjEuE3D6My4ZS5XSbqwHkSF3k5D9HbFwzrOkrizCpkJHWw
 E0vUzeH9sRfRo+uphqmV+prYFW7qBkMNv/0Y06MIqQ52XdBE4R/s9bnmjmiyJeP0Gd
 KQXW7PZ19w1eQ==
Message-ID: <cdd649b8-db85-4bfb-8c0f-2a099201f89a@kernel.org>
Date: Fri, 24 Apr 2026 08:30:19 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 3/3] accel/amdxdna: Set the system efficiency factor to
 2
Content-Language: en-US
To: Lizhi Hou <lizhi.hou@amd.com>, ogabbay@kernel.org,
 quic_jhugo@quicinc.com, dri-devel@lists.freedesktop.org,
 maciej.falkowski@linux.intel.com
Cc: Nishad Saraf <nishads@amd.com>, linux-kernel@vger.kernel.org,
 max.zhen@amd.com, sonal.santan@amd.com
References: <20260424040824.2253607-1-lizhi.hou@amd.com>
 <20260424040824.2253607-3-lizhi.hou@amd.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260424040824.2253607-3-lizhi.hou@amd.com>
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



On 4/23/26 23:08, Lizhi Hou wrote:
> From: Nishad Saraf <nishads@amd.com>
> 
> The system efficiency factor is used for QoS calculation. Change it to 2
> to account for the efficiency overhead.
> 
> Signed-off-by: Nishad Saraf <nishads@amd.com>
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
>   drivers/accel/amdxdna/aie2_pci.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/accel/amdxdna/aie2_pci.c b/drivers/accel/amdxdna/aie2_pci.c
> index a07e453a1721..f0ddb843eb21 100644
> --- a/drivers/accel/amdxdna/aie2_pci.c
> +++ b/drivers/accel/amdxdna/aie2_pci.c
> @@ -595,7 +595,7 @@ static int aie2_init(struct amdxdna_dev *xdna)
>   	xrs_cfg.clk_list.num_levels = ndev->max_dpm_level + 1;
>   	for (i = 0; i < xrs_cfg.clk_list.num_levels; i++)
>   		xrs_cfg.clk_list.cu_clk_list[i] = ndev->priv->dpm_clk_tbl[i].hclk;
> -	xrs_cfg.sys_eff_factor = 1;
> +	xrs_cfg.sys_eff_factor = 2;
>   	xrs_cfg.ddev = &xdna->ddev;
>   	xrs_cfg.actions = &aie2_xrs_actions;
>   	xrs_cfg.total_col = ndev->total_col;

