Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BCF606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 08:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=uD2/yZtj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBB0A10E86E;
	Fri, 30 Oct 2026 08:24:12 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11013055.outbound.protection.outlook.com
 [52.101.83.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5413F10E874
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 08:24:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mnWnjOeKOEkSPHIkoCP9ZSGLnyYojJpG9jSV6iZiZETasTYpQjn8iXFhjEUZEvLXEnieFrev1FstveMvbxv9e5lp1VkmwxNI1mzyTWSg0HRCCZ6O3ZSlODLUenM6q3dUlC2Pv7l/hBNF3kSB56vL4fB405ml5LyAgfOENOyepRDEWG0PNCN0uRkM4teMveb8lFLVp/sa7+JPjPQQK4GOKn4ljlJQoGJqMmwazaW5WzHjIwqSYNtvLwtxoerNUWuNHnE+HBZvVvjhGEf3T67Z9NB8Kb3lN0eq+GOkZiYWCNCRe+hlfj7ZM1wFkOFUp3dSpOr7KrsQ0YOGN7o9bXVAVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=txOwj9gERRyqHGddBb2ZLDDSkc7EA79Ps/QKkaKpHmw=;
 b=H+4TMFvNJStfzz0SzjElWuZ3sz6scG6m6F22NS3OP5BA1BbyUH/6jJyMbpnfX0+9UXiiDSoMOZESbXkFRgTeaezLmXjue2Nb3aN79hKO4oWPCnaJNuBRnPRHoTjJYnx1GUor1lS7inH1U4XmSbWZtIe7Ak6Sa/64ojW/v9LN5AawSkUgunvcv+zYI6phiv9i/CkazWulzOaLIfTcvMs9NsRJFZ/RPlKX/FDTV2+3BFi3ZWy8Aw8r6+71kUSHag9rXbKkGPyLowr0zpAMCqvTKJqL2qKuvqRN0ligh0wFMpTJz/gXnh4UecJKJoLO/XKQXr+MppGlxuihEnkOkn8h6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=txOwj9gERRyqHGddBb2ZLDDSkc7EA79Ps/QKkaKpHmw=;
 b=uD2/yZtjUwrs+6DCYPKug27QB326CB1uhldXwN2ho3EiuJ3LbFtx8G+hS2iu+p2wIk1lRUVH+TrYMNU2iaUnYFR/Ufdu/2Lc6X8uEEV7E6evLwEzPiz/tXFElw7i960tM+hEkYt9FKT0n4FA7605vUCKwAAjr0Gul41ePOs81AP6Qi5recHY1bC5iSw4nB1mHBf1CsBNtifiQBHv4h5oiM7W2v0seZUid+zH7tQfqx0aGcSrUIo3RfFIDWbfCSkfz+tqRu/OpVB5nE9nG27G03aXwlw2mH2/fa1VOWKggXzKW72w66p6DI3nDOT1QXDbkgw6ebiyqx8IopekYMdLdg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19) by BR0PR04MB401625.eurprd04.prod.outlook.com
 (2603:10a6:2c8:45::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 08:24:02 +0000
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa]) by GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa%3]) with mapi id 15.21.0569.008; Fri, 30 Oct 2026
 08:23:59 +0000
Date: Fri, 30 Oct 2026 10:23:56 +0200
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: Marek Vasut <marex@nabladev.com>
Cc: dri-devel@lists.freedesktop.org, David Airlie <airlied@gmail.com>, 
 Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Simona Vetter <simona@ffwll.ch>, Stefan Agner <stefan@agner.ch>, 
 Thomas Zimmermann <tzimmermann@suse.de>, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/mxsfb: Update MAINTAINERS entry
