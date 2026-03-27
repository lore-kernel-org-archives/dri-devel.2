Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4CA610ED674
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 13:04:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EA6A10E1F7;
	Fri, 27 Mar 2026 13:04:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BV3Rye0s";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F101C10E0BE;
 Fri, 27 Mar 2026 13:04:26 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 973A340716;
 Fri, 27 Mar 2026 13:04:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18093C19423;
 Fri, 27 Mar 2026 13:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774616666;
 bh=rGKwmiXyHfN5+L0HwaW5Cnl1fARnmwe/8Hv058mvEgc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=BV3Rye0sYCmQmUfEhD7/wWYugEZIBkDLg4xEPQ0H0AwKhjnfFZjVWpx9/97U/Rp1l
 UmbYyTpTwLrVH2h6I+Wr1bDNir0jfF/mUPnihm+QuZ4Z9oTiL9sB6UgqaXgDnumP9I
 ve7iiNiF6Kfj0WEaR2gLXxUdWpPboUj8wp6upKPJhE0cWmEeFiXPBIdK95AIyaey5G
 Vlguwkdm30o+vXNkkoDt0KjrFUYjmoam3PwOwanVz8/3G1HQcPBwUAAkuDh2LhWvLJ
 fun10nNZRB6XrQ1EPxUQ0gQQEg438RBY4JWPpIFY8i7UIiekfIkPkdGXDPrU86YCDk
 6Tccau9Ty4Zpg==
Message-ID: <1208774a-f1ba-4785-a91e-ae141f97a64d@kernel.org>
Date: Fri, 27 Mar 2026 08:04:24 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] drm: Move AMD VSDB parsing into DRM EDID core
To: Chenyu Chen <chen-yu.chen@amd.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>
References: <20260327082342.1286878-1-chen-yu.chen@amd.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260327082342.1286878-1-chen-yu.chen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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



On 3/27/26 03:21, Chenyu Chen wrote:
> The AMD Vendor-Specific Data Block (VSDB) v3 parsing currently lives
> in amdgpu_dm, using raw byte-walking over EDID extension blocks. This
> series moves the parsing into the DRM EDID core so the data is
> available through drm_display_info for any driver.
> 
> Patch 1 adds the parser in drm_edid.c and the new drm_amd_vsdb_info
> struct in drm_connector.h.
> 
> Patch 2 updates amdgpu_dm to consume the parsed data from
> display_info instead of doing its own parsing, and factors out
> panel type determination into a dedicated function.
> 
> Chenyu Chen (2):
>    drm/edid: Parse AMD Vendor-Specific Data Block
>    drm/amd/display: Use drm_display_info for AMD VSDB data
> 
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 120 ++++++++++--------
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  14 --
>   drivers/gpu/drm/drm_edid.c                    |  72 +++++++++++
>   include/drm/drm_connector.h                   |  38 ++++++
>   4 files changed, 178 insertions(+), 66 deletions(-)
> 

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
