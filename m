Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587B5606A336
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=inxstQ9z
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95DF910EDA9;
	Mon,  2 Nov 2026 13:02:07 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42CBA10EDAF;
 Mon,  2 Nov 2026 13:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793624521; x=1825160521;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=drxTo++OZkH7kBDSpfcynKa97bsiB9evM2el8QcMEC0=;
 b=inxstQ9zkCPbKo0XIQD8fAz6Nf5J1OBtT0ABo9NTTra6B6CVOD5iLbQm
 vJOemDAhe/7+V5yZxwnhlpV+x5i/+ZVF47CQMlZFvb/A4YwFiXStGoUgd
 CpdTxqSJzjC0fXWikU3oMAjfd9tEan5cAihFQFTTO3gYKZ6UcIsRtkJUx
 vNLhJIP7HXeWWlJwOsxCY8ywSGEWhH9TkTNnYcHVFef0+y5PdGMVWqNeW
 GCyajC5aTI4N0ivHYc04ZO8L6/Gub0JLkLKGyFAIohnoZ9B3R4wxIM2J+
 t3Vl8SP/CVaNmGR2AFra+jTiSzAfHGu3B/30ncqh7gl23fn6sjwpt4/HV g==;
X-CSE-ConnectionGUID: twn57bJyTvu/xolwUKzZZw==
X-CSE-MsgGUID: 5GNs1WnJSderR1ujK33vUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11953"; a="2191419"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2191419"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 05:01:49 -0800
X-CSE-ConnectionGUID: 7v3+O6SmRse+47iagkBWOA==
X-CSE-MsgGUID: FVk/xTTMQl2oCXXGju5lfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6449554"
Received: from black.igk.intel.com ([10.91.253.5])
 by fmviesa001.fm.intel.com with ESMTP; 02 Nov 2026 05:01:46 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
 id 236A699; Mon, 02 Nov 2026 14:01:45 +0100 (CET)
Date: Mon, 2 Nov 2026 14:01:45 +0100
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: diego.sure@gmail.com
Cc: Imre Deak <imre.deak@intel.com>, dri-devel@lists.freedesktop.org,
 Uma Shankar <uma.shankar@intel.com>,
 Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Mika Westerberg <westeri@kernel.org>,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] drm/dp_tunnel: Allow BWA when the DP IN adapter does
 not advertise it
Message-ID: <20261102130145.GU158991@black.igk.intel.com>
References: <20261031-dp-tunnel-bwa-flag-v1-1-f94ed3179349@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261031-dp-tunnel-bwa-flag-v1-1-f94ed3179349@gmail.com>
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
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On Sat, Oct 31, 2026 at 01:18:18AM +0100, Diego Noguês via B4 Relay wrote:
> From: Diego Noguês <diego.sure@gmail.com>
> 
> On an Alder Lake host (i7-1265U) with a Thunderbolt 4 dock (Dell WD22TB4,
> Goshen Ridge) driving two 4K@60 monitors through two DP tunnels, the
> monitor whose tunnel is created second is limited to 4K@30. Which monitor
> is affected depends only on the order in which they are powered on.
> 
> The thunderbolt driver enables the BW allocation mode (BWA) on both DP IN
> adapters: it sets the CM BWA support (DP_USB4_DRIVER_BW_CAPABILITY), a
> group ID and the estimated BW. The DP IN adapter, however, never sets
> DP_IN_BW_ALLOCATION_MODE_SUPPORT in DP_TUNNELING_CAPABILITIES (0xe000d
> reads 0x01), so tunnel_regs_are_valid() rejects the tunnel with:

Alder Lake firmware really does not support this and by forcing it to be
enabled you may end up in untested code paths and interesting behavior :)
BWA was only officially supported starting from Meteor Lake.
