Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C34E5FA0C40
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 07:23:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F36A410E68B;
	Wed, 15 Apr 2026 07:23:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="UZQbDu9L";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92BD610E114;
 Wed, 15 Apr 2026 07:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776237831; x=1807773831;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version:content-transfer-encoding;
 bh=QrgbCxApSEol6h6uuMByjLZFXrjDkvR0m8wJ21iO5ek=;
 b=UZQbDu9Lp+Nku6rC69LwvtF+AWesBoTze/Q4mVEf3RT8vwxlsvJOJff5
 FqHWlg8Lg4obIhDbvjX4gVapLQYnNqwLf21KszDmG3vlhCDX0t7FgwPYU
 OZIUcG36RfY3ZG0mGvg2jqSqzmxPAn1/0dwAyCoJxW/I3XDmh0007wId8
 zHFdeOA0d8ZANFsGi7daRtzGoj0qoFZsb4Dzn+B2mR6MnSJu8USdvL9g0
 Fpf+dB5G51djpxOJ5V1jR9YCvjKKApOcV6W2HzNLTLPb/U9Htr/AJauKL
 AxXqr1hq9TiJxzKuPviubdyopvaRymV2Bmxj83YngOEW2jVUHheG01pjz g==;
X-CSE-ConnectionGUID: XkYGZ4xORTSsNodn5vfB6g==
X-CSE-MsgGUID: d/qvEnb/RdSYeO3Ier6q2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="102663352"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; d="scan'208";a="102663352"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2026 00:23:49 -0700
X-CSE-ConnectionGUID: vLXmUoFDS/aIVQtbbofYLg==
X-CSE-MsgGUID: Lv+zPawqSm+DvFb5bZXMFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; d="scan'208";a="232083346"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.246.25])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2026 00:23:41 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Leo Li <sunpeng.li@amd.com>, Melissa Wen <mwen@igalia.com>, Timur
 =?utf-8?Q?Krist=C3=B3f?= <timur.kristof@gmail.com>, airlied@gmail.com,
 alexander.deucher@amd.com, alex.hung@amd.com, andrzej.hajda@intel.com,
 christian.koenig@amd.com, harry.wentland@amd.com,
 jernej.skrabec@gmail.com, jonas@kwiboo.se,
 Laurent.pinchart@ideasonboard.com, maarten.lankhorst@linux.intel.com,
 mario.limonciello@amd.com, mripard@kernel.org, neil.armstrong@linaro.org,
 rfoss@kernel.org, simona@ffwll.ch, siqueira@igalia.com, tzimmermann@suse.de
Cc: Michel Daenzer <michel.daenzer@mailbox.org>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 kernel-dev@igalia.com
Subject: Re: [PATCH v8 0/8] drm/amd/display: more drm_edid to AMD display
 driver (partial)
In-Reply-To: <67d07c60-a535-42c7-a6fe-79f9dd90c9b4@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260225121903.236115-1-mwen@igalia.com>
 <3856874.aCxCBeP46V@timur-hyperion>
 <3d928ea8-dee9-40cc-9fcc-af063b67138a@amd.com>
 <be7debbf-727e-4017-906a-36ee81fd844e@igalia.com>
 <67d07c60-a535-42c7-a6fe-79f9dd90c9b4@amd.com>
Date: Wed, 15 Apr 2026 10:23:38 +0300
Message-ID: <e9588bc344ccea0052a791e7f9574184cab804b3@intel.com>
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

On Tue, 14 Apr 2026, Leo Li <sunpeng.li@amd.com> wrote:
> On 2026-04-13 13:51, Melissa Wen wrote:
>>=20
>>=20
>> On 31/03/2026 12:45, Leo Li wrote:
>>>
>>> On 2026-02-27 03:52, Timur Krist=C3=B3f wrote:
>>>> On Wednesday, February 25, 2026 1:04:29=E2=80=AFPM Central European St=
andard Time
>>>> Melissa Wen wrote:
>>>>> Hi,
>>>>>
>>>>> This is a reduced version of `drm/amd/display: more drm_edid to AMD
>>>>> display driver` [1] sent a few months ago only with the less invasive
>>>>> changes, i.e., those changes that don't affect DC. This partial focus=
 on
