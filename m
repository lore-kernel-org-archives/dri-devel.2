Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CE75106B50D
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 12:14:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4499E10E891;
	Wed, 25 Mar 2026 12:14:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Dwnk/GEp";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011007.outbound.protection.outlook.com [52.101.57.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7703C10E88C
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 12:14:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xVZDNpZwLNIQrmz77OkccS6CatnfPZlNhw8Ez/YKTHU8lPMPTNjYf7bLY5OVaXIFr7EOkg4LKXNgZNpnfvDtvcS12OkmLwr5nlLa9uCqYAr9yzSBniylEjyobDdS5OLEn//Ur7usbvLgLt5nqInpcXBy69LwDtwwY2T6Bzas3+AoPcdCodOxl702f2Bdw/tiesbX7zjYVtfYkQlC8jOMIRyUWK7kX3ae53xwPsa+fdBnw64Obkyg5YabXCAT//xPZIuGNflRyrCVZOPPGYwVjwug3QmvqGgORfjk0OKz4Bur6/cqg8J5vIFQC4HOV9A7kqk9YJKjX55Z8QzvqA3YkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gAZKv43hfcOdVBucj3jlJ0cKT31HTJSSl+koMHpNOjw=;
 b=LpAS159DQXYkAQjXaeW0UElyiRR2awY44nKLvvXu/v4bruWHLkqvW0Oq6T0JXWGTpZZehZz9annIDXOpA+198fJddEVfmwR9lLws5q69cE/Hm6WuyCox0o6LTZ1z2AhuLCDglCH8swLVlb+V11rqwuOoWMJBwRsoQ40dGAKVimWua9ibR/AQjiMRpQK4l+sKnCHIrg9BFGOEy37d6XcTk7y4bjylfYlilm8AXlTYEP5F0+S8pzATkBrHsQsUiueaa8edF57M4U1BR5L6wsE/pqgXIiIo1R9oH4YDTruDurrANpD/trzPiW7aOTgWNZqxq1XWk3TVc/zaJT2NqQfhmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gAZKv43hfcOdVBucj3jlJ0cKT31HTJSSl+koMHpNOjw=;
 b=Dwnk/GEpgbQIwPS8S4wAfLM3xsCPmW3SxSD56qoheqBDx4HpAKnYanAAHl+suMtDGT8jnJsfn/n31sdOVu3KPuyyc3VI3jhXQBu6HkZKS1Do2mKeW1IUx905ItBKP1g9hxzITl35Tx/5O4TyEQG5GzW9kF+Hzs7140zWW7CrrNRAAYK09dJbu2LskApQeiKMymwDuTgQdUY0Ge1GkfmT12OJeuPh6yfiFUyArp3NVsqHg02vxEYALqzRXJ7d7F6h5RNMLcU6UiyvCw3I8INEGBJkKr+S9F4c8f6KoczEJLiAIK1yyJnQMcpZCIcY2b4mD8AZ0O1WE6NI8qBSjCbhIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by DM6PR12MB4298.namprd12.prod.outlook.com (2603:10b6:5:21e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 12:13:52 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9769.006; Wed, 25 Mar 2026
 12:13:49 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Subject: [PATCH v3 0/9] gpu: nova-core: gsp: add RM control command
 infrastructure
Date: Wed, 25 Mar 2026 21:13:38 +0900
Message-Id: <20260325-rmcontrol-v3-0-f3101093484e@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/1WO3U7EIBCFX6XhWgw/hcJe+R7GCzoM7iS2rFCJZ
 tN3F7smrpfnZL5vzpVVLISVnYYrK9ioUl570A8Dg3NYX5FT7JkpoaxQyvCyQF63kt/4HF0QNoE
 OIrJ+fymY6PNwPb/ccsH3j67cbiWbQ0UOeVloOw0xJaeFgiCjwGnS4EWcEWdhcDI+eW/Am9Ep9
 uM6U91y+TpmNnnIfhdNd4ua5II7a0eHo7Pd8bQ2ihQe+89D09QfqqW7R1VHffAp2CRhBP0P3ff
 9G0pO2bIqAQAA
X-Change-ID: 20260225-rmcontrol-bd8a06fc3a0d
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.0
X-ClientProxiedBy: BY5PR13CA0004.namprd13.prod.outlook.com
 (2603:10b6:a03:180::17) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|DM6PR12MB4298:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d6bfeda-1b4f-453c-4efd-08de8a67f8d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|10070799003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: ojWfC7cFgL9EguAW/0OcxE2M6/CMuZqgpSWX6NujHgKWNF8WMvkiOKxZ+9CRPh8eiIeIDOKegM6PRrzuUhfuaWyv1Ehdw47wUaOONdjsofq9Jm/ceuMPa5qEI5BEKMgv3iFYoJX3tfNXDtd6S3cWoeF0d1YJMY+ZKXFzcNLSbWwaS5VAFxF0tDXY1FxVr/JBO1SsyRyj2zQq0iSG61EX9vUXqM4ESKNIs2ZPwMJ1kQvYkt7t1hKwBZNC+tPsqq4AW8LbZqBRY/k4qJXTre6Kg1Usj/q73WlXaNmLW4O7qZ2judBWbzC+VyPox0wrAq++YMy9AGe56HekmlC4+QmZfp1GlB7AQzOQgAhaqKkZyNSJ/I4NrCdcl9un+H6qp9MsRMv60VHq5p/9232FNWIg73FljeY2HdO85+CC74rPtNrLDLioFDjm8ylWsrhQNbhWsro0kX/5uj/3wZK/JUxP/rloEm+rRBJwxA9ciuJKIJzxpSHTUaFIzklTrBLeb5ziIZ2JhKb6+8NvdeF7yD7RRIdjKZ1t7TvcnELO5KkAVQbY+UEtIHpz+rrva09nj8MnOtJCctYVc0MNoaavYbKGYZbG2U1Wj0V/mCuCEpVbK2relraemKWbgQM3nm0Dz0GrSwwhthOAK/UMGBpk2Xgrfupew0nA8uX9eVIiaHs579vTbMoNIimtWfodaVox6rzIitZeRKirK9aTraYcTIlIRFV4FVbGG+lZhJOPy/ftfj8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkZad1NTRmJiYkxtbVEyV1hqL1FCaXpwMkhQYXh5QklYTVcwZDNyQUNiOVZC?=
 =?utf-8?B?dHNxK3k1bU41bjA2dkpTUDFQeHZWWEIxc2dNWDlyVktaV3ZYM05raktvQytS?=
 =?utf-8?B?cUhDcVNHeUdMTG0rZlZUNlhYTGUrRE41VURnS3BFT21FeUhHblZ4K0hjNkIr?=
 =?utf-8?B?YmxHSzlXM2JGRkFLcThXTEU4U3ZkUE1MMlJvVmJPdjdYWEpOdDZzZkJGZGR1?=
 =?utf-8?B?aXlHSTZXMG9BVlovV3NjR1Q1UnFCMnNiSVZ1SUlRUzRubDgxTHlqOERmUlc4?=
 =?utf-8?B?V0hwVXQ2TnZTVEJ5VTBFTkl0cEFrUm1ZOHN5YzA1NTg1NXVyTlU5Rm00ZU5j?=
 =?utf-8?B?czFmWXJJOHBES1pUS1BVQnVRb1NxbCtWYjdYRzl1YkdGcDBJODIrbFk5OHdR?=
 =?utf-8?B?RFJFMlhjcFZUalRNQkJSaGxhYk50Y010TmVjTHh2M3FrTEVuWnZ0TVpBUS9j?=
 =?utf-8?B?WGNDOHZkcnE2ZWtQNnJoaFp0M2FmK1c0WnNPK2tWZTBZNy9neUNDdjhUZ05R?=
 =?utf-8?B?b2hoYnFCQ3IzOG1kV2ZIaHA3RFBuM0VYMGR3YUorS2w3ejRrcER0bTUrNWh3?=
 =?utf-8?B?V0haeEp4cTBiYVhRcFJYb1dnV0JhaVJKUXdkaTFRb28rdGJpQzhPWEdXR3By?=
 =?utf-8?B?bkU5TzQ2YkF4Vmd5dk5rZFJaM211SFE0SnNKL0d6ZVg3NEdGWWZxL0RsSTVG?=
 =?utf-8?B?a1Z1dkZZMmZqUHRlTU5DaEprbzFtL0s5U3FUdWh6WWNLYmFMcVo3SU1uejZN?=
 =?utf-8?B?NXRxOHBVMjFYbFUzYnBQckxJbS95NnNOeisvMHN5dnRFd081VFJyd1pKQVVi?=
 =?utf-8?B?ZTN5T1R1QWtESHR6S2hpNnNlQ3FKbm1XUHpod1dRUXZRaFRweVZsOUhRWmdS?=
 =?utf-8?B?OUwzQmtVeXhMUVFtcmlTNXM0VXNGaXpMTTVRY0IzcW9rRW9DWHFqRVhkZFgz?=
 =?utf-8?B?VTcxbzU1SWRnUW0wZkxPRlNNNEJOQlg4SHFrQ1ZUcnRLRjJkV2RhYjFFTE84?=
 =?utf-8?B?WjU0MTBxd0FVdlRBTjgrU09WWkxCV0V6Z0xVNUNxUUpRSmM4NWpMWmxwTnU3?=
 =?utf-8?B?TVNCOWVUeGpDRnZzR0c2dzltTWtXbUlIajhBbnhXc3luZzVtTlI2MUMvSkRD?=
 =?utf-8?B?UElndjZsaXU3bGlXN3BFNTBYOUUvVEgrZHNYWnd5RlNBNU9mc0hHOUFLV2hv?=
 =?utf-8?B?amhOY0ZPNk0veUJSSjJpblM0MUtST0RQRDRkUjV2bFFUbDZvZmZOVlBLbmE3?=
 =?utf-8?B?LytzUFpXTHhyQWdxcGxFTlRmVXlFSG1WeFd0ak1UalhXUGFHeGpWZ29TRzRo?=
 =?utf-8?B?cUNiWGZJenVSMFM5bFhhKzRmbXdYcGVaSWVROFY3UDZzTlYrRW04VkxzTDgz?=
 =?utf-8?B?a2FsekVFekJCa1RYZm5yOVZaQXJwd0ZvYURpTFd5RzhRRkRxRE1pL05SWlhO?=
 =?utf-8?B?R3dtMFhLVlpTRGQ5T1NSNGx5L3RVZHBNcjNkTTlaYmluS2FDY2RKRno2R0Ux?=
 =?utf-8?B?czFBS2tSVnFzMFI2OWk3azltMjFLNFFURmVOcmYrV0pVRUNldWFwckZkWHZG?=
 =?utf-8?B?TjQ5WGY3NXdsVlRXWkFLNEhTMlVYeG9EejdjRWdzZG9kc3ZsOUI5TjlmekpF?=
 =?utf-8?B?RUJtQnpGNFgzdjdIb0xhbFJ5dXBiY2hRL2J6Tm5tUHFSNE1FQjFSbk1KUmNh?=
 =?utf-8?B?TUhlUDZJTER2MkgrVnAxTjdIeEFScWV3eVZLWmpCQ2V3RFpUcEs2ck9kLzB6?=
 =?utf-8?B?YTcvS1RkbitvTGxWMGFINXl5YmtEUlFRbE1IMVJ0RjczZ0Y1QmMvOFJCWHlJ?=
 =?utf-8?B?cE1pT0lZMFRmL3RnVWI3S3BOTzFnWnI1T2pvUndla0RJVElsY0d3Z21rRlVh?=
 =?utf-8?B?TlR3Skc3VnY2d016cGluTm1QaXBaRDVPMGtXZGtKVFBJTGNHVU1EQ0tXZUx2?=
 =?utf-8?B?bURKZUwwZlFlY2JIaHIxTlBKUVUweE5zemIyd0JLbmlLajIwaUJ3YzI4cXdo?=
 =?utf-8?B?VXFrVGVMYm5GVUxxaGxsVVUzUkxKN2xiNkliaDdQSkpxRFl6MUtNOWQ5WkR4?=
 =?utf-8?B?alBRa0JkRTVKZWJtZ0RMY2U3bWREelVieEtkTUF2cUNhbHNBRmVvdWNqekwz?=
 =?utf-8?B?VjZUL2FOdlJ2ckIvbUh4WE0wVkhGeG5XTkdlbHRhMHZna2ZjM2dRbGkzWldl?=
 =?utf-8?B?NmFubno2eDRoQkVzOFA0UDBXSVB5WGRKTlRWR2RFMTkvL1pDTXN2Y1c4TTFs?=
 =?utf-8?B?dkJGMWN3TWhQVG1UNHAwSzliYUZYQ3E4RllGYnJsbVhhaU0zSkNUdGlsbERE?=
 =?utf-8?B?Z2ZTRFhYQ0pkVHJOSzBRcEJPK3JvbmlwT1lERnUvUVVUVGZVZXMvSnBkNFhu?=
 =?utf-8?Q?xOZlePkzhbkdYso/G4LDSRYeHfSrTcQSfUjCG/zkuCEDM?=
X-MS-Exchange-AntiSpam-MessageData-1: xBXb5JzgTa/2IA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d6bfeda-1b4f-453c-4efd-08de8a67f8d2
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 12:13:49.5308 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qpDx0qr5KUI/dVQmCHLnuk9dvs4mRTM2uEYCPS0QWiqIezgyfI4De9UccnkaYOU5zhOQ/mutaCDbXAa/Kf/nrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4298
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

Add the infrastructure for sending RM control RPCs. This is needed e.g.
for channel allocation.

This series adds:
- `NV_STATUS` bindings and wrapping `NvStatus` enum (used by RM control
  RPCs)
- The necessary bindings for the RM control RPCs.
- `RmControlMsgFunction` to identify individual control commands, like
  `MsgFunction` for GSP commands.
- `SBufferIter::read_to_vec` (using KVVec) for reading large RPC payloads
- A typed `RmControl` command that can send RM control commands.
- One usage of `RmControl`: the `FaultMethodBufferSize`
  RPC. This is useful for channel allocation later.

Each new RM control command can be added by extending
`RmControlMsgFunction`, adding the bindings and wrappers for their
parameters, and writing a type-safe wrapper to send and receive the
reply for the RM control rpc, using `RmControl`.

This series applies on latest drm-rust-next with the listed
pre-requisites.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
Changes in v3:
- Remove `send_rm_control` in favour of a typed `RmControl`
- Print out fault method buffer size at gsp boot
- Remove Reviewed-by and Tested-by on some patches that have changed
  substantively.
- Link to v2: https://lore.kernel.org/r/20260318-rmcontrol-v2-0-9a9fa6f1c4c3@nvidia.com

Changes in v2:
- Introduce typed Handle<T> for RM objects.
- Improve naming
- Improve doc comments
- Change SBufferIter to always use KVVec
- flush_into_kvec -> read_to_vec
- Rebased on latest cmdq locking
- Link to v1: https://lore.kernel.org/r/20260227-rmcontrol-v1-0-86648e4869f9@nvidia.com

---
Eliot Courtney (9):
      gpu: nova-core: gsp: add NV_STATUS error code bindings
      gpu: nova-core: gsp: add NvStatus enum for RM control errors
      gpu: nova-core: gsp: expose GSP-RM internal client and subdevice handles
      gpu: nova-core: gsp: add RM control RPC structure binding
      gpu: nova-core: gsp: add types for RM control RPCs
      gpu: nova-core: use KVVec for SBufferIter flush
      gpu: nova-core: gsp: add RM control command infrastructure
      gpu: nova-core: gsp: add CE fault method buffer size bindings
      gpu: nova-core: gsp: add FaultMethodBufferSize RM control command

 drivers/gpu/nova-core/gsp.rs                      |   1 +
 drivers/gpu/nova-core/gsp/boot.rs                 |  11 +
 drivers/gpu/nova-core/gsp/commands.rs             |  62 ++++
 drivers/gpu/nova-core/gsp/fw.rs                   | 402 ++++++++++++++++++++++
 drivers/gpu/nova-core/gsp/fw/commands.rs          |  19 +-
 drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs | 161 +++++++++
 drivers/gpu/nova-core/gsp/fw/rm.rs                | 106 ++++++
 drivers/gpu/nova-core/gsp/rm.rs                   |   3 +
 drivers/gpu/nova-core/gsp/rm/commands.rs          | 167 +++++++++
 drivers/gpu/nova-core/gsp/sequencer.rs            |   4 +-
 drivers/gpu/nova-core/sbuffer.rs                  |   6 +-
 11 files changed, 936 insertions(+), 6 deletions(-)
---
base-commit: dff8302ca1d0e773c90dbeeb05e759f995c95482
change-id: 20260225-rmcontrol-bd8a06fc3a0d

Best regards,
--  
Eliot Courtney <ecourtney@nvidia.com>

