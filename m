Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9891FE88D70
	for <dri-devel@archiver.kernel.org>; Sat,  4 Apr 2026 05:04:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D32B910E065;
	Sat,  4 Apr 2026 05:04:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q7patIhT";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012016.outbound.protection.outlook.com
 [40.93.195.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 008E110E065
 for <dri-devel@lists.freedesktop.org>; Sat,  4 Apr 2026 05:04:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AEHzGK0iKs+V9HK1U+0x2qaph7Q5aEcPmVLKRPzBTD8H7Ya5cq892CZhSNnwbFPycjo5138qXuGs0S5iqyqOa3OP6h1V5Ikq6pgDrzCrAMW9cugdvUH7C5kJ/vxdqlnoTJFPR02AIYAJ/3Ocv6V+4eanjtviJUx7UVwLBtv+x1a7roFkGiXeSuUn1zU06ChQX/evKjfOC0dHCAhZHvUGK48f4GtfJ407SLpCzqgpLPp4sZ0DA0so/VIOLhg8ZxWCzki3PAkgxfCjRqq7us0oS9IF1FU3t9jaq8LMGxPbI6CQWhlQ1CxNciOVZ1UAnBzbpiZIRTrYvAvQFD90heL8Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/q9WNzRfcuIhiV6g6931LMz3Y6AAm64OYcMaVdfW130=;
 b=G1mzhclpMkyV/iKoeXr2nRMXMuwxcVrOtoL0YU5uatsTe17M/xkVVuZn0qYej1zwXEByMwFPeq7m9VyboTI4BGU9X5R+Etd30DwPCmv/LzrvSyJXTX/DyZrvs9AAWicO3QSCLZpZsz+xim0Wftxj3+oo4tRPieO273sTcXkeFxEsUtDmtAM3jxG5mNGLocOEpirjKod0i5SNzsVvH1/PHUbI/AUWNWxK5fze0OvVn9xPj9qyqJDtcp1ZH0q/rItdY70wIuB1lDtbril3NaRf013wpmLrL9oSUgBzlTLz+Gek0wojVOiG+oQtF9w5gkAjJUdbv07t+qOb0kEQvGECrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/q9WNzRfcuIhiV6g6931LMz3Y6AAm64OYcMaVdfW130=;
 b=Q7patIhTXsi779lomwIwfKPOGiEyRrYRdpfl+ndtcR1WNScct0wG6ZguPXY0EFJXMh22N2fpQXsfk1Ez+coztclD4ADuUDdmag+Mq4JgUp9kAieyqSIBwcoL6PbKsoAQIBfFUVBVCcbECIJoIP98gpKNSnyt10Wqz9UH9p0khySuO9RiN56nOFCWg7xHOfDQLfEMDBwC8ZmUFXqapqvGpRKQMc7LVZMmWg/lkr1urFimVOU8Kce0JvNMpPKRIxwcIWXmJIVDPQQvXyAuevjGGvPYxBP5hBfH2dXm+FJ3aLsUFCeGMEec495hUF3IDHs2sMWQ6AM0vPRlKxv/8t3/dA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CY8PR12MB7513.namprd12.prod.outlook.com (2603:10b6:930:91::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Sat, 4 Apr
 2026 05:04:28 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.20.9769.018; Sat, 4 Apr 2026
 05:04:28 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Sat, 04 Apr 2026 14:04:24 +0900
Subject: [PATCH v5] gpu: nova-core: gsp: fix undefined behavior in command
 queue code
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260404-cmdq-ub-fix-v5-1-53d21f4752f5@nvidia.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23MSw6CMBSF4a2Qjr2mT0oduQ/joPQhHQBatNEQ9
 m5hIgSH5yTfP6LBxeAGdCpGFF0KQ+i7PMShQKbR3c1BsHkjimmJGVFgWvuAVw0+vMEKWWOlJRe
 1Qlnco8v3Urtc827C8OzjZ4knMr//O4kAAeyVL13lmXHs3KVggz6avkVzKNEVpmyLacZSWkIJM
 8xLv8NsjcstZhmrUntKeGW0MDvMf5hjssUcMGillfGqorwSGzxN0xc47RnbXgEAAA==
X-Change-ID: 20260319-cmdq-ub-fix-d57b09a745b9
To: Danilo Krummrich <dakr@kernel.org>, Gary Guo <gary@garyguo.net>, 
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Alistair Popple <apopple@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Zhi Wang <zhiw@nvidia.com>, Eliot Courtney <ecourtney@nvidia.com>, 
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.1
X-ClientProxiedBy: TYCP286CA0343.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38e::11) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CY8PR12MB7513:EE_
X-MS-Office365-Filtering-Correlation-Id: ea274edc-c69b-40be-8078-08de9207a5bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|376014|366016|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: Dd+RdfXHugpb2y6P3QJO9HoOf4j5Sno8ni5iHXE5ShVFLIWI48VfM2njGCaq8YIiyFV/VJNtH+ik74m1xQnwsOXDGBb11zk4ak4QUwQOg1cv7bUAbcMjrV30NkmYYO1IADiykcOYCnEPA+ra5PxQQ4DgtHrcbHp2X5PovPeSxfW0wRLjiwWQ5joTQtFJmsQbDdVmuV3JwvJA2ZF1wG4YN2wmSDgQ9+sXlkpY35TBd4pibnFwCwy8AbYAWtma7LXGaBypp7T6ddXKwD9gMvtIO3CA/e4CB7joUCV6Ax9My6elKECSdoeMIBMfG2hchmxoTIkweP8CPVdWClDwYi1YVENoVerMIbEKvQp8tvfrtta8lwJJDpEKZQQQ/omjfbuDgJThvK8A5blRcy3jwUd+dwqmOjZWctkGQimo3dG3tAsUL1HULgjbpxlivC5zeWigxwj1lBUpn0DDjW6WuM+t+hlonwPfT6MpdlvaQYVwloKyX3N/NeKwvsfMYuYUf0s048CCyRok1UnaNEtoXXmW0QUmUU15RrggwOg2GjyPLIu1Mb93XmPpXtBqR54dDqn66LHB8Rqgy5RI3en+3inA3LcWLFVBALsK/orS9EwZoPXLrJF1KC+M6/1VtEdYSRwT+wmEVzIy3ZtiPundt8LZiYOkBtscJb8zvnyHzue4I1oVUM79ARcQWcmVZXV3bspJMUOzRqDncvY5/m5+2ooLO55eOO2CHT6MoGS53SVnNqk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(376014)(366016)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1ZjK0o1ZllJN3M4bHZENEpqQmNMU0xwU0thS1F1bzljMnVyMnBzVEpSN2dq?=
 =?utf-8?B?S2djc1RaZFlmeWdLSUlVN04vMk9GQzJDeDI4MFBTSEhlS0NucWczN3JVamE4?=
 =?utf-8?B?NUNzUmMvamkzOXFSVjY0SHRsbHZUN09Kdmo2WkVhZ2dwRnRkQnFYVjc1UW9s?=
 =?utf-8?B?bXIrU0RwaW5DcXFQcWlBallGeTRwVURwOEdVNXVJSWU4UHhTbmcrTnNWMHRJ?=
 =?utf-8?B?SFQ1K1M5VDgzeUgvRzFwdUs2YW5IVlNmWmsyNFc4V2VyTVNNV0VRQ0JqL1ZT?=
 =?utf-8?B?U3JPRzNYQ0JkTVpuUFBoR1JuejdzSlp1UkcyaWdoUUcyNXM4YTF1bTBDOC9r?=
 =?utf-8?B?UWQyMW0rcGxYbUoyVzVVcWcvT0VnYkFEUnhUZmI1a2xMS053R21PSjdPVHJY?=
 =?utf-8?B?eUhmdTduMEtNRVFwM01FdGdGdGY4d2hyVUdMZVVXM1B0NDNDamIvcDJiZWpI?=
 =?utf-8?B?bmZrZ1NsNis3ZmRaaGhwcy9nUnpId0xQWFVMVy9DOXpkOU5rK1VIMnNhUXFH?=
 =?utf-8?B?RGhaT016VWNreWg2ei9mbUpGbFA5K0ZHSUFsamFNSjFQdTlyaGFjYmVVTFRE?=
 =?utf-8?B?cnhlNUNIcUF4MjZlTktUdU11djJUVm8zNVFCSnZSZENkRHBwQUFuTzB0c0F1?=
 =?utf-8?B?WUJpbWFHMzN4QW9mL1hMOUhPK1dzQTRvdEo2L0hLaCsyclo5TXJnUHJIMkJQ?=
 =?utf-8?B?NVlYL0o4RDBwRko0QjNlSGwzbUFoN0ZWem5WQ3hOM0lDbVVsZ0V6Yk1EdU9K?=
 =?utf-8?B?NmVYeUF0RXVjdHVFQVROa2dIWTJpMlBVcVliOXh1dkNUbW41TU91NC9Ha0kr?=
 =?utf-8?B?dGhlUmQzMWZIemo0UkFxMVk5Z3FxZWRSZ0RFUTVMRTg0ZUhPVjJmdTk1RXFF?=
 =?utf-8?B?aklaaEQxZkluZEI3OGFhWGEyZnlNdjg1bm15eSt4NkJmc3RDQUZqd1BmdnZI?=
 =?utf-8?B?dDFmQnQxaGt3azVTa0h6WW4vbGJUZHp6NXZPUTU3S05xWlZ3M1FFSU1aaERl?=
 =?utf-8?B?WmlubXpmZUJkNEhLVTd4ZDhoSFpiMXlpUHArUkszZzJkbWs2UXR3N3Vab3lw?=
 =?utf-8?B?dFMzenl6THlka3FoTGZqdWZQdjI3UVk5WkpRL2RxWDN0Q2M1QnVEaFAvZHlx?=
 =?utf-8?B?VFpRM2pqbkhkTmhqS1JZcjNaNkhuU1QveXdNZ04zN1ZucWhCaGZ3TGtBTnMx?=
 =?utf-8?B?YmJoQ3JCT0ZmT3g2YUd6YnNPQm9SQ0Z3dTlOZmptSENxYTR4c3NmQ2dFS2Fn?=
 =?utf-8?B?NHpiVTA3VURtbDB0aGwzUkNnMGx0OWRwVU1DNEhKZDQ5YVd3d3djN3FCdFpD?=
 =?utf-8?B?Wk1yaHhHWHhIOThWamlENVAwMHRhQm5LWHU1YXNsRVZ0TVdxSjV0aUZIY2RI?=
 =?utf-8?B?MHZUd0lxaTVoOFJON2cvRXRzOGJKTCtkL0R2eFo2bWhpMTlTRXo5N1BSSXcr?=
 =?utf-8?B?T25WSEZCMWRobzBTQTlWcWtxdzdxV1ZySG9OaXpsbzllT0IrMi9Ub3cwVVd4?=
 =?utf-8?B?K3ZVTFBKNU1KWXRQU3piTHJSaG5hSkJuTHNNZW9CTm9UT3JUdlNvUzVYWDhI?=
 =?utf-8?B?YklXNHYwL1NnZHA4WURVQVdUNXNteDdNSitFcVliSCtsekFMMEVwMFdKTGk5?=
 =?utf-8?B?bnZwMlQ4YitLSjd1VWRGQVgyODNsWVVqZ3YzbjVmeHVTditRa1ZkY3NwT0V3?=
 =?utf-8?B?WnRHTDMwc0tJZjVicURHakRBT2hpV3hOaVVHYnBzNTVTQ2VpaFNheXFEcTBy?=
 =?utf-8?B?QWNDYzNlZkU5SXlHMzNaa1VqcWh1bnQ4TmExS1h1cGlySzFsVFJUc3pYcGFw?=
 =?utf-8?B?dnh2eVNkZUhIMGRpTG1jeVloQUFiMXREUXhUQk5RR29tTGxKVE1WMzM3UE1K?=
 =?utf-8?B?ZXR1UVZDdWNFSHg1b3E4QUNpeWxDTk5pNm1xNVhtZGlQRzB3SEZyNWhsMDFS?=
 =?utf-8?B?NExOcG85NlZUNXg4R2U4ZE9Kc01SMXl3VUp4dEl6ODMwbFEwQTI2RERMMHVD?=
 =?utf-8?B?MTFJRWR3ZlBXS1RZbnpUQXdhbmNQamN1SGN1ZXJMZDNxV1orM1g1SGF5dUV4?=
 =?utf-8?B?VEREaE1CcUp6ZlUyZWRpTEZ6OHk5K2krYzFpWXloQTU2VkowQjM0eEFVaWht?=
 =?utf-8?B?YUkyRDZUUGZvZ0NuSStsS2RRR0lSbytrZUUzTDRBdHNycnFPeHFnOW43cmlV?=
 =?utf-8?B?aDBpVWVadXk4KzBLV3JlYnhkaXU0Rzh1cTcvcCtQV2NrZHgxQjNhd1EvRjdJ?=
 =?utf-8?B?VjBqRnhzcWFjdEp6OHYreFM5RFVEN0hzZVJaaEZ0dmZHTDhCOTVKbUo5UXZ4?=
 =?utf-8?B?aHVqTGpDc3dkSXJaQmhTSklOTER5VXF2WTR3SllPVGlualJyUExzM3BuS2JO?=
 =?utf-8?Q?n2F2tjnsH1C8vcQYUKGlGvSH/zBbsEhVM+nu3SOU0sI2y?=
X-MS-Exchange-AntiSpam-MessageData-1: 4OOAU+r96DY3+A==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea274edc-c69b-40be-8078-08de9207a5bb
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2026 05:04:27.9568 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ixj6XoBDv8GLOK70CMV3zxDX6PWhJtlZ/0E+WdtxaYNgAWAwYk77GGmEPXPF+YHL1kKs7eKkxEgD5u2qxdkkpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7513
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

`driver_read_area` and `driver_write_area` are internal methods that
return slices containing the area of the command queue buffer that the
driver has exclusive read or write access, respectively.

While their returned value is correct and safe to use, internally they
temporarily create a reference to the whole command-buffer slice,
including GSP-owned regions. These regions can change without notice,
and thus creating a slice to them, even if never accessed, is undefined
behavior.

Fix this by making these methods create slices to valid regions only.

Fixes: 75f6b1de8133 ("gpu: nova-core: gsp: Add GSP command queue bindings and handling")
Reported-by: Danilo Krummrich <dakr@kernel.org>
Closes: https://lore.kernel.org/all/DH47AVPEKN06.3BERUSJIB4M1R@kernel.org/
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
Since we are still getting `build_error`s on some configurations, this
revision reverts to building raw slices from computed ending indices.
---
Changes in v5:
- Eschew pointer projections with runtime-computed indices to avoid
  spurious `build_error`s.
- Drop `Reviewed-by` tags since the code has changed significantly.
- Link to v4: https://patch.msgid.link/20260401-cmdq-ub-fix-v4-0-a9a9cf982485@nvidia.com

Changes in v4:
- Make some methods providing the `ptr_project!` invariants inline.
- Use code paths that preserve the invariants `ptr_project!` depends on
  more obviously to fix these testbot build failures:
  - https://lore.kernel.org/all/202603280326.ucDKVaf2-lkp@intel.com/
  - https://lore.kernel.org/all/202603281331.1ESuqgfz-lkp@intel.com/
- Improve safety comment when creating the mutable slices (thanks Danilo!).
- Link to v3: https://patch.msgid.link/20260326-cmdq-ub-fix-v3-1-96af2148ca5c@nvidia.com

Changes in v3:
- Rebase on top of latest `drm-rust-next` (with `Coherent` patches).
- Use pointer projections. (thanks Gary!)
- Link to v2: https://patch.msgid.link/20260323-cmdq-ub-fix-v2-1-77d1213c3f7f@nvidia.com

Changes in v2:
- Use `u32_as_usize` consistently.
- Reduce the number of `unsafe` blocks by computing the end offset of
  the returned slices and creating them at the end, in one step.
- Take advantage of the fact that both slices have the same start index
  regardless of the branch chosen.
- Improve safety comments.
- Link to v1: https://patch.msgid.link/20260319-cmdq-ub-fix-v1-1-0f9f6e8f3ce3@nvidia.com
---
 drivers/gpu/nova-core/gsp/cmdq.rs | 116 +++++++++++++++++++++++---------------
 1 file changed, 69 insertions(+), 47 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index 2224896ccc89..569bb1a2501c 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -17,6 +17,7 @@
     },
     new_mutex,
     prelude::*,
