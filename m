Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC79DC79FB5
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 06:56:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30E0410EF59;
	Wed,  9 Sep 2026 06:55:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=dawidwrobel.com header.i=@dawidwrobel.com header.b="gKmhUhza";
	dkim-atps=neutral
Received: from mail-244103.protonmail.ch (mail-244103.protonmail.ch
 [109.224.244.103])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3C1B10ECF4
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 16:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dawidwrobel.com;
 s=protonmail2; t=1788883448; x=1789142648;
 bh=ZklINIGdqQH8GrDGYUn9b0Zuk3laMH2xgV5+Sg6qzoY=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=gKmhUhzauMbA7JQgu27gRNlnQOeTP3+hC4OdjaAmWHh9e4RgKANgXUnjIxPEmVuFJ
 7ij4iEldTMfDKckH4RgVoCWXGcr3m6h5uIcpPmfhuFYlJJgGSbEI/nifImuAwRDqpg
 Tm9vOjBH3ZP8HwrTzelhE8edPefV5NByF08QDp3DhX0xgauuzsMO3/GB4tk/06dizL
 XjBjafmsrvQe+t6zNVHJFclOM0rmiHSU9Y4oXRY/nk1shA0nukWLjydkEicMyUH6z7
 56CAooONG53zoV2VHiMqxBYGEqpDIRfl6PZ6arfpibEgLOvkIzAy8q0lBndFrRxlxn
 At/tmTJV5rO0Q==
Date: Tue, 08 Sep 2026 16:04:03 +0000
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Jianhua Lu <lujianhua000@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
From: Dawid Wrobel <me@dawidwrobel.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 4/4] arm64: dts: qcom: sm8250: add device tree for the
 Xiaomi Mi Pad 5 Pro 5G
Message-ID: <dc0759da-5783-4800-bdf1-9ddca0f2c851@dawidwrobel.com>
In-Reply-To: <1cdfb3e1-8a89-4b52-a5db-0359a9f68878@oss.qualcomm.com>
References: <20260730-sm8250-xiaomi-enuma-v1-0-ed6d8fb99668@dawidwrobel.com>
 <20260730-sm8250-xiaomi-enuma-v1-4-ed6d8fb99668@dawidwrobel.com>
 <1cdfb3e1-8a89-4b52-a5db-0359a9f68878@oss.qualcomm.com>
Feedback-ID: 173987960:user:proton
X-Pm-Message-ID: d5af8631e3ab773a6de51e94154d2b5224022f93
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 09 Sep 2026 06:54:46 +0000
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

On 18.08.2026 12:48, Konrad Dybcio wrote:

>> + * Copyright (c) 2025 Dawid Wr=C3=B3bel <me@dawidwrobel.com>
>=20
> Happy new year!

Hah, indeed!
>> +=09status =3D "okay";
>=20
> ultra nit: \n before status is preferred

Thank you for the review. Both fixed in v3, which I just sent out:
https://lore.kernel.org/r/20260908-sm8250-xiaomi-enuma-v3-0-0198c3bf954a@da=
widwrobel.com

Note that v2 had been on the list for two weeks when you reviewed this
one, so it may have slipped past you. It folds the WiFi-label patch into
this one per Krzysztof's feedback. I *did* carry your Reviewed-by onto
the v3 patch, though =E2=80=94 let me know if you'd rather take another loo=
k on
that fold.

--=20
With Kind Regards,
Dawid Wrobel


