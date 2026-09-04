Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13AB6C624DE
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 07:54:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CBF410F905;
	Fri,  4 Sep 2026 07:54:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="OjhJj8jY";
	dkim-atps=neutral
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013006.outbound.protection.outlook.com [52.101.72.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB0BD10F905
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 07:54:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RfRn9ocS6o3nXQ7fdjApmnsnCc4neaoxiBl3H3od4jpjjstP4yrZXrsUx9JxUx5tWpUc0mlGtWOr/M5ESYlX0IiqDR0QSKI1nPRtMN3xllIHP+03QmPY9NADmqcEIPQ+vtQTKVWZBiFiA0sDbDK2l23fcF34nTgOg+guyUmuaAD1FK1rHyosySW0EaXd+rMKQGnmPEaWKSWwYERizlqZpp4cGq6KeAIVgq70elivEoh4sF2X4q4hgiNgiG7YPwQNMHcRGDzDlCsmyJPypQU8Q0hM9UOKnqGfaQM8q1jB8vQavbENb3m/TuT94SMepC8OVH6JCyOGYPMCwRvxvwYo6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KWD5/sMxn/XcDxvP6Mps/cjNeNX4K2NEaPH7EJ5sY9s=;
 b=AFfXwTAX55m+v+l3+vPh/9Mc8AqmuyyPxA+qcntmEyz8KqYuMx8/lizKXHT1meuuiaueQ4MNQJ3ik/BV7zwkJcCsNjV4QV0jCsHF+TRJLolL97AztBy/z6azVmaokb8P5/osceLmM13yYPTYlS/jkX3nVYX88QlrYFMQadLkchlg+5ecpqVp/Smo/035Ectq2h6oVSozn4D/wEB/hfJJ4R39rECSV1hMHyPiuY4DaszA2zPYZNmkF6TugJ4t3bI5UFcyKUfksJUaZL3cwaAnMy0SrSWQiweM0NHBBiLghLOaZEraYgnVwKGRw+BaTCj22gP5g78NnYNeITfD99ftow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KWD5/sMxn/XcDxvP6Mps/cjNeNX4K2NEaPH7EJ5sY9s=;
 b=OjhJj8jYOwKkPSKg1FFpjmPEYsq9DpupcwFvpBo2Dnt+8tD/UcpeGYUkGPqbDHhHmUsECxrNXnYWV7Z0Yh/75scGk4XBxAvJLx1dsZZK3YEx2D/6jfAlydKgZBCvI7U7nns1O0r/LJAk5cO1URrmQDkHbAg7b4U0+OaDerXbmIV57IPL9VN6wKN0W1wPbPNmj9BUuQFCJfUkngbfsTjqZH97VS3SQIFFhG+e6H+MTfnXRMffDHwfXfoxRSL6Yel4pP1iHSJ/qYEi4+x5lSTg1xu7ZwKYhVeiBeovTyzzcMHTCCyGUl+p/x1ArzDSNCX/6QeTSex9+IqdW0H246YpZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com (2603:10a6:290:c0::7)
 by AMDPR04MB11702.eurprd04.prod.outlook.com (2603:10a6:20b:719::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 07:54:37 +0000
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151]) by MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151%6]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 07:54:37 +0000
From: Liu Ying <victor.liu@nxp.com>
Date: Fri, 04 Sep 2026 15:55:00 +0800
Subject: [PATCH v6 10/13] drm/imx: dc-ed: Drop initial source selection
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-imx8-dc-prefetch-v6-10-26643e3f6cb7@nxp.com>
References: <20260904-imx8-dc-prefetch-v6-0-26643e3f6cb7@nxp.com>
In-Reply-To: <20260904-imx8-dc-prefetch-v6-0-26643e3f6cb7@nxp.com>
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
 Liu Ying <victor.liu@nxp.com>, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: MA1PR01CA0168.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::23) To MI9PR04MB350878.eurprd04.prod.outlook.com
 (2603:10a6:290:c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI9PR04MB350878:EE_|AMDPR04MB11702:EE_
X-MS-Office365-Filtering-Correlation-Id: 56b945d0-0574-4670-6314-08df0a59c463
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|19092799006|366016|1800799024|23010399003|10067099003|18002099003|56012099006|11063799006|22082099003|921020;
X-Microsoft-Antispam-Message-Info: pb7P+GbBbH5BWMUQqWBnJIg+3R5JUkhz0ozZbimdBNKEqxqT7XCDAuh+0I2eNoh2wQLtuothPfsZUnt7ozZ6BXbugKCQ9r8NuhRjK44nab4EYu9x3Ys5MNCGghvh/RpwslqVTnt2oc8eV3J8TaTX0uD0oGUuNaEVQ0O7BHl9UqsTIWyQDh7XVF2toT+KLnMBdRBoGWQenx35CDHu1yAjtAE7RbAZA/YhFRLYLQlQT1oYv7Iy4x5cyhM8yFMvAW1PKeOH4E6o5bdxSmS96HH53lktZlXnnqOwNO4N7UMUl/8QyT12nONfQOIdFNBa/8cbgcsZHnkkh/mG+ibI/jAuuyBhPVXlyR1Ahmov6+Lk9H4XvjD5oU9GVxa+xVMUB7/nkL6StA+pxBeebMFvbu8N500AjzhN/pERRZwis07NSGH6z4HEIFF/KfLEKis8enVMq2e5LjBPQvaPfK+sHRt01/isjby6lXI4TgQplWEu/gvdyb5HY/AAPZTGCHGc/sRc+DS80OQiQCXJkT+CgLfBjhDuDBNYpJ2/8qZ01qLzcrD6hiOrG7x1a27+Dqn2c2ySjOm+dh8+oTKVHMuqMJxJS3rIOMuTaNdKPFcVwshEkM3D85AfNEpZ7BU3BkZaSatM4VAs1Xkuly7+kfSPvtK0hWCPS3aOKAXqLqylNkCIFoCfoEuRHHc4HrhTcmx/yF2kFuPUOi1xgiBzj8tHSj/J7g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI9PR04MB350878.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(19092799006)(366016)(1800799024)(23010399003)(10067099003)(18002099003)(56012099006)(11063799006)(22082099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkdCNHk1dXAxQWQ0cC83QjIyK1BEb2Z3WU1YT0hEWWVEL0oyZzZ0YzVoTDFJ?=
 =?utf-8?B?SkJwSFYwdjlRMkFuTjZqQVhoYS9rNFdGeldYMHRxY0RQdWF6VzFLeFZlUlBZ?=
 =?utf-8?B?c29FZ2dCZHZKUWcyeXdBNk9nN2NqWXdxVkNEYlB6VnlRN0s2MjJFQ3VKQi9u?=
 =?utf-8?B?c0pxRkpFOWNhMmcyaTlQVmYyNDRtdVlLZzJLS2Y1UnBHSlhFdEZNVVBaWlNk?=
 =?utf-8?B?NVdYUmpKc2FFT2JNeXpNZ0pTSVk5SnkzZUUwdDFxYk1JdFhzSVF3enBDU1hs?=
 =?utf-8?B?SVpMMnBxbTF3VGgvU0h4S2xVODNjck1jRGdwcnJOb2twdnpRSytnVXdxZmtP?=
 =?utf-8?B?UmRQbnZ0cDlSYVN1SE1ucldnSTRBaDMwWGpxdTd6N1VldnE0OEdKd2xKa2pr?=
 =?utf-8?B?bnExR0pTcDY2Q0ZaZHA2S244czkrdm9pd2Y0Z0ZOMkdud3doSGdKeG9jMUJr?=
 =?utf-8?B?MS95MklHbkNFRjhSQjNaT21zNURRa3IyTVpWaHRqZkpEU2hxT3lxRlg3aDdF?=
 =?utf-8?B?QzNWaG9XUDRONlk0K09pT25kcUt6eFJ0U0xNSVRPRnoycmxITW5OTWtjQTRO?=
 =?utf-8?B?dThRVExDeUkwRzRiMGY0NmRKcUlRVTdoQk1DblZzc1lKa2FFVm52b3JqckpS?=
 =?utf-8?B?MFgwNk41Nk1yNXFtREJ6WGVKNUJ2bWZIaWQrZVF5cmlaNDdoQXFObTBxdktp?=
 =?utf-8?B?b2Y2Y2RIaVd1Y1hkQVlOdXVSRU5PQy82S2tmRTl1bjVLdW51aGk2aGdTMVN0?=
 =?utf-8?B?Sm44T20wemE5eVpuMDFYbnhOSGxBVHJYak5tbWJUY21EbThvSjlkS0hOWmw4?=
 =?utf-8?B?ZnVwWVZZcWFnajYzYTdhZzdNckxvcDI2TU1zL1N2VEtQZUJNay9lU01qbHda?=
 =?utf-8?B?ZHdpWUFVdVd6VWxQV0RjWUF2MmZtR014TEtCcmRVamNGWCtMLzJrZnhTZHpD?=
 =?utf-8?B?Mmo1bWdudVJjdnRFRjVhelRjNkpVKy9zeWVDaGF3aDRsTk05THpVUU1jeXlI?=
 =?utf-8?B?UzdmWVJXamwvMnU1elUxOTkzSEwrRUd0U1NyanBjZmMwU2Q3d0xXZXZKbHU5?=
 =?utf-8?B?ZzFhdkxkY3V3cUFtYnhVSTlVelFqa0xld092WW9sS1k5UGhMd0ZNQW92UVZU?=
 =?utf-8?B?d3R3eWNMc2t6eWl3dUIzSE4rdGxRclp6eTJpSGhaNFU1eHFqNDdmZWRXa0ZN?=
 =?utf-8?B?ckVHcTNjMVprRStlZnVhUlhXb3YwUGlNZ1p6d0QyRmxmbzZySVMrSkoxTndz?=
 =?utf-8?B?OWdMNlphYU5OWmNoR2hZZWxuTTNjTXh6aGxKOGNlSU8ybmNkQzFGS3FOSFJF?=
 =?utf-8?B?SmUzMHpBWkJzMXBHM3h1M3RUTzlmNmZIK1BXclZNL2lBV0Q2OHdIZmFGMXFY?=
 =?utf-8?B?cXg4NjVCNWRnYXVEekJvNm0xUllWOGlYaHdIY0xIQmVVYkJ0RFl4ZEFPNDhv?=
 =?utf-8?B?eENiOGNpQ2pnVk91L3Z3TnFGN0dGanQ2VXhURFduVURHYnBOYnBGUDNjc1da?=
 =?utf-8?B?aitHa0JCY2taemVpRUZMYVlhZElmYUZpUW5TdWFQbmRpMVNqRHhUWG84K2xo?=
 =?utf-8?B?SGZoOFd4QURNZU5yYVVWN0hKV0dpT3B0U0ltazE2R2NuemJRWDNtT2xxblRZ?=
 =?utf-8?B?V0hSWlRRaDB6b1lZbzhrQWlPaGRqV1lleUJmQ1AyYmtKNDl2V2VEeFluVmhF?=
 =?utf-8?B?dEYrdjBqZGJHaW5qU0dMdTMzZzJZQ0x0LzdlbnU2anYzSTdqT2NuQnU2cWVW?=
 =?utf-8?B?cWxROE1xYTBJQS9HbFRMOERlMEh0SW82MHdIem14Ui96dEt6cUFaRUNJbkwr?=
 =?utf-8?B?WWtZdno4UG11TDc1cUNXdWVaVXliem1hQzFvSldQV3Z2bHAvbEpOK1VBVm1V?=
 =?utf-8?B?ZTF2Nk1NVjlFWnBEbXlRRzE5UjIvRjEzODNWNUpOREtsUlFLcTdLVjJ6NjlC?=
 =?utf-8?B?Q1AzcGl6dUEyZG5ka3A5bzV3by9Uc0lGV0JaV1hMZWVvNS85emVCN1R0UEZJ?=
 =?utf-8?B?VENnS3lOVDZqaWRRUWZpQnlDR0dEOU9mSmEyTkdzV2NwV2hLLzRPRCs1VHdm?=
 =?utf-8?B?K2U1NThPQ0JaZEdwUFFWRk9RZzZSTWttWlBZQ0pZRWNDL3BIV1k2VHFmY3oz?=
 =?utf-8?B?QjN5OVlnT1JBNDNlQWY4L2x6UjF1M002dGcwUzF4UHhWQWkxSFlXWkFnMy9G?=
 =?utf-8?B?VVdzWVloK0ZMMUdRdXBIamYxTWhnckFTZVBqZUhGc1VZNGFlZ2lId3RTSHFs?=
 =?utf-8?B?QTNKblZxTFdibFBsSzVxWmpvMDVhaXdEMTZXZno2aU54czlrOEdLWWhPQWFL?=
 =?utf-8?B?eVNvcFo2VnlUcC9nY0xZTnhQUmdvK0ZmZVl5TmNxRW5ETkViWEFIQT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56b945d0-0574-4670-6314-08df0a59c463
X-MS-Exchange-CrossTenant-AuthSource: MI9PR04MB350878.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 07:54:37.5043 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9BNDKvHVrTAMiuhf0SnGomd/IwMpfptss8cW8S6o2YoPK4OhZAxLOIh8GwzX17qEf18E4aGxx8W3QQkM56SXlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR04MB11702
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

It's unnecessary to set initial ExtDst source selection because KMS
driver would do that when doing atomic commits.  Drop the selection.
This is needed as a preparation for reading ExtDst source selection
when trying to disable CRTC at boot in an upcoming commit.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
v2:
- Collect Frank's R-b tag.
---
 drivers/gpu/drm/imx/dc/dc-ed.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/imx/dc/dc-ed.c b/drivers/gpu/drm/imx/dc/dc-ed.c
index b8ab41271bb4..803b3e891a1e 100644
--- a/drivers/gpu/drm/imx/dc/dc-ed.c
+++ b/drivers/gpu/drm/imx/dc/dc-ed.c
@@ -202,7 +202,6 @@ static inline void dc_ed_disable_gamma_apply(struct dc_ed *ed)
 
 void dc_ed_init(struct dc_ed *ed)
 {
-	dc_ed_pec_src_sel(ed, LINK_ID_NONE);
 	dc_ed_pec_enable_shden(ed);
 	dc_ed_pec_poweron(ed);
 	dc_ed_pec_sync_mode_single(ed);

-- 
2.43.0

