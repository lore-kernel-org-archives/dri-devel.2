Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39BEBC982FF
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 08:42:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6407010EBE9;
	Tue, 22 Sep 2026 08:42:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TlsEcLw/";
	dkim-atps=neutral
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27A7110E19E
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 02:48:29 +0000 (UTC)
Received: by mail-pj2-f13.google.com with SMTP id
 98e67ed59e1d1-396ccda24a3so2758101a91.0
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 19:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790045308; x=1790650108; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rWmT8GXNkKIjtVq2Tp5ZmO6NxHuTlquOEZj2eN8N3GI=;
 b=TlsEcLw/3yYke/0R8+H3d1tdH8bdInZLlyMb5aid3KA92fwX8J1r3rSFQ4K626TNwQ
 ww843mTbA1ZQmF6ZG7/ZSd9PLTcKlF/ply12d3P4dADFovsVLjpdZDDRpINRoc0VmTW7
 eDoHmqF5Wx7B0i3HPwUjET1A/t3xHyMsFpXH0m7aiuBRPY4DcBpwto25ek0iopq1GgZX
 TtVbf/uOSccn5wsxLnwVL9LWIjCogSqJRpbaKAmgcSn0wtwrLhjUt9S52m8M/xV3WVDj
 3eVTBAit50xbahRA+yvj+9qcojq7l6GE/hU1UQT3/hXf4GQcRIgt9YDWc8K1Jtg84h99
 ziGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790045308; x=1790650108;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rWmT8GXNkKIjtVq2Tp5ZmO6NxHuTlquOEZj2eN8N3GI=;
 b=JuPH/X3F52f98bmbsRP7pts6fC5fTDpaHHgLaRzfj5BSsNQ1/9rCpQevU6Fu/2mrLO
 +kU0tWmI7fTNq9dL6Ozy7Dzw22WInPkvvRUu+Nkl7ajMv+bdH9wSXF5PSM1QOQU1Xkct
 wxXTLnyN4BZ7qg+Ah/ZBjTMxjinHWVtSIs2QBshHOBijeMbCjK7j0TsWH67lFn4h8SzS
 OYU1Pw3kNXFCJKSnXuVfEEdE4SRaiNBhLyPL8hsL4p5/DfT7GCP8SLjSobA48gYfBUOi
 +h0l2P5rRYgwyhVaSvt1YMufzXO/6tetLAVQsh+isHBb6eGETpFKXyLfYHb5L2HUAr9/
 aaEg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxq2KPYYU0MYcaqbhFp6bE0ZMGmk6wKU2YZFdMZDo5FSa+shXv/Fg11BKd53dXUiBlt28k+cydeyz4=@lists.freedesktop.org
X-Gm-Message-State: AFuF++l0LHmW1u/NzFJm9s4nEciTGmF32fWQ7O5IQzcIB7u0O6cuQTf/
 qp5UYH8fJwJ5TEDWg5KURgoJ2njLnEbIjXJ905g/EeKo5c+/wvcxbuAI
X-Gm-Gg: AYBFou3OWhae123QhvzDO0CLA/CMOlyMv9naDveLE3ZbOqqE5BsdT70gfbPX3l8v/7v
 dW/SfDxKD1aVbtJhJvA2YXJ2Al17AChelPO4laVfpqX9Bd8q0W4umG/RWlioNTzFXZ6fNpQ3Ymy
 B6JX58tnrX9CCcoAw90ilRlQ3JtMYZ9vAFTVzjOfiROukjQCDxUuhqYmoH5ezXzSgKTAbABn/pQ
 k3cEA7t+M8QqKQQNbLOlLGt/UX80WRwa5MLlrhkFjkQJgbz4M2UMNrT3I0vVTkCXN7BMVXJN6Kw
 T/j0D6C5Vb4woJfzgV4K9f70tZc/PD/aj2kcOlnDZ5kWF0hiWMW9j575u++fcTQiNKAHNxJnnVo
 xAyPmA+pTQQZp4C8NkmWO0mdBMGUISw5bbotH2pR31KaSSh5xLBszDYsBl/r5Nf54Obvb6QcA6T
 q3saAFTa4UmwiSEVhKsG/OE1/XsxPsGrysatjZdC/gJLgH/zeoB4hs8cRUW9zMYh2VN88/hzN8G
 msFOcYd
X-Received: by 2002:a17:90b:224c:b0:39d:f317:44cd with SMTP id
 98e67ed59e1d1-39e54eab3dbmr22577003a91.14.1790045308578; 
 Mon, 21 Sep 2026 19:48:28 -0700 (PDT)
Received: from localhost ([2001:19f0:8000:3e6e:5400:6ff:fe38:3d01])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a06caf4a73sm297312a91.2.2026.09.21.19.48.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 19:48:28 -0700 (PDT)
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
Subject: [RFC PATCH 2/5] ata: libahci_platform: Adapt the return value changed
 for disabled blob
Date: Tue, 22 Sep 2026 10:47:17 +0800
Message-ID: <20260922024724.191412-3-inochiama@gmail.com>
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
 drivers/ata/libahci_platform.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index 6e072d681341..3e8ddbeb49b3 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -371,11 +371,11 @@ static int ahci_platform_get_phy(struct ahci_host_priv *hpriv, u32 port,
 
 	rc = PTR_ERR(hpriv->phys[port]);
 	switch (rc) {
-	case -ENOSYS:
+	case -EOPNOTSUPP:
 		/* No PHY support. Check if PHY is required. */
 		if (of_property_present(node, "phys")) {
 			dev_err(dev,
-				"couldn't get PHY in node %pOFn: ENOSYS\n",
+				"couldn't get PHY in node %pOFn: EOPNOTSUPP\n",
 				node);
 			break;
 		}
-- 
2.55.0

