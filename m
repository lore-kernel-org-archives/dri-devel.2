Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DE3606A687
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 15:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WWue3Yvh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A894112BC8;
	Fri, 27 Nov 2026 15:55:31 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34BAC10E5D0;
 Fri, 27 Nov 2026 15:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795794926; x=1827330926;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version:content-transfer-encoding;
 bh=x/nBAYYlqHg1Y+E5T3yXCdXotBzPEciD8XHisBmdYLI=;
 b=WWue3YvhelBkZziYCT/APjwHS9g/UrEeBPjwu5i2CSegj3gcBm+6ysUO
 Yt6AkayywzH/AMY26y4oxhMJIic//7tiJuR4ltwYzyyOtiE2kaBmevYIT
 BPdMToFCyL6nk2C141wrUGou38hkMezm+C4oPitKvmpHNpgKqjIdy7mQb
 kAbbbp4pITBCRoyAPaGScvggaWQpGCoOuszXAeSVZTx0TYs3Y2W3ZTNDu
 TnDdClf7PRutB6ZkHdtYLmtMKXfc88hyVReiXqW8go6IO9MlfjLsCHYFE
 Dca94zSnPtz7jNP0Trjy6f5GDYStAqL21P8Cy2cthsN0XNGztl6F4YnoL w==;
X-CSE-ConnectionGUID: xGoaqEFsRA6mfwJ97WgzgQ==
X-CSE-MsgGUID: ifyZnpmdTninQLvgMHi1uQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11979"; a="4601905"
X-IronPort-AV: E=Sophos;i="6.27,237,1787036400"; 
   d="scan'208";a="4601905"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2026 07:55:25 -0800
X-CSE-ConnectionGUID: 1irKUW0fSEe2yHzlQ5NAcg==
X-CSE-MsgGUID: LDvnlgoYT1KijHedTyR+hA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,237,1787036400"; d="scan'208";a="12416015"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.90])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2026 07:55:23 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
 sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
Subject: Re: [PATCH 1/2] drm/edid: Introduce
 drm_edid_get_displayid_product_id()
In-Reply-To: <awYXhjvZvrw3gWea@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20261124224621.6506-1-ville.syrjala@linux.intel.com>
 <20261124224621.6506-2-ville.syrjala@linux.intel.com>
 <sashiko-outbox-232161@kernel.org> <awYXhjvZvrw3gWea@intel.com>
Date: Fri, 27 Nov 2026 17:55:20 +0200
Message-ID: <b7f3b3e4a8eb866368cedf88c383bf14834077fc@intel.com>
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 25 Nov 2026, Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com=
> wrote:
> On Tue, Nov 24, 2026 at 10:51:24PM +0000, sashiko-bot@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 1 potential
>> issue to consider:
>> - [Low] drm/edid: commit subject mismatches
>>   drm_displayid_get_product_id()
>> --
>>=20
>> commit 4452aea3cbb2a5afd7ef8a119931282a44feb4c3
>> Author: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
>>=20
>> drm/edid: Introduce drm_edid_get_displayid_product_id()
>>=20
>> This commit adds drm_displayid_get_product_id() to extract vendor and
>> product identification from a DisplayID Product ID block.
>>=20
>> > diff --git a/include/drm/drm_edid.h b/include/drm/drm_edid.h
>> > index a2617aa34edfc..b44c26d422171 100644
>> > --- a/include/drm/drm_edid.h
>> > +++ b/include/drm/drm_edid.h
>>=20
>> [ ... ]
>>=20
>> > @@ -484,6 +492,8 @@ int drm_edid_connector_add_modes(struct drm_connec=
tor *connector);
>> >  bool drm_edid_is_digital(const struct drm_edid *drm_edid);
>> >  void drm_edid_get_product_id(const struct drm_edid *drm_edid,
>> >  			     struct drm_edid_product_id *id);
>> > +void drm_displayid_get_product_id(const struct drm_edid *drm_edid,
>> > +				  struct drm_displayid_product_id *id);
>>=20
>> [Severity: Low]
>> The commit subject names this function drm_edid_get_displayid_product_id=
(),
>> while the commit message body and code define drm_displayid_get_product_=
id().
>> Also, this declaration is placed in the "Interface based on struct drm_e=
did"
>> section of include/drm/drm_edid.h, where all other functions taking a
>> const struct drm_edid * use the drm_edid_ prefix.  Should the commit sub=
ject
>> and exported function name be aligned?
>
> I was going back and forth with the name and being dissatisfied
> with all of them. If anyone has an opinion how we should name
> these things I'm all ears.

Not really sure either.

Maybe I'm ever so slightly leaning towards drm_edid_ prefixed naming,
and only because in my mind we'll be able to use struct drm_edid as the
abstract type for all these cases:

- plain old EDID with no DisplayID blocks
- EDID with DisplayID blocks in EDID extensions
- native DisplayID only
- combined native DisplayID *and* EDID with/without DisplayID blocks

I.e. it's "struct drm_edid" even when it's native DisplayID inside,
i.e. just use drm_edid naming for it all.

In that context, drm_edid_get_displayid_product_id() makes sense. Get
the displayid product id from this opaque blob.

Digressing a bit, native DisplayID will still be a PITA to implement,
but I'm hoping mostly due to the userland ABI promises and having to
break the VESA spec about reading *both* EDID and native DisplayID DDC
addresses, even if native DisplayID is there. But I think the opaque
struct drm_edid and the hidden-from-drivers drm_displayid abstractions
can handle it.


BR,
Jani.


--=20
Jani Nikula, Intel
