Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EE12C624C6
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 08:50:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77C8A10EBFB;
	Tue,  1 Sep 2026 08:50:16 +0000 (UTC)
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.155.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32C6C10EAD6
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 08:49:06 +0000 (UTC)
X-QQ-mid: zesmtpip4t1788252501teb53240c
X-QQ-Originating-IP: 0mYgCpomsnDKbD+h2k+lHMBtEyjIbP0NaGhFxfccFrA=
Received: from [192.168.30.32] ( [localhost]) by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 01 Sep 2026 16:48:18 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3973929460923786869
EX-QQ-RecipientCnt: 29
From: Xilin Wu <sophon@radxa.com>
Date: Tue, 01 Sep 2026 16:47:56 +0800
Subject: [PATCH 3/6] drm/bridge: simple: add Chrontel CH7218A
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-q8b-dts-v1-3-7de0b6a73d08@radxa.com>
References: <20260901-q8b-dts-v1-0-7de0b6a73d08@radxa.com>
In-Reply-To: <20260901-q8b-dts-v1-0-7de0b6a73d08@radxa.com>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, Linus Walleij <linusw@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, 
 Stephen Chen <stephen@radxa.com>, Junhao Xie <bigfoot@radxa.com>, 
 Xilin Wu <sophon@radxa.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1028; i=sophon@radxa.com;
 h=from:subject:message-id; bh=iJGKW8aHiwPKnRjwppqL8s5bjHfZk47Bz/9I4jredbo=;
 b=owGbwMvMwCVmdFg0fe08Iz/G02pJDFnTJjoHXa6R05moK9HzrSoptJ+dcW6iy6JZUW73mZ0b3
 ydNfzWvo5SFQYyLQVZMkUUhnmEue2XutadipXowc1iZQIYwcHEKwESynjIyPPkxtaPHS99Qwuy0
 2n6hCT7FSzcyMn1Qn3XzYHzr606hzQz/HbWPrBT6ZGm1MvW4ytLClij5xQ3vm8p3s07VUvq6TcG
 RBQA=
X-Developer-Key: i=sophon@radxa.com; a=openpgp;
 fpr=205F009D07796DD6E516752E32C31567AD9E324E
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MeFNLUIt+GJ0TWXROn+s2kDj4QcsPXwZxU2uGv+aTsMRLbKU+v813QMC
 VaF7IeNtmgl7Z7w2nvAiRYQVBl3A9uvmf8NaTO23QUiXeEtn9GJjhpg1/KDKuqztY8mlYvb
 Gq/yZ0mt2veolXmcnQDkyy/BXzxKQq2g9sq++xNuDJ1fYDIpvIVNcM60Jy3Nja+JVfk/0vs
 9wa8m5umo7BOAawA64RFqBD9HmFePKhEHcR0Ux7lIC29/WUvNo27Va80FtNKbmxxTEVyCe7
 LqOjUmOIafaPn8p+DRg3SWKPaEmbOZwWHPlr0Xp2KwE0kRQAQ+YoJAZdiYyCtuCXJTT3svn
 9JkYo5uilfkX1X5gc2vXtINH5cRNjNabMJUARcB1ktUZJVjVUSMixd80PL7CME6Tdn+jwmI
 zlqub6jUP/InAyzRF06KMTPVefJmiwZuPNdNr+eEbjr2qGt7Re4bH6dohe27pdObUnZL06U
 ApZvSxDAoptg2m9Hr4LXrW3WIlSXnRNApiO7rpU03q2LbFTTeFhLxfql7W5KN9WKLPy5ZFi
 9/vaZTtKWdEEE6GumZoYOlTeBZdHo7UkW00bKDi7TI1peGo/q9+H8LTOdwvj3/8q6D++y9W
 0r3RamFkVaQxz4WcKdS+t/Wu0NgrL6jgxufn9GDxzrJAkNBOM1NuYP37H6Sn9eaww6fjMlC
 zS4hyITrPgtcL157IhHY3F0dpezM4L0wERT57I0vYmUywjnRVdwAO80dxFyV/N3nKeQyaY1
 ADPaDoekQFOqmJs77awuWXq5bL+dRQRZlapyRff5tbM7pkMSB+42QK02+7Whrcl/mCHz6oy
 pgl41TpQipyQEmoDn1JnrFMP4xcDyjLgvKGY1tAmIDOh6yvfj3hnXZBRM5WFEWh/xXb9iR9
 idC8E1N7AuCqtunyxYqNPmb217DbRrNaPbFBLmQVK6Kgo3t9hp4iP/aUncR2Xb2G6SvLgH4
 QQ5npNu6qLIlyjOwAH87scqeo7Bd3SI4dyzg1zUrnKSpiIWWLmd+dWUj6nj3pq/1uymud1m
 BuKy+vGPCk3qAsNEEh1GyVFey5C+hjpotpJAKmj6toU6lbemAqlg+4F06mFp0=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0
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

The Chrontel CH7218A automatically boots its embedded firmware and
operates without host-side configuration.

Add the CH7218A to the simple bridge driver and expose its output as an
HDMI Type-A connector.

Signed-off-by: Xilin Wu <sophon@radxa.com>
---
 drivers/gpu/drm/bridge/simple-bridge.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/bridge/simple-bridge.c b/drivers/gpu/drm/bridge/simple-bridge.c
index 3fba7002322e..fab793fb12b5 100644
--- a/drivers/gpu/drm/bridge/simple-bridge.c
+++ b/drivers/gpu/drm/bridge/simple-bridge.c
@@ -275,6 +275,11 @@ static const struct of_device_id simple_bridge_match[] = {
 		.data = &(const struct simple_bridge_info) {
 			.connector_type = DRM_MODE_CONNECTOR_HDMIA,
 		},
+	}, {
+		.compatible = "chrontel,ch7218a",
+		.data = &(const struct simple_bridge_info) {
+			.connector_type = DRM_MODE_CONNECTOR_HDMIA,
+		},
 	}, {
 		.compatible = "mstar,tsumu88adt3-lf-1",
 		.data = &(const struct simple_bridge_info) {

-- 
2.55.0

