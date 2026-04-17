Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 213AAF436B4
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 15:33:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8939910EA7B;
	Fri, 17 Apr 2026 15:33:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="ioPEjSiO";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012066.outbound.protection.outlook.com
 [40.93.195.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6186610EA7B
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 15:33:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xNz8vy8vzCHe41zLcTlPw2tRdCcyjqV8RMV/A+zUPQfUVxYTiQ94bVieux8X9lZzsf/p0Ln3Og4AHr5tDIcUP0uPTOAIzGB8P2SWMAp68+Ivj8OZPYDPweXBMD4Nqr+ADOvlHV7xCdkWqASK+sFKBJ9HA46PUy8eukEA0LOc/eZq+4zKcoKB6fKtL8UjLgH9d4uaXr3CvReJkvv/dR30LjtWXkqZ5MDlFQZko0Ssi55XmDDwSgpoywNkSHmpztOtj35dr2LXKiJKs1N1Mz0/iCAivsnDfkyD1UmyXer32IcTDb4wUZKL8gzwbxjqY2IywVjyTmtZcHnvt+zD8jIBhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ALajJxd5/K9gpLivWMZE8K4Hp3WGYGJlAqZ1jA5XO4k=;
 b=Dn8QpckFfL5Off1RWwfqI7rWR2UK2yk/lhNH8eP05P0JwqqI8mjTBJZg4zfPCzV01rrygMUCNlLSS7NY1LiKG7e0Jmb863p1vxp9cfn94wHcsPKNyYS1GxDaTi6OTkDoQzDI7pzb7HIdz+wYZrTgbFiODCEzhnyO1aMjDi80UWJfrC8T9bbCTmRDKOxHAKvidOILPmRwSzFP4phpnZlpRoood7F/jkDFNEHHptqjYNY0OK0r1J8Pk0a2HGJ822YGxJ7GZOeYH6u1sqAsCtJTtPEdMZqtk1gQ0EeASYh3zSsAtny/YshBHoOLhkLj5js1eaL6TvUa0SdISy6bgmfFeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ALajJxd5/K9gpLivWMZE8K4Hp3WGYGJlAqZ1jA5XO4k=;
 b=ioPEjSiOjYphDO+GzzH7DD9qURJdhAI/fbU69eu/xkg4Y8er//dF/FvqxQxi/9dNh6P3WS8eu3KMZQFRPU7bRSMbvwcEbx3RmxYgxh++9PuzSZDNzE3xMrgSAamg50IiVDa926uwnAyUrmYTIWYGlHt+w2h8/vsP20VIb9kR4N3YV1/qpNXY8AIPyWgwfwPzgnUfanj2Kwnpr5kp8r1/we+Wkr1Y3xi0Gm15WQNoKL2wtcdkP1oV4e9L1U8oMPsPOrq9fxwGH41O+jz/pnOkhn5FElcPqUX6l696cTGxmMZjXRrYW0RmvRix439iMsPyNTm99NhuUzjkT237jYTW5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by DM3PR12MB9389.namprd12.prod.outlook.com (2603:10b6:0:46::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9818.25; Fri, 17 Apr 2026 15:33:39 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 15:33:39 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Sat, 18 Apr 2026 00:29:20 +0900
Subject: [PATCH v4 2/8] gpu: nova-core: gsp: add GSP-RM status types
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260418-rmcontrol-v4-2-fda8c76dbb95@nvidia.com>
References: <20260418-rmcontrol-v4-0-fda8c76dbb95@nvidia.com>
In-Reply-To: <20260418-rmcontrol-v4-0-fda8c76dbb95@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY4PR01CA0095.jpnprd01.prod.outlook.com
 (2603:1096:405:37d::6) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|DM3PR12MB9389:EE_
X-MS-Office365-Filtering-Correlation-Id: c339f355-fc53-4a73-cf05-08de9c96b2d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|376014|366016|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: gYrsQVYdEkoo31P2TaVlqO91vy/ctW6Mg8FinGbwPPH7SDRSIyBz+8TwZoseQr7bUEleU8pl+x0iNSsH0xasl5ltEGTnpjuF8vTziILbo2bi7NtspPs2AQ6D5gw/TBiAW1sQE6oYq/qc0Iy5ovCjwrlwZM/xYVqwFPJ3vlhux402LNzk9yefdsyLUQ0oYHxR6MtS2iNdOu7TH7kZOXlFz8NaeWL5PMIdOS32h0Wp16fuslzamVMILefQHjfr6+htcG6Q57q/i1BSVWtCbSTZbYHdlwZGtcOPK26rpMXYJqF5Jr4HgRypdktd+LhH8LPdGyLMRS9HIWRuF45Q6uLVG80y7bcXJAHGtVntJi+zEJF6d7gUIYecqIdotzYYYan515hasFgPQ128zBuuGpx9WNnc3QX0UFcKGgEp+wFfzAp2mmaY2dWnFcRT05PWgCj9MWiS15rumGTB0DWuVAXmFN4ZEMZWG4XvzI2n05YxZ9HtUa9C0g9g4Z1cnoHDTLFJdA61bV0Vv1bSVY3iHRa2ylbXOQJgig75uweN/UO2x6HV8MV6TZvuQJT+uGbnO5z+lgciTUUjYbg7AYC9JH1YzWAJBMEZu2gNgJgWTM6HG7jV9l3zISDUy7RNu55i5Y32wcUGx8JDhJ7ecOj3lAOM+LPL8iUF/g6DtaEZsGeeWjs2VoQ5fAjSnui3h3KxDpY83gsEFTAlVzsGf9CRRvaCxm8TwvU5sCWrJAUUwD5Rix8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmtIYmpFQURGRlMyWjRGd0x6SUp4UEhreitjQzZnRndXY0VzYVMzSnFRRXZ3?=
 =?utf-8?B?RzhSVHNLVmR6YXVsajA5NnZSakJoRjlNZVZIdUloMlk3b0JlQVRHZmJBYlNp?=
 =?utf-8?B?eTJpQUpsY092SExLMmhYLzcyRnR2OUM0ejhZUUk5ZG8xRXFnRFl5di80a3hr?=
 =?utf-8?B?bW5QU295QU1UQVNrRGgwQWZwcE16cllkejNMQTU3a0txcUtIZnVka2VNeG1v?=
 =?utf-8?B?L1Jvc093b1ZhTUFsaEUwRnRRSkFBMzdjeXpRVEdjaGZRLzFDRTUvSUNKZzlQ?=
 =?utf-8?B?elRtd2VSR0R6VXJZdUhPcXNUSHBLUEZ0VDg2QkM4QldhUGZKQk9RUmthcXd5?=
 =?utf-8?B?bTREV3BNdnNCNjhZUkdnSk1xL3FyTGQ0cURxTzVKRGZ0WDQ0ZjdLb0QweU9u?=
 =?utf-8?B?b1d0aldRVmduU05uVjR0cGRqMkZkcFJNYU14dGd3OXpoQ1h4ZjhuTUxyL0RJ?=
 =?utf-8?B?TE11c250VGU5NW9uNjRKVkQzTmlVMmFCMHgzMURVYllGV0VlS0JiTTlITHVX?=
 =?utf-8?B?YW1LTGhXNFhJOFZlc3dqdnRQTUdQbVhkUURPY2NDeTJBa0dBcnhmcVlhSG5L?=
 =?utf-8?B?WUliWEVQRStRcm9BZm15d3B5NEZnUHpCRE90Vkx2UWNnakdMK1BZTEpsSmgv?=
 =?utf-8?B?UkhCMVpiOG1TNEtsZE5MdnEvTm1pT1hQNmJXSTRMSG1PdzNjKzN4ZVJsQlI1?=
 =?utf-8?B?TUNFMGRhR3dUR0dRbDRBdDVqMXJ1YWlSZlBzK29oUGNjNWtMd3RzZm53NnA1?=
 =?utf-8?B?ZjhSRnkyaVVHRXZteVlLYmtaTG1zQVVINGNTdko5dnZjQ2gveFhkby8yZGI1?=
 =?utf-8?B?bDJzRng2VnJlamlvbTRaWnFsNmwrU2pVaGNPOWwyVmFua0VWWDJQTkx0WW03?=
 =?utf-8?B?YW5ZRVNhNEZmUGh0TnZmV2YvdmJsNmZ2cVg2SytGMk5YS3RWV2s0am9uQlNy?=
 =?utf-8?B?bVBJUVN0QjUycHIyckFWMm1iVVRMN3dNMllQRmVIYnZJMkI4ODV0ak5ZOHhV?=
 =?utf-8?B?VjA2MGRWb01jMWZqamgxclgyakd0dTNpQ1NCTXZ1SHVRWXZCaXhSRFpKSlpv?=
 =?utf-8?B?NHBYREtQUWhYSitXREsxN1RsRHovMU9LeDFnSys3cFdhWGVjOUdHZkpXSm9w?=
 =?utf-8?B?SVRUNnlxeklQR21YWFdhOStiT3pYRFJOYUtSejA1MWZtTWxpcm0xK3g5ZzdS?=
 =?utf-8?B?SkdsdUJmeHg4ZFpva1pwQ29JdXErdWdscEcyVjNVUldZRVBKVzdQZFhUYkFF?=
 =?utf-8?B?MmV6K2Z3TkVWeXBvVC9YdHBjeVAva0pKZkNEeUV0aDVXNzBOZzYyd2RFY3Fr?=
 =?utf-8?B?MDMzVEZrZnR2ejllL1FrTGJ2UUdTdGZjaGMxT2VmcnA2RURDUkwrRE9aK0t1?=
 =?utf-8?B?aXpLMnd2NHhNd0VZZFZMZE5QUEYwMDNiUGpNZk1mVFBNYzN4VkdRS1dycU41?=
 =?utf-8?B?VUZLdFNqZDdlWkM2QXluZFpNbFVlQlNmb2Y1WUJoeFhTaVhyNUZWNHpaYVl4?=
 =?utf-8?B?SGMxbklJT3hpMnlWcytWRDVscVE4b1lLWGFkK3dteEN0RVhjODZXYm5LcC9C?=
 =?utf-8?B?WGNEN2prM2ptaGYwNmowZ2NLd3hINkVmUVozNjRjd3M2K01NVDFkU2NacW1i?=
 =?utf-8?B?SXc1MnNpeFMzdUNDQ3Nxak9YTWlEZXZuN0V0YnI0bmpTZllRd0VabUZZWFBo?=
 =?utf-8?B?cDd3ZkFVazlsVEZkTGJMYkZmSlYwUkJHZFVNWVlESWNDdHFpOWx5ckRXditu?=
 =?utf-8?B?VUJZVVBhejJoSm4vbXA0UlBtUlp1eVlVNURQdTVxVkl1Ym1wK2JhUy9wSWlC?=
 =?utf-8?B?bGFXTlhXV1g1QWtTTHBTejhWVVJKUi94WlpEVEJpbGIzV2lxbzBRems4TFpE?=
 =?utf-8?B?RUdobHJvaDhUaHdRUmcyOURmMXhXZ3JkYjZBTy9FQTdzdkNJbmhMa1ZjU1VN?=
 =?utf-8?B?eGs0ZEx2YWhnWVZtN0Z1amxsTHJuSDVEb2g1UDMwL2RiTkZuOStjZW52d3pE?=
 =?utf-8?B?ZHM2L1RkSm42Ti9HenlYSjFKSjV4UU5FVUpNbzBUVHh4Y2RZR1JlZk5JejhL?=
 =?utf-8?B?NXBXcFo3OVdhWG1BRGxpYm9RdWw1ZU9LWkNUVG5IelRtSFBFajNHQStPSlRF?=
 =?utf-8?B?dnBSanVDMy8vOGM5UmxXeklYc3FFdHNoNVpXcmhkM1c5WXN5UGhrWlh0djVz?=
 =?utf-8?B?Q3JkZ3orendsaGJ2R3BCMDUxMXFITExZSm55bEV1VHF3cVVreTNLRDVBOVZI?=
 =?utf-8?B?MHpRTksvQTZVOVE3RUZ4d1RxTVNFRW1RQTJWdWNETWlmR0VHaFF3TmNzcjRy?=
 =?utf-8?B?M3R6WmlLcTRVSVpFOFc0aysyNE5RUmhyeGJQb091WmxBY3lVRUkwcitKTThJ?=
 =?utf-8?Q?e2xJY8CA7wFcI2vrCZjeYdUmkClGBKpdTgNU/613ontHR?=
X-MS-Exchange-AntiSpam-MessageData-1: eHtbdd8IZ/L33w==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c339f355-fc53-4a73-cf05-08de9c96b2d1
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 15:33:39.5117 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KkwcEL2ohakG0xrJXCDoD4xdnabuyMIdxflkpjMlWwlXZuP3IYtm/3/i+xH+xEcmjTEBE3ECrrCXlWgcFGLzpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9389
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

These types represent the status value returned by GSP-RM for generic
RPCs and also for RM control messages. These are split into a success
status, a warning status, and an error status. Give a rust side type to
each of these, which lets errors be mapped to a rust `Error`.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gsp/fw.rs | 508 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 508 insertions(+)

diff --git a/drivers/gpu/nova-core/gsp/fw.rs b/drivers/gpu/nova-core/gsp/fw.rs
index 0c8a74f0e8ac..a8d7c62af097 100644
--- a/drivers/gpu/nova-core/gsp/fw.rs
+++ b/drivers/gpu/nova-core/gsp/fw.rs
@@ -97,6 +97,514 @@ pub(in crate::gsp) fn advance_cpu_write_ptr(qs: &Coherent<GspMem>, count: u32) {
 pub(crate) const GSP_MSG_QUEUE_ELEMENT_SIZE_MAX: usize =
     num::u32_as_usize(bindings::GSP_MSG_QUEUE_ELEMENT_SIZE_MAX);
 
+/// Status code returned by GSP-RM operations.
+#[derive(Copy, Clone, Debug, PartialEq, Eq)]
+#[expect(dead_code)]
+pub(crate) enum GspMsgRmStatus {
+    /// The operation succeeded.
+    Ok,
+    /// The operation completed with a non-fatal warning.
+    Warning(GspMsgRmWarning),
+    /// The operation failed with a GSP-RM-specific error.
+    Error(GspMsgRmError),
+}
+
+/// Warning code returned by GSP-RM RPCs.
+#[derive(Copy, Clone, Debug, PartialEq, Eq)]
+#[repr(u32)]
+pub(crate) enum GspMsgRmWarning {
+    HotSwitch = bindings::NV_WARN_HOT_SWITCH,
+    IncorrectPerfmonData = bindings::NV_WARN_INCORRECT_PERFMON_DATA,
+    MismatchedSlave = bindings::NV_WARN_MISMATCHED_SLAVE,
+    MismatchedTarget = bindings::NV_WARN_MISMATCHED_TARGET,
+    MoreProcessingRequired = bindings::NV_WARN_MORE_PROCESSING_REQUIRED,
+    NothingToDo = bindings::NV_WARN_NOTHING_TO_DO,
+    NullObject = bindings::NV_WARN_NULL_OBJECT,
+    OutOfRange = bindings::NV_WARN_OUT_OF_RANGE,
+}
+
+// TODO[FPRI]: This is a temporary solution to be replaced with the corresponding derive macros
+// once they land.
+impl TryFrom<u32> for GspMsgRmWarning {
+    type Error = Error;
+
+    fn try_from(value: u32) -> Result<Self> {
+        match value {
+            bindings::NV_WARN_HOT_SWITCH => Ok(Self::HotSwitch),
+            bindings::NV_WARN_INCORRECT_PERFMON_DATA => Ok(Self::IncorrectPerfmonData),
+            bindings::NV_WARN_MISMATCHED_SLAVE => Ok(Self::MismatchedSlave),
+            bindings::NV_WARN_MISMATCHED_TARGET => Ok(Self::MismatchedTarget),
+            bindings::NV_WARN_MORE_PROCESSING_REQUIRED => Ok(Self::MoreProcessingRequired),
+            bindings::NV_WARN_NOTHING_TO_DO => Ok(Self::NothingToDo),
+            bindings::NV_WARN_NULL_OBJECT => Ok(Self::NullObject),
+            bindings::NV_WARN_OUT_OF_RANGE => Ok(Self::OutOfRange),
+            _ => Err(EINVAL),
+        }
+    }
+}
+
+/// Error code returned by GSP-RM RPCs.
+#[derive(Copy, Clone, Debug, PartialEq, Eq)]
+#[repr(u32)]
+pub(crate) enum GspMsgRmError {
+    AlreadySignalled = bindings::NV_ERR_ALREADY_SIGNALLED,
+    BrokenFb = bindings::NV_ERR_BROKEN_FB,
+    BufferTooSmall = bindings::NV_ERR_BUFFER_TOO_SMALL,
+    BusyRetry = bindings::NV_ERR_BUSY_RETRY,
+    CallbackNotScheduled = bindings::NV_ERR_CALLBACK_NOT_SCHEDULED,
+    CardNotPresent = bindings::NV_ERR_CARD_NOT_PRESENT,
+    CycleDetected = bindings::NV_ERR_CYCLE_DETECTED,
+    DmaInUse = bindings::NV_ERR_DMA_IN_USE,
+    DmaMemNotLocked = bindings::NV_ERR_DMA_MEM_NOT_LOCKED,
+    DmaMemNotUnlocked = bindings::NV_ERR_DMA_MEM_NOT_UNLOCKED,
+    DualLinkInuse = bindings::NV_ERR_DUAL_LINK_INUSE,
+    EccError = bindings::NV_ERR_ECC_ERROR,
+    FabricManagerNotPresent = bindings::NV_ERR_FABRIC_MANAGER_NOT_PRESENT,
+    FatalError = bindings::NV_ERR_FATAL_ERROR,
+    FeatureNotEnabled = bindings::NV_ERR_FEATURE_NOT_ENABLED,
+    FifoBadAccess = bindings::NV_ERR_FIFO_BAD_ACCESS,
+    FlcnError = bindings::NV_ERR_FLCN_ERROR,
+    FreqNotSupported = bindings::NV_ERR_FREQ_NOT_SUPPORTED,
+    Generic = bindings::NV_ERR_GENERIC,
+    GpuDmaNotInitialized = bindings::NV_ERR_GPU_DMA_NOT_INITIALIZED,
+    GpuInDebugMode = bindings::NV_ERR_GPU_IN_DEBUG_MODE,
+    GpuInFullchipReset = bindings::NV_ERR_GPU_IN_FULLCHIP_RESET,
+    GpuIsLost = bindings::NV_ERR_GPU_IS_LOST,
+    GpuMemoryOnliningFailure = bindings::NV_ERR_GPU_MEMORY_ONLINING_FAILURE,
+    GpuNotFullPower = bindings::NV_ERR_GPU_NOT_FULL_POWER,
+    GpuUuidNotFound = bindings::NV_ERR_GPU_UUID_NOT_FOUND,
+    HotSwitch = bindings::NV_ERR_HOT_SWITCH,
+    I2cError = bindings::NV_ERR_I2C_ERROR,
+    I2cSpeedTooHigh = bindings::NV_ERR_I2C_SPEED_TOO_HIGH,
+    IllegalAction = bindings::NV_ERR_ILLEGAL_ACTION,
+    InUse = bindings::NV_ERR_IN_USE,
+    InflateCompressedDataFailed = bindings::NV_ERR_INFLATE_COMPRESSED_DATA_FAILED,
+    InsertDuplicateName = bindings::NV_ERR_INSERT_DUPLICATE_NAME,
+    InsufficientPermissions = bindings::NV_ERR_INSUFFICIENT_PERMISSIONS,
+    InsufficientPower = bindings::NV_ERR_INSUFFICIENT_POWER,
+    InsufficientResources = bindings::NV_ERR_INSUFFICIENT_RESOURCES,
+    InsufficientZbcEntry = bindings::NV_ERR_INSUFFICIENT_ZBC_ENTRY,
+    InvalidAccessType = bindings::NV_ERR_INVALID_ACCESS_TYPE,
+    InvalidAddress = bindings::NV_ERR_INVALID_ADDRESS,
+    InvalidArgument = bindings::NV_ERR_INVALID_ARGUMENT,
+    InvalidBase = bindings::NV_ERR_INVALID_BASE,
+    InvalidChannel = bindings::NV_ERR_INVALID_CHANNEL,
+    InvalidClass = bindings::NV_ERR_INVALID_CLASS,
+    InvalidClient = bindings::NV_ERR_INVALID_CLIENT,
+    InvalidCommand = bindings::NV_ERR_INVALID_COMMAND,
+    InvalidData = bindings::NV_ERR_INVALID_DATA,
+    InvalidDevice = bindings::NV_ERR_INVALID_DEVICE,
+    InvalidDmaSpecifier = bindings::NV_ERR_INVALID_DMA_SPECIFIER,
+    InvalidEvent = bindings::NV_ERR_INVALID_EVENT,
+    InvalidFlags = bindings::NV_ERR_INVALID_FLAGS,
+    InvalidFunction = bindings::NV_ERR_INVALID_FUNCTION,
+    InvalidHeap = bindings::NV_ERR_INVALID_HEAP,
+    InvalidIndex = bindings::NV_ERR_INVALID_INDEX,
+    InvalidIrqLevel = bindings::NV_ERR_INVALID_IRQ_LEVEL,
+    InvalidLicense = bindings::NV_ERR_INVALID_LICENSE,
+    InvalidLimit = bindings::NV_ERR_INVALID_LIMIT,
+    InvalidLockState = bindings::NV_ERR_INVALID_LOCK_STATE,
+    InvalidMethod = bindings::NV_ERR_INVALID_METHOD,
+    InvalidObject = bindings::NV_ERR_INVALID_OBJECT,
+    InvalidObjectBuffer = bindings::NV_ERR_INVALID_OBJECT_BUFFER,
+    InvalidObjectHandle = bindings::NV_ERR_INVALID_OBJECT_HANDLE,
+    InvalidObjectNew = bindings::NV_ERR_INVALID_OBJECT_NEW,
+    InvalidObjectOld = bindings::NV_ERR_INVALID_OBJECT_OLD,
+    InvalidObjectParent = bindings::NV_ERR_INVALID_OBJECT_PARENT,
+    InvalidOffset = bindings::NV_ERR_INVALID_OFFSET,
+    InvalidOperation = bindings::NV_ERR_INVALID_OPERATION,
+    InvalidOwner = bindings::NV_ERR_INVALID_OWNER,
+    InvalidParamStruct = bindings::NV_ERR_INVALID_PARAM_STRUCT,
+    InvalidParameter = bindings::NV_ERR_INVALID_PARAMETER,
+    InvalidPath = bindings::NV_ERR_INVALID_PATH,
+    InvalidPointer = bindings::NV_ERR_INVALID_POINTER,
+    InvalidRead = bindings::NV_ERR_INVALID_READ,
+    InvalidRegistryKey = bindings::NV_ERR_INVALID_REGISTRY_KEY,
+    InvalidRequest = bindings::NV_ERR_INVALID_REQUEST,
+    InvalidState = bindings::NV_ERR_INVALID_STATE,
+    InvalidStringLength = bindings::NV_ERR_INVALID_STRING_LENGTH,
+    InvalidWrite = bindings::NV_ERR_INVALID_WRITE,
+    InvalidXlate = bindings::NV_ERR_INVALID_XLATE,
+    IrqEdgeTriggered = bindings::NV_ERR_IRQ_EDGE_TRIGGERED,
+    IrqNotFiring = bindings::NV_ERR_IRQ_NOT_FIRING,
+    KeyRotationInProgress = bindings::NV_ERR_KEY_ROTATION_IN_PROGRESS,
+    LibRmVersionMismatch = bindings::NV_ERR_LIB_RM_VERSION_MISMATCH,
+    MaxSessionLimitReached = bindings::NV_ERR_MAX_SESSION_LIMIT_REACHED,
+    MemoryError = bindings::NV_ERR_MEMORY_ERROR,
+    MemoryTrainingFailed = bindings::NV_ERR_MEMORY_TRAINING_FAILED,
+    MismatchedSlave = bindings::NV_ERR_MISMATCHED_SLAVE,
+    MismatchedTarget = bindings::NV_ERR_MISMATCHED_TARGET,
+    MissingTableEntry = bindings::NV_ERR_MISSING_TABLE_ENTRY,
+    ModuleLoadFailed = bindings::NV_ERR_MODULE_LOAD_FAILED,
+    MoreDataAvailable = bindings::NV_ERR_MORE_DATA_AVAILABLE,
+    MoreProcessingRequired = bindings::NV_ERR_MORE_PROCESSING_REQUIRED,
+    MultipleMemoryTypes = bindings::NV_ERR_MULTIPLE_MEMORY_TYPES,
+    NoFreeFifos = bindings::NV_ERR_NO_FREE_FIFOS,
+    NoIntrPending = bindings::NV_ERR_NO_INTR_PENDING,
+    NoMemory = bindings::NV_ERR_NO_MEMORY,
+    NoSuchDomain = bindings::NV_ERR_NO_SUCH_DOMAIN,
+    NoValidPath = bindings::NV_ERR_NO_VALID_PATH,
+    NotCompatible = bindings::NV_ERR_NOT_COMPATIBLE,
+    NotReady = bindings::NV_ERR_NOT_READY,
+    NotSupported = bindings::NV_ERR_NOT_SUPPORTED,
+    NvlinkClockError = bindings::NV_ERR_NVLINK_CLOCK_ERROR,
+    NvlinkConfigurationError = bindings::NV_ERR_NVLINK_CONFIGURATION_ERROR,
+    NvlinkFabricFailure = bindings::NV_ERR_NVLINK_FABRIC_FAILURE,
+    NvlinkFabricNotReady = bindings::NV_ERR_NVLINK_FABRIC_NOT_READY,
+    NvlinkInitError = bindings::NV_ERR_NVLINK_INIT_ERROR,
+    NvlinkMinionError = bindings::NV_ERR_NVLINK_MINION_ERROR,
+    NvlinkTrainingError = bindings::NV_ERR_NVLINK_TRAINING_ERROR,
+    ObjectNotFound = bindings::NV_ERR_OBJECT_NOT_FOUND,
+    ObjectTypeMismatch = bindings::NV_ERR_OBJECT_TYPE_MISMATCH,
+    OperatingSystem = bindings::NV_ERR_OPERATING_SYSTEM,
+    OtherDeviceFound = bindings::NV_ERR_OTHER_DEVICE_FOUND,
+    OutOfRange = bindings::NV_ERR_OUT_OF_RANGE,
+    OverlappingUvmCommit = bindings::NV_ERR_OVERLAPPING_UVM_COMMIT,
+    PageTableNotAvail = bindings::NV_ERR_PAGE_TABLE_NOT_AVAIL,
+    PidNotFound = bindings::NV_ERR_PID_NOT_FOUND,
+    PmuNotReady = bindings::NV_ERR_PMU_NOT_READY,
+    PrivSecViolation = bindings::NV_ERR_PRIV_SEC_VIOLATION,
+    ProtectionFault = bindings::NV_ERR_PROTECTION_FAULT,
+    QueueTaskSlotNotAvailable = bindings::NV_ERR_QUEUE_TASK_SLOT_NOT_AVAILABLE,
+    RcError = bindings::NV_ERR_RC_ERROR,
+    ReductionManagerNotAvailable = bindings::NV_ERR_REDUCTION_MANAGER_NOT_AVAILABLE,
+    RejectedVbios = bindings::NV_ERR_REJECTED_VBIOS,
+    ResetRequired = bindings::NV_ERR_RESET_REQUIRED,
+    ResourceLost = bindings::NV_ERR_RESOURCE_LOST,
+    ResourceRetirementError = bindings::NV_ERR_RESOURCE_RETIREMENT_ERROR,
+    RiscvError = bindings::NV_ERR_RISCV_ERROR,
+    SecureBootFailed = bindings::NV_ERR_SECURE_BOOT_FAILED,
+    SignalPending = bindings::NV_ERR_SIGNAL_PENDING,
+    StateInUse = bindings::NV_ERR_STATE_IN_USE,
+    TestOnlyCodeNotEnabled = bindings::NV_ERR_TEST_ONLY_CODE_NOT_ENABLED,
+    Timeout = bindings::NV_ERR_TIMEOUT,
+    TimeoutRetry = bindings::NV_ERR_TIMEOUT_RETRY,
+    TooManyPrimaries = bindings::NV_ERR_TOO_MANY_PRIMARIES,
+    UvmAddressInUse = bindings::NV_ERR_UVM_ADDRESS_IN_USE,
+}
+
+impl From<GspMsgRmError> for Error {
+    fn from(status: GspMsgRmError) -> Self {
+        match status {
+            GspMsgRmError::BufferTooSmall | GspMsgRmError::MoreDataAvailable => ETOOSMALL,
+
+            GspMsgRmError::DmaInUse
+            | GspMsgRmError::DmaMemNotUnlocked
+            | GspMsgRmError::DualLinkInuse
+            | GspMsgRmError::GpuInDebugMode
+            | GspMsgRmError::GpuInFullchipReset
+            | GspMsgRmError::KeyRotationInProgress
+            | GspMsgRmError::NotReady
+            | GspMsgRmError::NvlinkFabricNotReady
+            | GspMsgRmError::PmuNotReady
+            | GspMsgRmError::StateInUse
+            | GspMsgRmError::UvmAddressInUse => EBUSY,
+
+            GspMsgRmError::CardNotPresent
+            | GspMsgRmError::FabricManagerNotPresent
+            | GspMsgRmError::GpuDmaNotInitialized
+            | GspMsgRmError::GpuIsLost
+            | GspMsgRmError::GpuUuidNotFound
+            | GspMsgRmError::OtherDeviceFound
+            | GspMsgRmError::ReductionManagerNotAvailable
+            | GspMsgRmError::ResetRequired => ENODEV,
+
+            GspMsgRmError::FeatureNotEnabled
+            | GspMsgRmError::FreqNotSupported
+            | GspMsgRmError::NotSupported
+            | GspMsgRmError::TestOnlyCodeNotEnabled => ENOTSUPP,
+
+            GspMsgRmError::CallbackNotScheduled
+            | GspMsgRmError::MissingTableEntry
+            | GspMsgRmError::NoIntrPending
+            | GspMsgRmError::NoSuchDomain
+            | GspMsgRmError::NoValidPath
+            | GspMsgRmError::ObjectNotFound
+            | GspMsgRmError::ResourceLost => ENOENT,
+
+            GspMsgRmError::DmaMemNotLocked
+            | GspMsgRmError::I2cSpeedTooHigh
+            | GspMsgRmError::InflateCompressedDataFailed
+            | GspMsgRmError::InvalidArgument
+            | GspMsgRmError::InvalidBase
+            | GspMsgRmError::InvalidChannel
+            | GspMsgRmError::InvalidClass
+            | GspMsgRmError::InvalidClient
+            | GspMsgRmError::InvalidCommand
+            | GspMsgRmError::InvalidData
+            | GspMsgRmError::InvalidDevice
+            | GspMsgRmError::InvalidDmaSpecifier
+            | GspMsgRmError::InvalidEvent
+            | GspMsgRmError::InvalidFlags
+            | GspMsgRmError::InvalidFunction
+            | GspMsgRmError::InvalidHeap
+            | GspMsgRmError::InvalidIndex
+            | GspMsgRmError::InvalidIrqLevel
+            | GspMsgRmError::InvalidLimit
+            | GspMsgRmError::InvalidLockState
+            | GspMsgRmError::InvalidMethod
+            | GspMsgRmError::InvalidObject
+            | GspMsgRmError::InvalidObjectBuffer
+            | GspMsgRmError::InvalidObjectHandle
+            | GspMsgRmError::InvalidObjectNew
+            | GspMsgRmError::InvalidObjectOld
+            | GspMsgRmError::InvalidObjectParent
+            | GspMsgRmError::InvalidOffset
+            | GspMsgRmError::InvalidOperation
+            | GspMsgRmError::InvalidOwner
+            | GspMsgRmError::InvalidParamStruct
+            | GspMsgRmError::InvalidParameter
+            | GspMsgRmError::InvalidPath
+            | GspMsgRmError::InvalidRegistryKey
+            | GspMsgRmError::InvalidRequest
+            | GspMsgRmError::InvalidState
+            | GspMsgRmError::InvalidStringLength
+            | GspMsgRmError::InvalidXlate
+            | GspMsgRmError::LibRmVersionMismatch
+            | GspMsgRmError::MismatchedSlave
+            | GspMsgRmError::MismatchedTarget
+            | GspMsgRmError::MultipleMemoryTypes
+            | GspMsgRmError::NotCompatible
+            | GspMsgRmError::ObjectTypeMismatch
+            | GspMsgRmError::OverlappingUvmCommit
+            | GspMsgRmError::RejectedVbios => EINVAL,
+
+            GspMsgRmError::IllegalAction | GspMsgRmError::InsufficientPermissions => EPERM,
+
+            GspMsgRmError::AlreadySignalled
+            | GspMsgRmError::InUse
+            | GspMsgRmError::InsertDuplicateName => EEXIST,
+
+            GspMsgRmError::FifoBadAccess
+            | GspMsgRmError::InvalidAccessType
+            | GspMsgRmError::InvalidLicense
+            | GspMsgRmError::PrivSecViolation
+            | GspMsgRmError::SecureBootFailed => EACCES,
+
+            GspMsgRmError::GpuMemoryOnliningFailure
+            | GspMsgRmError::InsufficientResources
+            | GspMsgRmError::NoMemory
+            | GspMsgRmError::PageTableNotAvail => ENOMEM,
+
+            GspMsgRmError::InsufficientZbcEntry
+            | GspMsgRmError::MaxSessionLimitReached
+            | GspMsgRmError::NoFreeFifos
+            | GspMsgRmError::QueueTaskSlotNotAvailable
+            | GspMsgRmError::TooManyPrimaries => ENOSPC,
+
+            GspMsgRmError::InvalidAddress
+            | GspMsgRmError::InvalidPointer
+            | GspMsgRmError::InvalidRead
+            | GspMsgRmError::InvalidWrite
+            | GspMsgRmError::ProtectionFault => EFAULT,
+
+            GspMsgRmError::BusyRetry
+            | GspMsgRmError::GpuNotFullPower
+            | GspMsgRmError::HotSwitch
+            | GspMsgRmError::InsufficientPower
+            | GspMsgRmError::MoreProcessingRequired => EAGAIN,
+
+            GspMsgRmError::OutOfRange => EOVERFLOW,
+
+            GspMsgRmError::PidNotFound => ESRCH,
+
+            GspMsgRmError::SignalPending => EINTR,
+
+            GspMsgRmError::Timeout | GspMsgRmError::TimeoutRetry => ETIMEDOUT,
+
+            GspMsgRmError::ModuleLoadFailed => ENXIO,
+
+            GspMsgRmError::BrokenFb
+            | GspMsgRmError::CycleDetected
+            | GspMsgRmError::EccError
+            | GspMsgRmError::FatalError
+            | GspMsgRmError::FlcnError
+            | GspMsgRmError::Generic
+            | GspMsgRmError::I2cError
+            | GspMsgRmError::IrqEdgeTriggered
+            | GspMsgRmError::IrqNotFiring
+            | GspMsgRmError::MemoryError
+            | GspMsgRmError::MemoryTrainingFailed
+            | GspMsgRmError::NvlinkClockError
+            | GspMsgRmError::NvlinkConfigurationError
+            | GspMsgRmError::NvlinkFabricFailure
+            | GspMsgRmError::NvlinkInitError
+            | GspMsgRmError::NvlinkMinionError
+            | GspMsgRmError::NvlinkTrainingError
+            | GspMsgRmError::OperatingSystem
+            | GspMsgRmError::RcError
+            | GspMsgRmError::ResourceRetirementError
+            | GspMsgRmError::RiscvError => EIO,
+        }
+    }
+}
+
+// TODO[FPRI]: This is a temporary solution to be replaced with the corresponding derive macros
+// once they land.
+impl TryFrom<u32> for GspMsgRmError {
+    type Error = Error;
+
+    fn try_from(value: u32) -> Result<Self> {
+        match value {
+            bindings::NV_ERR_ALREADY_SIGNALLED => Ok(Self::AlreadySignalled),
+            bindings::NV_ERR_BROKEN_FB => Ok(Self::BrokenFb),
+            bindings::NV_ERR_BUFFER_TOO_SMALL => Ok(Self::BufferTooSmall),
+            bindings::NV_ERR_BUSY_RETRY => Ok(Self::BusyRetry),
+            bindings::NV_ERR_CALLBACK_NOT_SCHEDULED => Ok(Self::CallbackNotScheduled),
+            bindings::NV_ERR_CARD_NOT_PRESENT => Ok(Self::CardNotPresent),
+            bindings::NV_ERR_CYCLE_DETECTED => Ok(Self::CycleDetected),
+            bindings::NV_ERR_DMA_IN_USE => Ok(Self::DmaInUse),
+            bindings::NV_ERR_DMA_MEM_NOT_LOCKED => Ok(Self::DmaMemNotLocked),
+            bindings::NV_ERR_DMA_MEM_NOT_UNLOCKED => Ok(Self::DmaMemNotUnlocked),
+            bindings::NV_ERR_DUAL_LINK_INUSE => Ok(Self::DualLinkInuse),
+            bindings::NV_ERR_ECC_ERROR => Ok(Self::EccError),
+            bindings::NV_ERR_FABRIC_MANAGER_NOT_PRESENT => Ok(Self::FabricManagerNotPresent),
+            bindings::NV_ERR_FATAL_ERROR => Ok(Self::FatalError),
+            bindings::NV_ERR_FEATURE_NOT_ENABLED => Ok(Self::FeatureNotEnabled),
+            bindings::NV_ERR_FIFO_BAD_ACCESS => Ok(Self::FifoBadAccess),
+            bindings::NV_ERR_FLCN_ERROR => Ok(Self::FlcnError),
+            bindings::NV_ERR_FREQ_NOT_SUPPORTED => Ok(Self::FreqNotSupported),
+            bindings::NV_ERR_GENERIC => Ok(Self::Generic),
+            bindings::NV_ERR_GPU_DMA_NOT_INITIALIZED => Ok(Self::GpuDmaNotInitialized),
+            bindings::NV_ERR_GPU_IN_DEBUG_MODE => Ok(Self::GpuInDebugMode),
+            bindings::NV_ERR_GPU_IN_FULLCHIP_RESET => Ok(Self::GpuInFullchipReset),
+            bindings::NV_ERR_GPU_IS_LOST => Ok(Self::GpuIsLost),
+            bindings::NV_ERR_GPU_MEMORY_ONLINING_FAILURE => Ok(Self::GpuMemoryOnliningFailure),
+            bindings::NV_ERR_GPU_NOT_FULL_POWER => Ok(Self::GpuNotFullPower),
+            bindings::NV_ERR_GPU_UUID_NOT_FOUND => Ok(Self::GpuUuidNotFound),
+            bindings::NV_ERR_HOT_SWITCH => Ok(Self::HotSwitch),
+            bindings::NV_ERR_I2C_ERROR => Ok(Self::I2cError),
+            bindings::NV_ERR_I2C_SPEED_TOO_HIGH => Ok(Self::I2cSpeedTooHigh),
+            bindings::NV_ERR_ILLEGAL_ACTION => Ok(Self::IllegalAction),
+            bindings::NV_ERR_IN_USE => Ok(Self::InUse),
+            bindings::NV_ERR_INFLATE_COMPRESSED_DATA_FAILED => {
+                Ok(Self::InflateCompressedDataFailed)
+            }
+            bindings::NV_ERR_INSERT_DUPLICATE_NAME => Ok(Self::InsertDuplicateName),
+            bindings::NV_ERR_INSUFFICIENT_PERMISSIONS => Ok(Self::InsufficientPermissions),
+            bindings::NV_ERR_INSUFFICIENT_POWER => Ok(Self::InsufficientPower),
+            bindings::NV_ERR_INSUFFICIENT_RESOURCES => Ok(Self::InsufficientResources),
+            bindings::NV_ERR_INSUFFICIENT_ZBC_ENTRY => Ok(Self::InsufficientZbcEntry),
+            bindings::NV_ERR_INVALID_ACCESS_TYPE => Ok(Self::InvalidAccessType),
+            bindings::NV_ERR_INVALID_ADDRESS => Ok(Self::InvalidAddress),
+            bindings::NV_ERR_INVALID_ARGUMENT => Ok(Self::InvalidArgument),
+            bindings::NV_ERR_INVALID_BASE => Ok(Self::InvalidBase),
+            bindings::NV_ERR_INVALID_CHANNEL => Ok(Self::InvalidChannel),
+            bindings::NV_ERR_INVALID_CLASS => Ok(Self::InvalidClass),
+            bindings::NV_ERR_INVALID_CLIENT => Ok(Self::InvalidClient),
+            bindings::NV_ERR_INVALID_COMMAND => Ok(Self::InvalidCommand),
+            bindings::NV_ERR_INVALID_DATA => Ok(Self::InvalidData),
+            bindings::NV_ERR_INVALID_DEVICE => Ok(Self::InvalidDevice),
+            bindings::NV_ERR_INVALID_DMA_SPECIFIER => Ok(Self::InvalidDmaSpecifier),
+            bindings::NV_ERR_INVALID_EVENT => Ok(Self::InvalidEvent),
+            bindings::NV_ERR_INVALID_FLAGS => Ok(Self::InvalidFlags),
+            bindings::NV_ERR_INVALID_FUNCTION => Ok(Self::InvalidFunction),
+            bindings::NV_ERR_INVALID_HEAP => Ok(Self::InvalidHeap),
+            bindings::NV_ERR_INVALID_INDEX => Ok(Self::InvalidIndex),
+            bindings::NV_ERR_INVALID_IRQ_LEVEL => Ok(Self::InvalidIrqLevel),
+            bindings::NV_ERR_INVALID_LICENSE => Ok(Self::InvalidLicense),
+            bindings::NV_ERR_INVALID_LIMIT => Ok(Self::InvalidLimit),
+            bindings::NV_ERR_INVALID_LOCK_STATE => Ok(Self::InvalidLockState),
+            bindings::NV_ERR_INVALID_METHOD => Ok(Self::InvalidMethod),
+            bindings::NV_ERR_INVALID_OBJECT => Ok(Self::InvalidObject),
+            bindings::NV_ERR_INVALID_OBJECT_BUFFER => Ok(Self::InvalidObjectBuffer),
+            bindings::NV_ERR_INVALID_OBJECT_HANDLE => Ok(Self::InvalidObjectHandle),
+            bindings::NV_ERR_INVALID_OBJECT_NEW => Ok(Self::InvalidObjectNew),
+            bindings::NV_ERR_INVALID_OBJECT_OLD => Ok(Self::InvalidObjectOld),
+            bindings::NV_ERR_INVALID_OBJECT_PARENT => Ok(Self::InvalidObjectParent),
+            bindings::NV_ERR_INVALID_OFFSET => Ok(Self::InvalidOffset),
+            bindings::NV_ERR_INVALID_OPERATION => Ok(Self::InvalidOperation),
+            bindings::NV_ERR_INVALID_OWNER => Ok(Self::InvalidOwner),
+            bindings::NV_ERR_INVALID_PARAM_STRUCT => Ok(Self::InvalidParamStruct),
+            bindings::NV_ERR_INVALID_PARAMETER => Ok(Self::InvalidParameter),
+            bindings::NV_ERR_INVALID_PATH => Ok(Self::InvalidPath),
+            bindings::NV_ERR_INVALID_POINTER => Ok(Self::InvalidPointer),
+            bindings::NV_ERR_INVALID_READ => Ok(Self::InvalidRead),
+            bindings::NV_ERR_INVALID_REGISTRY_KEY => Ok(Self::InvalidRegistryKey),
+            bindings::NV_ERR_INVALID_REQUEST => Ok(Self::InvalidRequest),
+            bindings::NV_ERR_INVALID_STATE => Ok(Self::InvalidState),
+            bindings::NV_ERR_INVALID_STRING_LENGTH => Ok(Self::InvalidStringLength),
+            bindings::NV_ERR_INVALID_WRITE => Ok(Self::InvalidWrite),
+            bindings::NV_ERR_INVALID_XLATE => Ok(Self::InvalidXlate),
+            bindings::NV_ERR_IRQ_EDGE_TRIGGERED => Ok(Self::IrqEdgeTriggered),
+            bindings::NV_ERR_IRQ_NOT_FIRING => Ok(Self::IrqNotFiring),
+            bindings::NV_ERR_KEY_ROTATION_IN_PROGRESS => Ok(Self::KeyRotationInProgress),
+            bindings::NV_ERR_LIB_RM_VERSION_MISMATCH => Ok(Self::LibRmVersionMismatch),
+            bindings::NV_ERR_MAX_SESSION_LIMIT_REACHED => Ok(Self::MaxSessionLimitReached),
+            bindings::NV_ERR_MEMORY_ERROR => Ok(Self::MemoryError),
+            bindings::NV_ERR_MEMORY_TRAINING_FAILED => Ok(Self::MemoryTrainingFailed),
+            bindings::NV_ERR_MISMATCHED_SLAVE => Ok(Self::MismatchedSlave),
+            bindings::NV_ERR_MISMATCHED_TARGET => Ok(Self::MismatchedTarget),
+            bindings::NV_ERR_MISSING_TABLE_ENTRY => Ok(Self::MissingTableEntry),
+            bindings::NV_ERR_MODULE_LOAD_FAILED => Ok(Self::ModuleLoadFailed),
+            bindings::NV_ERR_MORE_DATA_AVAILABLE => Ok(Self::MoreDataAvailable),
+            bindings::NV_ERR_MORE_PROCESSING_REQUIRED => Ok(Self::MoreProcessingRequired),
+            bindings::NV_ERR_MULTIPLE_MEMORY_TYPES => Ok(Self::MultipleMemoryTypes),
+            bindings::NV_ERR_NO_FREE_FIFOS => Ok(Self::NoFreeFifos),
+            bindings::NV_ERR_NO_INTR_PENDING => Ok(Self::NoIntrPending),
+            bindings::NV_ERR_NO_MEMORY => Ok(Self::NoMemory),
+            bindings::NV_ERR_NO_SUCH_DOMAIN => Ok(Self::NoSuchDomain),
+            bindings::NV_ERR_NO_VALID_PATH => Ok(Self::NoValidPath),
+            bindings::NV_ERR_NOT_COMPATIBLE => Ok(Self::NotCompatible),
+            bindings::NV_ERR_NOT_READY => Ok(Self::NotReady),
+            bindings::NV_ERR_NOT_SUPPORTED => Ok(Self::NotSupported),
+            bindings::NV_ERR_NVLINK_CLOCK_ERROR => Ok(Self::NvlinkClockError),
+            bindings::NV_ERR_NVLINK_CONFIGURATION_ERROR => Ok(Self::NvlinkConfigurationError),
+            bindings::NV_ERR_NVLINK_FABRIC_FAILURE => Ok(Self::NvlinkFabricFailure),
+            bindings::NV_ERR_NVLINK_FABRIC_NOT_READY => Ok(Self::NvlinkFabricNotReady),
+            bindings::NV_ERR_NVLINK_INIT_ERROR => Ok(Self::NvlinkInitError),
+            bindings::NV_ERR_NVLINK_MINION_ERROR => Ok(Self::NvlinkMinionError),
+            bindings::NV_ERR_NVLINK_TRAINING_ERROR => Ok(Self::NvlinkTrainingError),
+            bindings::NV_ERR_OBJECT_NOT_FOUND => Ok(Self::ObjectNotFound),
+            bindings::NV_ERR_OBJECT_TYPE_MISMATCH => Ok(Self::ObjectTypeMismatch),
+            bindings::NV_ERR_OPERATING_SYSTEM => Ok(Self::OperatingSystem),
+            bindings::NV_ERR_OTHER_DEVICE_FOUND => Ok(Self::OtherDeviceFound),
+            bindings::NV_ERR_OUT_OF_RANGE => Ok(Self::OutOfRange),
+            bindings::NV_ERR_OVERLAPPING_UVM_COMMIT => Ok(Self::OverlappingUvmCommit),
+            bindings::NV_ERR_PAGE_TABLE_NOT_AVAIL => Ok(Self::PageTableNotAvail),
+            bindings::NV_ERR_PID_NOT_FOUND => Ok(Self::PidNotFound),
+            bindings::NV_ERR_PMU_NOT_READY => Ok(Self::PmuNotReady),
+            bindings::NV_ERR_PRIV_SEC_VIOLATION => Ok(Self::PrivSecViolation),
+            bindings::NV_ERR_PROTECTION_FAULT => Ok(Self::ProtectionFault),
+            bindings::NV_ERR_QUEUE_TASK_SLOT_NOT_AVAILABLE => Ok(Self::QueueTaskSlotNotAvailable),
+            bindings::NV_ERR_RC_ERROR => Ok(Self::RcError),
+            bindings::NV_ERR_REDUCTION_MANAGER_NOT_AVAILABLE => {
+                Ok(Self::ReductionManagerNotAvailable)
+            }
+            bindings::NV_ERR_REJECTED_VBIOS => Ok(Self::RejectedVbios),
+            bindings::NV_ERR_RESET_REQUIRED => Ok(Self::ResetRequired),
+            bindings::NV_ERR_RESOURCE_LOST => Ok(Self::ResourceLost),
+            bindings::NV_ERR_RESOURCE_RETIREMENT_ERROR => Ok(Self::ResourceRetirementError),
+            bindings::NV_ERR_RISCV_ERROR => Ok(Self::RiscvError),
+            bindings::NV_ERR_SECURE_BOOT_FAILED => Ok(Self::SecureBootFailed),
+            bindings::NV_ERR_SIGNAL_PENDING => Ok(Self::SignalPending),
+            bindings::NV_ERR_STATE_IN_USE => Ok(Self::StateInUse),
+            bindings::NV_ERR_TEST_ONLY_CODE_NOT_ENABLED => Ok(Self::TestOnlyCodeNotEnabled),
+            bindings::NV_ERR_TIMEOUT => Ok(Self::Timeout),
+            bindings::NV_ERR_TIMEOUT_RETRY => Ok(Self::TimeoutRetry),
+            bindings::NV_ERR_TOO_MANY_PRIMARIES => Ok(Self::TooManyPrimaries),
+            bindings::NV_ERR_UVM_ADDRESS_IN_USE => Ok(Self::UvmAddressInUse),
+            _ => Err(EINVAL),
+        }
+    }
+}
+
+impl TryFrom<u32> for GspMsgRmStatus {
+    type Error = Error;
+
+    fn try_from(value: u32) -> Result<Self> {
+        if value == bindings::NV_OK {
+            return Ok(Self::Ok);
+        }
+
+        if let Ok(warning) = GspMsgRmWarning::try_from(value) {
+            return Ok(Self::Warning(warning));
+        }
+
+        Ok(Self::Error(GspMsgRmError::try_from(value)?))
+    }
+}
+
 /// Empty type to group methods related to heap parameters for running the GSP firmware.
 enum GspFwHeapParams {}
 

-- 
2.53.0

