Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15E0AC61DCB
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 12:20:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0C8310E4E1;
	Fri, 28 Aug 2026 12:20:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=freenet.de header.i=@freenet.de header.b="iZSutd/T";
	dkim-atps=neutral
X-Greylist: delayed 318 seconds by postgrey-1.36 at gabe;
 Fri, 28 Aug 2026 12:20:20 UTC
Received: from mout.freenet.de (mout.freenet.de [194.97.204.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DCFF10E3FA;
 Fri, 28 Aug 2026 12:20:20 +0000 (UTC)
Received: from [2001:748:400:2319::3] (helo=sub2.mail.fnrz.de)
 by mout5.mail.fnrz.de with esmtpa (ID viktor.jaegerskuepper@freenet.de) (port
 25) (Exim 4.98.2 #2) id 1wzvTs-00000008RKJ-2bwl;
 Fri, 28 Aug 2026 14:14:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=freenet.de; 
 s=mjaymdexmjqk;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID;
 bh=W3jS18jhU+PbPJF3OtPf1V1jSHY7+JgKo9ahDNrABJQ=; b=iZSutd/TDl13uYe5llZlM1e/CE
 nTJ8n2goknxpff3lWQwUJ+fqt+sQzmauMwEBmzsJCgSiy0CpXMTQvSMY9eF33zv/lbgLRX4r9opUJ
 feMR9z7sdpwrntQ/KWPowUZm6s3p7oavkIiwnFD063I5YH3SPcsk9ZUFjYJghJFBVwk6oES8vN6T6
 8c8z18mUWBU4jLcKSnbQOTKX0+RhGF8XwhMRETgz/nPmsJpJ0TZQTEkcZcMLG2q1qfd5ysZCROq6l
 49caeFpOb8Qct6sx+saff4HQrSYxGinT+NWsbhFZCUbPjeNyU7+dzj7Y4pQ8arkpiKpKE1YViYa0f
 OOwdGneA==;
Authentication-Results: freenet.de;
 iprev=pass (p200300f9df039f3750a2f981e028cbfd.dip0.t-ipconnect.de)
 smtp.remote-ip=2003:f9:df03:9f37:50a2:f981:e028:cbfd; 
 auth=pass (PLAIN) smtp.auth=viktor.jaegerskuepper@freenet.de
Received: from p200300f9df039f3750a2f981e028cbfd.dip0.t-ipconnect.de
 ([2003:f9:df03:9f37:50a2:f981:e028:cbfd]:36680 helo=[127.0.0.1])
 by sub2.mail.fnrz.de with esmtpsa (ID viktor.jaegerskuepper@freenet.de)
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (port 465) (Exim
 4.98.2 #2) id 1wzvTs-00000003sEQ-1nN9;
 Fri, 28 Aug 2026 14:14:48 +0200
Message-ID: <572f78a8-1b09-4275-bca7-0ae8703776d0@freenet.de>
Date: Fri, 28 Aug 2026 14:19:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] drm/atomic-state-helper: fixes for blend-mode-prop
 warning
Content-Language: en-US
To: Thorsten Leemhuis <regressions@leemhuis.info>,
 Melissa Wen <mwen@igalia.com>, Alex Deucher <alexdeucher@gmail.com>
Cc: airlied@gmail.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 daniels@collabora.com, harry.wentland@amd.com,
 leandro.ribeiro@collabora.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, pekka.paalanen@collabora.com, simona@ffwll.ch,
 siqueira@igalia.com, sunpeng.li@amd.com, tzimmermann@suse.de,
 Alex Hung <alex.hung@amd.com>, Daniel Wheeler <Daniel.Wheeler@amd.com>,
 kernel-dev@igalia.com, Lyude Paul <lyude@redhat.com>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 Xaver Hugl <xaver.hugl@gmail.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Greg KH <gregkh@linuxfoundation.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 =?UTF-8?B?VmlrdG9yIErDpGdlcnNrw7xwcGVy?= <viktor_jaegerskuepper@freenet.de>
References: <20260826104143.39077-1-mwen@igalia.com>
 <CADnq5_MEBLriK_M_atX6FKR5618fiB5DmAWOvxE_e+6nd5FdDg@mail.gmail.com>
 <83bef197-dfbc-44a5-b9d8-6e0c44488793@igalia.com>
 <6dda204d-2c12-4442-9893-6449b5ce51c9@igalia.com>
 <9d5fa2bf-d9e4-4c6a-a9ca-8abf14ad894e@leemhuis.info>
From: =?UTF-8?B?VmlrdG9yIErDpGdlcnNrw7xwcGVy?=
 <viktor_jaegerskuepper@freenet.de>
In-Reply-To: <9d5fa2bf-d9e4-4c6a-a9ca-8abf14ad894e@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-FN-MUUID: 1787919288BFDEC7C3E20FO
X-Scan-TS: Fri, 28 Aug 2026 14:14:48 +0200
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

On 8/28/26 09:22, Thorsten Leemhuis wrote:
> On 8/27/26 19:14, Melissa Wen wrote:
>> On 27/08/2026 18:37, Melissa Wen wrote:
>>> On 27/08/2026 15:34, Alex Deucher wrote:
>>>> On Wed, Aug 26, 2026 at 7:20 AM Melissa Wen <mwen@igalia.com> wrote:
>>>>> PREMULTI was the default DRM blend mode until 9813e158d13d
>>>>> ("drm/drm_blend: allow blend mode property without PREMULTI")
>>>>> introduced
>>>>> the possibility of exposing the blend mode property without PREMULTI
>>>>> being supported. However, __drm_atomic_helper_plane_state_init() still
>>>>> resets pixel_blend_mode to PREMULTI (hardcoded), ignoring the supported
>>>>> mode in this property. In the same series, 860e748bddcc ("drm: ensure
>>>>> blend mode supported if pixel format with alpha exposed") starts
>>>>> warning
>>>>> drivers that supports alpha formats in a given planes but doesn't
>>>>> support blend mode property, which includes AMD primary and cursor
>>>>> planes.
>> [...]
>>>> I presume you are planning to apply this directly to drm-misc for 7.3?
>>>
>>> Right, I'll apply to drm-misc-fixes, just doing it now.
>>
>> Or not now. I have to wait for -rc1.
>> I'll keep it on my radar.
> Hmmm, that sounds like these fixes will miss -rc1. But wouldn't it be
> good to get them included there, as they afaik (please correct me if I'm
> wrong, is easy to mix something up from the outside!) the warnings that
> Greg described as ""It's not good to boot and have a bunch of warnings
> already happening, resulting in a "tainted" kernel before I have the
> chance to break anything manually myself...""[1], as more people then
> will likely encounter this (and then waste time on bisecting an issue
> known for weeks for which a fix exists).
> 
> Ciao, Thorsten
> 
> [1]
> https://lore.kernel.org/all/2026082651-spinning-cornbread-33ba@gregkh/

If I understand correctly, the *actual* fix (for all affected drivers)
will make it into 7.3-rc1, see this answer to my question:
https://lore.kernel.org/dri-devel/20260826-brave-nyala-of-elevation-d23aea@houat/

This fix is queued in drm-next:
https://gitlab.freedesktop.org/drm/kernel/-/commit/271e90eb5f9ff34951647e5ed33c1775eebcca50

It seems the drm-next branch is used for fixes arriving during the
merge window, which might be confusing for outsiders.

I hope that clears up the confusion.

Viktor
