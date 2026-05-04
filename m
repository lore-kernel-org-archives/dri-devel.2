Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCBF9FF885A
	for <dri-devel@archiver.kernel.org>; Mon,  4 May 2026 20:58:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6084510E3F3;
	Mon,  4 May 2026 20:58:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="NXd/Jm0j";
	dkim-atps=neutral
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010015.outbound.protection.outlook.com [52.101.69.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5685710E3F3
 for <dri-devel@lists.freedesktop.org>; Mon,  4 May 2026 20:58:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kt7mY10TI3Ptr41EPdkXFC0s2iqr9SDFfpiQ1AL7R8nwPFJ5qE5uIw1IoUSMvWpbFs4DU3sSpbtdRo0Ou9yXSCiw/ZMPjJuAmETWqG7D3n40+Knd6Xe4gvVCTItY3RjIFS8DuA36vysUtfjK2km6CaeDcqBccJAQAwOOfQ9Wov5IE6Xk4SX2UiF1M9cawFKSDHlqfxi18BZvABFNla4X33vVlkVl62VBKwW3MIusfb9dRXs5PWVUUh2kTJ+sDDLMdZb2VXQWG/jesHojf+4pYIMUd9mTGTAn2dNapKlDV3PWT1+FcX+BUsUjcmcMuyJ+6G92YFkZQi99r2/ur0Dwqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PtoXoQl/9FfBIks32nWqVJ8QQRJzbZd93sacceaZXww=;
 b=JIdp8dPo0UmZsLd6jjuzu/TPo4/lXvh+LjEL9yOtUG04LR1yQbzCZPu7k2blKX8+ZBzrpv+sCWg/PliOXKSqXA+Et0ROMTaqdZBlRXQaRkuMT2e8YjOUz7luSeUVEwz2ImVwvbY9FbHoDIk/xCiqPPBltPwmPu55PjCun9DWTmN2zqJNp9KJ188Mw1Ru3HLzETNrlzQa6Cp53WtGJsshXf81BoPpDKRKQi5JPFz0DF5Pf54MjbLjMnGM/VEB74XK4lFWmgiRXg8DslLnBhZCDjEKiz7lvoeeY28EsQ62IISo/Gd9/jvr9WEDYurNZtDdxkDAeIo0EmEJwOW1t22OMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=bootlin.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PtoXoQl/9FfBIks32nWqVJ8QQRJzbZd93sacceaZXww=;
 b=NXd/Jm0jf3XtjwhnzD8nbBFBeT1AsLRgASee2jcd9GTgjpL9rEokYr95//svFn/aGvovDnukiBFomJzWMH5UkaSMU5+U6R/Zyi/VAciOMhoM38s471kA/sZN/UFbghKfgf23TX3Hu8wzMW007gE6+wQFYW9N1ZOEuZta7YEdJ1C8U9iAeDYQf9u3Zln3NSU/HrZyUpiecJvHp3QWB36MBe8zF7IYNdncZu9c0JWjlMV1AAF46Lz8QkWOJioRqqg/aKmihcJB7BDQBtHbvUSryS4f0EOh6CT+SiYo+yeT7D9uIYFA0XJ4I8o0rivoa5iF2VRTnDVuIk5gPLveXvEokg==
Received: from DUZPR01CA0042.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::9) by VE1PR10MB3774.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:800:168::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 20:58:52 +0000
Received: from DB1PEPF000509F1.eurprd03.prod.outlook.com
 (2603:10a6:10:468:cafe::b4) by DUZPR01CA0042.outlook.office365.com
 (2603:10a6:10:468::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.25 via Frontend Transport; Mon,
 4 May 2026 20:58:51 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB1PEPF000509F1.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.22 via Frontend Transport; Mon, 4 May 2026 20:58:51 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Mon, 4 May
 2026 23:02:26 +0200
Received: from localhost (10.252.19.99) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Mon, 4 May
 2026 22:58:50 +0200
From: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
To: <luca.ceresoli@bootlin.com>, Alain Volmat <alain.volmat@foss.st.com>,
 Raphael Gallais-Pou <rgallaispou@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, Osama Abdelkader <osama.abdelkader@gmail.com>
CC: <stable@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] drm/sti: remove bridge when sti_hda component_add
 fails
