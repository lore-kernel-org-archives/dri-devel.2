Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02875606A321
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 20:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=clJTmCYN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25DDE10F06F;
	Tue, 24 Nov 2026 20:08:45 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09E1410F06F
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 20:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1795550917;
 bh=kEMsWENHsct+hnOy/u/pQmeeCpFzxWi6tmYy7lkr2wM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=clJTmCYNwvUhqDOkMu4RA7chckDqhxt6fYb79HAYQV87DgCeTKdGRRp4ZIptr6uZd
 R+L81WK0g8UEzFdizqqMZC5R7oreyfbN5PCdUC1toBs9uqgO9zRjD5m8OCMXz1+FS2
 c0FuY4+EhDAezR/yNdahiteduhExHHbNGI/+Ug1tbC2lMwC7a+64uWCHuBAg/zlPxD
 dLdR19c2WmrAHoQD3UyYp07OcgYDJfoiS1tiNnD1QAguq43BZiTPlzt3/cow2Ae6cy
 1hP3jxq7GiX7KReuuni8DlsYuamVx4T3gAuPS2o2Tfuudtd0hN2qN7xncmx9fXxZCQ
 22Sqwa6dALYbg==
Received: from [100.64.0.241] (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 2A17617E090C;
 Tue, 24 Nov 2026 21:08:37 +0100 (CET)
Message-ID: <6f58183d-1bde-4b6d-b09c-094c97732609@collabora.com>
Date: Tue, 24 Nov 2026 22:08:36 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/25] drm/tests: edid: Fix conformity for 1080p+4K YUV420
 200MHz EDID
To: Maxime Ripard <mripard@kernel.org>
Cc: Helge Deller <deller@gmx.de>, Martin Bugge <marbugge@cisco.com>,
 Thierry Reding <treding@nvidia.com>, Hans Verkuil <hverkuil@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, kernel@collabora.com,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20261114-drm-conn-hdmi-cleanup-v1-0-20e8a33a2286@collabora.com>
 <20261114-drm-conn-hdmi-cleanup-v1-13-20e8a33a2286@collabora.com>
 <awRgyldN6JaiisFJ@houat>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <awRgyldN6JaiisFJ@houat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/23/26 5:51 PM, Maxime Ripard wrote:
> On Sat, Nov 14, 2026 at 08:03:37PM +0200, Cristian Ciocaltea wrote:
>> The test EDID added by commit 58fe1d78605e ("drm/tests: hdmi: Provide
>> EDID supporting 4K@30Hz with YUV420 only") fails 'edid-decode --check'
>> (v1.33.0) with the following issues:
>>
>>   Warnings:
>>
>>   Block 1, CTA-861 Extension Block:
>>     IT Video Formats are overscanned by default, but normally this should be underscanned.
>>     YCbCr 4:2:0 Video Data Block: Some YCbCr 4:2:0 timings are invalid for HDMI 2.1
>>       (which requires an RGB timings pixel rate >= 590 MHz).
>>   EDID:
>>     Base EDID: Some timings are out of range of the Monitor Ranges:
>>       Maximum Clock: 297.000 MHz (Monitor: 170.000 MHz)
>>     CTA-861: Multiple native progressive timings are defined.
>>
>>   Failures:
>>
>>   Block 0, Base EDID:
>>     Vendor & Product Identification: EDID 1.3 does not support week 0xff.
>>   Block 1, CTA-861 Extension Block:
>>     Vendor-Specific Data Block (HDMI Forum), OUI C4-5D-D8: Max TMDS rate is > 0 and <= 340 or > 600.
>>     YCbCr 4:2:0 Capability Map Data Block: Empty Capability Map.
>>     YCbCr 4:2:0 Video Data Block: YCbCr 4:2:0-only VIC 95 is also a regular VIC.
>>     Missing VCDB, needed for Set Selectable RGB Quantization to avoid interop issues.
>>   EDID:
>>     CTA-861: The maximum HDMI TMDS clock is 200000 kHz, but one or more video timings go up to 297000 kHz.
>>

[...]

> Acked-by: Maxime Ripard <mripard@kernel.org>
> 
> I've been collecting descriptions of these EDIDs here:
> https://github.com/mripard/redid/tree/main/edid-generator/samples
> 
> If you ever have the chance or the motivation, it would be great to
> submit a sample for this one.

Oh, nice, you have a tool!  Just had a quick look at
https://github.com/mripard/redid/blob/main/redid/README.md - are YCbCr 4:2:0
Video and Capability Map Data blocks not yet supported?

Regardless, I will give it a try and share the sample.

FWIW, I initially used wxedid to generate basic EDIDs, then resorted to manual
hex editing for the more advanced stuff, which was always painful.  Having a
proper tool for that would help a lot.

Thanks,
Cristian
