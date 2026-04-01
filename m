Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DBE3107636D
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 05:45:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B621810EC5A;
	Wed,  1 Apr 2026 05:45:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="HAZ5RLE+";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7AF710EC5A
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 05:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1775022311;
 bh=lVPcnMXVl0NGUZK2Q9WGlhvwy2OEuhJTYDneXCnFpv4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=HAZ5RLE+EKAserOvL/8jxdwQXxHYSHuQ9EO9TDrK8j27sepgj7SZO/XMGMLnWSdch
 66zQT9FC7NwoF89GOglCdM56YvM+zXQUfv+XPVt8DPhtRW2VEg2WmBD2DihdyiLjhj
 +eRcjrvr+zAYSkz0/J00z3tDepqCvrlNmuEBwdQMny0+//EUcfkJK48cm7n9YzJJ7I
 mFXQ7QzemPAAVxloaJazmZL6dM8a8Y2oTM1UfsIj6iIr326M1Q/eQVRiWG6KjMhHtr
 L7l/+PciTRWqMhdd/WmASPDL+7py4jd8qcOD7bJtCHHzYbDgH8c15nEaXpL8X675lO
 qlB2xed7ZWihQ==
Received: from [192.168.50.190] (unknown [171.76.80.25])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: vignesh)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 2A82F17E6F42;
 Wed,  1 Apr 2026 07:45:08 +0200 (CEST)
Message-ID: <dfa88f76-02d9-46a3-8bd8-bba0f14defa6@collabora.com>
Date: Wed, 1 Apr 2026 11:14:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] drm/ci: bump IGT version to v2.3
To: Jim Cromie <jim.cromie@gmail.com>, linux-kernel@vger.kernel.org
Cc: helen.fornazier@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org
References: <20260319161159.1149822-1-jim.cromie@gmail.com>
Content-Language: en-US
From: Vignesh Raman <vignesh.raman@collabora.com>
In-Reply-To: <20260319161159.1149822-1-jim.cromie@gmail.com>
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

Hi Jim,

On 19/03/26 21:41, Jim Cromie wrote:
> IGT_VERSION is currently pinned to a sha thats ~1100 behind HEAD
> 
> Lets bump it to the latest milestone/tag at v2.3
> Thats now only ~630 behind.
> Can we haz a v2.4 ?
> 
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> ---
>   drivers/gpu/drm/ci/gitlab-ci.yml | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/ci/gitlab-ci.yml b/drivers/gpu/drm/ci/gitlab-ci.yml
> index 56638814bb28..d546bd123a63 100644
> --- a/drivers/gpu/drm/ci/gitlab-ci.yml
> +++ b/drivers/gpu/drm/ci/gitlab-ci.yml
> @@ -5,7 +5,7 @@ variables:
>     UPSTREAM_REPO: https://gitlab.freedesktop.org/drm/kernel.git
>     TARGET_BRANCH: drm-next
>   
> -  IGT_VERSION: 129d5b10baaadea1d6cd6377341c4cb42e7ee6fd
> +  IGT_VERSION: v2.3

Thanks for the patch. We also need to update the expectation files along 
with this igt uprev. Are you planning to do it?

Regards,
Vignesh

>   
>     DEQP_RUNNER_GIT_URL: https://gitlab.freedesktop.org/mesa/deqp-runner.git
>     DEQP_RUNNER_GIT_TAG: v0.20.0

