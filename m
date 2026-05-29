Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4BCDCD6E43
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 11:41:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3495B10FDC7;
	Fri, 29 May 2026 11:41:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="s4q1OhIa";
	dkim-atps=neutral
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by gabe.freedesktop.org (Postfix) with ESMTP id CDBBE10FDC7
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 11:41:08 +0000 (UTC)
Received: by linux.microsoft.com (Postfix, from userid 1216)
 id 4198D20B7167; Fri, 29 May 2026 04:40:57 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4198D20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1780054857;
 bh=qveO8jYL+5Nz6TdMpNHPka2rOiang3qZOK/8ZXcpwdQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=s4q1OhIaU83v+cT3ZlIPWSPU0HW18wkUXj9cb8B1qDgP21qaTr8P/zQimij0fVQJJ
 wEw4At/08ktSTPk+jJLAxvSDJyoFtNyZP36gmFIDK3028+5OSU/kGjCIy0Qmg/ooNq
 dfzvVHCRWsSxQDx1O5ROfCkw5zSF1w92oiMwWyoQ=
Date: Fri, 29 May 2026 07:40:57 -0400
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: mhklinux@outlook.com
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 decui@microsoft.com, longli@microsoft.com,
 ssengar@linux.microsoft.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH v3 1/1] drm/hyperv: Use "hv_drm_" as symbol name prefix
Message-ID: <ahl7SWMUqsqFSMjN@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260529014826.41256-1-mhklkml@zohomail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529014826.41256-1-mhklkml@zohomail.com>
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

On Thu, May 28, 2026 at 06:48:26PM -0700, Michael Kelley wrote:
> From: Michael Kelley <mhklinux@outlook.com>
> 
> Function and structure names in the Hyper-V DRM driver currently
> use "hyperv_" as the prefix. This conflicts with usage in core Hyper-V
> and VMBus code, and incorrectly implies that functions and structures
> in this driver apply generically to Hyper-V. A specific conflict arises
> for "hyperv_init", which is an initcall for generic Hyper-V
> initialization on arm64. The conflict prevents the use of
> initcall_blacklist on the kernel boot line to skip loading this driver.
> 
> Fix this by substituting "hv_drm_" as the prefix for all functions and
> structures in this driver. In most places, this is replacing "hyperv_"
> with "hv_drm_". In a few places, the substitution results in
> "hv_drm_drm_", which has been collapsed to just "hv_drm_". In two
> cases, the existing prefix is a bare "hv" (including in the to_hv()
> macro), which has been replaced with "hv_drm" for consistency.
> 
> The changes are all mechanical text substitution in symbol names.
> There are no other code or functional changes.
> 
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> Reviewed-by: Dexuan Cui <decui@microsoft.com>

Applied, thanks!
