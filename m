Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BBFBCDB471
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 06:58:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BF0C10E4C3;
	Mon, 22 Jun 2026 06:58:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="p25/tZ7B";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013002.outbound.protection.outlook.com
 [40.93.201.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C2BE10E4C2
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 06:57:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TqSHPSS8l4JqZKIHRSObgtdaCrsYYGT5G5Pab/gpOnySNgNvLLRadlbnQb8qV8jC94POGEWKyTNRpipVJpW/s5QuONBjU37BitQa7IENg0PZ0vZ0NfHanWUaGSi07ZDngqmRzDYq9KgyQRbloms/DvnyW15DEO1eITS3kBdJp5ZZzFq8eawbmnmJO7CXgEKysYUt43C33coqMTfxtifQIwtWc78WkoJWOyxGlHQbnDcy2orEtrTvBYCck/dqkyzzCTmtlyHxE9N4EpZmZpproIYifDX7bDYYhfQrXt9JYBQ9yon+dMlfC6tk+9kTC71690jTFmozmdtNATbxrxM8kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0gYY50BNeFE2SYGzOiG7NUjStROGcMU1HL8X4cJj65s=;
 b=mdE3vvEuuNSubA9nD7PsdXLG4HatiEj7mww0jiHPW1Fn6pL+bw/TniPK+VmqcK1PotWYBxppu5tF81F4GBfvTG4PFH81EGHO007Su/NkCuqYfIz0ThozvAMoNyWxclmg5w80RVZOqvo1w3UCBUNDdEKY9WdZxY4LnlCXtv2M36lC5bjPieU/Qw+qsnZScF6OmOhJUh50mPapG4nJ3gfVHOlBJ7Qs6CUWmiHH1hSA3bqfR49PmUVSrNTKrk+kO7ql/hb+0c+efgzTUiMQUvX53O86bwbPJ3IhCYN2HN6kK/j2o/pLD9GKGsDn4FRZQFxuOmoQEiOAna6wZyIGKIxlfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0gYY50BNeFE2SYGzOiG7NUjStROGcMU1HL8X4cJj65s=;
 b=p25/tZ7B0QtWxReC22NLKDnGEcQ9K38w+dKEYJjwRmtaRuUOoW2LwTfRa3Z/z9v9zTaxQ9GTwLd3gLJPi3f8X33mGpX/N1XX0G9OJW1Zb2fx9fIBBLftdNKduvJxDZFoDsjuS9QMwhbyjn2oqH7t7nCjnLYqV6aVPNcYzyA+5m4x4CcHiVVgZc7zacUY04tzUjmwUPBKi+UUA12RZ3yJlCj3iHG8zdE+ngyVwPUB/DouBOSmFepCsnaWl+m/jchiTWs++ZR9Q0LOjpGSLw/2w+Li8quMqAmxLk5xdJBUWxmvp6YA+sXF9rGXj54gkvcS1IZrknItqVdGn399gEeDAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by MN2PR12MB4286.namprd12.prod.outlook.com (2603:10b6:208:199::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Mon, 22 Jun
 2026 06:57:54 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%6]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 06:57:54 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Subject: [PATCH v2 0/7] Host1x/VIC support on Tegra264
Date: Mon, 22 Jun 2026 15:52:13 +0900
Message-Id: <20260622-t264-host1x-v2-0-cdbb730165c4@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/1XMQQ6DIBCF4auYWZfGQQPSlfdoXBgYyywKDRhiY
 7x7qV11+b/kfTtkSkwZbs0OiQpnjqGGvDRg/RweJNjVBtlK1XbYiVWqXviYV9yENRo1Ls6R1lA
 fr0QLb6d2n2p7zmtM7xMv+F1/jkL55xQUrRic6XozaEdKj6Gw4/lq4xOm4zg+K9jP3qcAAAA=
X-Change-ID: 20260313-t264-host1x-c97171fdde77
To: Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mikko Perttunen <mperttunen@nvidia.com>, Santosh BS <santoshb@nvidia.com>
X-Mailer: b4 0.16-dev
X-ClientProxiedBy: OSTP286CA0008.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:223::11) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|MN2PR12MB4286:EE_
X-MS-Office365-Filtering-Correlation-Id: ec22e4e0-db6c-40df-a27a-08ded02b94d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|366016|7416014|376014|23010399003|56012099006|11063799006|18002099003|921020;
X-Microsoft-Antispam-Message-Info: Qmi+MSOk9myJWFpGhKuE3zN2H26nDYYMEZUNi61gXicl3lXpFrqf3p9a8K4/aZ9a9zfg94SGcqyfr/g1rSNC+sqM8mJNjygl/Gitm7wxxvKW37KDwKaj5Kr0GEe9g0jnMSVqZSP9Mz0JTl9c6/vyrTG8HiqKvmhhRUqFLCOka22k4lkPHNsIKWRKnBiUrErV57do/uB6cCgrChtA/8mCpV5U84DDKgZieJcqYacerFg2H3XDSuDFO2elpUOYmLQ5UAE3BWaZlvR4DPrhScfvhcpYjcCf+YN/+DjQEc9i/Cv6cPBkki/qbOZxelvr8KJo8/xrvQQ7nlUbCsW0Bn0DhpKbS6YGl+1SzUiRdNscB50QholqtYQk6wJF2QT6BZudpez0kcZIpa9nF6+kMY5g+iXSeIvikSwiJ0idef2o/CiqtUXAusRVcvmdUoL9AefMwZv01dvgM9f6bVimZNgiC0YMX0j7XC0AbxJp7yqJPf7e07deKR+JJavUM6I01FsT2sqmcnlk6jnpukWsoZZHPQQIdBdKfKmcwfs2wCS17/OoKR5xTUNWNOKROUHzRggnQMo8SUMzc2vKrcUzsuoFo+XPLjiLyqDy2/jyf9VbZbn6JudaEAmrbgB956w2/gzkvdkfZS5LWjFb6P/57GBR4EASW5r2V2tl5QQR+zZA2Sij3UPX7Hsz1cBHF5w5uLBT1yBEI9ILyjPbSAJJ1ZJohA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(366016)(7416014)(376014)(23010399003)(56012099006)(11063799006)(18002099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkQwQmRrd0pMUDNJeDZqNDFRVE9OUnpBRzZOeE9qbW1QMTBWUStMS29NY2ty?=
 =?utf-8?B?czZxWmFpT0ZDcXJyTnVHbW5CWkVNREsxM1duYngvcU90Si8wNVloK1d3QlMv?=
 =?utf-8?B?cVpKUXFNazNZNlhMK3I1bHpyUzdqcFdIZ2x0azBjcHBKa1RldkgrT3Z0Y1Nq?=
 =?utf-8?B?SUovMXNNR3ZDbStZM0NJb3dGTXBFMFplMmMyVFJLdWJrWGY3SUtRLzdqYWI0?=
 =?utf-8?B?cVl3bTN6dEJWRXRPZE40WS9rUnI1d2JPZG5sTHl1d3ZvSy94ZlBTcjRVTkhC?=
 =?utf-8?B?eWxzWk9wZkVhcW1hczl5VEVFd2F2Ums5cHVPMWMxZ3FIR082TzZYdm4wUmtD?=
 =?utf-8?B?T2JVWmRiVnpJRVpPUXZOK2JZSUlXR2VvSDRMWEtOdE5ZK0FzU3B4MDF1Sm5h?=
 =?utf-8?B?V3FEcXVpdXc4QmUwcHlVS01LWmQyRWY1YUxOSjhTMXF6OGI2ZGFoWjMwRjlU?=
 =?utf-8?B?RC9FRUpwbmlvQWZNaTlqR2U2RGZ0dDVCTW1wUEp1cFg2dEx5eDRkVVQwUkpK?=
 =?utf-8?B?YUFKRW1OUkZweUwyajhjbDUzM1lLQ3VXZFM4NjFsc1RCWS9rTkJLRy9neU9w?=
 =?utf-8?B?MnV6RVNibjJ3S3BZVmxuM1dsNWlVaUFaemFDaUFENjdFTzFjZlgwRGJ1V0lO?=
 =?utf-8?B?bjNuQlJRWk5uR0xabThEaVZHSUtwVm0vQjRvcjc3blZ5b2J2dHYxU3NSaHBT?=
 =?utf-8?B?YTB6ekorMG5QVXk2djFRTlN5SmNub2t1Z3pPb2tNV0pLUk1SMDBVeW1pam94?=
 =?utf-8?B?ZmwzUS9JN2p1NWw0WExwcE5rN2kxYzBIQjYwRWUyRlV5NG5uSzZ4Z2ExTG9P?=
 =?utf-8?B?OWE4enM1bDBGQTB3MmNtUlA3R1I0dmk0bmRKRHZFNy9JeEVZcVQ1bWEyaENo?=
 =?utf-8?B?OGZLZ1d6TlVCdDJUK0MzY25ReENUam1Nd2hydDdNVUJnTDJ3TlFmbkJsQ21N?=
 =?utf-8?B?aUQxVkk4bGdHTTZqRXhvOFBneS8zUEhJbHU2SUFsYU4wY1ZnVEppNjVIRzZw?=
 =?utf-8?B?YVRKR3FHa2pGSk5FNU1YRXlwK2JMOHREUnNHc3FRTXU1UmVxL04wUTNsbllu?=
 =?utf-8?B?NlVISmY0dHliaEcySlFOVkc3d0FIdi8wRWlTc1NmNGVEcGRnQXBRUW5LVThp?=
 =?utf-8?B?cVNvcXVBUUpKdVQ3SVpacjRZSkh5a0Y2Nyt5SmVnSno0Z3hrMXZGMU5jbUFi?=
 =?utf-8?B?UWdxTVpEV3J6akJXcXNvc25mMWRmSSsvbWFYVVpreldNMkxoY2FxTnRtSm1o?=
 =?utf-8?B?eXV4NkdqcEpBZXBWa1I3M3ovU1o0ZmxZa0xvVW5KRlp2VWJhNUFzUmQyOUVE?=
 =?utf-8?B?YjlpWlF4dVluaW9xRkVNbXFZVHlsWXpUL1hsaVFsT1V0am9qSTh2eG82blBT?=
 =?utf-8?B?NGFNRzIrWWJpWk4vRVhKYVNqQ1IxL2w0NmpZV1lRNGFsVDlnaThmYjVSZGNU?=
 =?utf-8?B?UXFLbUNNSGNaS2VtSkU5UTdhOXUxRnhYMXgvdnBFdDRsUFJtNXFhNE1mb0VM?=
 =?utf-8?B?cjQvZElNUnF3SityckZZSWJzaVJ1VEhrSHkrMGg4UmlYeEZFQTFtdGtNUFZR?=
 =?utf-8?B?VHBud3J3UWJhVVN6T2h3WnQ1RDdDTTY2NlRwZlplQ2JBaDZxR2NYS2FoaVp6?=
 =?utf-8?B?czYvUXRGNkhka1JCK2pWSmpVNUNjdmxMZG5SbldBaFovSmVYb0UxWkJpckFX?=
 =?utf-8?B?ejlLQnFhaUVtTnZBMS9TTml3eStZZWdPdXJINFNIRGg2T29NOGlUcXZZSnFx?=
 =?utf-8?B?TDFiaGtDR2RHbWJwdGl4cWdpSUFIRHN5YnJVS1phako2bVovNmdmSmFHUi8v?=
 =?utf-8?B?TmxRaGhkOTRYelEwbkpsd0lxd3orS1JpRXk5QTdaVW16QlJ1V1Z5dFBZc0Vx?=
 =?utf-8?B?YVZtYW9mUzRVSWNuSWd5RWpUWitIY1NXclp1dklYdTlmRTlVc1k4YzROUkgy?=
 =?utf-8?B?VUpPYXFFaXBXT0pjck52Wm5uQU5XZXVRVngwTVhnd3pKMzZYYXRCNDd1d2Jm?=
 =?utf-8?B?MmdUZmxtQnpVdWVrc2FuUjlMMGJaYUZLT2ZpSzdSZ09Rc3F4N2o3Z3FvVEFD?=
 =?utf-8?B?TFVraHFqNk1DaVJpa01idExyNjkrb2Nyc3YwdFoyUDRUMHBWdnFRTThXcWJM?=
 =?utf-8?B?cjNpT0kwSEI0eDl2dThGWUt0QW9EWm56YXNOZ0JrdUYzc3haUWc4ZVo2Tk8r?=
 =?utf-8?B?Z2ZreWhia0hscmdHQndRcUZYUjg2RFFSZHJwZEhJbm1jdXZ2bWRGQ290cXBs?=
 =?utf-8?B?MlV1bFRRY0FrT0wxN0xZUE5MdUtBQ0NFcUpWMXBNOWx4UCtuWkcyYm5xOGdu?=
 =?utf-8?B?U1dlOUM5NnpCSVVrMERZV0hucDBNeTdXNVQ4aFhIZ0gyT1dLb0RUMXdEOXNG?=
 =?utf-8?Q?VF7HQuzYoDlZp47XyBEfEu8cIOQw0+KCzVRxeGHL6cP5k?=
X-MS-Exchange-AntiSpam-MessageData-1: ovVw56V8qQaXbQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec22e4e0-db6c-40df-a27a-08ded02b94d0
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 06:57:53.4334 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DM6Bwa3tb1datTIaFNWPWbFhM4z1sS/WUgxwx4jjPMWTyoP0i9MuRVdicYiU9ksmIJoKEKI3Xkvr66vk2SyBGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4286
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

Hello everyone,

this series adds support for Host1x and VIC on Tegra264 SoCs.
The Host1x side is not very interesting, just adding the usual register
definitions and other information. One thing of note is that multimedia
engines apart from VIC have moved away from Host1x on this generation.

On the VIC side, there is a bit more of a change, as the VIC Falcon is
now RISC-V based. Unlike NVDEC, VIC is still "externally booted", so
the boot sequence is very similar to before.

host1x uapi-test[1] has been updated for Tegra264. Necessary headers for 
constructing VIC jobs have been added to open-gpu-doc[2].

Patches 1 and 2 add new compatible strings to Host1x and VIC device tree
bindings.

Patch 3 fixes the context device device tree parsing code to handle
iommu-map entries with length more than 1.

Patch 4 adds Tegra264 support to the Host1x driver.

Patches 5 and 6 add Tegra264 support to the VIC driver.

Patch 7 adds Host1x and VIC nodes to the Tegra264 device tree.

Thank you,
Mikko

[1] https://github.com/cyndis/uapi-test
[2] https://github.com/NVIDIA/open-gpu-doc/blob/master/classes/video/clceb6.h
    https://github.com/NVIDIA/open-gpu-doc/blob/master/classes/video/vic_ceb6_types.h

---
Changes in v2:
- Updated dt-bindings changes to be chip-specific
- Link to v1: https://patch.msgid.link/20260612-t264-host1x-v1-0-8d934987de67@nvidia.com

---
Mikko Perttunen (6):
      dt-bindings: display: tegra: Changes to support Tegra264
      dt-bindings: display: tegra: Add Tegra264 compatible for VIC
      gpu: host1x: Correctly parse linear ranges of context devices
      drm/tegra: falcon: Add support for RISC-V external boot
      drm/tegra: vic: Add Tegra264 support
      arm64: tegra: Add Host1x and VIC on Tegra264

Santosh BS (1):
      gpu: host1x: Add Tegra264 support

 .../display/tegra/nvidia,tegra124-vic.yaml         |   1 +
 .../display/tegra/nvidia,tegra20-host1x.yaml       |  20 ++-
 arch/arm64/boot/dts/nvidia/tegra264.dtsi           |  63 +++++++
 drivers/gpu/drm/tegra/drm.c                        |   1 +
 drivers/gpu/drm/tegra/falcon.c                     |  66 ++++++--
 drivers/gpu/drm/tegra/falcon.h                     |  23 +++
 drivers/gpu/drm/tegra/vic.c                        |  95 ++++++++---
 drivers/gpu/drm/tegra/vic.h                        |   9 +-
 drivers/gpu/host1x/Makefile                        |   3 +-
 drivers/gpu/host1x/context.c                       |  13 +-
 drivers/gpu/host1x/dev.c                           |  41 +++++
 drivers/gpu/host1x/hw/cdma_hw.c                    |  12 +-
 drivers/gpu/host1x/hw/host1x10.c                   |  33 ++++
 drivers/gpu/host1x/hw/host1x10.h                   |  15 ++
 drivers/gpu/host1x/hw/host1x10_hardware.h          |  21 +++
 drivers/gpu/host1x/hw/hw_host1x10_common.h         |   6 +
 drivers/gpu/host1x/hw/hw_host1x10_hypervisor.h     |  10 ++
 drivers/gpu/host1x/hw/hw_host1x10_uclass.h         | 181 +++++++++++++++++++++
 drivers/gpu/host1x/hw/hw_host1x10_vm.h             |  36 ++++
 19 files changed, 601 insertions(+), 48 deletions(-)
---
base-commit: 4549871118cf616eecdd2d939f78e3b9e1dddc48
change-id: 20260313-t264-host1x-c97171fdde77

