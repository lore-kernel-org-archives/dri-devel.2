Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B173F606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 06:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=icenowy.me header.i=@icenowy.me header.a=rsa-sha256 header.s=zmail2 header.b=VVy59VhX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C46810E52B;
	Wed, 18 Nov 2026 06:26:21 +0000 (UTC)
Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com
 [165.173.182.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CF7710E342
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 06:26:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1794983169; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=II/905t/7s1Bx2boCuHu/7QbYxEz+LgQLzRgga2Y2iNyT2iRlg8cYn/Sh9TeD5z/IL90wCBleYcN4uCdvRRdJWYm0Pe9kseSvuF+VxCLh/PiQIJ2Sop7S61eseKeZAFVwM45ji40cwP5T6E+zjOxc0L0Is0EmgpbeOK80P6RxF8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1794983169;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=wChTs17w/kPirEcR5u/gSY+8kUIHSjZ+Ainq8hP8/TU=; 
 b=JHhEy+7gRq7N9dwaoUeNiKRqY0KJCJLsbz8t6/Pe733vDBJY95QQy2YA4pEObW2cVV+hem/rSgnNqxoQREvZkpFCldM9ywDm55k+ifV9oZGcLcKN2B4KTyCnE0vsaJmkZvroWUEUeWnH3UCK6H7cQRIPt3RI4uotr2mnhSuw9+w=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=icenowy.me;
 spf=pass  smtp.mailfrom=uwu@icenowy.me;
 dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: a=rsa-sha256;
 b=VVy59VhXnd3NmcMyl4P+5fUkpk/NxP74/38dN0hJ+TQz/hJRSel3AlhuVs3d/fK1E2tFmbhkQDSBM1TV4GVn2/7pfJA/9XwedNA79MvxorYEBvSwPUQRCt0ycWmlie/UDgtBmQo33Fen2oDdQlfLCFqZ7AR/7o9x0LVKLGajmZ5aLlMvq6LptGs0TFjZL059B/PhrEN0uOvchMxc4njgNPo79UEfQjr2XHNv2Xk8VOyFVCxGWDWy3iZly+wsvucrZp8+Y43R8s3mVJ8BTti0VsnU+F99NOR7xxRYC7RDwQ85J1Qz/dp0axDxmlGdwmeMTkquFlKPQ1+8/JUes9R34w==;
 c=relaxed/relaxed; s=zmail2; d=icenowy.me; v=1;
 bh=wChTs17w/kPirEcR5u/gSY+8kUIHSjZ+Ainq8hP8/TU=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794983165898478.8118549869997;
 Tue, 17 Nov 2026 22:26:05 -0800 (PST)
Message-ID: <9d97d5dbcc619a9c52904ff8c6704a91fe8351e7.camel@icenowy.me>
Subject: Re: [PATCH v2 15/17] riscv: dts: spacemit: k3-pico-itx: enable the
 DisplayPort output
From: Icenowy Zheng <uwu@icenowy.me>
To: Guodong Xu <docular.xu@gmail.com>
Cc: Cody Kang <codykang.hk@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard	 <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring	 <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley	
 <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>, Vinod Koul
 <vkoul@kernel.org>,  Neil Armstrong <neil.armstrong@linaro.org>, Haylen Chu
 <heylenay@4d2.org>, Michael Turquette	 <mturquette@baylibre.com>, Stephen
 Boyd <sboyd@kernel.org>, Brian Masney	 <bmasney@redhat.com>, Philipp Zabel
 <p.zabel@pengutronix.de>, Paul Walmsley	 <pjw@kernel.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou	 <aou@eecs.berkeley.edu>, Alexandre Ghiti
 <alex@ghiti.fr>, Yao Zi <me@ziyao.cc>,  Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=
 <u.kleine-koenig@baylibre.com>, dri-devel@lists.freedesktop.org, 
 linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-phy@lists.infradead.org, linux-clk@vger.kernel.org
Date: Wed, 18 Nov 2026 14:25:38 +0800
In-Reply-To: <f4b8c87eb0676500661ebea67363ac27.docular.xu@gmail.com>
References: <20260809-k3-display-v2-0-327d7910bf71@gmail.com>
 <20260809-k3-display-v2-15-327d7910bf71@gmail.com>
 <576146d4f2752c3c3f6ec6c42812cb9956406383.camel@icenowy.me>
 <f4b8c87eb0676500661ebea67363ac27.docular.xu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-ZohoMailClient: External
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

=E5=9C=A8 2026-11-17=E4=BA=8C=E7=9A=84 15:51 -0500=EF=BC=8CGuodong Xu=E5=86=
=99=E9=81=93=EF=BC=9A
> Hi Icenowy,
>=20
> On Thu, 03 Sep 2026 20:09:42 +0800, Icenowy Zheng wrote:
> > The connector available on the Pico-ITX mainboard isn't a
> > DisplayPort
> > port -- it's a USB Type-C port instead.
>=20
> Right, it is a Type-C receptacle, and the commit message should say
> so.
>=20
> > I think you need to model the Type-C port and alt functions of it.
>=20
> I am not sure that can be done on this board. The redriver/mux in
> front of the receptacle and the PD controller that steers it both
> sit on the EC's own I2C bus, and their interrupt goes to the EC too.
> The SoC has no bus to either chip; all it gets from that side is the
> DP1 HPD line.

The ChromeOS EC firmware exposes some control for a Type-C port, you
can search for `google,cros-ec-typec` and `google,extcon-usbc-cros-ec`
compatible string in arch/arm64/boot/dts for more details.

Although the K3 Pico ITX hardware connects the EC to the SoC with some
not-so-embedded interface (eSPI), which needs to be handled first.

Thanks,
Icenowy

>=20
> So a usb-c-connector node would have nothing to link to here.
>=20
> Guodong
