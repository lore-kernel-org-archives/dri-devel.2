Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F81FFF6E88
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 08:32:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6CB510E756;
	Wed, 18 Mar 2026 08:32:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="QZ505TAX";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEACB10E752;
 Wed, 18 Mar 2026 08:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773822747; x=1805358747;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version:content-transfer-encoding;
 bh=J2qiH7yqvvTWnbSHiNC614ud0jSRe4pK95575XBxqAg=;
 b=QZ505TAX5MyjOA5ZV6xrgjNQEuMVZAkLShv1Ir60PTKD8X6YSoSxlNnV
 0hcZrOdm0PZK1RDLlf0BM5o/9N1q6u12cjDVntYC3RVln/dxBLn8LxUF6
 cvN5Q3NTiOqsdRwYVamOzMWzFAUAj1tIC8eKksYg6DaGXUTjHBDyFQ0I9
 l9ilaAH3+jBRYKKgAHaIxjmBaJuqkYv8snW74SBXfbU5xFOEfPppeIbnQ
 oLxRYTAjloqp3XQJGAMcxhPeI1Yo9vaYWGbeZY/R/J5DBX0NfZF5rGFEY
 jeJaErXXYgLOLsfm1iIxh7kYNlefCznVrMjR0GnM5eLSB8YPsGDVPkxaC Q==;
X-CSE-ConnectionGUID: qxnb0rylToO5CnENmYm27A==
X-CSE-MsgGUID: jbA6rqZfTQaBYH/Ywe9kLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="74570294"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; d="scan'208";a="74570294"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2026 01:32:26 -0700
X-CSE-ConnectionGUID: ZZxHlhQjTdWLSegJQytkkw==
X-CSE-MsgGUID: 99UwL+v5TK2LtwdQRh3htw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; d="scan'208";a="218604251"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost)
 ([10.245.246.79])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2026 01:32:17 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Gui-Dong Han <hanguidong02@gmail.com>
Cc: gregkh@linuxfoundation.org, dakr@kernel.org, rafael@kernel.org,
 rodrigo.vivi@intel.com, joonas.lahtinen@linux.intel.com,
 tursulin@ursulin.net, airlied@gmail.com, simona@ffwll.ch,
 gustavo.sousa@intel.com, demarchi@kernel.org, jouni.hogander@intel.com,
 luciano.coelho@intel.com, linux-kernel@vger.kernel.org,
 driver-core@lists.linux.dev, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-sound@vger.kernel.org, akaieurus@gmail.com, me@ziyao.cc
Subject: Re: [PATCH 4/4] drm/i915/display: initialize string params to empty
 strings
In-Reply-To: <CALbr=LadoX8g--rtU==HQfNQ9f1=KP=7AS-PGfooKaSbnYPz+Q@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260317185920.43387-1-hanguidong02@gmail.com>
 <20260317191538.43535-1-hanguidong02@gmail.com>
 <c14b399c9c6bf96f8c7d33615561b0d787ff175b@intel.com>
 <CALbr=LadoX8g--rtU==HQfNQ9f1=KP=7AS-PGfooKaSbnYPz+Q@mail.gmail.com>
Date: Wed, 18 Mar 2026 10:32:14 +0200
Message-ID: <8ac4b6ef2dfbc1dce0047dee55f2df609287a3ec@intel.com>
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

On Wed, 18 Mar 2026, Gui-Dong Han <hanguidong02@gmail.com> wrote:
> On Wed, Mar 18, 2026 at 4:12=E2=80=AFAM Jani Nikula <jani.nikula@linux.in=
tel.com> wrote:
>>
>> On Wed, 18 Mar 2026, Gui-Dong Han <hanguidong02@gmail.com> wrote:
>> > Passing NULL to debugfs_create_str() causes a NULL pointer dereference
>> > upon reading, and is no longer permitted. Change the default values of
>> > dmc_firmware_path and vbt_firmware to empty strings ("").
>> >
>> > Existing code that consumes these parameters already verifies both
>> > pointer validity and string length, so empty strings are handled
>> > correctly. Furthermore, heap allocation is not required here: these
>> > debugfs parameters are created with strictly read-only permissions
>> > (0400). As a result, the debugfs write operation is never invoked,
>> > meaning the static empty string will not be erroneously freed by
>> > kfree().
>> >
>> > Fixes: e9913f0bd2e1 ("drm/i915/display: move dmc_firmware_path to disp=
lay params")
>> > Fixes: 29292bc6cc37 ("drm/i915/display: Move vbt_firmware module param=
eter under display")
>> > Signed-off-by: Gui-Dong Han <hanguidong02@gmail.com>
>> > ---
>> >  drivers/gpu/drm/i915/display/intel_display_params.h | 4 ++--
>> >  1 file changed, 2 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/drivers/gpu/drm/i915/display/intel_display_params.h b/dri=
vers/gpu/drm/i915/display/intel_display_params.h
>> > index b95ecf728daa..0a8cad98d480 100644
>> > --- a/drivers/gpu/drm/i915/display/intel_display_params.h
>> > +++ b/drivers/gpu/drm/i915/display/intel_display_params.h
>> > @@ -23,8 +23,8 @@ struct drm_printer;
>> >   *       debugfs file
>> >   */
>> >  #define INTEL_DISPLAY_PARAMS_FOR_EACH(param) \
>> > -     param(char *, dmc_firmware_path, NULL, 0400) \
>> > -     param(char *, vbt_firmware, NULL, 0400) \
>> > +     param(char *, dmc_firmware_path, "", 0400) \
>> > +     param(char *, vbt_firmware, "", 0400) \
>>
>> Admittedly this is all very convoluted, but these NULL pointers (or
>> pointers to them) are never passed to debugfs_create_str().
>
> Hi Jani,
>
> Thanks for your review.
>
> Could you elaborate on why they are never passed? Looking at
> intel_display_debugfs_params.c, the intel_display_debugfs_params()
> function iterates over INTEL_DISPLAY_PARAMS_FOR_EACH using the
> REGISTER macro. This eventually calls
> _intel_display_param_create_file(), which uses _Generic to dispatch
> char ** types to debugfs_create_str().

In _intel_display_param_create_file(), valp is &display->params.x, where
x is dmc_firmware_path or vbt_firmware.

display->params gets initialized using intel_display_params_copy() when
struct intel_display is allocated in intel_display_device_probe(). In
intel_display_params_copy(), _param_dup_charp() handles the NULL
initializer.

Granted, if the kstrdup() fails, you could end up having NULL there, but
at that point it's fine if your debugfs_create_str() change barfs and
bails out.

Like I said, it's convoluted. ;)

BR,
Jani.



--=20
Jani Nikula, Intel
