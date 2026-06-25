Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4D3CCDE000
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 13:06:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7FCC10ED48;
	Thu, 25 Jun 2026 13:06:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ILnSkech";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013020.outbound.protection.outlook.com
 [40.93.201.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1913B10ED48;
 Thu, 25 Jun 2026 13:06:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=os0aqVdgMN/UhPIlMt8nyFBW/GN3iSbZqk/dilpsv7Ms5iOF9Q/Qu6aaJ5FMQc1gQ0N9Jr0IJpNvTURdsaAH5RvlA29Llkc+ELEPkv2PvvWgjunDUWjhKAMbmdlG9TtyhihlxNC3SYU2XfILApl1+FbAJAZM8g7C+YyfTOL3cMYZIN2zJ5rc6ov4P8ICKDuWsThB8SsNlhiTazbsfcDjkdtU5LWoK463CTTSgqPPcrn50qA8S9DSIwO1DhEG4cGtVs8xJ8FafMdYAojZsi70FCa5JqqF7s70OUmSd2GxFeiOS7Ruy0so21BzS/dL/x5gVgkkFL7kFvkF1t/6JL24MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+7L0x7xdBg47yhgFzeWgQ1a1i8LcxW2uyIVEmpYszCo=;
 b=c07XWp9vtVgDAjYy+uYZ9A9KukTbykdUBZocq/3AFsLv7sa93i8hAYAwP5i26EbilokVz5due79Xn5Aaq00kwPxKLkKk3pGphHfaYK/EbMmqpAq3Mi/8Y7s2r2cJ27M1lexWauKuGnPq2lEeQJCFYomZZ0Uq7DM6IWYAQjqnbAchZmhAk6g9MmpoLf9mAAJ4A0XSpf/hqxUZqkvIRZhP+IMMvQK55g38TGgD9LKRk5/o/j8IxIvicnabEilThXHjuIAtMjfms/DtXeAWnx0fUu4LdiVQs4Xk4DIFIaBZ/K25ervZQyOxNddge5Vud3oC+qjuwezBBUYyC7DGLdQVgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+7L0x7xdBg47yhgFzeWgQ1a1i8LcxW2uyIVEmpYszCo=;
 b=ILnSkechU6A9PhHbg9fIAOE8kVqmzgBTWMHcQ8Szw26BUGng/pFkOtDIL024er1Wz0eXEef6rSKkFTCA0WKFBG4C+M0j4rIEWsoAzjQYhyyTjvRvCbID3NyOefwE4bXY5vP02Pn9RPQC88UH5MX3FXOQDjHxrDN49CbnV5ARYAg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13)
 by SJ0PR12MB7458.namprd12.prod.outlook.com (2603:10b6:a03:48d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Thu, 25 Jun
 2026 13:06:23 +0000
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::c3e5:48f8:beb6:ea68]) by SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::c3e5:48f8:beb6:ea68%5]) with mapi id 15.21.0159.007; Thu, 25 Jun 2026
 13:06:22 +0000
Message-ID: <b3585357-bd02-44ba-8775-62cd9a7aa13a@amd.com>
Date: Thu, 25 Jun 2026 15:06:15 +0200
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1BBVENIIDAvM10gbW0vbW11X25vdGlmaWVyLCBk?=
 =?UTF-8?Q?rm/amdgpu=3A_block_THP_for_GPU_user_mappings?=
