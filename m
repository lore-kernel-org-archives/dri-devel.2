Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1892C43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 04:10:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4934210E41C;
	Thu,  2 Jul 2026 04:10:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Gn8hCnCn";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010046.outbound.protection.outlook.com [52.101.61.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF51110E41C
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 04:10:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ctbXXkx2CsDyj180Xae4hl4Rqfvcnt3AetjkrEDErBHh9kTxYaLuceu8YkgNUr1gfcPgIW70U6n8bgYLwdvLOBYsl2pxP+7c95A+Mv0x1fozIXgto9sGYj7I5gnFFJ+58EPzD9vQkvzKEy8cMskBE0PVhsepgf7RSC/x6ub0cKXFonT/dkVM0AI1YssjNMDxp0ml63JzdD/aNdcTh9ol8Dugbo1jnqR2a0Bk372G34GEyPPynIRbH4ICkTAXnyeZxg4RPa5s4xFI1F8JBC5BZDP/XErCNbuXXPg7CE6wfrRL8B1LHqJJBlmFPrqfD9CTjISBlCIJ8c9POqqcyia9Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BWl5bZKRPAi7rfT/L5gNdSgVLsFmMH3IiLSujIH7L2Q=;
 b=XzEq1UdvpRnupo5SLpL0GJKM11X3dYIFWAtrI6l+1dqWPZfPutJVudSu4moEh428rPH6q22h3ugp/HmqcskCsaW+NMYvAHBvEt5KarI7Ngky8Kc6erWm+GniAbBI+Qa0mA4Yfupv24rEy6xuB5CZn4xUNjG/PWwzeSBf1Gyq6nPK5oEs3iBBDQw8Zo3Y2M/tPqzDpysN9cid84EcrIQ3IpJzyzMqlNuhn2DVy/6FKp7PmL3jmCUfqJYWpaJG1800Wjna7uXbnFGjf4EpoySyHEA3p68KznMl01NlydCDuEaMtiW6yOyOgtDrnkv9rryaPw5hruOFBBW2mqtR2ussHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BWl5bZKRPAi7rfT/L5gNdSgVLsFmMH3IiLSujIH7L2Q=;
 b=Gn8hCnCnq7TsNfEF+DfppTFGZ7VQMtv/snnRUiN35XLBGF1Cwgg9kKilJJVYTItnHVTWjvj1OBHBRtKIe76O7T/Qeqm1r9acNHFNTB586Vx0mKOKu0HOwBjUizVUX2ZakNAlW7XDqAOF8Z9ZleBAU64mSRTdabDwk8ojjUThTJAhQR9KywbcriYBrNFetfgR7sCciF0asMYin/896M+e/xWRp0fwCUhh0i2SXFhg6Tf0qExe72YyNWI5WPgwnQNXF560MYiKRaspryMQ2cIQj9RQYArLAebaOyQndTCWw5RJ3Al297nPEP//TaKhOUpvONuDpmqLGA73x6iMDH31Uw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by PH0PR12MB7864.namprd12.prod.outlook.com (2603:10b6:510:26c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 04:10:52 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%6]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 04:10:52 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Subject: [PATCH v2 0/4] Support partitioned Host1x
Date: Thu, 02 Jul 2026 13:10:25 +0900
Message-Id: <20260702-host1x-nohv-v2-0-e6d88bac0af6@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/1XMSw7CIBSF4a00dyyGSyxYR+7DdIA85A4EAw2pa
 di7tDOH/0nOt0FxmVyB27BBdpUKpdhDnAYwQceXY2R7g+Bi5BNOLKSy4MpiCpVxhc4qI7W5eOi
 PT3ae1kN7zL0DlSXl74FX3NfdkVwK8edUZJzJ8WnkVWiJyt9jJUv6bNIb5tbaD4GfbXqnAAAA
