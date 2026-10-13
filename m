Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17125CC6B12
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 15:56:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5149010E8BC;
	Tue, 13 Oct 2026 15:56:47 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D096B10E8BC
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 15:56:40 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 181871A1214;
 Tue, 13 Oct 2026 15:56:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id D32E260362;
 Tue, 13 Oct 2026 15:56:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 33C6C11D717F3; 
 Tue, 13 Oct 2026 17:56:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1791906994; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=354zwLB4JSBzC6TqObl0kjMSQwxU/dQftIBcAR5WAQs=;
 b=SR51IdX+cqmSpy3ZmcfhTl/74buqACNKiOJK198dtlEBesTTLuXjG9o58dHpHqnBGPvkfm
 eGWOh3LMmAY6smt4dhYTbcMtALArKqPWOH8c/zl3wZzHsip9rXzCZtPeWIm7icU8a8vquN
 90ZVVtgKn2vrn1P+gLHiSKsXcljOhNgBrc5PVtUlkCp8JesuFbnwGOcrjkbOLZyJBUGe2y
 coPQtg34PjcJvyrlR8l81++Wgc6aT+1bjQs2TE/HiG1r2bhOj/Wv6t1oTCqnU8v4Od6lxb
 MnZiHT/O4KZ29UGlNM/gZNzrIo7n/2etAh1fGT+jaAjexb4XhyFTPsJJcrXvyQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 Oct 2026 17:56:32 +0200
Message-Id: <DM3U0JWSFAS4.2J8MSWTKYBDBN@bootlin.com>
Subject: Re: [PATCH v3 2/3] drm/vc4: dsi: stop using deprecated
 drmm_of_get_bridge()
Cc: <dri-devel@lists.freedesktop.org>
To: <sashiko-reviews@lists.linux.dev>, "Luca Ceresoli"
 <luca.ceresoli@bootlin.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.22.0
References: <20261013-drm-fix-of_get_bridge-build-regression-v3-0-0b4c0b65be82@bootlin.com>
 <20261013-drm-fix-of_get_bridge-build-regression-v3-2-0b4c0b65be82@bootlin.com>
 <sashiko-outbox-170020@kernel.org>
In-Reply-To: <sashiko-outbox-170020@kernel.org>
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

On Tue Oct 13, 2026 at 5:35 PM CEST, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] drm/vc4: reference leak of next_bridge on component unbind/reb=
ind
> --
>
> commit 01a94378aeae8cb42a9f68ed6384a34ccaa162a0
> Author: Luca Ceresoli <luca.ceresoli@bootlin.com>
>
> drm/vc4: dsi: stop using deprecated drmm_of_get_bridge()
>
> drmm_of_get_bridge() is deprecated, switch to
> of_drm_get_bridge_by_endpoint(). As of_drm_get_bridge_by_endpoint() retur=
ns
> a refcounted bridge, ensure it is put by using bridge.next_bridge.
>
>> diff --git a/drivers/gpu/drm/vc4/vc4_dsi.c b/drivers/gpu/drm/vc4/vc4_dsi=
.c
>> index 0148f2befed14..675bd0fc13913 100644
>> --- a/drivers/gpu/drm/vc4/vc4_dsi.c
>> +++ b/drivers/gpu/drm/vc4/vc4_dsi.c
> [ ... ]
>> @@ -1775,9 +1774,13 @@ static int vc4_dsi_bind(struct device *dev, struc=
t device *master, void *data)
>>  	if (ret)
>>  		return ret;
>>
>> +	dsi->bridge.next_bridge =3D drm_bridge_get(next_bridge);
>> +
>
> [Severity: Medium]
> Does this code introduce a regression that leaks the bridge reference acr=
oss
> component unbind/rebind cycles?
>
> During component unbind, vc4_dsi_release_action() only drops the referenc=
e
> to dsi->bridge acquired during bind:
>
> static void vc4_dsi_release_action(struct drm_device *drm, void *ptr)
> {
> 	struct vc4_dsi *dsi =3D ptr;
>
> 	drm_bridge_put(&dsi->bridge);
> }
>
> Because dsi->bridge outlives the component unbind, __drm_bridge_free() is
> not executed, and the reference to next_bridge is not automatically relea=
sed.
>
> When the component is subsequently rebound, vc4_dsi_bind() overwrites
> dsi->bridge.next_bridge here without freeing the previous pointer,
> permanently leaking the bridge reference. Does next_bridge need to be
> explicitly cleared in the teardown path?

Ah, right. I'm fixing this in v4 by calling
drm_bridge_clear_and_put(&dsi->bridge.next_bridge).

Not sure adding it to vc4_dsi_release_action() would be correct in case of
unbind/rebind, so I'm probably adding a new vc4_dsi_unbind() for that.

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