To: =?UTF-8?B?6JKLIOS6pumfrA==?= <jytscientist@hotmail.com>,
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Felix Kuehling <Felix.Kuehling@amd.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Yang, Philip" <Philip.Yang@amd.com>
Cc: Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R . Howlett" <liam@infradead.org>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Jann Horn <jannh@google.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>
References: <SY1PR01MB10596EB75463208A8E1EBBA0FC0EC2@SY1PR01MB10596.ausprd01.prod.outlook.com>
 <8f68ce2f-c33d-49f5-a671-7a4ab2f4f3d3@amd.com>
 <SY5PR01MB10599BCF8625DB8EAE9827293C0EC2@SY5PR01MB10599.ausprd01.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <SY5PR01MB10599BCF8625DB8EAE9827293C0EC2@SY5PR01MB10599.ausprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR3P281CA0166.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5673:EE_|SJ0PR12MB7458:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bf9f905-3e6d-402f-70ae-08ded2ba8dec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|1800799024|366016|921020|6133799003|20046099003|11063799006|5023799004|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: cEDBWWpIUMkHhdDhf3YNFBZdo9qUdmM8kSUEbZL1fS8CdNFEfvZddG5rm2pxLjnHcG6+xzRqVZunhjduMaNxwOtTuBk/CsdVmvAuAFnrzgElPEQToi8g1A7mdjafpaTM3VS6hbxRKpezxcx7np7hrZ3796DUOBsCilw2a3DR1k2xgzJEGuLrYHiWb3zUYXrhKJ/yua2UZXaT9HnwuzgPZwT3ZdA2xB7u0csx1BE9UDAE8rMpmMGpmLJbEklf3yUShKeuwQIiwx1i8IcpSPPhX9tC7T2PaBWBDWg88FG2VELf7dYpSxpx6tjazSJRpBUQGsEN81ysDLUfViF4eEbHrkG6pBbUmMvkcEJ1oC024bVLHjphN8asbx8oN36W3TIltf1q8yTvtPwL2wzIgHnLX1Vy8O+o6rCbwu48mJCunlJUhc7wAI0QgEI/wDr3knSQep9JGNgypiiM6ADtsUMcAf2nGQL105EotGyeE2r+UF7HqnzWgNo1uzXgHXrdFtbl8prRwo6ljyb+wj8GNzsRW3I1ahbuz6aQYZx/jsqxXT2923pT2CbJIXGxWo+t1IyM8b5UcEY7e6yFSkpaxFA+4pJhYDmTJoouL0xszZcYI81LEMF929Y0l/O9LxrYppv//TI66eA1abdvDF3OciswzjnDNd5GpVkMBhuiRPTsJycUW6IX6vd0MZvU3cW2N2WVyMS77GOrAJXpohNJ8rT0YQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB5673.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(921020)(6133799003)(20046099003)(11063799006)(5023799004)(56012099006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmtXWWwwQy9qLzIva0Nyc29NL1VqbTNQeC8wUXo5TjhMb1BXUXN2VC9tOUMy?=
 =?utf-8?B?Si8wS2VnM1p1RDlycnA4KzJXdDZyR0tOVEgyY2ZtY0tyS2h5blN1WTVxRmtr?=
 =?utf-8?B?eU1PWjVFV0tpZ2JLLy9mVEtXTnpYc24xeGV3amsxR3VneUl6aEF1cnQwRXVo?=
 =?utf-8?B?QWtQbWs0c015UXY1dWwxRFFsK084M3ZpUWlJRnJ5L1d5ZTFpaFpkbEUxUDdl?=
 =?utf-8?B?OWhjd003K0diSEpNQ3B6RG43Q01ERXdEcEdCR0dycjlUTGJzMXczT2FCeHFa?=
 =?utf-8?B?U2hQMWZxczNQMzdiV2FHM1RBVWhWSUNDZE96ZzdMd1FIMjErOGtEWFZLYmFT?=
 =?utf-8?B?djBJZ1lOVlAva1ZyTHVyRDF4aTVOSHZjYmhrQVhZMWtXeDc5TzVJUjd0SnR2?=
 =?utf-8?B?Yk5wT3RpeUpOM1duWmlXWlBWZ0oxck1GQzl2VXdIdmRkUWQyM1cwenpEUzRw?=
 =?utf-8?B?SitYRTV0YWFhd2kyZXZtbWIycmFXNmdMMlhXMlVUbE1hNlpaSk5NdnpqWFFV?=
 =?utf-8?B?ZEtKcTIrQVhHWjBEbEJoeUVDOTRkWExQZzBqRFZUVWxVcy96Y1pYVUdxTE1D?=
 =?utf-8?B?R0VHdldkK2VjU0JkQ3FOMlhqQ3RDcnNUMm02eWw1b3JHNnUrQytqWmlUZi83?=
 =?utf-8?B?ektSLzZBZE9ETWY5YVNmbGJuWjBPemd0cDYwc1JrWFpHbWwrMkNlSDZHdGNv?=
 =?utf-8?B?UUFUUUdEQkZ1OTFKbW93UWNmcHp4S3RFYmdvUXAwaWNKZTE2S3ZYME12dmdX?=
 =?utf-8?B?M1lIOU13djhhMWlRdTh5QllqVitFeXZWT1FZQzVYZ1VPR21rb1ArNVIrbkx3?=
 =?utf-8?B?WnRpbWNza3dqczUvRGg0NkxsQXZXcVlqczVDWW1meUZ2ZnBBQmdYSnJkM3h2?=
 =?utf-8?B?cVkzU0xvOHRCK1FEc2MzY1pEcXVYYXU4RU11VTVBZjRPNDYrVTFFVkRmRWN4?=
 =?utf-8?B?RHRoSjBjWS96L0hJZkV4bFNJdjg3T1NOeWNjLzlCNHkxZDJya3Zka0wvZ3hF?=
 =?utf-8?B?cTB1cE5aVWJLdk51dURIbzhjeWJwU2dudlJsRk1iRzlzeWgvbHNhZlhHdGxt?=
 =?utf-8?B?WFVsalQyVWZXbzV5Q0Y1UDE0dEFpdllXRk9vckJnZTQ0VTdvUXhJeEZxQ1JT?=
 =?utf-8?B?QmpHaXc0WUh2TmlNMEJKOUtzMlphRDNiRlBjNE8xT0EveUZ3a0l3MiswZHNG?=
 =?utf-8?B?ZDNrWkJWdzNnVXUxYTJPV09iQ0lobTZmdmxjQzFGdys0VURQckhYQlBacjha?=
 =?utf-8?B?RmgxK1crckd4aUtQR0ZkdjVZSVY5L2djWmgrU3lpbEcrNXQ5ZTFsYW5vRkNL?=
 =?utf-8?B?M0NXNk9xcVk4WUJScDB5dkFmSnFIdGFiTDhiR2huNTZtTVZHOGQrRnNNUERa?=
 =?utf-8?B?a1lSVUljUWVOd3ZpbTNHMU5vT3JHMUFVeGRHS2pEWG8xQ3JkcHcxRTcwaDE1?=
 =?utf-8?B?QVRpaEE3RmZwQUh2NFNrbUhNTStIVlg4Z2ppSXloaUxYNUR6OWNWYXFFRnRZ?=
 =?utf-8?B?akdacjJpVjZ0eFJvSDE0L2ZBUFp0OTdMMVRobEYxWnNLS29CYVhRelpNaC8y?=
 =?utf-8?B?MUFWSXRVWjdQbjlpNUNVakJYSjVIRnlQb0V1Qm4xWmd6OEk5MUZaYVVEWEx4?=
 =?utf-8?B?S01jckhDSi8zaDhWVU1IaEpBWVZGM25mUlp1TkxwWllhS3J2VEpYUjNtaWt3?=
 =?utf-8?B?c2JpdUh4UFJycnZKUERzYVFlY2QvR20wOHNuNndZcW1Ob0MvRThhdU1Fb1RX?=
 =?utf-8?B?ZjUyQlp5UjU5dUpDN1NkSWdUMWx4aFZvQ3lQeDZVRVJzbm93dkIyb3k5SUZ2?=
 =?utf-8?B?TWJKNlZBQUI5cFQ1N3l4Sk04VWlaMWRQREI1a3dXWE80NnU3NmNHemRxa3Yw?=
 =?utf-8?B?ZTd0ZkRYOTNXL0U5bkxMYXdRRXowZ2hhTTZWMUdWdFZuN2RUMXBOZmVBT3Br?=
 =?utf-8?B?cXpXeGhRUlVnbG4zdlRXTFlOVVZ0V0gwWFhPeWlZSVdFQkNVV2pIaCt2eWZh?=
 =?utf-8?B?Yjg0bEFRVm81ZU14eDRrbkJyb0hETXZvclBlQTh4TU9QQ1ZadHFOcEZYWHNZ?=
 =?utf-8?B?NnIvZnBpQ0FqZzlJMTFEMlM3YmdvZW1aRXV4UzFLc0ZEZ2pOTHFndVM2bWFI?=
 =?utf-8?B?NkVXSUNJaE9OTWpJUW01VXFPVmhiR3Y5ZUlGOGJXblJoQnZrRDFBbC9GQWRX?=
 =?utf-8?B?dnhWblhSdU9sMC9JMHBUbkhVbFp6QnprQWRDLzFmYWFJY1ppdTgwdGk1bDdO?=
 =?utf-8?B?YndoMkJIUzJmdWpsRXdLek11RW1yWVBoc2R3amtVa0I1NkdlRlU1aEdzSHFZ?=
 =?utf-8?Q?dYqEJSd5xsLA0c9NbP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bf9f905-3e6d-402f-70ae-08ded2ba8dec
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 13:06:22.5840 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +s5x3TqTTiDvGuqOOEP1Q93V0xadwu6SxtnCp+gRfW1nxLuMz6VutCaQM8Py5P4X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7458
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

Hi Yitao,

adding Philip Yang.

Thanks for the investigation, that sounds like some kind of bug in the KFD =
SVM handling. The driver should be perfectly capable of handling this.

I strongly suggest to open up a bug report for ROCm and describe how to rep=
roduce this, Philip can probably point you to the right location for that.

Regards,
Christian.

On 6/25/26 15:01, =E8=92=8B =E4=BA=A6=E9=9F=AC wrote:
> Hi Christian,
>=20
> I agree that my previous approach was wrong. Sorry about that. Please let=
 me clarify the problem I was seeing and how I ended up with that incorrect=
 conclusion.
>=20
> The original problem was not a synthetic THP test. I was running ROCm/PyT=
orch ML training on an AMD Radeon 780M system, and the workload frequently =
failed with asynchronous HIP kernel launch failures. The userspace error us=
ually surfaced later in PyTorch, for example around a copy/to_device/SetDev=
ice path, but the kernel log showed GPU resets and KFD/MES queue eviction f=
ailures.
>=20
> The relevant kernel messages I repeatedly saw were along these lines:
>=20
> =C2=A0 MES failed to respond to msg=3DREMOVE_QUEUE
> =C2=A0 MES failed to respond to msg=3DSUSPEND
> =C2=A0 failed to suspend all gangs
> =C2=A0 failed to remove hardware queue from MES
> =C2=A0 Failed to evict queue
> =C2=A0 Failed to evict process queues
> =C2=A0 GPU reset begin
>=20
> While trying to reduce the issue, I saw memory invalidations and THP-rela=
ted page-table/backing-page activity driving the AMDGPU/KFD path through SV=
M eviction. On this system, the path I was looking at was roughly:
>=20
> =C2=A0 svm_range_cpu_invalidate_pagetables()
> =C2=A0 =C2=A0 -> svm_range_evict()
> =C2=A0 =C2=A0 -> kgd2kfd_quiesce_mm()
> =C2=A0 =C2=A0 -> KFD process queue eviction
> =C2=A0 =C2=A0 -> MES REMOVE_QUEUE / SUSPEND
>=20
> One thing that misled me was the XNACK-disabled path. Since the issue app=
eared on an XNACK-disabled APU, and that path requires queue eviction/quies=
ce when CPU page table invalidations affect GPU mappings, I incorrectly tho=
ught the backing-page change itself was something the driver had to prevent=
.
>=20
> Another thing that misled me was that the application was not intentional=
ly asking for THP behavior. From the workload=E2=80=99s point of view, thes=
e page transitions looked unrelated to the model computation. I therefore i=
ncorrectly assumed that userspace should not be able to change backing-page=
 characteristics in a way that affects a driver mapping already registered =
