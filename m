Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83C68F33807
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 07:09:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3BD010E34B;
	Tue, 17 Mar 2026 07:09:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="bjP/Zt2L";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4923F10E34B
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 07:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773731382; x=1805267382;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=ydlq9iZT7pXZv1FbMyd6TdpJuscB6ziFp9CUv6mPs+0=;
 b=bjP/Zt2Lh//2qa2CEU1Nzrspk5alNYzebs4rU4x52ftB/YwxNzc0yghl
 qzPZXOpGF/u+b77hWHd3psk6g9f4v0Sb2jbtAli/0bdZpRcph4cew1coH
 lczEfNgaK04hYf8mZNVUKrBOwaBn9nkxIKavH66oJ6aaUaGo1ZJlHd312
 GhxlYkPVspGjKbDDhg24E9DJrvyfSknFU2FIXtaAIR/y82DTQepAJvIFi
 P8kEOfiRA/MGawqy+ZOEsIAHDpE2D7OCZzYQ0fQl+mTo+kDXfAEr40YoA
 KcxY519/3C0BkpEeiGDjEthIyzIg+AoCt+2/adlwPD3/9x7Gf95erhehh w==;
X-CSE-ConnectionGUID: ufxEDksxTdKYMiRpuSwnZg==
X-CSE-MsgGUID: viW74/NjQKS9hZQtiN1LQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="62321764"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="62321764"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2026 00:09:41 -0700
X-CSE-ConnectionGUID: 2rl5YYinR4qS/QnWc+E1oA==
X-CSE-MsgGUID: q2NQSYzSTIKk/IPjh2pz+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="218346746"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.245.99])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2026 00:09:30 -0700
Date: Tue, 17 Mar 2026 09:09:27 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
 Jammy Huang <jammy_huang@aspeedtech.com>, Dave Airlie <airlied@redhat.com>,
 Jocelyn Falempe <jfalempe@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/ast: DisplayPort edid supports 256 bytes
Message-ID: <abj-J1yYsFymXmn5@intel.com>
References: <20260313-upstream_ast_dp_edid-v1-1-2a75b7c091b2@aspeedtech.com>
 <b0b1f644-ea5c-4636-99a0-28b040ed2fe0@suse.de>
 <ad40e82fc2e6501f1b6e1073c70a6f1c308c89a8@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ad40e82fc2e6501f1b6e1073c70a6f1c308c89a8@intel.com>
X-Patchwork-Hint: comment
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
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

On Mon, Mar 16, 2026 at 01:38:22PM +0200, Jani Nikula wrote:
> On Mon, 16 Mar 2026, Thomas Zimmermann <tzimmermann@suse.de> wrote:
> > Hi Jammy
> >
> > Am 13.03.26 um 11:04 schrieb Jammy Huang:
> >> DisplayPort supports edid at most 256 bytes. Thus, allow it to fetch
> >> edid block 0 and 1.
> >>
> >> Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
> >> ---
> >> ASPEED DisplayPort's EDID size can be 256 bytes at most. Thus, EDID
> >> blocks fetched can be 0 and 1.
> >> ---
> >>   drivers/gpu/drm/ast/ast_dp.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/gpu/drm/ast/ast_dp.c b/drivers/gpu/drm/ast/ast_dp.c
> >> index 9d07dad358c..c938e1d6b1d 100644
> >> --- a/drivers/gpu/drm/ast/ast_dp.c
> >> +++ b/drivers/gpu/drm/ast/ast_dp.c
> >> @@ -88,7 +88,7 @@ static int ast_astdp_read_edid_block(void *data, u8 *buf, unsigned int block, si
> >>   	int ret = 0;
> >>   	unsigned int i;
> >>   
> >> -	if (block > 0)
> >> +	if (block > 1)
> >>   		return -EIO; /* extension headers not supported */
> >
> > But see the code at [1]. It clears the number of extensions to zero and 
> > updates the checksum accordingly. This is required to make the shortened 
> > EDID work with DRM. If you leave this as-is, it will still clear support 
> > for any extension in block 1.
> >
> > See the table 2.4 in the VESA EDID 1.4 standard for the semantics. For 
> > 1.3, if the number of blocks is >2, the first extensions is a 'block map 
> > of the extensions'. This is useless, as it's not a data extension in 
> > itself.  In 1.4, the block map is optional. That code should clear the 
> > EDID's number of extensions to 0 or 1, depending on whether there is a 
> > block map to be expected.
> 
> I think long-term the goal should be for the kernel to not modify the
> EDID, at all.

I think as a short term goal it would be much better if all EDID
mangling would be done by drm_edid.c rather than individual drivers.

-- 
Ville Syrjälä
Intel
