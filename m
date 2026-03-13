Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2443107BCD3
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 17:32:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5490010EB85;
	Fri, 13 Mar 2026 17:32:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="zBiKwoPe";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5EC610EB85
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 17:32:54 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 964B0C4270F;
 Fri, 13 Mar 2026 17:33:14 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 2F3E560027;
 Fri, 13 Mar 2026 17:32:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id DA5DB10368950; Fri, 13 Mar 2026 18:32:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1773423171; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=I5I6di6GxOJaF3M0DlGDG2wogUWuTcHbKDBWuT86Y4A=;
 b=zBiKwoPechlYPRYCGJPgUknDVsTV95lK9j/A7L6sgdwfaxW3HE7c0AiTHArm/kh7bhmC55
 aA1YmtzWZ1dW6tPCU+hDNsBlw6j+RBPPY/mlYnjG3BLftIwlHaj6o3xYVjuh/lgjUWkr6J
 d/whAuvrIr9bEM3ifgOrUxn9RkL2MrT4PWUrMD8t2VKFtxZcK9PBx3S4ex9v3fAqAU8qRa
 XchKrl7QnDpa88fE1PFZoIwYlbelewpcrX1yNqMi35mjdKQkGMJEb7TahPE5g+NkEgZlpH
 6kmRSVrj244YtLXsHtz+VM4lZ5WBSXdwdZHcLG/bR65VLb685PHS3EOahUqVYw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 13 Mar 2026 18:32:46 +0100
Message-Id: <DH1U1NUNGZTO.13UP9EXCAC2P5@bootlin.com>
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
In-Reply-To: <61a51c05-7730-4b7a-85cf-5f03a7985408@nxp.com>
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

On Fri Mar 13, 2026 at 11:22 AM CET, Liu Ying wrote:
> On Fri, Mar 13, 2026 at 10:57:04AM +0100, Luca Ceresoli wrote:
>> On Fri Mar 13, 2026 at 9:33 AM CET, Liu Ying wrote:
>>> On Thu, Mar 12, 2026 at 06:30:22PM +0100, Luca Ceresoli wrote:
>>>> Hello Liu, Maxime,
>>>>
>>>> On Thu Mar 12, 2026 at 7:05 AM CET, Liu Ying wrote:
>>>>> A typical bridge refcount value is 3 after a bridge chain is formed:
>>>>> - devm_drm_bridge_alloc() initializes the refcount value to be 1.
>>>>> - drm_bridge_add() gets an additional reference hence 2.
>>>>> - drm_bridge_attach() gets the third reference hence 3.
>>>>>
>>>>> This typical refcount value aligns with allbridges_show()'s behaviour=
.
>>>>> However, since encoder_bridges_show() uses
>>>>> drm_for_each_bridge_in_chain_scoped() to automatically get/put the
>>>>> bridge reference while iterating, a bogus reference is accidentally
>>>>> got when showing the wrong typical refcount value as 4 to users via
>>>>> debugfs.  Fix this by caching the refcount value returned from
>>>>> kref_read() while iterating and explicitly decreasing the cached
>>>>> refcount value by 1 before showing it to users.
>>>>
>>>> Good point, indeed the refcount shown by
>>>> <debugfs>/dri/<card>/encoder-0/bridges is by one unit higher than the =
one
>>>> shown in <debugfs>/dri/bridges. I understand it's puzzling from a debu=
gfs
>>>> user point of view.
>>>>
>>>> As you noticed, this is because the _scoped loop holds an extra ref on=
 the
>>>> current bridge.
>>>>
>>>> For other reasons I proposed a mutex for stronger protection around th=
e
>>>> bridge chain [v2]. With the mutex the extra ref is redundant, so in [v=
2]
>>>> the extra ref is removed, thus making your patch unneeded. However Max=
ime
>>>> asked to keep the extra ref, and so my latest iteration [v4] still has=
 the
>>>> extra ref.
>>>>
>>>> That series is still on the mailing list, we are still in time to redi=
scuss
>>>> it.
>>>>
>>>> @Maxime: based on the issue Liu is trying to work around, do you think=
 it
>>>> would make sense to go back to the initial approach for that series?
>>>> I.e. drm_for_each_bridge_in_chain_scoped() grabs the chain lock, which=
 is a
>>>> superset of the per-bridge refcount, and thus the refcount can be drop=
ped?
>>>> This would remove the debugfs issue, slightly simplify
>>>> drm_for_each_bridge_in_chain_scoped(), and introduce no new issues AFA=
IK.
>>>
>>> Just my take on the chain lock approach - I agree Maxime's comment on [=
v2]
>>> that keeping the get/put is a better than using the chain lock to ensur=
e
>>> the refcount is correct.  The chain lock could be added later on if nee=
ded.
>>
>> Well, no, adding the chain mutex is necessary(*), otherwise Thread A cou=
ld
>> iterate over the chain while thread B is adding/removing bridges to/from
>> the chain.
>>
>> And the chain mutex is a superset of the per-bridge refcount, so when
>> adding the mutex the refcount inside drm_for_each_bridge_in_chain_scoped=
()
>> becomes useless (and slightly hurting as it makes the refcount shown in
>> debugfs inconsistent, as you noticed).
>
> For better code readability, I think keeping the get/put is fine even if
> you add a lock

The [v4] code with the removal of the extra refcount would not be more
complex. It would be a bit less code (no need for the DEFINE_FREE and
__free()). Maybe it'd need an extra comment to clarify when the
drm_bridge_put() is called.

[v4] https://lore.kernel.org/all/20260113-drm-bridge-alloc-encoder-chain-mu=
tex-v4-4-60f3135adc45@bootlin.com/

> (maybe RCU list is better than mutex, since the chain is
> read often).  That follows the idea that you mentioned in [1]: "every
> pointer to a drm_bridge stored somewhere is a reference to a bridge".

That's true. However while it's an important pointer hygiene rule for
device drivers, for core code it's OK to deviate when there is a reason.

> Plus, seems no performance issue with the get/put, as discussed in [v2].

I confirm performance is surely not an issue here.

All that said, I'm OK with either option:

 * no ref taken when the mutex is added
 * ref taken when the mutex is added (as v4) + your patch to fix debugfs

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
