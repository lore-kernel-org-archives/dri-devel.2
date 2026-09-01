Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8673FC61DD6
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 15:50:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDB4410E0D0;
	Tue,  1 Sep 2026 15:50:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Dab5XZTe";
	dkim-atps=neutral
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com
 [209.85.208.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1A6410E0D0
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 15:50:49 +0000 (UTC)
Received: by mail-lj1-f172.google.com with SMTP id
 38308e7fff4ca-3a2b4743936so8446051fa.0
 for <dri-devel@lists.freedesktop.org>; Tue, 01 Sep 2026 08:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788277848; x=1788882648; darn=lists.freedesktop.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:content-type:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=sIycX/93dP8h/wj5U80nNU52ZrbLgXUgk65pU9prnfM=;
 b=Dab5XZTe9cRb0mILFjZq99cSeDpXKbWrdsTabeLiabABBniQ/jhdHrF5M13dubLR1F
 J3LV3xrwtrX7PDhudW78VMDaYWhwlukMyoBt9iCgmOV0FKGzy56RlzFLBa2C2+rXDrjz
 xw7MfZ3NDC/0v+cGegszqpq5OIGkSFBJ2K6eukjCRz7DtdhmIh/iFbNsXK8q+PJz2dU5
 oAA0/uUwK2sOGibBE0wJj5RT1wuhmraNkiOMv5etz/+cEKFA4DZDjc7Gf7IHBdRSKqpm
 SuJk9cKrSTWxREVR5DpWfkowJLZH1MG5Kk2x2fWv5W7wcV5+ZGEGDDbH1edHC5u8wYCV
 Cjvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788277848; x=1788882648;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sIycX/93dP8h/wj5U80nNU52ZrbLgXUgk65pU9prnfM=;
 b=CloON63NOE9SmiHxrRG/5IDzeFA+uYlk7LKxmtlaP2Kn/mdhRIMN+UE7xLQaTPcGKo
 s2esGQECIXuveearJfMhwbDW05QytRn9vQnwY7C+3nh8FujkyK4OgKDU0OIlzlSthKyj
 snG/DWZtSB36D/XwH3MEuy6PUkWPBbeW6fIWqfqM8qUTnE+K0z2gNO3McFIhj55F/Y2N
 Zbxs0nxYmyhP0LgMQpavSNmkR8Vx3lIR1duOe0eT7REjBINapc5kOB7+oUzVkGCUwy1J
 VaTNDM+wXZ9MqXvKSz5rdveT0hdP/uh6UUvTMLG3qdp0u0M+g3vqKwP7SekLAt4ldRA5
 bNPg==
X-Forwarded-Encrypted: i=1;
 AKwUvBysARONalxrXeMJ8DBXiJqzrSB1z3gswQYauUssgqXqR5YrDsQdNZa9O84LIqeNTEy+yJP7e6YaiNE=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mCrtYIY+KBKanPczjQS9TuYtjAtY+YGe+n/hcoBXuDxyYAxHJl
 KgYF+vw8fMreZaFqSj/LBxqWhzH45zQTPDvt30RugzlI1vKjTtBZChUD
X-Gm-Gg: AYBFou0lvaiq2ENlvXFhIz7FrEw6qFwEGbSuxOU32F2e+kFnKuEKTzWfLogyNHoJG+Y
 aIzOQmhGSw4DtxgqcYIv2kw4Yl6et10OgMzAGe42MKg4vDJ2wAOXqb0A6xQvf+E4rlYDeo80aRC
 pxwqfDji7DYDdaXmruPQXK2ScC60VJy2B/Qq6icTj1bRrIL9UsYpObuSrgUJ5d6ja6VLcNWgbWR
 57sDGJmzR7HqenK85J9uSW04BcjqVktrQ6yUHiqjAGDdzvnhwrahezwPSUaADAE0SFiEaP0Dvcq
 rgSyoNYMk8uRGfDKveQS6eGRgtwcogVAC3RmLcvofA0xc0GzrZZZl4Z/AjzR2WbSQs01F+14Vs5
 Pp8SfIwxCjp4uesRPATia812ioVH5N8eAonPRh3gYgpl0PAAf2rPmnmi5sOLNRkNvUAFyAOFsJw
 8oavQUDBUSsSKSFdIUvMZa9/N/506X6y7E9cXUUAPKv3QxTVdf1yUHj8T4ZbEOoz8s1wVJuB3Fx
 FLhxe9U1rIIHROTkg==
X-Received: by 2002:a05:651c:2117:b0:3a3:4526:e8f4 with SMTP id
 38308e7fff4ca-3a345270387mr8689181fa.6.1788277847338; 
 Tue, 01 Sep 2026 08:50:47 -0700 (PDT)
Received: from smtpclient.apple ([87.200.95.144])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a34ad010efsm326091fa.21.2026.09.01.08.50.42
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 01 Sep 2026 08:50:46 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH] drm/bridge: dw-hdmi-qp: Compute ACR CTS for unlisted TMDS
 rates
