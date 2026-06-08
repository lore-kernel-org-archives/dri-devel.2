Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C202ECD8CA4
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 18:32:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1548A10E36D;
	Mon,  8 Jun 2026 18:32:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Un/Grdi+";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011054.outbound.protection.outlook.com [52.101.52.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C48210E36D
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 18:32:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PwP+0gRGsC8kMXhqM6vEWmU0ILgzuGrdGlFBH+KHFrnQPs840qyUJt+3rmZIVIOaT9VA8/vt+e6cAoZ12oFDgcbwkUSmMIAFrIj84mGopGLScmZMWEvapuqIrLm/4bBjmmNXRfsU0kvmQdIzADseX+RxLTJWPVAHJ6vile/2jWjxSZd0FVVGgYPKzanA63JUKjnS4gAluMx53zCmTxAT9JYdtDXYsBrXQ4MKVC+LEoirwjiXSOhwbTCBtwVdlPtSlC76bWmiOyU0Oyt65bD6DYw7yNdBsoWqsQyXWtja7XMTvZXWLoRAH+afYXO96Ii04/tNw+0K0nFmJxC7eHvsWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=578dP/5UhaHLBmJ8axiKf50SOMzNB8+NtWPJEL1JIa4=;
 b=RzItZkNwyRNvP4DhB+TiQfHOTcYLJxBgRT1GplTzdLLvn3NK9eNQMcF984k04JKff0XE6nChyh0U4nS10O1u9+iYenzIQNtzhbz5gN2lhjJcCs//cYgyH6QiNtRWvLpUrFqLqqHUawHRDJ9bvKh6nlawfyQjb7wx7i6N4wQntD0w5MhpXrMj16w2FSvHA5H4vCaPllF21xlNgr493JOLyG4oBZlys8MiBUFO9sRUPy0jP8UYMAxReOXMomjaxOAxQTjgwfyUwhclkEY+S//Xh6XPxXhqOY903DIzNKSexSWY0bPnUJ6Tb5ydEFq0CXL9jg0hLS+h9NtvtlZGHQowfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=578dP/5UhaHLBmJ8axiKf50SOMzNB8+NtWPJEL1JIa4=;
 b=Un/Grdi+7LyxX6Kj4pSzdw82eubyZbZqDs0l1WhPMgEa9Q/bYPXg0Z0YRm+JVVFVcLIvSV00vmuIvJwhNJwSrBrdfmxHEPrLW8gpzL4UQnhLd7VxTPRTNIS2qx0welKp9La1i8fgCcpx3qutWAH66ItQexvLc1+6nihuRlYm6hw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH1PPF8423FDA82.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::617) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Mon, 8 Jun 2026
 18:32:25 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0092.006; Mon, 8 Jun 2026
 18:32:25 +0000
Message-ID: <ea4e0541-3702-4014-b8f6-0746a148df86@amd.com>
Date: Mon, 8 Jun 2026 20:32:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] dma-fence: Fix races of fence callbacks versus
 destructors by locking
To: Danilo Krummrich <dakr@kernel.org>
Cc: phasta@kernel.org, Sumit Semwal <sumit.semwal@linaro.org>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Alice Ryhl <aliceryhl@google.com>, Daniel Almeida <dwlsalmeida@gmail.com>,
 Gary Guo <gary@garyguo.net>, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260608142436.265820-2-phasta@kernel.org>
 <95f4ae6b-9dec-4122-84e0-fbb0cdee9cb5@amd.com>
 <fa9a335196525adbc03ec21b2e05bb526e4fc174.camel@mailbox.org>
 <9d49c901-fcdf-487a-a733-0320d0bdf94c@amd.com>
 <DJ3V3OCLIK2K.3CYKWYNHYU6JQ@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <DJ3V3OCLIK2K.3CYKWYNHYU6JQ@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0145.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH1PPF8423FDA82:EE_
