Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7487F3D60A
	for <dri-devel@archiver.kernel.org>; Sun, 29 Mar 2026 15:26:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E93D010E00F;
	Sun, 29 Mar 2026 15:26:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=protonmail.com header.i=@protonmail.com header.b="F1MCxIHM";
	dkim-atps=neutral
Received: from mail-24427.protonmail.ch (mail-24427.protonmail.ch
 [109.224.244.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9ABEF10E00F
 for <dri-devel@lists.freedesktop.org>; Sun, 29 Mar 2026 15:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1774798014; x=1775057214;
 bh=W0csasnSx2yLDoldpvYV8aUIdRGYmyJd4mDLqJYTvJo=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=F1MCxIHMdX3R7QKLkPfjSwZ2x72BI1DDziiMjduULH8SsntSTYTRO1oOPFxqHYv8g
 E3BfXwQmF0YI8RdBRaoSwwg+2U5fHN36u+fQoJFCnodYSuQJFhAqJYZHULRC2p76AL
 BHfR0vzvee/kSTxuDMV9Lj63Ye1pzSYjctMZHCpqVQcwZATF3Pz6CqNxoN10ojkIND
 iSvNL/JM+DBJaeCgsx3DyX+CnGVKxV5bK5n/a4K2kkGLXNHWyCsX7ZbhIBFeYOn5Qd
 5zQhjStsi/y3Cvc4j+OwGREI1VUN/uNS1GsxPCXUJjscNf9kEbB2P/Zu3lYcV9LQax
 7rP2sK2KylEHg==
Date: Sun, 29 Mar 2026 15:26:48 +0000
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
Message-ID: <VRCUEe2qHZa0a8HzVvhoRtAZyXO8pBU_l96B6U1kL5EFVSJyQBfYeKDvqPit-qpPRtIjUbtl7TH0JegJ7LXvctAxgyo50K6rTC5hwNjuV5k=@protonmail.com>
In-Reply-To: <o2sbqzcix74u46g74sil2c3b6mgd6zsrmafesoqltfbbrzqhjh@uochk3so46yx>
References: <20260327-rimob-new-features-v4-0-06edff9c4509@protonmail.com>
 <20260327-rimob-new-features-v4-3-06edff9c4509@protonmail.com>
 <us3ps4bgf5ekk2iudcgs2wa4b5qd4mzokec4q55pmhb6kvt6ht@qm4mmzdai2t2>
 <O7THc5h8ZhgzNpklYKTGOnEZKlN4BtHZHjKZt2KErekNb3E-hizt2dw7xuJ8G6giEyivmvC0f6-eIfCT6fJkUA7_CVQwhAktCXfBqAVV_Zo=@protonmail.com>
 <o2sbqzcix74u46g74sil2c3b6mgd6zsrmafesoqltfbbrzqhjh@uochk3so46yx>
Feedback-ID: 27475468:user:proton
X-Pm-Message-ID: 60242aa9c11534cdafdd19119148144aa99eeed6
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

On Sunday, March 29th, 2026 at 12:12, Dmitry Baryshkov <dmitry.baryshkov@os=
s.qualcomm.com> wrote:

> On Sat, Mar 28, 2026 at 05:30:53PM +0000, cristian_ci wrote:
> > On Friday, March 27th, 2026 at 23:57, Dmitry Baryshkov <dmitry.baryshko=
v@oss.qualcomm.com> wrote:
> >
> > > On Fri, Mar 27, 2026 at 03:30:49PM +0100, Cristian Cozzolino via B4 R=
elay wrote:
> > > > From: Cristian Cozzolino <cristian_ci@protonmail.com>
> > > >
> > > > Add the description for the display panel found on this phone.
> > > > And with this done we can also enable the GPU and set the zap shade=
r
> > > > firmware path.
> > > >
> > > > Signed-off-by: Cristian Cozzolino <cristian_ci@protonmail.com>
> > > > ---
> > > >  .../arm64/boot/dts/qcom/msm8953-flipkart-rimob.dts | 73 ++++++++++=
++++++++++++
> > > >  1 file changed, 73 insertions(+)
> > > >
> > >
> > > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> >
> > I wonder if I should, instead, edit the compatible property by adding a
> > second string (for the fallback), like this:
> >
> > compatible =3D "flipkart,rimob-panel-nt35532-cs", "novatek,nt35532";
> >
> > and, therefore, add "novatek,nt35532" string also to (patch 1/6)'s
> > bindings example. Let me know what you think.
>=20
> What would it mean? I think we usually don't include the IC into the
> compat list for the panel, but feel free to prove me wrong.

I've noticed use of that in this [1] patch series but I don't know why IC=
=20
string is used there (in the example) if the specific panel string (the=20
first one) is already defined in the panel driver.

[1] https://lore.kernel.org/linux-arm-msm/20251001135914.13754-2-caojunjie6=
50@gmail.com/

Best Regards,

Cristian.

> --
> With best wishes
> Dmitry
> 
