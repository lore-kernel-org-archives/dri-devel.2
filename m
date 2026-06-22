Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A33BACDB46B
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 06:58:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09C7C10E4C2;
	Mon, 22 Jun 2026 06:58:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="ewFKvRlH";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013002.outbound.protection.outlook.com
 [40.93.201.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA19110E4C2
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 06:57:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZnfxD/fOgDnHXpOOjHJc3mXZe4XdCfo+eZen2q9vXHQC1YpEMWAhLt2n3JkQPoME59BgHaw0VZly47bra6qcXtUoAGod0dE5aOrISR5PFmozYeg3/fxTVP8P935yBysoPc+Gfaw9m6mBzDnfcQr3GdupX0nsokwYtkk05VoebRQVu62N1xaA6SYUEGaxfkvH81qiZDLSEtaU/Y7kzkwiMCxR4J2ruYm4u25gz4/9eHDsLVFwYvTE8A9UdJf91xQtdFF8PNKlTwCNpfyjSGYSyaqYttztkbksgp5H5FaoSYarjwHXR9lFIajcvOT3V9FKzjIHZl8Y2sPOMzM5kmGAzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0gYY50BNeFE2SYGzOiG7NUjStROGcMU1HL8X4cJj65s=;
 b=eeA4yxDZs7icyEYQC2sA4V9kwWwIHfV1xiClOvlYBIoO4Z8A5hkkfL+s0L9wkgr2L1eJqmNBvpAGJOafJNumvB74GJQ78tbITyAMMOkP6Yft0Wg3sCNruFfvMMMA57XNZJE71xYgMEtWnLZPsPgs8wnFV5w/8j2FAGZLSn4SWrDtBjZHTStnSkReZAffOiA47kYXm9zEzLaILPI5ntqOEhBAr0bhd/L/5QSNDRv/JPAhvYv15S3Q/b2HqeF8blhNXGg1YDcTirKSiDd/Gga1bjq+O/rOARdmlcSIMm919qk/cJOQ/OhDRDg0VqtpYqZaC2F/4boab4S4xqulU1qLrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0gYY50BNeFE2SYGzOiG7NUjStROGcMU1HL8X4cJj65s=;
 b=ewFKvRlHevH8kgW5F/t7445l+ome5w5D5SF2vUXt5AA5kPbOTXCbUWV9RWdnHv1npn4UtWvxY/19iwAsqecXD9z49tOGxHdM6Go6PdyRcl2S30gx8Of/PV5ZFhtR0sHZGDOK6LTnJPsJ3WgA6yqbv1CGVkpxsuFQ9kWx2sGFsyO90c2yHjbaVhufTU+ekHZlniiGSX9BSJiJYm3Ib5rmk7PWq8ggJJXs6vBRfqQV3eSNOpy8lmU+N3GTBTjPEvcmqbYcXobixTCWhLKVGmtOYy5bqUt5MiSdEeUC+NgkLhRCH5SU0pm6mqRxhJWWd6iOOdmPuNbKxKXyj6DDLkEtaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by MN2PR12MB4286.namprd12.prod.outlook.com (2603:10b6:208:199::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Mon, 22 Jun
 2026 06:57:53 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%6]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 06:57:53 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Subject: [PATCH v2 0/7] Host1x/VIC support on Tegra264
Date: Mon, 22 Jun 2026 15:57:37 +0900
Message-Id: <20260622-t264-host1x-v2-0-ff7364d9ff7b@nvidia.com>
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
 Mikko Perttunen <mperttunen@nvidia.com>, 
 Conor Dooley <conor.dooley@microchip.com>, Santosh BS <santoshb@nvidia.com>
X-Mailer: b4 0.16-dev
X-ClientProxiedBy: OSTP286CA0099.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:219::16) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|MN2PR12MB4286:EE_
X-MS-Office365-Filtering-Correlation-Id: c8fe38f7-07c6-48a1-6923-08ded02b94c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|366016|7416014|376014|23010399003|56012099006|11063799006|18002099003|921020;
X-Microsoft-Antispam-Message-Info: ozTONDtn4DfrCxkL3kcUs5a1r2UL2ZdhZc4AVF+VC4Bo+9N1zvpX2Jxc8pEk1MESgzGxV6b3N3GUZoWMOlD+cURYhuspTTavC+H+B90+0eJuMck5nAmwVcNKG0YLPoYO42UKvMqy7KnYNs2INAtd8anI721KTJaHRfTRmhaPFVXsXG8ZWaeX9UjudtLIlX2RaDg+FxtDbP+REyRs8/cF/fm/RYOix72qGOIosuh4VuaXWroHnwRJEO8TvKSpkJHoEuo+owDfnXRj0ZvJyp9wNEWa3w4pjI17Rgl9OXPN2jILIlBqQ47jOHmBT0DZgqMzMqDHnjRN9d32Q2/qybw1VB6SX9nkrqitTncCcsxNR5XX+UWUtGft/jvmfj6TrjQT4yLZjK6k9NRBo2IfcCICwSsP1yscHTpCVHHJpfb8As+O0M6MjUfynStO6pSMjXXrsLWjfxRPlF70ThCiZ/4gojt9Luk5J5bulVLE87SQ1RZX2CPJpAutoPhgCTNlnmmZJwJjWJ4A+8JiPXltXnVItGWNYUZiGOnmyYAdjpZDGQdFcvpxxHCcYHc2212GjPdW7J/RoWc9G0lchcFdwEx8XFKzknc48BVdCJJtv785NRI2UFCyCvZLRQRjRmyqRNjzmokb2svl3qhg2DOBcHDgnCjo4isUwuJWGicx0507fRX5Iqv2XV4oZtKdbAEQpYe8bF4Qamv+7TepK0LRW4xG7w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(366016)(7416014)(376014)(23010399003)(56012099006)(11063799006)(18002099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUZjQzMwSTBLN1BuU1JPVzMwQVUxbHR2NElZMHptNkE3dDdJRVlGT2M3am5F?=
 =?utf-8?B?QitZS2lrdEF0aFVNSzUwTlZ5ZFJuNENESGdvOGpna2Q0Q0dtWmlEK2tZc3h2?=
 =?utf-8?B?c1RXbENIVTAvSkVxeFB1ekVwVnROSFg5R2kxSm5DT3V1ZzJnbTg0WUxRZVRU?=
 =?utf-8?B?SVVWME94ZkV6ZGRVK3FMMWFVSHJsSWxhc0I3dUVKSmFVL2NtWSthK3UwSldy?=
 =?utf-8?B?d0RUeUlna1hVWFZrUXRNOXdTWm5XQ1dJcnVjeW5FTWI5ZFVjSkJ5aU1yOVBO?=
 =?utf-8?B?SDk5VWNvN1ZQV3YxOHFic0ZtSWNLMkJGcTRsbzJUOHpoQ0hyLzVVTS9nRldF?=
 =?utf-8?B?S3pwOXdRYTRHMHNoVFFKdUhxMTJ6SGl1TWJOU3BJaW1tWEJ1cDNnR3NCSkFB?=
 =?utf-8?B?Kzl0cmVpZU9XeG82RkxIVnRyN1ViTTR3YWUzY2Z6SW9Pd3pPSW9LRk9wSFAx?=
 =?utf-8?B?bmN2WWY5QXI4QU02dTRwVUhBU1RtQk1qZWVZUG0zNStpUWtkYTlHdFFtNHRM?=
 =?utf-8?B?WVh6d0syVU44VVBHOTAvWUUyUzVaU0Vlc3pCaTArZnFWVkhtTExCUW1jem43?=
 =?utf-8?B?OFA5NWtiYVZySG1WUUg0MjljdjhLZkE2NW1qRHFkVzA3NC9jc2pIckU5Yisv?=
 =?utf-8?B?MXMvM0NlY0hpenY3cTVneHpra05CbklFRDNhaEFIK0RlY0FLQi9wKzdLOGRW?=
 =?utf-8?B?Y1dRWmticUg1cFovQjFQOTVXSWtLRUsvaVA2Q01aV2JkdDdiV0k2SFV2MGRS?=
 =?utf-8?B?cFdUTmlkS1IxMjkvUFljakpNTEFwRmZJS0JOSnM2TEZKSjAvUlR5ZENjaGFK?=
 =?utf-8?B?UndlTVd5Ulc2ODRTVDJEZmNjdUQ0VDZuRjdQM1lHNlBRK3RVcHh2dC8xbzNC?=
 =?utf-8?B?cFBPYWFGc0JnbVY3UFBXWmQrTDFMK2hKQldETXYyaTlUSmxsTThrd3FwTXNt?=
 =?utf-8?B?MG9NbTBUS2FSZkpzTmw3OFUyWjRNbTVTaHZJNkZneWw1eUNyYzJ0ZTU0cTZF?=
 =?utf-8?B?U2Y1dGx6d0JHZGszbVcxejRCcGQwUEtrV2dCZDVZTEE3NmNVSzgyejQrVUE2?=
 =?utf-8?B?RkpaenRSRzhxaTRxRnBQRjY0dVl4eFU3WEFCS1FhOGM3RFZMRWhTbE0rOTB0?=
 =?utf-8?B?SHRWZ3NBd0ZONDJrV09Ucm9DcFhZQkFLRlovZmZiWk1CNk5rblN1UHpaM0RN?=
 =?utf-8?B?RmtML0FHQ3dUcExKRnRWSWMySWxiNkNZRHY5K0JXcGN5c0dIR0toWGRtOTVt?=
 =?utf-8?B?V1pCeGJpRTBtR3FaNWp6MG5SUlVVQUc0Q1N5MVArS2NaSi9GNHRTdnJMbEMy?=
 =?utf-8?B?Zks5aUt5UWgyMmxiSzlTbWRhNXQ4cW5ISHgrSi9aTkFyQzE2UURleUMzc0ZT?=
 =?utf-8?B?QWEyeXdLSkczdkg4NTRQUWpTN2pJbldYSVhsYlZuVDNuZThnSjJqS3h0aUVF?=
 =?utf-8?B?QU56c0MvKy8xVEZkbzRNMUFWMmJYTW1CU0g2VU96MngwTjRib1JPL2lhblMr?=
 =?utf-8?B?Sjc5N2R1Y2JudFZLbTUxT2c1ekp2MmNibEtNNjVySzFRd0Q5NXF6SGltdlkx?=
 =?utf-8?B?c2FQZUR2TzlNTjEvaWk5TGxuUWgrWmZnTXJYcDR4R2ZOcWVnS1pqbm5NZm94?=
 =?utf-8?B?US9laDFCVXo0L2NsSFRjRlRHZzBFaHhoeFhqOHBrY2NpeVR6anNYWlhSZ1FX?=
 =?utf-8?B?ZWNtUDNvOCsvZVk0cUZTQy90UkNPcm0xeWpHYnBpQWZwemJLZjJsVkN5RXBL?=
 =?utf-8?B?UWhuaG5wTmJiMjdKOUczempsRHdJU0xacHJJeHFFbFZXeXpza3IyYVhVUUpR?=
 =?utf-8?B?M2N5bEZ3c0s0OFNYbVFBMzVBc3d6cmZuNjYrbFVGaXpFemRJU1hETEYxcWll?=
 =?utf-8?B?Qkd5bTJqK1AyVzVpbmIyMFBHSjVUS3ZSUjlQTTVjZVBNUnhpYmsyV0JRNkps?=
 =?utf-8?B?dGs3OVRkMk5DZTBkcFJoUGw5WFJUQmRzdlVMSjZOcmtBdUhJekFXcVoxdDZU?=
 =?utf-8?B?MG5tditYQU9PaHUzblVBVFE4OW5YOW1CRmZ5U25PcVdERVZ5QmhhcS9NVmdy?=
 =?utf-8?B?RFJlTjhxS2ExTnliVU85L1NodWlQUkw4VThjREZQKzd6Wk5jd0hvdzh1NG1Z?=
 =?utf-8?B?Zkd2eDlValg2b3hqQUp3Q3JQNkthUk44ZVdHR0x1WjV2WUZ0cU1NaTJrQXJT?=
 =?utf-8?B?dzF4emtGNC90S2hkc3dpMFBoYWdoUkNoMm5sb2RpMTlZQ0xsWnFucUlYMUZR?=
 =?utf-8?B?L1FibXc1ajRxTjcveW5aOXI0TlJDcnV1Q1c0bm5FeHBwa2JyUm9oQnRvNGJV?=
 =?utf-8?B?MGorT3dFZ3FQU2JmdVp1UTBUTDBDYmdNKzFxMkgvdGhZbk1zSFVWcUJkSVBH?=
 =?utf-8?Q?RRkgzesT10NpUvIEn7lPhs9AfDVt/ltNMocLMdGC8AS+2?=
X-MS-Exchange-AntiSpam-MessageData-1: vKYgMTPBs+LsYA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8fe38f7-07c6-48a1-6923-08ded02b94c7
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 06:57:53.4057 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UvnbO+Jit8w/TqFBlbm1GXSfwx/zJ+dpQtviZGyUTmHSxSL296J9H1ynUKnfRAw064o6dnuACO1Mq1aQo5NVTw==
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

