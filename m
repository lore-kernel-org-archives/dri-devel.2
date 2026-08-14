Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47A7AC5DF74
	for <dri-devel@archiver.kernel.org>; Sun, 16 Aug 2026 14:05:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47C3D10E2E8;
	Sun, 16 Aug 2026 14:05:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=protonmail.com header.i=@protonmail.com header.b="IOAFiCvO";
	dkim-atps=neutral
Received: from mail-4327.protonmail.ch (mail-4327.protonmail.ch [185.70.43.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A96B510E555
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 12:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1786712140; x=1786971340;
 bh=5CyJvTE+C18+28hqN3SKsvblt/DEqcy8hmgnnZ6dd/s=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=IOAFiCvOuY0ejXPK4bAzT4AU+PGHAGgoIV9Sy2zFNgzy7K6uJeFB5UB4+RQuc1Twf
 Vt8I3eeTRc+ipNv+bnvM5WA2kNNO9KddSadf/WgvudTQ2p/5/SzOx0GFVRR2R/je0V
 WWTQcC4Siv1BrugLahM6nNnBadVZmQA/AjJS22l0vnxTfOLDUDMhthoG4cOG4vOgBc
 dLCxzG+1xc3FWQA32AI0d0aFHEPzta5PTU4X6F1I9MX36CzBGgyKtzmg5RExonfOR8
 G0Pg8vlhKzTa59a8a7Szzq2a//c4ToKUp8A/e3rrq8tchkJCwPI3r42kLoNpJxQW4u
 qKyfG6bFhMghg==
Date: Fri, 14 Aug 2026 12:55:32 +0000
To: Krzysztof Kozlowski <krzk@kernel.org>
From: Roman Vivchar <rva333@protonmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Heiko Stuebner <heiko@sntech.de>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: gpu: arm,mali-utgard: add mt6572
Message-ID: <47r1iD-p_AVnHH7YeiXxNHnX9o8zmOaWUvLivra1vGyPngBdfaTKUtwGb_OAAwnW0-mu41sICz2PoKyCw99AACkhjt7XtyQp3_40jLMAUKU=@protonmail.com>
In-Reply-To: <20260814-portable-premium-avocet-eafbe2@quoll>
References: <20260810-6572-dt-mali-v1-1-fb908627bf23@protonmail.com>
 <20260814-portable-premium-avocet-eafbe2@quoll>
Feedback-ID: 173184497:user:proton
X-Pm-Message-ID: 2dc330e17f8b88bcaf3ae0dbfe5c2b4bce6048c8
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sun, 16 Aug 2026 14:05:11 +0000
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

Hi Krzysztof,

On Friday, August 14th, 2026 at 1:36 PM, Krzysztof Kozlowski <krzk@kernel.o=
rg> wrote:

> On Mon, Aug 10, 2026 at 11:16:19PM +0300, Roman Vivchar wrote:
> > Add a compatible string for the mt6572 Mali-400 MP1 GPU.
> >
> > Signed-off-by: Roman Vivchar <rva333@protonmail.com>
>=20
> Does not come with resets?

As far as I understand, no. Vendor kernel says there's a reset, but
toggling bit in the reset controller doesn't crash the GPU. I assume
android kernel has copypaste leftover and the bit is reserved/unused.

>=20
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
>=20
> Best regards,
> Krzysztof
>=20
>=20

Best regards,
Roman
