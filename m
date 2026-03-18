Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 894EB10775F9
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 18:10:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D36A10E055;
	Wed, 18 Mar 2026 18:10:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="c+o/xxcI";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012066.outbound.protection.outlook.com [52.101.43.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BB6110E052;
 Wed, 18 Mar 2026 18:10:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xgclJgfkrCHkf++diq4Kt4v7Nj4HmL1s71NmQ8TLCjnT/s+5iZSck9/rTg9w/PvKPC0bgSaT7+2F9tkPVFhdts9oAImm+B0WhtZB3bJAEDieweOBniBNVdlunlxTojhGO1BhOSlBdsr57XnsHSuoBbEMNLOJUbljYp2Sf3ddZIYbuNYBAIXdfq5vqva5cudS5HWpUOicTjFKuIpvWZHJ++6eyd/tDwu+XSOGFiVlQxTpff5hJ9CGFBGCIYfYZaFnDuObwN+33pKkWxR42SFX/WRH9RduydW0sV7rDWFW//jXqwrs92QW7WwdRVl75KEAAnLjfVWtVjS/t8GW0sxKNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gcf+6c8I0vSzTQfR5oRvdBi72N2aiD/xXAvYTi3mTxI=;
 b=o+HGCfzZJFETMEh0eTwpEiOZcmOktjnX5b4RGS6Xk1Z7U+z1kd0D3iJyfOBL6lap0g/QY8oRbZvLrIDDbX4wflwwRzwQLuGGbW8gIKkDv/6q2q3DYNkvcFr8JCuj/7WYZPOz15yDFfOFJmTurI/Piq2JxBMhENDN//4vPRbKSxzig17QNCvb5BwONpM/8GNN2S5WNQE+hLlVAzFNGoAmFlp0Q8bSJuBKsjP2oarRe5lBLtzKujr2Hh7DSpnYDmbTzAnumv9nq31N5EZkvk39AbDgB2N1Bxq6amEk6n8pVQ/4YaJR2h39ycO7UmG3Rw32Jr4tPNPYwZth0exC0w5ScA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gcf+6c8I0vSzTQfR5oRvdBi72N2aiD/xXAvYTi3mTxI=;
 b=c+o/xxcINtmFztPD9qt4azl/+qLgGsqevcYzCC0tYGqX2M114AMIGdBwdFNF37oLAxqGW4XwLllZcXfMtb4+W63HN7rS5CToXsHAoYfXme4ofnerFDVn4NmXpN0zF7DBEEMEYo3m34+6mlLqImmx6/M5Wem48NLTcGIOsgs21ek6Jrz4POM7wwLUKzoI3DnvCTcX0prrBTKv+esn+h15aFND82F2RKRytISpPa7SLyQMcG1GJcGbBK1n4hoTDTO17tsYM7uowgVL3spXj6ZKo9opiT36NbMXMfdODiNLVn9L/WrPcask7eRhXG3oihgEMP+GoO4WgxEo0kfrrByrRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 CH3PR12MB8511.namprd12.prod.outlook.com (2603:10b6:610:15c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 18:10:28 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%5]) with mapi id 15.20.9745.007; Wed, 18 Mar 2026
 18:10:28 +0000
Message-ID: <85a4d164-f2f0-423c-be66-fb1a6aacbb01@nvidia.com>
Date: Wed, 18 Mar 2026 11:10:26 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] gpu: nova-drm: rename nova to nova-drm
To: Alexandre Courbot <acourbot@nvidia.com>, Danilo Krummrich <dakr@kernel.org>
Cc: Cheng-Yang Chou <yphbchou0911@gmail.com>, aliceryhl@google.com,
 chia7712@gmail.com, dri-devel@lists.freedesktop.org, gary@garyguo.net,
 jserv@ccns.ncku.edu.tw, linux-kernel@vger.kernel.org,
 nouveau@lists.freedesktop.org, simona@ffwll.ch
