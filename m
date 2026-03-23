Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49733EC01D4
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 11:44:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C97110E0FF;
	Mon, 23 Mar 2026 11:44:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="uGEXp/xn";
	dkim-atps=neutral
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDE9710E0FF;
 Mon, 23 Mar 2026 11:44:29 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4ffWY70c1Gz9tsq;
 Mon, 23 Mar 2026 12:44:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1774266267;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2TUve5txxvSf6BWYHb2Px5K2r5y5MDg/b/HumxZnWkE=;
 b=uGEXp/xn5tV+VwS6LhUJ7M9iCLjV5UDwaXzOfQDQ6Ff8L7eUDctUa2gtoLDrNS8TLbO8zF
 FUL9i3vCrJSd1WHx4ko9JDnwbzTHmL7r1FVo7Lh9H0ZFjPdFHva2F8/mch4PFkaST/0Te8
 xFaV6IW5VPcUBerYbM2Ji4VVzPSx7i4ABqx9mJmctvDddeARAHZHet8OijueQbmBX8UHxk
 12j2fy71s3y386LlT9/VV62dRkGeNW4cm28TOcsyUNbsjXPdcN2ck0usD7WWtEptXtiA1E
 PI/qM1NxU2fO9LMJHSiQrmewtWvaZNi2xiIp1uQiYbhW9H1hUH7fn2gn+bdt1w==
Message-ID: <1378c83e-6271-4d47-9b45-9bbed131f37e@mailbox.org>
Date: Mon, 23 Mar 2026 12:44:19 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v5 0/3] Add "link bpc" DRM property
To: Mario Kleiner <mario.kleiner.de@gmail.com>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
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
 Marius Vlad <marius.vlad@collabora.com>
References: <20260319-link-bpc-v5-0-5306cd04a708@collabora.com>
 <8ba60a99-f69e-482e-bd68-f6bc36291c54@mailbox.org>
 <5797606.kQq0lBPeGt@workhorse>
 <CAEsyxyhnALbkaF+9nav8FkW5gcJdtTw5CHhK3Hf8f=fymFiOKw@mail.gmail.com>
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Content-Language: en-CA
In-Reply-To: <CAEsyxyhnALbkaF+9nav8FkW5gcJdtTw5CHhK3Hf8f=fymFiOKw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: ndkjuit9tox47ypefe8tyapcb5uwi87x
X-MBO-RS-ID: c4a909e62259ec18369
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

On 3/21/26 03:33, Mario Kleiner wrote:
> As somebody who writes software for neuroscience research, I would find this new property very useful.
> 
> Even if the 'link bpc' is not the perfectly accurate answer in presence of dithering or display stream compression, I think it could provide an idea about the minimum precision available, so a DRM client can at least make sure its minimum requirements are met. E.g., a 'link bpc' of 10 would at least guarantee 10 bpc, and effectively a bit more if spatial dithering is applied in addition.

There's a problem in the opposite direction: With dithering, the "link bpc" property implies that the display link can transmit less information than it actually can.


> That said, I don't have practical experience with the effects of DSC, I don't have any
> suitable hardware. Afaik it is not truly lossless, but only (supposed to be, usually)
> perceptually lossless. It would be great to have some property that informs clients if DSC
> is active or not, or allow some control over that.

FWIW, I mentioned DSC not because it's potentially lossy, but because it allows transmitting a larger "real" (albeit potentially lossy) bpc over a smaller physical bpc. If the "link bpc" property reported the latter, it would again imply the link can transfer less information than it actually can.


> Also as somebody who has spent many hours of his life hunting down some sysfs or debugfs files for reporting such numbers, the files usually being differently named, at different paths, with different formats, or not existing at all, depending on kernel version and gpu configuration. I'd like to do less of that in the future.

No doubt that generic KMS properties would be better than that, I'm just skeptical that this specific property (alone) as currently defined is really useful.


> In the scenarios used by my app, the app often knows what an optimal setting for 'max bpc' or reported value from such a 'link bpc' would be,

How can it know that vs dithering?


> But I could imagine regular desktop use cases, where a Wayland compositor can somewhat know what good minimum values for 'link bpc' would be, and maybe adapt, or give the user a hint about potentially degraded quality, and what to do about it ("Check your cables", "Reduce video resolution or refresh rate", "Run with less displays",...).

I see potential for false positives resulting in spurious issue reports.


> - A HDR-10 display mode on a true HDR sink implies one really wants a 'link bpc' of at least 10 bpc, especially given the large nonlinearity of EOTF's like Perceptual Quantizer, or things will look poor.

Even with dithering? (Same question about the other scenarios you mentioned)


-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast
