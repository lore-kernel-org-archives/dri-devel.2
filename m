Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DBE1CA5FA5
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 17:55:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8649A10EFD9;
	Tue, 29 Sep 2026 17:55:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KzZh3EOX";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2A4610EFD9
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 17:55:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B306B43722;
 Tue, 29 Sep 2026 17:55:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04EEA1F000FF;
 Tue, 29 Sep 2026 17:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790704501;
 bh=0EfffRw/+03BAbp7AMM/PV5HJzThLd289Q9U5wd/r5I=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=KzZh3EOXex/TIHNhJ04IeA9tMniD1Hlk7KN8GcKToU1mTRqGulAKdi462nFsFpgQo
 lr1X5EXaM8SogI8WCEPT/1rWw+dK4sOP5wBz4JCwM5Y4s7ERm8SRfGjG7dFZG3gHJx
 PU5elTeLWctEa6rm3Bt9rtjV0ROggRSKtuRXnV4TnXrjnSNufQhWTKA2vWs+4H7ID9
 Oud+lr8GUO5dRzAEB0SneZms6DJOdOEcbuFZl1H1auaaovY9IO78U0wyRQoIL0QaBe
 /zG4y9eaNOk+wpJ2dO37+XDwZVKAlkcyGqqRGG4k0Cst1j9g+6mFTP3Hwn4wGCqS5Z
 yn3KryVSaRIAw==
Message-ID: <3a8057f6-7174-407b-97e4-4b1a32a17d6e@kernel.org>
Date: Tue, 29 Sep 2026 12:54:59 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] accel/amdxdna: Add support for AIE2 revision 9
Content-Language: en-US
To: Lizhi Hou <lizhi.hou@amd.com>, ogabbay@kernel.org,
 quic_jhugo@quicinc.com, dri-devel@lists.freedesktop.org,
 karol.wachowski@linux.intel.com, max.zhen@amd.com
Cc: linux-kernel@vger.kernel.org, sonal.santan@amd.com
References: <20260929175428.925657-1-lizhi.hou@amd.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260929175428.925657-1-lizhi.hou@amd.com>
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



On 9/29/26 12:54, Lizhi Hou wrote:
> aie2_get_dev_revision() fails to recognize AIE2 revision 9 hardware.
> Add AIE2_DEV_REVISION_GRGH to the list of supported AIE2 revisions.
> 
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> ---
>   drivers/accel/amdxdna/aie2_msg_priv.h | 1 +
>   1 file changed, 1 insertion(+)
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

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
