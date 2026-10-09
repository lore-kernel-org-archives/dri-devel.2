Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF73FCA5FED
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 07:56:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 225CD10E9A2;
	Fri,  9 Oct 2026 07:56:19 +0000 (UTC)
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EFFC10E9A2
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 07:56:17 +0000 (UTC)
X-QQ-mid: zesmtpip2t1791532530tbb4c4c53
X-QQ-Originating-IP: 9/NgJElDi7wbagJh8pJMPJTdUCHLgUpjdwvUfflcCS0=
Received: from [192.168.30.32] ( [localhost]) by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 09 Oct 2026 15:55:27 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13704991742146090228
EX-QQ-RecipientCnt: 31
From: Xilin Wu <sophon@radxa.com>
Date: Fri, 09 Oct 2026 15:55:07 +0800
Subject: [PATCH v2 2/4] drm/bridge: simple: add Chrontel CH7218A
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-q8b-dts-v2-2-eda11e5dea8b@radxa.com>
References: <20261009-q8b-dts-v2-0-eda11e5dea8b@radxa.com>
In-Reply-To: <20261009-q8b-dts-v2-0-eda11e5dea8b@radxa.com>
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
 dragon@radxa.com, Xilin Wu <sophon@radxa.com>, 
 Daniele Briguglio <hello@superkali.me>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1079; i=sophon@radxa.com;
 h=from:subject:message-id; bh=/D8P3kABTsKmzN3/LTDLick9fibyBw396ut558wJNKc=;
 b=owGbwMvMwCVmdFg0fe08Iz/G02pJDFkn5j69eUdZ13FWwI1AsUeNCWtOvhHq6rBjd7LdLLbw7
 p17eX61HaUsDGJcDLJiiiwK8Qxz2Stzrz0VK9WDmcPKBDKEgYtTACbS/oyR4aTLgdCD5+9abY3x
 2utuvefpTiXrMD7XKTZ50ds+TTGemsHwv1B228oEs/mM8TfyKoUfq0fwMuu9mLd0rluN0IMI571
 rGAE=
X-Developer-Key: i=sophon@radxa.com; a=openpgp;
 fpr=205F009D07796DD6E516752E32C31567AD9E324E
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: M+5fA+c0T8eGmV+zFxRFh3+hjqMH5VothrRIQYVrRNORoq09lxlSxT9V
 IJ8PuqzRSc+vIRCFGQgUSw3AyfwKq5vi/rTlFVqpEWMOUOPT1JxvkqyMz9lZtY2UbmFn+/G
 VWYhn8TomQlrMosgLijqLfKKAOtxWrUyA8hVvtDr+XczYI9FhYsScLCybiBMIdS1nbwsJzT
 KisM0Q0Vc7t5jjHuVmee2Tm59E5HFwbZt03qxZVzhgVzrOe5WksqMF9Rcb+Ry+upCwHziWR
 ntjw/lbl1vK/npPZUt1BWmUJkeOHrzdAJgC+u7aDP6dqXg4Sf3xoPALtifbrP6/Z9sRMstt
 7u+xmKQob2Ay5vINBovtshgEVPmaZ2xrCspVYS5LfYYbv7JNSmVU6tOChkxyqxf6plnJP+L
 c/JHaMi7z8VqxxChWk+CuAIgveSY3cBmAf17h0/0bVkubUuYaPJu52MAsev2ZCTELmvEfoD
 lechL7wOsc29RR5IwPy4cKU/6QD5oi/i75D+Fmi1GSsi27B91hR7/fwrfyhmhpgJbVJVoga
 WdyHrAk8ufMxq3bX6GtP9qSTjHRC1kvCqxB4oKkKb9a94PD+FQYVwq8x4SluPF6DWsTgRrt
 vGVRqxvR1imaJQDb0fG2QEivRAS4LVNlgSG53dXRH8v38S4CW8p/OTNT3kHDdTvlh4oqL2e
 W8oQRIUKVe+/lUZSoxrW0tvlX5BKWSOEY+dfNNXZabQ9He36/g7+mLD1W/34oMbPPlMQkFw
 jx+f43S+IOiiJyhhADp9ciDrUtrQ/LPC3v/zR7YetNBq4iyVBMWzTljzPt98RZLHj7XKBgm
 CvHFdpmu1tsAztCOE9PoP/iA5bSHyxDJcLhZpSMsn0wKrDFkiow62SH6DRqRFwRYRUpl9W5
 3NFUHY+3GiYxpdkW2Q21aV+FspsOVBpe6zprsAEOlpS05Lh5U8C0SxF/Sh6eJON4LtOKvQZ
 cswCNgNbkRJt+YvDB/KoanjS6A77ruJ3TEnEwlkd1LxYUKtsVeSAjyB3/0MMTsBa8NGoM36
 3YcF2saCNrr1Ar3YuLISKsdGa/0cDBDbi4UgXBmSW9bcq2gVl22zj7xiX2/3UXVxT64SgPT
 tyXE/LlwEjHbWrMjSeopb8=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
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

Tested-by: Daniele Briguglio <hello@superkali.me>
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
2.56.0

