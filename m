Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46DE1CD8CB2
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 06:15:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A49EC10E72A;
	Wed, 10 Jun 2026 06:15:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="S/EuK96p";
	dkim-atps=neutral
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com
 [95.215.58.188])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88D2210E72A
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 06:15:07 +0000 (UTC)
Message-ID: <5152089a-2808-4fe9-b633-b03018105dd2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1781072103;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GCPO9v7e2NaYcPW5zVGvXXPxzu/fCfdM58tRqJXSo9A=;
 b=S/EuK96pTXAWUBg+8TCiJYM+danZr1codL6zDdrR1CXWZbSAz8OZt88gSb3T73P2+Oj0bR
 ye5UJbetTGxWmds/F2K/tlbDAkWts/YSgQ0PrY0mv2jpzcQt2r4zQh26U4ohdHNt5eRxKb
 jqr9Nyh610YgX0sau/FOqrE+b1XuGGI=
Date: Wed, 10 Jun 2026 14:14:06 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v2 00/14] list: Prepare entry iterators to cache cursor
 state
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Sowjanya Komatineni <skomatineni@nvidia.com>,
 Davidlohr Bueso <dave@stgolabs.net>, "Paul E . McKenney"
 <paulmck@kernel.org>, Josh Triplett <josh@joshtriplett.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, Huang Rui <ray.huang@amd.com>,
 Eddie James <eajames@linux.ibm.com>, Mark Brown <broonie@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Laxman Dewangan <ldewangan@nvidia.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>, Waiman Long <longman@redhat.com>,
 drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
 linux1394-devel@lists.sourceforge.net, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, linux-spi@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Christian Brauner
 <brauner@kernel.org>, David Howells <dhowells@redhat.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Kaito Cheng <chengkaitao@kylinos.cn>, Muchun Song <muchun.song@linux.dev>,
 Philipp Reisner <philipp.reisner@linbit.com>,
 Lars Ellenberg <lars.ellenberg@linbit.com>,
 =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
 Jens Axboe <axboe@kernel.dk>, Takashi Sakamoto <o-takashi@sakamocchi.jp>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>
References: <20260609061347.93688-1-kaitao.cheng@linux.dev>
 <bd0b7393-8ccb-4d67-8bfc-18c68347122c@amd.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Kaitao Cheng <kaitao.cheng@linux.dev>
In-Reply-To: <bd0b7393-8ccb-4d67-8bfc-18c68347122c@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
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

在 2026/6/9 18:33, Christian König 写道:
> On 6/9/26 08:13, Kaitao Cheng wrote:
>> From: Kaito Cheng <chengkaitao@kylinos.cn>
>>
>> This series prepares for, and then updates, the list_for_each_entry()
>> family so the common entry iterators cache their next or previous cursor
>> before the loop body runs.
> 
> Why in the world would we want to do that?
> 
> The safe and non-safe variants have very distinct use cases and that is completely intentional.
> 
> What we could improve maybe is the documentation, from my experience an astonishing large amount of people have misconceptions about the safe variants.
> 
>> The first 13 patches open-code loops that intentionally depend on the
>> old "derive the next entry from the current cursor at the end of the
>> iteration" behaviour.  These loops append work to the list being walked,
>> restart traversal after dropping a lock, skip an entry consumed by the
>> current iteration, or otherwise adjust the cursor in the loop body.
> 
> Well I have to clearly reject the changes for subsystems/components I'm maintaining, that just looks horrible to me and I clearly don't see a good reason for that.

Hi Christian and Andy Shevchenko,

Thanks for taking a look. I would like to clarify the point you raised.

The reason I started looking at this is the original motivation behind
the _safe() variants.  They exist because some users need to remove, move
or otherwise consume the current entry while walking the list.  In that
case the next cursor has to be preserved before the loop body can modify
the current entry.

