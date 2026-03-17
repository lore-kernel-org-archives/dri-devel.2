Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C2FFFED9EB
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 16:49:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E0E210E0D0;
	Tue, 17 Mar 2026 16:49:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dRpzC9Xf";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADA7B10E0D0
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 16:49:56 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4852f8ac7e9so70932195e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 09:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773766195; x=1774370995; darn=lists.freedesktop.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lgpjcbDB7G8Ltp9MmQbZQKZFro2nhljF0SDvfM2S37g=;
 b=dRpzC9XfWgeWUTAI43zYwnDKjzzmjWOggfgk0SSQJfm7IAuAklfJJY8q8wT2qdSma5
 lUucLDE4xLiCkSFS/6nLLKM3etdlYHNcmJIWpMnqAV+mBEZ3lcGNdGn7poYepPih/gZh
 rNMCx0YamZmFlN7hAhmn6Ycm5D6g5OimrZwGdbRTTGuyo2ccbdRYL1kbsmCzb5Wwwcw2
 QL2K5mzKL+GrLKt5ON4M/LzLULqupLot4PGPLmYN30V8Bvw5paPY+UO3cCnELKDov/FE
 H2juVQUwL5CqLB9QuKhHpf5RkpkLnhRQlJWu8Or2HDJNz+wZv8e90Ogn+CVRGIvwyPZx
 rqRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773766195; x=1774370995;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lgpjcbDB7G8Ltp9MmQbZQKZFro2nhljF0SDvfM2S37g=;
 b=fzTPujeKJBx8SlkTRhtV+9Hy0pb7qM+a6kITpqbNhOGuRxT3gKtrlTyMZzlv692PiJ
 0lDL32Q7PtZuiyNnroVSB2miEYejtUkp/zscqrGXhO8PH9SptLFvb5GtP612ux/UFg9C
 msa81DvwNfD/qkWpGgVN/1mB41FldKpI8s0MwPidKuHm0jXb/1wes7JQDbN2Ldt5HsJE
 g34ilDqcaQsaLprq1qDarPlpxjqCIlLkmPTcLpqiZZbeWAZHIHBCV2hw+DQKgbqJvkTZ
 e8oFDPwpyRfggi2h/yl2YdstlJQLaytv4/74Go+/5pEhwJxTpHqYEftJiRdwYq35aNII
 +KDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfuu1NiBxycYN7SAWaSdGCKSqKrrOhaXB/vXfXPSsI76gPELarSTaAcP2dm8/SB3mScK95DwGZbFc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxVcofNNUGGJs8Qta+TuZR8wLZfXS0hji69PsgiYTFiUz1+Nld2
 5E4vR8UJDFiX8TpVDKuz3MyRagxac/t0Ic/ubO/S/ZjWcQAK3qZvjwk7
X-Gm-Gg: ATEYQzyzFvQQUGdFno99vT9+ofLDj9p+mtJSPnITMAhh/GHzJqGv6O4jwhbBis+cgob
 LVYJ768029/zkZ/EVAHnJ5lT4jCHleNrm+V2fZtVy1rOrlORlYA5VMAXFh8zaEaAbDALlOE4Gea
 zW4Z96PSzPkJLW1Nzd+DtFXyuKxctFG2Ozu2yDQoPUs4kAnU65rmOcUKfzK/aOPoQi0qHt01ao7
 3eDs1ZJ2tZGOv1V/vl/v8yUQg3LPcKzmwMdsUzngwJKwxrT3KXrRlJizwVCmZOL3KcmkI7NujOB
 qbk2DBdloq+7ELSvBCCV5pBrU8gPPbtmVTp26pU2kPF1LP6HKYjSpBJHqsfhXVlztmbcG1ec9kf
 XEg1ipMEhptVNzoto8m3wK94xHHpcjKsVOvffJmHKqM5mC3wcGeCxm7upTzP+R4N4gkU2y4tnRj
 j4z2CnfifebF3kF1SUKDwSyM4KsBqUaF+kMl3qyAYNnpL86H6z3qLOvxEcB+K5nT0AuJz1M+InC
 SNCBwas0EPVUMCl7W//k2uJEZw=
X-Received: by 2002:a05:600c:4585:b0:483:709e:f238 with SMTP id
 5b1f17b1804b1-486f4479926mr3449905e9.29.1773766194877; 
 Tue, 17 Mar 2026 09:49:54 -0700 (PDT)
Received: from smtpclient.apple (static.253.36.98.91.clients.your-server.de.
 [91.98.36.253]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486f4623a26sm312025e9.7.2026.03.17.09.49.50
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 17 Mar 2026 09:49:54 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH v2] drm/bridge: dw-hdmi-qp: fix multi-channel audio output
From: Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <DH56X74P9GC9.1O123S92J60RG@bootlin.com>
Date: Tue, 17 Mar 2026 20:49:38 +0400
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Detlev Casanova <detlev.casanova@collabora.com>,
 Douglas Anderson <dianders@chromium.org>,
 Andy Yan <andy.yan@rock-chips.com>,
 Sugar Zhang <sugar.zhang@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <00EE3E21-F614-429B-ACB6-19AF64CF74B3@gmail.com>
References: <20260228112822.4056354-1-christianshewitt@gmail.com>
 <DH56X74P9GC9.1O123S92J60RG@bootlin.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: Apple Mail (2.3864.400.21)
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

> On 17 Mar 2026, at 8:16=E2=80=AFpm, Luca Ceresoli =
<luca.ceresoli@bootlin.com> wrote:
>=20
> Hello Christian,
>=20
> On Sat Feb 28, 2026 at 12:28 PM CET, Christian Hewitt wrote:
>> From: Jonas Karlman <jonas@kwiboo.se>
>>=20
>> Channel Allocation (PB4) and Level Shift Information (PB5) are
>> configured with values from PB1 and PB2 due to the wrong offset
>> being used. This results in missing audio channels or incorrect
>> speaker placement when playing multi-channel audio.
>>=20
>> Use the correct offset to fix multi-channel audio output.
>>=20
>> Fixes: fd0141d1a8a2 ("drm/bridge: synopsys: Add audio support for =
dw-hdmi-qp")
>> Reported-by: Christian Hewitt <christianshewitt@gmail.com>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
>> Reviewed-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>=20
> While applying this patch to drm-mics-fixes, checkpatch complains:
>=20
>  -:14: WARNING:BAD_REPORTED_BY_LINK: Reported-by: should be =
immediately followed by Closes: with a URL to the report
>=20
> You can send v3 with the link, or just reply with the link and I'll =
take
> care of adding it to the commit message.

Apologies, it looks like use of Reported-by was tightened since I last
used it, and there=E2=80=99s no official report anywhere I can link to =
(it was
all done in private channels) so better to just drop it from the v2 =
patch
if that=E2=80=99s possible? - if not I can send a v3 without it.

Christian=
