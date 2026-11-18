Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B83606A32F
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 08:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SPvxqWAd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2087010E711;
	Wed, 18 Nov 2026 08:01:14 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72D0C10E711
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 08:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794988868; x=1826524868;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=7s1YEUu0h5LWCmwc+9PJTO+WoXjBAvVCtfdBExqnlJU=;
 b=SPvxqWAdNyq/bI0sBtkA61aGOZ2GXskADoxfjzWgoBRUAiRQP+5A6+dB
 8wIMcrL+YDKy8yXvENNPLjjylyBdlP5TaITvnOn7BeSAkyvjhgzj8802L
 xfdI3CV6E4kxuN/fawuJmyX0qgXSGCU1ejMljHyecrVC47kiFa6KX65Nt
 QAoTY1ESPW0RZUG4VnNz2afHSGFcw7n5iybkHsy6tiNccP5f5cQUOieq9
 ch8r7aQuVEMG8jwf6RBMCl0xcskR9EMXBXpUyf2/Ru00NAqok18u1lBuJ
 Hkb1mKyR1kUw/hCyHiznutXoFKjSiJqXWceWJZBZzDBHVmlcuLzPbZxdw A==;
X-CSE-ConnectionGUID: w3wrqJNZQdWWZVdilpU3Ag==
X-CSE-MsgGUID: rjNkk2uYTUqRHZGCnTmD+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3706669"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3706669"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 00:00:55 -0800
X-CSE-ConnectionGUID: lyTRmHbiS6ac+zR6ybOY3g==
X-CSE-MsgGUID: eiQLTdwBR6GAZSGILnEBIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; d="scan'208";a="10599471"
Received: from yufei-super-server.sh.intel.com ([10.239.92.104])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 00:00:52 -0800
From: "Yu, Fei" <fei.yu@intel.com>
To: tvrtko.ursulin@igalia.com
Cc: dri-devel@lists.freedesktop.org, kernel-dev@igalia.com, mcanal@igalia.com,
 christian.koenig@amd.com, fei.yu@intel.com
Subject: Re: [PATCH 3/3] drm/syncobj: Add a fast path to drm_syncobj_array_find
Date: Wed, 18 Nov 2026 16:06:43 +0800
Message-ID: <20261118080643.180983-1-fei.yu@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261117103916.9101-4-tvrtko.ursulin@igalia.com>
References: <20261117103916.9101-4-tvrtko.ursulin@igalia.com>
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Fei Yu <fei.yu@intel.com>

On 11/17/26 10:39, Tvrtko Ursulin wrote:
> Therefore lets add a fast path to bypass the kmalloc_array/kfree and use a
> pre-allocated stack array for those cases.

Same as in 2/3, it's vmemdup_array_user()/kvmalloc_objs() now.

> @@ -1265,6 +1265,9 @@ static int drm_syncobj_array_wait(struct drm_device *dev,
>  static int drm_syncobj_array_find(struct drm_file *file_private,
>  				  void __user *user_handles,
>  				  uint32_t count_handles,
> +				  uint32_t *stack_handles,
> +				  struct drm_syncobj **stack_syncobjs,
> +				  u32 stack_count,
>  				  struct drm_syncobj ***syncobjs_out)

The handles array is freed before drm_syncobj_array_find() returns,
so the callers don't need to provide it. A local
"u32 stack_handles[DRM_SYNCOBJ_FAST_PATH_ENTRIES]" in
drm_syncobj_array_find() would do, and the six callers would only
declare and pass stack_syncobjs. Not a must, but it saves some
boilerplate. (Also u32 vs. uint32_t is mixed here.)

> -	syncobjs = kvmalloc_objs(*syncobjs, count_handles);
> -	if (syncobjs == NULL) {
> -		ret = -ENOMEM;
> -		goto err_free_handles;
> +		syncobjs = kvmalloc_objs(*syncobjs, count_handles);;

Double semicolon (checkpatch warns).

The DRM_SYNCOBJ_MAX_HANDLES check stays in front of the fast/slow
split, good. With the ";;" fixed:

Reviewed-by: Fei Yu <fei.yu@intel.com>

Thanks,
Fei
