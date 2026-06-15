Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACDB7CD98C5
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 14:41:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09B1910E4B0;
	Mon, 15 Jun 2026 14:41:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="aLd/hKxP";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013038.outbound.protection.outlook.com
 [40.107.201.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7798910E4AB
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 14:41:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e7EOqIEnVfKtNZxXwvcLXwdpQAcwCa2veg27aW+gRHKooHOh0bNr33Exn3kFtKooAerV+DGgaOQc2rRcHcLsbt07/YkHLNWkb86+FUqPivzD+YO2SElsfUUTffVqLFIOPxPpp5WXHYRlEgoVbbjTzZFQfFhtehEBqaiplr4ITwXBgxmMI8nB+8JcfBIjEl+8degGuhcXxkl1KE7hu4FxqCYCZsnEgGsju2xpWHO+r+4BeP2PZ5ZBbmote+dpnuQsHMkdh1OFnhe3PK7i2E29ktjKciIOrYTHS26GpaIeYpi7KZfs9NmcUy+w6ONELqUXbTti9yd82BMcLbJwoslJYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UAwjfGdAEE0aqEsregsTwBvqAhzSwP44ptO9Lz612eY=;
 b=Q0R9zOg/z4p80FvhtkJfnM9fgxlAqAnfSy7DzR2tPi/WmOB9BACTJtkmlxMINgHJ/i688vFkXLA1iLAqAhPFG9AOvLl2uqPmtpiN5CQVdlJmymg+EhrYk6vsiJjUjGFg16/wEhuHwC15LpT4xpr8AQFimfI/HHMLe16QWZpOkKMViKyD+yd3rSdXT1Ue5u4dO4s3M0Da0HhpH4hX7P4QUef5d+N6fcPuy5pcINo9IoQyNPYGDajyr9SWQyFR7vv1Q7GFolfJacDXu/PLn11C/OKZ8giKUoDTOn4zjAjUJ9rf22SG7ibOzCO0I9+NQyHDcudz2BCou+fIwWT3YUUTGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UAwjfGdAEE0aqEsregsTwBvqAhzSwP44ptO9Lz612eY=;
 b=aLd/hKxPd3GapN0IOf21ys+tOwuL51WbPMCIJMkj+IVEDKWQ67B5CNNUD92GLcW5q9NNBw9BYM6h7QkkwyAXKNaV85ZQ76lQChvlYHWzPLedfVukqKgrSE5CIaSkC0tGhdpiw672NbusqyQkQyeWes2/G1cDOUKFKSCT5HBuDXLCbF2vG7nDQL7Jwo/LmPyWMPrmkWPK8U/wGGN1kigajG92zs4a+0hmgeCC8LeFC9CGMlxDs6mdKfhly12a/Bm+ruZY3FsiD+AslE64AWiTuVhKmWOUn2pZv+8R+Gx9nBVCbTMo+f9imyMz2iEoK2Iivtl6tz5yfY0yw4aX+WRSkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by PH7PR12MB8105.namprd12.prod.outlook.com (2603:10b6:510:2b7::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 14:41:41 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 14:41:41 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Mon, 15 Jun 2026 23:40:43 +0900
Subject: [PATCH 03/13] gpu: nova-core: fsp: try to enforce exclusive access
 to FSP channel
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-blackwell-fixes-v1-3-f2853e49ff7d@nvidia.com>
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
X-ClientProxiedBy: TY4PR01CA0086.jpnprd01.prod.outlook.com
 (2603:1096:405:37d::14) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|PH7PR12MB8105:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bb612b7-1d8d-494b-b200-08decaec3696
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|366016|376014|7416014|23010399003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: MBKrWK7xgoekZXNOIgs0sPGlNmP/dLFi2xL3oCmy+78+YQHsJh5ZVtj7QebTiVDyAHlDaASZXF1VlqxkjFsrDWyAB9uGRpNvEuD+u+jXKDTCxqtCVjrUj0rB+lonUIQEvP2CpGeiLVwu5lEn1EYuTQsxH/T3/0LmKT6zw6A4vFIHAweMpBklTphBbaAizwI+si+L6uVNlM7TPVPIZxw3tJQUMj0ZoQC9DkdvkJrMbXRQmEoNStgEfaDBAO2R+ml17pweOdyzg7jms3IEp5brdZqazEIe3dWun3o1lQODhsow/xvS/rawL3MIttECjd8Y+4UCNDhaJtsil8MMsPdawOLPVU4snOsPsq4qcD8mjvT8VRITFsrM3rrWrq4P/05PSWNRi9pG4A7wdLflZRnzV2eh3tFCDJY9mollOq5HGXvUaH6KWjCE+XjGnqMQKwpr6LyITcaWcI79EaUHyyYAiIo3Q3sAh7fdrzhv8+4Iejzp/5zeL5oIgoINhsyq49lB1xS21oeezR/7N3z0XYwM5YMbnknP9adldLuh3WDuq5MMlCaJTT4rCKunvWtWcVPYkMjvqL3L5oJL/WVw+vNOOKrTcgk1hXh192MYuxoAM2+72qa2kb7usQ+cF1DeQBVnJc6LNUXkkr3DXzyBP+D7u/h/NiNmQ2BeFjMwf6iVAs/KVwhd3NA7L1x1AG61xyZa
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVFqdUthTXczNTd6aGxlcjFCbi9JaVpiRHpUMFE5LytOOFByckFwTzRzbFJ5?=
 =?utf-8?B?dmo5ZE1pLzJ2VlA4S2p1MHh3aWhuaGhsdkltV2tjbDdYMUhScnJJZnRpcStY?=
 =?utf-8?B?SEVNMzJqTHFNRHFLbnhJaC9GdkVrUkUzem1VQ1FtQzVtamtLZ0lram1iMysr?=
 =?utf-8?B?cTZVbDNnSnRqL1NiUzNoaWxsOUhnSDEvSDhHRzU4S2FLYzFjWlFkdk4rdUZH?=
 =?utf-8?B?TUlCSEhvODZWZlBHTkxRNFZCT0ZxUmptSm52b1JJTHlBcmlLOVF2eGFDaXBS?=
 =?utf-8?B?Z3RLaUIxcklRdFg2dUtPc0cwNmtQa0tXTTFiWnlLaklya3hsYTZvcUpmajFV?=
 =?utf-8?B?aWdTam1lREErc2dpdXUyci8vRlQ4ckVBNm1RZnpHbmJGdWFaTEN1RG91Z0hC?=
 =?utf-8?B?T1pTUTVCcVhORWNGWHp2MDBxc01tZ1d1dC9UNzgyWk9ZMEhSVVdUd2MyNXR1?=
 =?utf-8?B?WW56N0d4d0ZyU0FLZnB1WW8wVUwwQ3RrR2pNN3lqQVU0ZTJFME1LNnExQkJl?=
 =?utf-8?B?N21HbGtCNlQ2bEVZYWExYWFQWVRjUklwbWpYVFdmMkhwVGpxa0tndExMOTds?=
 =?utf-8?B?QXBiLzBDU1A4NS82U2lYT2xKVzYzVkx3R0pIbnp3SjhXWDRoY3V4TVhITXNx?=
 =?utf-8?B?Yy9haCtGSHNoUy8rYlRud1NFTU5HVFZoemdDWFBOUFVMOTlsR2FESHJvTjhw?=
 =?utf-8?B?RHhoWGt4MTZsOEwxUk5OeEtTYnVRWm9RYXRwNFNFMmpFR2lySFR4Y3VvbStI?=
 =?utf-8?B?cFFIN2dzdFFQenQvRUwvbnVKc1VmcVRzYkVVdkFQN0lFcmxMaXhGZVNCcFJo?=
 =?utf-8?B?Y3RKakpNZ1pLZVJoYnB3MldoTFphUzdvWFR6cXc0TEFsYkUzMHlYRUdUem5Q?=
 =?utf-8?B?aG9GMCs3MWxUNVRyVFdBdWd5M0NqQU1YRlNKS0pydHlWakhwUEIvOGtKaTEy?=
 =?utf-8?B?SHRUSzFIMy90Q2M1YzNoMGtBa2FheXdXUE9PeVd0dGxKTjVzOG5udVZ0S1l2?=
 =?utf-8?B?UDA5SWlncWVidU5BVi90RUlib2tMUW9BQW5JcmNKcU42RXBUK3JEWWZGeWFi?=
 =?utf-8?B?c2Y3ZlNUbmlneFViN2hyeFhZWCtacjNNS2wwV2cyQmR5RUFER2RMMk5EWnBu?=
 =?utf-8?B?V3pIT0JnSE5CMEpVVmNPSUtOV3U2bnVXQ29GREdueUprdE93WUdJdTVrZ3hv?=
 =?utf-8?B?blRQMmQxajJmVTZkczkyYWFTU2R3U0ltYUFSQldoWnlVblRkeWYyK0pzU29h?=
 =?utf-8?B?TFBSbkEyd3BpbFdSVzFzajcyV3RzaTBBMFA4WHJaMGpwWjlQb0RXSVI0QXRW?=
 =?utf-8?B?NWp1dUxKS29PZ2o1c21QUTIxM3dMN2lXY2V5R3VST1FGc3lsSWRZZkdNM2V0?=
 =?utf-8?B?M2lFVkRnay9ySW9Ud2FlM0VjbFh0b0Q5cHVFRW1hei9Ra09vYkF1S3RzT3l2?=
 =?utf-8?B?NWFoVTNnNjRnRFlFYmhpeE1CTWNsL2lHWHYrdk5iTjRSSTVsQS9KS1Y3NU9t?=
 =?utf-8?B?OEduOWYwbmhIQ2NrejUrTlFiVC95M2hBeTU0TmRPUk8xWlNTZndtbjVUdVg2?=
 =?utf-8?B?a1h2ZlR5Zk40U1UrMXJRdzBUc2U1RGtTMW4yckZwMjhGQk15RUVwT1VXY1NI?=
 =?utf-8?B?K256bWwraGdTSCt5SVVQd1pyUUFyMDhnTlFtcTlIcDlsSE53T2QyTWNWNWdK?=
 =?utf-8?B?cy9saUhPa2JXMGVKY2JlL3daVGlZQng1RDdDc1NYZVg0Q2ZTM3MzSE9wRjhn?=
 =?utf-8?B?QVpGUjd6cEEreS9NT08vaHRSK29xQTRHMHVQRzYvYWxPM0ZOVkZNRjkrei92?=
 =?utf-8?B?WEF3SmFXTFdETHBvRDdtQk56bG5HZEl2b2laVzM3ZlJnWlBUM3lkdGpkZzhE?=
 =?utf-8?B?TjR5WWtFUTZTOUMrYTZNelpNQ2JZSEh5VmtwQmFWUkJkVmJDdFIvMUdzM2to?=
 =?utf-8?B?WEc4TnRRMnBobU5QNzVqZ2REOCtrbEIxVjcyOEFJOHFqV3BlWi9oeUwvVERF?=
 =?utf-8?B?eGpYbWQrNlZjNW82WGZWa2NvSUJSSlZicnZKYWlwSGhybFk3YkViMjFwSVFz?=
 =?utf-8?B?VkpHU285dVNQUXl2MnRyVld3QnYrZmZGZE8yQzBUTUdtUHNUMkxsV2huTWNQ?=
 =?utf-8?B?Zkp4WnNnanJFS0gzenBMV055QWdUWm84Z0NUMGFkMkJhSjlGYXlxd2J5aGlV?=
 =?utf-8?B?SjM4Vjc2NitNanhzeVRBNWNnaUJBTVFyWmhacWEyV2dQcVpEaHBXdU1nczNy?=
 =?utf-8?B?MlNyUDJyN1ZtZDZWOUNPUkRjRk1INXUxT3dDNDdra3VnaGI5UHpZdmg0NS9N?=
 =?utf-8?B?dWZObEh2SHpaV0phT1RrWE0rdmxqeWt3ZUdWQk5MblllSnozVGVHN2hNTUNq?=
 =?utf-8?Q?XKcMYa9ZL/DI1FqyhHXbmrlaldYmbVvV3WrpUP7SWnwfB?=
X-MS-Exchange-AntiSpam-MessageData-1: d0+Ekz+8Vilhfw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bb612b7-1d8d-494b-b200-08decaec3696
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 14:41:41.1233 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: umP5o9wueZzux0Uon2pjGdeYTHO+86d1XQ0G4UjV9r6+2IFRBD4Py4Ujvw9zHGJHqHv8h13ZIqwNLdvd3uIFZQ==
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

Currently, `send_msg` assumes that the channel to FSP is free to write
into. But, it might not be. Both the kernel driver and GSP communicate
with FSP. The way they should attempt to keep exclusive access to this
channel to FSP is by making sure they don't try to start writing if
there's pending data until the full round trip has finished.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/falcon/fsp.rs | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/gpu/nova-core/falcon/fsp.rs b/drivers/gpu/nova-core/falcon/fsp.rs
index 21eaa8e261ce..cdb476894e1a 100644
--- a/drivers/gpu/nova-core/falcon/fsp.rs
+++ b/drivers/gpu/nova-core/falcon/fsp.rs
@@ -125,6 +125,26 @@ fn poll_msgq(&self, bar: Bar0<'_>) -> Result<u32> {
         }
     }
 
+    /// Both the kernel driver and GSP talk to FSP. Try to ensure exclusive access to the FSP is
+    /// enforced by making sure there is not a pending message already sent to FSP, and that there
+    /// is no pending message from FSP to be read.
+    fn wait_until_ready(&mut self, bar: Bar0<'_>) -> Result {
+        read_poll_timeout(
+            || {
+                let qhead = bar.read(regs::NV_PFSP_QUEUE_HEAD::at(0)).address();
+                let qtail = bar.read(regs::NV_PFSP_QUEUE_TAIL::at(0)).address();
+                let mhead = bar.read(regs::NV_PFSP_MSGQ_HEAD::at(0)).val();
+                let mtail = bar.read(regs::NV_PFSP_MSGQ_TAIL::at(0)).val();
+
+                Ok(qhead == qtail && mhead == mtail)
+            },
+            |&ready| ready,
+            Delta::from_millis(10),
+            Delta::from_millis(FSP_MSG_TIMEOUT_MS),
+        )?;
+        Ok(())
+    }
+
     /// Writes `packet` to FSP EMEM and updates the queue pointers to notify FSP.
     ///
     /// Returns `EINVAL` if `packet` is empty or its length is not 4-byte aligned.
@@ -133,6 +153,9 @@ pub(crate) fn send_msg(&mut self, bar: Bar0<'_>, packet: &[u8]) -> Result {
             return Err(EINVAL);
         }
 
+        // Try to make sure we have exclusive access to the FSP at this point.
+        self.wait_until_ready(bar)?;
+
         self.write_emem(bar, packet)?;
 
         // Update queue pointers. TAIL points at the last DWORD written.

-- 
2.54.0

