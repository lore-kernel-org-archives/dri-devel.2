Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DA30C53200
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 23:05:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C049210E096;
	Wed, 29 Jul 2026 23:05:11 +0000 (UTC)
X-Greylist: delayed 3107 seconds by postgrey-1.36 at gabe;
 Wed, 29 Jul 2026 23:05:10 UTC
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C83BE10E096
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 23:05:10 +0000 (UTC)
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
 by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 66TMD5pk066280;
 Thu, 30 Jul 2026 07:13:05 +0900 (JST)
 (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
 (authenticated bits=0)
 by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 66TMD5vb066277
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 30 Jul 2026 07:13:05 +0900 (JST)
 (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <b197e416-8007-4aec-b546-62574fa16d27@I-love.SAKURA.ne.jp>
Date: Thu, 30 Jul 2026 07:13:04 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] drm: use drm_warn() in
 validate_blend_mode_for_alpha_formats()
To: Leandro Ribeiro <leandro.ribeiro@collabora.com>,
 dri-devel@lists.freedesktop.org
Cc: airlied@gmail.com, broonie@kernel.org, daniels@collabora.com,
 jani.nikula@linux.intel.com, maarten.lankhorst@linux.intel.com,
 miguel.ojeda.sandonis@gmail.com, mripard@kernel.org,
 pekka.paalanen@collabora.com, simona@ffwll.ch, tytso@mit.edu,
 tzimmermann@suse.de, ville.syrjala@linux.intel.com,
 linux-kernel@vger.kernel.org
References: <20260729214505.185776-1-leandro.ribeiro@collabora.com>
 <20260729214505.185776-2-leandro.ribeiro@collabora.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20260729214505.185776-2-leandro.ribeiro@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav203.rs.sakura.ne.jp
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

On 2026/07/30 6:45, Leandro Ribeiro wrote:
> Commit 860e748bddcc ("drm: ensure blend mode supported if pixel format
> with alpha exposed") introduced a WARN() to let driver developers know
> that a previously valid behavior should now be changed.
> 
> But WARN() should not be used for that, as it's a kernel warning report
> mechanism for conditions that are not expected to happen. It also
> produces a stack trace. Instead, a simple warning-level log message
> should have been used, as drivers were expected to trigger the
> condition.
> 
> This is causing problems for fuzzers, as they may stop when encountering
> a "BUG:" or "WARNING:" in the logs.
> 
> Replace WARN() with drm_warn() in this function, avoiding these issues.

Thank you. But could something like

  pr_warn("[PLANE:%d:%s] pixel format with alpha exposed but blend mode not setup. Please fix.", plane->base.id, plane->name);
  dump_stack();

be less prone to get oversighted (because of printing about 10+ lines)?

