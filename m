Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6512606A331
	for <dri-devel@archiver.kernel.org>; Sat,  7 Nov 2026 14:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tYhCA5HG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAB8310E62B;
	Sat,  7 Nov 2026 14:27:50 +0000 (UTC)
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com
 [74.125.82.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F92E10E4DA
 for <dri-devel@lists.freedesktop.org>; Sat,  7 Nov 2026 02:12:14 +0000 (UTC)
Received: by mail-dy1-f173.google.com with SMTP id
 5a478bee46e88-35829219da8so271532eec.0
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 18:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794017534; x=1794622334; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=agfHd5pdc/EdSGq69ep6mXfkA+pM523Mmt9NosKXhZI=;
 b=tYhCA5HGhVxR+zAfP1G8S2HNWoQVP6GS7MMHWjPUp+/e6hK5hakaGeX1KJfBdNJgce
 MhEcBkM9M1i0GZmpZhcqOR+khcj8vSLnOXn9VGtVUi6Pi6LzZ2i+CJ1+lMkMveLx+6bz
 mkcgkfQfcbjVr12lCn5gYGfxIzwMS4edBHTr7++JiNktKOHwPZNPA7uegGL+I4reMyJ4
 QHgsRK+P2U/JPupd+kp/rV1Lzo4pSUT5qoJuy+JVYq5Tpmx1Q7FX52XJ8C7IKscfXbr3
 oh+uRKurIz3yPhLH938kF4KwpbZfi6IwfHEYmUuzQzA/8Fv+SEdqS/DBMr3UtQgwgBZo
 HvVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794017534; x=1794622334;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=agfHd5pdc/EdSGq69ep6mXfkA+pM523Mmt9NosKXhZI=;
 b=EpgOlN8lHBUvK3GaXGle1WckgBfiyHps4CNtEg5DgRh0g1L6pEIuuwNMS42c6JtHgl
 b7Bw4H0u1qTQcOpFIhoHsxN8sTjvNpLu+cgJCPrRuxUxx29I4fk6RUT23Bbeh17hWBgk
 Deda7rD3l+uuGQqWl6KvkAqn27xkg0BtV2/26naxHwrjOkvrfx3ePk8RPJqWgateXEBq
 3/+cnY6URU+cEHH/oql3h2wQRLAUbregRX16s9c31zLcxUbF2frPdpVeZ8WruEpW7qaZ
 RVSYYPGzBuYaIW3n8oSdg/ZPqyr75B1JEL4b1GFItUljJ4FpjYsdquzLOoW0m/x7vhrK
 KJEQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGMXWd8lNwbLyM3IASHJK6N/1sqtzT/8zLcVUs4fzOdsidROTE+cR6obKyZX7iRmxjTWvQJTHtIIBo=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+c8ZywImqFyfXZiIewzi1wOQEF4huyPkOX3/n24+SWLdkgqtNW
 cxYvGIAePxLioGFrLcUcFacFTPllGoCNaahlchdJi3lJdHbcVCcwXY5h
X-Gm-Gg: AYBFou3qX8IQayvDbMxf1omE9PwMX0QHboW08wA1YJBi/TCuZuco1iJMwF+Cops3qS/
 Ed+QLmkvvUSswtmF2aJLa+G0fZ8w2dW1c/eoRX7iZMHHoKfHv1Sn9tcMoyCNjPViKMtHbnbHNpT
 qkjTGCSpQj/p1TdjqZPJQ+/jSGpFoe+CrgdnCn5JJkemYzmMhggn5TYJgujlJEewRPXI4R5hnWj
 X+0+R/5Ug2AIrELfAi1tmaxtK9R7bcokicZqztfkjRIQsdgRDqJCCkidv2xOE0V1bLjA4lh0Pzv
 lO7Ea7Qx6ZR8+E/C/qtAje3Ve9+Vlg29tmmdAH3hbGiJdioBhLUX7y9rsILrj3UuQyYl+IFUTzo
 wy5trouXlZ0nLDJmKAfbk8VfSe+nPXpGkFXCq/oFjLmC1atpjaCFNpvAKKdHyRuEySfpBMK3lfK
 tGKC0pmC/hFawckA+jQll2n/FUZppwsRv2mStZGkxSk9o47Kskr7bfiuxBLSTLlmAU56bGqaaWr
 6YheaP23Jg8PAa7fq4YdIJk34X7zfOkfbAVEYTDgVeufzBoJxeK2NDpSKh7VPKoCAA8646IWpC5
 YvM5ubWdvY5Lt9QOOxNxh6NWE/Qx/SHHBgtWIHiCdnjys4DF65PyVwady6jNLRSqVA==
X-Received: by 2002:a05:693c:88d0:10b0:361:2a55:b94e with SMTP id
 5a478bee46e88-370f71bacabmr1019359eec.15.1794017533493; 
 Fri, 06 Nov 2026 18:12:13 -0800 (PST)
Received: from DESKTOP-NM9EKIA ([125.134.240.130])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36faa4b8aacsm10374563eec.23.2026.11.06.18.12.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 18:12:13 -0800 (PST)
From: Joonhoe Kim <26rote@gmail.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: aux-hpd-bridge: replay last HPD status on
 hpd_enable
Date: Sat,  7 Nov 2026 11:12:16 +0900
Message-ID: <20261107021216.952-1-26rote@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.5
In-Reply-To: <20260803-drm-usbdp-preboot-v1-1-2539b362be00@oss.qualcomm.com>
References: <20260803-drm-usbdp-preboot-v1-1-2539b362be00@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 07 Nov 2026 14:27:39 +0000
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 03 Aug 2026 16:43:08 +0800, Yongxing Mou wrote:
> If a downstream consumer (e.g. drm_bridge_connector attached by the
> msm/dp driver) registers its HPD callback after an upstream driver
> has already reported a HPD event through drm_aux_hpd_bridge_notify(),
> the notification is dropped because bridge->hpd_cb is still NULL.

The same happens on the Lenovo Y700 Gen 5 (TB323FU, Kaanapali) with a
monitor attached at boot, when pmic_glink_altmode probes late because a
mode switch it waits for is a module. A kprobe trace shows the HPD event
from pmic_glink_altmode arriving with no hpd_cb set, and the DP driver
enabling HPD about 2.6 s later.

On the two Sashiko points: I tested a variant that replays the status
from .hpd_enable directly instead of from a work item.
drm_bridge_hpd_enable() has already released hpd_mutex when it calls
.hpd_enable (only hpd_state_mutex is held), so drm_bridge_hpd_notify()
can be called there, and there is no work item to cancel on unbind.
That leaves the stale status. A mutex in drm_aux_hpd_bridge_data, held
around storing and notifying in drm_aux_hpd_bridge_notify() and around
reading and notifying in .hpd_enable, closes it. Roughly (plus
devm_mutex_init() and the initial unknown status in probe):

 struct drm_aux_hpd_bridge_data {
 	struct drm_bridge bridge;
 	struct device *dev;
+	struct mutex lock;
+	enum drm_connector_status status;
 };
@@ drm_aux_hpd_bridge_notify()
 	if (!data)
 		return;
 
+	guard(mutex)(&data->lock);
+	data->status = status;
 	drm_bridge_hpd_notify(&data->bridge, status);
 }
@@
+static void drm_aux_hpd_bridge_hpd_enable(struct drm_bridge *bridge)
+{
+	struct drm_aux_hpd_bridge_data *data =
+		container_of(bridge, struct drm_aux_hpd_bridge_data, bridge);
+
+	guard(mutex)(&data->lock);
+	if (data->status != connector_status_unknown)
+		drm_bridge_hpd_notify(bridge, data->status);
+}

With the mutex, the monitor was detected in 2 of 2 boots, and 2
replugs and 2 s2idle cycles still worked. An earlier version without
the mutex was detected in 4 of 4 boots.

Dmitry's "drm/bridge: aux-hpd: let drivers pass IRQ_HPD events"
changes drm_aux_hpd_bridge_notify(), so v2 may need to go on top of it:
https://lore.kernel.org/all/20261024-hpd-irq-events-v8-5-6ee949e7a384@oss.qualcomm.com/

I can test v2.

Thanks,
Joonhoe Kim