X-MS-Office365-Filtering-Correlation-Id: 404e920c-7be3-41b7-2d04-08dec58c4923
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|7416014|366016|18002099003|22082099003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: DuO7LF3REInbzREkQ4mD6e4vATESV3P5qH/9M+pbQ4MQKcSudtZ/5vKElNey7FgjoV2XlMelNKZZqUokdm0VmzpXCVk6p7YS1O3tJu6KyDwtM6klPn65iF6ASGt9DQ1NbBKTh0xC+lsgqidUEMeD4y7VNrT5Ui6QKEw/PR/WhK9mejks2HYMavuXuVt4ps9iOc4jgyckd0vdDWMZNiH9osF5Eajj2K0svo7pD/haXdNyXS1pBxOYubA14eL1XisM3x+VL7W8LmEJQtfZEp0sAUNEdTiplx/wqPxB8u5wWqA9ySI+vzZhbUgJx4oMJu2C3KzDMGUAV/0kA9yTE3liFD0yoBCtM5nlpFpvFS83EkEijXjPXEYBm5fnOX2D0wqpUVzcUUJSutMgYYUVf6e1GP0mVIELys53VV/cbRVKb3b5+LOa6BxPNd9virlczgqpWnvplGeBph0eKHbwD755UDqPW0bhBxpAWh1N+/XO9xmUsLqh9jsLy/FMgSWA2nDYR3pSNLBAKHY2kMjSV6H0hA/W8M4FH+bx0nXrf/QBwx8a/D42MH44aoU17aB7W7Ig9WvKNPB0vosmWcz+cgV2EaMSshyqADUU1mv+sIu6tKNJ4Rzk24kMc9qbiIni7Rh4e6kW1DdnKkJKKjrCV2PgyNz2hDWfcyEGTxgpwDOwzUFzIXFsd0YThC5Q7xmsNr14
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(366016)(18002099003)(22082099003)(11063799006)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUF3bWI5cW9ubUNoWmptU00rY25xbGNkeXNLblN3cTBBaGhVdUcyVGRVVFg0?=
 =?utf-8?B?WHg0eHl3WTdMY0ZoWVgwdlJHZE4rQklGTUdhQjRCZFBTbWhXM2FKMTBoV2xJ?=
 =?utf-8?B?b2FIdDlYT0IzS0kzWXAyR3hIU3Ixak85YWdncDZXSlQrTHJ2N0MxRW9XQU5a?=
 =?utf-8?B?ZkR1TTBvVEtvNzJwdVU5N3k5Yk5wbnZjL3B0dmxRMytFNHhwczFUUGVOOWtQ?=
 =?utf-8?B?dThHbzcwV21wTk1xMDQreXZKUjFjdVMycW5jT3pZVTVhSFdlZk1BWmJOT1R2?=
 =?utf-8?B?bTdqSlhEdHQrWkpOR3RKTWg1Vk4zdGhWRmN4MVA2dTlUNkw3TEJicy9BOTB0?=
 =?utf-8?B?LzhndFZMd1FSaGJValkybDdVb3J4bTB1YXgyTnozL055NFo0S1hqL3F1VjVK?=
 =?utf-8?B?QXg2SVVVOXJsZ2NycGZjN3VYbHJuZGN3ay9jaUN5amdlbk81ODdsLzBvRnZD?=
 =?utf-8?B?akhEQlIxTG9aRXVnL3R3ZXdZQ2MrYklwWXhDaVhOYVpILzBaWFpNZFdydzhm?=
 =?utf-8?B?UGZZNTFVcGp5cjFqVU5iNUZ5SzB6dnNUMExwVG5ya3lrbWlnOWpDb2NSbEtt?=
 =?utf-8?B?aDdHTzNnVUp4ZCtPV0lHMXlQVFVqY2prWEhQZFRrb1JDb3NTOWNpZTFsU2lk?=
 =?utf-8?B?UUp6OGJWbkNRUjlZSlRiazZsK0hESUFkQ3JoZTVMV3p1V1RSdGxnWVVoZTkr?=
 =?utf-8?B?aklrMmc4MmxhRzYzV1dXbGE5aVlhTVVLdVpzbkk4L01EZytQY2pjeDNuQnJx?=
 =?utf-8?B?c3ZML3lONmVheTF5ay9mYitQN3cvWHkzL1BNdEx0YjBFaVNVZGMwN3hOUFk0?=
 =?utf-8?B?ZUlpMDFLclQ0NkdaZ01kRnJWZ2FTcWNGZ3J2SERUck5FVUtIaGlDdk5iVEVF?=
 =?utf-8?B?WkExU0VTS1VjOVYxWU5kTjlzOHRYM2Y4dGRZc1dtK1lsN2FvelN1UmRXRklE?=
 =?utf-8?B?c2xUYzNxTjg2TVQzZlZpc0twUWMwUVRTQm1FOW01VDRaTmlpc2VmY3AxR1A5?=
 =?utf-8?B?eWdyNDA0Rkl2VXUya2RIcHJmQllld3F5bXdCb2tYdGthUU5SVjNvVjY5RUNJ?=
 =?utf-8?B?WGRTdVhsRHUrK0FTRTUra0gwZ1RJZy9pTWQ2SmFmcUJTNmREdjV1d1hLNjdr?=
 =?utf-8?B?a0R2OU5QWTg5c3ErRmxJVmZwTGN2UU12YVZSUENoTUVlUEFkdVNGWDhwcTNv?=
 =?utf-8?B?eEVwNHZRUVcvR1pFVDdwYjVNM0luREhkVk5zRGc4VUIrdURmQ0pTeTZUdGhm?=
 =?utf-8?B?Q0JvaG9aeVQwaGd2bUd0NkZ5Z2RPWVNsK3hSNWFNQzcvdEE4S1FpOVlkSU16?=
 =?utf-8?B?TXNQZTdYTmY4TEU5Q3lBUFBiUDd6bWl1L3k4T2dnU280ZE1JZXdGb256aFh2?=
 =?utf-8?B?Nm9MU05hbElGYWdnSnB1Y2JRMmZWcmI0eUxNcGdzbklsRkpxMkNCZ1RIRjBx?=
 =?utf-8?B?NFNPSThrVUhhaU5SUnBIRUM5azF5am15VHNreWVDMnp6dUJBZEtEd0tTTGti?=
 =?utf-8?B?QUhXejJLdWtiV1daQTBGekg5amMyQzdhT2xvNTVFMmY1R3cvcFBrRXUyMEs3?=
 =?utf-8?B?b2kzQnd1K2lsbW5MYi93YTZnL1FDbTZZVHBxNzBNbktmNy81YlIxOXQycDJ6?=
 =?utf-8?B?ZjJqakdEMjlrSkNLODdmUFlmcVU2ZzZtY0tkdGFBS3g5RzIvTDU3RWpKdUF6?=
 =?utf-8?B?RVYrY1hnUFB3WTR5c2ZWTEdWTC9oSXBkSUpqNllscWkxcE9PeTZYTzdIVGkv?=
 =?utf-8?B?a0NFY1NaY2pmOWxXSElYbGtZeGtMSm05YXk2TC9BOGx2bkNhMFpMRzQrM25K?=
 =?utf-8?B?V1oyWVV6NVpOLzl5TVJLT2VNcEI1Vm1EQ1JrRXR1ZkYwT1EwWG03dDl4QlpK?=
 =?utf-8?B?cEVOZWoxNXNqRWxvVVNxMVgyNzdOMWR0cTFCaCsvUURXeGsxa0RSY01UamQ5?=
 =?utf-8?B?T0tBSXFsb0wvZ2JRVkoyUFVDRjhBVWpwL2t2SHVBOVVVMTJqa2x3VlhHTFF1?=
 =?utf-8?B?VnNlNGZMaDdobUV6Z2xHMytyNzg3dVcxTlEvS2dOUDFpNDM1b0NIU2JxQ3Rv?=
 =?utf-8?B?TjhhU3RXWG84YXAwUENTWVEwVVhVeU00c1FFNGZscEZTK3NxOHdjb2pKU3ZL?=
 =?utf-8?B?ZEM2bisrUmZlaHJvUFVTT0NDajI2ZnFnRlFFYlN5R0VCNzRUR2k0aXJ1U2VV?=
 =?utf-8?B?Rlp0L241U3czUTVQb3NLazZqNmpzSmRUSXJvQURXUzVWeXdjZHVibmtWL0hv?=
 =?utf-8?B?dHdEcGtTVytvT2lxRHpyaCtWM1pENHc2M3FqUmwxRHhOSnVOZkcrYnFvUzkz?=
 =?utf-8?Q?sdQ61/G6fpBVxgoW0g?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 404e920c-7be3-41b7-2d04-08dec58c4923
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 18:32:24.9392 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xsNuLdB3XjD8b7AQ2nEyL/vC1Hu+5ytoOHhsxyBXSbrULuasTtSjgAG5wGkl33Bf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF8423FDA82
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

