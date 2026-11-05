Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192FD606A33F
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 14:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fooishbar.org header.i=@fooishbar.org header.a=rsa-sha256 header.s=google header.b=A0Xl+VJg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74E0410E3BD;
	Thu,  5 Nov 2026 14:34:15 +0000 (UTC)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3A1210E3BD
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 14:34:08 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-3ac7842c17dso1326733a91.3
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 06:34:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793889248; cv=none;
 d=google.com; s=arc-20260327;
 b=A59kX14J7xQ2K+Dcq+lmFDbfvJrbmNE5v66LqhyjWRuVTkUi0PxsK95rgHSIE/L75h
 hI6X12h2/DZySoj00Ip84puX1tWse5h1pPY5VCD0El+6P1zdIlTmwVwf0/+itymvYcxu
 ngQpMybq/9Lnybc0Zf82OezKhrSdV8SiujQeLIceUucigjTaKqbQ46Idq/ZAsFMposa0
 M78ZeXEaudPeBExGy/uBkO6RmP5krQVGqDutsfB+FsZAVX+IMaRmYZ2sp12yfIsOtcRb
 dRUqyDjJTaPOxlagVjA9eUGt2kzjliFwH/XEePBI8skgE3GBQK+G8Y1JzltwkSax5e0m
 b80Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=1jZ8AIzpmZVSpEwlYYo7Zj/7Q72rSuq9gl+sxktWfs8=;
 fh=jNigmqGCs4jvZkwiyImEni9y5XfxiLal7TsgAMWbh9c=;
 b=o8fjVWa9OCrcSTtgQFEc382XAsIzb1o8tVt54T2mRlxKRKvYTD0uU+6IcZB3PRnNhw
 NsqVL3cGJIYiEBd7lCgaRqGAnDCkb1blG6LVIR26ZrMmaRpPb1dULNQxdV/vSDMEsdPx
 o8FbchTNbuy4PvlsmegZmERM/HxmGZTD+kh4Uuzo6EhrZhXVfCMlw/uNP2mk1R5ivygF
 bgjqWSJNui/ndA2PGdqvGassY3Xy5TCILF8LU9AFetkgUWmt3y6RE+flyV7B/2AVo0ez
 iTjtiCbn09gZD9ZW9IVUNXKyrdNdhpspGMPwzA9e7JIORXHgA+UUWGuvKR/IeRcst4x0
 qxxQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar.org; s=google; t=1793889248; x=1794494048;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=1jZ8AIzpmZVSpEwlYYo7Zj/7Q72rSuq9gl+sxktWfs8=;
 b=A0Xl+VJg6u6uNE5o6Ev0TPwk4zYB++R3pWdmFLrOwY6rJoh8uTx5t15rWKOztw6aEw
 fjjpL9jUUdB38nEZtFFPyWVpd6wgGswL4iIirhoDIG3E5j/sYiHWyYzt82jv9T4V7rLY
 EVCisst8QmoJgPaV19iyHauDNuXKlFxGbAQKso9hlxSzGixBbCLGrM7wPbF0NQcVSsdR
 XosXIwiDkE3vZT7sQM24zrmfDGe19lkhagdOLfImsQOz3nahBy/wc25C1Wjt/VF4Xig6
 Ph/OQQtpQePpKwKQkxeZ8v8pYOVtfHqur5owtfdk0nLULthQCkKpkptZ9A7A9SjWmnEE
 cO4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793889248; x=1794494048;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=1jZ8AIzpmZVSpEwlYYo7Zj/7Q72rSuq9gl+sxktWfs8=;
 b=2rtpLXhANXM7XDNNigeZ6WiKDN1GIPo/kxQKqtMmqKy+kdnCw7JVezo0aIOHePqMbb
 9t8FlB5g7TYPDlbd5DYI0XBaY26i93HJPkIgjtMBHyFeh3kPbvSsEc59uCe9c4Hf/0d7
 xsGjCUXRARh/b5WaqgmochxIVR2vVZi8S+nhpwGWF6GHpXteK9Fk4giOkL4BfSlGnHsK
 ZhWaAPam8s6fsbAgIjzgTh4zLtjb1bWJsooE6WQwBGhXb0sCf1aTpmWUzAvP89BlK5Mz
 GUr9GapwGy48TTc03BkrZT962Hrgyn9eB9fCL99KEQsiRBvr86I0bg/bGW3W2WOBrbU4
 9jOg==
