Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E328606D801
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 06:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=CGYUklII
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81C6810F397;
	Tue,  3 Nov 2026 06:21:53 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013064.outbound.protection.outlook.com [52.101.72.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4F2410F39A
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 06:21:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SpSL+jhq8q2q9a+PA92lEpsZdQTjhkz1+CyHyBbq0mHLQkoIFGdDgBJUt+XDa70pXtfxSvkK4CaGjcZp8oG/M8lVoWIFskSaeOW+uKZxGQMpFGM7GWokJRRsR2qCTSur5t0Kg5jjj8AqXVdVWuqOqNDgPzs6rB5NqBHLTkJcm1BPEw/afH5GxjBd+gSHL3g3nWi3DE6PbLpzkzf/roGcYo941+vpqISlqSFz3d6Rf87uPYD0b98fMOuedKR0Z1txoe7OKVJ6r5ohJNVIUfg+Gf30nV0WnRI5oKsRtAAdLcGGmVwCoQHg/uV5xiKXqcQhTV3ODT4+nspWLlPdez714w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HCgCejc6+zP1pbPlX4yCXRHt6PU5eLCOTkjqxD0njr0=;
 b=hZ8/C9yXaO2QnmDoh8p2qQoDktPbqLmG5I6F9bVW8nG1JoXlkstcb3cn3I3u5bjfDzBWV0C2680deX+O3BmUS1v0Zop3nmR1JOFaipoK8Y02h3frzijSoGT5Y1xyKDgZP1Tq+7P+6SSVfwoKfBjCf9wa/3n3Ov3/2Aj48/JkKFvch39yOi4f0HUjys2XBbxIgi42lAGtKU7WgNQCBGbv1yiQgiE6vTsH+A9XQSFHmzvu2bMNJZlw0NeXoELO/htwgbZk31QDSG1GOe6382V9SjcDo1qqVk3H/xt900STZu2ywBVK5LrlgFd29KPQfPLXhKvwO/z0XsAl2pjNKjv58Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HCgCejc6+zP1pbPlX4yCXRHt6PU5eLCOTkjqxD0njr0=;
 b=CGYUklIIMRGU0gNMhuta4qU2SbnlsxVJeQLJ+9LQj7Wm/lDLW/l74p5w+5HiZRcDZ/OYUUwovdI2UdJ37yP/41phVnfVKVEP4hfMa9QKh1lw6Eosf/njU2IaC4ETHUdQaqibkHfhDF+DUKyNHGkNz+b+xMKoN7Fkezjw+HAJEWwb71/efGnsSfpEy8VIWx55mgWEDz8r2eY1gzgXAjEnDGfMgCgE7okCi3tEexzqd5IFI9GCAQ+6wgqKPVKIVHJkY1LAHvsgEt5/cUJYQACqiFO+ECtXVP5jz1dtqJzrNLadJIiSwBf0oirR5ipqAuWcRAgRMaIgxz0SuBpbEE2UIw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com (2603:10a6:290:c0::7)
 by PR3PR04MB7353.eurprd04.prod.outlook.com (2603:10a6:102:82::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 06:21:43 +0000
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151]) by MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151%6]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 06:21:43 +0000
From: Liu Ying <victor.liu@nxp.com>
Date: Tue, 03 Nov 2026 14:22:09 +0800
Subject: [PATCH v9 13/16] drm/imx: dc-ed: Drop initial source selection
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-imx8-dc-prefetch-v9-13-3b985e7636e2@nxp.com>
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
 Liu Ying <victor.liu@nxp.com>, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: MA5P287CA0262.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1f1::16) To MI9PR04MB350878.eurprd04.prod.outlook.com
 (2603:10a6:290:c0::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI9PR04MB350878:EE_|PR3PR04MB7353:EE_
X-MS-Office365-Filtering-Correlation-Id: 9408c4cc-104d-44cc-be09-08df3972bb1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|23010399003|7416014|376014|1800799024|10067099003|22082099003|18002099003|921020|56012099006|11063799006|261021123027099003|261026121527099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: x2uPwajzMkaFVSH711SlMtle01hqO8iqnra6RJibPFA+yZ9JQwUMdu0VNvQNg2Gvu6XFjm7/vOj8N4mYN1GPW8dE3kPgaRXsj0dSpHr9BRGJMNavF+jjS7g+F0NrYgRtGk6X5ta6MjgfKhW7Az2oxYXY+IATSlRlFZqhfHIRfEz8FzKyCBD7IrgwmTzIGnxyaezIP80zts/KrNfgvTk8yk4siJiEAV47waouKRLLTiziio3+quGBy2FmAUZLVNjVnmaflD5v53zPE7Flil/yIpU0BWAYj3yVMOg+Z0e+xlQvj13tcqy8fIzYphoFboaw4HO5CpzJg2Vz1avm5EIgZomdwokjxuTQr9h0mXRxfSs1A1GggjGGRuJL28s53mwWlil0nXgXrahtrTxx1xeQ0b2N75W40SVIeCTGU6gAEeTcQM884/ch5+NZhASao3P6N7yC8zJZcIXA1rpSu8LDF8vVwa3N3pEsjRgDixO6RH3oviKCbOsvAtVA+Mvo7k8HB9Th/it+UwXln8BFIAn9FVz8cxaKo8whXhCZD879AWdGT+u0FiiEXDhz/C1Q2qK0e9OU4QRlKL2iO2VrpmQz1mcBgDpbZF3pr6kY/WpYKvvFYQWHDV7rtDdLGiS9cbUN5EdxcozSMUDi9mt/qTR8NRPiB2Xcq80ZQsTUj14iZGuJ0oLE0S6memSQPW5ra8Fbc9QUW2buSKo1z3s4wReAvg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI9PR04MB350878.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(23010399003)(7416014)(376014)(1800799024)(10067099003)(22082099003)(18002099003)(921020)(56012099006)(11063799006)(261021123027099003)(261026121527099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2NiOERRYjgvZXh0V3pFaC85RXJsdGEzTnZJLzRxQURwc3FyWXJPTENxemI4?=
 =?utf-8?B?a3ViNTFJVmsvTDFjM01vVWUwQ2ZXMWVNdjVYWEJPaTFLM3hmTStIdlJ0Sy9N?=
 =?utf-8?B?NWhYZm43Ym93ak85SHpXTmFBTUpKNUpNSXN5dkhqVXV1TUU0OE1nV3JyVFJG?=
 =?utf-8?B?QWp4U2hyRFVKUUxocmFoMFpaeUY1RzV6ZXl0THdMZS9UcUdKSWJZOWpiQWIw?=
 =?utf-8?B?bVRvSm4zQ1dhSkVJakhvZVdMRmtFYS83cm9BK0NodTc3RE5CdWN5dStBTFQz?=
 =?utf-8?B?V3FScWtCcit4WFVBN3kwYmgxazVscWdGZ2ZDZG9venJwWEJRa1ZIQlJXZmph?=
 =?utf-8?B?MXNwcTV4cTk5bUVUQ3Y2WFNtcXVKclo0M2VtZDFSSUltdDVabWhML1lwMytm?=
 =?utf-8?B?RDZjOVdxSkZmSDNGTHR2cWFkUmwzaVBUeWVOQmplSGVjL2h4WFFkbVBXdzBi?=
 =?utf-8?B?VUNiQnFPeDJrbXJNaXNtN2tad0NoL3JMdkZlNEk4cUt6K2V3MlAvcTVwSDQ3?=
 =?utf-8?B?djN6UWJ2UlNWYjVJUnZjTThvSlh2eWhyeFNnSjkzNDdEMXpqaTdLZ2xibFQ4?=
 =?utf-8?B?ZFYveEhOQlhIUXlnRUZRNlhFMkhmNmNjNHE5K0pFbGIrd1dpbXBpME53eUUr?=
 =?utf-8?B?ZG41a2x2WTIwQlEyL1ZLbFRSb202bHg5WXcwQmVYdHFJcFJNaWJsdTIvZ2Nk?=
 =?utf-8?B?RjVlVjZzY2VXRWMxZlQzWThpbTZNSVltNFNPcGx6TXAzSmorQjYvSHo0Z1Jo?=
 =?utf-8?B?c21Qc25tY3BQVjNrZGM5d1JTb1JhOXFPMkdqL1dROEx3K0pqS1ZwQ0JXS3p0?=
 =?utf-8?B?QVNOdm1SaDJxdm5TYU5xN1NTWTJ0dVBOYzY3cUlIYUtkNXFTSVBQbmgxSmZy?=
 =?utf-8?B?SElNQVM5QVRybFZvaldmayt2TGs1R056bndZL3FjZ1NaVERHMUtsWTVoTGtm?=
 =?utf-8?B?cnhwa0IyWGJwQ1lRNUlNK2hldDZSbzdsVEZKd2FJdW1TK2RVTThXQ1JKR0F3?=
 =?utf-8?B?S3A5UmsyY0paRlJET2syWERlb2tTS0orTmQrK0llbXBZb3pTVTRjK2Z0Z0Fk?=
 =?utf-8?B?bDRsdUNGWGxlYVRoVDZvWWZsTEFuSVlQb3I3cWtIMFRPNzh2WDJLQ0c2UEV0?=
 =?utf-8?B?V1d2ZTVSMUpWU29vL1JHU3hIYXhab2hPZkxxU1ZSMlZ6N0I0dk1IZ1hHL3FK?=
 =?utf-8?B?VE1qVkR0c254YXJnWnpVNGlBUEc4QlQ3dzVUbVdXU21jZXNjdGg4Wk0zWHhC?=
 =?utf-8?B?MmFWdlpZYzMvZDRLZTVxRnVGaVFlV1ZFckdnaHAzK3pOZmN6Q3prVlduUVR3?=
 =?utf-8?B?T0lVUHpMWXErdDFSTnhnWVB1YzlvVVYyb0J2bUJDb2QxU2xlN09HcEs4dmlR?=
 =?utf-8?B?UUZ5aENpMTVDSk93T1ZaZ3pDZ0ZWUlcrQlMrLzZPZGpqL05ETkw4UWNGTmJJ?=
 =?utf-8?B?UFowdFdqRFNVdytnN3RnVWRKYnY5Z0MxaDRhWGFNQWZKWE5ZTlduQTlGelNC?=
 =?utf-8?B?RFdFRytQT2MycDZqR3Iya2YyZ1FJL3pwNzFLZjZDOXQxZ2FSUmhYM3VFN3ZQ?=
 =?utf-8?B?U0E3YWJUaEM1RUpYdFVpb3RUUldQL3ZpdDlYWnR6UHFtZERSajVWcG5mZEo3?=
 =?utf-8?B?Z012Q3p4MzRZRWpqUWw3YkdJU2psWkNaWHlBREd4c25mZE53RDVqTzBRREli?=
 =?utf-8?B?b29Xc3h4SEpXR2srdlVwVHZsczhMbU0yd1lRb1psRkNVMmpaR1NRdzIvWWpX?=
 =?utf-8?B?TnE2dFBQUVFvbFhWZVAybHl6S090OE5GYU52VG56aFFjejYyMjJJWGhpUmgx?=
 =?utf-8?B?ay9hZzVDRVNLcDliaG9LdUJRNnptV0xYUnovZnFnNEFudnYzaWN2MFNmNGR5?=
 =?utf-8?B?WFZRWkZpdzZuR1dVM28rdVRTejVWbHNyT1k4RFVVZDZ5bTF0Sm1MaXd5OVFO?=
 =?utf-8?B?UFVxZ0dRdmZvbG5sOGtaVzhEMWJOVFFhY2VOVXZDRmxBN3FJVWtPcXRuSzdO?=
 =?utf-8?B?cWZRODVlb1duY2RXMExjT0FRajM0dm9TZ2l1VGZOcHNBUENCU2tGejNqMDlP?=
 =?utf-8?B?RkZqUHlLRG5qdFdrWGVzTUhPTFh5OEVJcXNXVjlSS08wM0lvOTBEWjlpenlQ?=
 =?utf-8?B?dXJFMjNYT3FBTy96VU5IMkVQcjFUaDlmRFFWYkcvZXlZY3lLY1czRzNqNlZj?=
 =?utf-8?B?cmJiTTU2RkZlSFJjR09oV1RZSWI0V3VzTVJiaTNPMlhVNEluYW5VdVM2Nk1r?=
 =?utf-8?B?SmJ5c3BYb2M1RUU4OWVaeWJaMmlPRWZxTFlUaFhGbDRiV1dhY0k5V1ZaNnZz?=
 =?utf-8?B?WmhGSjd3bk1sbi9WMVl3QzFSRkxya3pDa2RjeU1zZGxQRHRubkM4QT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9408c4cc-104d-44cc-be09-08df3972bb1a
X-MS-Exchange-CrossTenant-AuthSource: MI9PR04MB350878.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 06:21:43.8553 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vtchLjUDKZ+fXE/cOfVeMyJwBEcdIdZygJy+G5RZzIhV9G0EMgL27m+/yTAYkV88YvD0Qwg+NvPto358XdjvPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7353
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

It's unnecessary to set initial ExtDst source selection because KMS
driver would do that when doing atomic commits.  Drop the selection.
This is needed as a preparation for reading ExtDst source selection
when trying to disable CRTC at boot in an upcoming commit.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Acked-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
v7:
- Collect Maxime's A-b tag.

v2:
- Collect Frank's R-b tag.
---
 drivers/gpu/drm/imx/dc/dc-ed.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/imx/dc/dc-ed.c b/drivers/gpu/drm/imx/dc/dc-ed.c
index a4a21d0affb6..1370b968168b 100644
--- a/drivers/gpu/drm/imx/dc/dc-ed.c
+++ b/drivers/gpu/drm/imx/dc/dc-ed.c
@@ -197,7 +197,6 @@ static inline void dc_ed_disable_gamma_apply(struct dc_ed *ed)
 
 void dc_ed_init(struct dc_ed *ed)
 {
-	dc_ed_pec_src_sel(ed, LINK_ID_NONE);
 	dc_ed_pec_enable_shden(ed);
 	dc_ed_pec_poweron(ed);
 	dc_ed_pec_sync_mode_single(ed);

-- 
2.43.0