X-Change-ID: 20250919-host1x-nohv-071ed7c6ac4f
To: Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mikko Perttunen <mperttunen@nvidia.com>
X-Mailer: b4 0.16-dev
X-ClientProxiedBy: TYCP301CA0050.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:384::14) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|PH0PR12MB7864:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e4675ea-9ebb-44f8-d039-08ded7efe7eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|23010399003|7416014|376014|1800799024|366016|921020|56012099006|11063799006|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: br645FBy+u6g9TeYWaRcYKYHxaAypVJfPnxqNO7oslJyV+Ueou/bxAo9FMg8NUYp3T9d4g0MsuyUYNmRMh7gxV2gWWAzBOojcFiQQ/7sPUr5yx3D/MsnPjxLTF8td/+oQW+jOCC9ZDyPJX6VSYyYsYIlvuZXdDjC8CMtVuRI7LlXf3PqYqeYLVjUHDJGboGHrdO9wXclRprv15AY94jbjnNgkBb+x2cVIF+pmGtwkKXiuX/el3pZRUWwfRicAZDAQ3Y3SrSMp6ICmVxjVQX6EBZppZ5dyKUabdasu3P0PM7h9AHzTM2xcziuLfeSmaXvO2eLYSAhsHBIEiDPto0FoVELe1xiYiZpr4Wyg5QHwhEYV+OyPEaZ9w5lnUMbHf0e5QYucU1BSZPDb1U1akXQM4lFk19Hbo4Cw9R2ikKPQwhDVMeowcBLo+20Tj7OMCMGtnIJwgFy0MI0+2q25BAzbXzIYT6+WPkfK+015scfQ1OtlYlRvxyqa2+HAC0rRYrK2b5z4qA4I105rqCOkKTD8S5YJqaTMgAthQ0LvjgoFI+5lgg2dACImV0q80VquHeis9PWIZeypNX7DgxetDBtMMFBigefNZr5qucQAH+PqqVedlcrwKA2Tq9VTsHBK29o3xv/leyvHLnuoaQNimb1+MA9GkmW5c4lnK3xZ3cNtdPyD+J7TA65CQsZeVRcgP/ffICDqtz5E4WujwlRnZIT2w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(23010399003)(7416014)(376014)(1800799024)(366016)(921020)(56012099006)(11063799006)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGRzWk5rMzA5SXp2R0M0SThrTURqU2J2L2NMbDBqV2R0VHRRdWdDbU96YmVx?=
 =?utf-8?B?R21zNDdFa2R2YjJSOGVqR2FiQU8rNzlNN1U3R29TNXhPMFYrK29sNVJidUJ1?=
 =?utf-8?B?M2FyYXVvM2pzSldsZmpOeWJibXpLNnhHbGkwVm1xYzAvMmpSSmk3aTg5NC9x?=
 =?utf-8?B?ckhpWXIzbEV1SHhwaTNVNG1TU2Z6U0xBRnhzV3REYm96TzhMZ1BzWWhlaUtR?=
 =?utf-8?B?ZHgxTG1wTGRtSEFhQkRiWTFzbE9XblRsbXBFUjhTN0w4L2ZSU3FSdGYxOHlM?=
 =?utf-8?B?ZXRFbnpWUWJOd1BJTjhERUVmQXBFWTRvck5JMlN2MEtuSXlEWDFvdU1taUxi?=
 =?utf-8?B?RUFXTGhnMWlIdDRrS054akxOMkJnUWNIMHlmL2JZNTFhSUxkSlFmMHQ1RVo1?=
 =?utf-8?B?L1Jaa1JKbGVGRzdzN1hLK3R5QWE5cEwwR1FrQTFDREJ5RFFwaytyVjRDT1Z6?=
 =?utf-8?B?VmU2TXdTTE40NDRQdTkrMnZnZ1gvZVQxMzMrR0dsWElGWDlvUW9ncU1yOEFR?=
 =?utf-8?B?UnNoNXF3SUt3azdQRkMyOXlFRXZnTTZsc3lzMVBZTnZwdEFtWFhJNkIrS1VY?=
 =?utf-8?B?ODRpemdXUi82b1ZWUzRHdlFKZEVsaVdLYWRFUXBVREtjdGxoVnM3clJVU2tj?=
 =?utf-8?B?SG9WQ2ZWSVhXbFcyc3NnRE9tMVFuV0s0L3U1bFZHb05maTBNblBnaTJ1cWM3?=
 =?utf-8?B?NG5uOFMwOGxSTGl4RTJIZVJUY0hsd0dIem9hZXVZSmluNU5idlMwcEhyY2ph?=
 =?utf-8?B?VStXRExJTWV3SU42azB6L2xiQXU4QVJxamQwSXNzclBMTjFnVkFEdjQ3ZjFv?=
 =?utf-8?B?cGVZZDJRdGJDZjh5Z2wvQVNKbkJ2NXo5Ly94aXVhZ0R3elY3TlBKeHU3b01L?=
 =?utf-8?B?RC9vcjNYdURuTDhGVHJ1NkpqaHcyK3VXYU5WMXFDRXgwMTFHYlMvZkUySTR5?=
 =?utf-8?B?ZzdmU0JlVmV5TzJETmoxWHFMM0s0THZUaTl5T0psQzg3YUk4b3c3ZndKSG45?=
 =?utf-8?B?aHVYa3hKMnlGUmNzbUlQUjNGYnNCaytISUN0TGExdVgvMWRSVEV1bWpLbitP?=
 =?utf-8?B?OUROY3phYTcxVUwzTGpWWERVWG90SG1lMTJncXZmdzNOUWlsbXZ5TlBsT1RM?=
 =?utf-8?B?bkJmcm9XRTZqRWp6SEdiNVp4MTd0ZFdPVVYyb3R3NHBvU0kvWFVLTEl0TkVp?=
 =?utf-8?B?WlhET1NBR1M2YTloSXZGQmNlUW1MRE5oSXB4RWZzWXVhcWh5NElTQWo1Y01w?=
 =?utf-8?B?QjJPUEl3U1JsN3hab3BHZktPNTlyQVlVVko4UmZFVDBvcnRqbldhSmg5OE1a?=
 =?utf-8?B?M3VyV1IrQTN5MG1YWWRnaE96NnlKNHc4YS91d1FlRmkvZUNEZ1dObFBKeUYr?=
 =?utf-8?B?R2pnWWxtZ0JoOU1MSTJUMGpTZUhsUUpLb21BM0wyWjVDMTBNYStiY2kxb2gy?=
 =?utf-8?B?VG94Rk4zWlp2dEdEUmdIbmcwQjh0WWxDTFB1eFcrdTRjRHR6YVpkVmJaOUtr?=
 =?utf-8?B?M2Ntd0tEOVFtLy9BSThFMWhmeWFPSEgxeWExM1o1RjlQM01LNUw3YktDajVl?=
 =?utf-8?B?NTVvRnd6bnYxUkcvc0J5YlRPNU5CMmVoRk9GMVFQa0d5dUdva2RlNlVQTVFX?=
 =?utf-8?B?OGYyeGZqanV3UzdNdFJQYmhRVXBpOGIrWDJTNVFSSDlHc0hnbkdjcnMwdDVs?=
 =?utf-8?B?Rzg5MGl2V2JuK205Sk1ackh4NHBDWVBjNUJYU3A5SE8relVROTNmMWJjMUlZ?=
 =?utf-8?B?MzMwSGdWNGpPTWlCSnF0T1BJcjVmazY5Q1U3Z3MrSDNsTzBPMU0vc0FUTmxk?=
 =?utf-8?B?ZEJPMnFOVkcyVTlHeWZnSTdKMEl2b1pQWnQ5NVg1SGNLUjV0SENTdUlTbmVM?=
 =?utf-8?B?MWZ3TVN2SG1iNVpOTkRrUzFPaURCS0pQL3MzdDNhT1FSL1dBYnZGSktnaDll?=
 =?utf-8?B?Uy9uZzR1dW83Z3I2TVJYU2FnWnNNYlp1Rk5pKzRVSkxiU0VnNzV0aTUyS1c5?=
 =?utf-8?B?N2lMWi9FWDJXTUc4c0lMVkhEOHFDYm0reW92TlpMZ29qbkNvZnZ6NnMxNFpI?=
 =?utf-8?B?WjdOTlhQZGlVRGRhRnZDTlp1a3kxd3RMMi9NMC9ucEQyM28vOFhXK2tlQnRh?=
 =?utf-8?B?aHZHMTNEWnpXNVFTRXoxTmloZEtkY0I5cUZkUkNQdkxJSFhlT1E0dFNyam96?=
 =?utf-8?B?UmFweHBNck5JdXZHOUUyTTc3cUJHOU1pdzBCQnh1UnZwRW01dHdIT3dyQjlG?=
 =?utf-8?B?aFNhZEFLaTJCLzRjaUJHTjRsVVZuTitaT21kTXU3aXlNR1JsN1JiQ2RNN1Nk?=
 =?utf-8?B?RkdFVWlUczFaTUQ3eUJZRDFUSytRMHY2N2hwVmdJSFFEbytTc1crQ3F2VWs4?=
 =?utf-8?Q?0M84W0uc95ZZbRPWmlUJeP140NAc3FJeuJ56ITvhwBdBj?=
