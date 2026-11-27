Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B0C606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 14:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ju7OMbA4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FA5E10EA90;
	Fri, 27 Nov 2026 14:04:21 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010011.outbound.protection.outlook.com [52.101.201.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC7D010E9E4
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 14:04:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TUI1D+2M+9bkWXNvc/vCaUTEfpsZClEH4rZcF9Dm1MGGRSIdLTSymFqyC+1P6vP6zz0UMyYSanhO2nA/iBCfEsYULtDYc97KzKgcskaKuFV5BZZ6TRK5ac+MjZR9qG4IOrAP9meRnBsyVFspjmKymFZq1Uu04Hrb95VmUf7RFFFZp1cJfqYTyoZ0LxZ89jYq01e61ZBoHSbEe3DedoQcFqX/SWGzZR9uEUT+xT0EmcejnL4JYeRlB1NzlVyOcKrc9cwHgLcHvMY29Pnh/l0Tagp3GkwAXNmdLGDrR+d4hmdZ7qlwi2SOQJd3SECy8yCyShoXgfo0pz3tN9iGbPVNXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o1yxfJmvCJsjXaJFTwJBWT00sitMraqI8VjwJhKAFr0=;
 b=DiSz9djXKo6U33j1Iy5Aw4k/zOmZ4MbpKIMmtt/SLmF4ASXIDBJi1RHRM/JTGJRtAkpeVI5JPjae0TPuGK0wh32kJb2FVrWOOiVg3Bd3Z12C4Ln+4An8r0MEcvb5Zo9H3urpWf7fFWf+YxPOio+dH+rj2TN8YQndHJhKIzaSjWYf7FV9g9F1gBNG5obBXAPmMGhOkDhoRzt5EclG6rX4FdGxbhtN+gjnU3x9ySshW2K3m1NcIKzBKS+C7sXhpoCfHmwrizBaf9/g+W9A4biuQRN+BoPLtM3bHvOU8AViW6ss2UDCRF/FGOATMTbz2Ee0F8W87WNiTYszPVdIw0S+sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o1yxfJmvCJsjXaJFTwJBWT00sitMraqI8VjwJhKAFr0=;
 b=ju7OMbA4qr5Ky89ImickYHAGZhZcGR0JVcfZkgLXPYzibf7VS9HLulnjapZ8pYleEpda+QXpBAHGm9hg1n+c1h/72I+6tjQALpMePP6AvHu+dgKgoFv/7jeVLszl62cQ+muKoq3FYKcAkx/KOt6oJVxL48bJeoyggYVAChxnh9ev3G6fe16DNH6bcfPpFXqD1HPmaj8DYfb+ToyCou+MuWiqk9mPRN4AlEXu0lSuobEZPwJeFGsghTikqsGeZ0szWpEgoMHFztJK/secvK4lhDM3QXgogBTxIes+AGe+OXq743dDJiFwRgSMoX++CUADrRMyuEEptDkDIYu75lIXDw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by DS7PR12MB6168.namprd12.prod.outlook.com (2603:10b6:8:97::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.4; Fri, 27 Nov 2026 14:04:09 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0662.001; Fri, 27 Nov 2026
 14:04:09 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Subject: [PATCH 0/4] gpu: nova-core: gsp: preparatory patches for the r000
 firmware
Date: Fri, 27 Nov 2026 23:04:04 +0900
Message-Id: <20261127-nova-r000-staging-v1-0-4eaf6e3c0942@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMMQ6DMAxA0asgz7XkRISIXqXqEFIT3CFUMSAkx
 N1J2/EN/x+gXIQV7s0BhTdRmXOFuTUQp5ATo7yqwZLtjLEe87wFLESEuoQkOWFPLvrRuZ5bD7X
 7FB5l/z0fz791Hd4cl+8IzvMCt02VU3UAAAA=
X-Change-ID: 20261127-nova-r000-staging-905c7f559e47
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: TY4P286CA0137.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:37f::11) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|DS7PR12MB6168:EE_
X-MS-Office365-Filtering-Correlation-Id: 74e5ece7-34a6-4996-c85a-08df4c8f4e30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|10070799003|23010399003|261026121527099003|10067099003|11063799006|261026140227099003|56012099006|261021123027099003|261022105027099003|261022075727099003|261102123227099003|261009223027099003|261021121427099003|261028144727099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: GOFoMqPOncsC1YHhl/dSfpJmhBfHfeJbHKPS1z9+2XR0PsBO/Os66SL6kuNqqL/5Py5NP4iXy9bKYs9GuS4wedwUKnAoonXEwwT0gzx+Ho4VEkUl95+uvxVaDW0dCTjl4VO4xjNMpsKEHsxa4cj5v6TGdRPwC47a6HvtIriGi/DLlM3wbdwHhgZHd2lHnSlQg0qdy/e7fT3x9lG3hwh6lQDfZwWfYphwdB2BnkmDdzwV3Nt74kB9duLEAoWv+IBI6BVDL/aTSG+qfLkPbtnK5tR1DaBgO3gqK+ZD8K1Bw6QoM54iJsaDUNiP8hRq49Nfv/SWPuo56nx8s5csLkkhCKHzf0Zf8B2/e1kIrRM6oGdBqwypj/MgInABIrDtKDxW5VAlny65ciU8/P6EHKhZK/fnpm+Oq6KmML48EU9QNoi2CIgskZRqyJp+iFsO4seEdh1lxTC1KHO7lriSXTeN1/tF2jHxEFsB5xYo8qWEurmLUt9SDPxqBPMBkkv+HT/aTBnZAD4HKbNxZBU0mqCL4atIlJdyOwfgAWB6c0sM4b1TQCImgsRVFo2LSR0nLrkQiizoig+EGMzRiTOORI5GrtM5A5yXSZ3bs4JRCs28suA7Qxs19ZddNSPlG7RGCaEBevMqBMD1ocE1O50UWJ4ub8UDQBcsbW05Sj76csCvIZY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(23010399003)(261026121527099003)(10067099003)(11063799006)(261026140227099003)(56012099006)(261021123027099003)(261022105027099003)(261022075727099003)(261102123227099003)(261009223027099003)(261021121427099003)(261028144727099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akNnSWxqNVJnQkRqaitwZWdSV0s0TDJ3QTN0ZElUVmJJYURYZEdiaVljemR0?=
 =?utf-8?B?TWoxbzdROXhlU2p2Sk9RdG9HR1VvbjZQRTVQbG1CQ3N2cUNjRjlzUXZRbWIr?=
 =?utf-8?B?T2gzQ2VScjFzcDFuY3luUHJ1UjZhYUU0Qm5zOGhIQ1pQTVVvUkdmZTRuYzdB?=
 =?utf-8?B?djdsc0I5L0FGdCt6dVZPQVBRdzJZNGp3TlZaclVwYUtacjFNSWdiZENRUnI4?=
 =?utf-8?B?M0Y5dUtXU3FTQTBpMkM5czA0cERLcWkrTkVWeGt3RW0zNytJV2dpeXM0TWtR?=
 =?utf-8?B?ZmdEYkpBNHNGay9EZTFYNmI0MzNVeWhDWDMvQ2RvUTNhdnJpUTlLQVVUdSt2?=
 =?utf-8?B?QWNCSlZtaWc5cFc5YW9ybkhZN284ZFFucDBBUHl6Y2ZCVnJKRkRmUlpNWGdl?=
 =?utf-8?B?bS9JNDZhUTRYT3dBbDdlMkJxRWh6bElKeDZIZWIxcXlwZFloU211S2dySUlG?=
 =?utf-8?B?dVZNTC9SV2pqd2Z5SHVJVGdORW1yc1g4d0QzbFN3Y09SaE5BSDhmNGJzNTZE?=
 =?utf-8?B?QldtdDU4T0dBVDAyUUxQTlNibHF0NG1EUmF6Tld3anRhRHlEN1VtTkhFWCt3?=
 =?utf-8?B?Zm4zbVNONnVPMkhab0F3V0tXS2FPU21uTzM4NzY3dHdpUDdCd3FJTFdKT3lw?=
 =?utf-8?B?SVd6SXRNanpMYzNjd3AvRVJyUUZ1cVJuYmsrNXU3RytMV3BZcU43N1FpT0J1?=
 =?utf-8?B?dTZuTlRIRTB1SW90bWdtd1VxSXd0YlFyOVAzOEJJdG1oM1lyWE44QU1ZNXRO?=
 =?utf-8?B?WkIxc2c0UWErdWVickxvQThUVkdJcGY5aFBtdFllWTJadGZ1VzlDRFd3TGZL?=
 =?utf-8?B?V3pYSERQd2J6UTdKYmw0Ti9xcGtldHlNdmw1bU45WWJubnZZZlZDdDZDUWlO?=
 =?utf-8?B?U2ZNVkpqMjlUOTh3SFVwK0RnWGZVYm90RUFTLzQ4NUNGTGp5UzNTYldqeXIw?=
 =?utf-8?B?SUw3T3BXcDltRVBKOGVVUG1jb0wzSmtsY0xpcnVEdGI1WThsZWxJMkNZTDBp?=
 =?utf-8?B?MlZJMVM1dnVnbzNUWFBaSkNaREF6MXhXUFd4WXZXRW5xUmRwTzZHSG4xSklN?=
 =?utf-8?B?OTk5eEw4bUI1enZ4czcrOFVnUkRndDdwTmF1MGdCTVRUbFRXRnNtL2tPNXd2?=
 =?utf-8?B?NFhKMG9jS3FCeUpDUkFBVm5YSUhnOHA4VGJkTWRUWEFMcWx5TU5aK1Z6WnJ5?=
 =?utf-8?B?Y0JKL0lxZEI0Qnlaa043NXB1NythL1dIYUZrdEN1WmJ0MjkwWFl4UkptbFVa?=
 =?utf-8?B?Y3R0K3NRVUhRNjhqdWtOYUVqZDFMV1VDaXFHT2NGc1pkTFVXMDhiNlZSR1B2?=
 =?utf-8?B?SUF2bDgxVjdOZTZXU0lweUZtN3RlcmszYVdNQjY1a2crd1ZTaktzalFLMzho?=
 =?utf-8?B?bkxSN0hrUlVWWlo4NlRKaDdPZmFzQ3RUelQvdSs1ckNMZ1BxelZ0RU1ZcjhS?=
 =?utf-8?B?S0lEZjRTLzJBUEpKZVhqWDZWZk9LUkZkYnV1eDd6Ty9tZFFjelUvWGY2KzNw?=
 =?utf-8?B?NlJXZXR6UFFlQkMrd2dmV0s0ZTJibDdyWlhoYlp6WU9uSGl6QmNKbEpDVVFF?=
 =?utf-8?B?MHJDOXk4SWNHTkIzN00vWEY1MHQySUZWTklqY25UL3NHdVEvSWN2VnlicGt3?=
 =?utf-8?B?N0Zwb1gxdTNibzVPZHhITmx0TVEvR3puNUhpRS9jblJyTEtmcExpMTNhYmFw?=
 =?utf-8?B?ZU1EeUdpak1RVnVPRHVoTU9LU2w1YmFBZlM0OUI4NHRWUjRpRHd3QXVaTXV6?=
 =?utf-8?B?OFdJMlRzQ0Uya1FvMkpBdVlFR2U2MENtc0FkVVhBLzZoK1lDTWxOQUR5NXpl?=
 =?utf-8?B?OCt3RmRhNjlTWjJsZWlIa29jVm0zamVDVkRBN2s2K3dmTWs4b0IwdUcyR0Ex?=
 =?utf-8?B?cklhaEQrVHRhWkc0bVRGcGpGTzUvM1dQWlB5YzlvdVVVeTFodXUyb1dWQmZY?=
 =?utf-8?B?OW9WbXVCUzhiMzhKdXJRSGFJV2s5bTEyeklHVHpQOXdqWXFMRU90YVcrWFNu?=
 =?utf-8?B?VHRSc3BmaHorOTlDOE5Kb0lPNFd1aUNya2VZWGRBL2dreG92QnFTSThsSFlE?=
 =?utf-8?B?T1B1M3oxM3ZrWkxWTUJEbU5ncTF6SFRpYmx4cnIySTZzNXJsWndubitYdWNH?=
 =?utf-8?B?L1BUeTVkSUorY0Y4L0d2aC9GZmpKdFlLK2hYVExWUkNwRUJ3SWk0clBNclVn?=
 =?utf-8?B?QVRRdnFsTmFXcm1uVWEvOTJpYVRRTXRmcE9DdmtFQzVTbjRiU0Q4bC8yN29E?=
 =?utf-8?B?cEtOSTg0T25WZFJJYXIzdmZkUmF5dyt0VEV0NUQvRjJPOE1RUnJ4SWR1WmdO?=
 =?utf-8?B?cjB0UG1qYnBzVDhBQWJZRTZobzZRVmRyMUVJeHJxMjZ4ZDIrelRCVnQybjFi?=
 =?utf-8?Q?H/mcHH35gQdy+Nuxat6tvB+c5J4SNaUX9v50SZEcl/nrN?=
X-MS-Exchange-AntiSpam-MessageData-1: i/L0MKEX4Uj3Hg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74e5ece7-34a6-4996-c85a-08df4c8f4e30
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 14:04:08.8928 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pd9GYLvE5ZGc2vVagCxRn4G9/UOK3UXQQ/+R3V+2lCn/9TM3x4bSWqNEocAHot9GiGm7owpZMLWhru+cowpmrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6168
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

These patches come from John's series switching nova-core to the r000
GSP firmware [1]. They do not depend on the switch itself, and both the
rest of the r000 work and the vGPU series build on them, so I would
like to get them in soon.

Patch 1 adds the r000 queue element header. It has no user yet. It was
posted on its own before [2], only doc comments have changed since.

Patches 2 and 3 make the static GPU configuration something the boot
sequence returns, since that is where r000 provides it. Patch 4 adds
the GPU short name and GID to the schema of the GSP_INIT reply, which
is not used yet either.

The only runtime change is in patch 3: the static configuration is now
queried at the end of the boot sequence instead of after it.

The patches were reworked since v3 (patch 2 also moves the type, patch
4 is new), so Timur's Reviewed-by on v3 is not carried.

Based on drm-rust-next.

[1] https://lore.kernel.org/20260918010719.1176945-1-jhubbard@nvidia.com
[2] https://lore.kernel.org/20261117-msgelement-v1-1-b918ffae5e7b@nvidia.com

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
John Hubbard (4):
      gpu: nova-core: gsp: add the r000 queue element header
      gpu: nova-core: gsp: rename and move the static configuration type
      gpu: nova-core: gsp: return the static GPU configuration from boot
      gpu: nova-core: gsp: add the short name and GID to the GSP_INIT reply

 drivers/gpu/nova-core/api.rs                     |   8 +-
 drivers/gpu/nova-core/gpu.rs                     |  36 ++---
 drivers/gpu/nova-core/gsp.rs                     |  13 +-
 drivers/gpu/nova-core/gsp/boot.rs                |  15 +-
 drivers/gpu/nova-core/gsp/commands.rs            |  70 +++++++++
 drivers/gpu/nova-core/gsp/commands/rpc.rs        |  68 +--------
 drivers/gpu/nova-core/gsp/fw.rs                  | 186 ++++++++++++++++++++++-
 drivers/gpu/nova-core/gsp/fw/commands.rs         |  13 +-
 drivers/gpu/nova-core/gsp/fw/r000_00/bindings.rs |  97 ++++++++++++
 drivers/gpu/nova-core/mctp.rs                    |  20 ++-
 10 files changed, 424 insertions(+), 102 deletions(-)
---
base-commit: abfb640b2374e26de8ff81d488c39d8254db538e
change-id: 20261127-nova-r000-staging-905c7f559e47

Best regards,
--  
Alexandre Courbot <acourbot@nvidia.com>

