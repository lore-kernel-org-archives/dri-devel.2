Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A0FFC98305
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 08:41:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52B0710EBEC;
	Tue, 22 Sep 2026 08:40:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bnFpp6YI";
	dkim-atps=neutral
Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com
 [74.125.228.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E2FA10E19E
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 02:48:23 +0000 (UTC)
Received: by mail-pz2-f41.google.com with SMTP id
 d2e1a72fcca58-85f0fc1fd8eso2520449b3a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 19:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790045303; x=1790650103; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=2fqnxRDPGydfMihJ2OX+RSCvcoKZzlenNPZIcztBjRk=;
 b=bnFpp6YIXVRr+yF/8F8FfHMMKsKfXhQja5GeDXAL8ZAYjfVlFm7qv2d5tMH3ziMZAB
 /PeMh6+e7VHtkYIsktIKjcyaf0l3+P0eAfPNtGCFCv4XKYS4/N8T6+1VN6Pnkl+PxYOH
 WXXAMYId9B1ns/bJ88RZldLRE30NViQuWt6O1CFWLpvHyVXqR/fXSKB69X3kvqBZ33DB
 DhGNGwld3JJu58Se0esZM9dxFzsxMN8cCac7KAlWx9BmJAvmHaPbh0/a34VhWufPgLNL
 GB87rDkUPZdyZScgv4yc83NQypEM5isOGXapMbnFFmPRUVc+EfpTpjVutNs2LmhafaIZ
 Sstw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790045303; x=1790650103;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2fqnxRDPGydfMihJ2OX+RSCvcoKZzlenNPZIcztBjRk=;
 b=UoqVLowx/tj9V245QTKK0MVrnvMPSAPJ5mKNpzAX2uJRbMEtntpuHPPePFGT9xQoLa
 UzGCEgglhSjloWk4Zm3qGC7pLEVPyrjTFYg11PWumji8sNPu/19Ov4e6/qcSyYSBVTfY
 FcY9Eitthp+S3MysiPvDuNjWJyywsK2P27/ObgnDrBDwqKn7/57eGwWnpstqmpycD5TS
 XZe2EwBTEkkUI9ZPDbFaZ3c+ZGqWnXgRCpjS2qwMQgDUw+iwiGDKOtY7fT2/fOnW9z6J
 3ZC41L/AmqrZF1mzGTxe5Dvu5w8hZglvPU5gs4PLJRDbEKCh/aZaMqqO0YUGd4J1CLrm
 EofA==
X-Forwarded-Encrypted: i=1;
 AKwUvBya27Z+lyngs8p/Z/M6j5Ofs1Wu5xVUUZgTaUYGGtPzWF83fusMVHfN5vgr65hKKoro9Yc7TvQU4kk=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mcnFNk+WMVfLQi5NiKG3CGeK5yPA+Npe7L4p5VtQ98UavlOmc3
 yAVPAw+D7FKSBIf4QEi3CRsysk/omBCaS4l2u47GVVXGSMEEt74iUEz7
X-Gm-Gg: AYBFou09Y06rBoHf7hiu5GcnEBKW+cRCHKzNTfe7LK0gY5i96iKImGGnYZOoUGxfFOo
 qTRxKlGFljp5Xs7z8la9d6PeMzip66jjblgbcpwzV9pja8YpRcU6abLS2vgz0adOx++hze7NvET
 67xZYXDQ5IDB3ILluixiv/tFNGoHauajZZI4fc8aTGTsN9ig/d/CKGPh2EHraHWJ6uBsXp1zKc8
 Dm9yXAHXr0DaifF72CfS05Ao6q9JT65uWEGdth3XBsP502VTw+7AyUHBMrtEZESxfq5tGARYBBS
 shSQ9y5ib9rqMhq3N7nMPCZtyb25zSYbU3L89s3sOQ0BnZkXOn1mEtXObXpXYqk5EQgLp+eciY6
 GYJjvAZD/wsmoN70flQbPxesLY+K3Ncef0ZmbnzKEk8yVFedA5Fsvs2LqGkxoPEAxlvJx7Icluh
 +7bLzzCz7KX4dayJhvKM+P8VwOLH7tPGAeh/En78jnOwnVaIykzXIPNBI/nsNPXdBOpazqjg2y9
 c/t+yA=
X-Received: by 2002:a05:6a21:6282:b0:3dd:a197:7362 with SMTP id
 adf61e73a8af0-3dda1977457mr14288897637.59.1790045302885; 
 Mon, 21 Sep 2026 19:48:22 -0700 (PDT)
Received: from localhost ([2001:19f0:8000:3e6e:5400:6ff:fe38:3d01])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc756a18d4fsm115091a12.11.2026.09.21.19.48.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 19:48:22 -0700 (PDT)
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
Subject: [RFC PATCH 0/5] phy: core: Use EOPNOTSUPP for disabled blob return
 value
Date: Tue, 22 Sep 2026 10:47:15 +0800
Message-ID: <20260922024724.191412-1-inochiama@gmail.com>
X-Mailer: git-send-email 2.55.0
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

Currently, the phy subsystem uses ENOSYS for dummy blob functions,
it does not reflect the function state correctly. As kernel already
has EOPNOTSUPP for disabled blob function, replace ENOSYS with
EOPNOTSUPP for a clear return value.

Inochi Amaoto (5):
  phy: core: Use EOPNOTSUPP for disabled blob return value
  ata: libahci_platform: Adapt the return value changed for disabled
    blob
  usb: dwc2: Adapt the return value changed for disabled blob
  usb: dwc3: core: Adapt the return value changed for disabled blob
  drm: bridge: analogix/dp: Adapt the return value changed for disabled
    blob

 drivers/ata/libahci_platform.c                |  4 +-
 .../drm/bridge/analogix/analogix_dp_core.c    |  2 +-
 drivers/usb/dwc2/platform.c                   |  2 +-
 drivers/usb/dwc3/core.c                       |  4 +-
 include/linux/phy/phy.h                       | 52 +++++++++----------
 5 files changed, 32 insertions(+), 32 deletions(-)

--
2.55.0

