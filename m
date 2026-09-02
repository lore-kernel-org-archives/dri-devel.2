Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB5AEC624DB
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 07:34:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2815E10F420;
	Thu,  3 Sep 2026 07:34:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="SPUcsT6x";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012042.outbound.protection.outlook.com [52.101.48.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D24F910F2D8
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 17:08:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vO3kIHB0xR3hW+EC2MObiv7GYmboNaD0gufq9bB9KbK9TMR5+yBr+Cn7h5A8UhImHBIgjrjgl3LL5T22T5vhWbjLypuqyXPiLTK/X8LFQU8IGoYLQ50xDZ8eYsDij/QIngG6kjN6Dgto9iYi2V84OAwMWyYdQ3qx0mpvp9tcA9JkwDLXQosiA24efOyIVizwvNqYyBVeSVtBaLOYWR9pJLf9fu1ELTuXOmuN836ZvladaCaEJOZ+c7qlT/40xZ9ft2uMey46yfjr+sxlnBa8w8agRocGmM8k7/II5mubKZn4gK39b/zhb0lSFufbuZhSUFD6h0chlx3nhOn+ol514w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EztI41z35Q717jaClwy2Nn6oM53JvXcVD9WfgGlShvc=;
 b=vZvcHNlWJ3Ycju8H6Ok4jum2BvympoKb3yqCDESTvNJOyC+jRQSBDJs0uY4L+TISZ1P3lS8dDcO/wacElQ9kmrKrhxPxO8Cz1JMANh1iOFzibgx3FtDnuMlKbNLhnErSkV5LbO01rAJojfoMu4jfwkr4f+6x6puq/h5FZjRZkjuQTLy8fHdc40muLJTBoceuceBIhKkRpoDzIeOkF3FxBq6UEkE0pKV8tU3+VrPJyECn0vPnx08mehS+Lk4D7URePlD5Ru/HCq7FMdtBddPXMkR6avOf9u6aqz9dQlh78Sz3Wpm4qcbr7YA2jyArnuyY5DE175MZDvjt3mUKts/iJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EztI41z35Q717jaClwy2Nn6oM53JvXcVD9WfgGlShvc=;
 b=SPUcsT6xnKZaJXl4jdqbC/gm6zcECVPoEzCyXs5Pt2uZ7rkT+zalW+bhUi2ng5nqjQgnX7DW5shP/vhmuTvmf0S48GzsGoE/dB09YL9PXyIY5/5zPWPf2UHN1AwzYWtC448h8eBVUmgCcfT21qYGMgX2fQU1o4z2CMRRBCMEhw8Es25MoRfXAEJ2OrLQZBz2Php0U3QTqGcMhUk3ExS48CYKcWJBhkLy5c7CrysHg3ilFOuq8hANVW5rMqLDsX8kkS7vCzvPsrYtIzy+KmSYmrYN1Z5hw6HLFkOA78M0u4fvEm+VtVZ0s0ssfffdohZzOoKPM281JC3YAwN+2Pwm1w==
Received: from BN9PR03CA0725.namprd03.prod.outlook.com (2603:10b6:408:110::10)
 by MW6PR22MB4150.namprd22.prod.outlook.com (2603:10b6:303:241::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 17:08:34 +0000
Received: from BN1PEPF00018072.namprd04.prod.outlook.com
 (2603:10b6:408:110:cafe::23) by BN9PR03CA0725.outlook.office365.com
 (2603:10b6:408:110::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Wed, 2
 Sep 2026 17:08:32 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 165.85.157.49)
 smtp.mailfrom=gehealthcare.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=atlrelay2.compute.ge-healthcare.net;
Received: from atlrelay2.compute.ge-healthcare.net (165.85.157.49) by
 BN1PEPF00018072.mail.protection.outlook.com (10.167.245.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 17:08:32 +0000
Received: from zeus (zoo13.fihel.lab.ge-healthcare.net [10.168.174.111])
 by builder1.fihel.lab.ge-healthcare.net (Postfix) with SMTP id 396C219244;
 Wed,  2 Sep 2026 20:08:28 +0300 (EEST)
Date: Wed, 2 Sep 2026 20:08:27 +0300
From: Ian Ray <ian.ray@gehealthcare.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Lucas Stach <l.stach@pengutronix.de>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/3] drm/bridge: dw-hdmi: optionally ignore rxsense
 when detecting hotplug
Message-ID: <aphYC5J0ggfKzLZJ@zeus>
References: <20260902130117.2731-1-ian.ray@gehealthcare.com>
 <20260902130117.2731-2-ian.ray@gehealthcare.com>
 <7b26a257-534b-4bb1-a6a4-17d3d41aa374@kwiboo.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b26a257-534b-4bb1-a6a4-17d3d41aa374@kwiboo.se>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018072:EE_|MW6PR22MB4150:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cf6a34a-3fc5-4a1e-0276-08df0914d12c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|10067099003|6133799003|22082099003|18002099003|56012099006|4143699003|11063799006|13003099007;
X-Microsoft-Antispam-Message-Info: JaDvvtrzNEAvil/l0mP8lf33h76kC04WSg1yfI6Gxv8eXjz0BQlSOP+wTozxGxMnkQ1FoDTIHj0AI7LwpoG3DYg2Q/rHxWzx/SVf397qTmOfDFxlQcSCvLVViRk6kTbYTJYE56jWRI2yiKhfy1BEkFnd/G9dPhdBkQnlTw0/To6QBRT1kCJtFkxOURO7+Ax49IJWgmV4S82GS8hOVTIM9z95d6NhbskNqAlWo2W8pquCm8xG/o1DJpQhtHoPfZoh5//PGE6Cm9CiMSRZY+7J6ZWj6Er9C3e1ulMow1yq0isLlySzz/eYGoRZjGMZWwgtZlSPp8cI2AGVdtnCCXwz9/ZMxsGvPBiZxoiNB7wH7xj5qjl2Vn19GZUJsbRP+t9j5EVger8faP3SzHRPSOvyjKrYtMdoD3JDv5LhZGAYgPzrdbEWVk8KX0IEXubDEMflLjhl9wBzHbkKk15FAQCQDQYzhJJtJWoHtCO+7sq80e2Zv7YLNdHrgJKNf2m3Uld/cRPl3jLZ+TwozcVIGH7t2B3WhO6rT0BwRJbwKQz2FrIK5aRnfjKwebsPOksAS83V5osRD1WNCJJTRpdOalSQVcL9RwDmEDH3HdxiTyKDMh9jmBYc9pEp1T+QC7Wmnq7SghhrZKuIS+f1IipP7IaxNQBDd9TkgvHrk5H/8DNCXpplvM1+/vCF8q2kGPXt4LoffbCUXslXOsrvWvEoL7gxDg==
X-Forefront-Antispam-Report: CIP:165.85.157.49; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:atlrelay2.compute.ge-healthcare.net;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(10067099003)(6133799003)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gGQueFoMWUjOV+ga+9EKPZEPE2Gu7foQVJ90rypthcimFTZErekPDxcLIlmKn7OGQZiVd138VUdcginutcqzA436Sznwsi5SdfIa8MkzOiCuhw++p8JXoJOHAAJ0zbCE9SDtjyQTXuTot4q6tOJPuX9gdgv7FkS9jt+3JQDvlZti1lUY8TvJYXOMkXW0M2yQL9ZAKFVcYbZWtDG+nFzyN9aKaPzXc92u4wYOV7hpZ55cB1De7VfaFZbodrG31mbUkLnPhwWFs72Z+nvGekLIvT7vY5B3UP4/cssENrm4ipoV3iikc4P9PbuSFF09CVVUHFfQ9bmfMPdK19grKcj7rnETjhhlei5oCXUkhHd7e8h+ho+CgNXhxAI3nVrGB+AQtXvQ+ywvO7wAPzXsyh8KLDTvfWrLAvbGSKWfM9ZL5JimnHrIcV+w3btYF3WaIyet
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 17:08:32.0577 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cf6a34a-3fc5-4a1e-0276-08df0914d12c
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf; Ip=[165.85.157.49];
 Helo=[atlrelay2.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN1PEPF00018072.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR22MB4150
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

On Wed, Sep 02, 2026 at 05:38:34PM +0200, Jonas Karlman wrote:
> Hi Ian,
> 
> On 9/2/2026 3:01 PM, Ian Ray wrote:
> > Commit da09daf88108 ("drm: bridge: dw_hdmi: only trigger hotplug event
> > on link change") changed the way hotplug is detected to take into
> > consideration rxsense.
> >
> > That change is problematic for boards where rxsense is always detected,
> > such as when an HDMI to DP converter is used.
> 
> I have a series [1] with a patch [2] that tries to fully remove the
> rxsense part from the dw-hdmi driver, any help to test that series is
> welcomed. Should likely solve the issue you are trying to workaround
> here.
> 
> Planning on sending out a v8 next few days now that v7.3-rc1 have landed.
> 
> [1] https://lore.kernel.org/all/20260518180206.2480119-1-jonas@kwiboo.se/
> [2] https://lore.kernel.org/all/20260518180206.2480119-21-jonas@kwiboo.se/

Thank you -- your series does indeed solve my problem.
I will reply to [2] with a Tested-by: tag.


> 
> Regards,
> Jonas
> 
> >
> > Introduce an optional property 'ignore-rxsense' to handle such boards.
> >
> > Fixes: da09daf88108 ("drm: bridge: dw_hdmi: only trigger hotplug event on link change")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Ian Ray <ian.ray@gehealthcare.com>
> > ---
> >  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> > index 34c5f583e910..a9337d1f4b88 100644
> > --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> > +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> > @@ -171,6 +171,7 @@ struct dw_hdmi {
> >       bool disabled;                  /* DRM has disabled our bridge */
> >       bool bridge_is_on;              /* indicates the bridge is on */
> >       bool rxsense;                   /* rxsense state */
> > +     bool ignore_rxsense;            /* use HPD only, ignore rxsense for detect */
> >       u8 phy_mask;                    /* desired phy int mask settings */
> >       u8 mc_clkdis;                   /* clock disable register */
> >
> > @@ -3156,6 +3157,9 @@ static irqreturn_t dw_hdmi_irq(int irq, void *dev_id)
> >               if (phy_stat & HDMI_PHY_HPD)
> >                       status = connector_status_connected;
> >
> > +             if (hdmi->ignore_rxsense)
> > +                     phy_stat &= ~HDMI_PHY_RX_SENSE;
> > +
> >               if (!(phy_stat & (HDMI_PHY_HPD | HDMI_PHY_RX_SENSE)))
> >                       status = connector_status_disconnected;
> >       }
> > @@ -3362,6 +3366,8 @@ struct dw_hdmi *dw_hdmi_probe(struct platform_device *pdev,
> >       mutex_init(&hdmi->cec_notifier_mutex);
> >       spin_lock_init(&hdmi->audio_lock);
> >
> > +     hdmi->ignore_rxsense = of_property_read_bool(np, "ignore-rxsense");
> > +
> >       ddc_node = of_parse_phandle(np, "ddc-i2c-bus", 0);
> >       if (ddc_node) {
> >               hdmi->ddc = of_get_i2c_adapter_by_node(ddc_node);
> 
