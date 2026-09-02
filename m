Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B099C624D3
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 14:23:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3F5110E028;
	Wed,  2 Sep 2026 14:23:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="bUr0a2Ef";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 752EC10F21F;
 Wed,  2 Sep 2026 14:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788359036; x=1819895036;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=kIj3SQ38TZT4z5GtBLMD6A8gzF/051ealJf9nGBjOAg=;
 b=bUr0a2EfuMpBfIxUYPzI8A/T2KP9TF8hTHY/IbbsdIcyg+qEcbOzCV48
 SnKdTRWLJG6eLgktlSRB1inPTO87aWWfiwuGBym/QHRH/3TSH8yvxXCij
 k9r07Q6/TvvK+7/ucFFE8d0FdqXmz5DEZ8K8e8QsYqZKOsHXQVOijctDe
 PovFfN3063QoH0rRdyeX2DGFsSIrV29VPhn2Xqc2aNE7vOMLYK1yVQC84
 bNQE3HoO/QsTOWJAUFXFNq7mFS+RNrDqeDpQpINt1ZJtDxCZqcNfQg3Df
 uHWOLGTYv/2aZ3uQnxVA3IljqiyUrGHjVvGljVpzVVxkc3VzpkSIAX5iW A==;
X-CSE-ConnectionGUID: rwh17PzUR4KpIMmEldCadw==
X-CSE-MsgGUID: sF9q/OKvS4KNqaloL2+Vcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="88581595"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; d="scan'208";a="88581595"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2026 07:23:56 -0700
X-CSE-ConnectionGUID: DwIXTqUmTTWVvKzen5TB1Q==
X-CSE-MsgGUID: s2UREMTXTy6DVkf02THQaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; d="scan'208";a="266186350"
Received: from vbelgaum-ubuntu.fm.intel.com ([10.1.39.16])
 by fmviesa007.fm.intel.com with ESMTP; 02 Sep 2026 07:23:55 -0700
From: Vinay Belgaumkar <vinay.belgaumkar@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
 Vinay Belgaumkar <vinay.belgaumkar@intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [PATCH v6 0/2] perf: Add some null ptr checks
Date: Wed,  2 Sep 2026 07:18:22 -0700
Message-Id: <20260902141824.733112-1-vinay.belgaumkar@intel.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
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

This series fixes a crash seen when the PMU ptr is freed while
there is an open perf connection.

Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Vinay Belgaumkar <vinay.belgaumkar@intel.com>

Vinay Belgaumkar (2):
  perf: Fix null pointer access in is_include_guest_event()
  perf: Add checks to prevent null ptr access

 kernel/events/core.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

-- 
2.38.1

