Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA749FCD0C5
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 07:17:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C46A10E6CD;
	Wed, 18 Mar 2026 07:17:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="AKPwnoUf";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010032.outbound.protection.outlook.com
 [52.101.193.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 737E910E6CD
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 07:17:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VZwaxe37eZJzrem/xRHwVvruq9if46KgMbONy3QTQNnrX0wK0EXllJnZjWNw0PeEpjyudlKMdIFFJTxmKQZo6ss4/ThgvJum5LA6JcfcWP8R4cKYWb9Bn0zhswYuJdUXpjsHkMKxjX6xcpMsHrHXBZcZfirchmcBguLbV5S+gGHw2u8oW6V+MaQ4lTfauA2FFoAtRw2f7EZnEypoHgjDpSBGXijMM+YCkTAku71cvbN/p8hsInBwHVa7Fm90zvTdzmhzPN9sjztmcRO0yaRsBOGQ0XtgdDB4HbjGztfuVssdujB/uDCetIsLB1FTJ+h/fX45rt4uR1n7SB0rHBPyZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tClHci7fxYft/7PmokBkFk1eAC7nNgP4dW+aJP6036Q=;
 b=Ffd1yAUzn/1xVpm4LzzuIr/moKUkQqVnCWxDJScW+7TMBSgShqTpWKUplYsGIunMGuwF1P3Qvix5BOEuvexM5cQy40Wqq3or57jBk4sTpS2QHlXnlVCct4n83LLt0M8HFu5O45kw574hTt8TyDsO9HN9A2bbQbReZmL6vAp/7GTAL2dEZgcU7fF4amyhMk41NUUv0CTPyQlncFg8PbG2JSOaXwUWBWjoPBwnyE+L4poYa9T487m3zBktmk0uSIpkyAdYW6KI5VJ9o0VVsdvGnWckradchvtAPcY3zL2n1P1aHvfKJ+jaXBLxtv+zbbk2ytlAJADquObLUQwpLq6wDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tClHci7fxYft/7PmokBkFk1eAC7nNgP4dW+aJP6036Q=;
 b=AKPwnoUfE8WJ3jf5D0UreOGd8SrhrohGCjwBshlmf/XlefRd4ujhrxZtIoLj0AcJ4TOhtMNlgq1MuuzEaS4S5gn9d34wDrWaLqj8j1i2aPoml1t3vwo+zbxqg9z/kpbTrRK+/MWc5eANmgRQbC4WS9SzoR63DthXwLavmRP27K3BG5qLbp1i3HmguQDa0W1R8d+XrQAuiGqvaonRYHvwrM2NV4/71v+Gm5/HiN9e5KvUUDKGDjhyJZXdXsf8IBRcFCNu3luZq9NVGmG7eFGiKZ9EroMRH7Z42u5S+Tw1IdIAnwfKmPTKzAllakoIeEIp4c2qHyDm9F0vt5AgBOG7kw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by MN0PR12MB5764.namprd12.prod.outlook.com (2603:10b6:208:377::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Wed, 18 Mar
 2026 07:14:43 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9723.016; Wed, 18 Mar 2026
 07:14:43 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Wed, 18 Mar 2026 16:13:58 +0900
Subject: [PATCH v2 2/9] gpu: nova-core: gsp: add NvStatus enum for RM
 control errors
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260318-rmcontrol-v2-2-9a9fa6f1c4c3@nvidia.com>
References: <20260318-rmcontrol-v2-0-9a9fa6f1c4c3@nvidia.com>
In-Reply-To: <20260318-rmcontrol-v2-0-9a9fa6f1c4c3@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SJ0PR05CA0048.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::23) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|MN0PR12MB5764:EE_
X-MS-Office365-Filtering-Correlation-Id: 822e6320-c914-470f-40f6-08de84be0740
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|10070799003|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: nGJtPYYUOW4uz3DiAc3nt3kY/J+LRtuX9Wa+v/kuyc/b8TOkdyjmUJqc7N+MAPWmG5KXOgewUOlo63DRyGOyeiWXxOiREKVWlsLixNXtzF03gzSVatELS9H6M54DxLIMoEx98OE2cSjMb+zSwNhlc1Cn8nLvWRWYMhdnzTnQVrsC+GcSatDhryAjnLCaqyCJaoiEV+otmfVAHt1+9153nSr7QkeeszjBa8pj08kYtzBvJSjyECeUZM6a/4bubMeeAU/mWZGEH9ocPDybpW+JwXr1CqPN0iWDt1uWUQ3bta88vHaKVOTuXv+07B0PuI0pfJu8quADbLOaCPLCf0VnyakH7ow8qemuaSfgWpACXXLv8kdsOIj8RAnRovxpV6gL8e7nOkHJCGKJwqVjyEy/w2Sxze/bcaRmZimq1EsvOOX71AMgGosofscTJI2j2tAxFTwdey2nuu61CKt7AUZJUvGSGa69kpGOkImhJUyPndeyYksiuCb4BqT8dt9Mw16yleA4jPjUSs99ewd9Hl7Bp/DOUpfD7V3rwyZ3NQC8veEC/GOjcwbl/gNYzKwYRky92S8Bfnf7j3YjaOP7hWn8AVOHcoyCcJssDvCZy2i0IInwRVrZxHAPsUfdfv85rtSozqAL5pdeBcyL41mGiCOC0+1GPlXgxyXwkbISbMz7SUO5fqVzf1NNIH/e9D48mdO1gFzHg8sB0pX7RbD1vgtIGza/vOFbcVakMWtwGVGDlWo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkszNlBwU1U1cnlYOW9xMGtzcHR6TTUwcmZJekFnSnFGYkJRQURrL2RxNGFv?=
 =?utf-8?B?eU1EZ1JLczRYVnpDNWZzbklHRWN0Y2JSZjBPcGNTdEM5ZlhCQ1FmQTFLZVVR?=
 =?utf-8?B?bjhuWjkyTDh5RFFabUZOaUxXWTB3b3NGTTU1bDhUOTcrQU5XY3dUazJqVUtx?=
 =?utf-8?B?RHU0NWNEeUt0dVFSb1UwSlN6NGljUjRSRDlnYUVETXNLanRoZXJZazNxWm1i?=
 =?utf-8?B?NFc5eXlUQXE4Tjl0RWtQK21UVzh0TUhlalRqUk1UbHhXMFR1UWVxUUpueit3?=
 =?utf-8?B?MXRPSmtLdGhHeE5Oc2lqcnd2a1BPZTZXclh0Z3cvNkpvMU5jUnZQem01bWxK?=
 =?utf-8?B?bnA3SHUzeXdNakdSWi9GOEhLUlBpTzJmMld1MXl0dEQ3c3NMVkhESjNnQ3FE?=
 =?utf-8?B?YXZDaFFodDdlUnNBZ1RKYkkzUVFBOElmS28zTktYM0dPMk56QUxVTzR3NTlz?=
 =?utf-8?B?MWFKQkJ4aHB5SG50Ull4S2JmNnhYbFE2ZURwS1QxdS9saWlWYURCdWVYMjFZ?=
 =?utf-8?B?eXJkMXdWWlVvVytsaUxCb1JnRFJEVEw3K3RGM25IKzBOeThyV3VWcTRCdUFh?=
 =?utf-8?B?aGhCcXZFQlBmVGVBd2Znd1JqYW5WQVZMR2tBUnV4amluMWxHUTlLWk81dFV2?=
 =?utf-8?B?b2xtK1Qwb1pIRUVFcEVnUWJ1bWMxYUw4Q1BtYitCUlFNaDBtbGRkTzNGR1Jr?=
 =?utf-8?B?OGlYdkRWcFZiT1I1bHRvMEQwdFhmNTVmUG94a3h0M011YUJLS1NoNzhNem54?=
 =?utf-8?B?NEhwUUhOZjIwTzgxWVBsNHJTN3ZQM1lLWUk3dlJuNmhXS3NXVVRHUURVMm1z?=
 =?utf-8?B?THNLUVBhd2NiVnZaRXFMektidGxzS1gwVEt5ZDN4eDhhc2Q2RjNycm1WdC84?=
 =?utf-8?B?T09QU3plbFVYbGZnYzhxakh1bndLNzRBY01tR3FYVS83K25NaEE5TjFOc25X?=
 =?utf-8?B?RW5qSDZyQnl3eFR1NkxlUGxoZlRoTzgxQWZYTGtPY3AwbUZpcHRWK2tCeVZ6?=
 =?utf-8?B?M09rVFM1M0ZUSUFETHgwcWlSS0ZlbEJ1c3QzYzllV25jQThQSVZoZkRyYTR6?=
 =?utf-8?B?ak14UDlORG0wOGl0UlBVc0xrZ1QwK3VQQjVLVDJvY1lja2hSZEExMWtNclZq?=
 =?utf-8?B?ejlWOWRYODc5MVFxNnBrVVJTT2NpSUR1RnQwZHJ5ME54cVQ5cGQweU1rbzlu?=
 =?utf-8?B?eE9hZ1FScHdVU3hvekxjQ0xsQzcxakdmb1Y3eExObVFaNktZbFc0YVJqd0Mw?=
 =?utf-8?B?Y1lwSFFnY3J4TzJhUlhwV01NMlZNcytKd1RQRVVwQ2xrRXZsQjQ5K2VVdzlN?=
 =?utf-8?B?cmdIMmt0RFBaZTdMZzZpZ0lUeVBFbTFGdTJLVWh2a1lkd3RDeTVQZGYwRFdP?=
 =?utf-8?B?RnJ2bnhkbTJXekRtYzFha1RzTXRoeS9NY04rOGdnaHUyU2luQUtQZk1VNlNs?=
 =?utf-8?B?NjNOWEhyN3FKSTVyZDRLVVJ4RHg0RG5vcTRmbThkTmtvSDh4THpoc0F1SnNL?=
 =?utf-8?B?dmJkSENOa1BscVhSTytuMWhEbHA5cmYyT05lWTBJV2c0Y2ZnRnE0U0JvWDFq?=
 =?utf-8?B?dmdEbmFTbFhTeXdKczVFcm82NFZWRVNTeFAyMHlmYjlmQnZCdWlGZTVsaDgr?=
 =?utf-8?B?Uk9ZZU4xQ2ZnK2pDajdUd2d1Q3JQa204cytXamJxMGRiZUxtdjdLYmZCUlhG?=
 =?utf-8?B?MjNjTWdVaEpjRlhLTU5nU1liZC8yUFcrUDJsOXNITkgxT2M1RkFOaUdaRFVa?=
 =?utf-8?B?TmZyVFc0QXA3MXMzYkMwZkhkeDBVQVlqTk1jK2s0dHZzZlhGaktTODhIZi9L?=
 =?utf-8?B?VUJwYUFlU2Q4YlBRenMzcFUrbDNTYko2anVvZ0VhQ1c2QUVMV1lobjQvaXF0?=
 =?utf-8?B?TE1hejFUcXRMMEoxZGE4alVYT3VYRzlETmZyYVNFTkJUdGIxdStxUkF4SElB?=
 =?utf-8?B?YVIrZFlla1M1U09YeERtVVRvMDB0ZU5Tcml4OEgzTHpkSVgwek0ycmc4cmdn?=
 =?utf-8?B?TFFqUkNudmZmTWxjMG9Ma0NRVUZzVzJJRXV5VUcrdE9OekZOUER0Z0IvS3ND?=
 =?utf-8?B?d3RybUtxSHkvelZzSDMwbjcwbjBYc1FHWWh4YiswWVlodzVrUmhlYUtHd0Fs?=
 =?utf-8?B?eHJVTkxwMDRBa21sZE5LN3VUNlpMY2cyR2RSKzdpdjY5bVA3dlA3UThtQk9C?=
 =?utf-8?B?ejc5a0dKMEdyS0JhQ2dXMmZTcjlQdXgzc1N0OWtRYjZCMXlEc3J2K0tjNlhF?=
 =?utf-8?B?dzBtd0wyNFNHVEFOblBSU2FwRDB1WXVZb3FaZFI1QzNsVEx3Y1VaWnZ0Z2k3?=
 =?utf-8?B?SlNyMXA2dEdEeUUyRi9vOXdKYVJEY3l5MjZvZllZWnlXZ05wMnpIelM3RVJL?=
 =?utf-8?Q?d0Cp9v7EsGMWGciJrBkxv53UwZQuhgNS5phtmmEKVDZ9G?=
X-MS-Exchange-AntiSpam-MessageData-1: wp3g4ZknM4f5Lg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 822e6320-c914-470f-40f6-08de84be0740
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 07:14:43.6020 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: apoOCO8BFjINWVW0Q6b7p+8d0SJ68RRQBAWgHaSZsfDDnQOwnoTfFjuToCAFJ77a0CA7VHC2QZlQdmutF8xRCQ==
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

Add NvStatus enum that wraps the raw NV_STATUS u32 codes returned by RM
control RPCs.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gsp/fw.rs | 401 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 401 insertions(+)

diff --git a/drivers/gpu/nova-core/gsp/fw.rs b/drivers/gpu/nova-core/gsp/fw.rs
index a061131b5412..37831034ec3e 100644
--- a/drivers/gpu/nova-core/gsp/fw.rs
+++ b/drivers/gpu/nova-core/gsp/fw.rs
@@ -112,6 +112,407 @@ pub(in crate::gsp) fn advance_cpu_write_ptr(qs: &CoherentAllocation<GspMem>, cou
 pub(crate) const GSP_MSG_QUEUE_ELEMENT_SIZE_MAX: usize =
     num::u32_as_usize(bindings::GSP_MSG_QUEUE_ELEMENT_SIZE_MAX);
 
+/// Status code returned by GSP-RM RPCs.
+#[derive(Copy, Clone, Debug, PartialEq, Eq)]
+pub(crate) enum NvStatus {
+    Ok,
+    AlreadySignalled,
+    BrokenFb,
+    BufferTooSmall,
+    BusyRetry,
+    CallbackNotScheduled,
+    CardNotPresent,
+    CycleDetected,
+    DmaInUse,
+    DmaMemNotLocked,
+    DmaMemNotUnlocked,
+    DualLinkInuse,
+    EccError,
+    FabricManagerNotPresent,
+    FatalError,
+    FeatureNotEnabled,
+    FifoBadAccess,
+    FlcnError,
+    FreqNotSupported,
+    Generic,
+    GpuDmaNotInitialized,
+    GpuInDebugMode,
+    GpuInFullchipReset,
+    GpuIsLost,
+    GpuMemoryOnliningFailure,
+    GpuNotFullPower,
+    GpuUuidNotFound,
+    HotSwitch,
+    I2cError,
+    I2cSpeedTooHigh,
+    IllegalAction,
+    InUse,
+    InflateCompressedDataFailed,
+    InsertDuplicateName,
+    InsufficientPermissions,
+    InsufficientPower,
+    InsufficientResources,
+    InsufficientZbcEntry,
+    InvalidAccessType,
+    InvalidAddress,
+    InvalidArgument,
+    InvalidBase,
+    InvalidChannel,
+    InvalidClass,
+    InvalidClient,
+    InvalidCommand,
+    InvalidData,
+    InvalidDevice,
+    InvalidDmaSpecifier,
+    InvalidEvent,
+    InvalidFlags,
+    InvalidFunction,
+    InvalidHeap,
+    InvalidIndex,
+    InvalidIrqLevel,
+    InvalidLicense,
+    InvalidLimit,
+    InvalidLockState,
+    InvalidMethod,
+    InvalidObject,
+    InvalidObjectBuffer,
+    InvalidObjectHandle,
+    InvalidObjectNew,
+    InvalidObjectOld,
+    InvalidObjectParent,
+    InvalidOffset,
+    InvalidOperation,
+    InvalidOwner,
+    InvalidParamStruct,
+    InvalidParameter,
+    InvalidPath,
+    InvalidPointer,
+    InvalidRead,
+    InvalidRegistryKey,
+    InvalidRequest,
+    InvalidState,
+    InvalidStringLength,
+    InvalidWrite,
+    InvalidXlate,
+    IrqEdgeTriggered,
+    IrqNotFiring,
+    KeyRotationInProgress,
+    LibRmVersionMismatch,
+    MaxSessionLimitReached,
+    MemoryError,
+    MemoryTrainingFailed,
+    MismatchedSlave,
+    MismatchedTarget,
+    MissingTableEntry,
+    ModuleLoadFailed,
+    MoreDataAvailable,
+    MoreProcessingRequired,
+    MultipleMemoryTypes,
+    NoFreeFifos,
+    NoIntrPending,
+    NoMemory,
+    NoSuchDomain,
+    NoValidPath,
+    NotCompatible,
+    NotReady,
+    NotSupported,
+    NvlinkClockError,
+    NvlinkConfigurationError,
+    NvlinkFabricFailure,
+    NvlinkFabricNotReady,
+    NvlinkInitError,
+    NvlinkMinionError,
+    NvlinkTrainingError,
+    ObjectNotFound,
+    ObjectTypeMismatch,
+    OperatingSystem,
+    OtherDeviceFound,
+    OutOfRange,
+    OverlappingUvmCommit,
+    PageTableNotAvail,
+    PidNotFound,
+    PmuNotReady,
+    PrivSecViolation,
+    ProtectionFault,
+    QueueTaskSlotNotAvailable,
+    RcError,
+    ReductionManagerNotAvailable,
+    RejectedVbios,
+    ResetRequired,
+    ResourceLost,
+    ResourceRetirementError,
+    RiscvError,
+    SecureBootFailed,
+    SignalPending,
+    StateInUse,
+    TestOnlyCodeNotEnabled,
+    Timeout,
+    TimeoutRetry,
+    TooManyPrimaries,
+    UvmAddressInUse,
+    Unknown(u32),
+}
+
+impl From<NvStatus> for Result {
+    fn from(status: NvStatus) -> Self {
+        match status {
+            NvStatus::Ok => Ok(()),
+
+            NvStatus::BufferTooSmall | NvStatus::MoreDataAvailable => Err(EMSGSIZE),
+
+            NvStatus::BusyRetry
+            | NvStatus::DmaInUse
+            | NvStatus::DualLinkInuse
+            | NvStatus::GpuInFullchipReset
+            | NvStatus::InUse
+            | NvStatus::KeyRotationInProgress
+            | NvStatus::NotReady
+            | NvStatus::NvlinkFabricNotReady
+            | NvStatus::PmuNotReady
+            | NvStatus::StateInUse
+            | NvStatus::UvmAddressInUse => Err(EBUSY),
+
+            NvStatus::CardNotPresent
+            | NvStatus::FabricManagerNotPresent
+            | NvStatus::InvalidDevice
+            | NvStatus::ReductionManagerNotAvailable => Err(ENODEV),
+
+            NvStatus::FeatureNotEnabled
+            | NvStatus::FreqNotSupported
+            | NvStatus::NotSupported
+            | NvStatus::TestOnlyCodeNotEnabled => Err(ENOTSUPP),
+
+            NvStatus::GpuUuidNotFound
+            | NvStatus::MissingTableEntry
+            | NvStatus::NoSuchDomain
+            | NvStatus::NoValidPath
+            | NvStatus::ObjectNotFound => Err(ENOENT),
+
+            NvStatus::I2cSpeedTooHigh
+            | NvStatus::InvalidAccessType
+            | NvStatus::InvalidArgument
+            | NvStatus::InvalidBase
+            | NvStatus::InvalidChannel
+            | NvStatus::InvalidClass
+            | NvStatus::InvalidClient
+            | NvStatus::InvalidCommand
+            | NvStatus::InvalidData
+            | NvStatus::InvalidDmaSpecifier
+            | NvStatus::InvalidEvent
+            | NvStatus::InvalidFlags
+            | NvStatus::InvalidFunction
+            | NvStatus::InvalidHeap
+            | NvStatus::InvalidIndex
+            | NvStatus::InvalidIrqLevel
+            | NvStatus::InvalidLimit
+            | NvStatus::InvalidLockState
+            | NvStatus::InvalidMethod
+            | NvStatus::InvalidObject
+            | NvStatus::InvalidObjectBuffer
+            | NvStatus::InvalidObjectHandle
+            | NvStatus::InvalidObjectNew
+            | NvStatus::InvalidObjectOld
+            | NvStatus::InvalidObjectParent
+            | NvStatus::InvalidOffset
+            | NvStatus::InvalidOperation
+            | NvStatus::InvalidOwner
+            | NvStatus::InvalidParamStruct
+            | NvStatus::InvalidParameter
+            | NvStatus::InvalidPath
+            | NvStatus::InvalidRegistryKey
+            | NvStatus::InvalidRequest
+            | NvStatus::InvalidState
+            | NvStatus::InvalidStringLength
+            | NvStatus::InvalidXlate
+            | NvStatus::LibRmVersionMismatch
+            | NvStatus::MismatchedSlave
+            | NvStatus::MismatchedTarget
+            | NvStatus::MultipleMemoryTypes
+            | NvStatus::NotCompatible
+            | NvStatus::ObjectTypeMismatch
+            | NvStatus::OverlappingUvmCommit
+            | NvStatus::RejectedVbios => Err(EINVAL),
+
+            NvStatus::IllegalAction => Err(EPERM),
+
+            NvStatus::InsertDuplicateName => Err(EEXIST),
+
+            NvStatus::InsufficientPermissions
+            | NvStatus::InvalidLicense
+            | NvStatus::PrivSecViolation => Err(EACCES),
+
+            NvStatus::InsufficientResources | NvStatus::NoMemory | NvStatus::PageTableNotAvail => {
+                Err(ENOMEM)
+            }
+
+            NvStatus::InsufficientZbcEntry
+            | NvStatus::MaxSessionLimitReached
+            | NvStatus::NoFreeFifos
+            | NvStatus::QueueTaskSlotNotAvailable
+            | NvStatus::TooManyPrimaries => Err(ENOSPC),
+
+            NvStatus::InvalidAddress | NvStatus::InvalidPointer | NvStatus::ProtectionFault => {
+                Err(EFAULT)
+            }
+
+            NvStatus::MoreProcessingRequired | NvStatus::TimeoutRetry => Err(EAGAIN),
+
+            NvStatus::OutOfRange => Err(ERANGE),
+
+            NvStatus::PidNotFound => Err(ESRCH),
+
+            NvStatus::SignalPending => Err(EINTR),
+
+            NvStatus::Timeout => Err(ETIMEDOUT),
+
+            _ => Err(EIO),
+        }
+    }
+}
+
+impl From<u32> for NvStatus {
+    fn from(value: u32) -> Self {
+        match value {
+            bindings::NV_OK => Self::Ok,
+            bindings::NV_ERR_ALREADY_SIGNALLED => Self::AlreadySignalled,
+            bindings::NV_ERR_BROKEN_FB => Self::BrokenFb,
+            bindings::NV_ERR_BUFFER_TOO_SMALL => Self::BufferTooSmall,
+            bindings::NV_ERR_BUSY_RETRY => Self::BusyRetry,
+            bindings::NV_ERR_CALLBACK_NOT_SCHEDULED => Self::CallbackNotScheduled,
+            bindings::NV_ERR_CARD_NOT_PRESENT => Self::CardNotPresent,
+            bindings::NV_ERR_CYCLE_DETECTED => Self::CycleDetected,
+            bindings::NV_ERR_DMA_IN_USE => Self::DmaInUse,
+            bindings::NV_ERR_DMA_MEM_NOT_LOCKED => Self::DmaMemNotLocked,
+            bindings::NV_ERR_DMA_MEM_NOT_UNLOCKED => Self::DmaMemNotUnlocked,
+            bindings::NV_ERR_DUAL_LINK_INUSE => Self::DualLinkInuse,
+            bindings::NV_ERR_ECC_ERROR => Self::EccError,
+            bindings::NV_ERR_FABRIC_MANAGER_NOT_PRESENT => Self::FabricManagerNotPresent,
+            bindings::NV_ERR_FATAL_ERROR => Self::FatalError,
+            bindings::NV_ERR_FEATURE_NOT_ENABLED => Self::FeatureNotEnabled,
+            bindings::NV_ERR_FIFO_BAD_ACCESS => Self::FifoBadAccess,
+            bindings::NV_ERR_FLCN_ERROR => Self::FlcnError,
+            bindings::NV_ERR_FREQ_NOT_SUPPORTED => Self::FreqNotSupported,
+            bindings::NV_ERR_GENERIC => Self::Generic,
+            bindings::NV_ERR_GPU_DMA_NOT_INITIALIZED => Self::GpuDmaNotInitialized,
+            bindings::NV_ERR_GPU_IN_DEBUG_MODE => Self::GpuInDebugMode,
+            bindings::NV_ERR_GPU_IN_FULLCHIP_RESET => Self::GpuInFullchipReset,
+            bindings::NV_ERR_GPU_IS_LOST => Self::GpuIsLost,
+            bindings::NV_ERR_GPU_MEMORY_ONLINING_FAILURE => Self::GpuMemoryOnliningFailure,
+            bindings::NV_ERR_GPU_NOT_FULL_POWER => Self::GpuNotFullPower,
+            bindings::NV_ERR_GPU_UUID_NOT_FOUND => Self::GpuUuidNotFound,
+            bindings::NV_ERR_HOT_SWITCH => Self::HotSwitch,
+            bindings::NV_ERR_I2C_ERROR => Self::I2cError,
+            bindings::NV_ERR_I2C_SPEED_TOO_HIGH => Self::I2cSpeedTooHigh,
+            bindings::NV_ERR_ILLEGAL_ACTION => Self::IllegalAction,
+            bindings::NV_ERR_IN_USE => Self::InUse,
+            bindings::NV_ERR_INFLATE_COMPRESSED_DATA_FAILED => Self::InflateCompressedDataFailed,
+            bindings::NV_ERR_INSERT_DUPLICATE_NAME => Self::InsertDuplicateName,
+            bindings::NV_ERR_INSUFFICIENT_PERMISSIONS => Self::InsufficientPermissions,
+            bindings::NV_ERR_INSUFFICIENT_POWER => Self::InsufficientPower,
+            bindings::NV_ERR_INSUFFICIENT_RESOURCES => Self::InsufficientResources,
+            bindings::NV_ERR_INSUFFICIENT_ZBC_ENTRY => Self::InsufficientZbcEntry,
+            bindings::NV_ERR_INVALID_ACCESS_TYPE => Self::InvalidAccessType,
+            bindings::NV_ERR_INVALID_ADDRESS => Self::InvalidAddress,
+            bindings::NV_ERR_INVALID_ARGUMENT => Self::InvalidArgument,
+            bindings::NV_ERR_INVALID_BASE => Self::InvalidBase,
+            bindings::NV_ERR_INVALID_CHANNEL => Self::InvalidChannel,
+            bindings::NV_ERR_INVALID_CLASS => Self::InvalidClass,
+            bindings::NV_ERR_INVALID_CLIENT => Self::InvalidClient,
+            bindings::NV_ERR_INVALID_COMMAND => Self::InvalidCommand,
+            bindings::NV_ERR_INVALID_DATA => Self::InvalidData,
+            bindings::NV_ERR_INVALID_DEVICE => Self::InvalidDevice,
+            bindings::NV_ERR_INVALID_DMA_SPECIFIER => Self::InvalidDmaSpecifier,
+            bindings::NV_ERR_INVALID_EVENT => Self::InvalidEvent,
+            bindings::NV_ERR_INVALID_FLAGS => Self::InvalidFlags,
+            bindings::NV_ERR_INVALID_FUNCTION => Self::InvalidFunction,
+            bindings::NV_ERR_INVALID_HEAP => Self::InvalidHeap,
+            bindings::NV_ERR_INVALID_INDEX => Self::InvalidIndex,
+            bindings::NV_ERR_INVALID_IRQ_LEVEL => Self::InvalidIrqLevel,
+            bindings::NV_ERR_INVALID_LICENSE => Self::InvalidLicense,
+            bindings::NV_ERR_INVALID_LIMIT => Self::InvalidLimit,
+            bindings::NV_ERR_INVALID_LOCK_STATE => Self::InvalidLockState,
+            bindings::NV_ERR_INVALID_METHOD => Self::InvalidMethod,
+            bindings::NV_ERR_INVALID_OBJECT => Self::InvalidObject,
+            bindings::NV_ERR_INVALID_OBJECT_BUFFER => Self::InvalidObjectBuffer,
+            bindings::NV_ERR_INVALID_OBJECT_HANDLE => Self::InvalidObjectHandle,
+            bindings::NV_ERR_INVALID_OBJECT_NEW => Self::InvalidObjectNew,
+            bindings::NV_ERR_INVALID_OBJECT_OLD => Self::InvalidObjectOld,
+            bindings::NV_ERR_INVALID_OBJECT_PARENT => Self::InvalidObjectParent,
+            bindings::NV_ERR_INVALID_OFFSET => Self::InvalidOffset,
+            bindings::NV_ERR_INVALID_OPERATION => Self::InvalidOperation,
+            bindings::NV_ERR_INVALID_OWNER => Self::InvalidOwner,
+            bindings::NV_ERR_INVALID_PARAM_STRUCT => Self::InvalidParamStruct,
+            bindings::NV_ERR_INVALID_PARAMETER => Self::InvalidParameter,
+            bindings::NV_ERR_INVALID_PATH => Self::InvalidPath,
+            bindings::NV_ERR_INVALID_POINTER => Self::InvalidPointer,
+            bindings::NV_ERR_INVALID_READ => Self::InvalidRead,
+            bindings::NV_ERR_INVALID_REGISTRY_KEY => Self::InvalidRegistryKey,
+            bindings::NV_ERR_INVALID_REQUEST => Self::InvalidRequest,
+            bindings::NV_ERR_INVALID_STATE => Self::InvalidState,
+            bindings::NV_ERR_INVALID_STRING_LENGTH => Self::InvalidStringLength,
+            bindings::NV_ERR_INVALID_WRITE => Self::InvalidWrite,
+            bindings::NV_ERR_INVALID_XLATE => Self::InvalidXlate,
+            bindings::NV_ERR_IRQ_EDGE_TRIGGERED => Self::IrqEdgeTriggered,
+            bindings::NV_ERR_IRQ_NOT_FIRING => Self::IrqNotFiring,
+            bindings::NV_ERR_KEY_ROTATION_IN_PROGRESS => Self::KeyRotationInProgress,
+            bindings::NV_ERR_LIB_RM_VERSION_MISMATCH => Self::LibRmVersionMismatch,
+            bindings::NV_ERR_MAX_SESSION_LIMIT_REACHED => Self::MaxSessionLimitReached,
+            bindings::NV_ERR_MEMORY_ERROR => Self::MemoryError,
+            bindings::NV_ERR_MEMORY_TRAINING_FAILED => Self::MemoryTrainingFailed,
+            bindings::NV_ERR_MISMATCHED_SLAVE => Self::MismatchedSlave,
+            bindings::NV_ERR_MISMATCHED_TARGET => Self::MismatchedTarget,
+            bindings::NV_ERR_MISSING_TABLE_ENTRY => Self::MissingTableEntry,
+            bindings::NV_ERR_MODULE_LOAD_FAILED => Self::ModuleLoadFailed,
+            bindings::NV_ERR_MORE_DATA_AVAILABLE => Self::MoreDataAvailable,
+            bindings::NV_ERR_MORE_PROCESSING_REQUIRED => Self::MoreProcessingRequired,
+            bindings::NV_ERR_MULTIPLE_MEMORY_TYPES => Self::MultipleMemoryTypes,
+            bindings::NV_ERR_NO_FREE_FIFOS => Self::NoFreeFifos,
+            bindings::NV_ERR_NO_INTR_PENDING => Self::NoIntrPending,
+            bindings::NV_ERR_NO_MEMORY => Self::NoMemory,
+            bindings::NV_ERR_NO_SUCH_DOMAIN => Self::NoSuchDomain,
+            bindings::NV_ERR_NO_VALID_PATH => Self::NoValidPath,
+            bindings::NV_ERR_NOT_COMPATIBLE => Self::NotCompatible,
+            bindings::NV_ERR_NOT_READY => Self::NotReady,
+            bindings::NV_ERR_NOT_SUPPORTED => Self::NotSupported,
+            bindings::NV_ERR_NVLINK_CLOCK_ERROR => Self::NvlinkClockError,
+            bindings::NV_ERR_NVLINK_CONFIGURATION_ERROR => Self::NvlinkConfigurationError,
+            bindings::NV_ERR_NVLINK_FABRIC_FAILURE => Self::NvlinkFabricFailure,
+            bindings::NV_ERR_NVLINK_FABRIC_NOT_READY => Self::NvlinkFabricNotReady,
+            bindings::NV_ERR_NVLINK_INIT_ERROR => Self::NvlinkInitError,
+            bindings::NV_ERR_NVLINK_MINION_ERROR => Self::NvlinkMinionError,
+            bindings::NV_ERR_NVLINK_TRAINING_ERROR => Self::NvlinkTrainingError,
+            bindings::NV_ERR_OBJECT_NOT_FOUND => Self::ObjectNotFound,
+            bindings::NV_ERR_OBJECT_TYPE_MISMATCH => Self::ObjectTypeMismatch,
+            bindings::NV_ERR_OPERATING_SYSTEM => Self::OperatingSystem,
+            bindings::NV_ERR_OTHER_DEVICE_FOUND => Self::OtherDeviceFound,
+            bindings::NV_ERR_OUT_OF_RANGE => Self::OutOfRange,
+            bindings::NV_ERR_OVERLAPPING_UVM_COMMIT => Self::OverlappingUvmCommit,
+            bindings::NV_ERR_PAGE_TABLE_NOT_AVAIL => Self::PageTableNotAvail,
+            bindings::NV_ERR_PID_NOT_FOUND => Self::PidNotFound,
+            bindings::NV_ERR_PMU_NOT_READY => Self::PmuNotReady,
+            bindings::NV_ERR_PRIV_SEC_VIOLATION => Self::PrivSecViolation,
+            bindings::NV_ERR_PROTECTION_FAULT => Self::ProtectionFault,
+            bindings::NV_ERR_QUEUE_TASK_SLOT_NOT_AVAILABLE => Self::QueueTaskSlotNotAvailable,
+            bindings::NV_ERR_RC_ERROR => Self::RcError,
+            bindings::NV_ERR_REDUCTION_MANAGER_NOT_AVAILABLE => Self::ReductionManagerNotAvailable,
+            bindings::NV_ERR_REJECTED_VBIOS => Self::RejectedVbios,
+            bindings::NV_ERR_RESET_REQUIRED => Self::ResetRequired,
+            bindings::NV_ERR_RESOURCE_LOST => Self::ResourceLost,
+            bindings::NV_ERR_RESOURCE_RETIREMENT_ERROR => Self::ResourceRetirementError,
+            bindings::NV_ERR_RISCV_ERROR => Self::RiscvError,
+            bindings::NV_ERR_SECURE_BOOT_FAILED => Self::SecureBootFailed,
+            bindings::NV_ERR_SIGNAL_PENDING => Self::SignalPending,
+            bindings::NV_ERR_STATE_IN_USE => Self::StateInUse,
+            bindings::NV_ERR_TEST_ONLY_CODE_NOT_ENABLED => Self::TestOnlyCodeNotEnabled,
+            bindings::NV_ERR_TIMEOUT => Self::Timeout,
+            bindings::NV_ERR_TIMEOUT_RETRY => Self::TimeoutRetry,
+            bindings::NV_ERR_TOO_MANY_PRIMARIES => Self::TooManyPrimaries,
+            bindings::NV_ERR_UVM_ADDRESS_IN_USE => Self::UvmAddressInUse,
+            other => Self::Unknown(other),
+        }
+    }
+}
+
 /// Empty type to group methods related to heap parameters for running the GSP firmware.
 enum GspFwHeapParams {}
 

-- 
2.53.0

