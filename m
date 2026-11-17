Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D733A606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 14:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ocjuUH48
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 472A910E84D;
	Tue, 17 Nov 2026 14:50:22 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010061.outbound.protection.outlook.com [52.101.85.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 283AD10E67A
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 14:50:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vgQBcFn1SqzJ5OlA/CJaQVKMvNhdKYGF9gUxLk9e/PtL2TLomGzEhOrxn+LKxVAK9UlCldH0RgCyrFk3VHerH1UfapUmLZLN4u32bli3TRVYk81u4TAdVE9eMoBw0z9VqQN4vMwVCvnKfVfeVoO2+fvjg1CvGTFnhOBz+jKTDGL4JFN77AbzYJO3/4t7F4g+PTodVSY2arsdQJDC2Iv5ZIry7Pbh0O9dF6VT2qL0K/g3YpJ0zaq3XDYWkAMVhwnvzQnICyCIrmKi8yOqRtQeGYFXrcpiPpqIxZAV8HmXqmiANq5351jo+9Xy8GRflln5ArKf6H2uM5oYoOid9CYoqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=28BSljvZHvV5aeHlZrTrSFybbvN7kygbCT44r+eZkMc=;
 b=u+9jyu+RTbYboaHqzBcQBtb2LAYzOalvi9HllnKxaYmFCmbB6bXSvib98gfy4CDAxuz0Bulgb+S7PQw9g8T3qdXiOfhdYpQFwD0uKL8f8KaMokJty5HTfR+QfdvrS0ZLfJzcH26YBNgU0sMJcdO72IARzyeJ/ilGdlGAX/cyVDvfEnApi/fCelLfmRf/3tZGwMElgfHfGYB1bjUOzQHxceEgnDHlY01CmNLNx2nx2Bi2Ioqs1zPKmathLrGUyGFiCn/Vj7irsLuh6bL23vSPhaMJWJSyRflYzoHuDp4QRl1kjCzcOd3IIPrXzJsEfax3hpVVaccBDDGSDNA3a4lf1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=28BSljvZHvV5aeHlZrTrSFybbvN7kygbCT44r+eZkMc=;
 b=ocjuUH489hv9YE+pcJW8SL+kzGts75upQFO7O/JAtFuQGLFTUseaOKKBAU1gfkN/7gYf/KxA7GgMxd+6OFtj5hZC0iK+dW/LdO9Yl1wV54xu7rSHPQnWluXElyNDGvqDxUuWchchQe6qdeBehoeacsrxP3VJw2aDPNdRdrnw7+M=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by FT1PR12MB475569.namprd12.prod.outlook.com (2603:10b6:170:33::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 14:50:13 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 14:50:13 +0000
Message-ID: <8da4a8c0-1740-450c-9cf1-1a7b21d12997@amd.com>
Date: Tue, 17 Nov 2026 15:50:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: DamFence: Remove warning about unsignaled drop
To: Danilo Krummrich <dakr@kernel.org>
Cc: phasta@kernel.org, Sumit Semwal <sumit.semwal@linaro.org>,
 Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot
 <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261112101015.528127-2-phasta@kernel.org>
 <5d466f7c-2e70-4011-be04-9ffdf877b915@amd.com>
 <49298d3a328c1695ea27993f714c20b8a1c05f32.camel@mailbox.org>
 <e2ec8a39-56c3-4274-91ce-60c273904877@amd.com>
 <ab99758408df682c68a3792cc3014b77d6e1c8ab.camel@mailbox.org>
 <c2dd46ea-94d8-4720-af37-897c91809338@amd.com>
 <DMXJ8TBSZJJ4.3HG0OJDI9URTT@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <DMXJ8TBSZJJ4.3HG0OJDI9URTT@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0166.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|FT1PR12MB475569:EE_
X-MS-Office365-Filtering-Correlation-Id: a1e2e5f5-c122-453f-3357-08df44ba15bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|7416014|376014|366016|18002099003|22082099003|11063799006|4143699003|56012099006|261102123227099003|261028144727099003|261026140227099003|261026121527099003|261021121427099003|261022105027099003|261022115727099003|10067099003;
X-Microsoft-Antispam-Message-Info: hlVWdcqpSDnC1WX33FZtMy7/9K4fXTQMmWrfQpUoDf+qaom2WoiCruQKm8ZuMFBXs9RVx/qoNPVWAE//24s5MwED1rtV6fA5/ZGNImtMXZEpTSjB44Fe4AMtZQPhISV+PEHnm+gx8riZMBFiWWy40nsIzj26ZvQXALZKcF31VAUV3Eki04O1ZZIHWGR4HHyv0uTjulxSGNTORq9yGPOXHy0Fid02x/upEizWps5qOV+RgwZnEFtbok5xVYK0/Hv9agqnM03XHO0gxTS6neOX9gV2+z+BWLiXaViEAlqjhigZLSuoIGktUgCaLd24pC9+y/qT5BHiBL3MfFp4sI0SnJWsYy7DZCH8CbXluFhDzfvNh+gUlqMdcBJGAh9AAdEJmahuzNWfwh6TTZbbyjzDuB29FZkysQHr+K3at3pTuyoFj++E9ZOgFpHt9LeGnF6Mwn8tpKCdQT2GUAuEHWrsRMym3Jvx1VHn4nogYUqmYrk9CaH85XQx4ra+b8XgOt1Xe/gDkymOzipSDTiXvQAVlzRHFC4nhv35ZuKHTuGIv3kbW0mI6uspuIPDP6CkPt7urif+BHYALZq0TlLCvRNVD87muKKy4uD4MD+ZIkQJHauinOS38NNnPVredeF8O2f3ZwShqQHzSp9PD6Z6KXpfkoC8c4l7OggVYX6I3ecniY8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(366016)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006)(261102123227099003)(261028144727099003)(261026140227099003)(261026121527099003)(261021121427099003)(261022105027099003)(261022115727099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1ZNSXd2anBuM0dnckcraGNqN2R0Z0NmU2tPSkZzMjBUcW5PaVBncVo1S1BH?=
 =?utf-8?B?SWhTQ0llc3NoZFZvRUttaVJEd0VuZmJObjJ5REtBMWhvTS9UVnd2UlZjc1pP?=
 =?utf-8?B?VGw4RVUxYjRRQ29GMThPMG5xME1CYTBsM21URndEd2srUnFzUGNIbWI5V3NT?=
 =?utf-8?B?RnNjN3lOcURWaVpNbklXeWE5ZWNSRzZnNjU2NXVVa0JaSDQ5U2psZFpYQjlB?=
 =?utf-8?B?TGxWbHY3dkdMUkh1ZGdxWjkvaEJMT0U4ckVaMDRZTkJmSjZqZEd2S0hPTy9h?=
 =?utf-8?B?eE41cGxkWHFOcFdzQ3BZUFg5V29xdDlGV3hBSEhZRnNzZm5IVzZhYlRjZnBX?=
 =?utf-8?B?MmhTMXdiazFvZTRIeHMyV0JVRHJBTTkrSlMvd1JZUzh0QjVGUW5XeTk1RVpq?=
 =?utf-8?B?Z0lTS2poM3hnbFFMeklobmZWWFhGRWZEcmdVZVRmenora0luR2Vudkd4V1lK?=
 =?utf-8?B?UXpDMjlTM3JuNHBTdzJHY3NSOEZNME0vUitMNGwrdnl4LzlhczFLajBYT0w0?=
 =?utf-8?B?Vlk5aU90L3BhTWhGSXlXNzBrK1J5L2psaDlTMVF1R25VVUwyaFQ4bkJtZncv?=
 =?utf-8?B?ZFdRWFU5aTliSndhZC9QZU9pTGRGSXl6bmtabnpLdmVYaGU0WkZ4aEJ1Ump6?=
 =?utf-8?B?RncyY2JzR0V0MDZqclBRZ2pDbm54dGUzbmZwR29mZUl4NzgvVSs2VFJDMWpB?=
 =?utf-8?B?WGJFZ2ZKdnd0UUlvN3AvMk10dEZBTFNJZXJDRzZGczBEeUNsSWVDQkFjdHlW?=
 =?utf-8?B?c0E3TnVLeUJwTjRNVnZLM05VMnpwUVRaQy94ZTdpTkhWZ1NVSE5DeWlSRk5D?=
 =?utf-8?B?RnRxQjB4RE4wdDZxanVCMXFuM1FGTE5wTTRoaHlzcU1ud0RmYkREOWwvVndF?=
 =?utf-8?B?S0V6Sng1UDNhTUsrNUdvdGx4c1hvRVBBYUVMR0RGbkhqQWtkTkR0TVY1Ti8v?=
 =?utf-8?B?aFBOQ2R1UHNLL3lvZVF1eXplUU5BbTF1bkJMOEJnZ2puSFBiNmJYaEdPVVpw?=
 =?utf-8?B?M2JlOUZJUGxMZVpJME8ramtWUVB2dG45SHQyekVVVTZ3VWFOVTlleDRBMkdY?=
 =?utf-8?B?MiswWkxRNUxFUEh6WTVpZHI1MEdBS3BmT3BxREl3cEtMbWN5SFA4SFNxZXZh?=
 =?utf-8?B?UVFMbE13bXMyS3BkS2xGN2prN0dMaTdzMEpaZFBIbjVqeU1wdVowU05ocS8w?=
 =?utf-8?B?b2JwL3dhU2twdU9NamxQZ2pOYkRuK0VTK251NWhmWlVReCtmbk4yZTdDbmQ5?=
 =?utf-8?B?VlI5dHAyL1ZDcE1HZTBCdUg1blVQOUJPNFF1cExTTFFMSGw3MVZwcFpTVEcv?=
 =?utf-8?B?TjdYZTZ5RkpKNjBxL1pIQVFpZ216RCtpM1NndXZoNVYwYkFGL1BBcU5MQ1RL?=
 =?utf-8?B?a3EvVlNvWCsvTzVweXJaYlUwTjFuNFJnSmdwVGRvYkY1RjFOZzkxK25mSVky?=
 =?utf-8?B?TFZiZlJJUDhBaWhDaDJLNjFwMk1HRTEwaFFmSUlCWTd4N3dRTGlKVXpYYzNS?=
 =?utf-8?B?Y3ZvN3NEOGZrTzNjMGxDL0JBVWZ1MzB0UlBnOFlpL05xR1E1dTVSWkZJVE1i?=
 =?utf-8?B?ZjVtN1llV3pBVmVzbWVkVXRnbU9wVDlwWWNYVzR0KzUySU1YRHFkZmtMZFJT?=
 =?utf-8?B?QUg5Sko4RE5McndCQjJ5VWdaZ2JITXR4M2JSSlArVEJCd3BvRHMvdTdjb1hN?=
 =?utf-8?B?ZzVqbVpWeGZDWGdsRS82eFMveE1iNWNGcFdta3pGY0tWMjlPdzMvYjN4NC81?=
 =?utf-8?B?YldlNXhjS3diQWlZU1VKRDFxK3ZHeFhPMFA4OGo4VU9sUXo1TE95ZW1hVDM1?=
 =?utf-8?B?dzBUSWF1eVYyOHZORXNVaW5GcjMyVHp4R1N6aUcvWE1UVVgxYkp0b3lJZW9X?=
 =?utf-8?B?SzB3VG9WWG16YitHM2YyM0FYaTJUNEhGYzAxUFllVlN3eWNISTU3ejBTbk5u?=
 =?utf-8?B?amxRYkFhZnE4eGVaR2VYNWR0dHgwK1MrdkNPSGc3WjdpOEk0ZWx3WjdpU3Q2?=
 =?utf-8?B?MzhKdk5LWVg0eFhqbXZWZ2tIOENNVjZTWE5uaGZXYXhNZEw1L1RlcVpvTUN3?=
 =?utf-8?B?Z2dvVGhFb3FKamV5a1JBVVczV1VFY2VhR3RkeExMNngrbWNWOTE3TXdpQTZy?=
 =?utf-8?B?VVdLR0N4clVsckczNjhhZkEyQWVTNEZxcjJOTlEwdTV1TTFCL3I1WGJlNURN?=
 =?utf-8?B?MmI0V0t3VWRCNWhFZkFmWWxaQWJSekQ5cEpJQ1ZybHd0b3dSYXNkS3pRYitV?=
 =?utf-8?B?a1RtT1RVOGVNL3hXTTl3Q3R0WUJTNk4vODRTU2ptOGsvNWQ1UEh4WCt4QUpP?=
 =?utf-8?Q?LWdtpnOmzdm5IqLbks?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1e2e5f5-c122-453f-3357-08df44ba15bb
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 14:50:13.2544 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XWeWHmex5SNgt6QXR3EvZu944l1f3gH4JXHKbLiAR78eb+Bks0cFXwvV05b8bo0J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FT1PR12MB475569
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

On 11/17/26 14:50, Danilo Krummrich wrote:
> On Tue Nov 17, 2026 at 2:40 PM CET, Christian König wrote:
>> On 11/17/26 11:54, Philipp Stanner wrote:
>>> On Tue, 2026-11-17 at 10:51 +0100, Christian König wrote:
>>>> On 11/17/26 09:24, Philipp Stanner wrote:
>>>>> struct DriverFoo {
>>>>> 	f: DriverFence<()>,
>>>>> }
>>>>>
>>>>> impl Drop for Driver Foo {
>>>>> 	pub fn drop(&mut self) {
>>>>> 		// Signals fence implicitly & automatically.
>>>>> 		self.f.signal(ECANCELED);
>>>>> 	}
>>>>> }
>>>>
>>>> Yeah, exactly that is still a bad idea :) See the HW eventually
>>>> doesn't necessarily stop doing DMA if you unload the driver.
>>>
>>> I know.
>>>
>>>> So just signaling all fences with ECANCELED is not enough.
>>>
>>>
>>> Yes. What I was trying to tell you as that you have no way to enforce
>>> this in Rust or C.
>>>
>>> dma_fence_signal(f);
>>> free_driver_resources();
>>> // Driver forgets to stop the hardware. Memory corruption occurs.
>>>
>>> You see? Neither your BUG_ON() or WARN_ON() saves you if the driver
>>> does it like that, no matter the programming language. You cannot
>>> prevent it.
>>>
>>> The only one who understands how the hardware works is the driver. The
>>> only one who can stop it is the driver.
>>>
>>> In Rust, the place where a driver drops its JobQueue is the same place
>>> where it has to halt its GPU ring correctly. Enforcing this cannot be
>>> done by dma_fence code.
>>
>> I completely agree that we can't fix things from the dma_fence code, but it is our obligation to tell the user that something very very bad happened.
> 
> That's the point, we can't infer that "something very bad happened" from
> dma::DriverFence being dropped unsignaled.
> 
> In Rust we use the RAII pattern, and drivers structurally embed a
> dma::DriverFence within the struct that represents the corresponding hardware /
> firmware queue (e.g. through Jobqueue).
> 
> Consequently, if dma::DriverFence drops unsignaled it means that the destructor
> of the structure that embeds it (which does the required HW teardown) did run
> already.

Oh WOW! The signaling state of the fence should *NEVER* be bound to some object lifetime.

That sounds like an extremely bad practice to me. Just imagine anybody grabbing an extra reference to the HW state object to inspect it for debugging and the fence not signaling because of this.

Signaling a DMA-buf should always be an explicit operation drivers do because of some HW event and not something which happens as a side effect cleanup because your object runs out of scope.

Regards,
Christian.

