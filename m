Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE439C55167
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 23:18:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 260A110F0E7;
	Thu, 30 Jul 2026 23:18:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=leandro.ribeiro@collabora.com header.b="LAfXLpFl";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC3F710F0E7
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 23:18:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1785453504; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=KNcTd6U+kW7l8wOLK+FRom7voO0i6a9wDJXsvPckRgy0i/CTJ0dkZn7tda6a9Ns9jzf9Qa+9FQFHI2es1Xzvp93LrtRfRJ610B6hq1Z5Uv7NOt+f+IF38fBzeeni/5Zu6jmPfM01cgyWaiPU8YC3TvScEKrQ9ht+0DtwwQSsVbY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1785453504;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=6YqsLGYVHUUcOyeHq8WHWJEFP2AtqkG5Rly86t9iiQo=; 
 b=b8KDOr4pFfkFlJ4cygmgZd8/Qq2k23cbatB6fDcv2tJHoiq3k4Z1fvjoKgFbn4ckYtn3/K7CBI5ZBrBF8TiC6USbuplishDI6LL27BGeWvE0OtjV1uLZoZn5xGW1JIBJ5qckdPwZtyvOrmfzQuxvXHxH7ct+g1uNAPiLnL+MMco=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=leandro.ribeiro@collabora.com;
 dmarc=pass header.from=<leandro.ribeiro@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785453504; 
 s=zohomail; d=collabora.com; i=leandro.ribeiro@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=6YqsLGYVHUUcOyeHq8WHWJEFP2AtqkG5Rly86t9iiQo=;
 b=LAfXLpFlBBYaJshg/VsMSJAIcdPTHMC8pWIIuFz1pp7BPXAU8u/vLC9ChxUy+XVG
 Isc+jkCEUlol9AVj7GCZwKRyJsyi8QiXs1Jzq941x5VIrDri6QkOUaKmDGfy62DzJNZ
 XP/khkK5rzOD29O9Ndkl5optL/KuQkMNSzrr/diI=
Received: by mx.zohomail.com with SMTPS id 1785453502216435.173956823253;
 Thu, 30 Jul 2026 16:18:22 -0700 (PDT)
Message-ID: <1dc8b8ec-e41a-4145-bffe-4cd1a0294bca@collabora.com>
Date: Thu, 30 Jul 2026 20:18:14 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] drm: use drm_warn() in
 validate_blend_mode_for_alpha_formats()
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 dri-devel@lists.freedesktop.org
Cc: airlied@gmail.com, broonie@kernel.org, daniels@collabora.com,
 jani.nikula@linux.intel.com, maarten.lankhorst@linux.intel.com,
 miguel.ojeda.sandonis@gmail.com, mripard@kernel.org,
 pekka.paalanen@collabora.com, simona@ffwll.ch, tytso@mit.edu,
 tzimmermann@suse.de, ville.syrjala@linux.intel.com,
 linux-kernel@vger.kernel.org
References: <20260729214505.185776-1-leandro.ribeiro@collabora.com>
 <20260729214505.185776-2-leandro.ribeiro@collabora.com>
 <b197e416-8007-4aec-b546-62574fa16d27@I-love.SAKURA.ne.jp>
 <5d8ff369-8afa-4fcf-906b-ab685fa04e42@collabora.com>
 <386a0a73-6f80-47e3-9048-18a4680ad0fa@I-love.SAKURA.ne.jp>
Content-Language: en-US
From: Leandro Ribeiro <leandro.ribeiro@collabora.com>
In-Reply-To: <386a0a73-6f80-47e3-9048-18a4680ad0fa@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
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



On 7/30/26 8:14 PM, Tetsuo Handa wrote:
> On 2026/07/31 3:54, Leandro Ribeiro wrote:
>> I see the point about making the message harder to overlook, but
>> honestly I feel like the stack trace would be overkill here.
>>
>> The error message is more important than the stack trace itself in this
>> case, and I think the warning should be enough to draw attention to the
>> issue.
> 
> OK. Then, please consider
> 
>  			drm_warn(plane->dev,
> -				 "[PLANE:%d:%s] pixel format with alpha exposed but blend mode not setup",
> +				 "[PLANE:%d:%s] pixel format with alpha exposed but blend mode not setup. Please fix.,
>  				 plane->base.id, plane->name);
> 
> to indicate that developers have something to do.
> 

Sure, sounds good! I'll change this, thank you.

-- 
Leandro Ribeiro

