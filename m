Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBDB3C5B572
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 14:47:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9E1210E00D;
	Thu, 13 Aug 2026 14:47:28 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96C1C10E00D
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 14:47:27 +0000 (UTC)
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
 by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 67DEl0il091104;
 Thu, 13 Aug 2026 23:47:00 +0900 (JST)
 (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
 (authenticated bits=0)
 by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 67DEl0ke091101
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 13 Aug 2026 23:47:00 +0900 (JST)
 (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <d47b8640-c84b-48ae-809e-95294e00859d@I-love.SAKURA.ne.jp>
Date: Thu, 13 Aug 2026 23:46:58 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] drm: use drm_warn() in
 validate_blend_mode_for_alpha_formats()
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: Leandro Ribeiro <leandro.ribeiro@collabora.com>,
 dri-devel@lists.freedesktop.org
Cc: airlied@gmail.com, broonie@kernel.org, daniels@collabora.com,
 jani.nikula@linux.intel.com, maarten.lankhorst@linux.intel.com,
 miguel.ojeda.sandonis@gmail.com, mripard@kernel.org,
 pekka.paalanen@collabora.com, simona@ffwll.ch, tytso@mit.edu,
 tzimmermann@suse.de, ville.syrjala@linux.intel.com,
 linux-kernel@vger.kernel.org
References: <20260731154232.37020-1-leandro.ribeiro@collabora.com>
 <20260731154232.37020-2-leandro.ribeiro@collabora.com>
 <46b86d82-6ff4-458a-ac7e-cbbae214b4e5@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <46b86d82-6ff4-458a-ac7e-cbbae214b4e5@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav302.rs.sakura.ne.jp
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

Merge window will open shortly. Can we have this fix applied before
commit 860e748bddcc ("drm: ensure blend mode supported if pixel format
with alpha exposed") hits upstream?

On 2026/08/06 22:14, Tetsuo Handa wrote:
> Who is supposed to take this patch?
> 
> Since this problem is preventing syzbot from testing changes in linux-next
> kernels for more than three weeks, I expect this patch to be applied
> as soon as possible.
> 
> On 2026/08/01 0:42, Leandro Ribeiro wrote:
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
>>
>> Fixes: 860e748bddcc ("drm: ensure blend mode supported if pixel format with alpha exposed")
>> Signed-off-by: Leandro Ribeiro <leandro.ribeiro@collabora.com>
>> ---
>>  drivers/gpu/drm/drm_mode_config.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)

