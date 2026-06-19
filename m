Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C378CD98F6
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 11:27:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDC7E10E072;
	Fri, 19 Jun 2026 11:27:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="bCkKutjg";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0FCE10E072
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 11:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781868423; x=1813404423;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=BPzg53B4d2uezihy35qEJ+C+HimwhYlZBZSiU+3ViEc=;
 b=bCkKutjgFMdYGhRFCBTAFsGYb0NvAqd/EoSBwRWDCdVKyBNAichElQV/
 wGaeXmJTLw/mQuXBwBozj6alVw9EdzcSTvWc2Z7zQPOOAtQv/ycUTOLLR
 ZP7f4FPNnQHycxpPE+qDe9JoaBGV1ypaT0EXYbsR8PTA2zaXDtYOvI3mh
 QCgIxruFz3VCP3sAq0QCyhYihF9eKDH9q3dSw15jvTh4Sg+DkbFzFzxAk
 5y4/tYuV9DYxqIxwBOnWA7SxzRXaLT1NlZAkbm/SEzyQ8xOf/LcH1Ooj1
 ZaCyMM58hviFAMW8DxA2dY8AwEU/nu8PEa6r8KRBSIdslWPlhGVaxCxfm Q==;
X-CSE-ConnectionGUID: q8S98dnvSLK+wnoRK4g4yQ==
X-CSE-MsgGUID: ZxvtVn6ZRXWi6AiVsGzJew==
X-IronPort-AV: E=McAfee;i="6800,10657,11821"; a="70228402"
X-IronPort-AV: E=Sophos;i="6.24,213,1774335600"; d="scan'208";a="70228402"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jun 2026 04:27:02 -0700
X-CSE-ConnectionGUID: +yTa1g+ZSxa1gJbcTRvyXA==
X-CSE-MsgGUID: 3wMtDynvQSWl+nLtyJRkPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,213,1774335600"; d="scan'208";a="286735681"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.244.188])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jun 2026 04:27:00 -0700
Date: Fri, 19 Jun 2026 13:26:57 +0200
From: Andi Shyti <andi.shyti@linux.intel.com>
To: Krzysztof Niemiec <krzysztof.niemiec@intel.com>
Cc: dri-devel@lists.freedesktop.org, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Joel Fernandes <joelagnelf@nvidia.com>,
 Andi Shyti <andi.shyti@linux.intel.com>,
 Krzysztof Karas <krzysztof.karas@intel.com>,
 Sebastian Brzezinka <sebastian.brzezinka@intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
Subject: Re: [PATCH 2/2] gpu/tests: Add a dedicated .kunitconfig
Message-ID: <ajUngfhlAatTqvK-@ashyti-mobl2.lan>
References: <20260618152331.36763-1-krzysztof.niemiec@intel.com>
 <20260618152331.36763-3-krzysztof.niemiec@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618152331.36763-3-krzysztof.niemiec@intel.com>
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

Hi Krzysztof,

On Thu, Jun 18, 2026 at 05:23:31PM +0200, Krzysztof Niemiec wrote:
> Add a dedicated .kunitconfig for running the GPU buddy allocator tests.
> 
> Signed-off-by: Krzysztof Niemiec <krzysztof.niemiec@intel.com>

not a bad idea!

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>

Thanks,
Andi
