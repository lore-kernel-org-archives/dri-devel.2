Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA61606A319
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 11:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RimjHblp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AE3610E3E1;
	Thu, 22 Oct 2026 11:34:16 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A563E10E3E1
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 11:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792668849; x=1824204849;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=qNlFDcEQenP85zNi1o7zqNU9K1Z6Ek4cKmafavrAjfA=;
 b=RimjHblpPZSJk0DusBTBBv6SM6xdNn3F2by+Fk6NxUOgz+QWoTHSFc6O
 GcabKGz3k42GznBsyiTiCsSbidV+01LIU6BE0kZIDxxB9ane5dvPeLxM7
 QE8grBI+hzFgIHxWRq33+sOEznp2udSGs5EXjkgICzA6krENA3XNrZvxn
 WsT65i599r9Xz+sGVABfSCQpGhDxVtd21na0AwFJgXDbJTSeKy90CUayE
 7N+EF+T87HLp47STI6WSItaoq1y6RgZyJYwdYIhwgufJyQ7eybMNqRAHQ
 OSrG/yCh/f5jSAg1T6a3rx6jsU6RwNufDoLTVL/8j/u2ZBH18YlRGSyu+ w==;
X-CSE-ConnectionGUID: FVCRaKDXTQmYeXtWvvCGBg==
X-CSE-MsgGUID: PhPKSqdWSvWL5RqZCQaarw==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1517391"
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="1517391"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Oct 2026 04:11:42 -0700
X-CSE-ConnectionGUID: Zq9IXJ3HSSCCWvo4b2f83g==
X-CSE-MsgGUID: gLECOAQiQdGQ+Fy6+680gA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="3698061"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost)
 ([10.245.244.5])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Oct 2026 04:11:40 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: Avi Weiss <thnkslprpt@gmail.com>
Cc: Inki Dae <inki.dae@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 dri-devel@lists.freedesktop.org, linux-samsung-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/exynos: hdmi: free EDID on connector update failure
In-Reply-To: <CAKOB7-Y0GTen0gYm-m4ixg8RjHuqEHsNgRTM4s3SbLg5J=vM3Q@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20261012064334.3193085-1-thnkslprpt@gmail.com>
 <e22eadd0ada0c8243cfdf7829580984fdf897498@intel.com>
 <CAKOB7-Y0GTen0gYm-m4ixg8RjHuqEHsNgRTM4s3SbLg5J=vM3Q@mail.gmail.com>
Date: Thu, 22 Oct 2026 14:11:35 +0300
Message-ID: <0b3c43bb7dddd657e4eb3ba79bb4a75c86313625@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

On Tue, 20 Oct 2026, Avi Weiss <thnkslprpt@gmail.com> wrote:
> Hi Jani,
> This complicates the if (!drm_edid) a bit further down, so might not
> be worth it.
> What do you think? Leave it, or should I try to rework it?

Mmmh. Right, very few places actually check for
drm_edid_connector_update() return value, or do anything about it.


> Cheers,
> Avi
>
>
> On Mon, 19 Oct 2026 at 16:38, Jani Nikula <jani.nikula@intel.com> wrote:
>>
>> On Mon, 12 Oct 2026, Avi Weiss <thnkslprpt@gmail.com> wrote:
>> > If drm_edid_connector_update() fails, hdmi_get_modes() returns
>> > without freeing the EDID allocated by drm_edid_read_ddc(). It's
>> > an unlikely error path but nevertheless possible and should be
>> > cleaned up fully.
>> >
>> > Free the EDID before returning, while keeping the existing return
>> > value of 0.
>> >
>> > Fixes: f6e4f57fd90dc ("drm/exynos: hdmi: convert to struct drm_edid")
>> > Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
>> > ---
>> >  drivers/gpu/drm/exynos/exynos_hdmi.c | 4 +++-
>> >  1 file changed, 3 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/drivers/gpu/drm/exynos/exynos_hdmi.c b/drivers/gpu/drm/exynos/exynos_hdmi.c
>> > index d4fce39c2b61..386557a7f5e8 100644
>> > --- a/drivers/gpu/drm/exynos/exynos_hdmi.c
>> > +++ b/drivers/gpu/drm/exynos/exynos_hdmi.c
>> > @@ -893,8 +893,10 @@ static int hdmi_get_modes(struct drm_connector *connector)
>> >       drm_edid = drm_edid_read_ddc(connector, hdata->ddc_adpt);
>> >
>> >       ret = drm_edid_connector_update(connector, drm_edid);
>>
>> You could just move the drm_edid_free() call here to avoid duplicating
>> it.
>>
>> > -     if (ret)
>> > +     if (ret) {
>> > +             drm_edid_free(drm_edid);
>> >               return 0;
>> > +     }
>> >
>> >       cec_notifier_set_phys_addr(hdata->notifier, info->source_physical_address);
>> >
>> >
>> > base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
>>
>> --
>> Jani Nikula, Intel

-- 
Jani Nikula, Intel