On 6/8/26 19:59, Danilo Krummrich wrote:
> On Mon Jun 8, 2026 at 7:34 PM CEST, Christian König wrote:
>> That's why we need the RCU grace period to make sure that nobody is
>> referencing the driver stuff any more.
> 
> Right, and that's what Philipp tries to address, the requirement to wait for an
> RCU grace period is perfectly fine if it is only about freeing memory, but it
> can become painful if the fence private data contains data also needs to be
> destructed in some way.

Yeah that makes sense.

> IOW, if a driver signals a fence, it is lifecycle-wise reasonable to destruct
> the private data that is no longer needed (remaining users only deal with struct
> dma_fence) and having to wait for a full grace period adds sublety and
> complication that can be avoided with the proposed approach.

Yeah, I've run into that when I tried to make the amdgpu fences independent as well.
> That said, I'd like to ask the opposite question: What are the concerns with the
> proposed approach over (pure) RCU?

Well a) locking inversions and b) performance.

For example the reason why we have the dma_fence_is_signaled() and dma_fence_is_signaled_locked() variants is because there is a measurable difference in some specific use cases for not grabbing the locks.

I personally find those micro-optimizations rather questionable, but the community agreement is that we should have them.

So my take would rather be that the dma_fence_is_signaled_locked() variant goes away and we consistently call the ops pointers without holding the dma_fence lock and the driver implementations can then optionally take it if necessary.

I think for this we would just need to replace most calls to dma_fence_is_signaled_locked() with dma_fence_test_signaled().

In the long term that would also allow cleaning up the container handling and simplifying the DRM scheduler a bit.

Regards,
Christian.
