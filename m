Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 182DE1061B17
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 16:57:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84AB310E1EE;
	Mon, 30 Mar 2026 16:57:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="fKoGHyUj";
	dkim-atps=neutral
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 205B910E1EE;
 Mon, 30 Mar 2026 16:57:41 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4fky9G1sKzz9vH3;
 Mon, 30 Mar 2026 18:57:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1774889858;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EWOzSBjurlqM57m3TNOGkoci9H4/VpgtQt5dVwkP0+0=;
 b=fKoGHyUjtFKycqppdgl8bq27qwY3aR/E7AgkC0dFqtxmxwvWjoKn069jUss56NLHq9jcyy
 Rv8KIMQT2LS0nsLuDUocMluPrQMwiZe/WPfczypwCsREck3g9SUxatIxU6qD4ThJqXSbVj
 xBJvx4R49Ie+XjTGlNYId8RYIgZDD48y1tl9NEmT3JOQtGvGT0f+mBQfB3m2CVT0nJ5bVP
 oYKyhYZ+cPP2T6k5Zn3y3+ITFe3DOhRsXRsaQt+2u0os0u1dooe1z5gIQO9CNjt5Sy7EVy
 zkDEgtl9BAWrWq9fnp2X9oLHd6RRMr5g9pB+FeDsM4IocBcPVQC2r+cICZ3WHg==
Message-ID: <792c4540-d690-4453-a32e-62e23e78d628@mailbox.org>
Date: Mon, 30 Mar 2026 18:57:32 +0200
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
 <4265353.aeNJFYEL58@workhorse>
 <254c20a4-cce3-4c8e-9902-514586f3e694@mailbox.org>
 <5416161.aeNJFYEL58@workhorse>
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Content-Language: en-CA
In-Reply-To: <5416161.aeNJFYEL58@workhorse>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 3da1573029725bafc90
X-MBO-RS-META: 51py31jnqr3rhanwy3kyte6i8y775ekt
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

On 3/26/26 13:17, Nicolas Frattaroli wrote:
> On Tuesday, 24 March 2026 17:44:21 Central European Standard Time you wrote:
>> On 3/24/26 16:25, Nicolas Frattaroli wrote:
>>> On Monday, 23 March 2026 18:27:41 Central European Standard Time Michel Dänzer wrote:
>>>> On 3/23/26 17:55, Nicolas Frattaroli wrote:
>>>>>
>>>>> "Someone might not understand its purpose" is, in my eyes, not a valid reason to
>>>>> not have this property, [...]
>>>> Per my previous posts, that's not my concern.
>>>
>>> Then what is your concern?
>>
>> Per my previous posts, my concerns are:
>>
>> * The meaning of the "link bpc" property value isn't defined well
>> enough vs things like dithering or DSC, which will likely result in
>> compositors / users overestimating what value they need / want,
>> resulting in compositors spuriously rejecting configurations which 
>> would work perfectly fine, and/or spurious issue reports.
> 
> Dithering and DSC are supposed to be transparent, no?

Not really, no. They achieve higher "effective" (as perceived by the user) bpc using a lower physical bpc.


> If a link bpc is 10 but DSC is on so it's 9 on the wire, it's still 10 bits.

If DSC encodes user-perceived 10 bpc at a lower physical bpc, and the "link bpc" property reports 10, that would satisfy my concern for DSC.

Are you sure that's the case though?

I would be quite surprised if this was correspondingly the case for dithering.

Either way, the "link bpc" semantics regarding these should be explicitly documented.


> No compositor would care about the compressed-to actual bit depth on
> the wire being 9 bits on the intake of a DSC decoder, it's not relevant
> for their use case, they're not decoding DSC.
> 
> Making it consider DSC as part of the link bpc would lead to what you
> describe, since now compositors would need to know the compression
> algorithms of every single display protocol to correctly determine
> whether unintended degradation has happened. Ignoring DSC, which is
> what I am doing, would not do that.

Sounds like you misunderstood my concern.


>> With my compositor developer hat on, what I'd want to know is something
>> like: "How many bits of information can be passed over the link, allowing
>> the display to present it in a way which can be perceived by the user?"
>> With dithering or DSC, that would be a higher value than the physical
>> link bpc.
> 
> You're assuming link-bpc isn't precisely that.

I'm not assuming, I'm asking for this to be clarified.


> [...], you seem to be obsessed [...]

Not sure why you keep attacking me personally. I'm not trying to shoot down your proposal, I'm trying to prevent potential flaws I see with it. A bit more cooperative attitude would be nice.


>>> If all you want is a clearer description of the property in the comment that
>>> accompanies it, then I can do that, and I said I agree with this point.
>>
>> Patch 3 would need to take dithering & DSC into account as well.
> 
> There is no patch 3,

The start of this thread is the cover letter of a 3-patch series.


> and I will not break the feedback loop semantics of this property to please you.

More ad hominem.


>>> But you seem to be arguing from a position of not wanting the property to
>>> exist at all, [...]
>>
>> I'm not. However, per the first concern above, a not-well-defined
>> property could be worse than none.
> 
> So should I remove max-bpc as well? It's not well defined after all.

This isn't a good-faith argument either. Nobody asked for that.


-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast
