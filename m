Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06E32CD8CAA
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 14:03:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D37710E444;
	Tue,  9 Jun 2026 14:03:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FJpt+XRl";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012009.outbound.protection.outlook.com [52.101.53.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6E4E10E444
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 14:03:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=drxyKcftM25K4tGQ7c7tRbSlkTANd6EnnqmKUWlPOO73Fnwsxv7kL+i2JHGSRBF8CO5KTVrp7dClWtgDSZfJD179lZoKtzr01mA20xyzavQlW2i57XQINlPiU6YhBt8/xVRutWljH9z6iL1mao8Pclu0fKwQqf0c86X8g3QU7bO5le2rtHE5P4zJmTutZ9RR3f/gk1HK9t7I8x2KgwbWGyabOBCy2su7bWOWwtdQOVEvu8QWaejwNIl0qXyJ4Bh7dQds/WGLRsVWFHsAgcVbRTLwqOWZBrf8cOXZtPK6L7hzy6dgLm9ppQ39LvyEiMBoFONkrMQ0IEd/uPwZlodGqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SPQp16ipUfkxDvXV7pp7ZmJ3jcN+rr5FOgqubToxWNE=;
 b=mc+yPCZk6WT9UIoX3TbBUbmFfEwCDBUh6ZsuawNpiQYWNGolT/P8rGdM1jndPySG1Ci76JVPEWRID9lwNY/9T45pUtVOIajZ2ZsHtHu0qEHyjUm50Ij+6bje4tTIoqRW/IfyFwaeBcTDle3K+sfvvpAoRqKJgZBQH0Un20OP/zz+TxUC6UqKZtzt/otOLrUvsP4arIx2LpfFryH2FGQyMBlDsYRzj3n4zKz0asgNsD2V49bRFU6Lif8bzI4BdZl+oPSTTV50DodHc75FzrBX0q6wkgOFmmz5G5LuYtEeIvnDdBSAGSjN12mRbdjTWbOvdkK+KTheaRHqBCLXB0BEwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SPQp16ipUfkxDvXV7pp7ZmJ3jcN+rr5FOgqubToxWNE=;
 b=FJpt+XRl6FozYr9+vb5hI1PfK9syUJqJMjLRLGm1CJAMexSpt7lei1ag8kPY/t2S5izTHoi4XicQlq0KD+gss0b9cIS0ArGZiq5RGz8pM3mqPPlBp2WmJHWCzFk5kle+wa2UGNZ1F7HmgPa0elhJSBDe/sbNQV58SGzUnXAE33s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB6349.namprd12.prod.outlook.com (2603:10b6:8:a4::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.13; Tue, 9 Jun 2026 14:03:44 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0092.006; Tue, 9 Jun 2026
 14:03:44 +0000
Message-ID: <c5aa9dbb-79b5-4d97-b46f-31c28af0aafb@amd.com>
Date: Tue, 9 Jun 2026 16:03:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] dma-fence: Fix races of fence callbacks versus
 destructors by locking
To: phasta@kernel.org, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Danilo Krummrich <dakr@kernel.org>, airlied@gmail.com
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Alice Ryhl <aliceryhl@google.com>, Daniel Almeida <dwlsalmeida@gmail.com>,
 Gary Guo <gary@garyguo.net>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260608142436.265820-2-phasta@kernel.org>
 <95f4ae6b-9dec-4122-84e0-fbb0cdee9cb5@amd.com>
 <fa9a335196525adbc03ec21b2e05bb526e4fc174.camel@mailbox.org>
 <9d49c901-fcdf-487a-a733-0320d0bdf94c@amd.com>
 <DJ3V3OCLIK2K.3CYKWYNHYU6JQ@kernel.org>
 <ea4e0541-3702-4014-b8f6-0746a148df86@amd.com>
 <DJ3VYD71HDQ2.3C8GG983Z2YCM@kernel.org>
 <c8564ea0-8ff4-4049-996d-bd978c478372@amd.com>
 <aebe759117cd65004510946e39bd02e4c903e1e3.camel@mailbox.org>
 <dbda178c-bf02-448b-a88d-5a094adea5c0@igalia.com>
 <6b7bcc667f294b248f51e890964c707f4545cf92.camel@mailbox.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <6b7bcc667f294b248f51e890964c707f4545cf92.camel@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0010.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::20)
 To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB6349:EE_
