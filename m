Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3E8606A322
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 09:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=PdpgmCJe
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F4041126BC;
	Fri, 30 Oct 2026 09:23:39 +0000 (UTC)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012059.outbound.protection.outlook.com
 [40.107.200.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D31891126BC
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 09:23:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gxIjaMCvZYA2Bvn1Wy0Ym+0ETV8wOznf861XMHj9IJQXPMjiOmc6c41F5MSPwoPAA7eT9TBJ70GKajDmMIXgp43mQh9NyoiODnT/vATD1bP8LY6YxOUXzSYi1PqTQcikFsU9mcsXzXAX1QBjvywAfJZzo0ZSD6QggB/1wEvB84xOjSx3rnzslXvjdnWmT6LIHzaXbrgyiOPeEccrUW/fHFHtbv6zC+b0QaI3CWl4vZAHSJfXzHKBjNHJmK/nbK+pCQx5PLeA5dfGuW3CVajuFJXxyemuLR7OcqVAq441EAgGN6AxOmlbe2LtRP0fo9OK8bb6EjPK6bviSS8jWBwsEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e49ZIpdacen+euhKghU0zuc7lLWM4WCit6PNxCgSJp4=;
 b=vrEF6IGJR9zs55RpmkFC6iZXF6y7JCxSfeliR6wDM+VZ1CMyP5AZSUE1fVtBP8OQ7cJGLceUppJ6ZQqP4Pui5eqi/oIh0hzL/C+ZMtFJYSNBuq6GJQ853jGxt2hxXHtv1iG6KwYaxfhLDrxOdwqr/G6ZOgoHV8r9/ox2jDSJqxy0kTC0oKCaGK4reKxfR+ey10uy/J/V9UjoJeFwXBQTzqhafgbRmQ3tNWXfQUgaYA0UT8oAsWc5bqJcpRXdf4Qp+dY6HVcSy67bVd7iYG/ppr3/naLhq/daHm2aav8pl1/m0bXOR+I6sO8kkfkN7GUAyEOa9bus70W7w51b7zIHmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e49ZIpdacen+euhKghU0zuc7lLWM4WCit6PNxCgSJp4=;
 b=PdpgmCJe+prfh7JuaqkyDrnVt8UEWuaPYCqwvrVmipvCaewgVc1AJHsZZ6JZMjhl+YUNjPMeYUdHMVUrJNDrkAMZSsa5GqKhStWVriCDzSfWcBdgpbvQx/OWAD1dcpu34cqtiWqKZPi9GO1wSEEOZSGXt9aKhIRh7EPjv3BaTi0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA1PR12MB7293.namprd12.prod.outlook.com (2603:10b6:806:2b9::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 09:23:25 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0546.021; Fri, 30 Oct 2026
 09:23:25 +0000
Message-ID: <b1e52411-e866-469d-943f-87922fd31068@amd.com>
Date: Fri, 30 Oct 2026 10:23:20 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: gadget: f_fs: Remove deprecated dma_fence->ops
To: Paul Cercueil <paul@crapouillou.net>, phasta@kernel.org,
 Neill Kapron <nkapron@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, Al Viro <viro@zeniv.linux.org.uk>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Sam Day <me@samcday.com>,
 Michael Bommarito <michael.bommarito@gmail.com>,
 Gabriel Prostitis <prostitisgabriel@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20261029125143.1744481-2-phasta@kernel.org>
 <7fd62daa875e4a3772e980127d368704a849caee.camel@crapouillou.net>
 <e30a0a03cb7d393cbd88565bf81e156d2f38b293.camel@mailbox.org>
 <304c061aa5fa7f271acfa74c640ab1f0a40e393c.camel@crapouillou.net>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <304c061aa5fa7f271acfa74c640ab1f0a40e393c.camel@crapouillou.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0180.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA1PR12MB7293:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a4fe8d4-1262-4183-9e96-08df36677363
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|23010399003|1800799024|366016|18002099003|22082099003|921020|11063799006|4143699003|56012099006|261026140227099003|261026121527099003|261022105027099003|261022075727099003|261028144727099003|261021121427099003|261021135927099003|10067099003;
X-Microsoft-Antispam-Message-Info: t6PNaQewTFuci7tKS1y8TFdab3Bk3sgPvvdufXLgQDG3KslZuT3z+gmideelasZ8bftEnsIY6DDrEpDplgOp2xsfw1wb8f/K5eS98Mb+HbhNm+DPDi2sUzSDBWoUPKsbpZU9dw3eSFCAye7TlFPJP4Yum5o+v2r9fVVdq7lEyTX2ttzhPK0JPyTbjCDkXxbq9pKuaHYO4n/4uEsJ8g57srbLXTIpX7Lxr6B3Tn9oseNRzlJjnooNxwa1h6MI3gfD4jUohTSP+8sSb+hrVByZY3rob1UejNDwoUeqw76gVC9pw5/h1R6vqzlLWjb+XynAZnQYehhfDmWIeF9Bcocq+dXjMmPR+MP2XplBUGl2VUkRAUebrtwlFzKT2e/qJLXQBv3Nifd1pHzDy0sgxFsv0RblMGMonBCw+ESavyPNU0L0rcL/E286LJ1b45/976IvlqXq2fUZBbK2KPmkgGRHUaBtxSr6w4KEDNPNhRIMKdgqqMjX2k6LP/jwT+3hr61WR52H0LHITB1JWTPruJNs2wBQcDC0iDS+1vKXAOlM9cgmINQ2tWeINvQt4Dpff2YJZfUOP4zkeH9EJHCC2xh6Jpzh5poZ2AB+3NKTkwNqVR536ynzxCfneHeiW8adofOsWmxwaymTYuaSQ2gv+HYFKYp7qM1JOSi43wagESOuUZI8sQlioZFCU/EU5JoMzc2iDxKG2OWDKFpetyB9ahLkJw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(18002099003)(22082099003)(921020)(11063799006)(4143699003)(56012099006)(261026140227099003)(261026121527099003)(261022105027099003)(261022075727099003)(261028144727099003)(261021121427099003)(261021135927099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1Q2ZUtNTDRhRU11RTA5ZUtVeDhQSlp3ekRsR3BzeXlwUzRmNDdtdExKVXFv?=
 =?utf-8?B?T3RlZWxnMENxa28yZ2RxcU5uSUlYNVU4TUx6VHExajJGaXgwT0Y4RGFXTjBO?=
 =?utf-8?B?QkY0NTZxVWw1dWtGWS9yYUtMM1BQS0dLUm1HT3B3QjFKQTJFYmNEYlNmdEJm?=
 =?utf-8?B?dzhoaWZyNlRKa1ZVclVDTDNHVnBObitMbCtXR2Z0a3FvQmhONGxxeGt0Vmg5?=
 =?utf-8?B?SGFEV3hMaE9TZUw1R1ljaEZ0T0wxbFllcDFKMk9iODVGU1pKdlpGWlF3OWNo?=
 =?utf-8?B?NmhGZ0dkOHhiNTRSTXpCcEczN1Q5RjAxOTlqOEhaV1VuUmJCYWV6Z1NTK1pK?=
 =?utf-8?B?TE55cFA3Z0k0Sm02ZDNlTWxodHJKQWZFM2Ivcms0T1VCa25NdHRiL2VMQ0hj?=
 =?utf-8?B?aCtuY0tzWitDblUxMGprQ2EwczlIWG9OekU3YmtqUDRvV2RqNnNDY1hXN3Rh?=
 =?utf-8?B?Vk1mQXdlV04xbFE0cEJTK2J1RVV4UEh2WmV0dVpYVTkxZVNPMmNJQ2hLZUFZ?=
 =?utf-8?B?UFY3MmVsRmlrRUFoZFZaa2RaVUx2MFdhTTRuRVl4aHZiaC9Kem1SeVg2V2RM?=
 =?utf-8?B?SUhSU0dtaUJSUkpBMXlRRjR4UE0vdWpnMSs4c3grOGdJdWVpT3ZsRnJrM2Fv?=
 =?utf-8?B?S2JZRWNadCtrSStkWXF1SURyN0lzYWRuWUxqTkljNlZ1blYwdkhCWkJsU2U0?=
 =?utf-8?B?ZVZBV3IwbE8yNW1DZlVnckxWUUJpaHI2dmwrdVZ6U2F1bDhVMHlEZ0hLdjRq?=
 =?utf-8?B?RzNDR2kvazIrRHhvNnM0c2YwT2ZPUHFPU2tiOTNMdFJNbjRsWmxwOGdpbjBs?=
 =?utf-8?B?bUF2Z3NFR1JXaExtNkYwOUFha0dSS2NnWGlEcTdWRllMZllZM3hVSjR3dUNr?=
 =?utf-8?B?L2RlVG5nd21lSEZwVTdtcW05ejlHeVJxQW9KSFN5U29sRlBLNEN0a2NtdlNW?=
 =?utf-8?B?VG91UDNCaWYvM2plbjZrZlQ4QVdBU3dKTVdic2JDcFd4eUtzT1VSVTZ2N1VL?=
 =?utf-8?B?RlZYVzhjRUhEVnl6Yys0R0tHUFlsY0hFM2VIamcxWnVlcHRySTNFSVhUOFlW?=
 =?utf-8?B?Q3JObU8zcUlMTDlPWjlVNlA1aVQ0OEpzVEMxbVFaVWQ5U1RuczRLRVZoRkht?=
 =?utf-8?B?ajVBVlBIREREZ3d6REJRWmI5VE9NQ3hFdnV0LzY4S045ejljYmZJYVk1RUow?=
 =?utf-8?B?M0pudHVkRDZOeVVJbnNSdXFVa25NWER0MnI3Z09IelFNZjFZS0JndnRvVjh0?=
 =?utf-8?B?dnlnT1Q5Z3lFZ1dCZWpIMHQwd29pN0pTTTYxd0dhL0c2bndiM21pSUhXTnlh?=
 =?utf-8?B?b1RjaVN3MHZ2RTIrS0hFdXE3L0NXNzVFUWw3ampqbThQTlh6eUFjWG1YQXFh?=
 =?utf-8?B?dlF4ZGlzNDJYT0RpVUJLUGdaTTF3MzBWOGpoVzJNZkp0VVRudm5KbFhhZ0pO?=
 =?utf-8?B?ZTVFTGFNQzVrYS8yYUtQYXRWNVE1dExZK3lJUUprMThFaGY5d080V3BLcERJ?=
 =?utf-8?B?ejBzMGIrRmsrQ2FIVHVQeGxQV1JVMDV3bVArdTNYY3VITXpEWFdhWW8yN09C?=
 =?utf-8?B?eGpYenZGejRaalpPbzhQZ015eXJ6UmRnKzU2WXVoVmovT0dkM2JIRGJPSU0v?=
 =?utf-8?B?RTh3SzJSdUlzcnJJUHBJUGhNQkFMcWlpSXRmamlvbFZBWGdObExyVnhqK2tP?=
 =?utf-8?B?aGZsTHE0dGdzY0htVUVzUnRpY1p3aEt4WHI0dGNkd2dCU3d0RW82RC9EeEha?=
 =?utf-8?B?c3VYS3EzQjJmejNVUnVZREFNd1JBSFdvS2V4eXVGMmVLRUl6NEQ1WG1mT0Fi?=
 =?utf-8?B?M20wNVFzSE9jdVg5Q29aeHd0LzdYNmFZVEZlaGl6QUpib2NBSFBQY0ZVM3dP?=
 =?utf-8?B?ZHJJNnVHM1pBSVdLZWVPRFcvUXdPcVlUQzJZYm9zSnVSMDduekJtclY2c1Jq?=
 =?utf-8?B?VlJQUVdmckFSTWpHNGRwdlZ1dUlLVTlBQWw0TWprVERHWjJlOHBFeFBrNDdW?=
 =?utf-8?B?Z1RsM2Y2SjZGSHBCaHVDMEdPL01Yc3RQYVp4NlZnR3NyMG41UDg4YlJ0RDk4?=
 =?utf-8?B?NFhuSWU2c3BZbCtiaEY4N0FlT1c1L3FuZG9iYVJtQlp5cTFGeVVpb1RDZjEz?=
 =?utf-8?B?ZlRYWVYzQWRXcmhRN2VnYmpWVUpOOVdMZnpZcEJRYk5qY0YreUIxdk9pdWUw?=
 =?utf-8?B?ZTB6cG5zUjBUcEwvdHBtTXFDYVoxNjdaN2R1VTVNVVBrNDlaZnJQaFowUVJt?=
 =?utf-8?B?aTA5TVlJRFpmaEtRZGlyZGM3ZEMrdFNHRnBJd0R4dkRnajFlcHhIaFhWVWYy?=
 =?utf-8?Q?w6yAKbrhwB6E+DnAMb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a4fe8d4-1262-4183-9e96-08df36677363
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 09:23:25.6584 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tvrutkKmtGg8UVN3DKr2y8vvgSjqC8yN+M/Bj9Lvxys1MNzqnS7XHkrQAKBsvBM2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7293
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

On 10/29/26 15:18, Paul Cercueil wrote:
> Le jeudi 29 octobre 2026 à 14:49 +0100, Philipp Stanner a écrit :
>> Hi,
>>
>> On Thu, 2026-10-29 at 14:19 +0100, Paul Cercueil wrote:
>>> Hi Philipp,
>>>
>>> For context, this .release() callback was added to avoid the implicit free
>>> of
>>> the base class, which IIRC was a request I got during the review process of
>>> this
>>> change set.
>>
>> Can't say anything about the request you got, but fences are reference-
>> counted and the ability to free itself exists since at least
>> 3c3b177a9369 (2014).
> 
> Yes, it already existed when I wrote the code and I was requested to make it
> explicit. Not trying to make a point here, just stating the reasons why it was
> written that way.
> 
>> From dma_fence's perspective it's certainly the desired canonical
>> pattern since the release() ops prevents fences from the important
>> feature of decoupling fence producer and consumer.
> 
> ACK.
> 
>>> I'm personally fine with the change, but do we need a "keep this field at
>>> the
>>> top" comment for the base class in the ffs_dma_fence struct? Or what's the
>>> policy here?
>>
>> When I got into the kernel I was told that it's common practice to
>> always have the base class as the first element. That also allows for
>> obtaining the parent class by a mere pointer-cast instead of
>> container_of.
>>
>> But the reality is also that some users are not aware of this rule. I
>> can document it in a v2 if you like.
> 
> Let's wait on feedback from more people. I don't have a strong opinion either
> way.

As far as I know It is indeed common practice , if you want a comment or not on your structure that the base class needs to be the first element or the dma_fence release will break is totally up to you I think.

On the other hand it is maybe possible to provide a dma_fence_alloc_obj() macro which wraps kmalloc_obj and compile time asserts that the member you give for the base class is at offset 0.

Regards,
Christian.

> 
> Cheers,
> -Paul

