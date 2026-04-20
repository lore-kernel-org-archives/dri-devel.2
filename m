Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92A41F5A8C5
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 21:46:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 084F010E1C3;
	Mon, 20 Apr 2026 21:46:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="nUEMSzAH";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012071.outbound.protection.outlook.com [52.101.48.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 381AA10E1C3
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 21:46:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tVY3kHAsDbIfh+JjpUJqOV8nJsfPRNmxX7hFndBi8D4RBCdmFyE2bYuT+sWpv+eu6FOL1QCj7OP19XHaKh5bPawp0FdRUl8Uu0W3LobJn8jETL795706qe+bL0dt23kjUMkcStCS1u5i6dd8X+4lGO5YXgKXBYsEQz+h4Ux75NTUDb3PLiWgstJp2tnUVXKtuP5R14ElkVGyCAngoSoTwn4Gy1UFAbupI41RHy3C3CrkJZlYcjSBTP8KaiTSJ+oVyvb0MZHpbEGtanbwnqI8hvB0zD9/44CQ0B0ZD5AmFezf9ArKXvwj2C0PdMlyJOhzrMrbskpm4nw5zkRIfg1Umw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=40dg/orMlf8PELDzBLNO3f/QYSwg9ywOFJYlTjYlyag=;
 b=Ny6PJe37Gvc0/ZjmeIRSP7f8KQ65ymWtgoAI+7XVMW2JlhJj2u11gn2q5jLRt++5jXLbDITwSNzrQWl7T+Rg3F9ngn+YuHVWI92OQz5kcyy0mshYNzj5/jn+1zBogmxQndWLLX0b1y8UMRFHB9FthR716bYkOrmGD5m5iY3duWS1pw2pvM/7l5msiq54EgNuwZrzRuUOlsUxAoJrAAv2rfPGjEemcVYbSFnhvLbYA7Pr0ZZHY61dFZ4VhfEKP9A8f2Zr4gC6fkU3LzXk0wF1BnxhS11PlD6EEG3pmteIsHWohNlqS4NkldXsSmZ923FhU3vtJYZWiq5kcgrZPhNTfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=40dg/orMlf8PELDzBLNO3f/QYSwg9ywOFJYlTjYlyag=;
 b=nUEMSzAHPSvJxSP/sMwnNoHygPn0Z+Hpc2RaxS7kAqZETRz/iwRldon5Us218vz+Kn29tdG1r5jm0NjhQBpRcZbKC0R43snjKixOay+QgrSApXBAwhhen0E6yen4bzTDFSu6qvfBIFy6QSA68OmGDd3nn9uS/WEEt504D3D4B2MQr2qAjjalQlg9VXEJQi17RpUxrj9tkwYCM2p3rWwYuExsgamGpXrtmMPVXumbQoXnHxKS1OXxWiCbKgyrB/B4+D5c0nc/Rqb8QQwin8EhD9ul3k6T4MJHfXwrF9BB37208HZ0lTWCa6hwqq6kbrx1o3ktGPAZZUdiuKOuAUhDfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 MN2PR12MB4437.namprd12.prod.outlook.com (2603:10b6:208:26f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Mon, 20 Apr
 2026 21:46:21 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9846.011; Mon, 20 Apr 2026
 21:46:21 +0000
Message-ID: <e1e869be-a681-420e-8a31-d9857f1c28f4@nvidia.com>
Date: Mon, 20 Apr 2026 17:46:19 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/11] gpu: nova-core: vbios: compute FWSEC-relative
 Falcon data offset
To: Eliot Courtney <ecourtney@nvidia.com>, Danilo Krummrich
 <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Timur Tabi <ttabi@nvidia.com>, rust-for-linux@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260414-fix-vbios-v2-0-705d30d16bba@nvidia.com>
 <20260414-fix-vbios-v2-8-705d30d16bba@nvidia.com>
 <54b13fa0-9405-4fc8-ae41-fd1d310c7aa9@nvidia.com>
 <DHV30FCX4QCU.2QA40VBWESOVU@nvidia.com>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <DHV30FCX4QCU.2QA40VBWESOVU@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN0P222CA0002.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:531::7) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|MN2PR12MB4437:EE_
