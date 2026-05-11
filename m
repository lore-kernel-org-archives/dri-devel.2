Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0599ECD37B9
	for <dri-devel@archiver.kernel.org>; Mon, 11 May 2026 07:41:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A93010E0B4;
	Mon, 11 May 2026 07:41:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="VGCzEOEt";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D34CE10E0B4;
 Mon, 11 May 2026 07:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778485291; x=1810021291;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version:content-transfer-encoding;
 bh=zBwSDzpx7xxdzAFVKY6dfHL9FRIKu6BdJZx+3y0v5sQ=;
 b=VGCzEOEtu8HBJkE0kOIFjdooIKECJ54bFhTiBfZDF5U8zk4/uR9Yz9my
 ZD61yEz2UmL7K+nMmjSJFkdHiQG4QyyHhvwNZUhegr/XpcQzrtoU2y/wh
 lOEGpYwDjVxGH2ch02oytglDEQgrlOuq/d0ICsfZ2oVNteAujAKL5SUxd
 f06jA+plriS+345BjFCvmwEG4sjtQmBmoum+z4IExlQBZF0XcqkVfmf5N
 E7ns8OJ3st5dU2gwxBS+rJcLHWN2erC0ziqHaUEm4+yJkirK5f1IJLEem
 qOfEh2sLchU3zE+rbcUzDv605qGiZLHrfaP+eXFbIp+f10RuOXk80rqgX A==;
X-CSE-ConnectionGUID: u7FUKUxzT3ynVkJdsy8wXA==
X-CSE-MsgGUID: uulXsGChS6i0VrVwbDLGxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11782"; a="90741908"
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; d="scan'208";a="90741908"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 May 2026 00:41:14 -0700
X-CSE-ConnectionGUID: dtEGvvG2SWC5TM1ceTz6vQ==
X-CSE-MsgGUID: L9VBZbOPTPSQmmanZOoxkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; d="scan'208";a="237332137"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost)
 ([10.245.244.253])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 May 2026 00:41:10 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: Randy Dunlap <rdunlap@infradead.org>, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-doc@vger.kernel.org
Cc: rodrigo.vivi@intel.com, Matthew Brost <matthew.brost@intel.com>, Thomas
 =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 joonas.lahtinen@linux.intel.com, tursulin@ursulin.net
Subject: Re: [PATCH 1/3] Documentation/gpu: add dedicated documentation for
 Intel display
In-Reply-To: <4aba5b5e-75a5-4800-bedb-8f7cc673c7f7@infradead.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <cover.1778235406.git.jani.nikula@intel.com>
 <21bfa7777eb0926eadd309d4c6f5c9cf48405cf0.1778235406.git.jani.nikula@intel.com>
 <4aba5b5e-75a5-4800-bedb-8f7cc673c7f7@infradead.org>
Date: Mon, 11 May 2026 10:41:06 +0300
Message-ID: <6c6e0124df2b5f13661d3d8f4f1a9b7f1fcaca85@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

On Fri, 08 May 2026, Randy Dunlap <rdunlap@infradead.org> wrote:
> On 5/8/26 3:20 AM, Jani Nikula wrote:
>> diff --git a/Documentation/gpu/intel-display/index.rst b/Documentation/g=
pu/intel-display/index.rst
>> new file mode 100644
>> index 000000000000..8d40363b8f90
>> --- /dev/null
>> +++ b/Documentation/gpu/intel-display/index.rst
>> @@ -0,0 +1,40 @@
>> +.. SPDX-License-Identifier: MIT
>> +.. Copyright =C2=A9 2026 Intel Corporation
>> +
>> +.. _drm/intel-display:
>> +
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +Intel Display Driver
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +
>> +The Intel display driver provides the display, or :ref:`drm-kms`, suppo=
rt for
>> +both the :ref:`drm/xe <drm/xe>` and :ref:`drm/i915 <drm/i915>` Intel GPU
>> +drivers.
>> +
>> +The source code currently resides under ``drivers/gpu/drm/i915/display`=
` due to
>> +historical reasons, and it's compiled separately into both drm/xe and d=
rm/i915
>> +kernel modules.
>> +
>> +The drm/xe and drm/i915 drivers are the "core" or "parent" drivers for =
display,
>> +as they initialize and own the drm device, and pass that on to the disp=
lay
>> +driver. The display driver isn't an independent driver in that sense.
>> +
>> +.. toctree::
>> +   :maxdepth: 1
>> +   :caption: Detailed display topics
>> +
>> +   async-flip
>> +   audio
>> +   cdclk
>> +   dmc
>> +   dpio
>> +   dpll
>> +   drrs
>> +   dsb
>> +   fbc
>> +   fifo-underrun
>> +   frontbuffer
>> +   hotplug
>> +   plane
>> +   psr
>> +   vbt
>
> Is this in almost-alphabetical order or just random?  :)

The above list is alphabetical, but the generated output does seem to be
more random due to the headings. This is in need of better organization
anyway, and this is just a step in the right direction, so I'll roll
with this.

> Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks for the reviews and acks and testing, pushed to drm-intel-next.

BR,
Jani.


--=20
Jani Nikula, Intel
