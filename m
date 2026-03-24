Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D15BF54AD7
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 16:44:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03BEE10E772;
	Tue, 24 Mar 2026 16:44:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="CBlDSMBZ";
	dkim-atps=neutral
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F248010E772;
 Tue, 24 Mar 2026 16:44:31 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4fgG8r3SHWz9v1Q;
 Tue, 24 Mar 2026 17:44:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1774370668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i6jFxC5QqAnVKARAaOlj7wQMriWLDHrAHv85BO6JVIc=;
 b=CBlDSMBZegpzqYTMaWbIexH5fv/MSRWqzFrZW1yA9LOsuKvtKAWs/KNcLs/34zgvyXF2zm
 CyGm73lJZ11VATDG38CO+1aBmNBnwaoeAAtpDQ/uWg0OXctLHQI2U4TJmsibPfHZm/DL7P
 Ism+wCTLmg2ph/WGSy7YqUEWSOKDdyOWX4JnURLP0oj91R9OTtJzANHkUjl4wnUlCkjLDN
 6HjTNmhnTyzMR9f1Y8zo1k7fBgrzC77jbzikhj0FpCzH/GFpCuzur4/y8eS7ZkT5CEPwXk
 y2ThqvxW0eG5HkHCepOgxIkoBGqmh7QazzElTAvo0a7ZQTSiIzOiHr/8HEpwLw==
Message-ID: <254c20a4-cce3-4c8e-9902-514586f3e694@mailbox.org>
Date: Tue, 24 Mar 2026 17:44:21 +0100
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
 <8676926.T7Z3S40VBb@workhorse>
 <eff61423-a854-44c1-8634-30e2bd61e005@mailbox.org>
 <4265353.aeNJFYEL58@workhorse>
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Content-Language: en-CA
In-Reply-To: <4265353.aeNJFYEL58@workhorse>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 8579321637022c6ad0a
X-MBO-RS-META: enrgji945et541zmwxco1a6gnwnhtgbb
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

On 3/24/26 16:25, Nicolas Frattaroli wrote:
> On Monday, 23 March 2026 18:27:41 Central European Standard Time Michel Dänzer wrote:
>> On 3/23/26 17:55, Nicolas Frattaroli wrote:
>>>
>>> "Someone might not understand its purpose" is, in my eyes, not a valid reason to
>>> not have this property, [...]
>> Per my previous posts, that's not my concern.
> 
> Then what is your concern?

Per my previous posts, my concerns are:

* The meaning of the "link bpc" property value isn't defined well enough vs things like dithering or DSC, which will likely result in compositors / users overestimating what value they need / want, resulting in compositors spuriously rejecting configurations which would work perfectly fine, and/or spurious issue reports.

With my compositor developer hat on, what I'd want to know is something like: "How many bits of information can be passed over the link, allowing the display to present it in a way which can be perceived by the user?" With dithering or DSC, that would be a higher value than the physical link bpc.


* There's no clear use case.

This is generally a requirement for new KMS UAPI.

The practical usefulness of the corresponding weston MR is dubious per the concern above.


> That the link-bpc property does not consider DSC and dithering?
> Two things which the max-bpc property also does not consider?

It's not (as much of) an issue with the "max bpc" property because it's just an upper limit, the driver is free to use a lower effective bpc.


> If all you want is a clearer description of the property in the comment that
> accompanies it, then I can do that, and I said I agree with this point.

Patch 3 would need to take dithering & DSC into account as well.


> But you seem to be arguing from a position of not wanting the property to
> exist at all, [...]

I'm not. However, per the first concern above, a not-well-defined property could be worse than none.


-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast
