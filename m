Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 419CCCD98DE
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 14:41:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 675DA10E49E;
	Mon, 15 Jun 2026 14:41:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="A2fS7xEI";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011038.outbound.protection.outlook.com [52.101.57.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0B3310E499
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 14:41:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HQtYoWOslpMDuxrbNqIFqSi7aDcRmpj0dDdoC49p4EqSohvAi7Ort+CIC19W57vb5u6Hms7+7WestJJzkdPjB+itEucPwLca6eecNzDiMs8jJfAOMcZ4eBNci3KtezyJiYATcHrzvW0yucJmL79Xkfsw+DSQvTWIByw8duhOlssAAdmCHSUHV5cyYzLtxRKOFIHx/uY2S+PIQPdNf66RdRd2HS7nrHxU3Xk4hkf36pv2i6yJ1Yn1amT1EK/WoX5NbLIp6aSJTBVqehBoPZ3zdPmU1Ak+W9Y+owIj2XvuEg7PtOUf/FaVlG3q+pO2H9phlvhmiRfBhMrc1SOaMQdVDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gw57VR/BaC+z1VenqRuOFkwJRemRFks9OF2cpNwtbPM=;
 b=MIZM9tTOZ34VQ5Lagqct5XlPzjs6//uVAe+kSB0FqXWhHWeoilQn7vtlberhqkLl5R8WLH766vK+XiU04oPo9mmMVS6etgkv+1Gzug/4tMBt5we35HZYzaLGuaTDsrmVCcUZOHY7Z6GAxmH3Gm5/jAx4+v/OJqX0pi8hwmJVBAb6dqOn3NVFS760j1Ui+p5RSsfKyCXWOo/LHp26tX5ANvtwEhuhmyFebZMybONKZlUaqnXK/PZ/mJxoXnMvSqTvzJbPAcsPMlYqOffkgbvNO+XwmgwPSwT/fZUGpfzWCL+ilaUH/M5nJIuo0N75Xa+PJJyEtx/hqOVwbrvsSft2uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gw57VR/BaC+z1VenqRuOFkwJRemRFks9OF2cpNwtbPM=;
 b=A2fS7xEI27daKT/C9L+93J9fHDFkVVmWryFI7ijatEGYl0Dcb9Sra1fFhcfkqjpP+c9KOXdRn1+nuaE3IZaZqaHVXIoh8gueeYA7yShn0c0bROu2Cg1Q+SV9IygWuAvyNNegr/Vnz+OTNkJlH4mypvtMS8kzzDubJ/C+on0b8+PdRO3AqJqODgJ2CvR53nxIuF4zDC9aDSobON604Yoyd9eMJom03T4IU9F6xqOC/jpcyXHgyLn12M9JR51Vh7VUcUbsJ8pItMqhQWJWUQWuEraBXaRExpW2uKpeMfoEo6G5WofPEK9Ff1g4lE/ha1jBHgudNTqvbHdrWHsRBCQ/aw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by PH7PR12MB8105.namprd12.prod.outlook.com (2603:10b6:510:2b7::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 14:41:32 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 14:41:32 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Mon, 15 Jun 2026 23:40:41 +0900
Subject: [PATCH 01/13] gpu: nova-core: fsp: limit FSP receive message
 allocation size
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-blackwell-fixes-v1-1-f2853e49ff7d@nvidia.com>
References: <20260615-blackwell-fixes-v1-0-f2853e49ff7d@nvidia.com>
In-Reply-To: <20260615-blackwell-fixes-v1-0-f2853e49ff7d@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP286CA0123.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b6::11) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|PH7PR12MB8105:EE_
X-MS-Office365-Filtering-Correlation-Id: 8102a1ab-ad16-4811-a311-08decaec31a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|366016|376014|7416014|23010399003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: o5fo6F1lfT28MOP64yVjXDt4Srota7Itw00cMzcoWcevlsKNQJHVdI36GTe4rVdKRA6TksbC8X4Rx2GH+4Co0wx7kkJbIMGbeFEF00sygWB7yhfqwLObKuoH0p2nHkuWF18udqi4bkJcHMXEdFyi05Sg1SAKD8HGfZHBcV8GCkJuXCZsDMFRS/wbaHqCS/TmAUQXy7pCPDapuFTIeps3D3hGbfAaobDRpg+SIKT9LxqUijlbkSeff7EcJUF4xNFTEWc/SsKRLW67zRo7lxGO0ZAfn/Beqxio0HsOUhOziQTZYqaasapQ5H7M1LZHyOCuQtc0oFzEFJsE++At6RU5ruLc7RWZ0wiMDiczty9EmII9ppN5cUAeN5mLjSZ48ogXOkZ8S2IdF6j185xDsChReLEIT+Y/+Nb75mDB84BR4hMiW2SiRoXHfgYXKdCTA/SF6wMAKEtr/vCNXaIppYuxRZassuRvt321i7giNY51YHmSkPFKHnYcRKcwefT6jLcCuOE2bZ4BnSYjSsjcZsK6ZzE1HYVl/PCm268qDFw9pFqPqcroCz5thkB4Y5SYnEVNlk+0T9Ypu2BV7TfIWQNobnmaFd3fTFD/YYil5rZAZugauNTrFPpHj/NAB0OpDTdUNqrQTEqzCSLWvXXqZ/Yxp6EI3bAJhCYfb0iK4AzL6eV6ynVIgZRhVbkk+gwuO97w
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c01MbEtPUElVTGlJY0ZSNU9TYVBZTlhBb3Q4UGZWVTBmSU9WZmxqaUdSTzFD?=
 =?utf-8?B?KzVha1lUcXc1VWtRTktsaWVKeFhqQzljU0tPM2NVMGNhZ2xXNGxadFRhSGhJ?=
 =?utf-8?B?U1duYVdsNmxNSS9nWVVpQkhSMnZBcUtYZit4TEFuZXBQcHpabE45MUVyejds?=
 =?utf-8?B?UDNkdUQ0a3FDdEgvdE5FS055ejlzSnovYUZMVzh5UE05aGt5WEtrQS91Q0lK?=
 =?utf-8?B?cGl4SW8rczRSemJUVmtBSDdzVmxVRFpNMWk5MmVPUExxVmNWMnRJRXJvNERy?=
 =?utf-8?B?SjhiWGowa2cySkJMOWVMK3dzTGNoRldBMUpsei96cWFZWTNtWlRCNTVzV21p?=
 =?utf-8?B?bWI2cG5aSHp5ZE9NZSsyL0J6d2VQTmNBekZBVGsxZFFFdko5OW9IbEU0TUxv?=
 =?utf-8?B?UzlMZEl2dFRIc2ptM1E3bURqU1VkSjkzRmVML2pYblk0cTdvdjlKVnBNNFFk?=
 =?utf-8?B?TlcwZzR5ZTBFQVBBcnV1VlVKSUJBbTRyUFpTeTFkaXQrUUlzOEpmOHltcmJ1?=
 =?utf-8?B?NHJDOUw4WkM1cmlLampGTnNMUXRjbUcvcUMvMElPMitBTXBHbFlveTVkZ1Q1?=
 =?utf-8?B?UFJkdllJSHpNc2E3M0pxbEtXdXdKczdscVd0Tmp1SnIySC9Jcyt1ZkVreUVq?=
 =?utf-8?B?d0RxbTFGaU5YbFF0OHRucjNEcDhBOWhoeU5XQ1o0Si9MbTY4T3JYSVBkaERz?=
 =?utf-8?B?V3Bhb2E4bFZ2Qm5PK04zU1pGUW12YXlPSlRqSTV3TTZ0SVFUNTRVRno2djdS?=
 =?utf-8?B?NWtkeUxHeFUxNExEaVBrSnl2dm00NWgyVWpXYVZIMU9FS3lhT3VLMFZxajdr?=
 =?utf-8?B?c2xyTGR5MzNDMGJQZjEzcDRlTkhrRnZYU1I1ZE5uYzZ6TkorMklnZG0xWXdX?=
 =?utf-8?B?dm0zYUFRZ1dOVFFGME40S1l6UFBTOWxZNmJaeTZNckZOMmw1RlY0VG1ncHkz?=
 =?utf-8?B?UmYzcWpkcTFIeXdGeEJ6ZnBIMmJtS3pFSjNXeFV1UEdRdXVZdHFid0p5K3pn?=
 =?utf-8?B?MGthaUdCZFNpNFJCSEFJUzdJMHZoNkQxT2xLSGxHYTd4YVltMzlaL2pXb0FI?=
 =?utf-8?B?MEVaNTZlYUxia1NmbFJPSWtxL0c5OXdERnB1Z3h0KzJEUUlpemtVRlZPbDFj?=
 =?utf-8?B?bUpGc2VwbmlvLzhkbUUyRFZxZk5wYVNtM1drd1pKYkxSZHNabk5GVW1ieWtY?=
 =?utf-8?B?MnVjQXg0WS80c2kwRk9UYytIOG5KRzBsY09aTHQzNEtkL2owSUxiT1ltSm1D?=
 =?utf-8?B?SlVsZGgwVUdJOG1vbERPUGIvS1hWRHIwbGhYSmdwT1ZvSFFLbjBkNEtKdVdq?=
 =?utf-8?B?YkFmVDVDYWEvQ2V6SDVuUFN4cXlzZmEyQk5DcDFTZ0F4Ry96dFYxOXdyUXow?=
 =?utf-8?B?REVFMExjV3Q5eDd3N2JjWnVYWm4vT1lSdW1vam9idlphNUFqS0lUMXlSQlVo?=
 =?utf-8?B?dm14b1RLTUM4RXQvNWNpUklYWmh2RzFmbTB2MFJVdXJrbFQyWU9mLzFsZU5I?=
 =?utf-8?B?b1RHNVRKZHVKY0xRRXZyK21TY3kxVXNkZXVUZGpKNVh1NWIxTkNGUTRYaVUw?=
 =?utf-8?B?c3BTTFF0a3JxYXpVc3NxdFZzTDMveXdybTF0R3NWVTJpd0xJSFBZVlpmMHNV?=
 =?utf-8?B?L0JBamkxUzZZelJvMHFiOVRMZTdWTnRGVmIzY1NxTGw3eUxkcWxTNEZQZnND?=
 =?utf-8?B?dVB2THNKdW9BdEtzNDRQVm5wZUJIQ1paZzFrR3orQ0dZdWlkSkx1dTkvMHB6?=
 =?utf-8?B?T2V1NDBWUGZlQ3NsbWFoMjd6TzhvN2Jsb3Q2bmkxb3hVZlZhWHlHaU5CNGVJ?=
 =?utf-8?B?QS96ampuc1dSUEs2bHAzSmkxbVVKN0pWQTJadFc0TWFLZk1pdmVzczcrVUJF?=
 =?utf-8?B?eHBXdE1lRUU2Q051Y2hHeEFuWEdqcE1iWlpKQjUwUENMQmZTOXR0MkxrM1I2?=
 =?utf-8?B?b3p5WmxUcWhmRzJkR2JBbnFYSjdxZVU2bnhUNnFBZks1dEdKUEtYR0lmSFdL?=
 =?utf-8?B?a2VQcjUrK2tqT0p3YVFhU2FQM09RWlhOeHhNeHpEWk1mOCsvckRDMXdwVVVJ?=
 =?utf-8?B?dXVuUGpNYW1GdHUzVDVtNllWWDhtNHhSc1Fhc2gvdUpmZ280a3NnUDJwZ1dH?=
 =?utf-8?B?ZSttWGZaM3BObEZPc0Z5djFRMU9LYmUxM3p4MmhyWDVnV3pvWWRPZm5YVmp5?=
 =?utf-8?B?amRRdlFtSzlUc1Z5a3ZudHlSRmFIY1pmYW81eXNlVXo4SjZnejBPZTVJaVpM?=
 =?utf-8?B?c2VJS0JsN3U1QzhtRUhKblVGdkk5ckNDV0ZtZmpNSEQ5SlJmaU5NMDhKcWEv?=
 =?utf-8?B?QS91YkFNNWpmejNkaE1mVmhXRDNNWThjckpjSk9ta0lWNER6d0hGajN6Rmkv?=
 =?utf-8?Q?FquNXNWIZSZL30yHcQocsyw5gP/oWWPqLPBJ0Dk/375Db?=
X-MS-Exchange-AntiSpam-MessageData-1: QX0AXr8cozTQzA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8102a1ab-ad16-4811-a311-08decaec31a7
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 14:41:32.8674 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sS1t2PUfNjfEZ27qPumm/2TBYTWA81SoDrF76VKydI8Drg0NlMGsmZSrvBdW2rS54B8mF1FUDKNS7w3dTYy03g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8105
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

Currently, the FSP receive message code will try to allocate whatever
was sent without checking it at all. But the actual size allowed is
limited to 1024 anyway, so discard any messages over that size as bogus.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/falcon/fsp.rs | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/nova-core/falcon/fsp.rs b/drivers/gpu/nova-core/falcon/fsp.rs
index 52cdb84ef0e8..e7419a6e71e2 100644
--- a/drivers/gpu/nova-core/falcon/fsp.rs
+++ b/drivers/gpu/nova-core/falcon/fsp.rs
@@ -35,6 +35,9 @@
 /// FSP message timeout in milliseconds.
 const FSP_MSG_TIMEOUT_MS: i64 = 2000;
 
+/// Size of the FSP EMEM channel 0 that we can use.
+const FSP_EMEM_CHANNEL_0_SIZE: usize = 1024;
+
 /// Type specifying the `Fsp` falcon engine. Cannot be instantiated.
 pub(crate) struct Fsp(());
 
@@ -149,23 +152,32 @@ pub(crate) fn send_msg(&mut self, bar: Bar0<'_>, packet: &[u8]) -> Result {
     /// Returns `ETIMEDOUT` if no message was available until timeout, or a regular error code if a
     /// memory allocation error occurred.
     pub(crate) fn recv_msg(&mut self, bar: Bar0<'_>) -> Result<KVec<u8>> {
-        let msg_size = read_poll_timeout(
-            || Ok(self.poll_msgq(bar)),
-            |&size| size > 0,
-            Delta::from_millis(10),
-            Delta::from_millis(FSP_MSG_TIMEOUT_MS),
-        )
-        .map(num::u32_as_usize)?;
+        let result = (|| {
+            let msg_size = read_poll_timeout(
+                || Ok(self.poll_msgq(bar)),
+                |&size| size > 0,
+                Delta::from_millis(10),
+                Delta::from_millis(FSP_MSG_TIMEOUT_MS),
+            )
+            .map(num::u32_as_usize)?;
 
-        let mut buffer = KVec::<u8>::new();
-        buffer.resize(msg_size, 0, GFP_KERNEL)?;
+            // Don't blindly allocate more than the maximum we expect from FSP.
+            if msg_size > FSP_EMEM_CHANNEL_0_SIZE {
+                return Err(EIO);
+            }
 
-        self.read_emem(bar, &mut buffer)?;
+            let mut buffer = KVec::<u8>::new();
+            buffer.resize(msg_size, 0, GFP_KERNEL)?;
 
-        // Reset message queue pointers after reading.
+            self.read_emem(bar, &mut buffer)?;
+
+            Ok(buffer)
+        })();
+
+        // Reset the message queue pointers regardless of outcome.
         bar.write(Array::at(0), regs::NV_PFSP_MSGQ_TAIL::zeroed().with_val(0));
         bar.write(Array::at(0), regs::NV_PFSP_MSGQ_HEAD::zeroed().with_val(0));
 
-        Ok(buffer)
+        result
     }
 }

-- 
2.54.0

