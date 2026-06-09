Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91722CD8CAE
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 08:10:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6AFB10E17D;
	Tue,  9 Jun 2026 08:10:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="fCG02AqW";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012016.outbound.protection.outlook.com
 [40.93.195.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B227610E17D
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 08:10:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OkZSYuHPzvxdy3YL37rd0nH65d4IXmeJYqoLLgyuTnC4LIuClcdV6udQLZCopYAfHl04SSI0GusRTvyHxzMl+MKbIr80DvShgdry/PCsXn57CWv5jytYWGEsuKQxM6dMBpRS09XLC4JRDm/5Gz1kmdglxRqJeYQ+JPd5k49wL9c7x1vQwQPd2clEdpj1bZk2/sp63QQmXJGV4q7i/qzXsMYpbr/asBTJ7nVlhzC2GLPboO33FmWqtopTdeTUxcEN+RH0H3HYtYUKYc2vbqa5EarTtnJWoPi2rHZVjl9P9isSY3NM6ImzJXFaKkjGafp5PePYsoiApAHBvf9F4wRfVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Yk+lLgc9Z/3naxZFJM25asuE2aJ4aRXc5OfdjmrieE=;
 b=FovAM8fElReolsaU1Z2r6XZYAhzG6/AuTUSfzUCx0qKVRV4OOTmt04/ffnXiRZ9Zy7JoK318FFWZl17sejDoYVc7iOF55iMcMENeRnhDd083vwyZBUm5A6kYDxnco3OFTblIITKZTvtZoELZ9wFlsojjp4hlQbf9C9+O7NhVvYQPlCilmzISSbuPnfMO/o1ah/0oHXSFZbvp8VO3QDIxH5ZjPicJTTBxpHCAqG5CRdAybgL11ofVGkhU+cbVuBSZc6EWvLgHYMUAQ5/A8Od3eHA/COL9UMwyZNCEoDM2Rj2KVxEpo4OJLpOvx9HsdnkSAMXBVIuJz4e+usH4YXCYZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Yk+lLgc9Z/3naxZFJM25asuE2aJ4aRXc5OfdjmrieE=;
 b=fCG02AqWJ42Gj9PaE184A+WXnAW+uO1lLTbY5yqpUe0Wz4RKsC5Ydw18PjXPxI80PB4pT5uwpjjtSQW+ifhaYRlgEtXcTUKTUDxt3bE/JHZsXIRcu7tG9/dD9/pJMDLMw2mwV9XSz6zTF9zC9FPblakcM8fyzyjDcKpSgRJqHKorIXFAIjYLMv3qyX4sMluV5npz2IYCoaNSoJN8/vdqvcoxrpg2e/VaY7om3c/hhy4zbGI6FcVpuSHlkgwXLGB5jT/rEEb/A0VCdyGG1mlxIiM+ZI2QqNTpCZHI7+JbZ+ediLs7IV1fzqtaVnzcYk3zS+22zsYh5BkIKMV3qkac2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by MW6PR12MB8900.namprd12.prod.outlook.com (2603:10b6:303:244::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Tue, 9 Jun 2026
 08:10:11 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%6]) with mapi id 15.21.0092.010; Tue, 9 Jun 2026
 08:10:11 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Tue, 09 Jun 2026 17:09:18 +0900
Subject: [PATCH 2/6] gpu: host1x: Avoid double device_add when clients
 already present
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-b4-host1x-small-fixes-a-v1-2-7c1131c0b3ad@nvidia.com>
References: <20260609-b4-host1x-small-fixes-a-v1-0-7c1131c0b3ad@nvidia.com>
In-Reply-To: <20260609-b4-host1x-small-fixes-a-v1-0-7c1131c0b3ad@nvidia.com>
To: Thierry Reding <thierry.reding@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mikko Perttunen <mperttunen@nvidia.com>
X-Mailer: b4 0.16-dev
X-ClientProxiedBy: OS7PR01CA0296.jpnprd01.prod.outlook.com
 (2603:1096:604:25a::9) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|MW6PR12MB8900:EE_
X-MS-Office365-Filtering-Correlation-Id: 80ec356c-4f71-4a7e-1e4c-08dec5fe8753
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|10070799003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: kiZaKZ4dzovMdIl4F03BwtoCndmJOLt0B9xCcKINjxFsx5155idEyLaKmbBsOpa5uQXUvTAPiQ4eRj10Ou2RGZHS0fNKqV+L/YnZbN91jXqMThdY9OAwAnWBoC+hg2QF5VgAD4Njbf4cFHDjao5pJlko8r67gmu7UuPiGiKxUK5LW/vGZkRgKCRjlg939C2xFzm0e2EDvJjp09ZwtXoYvYCcCQXpTF09b2mu/1jqlvrPbQRe0J+Cyto6fggGPyPl/KQSwQ5tstHrCg5l9mqt+3k08mwTxZ+26fAibP9T+OdqpNZiP54/LFg4c+ncBPPNxFBuwIUYuBI0klnL/d7Zd49ZCzDtP7zDJs0Ypwe9gFspdBtGE1urOs5W7nhcLf9uS2F27+Tkyk4mQc+3trPHmeyBp/981/nImBqMENH0I6uuDGfDkucy2990CaIAj19mQAuS3LPkS5YcTAPFh+4zb9gOvfZU7whEAGqWjdbx9EP56kpibOJJlQxBMTrqPGxhvsk82csZTjAeaLCb4zum0jeg/shdxiO/l3vfk7IAfHyutkdPPjpFtYQ6CNUQyKC6xkbO2UtFdUOygzMUDN4FeAeDKNSJoLyTSJATrcYDk6cr8+X7fRHVzYO0svxCB24XpyQFXURDgmJswcCu2PMv/5rHntLy4XcXy3ULRiSLADRLqrY11WkY5rLE+zcbR8En
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEtuTFNGdzFOWHBpOFlWMTNjQXBucUlRcjVjamxPTGxLT3VxeGNYZzhTd3NO?=
 =?utf-8?B?Q1BzTVEwR1UvN3BsZ0JvUnRXMnlKODRMNWNCQklYa2FqaUZtMXJMTE9xQk12?=
 =?utf-8?B?RjhEWUtHeTR0andaUFBMcXRVK2dhUlpDTXFkS3JvZEYzSXhZdTVRN2l3STda?=
 =?utf-8?B?MmtpTWpRTkhZdjk2WkVONGp5UEZkUjNwbnkybXgyanZKdUdHTkRHdzZKTDNJ?=
 =?utf-8?B?TjZZdVlnM0lmNmJDcTE1YzZKNTVEQ3RGRDlYTTVFM2d4amkrNVk4UzhPN1BN?=
 =?utf-8?B?RUI5Z1N4UC85VkdUWXY4OTNtN1V4RWhkeGI4SjUxa2xxUmcrTjg1enRjNW80?=
 =?utf-8?B?NHpWbHY2SnpCQ08vWnkyNXdBaFZxRll5UVVBbUlmblIxeXBUSnBYQWJnaWNU?=
 =?utf-8?B?MzU4VjRseHhlelVCcG5sTndzYUNGV25NdURBOWUrTHBSN3VjaHdMZldZU2pE?=
 =?utf-8?B?NlFqaVh0ejE5aFJHWmpscVBjR3JQaDlUb0J4Z2pZUDBFdUpMU2RZQ3RQMDE4?=
 =?utf-8?B?UVNTTDU0bU9lbXpHYVdwOGIyOE9TR1JsM2RObURTVW55dUQzamFBUWVjVnY3?=
 =?utf-8?B?V2ZJRHVkU1FuUmVuN1hyTFgxT3ZuUjFxNVN4U0FrYXpCL1pkdlVTV01FREZr?=
 =?utf-8?B?TS9Kbk9tTHNUZTJodDZnYkNLZDY2RDlZbFVWZmREMjZXblFQeEVIZC9BOU42?=
 =?utf-8?B?dDRLVXZIV2tlRTZOSCtxaUFHdU04M0R5ZzFMWEpIOUlUR0RyMHpGWXJOL2pa?=
 =?utf-8?B?K25xckJpL3lTdThYWUtHMHh1YlQzMk40YXdJNGNBUFNyMG92YitrN3lqUXds?=
 =?utf-8?B?WFdlc0pIM0pCTENndDRSUDQ3NGNJYTIwUjA2dmE3UldwUmJGU3I1alJjYkVW?=
 =?utf-8?B?MFRtdU5KUGdRck1Sc1dwS3Z6cXBIYWFiZklwQU9NYkEycDVVcXVVaE5GakJI?=
 =?utf-8?B?bGRsdjV1Q3BNcjhWdkxITmpmbWtlSm0rL0NUL3NhNFQ4UFBTUWJ2QmF2TERS?=
 =?utf-8?B?RWVZdEJsUTAwR3h0dXpEeUpzQmEreHcrMWdYdkwrZ2pMdG82SkZGRUlnU1Ur?=
 =?utf-8?B?V0pUN0phOXFvamQwQXY3ZC9yYzA3QStVTmpnRnk2c1hIVFhjQ3QxNEYvRE16?=
 =?utf-8?B?d2dtWnpMUGdMMmhDRnphMDUxeUExRXRxaGpENEVESE8wT3MvTXFkaDlyeXBp?=
 =?utf-8?B?OXlTcysxTHpSWTBEbEdvanZwaFgzUFoydkdSc3FpZCtFMU9JbW5GNjA1MnpO?=
 =?utf-8?B?K3Fxc2ZZNTdpTEFxVVcrRmNnVS93WWdKdG9Ob3JXN0FDc05ZUTVkS3lyNk45?=
 =?utf-8?B?SFlKdWlFU1NUYThxRS80VldzNk10bjhKWk8xTzk3TXE3UFc1MmJxRnF0RmpB?=
 =?utf-8?B?b3pPMnFSZXQzcXozQWlqdllSSWFxenFqZzRLcjEzUmhDVGZycDJibnA0MVo2?=
 =?utf-8?B?N25TU0xVN3pHa0Z6Zk5QamdlTTM5QzZUNnJWSkVuL09JSUFuYmh6d3JrMzFY?=
 =?utf-8?B?d1F0QSt3d1ZNYlluY05QbG0wWHhLZHVZbFlQdmJOMVVIUFpLanprWlkyV01x?=
 =?utf-8?B?K0gwVzBHMkIzTVEwcFhxeVNOdlZ3Y29pQlZOTXd5NERuejg3eWlnT1g2Wmdx?=
 =?utf-8?B?UklIWk05b1UvRFZzRVBrRDFzTEpxOXpleGhQUURpdTZRVGF3YU9GYjZTV3g5?=
 =?utf-8?B?Q2ZaTjk1VlpXVi91ejVaNThsam41RWNlaWlXSlFLZGgxMmpXZlBPYm5hZHgy?=
 =?utf-8?B?MWMyc1RmLzdpWVpnbFJCWnA5b2xkWitPMzU5Y1RmTlBGTHh3RFlDLytQTUNh?=
 =?utf-8?B?ZEdsWDFmdmhXblBpU1o1bWZYelRtTXowQlFxQStFUWt6cXpqYmxxTlFURzF5?=
 =?utf-8?B?cUpjbmU0SHg2eHJzYXBxMHNXUDdoU29VYmRrdjRQazhrUGFrUWJqVUg2UXo4?=
 =?utf-8?B?amFJREo2N1UrRnBoQlpwZVk4eWJOYURKWjRuc1p3c0FYTmVOTjF1VUJiVklv?=
 =?utf-8?B?SjVDUnB0Njc1N2NOY1ZpOHJOOTNyVWJVcjUzVFVQMGZ1QlhHTDJMSWNYZzVV?=
 =?utf-8?B?TXFCZ1FJS0QrM01PeitMU2lDZm5hQjk2c3pBVXZpT1R1aUxwQWRLVEU2UG53?=
 =?utf-8?B?akRyMHNBbWpoL1BZY1p0U3NCdnVMM1QzZXBqM01BbTlMTmNaR3F3YlVRUU4x?=
 =?utf-8?B?ZFA5WjE5ejN0ZlEyVG90eS93WnlrWEhxaERNMUZlc1FDQS83TTcxRnQxVTkx?=
 =?utf-8?B?U25Ba1pJWk9oRmVTY2I5MHJ1ajU5aWRqVEpDZjBPV0tmYmdqSXFiNmJrcHdU?=
 =?utf-8?B?Z0hnbkEzVUxreXdUK3lrNjVlbG9sb25lYXN5UWdsR1d0YWdyZnd2N281clpv?=
 =?utf-8?Q?rJbmVaJFYrPUWG1t9h62Qb8IvqU3qXEtm+jojcPfvSHM3?=
