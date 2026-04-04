Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED5CAE88D9B
	for <dri-devel@archiver.kernel.org>; Sat,  4 Apr 2026 13:23:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0722B10E31E;
	Sat,  4 Apr 2026 13:23:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="mUfVgPME";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010039.outbound.protection.outlook.com
 [52.101.193.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9AAA10E31E
 for <dri-devel@lists.freedesktop.org>; Sat,  4 Apr 2026 13:23:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CepVobxvO01lI4V41IH4zWJ2cS6xyLGpmIAtGlKL755LL0QEd1tMJWG8l7IKaP0Ndx4yb+WaOAgSIxa6r/ezx7v3JVyPt9Mts8af9LBIgPSJwyvkU84AZDoZ5GyBq/aZwNTjipDPMV2aNBB1DC/m1k2iM99/AxV80wKzcxMR3UJvRJR6Y+aYBCpsEOTMFmnGp2QrXxmHYFW/oWXmYvTuAHsfGOclQjI7bHlyVlTjXWfF4hTpRw1TZQuBk1CZdiIcGSblfu989PQpPWzkMe+w0SPb5Nza/o2aC6DWc30dPyYCYv1ddjEkZmHKUOfBYOI3RXUnbebDT3GB8EuzagS70Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a64FNQpCR+O6zyKimYdLURXovqN1xD5QHzDXp0lm3f0=;
 b=iZtui9VwLSWSuud4jcP42O6xR8PJDutPwc+ZJo262p3kLk1MW8NwEfq/T6RcCuELKiEmTqxppfVyxA9eSrIiNVSKr165TNoExduTnTOEPBQhMb5Ouu39X8IcQlJe4mxezEYVFEsF4x2pLKHGElqCBeWIEnTSzPIbrmV6cc5fwW8Q7HxgrJaWET9N47omTG5UQa2dcUdAgXS1yDHN6P6NFTqflfLPcm96/w4Xl/yFvym6eqoMXcq922qqb56QILWH3zY2QHfpILPkUu/67BNjWkvmE7tjc11XXQ/1iIZsopFwSkV/Okqx5T4n137+kvLUInHtYDLJ+M2tHPVw9dRr/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a64FNQpCR+O6zyKimYdLURXovqN1xD5QHzDXp0lm3f0=;
 b=mUfVgPME0GR2saH1QPj8VQYWMsT+bhjxtfS0HDkFsavPp7EJyMnWiYCja3te/Pj6Ny0pnpuX6iacJ7NSi/xRTTcPc9DEF7JO6awELC4Vvw0Gc//iiIr9w3QrC8wp2fDJ35RVnde+qwxYVheKhvsoDJZrsCo9YWi4Wnu+aQAOJ8eE6ZshKOy2YsXgPIKWSSi/Xtdqk7BsSPrnJ2zRoZNlL5dlWWmn9PxGQl/C/dVQXuwpiqBipxUFrzsn0K4o+nomKYbgfgZp8u0LJ3esNI6JgPphhSok7gfrpb9epSRN7UrSXv8a/z5j3xVouF27dk1uWK78C/PZXaMtVjGN4FtViA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH7PR12MB6834.namprd12.prod.outlook.com (2603:10b6:510:1b4::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Sat, 4 Apr
 2026 13:23:26 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.20.9769.018; Sat, 4 Apr 2026
 13:23:25 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 04 Apr 2026 22:23:21 +0900
Message-Id: <DHKEIOECSD1A.524K1KHYUC2F@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Alistair Popple" <apopple@nvidia.com>, "John Hubbard"
 <jhubbard@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>, "Timur
 Tabi" <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5] gpu: nova-core: gsp: fix undefined behavior in
 command queue code
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
References: <20260404-cmdq-ub-fix-v5-1-53d21f4752f5@nvidia.com>
 <DHKE5WW9QSVQ.31QE6KK92PU8R@garyguo.net>
In-Reply-To: <DHKE5WW9QSVQ.31QE6KK92PU8R@garyguo.net>
X-ClientProxiedBy: TYXPR01CA0051.jpnprd01.prod.outlook.com
 (2603:1096:403:a::21) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH7PR12MB6834:EE_
X-MS-Office365-Filtering-Correlation-Id: 6268c383-9ce9-47de-37a9-08de924d5a25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|366016|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: dM0QI4/li7LG/3fgXQAywLPyY8hjGmVHCJWtL0kqfm+QVBh0ngRp9sgb+dC2iXHqYAF2QSuOYPRHVxvSNgvxd14Sxd9lJCe82xQZEGO81umg4ruM48wTwJR4LHuaz9unqYgvonGvLuKFdZdopyfXQkxuXWu9/WGRpvnb8wtDKMNVksshyG69O3bkx5pXJhcLj51k0KidQUmWaEEuVlUMo1icYrn6UjXmmcxJIbGVa8IuhwpWgXb+rSZ5Nac4ReLQ2RJgoJ3Q3pldBZV1jFzjQuBWLTuGCBJyAdfmR6USFgWQCDLMAzTHRizSmiVBn3MnpZ1wlIFHWaWyHHYp29OUMNz0blitREoRCfVSK9m+hWDHf3nqi3+sqKe/zNQYXC4OIP7SQsTRCdy2ZSgqo+e2bUN/vFlWyk0fH0TjLmSPeFHi7870XwXOAMa0aY1FH8fLsNXRmZSUmGzSnLIrDEcL9JsJa4p7sIz3/ll7oMVADn+ZzRbumGFzHlBPp8VFYUlGfRCbsIQedsFzFd8bfZtpMy1SqA7pkhzk1Zvs17FGcVC5atqsYSH25D41TX1SVyfT2eZxXO2/Go1t5Lfwqqv0EL2Y/vDZ8+JTZX9gVpOHKdwxaWfjXQnFo5+IKfkVZYDeKTxY5gXSb6BK9vG7bH0s7DRKrydiHSEBS/qIyVSdeQksj11wRyL5/B2sqWwdMuyA6RCQX/4nyw/cAh/AZQ8wgIFyTLIsm1PB5S46lrW5/jY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnh6TGw2RFpFekMwYnRnOXFHQW52M0JDQjVha3FYeFlZbUpUc3QwNllyVERV?=
 =?utf-8?B?UGVVcFB1UWIxaURFKzdIY1FhWEtmYndYbTZtNVQ0VU5aRGdwUkpoM2ZaZlY1?=
 =?utf-8?B?VVpTY1FkWC9HWkszSHdhSnFUc3E0cXhBRnMxODhVRjMzOFk2L1pnQVNwSnFG?=
 =?utf-8?B?dkdiY0NuWkE1S2VYYXE3VTBGalU1SzFLc0RjODRENmlTMFlpRjhOWmR3ZE14?=
 =?utf-8?B?WG5aWW5LYWtVMUJseTNweUcyYW95V2dXUXN0SWgrRlp6MWhWV2UvSUk0MlYw?=
 =?utf-8?B?OHBMMU53dnNaZWRxeEQ2VWVybEtBU2F6Q3plZERhWXVlbmJlSVBTOVFkU3hZ?=
 =?utf-8?B?aklVRXFEejNjZWM3L25NRklqZ1Vnb3BNZ0c0cnlTQUFXaE9CSDlIb3lWemo1?=
 =?utf-8?B?dnAzZ2VkUWNHZDhmemhlQWtGUSt5N2I3Z0dJZm4vV2NLV3Z5Y0RQN2tyaVRq?=
 =?utf-8?B?MXpXMm5pbjhtM1NjSlVSL3YvN2IyTXlzbC9RcTNnM2k5MWMxZVkxTkNvaktN?=
 =?utf-8?B?UzB5VkxPdTY2VG4wY1hrcmhiT0Y2Z25DMG03VEFQZHQ2R1ZQMDhDVXphYk9U?=
 =?utf-8?B?Z0RmZEUwRnJhTjVhVW5zUFpjbzBmczVpaHdSN3YzZ0p0a1l4cm5HU3lGMlYz?=
 =?utf-8?B?VXhKYmovMjN6ZE1vV0N3ZXBxVmswaTMvNXRjWCsxUmM5cDRURzBqNGt4WEgz?=
 =?utf-8?B?MVBMMXZGOHprbEowWUpyMjAwdWd5aEVYa0xFNTVsSlcyekVQcVpFYXM0bzZ1?=
 =?utf-8?B?aHd0RmluUzNQdkNHOU51K3VrTWVMUEl4MDh1cHp2SGxUZmJmZmUwTnI5cTB3?=
 =?utf-8?B?VUVxK2ZYOHJyM1lnY2xKaTFHbTIxeWhBQlVxSHNCOEltNitLaWRLbmxia3cy?=
 =?utf-8?B?elhjTHlHK1lqSlR3dlkzOHZEM2hmSGNTeVZDYmVNN2dPWlVJVU5PaWM0RFJP?=
 =?utf-8?B?a2ZnVGk2WWZGOXNuTmFKNHRycDkxbXJodXZUb1RBazFXajZRalNXQWRyKzJv?=
 =?utf-8?B?Wi9LaG04cEw3QmJ1aG1NdEJZdi9tL0FMc1h2U3loSWZkSXA2a0EraXVjTUhu?=
 =?utf-8?B?Tjc0YXV3YmVwaTYyU2xXbkRrRW84emR3Ujc3Y090VWV2UWlGVmpXNEVoNytV?=
 =?utf-8?B?S0thaWNCTGY4ZVJ3YXkyRDV5YnNNcmZIdE5RSUVpQ0p2dzBRMURpOFdxcnEx?=
 =?utf-8?B?b3FwYUl5RVNmb0UzVHpoSXJabXlzU2ZHdDN4Z3IvSEh6a3VxOG94T2RQa2hM?=
 =?utf-8?B?ZkpRbXBHcGx4a0NDMTJtWjRtRXBNMVJaY21nNzVMYkltUlhka2VQOFpRdnNh?=
 =?utf-8?B?UElBTnNhZm94L0k0ZURCNTdmeDhwdWtNbGxmd2YrdnQ3VVc3ek5BcEdJMDl3?=
 =?utf-8?B?SFVGNVJBSHFBQlVVQlVKbEZFSFpTTWIrOGM2RTN3bVRDMHQ5dUxPQXB6K0l0?=
 =?utf-8?B?Y0UyUWNIWlZtWUNqZDJPdUFHWUNTeUE2dGxqNW5oNFlaUU9ZZk1tL1VDY1VU?=
 =?utf-8?B?MVZJRnNuM28wWktQanZJdXA5U2V6cU5oaWx2ZHVRWjRDSW1DcExHdUJZRGVP?=
 =?utf-8?B?TDMxSi84Y0U1MGJoVGtkaDZLYVBDb21nNGRCZTcvb2dxOXhuZEh0VmhKT1Jk?=
 =?utf-8?B?VWw0ZXVTQ3Z3NCtscTBZMXBmMXB0WGQvZjdHYlVHSTVhaW1kNThPN2RENXRz?=
 =?utf-8?B?WnhIeHVXdHdUOXlJVDRJZmltS2Zab0hvVUIxUDRiTyt4aTROU3RJZDZsQ0wv?=
 =?utf-8?B?Mnl2WjFkbXFYV0Niak9QQ0ZkbGNRcXNuNitWOEhzMzhuMEhuOXhrTGZjUUpR?=
 =?utf-8?B?bWZIOStBczd4MWNxWE5tcFQvazBWTTVHL1dOcmdzU0lqbERlY2drOGxIbjZ2?=
 =?utf-8?B?SzQzV0phT3YxZTRoazJkZ1VmcmJ6UHE1U3loZHk4MU9ROGsxUlIycVdYVDNB?=
 =?utf-8?B?T3dpU1JDbFpHRDhQeWIwYzBSaStKaS8vS21qR0tYYVZvRWVaU2J1UXJRYnly?=
 =?utf-8?B?TjF3YzFBczUxQlF6YVNTY3NieEtXbFpwU0lMRDRFVFhlYmNBWHBvT2ZRTkQ5?=
 =?utf-8?B?dWllWjZTeDZqSXJnY2xjZHNZRkJTK1ZGZjdydTJUMERXd0orVFplOGFzV0w4?=
 =?utf-8?B?V2pUdzhhbi9Za3dIZVNDTVR0eVN6NkQwNVRwa2NMRm9TRTE3UFRnSEpWaUNE?=
 =?utf-8?B?V2pibnVsUk9aM2VqUmExazA0QnkvMVV1V0hKY0lZMldsM0VqMG5TcnFUNUxG?=
 =?utf-8?B?T2pHTGQxT01vSWZXM1lWUzBkZjBtWkhvYU5TUUN0S3RqVVo4andOL09kMXln?=
 =?utf-8?B?dkZGTTZIQlRpNVE2ODUvNGNPdDRGZnZabldrNmVJbDhlN1JIaDNJWlg1dEdl?=
 =?utf-8?Q?qIQ4hQ7AviuwhKkzcJLmKGH1WVecs3hOj8rkDdnSz5l7I?=
X-MS-Exchange-AntiSpam-MessageData-1: vPlWT1UzbVbkxQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6268c383-9ce9-47de-37a9-08de924d5a25
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2026 13:23:25.8257 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ynlgYfeau6Yx6OCflj8zhU/TMfLk0W5YdGb5bbTfchfdPZ5fk0tZjw0pu209sdR/OyraduiQn4ujJLXtRWQQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6834
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

On Sat Apr 4, 2026 at 10:06 PM JST, Gary Guo wrote:
> On Sat Apr 4, 2026 at 6:04 AM BST, Alexandre Courbot wrote:
>> `driver_read_area` and `driver_write_area` are internal methods that
>> return slices containing the area of the command queue buffer that the
>> driver has exclusive read or write access, respectively.
>>
>> While their returned value is correct and safe to use, internally they
>> temporarily create a reference to the whole command-buffer slice,
>> including GSP-owned regions. These regions can change without notice,
>> and thus creating a slice to them, even if never accessed, is undefined
>> behavior.
>>
>> Fix this by making these methods create slices to valid regions only.
>>
>> Fixes: 75f6b1de8133 ("gpu: nova-core: gsp: Add GSP command queue binding=
s and handling")
>> Reported-by: Danilo Krummrich <dakr@kernel.org>
>> Closes: https://lore.kernel.org/all/DH47AVPEKN06.3BERUSJIB4M1R@kernel.or=
g/
>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>> ---
>> Since we are still getting `build_error`s on some configurations, this
>> revision reverts to building raw slices from computed ending indices.
>> ---
>> Changes in v5:
>> - Eschew pointer projections with runtime-computed indices to avoid
>>   spurious `build_error`s.
>> - Drop `Reviewed-by` tags since the code has changed significantly.
>> - Link to v4: https://patch.msgid.link/20260401-cmdq-ub-fix-v4-0-a9a9cf9=
82485@nvidia.com
>>
>> Changes in v4:
>> - Make some methods providing the `ptr_project!` invariants inline.
>> - Use code paths that preserve the invariants `ptr_project!` depends on
>>   more obviously to fix these testbot build failures:
>>   - https://lore.kernel.org/all/202603280326.ucDKVaf2-lkp@intel.com/
>>   - https://lore.kernel.org/all/202603281331.1ESuqgfz-lkp@intel.com/
>> - Improve safety comment when creating the mutable slices (thanks Danilo=
!).
>> - Link to v3: https://patch.msgid.link/20260326-cmdq-ub-fix-v3-1-96af214=
8ca5c@nvidia.com
>>
>> Changes in v3:
>> - Rebase on top of latest `drm-rust-next` (with `Coherent` patches).
>> - Use pointer projections. (thanks Gary!)
>> - Link to v2: https://patch.msgid.link/20260323-cmdq-ub-fix-v2-1-77d1213=
c3f7f@nvidia.com
>>
>> Changes in v2:
>> - Use `u32_as_usize` consistently.
>> - Reduce the number of `unsafe` blocks by computing the end offset of
>>   the returned slices and creating them at the end, in one step.
>> - Take advantage of the fact that both slices have the same start index
>>   regardless of the branch chosen.
>> - Improve safety comments.
>> - Link to v1: https://patch.msgid.link/20260319-cmdq-ub-fix-v1-1-0f9f6e8=
f3ce3@nvidia.com
>> ---
>>  drivers/gpu/nova-core/gsp/cmdq.rs | 116 +++++++++++++++++++++++--------=
-------
>>  1 file changed, 69 insertions(+), 47 deletions(-)
>>
>> diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/g=
sp/cmdq.rs
>> index 2224896ccc89..569bb1a2501c 100644
>> --- a/drivers/gpu/nova-core/gsp/cmdq.rs
>> +++ b/drivers/gpu/nova-core/gsp/cmdq.rs
>> @@ -17,6 +17,7 @@
>>      },
>>      new_mutex,
>>      prelude::*,
>> +    ptr,
>>      sync::{
>>          aref::ARef,
>>          Mutex, //
>> @@ -255,37 +256,46 @@ fn new(dev: &device::Device<device::Bound>) -> Res=
ult<Self> {
>>      /// As the message queue is a circular buffer, the region may be di=
scontiguous in memory. In
>>      /// that case the second slice will have a non-zero length.
>>      fn driver_write_area(&mut self) -> (&mut [[u8; GSP_PAGE_SIZE]], &mu=
t [[u8; GSP_PAGE_SIZE]]) {
>> -        let tx =3D self.cpu_write_ptr() as usize;
>> -        let rx =3D self.gsp_read_ptr() as usize;
>> +        let tx =3D self.cpu_write_ptr();
>> +        let rx =3D self.gsp_read_ptr();
>> +
>> +        // Pointer to the first entry of the CPU message queue.
>> +        let data =3D ptr::project!(mut self.0.as_mut_ptr(), .cpuq.msgq.=
data[0]);
>> +
>> +        let (tail_end, wrap_end) =3D if rx =3D=3D 0 {
>> +            // The write area is non-wrapping, and stops at the second-=
to-last entry of the command
>> +            // queue (to leave the last one empty).
>> +            (MSGQ_NUM_PAGES - 1, 0)
>> +        } else if rx <=3D tx {
>> +            // The write area wraps and continues until `rx - 1`.
>> +            (MSGQ_NUM_PAGES, rx - 1)
>> +        } else {
>> +            // The write area doesn't wrap and stops at `rx - 1`.
>> +            (rx - 1, 0)
>> +        };
>> =20
>>          // SAFETY:
>> -        // - We will only access the driver-owned part of the shared me=
mory.
>> -        // - Per the safety statement of the function, no concurrent ac=
cess will be performed.
>> -        let gsp_mem =3D unsafe { &mut *self.0.as_mut() };
>> -        // PANIC: per the invariant of `cpu_write_ptr`, `tx` is `< MSGQ=
_NUM_PAGES`.
>> -        let (before_tx, after_tx) =3D gsp_mem.cpuq.msgq.data.split_at_m=
ut(tx);
>> -
>> -        // The area starting at `tx` and ending at `rx - 2` modulo MSGQ=
_NUM_PAGES, inclusive,
>> -        // belongs to the driver for writing.
>> -
>> -        if rx =3D=3D 0 {
>> -            // Since `rx` is zero, leave an empty slot at end of the bu=
ffer.
>> -            let last =3D after_tx.len() - 1;
>> -            (&mut after_tx[..last], &mut [])
>> -        } else if rx <=3D tx {
>> -            // The area is discontiguous and we leave an empty slot bef=
ore `rx`.
>> -            // PANIC:
>> -            // - The index `rx - 1` is non-negative because `rx !=3D 0`=
 in this branch.
>> -            // - The index does not exceed `before_tx.len()` (which equ=
als `tx`) because
>> -            //   `rx <=3D tx` in this branch.
>> -            (after_tx, &mut before_tx[..(rx - 1)])
>> -        } else {
>> -            // The area is contiguous and we leave an empty slot before=
 `rx`.
>> -            // PANIC:
>> -            // - The index `rx - tx - 1` is non-negative because `rx > =
tx` in this branch.
>> -            // - The index does not exceed `after_tx.len()` (which is `=
MSGQ_NUM_PAGES - tx`)
>> -            //   because `rx < MSGQ_NUM_PAGES` by the `gsp_read_ptr` in=
variant.
>> -            (&mut after_tx[..(rx - tx - 1)], &mut [])
>> +        // - `data` was created from a valid pointer, and `rx` and `tx`=
 are in the
>> +        //   `0..MSGQ_NUM_PAGES` range per the invariants of `cpu_write=
_ptr` and `gsp_read_ptr`,
>> +        //   thus the created slices are valid.
>> +        // - The area starting at `tx` and ending at `rx - 2` modulo `M=
SGQ_NUM_PAGES`,
>> +        //   inclusive, belongs to the driver for writing and is not ac=
cessed concurrently by
>> +        //   the GSP.
>> +        // - The caller holds a reference to `self` for as long as the =
returned slices are live,
>> +        //   meaning the CPU write pointer cannot be advanced and thus =
that the returned area
>> +        //   remains exclusive to the CPU for the duration of the slice=
s.
>> +        // - The created slices point to non-overlapping sub-ranges of =
`data` in all
>> +        //   branches (in the `rx <=3D tx` case, the second slice ends =
at `rx - 1` which is strictly
>> +        //   less than `tx` where the first slice starts; in the other =
cases the second slice is
>> +        //   empty), so creating two `&mut` references from them does n=
ot violate aliasing rules.
>> +        unsafe {
>> +            (
>> +                core::slice::from_raw_parts_mut(
>> +                    data.add(num::u32_as_usize(tx)),
>
> The code would be simpler if these `num::u32_as_usize` are just applied t=
o `rx`
> and `tx`. But other than that the code looks fine to me.

That's what I did initially - but the problem then becomes that
`MSGQ_NUM_PAGES`, which is also a `u32`, needs to be converted to
`usize` as well, resulting in more conversions. I've figured that
working with `u32`s until the very end was the less convoluted solution.

One could argue that `MSGQ_NUM_PAGES` should be a `usize` as well, but
that would require more changes to `cpu_write_ptr` and friends.
