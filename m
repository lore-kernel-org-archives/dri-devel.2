Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D5A606A321
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 07:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fR9O1bvz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 225C311249B;
	Fri, 27 Nov 2026 07:53:27 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DADA11249B
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 07:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795766002; x=1827302002;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=en9nIFiPHp5NdJ2ji7cpb7Yy8P+oZwMxKLHFGCavy6s=;
 b=fR9O1bvzYOWWDJ+K2EzA3RrsESR2RxrEpsyl0VleBTKcrUgArO1kUVRj
 aI5lNc4Qa7hAQSuWgiqTfjOWTjfrAFHFbyTjThHyXOmx7V82kYFR8j/Ms
 gZWbjXHWkCF7qlY+b1fm9YT/kDs2hG3wjxXHLDQawAf4JB3vNvvvHFUb0
 Q1PH2fg5SEUF/2GsPCsKhfnARPOA98YRMmgHfwAwUKs1mWOn3EJhuWlNr
 ZDq6gNkF6Rk1PmeRBWNDB0lcCN9BKnMaSZm496lT7ono6FXzh8Up4AD1b
 OPLWzrA02ZtjLSaqgiwtZEQZpxCqUfelQap7TiLb4TTzyRVMpObodSufb A==;
X-CSE-ConnectionGUID: kT+lxMT5Rr+CNVP3pWkwXg==
X-CSE-MsgGUID: +V+LTaPMSpWDcQh+eGZrUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4639651"
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; 
   d="scan'208";a="4639651"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2026 23:53:21 -0800
X-CSE-ConnectionGUID: MH1cy0DKTe2MQJ5qqagh9g==
X-CSE-MsgGUID: SbKLa2ZeRkeg4uaVlKMyFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; d="scan'208";a="12338229"
Received: from yufei-super-server.sh.intel.com ([10.239.92.104])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2026 23:53:19 -0800
From: Fei Yu <fei.yu@intel.com>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: dri-devel@lists.freedesktop.org, kernel-dev@igalia.com,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Subject: Re: [PATCH v2 7/7] drm/syncobj: Add temporary array allocation fast
 paths
Date: Fri, 27 Nov 2026 15:59:10 +0800
Message-ID: <20261127075910.1869135-1-fei.yu@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126114945.67886-1-tvrtko.ursulin@igalia.com>
References: <20261126111117.67342-8-tvrtko.ursulin@igalia.com>
 <20261126114945.67886-1-tvrtko.ursulin@igalia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 26, 2026 at 11:49:45AM +0000, Tvrtko Ursulin wrote:
> Running the Cyberpunk 2077 benchmark we can observe that waiting on DRM
> sycobjs (drm_syncobj_array_wait_timeout) is relatively hot, but that the

Nit: "sycobjs" -> "syncobjs".

> v2:
>  * Use fast path in drm_syncobj_array_find itself!

Thanks, that drops the handles allocation from every array ioctl
(and covers the sashiko comment on v1).

> +#define DRM_SYNCOBJ_INIT_FASTPATH_ARRAY(_name, _src, _count) ({		\
[...]
> +	} else {							\
> +		size_t __size = (_count) * sizeof(*(_name));		\
> +									\
> +		_name = _name##_stack;					\
> +		if (_src) {						\
> +			if (copy_from_user(_name, (_src), __size))	\
> +				__ret = -EFAULT;			\
> +		} else {						\
> +			memset(_name, 0, __size);			\
> +		}							\
> +	}								\
> +	__ret;								\
> +})

A NULL _src means "zero-fill" here. That is the right thing for the
points arrays, but it is also why array_find needs its own check:

> +	if (!user_handles)
> +		return -EFAULT; /* Preserve ABI error code */

A future caller that forgets this check would silently get zeroes
instead of -EFAULT for a NULL user pointer. Maybe split the init into
a copy variant and a zero variant (a NULL user pointer then fails in
copy_from_user() / vmemdup_array_user() as before, and this check can
go), or at least say in a comment above the macro that NULL means
zero-fill?

Reviewed-by: Fei Yu <fei.yu@intel.com>

Thanks,
Fei
