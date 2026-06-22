Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0FF9CDB46B
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 08:37:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F99110E541;
	Mon, 22 Jun 2026 08:37:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="lwi+leCq";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5C9D10E541
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 08:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782117469; x=1813653469;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=o0XPey02pNHXumHWa6TQBgjgCeS/R84YiOVlMcvQRTw=;
 b=lwi+leCqmYWmuFst6FQBZ5DAHNBzvjzKOvdFm9YAWYeck1lFLPstlLLE
 HfvGplF7vI7ppon4Tfz83R0sJ7Q6UnhkB/puK65jNkqLWlw+oi1UKW+D2
 dmHcxGUFHvd15Dc0mMhfGhhAkaz7ESnKhl+LjgjHZNbe03xX5s2/kyNKX
 T2bQkviWBa+gpSAAvQYc38+tPbNSKQi5BFa0ScUd3NRX/apt0d888B4Lh
 XD1X3LFU5Ma16ZgS00f+GAY92w+Y1DarSdKVL2ZmHgWSG3tOfzLz3BQvQ
 ft49GdYMp53Vh5tvIMO+kqgJGdj8W04FzLYd7CsN+FVf6+Cmg2mV7j/HT A==;
X-CSE-ConnectionGUID: p5iaZs8dRgWJWGsnTT+lIQ==
X-CSE-MsgGUID: Zf6oLn/9Tdy1V9diM5ku+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11824"; a="82844701"
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; d="scan'208";a="82844701"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jun 2026 01:37:48 -0700
X-CSE-ConnectionGUID: 51x2ahlxRfadoXyoUtL0hA==
X-CSE-MsgGUID: PGIuZ8mzSP2g3MT4S82HXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; d="scan'208";a="254255860"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost)
 ([10.245.245.82])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jun 2026 01:37:33 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Kaitao Cheng <kaitao.cheng@linux.dev>, Andrew Morton
 <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, Jens
 Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
 <namhyung@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Juri Lelli
 <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
 Paul Moore <paul@paul-moore.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, "Paul E. McKenney"
 <paulmck@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>, Christian
 =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>
Cc: David Howells <dhowells@redhat.com>, Simona Vetter
 <simona.vetter@ffwll.ch>, Randy Dunlap <rdunlap@infradead.org>, Luca
 Ceresoli <luca.ceresoli@bootlin.com>, Philipp Stanner <phasta@kernel.org>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
 linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
 audit@vger.kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-perf-users@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, kexec@lists.infradead.org,
 live-patching@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-crypto@vger.kernel.org, linux-pm@vger.kernel.org,
 rcu@vger.kernel.org, sched-ext@lists.linux.dev, linux-mm@kvack.org,
 virtualization@lists.linux.dev, damon@lists.linux.dev,
 llvm@lists.linux.dev, chengkaitao <chengkaitao@kylinos.cn>
Subject: Re: [PATCH v3 0/7] Prepare mutable list iterators to cache cursor
 state
In-Reply-To: <20260622040533.29824-1-kaitao.cheng@linux.dev>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260622040533.29824-1-kaitao.cheng@linux.dev>
Date: Mon, 22 Jun 2026 11:37:29 +0300
Message-ID: <88f34c7fa5a3d1700cc8005818751d6aa31f09df@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
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

On Mon, 22 Jun 2026, Kaitao Cheng <kaitao.cheng@linux.dev> wrote:
> Add *_mutable() iterator variants for list, hlist and llist.  The new
> helpers are variadic and support both forms.  In the common case, the
> caller omits the temporary cursor and the macro creates a unique internal
> cursor with typeof(pos) and __UNIQUE_ID().  If a loop really needs an
> explicit temporary cursor, the caller can still pass it and the helper
> keeps the existing *_safe() behaviour.
>
> For example, a call site may use the shorter form:
>
>   list_for_each_entry_mutable(pos, head, member)
>
> or keep the explicit temporary cursor form:
>
>   list_for_each_entry_mutable(pos, tmp, head, member)

I'm unconvinced it's a good idea to allow two forms with macro trickery,
*especially* when it's not the last argument you can omit. I think it's
a footgun.

IMO stick with the first form only, and there'll always be the _safe
variant that can be used when the temp pointer is needed.


BR,
Jani.


-- 
Jani Nikula, Intel
