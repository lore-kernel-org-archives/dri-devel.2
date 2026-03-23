Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FBF2EC01CC
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 10:55:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D80D10E0E1;
	Mon, 23 Mar 2026 10:55:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="S4eqopk0";
	dkim-atps=neutral
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1BDD10E04D;
 Mon, 23 Mar 2026 10:55:54 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4ffVT30j0Qz9smK;
 Mon, 23 Mar 2026 11:55:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1774263351;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ag5QRbuw52fksr+sNEPlc4Qp9A88in5+kmKRQum8m94=;
 b=S4eqopk0l20aMHWj0eTxc8+LAFminiHShpJAtX6u5RiVG4Tbx8Pd8u2CyVpqDmYdsHCHGY
 Of2w94UklWTPFBIhebC7M9NocmT9zqGSfbf2OgTvALXchdkp3GX0hYmNhCGCwlYia+AhIq
 m0XfDf7Hho+FiQgX5Gxk7/6QWH9PsPHM9tm0Mg8Xeguye7YwzfFxknhYZa2PipKA5RP/Lh
 PrQCAqXG8tHxzdu7bA4w1rbjXCoKrcjH1qj34EfxlcJwfs8xMkQGt5L8563sf2NW1VAdB+
 c92hX0tmH4wJlPGqhFw2vykVsknCmVCrMJlKU5PfycK6HRJ/maj8CWqz6f1xVA==
Message-ID: <6baaebff-ea82-4b40-a4d9-419045526cfa@mailbox.org>
Date: Mon, 23 Mar 2026 11:55:34 +0100
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
 <8ba60a99-f69e-482e-bd68-f6bc36291c54@mailbox.org>
 <5797606.kQq0lBPeGt@workhorse>
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Content-Language: en-CA
In-Reply-To: <5797606.kQq0lBPeGt@workhorse>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 45428bdb2a2b05489be
X-MBO-RS-META: ojzqy8yypcsx9ghjr7ojbyei9bejxrt7
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

On 3/20/26 19:02, Nicolas Frattaroli wrote:
> On Friday, 20 March 2026 15:32:37 Central European Standard Time Michel Dänzer wrote:
>> On 3/19/26 13:28, Nicolas Frattaroli wrote:
>>> This series adds a new "link bpc" DRM property. It reflects the display
>>> link's actual achieved output bits per component, considering any
>>> degradation of the bit depth done by drivers for bandwidth or other
>>> reasons. The property's value is updated during an atomic commit, which
>>> is also when it fires an uevent if it changed to let userspace know.
>>>
>>> There's a weston implementation at [1] which makes use of this new
>>> property to warn when a user's requested bpc could not be reached.
>>>
>>> [1]: https://gitlab.freedesktop.org/wayland/weston/-/merge_requests/1850
>>
>> I see no description of a real-world use case, either in this series
>> or in the weston MR, beyond logging a message when the "link bpc" &
>> "max bpc" property values don't match. They are not expected to match
>> in general, so I have a hard time seeing the usefulness of that.
> 
> Hello,
> 
> these are valid concerns. The problem being addressed is related to
> userspace being able to detect whether the link has degraded due to,
> say, a sketchy cable.
> 
> This patch started out as a method of forcing the output link's BPC
> value to a certain value, but this is not desirable. The max bpc
> property is already used to restrict the link's bpc due to sketchy
> hardware that advertises a higher max bpc than it can actually
> achieve.

Not really.

The "max bpc" property is simply an upper limit for the effective bpc that can be used by the driver; nothing more or less. The driver is free to use any lower bpc value though, that doesn't mean anything's wrong.

It doesn't imply that the "max bpc" value can actually be achieved under any circumstances.

The practical purpose is mainly to restrict bpc in cases where higher bpc would prevent e.g. higher refresh rate.


> I agree that the weston implementation isn't a great showcase,
> but it's actually supposed to compare link bpc with an explicitly
> set max bpc config value, not the property value. The config value
> exists to request a certain bpc.

Per above, the "max bpc" property isn't really useful for that.


>> Moreover, there's no description of what exactly the "link bpc" property
>> value means, e.g. vs things like DSC or dithering, or how a compositor / 
>> user would determine which value they need / want under given circumstances.
> 
> I agree that I should've expanded on this after splitting it out of the
> HDMI patch. It's the output BPC as HDMI understands it. That means DSC is not
> a factor. I don't know if any display protocols do dithering at the
> protocol level, I only know some monitors dither internally, which isn't
> something that can be detected.

I know AMD GPUs can do at least temporal dithering of the data they send over the link, I suspect non-temporal as well.

Either way, the user may be able to distinguish more information than the "link bpc" property value implies.


-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast
