Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38BE2CD5BC8
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 08:13:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6BCD10E5D0;
	Tue, 26 May 2026 08:13:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=vignesh.raman@collabora.com header.b="N2XsJ7Zu";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBB6A10E5D0;
 Tue, 26 May 2026 08:13:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1779783227; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=k3bA9HZNIzRtUPkmE7kwEdDdWYNg8Aloog46APd+EBI91iqlgCkYTcmeu+VwXU+Sw46Jc/QCkOmZaQaeUiJASy7NrpRtLtV5sVL+Scec7eIP5a9CegKiEDvMGEwE3mJcbWEq9wxd9CLy6Pce61/sni7BEQ4/mwHcbZMHOX1Ua24=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1779783227;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=z57MFPRsdwTmrFHrY8/qbDvLzFQNW2cw6NkQLTP27iU=; 
 b=hpU22Gp48+Z0Wm97DWuzKpDSxvEs3nK3Jhxi56iDpdeyPjisXbv9qicq/DDDEqHyS3cyyUexsNTY4fND4bYJjeB4IPMofqlRl+ojNBsD12f89/4HzqfZeWz8vYOz7GPgq7qGYE5RhB6oGL2d4hnnrhignG0O5Q41z7x26/beKto=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=vignesh.raman@collabora.com;
 dmarc=pass header.from=<vignesh.raman@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779783227; 
 s=zohomail; d=collabora.com; i=vignesh.raman@collabora.com;
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=z57MFPRsdwTmrFHrY8/qbDvLzFQNW2cw6NkQLTP27iU=;
 b=N2XsJ7ZuTI0GBkgNN7kDh2yF6QLEPsugXHZZ3iyooyQIsKzksWv0PCuRazJr9/24
 I32TRZV2Q+65kefvmIgyYEXnOy9a+V/J33o7uaa+PXaLj1hWylgj8mf66KZtQG7t7c7
 xu59xxy2IqWO8SbveGXxMgJYKfmoyibp7E/Kx6gA=
Received: by mx.zohomail.com with SMTPS id 1779783214315576.654606631172;
 Tue, 26 May 2026 01:13:34 -0700 (PDT)
Message-ID: <e26a72b9-db14-42bd-9d3c-7e9620a71926@collabora.com>
Date: Tue, 26 May 2026 13:43:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/ci: disable mr-label-maker-test
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Helen Koike <helen.fornazier@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260522-drm-ci-mr-label-v1-1-39f778123b30@oss.qualcomm.com>
Content-Language: en-US
From: Vignesh Raman <vignesh.raman@collabora.com>
In-Reply-To: <20260522-drm-ci-mr-label-v1-1-39f778123b30@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
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

Hi Dmitry,

On 22/05/26 07:58, Dmitry Baryshkov wrote:
> The MR labelling is not used for DRM CI, however the job got enabled as
> a part of the CI pipeline and now prevents it from being executed.
> Disable the mr-label-maker-test job implicitly.
> 
> Link: https://gitlab.freedesktop.org/drm/msm/-/pipelines/1672049
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>   drivers/gpu/drm/ci/gitlab-ci.yml | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/ci/gitlab-ci.yml b/drivers/gpu/drm/ci/gitlab-ci.yml
> index 56088c5393cd..c1087731d1a2 100644
> --- a/drivers/gpu/drm/ci/gitlab-ci.yml
> +++ b/drivers/gpu/drm/ci/gitlab-ci.yml
> @@ -386,6 +386,10 @@ linkcheck-docs:
>      rules:
>       - when: never
>   
> +mr-label-maker-test:
> +   rules:
> +    - when: never
> +

Reviewed-by: Vignesh Raman <vignesh.raman@collabora.com>

Regards,
Vignesh

>   test-docs:
>      rules:
>       - when: never
> 
> ---
> base-commit: 687da68900cd1a46549f7d9430c7d40346cb86a0
> change-id: 20260522-drm-ci-mr-label-727766d73e95
> 
> Best regards,
> --
> With best wishes
> Dmitry
> 
> 

