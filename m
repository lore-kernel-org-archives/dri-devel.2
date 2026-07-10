Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3A79C43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 07:15:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D984710F7C3;
	Fri, 10 Jul 2026 07:15:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="azAXedPf";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010017.outbound.protection.outlook.com
 [52.101.193.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DB5910F7C3
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 07:15:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eg18FSK83yomHA5OHrzLVJkSqS2IY/1lQf/pO7/OjjQFNep+JL2PbktdoFOGWO+0fZjLQn+k7+D0hbUzr+T3FYeZ72Ysz0TqANN0IVgrHbl6/gpz3BQ8nLGDpiyxShrcU3xFh6AHi2LzzRPbYaJbVPexzPnXPLeWhZebrV2BLhZKBYXrFrpuwFUz1iSNfi1927EHIsaCyIOo7doziSS+tOqHT9+0Bp9GTvL2x+DD7fSkbeoRq7hvtY4zl/6nBtBZYWpRiCUwRXXXb51kdbFFRNYkJPQndeLqPbXejntGXUBkoHQV1w6J2iUdSmWz29zTW54rgdLbklTZtSPIfeGNIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BGWZhCNYKinmNCxBaxSvCsgn+YBUikvX+z9vnx9IrJU=;
 b=aMHl52D3uAC3yFQQksVJ5/dHgHmSjNP8suOWQhgHxn+vF2BI7nnoPUdadd5JkC0F2eIrsPzcarqaMdzXLs8sN5U5/xh/QUjkH5leDngzCmROzJNUqVzGQeoq5EwEqQtTapk30DLOiIf7dG2lwdJQ8BFz0U6Wpq/fIazdtYb8UWNDud0DryZMDQ6dyizKlrhPMKLkG3CUPdGOBNbpRlVwNqXlnnsd581PWVUgW/s/TamtIGKuIDlxB/NExmlxcK2ZCHUT7ySh4rzGFdaCu8z9rt8anSbFNpTooc9Qw7x+eTMemU8SYsSO7vBwBgWXeTCWEhkCKYyGUpvy3IaC2H0YYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BGWZhCNYKinmNCxBaxSvCsgn+YBUikvX+z9vnx9IrJU=;
 b=azAXedPfAwTW/A+UjsDrrpR1zKLQzStA9R07CrD36a5XSNMZQgtUfjBUaNDibQPHL8KBnALizSTtIstuIXz3wOS7I2skbr3DTwr8IQAaMNQsTUlYSWEbfjUI7Qa04DBw5MPb6yOpl/7OuSsgW3Nf8WK1x2/4jajebnFP00feJ2m2RpHhYk2WxXiwzte9QHHKweEoOzicDuTp323kHKgij1aDMLfG9IsaUn/bKB4FouBcLxnpkHw0Sn5957nSoUqNT1BtO8yFWPhyc4y62WirRDlyzeLFYiXuz9YiklPd0prNb5PYKKGTdW4Q/z/ABzF9Xg1juUbyeW3wFGPvy5yv4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by DSVPR12MB999124.namprd12.prod.outlook.com (2603:10b6:8:38b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Fri, 10 Jul
 2026 07:14:57 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%6]) with mapi id 15.21.0181.014; Fri, 10 Jul 2026
 07:14:57 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Subject: [PATCH 0/2] Host1x memory context stealing
Date: Fri, 10 Jul 2026 16:14:30 +0900
Message-Id: <20260710-b4-host1x-ctxsteal-v1-0-b1f8f6b37cc5@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/0WNyw6DIBQFf4WwLo2ghZZfaVwgXipNfZSLxsT47
 0Vt4nKSc2YWihA8INVkoQEmj77vEvALobYx3QuYrxNTkQmZSVGwqmBNj5HPzMYZI5gPy7lz9n6
 TBpyl6TgEcH7epc/yYByrN9i4mf6LAN8x1eIxO2Oa7Kmc5ywKecYeiivu6hqU0pPYJJVBYLZvW
 x81mdSV03Jdf2jYJ8bRAAAA
