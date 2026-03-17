Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4838FF33809
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 08:15:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9225F10E55C;
	Tue, 17 Mar 2026 08:15:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="Tbd2EQFo";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6FED10E426
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 08:15:36 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 5486D4E4263E;
 Tue, 17 Mar 2026 08:15:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 205915FC9A;
 Tue, 17 Mar 2026 08:15:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E791D1045035D; Tue, 17 Mar 2026 09:15:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1773735334; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=/KvbmOvCMwXMd8Y01EHjxoYBy0bzMdwstlWWPIFixJA=;
 b=Tbd2EQFoFMYhFFfWZ/sYqS0VcPBZKEnCW6wHWcMHju+728aUy2k7q566VMarfvY1DF0eS9
 WlrOoxaN5f7ijKlWgZ0a6D0A3S6bnm+bYPphGVPxhmIibjDcZtvK/yw9wwTchgJzbIw5JN
 zs1FYosCa9sJuO/tjei56x2rM/uww8DWbKJovouATGzXALSDCGzebdx8QVtsZKjd/LidaN
 /VDYjiOkUECDLCpsaASXSRSQNqR4JjBaF4uXlkTcC1vkz6Ok5KLRUUD9CFoYWb+eLApHmV
 PY/CArMvOJlxJY1HJeAc9zPgjElr13dd5d7gtZ4+dYcn1T+kpN0EKZrDxgcPsg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 17 Mar 2026 09:15:31 +0100
Message-Id: <DH4WP68B4M0T.3LUVBC71NSA3N@bootlin.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
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
X-Mailer: aerc 0.20.1
References: <20260312-drm-misc-next-2026-03-05-fix-encoder-bridges-refcount-v1-1-b9ba3d844732@nxp.com>
 <DH45WF6QQX3X.3197SDA7BFY30@bootlin.com>
 <c5fd18be-9537-424c-9c65-48d67ecfe266@nxp.com>
In-Reply-To: <c5fd18be-9537-424c-9c65-48d67ecfe266@nxp.com>
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

