Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C39CF4644F
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 11:14:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0021510E0BB;
	Mon, 16 Mar 2026 11:14:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="knqEIGCW";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9302510E0BB
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 11:14:33 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 00A331A2E6E;
 Mon, 16 Mar 2026 11:14:32 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id C905F5FC4A;
 Mon, 16 Mar 2026 11:14:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E9CC310369E4D; Mon, 16 Mar 2026 12:14:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1773659671; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=2MbOg0Y9XZ4FNZJISl3n/LWKp7gjXBMr4OVGp+U/RcY=;
 b=knqEIGCWGr3glusq9ivP4Nvwv2+FP9OWO13N77/x44sxOBCjgJPg0myoREbZL9ryKwHt00
 pKxhMV8PKyTcae5RGXr6lznBNAwPksBOTho+e+i+lRqR3vW184zLLzlZeasesRfqhPBw0v
 0LWIcGXqrVbSug7OViiTqDJ/DKb+SXqnolZ6UfKawOsePIX0kQVdxiXkHtUuaj4FyfR9Ov
 H1F+a6eDuGNXaBdCL5MRrt14vSBlEnH05RzZUACcmAdBzN2xLrXjQOK8Pl+PUhMrAK8IXj
 SfP9JwIPYiSJPDiE8OAa9Mdnxcn/xTbonXn34N1bDQEjQxbiF7cy2fYoI5EOWQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Mar 2026 12:14:23 +0100
Message-Id: <DH45VL1LHCP3.2MWX4VKP46H04@bootlin.com>
To: "Liu Ying" <victor.liu@nxp.com>, "Andrzej Hajda"
 <andrzej.hajda@intel.com>, "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Robert Foss" <rfoss@kernel.org>, "Laurent Pinchart"
 <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman" <jonas@kwiboo.se>,
 "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH] drm/bridge: Fix refcount shown via debugfs for
 encoder_bridges_show()
Cc: "Marco Felsch" <m.felsch@pengutronix.de>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20260312-drm-misc-next-2026-03-05-fix-encoder-bridges-refcount-v1-1-b9ba3d844732@nxp.com>
 <DH0ZD9UFY68E.2C1ISONVIO42L@bootlin.com>
 <53c257df-9800-48ed-a975-d7bfe4d71be1@nxp.com>
 <DH1KCR43169Z.200HRE4K6DNRQ@bootlin.com>
 <61a51c05-7730-4b7a-85cf-5f03a7985408@nxp.com>
 <DH1U1NUNGZTO.13UP9EXCAC2P5@bootlin.com>
 <b25719e0-21d3-4919-b95e-22b22bdbb388@nxp.com>
In-Reply-To: <b25719e0-21d3-4919-b95e-22b22bdbb388@nxp.com>
X-Last-TLS-Session-Version: TLSv1.3
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

Hello Liu, Maxime,

On Mon Mar 16, 2026 at 10:47 AM CET, Liu Ying wrote:
>>>>>> @Maxime: based on the issue Liu is trying to work around, do you thi=
nk it
>>>>>> would make sense to go back to the initial approach for that series?
>>>>>> I.e. drm_for_each_bridge_in_chain_scoped() grabs the chain lock, whi=
ch is a
>>>>>> superset of the per-bridge refcount, and thus the refcount can be dr=
opped?
>>>>>> This would remove the debugfs issue, slightly simplify
>>>>>> drm_for_each_bridge_in_chain_scoped(), and introduce no new issues A=
FAIK.
>>>>>
>>>>> Just my take on the chain lock approach - I agree Maxime's comment on=
 [v2]
>>>>> that keeping the get/put is a better than using the chain lock to ens=
ure
>>>>> the refcount is correct.  The chain lock could be added later on if n=
eeded.
>>>>
>>>> Well, no, adding the chain mutex is necessary(*), otherwise Thread A c=
ould
>>>> iterate over the chain while thread B is adding/removing bridges to/fr=
om
>>>> the chain.
>>>>
>>>> And the chain mutex is a superset of the per-bridge refcount, so when
>>>> adding the mutex the refcount inside drm_for_each_bridge_in_chain_scop=
ed()
>>>> becomes useless (and slightly hurting as it makes the refcount shown i=
n
>>>> debugfs inconsistent, as you noticed).
>>>
>>> For better code readability, I think keeping the get/put is fine even i=
f
>>> you add a lock
>>
>> The [v4] code with the removal of the extra refcount would not be more
>> complex. It would be a bit less code (no need for the DEFINE_FREE and
>> __free()). Maybe it'd need an extra comment to clarify when the
>> drm_bridge_put() is called.
>>
>> [v4] https://lore.kernel.org/all/20260113-drm-bridge-alloc-encoder-chain=
-mutex-v4-4-60f3135adc45@bootlin.com/
>>
>>> (maybe RCU list is better than mutex, since the chain is
>>> read often).  That follows the idea that you mentioned in [1]: "every
>>> pointer to a drm_bridge stored somewhere is a reference to a bridge".
>>
>> That's true. However while it's an important pointer hygiene rule for
>> device drivers, for core code it's OK to deviate when there is a reason.
>>
>>> Plus, seems no performance issue with the get/put, as discussed in [v2]=
.
>>
>> I confirm performance is surely not an issue here.
>>
>> All that said, I'm OK with either option:
>>
>>  * no ref taken when the mutex is added
>>  * ref taken when the mutex is added (as v4) + your patch to fix debugfs
>
> Maybe consider to take this patch first, since it doesn't hurt.

Yes, especially as the current debugfs output is non-intuitive.

> Even if
> we end up with the first option, the refcount is supposed to be correct
> anyway.

Well, if we apply this patch and then go for option 1 then this patch shall
be removed, or the refcount shown would be one-less than the expected
value, instead of one-more as it is now.

> Luca, do you think this patch deserves at least an A-b tag from you if no=
t
> a R-b tag?

I've been waiting a bit in case Maxime or someone else wanted to chime
in. I'm reviewing it now.

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
