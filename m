Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 363E1106B50E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 12:14:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6091610E897;
	Wed, 25 Mar 2026 12:14:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="FDYLL/8I";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013006.outbound.protection.outlook.com
 [40.107.201.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A545410E895
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 12:14:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fseDHAnvtezJ5TWbM0rL3F473Tn5Q/6lMzC1TPkb1hdCwwQwSqY7T/m3D87ZCTFOEFAFOSBThql51WRLN6uW1YDJ2hegmDTrw5fLer+m/be9UA72eLB8XQVMX5A815ga5UfDEQaha7DkfGuRLxaauFwIWjc2WY+Yx1R0akJXJKOs46yyeZKbH95MfCeO2YDDK0L2eEdoQ/+ZdG0B8LjXkmeZvUaIcsAge1gsFcmWLURo50FUSqml0hapHteL3XKWUtVC22bsscDE+uvUZZeg329Dg7w/iH5bUlgRNAl6MA59A3I8ZUbhulsmN092pXlZVFQlmmz4HMnX/Ti93XA6XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d3rhb5WgWWz6atyvtVrDptA1s76ZL3JwNecug9mDQ4Y=;
 b=rXyvnRhM0PpU1TCOYSQkmQtERp7OFm4vKJTt+OGTMnTf4knlGsX+qWHUH/JUjGjplsTKPntViT/hpfaYOTfMsPt79ojOk/aN2qYD3Dog/nkYuf4pE0IU7z7TBMWtFZIuw99WF6Ko82zoFtFoN/ECn1vgYWncTSqn409/rSpMSBIyMquaJ59JyQ21EJ51KBpzNSlDS+ydQd8HWQUdieFu5nP+28Rf68o04V7ydifCEWT9hS10FBcfHW4pBODMJZEKslHkxzTK75CUI1IaFKbHH1qt3m/YG6SdAxwSjBevzOvzWPK2X+3xdQ59sTmbYxAEQ149zs3ZtTT8GtpmI09aCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d3rhb5WgWWz6atyvtVrDptA1s76ZL3JwNecug9mDQ4Y=;
 b=FDYLL/8IVhc32VTMRONcn/e4oLx/+wwepGKneYVC3hXFlPFNjZ/rP8Devc60Nuho/ecfJU19E14r0C38nEchzlFcV6elpZ2k5ZR8fERGm12hkDcE5PVDiUGZVhLGypCyj+gTOhjCoRgBYSMVH8DQF8msIAchL0YmkOR6T6OXrPfyAygQk85HdKQ2DRNPW7+ogire1XyRctYdOIP53yIilTGLLlDrUIERDWLL4ZDo8c/yE6aszm/ALqe/h1ImDd9W3Alcx1XIoCEU0DG/pRf8u55BOkQRAYpa+Amj8gtwk9o3Pr6bm33cxwT2iFnlfhNdkW5PzVrxAPhzicxURLZVRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by DM6PR12MB4298.namprd12.prod.outlook.com (2603:10b6:5:21e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 12:13:56 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9769.006; Wed, 25 Mar 2026
 12:13:56 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Wed, 25 Mar 2026 21:13:40 +0900
Subject: [PATCH v3 2/9] gpu: nova-core: gsp: add NvStatus enum for RM
 control errors
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-rmcontrol-v3-2-f3101093484e@nvidia.com>
References: <20260325-rmcontrol-v3-0-f3101093484e@nvidia.com>
In-Reply-To: <20260325-rmcontrol-v3-0-f3101093484e@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.0
X-ClientProxiedBy: BY5PR13CA0022.namprd13.prod.outlook.com
 (2603:10b6:a03:180::35) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|DM6PR12MB4298:EE_
X-MS-Office365-Filtering-Correlation-Id: 33f10fb9-4115-45ba-184d-08de8a67fcd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|10070799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: PnUmt0JkEXwyia+XQ3Jp9jpnnqj4k3qhDI//gkMEx7uHYNZDgssv2vTa+ZlyG26qDGqQQ2+EoJKOitCxpkXNaKlclwvQfRpKqt15SbncFr19D3quMT5+h/5+RvEzVz+iwmS9WqXnV6cE6fhHJjrvoi/usQnPT/9nkqF+k7TkJ4eS+iOLBYoBV3XnAA69UdJMe6PLTNo7FtLOgJ88PdH8Zj6lzYuqbOpm7V6aPOKqoLdTnXrZNt6nTK4jRU0qJJ0dc5N/oxSNH1ypwJfBDBi9TL5jHmUYglSiWxIXYbzgbyF02lq1AG33TYLvri65SlO4OGN9yMFvhBaVdj1qlh36qDWGr9GOiKCv73g+FNav+bvQgyuz9v3qy+GIU9aciK0Ipvgpd+2K+d7QxHMFfWFPIfXtSbwEm3QK+guMil6hPeGEHVvefG6OgHJMJtmfGcZ7BrittSD4kYCJbiVB9by4xz+z13Ch921NghrBhgOUgpNxDzq9FkWeFWC5fhC96DPEzkcr6LdZHZLDgxi7vIEJ63e1oBXXDRErUIAOGoUzQ1IbKalYe3J1BCurevuNZ6lIyjUgLspCN0Vnju3KeKnBbs5BMyNFJrymxe/qn/0XBgmNxnNMDahjet20aEnUi/HWTAQE+IS6fATkUPXq33LJBzRwULPUFsWgoJE9q2CntW+5qZeHNmbWqTSVNuXduBiyiofzU2E5PHN0LRwXVZjYpHCRR8MpKTs77r0WGKGXZVI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGtpcjNwTFk1TG9mRjU2UXh3MFJ3MmtlSFRuL20rTDVYeGY4ZXAvdFk2S3F5?=
 =?utf-8?B?U0l0TldTVXFyNUJUUWhqcnltQ0RGK0NVWFRXZ3I1SWxXbDFhUEdlRGJhV3pP?=
 =?utf-8?B?UXNXaFZvRVg1SjQxMmlmM3V0clVOS1F4MUlsdFFaYUpYR1R1VmcwTGQ4UzNG?=
 =?utf-8?B?cDFKRytWUlJOU2NBZzFMTHFnbEI1bkdOOUMxdHp5ZEltSlBOS2NkV1M1L3RY?=
 =?utf-8?B?cXYyaGQ0QkdsLzJuSlcrbkdEekpZMnFUOFYweTZsMHUrY0VCRVUxdEVLMUly?=
 =?utf-8?B?Sjljbk9mV2JVZFVZQ3hlakQybTl4NkVMeklqM2NteXhnK1JtcERoQXE1OWhO?=
 =?utf-8?B?dm9qb0JtaHdDVXNjZU0wU0R5U21oUEoyd0dxYTFKa0pDM1NCNVUwb0s1ZFpN?=
 =?utf-8?B?NDdjakRsT3pKU2VmdExaaFNkcURFcG0wN0k4S3o5eDNJTW01ZVExTjdjdWF4?=
 =?utf-8?B?QUpWYU85UFQ1NkxTU1FZRDUxTXdoQUVJT2hmUzlaUE1wbnh6QjFJbDdxcnJs?=
 =?utf-8?B?SGFLeWErTDZnNlVSZ3dFZkh5WnkzRU9CeWpiQ3RsK0xQL2lpcmhLeFlGN1Nk?=
 =?utf-8?B?b3FnQnJMbjdTN1RhcStRSGV3WmtNdmZxajZwRDlCZGhQTkRMYzZDT1I5VjN0?=
 =?utf-8?B?QkxKR1RFdUYxaGZ5U0t6VTMyWGhTZWpsTnkrNldyMGVBMVJFcHFiMFNlUmRm?=
 =?utf-8?B?M3czbUZJdndQYjV2d200emlwUTE2Z1IzcnhwT2pOb3VHOW5lb1AzSHBRc01w?=
 =?utf-8?B?YjN1ZUVleTF5L0VoUThEbTd3UTVBbHlvWkduaGUzUmloVHRoVjg1SFhJQWZ2?=
 =?utf-8?B?UHYrUnVoSHA2ekZYSUYzdzMxRk4rL2JsbExRTDROSFcxcGVMWDlNUUZUS2lR?=
 =?utf-8?B?SDN5RjJmVitvdVo5N1lwWGRvNGllNG1QL2ZUZlR3em1xSFdmOEh4V3hYWlhH?=
 =?utf-8?B?TUFkRFdQa3JUWHBURDhveENmdkF6a1J2T1NFMTFRb2x1ajFVRW5aNHhjS0x5?=
 =?utf-8?B?Nm90cHFYSk5IZTFZeVk5Y1JOM1ltRWFTbW1ZVFkyWnRnejNWSktUb3pmdUZo?=
 =?utf-8?B?bnRvTHR4SmxTd0EyN2drd1BpR2VwUlFaVjMvcHZ6QVlqRXdQSkdmcGczL3pJ?=
 =?utf-8?B?N2F0S3Z4cjVpbVIxbmpsUXh0QTJ3M0Nvd3VBR2ppL3gvYzl5TnB2Z1I4UWJW?=
 =?utf-8?B?NlpveVU2Sm95bHE0SERDQmtQU2lFY09GdkVyZVlXZUpsNHNFT2Y3VXY5dURt?=
 =?utf-8?B?R2NzS1ZWWW9ZdkV0bHh6bmNUcGpFeUNmNDIySGYwZ0pVYmhSaDFUUHcxWWJG?=
 =?utf-8?B?SEVnYVhtRXpVcFZaOHFFd2dDOHVXZ2szSWFXQUNMeVV1WFU5K2FFN2RHWDk3?=
 =?utf-8?B?bjFOT3NWMmJ0K1pwS0RQdXJKWVBjYTZYUzFsYU5mcUlhZmQvVWR6a0V0dVBl?=
 =?utf-8?B?blFlcnhNYjdtd0tzQ0k1bmhVM093U3NWTGhTelhVcUJHdFlsbGJyalRrMk8r?=
 =?utf-8?B?dCtSbEdYYkQ0WFQvems5T3Z2VXI2Z3BrLzVrTTQwcGdndmxLbjBqQ0p2b3I0?=
 =?utf-8?B?VXd4cXg2UTZrMzY0S2JxdmRJdU85bkdwSktEeHlUeDNPUjVKY1h1R3NDZjI3?=
 =?utf-8?B?bE1KMElqb0NFQVc1UllGNVByRlF3VmRTUlZnRnFVc2RJN3NpYUg5YUhEd1pm?=
 =?utf-8?B?U3ZxOWEyQVc0VmVaTW5kTHNIcC9OTlNFUzRDRXFldFNPRmxaMnNYd1g5NE1a?=
 =?utf-8?B?U3pEOTdsZGNReU1OQVVTQ3JsY3AzaDd0NTBlRkpNZVIxRUoxR3ZEZmoyUUhL?=
 =?utf-8?B?OHNCMkFHL0tGZTNvVm81MnZJVkhDcXVveGk3akptQzd3YnBLdGszdTJydGdE?=
 =?utf-8?B?NXVnd1ZzRkxINkduVTdZaDlkTG1BUnhCVEhQS3FRSXBHaHFzckF1cGttRXh3?=
 =?utf-8?B?bWFtOHJneGRTUGFXQUZpU0RZckp3Vkw0OXk4aFN3YlE4c3hCb0JFZDhycnpJ?=
 =?utf-8?B?MkU3NE1WMjlSSzJPRndLWll2blJxMVpHYkJiOHliOVN5S2tuZnJBeTNvOS9h?=
 =?utf-8?B?TVpja1pkSWZBb2RGUTFWZnR6cFptWEZaVStpTXBINUYrcExnVDdQZTZwUFVt?=
 =?utf-8?B?cUhpOThremNabm5xSWg1Ly9rSC9LSGJ4a2VydEVoUHJGN1BGSm5nSytGMWxm?=
 =?utf-8?B?Z2FBUjN5Y0YzcmFicXRtUnRHYjFMN2QxY3ljNm10ZjNEWm1MU1o2MWgzaTd6?=
 =?utf-8?B?SWhjVWRzYVN6TXlTRjBvMjVlZEVzNXY3NGR6NkxCOC9GMWhLd3NvTG5TOUds?=
 =?utf-8?B?NlJMNWM3RWltK0RCV2Q2bXREQTBTL1pxTU00QlJaMCtVRkhOY1U0cjF0TDZz?=
 =?utf-8?Q?1nrZvQsFJSFg2+OAbg9ri7cHBtOgJLdDHKu7CEspzfbfz?=
X-MS-Exchange-AntiSpam-MessageData-1: F3QiCcBO76DGCQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33f10fb9-4115-45ba-184d-08de8a67fcd9
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 12:13:56.3648 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qw7YTheuBb8bS1/m+jbIPpvbA/A0TVtW6VbrcoMnZOBp2r4BjMCOseX9saIcwLryyWsyv0WbJ2ZvKn4aC89NAg==
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

Add NvStatus enum that wraps the raw NV_STATUS u32 codes returned by RM
control RPCs.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gsp/fw.rs | 401 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 401 insertions(+)

diff --git a/drivers/gpu/nova-core/gsp/fw.rs b/drivers/gpu/nova-core/gsp/fw.rs
index 0c8a74f0e8ac..cb4bda253193 100644
--- a/drivers/gpu/nova-core/gsp/fw.rs
+++ b/drivers/gpu/nova-core/gsp/fw.rs
@@ -97,6 +97,407 @@ pub(in crate::gsp) fn advance_cpu_write_ptr(qs: &Coherent<GspMem>, count: u32) {
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

