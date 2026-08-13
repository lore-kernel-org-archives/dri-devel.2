Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F29A6C5DF64
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 15:20:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E59D110E04D;
	Thu, 13 Aug 2026 15:20:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="fHS/Gj6o";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2223B10E04D
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 15:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786634447; x=1818170447;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=APemogmhtZDHWbVzDL+rN9To3ijEL2kyxlFbdtRKFp8=;
 b=fHS/Gj6oaS++AZaNRtLkNvNRsGWLGUkVpb4rDbq19QpdL3kCWtyO/Xpi
 AfYD+ZPpcVZQl0kZJf7W+s3wnKpOuH4hLP9MSJ5ROaNGTNW+CTbwSvXi2
 yzngSMyi8juCgphqXK8ACiad7saEoDZMA1n6R5jv6n/epjexUOx9/XHKf
 hvNuhPN8UtBS2kQpkuC5LzfsPEAldKReq4TL8cMtIswpB0rkRiKScZKtP
 bmpcvZnq7EEf1yB2fsASytii5c/vAQpOtMYspD29bx2WKNLrD2jvQYQcd
 +HbV+Kwx9mB1JUAl5f5X5yQRuwtul99G1/m2RIBZD+F2s0QEVcAbidA4J A==;
X-CSE-ConnectionGUID: Rv4CNb96SjqI5Hl7zu2oUw==
X-CSE-MsgGUID: WmArrCUiSoai8s5A7QfeEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="87337712"
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; d="scan'208";a="87337712"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2026 08:20:46 -0700
X-CSE-ConnectionGUID: Gpzvu8jwRUGOF18DA0pujw==
X-CSE-MsgGUID: iVbRuQ3JQWuGZ44qPS/BeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; d="scan'208";a="260695153"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
 by fmviesa007.fm.intel.com with ESMTP; 13 Aug 2026 08:20:42 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wuXEV-00000000VhS-2AlQ;
 Thu, 13 Aug 2026 15:20:39 +0000
Date: Thu, 13 Aug 2026 23:19:53 +0800
From: kernel test robot <lkp@intel.com>
To: Louis Chauvet <louis.chauvet@bootlin.com>,
 Melissa Wen <melissa.srw@gmail.com>,
 =?iso-8859-1?Q?Ma=EDra?= Canal <mairacanal@riseup.net>,
 Haneen Mohammed <hamohammed.sa@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rodrigo Siqueira <siqueira@igalia.com>
Cc: oe-kbuild-all@lists.linux.dev, dri-devel@lists.freedesktop.org,
 arthurgrillo@riseup.net, linux-kernel@vger.kernel.org,
 jeremie.dautheribes@bootlin.com, miquel.raynal@bootlin.com,
 thomas.petazzoni@bootlin.com, seanpaul@google.com,
 nicolejadeyee@google.com, Louis Chauvet <louis.chauvet@bootlin.com>
Subject: Re: [PATCH v4 8/8] drm/vkms: Add P01* formats
Message-ID: <202608132328.K0ZCjw8a-lkp@intel.com>
References: <20250530-b4-new-color-formats-v4-8-ef5f9f48376c@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250530-b4-new-color-formats-v4-8-ef5f9f48376c@bootlin.com>
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

Hi Louis,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 2271e0a20ef795838527815e057f5af206b69c87]

