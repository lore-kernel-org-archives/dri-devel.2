Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEA2606C566
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 15:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=boARJ02I
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA03B10EF6D;
	Mon,  2 Nov 2026 14:59:58 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011063.outbound.protection.outlook.com [52.101.52.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DD8210EF6B;
 Mon,  2 Nov 2026 14:59:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=INtIQ0skjY6OwIkTdqO0a1YVnAY2xNXfS6CAcn3KDgK2CJk65KuFToK++xen8mCdfNGHjKG+3DQJq6iDk7BHVzLLKVUOaTBNNC/JvcrYrzXjjQNO9/FAd3NAI9K8vLt89Wt/YwDMde7s6PCfJ64kx+sx3n88aAnWZs+PWNVT6ZmnVwfbcOwiydQ+KmYHvBstzgstWx8ifpThD54702UV9W399i32wRfsuZqQlJX9PNVifoPMfq0UpjqEKQULRpp3wFE8ZcTCUuNZhja6DLzJ5MHTqkCVoSCPNR9h7XJSQjUIahIYiFLGbk5dXHfW9/Jtw1f157iAtbg3vbBMIfsVhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hLm1vBV8u+Bv1B0r3aGcz6unt7/7aYZR7N10qCFDDOw=;
 b=Xhma40i8Kt3fSPo+c28WLbRxcbu8Ub8QKoloyBPZ4vKUJTHZf88Fy10qJ4jPXoovC4Naaj+u3RnNDUqDLkQGR4JNEc6Oj97+818kQ/DMuJb5w95UOPu+mFuc+AG1ubM34ipc+nAKaaMlprYe7xkEJVmwhfAVrMSCUzza1JzZ+Is2KgCNJlaQ4deZR4BqAhoYb6rZ4wMgLb79zEJ9uQKYpbG4nIe/VfUBwIdw4OG2ctkxdIEf+z3wdxMFKvcUgKaD/tZxAM6OzmrPo02LpHq65KSC2YPOwrv4a2m0oFkfH9MU1uMd36+w8f2c3QXBfKbLdyVG9li8AbbGMA9Q0wAojw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hLm1vBV8u+Bv1B0r3aGcz6unt7/7aYZR7N10qCFDDOw=;
 b=boARJ02I3djsp+D/5Xvw693oRh2WiNIFrVnkGF+MPdAa/qAkQ8IB2miWEpmVT8Vl13Uvomiokz1uEux5Egl4rMzmEqvVHmzloaXZY3vbNUpGm3h5s2teDwNeobKPXcUwbsCgHdi6tHxwY+VLbzSJIGEfnXP6dSWsOE6wT3l2Bjk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB9174.namprd12.prod.outlook.com (2603:10b6:510:2ed::9)
 by DS0PR12MB8562.namprd12.prod.outlook.com (2603:10b6:8:164::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 14:59:44 +0000
Received: from PH7PR12MB9174.namprd12.prod.outlook.com
 ([fe80::eaaa:b430:ba9:5dc]) by PH7PR12MB9174.namprd12.prod.outlook.com
 ([fe80::eaaa:b430:ba9:5dc%7]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 14:59:43 +0000
Message-ID: <5d9150eb-eb5e-4788-8945-cfc8084385d4@amd.com>
Date: Mon, 2 Nov 2026 08:59:40 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amd/amdgpu: add firmware file fallback for APU
 VBIOS discovery
Content-Language: en-US
To: Arnaud BERTRAND <arnaud078@gmail.com>,
 Alex Deucher <alexdeucher@gmail.com>, Oz Tiram <oz@shift-computing.de>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <CAGxFSwnJYc03fN+XWU8oLW9EbXhmetQuj1s3-m8UdZHoBdGJ8Q@mail.gmail.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAGxFSwnJYc03fN+XWU8oLW9EbXhmetQuj1s3-m8UdZHoBdGJ8Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR16CA0003.namprd16.prod.outlook.com
 (2603:10b6:610:50::13) To PH7PR12MB9174.namprd12.prod.outlook.com
 (2603:10b6:510:2ed::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB9174:EE_|DS0PR12MB8562:EE_
X-MS-Office365-Filtering-Correlation-Id: dcbe9a64-1192-49ac-d1d2-08df38f1edbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|11063799006|56012099006|261009223027099003|261028144727099003|261022105027099003|261026140227099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: IVaJ+9CGx0YYJUbn15NSfnNU6+8UMSlIkh53JAyWIs0+xuuRpXVHDNwji5PbWQ/luA/0lWtlPN5uDcpzhJHGi1XtvkEORcVg1ExU/5bnli1vf0UAAd+eItC7c6PVQ1yxzG+zer2YlIf+lunxvuG00MQBfTmDPQkK8MI2inOpSWpUkt2NwA1phiDhv07iR3OCLcxlugPJ6LG/9KXXRvzgeZDzh4b08lIKVWBFdcW+4sYmsZ6gBe8HJgmKTW7rzTRa99qj9+YGOoFZ/GC4fpCL5IuD1XoBp0lsaMcVsqVt8RKWX+/rvDNcv8DdE544UviP4dbF+XyWxANQg7wZl2faoT2FxZecQMFGYlqk21kvyUWQqrfVIwsVJANEmARir1iq778TbvtJx0x3rY85IddypnzPKvyoxbBTcswpl0iMA/ql3chbrXmRBYatuzxIn5XH4bSdlcw7IvRoPIUaFjzYpwEBgM9ifVsMyK014zt32VZqRpcEUrXaa316r8uqJ3dcaWq4Gai4ohcjpBkmY4fStzDIT5hWbtm5UQ5l4q7KiO2w9mVPocLNOH3jpoDVcD8Cq6e+jC2hJ6+NI2zM/J+WpVNpd6kAqfufEVh6NtjRxgA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB9174.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(11063799006)(56012099006)(261009223027099003)(261028144727099003)(261022105027099003)(261026140227099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWlYOXIyZmtpc1RTcGZJRjZSTGhHTXQveDl6N2VyMTZEVitPclY0M091cnVi?=
 =?utf-8?B?R29oczU1bWNBMDFMRWRnWlF6ZWNwMjNLYXpwUlJUcXE0R0pYOXZmb0JCRmRo?=
 =?utf-8?B?STYzTVFVOXNjdkoxM0NEMWhrdWxlWlkzUVNRWUx2a3VwZkkxNTVBVUQwZmJS?=
 =?utf-8?B?dVpvSjdKZHF4Y1JtRjNwY2V5eGJhUHRkd1JyVnRFKzgrVTRqRGxJbWhVM2ht?=
 =?utf-8?B?VFY0cTRNMmswc1Z4OUV1ZUs2VzlqM051TW14MTNhSUx0VUFaQ3FDd0tUR0Zu?=
 =?utf-8?B?cmp1UVFXeU4yZ1hnemNOcC9lbGhQSG1FSCtHeFF5WmswVVFDZ3pDQjNDNFZi?=
 =?utf-8?B?aDBnWVQwamZKbExNeWR6TmtsTHRuSmJaTHN0RWlYN1JCYXMwVTdIbm45eUU2?=
 =?utf-8?B?Z01KMEd5dEs0NGpldWFUR2phRDFtT0xqeEpuYnZqWW1Td0dFTmkrSlpld2Q0?=
 =?utf-8?B?UjhHTXgvREFpQ0FSZkdhMnFZdlVyU3YxMDFzUTQ2SkhMcHAyL1dNVXVFN1RR?=
 =?utf-8?B?V0tIZlA5aWliM00zd1RoR1Y4eU5IeU42Z2VrVHhCQVVaSGNCREFVeUg3eThX?=
 =?utf-8?B?OUlrYXphdzYzcE52aGNOYm5vUVN3TVBKeTcwdDliQUFXUmY5eFM4Z1F6bHhk?=
 =?utf-8?B?TU83bUJ4M0hMbU4zVlFrc1pGSi9nQ2xFWmJGZFBnb050VXNQek9CV21ZT1Fp?=
 =?utf-8?B?c3NPc2JQemNhNjBsN09PVmNnWmo0N0FyLy9YQnNMYU1wSCthRFVCazQ4QVlP?=
 =?utf-8?B?a1JIY3J3bFA0SkpZdFgzTkVKa2E0ejc1R0h1TkVJdXEvei9yMkZkVlBFT2Vw?=
 =?utf-8?B?eUVmMHlzS1MrKzlLZGgxUERPT1Nva3lnU1pobzZyRDdRRzJRWllGTDRmSktP?=
 =?utf-8?B?NGV0QVdjYkFxNGxmZ1VRVGg5bGgrK0EvNW05QWpIRFJGTHBoeEZ2ME1UMC9z?=
 =?utf-8?B?enc2dlc5blNrY3BBY2JJVWE1cUp1Z0g4RURrd25YWmtpVEVrdHk0RGZySjQ0?=
 =?utf-8?B?dXBZanc4czd2RVlEWk54S1I2UlA5NjFVWHM3ZVRXN1V6c3h1UDJhcElmVWlY?=
 =?utf-8?B?VUgxczc4RTdKQy9TNXpBU1FZY3I1UEtUN3hIZWQ3TDBYdysrU0R4YkN6M2Fk?=
 =?utf-8?B?TlJSNUR2NDY1ejBBa0xBdEFMRlYxdkMzZHR1L21PS0l5V2xYaDlmZnIrb1BT?=
 =?utf-8?B?REwwSHFoUThsaDczWjB0NndWakVnYWlEQ0IxbEh4Mlc3b2RjK2ZFZzNETXd5?=
 =?utf-8?B?ZEN4WDl2YitiN3BkbGdFZ2VsYXN5bWRXYlNRSU0xOFRucTNEdE1VeHlBOUs4?=
 =?utf-8?B?R0xLZ0phaFBwcTA5SFRUTmxhWHhNaVJyNW8zUVJLV0JLQ3VYYVhIT2RZaFVn?=
 =?utf-8?B?dWVkYmxueHdRTTkxMnMrZElvV0dOL0MrblZjVU4vOFBVdVUwU3VQTkRNdldD?=
 =?utf-8?B?YjJudzFBdU4wZDcrem9KcjFnL0ZPV0NIMjc3NUZsME5hUjg3S3BwblJhS0pE?=
 =?utf-8?B?NDg5UlZTVkxWWUlZMjNabUs3bFVXUm0wU01kSzhWSWdXM2NMdkdPa0VWTitp?=
 =?utf-8?B?YnIzUDRlNHdlZWMxVFl5dllvVTIrY2xZRGl1b3ppcHg2Y25XVmdUYzJhM25N?=
 =?utf-8?B?STVLU3VpRmxtU3dYRFIwZVRRVUF5SjlQRjRPaGsyRjVOekJlVUxYazc1Rndy?=
 =?utf-8?B?NkVDbjBNS3FVMUI1MWp6eWd4eHZrbU40S0hLblhpSDRUV3VHRXlRMFNYS3BT?=
 =?utf-8?B?NU9LR3E3ZHppSXdpWFptNlNMOTRjRENEU2Y4Wms2MzBDWkRkVlhPelNiMk45?=
 =?utf-8?B?SzFDY2VpTWMvQkpjd0lFejVXWTZUT1dRTnBvdmx2c3p0K2Z6cVE1ZWg3c1JI?=
 =?utf-8?B?Y0laS0dlRHl1Smx3Y3VyeUoxWXcrcThyekRoTlpSQVNDaytFS3Y1QnR5SDdY?=
 =?utf-8?B?MFJFY0wvVlQ0R3E2RW12MHlnT2RTWHMrelA2Znk2WCt4Q3JEZzVMNWRiUFlx?=
 =?utf-8?B?QzRoUGZLMFJQT0QzeXFUVmkzL3d0U1hQQVoxMFVGTmx2MEg1RlhsQ2R4N2VD?=
 =?utf-8?B?ZlZiMFV3OVYrZ1FubEVEZk5XaHY0RS92eWVKaDREQW5LUWx6OGI2OFp6T2pI?=
 =?utf-8?B?WjA2cHJkTm84a1NNbHVsVU83YlJUTTFVY2FIVTBwbFc2angyQS9jMnI5N21L?=
 =?utf-8?B?ZGo0SCs4NXhBYzNoZStwYUdaOHppRklYNDVvdEJFK1VIWDZPRW1ESnZyK1Fs?=
 =?utf-8?B?emdXMFo1bmFRZ3NDNnJxVUVOMzhwa1UraXBSUCtSUkZ4RDJlU0hlTG9xT01H?=
 =?utf-8?B?V21zWEdML2Rxd3FJaEswQUgwMWNpNnZ5bnRGK1NPblhRT1kvYVI2dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcbe9a64-1192-49ac-d1d2-08df38f1edbb
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB9174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 14:59:43.8546 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pTiQ4egDhx22juXQ+lRym0etCPMkU36X8BlKvff46BPaZnIcAQdvoXog3q5PBhDoGK2+FSiB9b3bEcrzNJA0Tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8562
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



On 11/1/26 17:31, Arnaud BERTRAND wrote:
> Hi Mario, Alex,
> 
> I have two dGPUs : a Radeon RX 6800
> XT and a Radeon RX 6800. They both report the same PCI identity
> 1002:73bf and each has a different VBIOS.
> I hit the same VFCT bus-number mismatch on 7.2.10, but with a different
> outcome: on my machine the device-identity fallback actively breaks the 
> second
> dGPU.
> I patched my kernel to remove the fallback, but I would like to have a 
> better solution for my use case.
> Would it be possible to apply the patch only to APUs ? That would keep 
> Oz's APU case working but a dGPU with a stale bus number would fall 
> through to its own ROM, which is the source that is
> guaranteed to match the card in the slot.
> I can provide more details if needed, I am out of my depth here.
> Thanks
> Arnaud

Can you please have a try with this patch series?

https://lore.kernel.org/linux-pci/20261027-vfct-regression-v4-0-0e7190e39c2c@amd.com/
