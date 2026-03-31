Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A2A0FF60D9
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 08:02:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDFD710E8DD;
	Tue, 31 Mar 2026 08:02:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="f1ogTgA4";
	dkim-atps=neutral
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DD7510E8DA;
 Tue, 31 Mar 2026 08:02:11 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4flLDv4NgZz9v05;
 Tue, 31 Mar 2026 10:02:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1774944127;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LWma+VJmsoQRIfIYqydIPc5B1ENuLNvGxTASbu4Lj6w=;
 b=f1ogTgA4r5NWDRA5+V3X7sC19IVZd11mSwKvPOZ3ZAtCuhSk4ZmjX9upL+CkSXLYbhl0pd
 9oGbgjkLyt+3LCjrovMrS2LwLxdJOS6IdLj3n9g+t+fqa/JGICR759T8YlUPf3GvwuF+z9
 F19sC08yP8vv5Fx8qZTVgIOBI/e9/N1iauhh7EKfD1Gx5lJNIVoYfzhB0T1yp/IAOYZmK7
 Rn/uSTiShwAWy3clZl24B6z30AK89kGaRUGge69hqbKDM44hV6p7Ti58uB2eZ0Z/PaA1CS
 hfMI1qc3BkKu4DTDNZlij7N5h0ljtwWMItBFCR/gTVk/gTCXiY2q4Sf/tyL+ag==
Message-ID: <47325395-3790-4cb4-8efd-84a3d8ddb80c@mailbox.org>
Date: Tue, 31 Mar 2026 10:01:59 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v5 0/3] Add "link bpc" DRM property
To: Pekka Paalanen <pekka.paalanen@collabora.com>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
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
 <8676926.T7Z3S40VBb@workhorse>
 <eff61423-a854-44c1-8634-30e2bd61e005@mailbox.org>
 <4265353.aeNJFYEL58@workhorse>
 <254c20a4-cce3-4c8e-9902-514586f3e694@mailbox.org>
 <20260326155305.736b4e64@fluorite>
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Content-Language: en-CA
In-Reply-To: <20260326155305.736b4e64@fluorite>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 77410acfb4e1f59b3ce
X-MBO-RS-META: efk64sa8g3dfoerph73uwr3bnixbrtah
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

On 3/26/26 14:53, Pekka Paalanen wrote:
> On Tue, 24 Mar 2026 17:44:21 +0100
> Michel Dänzer <michel.daenzer@mailbox.org> wrote:
> 
>> Per my previous posts, my concerns are:
>>
>> * The meaning of the "link bpc" property value isn't defined well
>> enough vs things like dithering or DSC, which will likely result in
>> compositors / users overestimating what value they need / want,
>> resulting in compositors spuriously rejecting configurations which
>> would work perfectly fine, and/or spurious issue reports.
> 
> That is ok. Compositors need to understand what the numbers mean, how
> reliable they are, and act accordingly. Knowing the lower bound for
> link precision is already useful as it guarantees a minimum precision.

I don't disagree, this needs to be made clear in the documentation though, if not reflected in the property name itself.


>> * There's no clear use case.
>>
>> This is generally a requirement for new KMS UAPI.
>>
>> The practical usefulness of the corresponding weston MR is dubious
>> per the concern above.
> 
> I think the example of RGB 10 bpc to be degraded to YCbCr 10 bpc rather
> than RGB 8 bpc is an excellent use case.

This series and the corresponding Weston MR aren't enough to address that use case though, are they? All they achieve is logging a potentially misleading warning.

It might make sense to combine this series and the Weston MR with whatever else is needed for that use case.


> I had another use case in
> https://gitlab.freedesktop.org/wayland/weston/-/merge_requests/1850#note_3115686

That would need to take dithering into account as well?


> Mario Kleiner had excellent cases as well.

I raised unanswered questions on those.


>>> That the link-bpc property does not consider DSC and dithering?
>>> Two things which the max-bpc property also does not consider?  
>>
>> It's not (as much of) an issue with the "max bpc" property because
>> it's just an upper limit, the driver is free to use a lower effective
>> bpc.
> 
> FWIW, 'max bpc' is a workaround for faulty sink devices that claim to
> handle a depth but silently misbehave.

That's not the only use case (in fact I'm not sure I'd heard of this before). E.g. it can also be used in cases where some HW bottleneck prevents using maximum refresh rate at maximum bpc for all displays, to explicitly choose which display(s) to limit bpc for, allowing max bpc for the rest.


-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast
