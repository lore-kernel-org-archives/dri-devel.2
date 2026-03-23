Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C588BD58CDC
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 05:40:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34DC710E09F;
	Mon, 23 Mar 2026 05:40:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="EYzEivAz";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012026.outbound.protection.outlook.com [52.101.48.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51FFE10E09F
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 05:40:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=asNQlwv+urxZ2HT8qEVjRuBsR7WA/w4Ne9c1oIGII4qnoIt+lJ1JUyzVCBlltCqup8fFCJnL61tka5dZ/waR2EurHY0J3hjqgC4D63ws8btvhpLQuhFs4Rig+spLp+EGE30YWrZUpmt7Ahk8Fn+68iYdi1DxYb12KjzLxXpE5xkGZgXSzPcyswyeVRbMOSbnr4shBkMCnlaeeerGN24sdJGp/YlzLFwTnWzllJZ2HKz+iBWwZJEeklCDdDoWUzbbPjW5+HgU7mNv40GXwmUoKczVKGyo/sEkNElVtdEaicrCnApwTM/ZRocHAn8idLk5UOZBNVRuWK+q25kZvZN41g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sAM/qYf8bW7yd6WZhQDsgMHXs1mW3e4OypdWJ6Zwmjg=;
 b=sM1q+3ufa6HO+ANWuN15jamaDX94a0qYkNbyWYLQn9BuRy5zcluaf3omZxB1nTHdgBbbETWAwxAfJTzcVZ4y1aJelYzie5TdJy6fBUO6PTFDgzyV1u/Stsl14KaimdsN3dLlcS1MIg8ydf+c7VRIKPlP0kAfVJJsb3daKqoCcZnKr3/7J1XNUT8+zm70/VBvnheC+QK4a9tVxFP3620tyVT3Y7zjZeLWLooLM1nySm1CGvnhg7vYIgfVVst6+TJQ/hBvz/upQvpgyj8bPk/2yOZFNZBscbYr2PB54AEKe2XhM/jgEpO0SSO5GvGQYxxJGdNiHfmZfTzcEVaHi4ky2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sAM/qYf8bW7yd6WZhQDsgMHXs1mW3e4OypdWJ6Zwmjg=;
 b=EYzEivAzdxtxnUxQB4yuq/sqdcVF6yg0Y8N5jDECP23erXdzqlrS44rpx0/6fgPMWppil8ZkS/+w87A0ehi341THHIsmsoAOG5F+rtiHBoo4NAA/hpvFYfdQaiBBON2ZtkTmXF3XV0UXSZF0RcpDg0Yyc93FPat+aSVJIBUTJ8Fp25WlFOFeF9aYC0st5g9tisrqCPau1lKq/I3V/y0/mWSGbT6m2ur5BMhF23TiRLMjCi5rWfJG4bMoBgW9aw2y0aEKlI3D7ycUVmAaDpJW+3snjBm0e15UN/AyhB226MxkMcE7O38kmSsU23UA3jbH26QT7LqSjdsDhozGqFHgMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS7PR12MB5957.namprd12.prod.outlook.com (2603:10b6:8:7c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Mon, 23 Mar
 2026 05:40:47 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9745.007; Mon, 23 Mar 2026
 05:40:47 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Mon, 23 Mar 2026 14:40:35 +0900
Subject: [PATCH v2] gpu: nova-core: gsp: fix undefined behavior in command
 queue code
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-cmdq-ub-fix-v2-1-77d1213c3f7f@nvidia.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22MOQ7CMBAAvxJtzSIfJMFU/AOliO012SIHNligK
 H/HpKackWZWSBSZElyqFSJlTjxPBdShAjf0052QfWFQQjVCS4Nu9A98WQz8Rl+3Vpi+PdXWQCm
 WSEXvt1tXeOD0nONnn2f5s/8/WaJEEUxo6By0I32dMnvuj24eodu27Qu7w1wgpwAAAA==
X-Change-ID: 20260319-cmdq-ub-fix-d57b09a745b9
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Alistair Popple <apopple@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Zhi Wang <zhiw@nvidia.com>, Eliot Courtney <ecourtney@nvidia.com>, 
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: TYCP286CA0306.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38b::13) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS7PR12MB5957:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dca1881-e49e-4f7d-3f53-08de889ebbe8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|376014|1800799024|366016|56012099003|18002099003|7053199007;
X-Microsoft-Antispam-Message-Info: xFntnPdEZ/uaXyHW6woju2Kuj/+e3c4ra7k1BEGxc9wwyPQlMhhXdUY0jMV/wqUIa/X+Sqc4d5MrnNYaxhYIn8h1+Ug8tvnLYDPgZPBHNFayN8JBw0+Ltj48+3EY9lgqmwXSk8+XBLQXUHhQD6pas57tyKVh/IfFM/pyVNM8XJIcM23VOTg0msSNTjskLZ4kdXzg4/9mbk7gUGzUZkZcH6wF8VxlYNDGeNn3veBmyQ1kdoCKZtk2uHlwq62ebXFaGfu4kLq6zeoIOmR7UyUyTnsGZz8i4f7V9Vt3ei8lfMXjg0DlHr/nBTL12bzggw8GIHt+ScJmmYbwDJAxHD5CnyXKs1RGcb7aCneLMniwEHDYcRUdFJ74FFiCCjBkGgjyWoqX+q30SsAs9iH+2jXQYgQK1GfKh2TJTFlfWapwzVrVkO118GMLLn2Bob8WdvK3OUdPyLWULNi3RpDuCEedyZvDfg9shb1e48mgklTT7Gq+oiGr9xCIF6KlkRSStWBt4N2gmttSn6CAEdECoBgJgeXoFrIpFXQLuQIcGeAmGVD9buawXOSPOxeZjP9Q2SX6XE1wZmEc+XGZDsvCmJ5D//8HTkLWZCMS6SvidY0Zntms5mRLuhe3NRZ3MMUmzmAb8Cxq9wWJ0eEpr/m1rFu7TerqXSIa/mX99NB317DIimib0TK8CYkdWsGGFBCLYrJYZr9QvDD/akjCEia3eljV+3a1CBzmqIZ9m50oVMCw/DJj/0hs/tFhlb1o3/267RCo
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(56012099003)(18002099003)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vm9RdnJ0ckQ3ZnBIM01wTlZpQnd0dFhJZnVlR0E3cDJmYkpMb0VRTzBDMXVv?=
 =?utf-8?B?cWxadDl4dkZsSkZLbXNqVDYrUGVvd1p1dEN4aW56enNob3J3dWhPU21lMHE0?=
 =?utf-8?B?aFplZjhJMlZXbmQ2U2JnTENWREE5djZFNCtTUTRVOTZrVFBqaFBCbDM1VnFK?=
 =?utf-8?B?anQ0dDVFY09lMUNDWk9kVHRSdHJtemY1Zjltdjl3WjBBKzZHbUZjalczOVoy?=
 =?utf-8?B?NDdGc0pFK2hOOWpZV3F6ZHFUMHJJODA3a1g4d1JYd3ZLWERWb0MvZnVmRVNZ?=
 =?utf-8?B?SVIvUFRoa0w3WGxQRmdjRzNxeUdNeUhKNjVJejV0ako3K0JsYjNxL3N3WVox?=
 =?utf-8?B?Z243WGdjY01iWFpsM25hRi83N3pHL2hWM0FvYjFHSE9qRkJ5ZDRjYnEyM285?=
 =?utf-8?B?NnpiRU9peklOZ2hOVXhORGp1YmhnTmloVFVnQVk4cXU4LzM3Tk9mSnVtOVJi?=
 =?utf-8?B?eHZnMlAza3ZuR0I3ZUdLcnpBbS84eG42MXNZbUdhQlNyazlGTWdzU2RHNkpO?=
 =?utf-8?B?R1RBMnF6dXdjMGJ2akt0Q01tdnp1MU8vWXNrRm1hK2pIZWdWdVpuWXhDSmxh?=
 =?utf-8?B?Y2FwOURDS3puK2F6YnArZHRTWkFxalZKU0U0WEg5c09HNG5XYjFsKzd6Tmt5?=
 =?utf-8?B?QlFqVmdOdzRBbW92eUlEcUZPbmZua3RWWE1yK0crVFNqMUkwVVNSU2RkMm50?=
 =?utf-8?B?S1hXdFVXeVBtTkJ1b0kwVUIxNzNVa09BQXRRVE5ZVGlJUS9kU2xJZ1AyZDh4?=
 =?utf-8?B?b0dHSjk5Z3IzWVVYKzQ0NEZMWmJzUDZUK2hnb3hacm05TmVMYitPTHhrcmVW?=
 =?utf-8?B?VHZaNjJMK3VMOUptR2RybUV0MHRmL2ZkM2ZhSTN3Z3d1cG1SakZSQVJJd1R6?=
 =?utf-8?B?L1hsdTNsdmJMOXA1RXBlU1AvemQ2Yjhva1dRYkwxWndwYmlVRmdKbm56TnZF?=
 =?utf-8?B?SURCeHZZRUFSbm9lK2J2YmJ4TW0vUmorYTV4ZUt0cWVOQnlpSUo5OFBSMVNC?=
 =?utf-8?B?SkJKczFBWjUzSG9tcTBwbVd6YWF0WUpSMVRqV3RSTWNRWHlQSnBxZmJJdXhn?=
 =?utf-8?B?R2hKemVQVXNINUdIZDM1K21yd1dBNGdFcDlNczBaOXNKZjNpMWgvMlJhMEs2?=
 =?utf-8?B?TzdnYitaS2xGd3B6UldFMm9EbGlhcW9xakR6SkJaZTVYeWFsSWVFMElkWWx2?=
 =?utf-8?B?RndEcFByU3dBUjd5YXBSSFBNblRPUHZnVkM2RmRDRE9zNVpuVHFSK2VneWVj?=
 =?utf-8?B?YzRvYUxWODJRQ0tLL1hNN2dlVUp6UW1yVy82TEVjWHVWQzZWTFFHN0E3aFFB?=
 =?utf-8?B?MFAyb1FYdGpiYzhzajR1KzczenpLcDdXamNnZ3Y3MnZ3NnFlcGlMNm93RDNI?=
 =?utf-8?B?N1ZwSTRHSEZZbzJVRVFKOVJycXhuc2FpbDQ0RFNmZE9CRFY2VjlSSGp0bzQy?=
 =?utf-8?B?VGNlbnZQYlg1VStrTTVwZnRLSVMxK1lwTnlaZHhSazhnbGpKZVMyZjVzRkNo?=
 =?utf-8?B?eW5BUS9IakVOb3JwSUhWTGpWSlhsR2dSWDZobEllcnpucXpBOHUya29qU1Fr?=
 =?utf-8?B?Rmc3QTFOcWFoeThVYlV1WXdJK0FyRHFhTlBMSzlQSG9Jb0R5Zi9rQS9DMTJI?=
 =?utf-8?B?bnFqeHJieWFiMm1zT2w1bGlWL2RGN01rc1RJRzh1dkVac2F2SlFSWVc5TFNV?=
 =?utf-8?B?WEV4YW9uZEJjWlcwbnhVajRWc1J3cTBFYkdEU1oycHdPUHV5K1RwN1p5SXg0?=
 =?utf-8?B?S1h6U3pIUHlKdTV2Y25JOXVaSHZ2UnpyNWdyMk12ampMZEtRYWRWOUZTdURP?=
 =?utf-8?B?dGJxTzBqaWRwL3BFN0IraUwwWlo1Z0E3MytnK01hQXlPSGhYMUo2TlhnSVZn?=
 =?utf-8?B?V2lCTUJPUXAxcUtmMEJ5RkkwZlUydHkvOGNQSTVEb3RmSmNUZ0JtcHVDaXRS?=
 =?utf-8?B?RVh5bjBKQ2JDMkFQMTJhQzhiWklIQko0N29Ca0ZoZGwrOXUzY2NNaVJybnR0?=
 =?utf-8?B?dGtQS0JWYnJYOEhoQ0hQZ3pRaWxoWWlpUERSY1J5TWZKVHhaL010U1R0dUNY?=
 =?utf-8?B?N2ZhTXV1Nld1aDhxQ2xDV1JkMW1jdGhzY1JVS3RIcFd2dk9xb2NRWi9yMW83?=
 =?utf-8?B?Y2RibnphOFA1OUp6NVdIbnlqRUlmM3hTa28yT3l2amlIcklEUTlhdjBia0ti?=
 =?utf-8?B?Zys2aTB4WkVNMXFQQms2cmNkUE9CdXc0ZnNCd1JvL3J0YTdJMkk2YzZxckxy?=
 =?utf-8?B?YXgxWjlqVmVaaVZYTXFrUEZqbWk0MmdUbzh4VWR1alh4YjFrTENNME9FdjNE?=
 =?utf-8?B?UWt5RFR0d1ZyM21nYTV0QkEvZ04rVnJGdEJZTzNETHM2RkRyV2F0eVZGU1hJ?=
 =?utf-8?Q?FxeOuTfvs29zrCToji02N6sV+tRcSHkIMNIxd8zA1uqZ7?=
X-MS-Exchange-AntiSpam-MessageData-1: loyisiQKc2uzRg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dca1881-e49e-4f7d-3f53-08de889ebbe8
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 05:40:47.4042 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5kxVyTCnm6WZTbw3oTBqxOj9Eo4EwKQ3wv1mqQw5DhC56YT25dgS61T6zOrqa5lrfy4Je7zMlRfk1dwtlzMT5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5957
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
and thus creating a slice to them is undefined behavior.

Fix this by replacing the slice logic with pointer arithmetic and
creating slices to valid regions only. It adds unsafe code, but should
be mostly replaced by `IoView` and `IoSlice` once they land.

Fixes: 75f6b1de8133 ("gpu: nova-core: gsp: Add GSP command queue bindings and handling")
Reported-by: Danilo Krummrich <dakr@kernel.org>
Closes: https://lore.kernel.org/all/DH47AVPEKN06.3BERUSJIB4M1R@kernel.org/
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
I didn't apply Eliot's Reviewed-by because the code has changed
drastically. The logic should remain identical though.
---
Changes in v2:
- Use `u32_as_usize` consistently.
- Reduce the number of `unsafe` blocks by computing the end offset of
  the returned slices and creating them at the end, in one step.
- Take advantage of the fact that both slices have the same start index
  regardless of the branch chosen.
- Improve safety comments.
- Link to v1: https://patch.msgid.link/20260319-cmdq-ub-fix-v1-1-0f9f6e8f3ce3@nvidia.com
---
 drivers/gpu/nova-core/gsp/cmdq.rs | 133 ++++++++++++++++++++++++--------------
 1 file changed, 84 insertions(+), 49 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index d36a62ba1c60..4d73a299f3da 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -251,38 +251,53 @@ fn new(dev: &device::Device<device::Bound>) -> Result<Self> {
     /// As the message queue is a circular buffer, the region may be discontiguous in memory. In
     /// that case the second slice will have a non-zero length.
     fn driver_write_area(&mut self) -> (&mut [[u8; GSP_PAGE_SIZE]], &mut [[u8; GSP_PAGE_SIZE]]) {
-        let tx = self.cpu_write_ptr() as usize;
-        let rx = self.gsp_read_ptr() as usize;
+        let tx = num::u32_as_usize(self.cpu_write_ptr());
+        let rx = num::u32_as_usize(self.gsp_read_ptr());
+
+        // Pointer to the start of the CPU message queue.
+        //
+        // SAFETY:
+        // - `self.0` contains exactly one element.
+        // - `cpuq.msgq.data[0]` is within the bounds of that element.
+        let data = unsafe { &raw mut (*self.0.start_ptr_mut()).cpuq.msgq.data[0] };
+
+        // The two slices we return:
+        // - The tail slice starts at `tx` and ends either at `rx - 1` (if the area doesn't
+        //   wrap) or the end of the queue.
+        // - The wrap slice starts at `0` and is either empty (if the area doesn't wrap) or
+        //   ends at `rx - 1`.
+        // One empty slot is always left before `rx` as a sentinel.
+        //
+        // INVARIANTS:
+        // Per the invariants of `gsp_read_ptr` and `cpu_write_ptr`, `tx` and `rx` are in the range
+        // `0..MSGQ_NUM_PAGES`, so:
+        // - `tx <= tail_end <= MSGQ_NUM_PAGES`.
+        // - `wrap_end < MSGQ_NUM_PAGES`.
+        let (tail_end, wrap_end) = if rx == 0 {
+            // Leave an empty slot at end of the buffer.
+            (num::u32_as_usize(MSGQ_NUM_PAGES) - 1, 0)
+        } else if rx <= tx {
+            // Discontiguous, leave an empty slot before `rx`.
+            (num::u32_as_usize(MSGQ_NUM_PAGES), rx - 1)
+        } else {
+            // Contiguous, leave an empty slot before `rx`.
+            (rx - 1, 0)
+        };
 
         // SAFETY:
-        // - The `CoherentAllocation` contains exactly one object.
-        // - We will only access the driver-owned part of the shared memory.
-        // - Per the safety statement of the function, no concurrent access will be performed.
-        let gsp_mem = &mut unsafe { self.0.as_slice_mut(0, 1) }.unwrap()[0];
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
+        // - `data` points to an array of `MSGQ_NUM_PAGES` elements.
+        // - The area starting at `tx` and ending at `rx - 2` modulo `MSGQ_NUM_PAGES`,
+        //   inclusive, belongs to the driver for writing and is not accessed concurrently by
+        //   the GSP.
+        // - `data.add(tx)` advances `tx` elements, and `tail_end - tx` further elements are
+        //   accessed. Per the invariant above, `tail_end <= MSGQ_NUM_PAGES`, so
+        //   `tx + (tail_end - tx)` = `tail_end` does not exceed the array bounds.
+        // - Per the invariant above, `wrap_end < MSGQ_NUM_PAGES`.
+        unsafe {
+            (
+                core::slice::from_raw_parts_mut(data.add(tx), tail_end - tx),
+                core::slice::from_raw_parts_mut(data, wrap_end),
+            )
         }
     }
 
@@ -305,27 +320,47 @@ fn driver_write_area_size(&self) -> usize {
     /// As the message queue is a circular buffer, the region may be discontiguous in memory. In
     /// that case the second slice will have a non-zero length.
     fn driver_read_area(&self) -> (&[[u8; GSP_PAGE_SIZE]], &[[u8; GSP_PAGE_SIZE]]) {
-        let tx = self.gsp_write_ptr() as usize;
-        let rx = self.cpu_read_ptr() as usize;
+        let tx = num::u32_as_usize(self.gsp_write_ptr());
+        let rx = num::u32_as_usize(self.cpu_read_ptr());
+
+        // Pointer to the start of the GSP message queue.
+        //
+        // SAFETY:
+        // - `self.0` contains exactly one element.
+        // - `gspq.msgq.data[0]` is within the bounds of that element.
+        let data = unsafe { &raw const (*self.0.start_ptr()).gspq.msgq.data[0] };
+
+        // The two slices we return:
+        // - The tail slice starts at `rx` and ends either at `tx` (if the area doesn't wrap) or
+        //   the end of the queue.
+        // - The wrap slice starts at `0` and is either empty (if the area doesn't wrap) or ends at
+        //   `tx`.
+        //
+        // INVARIANTS:
+        // Per the invariants of `cpu_read_ptr` and `gsp_write_ptr`, `tx` and `rx` are in the range
+        // `0..MSGQ_NUM_PAGES`, so:
+        // - `rx <= tail_end <= MSGQ_NUM_PAGES`.
+        // - `wrap_end < MSGQ_NUM_PAGES`.
+        let (tail_end, wrap_end) = if rx <= tx {
+            (tx, 0)
+        } else {
+            (num::u32_as_usize(MSGQ_NUM_PAGES), tx)
+        };
 
         // SAFETY:
-        // - The `CoherentAllocation` contains exactly one object.
-        // - We will only access the driver-owned part of the shared memory.
-        // - Per the safety statement of the function, no concurrent access will be performed.
-        let gsp_mem = &unsafe { self.0.as_slice(0, 1) }.unwrap()[0];
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
+        // - `data` points to an array of `MSGQ_NUM_PAGES` elements.
+        // - The area starting at `rx` and ending at `tx - 1` modulo `MSGQ_NUM_PAGES`,
+        //   inclusive, belongs to the driver for reading and is not accessed concurrently by
+        //   the GSP.
+        // - `data.add(rx)` advances `rx` elements, and `tail_end - rx` further elements are
+        //   accessed. Per the invariant above, `tail_end <= MSGQ_NUM_PAGES`, so `rx + (tail_end -
+        //   rx)` = `tail_end` does not exceed the array bounds.
+        // - Per the invariant above, `wrap_end < MSGQ_NUM_PAGES`.
+        unsafe {
+            (
+                core::slice::from_raw_parts(data.add(rx), tail_end - rx),
+                core::slice::from_raw_parts(data, wrap_end),
+            )
         }
     }
 

---
base-commit: a19457958c3018783881c4416f272cd594f13049
change-id: 20260319-cmdq-ub-fix-d57b09a745b9

Best regards,
-- 
Alexandre Courbot <acourbot@nvidia.com>

