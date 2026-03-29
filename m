Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4CFBF3D605
	for <dri-devel@archiver.kernel.org>; Sun, 29 Mar 2026 16:19:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5508D89D99;
	Sun, 29 Mar 2026 16:19:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=protonmail.com header.i=@protonmail.com header.b="jR4HNOD/";
	dkim-atps=neutral
Received: from mail-43166.protonmail.ch (mail-43166.protonmail.ch
 [185.70.43.166])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 167EF897F0
 for <dri-devel@lists.freedesktop.org>; Sun, 29 Mar 2026 16:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1774801170; x=1775060370;
 bh=Kw9ncBi2g8DQlEJYun43Cmx0pvsMzUUHiini5FmiIoY=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=jR4HNOD/PRWujIZGBjEed6lMf0sNd3E44VYccLzQHnZ7POen1Iwi4T8vwxObK7LMV
 a/8Plia578tlBFgGaLWEghYi9W7nJqJvCBdRU6InsTYF+vR8f4fWw/vTETdnT9HIAK
 0kV4DnQkY2wjjBF8cR1RJ7qYFGkZzkB2tZi9dBCDjlUoDU9y9FwgiT3ivZPFKgBZnV
 UfS6bn2dD9m8VE5EXDkYD0cgfwmL7JEQvKoQ5+VHoQOoqP+u/hAvlrTXHjUXmwieOf
 TnCWkz4p7JcDRbTVtHSqpiyG/FAsteB3B+bIYWfYQk0nJvDWMViNSM0IW8OAtsFoqi
 ezTCFcOVC3XJQ==
Date: Sun, 29 Mar 2026 16:19:24 +0000
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
Message-ID: <zXHQN4VYU88kI-ekIhzg4F064XjG_QxgfKKoMO2NW4OF3JPUq_wkLikIPwzqx2rLkf1N17mcTsKiuyBuXCsSu1qWfys6tcK7ik-g4aWOeMc=@protonmail.com>
In-Reply-To: <s6kyh5wyamcxyd7xsbu5wrrpndpdb5xhxapmxze2qgblng5eiq@hl36nzg2lldg>
References: <20260327-rimob-new-features-v4-0-06edff9c4509@protonmail.com>
 <20260327-rimob-new-features-v4-3-06edff9c4509@protonmail.com>
 <us3ps4bgf5ekk2iudcgs2wa4b5qd4mzokec4q55pmhb6kvt6ht@qm4mmzdai2t2>
 <O7THc5h8ZhgzNpklYKTGOnEZKlN4BtHZHjKZt2KErekNb3E-hizt2dw7xuJ8G6giEyivmvC0f6-eIfCT6fJkUA7_CVQwhAktCXfBqAVV_Zo=@protonmail.com>
 <o2sbqzcix74u46g74sil2c3b6mgd6zsrmafesoqltfbbrzqhjh@uochk3so46yx>
 <VRCUEe2qHZa0a8HzVvhoRtAZyXO8pBU_l96B6U1kL5EFVSJyQBfYeKDvqPit-qpPRtIjUbtl7TH0JegJ7LXvctAxgyo50K6rTC5hwNjuV5k=@protonmail.com>
 <s6kyh5wyamcxyd7xsbu5wrrpndpdb5xhxapmxze2qgblng5eiq@hl36nzg2lldg>
Feedback-ID: 27475468:user:proton
X-Pm-Message-ID: 7103ff29d7061ece36242b2be9670773b9f15ef5
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


On Sunday, March 29th, 2026 at 17:51, Dmitry Baryshkov <dmitry.baryshkov@os=
s.qualcomm.com> wrote:

> On Sun, Mar 29, 2026 at 03:26:48PM +0000, cristian_ci wrote:
> > On Sunday, March 29th, 2026 at 12:12, Dmitry Baryshkov <dmitry.baryshko=
v@oss.qualcomm.com> wrote:
> >
> > > On Sat, Mar 28, 2026 at 05:30:53PM +0000, cristian_ci wrote:
> > > > On Friday, March 27th, 2026 at 23:57, Dmitry Baryshkov <dmitry.bary=
shkov@oss.qualcomm.com> wrote:
> > > >
> > > > > On Fri, Mar 27, 2026 at 03:30:49PM +0100, Cristian Cozzolino via =
B4 Relay wrote:
> > > > > > From: Cristian Cozzolino <cristian_ci@protonmail.com>
> > > > > >
> > > > > > Add the description for the display panel found on this phone.
> > > > > > And with this done we can also enable the GPU and set the zap s=
hader
> > > > > > firmware path.
> > > > > >
> > > > > > Signed-off-by: Cristian Cozzolino <cristian_ci@protonmail.com>
> > > > > > ---
> > > > > >  .../arm64/boot/dts/qcom/msm8953-flipkart-rimob.dts | 73 ++++++=
++++++++++++++++
> > > > > >  1 file changed, 73 insertions(+)
> > > > > >
> > > > >
> > > > > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > > >
> > > > I wonder if I should, instead, edit the compatible property by addi=
ng a
> > > > second string (for the fallback), like this:
> > > >
> > > > compatible =3D "flipkart,rimob-panel-nt35532-cs", "novatek,nt35532"=
;
> > > >
> > > > and, therefore, add "novatek,nt35532" string also to (patch 1/6)'s
> > > > bindings example. Let me know what you think.
> > >
> > > What would it mean? I think we usually don't include the IC into the
> > > compat list for the panel, but feel free to prove me wrong.
> >
> > I've noticed use of that in this [1] patch series but I don't know why =
IC
> > string is used there (in the example) if the specific panel string (the
> > first one) is already defined in the panel driver.
> >
> > [1] https://lore.kernel.org/linux-arm-msm/20251001135914.13754-2-caojun=
jie650@gmail.com/
>=20
> That's why I wrote "usually". In the end we also have several
> (unfortunately) panel devices which use IC for compat string, etc.

Ok, thanks for the reply.

Best Regards,

Cristian.

> --
> With best wishes
> Dmitry
> 
