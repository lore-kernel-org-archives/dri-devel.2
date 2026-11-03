Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527D1606A324
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 06:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=aDedFtBt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F34E10F394;
	Tue,  3 Nov 2026 06:21:18 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011056.outbound.protection.outlook.com
 [40.107.130.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3042B10F38A
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 06:21:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PTlreN2oj4Uy90CzG/yDEhGcBaMtXOganVMnfBLAPCsX66oB3oHne02LXRobmdRDN2UrarrS/Ax6qHqD9zaiPzmGSGlUwS7qTJhwCLMMKdrkyAYrFFgb1d6oVCt6YY97a2vQUOSivjTu3j5qGtyZD5FvPUIJpUrFH00MdqR6OAzbNR0F+vsufSVJScC00+PTUSZ7u/Bw1Gnz8bzut6e6quG7p6YbhJX83drCz7EfeYmdKY/77W5CaEg+puRncvC6Ua119aiesn7P1sZYpT0x6HDGdEJz2EzRz9fyD8ME1kCKJpFXZl/9fz/eQx1CL5LwqRjxFO41eIpox3MKY1vAhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+1yV/f4mYLc3diRbvCtjlX1R6BeEeJipIZZZyqy1tMk=;
 b=wUp0IK+4YSE4t57qgAVysZe2igpQfPwDw1zaXzRy45pBbnN7HWf+vcuEEqPPUxXmI652uNC5gqMdl8xN5aDimFTMrHTaf3goo+l//qlkrPoHDQ3whzHZkuPLhnxAmfXg1/uamIEJY2PADfTrREiSgyS1iwS2NFUpmLrFShh40HySxv7T93aq8/QJde61D9z6pWiWzT2kTa2ZZ1lKBemw+0sDk1MUWTTGELt7DQtrBRVHWG5DBlReQi/nwl6PaPIw+3hDlbDu0HqOuTcdnZg5SPtrojJiqG/IZs6poI/DrcdGFzaa8WYxzNkcMRR2mrHkHvx5pWDVEbnd8OhqFvHCLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+1yV/f4mYLc3diRbvCtjlX1R6BeEeJipIZZZyqy1tMk=;
 b=aDedFtBtzdkn3Bu2Y21XR6bvoorwNEyQeNUL7ag4xtrXLK7p3rzjN9+4fwi6f05aIwWY5Mop/gSVm2832SlTCxZSSOgrdYQpTNxTIiAuDIknZrnRx2nItkeWPsFssDySx1DIDR9HW/JAqJBUYVDns9YhlUBZDu93ja0VQkPX0+WAlAIYRP2+XXGR+jYKNJaMbpek5GAbz1JgZQrUMQmNskVhup000Lcw8yo1zss2c81Q20UdqJtIV5hjilwHm/+T9P+Xmh8sjzCKO6QuM8VeohwjykhfVGr2zHunnMI/cY0P6t6P3N0TXfzIRdaoyY/e6qDIFG2z+EAsW8T4AhEwuw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com (2603:10a6:290:c0::7)
 by AS1PR04MB9698.eurprd04.prod.outlook.com (2603:10a6:20b:481::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 06:21:10 +0000
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151]) by MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151%6]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 06:21:10 +0000
From: Liu Ying <victor.liu@nxp.com>
Date: Tue, 03 Nov 2026 14:22:03 +0800
Subject: [PATCH v9 07/16] drm/imx: dc-crtc: Disable at boot
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-imx8-dc-prefetch-v9-7-3b985e7636e2@nxp.com>
References: <20261103-imx8-dc-prefetch-v9-0-3b985e7636e2@nxp.com>
In-Reply-To: <20261103-imx8-dc-prefetch-v9-0-3b985e7636e2@nxp.com>
To: Philipp Zabel <p.zabel@pengutronix.de>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Dmitry Baryshkov <lumag@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@mailbox.org>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>, 
 Liu Ying <victor.liu@nxp.com>, Frank Li <Frank.Li@nxp.com>, 
 Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SI2PR04CA0008.apcprd04.prod.outlook.com
 (2603:1096:4:197::20) To MI9PR04MB350878.eurprd04.prod.outlook.com
 (2603:10a6:290:c0::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI9PR04MB350878:EE_|AS1PR04MB9698:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f633813-5418-4de1-bc19-08df3972a6d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|7416014|23010399003|376014|1800799024|10067099003|22082099003|261102123227099003|18002099003|921020|56012099006|11063799006|261022105027099003|261021121427099003|261009221227099003|261021123027099003|261026121527099003|261022075727099003|261009223327099003|261009220027099003|261009221727099003|261009223027099003|261028144727099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: fhoRXvxwdjfeVKUJgSIeuYaJw4DgkR94w9JhfsL5qTAF5uThapx+V8zjI/FCTzpZ8Uitf79ePNkDTLUqF78RQZThRW9DPJBRuvQkxZyLSbTyqAqIBoPqP5DoDByAslRlZoCS3YCnUi9ONxZRi6Z1p6g2+pij7psL6hYc7jfQ+Aoh+ANqpqwEtVgx0Uok3EpdP0jrHnP/laJRYb9FtcH/JRXkw2nsWlhYfz0SpbMh/Fui1/29EExIEHiaxw368tvbgV0bNwnHQiSa6+uhXIItkGVYZKaS+J7kmXPAjyRevVcA81BN126aSyC1cMAs8gVPhLNybBrSPM2ih8UFcwMafhpTECDOTEQi6JvSbCafIVjA+6H4tCwRLO2xF8pdRs8Fgo/S207BVMiqNvfRaAU3whhUm1mWCTjJIdgZEVIf1ptbBxr5a+m+nOxYW/Qrs4cHsrk1qg+YgnycVHzf7XtJnOi6lLDA1VYwtmF5N1Yj1EnUYfoqCvk+9LnvlTDlFP9q5qRYTei0PPPwIK52pXtOOwBQFTo4pBsQyyND73iqlynOPZLMH5R+KVpr3F+l/e/rBud7dxiq7eip1aetbYmXYDnKdpDPQG6vCACEAiC78lQ5Rgehj+W8uLnlzoyd7LtDg4yB9GYR/Yxg1DSESH4/3gQ7XV0+SdCU0pWZseoYPI/1M4CtBB3mtHnhT7yR+7rr0+/WDNN+aCNOhrRdhonHZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI9PR04MB350878.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(7416014)(23010399003)(376014)(1800799024)(10067099003)(22082099003)(261102123227099003)(18002099003)(921020)(56012099006)(11063799006)(261022105027099003)(261021121427099003)(261009221227099003)(261021123027099003)(261026121527099003)(261022075727099003)(261009223327099003)(261009220027099003)(261009221727099003)(261009223027099003)(261028144727099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aW1aL1RjNHhkMzB6clA4MFEydnRBOXAxY2l3MGdyc1FSZExGcDNmbHVzWm54?=
 =?utf-8?B?ZnlUL215L2ZUeVMxWEQzeE9aanBkdDQrYjVmallaaUlpTXpOZWF5ZW40ZFQv?=
 =?utf-8?B?aGh0eDZtdkNrWjV0dSt6a2w5V05JU0dGakpUNTNVVUsramN1bERDbVpFZmty?=
 =?utf-8?B?enBZNUdMZFRVNFlINGRjdTZ5NVJkdmdCY1I2VkhScEJ1eVVHS1Z2MG9FM2Ey?=
 =?utf-8?B?ZWhKVTZJcUFwSGU4bkpzSUVhM0xjY2VHb3FIQUhjZTduN2tJWk5LRitVNVk1?=
 =?utf-8?B?V2VLUmtHNlYwdk5qUlUreG5GYnc2Sm9WNWIvR01QellwT1I3OTB5Nmhmd3hQ?=
 =?utf-8?B?bS9jMk51SUpJUFBtUHg1NU0veitYYmlhakZKQWV5MklDM2o4M2pUWk1HcHhi?=
 =?utf-8?B?eUJnTW5lQzVMV2ZYNk9zSjREeGkvcU8vRmV1RTNZbEFXdWNNV0pnT2RSZVJF?=
 =?utf-8?B?cVF1S0ZkOHdPRytSYnFTQlNqNUNVYzJqUkJlNlVsazc5U3FvYUM1MjdDZGtZ?=
 =?utf-8?B?M1k0aHhCRE5LelF6elp1MjlpNm03Z2FZUDFaTnZueFZSMkliWmVvSlplcVdT?=
 =?utf-8?B?L09zTE1kK1lXQTgyZXFsNWhyOE9sVjVKeWd2YmhsVlJscW5pOXdtRzhWUjBq?=
 =?utf-8?B?cElIb1N3aTlvd3JKRFo2dlRiVlFtRThHekJ0WWlaSWdlL3l1Sy9xUXZUWVhr?=
 =?utf-8?B?WDJCZ1NSR3RySnVkakUzKytldUUwNXhYWE50QmlKd3FNOHlpV1lRdlNCR2Vw?=
 =?utf-8?B?aHJZazZSZEpGUkw1Wnp0aU1rdFN5RVZ2azB3bEtCYWpUUTQ1QlZhUmJBZ1A0?=
 =?utf-8?B?T2JyOEFwWklMbXdNb1M5QllnclhSSURNV0xWRWJHWlpYZnMwMUY5MldVeFF3?=
 =?utf-8?B?eVNhbER0Nm9CNmMwOWFvenlBb2ZJa3I1bWF1NnFaVnU1VTBJcE4zOFFhYXpN?=
 =?utf-8?B?SlRjMHFoQ3FxSUlRSmhWczc1d3AwVTcrdVZWQlptdWhjQno1cEZiU2thZFVa?=
 =?utf-8?B?R2szZFZxckhVUmRWNWdKTThDZEUwR2hoS1dRV2pOWFNySmdJbVIzMXM4K0w5?=
 =?utf-8?B?NjIzRm1ZT3hhVEorZVErdXBxRUIrS3hKKzMzYkFXU0owdHczWGdEbHdTRDZj?=
 =?utf-8?B?UnJBaEcrN0NqRlVUVTNNMHRaWWRuRW5nT3hGaXlvbHBCbW9hdFkvMVN5cFVk?=
 =?utf-8?B?aWptSXZoZUhGQlQ2dnRCOSs5cm44U0wyc2VQWmQzK2dFVDArbW05MWFwNG5P?=
 =?utf-8?B?eGxuWVBSVTNIaU1NZkRvSmR2bWM1MWF5OTF0SytDblpKa2o1T2VsTUxvRm05?=
 =?utf-8?B?QVNRcnZyWk5PbTJOb2l5V1lpd1I5Snp4NUZMYWw4alZUekVDYUN0QWJ2QmNZ?=
 =?utf-8?B?TnBjTEZURThMRjdBYTdqNkVML0YyYWVIajJjdEJlN2hqdFNOUlVkdGlqQ3VF?=
 =?utf-8?B?ZVVZMkNpNDk3MnhPb2RDNEhqR2hBNzFnZTNwRzYvN2U1NU9IemNMVTRFYWgr?=
 =?utf-8?B?ZTVsYkk3WWJvVmtHcnB0cVdXcVZ4dFo3T09pOHRCbTdSL2ZhRlBheEw1ZkRr?=
 =?utf-8?B?S1p3QjlMRUVUWnQyNTY4WDgxRU1sOFFvdEdrMDAyS3JzcWxWSjh1YSs5Ym1D?=
 =?utf-8?B?MW1JM08ycjZzcDJuN3lrbG4wNk1HanY3cDIxaGtZakcyMmdIODZoeGhudmNX?=
 =?utf-8?B?Si9XeXRkMk1WV0RUTkRBbjFoT1U4Zm1CakJISXZiR0lOM3hVWndDNlVBTHRS?=
 =?utf-8?B?VGNBMFlJU0xXT3RpSTkvVVpnMVMzOS91Unh5OWpxL2JxVHZRMDJGV0kxUjJj?=
 =?utf-8?B?RExLK2RjL1VIQTVTUkJaYzdaNUxlRDRQcmY0YjY0RWxwVWkyWXZvSng4SG5Y?=
 =?utf-8?B?SnNKY3N3Y0M5MXcwNGExU0QzK0RVR2Nyd05JYkQwN2FUT1ZCZ1o0UXdKTHFn?=
 =?utf-8?B?TDlabkhSK2diNDdUQnRIc2x0NmJpekg0TUI5NEN3RnQ4UXVGcUlibVJ4SkhC?=
 =?utf-8?B?TGJ0WjVPbFAvR3ZjMTcvazFtQlh6YzJSWVh5aDk0VmVLUmtIZHE4b3FKakhm?=
 =?utf-8?B?RDNtcFROSXdURlJyWlY4L2VHZWZ4SlpOWkJ1NkliVlNrSEVJcG1ZbGdMRTdw?=
 =?utf-8?B?WTA0ZnRmZkFDK0NVcHpvYzdoWXdYYWJ2QS92cDYxWXMxR2g3d0N3SG16ck5t?=
 =?utf-8?B?TnhUSVNJSCtPcUlqZ2kxREdVTGhXakZwV3ZWenl2WWIwZnJIdXlhaGd1emZj?=
 =?utf-8?B?MU5TUGZIWksvMGRzclJIY0tFT1crSE9aWFhxTGFUaldiQXhaK3pPRFF1dFFM?=
 =?utf-8?B?d3NVMWMxaEIrNE5CVk5pUG1DMW1tTTNMallvSU1VMHFpYTZjR3FVZz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f633813-5418-4de1-bc19-08df3972a6d1
X-MS-Exchange-CrossTenant-AuthSource: MI9PR04MB350878.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 06:21:10.0154 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: utrXV3Cslm2zrdS8a1lZo/APkgTy5Z6zpcGVNEDwoMv1e4GmFIBZcdYP5NPEzCQA+W0wE+VcCNeabqSh4esFng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9698
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

CRTC(s) could still be running after the DRM device is unplugged by
calling drm_dev_unplug(), because the CRTC disablement logic is
protected and bypassed by the drm_dev_enter()/drm_dev_exit() pair.
Hence, Pixel Engine's AXI clock use count(managed by Pixel Engine
driver's runtime PM) and pixel clock use count could be inbalanced
after removing and re-installing the driver module.  To fix this,
add a helper dc_crtc_disable_at_boot() and call it to properly
disable all CRTCs before advertising DRM device to user-space by
calling drm_dev_register().

Fixes: 711a3b878366 ("drm/imx: Add i.MX8qxp Display Controller KMS")
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
v9:
- Collect Laurentiu's R-b tag.

v8:
- Call dc_drv_set_crtc_disable() in dc_crtc_disable_at_boot() after CRTC
  is disabled.  (Sashiko AI bot)
- Make dc_crtc_disable_at_boot() return an integer instead of void.
  (Laurentiu)
- Postpone Pixel Engine AXI clock disablement at boot to the time point
  where CRTC1(with index == 1) is being disabled at boot.

v7:
- Check CRTC status to ensure that clocks were enabled by a previous boot
  before disabling them in dc_crtc_disable_at_boot().  (Sashiko AI bot)
- Modify debug message in dc_crtc_disable_at_boot().

v6:
- Rebase onto the latest drm-misc-next and resolve conflicts.

v3:
- Collect Frank's R-b tag.
---
 drivers/gpu/drm/imx/dc/dc-crtc.c | 72 ++++++++++++++++++++++++++++++++++------
 drivers/gpu/drm/imx/dc/dc-drv.c  | 11 ++++++
 drivers/gpu/drm/imx/dc/dc-drv.h  |  3 ++
 3 files changed, 76 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/imx/dc/dc-crtc.c b/drivers/gpu/drm/imx/dc/dc-crtc.c
index 0d64186a9901..5bc952d6883e 100644
--- a/drivers/gpu/drm/imx/dc/dc-crtc.c
+++ b/drivers/gpu/drm/imx/dc/dc-crtc.c
@@ -227,6 +227,7 @@ dc_crtc_atomic_enable(struct drm_crtc *crtc, struct drm_atomic_commit *state)
 	struct drm_crtc_state *new_crtc_state =
 				drm_atomic_get_new_crtc_state(state, crtc);
 	struct drm_display_mode *adj = &new_crtc_state->adjusted_mode;
+	struct dc_drm_device *dc_drm = to_dc_drm_device(crtc->dev);
 	struct dc_crtc *dc_crtc = to_dc_crtc(crtc);
 	enum dc_link_id cf_link;
 	int idx, ret;
@@ -287,29 +288,37 @@ dc_crtc_atomic_enable(struct drm_crtc *crtc, struct drm_atomic_commit *state)
 
 	DC_CRTC_CHECK_FRAMEGEN_FIFO(dc_crtc->fg);
 
+	dc_drv_set_crtc_enable(dc_drm, drm_crtc_index(crtc));
+
 	drm_dev_exit(idx);
 
 out:
 	dc_crtc_queue_state_event(new_crtc_state);
 }
 
-static void
-dc_crtc_atomic_disable(struct drm_crtc *crtc, struct drm_atomic_commit *state)
+static inline void __dc_crtc_disable_fg(struct drm_crtc *crtc)
 {
-	struct drm_crtc_state *new_crtc_state =
-				drm_atomic_get_new_crtc_state(state, crtc);
-	struct dc_drm_device *dc_drm = to_dc_drm_device(crtc->dev);
 	struct dc_crtc *dc_crtc = to_dc_crtc(crtc);
-	int idx;
-
-	if (!drm_dev_enter(crtc->dev, &idx))
-		goto out;
 
 	enable_irq(dc_crtc->irq_dec_seqcomplete);
 	dc_fg_disable(dc_crtc->fg);
 	DC_CRTC_WAIT_FOR_COMPLETION_TIMEOUT(dec_seqcomplete_done);
 	disable_irq(dc_crtc->irq_dec_seqcomplete);
+}
 
+static void
+dc_crtc_atomic_disable(struct drm_crtc *crtc, struct drm_atomic_commit *state)
+{
+	struct drm_crtc_state *new_crtc_state =
+				drm_atomic_get_new_crtc_state(state, crtc);
+	struct dc_drm_device *dc_drm = to_dc_drm_device(crtc->dev);
+	struct dc_crtc *dc_crtc = to_dc_crtc(crtc);
+	int idx;
+
+	if (!drm_dev_enter(crtc->dev, &idx))
+		goto out;
+
+	__dc_crtc_disable_fg(crtc);
 	dc_fg_disable_clock(dc_crtc->fg);
 
 	/* request pixel engine power-off as plane is off too */
@@ -318,8 +327,9 @@ dc_crtc_atomic_disable(struct drm_crtc *crtc, struct drm_atomic_commit *state)
 	/* request display engine power-off when CRTC is disabled */
 	pm_runtime_put(dc_crtc->de->dev);
 
-	drm_dev_exit(idx);
+	dc_drv_set_crtc_disable(dc_drm, drm_crtc_index(crtc));
 
+	drm_dev_exit(idx);
 out:
 	drm_crtc_vblank_off(crtc);
 
@@ -331,6 +341,48 @@ dc_crtc_atomic_disable(struct drm_crtc *crtc, struct drm_atomic_commit *state)
 	spin_unlock_irq(&crtc->dev->event_lock);
 }
 
+int dc_crtc_disable_at_boot(struct drm_crtc *crtc)
+{
+	struct dc_drm_device *dc_drm = to_dc_drm_device(crtc->dev);
+	struct dc_crtc *dc_crtc = to_dc_crtc(crtc);
+	int ret;
+
+	ret = pm_runtime_resume_and_get(dc_crtc->de->dev);
+	if (ret < 0) {
+		dc_crtc_err(crtc, "failed to get DC display engine RPM: %d\n",
+			    ret);
+		goto out1;
+	}
+
+	if (!dc_fg_wait_for_frame_index_moving(dc_crtc->fg)) {
+		dc_crtc_dbg(crtc, "FrameGen frame index isn't moving\n");
+		goto out2;
+	}
+
+	dc_crtc_dbg(crtc, "disabling FrameGen at boot\n");
+	__dc_crtc_disable_fg(crtc);
+
+	if (!dc_drv_crtc_is_enabled(dc_drm, drm_crtc_index(crtc)))
+		goto out2;
+
+	dc_crtc_dbg(crtc, "disabling clocks at boot\n");
+
+	dc_fg_disable_clock(dc_crtc->fg);
+
+	dc_drm->pe_clk_axi_needs_disable = true;
+
+	dc_drv_set_crtc_disable(dc_drm, drm_crtc_index(crtc));
+
+out2:
+	pm_runtime_put(dc_crtc->de->dev);
+out1:
+	/* Let CRTC(with index == 1) disablement path disable AXI clock. */
+	if (dc_drm->pe_clk_axi_needs_disable && drm_crtc_index(crtc) == 1)
+		clk_disable_unprepare(dc_drm->pe->clk_axi);
+
+	return ret;
+}
+
 static bool dc_crtc_get_scanout_position(struct drm_crtc *crtc,
 					 bool in_vblank_irq,
 					 int *vpos, int *hpos,
diff --git a/drivers/gpu/drm/imx/dc/dc-drv.c b/drivers/gpu/drm/imx/dc/dc-drv.c
index 4c0749e5aa09..24b4be7be09e 100644
--- a/drivers/gpu/drm/imx/dc/dc-drv.c
+++ b/drivers/gpu/drm/imx/dc/dc-drv.c
@@ -17,6 +17,7 @@
 
 #include <drm/clients/drm_client_setup.h>
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_crtc.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_fbdev_dma.h>
 #include <drm/drm_fourcc.h>
@@ -109,6 +110,7 @@ static int dc_drm_bind(struct device *dev)
 	struct dc_priv *priv = dev_get_drvdata(dev);
 	struct dc_drm_device *dc_drm;
 	struct drm_device *drm;
+	struct drm_crtc *crtc;
 	int ret;
 
 	dc_drm = devm_drm_dev_alloc(dev, &dc_drm_driver, struct dc_drm_device,
@@ -131,6 +133,15 @@ static int dc_drm_bind(struct device *dev)
 	if (ret)
 		return ret;
 
+	drm_for_each_crtc(crtc, drm) {
+		ret = dc_crtc_disable_at_boot(crtc);
+		if (ret) {
+			dev_err(dev, "failed to disable CRTC%u at boot: %d\n",
+				drm_crtc_index(crtc), ret);
+			goto err;
+		}
+	}
+
 	ret = drm_dev_register(drm, 0);
 	if (ret) {
 		dev_err(dev, "failed to register drm device: %d\n", ret);
diff --git a/drivers/gpu/drm/imx/dc/dc-drv.h b/drivers/gpu/drm/imx/dc/dc-drv.h
index 8283795f3c76..1f0af7af5749 100644
--- a/drivers/gpu/drm/imx/dc/dc-drv.h
+++ b/drivers/gpu/drm/imx/dc/dc-drv.h
@@ -50,6 +50,8 @@ struct dc_drm_device {
 	struct dc_pe *pe;
 	/** @tc: tcon list */
 	struct dc_tc *tc[DC_DISPLAYS];
+	/** @pe_clk_axi_needs_disable: disablement flag at boot */
+	bool pe_clk_axi_needs_disable;
 };
 
 struct dc_subdev_info {
@@ -96,6 +98,7 @@ static inline int dc_subdev_get_id(const struct dc_subdev_info *info,
 	return -EINVAL;
 }
 
+int dc_crtc_disable_at_boot(struct drm_crtc *crtc);
 void dc_de_post_bind(struct dc_drm_device *dc_drm);
 void dc_pe_post_bind(struct dc_drm_device *dc_drm);
 

-- 
2.43.0

