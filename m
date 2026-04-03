Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09AABE7E365
	for <dri-devel@archiver.kernel.org>; Fri,  3 Apr 2026 10:23:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DF2310E44A;
	Fri,  3 Apr 2026 10:23:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="cFVCBbhH";
	dkim-atps=neutral
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8F3B10E432;
 Fri,  3 Apr 2026 10:23:36 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4fnFDh6nxNz9tQF;
 Fri,  3 Apr 2026 12:23:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1775211813;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GP9qELArIUgbsc41VJCgX7j/0EeHPA0FoRwMzjcZtuA=;
 b=cFVCBbhHkSrRL+0vPUNyQ2a3kxqTVNPRZUCPxAAR6cuQX76uTm+XL1Lw5KPY5GmrmdOT/W
 j6A+0D5xuvxtwzhZ3Kp3IcsbnyWuiixM/nUI7kI+Lzay9MhplvnrJWEB9ARd9A9qSCQgnp
 pqsOnA6MJfYvflE3GXruYuPfsQYH+Eaexo26hM3lO9mGNz0QFHAqAakylGvSiohHDH3YRR
 WoAyV1cP0x47VTsImlsUTPbqWC6IEQM3yTAoozdt/SehwYADqTOpSRk8dp4pGpTnICczwd
 tYvoT4+OC7bfpjuDTJnyibRaKkhXZK7iFcp2Rqg3xsejLepk2tod49+icWiWFg==
Message-ID: <915b3732-2c9d-4e92-a10e-68f59ee0b61f@mailbox.org>
Date: Fri, 3 Apr 2026 12:23:25 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v5 0/3] Add "link bpc" DRM property
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Xaver Hugl <xaver.hugl@kde.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
 Daniel Stone <daniels@collabora.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, kernel@collabora.com,
 Derek Foreman <derek.foreman@collabora.com>,
 Marius Vlad <marius.vlad@collabora.com>, wayland-devel@lists.freedesktop.org
References: <20260319-link-bpc-v5-0-5306cd04a708@collabora.com>
 <CAFZQkGzxfGP4E18owJf5d6L4n25-nvYn0TG=rTLCzjpj1Hk23w@mail.gmail.com>
 <4970515.ElGaqSPkdT@workhorse>
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Content-Language: en-CA, de-CH-frami
In-Reply-To: <4970515.ElGaqSPkdT@workhorse>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: aw43nkspy7kihge1budkr5nnxuhhfjrc
X-MBO-RS-ID: 3437b1f111f978ff333
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

On 4/1/26 14:14, Nicolas Frattaroli wrote:
> On Wednesday, 1 April 2026 13:57:08 Central European Summer Time Xaver Hugl wrote:
>> Am Do., 19. März 2026 um 13:28 Uhr schrieb Nicolas Frattaroli
>> <nicolas.frattaroli@collabora.com>:
>>>
>>> This series adds a new "link bpc" DRM property. It reflects the display
>>> link's actual achieved output bits per component, considering any
>>> degradation of the bit depth done by drivers for bandwidth or other
>>> reasons. The property's value is updated during an atomic commit, which
>>> is also when it fires an uevent if it changed to let userspace know.
>>
>> Hi,
>> I think it's a really good idea to have a property for knowing the
>> actual bpc of the link... however, I do have one big concern with this
>> API specifically: It only gives me this information after a modeset.
>>
>> With this limitation, I can at most show the user which bpc was chosen
>> after the apply display settings and have the end user manually test
>> and figure things out, but I cannot show in the UI which bpc will be
>> chosen with some configuration before they apply it, and I cannot do
>> atomic tests to find a desired tradeoff automatically on the
>> compositor side.
> 
> To do this I'd need to see if there's some feedback mechanism for
> the output configuration chosen by the atomic check phase, so that
> userspace can then run a DRM_MODE_ATOMIC_TEST_ONLY and get the value
> back somehow.
> 
> The current implementation wouldn't be able to do this since it
> updates the property on commit_tail. I'll need to look into whether
> drivers already have everything figured out with regards to link bpc
> in the check phase, and how that would best be communicated to
> userspace.

Taking both the Weston use case described in this thread and Xaver's requirements into account, a "min bpc" property complementing the "max bpc" one (as suggested by Ville before) might be better than "link bpc".

That might be a better fit even just for the Weston use case described in this thread, since AFAICT that only really cares about the minimum bpc, not the maximum.

The compositor could set "min bpc" to any value <= the "max bpc" one. If the driver can't make things work with effective bpc >= "min bpc", the commit fails. Setting both properties to the same value would allow selecting a specific bpc. That would allow compositors to find possible bpc permutations using TEST_ONLY commits, as described by Xaver.

Setting "min bpc" to 0 (which should probably be the default value) would allow any bpc, i.e. "auto" behaviour.


One potential issue with the "min bpc" property is that if one DRM master leaves it at a non-0 value, and a later DRM master doesn't know about it yet, it might cause surprising commit failures for the latter. This kind of issue already exists with other properties though. (Some kind of "default state" mechanism might help for solving this kind of issue)


-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast
