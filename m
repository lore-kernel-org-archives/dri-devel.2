Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4903C43602
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 10:00:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04D2910EC2C;
	Tue,  7 Jul 2026 10:00:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="gxHJGbdg";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4686810E48D;
 Tue,  7 Jul 2026 10:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783418437; x=1814954437;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=0yR72GiJj1ZuQanz9GmH0xgCa0XSMaMr4QJoXWVgvkc=;
 b=gxHJGbdgXd8WGv/MIlQGtWhuehNcjCFqM951pI8YB8gMFLiaJRFLQKHg
 H67h5PKXuyKeOLYcBDSfwrRA3xu4vYub3PA4lqmLeXiUl1QSz6N7B7MqG
 nfZLw5FxqWPQua2qWcbT1SL7ZZRuosSEKoAMjTDdpF9gzNed04xPa2uYh
 vZ2wtTMncWEvbttVfMY4RAy4JYa6ijfdeicPrFTzE9C0hX2ZrAuLCb6aJ
 15ns7yXXhwYEWsU/Q/mxcpPe4w2ASXgNNcIKmN1xZbkNo2to4BhMbkFKI
 95a/EfcAlJUv9S/5uf0Lif7brKlLqM/2zp+vaK4yJRAwCbSxZsaEYmfcx w==;
X-CSE-ConnectionGUID: KS4uAW1zSdqQtKXwB/IPEw==
X-CSE-MsgGUID: K2kOK4PKTs6jcsojUWT7Gg==
X-IronPort-AV: E=McAfee;i="6800,10657,11839"; a="109603476"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="109603476"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2026 03:00:37 -0700
X-CSE-ConnectionGUID: 3G9dJ2bPSIeby/mx6IrECA==
X-CSE-MsgGUID: TP4HqTkZTyyjuLeG+19bXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="252880536"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO [10.245.244.223])
 ([10.245.244.223])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2026 03:00:32 -0700
Message-ID: <6317e0b2-1534-4be1-8c58-fa9d2ad54b20@linux.intel.com>
Date: Tue, 7 Jul 2026 12:01:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/6] cgroup/dmem: Add reclaim callback for lowering max
 below current usage
To: Tejun Heo <tj@kernel.org>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Cc: intel-xe@lists.freedesktop.org, Natalie Vock <natalie.vock@gmx.de>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, cgroups@vger.kernel.org, Huang Rui <ray.huang@amd.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Matthew Auld <matthew.auld@intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>,
 David Airlie <airlied@gmail.com>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>,
 Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260703130541.2686-1-thomas.hellstrom@linux.intel.com>
 <20260703130541.2686-4-thomas.hellstrom@linux.intel.com>
 <akwBFlw8MwhrwsRu@slm.duckdns.org>
Content-Language: en-US
From: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
In-Reply-To: <akwBFlw8MwhrwsRu@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Hey,

On 7/6/26 21:25, Tejun Heo wrote:
> Hello,
> 
> On Fri, Jul 03, 2026 at 03:05:38PM +0200, Thomas Hellström wrote:
>> Also honor O_NONBLOCK so that if that flag is set during the
>> max value write, no reclaim is initiated. The idea is to avoid
>> charging the reclaim cost to the writer of the max value.
> 
> Is this really necessary? I'm not necessarily against it but this is trivial
> to work around from userspace and feels like a gratuitous addition. What's
> the use case?

The usecase is similar to the usecase in memcg's max/high, it allows
the controller to lower the limit, but move the penalty for lowering
the limit to the affected cgroups instead of making the controlling
process block, especially when changing a lot of limits dynamically
this can make a difference.

Kind regards,
~Maarten Lankhorst