X-MS-Office365-Filtering-Correlation-Id: fec05535-59a5-4db2-0cd1-08dec62feaef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|18002099003|22082099003|3023799007|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: 87NLgvqwTgrFZYOL/v9bu9pFrug/AeQU1IyKmj98qCK43vGA9Drx547RRfE5XlaVMYq7RRjeSlBLDSJovkSszG0imWXx/x4FhDmH4UteJ4Ydg1B0xTHt93wQpSszXRfucgnCZsLe1lJAOsWI/S/OwDBPMy/+QlFhHCUHNcUrl9gt3k5xUJyxayn1cT3Muxn7ZGl+kbE4DmpRGlLPxB3ftXgqWnFtne7Zl5ipYhws/Wuu31eS3j4e4A+DaQa1WmmOS8m/H48ZQ/oH+TS5/HOZRb0SVjXlWgTC4VutBd7v4qpvFjrApcXKiPYGyly5h/5IQ0brqDMKQXOy9KTi4N1Pi18pXqMShndyGWKx/M+drkUHlCoRkNZ7KtmTT+6AM9ibl8JdYchoAwsM+pbYpEEnuOfWnPSu95L6S4uEuOeuVE4gVBUId88a4X7IidRNqq9k1UazwMAKyPjtZDHnqdiQ/qEQNBD5QGoPQ4dVoTnLiP3tdiSlkAtTKTHYLfC9U+1cAFkcM3NQCB27vuXBgl3UbJJX0LJRwDFTiDizdzzB1uuGOuoANv6dtcUrTqegr2I+qXiUnj20Aqu99yfeoxGyDji02AOeeVkwKrQ5w6n9VUf541xCWGhmueCPXtb2ZQmtVODgMp4zcPJOJTlNqnZfc7nY+P1Fi9RrgbpqljAtYGrk4RK9+rQ9LabPC+Bh805R
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(18002099003)(22082099003)(3023799007)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXFLUzI4SkVPcXMyTUpzNUZGZFhMV3JDTXRqUGV5NmRhaE9oeVJTd2NaMThq?=
 =?utf-8?B?SjVtcC9WczdUckkrSDFoc1M0aUt5N1RLWTgyOURleFVUSmd0ZGZwRlBma3hq?=
 =?utf-8?B?ZEEzMEhJR3VxY05TT3l5T0dvaHhseXh4Q0dmeUZ1TUoyb0R0d1N6SDcvUjF2?=
 =?utf-8?B?OFUybVRHUzlBQ21OWllOVHVKYVJBWnFIK1NGY1BmS2lyT1YvT0g1My9YeHRw?=
 =?utf-8?B?NW84WEo1U1orYVJvejFBMUROS2JUMVJ6eXdlSXVLbC9WM2xmT2YzOUhiSk1w?=
 =?utf-8?B?TXJBR1pFNW5Pc3ZDMW1yaFJZYnlpUGtQdS9Ka0RDY0RwckU1YnpUd3RTWFpk?=
 =?utf-8?B?czNvVXZTbDJtWE53QWg1UlBnVE93LzdxbHo3OHZpUVNNeUNMcENRM2ZvSWIv?=
 =?utf-8?B?V3lnbWtUWkd1U0hqNnlDSnFpMEMvZlVCTWRtM2VBdmlpLzR0QU5UTm4vRVZN?=
 =?utf-8?B?UzdZWkdCeG5IOHA4eUJ4dDQvc1RDVXJqbFAxWldManBCSHdJZDFCeE1sK29R?=
 =?utf-8?B?Z3p5elU5RTlVVmNZSzlBNTd0Z1N6UGZxSmR1UnM4Qkx6QnREYXErbFpBSGFI?=
 =?utf-8?B?citLR1FtY1RtNnRTak9MUkV1YjVZZ3hCUXprL3l0eTY2M0k5ZHVwUEw4ZHJC?=
 =?utf-8?B?Nks3MHhLcmdXWFhTcGF1Z2IyMmdodko4WHE2RW5NdjUyV2J3LzcwSFB4MFlC?=
 =?utf-8?B?dk53d3NoVnpIdVppcUwrZ0lzaStYaXRwaEVEdkZWdFJRcHVvMmZvYTdFMXRl?=
 =?utf-8?B?R3hGYitLQ1Q4NXNuVWRlbXdoS1pwZHF5M3IzWnFoSHBNVnFIOEE2a1JUUVVk?=
 =?utf-8?B?cWVENzhQV1VtaURrNUdDUzF4S1NlMlU3T2djaXdXM2E2VDVCNGVRQldQd2Uz?=
 =?utf-8?B?VFloWjR4a2RyKzF4NmticXMwR0RlTDBjYWJHalZuYUFCQThUNEk2K0lyMGJI?=
 =?utf-8?B?b1JHRmhBQnhjeGZXTjBFTC9wZ1pIemZ6T2o4a1BuaU5KalNaMWtPZFEzK1c0?=
 =?utf-8?B?L3ZOcVZXQmRjbVBqU2JoQjZIem8xNmY4c081d29zczRJNXg3Q0Y0L2ErSjVI?=
 =?utf-8?B?OXVaTlUrUm9pNzRMZmowMG9VR2JxK0xTa1VmYlB6L1BTRUV5RWp3Qk9xOEo3?=
 =?utf-8?B?aW9HbUtiRkkwaUJ0ejJUTTRjYTRpdEVEaDdQeVBHWUoxcHZqaUl2aDNPV0lH?=
 =?utf-8?B?c3BGNjVmaFJCYWhOOWlTcHJSUVNsVVBvelVYRkZWVDAvRU5maHZESkdhdmpw?=
 =?utf-8?B?WVJiUzZhU0c2eGlTSmk1SW5lMzE0TVpmS3ZIc05sZmc3Y1VhR3g3SWwwSWxX?=
 =?utf-8?B?NmxaZnhSM0lkVWVUOVd6M1FKYzZvUzlrdEFhSVY0dGphWHdPVTdjUE1NL0Nt?=
 =?utf-8?B?eU1CSFdFUnZMUGJ3blhGU3JDUjYrcllQeWl3Q3FUQjQ0V1BNUk8wSlluWEdp?=
 =?utf-8?B?NENxZGxDcDFrUVJxSkd6cXdha05XdXJ2UFZhNWhIT2JySDUxbFJvQjVZRVNv?=
 =?utf-8?B?aWYzd2dvTHN5VUU4ZmZSUkczY2NEVDZWVTdaVE1yMllGa251SkN6Z3FhRHVM?=
 =?utf-8?B?Z2taUTI2ampmaTk5czhYQ3BtUStUV0pmZ2czOUlZWGY4WlJ6OFEvelVKWitU?=
 =?utf-8?B?ODh2WmRxTFNJVTk2M0RZcyt1b1plVG9mNGM4QUwxOUdwSEVxdTM4UGhvdk9H?=
 =?utf-8?B?MGY1R3JCTmZNUmhqTmJCZllmVDJaZXJuM01taTZ6TlAzeGgxekszdXhDd3JG?=
 =?utf-8?B?dmN4SStUVForU1lXV0xIMVlkQlNwSjRxNUR5UDVjYXZXYkRvTjNCYnNtdVFV?=
 =?utf-8?B?MW8yU0x0aTZPNjFPZkkrZ25HaHJEKzcwY3AzTUVvVWJ1SFBpbU1jYkx1dTRu?=
 =?utf-8?B?dEhOVm5la2hYbitQdGlMNXArWXloeUI4bTZDOElhK2V6MDlYWE4xTHNhbXdK?=
 =?utf-8?B?ZXlvWTh6Y3diYnpPMWdWNHNSQlZZNG4wS1VlOHY2WGQ5R0dyY3lnTlRkZlA3?=
 =?utf-8?B?QjdCZ2FWbkwzcE9oYlFZRVdJWnNtODlmWmFSN0ZRRklUczZPSk5NQm00R3J1?=
 =?utf-8?B?bFFzSGd6ZjR5RXM1Y012UWdudFZJK2pVdWxLSVJoc0JOYWVFbmg0ejZJbUta?=
 =?utf-8?B?VTZHSXRvK0NVL0lRc1dEOWowMGp1L2tEOHZWS0E1WXFZT2Uyek9xc3FqWjBU?=
 =?utf-8?B?MHpiSE5qSzhwL2ZtNkRkOGdBQWJSeXhtd0xQMmxadEt3MFN5Q0hOOXRSbllN?=
 =?utf-8?B?RFROS1VCZXlrNDMzVWhpUmZoUTVqcnE5SFJOaExVSjJDN3Z0bFBYdUVPYlA2?=
 =?utf-8?Q?T7GN4gYaQtCY0u9ABr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fec05535-59a5-4db2-0cd1-08dec62feaef
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 14:03:44.2903 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LF313uCVgdqDCxVouD57jtSL4uUPRMjxXyZhqbMi8wJkgh6a40SPoEbfYOf4LW/f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6349
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

On 6/9/26 15:57, Philipp Stanner wrote:
> On Tue, 2026-06-09 at 14:36 +0100, Tvrtko Ursulin wrote:
>> I wanted to ask something else.
>> What happened to the idea to remove opportunistic signalling from 
>> dma_fence_is_signaled?
> 
> AFAIAR that was declared impossible because some system setups like
> mobile devices don't signal the fences with an interrupt handler, but
> have some sort of daemon (in userspace) who peridiocally wakes up to
> update the graphics output. It wakes up every T milliseconds and
> opportunistically asks through dma_fence_is_signaled() (and that
> through ops->signaled() which fences are already signaled.

That's a pretty good summary we should probably add it to the documentation.

Just one additional note: The userspace deamon is usually the compositor who is in control of the CRTCs and the interrupt is the periodical refresh timer, usually vblank.

Christian.

> 
> P.

