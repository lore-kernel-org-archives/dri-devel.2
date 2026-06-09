Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAC33CD8C92
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 13:07:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17B7410E117;
	Tue,  9 Jun 2026 13:07:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="X1WWIq6x";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013017.outbound.protection.outlook.com
 [40.93.196.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8DA010E117;
 Tue,  9 Jun 2026 13:07:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k/6aaWtQhrGbFy1EwAHuVKQbyE6Asio1RC/+PA8oBk7g+4rzk1AHhp0nVyHhq9mMm9puVHDBVijqlhHNYZ+LkMStq5pfK5sn3xTaFFtWcbLeVY6NSpkjTCDIp075EhoQZpdUlsr9BM4gEE0diDkEeEDrxfdmQV6YiE4bUo0JhhoUFBb1Z1qIXFvIQ1HVYH+60KoIEYvo8cf4zHZAsicQ8vaLh8TNIM0zPcIkVDP75AVyWRYsLmeIBFr3Mf9fj7B+2bcOaj+aBOrm6auaR8+EkGGZutlKbU+O56bmkshgg9osdrqzWXPu2ePpMHC8bfdJ8av2GNPF2Mv8RTLiYEPdcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AIvtjTjStepZm3Lyoj4vSogUlJANC6Og8Bqy0x7UYng=;
 b=CwO+zTR1n5MvBCeyZiLB5Acu+kEKdgDd8Y+EbPg7tB7G4CN08i208l1J8DRDpHHS0F+E8WuphY1+qpw9xa78vbUApN/bV2SvJtgIm5NrIm+CmR8yMrryGZtDZz4P1gD8wO9GKNXLHgVxfTwbWlTlp/U2oj5bPBP37JHVENXjcdrxEl/RRC2zhwxu204kSicYYKajFy32MRehAJvHD7ToVd38x+nw1JhogkATXY7gl2f2w8Pt90UV0GA1SBm1Hy34x9Q9rAUmCIr70KeOgfMVYbQ2ZR46Opx4qyk33eib3ZSTJdDPv3JXwv57SPWPwIkTyf/J2/EYxwCTVxPEFs9G/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AIvtjTjStepZm3Lyoj4vSogUlJANC6Og8Bqy0x7UYng=;
 b=X1WWIq6xElGKBRsoF/inabTdfYYK/WN0FQmfqG5i/0HMfKSZBbgchPeuNQ79shUjh5Q7xNDXiI68c56qWuoHfKYpE0AZIbEteTFtWizobyizph+MokCGt9nqy8xnji8W2c/Tqo1BEltT8ELgti+5hOe1xFy9TocFLkCFTHZ2qP4JqNw3fgVG6wrFPXkATjDSWwQHFmTITFtIJ22/YbwrtJBsNKLG4h7nRAsJw1XYVww/KqilFbO4A+3etbjlwzDXL4kR72L6x0I9RUB+leAFAxdeoE/0f1nI+dvbQzLRoU/lJYBnq8YvcueytW9ah893jcxt52V1XcLchmw0PcOq7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SN7PR12MB7883.namprd12.prod.outlook.com (2603:10b6:806:32b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 13:07:33 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 13:07:31 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 09 Jun 2026 22:07:27 +0900
Message-Id: <DJ4JIGMNS50M.24ZEWDLMIWNYM@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Zhi Wang"
 <zhiw@nvidia.com>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 "Sashiko" <sashiko-bot@kernel.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH] gpu: nova-core: gsp: tu102: keep unloading if FWSEC-SB
 fails
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
References: <20260531-nova-unload-fix-v1-1-c8dcdc769b53@nvidia.com>
 <DIXCJDV6UQW2.E1SHSJ8KLMFG@nvidia.com>
In-Reply-To: <DIXCJDV6UQW2.E1SHSJ8KLMFG@nvidia.com>
X-ClientProxiedBy: TYCP286CA0245.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:456::13) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SN7PR12MB7883:EE_
X-MS-Office365-Filtering-Correlation-Id: b22da4c0-17c7-485f-91ba-08dec6281088
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|10070799003|376014|18002099003|22082099003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: OWMuP8KkBAy/V1VjZtW0W+C2Kyq79UvPTGCS73PTkvhp6MkWKYyYOTtQ/V4SKYzX+0PwedCrPVYpofudC2iSGLyGfmKpg9Jgv0+6hHwsOJX3RMdTi7903nY84gZ5csHyojfFsjPubxdjtKsfGAfpNzXVO+jCOl4/bMPOSuaVg4Dscr5i1uuDQPFPnR3upV8iIh7TGzEL1C2IXRDSGDtHf0pnzS1ix1DelzXbc2MA6qG7TQOFv2LgIHKi3vZvP+fjyPvYx5vLfjWpWinDpmyprVR+mSJPbWPNyhyoC+97KHx1jnxWIiOHWZtwsa1axXtJbpbJT+ntPlLvkkeHevDB91v/oLQszQnIAJJoAtpbHhWHwtzT2WRnlAInlNXgH51g9X/PpjrDWNcUe79HjV4ByNuExAYM6BPv2dGYd74noggYoDKGiKN+b7BFO8RWzsEg6a+oaNXiRBKorKty9HrCUb4OjFwragduPbspsqKD7oTTHWk+4dN/XB+Rf+m9uBSEpK1G+53ezCCwiuLQSncU7ItU1/sDsQbAv9lt/2GB7jHl8DAGReJvN87FvPAVoVD0RcC5+4m1i7QM9z7p2HMsXRCjoQMJSsDgaF9xaOBVGjDs/SVGtzXJb0yKwgrQacan3dBoZ3GINbpEQ7lPCi3xO1xZTUPRZDUJxwIjrH/S2x2ye1sAXtOWoz7fmxqJ2en+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(18002099003)(22082099003)(11063799006)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWVsakErYUZleWVhWmNLcEJGZmhBZjkxZk1yMnFBSjhjbHZVNHA5Ti9HT052?=
 =?utf-8?B?Zkw3NE40eW9uNUFTNnRhNFd5dWNaZzN0eG1lMUVZUFh0bU5TRkNtcmtpTWpu?=
 =?utf-8?B?anRKNEZPSE8xelJPN3k4NmZVclZuR1NIcEhjdFRoUmgrZzZHZUorYVhONy9m?=
 =?utf-8?B?Z2ZYSE1wbnJpTjJhOE1FTDdPbkZISGxJUDJNY1dZK2NQbUg3YkZ1ODJua0NP?=
 =?utf-8?B?aXZMb1I2ZjEvOHpzUXBkcXFEcUpHWk1sZ2ZNQloyVkZaNjJyTG1wWE9oSU5O?=
 =?utf-8?B?L3NzMWlCQXJMZi9tcFI0ZFlaVkVJL29BY3NJUUEwaUVnRXR1cmdTMGdiWlVE?=
 =?utf-8?B?Qy9EOXY0dEF1V3RmL3VQMjI2dG83TUxLK2Y2dFFTMFRZKzlHRHhhSkd6SFlX?=
 =?utf-8?B?QTRoemJhNEtHQW8xRnM0V245ZTd3SitadlZxQnBlVlpWUzc2b1VVVFlnV1ZN?=
 =?utf-8?B?L1lmdS9sK2lETFFmcWh4dG9ueis5ZXBDL1E0dVZ4NU80VUtXcktZOEdRZ1Vm?=
 =?utf-8?B?aW9GNVMveksvd3p0bU5USGV0QVlVZWV5TjlVRmRYQUNTNFFjWUZsTW1lZ3FI?=
 =?utf-8?B?dFB4cjZHU3lIL1QyZWlCVHFXN3YxT1dDbG1hemVINjZGZG10bDV2TDg3cHRy?=
 =?utf-8?B?b21aRjFUWUdqeEZNdzhNNis1Zm9Fak9OeHhMMThTTUJ5NDkwQjlRUUFuM1F1?=
 =?utf-8?B?YmdRdHBTd1VlZkxsSXpOcTVUemlQaDhBaUJEdklYSWFpdW4zaU4yVVo4YnJi?=
 =?utf-8?B?dVcxVUNQV09aWGNpK0dJZHUyQXZkOFdIUDBGbWs1NGZKbVA2bFhLREkrVEZu?=
 =?utf-8?B?WkRPandLZ2hkeFNYNnlWbURWOUVLd0pNZFZibmowRTZrUTJqVEtadE9MeHFD?=
 =?utf-8?B?VlA3RUs5bUxZZkdpczVaRG5ZeERCZkhEZGtlOXMwQTQzMG90OEFGOWpOMXNn?=
 =?utf-8?B?ZUNwUmc3RXFCKytNeEZ3NFBnM1ZwSmV6bmFKajNod1hKTXBuY1ZoZXlVSnpQ?=
 =?utf-8?B?a3pKRkp1VXI3alFaM2tHcDFEdmU0NS9NNWhQMk1weldKeVNCeHhQaDFyTlBG?=
 =?utf-8?B?WEh6cTRBeHc5aVlleG5oWm5OR1B6dHZybktHVzBoVkxITnFZWGlkSWtKRDRM?=
 =?utf-8?B?N2lVZEFsT0RNOHFhNFBSd2ZUdGN4dTFESk5NalFETzhOMTJiT2ZBc3N5RmJm?=
 =?utf-8?B?L1BFNElmRUpmVnYwNlpydU53UFQwOTVNMEhDUklYSFdjaW1HbXJjUC9ZTXp6?=
 =?utf-8?B?YzNacCtNK1VWSHJzZXdqQUpkdTVxUko5UWFEZXlBemlIQlExOC9uK3hwajUy?=
 =?utf-8?B?MkpNUE1JWmJXelYzRFNya2tyMEoyVnplakhvaGxnUWhYdndVMlBSNCs1Nmlt?=
 =?utf-8?B?UFZqOTFtNWlqVHJkVVZxdTZZRDlZMWFrYzlZZnhxMVE1NXh1SlpNL1VkSmJm?=
 =?utf-8?B?YnN6NEVGUVdQZW03a0ZGTHVNQ3lkUEduWTNybTlMdWw3S2h4SFJNVndEdkd4?=
 =?utf-8?B?UVUzcXA0ZlpxcGszSlBTZE5La1JwVERTSndWVjhtaU1PM3hsQVE1UTFHY0tt?=
 =?utf-8?B?c052cld5VDVzNi9SS0xkTVdYc0pnWWlES0t3SCtXdUNtT0ZKQlVqVXBHWERZ?=
 =?utf-8?B?NXNoa3VSTUt2dnFYTXJwU2w1WkI2WEU0TE9vZVdWYnV4UHRjRnA3bHlzSXJ4?=
 =?utf-8?B?TytucTF6bFo4eEZTUVhsM2dsQkVFc05peDJ5dHo0a3ZxVmEyTXRTZTdGekhp?=
 =?utf-8?B?VjNZRTdlYXVuK0hidkFlQ3I1ckZHZUtqU3NBa1VCSGZJUDd1UUt1dzNXTUND?=
 =?utf-8?B?V3prYzVxeFpxT2Z1UzgxM3YxQURXT2t0Ynpacm5taXFSZ25VZjlJR1loVkpI?=
 =?utf-8?B?ajZuZkhqdzc5WnRlTlBmcjd1bUEwTjlHOHVlT3pPc2l0OXdxa3F3N2ZadjZw?=
 =?utf-8?B?ZmxzYUdqRE5MUTMwSUpsSTBzZzZsK3V0bmJoNUNIZndjZ3hTNmxTaVFic2VH?=
 =?utf-8?B?aUxEczlYMkVCMFNVeXY2bXp4YVpnRjBSODRxUWxtZGtiZmN6aHRkeVlXT0Vh?=
 =?utf-8?B?eW5vMEgxYjZBOS9LRnFCbCs0VTRuNDhyVWZPTVJNMHZiVUtSZWFXTlRUWXZ6?=
 =?utf-8?B?WTg1RGRkekVwVzEzSjF1a2w4bEZOb2RUSFMvQVZHVDg3ZlpwM3I0aUlUWUIz?=
 =?utf-8?B?Q1pVY3JBeTBka1IzZlFlbjRPTWJXMTMxTjZWSU93MGU5L0hvNkx5ZnJjNlBT?=
 =?utf-8?B?RjZTdnRqd0dTanhDNWhCQm9iMUFucFYwT1NtWUNCbnNZWUM1TkhRZGlSOVdE?=
 =?utf-8?B?eVZSSllqUnd3QmxSM21rRGVzeG8yUmZBQW1MK1J6Sk0ydlpRU04walA0aW5j?=
 =?utf-8?Q?p0yu1U57W4StM/KdKpi6A/NuuvLZRepiuWNwN19L0V+ou?=
