Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BD1606A31E
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 10:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=CpsBQwnm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D52010E752;
	Mon, 23 Nov 2026 10:44:29 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010050.outbound.protection.outlook.com [52.101.46.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7991910E96F
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 10:44:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FIswQsohSkUVOdXd1FrraO/AiOKnZDJNkseu6MJvxHyi6ou9lhMm7WNmwMslNgga3qZYsjSgivADEe/BkqJAfklg25gd9z7D/TKkKBipKSjtARauBQ1U78UJwZJjqcWX1+90GPJDImWCUgbcOxy0RGLVcLUIRe5TYsafc9XGtGMyIueGnpzzJaAKzHlz/6DnhV0nuga8yiNEDK5cWLzzCjYGDjThngEpmPIr0BfovNFuEaLYOwOEU4zeZxSVhmRizX1KPaud2Zbfrm5YegN1x/DEQ/K3bO3sWm4KmUpWUmK8wjfKToD1rJDCwYZp6ldyiYkaDeF/Rg8jpg7o7yHzDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Kq1MJCrtwQNPCNOouWBnwL5DmtUs2yfWWyzVWmQkPQ=;
 b=yeVcP9Z8ewqq2xtGy6iWylD3eQLdQTHBfgezQAiS5G05oLUQlp1DCwZ3FevB3SAPdVm36T0jFnTGLVtJ5gwu6WXmmhRZyMB4pqyHYalA78x6PgTqcmPA8TcIMyJ9igxrR+nFrL5tMRmLM3cgDcTffAhLVQvOekpIF/Kg/P+MclumWTPXSHdsWxfcGdBOpgeRi7QzsNUB3gidoHyPPnEDpUp320i/COwuPD3B+YeNQRBRJGucBoSFRlOUZOM5OFOTh7o6pzHkGx2MTKbsOMZP0vQF6CkElKmlgbSYFBGU7mI3IrOkEChc5cYS1DaSOkTFRQgyu7iagwJolHNmv6WwFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Kq1MJCrtwQNPCNOouWBnwL5DmtUs2yfWWyzVWmQkPQ=;
 b=CpsBQwnmoQ2M2pb1RmZ42VLL12ePKxyq7G0xhJ3F4zUnjn2kgf7BxMnzSV+e5SOn+zXVBLEx15pkKFU5fJIk0DR57KJd2RV5A7p21xuQBLwV1hU67NuJCrwLTLIiw5tyJNYxOF1Yiqo7P7B3yfcXo8tkYQi0StGvd6u0N7SostE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7170.namprd12.prod.outlook.com (2603:10b6:930:5a::18)
 by CH8PR12MB9840.namprd12.prod.outlook.com (2603:10b6:610:271::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 10:44:20 +0000
Received: from CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f]) by CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f%3]) with mapi id 15.21.0639.011; Mon, 23 Nov 2026
 10:44:20 +0000
Message-ID: <316c1d61-f297-41ad-95d1-43aaa67c9696@amd.com>
Date: Mon, 23 Nov 2026 18:44:12 +0800
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Matthew Brost <matthew.brost@intel.com>,
 Danilo Krummrich <dakr@kernel.org>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Alice Ryhl <aliceryhl@google.com>
