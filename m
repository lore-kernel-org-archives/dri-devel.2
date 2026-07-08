Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9C2AC43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 18:03:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AE0D10F20F;
	Wed,  8 Jul 2026 18:03:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4cDo9I9P";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012053.outbound.protection.outlook.com [52.101.48.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9A3C10F20F;
 Wed,  8 Jul 2026 18:03:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mj2PRi1qGkOGRBcz6t3vFtNkRplgaYHQH5lMGipB/biUGpTaK8Yjl7W271sDra2ILM5kliUp/6G/jQetpNIdUwxtMnIcxRcQON4lfz9uZalUPM45987igrO9UoPqA22UakpsW0WR8J03O6g3p0FyRpOUbLDVFzeBa6+ttuJuhJ8i2BnzG9QXF5GFFgE/qWV673ZqIH5IVnmzGDGqDJ19fImJMvozcx56gwZhXCK6e8CsyCsHXU9N6OZtEuGzucaEXY0AacQrlHOfOPLHP6HTblMDMSjGQCbqV3AVpXC1vRo33fhZQjbdWGLidxgaVfoQq0jzxSPfvY058K+bK+xxhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5LSmsMBMVjSo3EbRRv6tdmqceypJer9FFvLb1txcUt8=;
 b=yQxw/jGrm+JPwbkIk+qwUOYHY1UWq5c8uWF70rCvcMvLg1avlivENbZW7ueg7HCU9bQQ1dLqmTL9VNfMJy5gze1PdjgPLsVBfTM2vrTdmPkxf3VKd7oA+717fIcxy1lH0B1dKKhsJywESWY8W+uqXV520LFx4wTx7Vr/mGaWFp6Z4PNdeJIGeSMINnr6N5hDOjqJU7xJs0I2/mm3JnFk/I48Emv4hGGUorkGia84dJQiyRdzu+UsMrCfnYZUVvGS3aLxSOlMqHxY2cXUWDP/sN1BlOGnbyT6LaRXN4JEw15lQ/XLT/lciFioSmKPuvOg+mdMH3qAhJC4F5nLlm1A+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5LSmsMBMVjSo3EbRRv6tdmqceypJer9FFvLb1txcUt8=;
 b=4cDo9I9PHniFZPfQfvVqJA7A0ZrExMgzY0R0c7BDkEuC+vrQNp9OdA4ooPwWVC+i3+z1tSXD0p+BempjjRvfRCV8wDDCsA5edwfqMQO6K7wcNXPveABZfalSBbGc1Ck7jCkGXpZLSKXHJom75JaZDqlze8EP9O/jxPUo0sKG+FU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by PH7PR12MB7164.namprd12.prod.outlook.com (2603:10b6:510:203::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 8 Jul 2026
 18:03:40 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%6]) with mapi id 15.21.0181.008; Wed, 8 Jul 2026
 18:03:40 +0000
Message-ID: <a316f414-b995-4ee6-a082-259b4ea2d7ca@amd.com>
Date: Wed, 8 Jul 2026 13:03:38 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amd/amdgpu: add firmware file fallback for APU
 VBIOS discovery
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Oz Tiram <oz@shift-computing.de>, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <716a31c5-0484-4ef9-b49e-b71310f92d86@amd.com>
 <20260705100436.6877-1-oz@shift-computing.de>
 <a8339282-e3ef-4a4f-a135-968f94855e76@amd.com>
 <42e07bbb-9384-4871-a345-e0fd6c00a772@shift-computing.de>
 <bd1f1632-f53d-4bfd-9d28-5b66e466366c@amd.com>
 <80f34509-9781-421e-b60f-1b8c772a01a9@shift-computing.de>
 <8dd56d76-e46d-43b6-831d-27e66fa2879a@amd.com>
 <cc849fb3-224e-43c0-bc50-67fd025009e7@shift-computing.de>
 <0478bdcd-dc55-4eeb-b7a3-6c5e625ac5c1@amd.com>
 <6e2eaccf-823b-4db2-a4f3-451e5753af8d@shift-computing.de>
 <bc1dbadd-a3ea-4ff9-826e-6826c20bb54e@amd.com>
 <d224d046-0480-4e38-9e93-29a0d37f3331@shift-computing.de>
 <fc0fbda4-87a1-4a58-a66f-728274b4df92@amd.com>
 <CADnq5_Niga7=B9DqPAOJLkBGMqf25jfcexeCXzBO5_4Cu-Lfhg@mail.gmail.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CADnq5_Niga7=B9DqPAOJLkBGMqf25jfcexeCXzBO5_4Cu-Lfhg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0053.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::27) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|PH7PR12MB7164:EE_
