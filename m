Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B769EFCD0C6
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 07:16:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2C9A10E6C2;
	Wed, 18 Mar 2026 07:16:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="uAVcfEcl";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010040.outbound.protection.outlook.com
 [52.101.193.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D808810E6B5
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 07:16:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lF64VeqFHBqHojHIu5F5jJb6Rb6dIXRSxDT6+P4pf15Nm1y8XKh5Nc6suNAU16r0wzQLb1TxQul9NjZO+H4UiVyC7+rS+9pFZH48MXWMjgHUyj6aHWlPMrb4+tIoUDiKtraDEHGM2V8itGkBQnVnxcVU8OinVf0Rr2QW6ydPtbKfnlQccIboPL9gcH6i0Dtcw+mFNkaojiFXCH/jZSBV5UzZcPXh6GhBDbhvcyHdazopBe+uTvAO6P2/adt+jV3JpaCJo/B8DDAG/9y+xKayUbABPQgJHFNHzhGAtzRqF0BdIU+OiwzU52tiTrn4+GZ8dWgrcYe2g7yhTixV2a28oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F2ir/IgzwC/n868pveS/9V/xqJaPiT9rl/CgBG+hXK4=;
 b=mIuADG/gHR/8LaPdxBQ53Z5wa6qJCdD7cKLmwl6mojPJodSWv2YWEOGhV+WOpvDsKmq1t6IrJZQfNvc7Aq6LyduRti9Cpswa+qLIcmKnEyjUy9MExxIRh+FC5p9M7TZg6dzU8tuhUB5QrBpQGHCOvuxnkemlxmGmOm3sQhEDDOaf6sz15G6rfZzkEi/QK9GEHvSeVZTAZpCxphlrYNYphg4ly0Mr2cZr0/B3660kZsDZgHOkXAfYSxjUkB05vIuVwqoZJvQwKvrtigJtZct+uJhpJBzxUZ0BwZY83D02bef5QIYAE7d+ud6CRg8YGixDshNurFPgFm/G5khpjq/e/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F2ir/IgzwC/n868pveS/9V/xqJaPiT9rl/CgBG+hXK4=;
 b=uAVcfEclseA9eTjFBdcze8RPpk3rXmogJlfT7zUcu/VBZG9d00pcA42xsmhdT9LWEM/cb3LyuBZLzy4FKi93oPv7MV9sfqLAFHK9E583AcAUxvj2vIoBzqRkee50Qdr6mz5AR+OCSIPkVw2m8vgmBpmEMWe20rcjGtULUVK0EfQ6Uy3vxh/AYX2+1QGe6NXLB3N6ks52Zp9P1/GWh0bZQy1fUOQz+nGTlWM3gNnxMvIB0AoFJhzaryD0E8rO1VYsXtUh3WrSlCky8e074+z6JGQ0rmJnL3bPk87eze/aBr1UCyAGo5x6AbB1UEnzlVuz7cR9YWCuROn5iz68YFpewg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by MN0PR12MB5764.namprd12.prod.outlook.com (2603:10b6:208:377::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Wed, 18 Mar
 2026 07:14:36 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9723.016; Wed, 18 Mar 2026
 07:14:36 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Subject: [PATCH v2 0/9] gpu: nova-core: gsp: add RM control command
 infrastructure
Date: Wed, 18 Mar 2026 16:13:56 +0900
Message-Id: <20260318-rmcontrol-v2-0-9a9fa6f1c4c3@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/02Py2rDMBBFf8VoXRW9rIcJJf9RstBjnIjGViM5o
 iX43ys7XWQxizsMZ859oAI5QkFD90AZaiwxzS2wtw75i53PgGNoGTHCJGGsx3nyaV5yumIXtCV
 y9NySgNr9d4Yx/uysz9MzZ7jdG3J5LpGzBbBP0xSXoQvUWCeYlsqC8lI70AKC6dU2lDlluFCKj
 xt6glLs7jJ0h12FU439FG74mvxXnM+49phgqh1XwEdDpDnONYZo39u/D7T5XGJZUv7dq1a6C/2
 3Ui+tKm0cLaXQILQ04ysHndZ1/QN2MBhwMwEAAA==
X-Change-ID: 20260225-rmcontrol-bd8a06fc3a0d
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Eliot Courtney <ecourtney@nvidia.com>, 
 Zhi Wang <zhiw@nvidia.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: TYCP286CA0104.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::20) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|MN0PR12MB5764:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d8c0304-9a63-4611-ce7e-08de84be02de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|10070799003|366016|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: agQS5m6gVh9TshOC0xUI7062ScbVbOus3C33aFUMd3pabPELevfxSbJEmC2E/bxE4bLCiY4SgdlDG5U8dATcODAIrpQexjNi4wrBEmY6V7jilyM8l+AGRwIC8olQeCGgSbUQbAWMj0B16kQg4daCXThkvZA8i34oa9PzGrIMK1lrVD1RflU0mYhBVJpFilD3rZmS9a9/nsdnWiqTTMjPY95EXhMcZOxSCYRAKhfHZDZzqDp5scNLlkpw1+M3T7Zz7LXf9kuZocnuAwVuQe2LQIIxg7bVvAaV67Fz1ys7sBfH1lLXrT7UziN0IaI3NpyBKq/ZxhGERgKcXOqt5vzqhWMQfPvdhqolwmNxcEJE15QTyr4sCP9VaUN3a7djGXQlJF3cWDW/MlGS3DrVmngCOLSCfJFxfgAM+a2dKiQbl7LmhtFMMIHVeFoxrOTEDWS+myvqxdH2e0C53Q7KnkNoMIBIfw7rsPnRW3OMH9TF+N3fj2BVOCSRJdeu0nB3IIE6MUSumPTYB7UDMXgR4CIEdcnvJonoVUzpzgYxiLBlZ0xvV5r9m2Nje+BBc/Sff2lJSmbcW/MRVmM9ufnqElddQ0R1p2W08BHDY7O9yAEhTMG0NvbTSboNG39RfDGopUgNKRueTWA7EFlE7nkeJv8vqBdHJQ0FDl3bxTPUkON5qGWbwrfetfdtSEFhtnrPuDdVyp+EAVBAzI7o4idxUZsED2T7uFuxdPA+01SK2IHjC7k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzVBVEh4cVBOdzIvelZrdHdjV3Rib25NMjJaeFhPbDNSWkpmemo4MmZYYm5y?=
 =?utf-8?B?WFV0c0VVM2N5dDhwTTJ4WVhYNzZDTTF2UHdsdTRkSkVoTHUrZVgvV1VFVFho?=
 =?utf-8?B?WUNWRzh4aThYZi9VdkgrMDZYV0NEZVhpbU5lcXh1ZEp6b2dBV05wK1lweGky?=
 =?utf-8?B?dW8vd3pjbGNWWmlXSDRBTlphbjNGSXY0Um1QWXFmTU1rbzRyU1RNTXAvOUJS?=
 =?utf-8?B?dmlYVCtCdzZwV0JBSFR1MHFQMW1aYmwybmRzNFNLbWlOR1JGc2JaNXFqZkpD?=
 =?utf-8?B?RlRlNm13V3lMTitGTnlic0xhRy9IaUNpV3BMaVBPM1VIYVJCUmkzZHg1N1dY?=
 =?utf-8?B?VmNnRngyd2w1alE0SzNNVFRMZisxY1NMd1RHZk9aT2ptbjV1bmt6SWxLVm9G?=
 =?utf-8?B?UHQzNDAwWnMzQU5KczlDUzRINGIrZ0ttOUhydGFxNDFZUzJQNm5xY29Denhy?=
 =?utf-8?B?M1RabEdwUml5N21Ebng1aXE2QlhtNGNpTTVycEJoQnFSR3RlTTNjZ1lKMWl6?=
 =?utf-8?B?a0U4aVl0R25UTDJxRkZaQ013czZUQVZMRm5QRnlleXJ4dTUyVWluMnRacjdC?=
 =?utf-8?B?ME1hUVBacUNCSjhHemR0eTB1OEduUzQ0ckpFMy8rN1F3MzdWS3dTWnBMZE9z?=
 =?utf-8?B?R2hwdndaMG1PWUhxWDJSb1lCRXdXYTNLK1VEaEpNRjVzVDFPZkJKRHhwNEM0?=
 =?utf-8?B?SG9IT09ZcFpOOG1ZQ2s0ZlZmdlB3b1kxV0FxRUc2V216YkxWT290Z3lNMlhS?=
 =?utf-8?B?WFJwNlRsVzkyUWFSQ2ZadlBkVDEwdEdyOWgxWkdMRFhjZjlLRzB0amJoMFls?=
 =?utf-8?B?WXoxdmY1ZjBSb3BkQXY1eHRNdHhITDlYRktSSHZDM3NjQ3ZjVmo3S0YwT1Vr?=
 =?utf-8?B?SUFIdEg5M0JrdmtOSWcvUFJlaE5remtWWnpaOGNOVy9jL1dBckE0V0liR0dt?=
 =?utf-8?B?K01weko3R3dRckZhYTkwOVFTVWpTdnhocG9kNTJpNlYvM3ZuU01ZVEVMejhy?=
 =?utf-8?B?TDBocmNHUW12aFdxZGxPdXBPOEsxbVh1cERVb290cUluZFNLdWZQNXVNR0Ir?=
 =?utf-8?B?NHJCZzRlbHY0UGlxOU0xVHAvZ0Z1MEJnMzlTWnlvb3g0aVprODFaOVIrSE4w?=
 =?utf-8?B?WGF1YlpTMytKRlJKbDE1NEo4cS83MzFLUWtOZEd3c295VC9DQnZNenhpMzI0?=
 =?utf-8?B?WE4xdThsMnUxNktrdzdQcml3Y2gvbVZ1TDIrTm1wdTUwM0lwNm5FRlRTUThn?=
 =?utf-8?B?dXhsejVaTkVmeTBKUjdWUzBzWVc1R1NORzk1TzJmRGNRNUg2WDFtZm5yZGJM?=
 =?utf-8?B?VVBBNTdnMlZIZkk4NmN2Ti9DYXJIUHFUOTJwOFgxcE5GQzQyQlI0eldCbkZx?=
 =?utf-8?B?d3A2dkFCa0xQKzVLcmlWWnV5Z1F0MjhiWmdxNGp5bkw5eGlOY2lQa2IyQTU2?=
 =?utf-8?B?eG5wWEdMV2Q4NStidWlKMEMzY254ZUFZbEpEdUV1L1l5ZjRJempIRFE4eC9o?=
 =?utf-8?B?eFZRVzVzYThlRFlBdGRMRFhXKzJzTkxiTnBTWC9TNHJQUnhUdkFhTzkvWmFV?=
 =?utf-8?B?YTMwNzhsRnVuNTRhTHNnSE1wbXROTHFRTC85NldCdmxwby9mM0RXOTVlUHhL?=
 =?utf-8?B?eDVUSElnb0FydWhwQ1o0cUdwUzV6eUNWWFRjSS9MbDNmeWMrRFl0alB5VEdT?=
 =?utf-8?B?U2R0ZVJ0YW1KWVV1UUdiWFpIOHVuMFhnNWI2QUI1Lzk5eGdkdFltYVNIMms4?=
 =?utf-8?B?cS9pREErcjJjYW9JZzVTV3RGbTFWbHZvRW5ZZDlUd1B6N2RPak1pa1BGRFZY?=
 =?utf-8?B?M0RIR20xbmFpcWQrRGVBK3lmcjV0OUVWbXkvZ0h1Y0p2ejJ1V3V2aUR0ODBR?=
 =?utf-8?B?ei8vVHhwNVd4TFU1bUJJbHVyUGgvTUFUSlB1SmdXRWc0UHNndUpxdFBmcDJr?=
 =?utf-8?B?bytHMmMxbllHNWZrZ1ExZFhScWRidFlRcThDeXJWUEFvaDBaUWVpT29XTzZp?=
 =?utf-8?B?Yjk3UDBYSnc2ejU4djVueU1FNnVCMjlWS2VVL1l5QzZlWDN3Vmk2eHlQV2Ns?=
 =?utf-8?B?aU5lR2REUEZ2dkozbGk2T0lpMjlXY1Y2U0NvQ2dtcjN0TUNrV2pLcGJGSm1V?=
 =?utf-8?B?bnlZZkRwZEhEQ1JNemtrdHoydGZLUFhqMmlVenUwVTlEQWw0VWRBMHVLNk5K?=
 =?utf-8?B?djhTd01zbDhmc2E3ZGZJaUcwRTNCSkxudjNyVm1PSktxYnE2c01IRlhZRllC?=
 =?utf-8?B?WVE5dXRZdG1xbVAxdXdMRFJ2bGQzQ2RiYTlKR2E2UlgxL2Q0MFc4M3kwUWsx?=
 =?utf-8?B?Q3V1d3pmL0JRMFlib1NkTjNkb1ZYVzJTSzhwa3JtdWhqbWhHdVVUcWl0NExN?=
 =?utf-8?Q?Y6CvEFxUG+jvW+Xw8mkiW+YQC2t5GjUt0sGGfy/F5jzOE?=
X-MS-Exchange-AntiSpam-MessageData-1: LT+9U6N9oaYu2A==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d8c0304-9a63-4611-ce7e-08de84be02de
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 07:14:36.3191 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cDZgZ//DLM8pBZDlNg7o46GyibF6eCwXVuk7rLvQK84jfIWnDS2fzy60vT+pVZNUzakH3FXS4bw9PoNh/hhLxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5764
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
- A `send_rm_control` helper that sends a control and checks its
  NvStatus
- One usage of `send_rm_control`: the `CeGetFaultMethodBufferSize`
  RPC. This is useful for channel allocation later.

Each new RM control command can be added by extending
`RmControlMsgFunction`, adding the bindings and wrappers for their
parameters, and writing a type-safe wrapper to send and receive the
reply for the RM control rpc, using `send_rm_control`.

This series applies on latest drm-rust-next with the listed
pre-requisites.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
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
      gpu: nova-core: gsp: add CeGetFaultMethodBufferSize RM control command

 drivers/gpu/nova-core/gsp.rs                      |   1 +
 drivers/gpu/nova-core/gsp/commands.rs             |  64 ++++
 drivers/gpu/nova-core/gsp/fw.rs                   | 402 ++++++++++++++++++++++
 drivers/gpu/nova-core/gsp/fw/commands.rs          |  19 +-
 drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs | 161 +++++++++
 drivers/gpu/nova-core/gsp/fw/rm.rs                | 103 ++++++
 drivers/gpu/nova-core/gsp/rm.rs                   |   3 +
 drivers/gpu/nova-core/gsp/rm/commands.rs          | 147 ++++++++
 drivers/gpu/nova-core/gsp/sequencer.rs            |   4 +-
 drivers/gpu/nova-core/sbuffer.rs                  |   6 +-
 10 files changed, 904 insertions(+), 6 deletions(-)
---
base-commit: d19ab42867ae7c68be84ed957d95712b7934773f
change-id: 20260225-rmcontrol-bd8a06fc3a0d
prerequisite-message-id: <20260318-cmdq-locking-v5-0-18b37e3f9069@nvidia.com>
prerequisite-patch-id: fefd403caf8af386276351dd12397dda8ae8553f
prerequisite-patch-id: 3e02192944c4dde97e6895a28371479aa49ddc96
prerequisite-patch-id: 0d4f54098125ee748489a7fcf2ec8ddaf2040bb6
prerequisite-patch-id: 45041e4ac74e3ea76ea8dd0632e7746418bdf822
prerequisite-patch-id: 0506bfdd3d8bb9c6efe7fc9246fc3695f8ffc338

Best regards,
-- 
Eliot Courtney <ecourtney@nvidia.com>