From: "Huang, Honglei" <honghuan@amd.com>
Subject: About NUMA support in drmsvm helpers
Cc: Simona Vetter <simona@ffwll.ch>, Alex Deucher
 <alexander.deucher@amd.com>, "Kuehling, Felix" <felix.kuehling@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Huang Rui <ray.huang@amd.com>, dri-devel@lists.freedesktop.org,
 Honglei Huang <honglei1.huang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0012.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::15) To CY8PR12MB7170.namprd12.prod.outlook.com
 (2603:10b6:930:5a::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7170:EE_|CH8PR12MB9840:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f93d561-de5a-4adf-7c58-08df494eba98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|10067099003|11063799006|56012099006|261021121427099003|261022105027099003|261009223027099003|261026140227099003|261028144727099003|261102123227099003|18002099003;
X-Microsoft-Antispam-Message-Info: sdkWCg6NR3KzTQWhD/mWA+slvJ6HMw17GkYI9yEdyUWeFVrNFXLBx1mUVoZZ1MY84NXKmaia0rbuiMoiS6MvxHi6NFlg+Ajgxv/gZ1aID8gPopAX9Ph736EVQ3R/dSfaJCARK33ZyHJ7XSEySCbkNt4jNPVtN4CYNqw4nN8wgmCW8brSbQ+Khu8c7T1CdlU+oP9IeU5Nk3Tb9mjmtHkfrAzNGs3h0S/4wuNiqB+3nBLvVirIumfixhDUs3M60iA3ECtMa411tKG2ulblHR8m5WTmMOMGEmzZqwt7W2O9osBVrxhOYRgV7WcFJZIUUDwcf8jAoFAG3teaQuPUQWtFtk3r3CJ3LMV3e8kqnPrmVag6gOF1RMmUUpACUgdG4quvwMxhYpcYoJrOFFdUBIevrRGv8z3yxSV2hacEpTZjZQ2iHrGB4R2nUDVcnxEzCGrwT7OMPxUv5sDOtsQICoX6LvKoigqkGFC3RDIVCUpDhnHyZzx5hrW/6urmfc/hzDny46xgtSRZQXCHhsCv/iSKBPqm0DCCYQwFx08F4kWCn1WmE+M3dTkaoNfPfrR1rw3uez1Bn1ZUjlsLwTU8AElCpDbiVah6Nz9TOjTdSAr2jFhpoxIuii/eOnKQEGbn188z
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7170.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(10067099003)(11063799006)(56012099006)(261021121427099003)(261022105027099003)(261009223027099003)(261026140227099003)(261028144727099003)(261102123227099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enFZaklXYXNKZzg5SVU1SGdibmljeWFZMEEvTzcwTzhpc1FFTkROOTlQY3VL?=
 =?utf-8?B?c3NQdzNrN2lBd3BwRFIzeFlmRkxOOFBvSVY3a0M3ZlRxWldEQnd6YXU1bFov?=
 =?utf-8?B?S1k4am16SFdzWmxqcmFnc1FIaXppNUtSTzBOTnR1TnRIUWM4dCs2TjhNQ2Vl?=
 =?utf-8?B?UDBUeXhZc0ZXQ2FpN0s0Ylc3aGxFY0xrMHJGSG1YZCtGR3lEcWlHM3ZVT20v?=
 =?utf-8?B?OGVKQzdTb3FXR2thS1NWNStCSTRNcW1oVGEzZDBpOWVDY1Z2TW5NMjJTSzAr?=
 =?utf-8?B?T2Nkai9nT0JkNFkvMkdhTWdHZXl0R0pqOC9vSEJkdVFsQlgzalZlaFZJTEFO?=
 =?utf-8?B?TjdjT2F1aExEU0Z2ZUlwZjlWeG5QQ21mRE9CWll5ZzZEWEU1MURhZkVUV1ov?=
 =?utf-8?B?MlVKR2VhWUlZeWZhUTl3dWNXRFdQYmFpaW80QXF6WFQzazNzQ0Q2YlE5RHpX?=
 =?utf-8?B?ZlZpT091R0VvOVFDaHc4VmdkVWkzQ0RTWEcwaGlJRHZvenhGMjNOTnFDWXRV?=
 =?utf-8?B?Q05hODRDUzJzSHB3YXBCSUhoNkFORXZRRlg0K016WngxZVIveVZDN3p4Q1dM?=
 =?utf-8?B?SWNzaU1CWW9Na1B2VG1jTTVFellPZU9jbjdsYkI1Um44VXNKTTZ4cmdWV3kz?=
 =?utf-8?B?L2hKVFlXZG1vWFFDMWtWejNNbU1YNE5ub0VDZFFmNW5DSnhpZ0VqMW92aEhD?=
 =?utf-8?B?cGdkd2NHcWxkLzJFY2lrOEhVWjFNR3hGQnFJWGlmUlZNdXhxd2JlZ3NNT3hK?=
 =?utf-8?B?M1VmZ2xMenhCRHhpTmNuVGFLU3RaR2lXQk16YVIybWFuMnRyZGVjNTVtMVpG?=
 =?utf-8?B?WVlibmRtVjVwd1lVUG5keFhKdWtIMGhEdmJSRXg5bE52YXluRDJtb29HT2pH?=
 =?utf-8?B?eWNyMzZFOHpXa0ZrU3NjVGlheG55V0pBeXJUWTVWN0ZyOXJ3bnNHbWkyaUR3?=
 =?utf-8?B?NGgrYW44eEt4Yk1ZcXM2enNZelUvK0pCOGZVTVMrVS9ycGdud2pSUkticW8x?=
 =?utf-8?B?c2VidE1tdU03emJtZVdzTVhzUmVVVG02citiV29OcGVSQ0ZqSkhMaFFSQUJs?=
 =?utf-8?B?WnN6MUp3ZTNENHpvREdmamd0bVZ0bzlWMmU2VDlZMjV4MSt3cFJPOUxKNUw4?=
 =?utf-8?B?b29pd0ZJbit6eHNQUDNnY3lDS3FVY0NPTkZRV2Y3ajZrM0YyYkRrTkpWT0tW?=
 =?utf-8?B?bXRSY05QNG9IeVhMOUNXQzVmS2ExWEQ4VkdHdW80Yk1Iczh6WGRwbGJKQWtQ?=
 =?utf-8?B?dmEzd3hXeXFKd0RmMkNxZXFoMTJGcHZLUXFXaFJuTi90YXl5NHQySDFKWEdo?=
 =?utf-8?B?UjVlTlpTRWozRW5rWFNZb1ZhdkFCaUpBSllJNHNTNEdzaEJJNXl0QXJEdnZi?=
 =?utf-8?B?M2J4UGRrclhJQkJiNG9JNlR3NnpBa1g3SjFkdVV2OGIrdWwrM2ltZGlyNFN0?=
 =?utf-8?B?UHhHazd4bkxkYlZSalI3Q0xRd2ZicHltQ3J0T2dPbk9ZenBJY2NwaUNmUVdX?=
 =?utf-8?B?eDFuQXgzaHJUWXd3Y2Q5QkU0cjJvc1ZMVGlzSEpWSmVMdjJzNytwYkdPUXM1?=
 =?utf-8?B?U2RQLzhVMytwMThIT1hoQ0liQVloSW50K2dZRzAva2NEVDhqc09FNzFsaW9q?=
 =?utf-8?B?alFlYjJ5N3VFcTZvQUJydVByUDNHRi9zMWpkMzM4UjIwN3FXQkswSFpWNGJy?=
 =?utf-8?B?Z3lUWGFmMmpHbnpveVpZd3cwS1F0YzllenhnaUM3WncybGZOODh1aUtIZTJn?=
 =?utf-8?B?YU1qcnhXL3h5Wm5UN3lPcERMYy8wOFMzQ3pmNlhjUlZJMGNyOWdXRWVDb3R3?=
 =?utf-8?B?QVBKYzEvZTFoMG9lVnc0MTQ2SmVrT3V0RmoyNWJzd1k4bitsRXRJRlRCeDN0?=
 =?utf-8?B?SmtnYTF4TXJWL0s2RjZYUWRyOGRYeDNGajFSOHowR3dFelRvbTE2L2FBSFBm?=
 =?utf-8?B?bEtWNGV1dG1GUExFQ3p6RnJ4WjR4SzZFNVBHcXFxMVJFUzVDUzg2YjZDSEh5?=
 =?utf-8?B?T0ZGV2s0L0NaQmkwRVFSRXQ5bmZqTitSOU1GcFpWRHgzQXFsNVpwNkRoQXZj?=
 =?utf-8?B?M0dMTUFSSS9iTjN4VmdYd0w0Rm1ncm1sSVhad0l2UWlJUDhRbXNBWXl1bVNI?=
 =?utf-8?B?RFM4K3AvUlY5ZXZZanJncnNRTllKSmE3WFVrWnRBYXNSbWQzSGxQaVRTZ05R?=
 =?utf-8?B?U0FKUlRaOG9ETzM1bmxwSjNHaTZqdlU1TVhDWnpMeXpsTHIzQ21wVDdFN0ZZ?=
 =?utf-8?B?QnVLWk9GRDR1QXlYT2ZsRE5rSmxhWUczZFJuczVFd3FmcmR4VkZMM3FEZjlv?=
 =?utf-8?B?YXhMcm1FNi94R2R0Q2dkMTBZM3ljOFdYN0hlczBXdUs1OUtaQUxDZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f93d561-de5a-4adf-7c58-08df494eba98
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7170.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 10:44:20.0374 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PdWUbafjI7VkRPXF5MdKWmvFRz59GGA3DNUIAC798EJ6d2mqtH1ZicoT7deFnPj+l01nqzqSG+RBPuccwZeyyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9840
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


Hi all,

A NUMA issue is found in another thread in [1]

We also encountered a similar issue, performance drop occurs when NUMA 
balance is enabled.

And there is one more thing about NUMA:
The current amdgpu drmsvm can specify system memory as a destination, 
but not a specific CPU NUMA node.

This has impact on some platforms like MI300A that feature unified 
memory for CPU and GPU.  We did a test for 2GB memory accessing in node
0 and node 3. GPU read/write bandwidth averaged about 2.78 TB/s with 
local pages and 103 GB/s with remote pages, it differs a lot.

There is a requirement from AMD HIP to specify certain SVM memory to 
specific NUMA nodes. But KFD also can not support NUMA fully. So the HIP 
runtime have to use linux NUMA facilities to move memory to the correct 
NUMA node, this could lead to unnecessary ram to ram migration.
And it also can not solve VRAM to RAM evict to error NUMA node issue.

Would it make sense for drm_gpusvm helpers to let a caller pass a 
preferred NUMA node by interface? An explicit destination node for 
migration to system memory.

[1]: 
https://lore.kernel.org/all/b32fb02a-68b4-4db9-83dd-254147dbf215@kernel.org/

Regards,
Honglei