Message-ID: <auRT2ucePXPm_hfX@vm>
References: <20261030081908.324212-1-marex@nabladev.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261030081908.324212-1-marex@nabladev.com>
X-ClientProxiedBy: FR4P281CA0271.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::20) To GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB12318:EE_|BR0PR04MB401625:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dba4cc9-d9ad-4735-4e9b-08df365f25c9
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|366016|376014|7416014|23010399003|10067099003|11063799006|261028144727099003|261022105027099003|56012099006|261026140227099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 1c+7bj4JacPUrI2r8EKpe6UiHYfFDjNlqo+l0n+4d2NfWj55FFn32H+6L4TzG7kvE+drbDw6+7aW0joK/ICPwIsjRYrYGhRpbUjRN+RpfLpijEXlIumixvksgsxWGRyqXO7j3RFbnEBp9lxr5E69bPbLabUL2T/SqZ/tA6r6+tk9b8wU1Uyq+35rxAIa4Sy7OyeVUX9hkhSiGFWjjKMaJvo9DzIav/8Xz4K9jvxObrEYLfCt1+rCk/cQBRnlT+WzRSdn6/ZyPspf8jSlzjmSFc0IBu4RJfh4jMRo/ea0ChAiHh/so6v/bPA9XQvL7+G0Tf+eCQxANJAAs4Imw3S3REO22Rh51WUaBYicbI+h+EuT8hlCFQiaeL382uwd1qpIdAaFU3SgV2bQr6OtMvJaGVYAbRpB8oOGFn7/mvDXeGIIaqmFYdXqVnzO5GVrBgIZSXUuhPAnz/TNEwQ27EvKxXsYr+Ay+lO0XUOO1oH6BAzskC36V3ck7iD2pgDvIFTDK820ccDel5+Zj+1mxytvxv0Of8BZin/D4EvDVW5napGEBIZihCa+ZmV2tR+TFM2+8eY+OOoVzhgYHiUQ3HjQJ5NC8AFiPjfJp6h7DSanvKmX/BULNw7TGGsWD95FabWOLJMzk/rtrJQfiSmzYtuHvpbUohjXfPssannyuvXa8Ac=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB12318.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(7416014)(23010399003)(10067099003)(11063799006)(261028144727099003)(261022105027099003)(56012099006)(261026140227099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TY6Kge9KuzfdPJKXlBkd07XWGfi8TSYO6KRzF0jFxXTGsVOb4l1zEIAP3NKQ?=
 =?us-ascii?Q?ZVeOJjYPAG4nxj+4uvEwXCZJl2+nz5LyEfdnFPyrDHR4VqCmp92nkRwA33Io?=
 =?us-ascii?Q?GTme+aNNe+5H5YuanZVUW0dpXxXO7RDE0u+atvx3A5UeNEU8drOmqwts6kYj?=
 =?us-ascii?Q?F0NB9jLJ2geHLw/UhVHr8Ycgg8xTifjTbjVjh1WL2ek2uaOHJfQ2fttfq37G?=
 =?us-ascii?Q?0kVpz49BPAH83eiGTLiDwIQWSHUXn36ec8v1eY0NazfbTEIxmuzwrOmkV6tE?=
 =?us-ascii?Q?SAFsB7TRqWHRxL6WzhnDwDJhx23Bn+NVvZKmKJgKUpqbWkL200k8VCoj147i?=
 =?us-ascii?Q?sblfqC2qs9iVJ0HDpW3t5xcQ2TwU1/VCRLOI9VhfH2Rpv73x77TWyd3/7k3Y?=
 =?us-ascii?Q?RcWWlo+HXduq0mZgRBxWtIZZCk/OToWA02T0p6bH7Nwrzv6vKBT4BOYjrXs3?=
 =?us-ascii?Q?nBVNErmqEb+kJMenxK29JKE7I5XmN2xihdRhJPPxJHtnRL4gaaJO2lknG4z9?=
 =?us-ascii?Q?o6yZmtUxwTCnNLukgvw5PBeIac8M5YQhbrbAodmbYnXpLBb9OHxzqsl+1v4A?=
 =?us-ascii?Q?lCfs2Ph1T09wD0weGE5hBAk5UM6omniHnzvSIbLoWkrlnpPgeFkYYlF+jMlO?=
 =?us-ascii?Q?rhcYxdOK9+6HHbQvK4NVU/adyxEeWRX3NCDMTA4RTxxYGMIpKdUrnJ6HWT4T?=
 =?us-ascii?Q?0cdV0eW5QPsapuHQbMjYCkyNi6b7U3OODD6NBno/+9urDTd362gsSODjgpSv?=
 =?us-ascii?Q?s/krGZZKhwzKn/bhQpyWNTNeCFltASf60h6/3RHXXt2mXCEL2HjzOZcFN/jM?=
 =?us-ascii?Q?1t045X2fH/VuMPguzrXa4MQJ7fxVO4PHunOhHOs8qRnGNz+Gk0zjer9VTQm9?=
 =?us-ascii?Q?2iUFRzrGdIEG7fLeCfJpTVLDPiqAxFIyjT+Blbbl9Y5AmvqakVkICLsQaE1m?=
 =?us-ascii?Q?njY/peveBd+j15G8PzmUxxSay2WWf/7xj/ac7/kIaY4YUaIpXt6jK4MD6c5P?=
 =?us-ascii?Q?7mzwBsoMhIARLVlvt1eoH2AoHooNlHbX3gqfF2uPIkKrMifKsyKbVYqRb4sG?=
 =?us-ascii?Q?6hDYZ52oRWDyAgDE9XicghYvMFOSZykAuaTrrYottggfErfr6YwkvsLGgfU9?=
 =?us-ascii?Q?O2RRJ8qIOd2YaCH4yENOlM/8gWewbgSo6oFWaD7MBtaV5i9QmpJwYktBjSpF?=
 =?us-ascii?Q?EEIif8LR7sWlHS0CLQ+n198aWGrt+YQoZqbmv+6jgE8/nJoyU80Ue23zJzrT?=
 =?us-ascii?Q?5+iYvOi9Dyyr23xdfyRUB3ulc70wAXdZm6O2RSMCrVNsJ1c6sqLlKHPZsY4H?=
 =?us-ascii?Q?HI+5269/tfNIdzpg9ZbunUon7nm8mGbWIooWOJZvFY0y+L2lXox5kGvewmId?=
 =?us-ascii?Q?hiuxGPDABleqOMjk+xmcvDsGDkkrOi7fFLW/VDUmYGrsxUk7zBOLbJBjjmPQ?=
 =?us-ascii?Q?osh/vYyjA5F1pbI9ii2qKPIZIDwpL5QrLFAD1DdtjayYsBOVn3HqaWcr2rne?=
 =?us-ascii?Q?qlWRriqeG3Vk3safqZgGmh6VusrgYaABxR3YL02f8UzlsMGUuzhnkyyloVLW?=
 =?us-ascii?Q?V758DmupcrmhwcnNZ9p8+Q7u6Zhg/KDuySFsScjNluNpqF5jWXyXZPG04Psv?=
 =?us-ascii?Q?uvYMqHmcHesJAzp+6VOO7VhCPGE70QFlGTouVl7H00QDZoKSkOnMWzuaKLJt?=
 =?us-ascii?Q?MRD4gRbsMSIcQ1Bb6cUMvP+HWcn0+j6oha4A9M8DwRG10saWsdqEZ5zb06xx?=
 =?us-ascii?Q?kLwnN+lyfw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dba4cc9-d9ad-4735-4e9b-08df365f25c9
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12318.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 08:23:59.5146 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Db8NZv5EpOKqk+djotlcrNiylQH/Pgmsyw+7PeT7IKGbaEyP5ZzS/v8Cwcek3zs6bGwzK2QXAwia9IAAJSyhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BR0PR04MB401625
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 30, 2026 at 09:18:49AM +0100, Marek Vasut wrote:
> Fill in updated email address and imx@ list, no functional change.
> 
> Signed-off-by: Marek Vasut <marex@nabladev.com>

Acked-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>

-- 
Thanks,
Laurentiu
