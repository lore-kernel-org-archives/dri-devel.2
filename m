Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BDE606A325
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 11:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=thundersoft.com header.i=@thundersoft.com header.a=rsa-sha256 header.s=default header.b=BV4ItemZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 502BB10E9E9;
	Sun,  1 Nov 2026 11:58:13 +0000 (UTC)
X-Greylist: delayed 302 seconds by postgrey-1.36 at gabe;
 Fri, 30 Oct 2026 09:30:55 UTC
Received: from mail-m12793.qiye.163.com (mail-m12793.qiye.163.com
 [115.236.127.93])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D26E1126C4
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 09:30:55 +0000 (UTC)
Received: from ROG.. (unknown [36.129.139.90])
 by smtp.qiye.163.com (Hmail) with ESMTP id 52ee543f7;
 Fri, 30 Oct 2026 17:25:48 +0800 (GMT+08:00)
From: Hongyang Zhao <hongyang.zhao@thundersoft.com>
To: m.szyprowski@samsung.com
Cc: Laurent.pinchart@ideasonboard.com, andersson@kernel.org,
 andrzej.hajda@intel.com, dri-devel@lists.freedesktop.org,
 hongyang.zhao@thundersoft.com, jernej.skrabec@gmail.com, jonas@kwiboo.se,
 linux-arm-msm@vger.kernel.org, luca.ceresoli@bootlin.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 neil.armstrong@linaro.org, rfoss@kernel.org, sam@ravnborg.org,
 srini@kernel.org, tzimmermann@suse.de
Subject: Re: [PATCH] drm/bridge: lt9611: Don't override ADDR strap when
 strapped low
Date: Fri, 30 Oct 2026 17:25:27 +0800
Message-ID: <20261030092527.131154-1-hongyang.zhao@thundersoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261030074518.516993-1-m.szyprowski@samsung.com>
References: <20261030074518.516993-1-m.szyprowski@samsung.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa18c21340b09d5kunm5772b0bcae8a9
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDQk8eVk5PTkkaGUlKT01CGlYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlITVVKSUJVSkhCVUJLWVdZFhoPEhUdFFlBWU9LSFVKS0
 lPT09IVUpLS1VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=BV4ItemZ+Xnop7V3RPgdwKTM0L0gJEJ/FrmBcse5yBiO2lLSFUVFvJ1LJ5NVLN3eAHw+cJBZRCz9uktLHyzrolyGC297FoVZPyRsmTS154RX6tvMrMyvbGRWxTo9NNcsAvuOA/24p08GliLzVL9vPPJwm/3+fDqwur0IbaY8lXE=;
 s=default; c=relaxed/relaxed; d=thundersoft.com; v=1; 
 bh=AV6l8V0MXNjptQC3bitgmPWMkuz0AafRUO/XZ5Ldxf4=;
 h=date:mime-version:subject:message-id:from;
X-Mailman-Approved-At: Sun, 01 Nov 2026 11:58:11 +0000
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Marek,

On Fri, 30 Oct 2026 08:45:17 +0100, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
> lt9611_sleep_setup() writes 0x8023 = 0x01, which overrides the ADDR
> strap and moves the chip to I2C address 0x3b, and then configures the
> ADDR pin as an output (0x8157/0x8149). On boards where the pin is
> strapped low (address 0x39, e.g. Thundercomm RUBIK Pi 3) the chip
> becomes unreachable as soon as the bridge is disabled: all further
> register accesses NACK and on resume the bridge fails with "power on
> failed", leaving HDMI dead until reboot.
> 
> Skip the address override and ADDR pin setup when the device sits at
> the low-strap address.
> 
> While touching this driver, also fix the misleading error messages in
> atomic disable path.

Thanks for the fix. Tested on RUBIK Pi 3, and the patch works as
expected.

Reviewed-by: Hongyang Zhao <hongyang.zhao@thundersoft.com>
Tested-by: Hongyang Zhao <hongyang.zhao@thundersoft.com>

-- 
Hongyang Zhao <hongyang.zhao@thundersoft.com>
