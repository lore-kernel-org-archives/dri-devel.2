Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37D09FCD0BE
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 07:08:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 952E110E2C6;
	Wed, 18 Mar 2026 07:08:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TcaGRxTP";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 112DA10E2C6
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 07:08:57 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id C389F4016A;
 Wed, 18 Mar 2026 07:08:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DC58C19421;
 Wed, 18 Mar 2026 07:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773817736;
 bh=GRW9JHLTAa2b0AKI+R0G8NVxVhAnwl0rvo+lqgcmuxg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=TcaGRxTPJWODKPaqHMRpCW7G9G82mIVGX0jBFULb7NqGtb734uxPj3pf3T+KR9JlL
 9Bm17QFIZoA42pBnbHT1s+PWgLsTSiroKJhBjFfzKdsmI6wT+PtE2n3bMnbqgCR7eb
 xRuU5oO+5Mn7kNCB70IErj6du8DYO/J+/ya2BbFPlIGGniP8bTq0l6PWmH8qKyxfMw
 00GXwPTPe6fit9dyajGrf3AoWJOlv/HRiB4yC41RpzvrrhhkSGHS6ERypnuZY4iyxd
 cppL1tnF6jUThdZt9mFSUJBvJ1/PKFp8AHAMjS8KlYfbtszHxykXv99n/dDbDEelt2
 tHZ9eFQPCN7Dw==
Date: Wed, 18 Mar 2026 08:08:54 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Yedaya Katsman <yedaya.ka@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>,
 Kamil =?utf-8?B?R2/FgmRh?= <kamil.golda@protonmail.com>, 
 Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 ~postmarketos/upstreaming@lists.sr.ht, 
 phone-devel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v5 1/3] dt-bindings: display: panel: Add Samsung
 S6E8FC0-M1906F9
Message-ID: <20260318-astonishing-spirited-perch-bbfd14@quoll>
References: <20260317-panel-patches-v5-0-ef99f7b280da@gmail.com>
 <20260317-panel-patches-v5-1-ef99f7b280da@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260317-panel-patches-v5-1-ef99f7b280da@gmail.com>
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

On Tue, Mar 17, 2026 at 08:50:29PM +0200, Yedaya Katsman wrote:
> Add Samsung S6E8FC0 DTS binding used with the M1906F9 6.09" 720x1560
> panel found in the Xiaomi Mi A3 smartphone.
>=20
> Co-developed-by: Kamil Go=C5=82da <kamil.golda@protonmail.com>
> Signed-off-by: Kamil Go=C5=82da <kamil.golda@protonmail.com>
> Signed-off-by: Yedaya Katsman <yedaya.ka@gmail.com>
> ---
>  .../bindings/display/panel/samsung,s6e8aa5x01-ams561ra01.yaml        | 5=
 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

