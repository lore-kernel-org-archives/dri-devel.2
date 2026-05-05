Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB0D0CD342F
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 07:54:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8E4189A5D;
	Tue,  5 May 2026 07:54:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dKDfuqcB";
	dkim-atps=neutral
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com
 [74.125.224.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C69F89A5D
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 07:54:31 +0000 (UTC)
Received: by mail-yx1-f48.google.com with SMTP id
 956f58d0204a3-651d692e833so5063242d50.3
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 00:54:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777967670; cv=none;
 d=google.com; s=arc-20240605;
 b=UAbmUEFbuZnENZHSpOFVZpRE2uBN2Z2rSWS46VEqbqPVb4vsxjl/zLfWSOCL0jI92p
 VSuA+GfoxIp7n1z9LS3A0xkp9GJyarjLr6Ma85NNCbEMIgBoFhGt3sPZFwSsbd6mgaL8
 y647i3BMC982lnJnGIK8jGNtSIuhPnLCY210NWqBgiU0qEgDYYQuu0/TIuMVnx4E9BOP
 kWpWLGxj9Tt8bK5qrSZ8EGPL79cjs0Gn3KCByfKHOFbtRnVqJh+R1P7FOkit0R4EG9bR
 rD2yz0TFpZOwR14wGTsA7bvpOjBujecTam5Ry7CkjIw2k30SNN2Hs6wx/s8zPR4UOlga
 hJmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=+qJ4YHyeQCm/Bg4W28ChXgXo4YJ3WH+NhGRvqcilHzs=;
 fh=4hLljrXbysPYGzr5ONbZO4s87AkG2p86mteSja0dvP0=;
 b=I1mlJf7hIPbUws57e15YPEvpCzBXOogwUjsZzIMu+xKQjg5Pz2AVjVpV3xaILiGops
 0UApDpiDHxcvP7Z4ZaYEXKHUpLG5Y89eBssq79IrRO+kYcu9J0KA1hIqaUiMRrd7HFR9
 QagtQe5jkbk3Wr3Cfinv/DadR02ar4QGKcJdkGLgn80rlzwh0lo+Kgtqn+wp+Sjas9K4
 I/VJdlfYUYP6TC+xJi+Vf66ER3CNAy3UPEDBvzHlWWMky8LAyFyI0l+GUXC5WXsbb1mE
 jdiJ88ykBPViVoJfFPh6ZnOtieaeEJHayu83DoKjPDTzI2vSZlLKyezB6Ls+o6kUc19l
 2/Hw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777967670; x=1778572470; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+qJ4YHyeQCm/Bg4W28ChXgXo4YJ3WH+NhGRvqcilHzs=;
 b=dKDfuqcBbTvSvHDDNcMaak/oxGvajhGG8/L8WaEV21J4fZ+fe8VAPfGUuWzqnF8XLZ
 mRwWtOafQOBrcklGXtnXeHi5HHM8zvM7cu5dMIsfm0sqADJ7K6aVteATWB3Dmie6I1CB
 XkHTtZCFTWmu5dsVpQqvH1gn1w4PuZmzaB11t/b4SOWX/xy6b5Mi5+6eI6k9w7An+fBE
 UmLZMnlM/jjhuTG6W0miye9FBpYp26Q+tNcL0AscOnu2rxaeQs/yEHRajAQ57PL2OtQU
 XSd585nILIcZs1qcvIW50Fptt5J/UYDYCkxXi03fX11Is93e995dEzgv1j8MtljUTXi9
 JnDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777967670; x=1778572470;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+qJ4YHyeQCm/Bg4W28ChXgXo4YJ3WH+NhGRvqcilHzs=;
 b=QBxzPuhucfG0oq5telyz4F4fjtLQ2izJEHfJw9PE52EIbUPaxm4E7E+EMIb2Ryg3l7
 NR2uGqghFaOEKRklxyucmGVTDpTRLZQgUtjYerSCEqI0vA+DuzgGb/PSu8RDsZ7OdM2g
 MFI5w5hSAlzLP15gwebGtB8zUClWOkDQk+WK/JQu+gF2v9ZRUjEnvunTJIOS5SIPbMw6
 AaWCY7OuBmiFla8dtxiyB7pOK04L2hGuGcVXLCTwCnKS9ShG7lXqxEMnuupEc3CDMOjY
 XtqSBvJwMXhHuHyQRPLhf/Fnr3Zu0aKHFgORfTecA3gItSCYH/hCHxSCz25POmkSMX72
 Ll6Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ/X+HWv+zifgMHdLdWsgPZw/npBJtZvrPEmijSIcVc7rMTEt28j8yCOaDcWgjacIkTfw3WHgOyjczE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxXALV0a0uvLlyVNQ68RQRzTg43pM3/AoonoVaiELMay3R61Isj
 GIpkuOqY9oucuPp6E1ng/3YXV1akXYzEjmXmC0H3pyAvlYcAJkE4aU0OKRrOPfUaCM6+HWBiFjR
 P03VpJSlBahOu95JQbNWjlB6jTee5S4k=
X-Gm-Gg: AeBDiethoXqbWKwukI9AKuiYkH4SnTiGYsjPDxnSf64vmj2G2Vvb1ResgT8IYxfHSHo
 KqCfIzrDfzzpdzOKwXUpfL1QHeVRtxeYi2sJShnytgzGnlSGe3lfuJ/wR9CxOrpb3xC7D9iAQAF
 WIii++Cs+iX/CSLK2XGj4eb3bK21om4rLL+952RI0Wz2CGItNz3NJSsFL7F14pyz6TpFk4dsIp1
 FQ/Lknt6l46mJlf/8qsLVd/xT5D921+hJE0F8rjUs88vbOMUp/ahk8CIv+hm0vHWKwpPEvd10Fl
 1rbxr+gtdFsdAU1CCPk=
X-Received: by 2002:a05:690e:130b:b0:65c:391:4553 with SMTP id
 956f58d0204a3-65c3d972826mr13438227d50.2.1777967670455; Tue, 05 May 2026
 00:54:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260502115528.530401-1-lgs201920130244@gmail.com>
 <afju2dg8fZ_RSD7-@lizhi-Precision-Tower-5810>
In-Reply-To: <afju2dg8fZ_RSD7-@lizhi-Precision-Tower-5810>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Tue, 5 May 2026 15:54:21 +0800
X-Gm-Features: AVHnY4LouAC2lU1dj0J8xcKYYWaYsdxpQJ4QBxgr9v4zBA8FqVVNp9OP76U4_MY
Message-ID: <CANUHTR8VCdYS1NdTXU_P1hAkCwiZ=pbTApv3B3ShLB678Son9Q@mail.gmail.com>
Subject: Re: [PATCH v3] drm/bridge: imx8qxp-pxl2dpi: avoid ERR_PTR with
 device_node cleanup
To: Frank Li <Frank.li@nxp.com>
Cc: Liu Ying <victor.liu@nxp.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 dri-devel@lists.freedesktop.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
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

Hi Frank,

Thanks for reviewing.

On Tue, 5 May 2026 at 03:09, Frank Li <Frank.li@nxp.com> wrote:
>
> >
> > This issue was found by a custom static analysis tool.
>
> Nit: needn't mention this.
>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>

I will drop that sentence in v4.

Best regards,
Guangshuo
