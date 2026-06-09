Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77D34CD8CAD
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 08:10:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BCBF10E177;
	Tue,  9 Jun 2026 08:10:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="L8wskNhX";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013065.outbound.protection.outlook.com
 [40.93.201.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 421AD10E177
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 08:10:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CfI1C9ST79tgEcfAQBzwUTEkMQQhT3v5lbL6KxTCbkedFjG2Iee1s22abBlCDP446/UsvajuB+BGhpxcOJgYNejKIpgSZ4Yhpx5gGSvmUEjyVI4NiHDPWFwQx4jAtO9kqfQt1r5pwK2g7LasU5MNHVZiLEwqpirQS7hmreDAd+4kPIfnIw6MMooJmoP9qEfsNOKzqwuCwilRMGWVlZdL69oFBxYk8Tsdgis9htA3SdGN4En3A32t5gwLWRNls1Djestm0qzpqsDV5YNPbSm36OnjHwVS57a0ld5IOlAfgK0AD66SQQOj+I3oSqCCo+C5K1bu5LpSvFH5lf2WfAosZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ZdcHrNdZHR7CgG5p4dO7LqIZSpCO6qYiiwmrrydSYU=;
 b=B7IGTKX9q6082goskrUkr4vibJjhNWVmVnHgBG1nYpdj4X8ELt0I3aH4tI2PEp5vRJm35p5wP4Vt6g/vx5kfmAPIJGa4bKB3B2i4Z2nLI3WM9cfT5IsKVugaeEiiyIwFFkaqIF2JhewLKELo1iE+bBCDRZXR/B0wP3D6uyI7XhWGLmwFCjuHxhj0yBrq6r0mODPFV6RKnGeo7n6ZVRGnqMC1fvJrYNJJjFW305rzVM7jthVIapybkJOrX0g7hFXAZgsG35EeRjEEX3Lpn3qvhFeW0t3YcL0nRGuw21bXHHHPd411TllcFOj3gpp22r2av2S7CuvQSQWffCEMi6YhTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ZdcHrNdZHR7CgG5p4dO7LqIZSpCO6qYiiwmrrydSYU=;
 b=L8wskNhXY2rphNXqMvE3Z9GmX5gvSps6YcgmQx4EcbjxlJ00UiGatgf3mpJatwSAyFzGiyVlsMbd8MHypX/0KEGJO3UbKQCGl0QGb2uw0wuDG+Q8/bUKIlGQQ56YeTbE3XjEG2W2iZD7rrCV7mnVywNYElr3C/jGCoyy2kge9dtplwQPIyvrkdsVhbt9DK9mstySSXGNHv5MWTdevbSQclgXjnooI5ruyuq1tk6pXPbaLJYYLTYKot0JjkmSidHShvX2azNlbP2kGJu0XRetHLsh2iPEFqBdIu34KPl+G8nEYuLgzExYmkePUqjNLJjDIrefhJDJIGf4w7D9ubxgfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by MW6PR12MB8900.namprd12.prod.outlook.com (2603:10b6:303:244::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Tue, 9 Jun 2026
 08:10:04 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%6]) with mapi id 15.21.0092.010; Tue, 9 Jun 2026
 08:10:03 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Subject: [PATCH 0/6] Miscellaneous fixes for the Host1x driver
Date: Tue, 09 Jun 2026 17:09:16 +0900
Message-Id: <20260609-b4-host1x-small-fixes-a-v1-0-7c1131c0b3ad@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMywqDMBCF4VeRWTswSYuKr1JcxHTUES8lE0UQ3
 71pXX4c/nOCchBWqLMTAu+isi4JJs/AD27pGeWdDJZsQQVV2D5xWDWaA3V204SdHKzokCrjO3b
 WU/mAVH8C/6cUv5rburUj+/i7g+v6AueRNLB7AAAA
X-Change-ID: 20260608-b4-host1x-small-fixes-a-081cfea2c073
To: Thierry Reding <thierry.reding@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mikko Perttunen <mperttunen@nvidia.com>
X-Mailer: b4 0.16-dev
X-ClientProxiedBy: OSTPR01CA0045.jpnprd01.prod.outlook.com
 (2603:1096:604:21b::12) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|MW6PR12MB8900:EE_
X-MS-Office365-Filtering-Correlation-Id: 502d5dac-bfb6-4897-c927-08dec5fe825f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|10070799003|6133799003|18002099003|3023799007|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: rFkCfUVLzXMCkbHURrhsEvOK6KTWuBidL+qV6EilbgFrUQlWt+xgu+RUj8Wi4CYwWPFv59+yVQ82bW+S5NClvFW9s0yOuUFdvum+q+ZX26PhdYvN3BAOM4jjJrwqesS9yLu/ytd2IFFTXDyZcEfDHdqUGVjSo8AzGXE99VEhwTrZyB7K5M6laPY8xhL4leFpo5u+SgG1YfM1wLijjcLS9Pmp1DVUq2fq5w2dm23UYbV+skPQ/pr3k1VFpZBfBlE/v2itRm/2KzJpMSygNnabBY/s8vLY9qNQaPWlFzKYsTRqkLmN4X8zt2uNa/GgWS0kV8DWVglaM76zLZ8Ck/s7k/hPDgsLt/qBRN2s6z3ee9nXDu8Ywy4s22LCZTnuXg1vmbNNgV1KmXeGGYSYHiXP4iinqdNcL/aYzb/7V1VZ+d17Cpar0GavkWL5LDGTdljKpmcZjPTBxHkJBHLD2+0J7VDazV3EgC9HOi2VGb395SZRs1sATzM9pWi5GuXBOCfeTJlXbhkrUvkXpubAOCai71kNu219DOQV5/6WYGg1zd5aGUzdH8HwobqYfIOYbt3B9rFIxijUwqfgxAYsbtMDIBTbNtlTAW4iUXXy5iidAmhEwZeMvK+uaMI3V1BpjM8lK71k+RIX60vemThL9TXggoK3HaZypKnLRvnBQCvKIFPitqXRkMLUDCsgDHxXP2e8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(6133799003)(18002099003)(3023799007)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2VUVzVMTWRwalVTU0JUdjVxNXQzN3QzSGcyOHplYWs5NEI3djJYclBacEpQ?=
 =?utf-8?B?R0pXZ2dOaG1ubmYvS1pzZHRmaERaM013YXJ1eFFLS3NwOEpIOWZsRHNlLzBK?=
 =?utf-8?B?VnVyRisyWnFVRGhsMlVXbmVPZkRseWhJSjBETGc1V1FSOU1aT0twZ2t0aUpz?=
 =?utf-8?B?a1gzUFRmVnFxZVZVMWNwUURnak1lc2tEQmppbm1ucWRqNk5XOHczTXNoMG8y?=
 =?utf-8?B?Z0ZJdnhNVHVMa2hUWmZLVEkxdGt5MEp4cUxrRkFCS2VHWmRlbXJiT09rQkhn?=
 =?utf-8?B?dkFuNUM2b0xOcW9rZm54ZjhPMVJqRkprUGxKdVQ2RW5PaEkzeDNaSk1kd01Q?=
 =?utf-8?B?bWdiZjlzaVpLT2Q3djE5NmlIWjlSbDRvalp1UnYvRUZ0MmxwYlJDUXdpWmVm?=
 =?utf-8?B?ZHN3ck1YSEtjT0tNY1ZpL0g4ZGJlblJLV3RlaHZ4ckdTcWh4cUZVREU2OFlR?=
 =?utf-8?B?Rm9IWGxUbm5BL3Mzb2crUEFjQU1TOTFIdElLRENFWlpGZFZrYnRpUFBpNUo1?=
 =?utf-8?B?QzgwcUg1b1E3S0YxZUYwZWJkWWxiMUlPK0gwVUVrREVrWTJJUkNrZGlxZHU1?=
 =?utf-8?B?QXpTSDFCVDJnY1F0RUM3ZWxlZWlPQmNOZ2FjcFgzYnRBU1VtNVFxZHNuS09M?=
 =?utf-8?B?aS9RVloyN29ENHpqWjVZYW5pdE5TVGk4MFd6bXExNzBQbW92eTdtVHFQS0ZX?=
 =?utf-8?B?MVJIU3pNTkw1N3UwY0R0UHhXNVQxSVVNNUN4c1dyQzZQaVd3WVdDNTBZSnV6?=
 =?utf-8?B?bUo3QVZiODRXcXpNb3htbDlnVk9MeC84YjNKRGl2dVNtNy94cExmVjcyeTRL?=
 =?utf-8?B?N0ZGSUZrRFp1TjFiY2o5LzEvbFJkcjdpazNsSmJrT1h2c1ZSRDAxa01HU3hw?=
 =?utf-8?B?OUZ2QVlraDV4bnZjK2FIV0NIaFZydHdGRGlvcm5XaVMxQkVLUjRyOUZrVTVI?=
 =?utf-8?B?enFPa3l6MG03a3kyQW0wb2dJZ0pyUElBOGFIajVvbkFzbXNlVXhJUTNOb1lV?=
 =?utf-8?B?V01VSk81ZUdPVi9weFM2S2ZRRDlyN25ENGJ1RS9DMm91WjM1cnFRUFFzSWNE?=
 =?utf-8?B?TithNjZYRDhLUlNsNExsWFZwVk5KNEUxYlJjNHB5Tk1VVFI4VzFQeWxQZ2kr?=
 =?utf-8?B?ZGIydFA4SVpUaW9KcXBzVE5raStwUXNvOWJTbmxDNExpSnB2U0ZCa0x3NlJR?=
 =?utf-8?B?ZXYvRWdyV0pBUGt5eHQzdzI3bXppNUVpM2xJZ25IUVdtM1lBQlBNaFRjc1Ju?=
 =?utf-8?B?dUxMZmlRQ1htWENZeUF0VVArMzFla3VJNHhidUZvRnU2RlR2RDc2Z2cxTFpW?=
 =?utf-8?B?TzQ0S0t0RUNTbnV4MEc3Tm8vb1AxOVg3UUNYUXJQQWJSMllxaUFUVUJTblhD?=
 =?utf-8?B?U05QZjBWS2xia01hVWY4Y2I1emdhUk9OZFErTmV4UTd2SldjMSt5dGpSclhK?=
 =?utf-8?B?RzMvNVdMSkc1SFNxaWhWUnMwMWh0SEZRbTVQNzgvekZTQkJ0aXNzaCtDcGYw?=
 =?utf-8?B?ZnVmVFRDWXpOUWx4V2NPQ1FGcndoZTdZQ3VKdktKd2FkQlF3T09TQ09QNkQw?=
 =?utf-8?B?dHhHb3B2SUdUUEplbzRueTNKakkyOEJXMnVWcEdNL1dXRFlRendlamszMW16?=
 =?utf-8?B?dXhSdzJMRjZOdlV3a2tDWGJaamx1Q0pDQ0JzSUZQZkIvL2FUWjBkZGtVQ1NU?=
 =?utf-8?B?OVhSbUVUZi9zMld0OWEyZnVCMmFOR2ZrYUFKSVpkQkdKSDJLQnByek52V04w?=
 =?utf-8?B?RTZaMjBHMEdVV3VjVEd4R1kxVE5STmJrWFg4bWhIYTN5d0F2WHplaDhvQ2lX?=
 =?utf-8?B?Y21wM2JtbkFNUDdGWDU0OWd3TGQ4Mit1WGphUnpSazR5V1U4andLVzc4U0RI?=
 =?utf-8?B?Zmpna2NYcDFZRkw3YzRSYzRZUlI3ZFRBR3l5K245QXQzSEgycEx1LzNjd3BX?=
 =?utf-8?B?VVRxZzlLTVpmTG5oa0VIeis2UjE2VGZQbFhmT2FVWVVnOHJObkZoS0RnRUdS?=
 =?utf-8?B?VWdvU2lsekgxbFBneS9OWXlsWGp6VWVlTjlFc1VmSy9seUttUXA3ejZTS3pr?=
 =?utf-8?B?Qy8yWnJGeVJlYllHdDF4V2QzRWtsc2k3b1VIMFcrRXZ1Mmcyemx5aUptbDU4?=
 =?utf-8?B?bldHV2JyY2dvc3hVVFNNNWMwZWxyQlRDVWdldlc3UlJJTzNaaXp1bmlFMmlm?=
 =?utf-8?B?R3RHRXBTRVE1ckNaSmRMMHNEV2h6eXAvekxtUDVXRWpZOTB3R1YwMTNKbGNh?=
 =?utf-8?B?VTdUUldibGRBNCtsbkZDaFhqNHhhMmhkaG1hTFZLV0hxMkFLTUswK0F0TmtS?=
 =?utf-8?B?a1pKbnRsektMTURDalN6VXJSTWYzRC9vSmhtSTBLVGxaZjBjOXRuRXp5N1Rn?=
 =?utf-8?Q?Yqk7624gXIISTG5nhCA2C/Q/3bFVFrzudeeC3GX3nRa8Y?=
