Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C61EC5516F
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 18:55:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E49610E1CD;
	Thu, 30 Jul 2026 18:55:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=leandro.ribeiro@collabora.com header.b="HLl/j4xV";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 171C810E1CD
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 18:55:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1785437703; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=KF8xdYFkiAHfsZzZwCtc6DDFV1VVV320azulRXqWAZdzoZ33S883WCrUO364HDCNScjElUtMF7ZJquQgBuTJxG6xKtHppiCznOvPxnO+pB5p9pdq9J+eixLTSCdOzDwK5hdpZN2PpzD+i7sRB3rIM+BBTjJvabWFt5RJ9+u4ML0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1785437703;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=9AIxGw1TLp+p2tcxS7/F14XLcUmuxOVmyqIJY65QchY=; 
 b=O1iPcOOrPQXk5cdFiV1wKo706fUyhY9reIdeoA3lFkOgct2DURrlUp22cyarLF/a7Mjl0FbA3kOcDtXeQDAw6ezJDIVwdrzN411WJTDuadVAjkmoLo3gjfg9nl8pkdImb5Z6gIGbE6zl7io5dkWXyEo+WqoSL3Vk049XZBKUrGY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=leandro.ribeiro@collabora.com;
 dmarc=pass header.from=<leandro.ribeiro@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785437703; 
 s=zohomail; d=collabora.com; i=leandro.ribeiro@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=9AIxGw1TLp+p2tcxS7/F14XLcUmuxOVmyqIJY65QchY=;
 b=HLl/j4xVw/vZVmiOdCOGpTkFDGK5kwMUuoUSEs3OkbE9kUth8Ys3F5JUqXUfkW+L
 aXKHjwAAD9LBGIwvUYA4drvU0CNYkuWrZXZoZJYVbszJW03vBFQ/AQ2gUi/aDf1lsR1
 Ny7IJuZzGEG3FMdLR1wRLL/y9aQt//O1U0EoQybA=
Received: by mx.zohomail.com with SMTPS id 1785437700926956.5335535558954;
 Thu, 30 Jul 2026 11:55:00 -0700 (PDT)
Message-ID: <5d8ff369-8afa-4fcf-906b-ab685fa04e42@collabora.com>
Date: Thu, 30 Jul 2026 15:54:55 -0300
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
Content-Language: en-US
From: Leandro Ribeiro <leandro.ribeiro@collabora.com>
In-Reply-To: <b197e416-8007-4aec-b546-62574fa16d27@I-love.SAKURA.ne.jp>
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



On 7/29/26 7:13 PM, Tetsuo Handa wrote:
> On 2026/07/30 6:45, Leandro Ribeiro wrote:
>> Commit 860e748bddcc ("drm: ensure blend mode supported if pixel format
>> with alpha exposed") introduced a WARN() to let driver developers know
>> that a previously valid behavior should now be changed.
>>
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
> Thank you. But could something like
> 
>   pr_warn("[PLANE:%d:%s] pixel format with alpha exposed but blend mode not setup. Please fix.", plane->base.id, plane->name);
>   dump_stack();
> 
> be less prone to get oversighted (because of printing about 10+ lines)?
> 

I see the point about making the message harder to overlook, but
honestly I feel like the stack trace would be overkill here.

The error message is more important than the stack trace itself in this
case, and I think the warning should be enough to draw attention to the
issue.

-- 
Leandro Ribeiro

