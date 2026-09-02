Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45644C624D7
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 07:33:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A75A210F3F6;
	Thu,  3 Sep 2026 07:33:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="VkQ6K+ef";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013018.outbound.protection.outlook.com
 [40.107.201.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FE0010F1CA
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 13:01:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eRXpHRlUyPDAQmqrZkd4gr7ZhqsKN1+5h3iNoXn5CYHzTmc14I2DI8gsnc8ywu+3+5qOdRwfqyHHl6w/wu3ekexi+H+L0NoKXng7mjP8twZw4I9br1drf2oXD5nNS9HKJxnmMTGNhoftgaYDyiuY6fINcuUnld2Tu6wiAmSo5b2IW3z9lB4HDLnPkbVW+ocoI55ZqY8xNij6SI2DK93gZZBGfkxf1T9n11fDHVMjVYj1Pl9NkIoImHX1x5T2NfYYQWZVlEA9Y4rzIcbouAAgomTqGAHlG0xJQIEqJgPz8ECzrgfe0JKsWYuANrBc36F5NbsIJpCkHfHdJ4hVNI+enw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HtFuLWOeo044dXAap0RsBsuypxn/lF5Pc0jcoVn0jRo=;
 b=mPpH653Pg8ATQXtlOWtDkGcURyx1dKeg7XVLgZl30i2efEaAZDh3DyNtYeYbYaGV871X+1SR8gYA4NEeerOEkyV9Eb2m37Iw2szD2wrYnHiFaT+xNRieD2wBcBhkDoC7x84geLdsrAIbN/gSXXvxTpFwpPiGfjecM9Lp4CP8UwE9taz5rripSLm8f9XkyREHSRsTcu+qbU2IzYjHeBk/xOsUsrEN65VSs3cC91vqh9bgeRiAXD4BzrjZkY/Zdole3q97ZHnMZRrTzOOKE6pPZ7fjuQ2GXu6LRqOToyzJaTOFcXpFwE/v+05/dlqPjttmh7xAcAKnX7JaSOtlWHImag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HtFuLWOeo044dXAap0RsBsuypxn/lF5Pc0jcoVn0jRo=;
 b=VkQ6K+ef44HRAfK0cz+p3Yngs2fgvFRpxYZwZHHA2nmaBMPHVdJL7vkAg90VdVVFgV509XDt2L+l1dC3ZiNOyyNjGdHW8lh975+fNfQ/R+6API7tnK++YSFWhPK6eRFfYA90DeAt6LQNWGoNeRp+0tggnoh1L4T2F+pHLTTF6FM2XM6OjFFPlbGFRSNxFJmCXKTTJR21Ea5ECu3hJ26oTBNBxxwBDAflI8iPjz6ZHponvpsEaLkyGNv/D7GmoWSw8s4fc+WZUxxzQGiR8bHfFJ2nmLGupEsmH5Al67qc9icXVT/aT5QfWO5LEI3sfHEp4T6xMLMutKrlBbKs5WHO+w==
Received: from MN0P223CA0023.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::10)
 by SA1PR22MB6008.namprd22.prod.outlook.com (2603:10b6:806:469::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 13:01:28 +0000
Received: from MN1PEPF0000F0E4.namprd04.prod.outlook.com
 (2603:10b6:208:52b:cafe::ab) by MN0P223CA0023.outlook.office365.com
 (2603:10b6:208:52b::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Wed, 2
 Sep 2026 13:01:25 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 165.85.157.49)
 smtp.mailfrom=gehealthcare.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=atlrelay2.compute.ge-healthcare.net;
Received: from atlrelay2.compute.ge-healthcare.net (165.85.157.49) by
 MN1PEPF0000F0E4.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 13:01:25 +0000
Received: from zeus.fihel.lab.ge-healthcare.net
 (zoo13.fihel.lab.ge-healthcare.net [10.168.174.111])
 by builder1.fihel.lab.ge-healthcare.net (Postfix) with ESMTP id 6C55719244;
 Wed,  2 Sep 2026 16:01:21 +0300 (EEST)
From: Ian Ray <ian.ray@gehealthcare.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Lucas Stach <l.stach@pengutronix.de>
Cc: Ian Ray <ian.ray@gehealthcare.com>, stable@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/3] drm/bridge: dw-hdmi: optionally ignore rxsense when
 detecting hotplug
