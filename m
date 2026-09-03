Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAA65C624A4
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 13:43:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E4B010F5EC;
	Thu,  3 Sep 2026 13:43:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="k7V11AWO";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8354210F5CF
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 13:43:16 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 198F84E414E5;
 Thu,  3 Sep 2026 13:43:15 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id C2F6C602B8;
 Thu,  3 Sep 2026 13:43:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 7BE3D11C7A01D; 
 Thu,  3 Sep 2026 15:42:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1788442989; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=ZurAKKCu2FRtuzkbbixd8DBWFCJp9qT4g/V/S8l5AhM=;
 b=k7V11AWOe8QeWbabRKC0jiVuby0MYr8K3IeyjIBqJt6H/AXan9AlQ0xxrYHKEYzisACsHx
 73n1Vs5V4HrWEgN1ilVnchWPUUP9OmrnDm3hRc+xDHvnDxsNPtsn1hfiW7YvqNexaQ+Vxg
 d1Yu767DXFfmUEBOdsJQuQlE4ZskSKo+cyYOQsDUaQz/OWsA7feSIQ4zK+tJ6gcyxRZ/9G
 Bx+XNXaMOjmfn75iIliHUZGsspWm2VpusMwYpLx6FPIlOL5HrWUJWCSOaAn4rpnyxwLG7U
 jsAw4nFdJ6q7hwYlTsIo91xdq7L5J/rtnOBamEyM/58rmp6NKWe/Y/Qufd1fEA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 03 Sep 2026 15:42:57 +0200
Message-Id: <DL5Q4HIVN3Z2.2A35BDU06T6MA@bootlin.com>
Subject: Re: [PATCH RFC v2 01/19] drm: of: move
 drm_of_find_panel_or_bridge() from drm_of.c to bridge/panel.c
Cc: "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Thomas
 Zimmermann" <tzimmermann@suse.de>, "David Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>, "Andrzej Hajda"
 <andrzej.hajda@intel.com>, "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Robert Foss" <rfoss@kernel.org>, "Laurent Pinchart"
 <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman" <jonas@kwiboo.se>,
 "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Jessica Zhang"
 <jesszhan0024@gmail.com>, "Linus Walleij" <linusw@kernel.org>, "Inki Dae"
 <inki.dae@samsung.com>, "Jagan Teki" <jagan@amarulasolutions.com>, "Marek
 Szyprowski" <m.szyprowski@samsung.com>, "Albert Esteve"
 <aesteve@redhat.com>, "Anusha Srivatsa" <asrivats@redhat.com>, "Dmitry
 Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>, "Hui Pu"
 <Hui.Pu@gehealthcare.com>, "Ian Ray" <ian.ray@gehealthcare.com>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
To: "Maxime Ripard" <mripard@kernel.org>, "Luca Ceresoli"
 <luca.ceresoli@bootlin.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.22.0
References: <20260903-drm-bridge-every-panel-v2-0-2ab8ee24538e@bootlin.com>
 <20260903-drm-bridge-every-panel-v2-1-2ab8ee24538e@bootlin.com>
 <aplCttfyxmPhToUq@houat>
In-Reply-To: <aplCttfyxmPhToUq@houat>
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

Hi,

On Thu Sep 3, 2026 at 11:51 AM CEST, Maxime Ripard wrote:
> Hi,
>
> On Thu, Sep 03, 2026 at 10:11:04AM +0200, Luca Ceresoli wrote:
>> We want to move drm_panel.o from the main drm module to a new drm_panel
>> module, but there is one function in the drm module that calls into
>> drm_panel.c code:
>>
>>   drm_of_find_panel_or_bridge() (in drm_of.c, drm module)
>>      -> calls of_drm_find_panel (in drm_panel.c, would-be the new drm_pa=
nel module)
>>
>> Avoid this issue by moving drm_of_find_panel_or_bridge() to bridge/panel=
.c
>> (which is currently in the drm_kms_helper module).
>>
>> As a result drm_kms_helper will depend on the new drm_panel module, whic=
h
>> is fine because there is no dependency of drm_panel on drm_kms_helper.
>>
>> After this change, all drivers using drm_of_find_panel_or_bridge() will
>> have to select DRM_PANEL_BRIDGE (and DRM_PANEL, recursively). Add that f=
or
>> affected drivers. While there, also add DRM_PANEL on drivers selecting
>> DRM_PANEL_BRIDGE.
>>
>> No functional changes, just moving code around.
>>
>> [AI used to add 'select DRM_PANEL[_BRIDGE]' for affected drivers]
>> Assisted-by: opencode:deepseek-v4-flash-0731
>> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
>
> In the previous discussion, I suggested to move it to drm_panel.c
> because it's not really related to the panel_bridge stuff, like, at all.
> And both drm_panel.c and drm_bridge.c are in drm.ko at this point so you
> shouldn't have any issue there.

I had this other implementation done already, and I wanted to have patch 5
out ASAP so I sent as is.

I don't care much about where drm_of_find_panel_or_bridge() is moved and
the discussion about where it's more fitting, because it should just
disappear eventually anyway, hopefully soon.

I will try your idea in v3.

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
