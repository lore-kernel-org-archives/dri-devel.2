Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF70CCA5FF1
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 12:12:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20B6310F562;
	Wed,  7 Oct 2026 12:12:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="T+Nf6FRz";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013058.outbound.protection.outlook.com
 [40.93.201.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C19DB10E533
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 12:12:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=txXohJyjBaEa6HjT1TQTBAMml/ml9aG4tmZm2nIvq5ckFEPg1fRi4HcxEagwcWva0EOPjhv//9YyEquzbwqOoIKpwejo1iy9R2VgYJy6PZvKFp1ECQeBLKozwpOmf3YspcCa9HqpRR9/TT9xBOoNUynVmzsgTVjegiKhD0t6OUOPtAAunuw0UwusggO/Nm/vS5j6NACbNEOOrkZxxItVXVfykMHM131vteANw6Oj8DIdewyHMTRWPVlvO0krHVJFhCmFa4zbtznLWi18HiusUYdf9kf5bjcKki696RbIPEKknwMQNjI4mlpG1uifiiQjft1kzlkpV94cMg2JQ5rU1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W5K2mAtfdtB+SuDHkpTYP0WdBzF1tm6mnkRN5hEruQs=;
 b=qnd2iQbVbRqVBbyzwUTcYYl5zz7iBAOfnATqV66uoCnDFtltnf+ANIKlQi7vhf0U0AIXUdJHitW4aIE2ZzpSe0Lg68uQ13ZwmtC6dlG2tUvE6dMLK/8dt9V0L6bcrM9M+KxMgIwD22m/CDuKlMxerXU/sfJnrjRfGdNNGf6pxia4qeO+GE8TEvVb/S8QrWvMXFBvdyIljCWCorY3mKJ6EW1NFCXBJ1kZ2qSt4qt/W8PbNbUAjcvqhpFzQxyWcV2l+azOcg+2VIojpqh7mW4D0/sXf+tdcWg02JI0Oxrz5zrV+AsB8keeANWDkMtQ7k1lY+bb53oIaZ7qAkkXXrhumw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W5K2mAtfdtB+SuDHkpTYP0WdBzF1tm6mnkRN5hEruQs=;
 b=T+Nf6FRzx8Bsar08dsVtB4lbxhzEZBf2ploDK84WlT+FAfj3eHQyyQRpyUfJiRTtNgIAaEALS04EschM8Mu5mtw5+5CS439wlSzQvTI8ZqCQqBg4Sf986gn87/Eu8URdeuP6dJInShR4sAd7wQmykY4ZeNQNFmhcTx4aLR+SXhDIo8r2rsaFq/nUqYVwy2eFUAUhuSchK6G1HCX03J3buWnphpCWUXgPafZCR1AFuQyhZ4VeIXLhORUPTo2CEFB4yzyKnRHdzSN9Y5iWhTWbCzOZ8H3euzLYuCFfdBSsdYToUMcoX/VO2/hLTD9c5Aw9XPwPbhLMO09hBLxedhW7wA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by CHAPR12MB999248.namprd12.prod.outlook.com (2603:10b6:610:2ff::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 12:12:04 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0472.016; Wed, 7 Oct 2026
 12:12:04 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 07 Oct 2026 21:12:01 +0900
Message-Id: <DLYLHDR38T98.ABF99FVJYFWP@nvidia.com>
Cc: "Thorsten Blum" <blum@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "Gary Guo" <gary@garyguo.net>, "Timur Tabi" <ttabi@nvidia.com>, "Robin
 Murphy" <robin.murphy@arm.com>, "Tim Kovalenko" <tim.kovalenko@proton.me>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] gpu: nova-core: firmware: fwsec: use zeroed() to
 zero-pad buffers
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
References: <20261006100442.80432-3-blum@kernel.org>
 <DLY3SJLA1YG0.1YBCCD2CAH2IC@kernel.org>
 <DLY6MDDAUDFL.142WKY7PWTNDU@nvidia.com>
 <DLYH15Z18TCO.5CK2MNXMZUG2@kernel.org>
In-Reply-To: <DLYH15Z18TCO.5CK2MNXMZUG2@kernel.org>
X-ClientProxiedBy: TYCP286CA0006.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::14) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|CHAPR12MB999248:EE_
X-MS-Office365-Filtering-Correlation-Id: e6eba444-b6ce-4a75-432d-08df246c32fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|10070799003|7416014|23010399003|376014|56012099006|4143699003|11063799006|22082099003|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: a5dSilGrjvZHgHHMP7MQA6v2bnXte5KLYWdEGgk+VCl2H5c/ObZloYmR9xPaLRbeNZdk4lUQbSXaxn7HFIY+6jIyc8jIqPxKUrHtRXdOcjkGwSs8Iu28+SpTujzAt1U4mrbTWVjySjIAWHK1nGNDiIRtbv4mgPenFWGJF11IipIwKFL+tQTdJlLpBr4gyG1zM/k0yDIRz1QOA8Uich3pdqgAxLkbRQyt0N1SRNGvNqxk/4MkR9jHDJipLFnbTlmtEnTW0rFAyp4fDIi0GVuOtiX22U5UP0/WXXztaAJS2w5RLq/98IUKA27aH+tcfMWbCfG1aYSMgUxpz8g9YYxpAzYLqS52B+SIgQc0ZANAOPQveVSpprCwNul5ueNaQDQqgjvzEvKnvzZqbDQnA+TSKVSVL1syxg1lYcwhTcFeiyENlTLQOWCziUVakVr9PGVWKN9gPwHwds75VTwmc/ePGEom0PShPviULG2UCPRq91BzBe0y/os1OzWMcB69k1998c7TbhhBf2+TCmRS5LQlt6QSNQFx9fxNBqwA4IXW+mlJoCGjl4LXs4GLrlYG7F6yGci4r5Oo0y8aqNHwvXZ2UT9ntcI6gaY8x9pWNGRGPQLcJkb+DA5fQ21BC8H6ChJpxCiXQxFxcZxHdliM+Y6dlo8PInoEXMfdK3AyCnAbfGc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(10070799003)(7416014)(23010399003)(376014)(56012099006)(4143699003)(11063799006)(22082099003)(10067099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVNITk53c1N1cThPZnhZNlpMU1R0Z2M4NDVZTFJwK1lNTWg5dXRORDZyOVp5?=
 =?utf-8?B?S2p6VzE2b3c0eDhWZXRyclpFZVBxQXlUM3k1aWRrR3JDM2pvRlFqL3l0TzBs?=
 =?utf-8?B?U291a2MxS3FFa2tNUVF5VmdsaDJqWmthanozSFM5VGFTUTBGMC85emlHRlha?=
 =?utf-8?B?bU1RMEpySWphSi92MWdPa3lDRWYwZmU2OGptc091UTJsN0pnbGw1NUtQcUdi?=
 =?utf-8?B?bm1rcG9EUHdLQWZWNnVwclNLS0hkaUd4endtR0ZUWDk5Q3NlQ20zakF0NGtq?=
 =?utf-8?B?cUhCeDlWZ2RQZm5uUzk4TmdzSjg4UE13b2dRR2ltTmpUSjVIRlVEVUoyd3VP?=
 =?utf-8?B?WDN3UXNaWWMvaXBQT1ppaTFlSU5vSXJxcEI0eCs3QUN6ZFlPYWRERmx4SEdR?=
 =?utf-8?B?ajRJVFdqVlVwNk1yd21PRTBvN1VCZjNoTjREZkRmbDUxR2lRWEphM2lnak5y?=
 =?utf-8?B?QU11RFhsNzIyam9TRWpYbTU0eDIxUGwwRlVTSXJlbURkYlVzTlgvWVZPS3Jh?=
 =?utf-8?B?QTB2MGpUZ1BZZ1JmRm5GL0RzbU4xWGMwcGhMa2RLbmxVbHRIb1VwNSs2WUgv?=
 =?utf-8?B?SUFQc2tzZ3lEWEkrdlRmTzlDbUZ2aDJuQUt5TjRXVUtZdG5EeGhZVUNMcGZh?=
 =?utf-8?B?N0ZHUUhveW1BQkhPOXI4NmFHY1A4WHpyQUVrbkExTDh4UlVwRm5tdW12WHM4?=
 =?utf-8?B?OGdFMUpjV21OcFlLc25mREFqdVN4S0M0bncxei8vcVdsdzVyOHk0VFU3N2w1?=
 =?utf-8?B?ZlBtZVpCQjZHSEZCRVFaU3BCSFpOWmpaWDBNUG42MHgwNko4eDdvZ0QzS3U4?=
 =?utf-8?B?ZWE1eXNjZldHUWVUckdpeWFZbUFDNi9CTm1jZG9uN1pFeVdtaFZuSGdXWkVT?=
 =?utf-8?B?UFhCVTdWNVZvN25JY0RNdGgzQ0tIRlZLSnpRbUZKMWwzdjVYb0dxbEZFbnB0?=
 =?utf-8?B?WjNXZ09FV3J6WWhhcytGS3h4Rm96VUs0Z1JqSE5YWTVlRVlCSnFaTEhkcFFh?=
 =?utf-8?B?N2JrRXllSTRmQnRxNlNUNEhSUDA1dlhCNzRMd2lmMmtCTmowTXRTdGpNb011?=
 =?utf-8?B?UU0vK1hvWnhDOHkvOEpENmRubG9ubitBY0VyaE5sSFpSeDM0Mk9ZTjRGUXd1?=
 =?utf-8?B?UU13RDlIRlBlMXRPaWRZdGhCYUdjbUJLbG1RMG1IYkJhQTRLRFN1UTZNVUlE?=
 =?utf-8?B?bmNZc1I3RUVaR014eWYyUFFnRVo1c0twN2xyRElrYldxV2FVTUpJMUlVOXF1?=
 =?utf-8?B?NldYT3VmRTJMdzdONWhCOWxscE42ckd6d2I0MlFCdEI2U0YrWW9OSzJLTVJL?=
 =?utf-8?B?dHhpM0JXeStsTVpEeFZyczc1TEdqOVBPSEJvTkV2V25GQStGTTBpZlVJZERM?=
 =?utf-8?B?Rm9DdklWTHVQVzlBbjJHcDN1WTcxOGJ3cXFXbkIwTXlaYnRQT09meklJZmdL?=
 =?utf-8?B?ZW5jOFBWQkdEU3QzTUNtbVFhdzAvbmlBZ3ROZ1pkY3B1TzFuYWN3V1NmRW9T?=
 =?utf-8?B?MkJWL0cwaEY5WmkwUklDdjVCejBoK2Z6SmhoUnhEN1hhRmFLUC9zcGdGTlpW?=
 =?utf-8?B?eEFQWjhWWlp6eUhTQ1VQQ2FHWXZxOXF2alJuNWh2bHZpUkRncU5ENHhIb2Vw?=
 =?utf-8?B?eXFMcTdkODE3VWtiYUMvSnIwKzQ5UkF4d0Q3VTBJRlR2TDl5c0NQQWF4bHYv?=
 =?utf-8?B?NHdpTzdnWjZSUkxqTTFBRGxsWStNYklVVG5ES2JVM1dFY3JEK3JQOGs3SVha?=
 =?utf-8?B?OFRvM04yZEljMU5CZUZPMlA4VHFDVU9oRlFPRnJUb0ZiNnd4QVBaY2xBUldl?=
 =?utf-8?B?SG56dGpRNFk0bkxCY1RwNGZOQ2FuZlBQY2Zqd3oxc1RadzNlcjU5elhyK3pB?=
 =?utf-8?B?NGs0N2dSdERZZDV6RzJZd3JyTUs4M3NDNTIvUUl4aWR0VnAwdFZYY0MzMzZ1?=
 =?utf-8?B?cjQwMnVTZS9VamRrckhFZnRZTG1FNi9wa1BDdEw1a3NvRmhiQ1AxRHlFb3ll?=
 =?utf-8?B?WFFFMUQzbXI1dGN0dmlxL1hLaDdOT0xjMnM2KzlnYWdEWWRwMmM2bDd5N1hH?=
 =?utf-8?B?RXVKblhjYjVOTVpKMVJrSU10SXR3dFJTWlhLRVhkV0JBcmxHOUpZMXJFUldh?=
 =?utf-8?B?SlhjYmtKdGRXZE1jSzIvczVzUE9JNmJSeTBSWG5KWUR6MFhNS1VtZ2IyR3Ev?=
 =?utf-8?B?U1lnWkM4VnNRbS9DZzZkL0JGQzBKTmF3eDlOUHZ6ZjhOb2dBa2J5bzliU3Nz?=
 =?utf-8?B?Qy8welFlUkh6THlKbmU2eG1ic1JsckhqeWhDRnMzR0F3ditkb2FZTlAvZDh6?=
 =?utf-8?B?dGtMVmF4TU4vSWJRWGlsYVpyUVJIYUUxNmdMc2hRbGRvaDloVWZPNkY3QW13?=
 =?utf-8?Q?T7ejAN9b418soXs6VNmF2MNBB3lq08qhTJOtmkKDcWNg2?=
X-MS-Exchange-AntiSpam-MessageData-1: eGjeVFKJasCh/g==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6eba444-b6ce-4a75-432d-08df246c32fb
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 12:12:04.1407 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YROj9oeBG5YZWP06PJQXPtK/Rd9vUsbsKzeM0whaxIU3NLbqGutxyZ/d3OU2e8y3y0nkmb4dCjIFFldjBDxnjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHAPR12MB999248
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

On Wed Oct 7, 2026 at 5:42 PM JST, Danilo Krummrich wrote:
> On Wed Oct 7, 2026 at 2:33 AM CEST, Alexandre Courbot wrote:
>> On Wed Oct 7, 2026 at 7:20 AM JST, Danilo Krummrich wrote:
>>> On Tue Oct 6, 2026 at 12:04 PM CEST, Thorsten Blum wrote:
>>>> -            let mut ucode =3D KVec::with_capacity(aligned_code_size, =
GFP_KERNEL)?;
>>>> -            ucode.extend_from_slice(code, GFP_KERNEL)?;
>>>> -            ucode.resize(aligned_code_size, 0, GFP_KERNEL)?;
>>>> -
>>>> +            let mut ucode =3D KVec::zeroed(aligned_code_size, GFP_KER=
NEL)?;
>>>> +            ucode[..code.len()].copy_from_slice(code);
>>>
>>> I kinda dislike that this is now a potential panic, but it does better =
express
>>> the intent.
>>
>> IMHO the original code expresses the intent just as well, and avoids
>> writing the area covered by `code` twice, on top of not introducing a
>> potential panic site.
>
> I'm referring to the fact that the original code expresses "I may allocat=
e"
> three times, while the intent is that the allocation is exactly
> aligned_code_size.
>
> This is much more clear with the new code, if we really want to avoid a
> potential panic here, we could use get_mut(), but the ergonomics isn't gr=
eat.
>
> That said, I wouldn't mind adding something like Vec::extend_within_capac=
ity(),
> which fails if there's not enough capacity.

You know how I feel about panic sites in the code, even if they appear
to be untaken today. :)

Another thing we could do is replace `KVec::with_capacity` with
`KVec::new`, removing one potential allocation site. The added padding
(which in practice is likely to be 0-sized per the comment in the code)
is unlikely to trigger a resize anyway.