X-MS-Exchange-AntiSpam-MessageData-1: z4NG3oDZEuS8qQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b22da4c0-17c7-485f-91ba-08dec6281088
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 13:07:31.4327 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PJ3Gr6icR9HrH5aRBtnEUxyErC6940SaVz+g4HVpz6T5+zezsQWAMSszZ22vU8oPnNKW2yNqIQQcsg08q23h+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7883
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

On Mon Jun 1, 2026 at 11:10 AM JST, Eliot Courtney wrote:
> On Sun May 31, 2026 at 9:37 PM JST, Alexandre Courbot wrote:
>> On Turing and Ampere, resetting the GSP involves running two firmware
>> images: FWSEC-SB and Booter Unloader. They are independent from one
>> another, and we should do whatever is possible to restore the GSP's
>> unloaded state even if a failure occurs along the way.
>>
>> Thus, keep going and run Booter Unloader even if the execution of
>> FWSEC-SB failed.
>>
>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>> Closes: https://sashiko.dev/#/patchset/20260529-nova-unload-v7-0-678f392=
09e00%40nvidia.com?part=3D3
>> Fixes: adb99ce3cc78 ("gpu: nova-core: run Booter Unloader and FWSEC-SB u=
pon unbinding")
>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>> ---
>
> It seems that in openrm and nouveau AFAICT these two cleanups are both
> done regardless if either fails.
>
> Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
>
> nit: it seems odd to me to log on fwsec-sb failure but not on booter
> unloader failure.

Good point, let me add an `inspect_err` to the result of Booter Unloader
as well.