url:    https://github.com/intel-lab-lkp/linux/commits/Louis-Chauvet/drm-vkms-Create-helpers-macro-to-avoid-code-duplication-in-format-callbacks/20260813-163823
base:   2271e0a20ef795838527815e057f5af206b69c87
patch link:    https://lore.kernel.org/r/20250530-b4-new-color-formats-v4-8-ef5f9f48376c%40bootlin.com
patch subject: [PATCH v4 8/8] drm/vkms: Add P01* formats
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20260813/202608132328.K0ZCjw8a-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260813/202608132328.K0ZCjw8a-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608132328.K0ZCjw8a-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/vkms/vkms_formats.c:324: warning: Excess function parameter '__VA_ARGS__' description in 'READ_LINE'
>> drivers/gpu/drm/vkms/vkms_formats.c:335: warning: Function parameter or struct member 'a' not described in 'READ_LINE_ARGB8888'
>> drivers/gpu/drm/vkms/vkms_formats.c:335: warning: Function parameter or struct member 'r' not described in 'READ_LINE_ARGB8888'
>> drivers/gpu/drm/vkms/vkms_formats.c:335: warning: Function parameter or struct member 'g' not described in 'READ_LINE_ARGB8888'
>> drivers/gpu/drm/vkms/vkms_formats.c:335: warning: Function parameter or struct member 'b' not described in 'READ_LINE_ARGB8888'
>> drivers/gpu/drm/vkms/vkms_formats.c:345: warning: Function parameter or struct member 'a' not described in 'READ_LINE_le16161616'
>> drivers/gpu/drm/vkms/vkms_formats.c:345: warning: Function parameter or struct member 'r' not described in 'READ_LINE_le16161616'
>> drivers/gpu/drm/vkms/vkms_formats.c:345: warning: Function parameter or struct member 'g' not described in 'READ_LINE_le16161616'
>> drivers/gpu/drm/vkms/vkms_formats.c:345: warning: Function parameter or struct member 'b' not described in 'READ_LINE_le16161616'


vim +324 drivers/gpu/drm/vkms/vkms_formats.c

   294	
   295	/**
   296	 * READ_LINE() - Generic generator for a read_line function which can be used for format with one
   297	 * plane and a block_h == block_w == 1.
   298	 *
   299	 * @function_name: Function name to generate
   300	 * @pixel_name: Temporary pixel name used in the @__VA_ARGS__ parameters
   301	 * @pixel_type: Used to specify the type you want to cast the pixel pointer
   302	 * @callback: Callback to call for each pixels. This fonction should take @__VA_ARGS__ as parameter
   303	 *            and return a pixel_argb_u16
   304	 * @__VA_ARGS__: Argument to pass inside the callback. You can use @pixel_name to access current
   305	 *  pixel.
   306	 */
   307	#define READ_LINE(function_name, pixel_name, pixel_type, callback, ...)				\
   308	static void function_name(const struct vkms_plane_state *plane, int x_start,			\
   309				      int y_start, enum pixel_read_direction direction, int count,	\
   310				      struct pixel_argb_u16 out_pixel[])				\
   311	{												\
   312		struct pixel_argb_u16 *end = out_pixel + count;						\
   313		int step = get_block_step_bytes(plane->frame_info->fb, direction, 0);			\
   314		u8 *src_pixels;										\
   315													\
   316		packed_pixels_addr_1x1(plane->frame_info, x_start, y_start, 0, &src_pixels);		\
   317													\
   318		while (out_pixel < end) {								\
   319			pixel_type *(pixel_name) = (pixel_type *)src_pixels;				\
   320			*out_pixel = (callback)(__VA_ARGS__);						\
   321			out_pixel += 1;									\
   322			src_pixels += step;								\
   323		}											\
 > 324	}
   325	
   326	/**
   327	 * READ_LINE_ARGB8888() - Generic generator for ARGB8888 formats.
   328	 * The pixel type used is u8, so pixel_name[0]..pixel_name[n] are the n components of the pixel.
   329	 *
   330	 * @function_name: Function name to generate
   331	 * @pixel_name: temporary pixel to use in @a, @r, @g and @b parameters
   332	 * @a, @r, @g, @b: value of each channel
   333	 */
   334	#define READ_LINE_ARGB8888(function_name, pixel_name, a, r, g, b) \
 > 335		READ_LINE(function_name, pixel_name, u8, argb_u16_from_u8888, a, r, g, b)
   336	/**
   337	 * READ_LINE_le16161616() - Generic generator for ARGB16161616 formats.
   338	 * The pixel type used is u16, so pixel_name[0]..pixel_name[n] are the n components of the pixel.
   339	 *
   340	 * @function_name: Function name to generate
   341	 * @pixel_name: temporary pixel to use in @a, @r, @g and @b parameters
   342	 * @a, @r, @g, @b: value of each channel
   343	 */
   344	#define READ_LINE_le16161616(function_name, pixel_name, a, r, g, b) \
 > 345		READ_LINE(function_name, pixel_name, __le16, argb_u16_from_le16161616, a, r, g, b)
   346	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
