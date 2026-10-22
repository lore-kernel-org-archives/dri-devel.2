Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF1E606A319
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 11:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=J7D16Nrx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E00C7112504;
	Thu, 22 Oct 2026 11:11:52 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 765E11124FE;
 Thu, 22 Oct 2026 11:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792667508; x=1824203508;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=PXeNzYKdF9nvSMsofSGGo6a352WSrrmiD4mLexC+jYA=;
 b=J7D16NrxWP+IR5/by0ptoEIjdlWRBGtLADllCWfj4xNmkRuZBG3FWa70
 KG8vqJIYOm1ii7+MKFAuFpTvI1zBKJgQPfDY5iFA2PrQ2pymF+SfEAC14
 G32E14D/ERiLoX1uPD5civwd+0/WOCzdB6hBT5CJ73nfYlOCxtR6e2o1i
 xK6R2aPV25HSOKk9XvhxDEAb8opzhVXW7nJVOHvYOHVHzHDVvEKnKVptd
 HIWE8ML2+diJ/n2F6EvcVcOIOkjYIU7DxY9D36uBn7G95wi5Ax86thHrF
 fAMtFB44iNO5hzj0oeJLbHYrsx95lvMj8JzogtiJeuum/asLAorhrER3B g==;
X-CSE-ConnectionGUID: TNvonzSxRKCcReo4VZK39w==
X-CSE-MsgGUID: 39FKyeHaT+iyomzWvaJ8iw==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1447192"
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="1447192"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Oct 2026 04:04:05 -0700
X-CSE-ConnectionGUID: hT78EouLRaul8FJVU7XKHw==
X-CSE-MsgGUID: 2538i0qiQCui2pW8SJpxrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="3743204"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost)
 ([10.245.244.5])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Oct 2026 04:04:02 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Andi Shyti <andi.shyti@kernel.org>, Krzysztof Karas
 <krzysztof.karas@intel.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, Andi
 Shyti <andi.shyti@linux.intel.com>, Janusz Krzysztofik
 <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>
Subject: Re: [PATCH v5 1/6] drm/i915/selftests: Use gt_*/drm_* prints in
 core selftests
In-Reply-To: <atkzD99digX-p3KI@zenone.zhora.eu>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20261001074100.2694888-1-krzysztof.karas@intel.com>
 <20261001074100.2694888-2-krzysztof.karas@intel.com>
 <atkzD99digX-p3KI@zenone.zhora.eu>
Date: Thu, 22 Oct 2026 14:03:58 +0300
Message-ID: <46d91f68ae44178727e7105b36058e5722e2ee5c@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 22 Oct 2026, Andi Shyti <andi.shyti@kernel.org> wrote:
>> Assisted-by: GitHub-Copilot:claude-opus-5
>
> Assisted-by: LLM

No, please zap the whole Assisted-by trailer [1].


BR,
Jani.


[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1e035297ffdadf2184c3c773b8c098e372324aaf


-- 
Jani Nikula, Intel