X-MS-Office365-Filtering-Correlation-Id: cefe2eb4-11d3-4b16-c2da-08de9f2642b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: 5B1SHYsTcuPumK6f1Jp8QEsb0lxo0uCCpN6bCEpeWks/oivIx+2QW8aVHYSMso4XXyNQC91Q36kaDpoGqhPVpffe9LsWvckyWanp+kQyaYVG/gN2ymOgE01HnNCD9mcW5qfIwe2qRytNZJn8IuSOU0ledVPniSmUOVh8eGsr6VmKEit8h+O55F/bn9y6cRm6iBL2CngqSrFpuH4LE7P64bNCQjcD/1IMI0fBrkJZX1IwVXeu7v2M7khSGLqGxZr+Tiga/T3u3GKGU6pNtRXoXKS83yCwHXq9zz8c2GcSYIxVDBZXY3ilS3ystKJaBRmdlDZIX4tWjL7kQgLz/CWrtz1TXCUeDiCZIA/TyeI8dY2yYty/22V3KB/Wj+FVNzMcp0UBXIyYKqPSmWuSOu1e7tHrIpx4vzHsB3aYBZqwxSTqpWDUv4bTRqOeSFy2Hngix8b/r7/ZeGyguaGOgw5d6FIOmErrHyBHKF5Sbm6GX3riupYlKUhK4NcABGwj32JC5ihm11fExCYKeezBDeCeK3PZuvylARGNtty8dhXgF5yj7Xd6mUncEUki6YttYvCGGdas+MWghDIt4Iwel9sDeWfjr26scORM+07MBhL3lN6+0xyVds5K+bmBvjr6ifZvXT75omc9hrhLGmi3P4h2zCcZ/8sk83k8O6a1pu9JUe5XRIqCn3qwxyQeBHMk4hBIHQNu5Q4ZP/VDqK5KRhf2hX+utXKrj/zvRyT03EgDs9I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFVoZ201ZFFnYWhBWkpvYTRqYm1TRDNoUDFHUFJVa1g4eDAzUDFmdG1BcE5h?=
 =?utf-8?B?aUFqUzM1bTdQY1F4TkJ2K2dqVjUzSzFkZEZDdTZLbmNSQVN2UHgzNGhiOWxh?=
 =?utf-8?B?VVhHLzRsbG13emZQTGxZUzM3REppWDdTUllQWTI1SGp6VUVweGE3YnR3Qys2?=
 =?utf-8?B?bng3NmpFejFrZHlqRnRZVmpGSHNKYWhPNmo0K2cra3A0N2lFb3d2cGdhUWZy?=
 =?utf-8?B?WHJsdkgzQ1dTb0h5bU5hb0hVOXhjZEVXcmVPZ3ZZT1A0M0d3WGFMdk1BQm1m?=
 =?utf-8?B?Z09KQU5HYlB0N2RCRi9RTHNBY1V6cE1kK1FTUExOb2c3Y3M5NkhSUGNIM3cv?=
 =?utf-8?B?Sm04UEwzSXJ2dmdaTFA0UkJYNFRwa3hLQ0tsWHhjMEhJNCs0ME9xN3hHNklu?=
 =?utf-8?B?eStoSzFQanE5TThibG5kQmFyWTRzNWw3bUh6OFdUdHYzZTRDZjJUTmJQTk5L?=
 =?utf-8?B?Vjh6NDVBZUpiRloxTEI4Zkp4Z1ZPV3VsamN6L3laSDE1M2lGYVd6Y1h4VUQ4?=
 =?utf-8?B?Rzd0d0w2eHkrejJFQnZqeDFoSHZhQ3pQQ1BuYWhDcDhmL2xVN3IzeE9BS3pI?=
 =?utf-8?B?SU5JYlczMUxjS2ZyYjRPdVdYMjhRRUNwMTZIUUUvNVhSMmZtenkwSkVsbENv?=
 =?utf-8?B?WVd6bXhNenpsVFZLeFVia1NGbmw4bVF2d05qRmdXQlNPcjllc2VER0JqQnBO?=
 =?utf-8?B?aEhUMU8xTjg1Y3dXZjB4N1V5T29haGJLaUpkQ3Y1YTRjcldPRUlsWHFFT0M4?=
 =?utf-8?B?ekxnU0gvZEZ6c09WQ05VU0FPRDJVSS96cGtEZ2E4OFdnbWZtQXZtTTlQbUp0?=
 =?utf-8?B?SmlNZ2I3Y1YwcndBdDJlTm4rNmVxL0NoWEJlVmVtRUlSdVBkeU9ORXk2OXFk?=
 =?utf-8?B?bkM4bzE4V3U1dWhkNXpCR3kybEkzOEdMODdZeWlOWVRSY3g2dU40Y0dtRUVw?=
 =?utf-8?B?NUJuQStDMjZjR3lEMlc3Qm91U3p6Q0VPUGs2NlZTQ1lpY3hZUHFsS2R3SVZq?=
 =?utf-8?B?SXk0clk0ejBTU0R1S2c2V2YrN3VyS3NCMVVVTS9SZFBua1NhQ2xwLzVoNitn?=
 =?utf-8?B?TlFmVkRKSGVEa2pmSk93MkRjMU5aUDMwR3E0clVGWDJPV296MEM1em5qVGsw?=
 =?utf-8?B?cVVCMGEwekZxYnlSYko4OG1uOXJhbkQ5eUFmMWtRVGtwcFJmL3NYQ2ZZcy8r?=
 =?utf-8?B?am1OeFRPa1ZlaGdSeno0bE0zTmpySWtnL1huS1h4Vk1ydG1vUFJ0SWJuQUh3?=
 =?utf-8?B?N1RYZHJZa1NJOTJNY2RManFFaTFSekkzZEJ0MUxJclp1eFRHd1VSa1BzOVNS?=
 =?utf-8?B?NWQzMUpPWVpaTWpXTnJ5b0wxNTRnTkdQa3dKSlYwQjhtVndwZHJIWDUzano1?=
 =?utf-8?B?T3dRdXFmbWZERWNSNW5nMFhiaytYdzhwOTZzM3BsbEIrNVlzY1VLUk8rVFN3?=
 =?utf-8?B?bXlTVlJxSFJHWkVhRVdsdlJhTGNYRlJWU2tvYThueEhHNkpJdHovdE9nWHBz?=
 =?utf-8?B?bzB0TUJJOURSRUlsSHN5KzZyQS9OTVhJQTdZaEVwWUNhWHZwdFZBYmxBeUdq?=
 =?utf-8?B?a2hpeVVhZ2JtZWo3UnRFYXdPeG9EWTIxcjdJTGlNR0hwNUdNUE9kY2dqemdh?=
 =?utf-8?B?YTREaVpJbUNzb1VoNUI3Yk1oUGtjRlR1Y1JFNjAyYVRpUG1NTEJHL0hhd2do?=
 =?utf-8?B?bnYzUTJ3UkMrVWphZUVGd3VteGhWM2h3TDZLeGJkdW8vUC9SVDAxM2ZXc3BE?=
 =?utf-8?B?R3lTSVdjUHNrNHNhV2lnckhscm1LdUNveVpOZWNMV1NyVlpOaXgrUld6K2NL?=
 =?utf-8?B?ZGRhTnlCMXJXWXkwUitKSWwrb1JLSitTWCtENkVOMWRFOWloUVZXQklwejd5?=
 =?utf-8?B?VHJVTk90VXZiYnBTZzB5L2FmZFNNLzRxMlJzSTMxT3dvVTQrWmpOWUVVN1VN?=
 =?utf-8?B?WnZXSUd3NWU4dUVZWFhtSUtKR3QxeExpR0FYRUlyZFlwNmFUSWYraFlCdzVK?=
 =?utf-8?B?aUE4d29UamJxaGZiSjlkSE1WMGcrbHlqSE1qc3ZKVDVQTkdpYkhXdGNpQlIw?=
 =?utf-8?B?RXpCSnpjTG5DRytHZWp4aFlRTHgvRjRFdnpYNmFLeVEzSkRxK1FNVnhuL1dJ?=
 =?utf-8?B?QlRFYzlXV28yQ0dOa1dHVHQ4MUp2R2RNQWlzblNWVU84RVdlYWNGUnN5bnor?=
 =?utf-8?B?NnJObk1raXo3Vld1U0FpQzlJQkdmRGhENy95UlNCKzdCMDNTdWo3ZDRCWmZY?=
 =?utf-8?B?ZmFqb3lkWWJIdGFKaDhLaCt3SmFHWmxNVVZxbDRXNXBlL0lWN1kyL3kzTkZv?=
 =?utf-8?B?L1NyaHRHRFlJcWNIZHNjc0E1M1Q3SjZYOHNSeURBeVJ3MWRxV1FEdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cefe2eb4-11d3-4b16-c2da-08de9f2642b2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 21:46:21.1444 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wvEfUJFTPrEmqgRGg6hKziGQEOmaY/1tNPD6AYq+u8E/q5/vX7E96nPAiKo7ka07j6636AHMMhGpuFuOlVMWsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4437
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



