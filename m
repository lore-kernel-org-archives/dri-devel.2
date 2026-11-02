Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9F66083E3D
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 17:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eX9qAhNe
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA76F10E6A7;
	Mon,  2 Nov 2026 17:16:47 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 461F110E69C;
 Mon,  2 Nov 2026 17:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793639802; x=1825175802;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version:content-transfer-encoding;
 bh=bQQ8b00p+aaACuVmXgY9QMprnW3EPNjaskpRbrQdCGE=;
 b=eX9qAhNekAfXIyvbe9GwWWNJx2afnfqhnncUDBp78azo1e5hy9So3JHC
 HUCxOeIV97XhRJY4R80hyBpfquTGn/AYw3exRUmwH1bR42yhcvpXePbyp
 EC9S2eZXEvDteFARbjmAO+DPW6DxRn7e6i/zcfvMjxvH9zetzI+44hMPI
 XD0oQD+2/SOD2S6yY4ldbxoed2fiWNXTAGBeA+X4p5tVlJDXONF9JcaTv
 2PNEGvNOHyYvZFVcdQMs/y63rRP4u+KkYXJHBYVx/DzS1xMM0yjG8sfZu
 XCweNbVZx2zg6CH5WiEIBLx1aF5aUGDkXyUyaaYRueJB0cE/LL5OUZE98 Q==;
X-CSE-ConnectionGUID: /uJQaNc1TVy4hywEIUpIGA==
X-CSE-MsgGUID: ea585ht0SJ64AKf+L0Me7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2353637"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2353637"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 09:16:41 -0800
X-CSE-ConnectionGUID: 4/0PXugHRneRQXEC0s2BLw==
X-CSE-MsgGUID: sa21N8FPT3il201HI4Ku7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6190883"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.222])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 09:16:39 -0800
From: Jani Nikula <jani.nikula@intel.com>
To: Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
Subject: Re: [PATCH 00/13] drm/dp, drm/i915: conversions from seq_file to
 drm_printer
In-Reply-To: <auh-qcn8xkDBX5sY@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <cover.1793361738.git.jani.nikula@intel.com>
 <auh-qcn8xkDBX5sY@intel.com>
Date: Mon, 02 Nov 2026 19:16:36 +0200
Message-ID: <68b1495bbfe5223644b71cd9f3a715ca65409f5b@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 02 Nov 2026, Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com=
> wrote:
> On Fri, Oct 30, 2026 at 02:03:03PM +0200, Jani Nikula wrote:
>> I've had this in a branch since at least April, seems useful.
>>=20
>> Jani Nikula (13):
>>   drm/dp: pass struct drm_printer to drm_dp_downstream_debug()
>>   drm/dp: prefer drm_printf_indent() over inline \t
>>   drm/i915/debugfs: pass struct drm_printer to intel_plane_info()
>>   drm/i915/debugfs: pass struct drm_printer to crtc_updates_info()
>>   drm/i915/debugfs: convert crtc_updates_info() to use
>>     drm_printf_indent()
>>   drm/i915/debugfs: pass struct drm_printer to intel_scaler_info()
>>   drm/i915/debugfs: pass struct drm_printer to intel_encoder_info()
>>   drm/i915/debugfs: pass struct drm_printer to intel_crtc_info()
>>   drm/i915/debugfs: pass struct drm_printer to
>>     intel_{dp,dp_mst,hdmi}_crtc_info()
>>   drm/i915/debugfs: pass struct drm_printer to intel_hdcp_info()
>>   drm/i915/debugfs: refactor intel_seq_print_mode() into
>>     intel_print_mode()
>>   drm/i915/debugfs: pass struct drm_printer to intel_connector_info()
>>   drm/i915/debugfs: prefer drm_printf_indent() over inline \t
>
> Looked fine with --color-words
>
> Series is
> Reviewed-by: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>

Thanks, pushed to din.

BR,
Jani.

>
>>=20
>>  drivers/gpu/drm/display/drm_dp_helper.c       |  39 ++-
>>  .../drm/i915/display/intel_display_debugfs.c  | 250 +++++++++---------
>>  drivers/gpu/drm/i915/display/intel_hdcp.c     |  27 +-
>>  drivers/gpu/drm/i915/display/intel_hdcp.h     |   4 +-
>>  include/drm/display/drm_dp_helper.h           |   3 +-
>>  5 files changed, 160 insertions(+), 163 deletions(-)
>>=20
>>=20
>> base-commit: 29f9258a2788a1066c0910c480e65c80887f4d20
>> --=20
>> 2.47.3

--=20
Jani Nikula, Intel