>>>>> using more drm_edid helpers instead of raw EDID helpers. Most patches
>>>>> here are already reviewed by someone and I think they can be merged
>>>>> without major concerns. They can also prevent new initiatives of keep=
ing
>>>>> parsing raw EDID as driver specific code, which can make harder for us
>>>>> to remove `drm_edid_raw()`. They should focus on moving raw EDID
>>>>> handling to the DRM common code instead.
>>>>>
>>>>> Regarding code changes from previous version, here I added some r-b t=
ags
>>>>> (from Mario and Timur), fixed commit message syntax (Mario) and
>>>>> centralized error handling (Timur). I'll follow up the changes in DC =
to
>>>>> accept the Linux/DRM opaque object in a separate series since those l=
ook
>>>>> more sensitive.
>>>>>
>>>>> [1] https://lore.kernel.org/amd-gfx/20251106165536.161662-1-mwen@igal=
ia.com/
>>>>>
>>>>> BR,
>>>>>
>>>>> Melissa
>>>>>
>>>> Nice work, Melissa.
>>>>
>>>> Reviewed-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
>>>> For this series.
>>> Thanks for your patience Melissa, series is also
>>> Reviewed-by: Leo Li <sunpeng.li@amd.com>
>>>
>>> We'll include it in this week's testing.
>>=20
>> Hi Leo,
>>=20
>> In the end, was this series applied to AMD's branch or do I need to reba=
se it?
>>=20
>> Melissa
>
> Hi Melissa,
>
> During testing, it seems we're failing drm_edid_valid() in this callpath:
>
>     dm_helpers_read_local_edid > dm_helpers_parse_edid_caps > drm_edid_va=
lid.
>
> I'm 90% sure it's because recreating the drm_edid from dc_edid ignores the
> HF-EEODB (HDMI Forum EDID Extension Override Data Block), which can overr=
ide the
> number of extensions dictated by the base EDID. However, drm_edid_valid()=
 does
> consider the HF-EEODB, causing this line(*) to return false. Commenting i=
t out
> "fixes" the issue
>
> (*)https://elixir.bootlin.com/linux/v7.0/source/drivers/gpu/drm/drm_edid.=
c#L2076
>
> This whole drm_edid to dc_edid conversion in dm_helpers_read_local_edid()=
, then
> immediately back to drm_edid in parse_edid_caps(), is really not nice... =
We lose
> the HF-EEODB-aware size by creating dc_edid based on the EDID-advertised
> extension count. It should work if drm_edid is simply passed straight thr=
ough.
>
> The challenge is dm_helpers* are DC's interface back to DM, and there is =
another
> OS that depends on it. Plumbing drm_edid through DC would be quite challe=
nging.

I find this to be in stark contrast with stable-api-nonsense.rst [1].
Why do we have internal kernel code that we can't change based on the
*outside* needs even if it makes total sense from the kernel POV? Nobody
outside of AMD has any idea of the constraints or how they apply.

[1] https://docs.kernel.org/process/stable-api-nonsense.html

> Alternatively, It should work if we carry over the drm_edid.size value to
> dc_edid.length. Do you know the motivation behind keeping drm_edid->size
> private? Would it be a good idea to implement a drm_edid_get_size()?

struct drm_edid is opaque specifically to prevent drivers from trying to
parse EDID directly or trying to calculate the EDID size. I did this to
enforce centralized handling of HF-EEODB. With the old struct edid,
there used to be huge amounts of code computing EDID size, and you
couldn't be sure if whoever allocated it was aware of HF-EEODB or
not. struct drm_edid dissociates the EDID from the allocated buffer
size.

And, really, all EDID parsing should happen in drm_edid.c the same way
for all drivers, and making struct drm_edid opaque is pretty much the
only way to block quick hacks from proliferating.

BR,
Jani.

--=20
Jani Nikula, Intel