On 4/16/2026 10:41 PM, Eliot Courtney wrote:
> On Fri Apr 17, 2026 at 1:13 AM JST, Joel Fernandes wrote:
>> On 4/14/2026 7:54 AM, Eliot Courtney wrote:
>>> Push the computation of the falcon data offset into a helper function.
>>> The subtraction to create the offset should be checked, and by doing
>>> this the check can be folded into the existing check in
>>> `falcon_data_ptr`.
>>>
>>> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
>>> ---
>>>  drivers/gpu/nova-core/vbios.rs | 48 +++++++++++++++++-------------------------
>>>  1 file changed, 19 insertions(+), 29 deletions(-)
>>>
>>> diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
>>> index 01f65d50cbb3..0c0e0402e715 100644
>>> --- a/drivers/gpu/nova-core/vbios.rs
>>> +++ b/drivers/gpu/nova-core/vbios.rs
>>> @@ -765,33 +765,29 @@ fn get_bit_token(&self, token_id: u8) -> Result<BitToken> {
>>>          BitToken::from_id(self, token_id)
>>>      }
>>>  
>>> -    /// Find the Falcon data pointer structure in the [`PciAtBiosImage`].
>>> +    /// Find the Falcon data offset from the start of the FWSEC region.
>>
>> The comment change is incorrect, this subtraction is just for normalizing.
>> It basically normalizes the pointer wrt the PciAt image.
>>
>> It is only after the following in the caller that we get the true offset
>> within the FWSEC.
>>             offset -= first_fwsec.base.data.len();
>>
>> I suggest, let us rename falcon_data_offset() to
>> falcon_normalize_fwsec_offset() and update the comment above.
> 
> Thanks for your reviews! W.r.t. this, my understanding is that the
> layout is something like:
> 
> PCI-AT | Efi? | FWSEC | FWSEC
> 
> And that the falcon data pointer that we get out of PCI-AT starts off
> like this (indicated by ^):
> 
> ^ PCI-AT | Efi? | FWSEC | FWSEC
> 
> But the actual "address space" it's in is:
> 
> ^ PCI-AT | FWSEC | FWSEC
> 
> Because it doesn't count whatever images are between PCI-AT and the
> first FWSEC as part of that space. So by subtracting the PCI-AT size, we
> convert it to this logical space:
> 
> ^ FWSEC | FWSEC
> 
> Based on the above understanding doesn't it make sense to say that
> `falcon_data_offset` transforms the pointer to be relative from the
> start of the FWSEC region? Once we subtract off the first fwsec image
> length, it's then relative to the second FWSEC image. Please LMK if I've
> missed something. We could also emphasise in the doc that the "FWSEC
> region" means the contiguous region defined by the first two FWSEC
> images. WDYT?

You did not miss anything, your explanation above is spot-on.

You could also keep your function name and add a comment on top of
`falcon_data_offset()`. Something like "offset from the end of PCI-AT
(i.e., the start of the combined FWSEC region)". Sounds good?

thanks,

--
Joel Fernandes

