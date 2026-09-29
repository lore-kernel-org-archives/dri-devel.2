Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFBF1CA5FA7
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 18:24:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E10010E45E;
	Tue, 29 Sep 2026 18:24:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Kx10XmVa";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D63E10E45E
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 18:24:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D34AE6022B;
 Tue, 29 Sep 2026 18:24:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB9B81F000FF;
 Tue, 29 Sep 2026 18:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790706289;
 bh=IrC4cWja7TCbiw78bWvPQDNptyMl3nO7KwA5wFFZroM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=Kx10XmVaId7/ri+3fc2IQCfjoT77F2zkVT1y3XpBpPg1MeDypM6MiusbI3Z3/3fBF
 J0NIei3R+KW0yrrUGtvdIbJKuJ7jPvOnDYilQTMoMI6rPFMLkr3c8li8a5v8dVQc5w
 n/M5AvU8AX2zh17e8hDhJ56IklMa34rdhPZNhgcKhLyjTY9oE6hd+EKP1blcO/1dYY
 PoVqwOAem5fmGafiqQp/3gviF+hMWyFhwpSP5POVg2UfWsmRWxo6u4HX3JIw5wRw2i
 lqMtOY+rTMEPAchZT0vJlzGCCP/u3fqtGClOpvH4u3k7MACz6iFTQOQgB2UbFiVPoy
 kP2Vfq6YFOumQ==
Message-ID: <aee76270-590d-4d2b-93ca-23e56bc3f482@kernel.org>
Date: Tue, 29 Sep 2026 13:24:47 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] accel/amdxdna: Add support for AIE2 revision 9
Content-Language: en-US
To: Lizhi Hou <lizhi.hou@amd.com>, ogabbay@kernel.org,
 quic_jhugo@quicinc.com, dri-devel@lists.freedesktop.org,
 karol.wachowski@linux.intel.com, max.zhen@amd.com
Cc: linux-kernel@vger.kernel.org, sonal.santan@amd.com
References: <20260929181459.928468-1-lizhi.hou@amd.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260929181459.928468-1-lizhi.hou@amd.com>
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



On 9/29/26 13:14, Lizhi Hou wrote:
> aie2_get_dev_revision() fails to recognize AIE2 revision 9 hardware.
> Add AIE2_DEV_REVISION_GRGH to the list of supported AIE2 revisions.
> 
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>> ---
> V2:
>    Fix sashiko comment: add the revision string.
> 
>   drivers/accel/amdxdna/aie2_msg_priv.h | 1 +
>   drivers/accel/amdxdna/npu4_regs.c     | 1 +
>   2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/accel/amdxdna/aie2_msg_priv.h b/drivers/accel/amdxdna/aie2_msg_priv.h
> index fd65a4236d49..8ed2b5701dcc 100644
> --- a/drivers/accel/amdxdna/aie2_msg_priv.h
> +++ b/drivers/accel/amdxdna/aie2_msg_priv.h
> @@ -530,6 +530,7 @@ enum aie2_dev_revision {
>   	AIE2_DEV_REVISION_GPT1,
>   	AIE2_DEV_REVISION_GPT2,
>   	AIE2_DEV_REVISION_GPT3,
> +	AIE2_DEV_REVISION_GRGH,
>   	AIE2_DEV_REVISION_UNKN,
>   };
>   
> diff --git a/drivers/accel/amdxdna/npu4_regs.c b/drivers/accel/amdxdna/npu4_regs.c
> index 15a161384625..c9648c8032ec 100644
> --- a/drivers/accel/amdxdna/npu4_regs.c
> +++ b/drivers/accel/amdxdna/npu4_regs.c
> @@ -153,6 +153,7 @@ const struct amdxdna_rev_vbnv npu4_rev_vbnv_tbl[] = {
>   	{ AIE2_DEV_REVISION_GPT1, "NPU Gorgon Point 1" },
>   	{ AIE2_DEV_REVISION_GPT2, "NPU Gorgon Point 2" },
>   	{ AIE2_DEV_REVISION_GPT3, "NPU Gorgon Point 3" },
> +	{ AIE2_DEV_REVISION_GRGH, "NPU Gorgon Halo" },
>   	{ 0 }
>   };
>   

