Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BD9DC624D3
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 18:59:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A491910E43A;
	Wed,  2 Sep 2026 18:59:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="rilCVEd6";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EE8B10E43A;
 Wed,  2 Sep 2026 18:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=ijFdRv7k9P9GZDfrgCL5+rI4nlJpeZphc+H/ghPffHU=; b=rilCVEd6zRk+htwDFT4efTcynV
 8D4o9TDWuOYiEYOOry0juLByWs0i39jkDH3dTziLxyYq2keuICS2smUvhx0FoljGn1giwhEi5RyFp
 ertoFOkOoBXEMqJ15YSgWR4x+67IAWCWkGylHyWD3Oe1ev++nTDyA4njSoHSgLMf+olMwIHZSvVfd
 UuMtXFKsaFI8P7xeRvjW4wlqYayeQHH6IORGrRllSU7NiQs44pbn5IETlspJCa3TcM2qXddTEiYob
 wkCLXi1iWh6/M8ka4Ab4WgocQgTUUqzgYNcNqZ43M6XBszx8lU+lvML93uyJOMLJlJVyrcF/vvkCb
 xZuaTOoA==;
Received: from [31.4.135.192] (helo=[192.168.1.126])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1x1qAS-00DzCf-6E; Wed, 02 Sep 2026 20:58:40 +0200
Message-ID: <cba8b58c-4869-494e-9b1c-84483ff8e701@igalia.com>
Date: Wed, 2 Sep 2026 20:58:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] drm/atomic-state-helper: fixes for blend-mode-prop
 warning
To: Thorsten Leemhuis <regressions@leemhuis.info>,
 =?UTF-8?B?VmlrdG9yIErDpGdlcnNrw7xwcGVy?= <viktor_jaegerskuepper@freenet.de>,
 Alex Deucher <alexdeucher@gmail.com>
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
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <20260826104143.39077-1-mwen@igalia.com>
 <CADnq5_MEBLriK_M_atX6FKR5618fiB5DmAWOvxE_e+6nd5FdDg@mail.gmail.com>
 <83bef197-dfbc-44a5-b9d8-6e0c44488793@igalia.com>
 <6dda204d-2c12-4442-9893-6449b5ce51c9@igalia.com>
 <9d5fa2bf-d9e4-4c6a-a9ca-8abf14ad894e@leemhuis.info>
 <572f78a8-1b09-4275-bca7-0ae8703776d0@freenet.de>
 <722d96c4-8938-4da4-9eb4-2af50b9d8b26@leemhuis.info>
Content-Language: en-US
From: Melissa Wen <mwen@igalia.com>
In-Reply-To: <722d96c4-8938-4da4-9eb4-2af50b9d8b26@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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



On 01/09/2026 09:12, Thorsten Leemhuis wrote:
> On 8/28/26 14:19, Viktor Jägersküpper wrote:
>> On 8/28/26 09:22, Thorsten Leemhuis wrote:
>>> On 8/27/26 19:14, Melissa Wen wrote:
>>>> On 27/08/2026 18:37, Melissa Wen wrote:
>>>>> On 27/08/2026 15:34, Alex Deucher wrote:
>>>>>> On Wed, Aug 26, 2026 at 7:20 AM Melissa Wen <mwen@igalia.com> wrote:
>>>>>>> PREMULTI was the default DRM blend mode until 9813e158d13d
>>>>>>> ("drm/drm_blend: allow blend mode property without PREMULTI")
>>>>>>> introduced
>>>>>>> the possibility of exposing the blend mode property without PREMULTI
>>>>>>> being supported. However, __drm_atomic_helper_plane_state_init() still
>>>>>>> resets pixel_blend_mode to PREMULTI (hardcoded), ignoring the supported
>>>>>>> mode in this property. In the same series, 860e748bddcc ("drm: ensure
>>>>>>> blend mode supported if pixel format with alpha exposed") starts
>>>>>>> warning
>>>>>>> drivers that supports alpha formats in a given planes but doesn't
>>>>>>> support blend mode property, which includes AMD primary and cursor
>>>>>>> planes.
>>>> [...]
>>>>>> I presume you are planning to apply this directly to drm-misc for 7.3?
>>>>> Right, I'll apply to drm-misc-fixes, just doing it now.
>>>> Or not now. I have to wait for -rc1.
>>>> I'll keep it on my radar.
>>> Hmmm, that sounds like these fixes will miss -rc1. But wouldn't it be
>>> good to get them included there, as they afaik (please correct me if I'm
>>> wrong, is easy to mix something up from the outside!) the warnings that
>>> Greg described as ""It's not good to boot and have a bunch of warnings
>>> already happening, resulting in a "tainted" kernel before I have the
>>> chance to break anything manually myself...""[1], as more people then
>>> will likely encounter this (and then waste time on bisecting an issue
>>> known for weeks for which a fix exists).
>>>
>>> [1]
>>> https://lore.kernel.org/all/2026082651-spinning-cornbread-33ba@gregkh/
>> If I understand correctly, the *actual* fix (for all affected drivers)
>> will make it into 7.3-rc1, see this answer to my question:
>> https://lore.kernel.org/dri-devel/20260826-brave-nyala-of-elevation-d23aea@houat/
>>
>> This fix is queued in drm-next:
>> https://gitlab.freedesktop.org/drm/kernel/-/commit/271e90eb5f9ff34951647e5ed33c1775eebcca50
> Ahh, yeah, many thx, I had see this downgrade to drm_warn() (which made
> it to -rc1, yeah \o/), but had not made the right connections. :-/
>
> FWIW, even with that done there is now one amdgpu regression report
> about this already post-rc1:
> https://lore.kernel.org/all/CANkdJ2VvJQSBzyOq=LgSW1=Z8-YiN_r9Py2iJ0UJDo55+dbfuA@mail.gmail.com/
>
> """
> [...] After updating from kernel v7.2.2 to v7.3-rc1, several DRM plane
> warnings regarding unset blend modes for pixel formats with alpha
> channels started appearing in dmesg during initialization.
>
> [drm] [PLANE:44:plane-0] pixel format with alpha exposed but blend
> mode not setup. Please fix. [...]
> """
>
> Will reply there now. Wondering if we need to do something about that if
> more reports like that show up, but let's wait if that's the case.

I just applied this series to drm-misc-fixes:
- c3080b58d81d ("drm/atomic-state-helper: set pixel_blend_mode to prop 
default on reset")
- f0c75da0a6b4 ("drm/amd/display: fix missing blend-mode-prop warning 
for DCN")
- 332ad707e38f ("drm/amd/display: advertise PIXEL_NONE and PREMULTI 
blend mode for DCE")

With this, the dmesg message will no longer appear on the AMD driver.

Melissa

>
> Ciao, Thorsten

