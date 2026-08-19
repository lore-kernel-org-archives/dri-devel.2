Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AC4AC5B572
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 08:18:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D899C10E24F;
	Wed, 19 Aug 2026 08:18:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="dyg3Oq43";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5414110E24F
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 08:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787127485; x=1818663485;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ZuWDyIBOdNYDPkNZyP4jSMIh03UuxtWcNBlU6DMMd14=;
 b=dyg3Oq434tpR9Ze1V87/KKDdQeLkP+128JakG+PZQhUrE29FtrwuX0Cz
 RYm9s9aVuWq9t7waluc3J/yQ2w9BOIMb+xn6n82jXwnvEWY4QX7auifH8
 p7EMhe6tZL2AXsQmBaTIvsc9m3LQ2s+2dSEt0wx5q7fGk0nwhnr3kXQuO
 3RReaQE6EL5NZN8j+Ml5I1dGqHvW9SSbqiUhv1YzdCEKUdF+x2zEE+Gbd
 fhRi+jA6UQlj+J5GbEPGXIViWo7a5UunZANzmT2zOqRyhc+tr4isSdnIc
 oHKUdqixme6toRMo3axEMRBQa+mj9AMmY23cvj8bX2sG6Gkvo56twEJuf g==;
X-CSE-ConnectionGUID: Cj3+rWZkS4W9MdLnaPEsgA==
X-CSE-MsgGUID: 4M+hgVxyTF2+M66TZ1t8HQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11879"; a="105165667"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; d="scan'208";a="105165667"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2026 01:14:46 -0700
X-CSE-ConnectionGUID: 9JdXdAHNTeCYh44PNe0xMw==
X-CSE-MsgGUID: J3kZ9h0zRjmdq051Dtr+jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; d="scan'208";a="270680863"
Received: from tester.sh.intel.com ([10.112.106.126])
 by fmviesa005.fm.intel.com with ESMTP; 19 Aug 2026 01:14:44 -0700
From: Tao Yu <tao1.yu@intel.com>
To: sashiko-bot@kernel.org
Cc: dri-devel@lists.freedesktop.org, sashiko-reviews@lists.linux.dev,
 tao1.yu@intel.com
Subject: Re: [PATCH] drm/gud: validate TV mode names before creating enum
 property
Date: Wed, 19 Aug 2026 16:14:42 +0800
Message-Id: <20260819081442.4092116-1-tao1.yu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260819073834.2714F1F00A3A@smtp.kernel.org>
References: <20260819073834.2714F1F00A3A@smtp.kernel.org>
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

Thanks for the review.

This patch is intentionally limited to fixing the out-of-bounds read caused
by malformed TV mode names. The NULL-dereference risk caused by TV property
ordering is a separate pre-existing issue, and I am addressing it in a
separate follow-up patch.

Thanks,
Tao
