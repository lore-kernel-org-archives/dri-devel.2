Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F326C55174
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 15:34:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDF9910EEAE;
	Wed,  5 Aug 2026 15:34:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fk09xZF+";
	dkim-atps=neutral
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E482B10EEAE
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 15:34:54 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-47df6a5655aso147599f8f.1
 for <dri-devel@lists.freedesktop.org>; Wed, 05 Aug 2026 08:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785944093; x=1786548893; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=K7C5bX9yrteFlRiHmbAJKSV1MNI7QdrKD956BMaNNmc=;
 b=fk09xZF+tpxm2ta40Jh4nhIZa6lhU27axE3wUBVZZx11q2IORlNRqscnHGvKNmMYuz
 JGX4I87kDmZgv9s9qeMbWbxc8y/WFys21tLsQmHLxCT8h4GrZGJ5VS9tRbQAdQMq71W7
 Bo91DyyKp07U/NiAZZguhPeYRYyUQu2r1WYakbjt4GtBF/nK3ApHZWVnr7j+E3TlcH03
 Sr2AMy/o3PO9kt30N57SdcghAKPqc+OnzbO5S0n+kATLJ8m8ZXn266zSrurLk6/Vz/qM
 g++yzqvmmcjED2EkVm/q38ZY9U5iEKX2C8WZMcrWscvBWlhWQCYpF+GbtYIw8H3fHydQ
 lMZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785944093; x=1786548893;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=K7C5bX9yrteFlRiHmbAJKSV1MNI7QdrKD956BMaNNmc=;
 b=k3P5Fq3nuEvI1ticvbZ8vhXPcEzXGvxlYnRFF8pVG+j3yr4Hn0CHNefXC2B4kiEL1q
 vxfVIWRZx8zfBNpLA5IZGG4rOImrxqC8c02ftgvj2X5cz7qdVfh7pDsgo+f3WkrvA4pd
 WsVInHSd/VdZqkgHzi133LM9H4QsUrQVaiLuwme4gL/lxp3nvpELBCvQweH/Gvc7qxyr
 IW08+iUkR1v051H5EyJnzUUo8P7dZCLs5UeOIbICVpjQveVk6Ng0sw2Hp5sn6uEY2vQ/
 Df5TegpqxlFu66n6BPs+FyTJGrnbWamb/9dXa3Ury0T5J4nzGMdYgyqAywEegj0Cirs/
 g12A==
X-Gm-Message-State: AOJu0Yw37fvjLUdLKC08MboTQP/OI/dv3ATujUQILi3LD4ZHxS05Z9tQ
 2fMBEQPGwHw7ce9f91jCNev0+57DVv67LbwiXsP7XLbZ5WWjjmfYouIs
X-Gm-Gg: AR+sD116uvsSqUSDFD7kAT4XHdpA2uBvoEXaIatSJTjSdBC2FTbOqi3RyaqKPMLJQh4
 6ngOCzY9y1tw563f1+aOYg4k7UdZmKtB4kpBkNtJNzmflpJGTthnyLEV1M5v8yJWVkNwL9fIV68
 5yxYjmBJlZiXrlejO+Jdc4789OAqgPmqRYg0ytjKfiwJW7DpfC407OAywg2TJVW1cDmAVT+iW5d
 tUEvvpKp3Gakb6lsaRKWSahe3+v+cZk8nD569DvWTRH3TtCE/y53lmq2yJYIP8DbpTgcd/UaJdG
 K2GBRk0g+Oaq/1v9WZvFssZBoCLYFoyohWCXMLiyrYhvG+Ac8cwSTsRSQkf0OjA6bXml6P3bZzi
 QFOQBR705A+njdqNma/4BBnySQEGg/AKDinBc5daNoBnyaAa6bfil4hG0EO1ewGMBDGKnebEN3i
 jNRKCSziKEM3CzLY/aW+n3kx591BiGeN6/2M6SLa7OnqhAaVlRxOE+DhjditSX+wEwo6LUdmCgZ
 3SPrW/ApRLaF4np3VFaXni17kqHDImLau+zhDH0uEw/6GpIRxv7GGdeMy1LOxN5FvPK
X-Received: by 2002:a05:600c:1549:b0:498:1371:660c with SMTP id
 5b1f17b1804b1-4994e704bd5mr50927585e9.0.1785944093070; 
 Wed, 05 Aug 2026 08:34:53 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B86F10001BE789C6EE938EE.dsl.pool.telekom.hu.
 [2001:4c4e:1b86:f100:1be:789c:6ee9:38ee])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47febfda6afsm9047223f8f.3.2026.08.05.08.34.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 08:34:52 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Igor Paunovic <royalnet026@gmail.com>