X-Change-ID: 20260624-b4-host1x-ctxsteal-31ffc856aefc
To: Thierry Reding <thierry.reding@kernel.org>, 
 Mikko Perttunen <mperttunen@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Jonathan Hunter <jonathanh@nvidia.com>
Cc: dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.16-dev
X-ClientProxiedBy: OS3P301CA0035.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:604:21e::17) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|DSVPR12MB999124:EE_
X-MS-Office365-Filtering-Correlation-Id: d6fa9ed1-46c5-4345-adb4-08dede52f2a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|10070799003|366016|23010399003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: IH0zX7wE3i+caQRJUD3UxUOo7to7xT79Ogn7Z2aBJeSAKx4GPuc2tRKBgZJXDNfo9zEHoaE+WO7AzM74dcrY02ZyqDNbzZOp5eC0dSpW7yb8cJIIJrdOknJhU8thkSDj2/OPcwTJ+fydZDxiY//o+VL4lXN+FNyjwo+JrgmfGDDqScLLPam/x2GJsfNaiihJyo77oF1j0akS2xQMZmPPnUNW9Gktg8odzMaMIcBItR+CtYQDhnwOea0/eTWuXG2H85BTU47MR8I7T5Hmpxy0EEiMk/+hvXNdtQoOKERcOsjaziHJAsWp+Zi6EtpP+nRG+RmynLi5lOxILanQIcN+y7Mu0+k1N9Q/VjKde58xo4Ttu1WxYbKKDLK4BkJ1mFOI7bRmNrwC+6Oqn/SlvFDW1gkCPrR2/WGjIYOM1XSL9bJD2wqeTNB+HrJMbdNDOJ/08cSDCFn+hmvK4SLcB6RxmVbGIEh1csOMIGWHmBJe5Ldu7jNjtE+6qWxVDL5y2VWzclwKQxpFh7YJTdaqzqy2j/D3c52+oh3I2r88+z+FRQ7Niban6ipJ6KDiAyBUTlE3odqX/wC3HG9oH05D3uFAOujIOMWxAwLiiBncKFEtCE4UkN1SVLrb4xRCtSSgiNF+Lq72eeh1iCOqemOQJdws+eLgjHzzagy+MwnOJUwfTis=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(23010399003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aCttUFZiTDZaODNlK1ZkNFgvdy9NVGhCM3pOcHI5SnVBd1FxZGpLUU5XZnJY?=
 =?utf-8?B?TThxYTFuVWs2N3RwWmd0WkVWdGZua0dNRGdBa2hOTDNoUG43WEgzaWIybG5I?=
 =?utf-8?B?ZVowMTBaV0l2TCtVMHN4ejVsLzIvWWZOK1ZQbmxSa0hTSU1IVEE2OTRyYXdo?=
 =?utf-8?B?eFdGRzYwVHlhckoza0RTVW1oL1hVc0Q4SFJWVzdMTVREVVE2R1QxQ2FDVTRZ?=
 =?utf-8?B?N0o5M3NwK3FVWmh5cEUrKzVjbGRodFJ1OUJVS3hodzk2YmxuM2ZPd1Z5YVg4?=
 =?utf-8?B?NytiMXhtcWNEM2J6dGpLeDd4clViMlJ5Q1BCYTEyZk8yaXdyeXY0aGQvdndJ?=
 =?utf-8?B?cE5GcDJNcER0cCtQQklZTUVrZzZvL3Z0WmF2RGF5SVcreldEbUVGd3djakZI?=
 =?utf-8?B?bndZMWppSlNyV2hQK1JsenlRdDJNUWtucFFwcGZvVVNTZ1VsOVFWc2ZRVEY1?=
 =?utf-8?B?WVBaVHNRb1lTV3paN05CWHBaWDhSY1JrNmo4eFZ1QThKdUoySU5QWUhLR0Nn?=
 =?utf-8?B?QWlVV1FZbkE0ZnZWemMzMEhobXZweExNaFExVmphclF0eUlsVXBMZkx6TzNx?=
 =?utf-8?B?NHFqRkhwNXBoKzZMN0o3bXRXQ2JQVytNeXBTWmNzL1hMdnhURDVTRjZxT0tB?=
 =?utf-8?B?MXo3N1VPRXNlUUFuRUk2WjRDSFBzeTMyVUwxL21tblJybWpHMEFDTUVJb3pI?=
 =?utf-8?B?RFBjWW1nS1BrZk9kYWZtUXRJU3luNUJOcFdGMGpmYlRmNW9KR0VPWVNpdWNF?=
 =?utf-8?B?dzlySW5CYXlNcGFhMHgyTjhmVEk5c2tNYTVpWmp0WjRGMk1mNmo3OW9LaVdh?=
 =?utf-8?B?TzVPMVdFWHNXNmRGQnpjMG02QTIxVWQ0Y0FuNVhvZlk5ekNsYmxGaHNncnNZ?=
 =?utf-8?B?dkYwZWtoRnRIeFNCQkxnSlpJNDBxSW5BOUxEM0JSRiswdm8wWTNjWENxU0g4?=
 =?utf-8?B?SVpTOW9Oa0JlWWNybTZDUFMwSjdYTGFCd2RHOXBjd3o4dm9JTW1aTzQ0RER6?=
 =?utf-8?B?ZWlKU2pGOTBhRm1EM1dydll1TG1yRHBxUWlEanc4ZS9DWWdpTjBZS3EzNENm?=
 =?utf-8?B?Zm5iZXZFODV0WUhBV3pxMTJWQmMwZ2t4NkhzR3VTZXhGVDVFU0VlaElmQ0Zn?=
 =?utf-8?B?K2hsckt5QjdDdjZUTjF3TE4ybWFlbzFBQzBORkZmOVdsakxESGdSNjV5WkQ5?=
 =?utf-8?B?V2ErbitNQTNCZ3UzRDlIblgwR3NtRWZlVytYNCtwYlVqQ05iZnU4MVRBempT?=
 =?utf-8?B?MG1FV1RzVmU3RDBFUmdtbkNGNURQTFUwc2h1cGVUdkVtRFU1Qm1UTTg0M2or?=
 =?utf-8?B?OU1EWFJrdWFKcXZzYTFYcVpJa2RCd2IrSXN4YjZ2OHZWMnB4aFlETGxESGlx?=
 =?utf-8?B?OFNSc3IrZnJ4SWczbzBSVWhDV0FrMUJKTURqbDdzZ0hmaTJwWG80cnFTQTM0?=
 =?utf-8?B?RndkOFFVRUF1cXBsL0dnS0ttbW0wZTJWS0ZGT1JiWlcrYmZFaGNQZEkvQ2hG?=
 =?utf-8?B?YnlJbC9WT2pNV28zQWNjN01pczRaalZ3THl0QXh1bG1rdlVqTG5zcDJQZmtJ?=
 =?utf-8?B?MklpdGIwWXhJd1UyeTc4UFVsUi9SSVk2aitxSVd1RkhPWWxaZVpGcnBMMEtF?=
 =?utf-8?B?aDhucWxZR0NyTHpFYXAxMlkwSDBlWFFEaDhPRDZ5SzAvZzhqTEZwaVlId2k0?=
 =?utf-8?B?OFdXUTRuTGR3QnRiTld0YW92NUJiS3pKbGpicGVKdjdnWG80ajB5ajd5Y2Nw?=
 =?utf-8?B?K3o3VWQ3REJUTTlUMDdTalIwejl1T2pDYTg0Z3hwWFVyVE5yYTl6WUR3TnlI?=
 =?utf-8?B?OUlOSmVYNmdYV3VSelRIN2lSVDdpam5SdGZocWY3em5kQmgyVlpQWmI1b3F6?=
 =?utf-8?B?R3RXSWtxZTFmcWUyQ3FtOEt5SXRIend0YzNjTFNvZVpmSlpwUmxqMUJNTHNT?=
 =?utf-8?B?Ym5iWnV6MFFCdXRWTVAxS1kzMGRndHFjVXZsWmQwK0tGRXZveFNPUFNkN1Rt?=
 =?utf-8?B?d2JibnJwNnduQTFNZ0N3QjFXYktIRmYwK2tYVE5na0lreVZ0TUVmUlpUL0dH?=
 =?utf-8?B?RThYL1ZXT3h3bzcxWkxmNUF4bGhJRnZPQlNXMURTcXI3WUZJVGVodmM1MEE5?=
 =?utf-8?B?K3l3MGo2SUxMa1cxVTNVME5zTG9rejl1em54RzUvSEs3K1hJUzRhV0hEaWEr?=
 =?utf-8?B?V00xRngvbWJtMFNRNnFyaHlmdkduMzZCVTRheE5IZTBpNERhZndaditpdVlY?=
 =?utf-8?B?L01TSU8zcTc1aWc3Um9EdDFZcFZ0TFNRY3lYS2hqT3ByMlpESDdDS0RwRkpI?=
 =?utf-8?B?MzRtS2cvSnVkenJ3bjZkTGxnRWZyRFFKeWk0WkhQaThwdVBoRmI3ZVJya0RK?=
 =?utf-8?Q?zPJnAN1pYrF0lYVrMdaKqYP0KscMP1P2krCVuIW2L4AnN?=