X-MS-Office365-Filtering-Correlation-Id: 357ffb44-7d30-48c7-02fd-08dedd1b3d8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|18002099003|56012099006|3023799007|4143699003|5023799004|11063799006|6133799003|22082099003;
X-Microsoft-Antispam-Message-Info: ShuJxw7Dlf5/WdBEN3GAXnoEiCQu16mQo8AWB1GaU59KRPOt1Poi2txUm0zY2xFYJY41QhKDs/8brUuHwoUc6qwNpJKGiO3w/epyVmX6BFG8ti1dMoVZfDQejFmGg7lPGDiBK4MuYh593rlW5GBUUWPb/Uxzit9WS9cKjK8ZW5G2ycXvzXKZLW/ChVRGk5eO6nkIBvOHFBnMsCuigca4gHUgPNWTRcKBhEo0rPs2Cc8R9Tou8tqxn+HhAmiTkJTt4SRHR6R1Zn2cthP579Q5g7XZiHQwpbkyyxzJ9yI52ashL2iHCnmb2UVIeBSXPiBuwsCCZi6EnLreMGZUOhVaZKg/1eq/Hl3wfvnuZrnvK2fmMFmGMVQ+tdMwcjmxAQZjfoAmdSGIfL2L9KAZSPagXSVm6kBbVXCCM0kgaWVedbanbWOy6F3QbXY0SU9Z78Bb9WRNFAUKnzTBGGP32/FI2ZiMUKUFi1fb8ZreNMiP5qtjG0ktXh5dPlf+CuF6+M28erbYJtugXEyBQkwarTynlACWbo4Qr/v5LfNSVYpsTazlENIUXGhX3cqijswCFu8PEXSypgbMsHYm+QoEd3BSokJeQjY8eR3U0e+4qq8ZOZFyeGz1ojowBcZfTPzMnA1R4HzKjLsjkmFJKXK21ZJLup3derAWlxW5xp+ssNf8nJE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6914.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(18002099003)(56012099006)(3023799007)(4143699003)(5023799004)(11063799006)(6133799003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Unh6L0VtVlQvT09qb0V5RjFVdEE2OHBWblBaVjJSU1A2QUkyZnNYU1JnNXYw?=
 =?utf-8?B?dGhsVkdFYkkwb1QwSDVxTlErRk0zWG5qTzUrc3hBM2lyK2F2RjdQWlFlOUxM?=
 =?utf-8?B?QXYrMXZ6bkx1dnRtNmtQMW9ad0lUNllEbDZTbUIwMzQzYk10dmJ3TXhiQ0dN?=
 =?utf-8?B?a3dRNDUrMnoxL1QyWm5JczNZN2phZTROMUZwczhHR3MwT0kydEluVXhpaHRk?=
 =?utf-8?B?MEdUQjV0RlRJOGxvRXI5bmEvdUJEMU5LbTFrYjJ5WUdJSjk3ZGlDSUREWHpw?=
 =?utf-8?B?OWp4MTdSQTc5Q25oVUlzeFZRdjc0RjJ2OEkwLzBUZW1OaUc4M1YwbElpaC9o?=
 =?utf-8?B?M2dUUjhJMXFvUDN1NFhTd3VaMWlQSFBDNTBybmtVN0JXY0FUVEc0VVlOVkM4?=
 =?utf-8?B?bG15RUdmRnA4RHRCeWROVGxiTXorN29sSXFUcGliU2dNMmZzNzVOZGlYYlVX?=
 =?utf-8?B?bkNPcFVCNm9Dbzg1dU9MUTZIYnR6ZjNDQXczandJcmdGazg1NVZ2UU9qb1Ar?=
 =?utf-8?B?ZktkZGl0ZDV2QzcrM1BUOEtSRTY5RnhIOEFra2NjczYrRjNnU0xQUjZ6ajRn?=
 =?utf-8?B?eGtEZmFmVFhPT0xUY3orMzhEZ2NOeDIxTUJGUEE4YTdRYWg3blpYY0NScW1r?=
 =?utf-8?B?RE1ITzYxaHhqWkR2ZUJudGxzWHpmc0EzTE5BWTd1Z3c0RmJRek9yY1dnZllG?=
 =?utf-8?B?VnZTY1crWWs2TjliTUVUM1VvWlkzWEk5WDE4bXNlR1dQRDNUM0N4MVpLQWxy?=
 =?utf-8?B?OWNwSmZ0SDVVNzRldkd5Z3MvWDBnNk5pV0NnTGg1czRRL25reERrNXZacmNV?=
 =?utf-8?B?a09KU29yU2FzZVNuWW9jMU1McGxCYjNOcTRsRGVTczFKUjJhZUpsWStBU013?=
 =?utf-8?B?V3RiejlPMk9Cb2lmZ09uMjlXbFB2YWtreFpFWE0vSTY2N3R5RXN5N2FyV0FU?=
 =?utf-8?B?VUtuZ0F3Ry9WNVhTV29QTDNLcjZ3Z1ZZQ3M5YUxGN0Y2NXlCZDNjUmJHblhx?=
 =?utf-8?B?Mk5jaGlMNE1xRnF0UGpjUHF1NG9zMy9RK2lyV3g1OEVsc1FqMFVTeE9oamtD?=
 =?utf-8?B?N1BpczNlQVdIK1NyRW5Ra0FaY2dMSml5MHR2TENKU0tzUlc3dkVYWFBDbVRz?=
 =?utf-8?B?Wm05NXdaQVdyM0tQd1ZJT3lsUmVrZzRXemFJM0pCbVpvMENnRmxnejhaVHZU?=
 =?utf-8?B?ai9RNE0yb1VOVXFvYVVLVTc3ZklJWUpkc2xsY0I1aVgweVYwT3NPeU15MFNy?=
 =?utf-8?B?SmxvL2tUOS9MTkMyQ0VqRkZpcVB2Y1B0VFkwQ3FHc2k5MVZTK2VuL3BONlRv?=
 =?utf-8?B?ZmkwTmJpNFM5VnNrQkFvVU5xOTNmaDVJb2tMZUJUR1N6ditKWWJYRmNLUU9E?=
 =?utf-8?B?M1BJcSt3RDNuWjRwNzZvZ1BRbU1BV0drS2tiUWVRK0FPZWhDcTF0VUx1dVhB?=
 =?utf-8?B?V0RBRzZwQngyMVI2SllJbTNNNkw0QzM4WllXbkRLTGV5bnk3VGkxZ2loOWNQ?=
 =?utf-8?B?YmJuRktQcTgxQ2U2WGlKWVhFSzZnY0NNb1BZMkljS3FLeEFzMFpBam9ESnBB?=
 =?utf-8?B?TzdjN1ZGb2p2eWMwVFZETjlpZnN0RWp0WU9UL2tUNzh4aW8wYTNKdytGOHB4?=
 =?utf-8?B?eUdudTZ6S3ZUMXFNa2p5bVBsbHhxTzRJU0xnUVdzWW9VamlqblJWd0JXd2xw?=
 =?utf-8?B?cGZ6bEo0TXUwVUtkMCsvSTN4Ty8rWGJhczlLL1J3SlUyNFBtb0JFRkpBSmF2?=
 =?utf-8?B?ejNJY2JnVFlUVmJzbEhMUm1CcElkaDUxdG1VUW02dnhkejRjZ0R2aVNhSWxs?=
 =?utf-8?B?UVA5NGNtc3lEaDUzRVRMVDNtdTREc2hQVTk1UnVFbk51VTFWTzUwWkljK2F4?=
 =?utf-8?B?TWtITVN1RTVrVStId3FtdDZaWGFZdm9icHVEK0hMaTBMZjdGNE10cmpFckVP?=
 =?utf-8?B?SWNOTUhIb2FETzJkZ1FtcTl5RnZYOVVDL1Z2TnRDczZoZ2FmbWU0LzRIUXhk?=
 =?utf-8?B?Y0R6ajVIUitQZ3lvMkpsVXkzN3k4dHdTd1JZcWhXaXQrckRRV0p1UTZRTlcv?=
 =?utf-8?B?N2haMHNjM1c3cE9CdHNEMGJkMHdkWUFqaXI0cVgxTWxiVXhBK21RTDdmcnFt?=
 =?utf-8?B?YUVjOEFPOGQrYXQvRTVLbmRJdlZvbVhYVTdPemNPdmR5azJIeDhIekRQUkE1?=
 =?utf-8?B?ek9yWTBiOXJFMnZMVWxZbnhrN0xja1lEQ2VZK2VXOG9lSUI3bHJsY3dsK2xC?=
 =?utf-8?B?Zk1vajhFQ3ZyMmF0SElwVVZYUkVoa0pDRWtvck1ZNmxIY0l2bCt1T1pnaDBH?=
 =?utf-8?Q?Uq/3Ipd4YVHl5lVBsG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 357ffb44-7d30-48c7-02fd-08dedd1b3d8c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 18:03:40.1180 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XLeyVD/7sbg8Q9WBGn62leyjm8l6FHNszVLjCdQk6CmmOFDGKtpRITVkpDFnastPoBfAR3hDvoBMyDOT6t+LFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7164
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



On 7/8/26 13:02, Alex Deucher wrote:
> On Wed, Jul 8, 2026 at 1:59 PM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>>
>>
>> On 7/8/26 12:52, Oz Tiram wrote:
>>> Hi Mario,
>>>
>>> Tested on 7.2-rc2 with your patch applied. The mismatch condition is
>>> unchanged from 6.18.35:
>>>
>>>     amdgpu 0000:0b:00.0: VFCT bus number mismatch: table 106 != runtime 11,
>>>         matching by device identity (vendor 0x1002 device 0x1900)
>>>     amdgpu 0000:0b:00.0: Fetched VBIOS from VFCT
>>>
>>> Both GPUs initialise fully with your patch.
>>>
>>> I also tested 7.2-rc2 without pci=realloc,assign-busses to check whether
>>> the pci/realloc changes fixed the dGPU probe failure. They did not -- the
>>> dGPU still fails on 7.2-rc2:
>>>
>>>     amdgpu 0000:03:00.0: Fatal error during GPU init
>>>     amdgpu 0000:03:00.0: probe with driver amdgpu failed with error -12
>>>
>>> Without the kernel argument the iGPU sits at its POST bus (0x6A), VFCT
>>> matches directly, and it works fine -- but the dGPU is unusable.
>>> pci=realloc,assign-busses remains necessary for this machine on 7.2-rc2,
>>> which means the VFCT mismatch persists and your patch is still needed.
>>>
>>> Thank you for not giving up on me so quickly!
>>> This is my first time working on such issue. It feels
>>> daunting to modify kernel code.
>>
>> OK, in that case I will clean up and post the patches shortly.  You'll
>> be able to use them for a workaround if everyone else is aligned.  The
>> part I'm worried about with these is how they would interplay with a
>> system with multiple of the same GPU.  But I don't believe we would be
>> fetching VBIOS from VFCT in that case most likely?  Not sure.
> 
> It's allowed by the spec.  A number of apple systems use VFCT for
> multu-GPU systems with the same GPU.

But then what happens with the bus numbers?  They all need to be on the 
same bus?

> 
> Alex
> 
>>
>> We really shouldn't have to set pci=realloc,assign-busses on a design
>> with all internal PCIe devices.  We should adjust resource allocation
>> code for this case.
>>
>> So please start another another thread with the linux-pci mailing list
>> on this issue, include a full dmesg showing what happens when you don't
>> add the parameters and then what happens when you do (feel free to
>> include/reference this patch in that thread too).
>>
>> If you want to use one, this is the kind of thing an LLM with access to
>> a kernel checkout and both those dmesgs might be good at helping to
>> propose a draft for a solution to the resource allocation code too.
>>
>> You can CC me on that linux-pci mailing list submission, and we'll see
>> if we can come up with a better solution for you.
>>
>>>
>>> Oz
>>>
>>>
>>> On 7/8/26 18:39, Mario Limonciello wrote:
>>>> On 7/8/26 11:35, Oz Tiram wrote:
>>>>> Hi Mario,
>>>>>
>>>>> The GPU is internal. It's an AMD RADEON PRO W7800 48GB.
>>>>> The kernel is built from gentoo-sources-6.18.35.
>>>>>
>>>>> I will test the latest sys-kernel/vanilla-sources (7.1.3) and let you
>>>>> know.
>>>>>
>>>>> Best regards,
>>>>
>>>> Thanks. Can you please test 7.2-rc2?
>>>>
>>>> I'll clean up the workaround and propose it for review in parallel.
>>>>
>>>>>
>>>>> Oz
>>>>>
>>>>> On 7/8/26 15:13, Mario Limonciello wrote:
>>>>>>
>>>>>> On 7/8/26 08:10, Oz Tiram wrote:
>>>>>>> Hi Mario,
>>>>>>>
>>>>>>>   > If you drop that - does this notice still come up?
>>>>>>>
>>>>>>> No, the notice does not appear without pci=realloc,assign-busses.
>>>>>>> The iGPU  stays at its POST bus (0x6A = 106), VFCT matches
>>>>>>> directly, and it fetches the VBIOS without any mismatch.
>>>>>>>
>>>>>>> However, dropping the kernel argument is not an option on this
>>>>>>> machine:
>>>>>>> without it the discrete GPU (0x7449) fails to probe entirely:
>>>>>>>
>>>>>>>     amdgpu 0000:03:00.0: amdgpu: Fatal error during GPU init
>>>>>>>     amdgpu 0000:03:00.0: probe with driver amdgpu failed with error -12
>>>>>>>
>>>>>>> The firmware BARs cannot be mapped without resource reallocation, so
>>>>>>> pci=realloc,assign-busses is required for the dGPU, which in turn
>>>>>>> reassigns
>>>>>>> the iGPU to bus 0x0B and triggers the mismatch your patch resolves.
>>>>>>
>>>>>> Got it; thanks for clarifying.  I would like to dig a little bit
>>>>>> futher into that though.  What kernel are you finding this behavior
>>>>>> and can it still reproduce with 7.2-rc2 if it's older? There was a
>>>>>> bunch of pci/realloc changes that happened in the last cycle that
>>>>>> might have helped this.
>>>>>>
>>>>>> Also; is it an eGPU (external) or dGPU (internal)?
>>>>>>
>>>>>> If it's an dGPU IMO this is arguably a BIOS issue that not enough
>>>>>> resources were applied in the first place.
>>>>>>
>>>>>> Thanks,
>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> Thank you,
>>>>>>>
>>>>>>> Oz
>>>>>>>
>>>>>>>
>>>>>>> On 7/8/26 14:55, Mario Limonciello wrote:
>>>>>>>> Hi Oz,
>>>>>>>>
>>>>>>>> On 7/8/26 07:36, Oz Tiram wrote:
>>>>>>>>> Hi Mario,
>>>>>>>>>
>>>>>>>>> Tested on a Morefine MNAS X1 AI Workstation (AMD Ryzen 7 Pro
>>>>>>>>> 8845HS / Radeon 780M iGPU) with pci=realloc,assign-busses.
>>>>>>>>>
>>>>>>>>> The VFCT entry for the iGPU has PCIBus=106 (0x6A, recorded at
>>>>>>>>> POST) while the
>>>>>>>>> runtime bus is 11 (0x0B). Your patch fires exactly as expected:
>>>>>>>>>
>>>>>>>>>     amdgpu 0000:0b:00.0: amdgpu: VFCT bus number mismatch: table
>>>>>>>>> 106 ! = runtime 11,
>>>>>>>>>         matching by device identity (vendor 0x1002 device 0x1900)
>>>>>>>>>     amdgpu 0000:0b:00.0: amdgpu: Fetched VBIOS from VFCT
>>>>>>>>>
>>>>>>>>> The iGPU initialises fully and drives the framebuffer.
>>>>>>>>>
>>>>>>>>> One minor nit: the dev_notice format string ends with \\n (two
>>>>>>>>> characters) rather
>>>>>>>>> than \n. The resulting kernel message has a literal "\n" at the
>>>>>>>>> end. Same issue
>>>>>>>>> exists in the nearby "too short #2" dev_info -- not introduced by
>>>>>>>>> your patch, but
>>>>>>>>> might be worth cleaning up.
>>>>>>>>>
>>>>>>>>> Tested-by: Oz Tiram <oz@shift-computing.de>
>>>>>>>>>
>>>>>>>>
>>>>>>>> Thanks for confirming.  Before I split up this patch and post it
>>>>>>>> in smaller logical pieces can you confirm my proposed root cause
>>>>>>>> is right that this issue happens because "pci=realloc,assign-
>>>>>>>> busses" was on your kernel command line?
>>>>>>>>
>>>>>>>> If you drop that - does this notice still come up?
>>>>>>>>
>>>>>>>> Thanks,
>>>>>>>>
>>>>>>>>> On 7/6/26 02:56, Mario Limonciello wrote:
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> On 7/5/26 14:10, Oz Tiram wrote:
>>>>>>>>>>> Hi Mario,
>>>>>>>>>>>
>>>>>>>>>>>     To make sure I understand correctly: are you suggesting that
>>>>>>>>>>> the bus
>>>>>>>>>>>     number in the VFCT was legitimate at BIOS POST time, and that
>>>>>>>>>>>     pci=realloc,assign-busses is what changes it at runtime,
>>>>>>>>>>> causing the
>>>>>>>>>>>     mismatch?
>>>>>>>>>>
>>>>>>>>>> That's what it sounds like right now.  You can easily drop all
>>>>>>>>>> the superfluous kernel command line optiosn and see.
>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>     I'm not familiar enough with the PCI subsystem to know the
>>>>>>>>>>> right way to
>>>>>>>>>>>     implement that — could you point me in the right direction?
>>>>>>>>>>
>>>>>>>>>> Well there's a variety of ways to do it.  But how about we start
>>>>>>>>>> here - if we make that specific busnr match optional and instead
>>>>>>>>>> make a VID/DID match.
>>>>>>>>>>
>>>>>>>>>> See if the attached patch helps.
>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>     Oz
>>>>>>>>>>>
>>>>>>>>>>> On 7/5/26 20:37, Mario Limonciello wrote:
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> On 7/5/26 05:04, Oz Tiram wrote:
>>>>>>>>>>>>> APUs (e.g. AMD Radeon 780M / HawkPoint, PCI 1002:1900) have no
>>>>>>>>>>>>> dedicated VBIOS ROM chip.  amdgpu_get_bios_apu() attempts
>>>>>>>>>>>>> four paths
>>>>>>>>>>>>> before giving up:
>>>>>>>>>>>>>
>>>>>>>>>>>>>     1. ACPI VFCT table
>>>>>>>>>>>>>     2. VRAM BAR read
>>>>>>>>>>>>>     3. ROM BAR read
>>>>>>>>>>>>>     4. platform BIOS
>>>>>>>>>>>>>
>>>>>>>>>>>>> On some systems all four fail.  The specific case motivating
>>>>>>>>>>>>> this patch
>>>>>>>>>>>>> is a hybrid graphics machine (dGPU + APU) where:
>>>>>>>>>>>>>
>>>>>>>>>>>>>     - The VFCT table contains the iGPU entry but with a stale
>>>>>>>>>>>>> PCIBus value
>>>>>>>>>>>>>       from BIOS POST time (0x6A).  When the kernel boots with
>>>>>>>>>>>>>       pci=realloc,assign-busses, PCI bus numbers are
>>>>>>>>>>>>> reassigned dynamically
>>>>>>>>>>>>>       and the iGPU lands on bus 0x0B at runtime.
>>>>>>>>>>>>> amdgpu_acpi_vfct_bios()
>>>>>>>>>>>>>       matches entries by bus number, so the entry is never found.
>>>>>>>>>>>>>     - The VRAM BAR is unmapped at probe time.
>>>>>>>>>>>>>     - The ROM BAR is zero (PCI firmware did not assign it).
>>>>>>>>>>>>>     - No platform BIOS mapping exists.
>>>>>>>>>>>>>
>>>>>>>>>>>>> The UEFI GOP driver initialises the iGPU successfully for
>>>>>>>>>>>>> early display,
>>>>>>>>>>>>> confirming the hardware is functional.  The VBIOS image data
>>>>>>>>>>>>> embedded in
>>>>>>>>>>>>> the VFCT is also valid; only the PCIBus metadata is wrong.
>>>>>>>>>>>>
>>>>>>>>>>>> So the BIOS on this machine is actually totally fine; it's
>>>>>>>>>>>> just when the kernel is booted to reassign busses there is a
>>>>>>>>>>>> problem?
>>>>>>>>>>>>
>>>>>>>>>>>> In that case; why not detect the kernel was booted this way
>>>>>>>>>>>> and keep track of the original bus number when reassigned to
>>>>>>>>>>>> avoid the issue?
>>>>>>>>>>>>
>>>>>>>>>>>>> The firmware
>>>>>>>>>>>>> file can be extracted directly from the VFCT using dd:
>>>>>>>>>>>>>
>>>>>>>>>>>>>     dd if=/sys/firmware/acpi/tables/VFCT bs=1 skip=$((0x68))
>>>>>>>>>>>>> count=16896 \
>>>>>>>>>>>>>        of=/lib/firmware/amdgpu/1002_1900.bin
>>>>>>>>>>>>>
>>>>>>>>>>>>> (0x68 is the byte offset of the VBIOS image after the ACPI
>>>>>>>>>>>>> table header
>>>>>>>>>>>>> and VFCT_IMAGE_HEADER; the image length 16896 comes from the
>>>>>>>>>>>>> ImageLength
>>>>>>>>>>>>> field in VFCT_IMAGE_HEADER.)
>>>>>>>>>>>>>
>>>>>>>>>>>>> The driver then prints "Unable to locate a BIOS ROM" and
>>>>>>>>>>>>> refuses to
>>>>>>>>>>>>> bind, leaving the APU completely unusable under Linux.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Add a fifth fallback: request a firmware file named
>>>>>>>>>>>>> "amdgpu/<vendor>_<device>.bin" (e.g. "amdgpu/1002_1900.bin") via
>>>>>>>>>>>>> request_firmware().  This allows a VBIOS image extracted as
>>>>>>>>>>>>> above to be
>>>>>>>>>>>>> placed in /lib/firmware/ and makes the binding succeed
>>>>>>>>>>>>> without patching
>>>>>>>>>>>>> ACPI tables or BIOS.
>>>>>>>>>>>>>
>>>>>>>>>>>>> The fallback is only reached if all existing paths have
>>>>>>>>>>>>> already failed,
>>>>>>>>>>>>> so there is no regression risk for boards where VFCT or ROM
>>>>>>>>>>>>> BAR work.
>>>>>>>>>>>>
>>>>>>>>>>>> What happens if the VBIOS changes in another way one boot to
>>>>>>>>>>>> another? You might have some other stateful information that
>>>>>>>>>>>> isn't updated.
>>>>>>>>>>>>
>>>>>>>>>>>> The whole thing to me feels like a hack for a behavior we can
>>>>>>>>>>>> control in the kernel when doing reassignments.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Signed-off-by: Oz Tiram <oz@shift-computing.de>
>>>>>>>>>>>>> ---
>>>>>>>>>>>>> v2: Fix commit message: clarify that VFCT contains the iGPU
>>>>>>>>>>>>> entry but
>>>>>>>>>>>>>       with a stale PCIBus from BIOS POST that mismatches the
>>>>>>>>>>>>> runtime bus
>>>>>>>>>>>>>       number assigned by pci=realloc,assign-busses. Explain
>>>>>>>>>>>>> that the VBIOS
>>>>>>>>>>>>>       image data is valid and document the dd extraction
>>>>>>>>>>>>> command and byte
>>>>>>>>>>>>>       offsets.  Note that the UEFI GOP driver initialises the
>>>>>>>>>>>>> iGPU
>>>>>>>>>>>>>       successfully, confirming the hardware is functional.
>>>>>>>>>>>>>
>>>>>>>>>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 23 +++++++++++++
>>>>>>>>>>>>> ++ ++ ++ ++++
>>>>>>>>>>>>>    1 file changed, 23 insertions(+)
>>>>>>>>>>>>>
>>>>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/
>>>>>>>>>>>>> drivers/ gpu/ drm/amd/amdgpu/amdgpu_bios.c
>>>>>>>>>>>>> index aa039e148a5e..86064c753b09 100644
>>>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
>>>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
>>>>>>>>>>>>> @@ -26,6 +26,7 @@
>>>>>>>>>>>>>     *          Jerome Glisse
>>>>>>>>>>>>>     */
>>>>>>>>>>>>>    +#include <linux/firmware.h>
>>>>>>>>>>>>>    #include "amdgpu.h"
>>>>>>>>>>>>>    #include "atom.h"
>>>>>>>>>>>>>    @@ -457,6 +458,28 @@ static bool amdgpu_get_bios_apu(struct
>>>>>>>>>>>>> amdgpu_device *adev)
>>>>>>>>>>>>>            goto success;
>>>>>>>>>>>>>        }
>>>>>>>>>>>>>    +    {
>>>>>>>>>>>>> +        const struct firmware *fw;
>>>>>>>>>>>>> +        char fw_name[32];
>>>>>>>>>>>>> +        size_t fw_size;
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +        snprintf(fw_name, sizeof(fw_name), "amdgpu/
>>>>>>>>>>>>> %04x_%04x.bin",
>>>>>>>>>>>>> +             adev->pdev->vendor, adev->pdev->device);
>>>>>>>>>>>>> +        if (request_firmware(&fw, fw_name, adev->dev) == 0) {
>>>>>>>>>>>>> +            adev->bios = kmemdup(fw->data, fw->size,
>>>>>>>>>>>>> GFP_KERNEL);
>>>>>>>>>>>>> +            fw_size = fw->size;
>>>>>>>>>>>>> +            release_firmware(fw);
>>>>>>>>>>>>> +            if (!adev->bios || !check_atom_bios(adev,
>>>>>>>>>>>>> fw_size)) {
>>>>>>>>>>>>> +                amdgpu_bios_release(adev);
>>>>>>>>>>>>> +            } else {
>>>>>>>>>>>>> +                adev->bios_size = fw_size;
>>>>>>>>>>>>> +                dev_info(adev->dev, "Fetched VBIOS from
>>>>>>>>>>>>> firmware file %s\n",
>>>>>>>>>>>>> +                     fw_name);
>>>>>>>>>>>>> +                goto success;
>>>>>>>>>>>>> +            }
>>>>>>>>>>>>> +        }
>>>>>>>>>>>>> +    }
>>>>>>>>>>>>> +
>>>>>>>>>>>>>        dev_err(adev->dev, "Unable to locate a BIOS ROM\n");
>>>>>>>>>>>>>        return false;
>>>>>>>>>>>>
>>>>>>>>
>>>>>>
>>>>
>>

