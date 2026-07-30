Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0D9AC5516E
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 18:47:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1047310E1C2;
	Thu, 30 Jul 2026 18:47:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=leandro.ribeiro@collabora.com header.b="UXq+3cPC";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4FD110E1C2
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 18:47:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1785437218; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=htx5p144lk40t/aerUg5wo+4yT0OXE6iI8rCiZqtiTYiKanlLfSerrz6Sjh+NrAN96VLqpxZ6vhKQQV//mydhccDSL8cHsyhbiZ0Z0tYB3I9LgovhJqpAM3FKD4smGGmBnbZbnyoRvxOhcG70bM3Me8HcS1gVdfilyadcSTppWQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1785437218;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=cnyTpjFHVwtEUE1dZJKrBGhVFLRLW0sRLYWbADUw1sU=; 
 b=F0ZIv0+8vYhfgo48Uu7lEnCbBqBRRZaAabXVRq4ahaJsEgmhLlYkXSAvyzHmX7Da1uZAqptQ2vXtk+ggRNzS/gJJjLg4CQkQA/dsg3dMrtvYe7BBtMOdLcV+iggC/QyDjThxoAD29klFhvcbTRiq9s9B4ifmn9IBhJWAkRTG9N8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=leandro.ribeiro@collabora.com;
 dmarc=pass header.from=<leandro.ribeiro@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785437218; 
 s=zohomail; d=collabora.com; i=leandro.ribeiro@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=cnyTpjFHVwtEUE1dZJKrBGhVFLRLW0sRLYWbADUw1sU=;
 b=UXq+3cPCq/Lzc6VinPo8pkRXKfi4huJBl16F4e9tU2t8UG5dAG6O+ozVAa9fHxen
 T/aQXDt75L3dNCztdALXbSk5ZU7cbpkFWM+c8IWu497F5jyb8vKtbaxlqgZC0ITvbfT
 9c4LW9M94BUn0XmkjYwOAcVIlO8U+iC4fCqP6h7w=
Received: by mx.zohomail.com with SMTPS id 1785437214954360.024094066045;
 Thu, 30 Jul 2026 11:46:54 -0700 (PDT)
Message-ID: <2167238c-ca2b-443b-ac79-a1975e175509@collabora.com>
Date: Thu, 30 Jul 2026 15:46:48 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] drm: use drm_warn() in
 validate_blend_mode_for_alpha_formats()
To: Jani Nikula <jani.nikula@linux.intel.com>, dri-devel@lists.freedesktop.org
Cc: airlied@gmail.com, broonie@kernel.org, daniels@collabora.com,
 maarten.lankhorst@linux.intel.com, miguel.ojeda.sandonis@gmail.com,
 mripard@kernel.org, pekka.paalanen@collabora.com, simona@ffwll.ch,
 penguin-kernel@I-love.SAKURA.ne.jp, tytso@mit.edu, tzimmermann@suse.de,
 ville.syrjala@linux.intel.com, linux-kernel@vger.kernel.org
References: <20260729214505.185776-1-leandro.ribeiro@collabora.com>
 <20260729214505.185776-2-leandro.ribeiro@collabora.com>
 <b2628133dfe020b9e3c74af27a3cfa2525f66223@intel.com>
Content-Language: en-US
From: Leandro Ribeiro <leandro.ribeiro@collabora.com>
In-Reply-To: <b2628133dfe020b9e3c74af27a3cfa2525f66223@intel.com>
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



On 7/30/26 6:14 AM, Jani Nikula wrote:
> On Wed, 29 Jul 2026, Leandro Ribeiro <leandro.ribeiro@collabora.com> wrote:
>> Commit 860e748bddcc ("drm: ensure blend mode supported if pixel format
>> with alpha exposed") introduced a WARN() to let driver developers know
>> that a previously valid behavior should now be changed.
> 
> I should've chimed in way back when, but in retrospect it's a bit
> presumptuous to add a commit that puts the burden of the change on the
> driver developers, without so much as identifying which drivers or
> getting an ack from them.
> 
> This is really not unlike the __deprecated attribute, see commit
> 771c035372a0 ("deprecate the '__deprecated' attribute warnings entirely
> and for good"), but this one's runtime not build.
> 

I agree. I hadn't considered the driver coordination aspect when
proposing that change.

>> But WARN() should not be used for that, as it's a kernel warning report
>> mechanism for conditions that are not expected to happen. It also
>> produces a stack trace. Instead, a simple warning-level log message
>> should have been used, as drivers were expected to trigger the
>> condition.
>>
>> This is causing problems for fuzzers, as they may stop when encountering
>> a "BUG:" or "WARNING:" in the logs.
>>
>> Replace WARN() with drm_warn() in this function, avoiding these issues.
> 
> Fixes: 860e748bddcc ("drm: ensure blend mode supported if pixel format with alpha exposed")
> 
>> Signed-off-by: Leandro Ribeiro <leandro.ribeiro@collabora.com>
>> ---
>>  drivers/gpu/drm/drm_mode_config.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/drm_mode_config.c b/drivers/gpu/drm/drm_mode_config.c
>> index 3bcc7bf0900c..3d9c554e08a8 100644
>> --- a/drivers/gpu/drm/drm_mode_config.c
>> +++ b/drivers/gpu/drm/drm_mode_config.c
>> @@ -869,8 +869,9 @@ static void validate_blend_mode_for_alpha_formats(struct drm_plane *plane)
>>  	for (i = 0; i < plane->format_count; i++) {
>>  		fmt = drm_format_info(plane->format_types[i]);
>>  		if (fmt->has_alpha) {
>> -			WARN(1, "[PLANE:%d:%s] pixel format with alpha exposed but blend mode not setup",
>> -			     plane->base.id, plane->name);
>> +			drm_warn(plane->dev,
>> +				 "[PLANE:%d:%s] pixel format with alpha exposed but blend mode not setup",
>> +				 plane->base.id, plane->name);
>>  			break;
>>  		}
>>  	}
> 

-- 
Leandro Ribeiro