X-MS-Exchange-AntiSpam-MessageData-1: Wzf+4cx/UI5mLA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6fa9ed1-46c5-4345-adb4-08dede52f2a6
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 07:14:57.4056 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RKb8VE1wf4ExF8lfHwOFiDs/t7D8o6rPQ1GMBEdInh+to4kQSdBfyGIzc1iGn+G8tj/sK2yfmAy+9K4rZC/2UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999124
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

Host1x and devices on its bus support isolating address spaces for each 
user via memory context devices. However, their number is limited by 
hardware (SMMU context bank / stream ID assignment). Currently, each 
process with at least one open Host1x channel is assigned one of these 
devices of which there are typically eight. Any subsequent process 
attempting to open a channel will simply fail.

In practice, often some of the processes with open channels, however, 
are not actually using them all the time. Hence, we can improve 
usability by moving the context devices between processes when 
necessary. This series implements support for that by 'stealing' context 
devices from idle processes. Additionally if all devices are in use,
the process will wait interruptibly until a free one appears.

On some systems more deterministic behavior is desired. For that 
situation, a module parameter is introduced that can be used to revert 
to the earlier static behavior.

The series is based on top of the Host1x T264 support series.

---
Mikko Perttunen (2):
      gpu: host1x: Memory context stealing
      gpu: host1x: Add option for disabling context stealing

 drivers/gpu/drm/tegra/submit.c     |  36 +++-
 drivers/gpu/drm/tegra/uapi.c       |  49 +++--
 drivers/gpu/drm/tegra/uapi.h       |   3 +-
 drivers/gpu/host1x/context.c       | 383 +++++++++++++++++++++++++++++++++++--
 drivers/gpu/host1x/context.h       |  18 +-
 drivers/gpu/host1x/hw/channel_hw.c |   3 +-
 include/linux/host1x.h             |  49 ++++-
 7 files changed, 488 insertions(+), 53 deletions(-)
---
base-commit: b3f94b2b3f3e51ab880a51fc6510e1dafba654ed
change-id: 20260624-b4-host1x-ctxsteal-31ffc856aefc
prerequisite-change-id: 20260313-t264-host1x-c97171fdde77:v2
prerequisite-patch-id: 430f8b34014f6b256630d0a2ca83245ccb20f31a
prerequisite-patch-id: 63ebc5b572f9637452244edbba6e1fad559e9764
prerequisite-patch-id: 1017c5f3670cedfa1ce2e5d2ae309739a836d514
prerequisite-patch-id: 4503288cda4b78b5e5397f236a01835275799b3e
prerequisite-patch-id: e678806351cc92f32c70923aab259111365324e9
prerequisite-patch-id: 6e8e3d23872715a36074524121ffbf66c451c1b0
prerequisite-patch-id: dc2aac97cd569d9fff8f05294d2e4ce13d5a741a