with MMU interval notifiers. I now understand from the MM feedback that thi=
s is expected behavior, and that the notifier user must handle unmap/remap =
correctly.
>=20
> So the more precise problem is that THP/remap is only one way to trigger =
the invalidation path. What is failing for my workload is the AMDGPU/KFD/ME=
S queue quiesce/eviction path during those invalidations. When that fails, =
the GPU resets, and userspace later observes an asynchronous HIP failure.
>=20
> Please allow me to continue investigating a more appropriate fix for this=
 problem. I will try to keep the fix boundary within AMDGPU/KFD/MES and avo=
id changing MM-core or THP policy semantics.
>=20
> Regards,
> Yitao
> -------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
-----------------
> *=E5=8F=91=E4=BB=B6=E4=BA=BA:* Christian K=C3=B6nig <christian.koenig@amd=
.com>
> *=E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4:* 2026=E5=B9=B46=E6=9C=8825=E6=97=
=A5 8:35
> *=E6=94=B6=E4=BB=B6=E4=BA=BA:* Yitao Jiang <jytscientist@hotmail.com>; Al=
ex Deucher <alexander.deucher@amd.com>; David Airlie <airlied@gmail.com>; S=
imona Vetter <simona@ffwll.ch>; Felix Kuehling <Felix.Kuehling@amd.com>; An=
drew Morton <akpm@linux-foundation.org>; David Hildenbrand <david@kernel.or=
g>; Lorenzo Stoakes <ljs@kernel.org>
> *=E6=8A=84=E9=80=81:* Zi Yan <ziy@nvidia.com>; Baolin Wang <baolin.wang@l=
inux.alibaba.com>; Liam R . Howlett <liam@infradead.org>; Nico Pache <npach=
e@redhat.com>; Ryan Roberts <ryan.roberts@arm.com>; Dev Jain <dev.jain@arm.=
com>; Barry Song <baohua@kernel.org>; Lance Yang <lance.yang@linux.dev>; Vl=
astimil Babka <vbabka@kernel.org>; Mike Rapoport <rppt@kernel.org>; Suren B=
aghdasaryan <surenb@google.com>; Michal Hocko <mhocko@suse.com>; Jann Horn =
<jannh@google.com>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedeskto=
p.org>; dri-devel@lists.freedesktop.org <dri-devel@lists.freedesktop.org>; =
linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; linux-mm@kvack=
.org <linux-mm@kvack.org>
> *=E4=B8=BB=E9=A2=98:* Re: [PATCH 0/3] mm/mmu_notifier, drm/amdgpu: block =
THP for GPU user mappings
> =C2=A0
> On 6/25/26 12:59, Yitao Jiang wrote:
>> Hi,
>>=20
>> This series fixes a THP policy problem I found while debugging
>> frequent ROCm GPU failures on an AMD Radeon 780M system during ML
>> training.
>>=20
>> Some AMDGPU/KFD user mappings are registered through interval
>> notifiers and cannot safely tolerate the backing VMA changing from base
>> pages to a transparent huge page after registration.
>=20
> That's certainly not correct. This is a must have for a whole lot of use =
cases.
>=20
> Why exactly isn't that working for your use case?
>=20
> Regards,
> Christian.
>=20
>> Userspace can
>> still apply MADV_HUGEPAGE or MADV_COLLAPSE, and khugepaged can also
>> collapse the range, after the GPU mapping has been registered.
>>=20
>> On my system this showed up as asynchronous ROCm/HIP kernel launch
>> failures, often reported later at a synchronization or copy point. I
>> expect the issue to be relevant to AMDGPU/KFD mappings on
>> XNACK-disabled GPUs more generally, because those mappings cannot rely
>> on replayable GPU faults after a CPU-side THP remap. I have validated
>> the failure and fix on AMD Radeon 780M / gfx1103.
>>=20
>> Patch 1 adds MMU_INTERVAL_NOTIFIER_BLOCK_THP so interval notifier
>> users can ask the MM core to keep the covered VMA range out of THP
>> while the notifier is active. The MM core applies VM_NOHUGEPAGE and
>> clears VM_HUGEPAGE under mmap_lock for write. A later MADV_HUGEPAGE
>> over an active opt-in range is treated as an ignored hint, and
>> MADV_COLLAPSE is rejected by the existing VM_NOHUGEPAGE checks.
>>=20
>> Patches 2 and 3 opt in the AMDGPU/KFD paths that need this behavior:
>> HSA userptr BOs, KFD SVM ranges when XNACK is disabled, and
>> GPU_ALWAYS_MAPPED SVM ranges. Other interval notifier users keep their
>> current behavior.
>>=20
>> This does not disable THP globally and does not add work to GPU
>> command submission or kernel launch paths. Additional work is limited
>> to opt-in notifier registration, opt-in notifier flag transitions, and
>> MADV_HUGEPAGE attempts that overlap an active opt-in range.
>>=20
>> I tested this on top of torvalds/linux commit ab9de95c9cf9 with:
>>=20
>>=C2=A0=C2=A0 - scripts/checkpatch.pl --strict --no-tree
>>=C2=A0=C2=A0 - git apply --check
>>=C2=A0=C2=A0 - x86_64 defconfig build with TRANSPARENT_HUGEPAGE=3Dy,
>>=C2=A0=C2=A0=C2=A0=C2=A0 DRM_AMDGPU=3Dm, and HSA_AMD=3Dy for mm/ and AMDG=
PU/KFD objects
>>=C2=A0=C2=A0 - standalone HSA/HIP reproducers and the ROCm/PyTorch worklo=
ad that
>>=C2=A0=C2=A0=C2=A0=C2=A0 originally exposed the failure on my Radeon 780M=
 system
