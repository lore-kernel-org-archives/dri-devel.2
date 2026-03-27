Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FAB610BA42C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 05:26:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2C0210ECA7;
	Fri, 27 Mar 2026 05:26:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=protonmail.com header.i=@protonmail.com header.b="sDNBBMYV";
	dkim-atps=neutral
Received: from mail-24430.protonmail.ch (mail-24430.protonmail.ch
 [109.224.244.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35E3910ECA6
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 05:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1774589214; x=1774848414;
 bh=E+nwK/sviPTJ4YHe+rWlRmRhYCoqZkYMB6zYwWx5tr0=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=sDNBBMYVJAp1LdeUIFiSOLc1bKhghvNL2Q1/KdU+eYfNHKzsfgkEW5FXp3fipfxAF
 kxEReEJ74UPzEYehOn/I43Oft4dOT2J0vhpFHuayeKtp4GyY43vSG5zQ3PCJeBos83
 etrIxLyRi6fbZGk4iV4fWhIWaG6zTlwT8kHehaEqLVjBcMH9hpemmegLF+S8pBlX4S
 HsieuSir62nZmmtMFXiS4YrJMF1/MuFpcu3uUv3U4yWighWmEU27hvLXnfIVqDbJOw
 BcEtLsktfxf0ylr2CZN7sbpn1qqIYuojbyBf9UToMTNgNpmAWd1KiFs8yzH+rPrXv3
 MFNROqRF7aMnQ==
Date: Fri, 27 Mar 2026 05:26:47 +0000
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
From: cristian_ci <cristian_ci@protonmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
 phone-devel@vger.kernel.org
Subject: Re: [PATCH v3 3/6] arm64: dts: qcom: msm8953-flipkart-rimob: Enable
 display and GPU
Message-ID: <63LsT_8yLkjzVTSswYeIbFl40zYY30Bo5DyyLCqYrG1E0eJ4RqKF715_8j2J0WRd3RESpYvwfPTJzw7xsCa4wdxmYGQbUArRlKz3PL1cJ5Q=@protonmail.com>
In-Reply-To: <87943afd-2601-423e-878d-36b69ac3d6c3@oss.qualcomm.com>
References: <20260321-rimob-new-features-v3-0-d4b8ee867de7@protonmail.com>
 <20260321-rimob-new-features-v3-3-d4b8ee867de7@protonmail.com>
 <109d21b4-5d16-4689-8383-ecd29bbbf8a6@oss.qualcomm.com>
 <7wYxWlqdcbL3ANB9n0g4t74x-dwE2yG4CmVw9TwGNmwARxbT5WsdG1fpuIDSA5ab750Gs8OUBwmVa_nZd065guKDJueytb1AmlQ05__IzmU=@protonmail.com>
 <87943afd-2601-423e-878d-36b69ac3d6c3@oss.qualcomm.com>
Feedback-ID: 27475468:user:proton
X-Pm-Message-ID: 13a94298c7042e78ace8ac9e771817c299e4a043
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

On Thursday, March 26th, 2026 at 13:08, Konrad Dybcio <konrad.dybcio@oss.qu=
alcomm.com> wrote:

> On 3/24/26 12:18 PM, cristian_ci wrote:
> > On Monday, March 23rd, 2026 at 11:52, Konrad Dybcio <konrad.dybcio@oss.=
qualcomm.com> wrote:
> >
> >> On 3/21/26 5:23 PM, Cristian Cozzolino via B4 Relay wrote:
> >>> From: Cristian Cozzolino <cristian_ci@protonmail.com>
> >>>
> >>> Add the description for the display panel found on this phone.
> >>> And with this done we can also enable the GPU and set the zap shader
> >>> firmware path.
> >>>
> >>> Signed-off-by: Cristian Cozzolino <cristian_ci@protonmail.com>
> >>> ---
> >>
> >> [...]
> >>
> >>> +=09panel_default: panel-default-state {
> >>> +=09=09pins =3D "gpio61";
> >>> +=09=09function =3D "gpio";
> >>> +=09=09drive-strength =3D <8>;
> >>> +=09=09bias-disable;
> >>> +=09=09output-high;
> >>
> >> This says "by default, actively drive the pin not to reset the display
> >> panel". Is this actually necessary?
> >
> > I've tried to remove panel pinctrl stuff from the panel and the device =
still boots/works exactly like before. So, have I to submit v4 without pinc=
trl at all for the panel?
>=20
> No, the pin config is useful, I'm specifically referencing the output-hig=
h
> property

I've commented out "output-high" property and (apparently) the device=20
boots and works like before.

> Konrad
> 