X-MS-Exchange-AntiSpam-MessageData-1: oeWngi9OE1WcCg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 502d5dac-bfb6-4897-c927-08dec5fe825f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 08:10:03.5521 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6qL6JJ5OBq/AtE9Up5W3tA30FegnRW5NzigY8a895oZs+PrJVfx4RpM8wyocGymLmYe0j+Q+fzjW4HKgd96qcQ==
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

This series has a number of small miscellaneous fixes to the host1x 
driver.

Patches 1 to 4 fix various logic issues that are unlikely to happen
but technically possible.

Patch 5 fixes a return type from unsigned int to int -- no functional
difference.

Patch 6 adds makes syncpoint value arithmetic explicitly wrapping, 
mostly to help static/dynamic analysis tools.

---
Mikko Perttunen (6):
      gpu: host1x: Wait for timeout worker completion on channel free
      gpu: host1x: Avoid double device_add when clients already present
      gpu: host1x: Fix offset calculation in trace_write_gather
      gpu: host1x: Avoid stack over-read in debug output helpers
      gpu: host1x: Change pin_job() return type to int
      gpu: host1x: Annotate intentional syncpoint wrap-around

 drivers/gpu/host1x/bus.c           |  2 +-
 drivers/gpu/host1x/cdma.c          |  3 ++-
 drivers/gpu/host1x/debug.c         |  4 ++--
 drivers/gpu/host1x/hw/cdma_hw.c    |  2 +-
 drivers/gpu/host1x/hw/channel_hw.c | 15 +++++++++------
 drivers/gpu/host1x/intr.c          |  5 +++--
 drivers/gpu/host1x/job.c           |  2 +-
 drivers/gpu/host1x/syncpt.c        |  7 ++++++-
 drivers/gpu/host1x/syncpt.h        |  3 ++-
 9 files changed, 27 insertions(+), 16 deletions(-)
---
base-commit: 4549871118cf616eecdd2d939f78e3b9e1dddc48
change-id: 20260608-b4-host1x-small-fixes-a-081cfea2c073

