Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAF5CC43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 12:55:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20DFF10E949;
	Mon,  6 Jul 2026 12:55:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="I4SM851D";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE63810E949
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 12:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783342538; x=1814878538;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=wgXE/5WakAChr6/xqwPgWIRl6ad6PllWANqhyqZ3FK4=;
 b=I4SM851DCxzfVKPcWv8Q30+4xwWd5bjENgKzF4PAtQugNsVgcO6nAT5T
 aAK2yXltxR2acdsdAzyZ8P06tQS6W1UjLbcdJk0hf6oWvUXWh5yCDgJZ0
 Y4C4YAntXqM4WIujqOOKGtgQ16UP+eqDa68LrZgbpo/lmtbQiLy9eGhlC
 hlVDJr02XJ/mxGOdXcC2Uh4Ibi+p06+lEgq86l7hdCdbR/xgeyzxLBRNL
 wMgWNylWVUKo/BEXeN8lQBr78+z1fAf7JJWWTbTFUI7JejxEn4+8QBtFp
 Hl1co1XOPhG8qr7R+oOGyNPHgVfv71bXnwPpaIf3/0SJrH+AHXVps9MV4 Q==;
X-CSE-ConnectionGUID: EiahzzxKRj+Ck0Og1z+pTQ==
X-CSE-MsgGUID: +l0KWLsUSaadpa4kNAQr1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11838"; a="109518666"
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; d="scan'208";a="109518666"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jul 2026 05:55:37 -0700
X-CSE-ConnectionGUID: K445YKG/SkaVQpRnNPAs+w==
X-CSE-MsgGUID: ulcDtYrpQhujLXKhH9iDvg==
X-ExtLoop1: 1
Received: from smoticic-mobl1.ger.corp.intel.com (HELO [10.245.244.90])
 ([10.245.244.90])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jul 2026 05:55:36 -0700
Message-ID: <de118156-3125-404e-8ddf-2326747df303@linux.intel.com>
Date: Mon, 6 Jul 2026 14:55:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Update Natalie Vock's email
To: Natalie Vock <nat@pixelcluster.dev>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org
References: <20260705175305.5589-1-nat@pixelcluster.dev>
Content-Language: en-US
From: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
In-Reply-To: <20260705175305.5589-1-nat@pixelcluster.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Acked-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>

On 7/5/26 19:53, Natalie Vock wrote:
> From now on I'll use my own domain for development work, reflect that in
> MAINTAINERS and mailmap.
> 
> Signed-off-by: Natalie Vock <nat@pixelcluster.dev>
> ---
>  .mailmap    | 3 ++-
>  MAINTAINERS | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/.mailmap b/.mailmap
> index d0d1367a261b8..3050ab1b97ea2 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -627,7 +627,8 @@ Nadav Amit <nadav.amit@gmail.com> <namit@cs.technion.ac.il>
>  Nadia Yvette Chambers <nyc@holomorphy.com> William Lee Irwin III <wli@holomorphy.com>
>  Naoya Horiguchi <nao.horiguchi@gmail.com> <n-horiguchi@ah.jp.nec.com>
>  Naoya Horiguchi <nao.horiguchi@gmail.com> <naoya.horiguchi@nec.com>
> -Natalie Vock <natalie.vock@gmx.de> <friedrich.vock@gmx.de>
> +Natalie Vock <nat@pixelcluster.dev> <friedrich.vock@gmx.de>
> +Natalie Vock <nat@pixelcluster.dev> <natalie.vock@gmx.de>
>  Nathan Chancellor <nathan@kernel.org> <natechancellor@gmail.com>
>  Naveen N Rao <naveen@kernel.org> <naveen.n.rao@linux.ibm.com>
>  Naveen N Rao <naveen@kernel.org> <naveen.n.rao@linux.vnet.ibm.com>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 377d224c5f76d..0caa9ea58db04 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6636,7 +6636,7 @@ F:	tools/testing/selftests/cgroup/test_cpuset_v1_base.sh
>  CONTROL GROUP - DEVICE MEMORY CONTROLLER (DMEM)
>  M:	Maarten Lankhorst <dev@lankhorst.se>
>  M:	Maxime Ripard <mripard@kernel.org>
> -M:	Natalie Vock <natalie.vock@gmx.de>
> +M:	Natalie Vock <nat@pixelcluster.dev>
>  L:	cgroups@vger.kernel.org
>  L:	dri-devel@lists.freedesktop.org
>  S:	Maintained