>>=20
>> The standalone reproducers depend on ROCm userspace libraries, so I
>> have not included them in this series. I can send them separately if
>> useful.
>>=20
>> This series was prepared with assistance from OpenAI Codex (GPT-5.5).
>> I reviewed the resulting code and take responsibility for the
>> submission.
>>=20
>> Yitao Jiang (3):
>>=C2=A0=C2=A0 mm/mmu_notifier: let interval notifiers block THP
>>=C2=A0=C2=A0 drm/amdgpu: block THP for HSA userptr notifiers
>>=C2=A0=C2=A0 drm/amdkfd: block THP for non-replayable SVM ranges
>>=20
>>=C2=A0 drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c |=C2=A0 25 ++-
>>=C2=A0 drivers/gpu/drm/amd/amdkfd/kfd_svm.c=C2=A0=C2=A0=C2=A0 |=C2=A0 36 =
++++-
>>=C2=A0 include/linux/huge_mm.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 5 +-
>>=C2=A0 include/linux/mmu_notifier.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 28 ++++
>>=C2=A0 mm/khugepaged.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 9 +-
>>=C2=A0 mm/madvise.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 3 +-
>>=C2=A0 mm/mmu_notifier.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 204 +++++++++++++++++++++++-
>>=C2=A0 7 files changed, 286 insertions(+), 24 deletions(-)
>>=20
>>=20
>> base-commit: ab9de95c9cf952332ab79453b4b5d1bfca8e514f
>> --
>> 2.53.0
>=20

