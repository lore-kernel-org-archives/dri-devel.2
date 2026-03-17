Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEB9EFEDA1A
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 20:10:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC96110E1D1;
	Tue, 17 Mar 2026 20:10:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="HepQ14Il";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F28FD10E1D1
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 20:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773778207; x=1805314207;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=NMZP6Qz3YNz6DHSAOxPDT4rZ1sUP3PSvyuJhKwPtVmM=;
 b=HepQ14IlwsyX4MV5pyaIcwkQBeHWsmMg0BQGBOBJo+YIH/NMSvWEM7wW
 fJ5RvId8ZpNGBnweit/u6+FsFKclKKX4SOn/txbWdFZwVCJTbxSpskmiM
 fZEHLN8CHQzD+gbbv6Ww4e6BCgJ3b0+k5QNw0OS7yuiEHjIjHG2sRK95u
 8nbs1714w5pq4zjVIKbUUkUf4+I/cMHV9bqPOtZjx7n0o2EVd0KDXwDNi
 UNNUK2MZfEIUCiQc+GpCZMj+lREBfrbdbinA8BOOAP+icqU3QOVZ3Pmp2
 h86TByD/4AmAMJ+6P2P6GwbWSSgi1PKpYWu+wi1zJjxo8H3nRvy2xfg1Q g==;
X-CSE-ConnectionGUID: HiDv7MAxSCWnfVAiZ4mU+g==
X-CSE-MsgGUID: V6Y9NSa+Q/6x8zsSzbYirw==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="85519388"
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; d="scan'208";a="85519388"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2026 13:10:06 -0700
X-CSE-ConnectionGUID: ype5y8bESTaY+gm9jfzMQQ==
X-CSE-MsgGUID: j2go9QJXRG+lmq0mfiPPJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; d="scan'208";a="221449095"
Received: from chu13-desk.fm.intel.com ([10.80.209.210])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2026 13:10:06 -0700
From: Austin Hu <austin.hu@intel.com>
To: ville.syrjala@linux.intel.com
Cc: austin.hu@intel.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, robin.clark@oss.qualcomm.com
Subject: Re: [PATCH] drm/atomic: clear the state of plane which is unused.
Date: Tue, 17 Mar 2026 13:07:46 -0700
Message-Id: <20260317200746.501646-1-austin.hu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <abj79EU0bMEkcSD3@intel.com>
References: <abj79EU0bMEkcSD3@intel.com>
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

Hi Ville,

Thanks for your comments!

> The kernel isn't allowed to magically change the value of
> properties set by userspace, apart from a few special cases.
>
> No idea what you're actually trying to fix here, but sounds
> like your userspace might be broken and needs to be fixed.

I agree that userspace should reset unused plane properties.
Otherwise, the drm_plane_state UAPI "sticky" values may not
match what is actually programmed to hardware, which can be
confusing.

For example, i915_display_info debugfs shows:

    [PLANE:123:plane 4A]: type=OVL
        uapi: [FB:0] n/a,0x0,0x0,, visible=Y plane,
              src=125.000000x48.000000+0.000000+0.000000,
              dst=125x48+897+0, rotation=0 (0x00000001)
        planar: Linked to [PLANE:33:plane 1A] as a Y plane
        hw: [FB:567] NV12 little-endian (0x3231564e),
            0x100000000000010,2048x1088, visible=no,
            src=1920.000000x1080.000000+0.000000+0.000000,
            dst=1920x1080+0+0, rotation=0 (0x00000001)

That said, I was wondering if DRM could also reset unused
plane state defensively, in case userspace does not do so.
For example:

https://gitlab.freedesktop.org/drm-hwcomposer/drm-hwcomposer/-/blob/main/drm/DrmPlane.cpp#L464

Maybe this is not the right way, but my intention was to avoid
such mismatches.

Thanks,
Austin
