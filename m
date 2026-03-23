Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF035EC01C5
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 10:32:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57E4510E4D0;
	Mon, 23 Mar 2026 10:32:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="04wGH4mC";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10EE310E4D0;
 Mon, 23 Mar 2026 10:32:57 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id AFC9B43FA5;
 Mon, 23 Mar 2026 10:32:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 155C6C4CEF7;
 Mon, 23 Mar 2026 10:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1774261976;
 bh=nu9KpscKUDBHHpMe1GSngED3iiYBegN779XB3oiDq/0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=04wGH4mC1KfLOSBXHPTRJfNUuxnMmyK+Lsx5lpOWNqMYwWDLirA8niGIkoAcmghVA
 jyiXRHixl+6ydXRyru9sEQgDb3javn5DMXGxej+/A5KEl6Ghpvpk5JMDhhfo10luEX
 KFngbqFlqN/0lTu76BpXagjLE/N7QY7WCsuJpGDI=
Date: Mon, 23 Mar 2026 11:32:35 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: Li hongliang <1468888505@139.com>, srinivasan.shanmugam@amd.com,
 patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 alexander.deucher@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
 daniel@ffwll.ch, sashal@kernel.org, guchun.chen@amd.com,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 6.1.y] drm/amdgpu: Fix potential out-of-bounds access in
 'amdgpu_discovery_reg_base_init()'
Message-ID: <2026032346-ruse-dork-baf3@gregkh>
References: <20260323071052.4068410-1-1468888505@139.com>
 <f2d125ce-8cb9-4ae8-8f55-0b5a78e66f83@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f2d125ce-8cb9-4ae8-8f55-0b5a78e66f83@amd.com>
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

On Mon, Mar 23, 2026 at 10:51:18AM +0100, Christian König wrote:
> Hi Li,
> 
> On 3/23/26 08:10, Li hongliang wrote:
> > From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> > 
> > [ Upstream commit cdb637d339572398821204a1142d8d615668f1e9 ]
> > 
> > The issue arises when the array 'adev->vcn.vcn_config' is accessed
> > before checking if the index 'adev->vcn.num_vcn_inst' is within the
> > bounds of the array.
> > 
> > The fix involves moving the bounds check before the array access. This
> > ensures that 'adev->vcn.num_vcn_inst' is within the bounds of the array
> > before it is used as an index.
> > 
> > Fixes the below:
> > drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:1289 amdgpu_discovery_reg_base_init() error: testing array offset 'adev->vcn.num_vcn_inst' after use.
> 
> well this patch only fixed a compiler warning and has not much practical value otherwise.
> 
> Why are you sending this for inclusion into the 6.1 kernel?

Perhaps because it was assigned to CVE-2024-27042?  If this is ONLY a
compiler warning fix, and NOT an actual vulnerability fix, please let
cve@kernel.org know about that and they will revoke this CVE.

thanks,

greg k-h
