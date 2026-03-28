Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B80B10F3DEE
	for <dri-devel@archiver.kernel.org>; Sat, 28 Mar 2026 17:31:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B78D410E040;
	Sat, 28 Mar 2026 17:31:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=protonmail.com header.i=@protonmail.com header.b="JYXx2ugx";
	dkim-atps=neutral
Received: from mail-24429.protonmail.ch (mail-24429.protonmail.ch
 [109.224.244.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B69CA10E040
 for <dri-devel@lists.freedesktop.org>; Sat, 28 Mar 2026 17:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1774719059; x=1774978259;
 bh=sgqrW4vue2YRH/11cpwfBbkabMPf+9TeMN7abNY/hXQ=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=JYXx2ugxoLBqIhcply1iBLXBWtiOGWnNv8TPcXKMqbK0dTiKIhPDiY4fuMniIzG0c
 DgcG4PxASDHkVW+RCVWk1GlERuVPiwQH3xVFSHB2bS5oj6/LKbvTPgInk6MZjj08+s
 53RJcD5kY/AwH6oCXofd2azsDtu+4m/m0L+IpTfD6gZrrhTRrfhvhL/vV3Awwtnxks
 Kiyfc7ZgE8ASj4btj4yHWeM40sFaUhE1vfH8ZsAca2dhXeLw8DfEgrwkN3rs8jkBq0
 N9USWcLMelB9iPxGrLYHaR7DvhfOBjnhydzrUol06o/2kkHkQxIdpTxr6DC0lhzOxi
 GnbAJTbZVDiew==
Date: Sat, 28 Mar 2026 17:30:53 +0000
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
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
Subject: Re: [PATCH v4 3/6] arm64: dts: qcom: msm8953-flipkart-rimob: Enable
 display and GPU
Message-ID: <O7THc5h8ZhgzNpklYKTGOnEZKlN4BtHZHjKZt2KErekNb3E-hizt2dw7xuJ8G6giEyivmvC0f6-eIfCT6fJkUA7_CVQwhAktCXfBqAVV_Zo=@protonmail.com>
In-Reply-To: <us3ps4bgf5ekk2iudcgs2wa4b5qd4mzokec4q55pmhb6kvt6ht@qm4mmzdai2t2>
References: <20260327-rimob-new-features-v4-0-06edff9c4509@protonmail.com>
 <20260327-rimob-new-features-v4-3-06edff9c4509@protonmail.com>
 <us3ps4bgf5ekk2iudcgs2wa4b5qd4mzokec4q55pmhb6kvt6ht@qm4mmzdai2t2>
Feedback-ID: 27475468:user:proton
X-Pm-Message-ID: cf18d05c5f1d325076efcda785cfdd467cb230d9
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

On Friday, March 27th, 2026 at 23:57, Dmitry Baryshkov <dmitry.baryshkov@os=
s.qualcomm.com> wrote:

> On Fri, Mar 27, 2026 at 03:30:49PM +0100, Cristian Cozzolino via B4 Relay=
 wrote:
> > From: Cristian Cozzolino <cristian_ci@protonmail.com>
> >
> > Add the description for the display panel found on this phone.
> > And with this done we can also enable the GPU and set the zap shader
> > firmware path.
> >
> > Signed-off-by: Cristian Cozzolino <cristian_ci@protonmail.com>
> > ---
> >  .../arm64/boot/dts/qcom/msm8953-flipkart-rimob.dts | 73 ++++++++++++++=
++++++++
> >  1 file changed, 73 insertions(+)
> >
>=20
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

I wonder if I should, instead, edit the compatible property by adding a=20
second string (for the fallback), like this:

compatible =3D "flipkart,rimob-panel-nt35532-cs", "novatek,nt35532";

and, therefore, add "novatek,nt35532" string also to (patch 1/6)'s=20
bindings example. Let me know what you think.

Thanks,

Cristian.

> --
> With best wishes
> Dmitry
> 
