Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66788F54ACE
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 15:15:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB40310E6EA;
	Tue, 24 Mar 2026 15:15:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="sYrfhA1u";
	dkim-atps=neutral
Received: from CWXP265CU010.outbound.protection.outlook.com
 (mail-ukwestazon11022073.outbound.protection.outlook.com [52.101.101.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD14510E6EA
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 15:15:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eFsZCt/ujiKAOdATSbMPYJgIkEEGdukwujataHiuVBk9NstA/OioometlRkDpr3mG3QCLj5bl99Zxbdk5Hnsvu96hnsFDUy24sxkSnJwTd01JwXKhRb89Pw8aRm6wImtOKini5Y9qKVhx4vACzMQTmXJrdsafyzw5U4qvC8aPfodrbDv+ffQ5cIAEW2jwrF25Azh0TdJ7qMnh2/sbekdsIJnfMOytxdgS9fGx0JGvmbRN3ATw6uGZgcbdUHbpdYelcp6VhRh0ggYqophc396paB+oMRvov06Sy0OnuYko5grKYWtn3GJjHBZ09w7Yd7dYv+vEVI0j9tYmgvj99rQrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D6Kyjni7jtVCVX8h+/T0NobnDPJpxwya57xVuVfbqa0=;
 b=lDwZlsn6GGeQecnFh40MgcvcuHL23uNq6j2spMQDjRlfLjNrFhrGcJq7/gw8qRn7R5YiXRKLMdtS+5awXOqoyS4NLCqySdLfVFBI9Pn6b1Ijgk2gW5a+vi6qqBvHSwiGzWyWOTd/KsflKg9rRBvPtVgW+yTZ5oMZzkfBVAMTT4bEdf1mNOSTxO+3otOqqy6m6575B2fSyovEwNNnyTG35P9zxwCpy5nzGLQH0RefW36Kn4R/xFObtiMFYisiXO27mOOqoH30sZ+kTRuOJ4yuP6S6TI4j3oEGmCRSaUjvIZFr4s7dfUoogpsiPCf8pHPH48HOVUEMacS27vuYzkzsPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D6Kyjni7jtVCVX8h+/T0NobnDPJpxwya57xVuVfbqa0=;
 b=sYrfhA1uk/mTWk6nmDEtzzJHNU4fhvH/bNI3T7KFd1Pl1pudciK4IVjozWWL72rXyrYFIinE3cjRkAbTiPfg4SJA8XXn8ZwTsnLCpjy7A/rwceGcdHVwaonl6rzaxQSg7eHDkRnXTJo7dKq4si7Fc6BAZgO7rRazF1Juaqf4Kbg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO7P265MB7570.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:398::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Tue, 24 Mar
 2026 15:15:26 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9723.030; Tue, 24 Mar 2026
 15:15:26 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Mar 2026 15:15:25 +0000
Message-Id: <DHB40HKJD3OC.OMC04LASMS4G@garyguo.net>
Subject: Re: [PATCH v2] gpu: nova-core: gsp: fix undefined behavior in
 command queue code
From: "Gary Guo" <gary@garyguo.net>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Gary Guo" <gary@garyguo.net>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Alistair Popple" <apopple@nvidia.com>, "John Hubbard"
 <jhubbard@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>, "Timur
 Tabi" <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260323-cmdq-ub-fix-v2-1-77d1213c3f7f@nvidia.com>
 <DHAB9Z571FPB.25927BK1RGNGL@garyguo.net>
 <DHB3CGY1Z5HF.1KSJV8SP8YD8A@nvidia.com>
In-Reply-To: <DHB3CGY1Z5HF.1KSJV8SP8YD8A@nvidia.com>
X-ClientProxiedBy: LO4P123CA0177.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18a::20) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO7P265MB7570:EE_
X-MS-Office365-Filtering-Correlation-Id: 32d81b8d-b7a6-4bb2-bcec-08de89b82d61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|10070799003|366016|1800799024|376014|18002099003|56012099003|22082099003|7053199007;
X-Microsoft-Antispam-Message-Info: jGcTrg5F2W1Kk5LVaj7zQ1NVEe/vVuEzoL91lB1MaWGRkY2hkuv2FdBuF4e5PpG6Yqrx8nD47kyTadf+Vah86t49EFU4oYnEPfc0viYwVzANqfnYLzNg5S1HaHZvz0ozme4iGirHmV79XgGaf10XLHj4qvXZtLMegBUYUK6KqACdSDUyaEYuP0+lmQ62MaENc9hCZoczc/hkVoz9yFhcDAklHaOWdq/OgE6LWWtNKvah+SMZAnRZD5V/jUjXUsVKLzIKcl6QCNwmQgOfletz7ipnKZiEc+kh+R3B4urZJw9Sr/FmUpqyUG3bfFkzRRiw9zthNt6LlvzZ8GA33ovnwkPfcbh5sNeT1fnVysSsjMhLnX7Bk7fVsyIUF/0qwLjWIuDvljZ98i6j8RAHoG9OKsPg+XEqkHPirCIqhMvKilERfw5iIBf4/ZmaGr40TEh1zMgHr/Oc5bD7v3RgJWMbCj1eiAKwtqpZ9JtFSDKYulrZIYycwBA84Kw1vMgwLvXyVI7QhMpr5WpCsOwUEdB1SSDGh7VCCBFCPpy5CtN0itJc0mcKRkbfSxy5SeMeppl7VofgjrwPAL/eOARianWUS9wt8PJpLUPqUa8avFFey8VtvTHA/+GqCJ/kX07Hk92DYjz4atFUEq4u2lIwFQ3yRqv1kv0Y4OtkixKPh5qNwiT7ULdjTnp5dvWShHaY1LNr
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(10070799003)(366016)(1800799024)(376014)(18002099003)(56012099003)(22082099003)(7053199007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cm1HZkhzZ2xnSHE3emwrM0ZiZWtReEJVN1dDWVErUHZBUVJjWE5WNTVqQS83?=
 =?utf-8?B?ZWdQYWI1YWN3a0hTbDh2Q1FEdy9hTU5URmZwMnlCbmVhOFp4Y2FBQjVsN0k3?=
 =?utf-8?B?dlNFblJrVlNjbXNzYXcwcWhYaFo5bUZXZzhTekEveXdmb2xnR05md2U1a2ZQ?=
 =?utf-8?B?d1lwYXJKY0REUjJTaFBYSjk5ZUVXdllrY3FJbTlBK2loVi9iYW9RNDZjQUpj?=
 =?utf-8?B?eHFuOHd5ZnlrRW9VWEF5TDFqWEUwdlA0UGRQQTl6Y0s3bm9BN2NpZ242cUo0?=
 =?utf-8?B?MW8vSGVFYWtKK1hrWVZPRlJQTkxyK1hrbStLTEhocHRTMjFFVlkwODRnaW5J?=
 =?utf-8?B?M3oreVU1bHpHY3BPTExBM24zTG94VVFLT0VUMDVJeTNkaXQ2QktrQ0RaS2hj?=
 =?utf-8?B?cVh1MEw5U3BWM2w1S0JvaE4yeVlxZ1NZam54R1BEc3VmUmpVMy9vVVVxZUlz?=
 =?utf-8?B?Y0hta1BCUlJHTlY3TmZ1Wnpyd3JqUktFVUtaTHZKSmhkRVg2cU9OVE5MWUlI?=
 =?utf-8?B?N3RiOC9sKzFUM1pGUTh6NVZIUDJxdHE0dVlHY3NJQS94TDU2ODVMTy9tODdy?=
 =?utf-8?B?VE9FQU0xRUVVcy9oUGxqY05iaEJ5U1lPK21paklkVzBJcFVqeklaMllTTERq?=
 =?utf-8?B?eDREbThLRU1jZTNkQVdvTis0NG5QWmVnamlPYlZSUUc3WTcvOFVUWlpVSWh0?=
 =?utf-8?B?bHVJTVVGb0xZaWtISmEzeFVJMjM0RnFDaDJqdU1mand5OS9BZUZJL0ZwK1ph?=
 =?utf-8?B?VDgxK2QxclVIV3UzbXlNYlB5b211N3JkbDVWKzZTRm53VzJscElBdkpIYnds?=
 =?utf-8?B?cG5DZkEzemVpYVVPN2RyZytVK2t5UFNia2dGR1psMWh6ZXhBN0hnWUZFcDhl?=
 =?utf-8?B?UldHUWllQ3ZYRG1Gb3VLUU1qU3czT1grbFFOaG5DdTNET0JYMXN6N3lxVHpo?=
 =?utf-8?B?cDBGb3AwWGZQemdSS0JndCtSRzljR0plZ1ZiYW1oN3k3Qm9pcEpwSmIyK0o3?=
 =?utf-8?B?OW1nOHhSN1docUZKNEtQeWp0TmpjNjNiMmFXdC9oZW40SkQxUFQzT29hQlov?=
 =?utf-8?B?aUo1b2F3TXgrWE9WZDJLTVhYcWdQZDk1TXFwVTJNYTVnditNRlphdlNRR0xq?=
 =?utf-8?B?dGJjZDcyZHRsTHFOSEpQM29CejBRdk04alJQTng1a3RId1pqd0JwUlptcFBx?=
 =?utf-8?B?VXYwbXJQTXFNZ01FeDJ2TE9vUUFKQWJ0dU5YaUM4Yy9pSTVJZm5qNENVakU5?=
 =?utf-8?B?RFhZb1FnZkhZUGh0cTRoK1c4ZXRBUHJEME5odWZ5N1NTYi9PTmtEUE5iU2VK?=
 =?utf-8?B?cWJ3M2dKektQV2E2YU13eldGMENWeHk0L2F6MjkvOE1LMy83Z3lXNFhNcnpL?=
 =?utf-8?B?MVNLQ0lacHM2VjlMR0Q3Z1dvcDdrcW5FK3BVM1ZXSm0rTHFORWJ3aGtFMHpP?=
 =?utf-8?B?OS9ud1NBVTVIeVdtQmxwQmR2Sm5Oem1DNHNJRnpiMEtka0xnMXlGaEZQZ1JS?=
 =?utf-8?B?eXY5c0o2aUgrdC9Vc2thVi8xSjF6cGJwYk05QUxXQUowVHBPdi80RElJNFRW?=
 =?utf-8?B?T2k1dEZyK2pMOVhPWmtZOVBVVytQWmRQUVpXeEFqSklLZ1M5aGdZUDZXdUdF?=
 =?utf-8?B?Q2hZVndkVWFlQm1pbDN6Um5Md3B3Nm9rYkdNNDU1U01xV0J4WDJCaG9wdTc4?=
 =?utf-8?B?azF3a1BobGdhQSt6cmdVZ2FZMWx3NU83UERvS1VPYlNCTURhb3dPWVdoQnBD?=
 =?utf-8?B?T0hFT1VsamFXdEJTWll5czlabEpmam5rdW85eVN3Ums2L2YxTFBjaCs2ZmNo?=
 =?utf-8?B?YjUrdWg4UVAyR3FKS09JMUtLRENzKzg3UC80eTdraFUwdnNhZ1lzek5MM0ND?=
 =?utf-8?B?Sjl2MmRsT1ZKc1Y5Y1VJRFp1WlV3SWJTN0YwSExHeUtQRXY5MS81YVVlM0tr?=
 =?utf-8?B?eElycE9lTTZpc3N0TGYzc0FPTk41dCs0TDZOZkpsSitZRXBYZHhTSDloVjFy?=
 =?utf-8?B?K09qUHh0YnBiMzZnbk5SV2VtTE1KZDFhZS82Rm5TYmZSOU9ZNlFPUHRsbmNn?=
 =?utf-8?B?dVB6c01GNEtNZkNMTUN2SWwzWXNWZFNaYVloUkhidHd6aHVxeVM5N2I3cUVF?=
 =?utf-8?B?ZnZ5RHlVU3l2TkNCMFExNUhWSmxENGh4cFY1ak9rdC9OazlhZHgxZXppdnJx?=
 =?utf-8?B?S1ExU3FROXl0Q2d4Zll2dGpaTXRZQ1d5eis4YmJVQ0V6NExGTUY5S3cxdmU2?=
 =?utf-8?B?MVIvODNiTTRTMmQzM1ZFRFc2K2lsZTBuTUNDZndGZ2hkR0RtenBYQzRNRkxN?=
 =?utf-8?B?T2hVLzQwRDNwL015bjFhVFRnWDJ1blgrdXFxNW9udXZ5R0dJRzNxQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 32d81b8d-b7a6-4bb2-bcec-08de89b82d61
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 15:15:26.2725 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q/JXlXxmzlNvU4Kttfzh3jlmX+gFuWKEBSETlc/8m6+XXrLLF51xH4pvmIZIUT3K+Zg50L4H6o36+WJiU2D4Iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO7P265MB7570
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

On Tue Mar 24, 2026 at 2:44 PM GMT, Alexandre Courbot wrote:
> On Tue Mar 24, 2026 at 1:44 AM JST, Gary Guo wrote:
>> On Mon Mar 23, 2026 at 5:40 AM GMT, Alexandre Courbot wrote:
>>> `driver_read_area` and `driver_write_area` are internal methods that
>>> return slices containing the area of the command queue buffer that the
>>> driver has exclusive read or write access, respectively.
>>>
>>> While their returned value is correct and safe to use, internally they
>>> temporarily create a reference to the whole command-buffer slice,
>>> including GSP-owned regions. These regions can change without notice,
>>> and thus creating a slice to them is undefined behavior.
>>>
>>> Fix this by replacing the slice logic with pointer arithmetic and
>>> creating slices to valid regions only. It adds unsafe code, but should
>>> be mostly replaced by `IoView` and `IoSlice` once they land.
>>>
>>> Fixes: 75f6b1de8133 ("gpu: nova-core: gsp: Add GSP command queue bindin=
gs and handling")
>>> Reported-by: Danilo Krummrich <dakr@kernel.org>
>>> Closes: https://lore.kernel.org/all/DH47AVPEKN06.3BERUSJIB4M1R@kernel.o=
rg/
>>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>>> ---
>>> I didn't apply Eliot's Reviewed-by because the code has changed
>>> drastically. The logic should remain identical though.
>>> ---
>>> Changes in v2:
>>> - Use `u32_as_usize` consistently.
>>> - Reduce the number of `unsafe` blocks by computing the end offset of
>>>   the returned slices and creating them at the end, in one step.
>>> - Take advantage of the fact that both slices have the same start index
>>>   regardless of the branch chosen.
>>> - Improve safety comments.
>>> - Link to v1: https://patch.msgid.link/20260319-cmdq-ub-fix-v1-1-0f9f6e=
8f3ce3@nvidia.com
>>
>> Here's the diff that fixes the issue using I/O projection
>> https://lore.kernel.org/rust-for-linux/20260323153807.1360705-1-gary@ker=
nel.org/
>
> Should we apply or drop this patch meanwhile? I/O projections are still
> undergoing review, but I'm fine with dropping it if Danilo thinks we can
> live a bit longer with that UB. It's not like the driver is actively
> doing anything useful yet anyway.

I want to avoid big changes back and forth. We could use raw pointer projec=
tion
today, which could be fairly easy to convert to I/O projection:

diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/=
cmdq.rs
index 191b648e2ede..4cdbeed04294 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -23,6 +23,7 @@
     },
     new_mutex,
     prelude::*,
+    ptr::project as ptr_project,
     sync::{
         aref::ARef,
         Mutex, //
@@ -306,24 +307,25 @@ fn driver_write_area_size(&self) -> usize {
         let tx =3D self.gsp_write_ptr() as usize;
         let rx =3D self.cpu_read_ptr() as usize;
=20
-        // SAFETY:
-        // - We will only access the driver-owned part of the shared memor=
y.
-        // - Per the safety statement of the function, no concurrent acces=
s will be performed.
-        let gsp_mem =3D unsafe { &*self.0.as_ptr() };
-        let data =3D &gsp_mem.gspq.msgq.data;
+        let data =3D ptr_project!(self.0.as_ptr(), .gspq.msgq.data);
=20
         // The area starting at `rx` and ending at `tx - 1` modulo MSGQ_NU=
M_PAGES, inclusive,
         // belongs to the driver for reading.
         // PANIC:
         // - per the invariant of `cpu_read_ptr`, `rx < MSGQ_NUM_PAGES`
         // - per the invariant of `gsp_write_ptr`, `tx < MSGQ_NUM_PAGES`
-        if rx <=3D tx {
+        let (first, second) =3D if rx <=3D tx {
             // The area is contiguous.
-            (&data[rx..tx], &[])
+            (ptr_project!(data, [rx..tx]), ptr_project!(data, [..0]))
         } else {
             // The area is discontiguous.
-            (&data[rx..], &data[..tx])
-        }
+            (ptr_project!(data, [rx..]), ptr_project!(data, [..tx]))
+        };
+
+        // SAFETY:
+        // - We will only access the driver-owned part of the shared memor=
y.
+        // - Per the safety statement of the function, no concurrent acces=
s will be performed.
+        (unsafe { &*first }, unsafe { &*second })
     }
=20
     /// Allocates a region on the command queue that is large enough to se=
nd a command of `size`

