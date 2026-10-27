Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE76606A31B
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 07:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=idW0dpXs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9742B10F2B9;
	Tue, 27 Oct 2026 07:36:38 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011068.outbound.protection.outlook.com [40.107.208.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98C9210F2B2
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 07:36:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kZMr0ZDpEzkdDrt+qIpObv/pLXRLL58t6wzKoFwSTyuMAn2RgSLp6w93BUdZvMaa6QUqBFhy5hyo81sblfXr+ezAT1jj1dJa091UpuxRI6NxeNaRuJ8xfkQupkwYBSx3vyie6Ep9XfeSVOtE8FXePA4HOfO+b4JfwTVdDh+l3wE1nRcN5McK/EMTUM9+mZ3y/udlMtR/TP8WD9JwPKViE5fr1mmgCt07HVptOSvQH7sIwVJOTZJIEbRy54jqDhPxSbMmcdE2C4+ZfoXiI7gYaVRjs3pDYQityRdW+kgOR02GwkSi39q4QYPpDLIkMCIRhsi3MoRL2Bpiq6kJuJvpNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cv0Ch1LppCYiv3p0gJ36zBRbMRSGsiA4S/0fELGP9rk=;
 b=U5s5VpabyJBaFikG8YlPuGjoWRoXiefQKpmZwSHxrjA8VpHBf1ywsSeT805CQI+Yry3pBmmK+fQK+hxJghlpHm7BYctLHOuqYXi56ZbVc8o/Fj65gmmhcypljzNb8uF4aT1xTmREiMhDekr9TFBnI6jFVC/xQEkucr005GhQ+4b3jgNbeKa0zkvnVgtKWOkD5g3kVXwYF6CSnujHKZhUX4B1LvIRHWpH0bAQNSrgk+Lwy8gfBpTL2R/l8fHUTZKc5PNcjyq8S/Q6La5+v3GuN7bWs/6FAF50YQOCdTEmrB2/erObgAd5lq2fNAX9AYUEAVKcUeigmnQBdJP4Kfc8PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cv0Ch1LppCYiv3p0gJ36zBRbMRSGsiA4S/0fELGP9rk=;
 b=idW0dpXstYKIGzKUEvrYzkR8dHWlmd5Gu4r9SG4CWBxMJPHoVbOUlZmYDBSpRX1eKzTmUvqpGPl2X+bXZC6ZHayCn7dZa0zz14Kk8OXXvj8hKNI52gRW+rk578sZuyMyxEduaZ88hhXS2IRISBpHRWLTd+t2u5XkVcrWSDrXZm5KJKI6s9M3w12JOG7JrjcuoaJi9Y9usMoKinjvYbUynZIdZpoZtJMe6wOzVYEVkV/Gtp8W9jUKOQwhaQ0B9FXmDxPIih4GeV/YDA0XMoPzjmAH5DzfzoMMATvx54w3QzSe8JzOjyL0Y9+QGiAvsglgzL4hHoi7a/KW+py9uB7Rhw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by DM4PR12MB8451.namprd12.prod.outlook.com (2603:10b6:8:182::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 07:36:11 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 07:36:10 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Tue, 27 Oct 2026 16:35:50 +0900
Subject: [PATCH v6 07/15] gpu: nova-core: gsp: cmdq: split RPC parsing part
 of the receive path
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261027-cmdq-rpc-v6-7-bed9669724ba@nvidia.com>
References: <20261027-cmdq-rpc-v6-0-bed9669724ba@nvidia.com>
In-Reply-To: <20261027-cmdq-rpc-v6-0-bed9669724ba@nvidia.com>
To: John Hubbard <jhubbard@nvidia.com>, Danilo Krummrich <dakr@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Benno Lossin <lossin@kernel.org>, 
 Gary Guo <gary@garyguo.net>
Cc: Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY4PR01CA0065.jpnprd01.prod.outlook.com
 (2603:1096:405:370::19) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|DM4PR12MB8451:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bc63bce-dd20-4318-f9ea-08df33fcf8b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|7416014|376014|10070799003|261026121527099003|261021123027099003|56012099006|11063799006|261021135927099003|261022105027099003|261009223027099003|261022075727099003|261021121427099003|10067099003|22082099003|18002099003|261026140227099003|3023799007;
X-Microsoft-Antispam-Message-Info: 1nqeL1TTooJb0fDIiElex8f3z37DDpeZQeYUGF/2lyzeRyD6QhpC3x/y7y2WVh44nqhr2KDSK0mfW63Rv7k9Pi30YXLPd/Qwkqn+kIIzlcd/L+8+iuiP1m/n6QxTBGr/36t8qp9yU1pB99Qz3RP4CNWNMyW59CyoJb9balNWADemnNK6BeNGWErhB2aKftZT4A5Ed3fzfuYYh8X485ED6EJDqt9Bzay0ll0LFxSrkBMpGzeuZUpM7BQw4C/hOQepqgl3n5T+EjfQMDro3yqfv+FwfIU6zo76Fty0N2L2NIRUzbaldZhXEWSSgbLaWNTrVn4UzLEdeiPYRWc+XNiSMn+mTMqPOEg1yuip3si/qCd0G5DRwv4kFsRCS6ZseXylO7LG5/bvXSQZ3IOLIBko1sS6HgyUvjtiUu9xjGid/TuZjTGpl0l6tTPmf7Sk92f/8qnoLfTQDudr0WLVDcttORNluPPhYP/hNaT0kxiiefRByOuJDfLqB2bdjT1tujDn4mDlXzubY3wbpvDAc9lyNdGhnzw6ZW4tE+zBmrquJBx2ZFtFyI4ZzOCtZ1BeD3uLd0Luf6SouKegLFOG0nbScb5D03gHkOakl/CGCuS3LuLKbMonWbPbj5IvHy2FHWnXxMW9XwmtTTArUvjAbIWa9Htw1Q/+zInALL3i3q3IYuY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(10070799003)(261026121527099003)(261021123027099003)(56012099006)(11063799006)(261021135927099003)(261022105027099003)(261009223027099003)(261022075727099003)(261021121427099003)(10067099003)(22082099003)(18002099003)(261026140227099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWZwVDJ5YWg3RmdDVUhWUFlWckdKRGdIKzZxSDdqeDhseHAzTUh3cGpDdTc3?=
 =?utf-8?B?TWMvQ0wvVVVzZTB2RkFHRUt5WUtDbU1zUXRERTN2QkRtVCthZXZjT3p0WFVy?=
 =?utf-8?B?VnJlSjNwYm5SVTBLQnVucTU0dlZwdXRWeVFqV0xiellBTkVVb1RUc0pIbm9M?=
 =?utf-8?B?c25pTTcxWk84REFOdkNoS3R5TVR2ZkNNdElqalV0VUpJTXR5WFd5NE8vVzVy?=
 =?utf-8?B?dU1iT1hpQkFqVlE2ZUo4dWUrc0Zmb1p5NU1Vb2YzTUl2am14clVVYTBGenlq?=
 =?utf-8?B?NUZFa051RUo1b1FTNUloQVNkYnJyQzZRcWNmajQxR0h4N2oyNUl1RWNyYlNS?=
 =?utf-8?B?a2ZuYXlpdEMvY1VUZ25taHp1aTZLaU94U1ppQklRU2JWRzZHdWcxcEFvSFY5?=
 =?utf-8?B?THI4RWZLTFZKSFBOMkFMZTFTTWNyRlNsS2lmM1Y2QnJaUkR5QWNLeWVteDlU?=
 =?utf-8?B?UkJrdlQvekZORWZ2cThTNXJwNjZtMEhVOE1NVmsrRlovTzFKMFBDS1AveUQw?=
 =?utf-8?B?SVFHR2Q2ajdYZjBvV3c3cTJrenlIS0k2Z3B1SFRJblV0OWgrQjNKNU9QOS9P?=
 =?utf-8?B?MDQ1SGNlQ1lqRXc3Unc5UlMrTmFoWXllb3BLNm10c0tMSzArR295MnpwK0pZ?=
 =?utf-8?B?dk9xUk5vU09mS1pRRlZndmVyN3BWcUJuODZtam9NeTUxcGovK0owVU41UEY3?=
 =?utf-8?B?WHVwekRnMS94M0xobjZxYmwvcnNXVnFscHVHSmxMTWN1dnJMYlpyU2RqZzRR?=
 =?utf-8?B?M1ZnVkZHaGxEd1d0NUNsRldzL2VUZU9aSmNWT1F5alh4UjYwWkhrWlNVUy9S?=
 =?utf-8?B?a09oNTFBL2Q1cWtWS3Vwb055bXZqNVpVTi9VQ2UrbXZyYnNGVUg4SjhOVlBt?=
 =?utf-8?B?d0wyZE50TGduOHhYUTdldWhCOGFsRE9JSnhmaEJjYTg2a1FDbCs1V2lGcFhY?=
 =?utf-8?B?Nmg0VkJIY0EyeDNRLzN1dHIyZTV6bE0zR1ExT3o2ZzNFNCtYTUpSUWNwbU9T?=
 =?utf-8?B?Q3QxMDdFbnF4WFQ1ZS9obTlweWZ1bnVTOVI1MzVpSEl3NlA5Zm9VTldBRmJh?=
 =?utf-8?B?RlRleldMTm1jNyt4bTJLRENJTmlNNUZVbXJmMXVCd21rVm5pU2hvdTFFWlFQ?=
 =?utf-8?B?Z0hac3luS0MyRENnZTd3S2lMOVArSjVlRHdxdkR5ajkvZ0puZEZJZ1lBNTRM?=
 =?utf-8?B?OWlaZlBtMjdCd3QvcXdMci84MXMxL0Jsb050Y0tjQll4dVNrSWdHeUFWZ0Q1?=
 =?utf-8?B?cGhyN08vYTBFQ1d6NG93WHYxY2FpYWlKS25BeHczeWxGS3FSS0ZyT0x3NUhE?=
 =?utf-8?B?OHpTcHdIUTlJYWlpZW5pZkd5TmVLTzFlTFc1djF3RzBTTzhQUVdwQW5VTmxN?=
 =?utf-8?B?U3JTRmZmdXVTWUNzVTJBZDlHU2dzYUxoSlFJeThydkxVRExtd3pLak5sSk0r?=
 =?utf-8?B?azB5bmVjYWlNekZzb1FkWURtT2h3TDNLMTNUK1hzdDVqZzk1WWtIZUxRT1Zv?=
 =?utf-8?B?anJoSUVnNUcxV0tPR3UzdVJPem5vYjFYdWFBRFcyR0ZaOHBFdUV0VnZUb1Rk?=
 =?utf-8?B?SHUrTHRzNkhWRVVtdXBtWFBnQlhUZWZVL3AvK2VrSGh3T2R4M3ArUWJFcmFt?=
 =?utf-8?B?aXBXay9WeFFLcU5YQ0twV2o4ZEgvd0g3NlRjYkdvRk1WYkpNRlNiWTkzV2g2?=
 =?utf-8?B?M29sWGFpUzNnbmEyNlpuZHV0WmdYQ1IvZGg4ZmdPTEVLYzFYOVZ1SzRkZ3Qw?=
 =?utf-8?B?M0NWREY4dmI4eFZNaFp2bVQ4bCtRRHRIOEJnTHA2R1RJSlNOZmlJS2lKUVFR?=
 =?utf-8?B?V0prQXgyNkV3Q3N2dDNkZmJzUHJwSG1uaVBYVytVVm1QdUk1YnUrU0VQYnlk?=
 =?utf-8?B?bEdwODNWQ2I3OEcwU0hDMTl5RDE4STJTK1FiMGVqamEwTzFoZ0g5OUF1T1Zu?=
 =?utf-8?B?NFBtVDJXeGlhQjRMOHNUU3hrSk10WU0xYURLWlBUMk15RnpVN2xhRExHWmpX?=
 =?utf-8?B?OU5ZUStrMFFGUnpqU2NmZ05wekttQ0FCV2dDUS9NT0prbUs5TW52UWp2R0hh?=
 =?utf-8?B?bDV3RTFpeUtzL0cyc3p2WWVpd1dLalRWdVpRVWppRFVDbVdacnp4aEd1UmxM?=
 =?utf-8?B?TTJZdFRoOVc0RjdqSVRHbUxZM2ZPcCthRXI0NkN2bjMxL2w1MjFmUFRDWXZZ?=
 =?utf-8?B?Rjh5YW43ZE5Ob0RaanRTRHRCV2FKa1FRVFVUdTlnM283Qlpta2tPTlk3WEZo?=
 =?utf-8?B?VVFzR0VEdGx1ckdvcVZQTzFTWi9LWEFQaXhETm4xNkdoYVI4c2VIRGxkTkM3?=
 =?utf-8?B?Q2VoNU5Vc0hZLy8zWTRaOVdtcFFMN1RLMjRQYlpsekNjMHgwY2Vxc1AwZGU1?=
 =?utf-8?Q?LFW/oXOV9seNirkOYrbt0kGDs3nTX/BhcUu6SvWmY3vxq?=
X-MS-Exchange-AntiSpam-MessageData-1: vizOz7Cwq2s7yQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bc63bce-dd20-4318-f9ea-08df33fcf8b0
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 07:36:10.8336 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vtrNpoDoajikN5chPB62E1sdzdcwtLKMih/YPTV4Q49lweVqZL9Xld+Z7JJPvaOK3G6sbDtTZZr7AacNq3+GGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8451
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The RPC parsing should not be done in the same method as the transport
header parsing. Split it out and introduce a `RpcMessage` type to
indicate messages that have been successfully parsed as RPC. This makes
the code easier to move around into its new destination.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gsp/cmdq.rs | 112 ++++++++++++++++++++++++--------------
 1 file changed, 70 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index ef59f541f7e6..18861400c3be 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -554,11 +554,69 @@ struct GspCommand<'a> {
 struct GspMessage<'a> {
     // Reference to the header of the message.
     header: &'a GspMsgElement,
-    // Slices to the contents of the message. The second slice is zero unless the message loops
+    // Slices to the contents of the message. The second slice is empty unless the message loops
     // over the message queue.
     contents: (&'a [u8], &'a [u8]),
 }
 
+/// A RPC message ready to be processed from the message queue.
+struct RpcMessage<'a> {
+    // Reference to the RPC header of the message.
+    header: &'a RpcMessageHeader,
+    // Slices to the contents of the message. The second slice is empty unless the message loops
+    // over the message queue.
+    contents: (&'a [u8], &'a [u8]),
+}
+
+impl<'a> RpcMessage<'a> {
+    /// Validate the RPC layer of `element` and returns its RPC header and its contents trimmed down
+    /// to the RPC payload.
+    ///
+    /// # Errors
+    ///
+    /// - `EIO` if the element is shorter than the payload length advertised by the RPC header.
+    fn parse(dev: &device::Device, element: GspMessage<'a>) -> Result<RpcMessage<'a>> {
+        let GspMessage {
+            header,
+            contents: (slice_1, slice_2),
+        } = element;
+
+        let rpc_header = header.rpc_header();
+        let payload_length = rpc_header.rpc_length();
+
+        dev_dbg!(
+            dev,
+            "GSP RPC: receive: seq# {}, function={:?}, length=0x{:x}\n",
+            rpc_header.sequence(),
+            rpc_header.function(),
+            payload_length,
+        );
+
+        // Check that the driver read area is large enough for the message.
+        if slice_1.len() + slice_2.len() < payload_length {
+            return Err(EIO);
+        }
+
+        // Cut the message slices down to the actual length of the message.
+        let (slice_1, slice_2) = if slice_1.len() > payload_length {
+            // PANIC: we checked above that `slice_1` is at least as long as `payload_length`.
+            (slice_1.split_at(payload_length).0, &slice_2[0..0])
+        } else {
+            (
+                slice_1,
+                // PANIC: we checked above that `slice_1.len() + slice_2.len()` is at least as
+                // large as `payload_length`.
+                slice_2.split_at(payload_length - slice_1.len()).0,
+            )
+        };
+
+        Ok(RpcMessage {
+            header: rpc_header,
+            contents: (slice_1, slice_2),
+        })
+    }
+}
+
 /// GSP command queue.
 ///
 /// Provides the ability to send commands and receive messages from the GSP using a shared memory
@@ -838,35 +896,6 @@ fn wait_for_msg(&self, timeout: Delta) -> Result<GspMessage<'_>> {
             return Err(EIO);
         }
 
-        let rpc_header = header.rpc_header();
-        let payload_length = rpc_header.rpc_length();
-
-        dev_dbg!(
-            &self.dev,
-            "GSP RPC: receive: seq# {}, function={:?}, length=0x{:x}\n",
-            rpc_header.sequence(),
-            rpc_header.function(),
-            payload_length,
-        );
-
-        // Check that the driver read area is large enough for the message.
-        if slice_1.len() + slice_2.len() < payload_length {
-            return Err(EIO);
-        }
-
-        // Cut the message slices down to the actual length of the message.
-        let (slice_1, slice_2) = if slice_1.len() > payload_length {
-            // PANIC: we checked above that `slice_1` is at least as long as `payload_length`.
-            (slice_1.split_at(payload_length).0, &slice_2[0..0])
-        } else {
-            (
-                slice_1,
-                // PANIC: we checked above that `slice_1.len() + slice_2.len()` is at least as
-                // large as `payload_length`.
-                slice_2.split_at(payload_length - slice_1.len()).0,
-            )
-        };
-
         Ok(GspMessage {
             header,
             contents: (slice_1, slice_2),
@@ -893,14 +922,15 @@ fn receive_msg<M: MessageFromGsp>(&mut self, timeout: Delta) -> Result<M>
         Error: From<M::InitError>,
     {
         let message = self.wait_for_msg(timeout)?;
-        let rpc_header = message.header.rpc_header();
-        let function = rpc_header.function();
-        let seq = rpc_header.sequence();
+        let elem_count = u32::try_from(message.header.msg_length().div_ceil(GSP_PAGE_SIZE))?;
+        let rpc_message = RpcMessage::parse(self.dev, message)?;
+        let function = rpc_message.header.function();
 
         // An early return here would leave the read pointer on this message.
         let result = if matches!(function, Ok(f) if f == M::FUNCTION) {
-            let (cmd, contents_1) = M::Message::from_bytes_prefix(message.contents.0).ok_or(EIO)?;
-            let mut sbuffer = SBufferIter::new_reader([contents_1, message.contents.1]);
+            let (cmd, contents_1) =
+                M::Message::from_bytes_prefix(rpc_message.contents.0).ok_or(EIO)?;
+            let mut sbuffer = SBufferIter::new_reader([contents_1, rpc_message.contents.1]);
 
             M::read(cmd, &mut sbuffer)
                 .map_err(|e| e.into())
@@ -914,15 +944,13 @@ fn receive_msg<M: MessageFromGsp>(&mut self, timeout: Delta) -> Result<M>
                     }
                 })
         } else {
-            self.log_event(function, seq);
+            self.log_event(function, rpc_message.header.sequence());
 
             Err(ENOMSG)
         };
 
         // Advance the read pointer past this message.
-        self.gsp_mem.advance_cpu_read_ptr(u32::try_from(
-            message.header.msg_length().div_ceil(GSP_PAGE_SIZE),
-        )?);
+        self.gsp_mem.advance_cpu_read_ptr(elem_count);
 
         result
     }
@@ -1004,9 +1032,9 @@ fn drain(&mut self) -> Result {
                     dev_err!(&self.dev, "GSP drain: message length overflow\n");
                     EIO
                 })?;
-            let rpc_header = msg.header.rpc_header();
-            let function = rpc_header.function();
-            let seq = rpc_header.sequence();
+            let rpc_msg = RpcMessage::parse(self.dev, msg)?;
+            let function = rpc_msg.header.function();
+            let seq = rpc_msg.header.sequence();
 
             self.gsp_mem.advance_cpu_read_ptr(pages);
             self.log_event(function, seq);

-- 
2.56.0