X-MS-Exchange-AntiSpam-MessageData-1: 2+0wTC7AzP22zw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e4675ea-9ebb-44f8-d039-08ded7efe7eb
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 04:10:52.4164 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vrCNAB8tQnUa3KvvRHmXTED4iu8QAQdbJ+PstwWO75I7kriNJblWZXF0WRmChA02N0YkmfCBDT36UadIeCQlGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7864
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

The resources (channels, syncpoints) provided by Host1x can be split 
into multiple independent partitions similar to e.g. PCIe VFs, which can 
be assigned to virtual machines, non-CPU embedded controllers, or other 
bus masters.

Each partition has its own MMIO register region and interrupts through 
which the set of channels and syncpoints assigned to it can be accessed. 
This set is configured via the hypervisor MMIO region earlier during 
boot.

This series adds device tree bindings and support in the driver to 
function when Host1x has been partitioned in this way, by making the 
driver work without access to the hypervisor region and with a limited 
set of channels and syncpoints.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
Changes in v2:
- Updated commit messages to clarify software view of registers
- Minor rewording of schema description for channels/syncpoints
  properties
- Rebased on v7.2-rc1
- Link to v1: https://patch.msgid.link/20260622-host1x-nohv-v1-0-65bc682a617f@nvidia.com

---
Mikko Perttunen (4):
      dt-bindings: display: tegra: Make non-vm registers optional
      dt-bindings: display: tegra: Add channel/syncpoint range properties
      gpu: host1x: Support running without hv/common registers
      gpu: host1x: Allow limiting usable channel and syncpoint ranges

 .../display/tegra/nvidia,tegra20-host1x.yaml       | 52 ++++++++++++++++------
 drivers/gpu/host1x/channel.c                       |  6 +--
 drivers/gpu/host1x/dev.c                           | 52 +++++++++++++++++++---
 drivers/gpu/host1x/dev.h                           |  3 ++
 drivers/gpu/host1x/hw/cdma_hw.c                    |  3 ++
 drivers/gpu/host1x/hw/debug_hw_1x06.c              |  3 ++
 drivers/gpu/host1x/syncpt.c                        | 21 +++++----
 7 files changed, 110 insertions(+), 30 deletions(-)
---
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20250919-host1x-nohv-071ed7c6ac4f

