Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B4ABCD5BB1
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 17:40:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D234010E1BF;
	Tue, 26 May 2026 17:40:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="prSRkHkM";
	dkim-atps=neutral
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com
 [209.85.222.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5476910E1BF
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 17:40:40 +0000 (UTC)
Received: by mail-ua1-f52.google.com with SMTP id
 a1e0cc1a2514c-956948531a1so2866996241.2
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 10:40:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779817239; cv=none;
 d=google.com; s=arc-20240605;
 b=hohTCCgZjz2gj10+7Ed/mhB2MsiHWmD8IQohCLDmw17M0V/SqYwnrzEbOHaEHG8eMQ
 hZd1wiZPl7Xql+UUCmXd1c6p36Pupg5P/D5ON35i2r6rHAOOjozj3A9/meMAhjcRu6sk
 Bs5+gBvzGVmvRP++WMCoG6nLzc4yN87SmqURr8PHuPbGYIIh+Lghc3A0ylewbpgVXhUw
 4KKuw0lkCu6TdyIEi29ugn9Ryo+a0wRfI31dqC7Tb6IrUuIZkTBxrPKycmRBLvhq20J8
 Q7K1Xox5Y+NOUbI5Xqh36zNpD/iEXFaK7M+tYkuEJ9CIwRlkUAOKb9zul0c9uw3ZUzl1
 e3+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=sB+mjSu/pqVnN5kPDqiN9QaioGX3lZ6RIksWWTXTj0o=;
 fh=8E4bXk5Y/37793CjLV35lGoMVP9A/bqAWwfMp7qS5WE=;
 b=hNdu6WJNpu7VgkCleFOFvnETnCkPcmn04IongHh3gU2aYDG/gwm6n8G4TDAQgvMvHj
 NLsKvl5bSSUCDOz1sLczVokeXJmKrKUbujhiQdCaORR2l6iiX8/ZGlpNsRg1TZDgU07I
 qdCR5N+PsBjZjVYw8sxb7my0gcMuP0pTLOytU/X/cOEioPr+92w058aId7ziWlQSCKm+
 hcD2eXMrnyduodY1eoyB2DzlPfZ9l1r+Od9vxJS+sXDLf8iyWcnvs9kGtynPw2In47rW
 75UmgDkFvz8j6iGMXZpqntL9imLas9AP5Aho6/CTBUKBLgLkvXr0VP8OQIQJi1NLB7jV
 ITTQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779817239; x=1780422039; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sB+mjSu/pqVnN5kPDqiN9QaioGX3lZ6RIksWWTXTj0o=;
 b=prSRkHkMuIW/F8Qg8izJM/CKVompV7HyFtigfdgDq5KisrfJD/aSvqramDrks2Sctq
 wlg8JFA/AHFTGr8qIWoRKcecu8HMzmRSoZq5gqYC9t0kJBI54nZuLbrYmco1bVvPlFF8
 TGwRHmL9nmcn/r+9+rHM2LLTxTPDdcMFO2VOJfWEq+TCPRSWp2YIPeZGIxit+excL18A
 a7JKe1twW23BUrev5r0zFUBmvIxP7riIp3j3cO2MrKlK29z8mUX8aTkGNAzWT6+/lGJE
 6ig7qokacGlpHgkKTQAOfsRQyhdY74mTsbdja4+BG41Q551XOPoTjBOQHQnp+DrXe3l4
 L0aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779817239; x=1780422039;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sB+mjSu/pqVnN5kPDqiN9QaioGX3lZ6RIksWWTXTj0o=;
 b=q/0NzoX1/zi5XnseOy0ex3Uy+NP9Q/6qamJRIiYPfnFIqq/335wZeTz/qXIOe8ylLh
 36Fl4wj7gJEIHOvERhCb0pdno38stj40cDpPmMDofeRP6C57F7qfpICMMGbXSffJVCBn
 eLzuf18ldeQm5jyhABSRilc3Mzx/qpk85KS+cbKdBGfynuX1QESYgu2tE+VVFXtir2kH
 FWpVrFWEv2dcYjFyhqoeU2I7CEY8uLZr+kA5XpW4EGtVIWxdiSfTApwW2odOfGDpO1dn
 Xp/K/CMqxUnppnMoDF0EiBc3mQhWxXvvzzCMcl3v4tEInCbHLA5QnElsj8wg+7Aj7LnI
 FzhA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+hx/Xuzh+sT156BY1CJhdHiF0PCR4xoWymiz7YQXlLiWtCjyhjKvI5HcM6DWzJ4VetI9NzFDpj2lc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzffZp8nMXdFQb7p6MpPKdHjS7rgKAhLRKyOidKbLBgRJ0RrstR
 fTKxvy1s5uNecUYUe3sufEIrEBuF9ohokhGhMr2px0ZHAWdJMgAArWZRj3eRZsqPThAKelsgHFz
 FUI3pBwzf0E1lFJdZNdpA4JMFo2poE5U=
X-Gm-Gg: Acq92OHm95RrcV8wLj36SUtsl8J1IXApvqyNB9XXudfJX3/c2kdTeIX83Vk/a5zQL7W
 UKJV8B5fIy8gSs1gFEK6SxASiXPObPr29w+ngECbrNmiXX4xvx0Tsfv+TZt6rnUDU0qCxHepSji
 RyaBQIAqr8y6+kNDLurgVQOrLzE7+UKniuCxRuE9VMrJzYJDHu3g5omt2HmTKPnmBOFeUwkiCy4
 2Yj9cTqasm0b2X7DoMTtimDMVJr/YSh5wMwH0kGG4ET0HVex9KDQCSL1viSN6s6nhXr1AOKKnvW
 DPEjOJ0=
X-Received: by 2002:a05:6102:3f86:b0:602:8c16:b24c with SMTP id
 ada2fe7eead31-67c7c0765aemr9185857137.19.1779817239074; Tue, 26 May 2026
 10:40:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260314-panel-patches-v4-0-1ecbb2c0c3c8@gmail.com>
 <177818605997.73000.9692910497119100760.b4-ty@kernel.org>
 <CAHuF_Zr0Z+rP72fLts5Ar56XyY8VMROzE0wQ_S5iyO+A4YoMSw@mail.gmail.com>
In-Reply-To: <CAHuF_Zr0Z+rP72fLts5Ar56XyY8VMROzE0wQ_S5iyO+A4YoMSw@mail.gmail.com>
From: Yedaya Katsman <yedaya.ka@gmail.com>
Date: Tue, 26 May 2026 20:40:27 +0300
X-Gm-Features: AVHnY4K0YHv_VhlqTQcjH1BYoi9vYxYTC8vhg9AZJCVfVLC71VCaUv3jbXuBfa8
Message-ID: <CAHuF_ZoirJ7PdLxQcY2NC-Gay6wv=m=eVZBDLFXrRYnszo8Wew@mail.gmail.com>
Subject: Re: (subset) [PATCH v4 0/3] Add support for the Samsung S6E8FCO DSI
 and M1906F9 display panel
To: Bjorn Andersson <andersson@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 =?UTF-8?B?S2FtaWwgR2/FgmRh?= <kamil.golda@protonmail.com>, 
 Konrad Dybcio <konradybcio@kernel.org>,
 Kaustabh Chakraborty <kauschluss@disroot.org>, 
 ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
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

Hello Bjorn, just a reminder about this, I don't want the wrong
compatible getting into a release

On Wed, 13 May 2026 at 15:09, Yedaya Katsman <yedaya.ka@gmail.com> wrote:
>
> On Thu, 7 May 2026 at 23:35, Bjorn Andersson <andersson@kernel.org> wrote:
> >
> >
> > On Sat, 14 Mar 2026 23:46:20 +0200, Yedaya Katsman wrote:
> > > This adds a driver to support the Samsung S6E8FCO DSI controller with the
> > > M1906F9 display panel found in Xiaomi Mi A3 (xiaomi-laurel). The driver is
> > > generated using linux-mdss-dsi-panel-driver-generator[0].
> > >
> > > The mdss reset dependency makes the screen work more reliably.
> > >
> > > [0]: https://github.com/msm8916-mainline/linux-mdss-dsi-panel-driver-generator
> > > Original tree with patches: https://gitlab.postmarketos.org/SzczurekYT/linux/-/tree/laurel
> > >
> > > [...]
> >
> > Applied, thanks!
> >
> > [3/3] arm64: dts: qcom: sm6125-xiaomi-laurel-sprout: Enable MDSS and add panel
> >       commit: 493cb869874cd301c370adf9a3f9577942c4f0f1
>
> Thanks for applying, but notice that this is an old version, the last
> version is v7:
> https://lore.kernel.org/all/20260320-panel-patches-v7-3-3eaefc4b3878@gmail.com/
> The compatible string was fixed in v5, and other patches in the series
> were applied with the new version.
>
> The difference is in the compatible, 's6e8fc0' with a zero instead of an O.
>
> > Best regards,
> > --
> > Bjorn Andersson <andersson@kernel.org>
