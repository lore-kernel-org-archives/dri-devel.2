Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 902B7F4612C
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 14:39:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3EC410E49F;
	Mon, 23 Mar 2026 14:39:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="OjI0iJuj";
	dkim-atps=neutral
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83FA110E422;
 Mon, 23 Mar 2026 14:39:09 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4ffbQd6vrgz9thq;
 Mon, 23 Mar 2026 15:39:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1774276746;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TPbcy+jDfWMiVExSnzQ8BzXwJPREIs+HTyS0kmi21U4=;
 b=OjI0iJuj07q3A+MlWfI9JNnOewHrAS73jtLIEkL7YW6LtTQVB0+sIjPzxnOPG0vLHw3T+h
 htwwAcKlssXHQ6WV0JUVP4jSCOk1QTr+YnrAfroIeMi4DnabErcl6hkZ6mGVILskzC3Glp
 PP9YlePD4iuyIiM9G1x1sprGkpdVAJvaI0rIAMOqGfweg3c0JzJPDR5g8R7El0w5Nrymqs
 CjZEjmL/X3wLjbsqwq8E6h2x0m1PWD/CuUFPHQOB2u/6j/g+uTaEN2D5R9xUu9uN9HzQdl
 WFzQB8Q3k6vEuSxUeMllaGhLJgjORjozTuijk5mRvS/eMpaLSc/AzaMndJ+E9Q==
Message-ID: <aead136d-4da5-42de-aef8-3f91815a95a9@mailbox.org>
Date: Mon, 23 Mar 2026 15:38:58 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v5 0/3] Add "link bpc" DRM property
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
 Daniel Stone <daniels@collabora.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, kernel@collabora.com,
 Derek Foreman <derek.foreman@collabora.com>,
 Marius Vlad <marius.vlad@collabora.com>
References: <20260319-link-bpc-v5-0-5306cd04a708@collabora.com>
 <5797606.kQq0lBPeGt@workhorse>
 <6baaebff-ea82-4b40-a4d9-419045526cfa@mailbox.org>
 <5995842.DvuYhMxLoT@workhorse>
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Content-Language: en-CA
In-Reply-To: <5995842.DvuYhMxLoT@workhorse>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 23ba6435310b5e63003
X-MBO-RS-META: gp7oro7r8z8gkwz3fsbjkw9h16b6aa9q
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

On 3/23/26 13:05, Nicolas Frattaroli wrote:
> On Monday, 23 March 2026 11:55:34 Central European Standard Time Michel Dänzer wrote:
>> On 3/20/26 19:02, Nicolas Frattaroli wrote:
>>> On Friday, 20 March 2026 15:32:37 Central European Standard Time Michel Dänzer wrote:
>>>> On 3/19/26 13:28, Nicolas Frattaroli wrote:
>>>>> This series adds a new "link bpc" DRM property. It reflects the display
>>>>> link's actual achieved output bits per component, considering any
>>>>> degradation of the bit depth done by drivers for bandwidth or other
>>>>> reasons. The property's value is updated during an atomic commit, which
>>>>> is also when it fires an uevent if it changed to let userspace know.
>>>>>
>>>>> There's a weston implementation at [1] which makes use of this new
>>>>> property to warn when a user's requested bpc could not be reached.
>>>>>
>>>>> [1]: https://gitlab.freedesktop.org/wayland/weston/-/merge_requests/1850
>>>>
>>>> I see no description of a real-world use case, either in this series
>>>> or in the weston MR, beyond logging a message when the "link bpc" &
>>>> "max bpc" property values don't match. They are not expected to match
>>>> in general, so I have a hard time seeing the usefulness of that.
>>>
>>> Hello,
>>>
>>> these are valid concerns. The problem being addressed is related to
>>> userspace being able to detect whether the link has degraded due to,
>>> say, a sketchy cable.
>>>
>>> This patch started out as a method of forcing the output link's BPC
>>> value to a certain value, but this is not desirable. The max bpc
>>> property is already used to restrict the link's bpc due to sketchy
>>> hardware that advertises a higher max bpc than it can actually
>>> achieve.
>>
>> Not really.
>>
>> The "max bpc" property is simply an upper limit for the effective bpc that can be used by the driver; nothing more or less. The driver is free to use any lower bpc value though, that doesn't mean anything's wrong.
>>
>> It doesn't imply that the "max bpc" value can actually be achieved under any circumstances.
>>
>> The practical purpose is mainly to restrict bpc in cases where higher bpc would prevent e.g. higher refresh rate.
> 
> The max bpc property's upper limit is an arbitrary driver-set value as
> you stated, but that's not what I'm talking about here.

I'm not talking about the maximum value of the property itself either.

The value of the "max bpc" property, which can be modified by user space, defines the upper limit for the effective bpc used by the driver.


>>> I agree that the weston implementation isn't a great showcase,
>>> but it's actually supposed to compare link bpc with an explicitly
>>> set max bpc config value, not the property value. The config value
>>> exists to request a certain bpc.
>>
>> Per above, the "max bpc" property isn't really useful for that.
> 
> This is straight up false. Setting a max bpc value in weston's config
> sets the max bpc DRM property to that value, which in turn sets
> max_requested_bpc. On atomic_check, the minimum of state->max_bpc
> and state->max_requested_bpc is taken for the new value of
> state->max_bpc, i.e. what is set through the property does constrain
> the max bpc.

What I mean is that the "max bpc" property isn't useful for the purpose of "request a certain bpc". It only affects the upper limit, not the effective value, which can legitimately be lower. Logging a message in that case may be a false positive which may result in a spurious issue report.


-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast
