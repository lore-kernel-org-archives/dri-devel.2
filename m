Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9423FC72C5
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 12:38:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1780E10E3CA;
	Mon, 23 Mar 2026 12:38:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nnyzGq3O";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9969010E3C9;
 Mon, 23 Mar 2026 12:38:10 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 854D3600CB;
 Mon, 23 Mar 2026 12:38:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5A21C2BCB1;
 Mon, 23 Mar 2026 12:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1774269489;
 bh=rkx+d/cCup4mYc8hIEmm49s0orQZ9+5H/BGP8P6UdMI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=nnyzGq3OikkxSI6RE07xpwTs56qwH7VpWX91JO4Tedr5fiDGB8QpFlrPxPTORJA0f
 FIUf+wkxKj1ZXfRgsExPWvLIbKwPETPT0wmhGPv8sGkm9VmhJU2ZYHvvxHDljIihZP
 1qpUksXJwu2+NuhONKC5HP8JDQi8JLfyUFW0CQUA=
Date: Mon, 23 Mar 2026 13:37:46 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: cve@kernel.org, Li hongliang <1468888505@139.com>,
 srinivasan.shanmugam@amd.com, patches@lists.linux.dev,
 linux-kernel@vger.kernel.org, alexander.deucher@amd.com,
 Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch,
 sashal@kernel.org, guchun.chen@amd.com,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 6.1.y] drm/amdgpu: Fix potential out-of-bounds access in
 'amdgpu_discovery_reg_base_init()'
Message-ID: <2026032335-muster-chump-60f7@gregkh>
References: <20260323071052.4068410-1-1468888505@139.com>
 <f2d125ce-8cb9-4ae8-8f55-0b5a78e66f83@amd.com>
 <2026032346-ruse-dork-baf3@gregkh>
 <bd383c94-8350-420c-adbf-cc02a9918a37@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bd383c94-8350-420c-adbf-cc02a9918a37@amd.com>
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

On Mon, Mar 23, 2026 at 01:28:24PM +0100, Christian König wrote:
> Hi Greg,
> 
> On 3/23/26 11:32, Greg KH wrote:
> > On Mon, Mar 23, 2026 at 10:51:18AM +0100, Christian König wrote:
> >> Hi Li,
> >>
> >> On 3/23/26 08:10, Li hongliang wrote:
> >>> From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> >>>
> >>> [ Upstream commit cdb637d339572398821204a1142d8d615668f1e9 ]
> >>>
> >>> The issue arises when the array 'adev->vcn.vcn_config' is accessed
> >>> before checking if the index 'adev->vcn.num_vcn_inst' is within the
> >>> bounds of the array.
> >>>
> >>> The fix involves moving the bounds check before the array access. This
> >>> ensures that 'adev->vcn.num_vcn_inst' is within the bounds of the array
> >>> before it is used as an index.
> >>>
> >>> Fixes the below:
> >>> drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:1289 amdgpu_discovery_reg_base_init() error: testing array offset 'adev->vcn.num_vcn_inst' after use.
> >>
> >> well this patch only fixed a compiler warning and has not much practical value otherwise.
> >>
> >> Why are you sending this for inclusion into the 6.1 kernel?
> > 
> > Perhaps because it was assigned to CVE-2024-27042?  If this is ONLY a
> > compiler warning fix, and NOT an actual vulnerability fix, please let
> > cve@kernel.org know about that and they will revoke this CVE.
> 
> Thanks a lot for pointing that out, adding cve@kernel.org.
> 
> As far as I can see the CVE-2024-27042 is not valid or at least not correctly categorized.
> 
> It is correct that there is a potential array overrun in amdgpu_discovery_reg_base_init(), but that function is used to parse a VBIOS table from a flash EEPROM located on the HW and not user input.
> 
> If an attacker already had the ability to modify that EEPROM he could just overwrite the VBIOS code were parts are directly executed at bootup and/or driver load. So this problem here wouldn't be needed at all.
> 
> It is good that this warning is fixed, but as far as I can see there is no reason whatsoever to backport it nor to assign a CVE entry for it.

Now rejected, thanks!

greg k-h