X-MS-Exchange-AntiSpam-MessageData-1: aklsUGcKS7qc9Q==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80ec356c-4f71-4a7e-1e4c-08dec5fe8753
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 08:10:11.6833 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GvNS+piHHNWbNVDLy77XOZibaSWY+J6Fc/TeoEi0RkcQZ0xczZCOFHX7nBo9a9a4OEoIoQUOicJJ3QUPIvt6LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8900
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

host1x_device_add looks through the idle clients list to populate
subdevs, and any matches entries are moved from the subdevs list
to the active list. If all subdevs are populated, device_add will
be called on the device. The secondary "subdevs list empty" check
will then incorrectly again call device_add.

However, this would require a convoluted scenario since clients don't
typically end up on the idle clients list.

Fix by checking whether the device was already added before adding
again.

Fixes: fab823d82ee5 ("gpu: host1x: Allow loading tegra-drm without enabled engines")
Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/gpu/host1x/bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/host1x/bus.c b/drivers/gpu/host1x/bus.c
index f814eb4941c0..fe4af98e8fc6 100644
--- a/drivers/gpu/host1x/bus.c
+++ b/drivers/gpu/host1x/bus.c
@@ -508,7 +508,7 @@ static int host1x_device_add(struct host1x *host1x,
 	 * Add device even if there are no subdevs to ensure syncpoint functionality
 	 * is available regardless of whether any engine subdevices are present
 	 */
-	if (list_empty(&device->subdevs)) {
+	if (list_empty(&device->subdevs) && !device->registered) {
 		err = device_add(&device->dev);
 		if (err < 0)
 			dev_err(&device->dev, "failed to add device: %d\n", err);

-- 
2.53.0