References: <e7539fd5-9a0d-4a06-aa02-ec3dcd235926@nvidia.com>
 <20260317092304.424377-1-yphbchou0911@gmail.com>
 <DH536IWQDX23.22R0P6FT091LH@nvidia.com>
 <DH53WAJHTQFS.ZSO15BGJLQ8M@kernel.org>
 <DH55S9CU9YCB.2Y3G50LUGSAZF@nvidia.com>
 <DH560ZMNK76A.1YFRKZ6FDU4I2@kernel.org>
 <DH5HZM2YNL83.3C1BPIJQMIU7A@nvidia.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <DH5HZM2YNL83.3C1BPIJQMIU7A@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0008.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::16) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|CH3PR12MB8511:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ede8f96-0e6e-4e1f-cbf9-08de8519a276
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: xHBV39GmZ0Y06+7B95Z3PT+qaQLQHNF1izrwwVSKmRv9rT7IgXcUccFnJUkDjF0qRXGrpfq47npuO654NyEBL7n6I0MnUzePEu+7yMZ61EHOYhUKUleyZ678yd/nMLRj8dZtG5qKcLrG5dN9wCypTuNJS7c35B3wq6YQ1f+RUheZqL3lLFKC+7FoXTfi/YxmmGLARddg82iQkzdkQiZygNVkDHBN/rwM0RBAxUaSJNKNrXT/K76a/9kx/I04c+qXpZPpZfzLts1DPBVHF+hSUmUa2wg9ELg4umDkmr5lTHvyTk6ylMlySnBi+FCRZf9ew0n3cy10W8wEF6mYoOSRevMNROEIZ7LpdEUYhEjfSWszLPd3N5GiONnEK49erz09LmEYCCBKuHY9TR2sGhvrgg4Fly06XKeGD3ytBY4gs4ZbZw2lg1Y+7tNEvd854Lc5b3nI2VhmN9DQd3BSVhMIDOx8irkpJHskGmIjv/Vm+SuhY455P8mD2bJ0e/aBfAUgattr2hlF7EI83UN1y/yrXp3jhEO+KqQYMu+YS9yCLySLVLMLMEQKaGCgAyJR2MyarUIu3PklXoCNmYYbmnHf+lCxW82SgEMIz16y1SUhpYVd+VRrGtG51f5Mt79fQ+hbf2lhOEEkdBv6PHtpi5TjnZAySW8p2p36/bde1WZPBisrDEzSEeXV4W19qWVAdlHsOSGbXctMS04C8m9zppLxn0tYeH00bgwfYSKdSZVpvOg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR12MB9416.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REhLYWVZN2Rna0lZeENPeHJjbnI0bHlmMzZGRUZVOTJaaWtLcGlsNXg1Mi9Y?=
 =?utf-8?B?WGdqbHZNRnlZUDFweldvQWdYZENoMEM1VUgwN2ZzYTJZSzJiVCtJODVDa3RJ?=
 =?utf-8?B?TUxKbGZvZ3lnTng3bTM0dHJySm5pVk90dEE5VGN4V3gvODlkd2E3KzI3SnM1?=
 =?utf-8?B?V0xrTlptQWdCdldWQ3BUZ25JNmV3UFVXYnhLOVRxK1h5Q00zOWdFR0ppUmtO?=
 =?utf-8?B?ZlFIcjdQZzh0QWF4S01tcmVSZXRlR3lCK3IvZjRUNTZWZ1d3V2lEZVMycm80?=
 =?utf-8?B?Wk9jbGxzSVFPL2ZpMjBwSytQNWQ3bVBkZWNuUjA3STlZWlk4cFpiQWxsQkxv?=
 =?utf-8?B?RzU5RSt2ajIwTHZDaUk3bnJsU1p2Qm1JcHVRNGdzSFhJU3QzQjg5T05uVTJW?=
 =?utf-8?B?NktQU0Y4ekFDMnNSY2JobGtoMW1ZRVF5eG1OYVpBTWgyS0xaOU16dU93SnJw?=
 =?utf-8?B?VmZSa0h3bVU5NWFFbmVGRzVmTnp3OHVwUXExMWxLTC9oMzBWUHVJeExhUTRD?=
 =?utf-8?B?Vm5oWFUxNUZ6cG5jN3ZnbE5wRWxRanVVajJMSWl0VlYySm9sa0RaWkdweDh3?=
 =?utf-8?B?SFJDTXZvSlJMN2JkRUFvUzhkcDdDcWF5dlhSMXpId0tGMFNsTmh6c0NsQnFH?=
 =?utf-8?B?akI1VlR0Y3BXN2o1YnIzY1EwNVpHNlRWWFNRUVVkcWhxbG1uZzRrNUVCaFY5?=
 =?utf-8?B?a09SalJFYnBLenJmMy82NHRXSGlkR0J1aFlaOENNQzNNOU1tUktpbm1LUlJ0?=
 =?utf-8?B?YXg0dFpXY3o2MWxLSGZuNTk5VGxVbHN2SUJwSEZEUTE4T2lnelNCRnJwSE9u?=
 =?utf-8?B?RzA2R3F2RnVlVHp0MExiU3hRS3FkWkxHaDMxOXVCV1ZSbW1yK2o0RFdTeTgv?=
 =?utf-8?B?aFJPT1hDYXI0Ty8yUHMyU0h3V0tvM2ZPdFQyVVkzeUROd3QvTjFjZW1hVmFa?=
 =?utf-8?B?UEVnMVhvL1Nka2V5cXNFMkI4ajhwQ1ZKcng0NG00VWhGRTlzQU94STZsZXQy?=
 =?utf-8?B?U3JnNDVzYk14QWFDMXJNTXFzd0Z3L1pZN0JCNGZGVTNRQXNpcDBpcWJ3OFYr?=
 =?utf-8?B?OGh4ZHJOWk83Z0FGMStNYWRWVGR5M05uR2kvaTBqZ1JQUlVwdzYwSDB4WmRJ?=
 =?utf-8?B?c3BpVGxKTC9lWVZIcGpvTUlwK2lsS1d5MmM2RFJ1elM1b1hNQ1Z5Uy9VaHJt?=
 =?utf-8?B?cUVwdmVKSElZTkNiYkRZRDhVVVNCck5XbFUrN2tibFpwUzF1OStmMS8yUlgy?=
 =?utf-8?B?dTNqRGJDc1BnUnd1UW02bUQ4VFl1YXR4ZnNock1ENGo0c1Z5U2o3OVFiTmNl?=
 =?utf-8?B?ZnpxL3VZZVBMZjRrbXRXRFBWcTc3ZlgvWk1SZjBvY25sTVFYM2dISkJFTktN?=
 =?utf-8?B?ZEFNc1dQYU5NWSt0YldlQm9mbXl2ZisvL1dyVzhnNysxdEFmenZDYk9SdjBX?=
 =?utf-8?B?ZXJOazNvYU1zalFJWnN6MlBMS0ZYem1sMjFLKy91bWFzVHlYZ2xBWjFlczZD?=
 =?utf-8?B?RnZuMWFtbTY2alVvdkxXdVBnYlBuU08zeDlVQVJEZDNjUVBHTFlYdnRtL2VC?=
 =?utf-8?B?dlZGek9QdFkxMkpoS2Qvc3hJVkw2djFyMXZmYTZIUTBRYlkxUFFLYmd1a0VX?=
 =?utf-8?B?ZW81dGo5QVpFTW0rcnArRHJGQVM5enM5eUpFSHljMmpKNEs0NUNHZDZ0V3Ro?=
 =?utf-8?B?N0lONEdWdExhTGFVdThBUGEvbE41MFhDWG0zSElGZ3FOTHVxMlNvTTZtYlVK?=
 =?utf-8?B?WTNiTStuTDVBK2gwQU5wMUJqa1d6aVhPbDBDMjFMWitZaWxnbkhJZkc4akEy?=
 =?utf-8?B?YWExSTBWYVdVOFdDdjI1cDZVdkVJTDFHdUNUeWFRTTlkcmREN29WVWVFR0to?=
 =?utf-8?B?bnljUVd2VlA0OThFWWZNMzFxbktkTklFM0ZqeXJISjBKNDQ1YTJMSENZVFFF?=
 =?utf-8?B?a0xuQzFUUGEvekNMSlFUb2diS0s0VmtqaG9QZXNTbDUxYURFa0V3OUZqRU1l?=
 =?utf-8?B?aFgxd3RtVjNzRitacVVRYXgrbzZHeEZEUng5RFhkRThub3dlZWtvN1hzSkM1?=
 =?utf-8?B?YlVGdndheS9EeWJaM2ZOc1ozSjFLQkhsY01pV0xGbjg5QWNTLzdDMEpGamM5?=
 =?utf-8?B?QjJxOURlbkoyUFJnQ3NFNzVPdEFpbTlrdnhmUXh1bDJIR0xEYnFWSHY0eWpQ?=
 =?utf-8?B?VmZhdCtvVHlGQmYxOW1EUVh0M2hGMyttVnJBbmdsTGxFSVlIMW10aG92bXJK?=
 =?utf-8?B?Sy9sSDNyc2VCbzZyZE5GVVpOemZQYTVJOGVFQXBpVFBsaytYaGY3UnRnTERP?=
 =?utf-8?B?TjFLVnFNckVYQjFYcHNXRnBJaUdHV3V4R2hJSzM4ekg2Y3Z2bktrQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ede8f96-0e6e-4e1f-cbf9-08de8519a276
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 18:10:28.2230 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BXyn+ogHE1VWe2xlZKXKH8+WCIIfbVC3AaUNkdZRkH9PRuHyD6taCpoeXxQY7YdeFcS6V6zDmZ8TZvPjT5ex3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8511
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

