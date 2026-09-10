Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A64B5C79F9F
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 08:35:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6C7010F377;
	Thu, 10 Sep 2026 08:35:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pQrmAdN7";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013044.outbound.protection.outlook.com
 [40.107.201.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FB8210F377
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 08:35:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ACMCcFY267vJwZwBhJlMr7wsGEKoM0DsjXBEyjuT4PqluvjkoYufoN7KRXPsol/TE75GG1ocuYdQk47f5Tr9VwI6Qvs15LL4uWcouTdg7HkX8WPlLG4Y1ptGYAW8gq07Fd+AabGGxxOATx9tvKVQ7C60mLGUk5byJ3NoQRyXJ7Jmijx2wqGF0CGXNORnWSgSoopdrBjyn8ji5bsXcCOhLHZGSNlZq8V2+ZL6feHVknzr+EUHG8ykCOcla0PZIKP3838ELRoavDW1kp668N5UTVzFgBIT8o/yJ9gLrZpWTuavb08JoUXHmcUa8SgyULZDa9n73PuNJpD/MgFoZU/4Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WWeo9uHc51MT3Ua2y309PF83bFN1X9+EsWqi+WbE8Uw=;
 b=M+aAR8HBjuOcdd/jM3zuS2AD+sPOHDh5pqX4HoQMiRRme2xnI6k7LeVZjEx1j6x/gyBIMsZifEbEQ+M9Nw5/hML+Rep1dZtmYtbWeieafPA6Jko95SaZK6hnEQ6xoYWCQSR9sQSSsZZowJCurvAHYSK3KxvTfNkihtlYxSuUBpofDbu08vmCEOqhJzUoFUoA5VJvuYIChOdADglem89dpxPVzOW9kXmtOpPQSa18/2f9OM2FPWDnOc1/8YLXShtOrFV5hgx+fLJGnlqPi3QFA1HPEohtF9QuvjrQZQCwyxOplAzcuFSOjrhEvCpV86jxZbMEgX7WjM3JOprL47QBcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WWeo9uHc51MT3Ua2y309PF83bFN1X9+EsWqi+WbE8Uw=;
 b=pQrmAdN73o82RdbmM/zWYyYvkQ9Q208h4coShmOAfY2NBELxOCgGCCWF49esuaAZtYHv8m9XP9B1X8ZP5A5jlOJ/uxEe4FWynWk/Q0EBmEARCF0QHX7Xz9Ux5IW23Gy8npdiSLLhmcF/QWUkW1+WcG6AQXfPysC80RJgCmrqmpA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB8188.namprd12.prod.outlook.com (2603:10b6:610:120::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Thu, 10 Sep
 2026 08:35:37 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0406.005; Thu, 10 Sep 2026
 08:35:37 +0000
Message-ID: <4cfdbbf6-2bd6-4d38-98ae-957e9db9d883@amd.com>
Date: Thu, 10 Sep 2026 10:35:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] misc: fgds: enable GPU-NVMe direct I/O via POSIX and
 io_uring
To: Li Wang <liwang@kylinos.cn>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Sumit Semwal <sumit.semwal@linaro.org>,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, io-uring@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mengmeng Zhao <zhaomengmeng@kylinos.cn>
References: <20260908131545.105987-1-liwang@kylinos.cn>
 <2026090913-landline-encroach-c544@gregkh>
 <6aed7ecf-d125-40d1-a82d-1a7f62049605@kylinos.cn>
 <2026090924-corsage-shout-833d@gregkh>
 <33c9db65-fa30-4d34-9026-98144ce1ed95@amd.com>
 <9447bb67-96e9-43b3-87c8-db231051fa2d@kylinos.cn>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <9447bb67-96e9-43b3-87c8-db231051fa2d@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0432.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB8188:EE_
X-MS-Office365-Filtering-Correlation-Id: bc093c3b-ab02-46a0-a4d3-08df0f167d12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|23010399003|1800799024|6133799003|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: YsxIBc6iK/XKrxn1uItHZb3LmKz7KZ9U8rto6pFxYaf/IDhyseJKvwDfLlK7XwEIL9tYR45MyRXUrkEZWs2/Znps/Lp7wSvcP6IltejNj7IpfwWKhuTox79QBx3BacK/vvBVYlPJw2v2lWVvY24DaD5eGkS09nYaE+/EducF5OMUGL0qeqZpC9t9ol04dhqdjjckCO2k8jqr6oy3ZsLZd8QBObIxbOKhlIhYAAP9BegAjZoK0x7t+LP+EMcVFWooTuOCB2ryNL7Apm6USVRqTyQtnCFDDkkp3djC63tb67iTyMZ8fnIiEjHgVU0vVYE9JYrHX7tRVxHwuenA8wCTQBZBe9SUCMTUKogOpaeKKWYppbdWZJ32rjG6Lx+yAZkPlo5629S6m2g9r5IB/mf8qZBdRWCX5gAkyzJU9o5GkLGgk0k7cdbiUFajVMCq9lpDHHAlz8CiPDZBBIf20vlbeCROvIWZk7BfzLN6qzLdtHA7hxunURYczez4ktdkw6G62QQhayowsSmJYH8TP3dH/+94STULGfhifAEzXVTxZRQJq7SDvB7WF6z83DMrP1xbcwrrLAnPS+DCTSrkzvQX5bgeprlwGSkCezIWN8I/5KG+i+TOCv8qLvGe/S4XLr0vh/tisRkSnW/waYGl3M7q8qutcRt4JUxwWFeLJeuCENQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(23010399003)(1800799024)(6133799003)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0JpV0lZdlNIL1F0OGJRTGhodEFHSHZWUytxaWs2emdweUFMYjh2R3djcWhs?=
 =?utf-8?B?cFpsYVVoQ0VoUG9VVWlBRWZaYnpCcnczOVZUb1JZdGV0ckpLSUcreVM2cXBz?=
 =?utf-8?B?dVNOSXhlVzJONEZ4cWw3dkRlRlVrZFc2SCtiM2lCd21tdnpqZjVPT2t2SzFj?=
 =?utf-8?B?SHd2VXQ4V2l5TzIyb2FGRWlsYndXaTgyOWNxZTcvWEN1N2E1R2FzUDlQSzBs?=
 =?utf-8?B?WWJOc1AwcDdtNGtVRXNOakxjTkFrdTFhbko1bXFDNitaMjR1Tk9ZbkloTmJG?=
 =?utf-8?B?SWFDSGFpTmJWVGxPanNFQURZeEQ4NmFReUpBNWRXSU5MMnpUS01UTmRXaEJU?=
 =?utf-8?B?bGV5L0I2QXFhVUkzd3AwdU9LZ3g2V0ozMUh6TldiZ3o3K0NqbHprd21KWGY1?=
 =?utf-8?B?RUNHTnpIakoxWEZIQUI4TW5HOTkzNFU5KzEzWUlPTHJpWkhvNEdMTFlyWUts?=
 =?utf-8?B?TU9RN1d3ZWx0NTllcjNOUUcxQzBIc2s1WmxEaitNc2lhRlF0aC8wejVLS0Fr?=
 =?utf-8?B?cmRUWHlySEVSVFNiSXVpRjVmRFVOODZpNTRLa3BTc0doS1Z5eGFaTWM1TnJr?=
 =?utf-8?B?WnJZc3BINi9Mc0tWOTVMZnk1UGhaWTd6ZjhjK1hIcktrbUZxUWZrRnR1bFJl?=
 =?utf-8?B?MkZoWDZaejJxeTh3MjhQMU5xczEzUjBTaVNmQlEvS2VnRDVnYXh6bEgxSXQ3?=
 =?utf-8?B?dXJERTVEQlh2REFhaXNzTFBOZ3RGanJGL25lUnhyLysxMDh2dmczaGxRQ3RF?=
 =?utf-8?B?ZW9mRkFCalZ1ZnlOVUFTOXJlZmZsWFR2cXQyQnlPRG51T2loSEpBaXNOTmNI?=
 =?utf-8?B?VHhYYU9TeVFnNU4zUnVPSDBEQ1EySE5udnBuNyt0WWkvYUd6VEJOdUlXaTlW?=
 =?utf-8?B?SGhkYXQ2SFV0Mkk1WkNsWGE1eTZCb0JESnQwQnYyMXZ0T2VRb2NPS0drejRG?=
 =?utf-8?B?cHZQUVdQNUlkanNEalV2Ly8rVzFpbXZUTzlkM3JsckgwT3ZWc2FOUGNZMkFQ?=
 =?utf-8?B?UnRraWZGOUo1bzRQZ0JQWXlMdWpHWXBld0FHMHExd0VJWTgzYVY0enNIend0?=
 =?utf-8?B?djNrZ1lZb01jRzUwb0ZSYnJWd2pOSWxJWjlZNXBGS2tlUGJvWU5MZHNOaDl6?=
 =?utf-8?B?QWE0NUpiOGxlaUxQYlNRWmpOb25ETUpPZ0s4MnZwQVY3elhYTmFYbFpHMkty?=
 =?utf-8?B?NGN3UUFBNFRjUWQxUUZYaGFldjA4c3RXTzk3bGxXeTk1Tm5FaFdKVEFXOXBY?=
 =?utf-8?B?N0F6Smx1dTVOUlk4N2FyTW9OdFNncWQrZTY1aitVWm9wYTFXMTlMcVI1c1l3?=
 =?utf-8?B?SzZQdnN5VzJLVkJnZWUzYjg2bHJWUXJXdGxQTlF2alhGRDhRZWZ5RDdqK2pl?=
 =?utf-8?B?ZWpNRklXclpZbnoyUk5XalF3Tnc1QjB3OWE5blhKdWlqaWFGWkVZcWRvb1NR?=
 =?utf-8?B?c1ZMeXJaUFZnS0RFQlJMTmtKazU0U1ljbUtOanQzbnNEelNUS1B5bjEwbUM1?=
 =?utf-8?B?QVYvRFpiSWNVM29PRjhuWFA4b1c5Zm9wNUlXTmM1T251dm1PVnRRNWY1MWZE?=
 =?utf-8?B?MktxWlo5NndnSWxJRG1kRHNTdTJ1U0NtZ3lOd3c5UnBvc2F3Mzhldm1zSXQ2?=
 =?utf-8?B?YzF3SlF4eEtmSUNXUHE3K1h3bUhmN0Z4TllqUHU3VXF2UkNGakpDZFJRRlA3?=
 =?utf-8?B?Q0NvcXhtRzBsWmRSSWovdmRRNWtxanhEMFgza0trZEZsWUNEN1U0NDNCaGNO?=
 =?utf-8?B?eGxwT1JTRjZ6d2hKSFFIY2VVRGRsUmJPZUNVSElLNVp3aktPNkgxT2s4Y3hz?=
 =?utf-8?B?Zm5NUXBSK09FVXlpbWRuQjdIejlUZHdqUEgvdENNczV1TWxIRnM1S0RsTldY?=
 =?utf-8?B?WlNUbDU3dWttd2lQakdhV2Zzc3RTOHdpc3RWSmR5amFTREZhcVVoUFlzSzZw?=
 =?utf-8?B?TmM1Wlh5U1NxdWN4aDhYNXZQbzNMME4xMXVNOXpwbU9xYUNSeGM1a05qRURH?=
 =?utf-8?B?YnlWZkh5dlFMeXk4VjVVTGNKamRWTEg1Y0dvQjEvRkJ6aHozTFFOM0RUaW9B?=
 =?utf-8?B?dmpJOWp0L3E3dGIrWEt4UUxkUWVhSERIZkxvNFFEOHdGNy9XcU4ybXlObzc2?=
 =?utf-8?B?cS90TWpMbzJnVjJoLzE0SHhQT0FpMk5RNWN2NE5TL0FwZWF4S3VELzhJT2k1?=
 =?utf-8?B?c2NkNjhpWWpaaTcycmx4Y2N3bWNYb2hlc29xTTZrRjM4cTJNK0FhN2lIUUMy?=
 =?utf-8?B?bk5OdWhBQ25RL2ZTZnBhSjNkQ0xENGNIWk96QWNnUlVpSVAyeTRpdTU0OVJx?=
 =?utf-8?Q?Yb/IFYOIj/u59LfjkF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc093c3b-ab02-46a0-a4d3-08df0f167d12
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 08:35:37.3824 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oWJs7I1VF3jPn1FUL8nfHyksehhTBO6y44FUsZSE7F4/iMU47k+/5ryc2P6NyQlm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8188
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

On 9/10/26 05:57, Li Wang wrote:
...
>> AMD came up with something similar, but all those approaches are so fundamentally broken that we didn't even considered upstreaming it.
>>> And you are using this as a "bypass" for the normal accel subsystem,
>>> shouldn't this be part of that subsystem instead of a custom user/kernel
>>> api like you are creating here?
>>
>> As far as I know there is a patch set under review and even already partially merged which enables exactly that functionality as general feature for DMA-buf which is vendor independent and should at least in theory work with all drivers.
>>
>> I'm really surprised that somebody is still working on the vendor specific stuff.
> As you pointed out, every vendor has been inventing their own way and interfaces to support GDS,
> introducing custom kernel modules and proprietary UAPI interfaces, with varying performance that
> leaves developers heavily frustrated. Apologies for not making this clear enough in our commit
> messages, which understandably caused some confusion. We merely borrowed the name "GDS" to describe
> the functional purpose of fgds.
> 
> In fact, we believe fgds offers four key advantages:
> (1) GPU platform independence;
> (2) POSIX/io_uring interface compatibility;
> (3) Higher performance than GDS;
> (4) Minimal kernel footprint and UAPI footprint
> 
> Regarding (1), (2), and (3), please allow me to briefly explain the design mechanism of fgds:
> fgds turns a GPU memory buffer into a POSIX/io_uring-compatible user-space virtual address via
> three main steps:
> 
> Step 1: Utilizing ZONE_DEVICE support, we remap the GPU memory exposed via PCIe BAR into struct pages
> using devm_memremap_pages();
> 
> Step 2: Utilizing dma-buf support, the GPU memory buffer is exported as a dma-buf file descriptor (fd).
> Using this fd as a bridge, we look up the corresponding DMA addresses for the GPU memory buffer inside
> the kernel;
> 
> Step 3: Through mmap, we insert the struct pages corresponding to the GPU memory buffer into the userspace
> VMA, mapping their physical/DMA addresses directly. The virtual address returned by mmap can then be directly
> passed into standard POSIX or io_uring interfaces.

Well long story short what you do here is completely broken.

Approaches like those have been suggested before and we added both documentation as well as code to prevent such hacks from working.

Please see Pavel Begunkov patch set on the LKML which adds DMA-buf support to io_uring for how to do it correctly. Just google for "Add dmabuf read/write via io_uring".

Regards,
Christian.
