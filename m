Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA467606A321
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 15:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=pa1SkCau
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B91710EA4D;
	Wed, 11 Nov 2026 15:47:06 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2771B10EA4D
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 15:47:00 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 72B064E41408;
 Wed, 11 Nov 2026 15:46:58 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 247E86017E;
 Wed, 11 Nov 2026 15:46:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 7D2B111BC11DA; Wed, 11 Nov 2026 16:46:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1794412016; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=lObV9SJ3OT2Wgv/d4ibJqweN/ItK4qe1uoafBv25MSk=;
 b=pa1SkCauabOXsGW1QTvaCW47YI99lKCbofvAZexbKBnnfFh55KV3oxKqHEM9b8AaV+Uj+t
 5oody8gTTyaxGnhdmUoldPEwpFgdESY2nZO/y6RKKMI5PkmzgzYrrVhdSJ5ACbwB/tB3J5
 rIBNsTavzzzfCU6PazyuSxFAYXlN0Uv6yTQ/3iYgJYLR077mTxRL14irfC+co9k6O/byy0
 BiDzxMdfpGjZdykdxVzWOk23FzoRs1a0kkhGLwlFI3j70yLhOeUn8fzujGEweeU8yfscGU
 tFL/93qAg6YkvvjGyQpg2LPNapv51pcpxL8BbCV8cr23YQhRkfVDVZQzI7FKZg==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 11 Nov 2026 16:46:51 +0100
Message-Id: <DMSHYXQ01R6O.3F13LZ51TUPCP@bootlin.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH] drm/omap: dss: fix handling deferrals
Cc: <dri-devel@lists.freedesktop.org>, <linux-omap@vger.kernel.org>,
 <hns@goldelico.com>, <linux-kernel@vger.kernel.org>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Luca Ceresoli"
 <luca.ceresoli@bootlin.com>
To: "Tomi Valkeinen" <tomi.valkeinen@ideasonboard.com>, "Andreas Kemnade"
 <andreas@kemnade.info>
X-Mailer: aerc 0.22.0
References: <20261111-gta04-drm-regression-fix-v1-1-1de27d5ba46a@kemnade.info>
 <33f63eaf-42a0-4b3f-a21c-3752436d07b4@ideasonboard.com>
In-Reply-To: <33f63eaf-42a0-4b3f-a21c-3752436d07b4@ideasonboard.com>
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello Andreas,

On Wed Nov 11, 2026 at 3:56 PM CET, Tomi Valkeinen wrote:
> Hi,
>
> On 11/11/2026 14:22, Andreas Kemnade wrote:
>> Forward the error given by of_drm_get_bridge_by_endpoint() if it is
>> EPROBE_DEFER to ensure output gets initialized later when available.
>>
>> On GTA04/OMAP3 no display was found, but it appeared after doing
>> rmmod omapdrm ; modprobe omapdrm
>>
>> Fixes: b7e9b93fc8ecf ("drm/omap: dss: don't create a panel_bridge")

Ouch, sorry about breaking this driver. To my excuse the old code removed
by b7e9b93fc8ecf was (ans still is) pretty obscure.

>> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
>> ---
>>   drivers/gpu/drm/omapdrm/dss/output.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/omapdrm/dss/output.c b/drivers/gpu/drm/omap=
drm/dss/output.c
>> index 36d37deac8026..220ed7e003080 100644
>> --- a/drivers/gpu/drm/omapdrm/dss/output.c
>> +++ b/drivers/gpu/drm/omapdrm/dss/output.c
>> @@ -24,6 +24,11 @@ int omapdss_device_init_output(struct omap_dss_device=
 *out,
>>
>>   	bridge =3D of_drm_get_bridge_by_endpoint(out->dev->of_node, out->of_p=
ort, 0);
>>   	if (IS_ERR(bridge)) {
>> +		if (PTR_ERR(bridge) =3D=3D -EPROBE_DEFER) {
>> +			ret =3D PTR_ERR(bridge);
>> +			goto error;
>> +		}
>> +
> Shouldn't we just return PTR_ERR(bridge) here? The error label will call
> omapdss_device_cleanup_output(), which cleans up things set up later in
> this function.

Indeed.


Additionally, by looking at the omapdss_device_init_output() code right
now, the goto-based error management appears:

 1. unnecessarily complicated: only one goto for only one line of rollback
    code

 2. potentially wrong, or at least doing too much, because
    omapdss_device_cleanup_output() does two things:

      a. drm_bridge_put(out->next_bridge): but when goto is invoked the
         out->next_bridge pointer has not been touched yet
         (I assume we should not touch the refcount in this case)

      b. drm_bridge_put(out->bridge): unneeded because the goto is inside
         an 'if (!out->bridge)', thus there is no reference at all to put

Do you agree with these findings?

If you do, I guess this simple patch should fix both at once (untested):

---------------------------------8<---------------------------------
@@ -31,20 +31,14 @@ int omapdss_device_init_output(struct omap_dss_device *=
out,
        out->bridge =3D bridge;

        if (local_bridge) {
-               if (!out->bridge) {
-                       ret =3D -EPROBE_DEFER;
-                       goto error;
-               }
+               if (!out->bridge)
+                       return -EPROBE_DEFER;

                out->next_bridge =3D out->bridge;
                out->bridge =3D drm_bridge_get(local_bridge);
        }

        return 0;
-
-error:
-       omapdss_device_cleanup_output(out);
-       return ret;
 }
---------------------------------8<---------------------------------

Can you double check this, test on hardware and if it looks correct send
that as a separate patch?

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
