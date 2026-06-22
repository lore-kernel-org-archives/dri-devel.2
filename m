Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC26ACDB46F
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 09:27:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1614810E5A4;
	Mon, 22 Jun 2026 09:27:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="I16u7/qr";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011048.outbound.protection.outlook.com [40.107.208.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A805010E5A4;
 Mon, 22 Jun 2026 09:27:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SRc5cUKcP4eh8wtVMd91pqmm2WQTIxWQ3bwnxro9G1eKI6QMcdqbmC4FIdGpZfw5c63rMlPTaXkmtK6jBgasL0YWUKrKByWzQzdrqRzndU20i05Edb9cckvsx+WlvgG7WkTH2dkM4PSmHmHbA1RqBG3y0KvREhO1LVvBjgRDfS6OHV07coaAt1PoHG90+1+ghQvLXFILXJdq13cbFzwLQAOSyQTgfPGNw3kTwoZJ/SInXX/fQtBSIgWWKxwt99QfPi5P8z/IGrSQw29xpqbyas2g1QGTltmjeT4o1pZyL+aCQ1iDWV+KqCg/CFR48o1R4YTnIu/eq8LsRXy8fBIhlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YShV8EjGuQks+w1IDeOjgIZgXnk9RY61dD3BmDWx/78=;
 b=af+PhNmxJHcbXa5APwAMDGBsuirFWHYczxZSeHtE77PJuc+AdwQb3aR2Nkrkyi0ZDbZWGPykCavizERioYhPzPWopoGGSDUFrfkCXjvAN/yXiCcNu5zRYFNxrEN9jb+Enr5TVKksH402hKwLXy1CnntqNPpkydGI+HiMfaFiV1hjzvL510qvFOUMVEU1wBRpvS+WJBllycZqqPNIk3/dJW6DDGjIhEVU5470hdj2OMl5AtHWogzqyDTC9HxxKtUT9yo8XViDWlLT7zVizm2v9Nv8pIsyq6dkrdSL/Esd/o8/m/upbcF6oTNmfrd+jJVzWpPDxYAqP2e+oblu/bcGgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YShV8EjGuQks+w1IDeOjgIZgXnk9RY61dD3BmDWx/78=;
 b=I16u7/qrhoEQFcocJpWy6yxYHTWp9SqSpKeNUD4tLeNxjQVnmAo7BHgcsNlCMb5+dRk/YS8mTCATr22UcANDF2U0hQkXqjnKe6G5kF9WVJNPVA7fDU6mjCfdWiuvB5vhs7qUQKNBaOfx+37DhIVy16jz9UkGIZOyXZqXthLRYOQn05eQ6IDIlBiCzhfdIj3PDk7VvswqbNPZayqSp1eRi+Adr7X2ok/9SVhkASvwNsquov/+fEEzVzCh41gf5DnlpXTNhYBNrIQYSC+ZpKYlWLQplCSA3RLCutVy1Ae0WPBlmpRNiyG8/nS0XzmzbfWHIK0K8KfJRsRx1eR5EjrrWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN1PR12MB2368.namprd12.prod.outlook.com (2603:10b6:802:32::23)
 by BY5PR12MB4275.namprd12.prod.outlook.com (2603:10b6:a03:20a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.21; Mon, 22 Jun
 2026 09:27:25 +0000
Received: from SN1PR12MB2368.namprd12.prod.outlook.com
 ([fe80::281e:52ee:b18e:ad42]) by SN1PR12MB2368.namprd12.prod.outlook.com
 ([fe80::281e:52ee:b18e:ad42%7]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 09:27:25 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 22 Jun 2026 18:26:50 +0900
Message-Id: <DJFGYM6U7QN6.9WVDG87QNK@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>, "Eliot Courtney" <ecourtney@nvidia.com>,
 "Danilo Krummrich" <dakr@kernel.org>, "Alexandre Courbot"
 <acourbot@nvidia.com>, "Alice Ryhl" <aliceryhl@google.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Benno Lossin"
 <lossin@kernel.org>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH 05/13] gpu: nova-core: gsp: keep FMC boot params DMA
 region alive during error
From: "Eliot Courtney" <ecourtney@nvidia.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260615-blackwell-fixes-v1-0-f2853e49ff7d@nvidia.com>
 <20260615-blackwell-fixes-v1-5-f2853e49ff7d@nvidia.com>
 <DJ9SQ12O99GR.3TDJ2L39P03GQ@garyguo.net>
 <DJB2QJAXEDVF.2KUIUQ90Q818W@nvidia.com>
 <DJBDHLVDG7LU.VBPNFIKARCBL@garyguo.net>
In-Reply-To: <DJBDHLVDG7LU.VBPNFIKARCBL@garyguo.net>
X-ClientProxiedBy: DB9PR02CA0022.eurprd02.prod.outlook.com
 (2603:10a6:10:1d9::27) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PR12MB2368:EE_|BY5PR12MB4275:EE_
X-MS-Office365-Filtering-Correlation-Id: f5d586fe-5d69-48d8-f675-08ded0406ab7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|10070799003|23010399003|22082099003|18002099003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: wMmmYkoZOqO1jPtOrAvGCmx/MZ2U1mhI4uON4kYm0daFZ5KrN1ziPbuS2TZ0OU0472Rzjzbh8iT4rOhI4kXTERXOl37soDlJdedNDmzoA4/5fQL3EZ2q+yZlvEQNI5RkuQ5khoZLkjgk14DmGTTbQPGZgPvg+TigSEdzIiGcC8sK1NglPcVGAeiUX1hcebSdzBvbKADe/FDPPYbVhHtltsyWJFnjNbivq4zI5urkr/z406jEz89PM45P9qdIUbZhJfI+OSCcE6gtFd7qywlJURox3VXAbQ182klDQy+81TxF3yE1iGXGHVAeXgSXwClcK/DEuZAGH8L4HqMQGvlo0C8d6ZCvHsy89JByn5hPiJIg4lEHtUrsS1gjQIKEujQD3thEMOJ36csd8yh9XttLr8Oc+shJRYwsUyL1wuUsGL14FGUvrrsCcjSvlx/j4Ar9zZQrrNi3knB7u+JtA645w/avSVyk8LacG0MxXzt/QufUnH7eywC5G7ytjvsXcvGJWqIL8OdlZ8vAxey7fqzERQRGDPcWdiEBBYR4avQp3RwTt2UQK//PcTlbLnwd1JJAkcDP+E5yIdaEcg8nqf8M9Ea0rIAcJaQfp6gBBCOiSPFCs1uaR+nxcWBqu4axTB34/tNLKHQY24CJCLxnKBDC9Fx/uYPii/4ivdW97OIU0FQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2368.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(10070799003)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTRIZDM1Z3B0RDJUcUxWcTIyWmpJWGhYb0t4RW9hSkZpdzFYTEVjOVlaa0FU?=
 =?utf-8?B?UGw1M25mNW1TYzNEdGVNS0RQbTBXMVEwOTBkeFdlKzFhNE83ZmxRdlU2bk9Q?=
 =?utf-8?B?Rm9NNC8wbG11ZmdqOU9hTHRpenBlajVVWEVlbG9DMkIydzU2SkV0MS82NUFi?=
 =?utf-8?B?eTBGL3JSd3BodWdybHFUME9QcURSYjlCbW5iSnJYcGF1NWk2Tlc3RGhteHZt?=
 =?utf-8?B?NHVaVHVFckZJL3BCTzRkWTMwMm9uVDFwQWdLenpOV2E5RjhTaU5GV28wVkM2?=
 =?utf-8?B?aEFERGVlUGJ5S3RTeFU3bldoME9EdWRtbjlKdUo0c2dHZ1JCOGlxdUEyeVJI?=
 =?utf-8?B?UjZubUg2ditRWHBVTGszenBqYVhHOXBuVjFxcXpxTDJKRDVtV0VkTENOWXd2?=
 =?utf-8?B?VUl6a2d6VERVUlVNNTc2RkZpWjgwZFRMbnd3MThVWUc2aWZvUUdTWlhUa2J0?=
 =?utf-8?B?SkVjNnNiQUgvcGZ4aHVIaGVEaDdJNnRkc3UvalFKMW9adkVyNmQvRTluOXFZ?=
 =?utf-8?B?QTR0R2RhRHpiNk0vMzBUQkZ1NFpjaHRiN3g5UkJoZERlSVlENE13TStMWkgr?=
 =?utf-8?B?WTVaMjFVTW9YdmMrNUtRSGhRaUZxREllcEdMcmN4QTVsdU0ybVJQeXlFNU9P?=
 =?utf-8?B?ZmRhcWJkQW93RVc4TEN1UThGVysyc21pT0dDVUpBQmRoNCtEclR3RkJSYS83?=
 =?utf-8?B?Nyt0eXp6cmVxLzJzWUN6NTU5d2xzcDB5MnpiU1hPM0o0Nnc1cy9IcjVKZE4r?=
 =?utf-8?B?bXYxZXF4ZDRiYUNOREdkUGdKd1ZxdVNpVUJCNm91VWFWcVNqVktZQlU3T3Fu?=
 =?utf-8?B?S0J0ZmdCcm9zaERiTkRLeTVsS0xnTkgyRmt0cHFjUnAyVUp0dDdJdFB2bHlF?=
 =?utf-8?B?OWZOK3Vvcm9FU2JpeHd2S210eEpaNis4Q3ZsNnNDT2NmT29uNVcyOXZBN1J5?=
 =?utf-8?B?WUlmQ2ozOVRkcXY1L3FOekJVQkJPeDBYS0Q0MmprbGh6TnhkWGxMZW9MY2gr?=
 =?utf-8?B?LzJweXJHVVRINXV6WkI5OVlHN1lSUGN3OFFKbUNESks5dFZZMWFPTUZBTVE3?=
 =?utf-8?B?SUw4elNkRjVpVjF3VklWd05yY2ZpQmlCcHNOMitQUUYzaWRReTU2emROMk5r?=
 =?utf-8?B?NFN6bTQ3UEI3WlJXYnRoMWFWN1FSS00ycStPa2FHVTNUSzRFNDJxanpoSG1o?=
 =?utf-8?B?MU9SaUdpTmFiWmZ4RzM2TGl1UTJsbzZ4VXI4QkUwc201MVlyNm1EaEJwQUs3?=
 =?utf-8?B?c1VGdXdnaHVDcDl6Z0tyc0VpSDVHNFI2NmJTZkMxTExFY1hhMU54bkRTVVQz?=
 =?utf-8?B?Uk1IcUdtajhQb0Ruek9XUmU0aVhiMmp6QUxIdTlnaHBYYk4vbGwrMnZZaG5o?=
 =?utf-8?B?cWc0QnRRN2drcjljTDV5WmlNblBqZUJMT3g4Zy92b1FHTS8xTy9obk1nYnlw?=
 =?utf-8?B?SytLUUlpUGtUanR2azlhTHUvby84S0VLUXUzbFdxaTgxeUxWWThxVWx6cUNN?=
 =?utf-8?B?OWtxUzh5b2ZKdkE3SVUrbkwwNlZVMkVkcUU2NC9zc2Z2TFZqNGx1a2Y0eXVC?=
 =?utf-8?B?aGwyaUNzT2w2am1lYmx4WE9GbS9sZUFxdEcwNk1JVXVHOS9QZC91ckN3TlNO?=
 =?utf-8?B?R3ZwVzF1bGRJdUUvNjJiYlNFUkc4MXpUMlpSWEZiZmV1TTFCQ1ZZMWwwVzJR?=
 =?utf-8?B?bWR2blBmRG5xbHlGRUNKbzdHa1pxZmtuLzE4TkJ3WDNkcnJOb0ttN1VRSCtH?=
 =?utf-8?B?dS9iWE9BTmxuSXVzTGlnbXlhaWtOTWZYNDFOamJEZUFNUjFlTEdWQWFwcHZW?=
 =?utf-8?B?RzdwdVh6S2RoUm8zV1ZZd3NJajNFSjRhdWRVN2xidGhkN1VXWS9OU1B1dEx6?=
 =?utf-8?B?KzV5eXFSUXp2enBFT3MwcHdkUjRuRGYxWG5ZOVdSZU9tckdQY2VyYzdiOXlV?=
 =?utf-8?B?S2d3TjdRQzVKdHFSWi92MnpPTlM1Q2lMbzZGSWhhcy9EaUxwOXVNZVVROCtS?=
 =?utf-8?B?dlNsMm02RkI5WWFCdTM1OFhBUDE5T2pFNkUrUEFYQ0FLQkU4Y2ZuNlRZY2k1?=
 =?utf-8?B?MTBIWDZxRjJ5Q0YrejN0cTdTdkx5UFZ4c1Z0RFNxaWlDTUpZMk44eEYzczYy?=
 =?utf-8?B?M1N5bEhldWQvdGVhS0l5SGp0QlFMVGhPWlNnQmhGcVo2R0lPNWlYSXJCTHkw?=
 =?utf-8?B?UDZGM3FrWERpSXVMNmhMM1VSZGlGMzB6cWxBaDM5SGs2dWZId3NvRVREVDll?=
 =?utf-8?B?andkMGdzaVhYbytja3V0eW02aGJpTk93ekQzS2R5aTJiNjdVZHBadCtCV1Qz?=
 =?utf-8?B?WXdTRzlGVjFKeHo4QitydzVXTE5ZTG1RdFYyd1dVQ3EwcEZlWHZwWGZlNTI4?=
 =?utf-8?Q?q2p5xFwyedtqfihu2j0oNJszbnlPxaoIVABPS6rjG4E+o?=
X-MS-Exchange-AntiSpam-MessageData-1: CJYlsblgbaArEg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5d586fe-5d69-48d8-f675-08ded0406ab7
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 09:27:25.2329 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tu1wJFZyh+tGCqCLFeXMAbWsRtPt2cbbtd7ZkSzgCZE2xB3+RG4rhnwoHJUXNssUcq+kJ9b1G6Yu0nsuopzk5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4275
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

On Wed Jun 17, 2026 at 10:52 PM JST, Gary Guo wrote:
> On Wed Jun 17, 2026 at 6:27 AM BST, Eliot Courtney wrote:
>> On Tue Jun 16, 2026 at 2:23 AM JST, Gary Guo wrote:
>>> On Mon Jun 15, 2026 at 3:40 PM BST, Eliot Courtney wrote:
>>>> Currently, if, for example `boot_fmc` fails, `FmcBootArgs` will be
>>>> dropped before the boot unload guard. But until everything is unloaded=
,
>>>> GSP may access this memory, so make sure it doesn't get deallocated.
>>>
>>> Hmm, this looks very weirld. `boot_fmc` only needs `&args` but it actua=
lly need
>>> it for much longer?
>>>
>>> This is hinting to me that the signature is wrong of the `boot_fmc` fun=
ction is
>>> wrong..
>>>
>>> What is the exact lifetime requirement for GSP?
>>
>> Once `wait_for_gsp_lockdown_release` returns, it no longer needs the
>> allocation. In the case that we get an error in this function, GSP may
>> be (asychronously to the CPU) accessing the DMA memory we gave it. So
>> FmcBootArgs should stay alive until FspUnloadBundle finishes (GSP is
>> reset) if there is an error, or, until `wait_for_gsp_lockdown_release`
>> returns successfully.
>>
>> So for `boot_fmc` to cover the actual lifetime it would need to be
>> responsible for waiting until GSP is reset, which it doesn't feel like
>> it should be responsible for (even as some unload bundle that it
>> returns).
>
> I suppose logically the GSP does need to take ownership of the full `Cohe=
rent`
> until unload if this errors?

Yerp, although it would feel noisy to me to have GSP optionally hold this
value (if HAL requires it, if we had an error specifically during this
FSP window of time).