From: Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <apbgp2h_tSZQzbdV@venus>
Date: Tue, 1 Sep 2026 19:50:28 +0400
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Daniel Stone <daniel@fooishbar.org>,
 Detlev Casanova <detlev.casanova@collabora.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Douglas Anderson <dianders@chromium.org>,
 Andy Yan <andy.yan@rock-chips.com>,
 Sugar Zhang <sugar.zhang@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <1035B0DB-D4B0-4E24-A23B-48854B49A3FA@gmail.com>
References: <20260901112541.84588-1-christianshewitt@gmail.com>
 <apbgp2h_tSZQzbdV@venus>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: Apple Mail (2.3864.600.51.1.1)
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

> On 1 Sep 2026, at 6:28=E2=80=AFpm, Sebastian Reichel =
<sebastian.reichel@collabora.com> wrote:
>=20
> Hi,
>=20
> On Tue, Sep 01, 2026 at 11:25:41AM +0000, Christian Hewitt wrote:
>> common_tmds_cts_table[] holds only six TMDS character rates (25.175,
>> 25.2, 27, 54, 74.25 and 148.5 MHz), so dw_hdmi_qp_find_cts() returns =
0
>> for everything else. dw_hdmi_qp_set_cts_n() then clears the CTS =
override
>> enable and programs a value of 0, leaving the sink with no CTS to
>> regenerate the audio clock from.
>>=20
>> Any deep colour link falls into this gap: a 10 bpc RK3576 HDMI output
>> runs at 185625000 Hz (148.5 MHz * 1.25), which is absent from both
>> tables. N is computed dynamically and comes out correct at 6144, but
>> AUDPKT_ACR_CONTROL1 reads back as 0.
>>=20
>> Give CTS the same dynamic fallback that N already has, using the =
formula
>> from the Audio chapter of the HDMI specification, and drop the =
-ENOENT
>> returned into an unsigned int for the unlisted sample rates.
>>=20
>> Fixes: fd0141d1a8a2a ("drm/bridge: synopsys: Add audio support for =
dw-hdmi-qp")
>> Assisted-by: Claude:claude-opus-5
>> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
>> ---
>> This was found after testing unrelated patches from DetlevC that =
rename
>> the RK audio cards to see the impact in Kodi. RK3588 had audio =
output,
>> while RK3576 did not. I'd not used an RK3576 board for a while so =
tasked
>> Claude to help triage the problem, and this was the finding. The =
problem
>> appears to have been exposed since Kodi reworked plane selection =
logic
>> and support for 10bpc planes; earlier Kodi/LibreELEC images were =
using
>> 8bpc planes thus avoiding the problem.
>=20
> You are looking for this series:
>=20
> =
https://lore.kernel.org/linux-rockchip/86fcf349-0a7a-4618-9001-612371b0f71=
b@symple.nz/

Ahh, I missed that. I have now tested that patch (and will reply
to it with a TB) so please ignore this patch. Thanks!

Christian

