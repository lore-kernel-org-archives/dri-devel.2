Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E56DDC44520
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 19:04:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A45DD10E131;
	Mon, 20 Jul 2026 19:04:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=loe-web.de header.i=@loe-web.de header.b="dcoO2h/w";
	dkim-atps=neutral
X-Greylist: delayed 2257 seconds by postgrey-1.36 at gabe;
 Mon, 20 Jul 2026 12:58:35 UTC
Received: from wp585.webpack.hosteurope.de (wp585.webpack.hosteurope.de
 [80.237.130.107])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0E9010E90D
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 12:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=loe-web.de; 
 s=he168698;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:In-Reply-To:References:Cc:To:From:From:Sender:Reply-To:Subject:
 Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=ZT1jaqD1Iccb31fXdwSCF9w0Y9iQoL1OwEC509jWVdI=; t=1784552316; x=1784984316; 
 b=dcoO2h/wSO2HaslHVCprSoOnnbA6/oQvYc755HB+TK8NAcWAiVWpzLWjYG/hfqERhxTechAnliy
 B2An6wYgSRe6mB9cHcwBO6RSFfRcFBvObVGsKUOyTtDjECuajDHJ+X1mi95gxcOiR5N/vvp45WHR7
 1jNUz1DKE9cGoTxWSs/wkPHgAMquU1qsUnCHSrUQslrmeMrEzRAroY2ZSu1bseQspCA5AHFUQaJXp
 pXEj6GZuU3FoeQpP80HLkmxh/blHZqXu2Gr5ZRwKF0iMYHM6FST6JM6xzh72vr15qnh8/BtiqHFog
 G8EpWS9viTe7oBl6hEDQLNKBxqWDeVBS74Xw==;
Received: from host-213-179-158-197.customer.m-online.net ([213.179.158.197]
 helo=84JJL23); authenticated
 by wp585.webpack.hosteurope.de running ExIM with esmtpsa
 (TLS1.2:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 id 1wlmzI-004nlt-2U; Mon, 20 Jul 2026 14:20:48 +0200
From: "Jakob Loe" <jakob@loe-web.de>
To: "'Alibek Omarov'" <a1ba.omarov@gmail.com>,
 "'Rok Markovic'" <rok@kanardia.eu>
Cc: "'Heiko Stuebner'" <heiko@sntech.de>, "'Sandy Huang'" <hjc@rock-chips.com>,
 "'Andy Yan'" <andy.yan@rock-chips.com>,
 "'Maarten Lankhorst'" <maarten.lankhorst@linux.intel.com>,
 "'Maxime Ripard'" <mripard@kernel.org>,
 "'Thomas Zimmermann'" <tzimmermann@suse.de>,
 "'David Airlie'" <airlied@gmail.com>, "'Simona Vetter'" <simona@ffwll.ch>,
 "'Rob Herring'" <robh@kernel.org>,
 "'Krzysztof Kozlowski'" <krzk+dt@kernel.org>,
 "'Conor Dooley'" <conor+dt@kernel.org>, <dri-devel@lists.freedesktop.org>,
 <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-rockchip@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20260717120005.2087386-1-rok@kanardia.eu>
 <20260717120005.2087386-4-rok@kanardia.eu>
 <CAKyg=SV2-81VFgr+Tq=-Si5EO-86MA+ZFoQ+DX1fEYdnnLYJng@mail.gmail.com>
In-Reply-To: <CAKyg=SV2-81VFgr+Tq=-Si5EO-86MA+ZFoQ+DX1fEYdnnLYJng@mail.gmail.com>
Subject: AW: [PATCH 3/4] drm/rockchip: lvds: add RK3568 support
Date: Mon, 20 Jul 2026 14:20:48 +0200
Message-ID: <000c01dd1842$32a0a580$97e1f080$@loe-web.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFaHWtND3nIPg5aqhiCEj6HM4JNGQJz810+As1SicW3Uj7lQA==
Content-Language: de
X-bounce-key: webpack.hosteurope.de;jakob@loe-web.de;1784552316;7e40d5d9;
X-HE-SMSGID: 1wlmzI-004nlt-2U
X-Mailman-Approved-At: Mon, 20 Jul 2026 19:03:49 +0000
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

Hello!=20

Nice to see this is still being used.
I can confirm that this actually works and outputs fine LVDS on a =
RK3566. Also reliably so far...
Any questions, I will see what I can help.

All the best
Jakob


-----Urspr=C3=BCngliche Nachricht-----
Von: Alibek Omarov <a1ba.omarov@gmail.com>=20
Gesendet: Montag, 20. Juli 2026 07:39
An: Rok Markovic <rok@kanardia.eu>
Cc: Heiko Stuebner <heiko@sntech.de>; Sandy Huang <hjc@rock-chips.com>; =
Andy Yan <andy.yan@rock-chips.com>; Maarten Lankhorst =
<maarten.lankhorst@linux.intel.com>; Maxime Ripard <mripard@kernel.org>; =
Thomas Zimmermann <tzimmermann@suse.de>; David Airlie =
<airlied@gmail.com>; Simona Vetter <simona@ffwll.ch>; Rob Herring =
<robh@kernel.org>; Krzysztof Kozlowski <krzk+dt@kernel.org>; Conor =
Dooley <conor+dt@kernel.org>; dri-devel@lists.freedesktop.org; =
devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; =
linux-rockchip@lists.infradead.org; linux-kernel@vger.kernel.org; Jakob =
Loeschke <jakob@loe-web.de>
Betreff: Re: [PATCH 3/4] drm/rockchip: lvds: add RK3568 support

> Based on Alibek Omarov's earlier posting [1], with the changes below.

Hi, I'm Alibek Omarov and thanks for picking up my patches. I didn't had =
time to finish them and these days I don't work on hardware that uses =
any of Rockchip SoCs. However, if I'm not wrong, it's still used in =
production and I had report from Jakob Loeschke (added in CC) who =
confirmed it worked in their setup as well.

Thanks.