The unfortunate part is that this could not be expressed with the
existing list_for_each_entry() interface without changing its calling
convention.  The _safe() variants had to grow an extra argument for the
temporary cursor, and that is why we ended up with a separate family of
macros.

But conceptually, the distinction does not have to be exposed as two
different iterator families forever.  The difference is an implementation
detail: whether the iterator keeps the next/previous cursor before the
body runs.  This series makes the common list_for_each_entry() iterators
do that internally, so the safe and non-safe forms can effectively be
folded together, or at least the need for a separate public _safe()
interface becomes much weaker.

There is also a usability issue with the current _safe() interface.  The
caller is forced to define a temporary cursor outside the macro and pass
it in, even though almost all users never use that cursor directly.  It is
just boilerplate required by the macro implementation.  I find that
redundant and awkward: the temporary cursor is an internal detail of the
iteration, but every caller has to spell it out.

With the updated list_for_each_entry() implementation, that extra cursor
can be kept inside the iterator itself.  Callers that only want to walk
the list, including callers that delete or consume the current entry, no
longer need to carry an otherwise-unused temporary variable just to make
the macro work.

>>
>> The final patch changes include/linux/list.h to keep a private cursor in
>> the common entry iterators while preserving the public macro interface.
>> The safe variants remain available when callers need the temporary
>> cursor explicitly or have stronger mutation requirements.
>>
>> Changes in v2 (Muchun Song, Andy Shevchenko):
>>  - Drop the list_for_each_entry_mutable*() helpers from v1 and make the
>>    cursor change directly in the existing list_for_each_entry*() helpers.
>>  - Open-code special list walks that rely on updating the loop cursor in
>>    the body, preserving their existing traversal semantics.
>>
>> Link to v1:
>> https://lore.kernel.org/all/20260529082149.76764-1-kaitao.cheng@linux.dev/
>>
>> Kaitao Cheng (14):
>>   drbd: Open-code transfer log list walk
>>   firewire: core: Open-code topology list walk
>>   drm/bridge: Open-code bridge chain list walks
>>   drm/i915/gt: Open-code active timeline walk
>>   drm/i915: Open-code DFS dependency list walk
>>   drm/ttm: Open-code reservation list walk
>>   spi: fsi: Open-code message transfer walk
>>   spi: stm32-ospi: Open-code message transfer walk
>>   spi: stm32-qspi: Open-code message transfer walk
>>   spi: tegra210-quad: Open-code message transfer walk
>>   locking/locktorture: Open-code ww mutex list walk
>>   locking/ww_mutex: Open-code stress reorder list walk
>>   ASoC: dapm: Open-code widget invalidation walk
>>   list: Cache cursors in entry iterators
>>
>>  drivers/block/drbd/drbd_debugfs.c      |  4 ++-
>>  drivers/firewire/core-topology.c       |  4 ++-
>>  drivers/gpu/drm/drm_bridge.c           |  7 ++--
>>  drivers/gpu/drm/i915/gt/intel_reset.c  |  4 ++-
>>  drivers/gpu/drm/i915/i915_scheduler.c  |  4 ++-
>>  drivers/gpu/drm/ttm/ttm_execbuf_util.c |  4 ++-
>>  drivers/spi/spi-fsi.c                  |  5 ++-
>>  drivers/spi/spi-stm32-ospi.c           |  4 ++-
>>  drivers/spi/spi-stm32-qspi.c           |  5 ++-
>>  drivers/spi/spi-tegra210-quad.c        |  4 ++-
>>  include/linux/list.h                   | 46 ++++++++++++++++++++------
>>  kernel/locking/locktorture.c           |  4 ++-
>>  kernel/locking/test-ww_mutex.c         |  4 ++-
>>  sound/soc/soc-dapm.c                   |  4 ++-
>>  14 files changed, 78 insertions(+), 25 deletions(-)
>>
>> --
>> 2.43.0
>>
> 

-- 
Thanks
Kaitao Cheng

