Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85D47C4452D
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 08:06:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D785010ECB5;
	Wed, 22 Jul 2026 08:06:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=flipper.net header.i=@flipper.net header.b="cjvPkvFn";
	dkim-atps=neutral
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com
 [209.85.218.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CBD610ECB5
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 08:06:44 +0000 (UTC)
Received: by mail-ej1-f41.google.com with SMTP id
 a640c23a62f3a-c1601d552a8so1292547066b.2
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 01:06:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784707602; cv=none;
 d=google.com; s=arc-20260327;
 b=bS163etoddaAIu9CjKiiPv/pCDB9S+JLQhItGeyz1dXqWcg8dx2pMoGiiowLF5s0d1
 b7yPk5a28am6P7mbTV+Y+R+8bzFejRvUF1v2eexEdcQAAuvJDxIsk6P3G/VUDQBW+TsP
 nDZYuwtBYLyZwulhvBEkWwykUbVyDNkVVCS2bItPtP3jQ7eHVRlTYFGTxNBAghzoZdnW
 +YyGKRMcozdWCy7Ozqc0dWcyRkyP0km5Tyx5E64Rly0svordZdNbhTX8jNDPbYyzdn8u
 w8fk6x8gxYq25clQq4UKud1UbHLBIIHc3cB5PWdgHytDLxeFEf7imalKx4sRjs54XSSO
 kvgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=dNnBgtMvRWoIDKMpvV9eibQpg+sWb3zuYV0OsS+F7RY=;
 fh=jzD9kzT2VSOtlV9IPRlRA4IvTT4UArnJCpk42x/i6bQ=;
 b=hHOeamFsyHCwYHRYYH07iDBOflweWHvlyDreqS9QD19G+x/rXJW5SXxuHg+FmlQbyj
 a0rhWzadV9xUh0ckFBEjDbJ25LRK0BIEc/TVAF6vSxccpk3C2CAKaYvqTe2JwD5Pt+ei
 ThyWxAR2Ly+Xqwtou4YcBWk8S7b1z65+6N5CSD3g+l/T4+97bp7BRiBoG4sitCOkUI3x
 /OXBmAHAZHlg6i0PsyMJ4mQ/ts7ZeIjfSVwdBdx/DcH8R3TfkfeIjq+oinLPlWv7xV9R
 D11uMGF61bp40tXFE45scG9nXrP8VI04kNZa//BLa8sfb3MYGKqOhJWbctWnbdhZ/zrf
 2FnA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1784707602; x=1785312402; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dNnBgtMvRWoIDKMpvV9eibQpg+sWb3zuYV0OsS+F7RY=;
 b=cjvPkvFnnWjofWYLLIHuQb0waOcPwlGrLUWvF0G3v8uMkcuW+gGI/1yPAK7Th3tZCj
 3KtKxXLvhBCB388oDxsy8CXZKuo0yfbQHfOVZDnqSVvVUu0+zNMYx3wL/KGK6zg5YW4a
 j3Jm2b7aKP7NlZWdkbmcVneL9VGarARZNfE/hTbl8Imqn5hQAgacG2W5DTvNM8geP4A9
 n8jwXB4QdExEaz7NpLGVQs57FRkV0R0W6+zEjvWOqeB5ioIlme8uEqqilK0uC0UuYs4L
 qvsHtmzfmRfaYfl0E6Pv7vuCBStBYTbEEzULNPLtSOL1x1oVPiMQqaPquGzLH4R4Ogyf
 mBeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784707602; x=1785312402;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dNnBgtMvRWoIDKMpvV9eibQpg+sWb3zuYV0OsS+F7RY=;
 b=o/q2pvR+Bmng/SDqUyscJy1dBXZricFJfoRiTybi2DJlWkYYMAQTvEDfqtToxkSlVS
 LotfcqcHT071pXybT+hnPMI3xbV8V6mmE5dXbQnjPVdXmm8oH8RzT0wzvpF0FTjBa0O6
 VIVFuYZ9UDKAXpwesayYzs8czdElfPi1e1Xy/nqGpt7RJNMfcdIzVU/mT8utIXLQjpil
 dtsGaonEPnlCruXmrhK4nTLcxNhqEjn1zu06QmhR8xxxUUSTYvltX2+n+OWhsv+UkxBY
 plbTSHiRtviDj3eTxdccYrmLtD1VwlDosl179g2VpsLe5HkbfpTdw7CjIBJyxcL6WMHV
 Hzig==
X-Forwarded-Encrypted: i=1;
 AHgh+RqDqwkMTOf/O/mwZI3ms7cckbdGFK8AnnXGAq3qelUNGMU0or3ebK+7Sp1f1Kn4hheVhzr1qf20Gns=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwI+6vilmgPOrmbVJHYZkZSxK378z+qURPhkHBTQw7XvsoYYfvu
 F1eVvdyx/JdPg+7N7ZaWLVdlRCnJ69wOoRjvrV3g6V11+026IN+0/jiWoj/+wxEyG2tboFKh77M
 0yTf91kaj0WII8JjCp9Loi1ZpErLemsWgr3IDxT/Tbg==
X-Gm-Gg: AR+sD13gzrluoaIRyuu9WVypSM6tSShmC8dk8Gwi6OOL2IGVBUguOUbVgYDmCn5rjCi
 7FLJVq2HDGfgcPeUtW774YyVLuXxguDuB98aB4WgAEV10PgkVN6rqmMuHvnAutvgHFjJMQY1vnz
 WxWCKUaHGSH3HgjkjtNgjcjXXZZ1p/mzJ48vrodOoSQ1A+sAKbcuHMiforA5J8tGz/YuqmXgvso
 RN/jd6jxLOIbcxe+j2lxzSXGV2CSBBdRh3mlUs+0cWdgOP6xN5cNF8QoYkA6CtdhJ6SHBYpQVZR
 Wxp4hTjfCl4i8QInNr6BSFPJKt9j
X-Received: by 2002:a17:907:72cd:b0:c16:3187:997e with SMTP id
 a640c23a62f3a-c16b46ade61mr848716466b.7.1784707602465; Wed, 22 Jul 2026
 01:06:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260721-synopsys-dw-dp-improvements-v4-0-f0f4a4ede712@collabora.com>
 <20260721-synopsys-dw-dp-improvements-v4-10-f0f4a4ede712@collabora.com>
In-Reply-To: <20260721-synopsys-dw-dp-improvements-v4-10-f0f4a4ede712@collabora.com>
From: Alexey Charkov <alchark@flipper.net>
Date: Wed, 22 Jul 2026 12:06:33 +0400
X-Gm-Features: AUfX_mzBw-mJbEQ5WnpY1t4r4yErUbUBJRWK9UICtFzIcvZnEWvrXDi7mlfnRTM
Message-ID: <CAKTNdwE6OOPHYpMQXYfWPtdA26AiPJjSi6N_J-yGSU0mSL7HSg@mail.gmail.com>
Subject: Re: [PATCH v4 10/10] drm/bridge: synopsys: dw-dp: Add audio support
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>,
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Damon Ding <damon.ding@rock-chips.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, dri-devel@lists.freedesktop.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, kernel@collabora.com, 
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Sebastian,

On Tue, Jul 21, 2026 at 9:52=E2=80=AFPM Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
>
> Implement audio support for the Synopsys DesignWare DisplayPort
> controller.
>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  drivers/gpu/drm/bridge/synopsys/dw-dp.c | 230 ++++++++++++++++++++++++++=
+++++-
>  1 file changed, 229 insertions(+), 1 deletion(-)

Thanks for your work on this!

Quick question. It looks like the audio-related change along with the
DT binding update is independent of the hotplug/PM part, and shouldn't
really depend on the (large!) USBDP PHY changes. Would it be possible
to split it out as a separate mini-series, so that the whole thing
doesn't have to wait for the fate of the USBDP PHY series?

Best regards,
Alexey
