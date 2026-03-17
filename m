Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C77A1FED9EF
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 17:36:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2879310E579;
	Tue, 17 Mar 2026 17:36:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="0FrSobcS";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A13A610E579
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 17:36:08 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 526414E426D5;
 Tue, 17 Mar 2026 17:36:07 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 0AF965FC9A;
 Tue, 17 Mar 2026 17:36:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id A92BD1045065D; Tue, 17 Mar 2026 18:35:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1773768965; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=jpsLJn4w7neAQsnq1JuiayRZw0qDoeOk/wH87a8LDpY=;
 b=0FrSobcSxum9vt1AIfUY5FnLi/zPcxY6DTWX7PMLG25gqnT6Ea+Pdp7Jb/VY5KvywAAcgm
 4/JkHrHrU9v8jw1+h2OWqusK5R1j0hCRseQJlKMG3E4E6y//QN9Od8WSOdVK1lmMrt2hIn
 ABsGxuCGGDBSGmFrMhXZ5bCbgeLtJrqJeijIEQ+LT3QMeHZXEnJjoFYgBdQkkxwoAXxonS
 lE87RrmAvA+pIBxCp1bku2ZmOUl8TtgwiA8u4n2p8Gjm43NGDq7kKPyabbszqJiYvpbVnj
 lCwurXWGVNwJN4XKEnMt9Oy7FxXSTn6+piM3Z38PUfdpjpQf+F6L7s8NWgGLDQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 17 Mar 2026 18:35:58 +0100
Message-Id: <DH58MAETGDMM.2QS6VJDQ7UXIV@bootlin.com>
Subject: Re: [PATCH v2] drm/bridge: dw-hdmi-qp: fix multi-channel audio output
Cc: "Andrzej Hajda" <andrzej.hajda@intel.com>, "Neil Armstrong"
 <neil.armstrong@linaro.org>, "Robert Foss" <rfoss@kernel.org>, "Laurent
 Pinchart" <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman"
 <jonas@kwiboo.se>, "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Dmitry
 Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>, "Cristian Ciocaltea"
 <cristian.ciocaltea@collabora.com>, "Detlev Casanova"
 <detlev.casanova@collabora.com>, "Douglas Anderson"
 <dianders@chromium.org>, "Andy Yan" <andy.yan@rock-chips.com>, "Sugar
 Zhang" <sugar.zhang@rock-chips.com>, "Heiko Stuebner" <heiko@sntech.de>,
 <dri-devel@lists.freedesktop.org>, <linux-rockchip@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>
To: "Christian Hewitt" <christianshewitt@gmail.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.20.1
References: <20260228112822.4056354-1-christianshewitt@gmail.com>
 <DH56X74P9GC9.1O123S92J60RG@bootlin.com>
 <00EE3E21-F614-429B-ACB6-19AF64CF74B3@gmail.com>
In-Reply-To: <00EE3E21-F614-429B-ACB6-19AF64CF74B3@gmail.com>
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

Hello Christian, Cristian, Jonas,

On Tue Mar 17, 2026 at 5:49 PM CET, Christian Hewitt wrote:
>> On 17 Mar 2026, at 8:16=E2=80=AFpm, Luca Ceresoli <luca.ceresoli@bootlin=
.com> wrote:
>>
>> Hello Christian,
>>
>> On Sat Feb 28, 2026 at 12:28 PM CET, Christian Hewitt wrote:
>>> From: Jonas Karlman <jonas@kwiboo.se>
>>>
>>> Channel Allocation (PB4) and Level Shift Information (PB5) are
>>> configured with values from PB1 and PB2 due to the wrong offset
>>> being used. This results in missing audio channels or incorrect
>>> speaker placement when playing multi-channel audio.
>>>
>>> Use the correct offset to fix multi-channel audio output.
>>>
>>> Fixes: fd0141d1a8a2 ("drm/bridge: synopsys: Add audio support for dw-hd=
mi-qp")
>>> Reported-by: Christian Hewitt <christianshewitt@gmail.com>
>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
>>> Reviewed-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>>
>> While applying this patch to drm-mics-fixes, checkpatch complains:
>>
>>  -:14: WARNING:BAD_REPORTED_BY_LINK: Reported-by: should be immediately =
followed by Closes: with a URL to the report
>>
>> You can send v3 with the link, or just reply with the link and I'll take
>> care of adding it to the commit message.
>
> Apologies, it looks like use of Reported-by was tightened since I last
> used it, and there=E2=80=99s no official report anywhere I can link to (i=
t was
> all done in private channels) so better to just drop it from the v2 patch
> if that=E2=80=99s possible? - if not I can send a v3 without it.

Thanks for the quick feedback.

I applied keeping the commit message as is. In lack of a public discussion
I guess the 'Reported-by' is somewhat informative anyway. I read the
checkpatch as a general suggestion, not a hard rule.

So now this patch is on drm-misc-fixes, but drm-misc-fixes and
drm-misc-next are now conflicting because of other changes by Cristian
Ciocaltea applied in the meanwhile to drm-misc-next, and particularly
commit 3ea699b56d31 ("drm/bridge: dw-hdmi-qp: Rework Audio InfoFrame
handler").

Cristian, Christian (heh), Jonas, could you please check whether the code
on drm-misc-next has or not the bug that is fixed here? And if it still
has, send a fix based on current drm-misc-next?

Thanks!

Best regards,
Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
