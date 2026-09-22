Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32FA3C982FF
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 08:41:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F4DC10EBEB;
	Tue, 22 Sep 2026 08:40:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KVWpKFuS";
	dkim-atps=neutral
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6580C10E19E
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 02:48:34 +0000 (UTC)
Received: by mail-pj2-f13.google.com with SMTP id
 d9443c01a7336-2d747ee1f38so37091555ad.2
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 19:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790045314; x=1790650114; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=26rOLZ6VAdNb1QMWubw0rV33TxsyOkNQWkVFzg0YEAw=;
 b=KVWpKFuSFKZB/HdHm0z9OZgY5Qu0TbyIngRe0knOewfKp8q/mm43LXht236lMrdhUb
 yueMfVuasToILpGTu6ebZdjmpaTjCAAvouZ8CmRXnKF63yMw/8gvXrm9Y74Q1NkDA344
 cpTjLkqAeFadRbuV9fyudeSoFYQpCKmpWqUc/+JMprFP32YRKkLWScastpBgknn6VeLw
 VsfM9NGgM3DgQ7kZN1G9tnm2HlOkiOA3yuDnpBJOo5dkOMVRbnd3V3izxna/Mocv97A1
 oOB/j/9OtU2MKuN6j8FHQUddseRyypr4djPUZT093+3jX4O4ctmFaxzez6R0kcs59JDk
 10qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790045314; x=1790650114;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=26rOLZ6VAdNb1QMWubw0rV33TxsyOkNQWkVFzg0YEAw=;
 b=TPoctCLPkJ5CTpbSP2ieDkz/PJZSwcdut2REW6238uacav7ao4LN3MxKwrfHY1Zi35
 eSHg9CMjg0O2h0U3iZDmNdVeeCUG4GYR9BUnVpnbegzlD94Pz4+9SRYBIqQqH6KsXkRi
 l6PuLCRoEKXZ/mtiTIkxwMaROO0jv2nNpUMVMAQlVPKuOQVLl27k5TP9IJP1KaOens+U
 oKEJgZG8QRw88r/i3ywVzClCUttw5phNr3hjw2btsxNrf/lwi0K79UqODsy/+h47Clc7
 9vaG/5JxUiDtAVrnU7BBRYbXBLCO7ajZsih2cH3yCzVpm7hB3bcYhyUgdUgm769lxRLr
 3z/g==
X-Forwarded-Encrypted: i=1;
 AKwUvByrGjOMccBuHnIOfLCXPsn3WTXQr2bbOIQRmtXC60dXoCPLFvu0FYkHudv8yyFaW5pib3KIpV3uog8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++knjBf2X0dV6Ikh8NlYgDBd8+OvPijYWlYiBYLvzmiTfqUURyV3
 p8fkDWc4Oc0h3K+dHKwgTwYkoA4QmnLfug+Z+aw5EE9QpZZj/jzep9rk
X-Gm-Gg: AYBFou2xd9T7gS0VjstRf6DV1NUOl++ALDn6QiZQA0yu1NDJTcNTLhkKD7WerIjDksy
 LcRK8DHQ6OnKHA9JfGUMzX5yUmUvYViVF413fAc2SUtDf+wA/CRNWvjHx+u6LpDckiklkjjcUXp
 k4IiW6L/Ng1hhM4x9LEZdJd6Ffcjy0dGQGw+jaqSoi1TISDGc4hTAd/8P45PpMILNRS4HfhwcjH
 wxQ1BgHPkM2f4UcWg5e/J2FiIfDdVHFd0Sc4kqk3B/SwuFjUS+7tyqlhyaIxC76lptICEw3cMoW
 8dDJLSEwsRPf2zfXj5RsoSkGR4nzQlK2FzopWbjGF+0DFeT+9URI8b5niw4RYmJzf7uL5dVJ+6o
 aQj5/Ao9tsjyPvGuMoqmhL/fgm1LK9wPwTC+0vPZAmg8jt7/E+pt95LdUI888Ipyc7XgBZUB830
 el5tvyJxW8T1h8T/Ho9LrpAMhTfedi1GVXTvrZ6WxIgQbmDbtfGVrrhb3Qjj740Iwu+jdF2Q==
X-Received: by 2002:a17:902:c402:b0:2d7:3f6e:5cb9 with SMTP id
 d9443c01a7336-2ddb1b7a04cmr194077855ad.8.1790045313882; 
 Mon, 21 Sep 2026 19:48:33 -0700 (PDT)
Received: from localhost ([2001:19f0:8000:3e6e:5400:6ff:fe38:3d01])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2df5d06808csm1648645ad.83.2026.09.21.19.48.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 19:48:33 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Hans de Goede <hansg@kernel.org>, Damien Le Moal <dlemoal@kernel.org>,
 Niklas Cassel <cassel@kernel.org>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Minas Harutyunyan <hminas@synopsys.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Vinod Koul <vkoul@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Damon Ding <damon.ding@rock-chips.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Heiko Stuebner <heiko@sntech.de>
Cc: Inochi Amaoto <inochiama@gmail.com>, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-usb@vger.kernel.org, linux-phy@lists.infradead.org,
 Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Subject: [RFC PATCH 4/5] usb: dwc3: core: Adapt the return value changed for
 disabled blob
Date: Tue, 22 Sep 2026 10:47:19 +0800
Message-ID: <20260922024724.191412-5-inochiama@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922024724.191412-1-inochiama@gmail.com>
References: <20260922024724.191412-1-inochiama@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 22 Sep 2026 08:40:51 +0000
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

Check EOPNOTSUPP for disabled helper function as the change in phy core.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 drivers/usb/dwc3/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index fd5c2cd36c59..6d253810c71f 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1588,7 +1588,7 @@ static int dwc3_core_get_phy(struct dwc3 *dwc)
 		dwc->usb2_generic_phy[i] = devm_phy_get(dev, phy_name);
 		if (IS_ERR(dwc->usb2_generic_phy[i])) {
 			ret = PTR_ERR(dwc->usb2_generic_phy[i]);
-			if (ret == -ENOSYS || ret == -ENODEV)
+			if (ret == -EOPNOTSUPP || ret == -ENODEV)
 				dwc->usb2_generic_phy[i] = NULL;
 			else
 				return dev_err_probe(dev, ret, "failed to lookup phy %s\n",
@@ -1605,7 +1605,7 @@ static int dwc3_core_get_phy(struct dwc3 *dwc)
 		dwc->usb3_generic_phy[i] = devm_phy_get(dev, phy_name);
 		if (IS_ERR(dwc->usb3_generic_phy[i])) {
 			ret = PTR_ERR(dwc->usb3_generic_phy[i]);
-			if (ret == -ENOSYS || ret == -ENODEV)
+			if (ret == -EOPNOTSUPP || ret == -ENODEV)
 				dwc->usb3_generic_phy[i] = NULL;
 			else
 				return dev_err_probe(dev, ret, "failed to lookup phy %s\n",
-- 
2.55.0

