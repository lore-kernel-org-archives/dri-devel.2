Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB797F33809
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 08:15:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 379A810E426;
	Tue, 17 Mar 2026 08:15:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="kBtP1zft";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1E1110E426
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 08:15:35 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 5B72E1A2E80;
 Tue, 17 Mar 2026 08:15:34 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 279A65FC9A;
 Tue, 17 Mar 2026 08:15:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id BB82E1045035C; Tue, 17 Mar 2026 09:15:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1773735333; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=Z9OLFEDq87BQa7nWUmmBOByV33+PPHVSVxneDISW25s=;
 b=kBtP1zftCfylQvKpg6pg/pN/XX09EDXsIH8u4cYc0tX+LQbEcsMW/WmDJ+xUn2wXAS9GFh
 6SqXn+caJdMZvVqrtjyIz6rdmTCaBTVYnA8jyIUVCRis9YkHqsc5Lwp7c0pHr8bGlyRC8l
 5RsdMjQeyIuCbrc+EvxxM82sfA0GZZKna8B1OXfObY3joMs/05goe/iZ8kaj5m3yiccAZd
 HoEHFhuu2JptQ6JcLBfDgAI6WPzI+MNFNk7Vtn1RV/m84blnGmDOuYy3Z04vf9ynvkwFVE
 owObIiOuzBd/Xyz1fRzi8H+bWkMm1VtFVgVeaKs2JE1cgA8iCVSidTcjJ9ACoQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 17 Mar 2026 09:15:26 +0100
Message-Id: <DH4WP3VS8DDK.14DVCYMYLGGNK@bootlin.com>
Subject: Re: [PATCH] drm/bridge: Fix refcount shown via debugfs for
 encoder_bridges_show()
Cc: "Marco Felsch" <m.felsch@pengutronix.de>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
To: "Liu Ying" <victor.liu@nxp.com>, "Andrzej Hajda"
 <andrzej.hajda@intel.com>, "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Robert Foss" <rfoss@kernel.org>, "Laurent Pinchart"
 <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman" <jonas@kwiboo.se>,
 "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.20.1
References: <20260312-drm-misc-next-2026-03-05-fix-encoder-bridges-refcount-v1-1-b9ba3d844732@nxp.com>
 <DH0ZD9UFY68E.2C1ISONVIO42L@bootlin.com>
 <53c257df-9800-48ed-a975-d7bfe4d71be1@nxp.com>
 <DH1KCR43169Z.200HRE4K6DNRQ@bootlin.com>
 <61a51c05-7730-4b7a-85cf-5f03a7985408@nxp.com>
 <DH1U1NUNGZTO.13UP9EXCAC2P5@bootlin.com>
 <b25719e0-21d3-4919-b95e-22b22bdbb388@nxp.com>
 <DH45VL1LHCP3.2MWX4VKP46H04@bootlin.com>
 <df7006cb-d1dd-4a72-8ef0-2f27ca0143cd@nxp.com>
In-Reply-To: <df7006cb-d1dd-4a72-8ef0-2f27ca0143cd@nxp.com>
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

Hello Liu,

On Tue Mar 17, 2026 at 3:04 AM CET, Liu Ying wrote:
> On Mon, Mar 16, 2026 at 12:14:23PM +0100, Luca Ceresoli wrote:
>> Hello Liu, Maxime,
>>
>> On Mon Mar 16, 2026 at 10:47 AM CET, Liu Ying wrote:
>>>>>>>> @Maxime: based on the issue Liu is trying to work around, do you t=
hink it
>>>>>>>> would make sense to go back to the initial approach for that serie=
s?
>>>>>>>> I.e. drm_for_each_bridge_in_chain_scoped() grabs the chain lock, w=
hich is a
>>>>>>>> superset of the per-bridge refcount, and thus the refcount can be =
dropped?
>>>>>>>> This would remove the debugfs issue, slightly simplify
>>>>>>>> drm_for_each_bridge_in_chain_scoped(), and introduce no new issues=
 AFAIK.
>>>>>>>
>>>>>>> Just my take on the chain lock approach - I agree Maxime's comment =
on [v2]
>>>>>>> that keeping the get/put is a better than using the chain lock to e=
nsure
>>>>>>> the refcount is correct.  The chain lock could be added later on if=
 needed.
>>>>>>
>>>>>> Well, no, adding the chain mutex is necessary(*), otherwise Thread A=
 could
>>>>>> iterate over the chain while thread B is adding/removing bridges to/=
from
>>>>>> the chain.
>>>>>>
>>>>>> And the chain mutex is a superset of the per-bridge refcount, so whe=
n
>>>>>> adding the mutex the refcount inside drm_for_each_bridge_in_chain_sc=
oped()
>>>>>> becomes useless (and slightly hurting as it makes the refcount shown=
 in
>>>>>> debugfs inconsistent, as you noticed).
>>>>>
>>>>> For better code readability, I think keeping the get/put is fine even=
 if
>>>>> you add a lock
>>>>
>>>> The [v4] code with the removal of the extra refcount would not be more
>>>> complex. It would be a bit less code (no need for the DEFINE_FREE and
>>>> __free()). Maybe it'd need an extra comment to clarify when the
>>>> drm_bridge_put() is called.
>>>>
>>>> [v4] https://lore.kernel.org/all/20260113-drm-bridge-alloc-encoder-cha=
in-mutex-v4-4-60f3135adc45@bootlin.com/
>>>>
>>>>> (maybe RCU list is better than mutex, since the chain is
>>>>> read often).  That follows the idea that you mentioned in [1]: "every
>>>>> pointer to a drm_bridge stored somewhere is a reference to a bridge".
>>>>
>>>> That's true. However while it's an important pointer hygiene rule for
>>>> device drivers, for core code it's OK to deviate when there is a reaso=
n.
>>>>
>>>>> Plus, seems no performance issue with the get/put, as discussed in [v=
2].
>>>>
>>>> I confirm performance is surely not an issue here.
>>>>
>>>> All that said, I'm OK with either option:
>>>>
>>>>  * no ref taken when the mutex is added
>>>>  * ref taken when the mutex is added (as v4) + your patch to fix debug=
fs
>>>
>>> Maybe consider to take this patch first, since it doesn't hurt.
>>
>> Yes, especially as the current debugfs output is non-intuitive.
>
> Agreed.
>
>>
>>> Even if
>>> we end up with the first option, the refcount is supposed to be correct
>>> anyway.
>>
>> Well, if we apply this patch and then go for option 1 then this patch sh=
all
>> be removed, or the refcount shown would be one-less than the expected
>> value, instead of one-more as it is now.
>
> I meant that if we go for option 1, then a single patch may introduce the
> protection for the chain with the mutex/RCU list(whatever), plus remove
> the change done by this patch.  This way, the refcount would be consisten=
t
> over time.

Ah, yes, sure.

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