On 3/17/26 5:56 PM, Alexandre Courbot wrote:
> On Wed Mar 18, 2026 at 12:34 AM JST, Danilo Krummrich wrote:
>> On Tue Mar 17, 2026 at 4:22 PM CET, Alexandre Courbot wrote:
>>> On Tue Mar 17, 2026 at 10:53 PM JST, Danilo Krummrich wrote:
>>>> On Tue Mar 17, 2026 at 2:20 PM CET, Alexandre Courbot wrote:
>>>>> On Tue Mar 17, 2026 at 6:23 PM JST, Cheng-Yang Chou wrote:
....
>>>>> That `drm/nova-drm` reads a bit awkwardly to me and feels unnecessary.
>>>>> Even `tegra-drm` is in `drm/tegra`.
>>>>
>>>> Well, that's why I named it "nova" in the first place, but I don't want
>>>> KBUILD_MODNAME to diverge from the directory name and I also don't want the
>>>> driver name to diverge from KBUILD_MODNAME.
>>>
>>> What is the rationale for that? I like consistency too, but also think
>>> it is not particularly difficult to figure out that "nova-drm" resides
>>> in "drm/nova".
>>
>> It is consistency. But why are we discussing this, what is the concern being
>> consistent here?
> 
> I just find the repetition of "drm" unnecessary. That's not a big deal
> though and I can definitely live with it.

As I mentioned in an earlier version of this patchset, things such as
lsmod(1) do not show the source code directory of one's kernel module.

 $ lsmod|grep nova
nova                   16384  0
nova_core             253952  0

And of course, lsmod(1) is not the only case where this comes up: few
people know the source directory paths! Nor should they. But this
means that in many situations, we are left with an initial report
that only includes the module's basename.

We would like some hint about what "nova" means, especially
given the presence of nova_core.

So it turns out that a little redundancy, and even saying something
more than once, is helpful in this particular case. :)


thanks,
-- 
John Hubbard

