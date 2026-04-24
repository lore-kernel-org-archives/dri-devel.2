Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AED5FED3CB
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 13:29:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 770FA10F439;
	Fri, 24 Apr 2026 13:29:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="crnQVCDg";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5689410F439
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 13:29:07 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 746FB600AE;
 Fri, 24 Apr 2026 13:29:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A168C2BCB2;
 Fri, 24 Apr 2026 13:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777037346;
 bh=7/Slp01bWIa+nBHpfxnHdx0JY+Y1XCFf8Fo2v7B0Z9M=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=crnQVCDg4F/PxuSUXZdQjCSxtFp+UT8XoZxuJksKwlnBYLUHTKBaurPvmKqlTW4Zz
 b5+vh3/RS0mzyTtYWjhUCuifFsyzwYR6kFmls0q2d7Gnc57tlBKk9Xq1eFmNZUbEUi
 fJAZi70q5DUxxeiqC76COHX4Z9l9Pa4V9upW3YrYYJIWHXiFw6UCycZs3NSlKsuCVy
 yA4f692klgPtogr3hlSdmRAIL7nMnWU+csdxuVFV4W3KPYu4C7IJZaF3JyD5x6m/y3
 F0b3d0KOestYiomjnwgdhSKIDz1hHGjUlYKpuHIXCd4zxT5paIVRjkQVdbmlLpoOpz
 /kOhK6C9L71MQ==
Message-ID: <142638ac-4fbf-4397-9811-690163e426bf@kernel.org>
Date: Fri, 24 Apr 2026 08:29:04 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 2/3] accel/amdxdna: Add configuring low and medium
 power mode
Content-Language: en-US
To: Lizhi Hou <lizhi.hou@amd.com>, ogabbay@kernel.org,
 quic_jhugo@quicinc.com, dri-devel@lists.freedesktop.org,
 maciej.falkowski@linux.intel.com
Cc: Nishad Saraf <nishads@amd.com>, linux-kernel@vger.kernel.org,
 max.zhen@amd.com, sonal.santan@amd.com
References: <20260424040824.2253607-1-lizhi.hou@amd.com>
 <20260424040824.2253607-2-lizhi.hou@amd.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260424040824.2253607-2-lizhi.hou@amd.com>
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
> Add support for POWER_MODE_LOW and POWER_MODE_MEDIUM.
> 
> Signed-off-by: Nishad Saraf <nishads@amd.com>
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
>   drivers/accel/amdxdna/aie2_pm.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/accel/amdxdna/aie2_pm.c b/drivers/accel/amdxdna/aie2_pm.c
> index d9ccd7fc8a6d..4fe6030d2c41 100644
> --- a/drivers/accel/amdxdna/aie2_pm.c
> +++ b/drivers/accel/amdxdna/aie2_pm.c
> @@ -108,6 +108,14 @@ int aie2_pm_set_mode(struct amdxdna_dev_hdl *ndev, enum amdxdna_power_mode_type
>   		clk_gating = AIE2_CLK_GATING_ENABLE;
>   		dpm_level = ndev->dft_dpm_level;
>   		break;
> +	case POWER_MODE_LOW:
> +		clk_gating = AIE2_CLK_GATING_ENABLE;
> +		dpm_level = 0;
> +		break;
> +	case POWER_MODE_MEDIUM:
> +		clk_gating = AIE2_CLK_GATING_ENABLE;
> +		dpm_level = ndev->max_dpm_level / 2;
> +		break;
>   	default:
>   		return -EOPNOTSUPP;
>   	}