+    ptr,
     sync::{
         aref::ARef,
         Mutex, //
@@ -255,37 +256,46 @@ fn new(dev: &device::Device<device::Bound>) -> Result<Self> {
     /// As the message queue is a circular buffer, the region may be discontiguous in memory. In
     /// that case the second slice will have a non-zero length.
     fn driver_write_area(&mut self) -> (&mut [[u8; GSP_PAGE_SIZE]], &mut [[u8; GSP_PAGE_SIZE]]) {
-        let tx = self.cpu_write_ptr() as usize;
-        let rx = self.gsp_read_ptr() as usize;
+        let tx = self.cpu_write_ptr();
+        let rx = self.gsp_read_ptr();
+
+        // Pointer to the first entry of the CPU message queue.
+        let data = ptr::project!(mut self.0.as_mut_ptr(), .cpuq.msgq.data[0]);
+
+        let (tail_end, wrap_end) = if rx == 0 {
+            // The write area is non-wrapping, and stops at the second-to-last entry of the command
+            // queue (to leave the last one empty).
+            (MSGQ_NUM_PAGES - 1, 0)
+        } else if rx <= tx {
+            // The write area wraps and continues until `rx - 1`.
+            (MSGQ_NUM_PAGES, rx - 1)
+        } else {
+            // The write area doesn't wrap and stops at `rx - 1`.
+            (rx - 1, 0)
+        };
 
         // SAFETY:
-        // - We will only access the driver-owned part of the shared memory.
-        // - Per the safety statement of the function, no concurrent access will be performed.
-        let gsp_mem = unsafe { &mut *self.0.as_mut() };
-        // PANIC: per the invariant of `cpu_write_ptr`, `tx` is `< MSGQ_NUM_PAGES`.
-        let (before_tx, after_tx) = gsp_mem.cpuq.msgq.data.split_at_mut(tx);
-
-        // The area starting at `tx` and ending at `rx - 2` modulo MSGQ_NUM_PAGES, inclusive,
-        // belongs to the driver for writing.
-
-        if rx == 0 {
-            // Since `rx` is zero, leave an empty slot at end of the buffer.
-            let last = after_tx.len() - 1;
-            (&mut after_tx[..last], &mut [])
-        } else if rx <= tx {
-            // The area is discontiguous and we leave an empty slot before `rx`.
-            // PANIC:
-            // - The index `rx - 1` is non-negative because `rx != 0` in this branch.
-            // - The index does not exceed `before_tx.len()` (which equals `tx`) because
-            //   `rx <= tx` in this branch.
-            (after_tx, &mut before_tx[..(rx - 1)])
-        } else {
-            // The area is contiguous and we leave an empty slot before `rx`.
-            // PANIC:
-            // - The index `rx - tx - 1` is non-negative because `rx > tx` in this branch.
-            // - The index does not exceed `after_tx.len()` (which is `MSGQ_NUM_PAGES - tx`)
-            //   because `rx < MSGQ_NUM_PAGES` by the `gsp_read_ptr` invariant.
-            (&mut after_tx[..(rx - tx - 1)], &mut [])
+        // - `data` was created from a valid pointer, and `rx` and `tx` are in the
+        //   `0..MSGQ_NUM_PAGES` range per the invariants of `cpu_write_ptr` and `gsp_read_ptr`,
+        //   thus the created slices are valid.
+        // - The area starting at `tx` and ending at `rx - 2` modulo `MSGQ_NUM_PAGES`,
+        //   inclusive, belongs to the driver for writing and is not accessed concurrently by
+        //   the GSP.
+        // - The caller holds a reference to `self` for as long as the returned slices are live,
+        //   meaning the CPU write pointer cannot be advanced and thus that the returned area
+        //   remains exclusive to the CPU for the duration of the slices.
+        // - The created slices point to non-overlapping sub-ranges of `data` in all
+        //   branches (in the `rx <= tx` case, the second slice ends at `rx - 1` which is strictly
+        //   less than `tx` where the first slice starts; in the other cases the second slice is
+        //   empty), so creating two `&mut` references from them does not violate aliasing rules.
+        unsafe {
+            (
+                core::slice::from_raw_parts_mut(
+                    data.add(num::u32_as_usize(tx)),
+                    num::u32_as_usize(tail_end - tx),
+                ),
+                core::slice::from_raw_parts_mut(data, num::u32_as_usize(wrap_end)),
+            )
         }
     }
 
@@ -308,26 +318,38 @@ fn driver_write_area_size(&self) -> usize {
     /// As the message queue is a circular buffer, the region may be discontiguous in memory. In
     /// that case the second slice will have a non-zero length.
     fn driver_read_area(&self) -> (&[[u8; GSP_PAGE_SIZE]], &[[u8; GSP_PAGE_SIZE]]) {
-        let tx = self.gsp_write_ptr() as usize;
-        let rx = self.cpu_read_ptr() as usize;
+        let tx = self.gsp_write_ptr();
+        let rx = self.cpu_read_ptr();
+
+        // Pointer to the first entry of the GSP message queue.
+        let data = ptr::project!(self.0.as_ptr(), .gspq.msgq.data[0]);
+
+        let (tail_end, wrap_end) = if rx <= tx {
+            // Read area is non-wrapping and stops right before `tx`.
+            (tx, 0)
+        } else {
+            // Read area is wrapping and stops right before `tx`.
+            (MSGQ_NUM_PAGES, tx)
+        };
 
         // SAFETY:
-        // - We will only access the driver-owned part of the shared memory.
-        // - Per the safety statement of the function, no concurrent access will be performed.
-        let gsp_mem = unsafe { &*self.0.as_ptr() };
-        let data = &gsp_mem.gspq.msgq.data;
-
-        // The area starting at `rx` and ending at `tx - 1` modulo MSGQ_NUM_PAGES, inclusive,
-        // belongs to the driver for reading.
-        // PANIC:
-        // - per the invariant of `cpu_read_ptr`, `rx < MSGQ_NUM_PAGES`
-        // - per the invariant of `gsp_write_ptr`, `tx < MSGQ_NUM_PAGES`
-        if rx <= tx {
-            // The area is contiguous.
-            (&data[rx..tx], &[])
-        } else {
-            // The area is discontiguous.
-            (&data[rx..], &data[..tx])
+        // - `data` was created from a valid pointer, and `rx` and `tx` are in the
+        //   `0..MSGQ_NUM_PAGES` range per the invariants of `gsp_write_ptr` and `cpu_read_ptr`,
+        //   thus the created slices are valid.
+        // - The area starting at `rx` and ending at `tx - 1` modulo `MSGQ_NUM_PAGES`,
+        //   inclusive, belongs to the driver for reading and is not accessed concurrently by
+        //   the GSP.
+        // - The caller holds a reference to `self` for as long as the returned slices are live,
+        //   meaning the CPU read pointer cannot be advanced and thus that the returned area
+        //   remains exclusive to the CPU for the duration of the slices.
+        unsafe {
+            (
+                core::slice::from_raw_parts(
+                    data.add(num::u32_as_usize(rx)),
+                    num::u32_as_usize(tail_end - rx),
+                ),
+                core::slice::from_raw_parts(data, num::u32_as_usize(wrap_end)),
+            )
         }
     }
 

---
base-commit: 7c50d748b4a635bc39802ea3f6b120e66b1b9067
change-id: 20260319-cmdq-ub-fix-d57b09a745b9

Best regards,
--  
Alexandre Courbot <acourbot@nvidia.com>

