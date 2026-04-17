Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9160DF436B4
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 15:33:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A614610E2CA;
	Fri, 17 Apr 2026 15:33:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="i6MTCWYP";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012052.outbound.protection.outlook.com
 [40.93.195.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FD3410E2CA
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 15:33:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HcIH2WIdEV5vaMfMYmLVKHVEGdo8V1e72Sm1WKtuUzJGVlVBAcHXqozXWSat0H+2BtaaYLKIeSzzZrr+0joduFpXhUmApc8+WIMTue+cfFEa+xlVt1PRw9TP2GxTaFQhn/ELE5F8jZ2EgSKhD9xo6tOdPF48fVJIBX266htpitBmY9Qva3M0nsiWIX2vbBDL+D2RtlHFjimvkie/RPfowmSwm9lzPTN90LQ3yR/x43dXL/mJA1Zv8mylCCSq1tuEobWH0aiOQJT5sIGqxHnqFW368Ed9PzZ5qB5QMkDKzrJITTnrrg9gKzQ2C7E4JeNJRNcqf3sgPyU+dfS3WP3tzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O4AkljXHdD5uDCDTQ8E1of2p9pvM/3eiyRpbs6sT+Hw=;
 b=YaZ+gqKJKS/x1LRxvhFVRli0+KmDUvZiQaET8RJX1mqjjWcOz/rlQgycRXcczV1y+vsPDIqf2uIQ51wucaciqBaN3S9/GItUctBkn+pxWdCyDInzFCqPiwEiiEgikl+Ziw7PRnHJtt7p5vdeAzADhoFmsp1hYbdYHnJ4u4VGeUk0sBXEpVw82fAhQAda4uaXHwBHG6FczF1l5UA8yGOD0wvV9On/1ALqUuWaBAO/MJht18btzP9VWFV7ssvX9yLGWGkO+tRUTbu9u2UlS1YBtxXpi6ZvhBDLAi0rEr7PXjA8Q7e6gHI0haNp1IsItFW+AFcSyI1khJV3L1lfEKbjnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O4AkljXHdD5uDCDTQ8E1of2p9pvM/3eiyRpbs6sT+Hw=;
 b=i6MTCWYP6aVKHNxfmvAsN/uC/KwpgmeE1vKdoFGus2ObwVIzh2Bczt31HCWPSevI0ZpnqvzQwtzNjZVToV8lTPtMMqKAOF9BL+qLyaAI3bLvObmtEvEC+SHFy3tee38/QcdBqOa0T7zVFhfbaOP5Omq3VBYAJuUFFDQ17KmvUiNUixqCVDm4RDeG7Tv/Qp+UyUen5f1PxQ0uTQUx4Y3eRxgN3g68y+gdjB1cHzpGELQvsjnIXq5U4cr/g4/sKh/BDzn5bpDLgLnY8R10cJDaJJVi44MFMp5J+G6m1gynS0VGP4RPFi+P9TE5c5YGsTlCn37jOI1vSgrisc2PmkmhIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by DM3PR12MB9389.namprd12.prod.outlook.com (2603:10b6:0:46::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9818.25; Fri, 17 Apr 2026 15:33:30 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 15:33:30 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Subject: [PATCH v4 0/8] gpu: nova-core: gsp: add RM control command
 infrastructure
Date: Sat, 18 Apr 2026 00:29:18 +0900
Message-Id: <20260418-rmcontrol-v4-0-fda8c76dbb95@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2WPy27DIBBFf8ViXaLhEQJZ9T+qLDAempFq04KDE
 kX+91KnUh11eUdzzp25s4KZsLBjd2cZKxVKUwv6pWPh7Kd35DS0zCRIA1LueR5DmuacPng/WA8
 mBuVhYG3/M2Ok6+p6Oz1yxq9LU86PIet9QR7SONJ87PzBg4W+11IZ9rN/pjKnfFtPqWIFflsPm
 9YqOHBrjLaorXHRvU6VBvK75l01Vf6hStgtKhvqvIveRBF0UP9QtUGffq2qoVEJEOCUthqf0GV
 ZvgG84AfRSQEAAA==
X-Change-ID: 20260225-rmcontrol-bd8a06fc3a0d
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY4PR01CA0092.jpnprd01.prod.outlook.com
 (2603:1096:405:37d::17) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|DM3PR12MB9389:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fadf5f0-ada5-45eb-9494-08de9c96ad7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|376014|366016|1800799024|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: nIQ/nCPXdpBAikE5ES6n/0M1UeE4/txQ3bfacww9e4DAjlF45BbWeH3u5wJiHO0ez1lCrxbpxmaqrPIiNudL8o4AZenrqn5zzr/EUnBgbfplyDBYqkxBXJXAIe3dEjMKQpmcGl+blZavVTwkYB1LDmA6IqdwHxNS7UK63xReWEfe6+3rOKlVSEOU+GLHrhAVoy0bXhVZRFFGwwICNmRhazOzR0E5DIX7dcuoqTG1fXDDzbNlu4JV8oU10+8Yg/5JIltc+SlbTxUzNTWNIXgaCuZks40jN3G1TX1UUCVpjS//S06Qp8fmsxUegmgMqN8YKClJRQR2bxdmYn6PSQrOtlIEDF2NhRtjNiFcGay2A7yOPPU0lTTfri4JTMHVJhFQb2doZr8T1lSihe1zmOWo30wUtaXHw/wAZoGXEiZ1WO5naB8zB/FAyxCDEkECOIp2O/Ru1yKA7tmSy09r5w3oAnLOlwjR/IaF85a2009a8gSljK+ALI9GEf6PQl2CaSVItd/Co+bKi2u82fNkTqh/tEKjLptiVPymDUD4jFmqUp+SiW3sKK5Z8pm0CpllQty7I94wp1ycN0H0eBLUZ9R5LhcUegOQgZ/DyNl3PS65nQloR5g04xEmr13aZwWLxkUsPNbrX0DnePnS4TL39acN+093lY64hsKKj2DvdBRw6/EjJbkjI/0aPjU15KeXgVOkQOcMiEPQ5RROZC3037wYxMk9se+5q04rmeyQmEHmzss=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkJ2SnkxcWFZeGZsVG14VysvbHhuOFlHTlNlei81MDlndnorblNEQ3VXZm5O?=
 =?utf-8?B?bXUwb1o5S2hsU25aeUpVdE12ZHRMWVYwbXlNOGlLYTNyZVFzOEN5Mlc5d1B4?=
 =?utf-8?B?N2x3aGIzUm1IVnJVVnhSWVZWem8rNUttSkRURzVrNHNXOGNjdTFJWlgwcndU?=
 =?utf-8?B?NUtEUHM5TTh5Ly9zQjdWVWxQM0UxY0tnc0dlSFNpbXJRUmhRVE0vZHVTRktV?=
 =?utf-8?B?K0I5MU1NSVozMjBPSUwwdUNqM1JpMWFVakx4MlVsRTNrOHpnZHU2a0RObjM0?=
 =?utf-8?B?Rk52dG1DSk9odktlejJERFU4RWJTYkl3eWhEazBxYytqT2VVMzZGWEJiWWM3?=
 =?utf-8?B?QWRKem85RjdWRVFLYVk2eDhJTHZ4L1hJTUFDT1lORlVhaURpZDlyUXM4SzdH?=
 =?utf-8?B?UU05RnZNV2FUNXV4bVlLcUFIYmRZWTFRekkzaFZDa3prOUpvbGVwLzBJRHhs?=
 =?utf-8?B?MERvcUpYKzF2RTVFK0hXakVxaU1YbjJlaWJMTTk5TGIvbjgwVjFnZm5xalU0?=
 =?utf-8?B?R1dGdDN4STF5cU15ZmxacFJoY0RmaGFhaDVmYVVmd0huQ0R6TXA2SnJWUUdl?=
 =?utf-8?B?eUNMWHQ4cktmNmpZcVdDYlZLRGltMklVb1RvSFFjZlVHZ2pIc2s0OVRXcThR?=
 =?utf-8?B?cGNnMTBYT1dxL2UxZ3JCMWNCU3RPVEFjV2ROdFUxcWRGcXdkTWlyYzdxYVdU?=
 =?utf-8?B?VUIvM1JJZVBwbllCVTlRNmtVdG1EYU10aTFIRnJVdnlmRWR3bVh1UWJjc1pQ?=
 =?utf-8?B?SGZaNVJuUnVDUG5xYWdKVTUrUWpBWDRveE95YWpLb3cwVGhORThjZ01BQmlB?=
 =?utf-8?B?dlU1RDBrV3l5TDEyWGRuZHEzMkNZSE55SDJqRkpvQ3ljSFNXbTBjU0lRcGhl?=
 =?utf-8?B?L2lneEFsTGxIU3UrR2dzdkRCZGV6SmkyMnVOY3h0ZTdzZHBHWFZlckdpY2Fz?=
 =?utf-8?B?NjEzSnZaTEF3b3FWSUV1Z3Uyd0x6WnRrRjFGY1hhMDhjWDA4QUorclJiVUZ0?=
 =?utf-8?B?QlI3YUs5NzFmR1BoYTdpeWwyZjQyWWF1emxoK0JCaURxNW5CcGhWcVh3bFZ5?=
 =?utf-8?B?UFhJUFNZNXh3Ni93OEJKMUpobkxpdkpkaFdldVRNSlRscHV2VVNOM2RzSUtB?=
 =?utf-8?B?c0I5VUpnVEd4bm5Mc2hBMHVUYmhQV2FTRXBuZ09PNFZQUjJaTHF4Z24wVXJW?=
 =?utf-8?B?Q0lkNzNWMXVJdjM0QWhpM2V6UWRpaWpZSDFFM1VRcVlkaWFvdjRXNTRVR21z?=
 =?utf-8?B?MkNOS3ZUczJBVDMreHl3QTdjNjlRTWJLMmM5UEY0c25Wa0xESVhmMXBBckVm?=
 =?utf-8?B?YzVHWmZvVlhVSkxwanpRNVJsQ0RzMmNTNjF5RzBPc1BoNHJSWU45RUZ5cnk5?=
 =?utf-8?B?YXpFWW5OcEt2RjJ1azkrTllCRHE3cTlIZytUZWhCc3I3Y1pIY3pNdDVjVnVK?=
 =?utf-8?B?cCtYZzhOYkhZcnc3dllQcDJBSDlUdFcxSlV5YjlYTFFlNFo4Z2FpdUMxWk9u?=
 =?utf-8?B?MTJON2dwMFQvQXlUZGZQQkQ0eERidlNmQlNwcE1zV1dpNFVGTytwcVV2UWlW?=
 =?utf-8?B?ZFpMNVVaazdoTk9hbWZjTEN3SnRhRVFmeE5lY3ZzQlJrUTRHVXFIUG5SSXha?=
 =?utf-8?B?RFJONS91Uk1hbVFXMEx2SmRHeHVMTmRLOE4rOWFhSFV1ejlma21nM0szRHlU?=
 =?utf-8?B?b0ZDQjVNcVh6a01pSHBDSnFYS0ZjaDJMakRFWnF2VGFZOG13NXBhZDhjbTFl?=
 =?utf-8?B?a3JmOWNmaUc3SURUY1NPd0Z2TklEMktGZ3dXN0g4Ukc4KzljQXVSMG9aMUJ6?=
 =?utf-8?B?M0Ywak04a3RBNGx0Y1Z6OHNFbXB2eHJnNkwxVkRuSFJOTXZUUlJvVkozbG1o?=
 =?utf-8?B?Zzc0MkVQSHBZemJxSDVIN3Uvd2RrTFUvRmxtbTRQc0o0K0hadWFQM2xueFVS?=
 =?utf-8?B?VHhTNjNrdFV4elBtR2ZLaDZSWmp1MGtOMXhOVUJ1RFhuNkx4T1BKS2VHMVZI?=
 =?utf-8?B?bmlONXB1K0NiemVybmg0S3J2ZHFBYUZBb0puNXFRZndTbU83dmFlVWZyOXNt?=
 =?utf-8?B?bVo5SU4rSmVTL05NejlIZ0lpalZFZXhHVnpCdWpmeUtNQ0xRaXNxZ2VJUlBi?=
 =?utf-8?B?RUhQVHhlV2tFM2N5a3pXWjJ3eDNiS1p0Y0QvaEFkR21aQnFnMUN4bHFGT01E?=
 =?utf-8?B?NUtWaVlJWVdJWkRFSlVSTXlzSXl6ZXRBVDArRTFObWZ0VjRvM0hpUFBkdksw?=
 =?utf-8?B?d05GVnpTN2o5dzlyZWh0eDZ3SUNPNCs0K05JQi9kNWwwcEVhSHlHaUNjWFBi?=
 =?utf-8?B?dGRrRDUxa21CbnNCVTF6Y0s3YjRHR2dua3VNZWRKNmVzeHkzYkNkSXAwZHhj?=
 =?utf-8?Q?qbdzL5rHSFzXd9fhMRAcsp1q1WX0LjR6pOW5OXiK+liLT?=
X-MS-Exchange-AntiSpam-MessageData-1: g0O/roM101jEGg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fadf5f0-ada5-45eb-9494-08de9c96ad7c
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 15:33:30.4090 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cNNWuaRgMmbOJ74HOEydntrc62aovZV3K4zIpsz5ez21fcRojjFGUc3hNun3DFezhOp+nDZ29wjqWLd4wrFlkA==
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

Add the infrastructure for sending RM control RPCs. This is needed e.g.
for channel allocation.

This series adds:
- `NV_STATUS` bindings and wrapping `GspMsgRmStatus` and similar enums,
  used by generic RPCs and RM control RPCs.
- The necessary bindings for the RM control RPCs.
- `RmControlMsgFunction` to identify individual control commands, like
  `MsgFunction` for GSP commands.
- `SBufferIter::read_to_vec` (using KVVec) for reading large RPC payloads
- A typed `RmControl` command that can send RM control commands.

Each new RM control command can be added by extending
`RmControlMsgFunction`, adding the bindings and wrappers for their
parameters, and writing a type-safe wrapper to send and receive the
reply for the RM control rpc, using `RmControl`.

This series applies on latest drm-rust-next at the listed commit.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
Changes in v4:
- Collect Reviewed-by on patches that haven't changed too much
- Split NvStatus enum into GspMsgRmStatus/Warning/Error
- Added GspRpcError for Cmdq errors
- Log NvStatus warnings
- Exhaustively match for NvStatus error -> errno errors
- Change a few NvStatus->errno mappings to match openrm
- Drop fault method buffer size patches
- Link to v3: https://patch.msgid.link/20260325-rmcontrol-v3-0-f3101093484e@nvidia.com

Changes in v3:
- Remove `send_rm_control` in favour of a typed `RmControl`
- Print out fault method buffer size at gsp boot
- Remove Reviewed-by and Tested-by on some patches that have changed
  substantively.
- Link to v2: https://lore.kernel.org/r/20260318-rmcontrol-v2-0-9a9fa6f1c4c3@nvidia.com

Changes in v2:
- Introduce typed Handle<T> for RM objects.
- Improve naming
- Improve doc comments
- Change SBufferIter to always use KVVec
- flush_into_kvec -> read_to_vec
- Rebased on latest cmdq locking
- Link to v1: https://lore.kernel.org/r/20260227-rmcontrol-v1-0-86648e4869f9@nvidia.com

---
Eliot Courtney (8):
      gpu: nova-core: gsp: add NV_STATUS error code bindings
      gpu: nova-core: gsp: add GSP-RM status types
      gpu: nova-core: gsp: add GspRpcError for Cmdq RPC error handling
      gpu: nova-core: gsp: expose GSP-RM internal client and subdevice handles
      gpu: nova-core: gsp: add RM control RPC structure binding
      gpu: nova-core: gsp: add types for RM control RPCs
      gpu: nova-core: use KVVec for SBufferIter flush
      gpu: nova-core: gsp: add RM control command infrastructure

 drivers/gpu/nova-core/gsp.rs                      |   1 +
 drivers/gpu/nova-core/gsp/cmdq.rs                 | 112 +++--
 drivers/gpu/nova-core/gsp/commands.rs             |  71 ++-
 drivers/gpu/nova-core/gsp/fw.rs                   | 544 +++++++++++++++++++++-
 drivers/gpu/nova-core/gsp/fw/commands.rs          |  19 +-
 drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs | 156 +++++++
 drivers/gpu/nova-core/gsp/fw/rm.rs                |  90 ++++
 drivers/gpu/nova-core/gsp/rm.rs                   |   3 +
 drivers/gpu/nova-core/gsp/rm/commands.rs          | 155 ++++++
 drivers/gpu/nova-core/gsp/sequencer.rs            |   9 +-
 drivers/gpu/nova-core/sbuffer.rs                  |   6 +-
 11 files changed, 1117 insertions(+), 49 deletions(-)
---
base-commit: a7a080bb4236ebe577b6776d940d1717912ff6dd
change-id: 20260225-rmcontrol-bd8a06fc3a0d

Best regards,
--  
Eliot Courtney <ecourtney@nvidia.com>