Date: Wed,  2 Sep 2026 16:01:14 +0300
Message-ID: <20260902130117.2731-2-ian.ray@gehealthcare.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260902130117.2731-1-ian.ray@gehealthcare.com>
References: <20260902130117.2731-1-ian.ray@gehealthcare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E4:EE_|SA1PR22MB6008:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 0787d057-28c7-4fc9-3553-08df08f24ba7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|10067099003|6133799003|18002099003|22082099003|56012099006|11063799006|921020;
X-Microsoft-Antispam-Message-Info: 7V2kQeeLQwDkXicIR1UynJQVYHI1V1XlTkK0DAzNEdRId3Nh037NSNidBsnWaYQt1ywdlOoUeKqGwXBMhUZuARNmjFD0XdC4Vki04GHw+MU98jpI3fD8zGSqDEBJa11eT1ij2JUeh9r7eGGugXpk9v63goNHrG2etiE6cNzpA/NIXct1vApcuH+PG74ZSsmcB2uRMtI16SeNZjScj6ECGyPArdYtHkqjVcmZHPkhYU01q4WjHtb04Cz/SpiNgetuAYYrzUzMykwhUbyKm7sSSea/zxSBp0KHj+qVTQfJqcwyiGzPtPT2Q5hdxEXVE1U1iuK60df68K+B2HvlDzdmR9A+jw8vM59Ymfm6o0inK0erANK4ML+MKAaq4/PZkmodW0WSoWNSydAEq/CSSmH6ouH5ePbWbGwiAPEMgmDct1nWrhMWi8Ik305+UeXnlPpYdPE4kQkyuvzd59XIjbzLXRE2IcA1OL4Y/9ZowGbPxz5z6QtxeBM4Qnqr1osCXxSvNlujZr67/TdLl7sJxRD8PNSQyKcoVl5ExlrQPxEmX3Nnk/AXSs5lQTVnAev2i0zXMheLe/jKw0vZRvQZcqrKSxHt/6JcV3MTHRzQC1qcfpDwlMl6PgaOi3uUDXoUFKiyIY7p1Stj3AcyxdNITJh6A7etkZg4KbsfgL+/DYoAgiYdXPIZQtGT7OMqNIS1iftXKrMPiQYudyplDJmrSp1yYmBNS5xI4MFltcXdAxURYZApqDAfM2xdkkZbnhumfTc3
X-Forefront-Antispam-Report: CIP:165.85.157.49; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:atlrelay2.compute.ge-healthcare.net;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(10067099003)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZNMfpGZClla927YX52TQpvMQpy9ax1kWkdvjmlr/LxfYDUik79Y4ciWFKR4JqsfvtUU2wIAa4h/rxb9Rp6nDEL7IHeHzTGuDCKmbZR1pEGC721zoof5EOG4n1iqBS4dFoU/fLrXntOmMIAAOVZxYEZioN5SZ9SHo7igave0osXEdfcSCdxz/A4k4rg61D/rtXN9bXG1exf8h7xPAk6wKZmg07amWOdim8y/E35BVxeUZjDa+wlsM5YLLoGya+yqxdm/Mli8LqM+Y83Qm4W+9nCkipbs2P/oovF2GwGllSEbq9X9pfvvwTWihCm2H83q3poqRYH/SNNA0TBKk/efkrLcmvL3KNwLcWO2zLgBY1TJqz+Ru7RyUxTcVsqMSPYFExSUnrlhIHJgM9TpRJfxIV1X/oZ13F3zGlj/4VEXV2QgF9LIj63WTgYjRZxZ5daMV
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 13:01:25.1415 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0787d057-28c7-4fc9-3553-08df08f24ba7
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf; Ip=[165.85.157.49];
 Helo=[atlrelay2.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-MN1PEPF0000F0E4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR22MB6008
X-Mailman-Approved-At: Thu, 03 Sep 2026 07:33:13 +0000
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

Commit da09daf88108 ("drm: bridge: dw_hdmi: only trigger hotplug event
on link change") changed the way hotplug is detected to take into
consideration rxsense.

That change is problematic for boards where rxsense is always detected,
such as when an HDMI to DP converter is used.

Introduce an optional property 'ignore-rxsense' to handle such boards.

Fixes: da09daf88108 ("drm: bridge: dw_hdmi: only trigger hotplug event on link change")
Cc: stable@vger.kernel.org
Signed-off-by: Ian Ray <ian.ray@gehealthcare.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 34c5f583e910..a9337d1f4b88 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -171,6 +171,7 @@ struct dw_hdmi {
 	bool disabled;			/* DRM has disabled our bridge */
 	bool bridge_is_on;		/* indicates the bridge is on */
 	bool rxsense;			/* rxsense state */
+	bool ignore_rxsense;		/* use HPD only, ignore rxsense for detect */
 	u8 phy_mask;			/* desired phy int mask settings */
 	u8 mc_clkdis;			/* clock disable register */
 
@@ -3156,6 +3157,9 @@ static irqreturn_t dw_hdmi_irq(int irq, void *dev_id)
 		if (phy_stat & HDMI_PHY_HPD)
 			status = connector_status_connected;
 
+		if (hdmi->ignore_rxsense)
+			phy_stat &= ~HDMI_PHY_RX_SENSE;
+
 		if (!(phy_stat & (HDMI_PHY_HPD | HDMI_PHY_RX_SENSE)))
 			status = connector_status_disconnected;
 	}
@@ -3362,6 +3366,8 @@ struct dw_hdmi *dw_hdmi_probe(struct platform_device *pdev,
 	mutex_init(&hdmi->cec_notifier_mutex);
 	spin_lock_init(&hdmi->audio_lock);
 
+	hdmi->ignore_rxsense = of_property_read_bool(np, "ignore-rxsense");
+
 	ddc_node = of_parse_phandle(np, "ddc-i2c-bus", 0);
 	if (ddc_node) {
 		hdmi->ddc = of_get_i2c_adapter_by_node(ddc_node);
-- 
2.47.3

