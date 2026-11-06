Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2C2606A32D
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 11:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QX/PbVke
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B955310E9E2;
	Fri,  6 Nov 2026 11:08:32 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA5A410E9E2
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 11:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793963307; x=1825499307;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=MYpRdIgz4VF5KaXErgd4feHkN9DzPg6BAG+Vr/5aYsA=;
 b=QX/PbVketNS3lFZfCm8t5qfPkDiFNK/WZNBA+IYpjP1hM2C+DAtPfIhP
 FMp+IDHuMsQpAGHL36D4ky4JVfBKfyRc1Ir5h5c7DIMfG2l8rDrnSWdy6
 aZtp0ynRP5svTnKMEO6/8Mm3lbUwy5bwTMCpZHA4pVlzEMr0ZYrZbv6i/
 VXaENZM5VdihR/OgGoqR/LmoX5WLQx0QYoJxRWiREd+WvfATpsUiJ+Rli
 Eo0uKES0bvPZqKk00ms6XChyTGHYd+MeZDrWIoOBdXtTeeU6dPPGZNUKK
 dPaI9Q68TfxgeIAlMUYJ2M1Puf6lKTITywocK43A16j+tc4MCEb3XgZX4 g==;
X-CSE-ConnectionGUID: xY+MJUm7RfCiNlR9aGEHng==
X-CSE-MsgGUID: ovOlgWEkTC2h9IDLkTJpag==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2775601"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2775601"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2026 03:08:27 -0800
X-CSE-ConnectionGUID: oD0vyB4QSDO3/qT7UX6MpQ==
X-CSE-MsgGUID: ZI27fi6ORt6NHSDT2fbVcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7677534"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost)
 ([10.245.245.101])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2026 03:08:22 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Dave Airlie <airlied@gmail.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Alex Deucher <alexdeucher@gmail.com>, Simona
 Vetter <simona@ffwll.ch>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>,
 Matthew Brost <matthew.brost@intel.com>, Thomas =?utf-8?Q?Hellstr=C3=B6m?=
 <thomas.hellstrom@linux.intel.com>, Alice Ryhl <aliceryhl@google.com>,
 Alex Deucher <alexander.deucher@amd.com>, Christian =?utf-8?Q?K=C3=B6nig?=
 <christian.koenig@amd.com>, dri-devel@lists.freedesktop.org, Mark Brown
 <broonie@kernel.org>, linux-next@vger.kernel.org
Subject: Re: [RFC] linux-next: replace the DRM trees with a single
 drm-for-linux-next
In-Reply-To: <DMNL1MG0A8P4.1VPON40R8BX2U@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <DMKY979I29AF.BS1DF5YAZMOY@kernel.org>
 <aujikV14tF6K1Xqw@intel.com> <DMKZR0YZV1CX.DWVK9V47GR1J@kernel.org>
 <CAPM=9tww=CJdxzvfUvLwQ6V4uoszg8JrB1XCAcp15upM-xPvSg@mail.gmail.com>
 <DMLTRKUXTL3P.11VRVU1A8ERMG@kernel.org> <aupFKGpAwAiGXN0U@intel.com>
 <DMLVPRO7XF7F.21199FO61MFRD@kernel.org>
 <CADnq5_N-6_T8EnihjoTSqpHGb_mZPogi6z=Ti-7_oue5d07oTw@mail.gmail.com>
 <aupktBCwcN_coHEH@intel.com> <DMLY7GDT8VBO.EE1P01ZX2HPK@kernel.org>
 <auqaZdocMvOIxN1c@intel.com>
 <CAPM=9tzu6MYQ-Y0iYK=2PLiM5=1BsEN+Q5WnmYh=hkKnLJ4b1Q@mail.gmail.com>
 <629d19bcd0f61974f3e1c94c90b4052216d2a967@intel.com>
 <DMNL1MG0A8P4.1VPON40R8BX2U@kernel.org>
Date: Fri, 06 Nov 2026 13:08:19 +0200
Message-ID: <3678ff00381a70148d6abafcf20ba3726bff2fc7@intel.com>
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
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 05 Nov 2026, "Danilo Krummrich" <dakr@kernel.org> wrote:
> On Thu Nov 5, 2026 at 2:44 PM CET, Jani Nikula wrote:
>> The main downside is the delay between merging in a driver tree and
>> hitting linux-next. But we could also decide to mandate more regular
>> pull request to drm-next, maybe weekly, especially for the drivers with
>> more traffic. This will mean lots more pull requests, but it's really
>> not a bad thing to keep them smaller.
>
> I was already concerned about losing up to a week's linux-next exposure with the
> proposed global cutoff at -rc5 [1]. This approach would extend that delay
> throughout the cycle.
>
> Even with weekly PRs, changes could wait up to a week before reaching
> linux-next. They would also only get that exposure after being merged into
> drm-next, whereas I'd like them to receive linux-next testing before that merge.

Fair enough.

> I don't think that such a compromise is acceptable: If a tree breaks linux-next
> it would mean that linux-next is broken until the next PR hits drm-next (and not
> only until it is fixed in the tree causing the issue).

Yeah, this part is really not great.

Throwing around ideas here, thanks for taking the time to debunk.

> I don't want to sound like a broken record (sorry if I already do :), but I
> still think the
>
> 	git merge-base --is-ancestor $remote/$linux_next_fixes $remote/$linux_fixes
>
> switch we already have in dim seems like the best fit. It already does exactly
> what we (and linux-next) need and is accurate: it preserves direct linux-next
> coverage and bases the selection on the actual tree state. And with the proposed
> git request-pull --final option it is very maintainer friendly.
>
> [1] https://lore.kernel.org/all/DMMS9R5JJ4ME.TBIB1TNLB3IP@kernel.org/

At a glance, I think the *feature* sounds good. But I think we're all
just going to forget to add --final.

The reason we have dim in the first place is to make us do stuff the
same way, every time, and not forget stuff. When we screwed up, we
addressed it in dim to not screw up again.

Not everything can be easily automated or enforced. Perhaps you've
noticed dim asks for confirmation when you're trying to push merges or
more than ten patches. Usually it's something committers shouldn't do,
but maintainers occasionally need to.

Anyway, how about just *prompting* "Is this expected to be the final
pull request for the development cycle?", and if yes, update
drm-*-next-fixes while at it, and have the automation handle the rest.

You should be able to do another final PR if something urgent comes up,
and it'll be just fine.

Also, if we are able to make dim more -rc cycle aware, the above could
also start asking the question at -rc3 or -rc4 or so.


BR,
Jani.


-- 
Jani Nikula, Intel