Date: Mon, 4 May 2026 22:58:47 +0200
Message-ID: <177792809197.128301.8006898969562443963.b4-ty@foss.st.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260423200622.325076-1-osama.abdelkader@gmail.com>
References: <20260423200622.325076-1-osama.abdelkader@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.252.19.99]
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F1:EE_|VE1PR10MB3774:EE_
X-MS-Office365-Filtering-Correlation-Id: be4daade-883c-4992-f174-08deaa1ff1f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|7416014|82310400026|22082099003|18002099003|56012099003|921020;
X-Microsoft-Antispam-Message-Info: cOb+tdsj/oDardP6hCwon+qudhwRqi/Nh2nxB/Z1XrK/SACK0rww13QtPAXWgp+qEVGuOPZMTQ+zDKfDnXKLSKKesElX8x9Jo2M4dxbmt7Qj3/KqEy8A6GxvmTRMwywko3AfMH2+e4g48wL5b4xKIxHkzSQvgosIFzCiq83FXG3VMuQeIbsA5pBES4OBTmFOYR1T6QPzJaaulXW39Piu0IOzzwlhtKJpMODiOMnFPNJxWuDZUl+YBJK7ObgrcknrZ/AwX++NlakcWFlN+Q90KB2MUNjSEsB/dhcv/Hq3M8kx4owoxYT/LgE1HbTvNA87I36dsnP1ARmLLMIryr/r3qI7tTYwV00CRLPaezec7jxv+UHeVY4bpWTfOsOIchKPxD02UhkHU5nFEOggUNqtWABeS6e4sCgE94tUsnFnheSWTiIhN8YcZldUQUCuaTmfajbbUwnS7EqaOTKdZ4DVR87hyPc5YxvyPm4kXKtQxui38qRM1ZEEjZoWBQt8sutZMO4s+WiLksWxlRhaK642BChFnk9we4tJg/1WxjfaveC4E06e58J+93WeC2U0++Rp5KSfdcAcYnxIzFJ8pJ214zuw0LRFPrR8eLMT+KZVIXs+T7Azf/iycjgEtaonvFUg+ffDZt4ztH5aS8iPZO1Aw+bHEGSBXksKY2w/ICCT/s3nr9GJb9B6chy1iEStUPH8Wpt5auq9AWPdHY0mLb4QNdvzzgf88/xXe2ltd5A5LfoZMB55wiOf5Zorg5npbC+lEWqYcVPzkCdbBIwMquokIw==
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(7416014)(82310400026)(22082099003)(18002099003)(56012099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NOF/FEJvrFS/QtqPHtPbMOr/cIcSiOcZHZXswMUDOdPSU4cWe0u4v4oWoWaI4US9sO5r1+8fr4RuekysHU/PGEVJDyDwjoOIymNn3ViAUqR9TvkjUlUnB8oOOLi1RjCg8YgYx9fKyhZgPjAt/XkP2kqXtVTO2paMAy3SzeZzuJfCbt3at481IcEmGloUY7Fya+HyINc6NRrF/Pf5QMsJb+j2erXZHPQM6NVQ8tRJ4OHlVivs0Sf8PLndCGobgkFo7fbaHPMlai0N4YT9pLSri+Mpfi6byTDqi6xzBp+vYtooqghvIVSPOgEM3ct4VpQuOS5GOoZS2ALDMtS8I7UlnoqHiCdg/AVczrCXawg90ULNsfdSRvwyvyE24tj9byPT+UCEjRi4mKQT1r/YVV5Mlo5caK61Pj046ijwM4Qvktn8s8ryTZndKo3Yx2GSoQly
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 20:58:51.2271 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be4daade-883c-4992-f174-08deaa1ff1f6
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509F1.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3774
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


On Thu, 23 Apr 2026 22:06:19 +0200, Osama Abdelkader wrote:
> Use devm_drm_bridge_add() so the bridge is released if probe fails after
> registration, and drop the manual drm_bridge_remove() in remove().
> 
> Check the return value of devm_drm_bridge_add().
> 
> 

Applied, thanks!

[1/3] drm/sti: remove bridge when sti_hda component_add fails
      commit: 84ae1840260fece9b6b70d3872b79384bbe5a90b

Best regards,
-- 
Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