Subject: [PATCH v2] drm/rockchip: dw_hdmi_qp: attach the HDMI Colorspace
 connector property
Date: Wed,  5 Aug 2026 17:33:55 +0200
Message-ID: <20260805153416.8459-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The RK3588 HDMI QP output never exposes the "Colorspace" connector
property, so userspace has no way to request BT.2020 colorimetry.

Everything needed to signal it is already in place. The connector comes
from drm_bridge_connector_init(), which calls drmm_connector_hdmi_init()
and attaches "max bpc", "HDR_OUTPUT_METADATA" and the output color
format, and the HDMI state helper feeds conn_state->colorspace into the
AVI infoframe colorimetry bits via hdmi_generate_avi_infoframe() and
drm_hdmi_avi_infoframe_colorimetry(). dw-hdmi-qp then emits the
infoframe through its hdmi_write_avi_infoframe hook. Only the property
itself is missing, so conn_state->colorspace stays at its default and
the AVI infoframe always reports "no colorimetry data".

The user-visible effect is that HDR is unavailable on every RK3588 HDMI
output. KWin (Plasma 6.x) requires "Colorspace" alongside
"HDR_OUTPUT_METADATA" and "max bpc" before it treats an output as
wide-gamut capable, so it never offers the HDR toggle.

Create and attach the property right after the bridge connector is
initialised, as vc4_hdmi already does. Passing 0 to
drm_mode_create_hdmi_colorspace_property() selects the full HDMI
colorspace set defined by the core.

Tested on an Orange Pi 5 Plus driving a Samsung Odyssey G70B: KWin now
offers the HDR toggle, the connector property switches to BT2020_RGB
once HDR is enabled, and the output runs 4K@144 at 10 bpc.

Signed-off-by: Igor Paunovic <royalnet026@gmail.com>
---
Changes in v2:
- Regenerated with git format-patch. v1 was a hand-assembled diff: it
  carried no "diff --git" header, no diffstat, and no function context on
  the @@ hunk header. That is the most likely reason it never showed up in
  patchwork and got no review in three weeks.
- Rebased onto drm-misc-next (97c03b32b28a), the right tree for this
  change. The hunk is unchanged apart from its new offset and the function
  context that format-patch adds.
- Reworded the commit message to lead with the user-visible effect and to
  name the exact core path that consumes conn_state->colorspace.
- Trimmed the in-code comment to a single line; the reasoning now lives in
  the commit message instead. No functional change from v1: the two API
  calls and their placement are the same.
- An automated review of v1 flagged that returning an error from
  dw_hdmi_qp_rockchip_bind() leaves hdmi->hpd_work queued. That gap
  pre-dates this patch and is shared by every existing error path in
  bind() (drmm_encoder_init(), dw_hdmi_qp_bind(),
  drm_bridge_connector_init()), since cancel_delayed_work_sync() runs only
  in dw_hdmi_qp_rockchip_unbind(), which the component framework does not
  call for a failed bind(). It is already being addressed in the HDMI 2.0
  series below ("Cancel pending HPD work on suspend", 30/69, and "Control
  the HPD IRQ line via the bridge HPD ops", 37/69), so this patch adds
  nothing for it.

v1: https://lore.kernel.org/all/20260714202850.40999-1-royalnet026@gmail.com/
HDMI 2.0 series: https://lore.kernel.org/all/20260731-dw-hdmi-qp-scramb-v10-0-294364b2cf15@collabora.com/

 drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
index 9c4cf68d79d5..35d04680d011 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
@@ -695,6 +695,13 @@ static int dw_hdmi_qp_rockchip_bind(struct device *dev, struct device *master,
 		return dev_err_probe(hdmi->dev, PTR_ERR(connector),
 				     "Failed to init bridge connector\n");
 
+	/* Passing 0 selects the full HDMI colorspace set defined by the core. */
+	ret = drm_mode_create_hdmi_colorspace_property(connector, 0);
+	if (ret)
+		return ret;
+
+	drm_connector_attach_colorspace_property(connector);
+
 	return 0;
 }
 

base-commit: 97c03b32b28a9f7f13f768f2b06e1eaafe850e66
-- 
2.43.0

