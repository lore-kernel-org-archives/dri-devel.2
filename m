Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F3F0C55184
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 03:08:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8EA110E0E3;
	Tue,  4 Aug 2026 03:08:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="BEeUDIRi";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1EE010E53E
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 03:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785812884; x=1817348884;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=6e7fEo+yH3CS0utjEIF3ZYJk0Bo7r58b+dyBnMlNWrM=;
 b=BEeUDIRiZkR/62M/ZH94hKGFgcQRAW0n7xOP5t8FT4j2qod2rwq1Fbkp
 PSahVTfoMVMclObhNXZiPrKLIbLEal/cQhW1FEkTQpMDHFZX/r1shWzmU
 6bSrjkY131c+Y3TTpJp1OK80Yzyw06VLe050YgRwn+WP4YSHTMGfncEB+
 6oVq3YcGQ/ywRl5Z+2hMaiaultFKvgfPriGX5MA1v99A+BwPDW29S//Se
 WUvQxzAleem3k0Ve8FDBGghKIr3Yu3JkXjVPvBs96FB3CePiISmnFZxoQ
 E3hf5W1y9NJPYv3rWwXoY/hbP6AcjgWL6e3hMwGQ2kt6tD2XoYP8NBEX/ g==;
X-CSE-ConnectionGUID: LDsm7AmARNy4UZHDlrxXmA==
X-CSE-MsgGUID: d2z+eBhxTqajfAyfENt3NQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="86436511"
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; d="scan'208";a="86436511"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Aug 2026 20:08:04 -0700
X-CSE-ConnectionGUID: aMuq/oAxQVC5HJwYLjVslg==
X-CSE-MsgGUID: 99FrX/6zQcCkd8pv2NtdUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; d="scan'208";a="265642998"
Received: from junjie-desk-dev.bj.intel.com (HELO
 junjie-desk-dev.tail2c02c1.ts.net) ([10.238.152.71])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Aug 2026 20:08:01 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Pengyu Luo <mitltlatltl@gmail.com>
Subject: Re: [PATCH v2 1/3] backlight: aw99706: Fix DT property names to match
 binding
Date: Tue,  4 Aug 2026 11:07:07 +0800
Message-ID: <20260804030707.1936569-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260803141310.1379194-2-junjie.cao@linux.dev>
References: <20260803141310.1379194-2-junjie.cao@linux.dev>
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

The rest of this series was lost to a mail delivery failure; please
ignore this one and see v3 instead. Sorry for the noise.
