Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B43FC982F1
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 08:42:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95D0710EBE3;
	Tue, 22 Sep 2026 08:42:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="crkDAUl4";
	dkim-atps=neutral
Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com
 [74.125.228.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF53210E19E
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 02:48:31 +0000 (UTC)
Received: by mail-pz2-f43.google.com with SMTP id
 d2e1a72fcca58-85469d249c4so3240600b3a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 19:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790045311; x=1790650111; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5WX6Mfh4l0Vw/8UzDpK6UHvwa+BQE0w9TDFZftgIIYk=;
 b=crkDAUl4jF5nIzhY6XM4+UkNkKyKEFwaFVqsWPkAmdGvF6ThUXPQswIWKgWfawRZg7
 NeuhjLPyaaEuQLzc4/404r02iJW1REghFL7wZcem1IRfpONDIXi20Nd8SMI6fhnZTRDM
 JndOgGh0cab6BSwfW5bqwHQ9IB0EeqBOla1Pn2xR/Qm3fdQCOxi8/qE8H/5ASOHLzAmK
 4ikxRLO/KXchQasalSrzT5Mzi5D6ILBkTJGlXd4n1KTvf4UPO40TOQNgChLJDAq2Q4nZ
 qI4kC9FHld6oYkBMDL1fYJCQmrv65jVr9osccRb97pRgjFtqfG8+LaVWZDvrbuIb60Jb
 eZsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790045311; x=1790650111;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5WX6Mfh4l0Vw/8UzDpK6UHvwa+BQE0w9TDFZftgIIYk=;
 b=SCQ8n1JMn3hRta29WxMgWiiyrg5Qbb5daHKPuja0xr4w6ONbjwTiPA0CvTq0MPrOUw
 fyFWTBntTkkiLONHez2PO5I5BnoeIHi7TxO42ijkqGJbyTUIQkrFSH9bHzzyV0sKkD1Q
 SOLKo8nhVo2JCfi/KiwBCucHlF2Q/Z9WjsseSTzaLlWH9UpDcm6Seq7X8XyYT4OHHQQp
 tVVKvOfSnDsPaYt6L0QJ0h5kh7RWwjghWoDZwlXoYkdRD76Fj22XXpiH2WfUT4l5Uz1Q
 nOsU6b374rqDNQZ3/dJhMgCHyX/PiTa7q74ngb0FaeNbLeNcI5HTCnggXh7Vzxucmqg+
 +0Bw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwD97LX7YEYxPblAGSdhz1fL+rcnv4sPUSCiXE3Pr4pRoMXQt17+BKIYR9/lo/JyQwmJSSV7eO9zS8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++n7NgBqiWeEK+2q7HwHDuWXnnoFWboDXwdVzi4gfSDUCY0ptTB2
 vve7x6vzrsRUouxK786HfHpc5/HN1XtpaEGhJmQIOmwshozxGpD0EAAD
X-Gm-Gg: AYBFou2V2cPB0sIM85HaKlrqgGgAqSpCrMWgkf71d05L2FBbZCS5OrooPZbmiqYHH58
 VxkK6HBK/RCLTeqJR2fbHhRosr2k24hmCB71pYLO0plj7j3w0QuVYMiyrn9l7xmVIHJTCar2ASY
 nBgGqAl8QTrJNSsK/6VpK7VmZi7cJUak3YdzcVaodYOkjfLHvbgxr4hNtisnyaAwA7ves9kBYCK
 OuJyD4gd6pZjqR2yX7Tjv6mcfP+altZpe8z/E3IhFo5rnwQgejnglj858fS3c42kmnzU1q4OBM5
 fSyG8Ha5rMWfbB84ho9OKcQyPU5M+iGKXKwxZ8SGo1XlbGC/av0mtrkdYOaZuOx/5j+AWQbrFrq
 p1c3D4ZKqi03BhInb+2K2JTLnyNA6UzuAj7V1cQgCijQQLzOcXol2WJv0+hXeDBgbSCnZeqxTNY
 qU1dB+1QoPZ0V4cccxg6rxgW99nOC+OQ38fz9ox25wq//KzbhWJ4GitKX3zkfRdi32/P2t
X-Received: by 2002:a05:6a00:278d:b0:879:ffd9:126d with SMTP id
 d2e1a72fcca58-879ffd91ae4mr6025072b3a.15.1790045311312; 
 Mon, 21 Sep 2026 19:48:31 -0700 (PDT)
Received: from localhost ([2001:19f0:8000:3e6e:5400:6ff:fe38:3d01])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-87c336aba96sm112998b3a.61.2026.09.21.19.48.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 19:48:31 -0700 (PDT)
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
Subject: [RFC PATCH 3/5] usb: dwc2: Adapt the return value changed for
 disabled blob
Date: Tue, 22 Sep 2026 10:47:18 +0800
Message-ID: <20260922024724.191412-4-inochiama@gmail.com>
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
 drivers/usb/dwc2/platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc2/platform.c b/drivers/usb/dwc2/platform.c
index ef0d73077034..62b663ef1504 100644
--- a/drivers/usb/dwc2/platform.c
+++ b/drivers/usb/dwc2/platform.c
@@ -243,7 +243,7 @@ static int dwc2_lowlevel_hw_init(struct dwc2_hsotg *hsotg)
 		ret = PTR_ERR(hsotg->phy);
 		switch (ret) {
 		case -ENODEV:
-		case -ENOSYS:
+		case -EOPNOTSUPP:
 			hsotg->phy = NULL;
 			break;
 		default:
-- 
2.55.0

