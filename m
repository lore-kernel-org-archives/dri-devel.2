Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FA05CDB479
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 17:35:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6773710E0F5;
	Wed, 24 Jun 2026 17:35:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="fSqG0wgG";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1A6210E0F5
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 17:35:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1782322541; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=DDVdUgeH7zJvQYOG7GEYThlZZ3fbrC5Prx5kCV+GZXTiVOfN2ka3fm5ZttDee1G0OuBNGxkvHAz1jFWQQhudyt7yg0FGaodd10EupB+n+8bR1GexX+JyFe2Yka/wW60Lp5upnrTTLGrayztUIDbf/sHzWDvjFzcYSnc2uJxBc4o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1782322541;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=zqKFR1eYsc6fWBZow0rBCx89NPUaO0f/5Z1k7T53TSg=; 
 b=XEeW1QYVevnuLBF2WcdY3VZ2GsZ0JRBgLTunDF74bTKupuf4SzueE/phdYnWh/hwewkiSuHzpjeeSnjh22SQy/oPUGxojkD/CfgEujwW98+BfH75oqq1RlAulWJYJn7R7gW5XC7MpuiS53rRuqg/CEfVjGbYd4sXly/7zN7o7gk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1782322541; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:Subject:From:From:To:To:Cc:Cc:In-Reply-To:References:Date:Date:Message-Id:Message-Id:Reply-To;
 bh=zqKFR1eYsc6fWBZow0rBCx89NPUaO0f/5Z1k7T53TSg=;
 b=fSqG0wgGOkfBE8hYj6i7lfjv5rwRg4ELjVQyp1QUU9kZCkICjYMFeCCCzS42Xs3L
 BQX5fjSoCnwHoBLNnHnMRS8wSWDe3mVmnktWH8kEGisd4rjfwjAQ2DceRd1j3ntic13
 k/3iRNOY6/xOIJ7eB3Ui4gBTSX625Is/IeomKqUA=
Received: by mx.zohomail.com with SMTPS id 178232254073826.500951919288923;
 Wed, 24 Jun 2026 10:35:40 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/2] drm/panthor: Add vm_bind region with kbo range
 overlap check
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
To: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>, 
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260619-vm_bind_checks-v2-1-b51abab35f71@collabora.com>
References: <20260619-vm_bind_checks-v2-0-b51abab35f71@collabora.com>
 <20260619-vm_bind_checks-v2-1-b51abab35f71@collabora.com>
Date: Wed, 24 Jun 2026 18:35:34 +0100
Message-Id: <178232253441.11712.16049726294094104029.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1328;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=QVtFORrOVlRVQrjg9UzIAEUHBFm4FOTbmQZkrOLqjYs=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqPBVo3hVOcoycFl/ame0/JprkQtFOU5zNgPnd+
 DBQx1Cx6GeJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCajwVaAAKCRAOJn5M7lND
 Pa9LC/9WXZpInvFPs7+fzCkluzcvlB4F36QoV+YaZq3Yi4loR1Ye1iHpc1JigpNaPHpHDy9jft3
 yi05W3e+icxakA7TZod7ZQ9+gqKLEV34Ci9KKY11MoOh4mMib5fwTubtN74R3gmU6WDCtY8HYxx
 f0+viWq+BhbsoZdGaH6obF+5cNzfBjdUYW1cOs4kOb3tUDRBOhFFVNfpXRXm1OQcsWe7d09/ZTv
 Q7DUVX7Ni8UzL6MtYR0HNHCtINwuA7XHllI+4OV0eS6m4jIOCaPF/yV/Cpl+5IbSSrieUx3j64q
 dtxGPOz4VQYJsFM486xYQxDT5v+Rig6pRXWQ5aaaF10jaPVt2eLgEWH1iCnjlAUAxp70ydt6gyS
 S3ZTFcCV9dxW0Yao++m7IFSQb0MhowB/udG8BurVDG21uFY5eW9EgLhSsSdiem8jlz07M58WWnt
 dFtMkGAN7p99yy1ZJzKsdJE17iNz93LWb21wRWekR7IjN4NJW6mdxDFkr4qcvh/zdU2aQ=
X-Developer-Key: i=adrian.larumbe@collabora.com; a=openpgp;
 fpr=324030E8C005175DF93707A40E267E4CEE53433D
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

On Fri, 19 Jun 2026 13:41:22 +0100, Adrián Larumbe <adrian.larumbe@collabora.com> wrote:
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> index 31cc57029c12..a8de4fe6b231 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -2981,6 +2986,10 @@ panthor_vm_bind_prepare_op_ctx(struct drm_file *file,
>  	if (!IS_ALIGNED(op->va | op->size | op->bo_offset, vm_pgsz))
>  		return -EINVAL;
>  
> +	/* We don't allow mappings that overlap with kbo's reserved range */
> +	if (op->va + op->size > vm->user_va_end)
> +		return -EINVAL;

I wrote an overflow check as follows, in panthor_vm_prepare_map_op_ctx():

/* Protect against sparse VA range overflow */
if (is_sparse && check_add_overflow(op->va, op->size, &end))
	return -EINVAL;

However, despite Shashiko's warning, it seems there's no need for this, because drm_gpuvm
core code is already performing this kind of check inside __drm_gpuvm_sm_map():

__drm_gpuvm_sm_map -> drm_gpuvm_range_valid -> drm_gpuvm_check_overflow

So even though we wouldn't catch the overflow when we test that the bind range falls within
the user_va boundary, it will be caught later at map time, and maybe that's enough?

-- 
Adrián Larumbe <adrian.larumbe@collabora.com>