X-Forwarded-Encrypted: i=1;
 AKwUvByIrOAytKbJGdXrvgWNgf+QYSPuTWwrSR3aQ1d1M4ph8iAzS1WrpiEjufYB2TCjZ4hJ9ARRKKoE5Ac=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9PI8bdfzr+FwSeWk8dz2uJCMAnyf/JDlq8zjCaVrB/04cFzaBZ
 RRNDwZ1+6vLip+3wjbsB+wWf/Eqto72C51ijzotd6wHKQ9uTw47Q3P6QM2YA9npb4ZH0pd7IlgN
 anfLrCeezqg8QbXAva05QPVk4PuRKIdd/Ccvy22sgvA==
X-Gm-Gg: AYBFou3BEDqIWjtRqfowFH9viGYpbIyy6ht0p4DVn2X3y+K0Z2Qaogt1D/VqDl0vaVG
 pMNwF7KGflfBwso5j2v4m8mGC3vJQsTwc6M/+WD9ah9G9PZaARlhlmTNAP645ZkF8HegA7U+OwS
 k4DLu7522YW739tj8oGbqGajLcAiWHPBrYN/16nl1SX/2WAy/+IVPBsqdBta0UA2dP8ARst7C12
 NyonqQYANZaHU6HsVIdp8uTZau790DMOfY7u2IW5FcstGUrjAc+wehiSrkUnFxGPpiX/BOXUwmY
 67ZJ3jpWY4rJTd2V76ht/E9VFP3Bs03d5MBBoBjmyaNSMuArbQybfC2tEp3Vro+lgKhDy03zhJ6
 +QpuAgxyt9G9oQuPmA7VDxk8E4WW+wRxIXuLiC+p+PBfQF6x5PtngY2t4eA==
X-Received: by 2002:a17:90b:4cd2:b0:3a8:a1f6:3b32 with SMTP id
 98e67ed59e1d1-3ae89772b3dmr14182837a91.38.1793889248197; Thu, 05 Nov 2026
 06:34:08 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261105-dw-hdmi-qp-yuv-v6-0-1bb63ef5766e@collabora.com>
 <20261105-dw-hdmi-qp-yuv-v6-8-1bb63ef5766e@collabora.com>
 <CAPj87rPk=girxTziKY5ROV3ZYqGhKRz471BLWpkCjtvNNseuog@mail.gmail.com>
 <7b86ca7f-fe7f-492a-bf88-0ac7afee3963@collabora.com>
In-Reply-To: <7b86ca7f-fe7f-492a-bf88-0ac7afee3963@collabora.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Thu, 5 Nov 2026 14:33:54 +0000
X-Gm-Features: AclHuK_cuDuuWPdBNDPf4-o5prQpG_rTSQHgkH5hHnp_VrKYmgc4urnB9GsSVjA
Message-ID: <CAPj87rMWa0wyopX6D2dUSYLXUYS9wvzVUFeKUh8coTxtF+Jf6w@mail.gmail.com>
Subject: Re: [PATCH v6 08/15] drm/rockchip: vop2: Consolidate HDMI PHY PLL
 clock parent switch
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andyshrk@163.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Daniel Stone <daniels@collabora.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, kernel@collabora.com, 
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Igor Paunovic <royalnet026@gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On Thu, 5 Nov 2026 at 12:56, Cristian Ciocaltea
<cristian.ciocaltea@collabora.com> wrote:
> On 11/5/26 2:18 PM, Daniel Stone wrote:
> > I'm confused ... if we have switched to the PHY for dclk, then a mode
> > switch wants us to come back to the CRU source, don't we need to
> > reparent to dclk_src?
>
> This is actually done in vop2_crtc_atomic_disable():
>
>     if (vp->dclk_src)
>         clk_set_parent(vp->dclk, vp->dclk_src);
>
> Mostly to ensure the PHY related resources are released when not in use, e.g.
> after unplugging the display.

Right you are, sorry I missed that one.

Reviewed-by: Daniel Stone <daniels@collabora.com>

Cheers,
Daniel
