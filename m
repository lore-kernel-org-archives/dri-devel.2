Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43D08C98321
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 10:47:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BC8910F9D5;
	Fri, 25 Sep 2026 10:47:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="nnICUKrB";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F6B410F9D5;
 Fri, 25 Sep 2026 10:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790333265; x=1821869265;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version:content-transfer-encoding;
 bh=+6cRRpmYbLoJyjX8/wSNF3x3uHOI6XSiZFULHXjFZc0=;
 b=nnICUKrBlApDnsSE9yJBxOzmXvUKITNR2suMs0b6VyHWwU6OLkZNurhf
 lHQ17/gLHWUuUy3zi2m9QHivDdWp65ZxHPAYdB6oHT4CpBtzejI4ZyjGr
 DOsuAzWvu/KohCWS8dIrXdJmw3tM7tuHsHPFXQGYhTGK8NvJPkuvMynYQ
 sJcyRDWDIH+R2uoA/5Kfep9WwRakf8MiS8QBLKyjtuXZnQn/fA5M5XyuN
 26V0w67xkZoBVXxdzCkt1PbNE9bQMnvf4NtGjKE9oDMkKxB8lMiAO+SyU
 c2rY99sk5tS1ZgBG2oUEdZ2oRpPB5W2JVXapeHgmdM+Fx3bzqcQCK9QTD g==;
X-CSE-ConnectionGUID: R2jgIy3YTU+RYQ0ALV7a5w==
X-CSE-MsgGUID: Bo3CQCZuQiGhcM09ULvE2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="108607142"
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="108607142"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 03:47:44 -0700
X-CSE-ConnectionGUID: VvhFciNwQAG6GlAtc/uItA==
X-CSE-MsgGUID: PXepr1YuQk6eoFFXH2fUfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="312227156"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.90])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 03:47:41 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Krzysztof Karas <krzysztof.karas@intel.com>,
 intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, Andi Shyti
 <andi.shyti@linux.intel.com>, Janusz Krzysztofik
 <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>, Krzysztof Karas
 <krzysztof.karas@intel.com>, Andi Shyti <andi.shyti@kernel.org>
Subject: Re: [PATCH v4 2/7] drm/i915: Add i915_* printer macros
In-Reply-To: <20260924120147.1305127-3-krzysztof.karas@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260924120147.1305127-1-krzysztof.karas@intel.com>
 <20260924120147.1305127-3-krzysztof.karas@intel.com>
Date: Fri, 25 Sep 2026 13:47:39 +0300
Message-ID: <344886121db0900dd7c22b3807ee75632f230f3d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

On Thu, 24 Sep 2026, Krzysztof Karas <krzysztof.karas@intel.com> wrote:
> Add i915_* family of printer macros, following existing example
> of gt_* and xe_* prints.

Frankly, I don't want *any* of this.

The drm_* macros are already a bunch of wrappers around dev_*
macros. IMO this is just too much, just to avoid writing &i915->drm.

(And yes, I dislike what's been done in xe too.)


BR,
Jani.

>
> Suggested-by: Andi Shyti <andi.shyti@kernel.org>
> Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
> ---
>  drivers/gpu/drm/i915/i915_printk.h | 53 ++++++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 drivers/gpu/drm/i915/i915_printk.h
>
> diff --git a/drivers/gpu/drm/i915/i915_printk.h b/drivers/gpu/drm/i915/i9=
15_printk.h
> new file mode 100644
> index 000000000000..5bbbe604cae8
> --- /dev/null
> +++ b/drivers/gpu/drm/i915/i915_printk.h
> @@ -0,0 +1,53 @@
> +/* SPDX-License-Identifier: MIT */
> +/*
> + * Copyright =C2=A9 2026 Intel Corporation
> + */
> +
> +#ifndef _I915_PRINTK_H_
> +#define _I915_PRINTK_H_
> +
> +#include <drm/drm_print.h>
> +
> +#define i915_printk(_i915, _level, _fmt, ...) \
> +	drm_##_level(&(_i915)->drm, _fmt, ## __VA_ARGS__)
> +
> +#define i915_err(_i915, _fmt, ...) \
> +	i915_printk((_i915), err, _fmt, ##__VA_ARGS__)
> +
> +#define i915_err_once(_i915, _fmt, ...) \
> +	i915_printk((_i915), err_once, _fmt, ##__VA_ARGS__)
> +
> +#define i915_err_ratelimited(_i915, _fmt, ...) \
> +	i915_printk((_i915), err_ratelimited, _fmt, ##__VA_ARGS__)
> +
> +#define i915_warn(_i915, _fmt, ...) \
> +	i915_printk((_i915), warn, _fmt, ##__VA_ARGS__)
> +
> +#define i915_notice(_i915, _fmt, ...) \
> +	i915_printk((_i915), notice, _fmt, ##__VA_ARGS__)
> +
> +#define i915_info(_i915, _fmt, ...) \
> +	i915_printk((_i915), info, _fmt, ##__VA_ARGS__)
> +
> +#define i915_dbg(_i915, _fmt, ...) \
> +	i915_printk((_i915), dbg, _fmt, ##__VA_ARGS__)
> +
> +#define i915_dbg_ratelimited(_i915, _fmt, ...) \
> +	i915_printk((_i915), dbg_ratelimited, _fmt, ##__VA_ARGS__)
> +
> +#define i915_WARN_type(_i915, _type, _condition, _fmt, ...) \
> +	drm_WARN##_type(&(_i915)->drm, _condition, _fmt, ## __VA_ARGS__)
> +
> +#define i915_WARN(_i915, _condition, _fmt, ...) \
> +	i915_WARN_type((_i915), _condition, __I915_PRINTK_FMT((_i915), _fmt, ##=
 __VA_ARGS__))
> +
> +#define i915_WARN_ONCE(_i915, _condition, _fmt, ...) \
> +	i915_WARN_type((_i915), _ONCE, _condition, __I915_PRINTK_FMT((_i915), _=
fmt, ## __VA_ARGS__))
> +
> +#define i915_WARN_ON(_i915, _condition) \
> +	i915_WARN((_i915), _condition, "%s(%s)", "WARN_ON", __stringify(_condit=
ion))
> +
> +#define i915_WARN_ON_ONCE(_i915, _condition) \
> +	i915_WARN_ONCE((_i915), _condition, "%s(%s)", "WARN_ON_ONCE", __stringi=
fy(_condition))
> +
> +#endif

--=20
Jani Nikula, Intel