On Tue Mar 17, 2026 at 3:35 AM CET, Liu Ying wrote:
> On Mon, Mar 16, 2026 at 12:15:29PM +0100, Luca Ceresoli wrote:
>> Hello Liu,
>
> Hello Luca,
>
>>
>> On Thu Mar 12, 2026 at 7:05 AM CET, Liu Ying wrote:
>>> A typical bridge refcount value is 3 after a bridge chain is formed:
>>> - devm_drm_bridge_alloc() initializes the refcount value to be 1.
>>> - drm_bridge_add() gets an additional reference hence 2.
>>> - drm_bridge_attach() gets the third reference hence 3.
>>>
>>> This typical refcount value aligns with allbridges_show()'s behaviour.
>>> However, since encoder_bridges_show() uses
>>> drm_for_each_bridge_in_chain_scoped() to automatically get/put the
>>> bridge reference while iterating, a bogus reference is accidentally
>>> got when showing the wrong typical refcount value as 4 to users via
>>> debugfs.  Fix this by caching the refcount value returned from
>>> kref_read() while iterating and explicitly decreasing the cached
>>> refcount value by 1 before showing it to users.
>>>
>>> Fixes: bd57048e4576 ("drm/bridge: use drm_for_each_bridge_in_chain_scop=
ed()")
>>> Signed-off-by: Liu Ying <victor.liu@nxp.com>
>>> ---
>>>  drivers/gpu/drm/drm_bridge.c | 32 ++++++++++++++++++++++++++------
>>>  1 file changed, 26 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.=
c
>>> index f8b0333a0a3b..84fc3cfd17e0 100644
>>> --- a/drivers/gpu/drm/drm_bridge.c
>>> +++ b/drivers/gpu/drm/drm_bridge.c
>>> @@ -1567,14 +1567,18 @@ void devm_drm_put_bridge(struct device *dev, st=
ruct drm_bridge *bridge)
>>>  }
>>>  EXPORT_SYMBOL(devm_drm_put_bridge);
>>>
>>> -static void drm_bridge_debugfs_show_bridge(struct drm_printer *p,
>>> -					   struct drm_bridge *bridge,
>>> -					   unsigned int idx,
>>> -					   bool lingering)
>>> +static void __drm_bridge_debugfs_show_bridge(struct drm_printer *p,
>>> +					     struct drm_bridge *bridge,
>>> +					     unsigned int idx,
>>> +					     bool lingering,
>>> +					     bool scoped)
>>>  {
>>> +	unsigned int refcount =3D kref_read(&bridge->refcount);
>>> +
>>>  	drm_printf(p, "bridge[%u]: %ps\n", idx, bridge->funcs);
>>>
>>> -	drm_printf(p, "\trefcount: %u%s\n", kref_read(&bridge->refcount),
>>> +	drm_printf(p, "\trefcount: %u%s\n",
>>> +		   scoped ? --refcount : refcount,
>>
>> I'd s/--refcount/refcount - 1/ here, no point in modifying the value whi=
le
>> printing it.
>
> Well, maybe there is a point if we consider 'scoped =3D=3D true', which m=
eans
> one reference should be dropped from the refcount.  In the future, if the
> refcount is used in this function multiple times, then we don't need to
> do 'refcount - 1' for each time with '--refcount'.  But, for now, since
> the refcount is just used for one time in this function, I'm fine with
> either '--refcount' or 'refcount - 1', please let me know your preference=
.

My preference is to not use the '--' operator. I tend to avoid it in
function/macros parameters because it can be tricky with macros, and I
admit I had to double check to find out drm_printf() is not a macro (but it
could become at some point).

So my preference is for 'refcount - 1'. Or, if you prefer, decrement just
after the assignment:

	unsigned int refcount =3D kref_read(&bridge->refcount);
+	refcount =3D scoped ? refcount - 1 : refcount;

But anyway this is a minor detail, go for whatever seems best to you.

>>> @@ -1599,6 +1603,22 @@ static void drm_bridge_debugfs_show_bridge(struc=
t drm_printer *p,
>>>  	drm_puts(p, "\n");
>>>  }
>>>
>>> +static void drm_bridge_debugfs_show_bridge(struct drm_printer *p,
>>> +					   struct drm_bridge *bridge,
>>> +					   unsigned int idx,
>>> +					   bool lingering)
>>> +{
>>> +	__drm_bridge_debugfs_show_bridge(p, bridge, idx, lingering, false);
>>> +}
>>> +
>>> +static void drm_bridge_debugfs_show_bridge_scoped(struct drm_printer *=
p,
>>> +						  struct drm_bridge *bridge,
>>> +						  unsigned int idx,
>>> +						  bool lingering)
>>> +{
>>> +	__drm_bridge_debugfs_show_bridge(p, bridge, idx, lingering, true);
>>> +}
>>
>> I think this should be much simpler and avoid a lot of the boilerplate
>> code: just add a 'bool scoped' argument to drm_bridge_debugfs_show_bridg=
e()
>> and pass true/false as applicable.
>
> Hm, I was thinking how to avoid the two bool arguments(lingering and
> scoped) for drm_bridge_debugfs_show_bridge(), because they make a functio=
n
> call look ugly - people have to go back to the function declaration to
> check which bool argument is which.  So, I came up with the boilerplate
> code, at least any function call has just one 'true' or 'false'.  I'm ope=
n
> to any better idea.  If you insist on adding a 'bool scoped' argument to
> drm_bridge_debugfs_show_bridge() is a good way to go, then I accept that
> and would follow - let me know your thoughts.

Here I really think adding a dozen lines of boilerplate code for such a
simple think is bad for maintainability/readability. The code is simple
enough that two bools (or 1 bool + an int offset) will be readable. If/when
the needs will become more complex, code can be made more sophisticated
accordingly.

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
