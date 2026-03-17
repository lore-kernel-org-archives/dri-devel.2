Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08D54F3380C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 08:12:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D07A10E558;
	Tue, 17 Mar 2026 08:12:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="YhVu0QWP";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFD8A10E558
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 08:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773735140; x=1805271140;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=gSar/ZcMuK/0YBH76OngvipkYZaWuMPb2lH4klejFqs=;
 b=YhVu0QWPGFxeCOySlAq4x/JFBzi5NMH+FhTQNk2E2L5apjU9Nv1NRyyL
 3WC7fjsFBa0qNssPslVz2AL+ZVodXdWoluERBQxOan7qE7o9Q+TS754X2
 Ui9kTguJJb55LrOM+POW9JwkGqFRXjujC8G6mOLOkY1EvBBB/KqIUxbnW
 k9LWzijo0o2xk1mtfdacJeWjnzbj4N8qgTKIT4n+OS/+9j2b9CgummsFk
 a1py36YtuNRFjNfVfDOd0TPC3kQHYsUDxOpkjbJrQqT6QEcP7LqjwYqg7
 oIn1eJqp51o4LvqO3tU1N1r5t5hNwAyZ+zUYEYeQ4+6TUOag2q40xads1 w==;
X-CSE-ConnectionGUID: cq4t5MucTB6AF3guvh8iKQ==
X-CSE-MsgGUID: d6q+L3iiTymGXnSTI2CV7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="74839027"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="74839027"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa108.fm.intel.com with ESMTP; 17 Mar 2026 01:12:19 -0700
X-CSE-ConnectionGUID: XCsk+LsYRgKzmWIUjB9eZQ==
X-CSE-MsgGUID: uj9YVm2HRemt0Yec5MgdXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="260091139"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.245.99])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2026 01:12:14 -0700
Date: Tue, 17 Mar 2026 10:12:11 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
 Jammy Huang <jammy_huang@aspeedtech.com>, Dave Airlie <airlied@redhat.com>,
 Jocelyn Falempe <jfalempe@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/ast: DisplayPort edid supports 256 bytes
Message-ID: <abkM2-295MJO15ht@intel.com>
References: <20260313-upstream_ast_dp_edid-v1-1-2a75b7c091b2@aspeedtech.com>
 <b0b1f644-ea5c-4636-99a0-28b040ed2fe0@suse.de>
 <ad40e82fc2e6501f1b6e1073c70a6f1c308c89a8@intel.com>
 <abj-J1yYsFymXmn5@intel.com>
 <7b91451a-7764-4822-b15b-47437592691f@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7b91451a-7764-4822-b15b-47437592691f@suse.de>
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

On Tue, Mar 17, 2026 at 08:41:35AM +0100, Thomas Zimmermann wrote:
> Hi
> 
> Am 17.03.26 um 08:09 schrieb Ville Syrjälä:
> > On Mon, Mar 16, 2026 at 01:38:22PM +0200, Jani Nikula wrote:
> >> On Mon, 16 Mar 2026, Thomas Zimmermann <tzimmermann@suse.de> wrote:
> >>> Hi Jammy
> >>>
> >>> Am 13.03.26 um 11:04 schrieb Jammy Huang:
> >>>> DisplayPort supports edid at most 256 bytes. Thus, allow it to fetch
> >>>> edid block 0 and 1.
> >>>>
> >>>> Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
> >>>> ---
> >>>> ASPEED DisplayPort's EDID size can be 256 bytes at most. Thus, EDID
> >>>> blocks fetched can be 0 and 1.
> >>>> ---
> >>>>    drivers/gpu/drm/ast/ast_dp.c | 2 +-
> >>>>    1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/ast/ast_dp.c b/drivers/gpu/drm/ast/ast_dp.c
> >>>> index 9d07dad358c..c938e1d6b1d 100644
> >>>> --- a/drivers/gpu/drm/ast/ast_dp.c
> >>>> +++ b/drivers/gpu/drm/ast/ast_dp.c
> >>>> @@ -88,7 +88,7 @@ static int ast_astdp_read_edid_block(void *data, u8 *buf, unsigned int block, si
> >>>>    	int ret = 0;
> >>>>    	unsigned int i;
> >>>>    
> >>>> -	if (block > 0)
> >>>> +	if (block > 1)
> >>>>    		return -EIO; /* extension headers not supported */
> >>> But see the code at [1]. It clears the number of extensions to zero and
> >>> updates the checksum accordingly. This is required to make the shortened
> >>> EDID work with DRM. If you leave this as-is, it will still clear support
> >>> for any extension in block 1.
> >>>
> >>> See the table 2.4 in the VESA EDID 1.4 standard for the semantics. For
> >>> 1.3, if the number of blocks is >2, the first extensions is a 'block map
> >>> of the extensions'. This is useless, as it's not a data extension in
> >>> itself.  In 1.4, the block map is optional. That code should clear the
> >>> EDID's number of extensions to 0 or 1, depending on whether there is a
> >>> block map to be expected.
> >> I think long-term the goal should be for the kernel to not modify the
> >> EDID, at all.
> > I think as a short term goal it would be much better if all EDID
> > mangling would be done by drm_edid.c rather than individual drivers.
> 
> We don't fix the EDID here, but work around a hardware limitation. I 
> guess we could fix this automatically near edid_block_read() [1] if the 
> driver clearly communicates this issue.  The read loop could then fix 
> the header's checksum by itself.

edid_filter_invalid_blocks() already has the code to update
the extension block count and fix up the checksum.

So seems to me all we'd need is some way for the driver to
indicate it simply cannot read the requested block (based on
which edid_read_block() would return some other value than
EDID_BLOCK_READ_FAIL), and then the fixup happens naturally.

Hmm. What happens if the driver returns "success" for the
read, but just leaves the entire block zeroed? Looks to me
like we should then end up with status==EDID_BLOCK_ZERO
and the block will get treated as invalid and filtered out.

> Best regards
> Thomas
> 
> [1] 
> https://elixir.bootlin.com/linux/v6.19.8/source/drivers/gpu/drm/drm_edid.c#L2424
> 
> >
> 
> -- 
> --
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
> GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)
> 

-- 
Ville Syrjälä
Intel
