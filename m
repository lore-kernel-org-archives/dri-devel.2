Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61CAB107637F
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 14:30:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE7AE10E064;
	Wed,  1 Apr 2026 14:30:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="FzVxOFyT";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010052.outbound.protection.outlook.com [52.101.46.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CABB10E064
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 14:30:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mXhyborWJdiT35EY46d5408R8SlC6bHgwYOgEL+C5lk0HiVY9K0J7GBZPU9Od/M9NcnbXDowI+M/TIgKmrpdyo6MrAgZDyzwSvvnFnUg+eru5wljOyqJq3axVoXVj2oixq3R61W99USnSaMytkA07BWRnfOmHtVfkqegMdSfrqGGVNbIYu1/kiQWQ5U5dFX+BkXGdsFDlR6PAZbojCKPqJeJDUGte99VIFNuy9y/jETQnB2S5E0HZHle2Wwgrx4ohtsj7NCukD6p4O74Dilu1nAEP72lYUTxK0NDDb2DOzEeD1BEwqAWm50b8PQ7WenMTe8fG55ZHtuPnaQtyppyIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y+68OGjYKFP1ktMixBji2lQ+a3TNPPoXvHlAYtm4pZw=;
 b=wJoAITOLOs6GQPnUdc8obrVYN2kEApeIz3W9H1qatR83Aqt/QNBwL497YWU/M32k36mZAsbyJa74n7KPK5w3SjZYb/zoRWvqt4pmHMFBDc54BO3lbrNwvlrl41DrROSMAFAfy5V+WqniN7GaFBc7iUkBCFORQ7kxARkuUOaVf1KdrtlHG6RjYhOXKm0l5CWaQsVFRqQm6lNTMzmaSGpeTeErKtszV9yirMl+MHBVOFYaOun+I2kAQqqoMmfMcMRTafk1UDlz/2YN0nr2lHKtipfNzHBWRE1IOupAKWE9BonqCbmmue2rk5a1BCBB/1lPEdaF2unD6gZzIOOXRcb7Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y+68OGjYKFP1ktMixBji2lQ+a3TNPPoXvHlAYtm4pZw=;
 b=FzVxOFyTFtZN8NI3fVDQbppM5alYef39Kg/Ra2x9Pj1iYb4PAN/0CkG0y1C5Hbxh45sq/t1g4Wgp/4gBel0GyG2bzM2KarzlTTbbARCbMFqo0fC7fLClgAtfyDSnFan+xDGb7CxjerdDlGq41+R45Fm7qra/7mijZ2sSABZmgIyKMbnDML4xq9Ag5sJnOesdfZyx9N4S0Zdh5hj2EosyTwk46Kh8XXZF1X5HThG61IK08Au2t94/zn6D4wF6kR2Qaa51rwxFJ2b+qECnZXzP/2tuj0H5qLmyaNNoiuxjLEyWQ6q+ZvtEOoDEMDb/OHJB6dcCb6wCXIL+m/WwbMROYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS1PR12MB999188.namprd12.prod.outlook.com (2603:10b6:8:495::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Wed, 1 Apr
 2026 14:29:59 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9769.016; Wed, 1 Apr 2026
 14:29:59 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Subject: [PATCH v4 0/2] gpu: nova-core: gsp: fix undefined behavior in
 command queue code
Date: Wed, 01 Apr 2026 23:29:49 +0900
Message-Id: <20260401-cmdq-ub-fix-v4-0-a9a9cf982485@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23MSw6CMBSF4a2Qjq2hvdBSR+7DOCh9yB0A2mqjI
 ezdwgiiw3OS759IdAFdJKdiIsEljDgOeVSHgphODzdH0eZNeMlFCUxR09sHfbXU45vaWral0rK
 qW0WyuAeX77V2uebdYXyO4bPGE1ve/53EKKOlV164xoNxcB4SWtRHM/ZkCSW+wRz2mGcspWWcg
 QEv/Q+GLRZ7DBkroT1nVWN0bXZ4nucvNiFbbCEBAAA=
X-Change-ID: 20260319-cmdq-ub-fix-d57b09a745b9
To: Danilo Krummrich <dakr@kernel.org>, Gary Guo <gary@garyguo.net>, 
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Alistair Popple <apopple@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Zhi Wang <zhiw@nvidia.com>, Eliot Courtney <ecourtney@nvidia.com>, 
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.0
X-ClientProxiedBy: TY4PR01CA0124.jpnprd01.prod.outlook.com
 (2603:1096:405:379::6) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS1PR12MB999188:EE_
X-MS-Office365-Filtering-Correlation-Id: ac1b5105-0775-42d8-cb3e-08de8ffb26f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|10070799003|1800799024|366016|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: tzzNm6VPVfGEtMZfJDrL1QAyrUR1MAu4A5sOTSFuQAHxDBo8JWkclHEUWXyQSAeLahzAdl+T1+Z2XigAwNIBDdhr3jbEr9SPYLxSRfIqyuS/bwOCuZmwcMCwJjBrLDPQOGN1aQNtfQ1i1If9x4+s2WSXfu92cnnjjTQTcKfNO2Ll40xT0oFjmiIdjQJayE1eJF7TAXehh0XhEpyemuzrRoLmRVwI6txT8Jz7KfKwJVy1n7doO89iiwRsA87FRQVm/baLAsRjUloGHBMZMd3hLPsi09f4Fp4BGXFJUAjvca1SujnW4c7UwDg10H/8N0OhmS2Q9r8liHDxrJEW7TKtcESBPC8VsSEbE7P4RjOJ8XJw5Uel9qZP24DgdB3QFsk4i196Vh2TQe1LV6kbYyDnz3hfX0qvqyl+1pnfQpGTl85+sxiY47w2hEf/f0dCBJjeVq97tlkR1nj5lEsQjnxn3bzpORfLQXFx9Ll2GS1Jq2/8SzmLnkdcH01NZZaETXR5iV6JR+AbjQwZUmVu5MTYG6Hlyeb+pVfvf75baNb3fu5kTvHGe/FeCUmA2Ll6kWpky8aqVfBXgyaXjXj76yA7Z7/PDfE4APWt27otWNPzIFOJfjFRyknGmofD18+pnqqE3h4pODP9kFggZzcRUskuj7ElJssW9WzOCrgbuqBe9nf85FSYVbF2js5R7A83/hUhdoN8ElC+4W3vdXA10R+MmghuUBwzuRvq4r5lX6L4iew=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFNTeFhxQkRXK3FIeHFLdVJLUThrK0tGdXJoZG1kVlFjVVM2UUNyd01tTEZZ?=
 =?utf-8?B?M0dnMkFnU1NHeU9Xa1Z5ZkdpZXFNbEtTQ3JnTGxEMU5QQXM1MEI3Wm5aN21v?=
 =?utf-8?B?WG9LNGpsdFo3WE54UU5sejE5MWszNFFRRnZLWjFLdDd0QlYrSFFsWWJhazN1?=
 =?utf-8?B?SlF5YlBaeXZOMUp0bTBTNk1hbnFCb3JzQnJteVQzTkduUlRqTFFpNDc2L1o4?=
 =?utf-8?B?OUx5cWdMa3Y4N1JDNGtDbEh2ZExEeS9sSXE0aExOQ1pyZjJib3NPVittWk0w?=
 =?utf-8?B?WnczdzY5aDNQcks1OVpWcDUyNnhCYnR5ZXdlclNqakZlVkEycHg5SzdhR0xD?=
 =?utf-8?B?czhvdVJaY25laXVEZW9EbURGV0U4YUxISmxTbmZsempUZkhsSDRoaVNvU09Y?=
 =?utf-8?B?T0xxRG15dUdDU2pWRVlGSG4vWWJ5M0xNMDFkcnFwc01Wc211VTZCMnVOeHgv?=
 =?utf-8?B?aitvdTZHK29nTTZxTVpJYWFWbmlnSHhIMGxvYjZYUlhmeXpWVndnYTJJZHhi?=
 =?utf-8?B?TUdVTXh2MkgxVmtEMHdDZGhqR3U0ajJ5NUFTay95UExxdkxkN0VXQkVnY1lN?=
 =?utf-8?B?U2NaSithY2syMVQ1czdlT1YyQnNocGJTaWsvYTJwbUdjbm55NU9venZQbmdC?=
 =?utf-8?B?WnNNeUVoaURtM2MrM2doRkw3dkhOaEhURkRhc1czazNYNXkzQ2tHY2MrdWNB?=
 =?utf-8?B?VkpncGY0MWlSSnVNc1lhekQyN050SjVaQmY4c1VlOUxaWGd4QVRlRE92TjNP?=
 =?utf-8?B?Mnp5a3RId2NQU21YSVFkaC9sVHhCN25YQ2ZUb2NpWVQwT2oyRFRTalpSRi9R?=
 =?utf-8?B?d2x6VmRhVlJWdUM3TWRHZjRubEk1QnUwVit4Z0IvMGdxTnZpd2JGTjlxSFNk?=
 =?utf-8?B?WnFrUTM4N3VTZWVUcXBmTjhVek10UXBacmc1SjVuV2NFWjBqK2VPRW0wdTVL?=
 =?utf-8?B?Yi9xbVMvbzhiR0lncGNsNVVhR2t0c0dUUmJ0RFhaQk1odE44VXVjYWFZUkRs?=
 =?utf-8?B?K2V5cDFhQzU4amVTQ2h5YWY4eE9Ccm56c3hNVE03WlBpci9UMVMvd2ZBU0JP?=
 =?utf-8?B?Zk5UbjNlZjhWOFVqb1ZXYUJpWFE4dklhalF0OGRHWlNiMWtvN3VoUEZLZlVR?=
 =?utf-8?B?TzBrVm1rM1VNWGdnR045dGt6SU12TVdtTjl3anIxSVpWeHpNNHZjaGxxUG5W?=
 =?utf-8?B?eWIzckZVOGdRMkxiUE95L1JVbHNMMjQ0bHptYXNNWmlqMGJKZ0Zqb1dEZEJi?=
 =?utf-8?B?enFaRnlwYkhhdzRET3gxMzVoTUViSmR0dW5BYUo4WW5xL3E1aGJHWVJOa1ZL?=
 =?utf-8?B?bGhjM3FoK2JHdlRYbDFVZEZBVHlhRWdQbFRSUVlrR0RKUW1PdXFOVUhlQXZF?=
 =?utf-8?B?dkhYRHRpNmlJUmpHSWlna0I5T1cwcEY2eWRmeHlTQjVUY3EvT2hEMFV6QXlI?=
 =?utf-8?B?eGpHZi9PcmxWeHBhUXdDa2QySkM1VkFpcE0wTEFjQlgxYzk5T0hMZFpIM0ht?=
 =?utf-8?B?cVdvSXorSXhjSmdacHREVkcvMkcwT0E4YXBqZkx6OWEwbHdhQlB4Z1NtTU1k?=
 =?utf-8?B?dmhBemdCWFNFVUhGYlBtbWRaNTAyOEtoeWVqUXFUVmdrUzF1eEFoN3JYUzhY?=
 =?utf-8?B?VEtwUEp6VXlNNjA1YkoyTWtJa25VZVpKSFBGblFrOW1Db1dyb0xnWGxDemxr?=
 =?utf-8?B?Ni9UTGphRU9xMFhhMlc4akg1V2FKTTVBN3hCKzNqN1FFS3lRMENqb3laSDZo?=
 =?utf-8?B?NVV5ejBnQ0QyQXdTNCtHR0FJcjJBR25yWmthMExMTGdPTjhiTVF5MUNEZHl4?=
 =?utf-8?B?c2lLYzYwL2kxRlQ1eHJCQTJvUVJiSDBabXJtU2taYnFaSjRYQm1yZjJNbmNJ?=
 =?utf-8?B?VEM2YncxbnI3S08yek5CYVF6dXBuaml1YTNaTXZnYXFwY0szeE92VmFkeHBi?=
 =?utf-8?B?L24zN1VYWmxxMEYycVJ6N3hoOTdKTHBOejUzTkpLbFkydGYxVUw5Y2U1U3Bs?=
 =?utf-8?B?eUNsMUUvRFBsMjRUckU2VUNLL0lqVVltNTVZMkJYa3NqUEQ2Z01ETEIvMXIw?=
 =?utf-8?B?bzR0QlRVUzhtUnV6UGpVVDBUTDZ5SHVRQlpRUUNqNFdiY2ZQSG5pemtsMzR6?=
 =?utf-8?B?UkIraTRtaGNVSm91RTJCSUlVT1diOTJLRUFidjdyMlNDbDQ1K0pPQnBNL2J3?=
 =?utf-8?B?dkF4dFJzTGRpZStpbEtoNDJXWXJEcm5DdHJheFFTR21aZTVhNVJHekI4V2xJ?=
 =?utf-8?B?ZUpwMTRISmJxT0xQN3k5ZDkwbU8yREpoQ0NqQUp2QklzOWFWZGRYQ0cxWTNL?=
 =?utf-8?B?VTdOUGlacjNITFNMRkFWSExic0Y0WWhQSUtqZ3NKS3NpT256dEZ1YXIybFh5?=
 =?utf-8?Q?jaGQUopwD1bD/uWPLvCEMYccr8VXiTzmj0Mlvevq0CYdv?=
X-MS-Exchange-AntiSpam-MessageData-1: uSfW4uA8qOJ/xg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac1b5105-0775-42d8-cb3e-08de8ffb26f4
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 14:29:58.8866 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LZc8RQ4ESKnAgqOvrMyojerPG4KfmX8VpTc4ARU6VG6k/Ih4ujK7BHKqH/RtXItnwyhwfMcuoA5rADSQfGRMzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR12MB999188
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

This revision is mostly to fix the testbot build failures of v3. They
were due to the inability of the compiler optimizer to preserve the
invariant that `rx == 0` in `driver_write_area`. To preserve it, a
nested branch is used, and the methods providing the range invariants
are made inline defensively.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
Changes in v4:
- Make some methods providing the `ptr_project!` invariants inline.
- Use code paths that preserve the invariants `ptr_project!` depends on
  more obviously to fix these testbot build failures:
  - https://lore.kernel.org/all/202603280326.ucDKVaf2-lkp@intel.com/
  - https://lore.kernel.org/all/202603281331.1ESuqgfz-lkp@intel.com/
- Improve safety comment when creating the mutable slices (thanks Danilo!).
- Link to v3: https://patch.msgid.link/20260326-cmdq-ub-fix-v3-1-96af2148ca5c@nvidia.com

Changes in v3:
- Rebase on top of latest `drm-rust-next` (with `Coherent` patches).
- Use pointer projections. (thanks Gary!)
- Link to v2: https://patch.msgid.link/20260323-cmdq-ub-fix-v2-1-77d1213c3f7f@nvidia.com

Changes in v2:
- Use `u32_as_usize` consistently.
- Reduce the number of `unsafe` blocks by computing the end offset of
  the returned slices and creating them at the end, in one step.
- Take advantage of the fact that both slices have the same start index
  regardless of the branch chosen.
- Improve safety comments.
- Link to v1: https://patch.msgid.link/20260319-cmdq-ub-fix-v1-1-0f9f6e8f3ce3@nvidia.com

---
Alexandre Courbot (2):
      gpu: nova-core: gsp: inline methods providing queue range invariants
      gpu: nova-core: gsp: fix undefined behavior in command queue code

 drivers/gpu/nova-core/gsp/cmdq.rs | 118 ++++++++++++++++++++++----------------
 drivers/gpu/nova-core/gsp/fw.rs   |   4 ++
 2 files changed, 73 insertions(+), 49 deletions(-)
---
base-commit: 7c50d748b4a635bc39802ea3f6b120e66b1b9067
change-id: 20260319-cmdq-ub-fix-d57b09a745b9

Best regards,
--  
Alexandre Courbot <acourbot@nvidia.com>

