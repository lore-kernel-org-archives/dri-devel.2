Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F28606A32C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 13:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=qyVMq5QR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77CBE10E607;
	Tue, 17 Nov 2026 13:41:13 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010025.outbound.protection.outlook.com [52.101.46.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F83010E607
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 13:41:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ErmldmCBZ0BgFQJsqbYs/FGKBHDxQAK5oC21xqQ9PADFQLAmAgKVqRqpitLWcnKXZ2JBoGSmZ+nNF2aT9xhqOamxXp3tlIFEyU56OFwsN0k9gRBPRNZynXwsOpfz6AMHWwPRM5bZq0sICcwL2SQE4uKW2LnBCOTdqafp42uM9HU/miAnQ3Fb5RGeOHTtNBqciQU/fjQA12/vzVA4qHloEVY+5s9s/jWKhNbmefuxCrgl0VKKRjBb/PdBRwOaBHAx4X59/NB2Oi4f0g4L+P1/u57M/PT6uLwIFs/yhZm4+sgnwpC8FSN1f3KKg/YRP0xg9Spq6EEDh5MWvYvs21MJpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=034xZ/R3Rbx6TAQYtSn2V1M4t7pkq7VAG2DeR9T79A8=;
 b=qJYRYSzWgeEiAcqIdNpvb+i69bo/HAWTX9U4l6L06X7loTNVUA/L/pXWnGzENxGNA8qY8tcmtl/Fz1IQZb9PXUhU5ap1pOXr+lDhnAENs6j4guFbfADl6YLJzGie7elJoOXJ37cU7DHgMk3sgKk1vZUBxoaqd3VIB56s3zFdUe04agsM4OS8UUHlzcxqhdJLqpG+gGh+K/OtPFb37lwqNvUh0KNMe2Ylc1kW8c5a0SJM4CHVQC22zK6z2oiLXxnR14nnPx7P3Zb6b6EIiVmweN45bLm3zdH+ko1J04TZRGVA9fEDza45s7QE/owqdU1KmiRqSvOlrkl+c4iQyYy9wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=034xZ/R3Rbx6TAQYtSn2V1M4t7pkq7VAG2DeR9T79A8=;
 b=qyVMq5QRh69SIKNQYKAnYo9cHabuDoFVkfWnbP3ToRfxeF7px931Kk1xyBvN51z7xWbyYSx60ZehVtKOLpdob9kCJWbDaOOqP4G8TQpJWU4yw1PBXuRl4PrTfufmNzCMYPs3L8ysaQwpUcVXuwbrU4VamcipIpoBeMLwNM71+4E=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS6PR12MB317717.namprd12.prod.outlook.com (2603:10b6:8:414::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 13:41:05 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 13:41:04 +0000
Message-ID: <c2dd46ea-94d8-4720-af37-897c91809338@amd.com>
Date: Tue, 17 Nov 2026 14:40:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: DamFence: Remove warning about unsignaled drop
To: phasta@kernel.org, Sumit Semwal <sumit.semwal@linaro.org>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot
 <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261112101015.528127-2-phasta@kernel.org>
 <5d466f7c-2e70-4011-be04-9ffdf877b915@amd.com>
 <49298d3a328c1695ea27993f714c20b8a1c05f32.camel@mailbox.org>
 <e2ec8a39-56c3-4274-91ce-60c273904877@amd.com>
 <ab99758408df682c68a3792cc3014b77d6e1c8ab.camel@mailbox.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <ab99758408df682c68a3792cc3014b77d6e1c8ab.camel@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0185.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS6PR12MB317717:EE_
X-MS-Office365-Filtering-Correlation-Id: ffafbc56-686e-4c52-f273-08df44b06d0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|7416014|376014|366016|18002099003|22082099003|921020|11063799006|4143699003|56012099006|261102123227099003|261026121527099003|261021121427099003|261021135927099003|10067099003;
X-Microsoft-Antispam-Message-Info: ZoSbGaTVmKFEGYYqNCWH9Y1IY3qnZJQ1uPwQkeRjFv5UeKQRIEG521WaKfhdnU4PuwdsZ6en2fnr+8nEf2Br4VqUMz8fOSd+e8SaJOXVpfhe7NlCbqCMWzAafhIlORUTNzL4Nqo3RRQw7AOL6LqT4QOlaAvteE4KRBhhcR24Bzs3LF4OeSbLKY/hbQlpgMfYwChG0TuV1iNGJhm/SmQWiWjTO5UCmITFDsEp0H29JtTrw+s7728Sf4PrbnwtZcaxU3jlHsBgFTU8KMEKln1d6+YNnfAjbTltl5chKEe67SYETkbWqfWwq8U9OoUQfakHgzyJqDtSF8OPdECtnkNWK/c9dmpnzwAHN5rAHyiUwCSkV7xif+thdYMr2PT1AUMOrv1MVC6qsenFc/vraIY6KtfFakrBglVtjtbT8msyJWjiapKHNDjr/x+cBbBjBxL8bJMMPcv3r3KGIpYwxu9ftfGxHpHq39vEs89QFz/PFTVPOaZLfnaHj6TPopKDOhjs5wHdNGHB1q5ftRKOoIrtuLGMLDNNEn6ThRBuO9gyR2C29Rakr2qbzW0bcPaRcI/Xv3tvMe0tuV/7fZVKHq2hvyFlFbv+oqycKfnBkAlQlOFiov8rOibfOYLhEyXxHYS0pwsu1AH1nJaPuHHF0mqP4mk69o5XsTyPC4JZFhS7jv5mHdNCEzyuJlnS7M6tZpGg31oAysl0hWcEFkSvsnt3bQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(366016)(18002099003)(22082099003)(921020)(11063799006)(4143699003)(56012099006)(261102123227099003)(261026121527099003)(261021121427099003)(261021135927099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmhyUlpydXFIODA1Nm9ETVdxaUlkYnYvK1B0R3RaNXh5amhqY2RYbEIxYkEy?=
 =?utf-8?B?Z250cVRpR3Z5QmJpbGxXL25zQmVVR05zM3VLUlFZUWx0a3dQejFhaEpiOFY0?=
 =?utf-8?B?T0NJRTc4SkR3Szc5THgyS1JoWXRRTWJTK0prR1Jna0tvN2tKeEZydUhkN1pi?=
 =?utf-8?B?RkJseXU5MXpOQzQyNklQZytoSXYwa1pzR3NNOEVFQVBIWlRYY0diVXJDRDRl?=
 =?utf-8?B?VWQvK0kxK1NZdnJwdGZ5S01MelZKWk5SSzNKdm0wUFhoSnZGWHVybWd6eHdm?=
 =?utf-8?B?eThMOUtYUGttdWpvWjhIQ3NyMVI3VjJOMCt4UjlXQzVKUkU2T1QycjRlZWhl?=
 =?utf-8?B?VFB2dW5pNWZxK1VFazVWQUtjZXBqNHA0b2M5UEwyYVY5U1Z2d01QRzkrbmlC?=
 =?utf-8?B?cktaSXNucnNiVTFQNEROSklBc0l5bHRxdkt5enJxaW1HNkMxTEg2Mk9SWEMv?=
 =?utf-8?B?Ulo5N3pCaFJteXBXSTNkbGQxVjZHbHkxYzZkeGF2azVGMVVva2MxUGNmSkxI?=
 =?utf-8?B?SE81alEzRG9lSTlkZjhmc1c1NHVONlVGdWRNVVlkeVJTRUlGN2M0dUFybVR3?=
 =?utf-8?B?ajAvdVZKdXNCYkNLR0cwN0VNZFAvMEdIQ2IxOTZwOW9BYmR1M3RaZm1SNnlz?=
 =?utf-8?B?SUdvK2FmdFlHV3JZSUhTTFNadHBLblBLUXYxZ2tGVVpCcy8vNGg2Z3l2QlZI?=
 =?utf-8?B?VHJiQjgzSDN3TnVoc3d5K1dSVW9DRWcxRUViQklSaHdZMU9zSVdwaHBPK2Qz?=
 =?utf-8?B?UWw2N21qVjJSVkJ6ZTdkZWM4OFVIRnI3dmgrb1J4NW5SQVB6NmRJZ2xTVFdX?=
 =?utf-8?B?WGRQRmFkQnVBdW40SUZJRDVYYW03dkRDcXplaTQvdXBkRnAvd3g5KzVXdDNE?=
 =?utf-8?B?ZlZNOXZPVHE5b2d3T29tQmtnZmFKYlhkTjU3WG83ZlR5d2EwaDBWRE5jYWdE?=
 =?utf-8?B?WmVtUXV1ZTVzY3BidXhMQVhFSTdpSUxoaHIrazgrS0VHWG9TWUFrTXFJZGlK?=
 =?utf-8?B?djNiUmtlZHk2czY0TmZzMENQWXlLTVJLWW00SWYwTzFlVllZLzRwM0Mrd2pv?=
 =?utf-8?B?N2NkdWNlQmZXS3M0eVB3dGpkTW9LNGtiSitNUE82VGxjY29wNTlFUjNJLy9m?=
 =?utf-8?B?MVB2N3RraWYvL0kxREJ2OHdNMFhydzFqTGtHUFVQMzZKbmo5ejhQai9Gd0FN?=
 =?utf-8?B?TU5reVE5Mnp6UFdtejlCamgxYVg5TkhsNElNdTQrWDN3VUYwRlU3ZGs5cHhL?=
 =?utf-8?B?Unk0L3AyazJtaEhxMEoxUWxqVHFxSldlWEcxQWY1TnZRbEJ3U1V1V3BJZFBX?=
 =?utf-8?B?Sy9tWjd5S1RxUmVjZ2VmOTVMTG9kUXQ4RFlBOXU5ajRRTXUyUmxjSmxlZSt2?=
 =?utf-8?B?WjJET21Pc3NRSWU5eFRIL0tHREZUMERwNEl3azZSbmQyQ00yZURHUXJpZGRL?=
 =?utf-8?B?ZE54UEJTOVV4VlZjbEU3WmJjbFlVSWx2ZzdWdWlSanVxVUxUWi9rbE1SVDVC?=
 =?utf-8?B?eFBSN1gzZVZnMVBxaEgzVW9DNE4ydDZFRnJoZStneERZb25CRWc2N1NpWDNt?=
 =?utf-8?B?czhCaTJpZTJUaW1Pc1dzWStlVjlSNnhzQ0tkYmZJb0E5QVlQYnNNdVl5RHQv?=
 =?utf-8?B?c3dMaFBFZUFYQ0ZXS0VuRkFKVGF4NHRHdUZGcFlsTHdIRUFKUUY2S2VnUEQ2?=
 =?utf-8?B?WUVTM1FxdTRUS2dMWmFpeGNVRnl2TVFBd05vcUNQZ3NiTjc2bkphYUd3TUx1?=
 =?utf-8?B?cHA2TUd4ZEV3ZFlpZ2prVTB5ZEJPU3ByNU5oY2pSemt3d1ptZWxCTDlXME5Q?=
 =?utf-8?B?SkVZK042NHVMdXJkUjVIRDRicHl0R1BrYXZWYkJzcHFQckNDaVhQcEluNGJn?=
 =?utf-8?B?QWhQQ01SUUdxSDlya2hlUnQrN2lJWW5WeTk0ZDJIUHcxZ2FyQWtvZTBWOGZ5?=
 =?utf-8?B?UnkrYXJheHZlNzFTN3NVcGNFdVVBRDV1VzJhbkxreUE0S2MyY1BHMnZvcjZr?=
 =?utf-8?B?OW4yTEhSVUtIWXkwZFlyZGlCV1lYejYwRENFdHRXVkVwbUZsT2M5dHhZL2dx?=
 =?utf-8?B?TkNtYzR0dmJtZjl1R0dTZXdSOUpBdjl4ZHo2KzVBSVVUTUZBYUVDbnFIZm1N?=
 =?utf-8?B?MG4vaWt0Y0d5dFo5L05xQ3F4Um9BRStiVU5hMnpZeUxhNFhvQkZxMHNKc2hx?=
 =?utf-8?B?RFRDb0t1UkRYRGVhVS81UnFqT3hEYjZGUkhTYVlHd1gzMmFiV3NmSG1MZnN3?=
 =?utf-8?B?dStvNGJZbkVKNXFBTk1BN1BqeHBzSk1tQ2RYa3ZRVmlnc3IxdDJZT1ZXbjgr?=
 =?utf-8?Q?/NlBj9vqeDfBMTL3H1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffafbc56-686e-4c52-f273-08df44b06d0e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 13:41:04.7177 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8WKbs4wJUmXvH9X7PyiL278kF6/Xjps/RZJufE56wJPUnVxXbdfQe1QBqthmdrAH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR12MB317717
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

On 11/17/26 11:54, Philipp Stanner wrote:
> On Tue, 2026-11-17 at 10:51 +0100, Christian König wrote:
>> On 11/17/26 09:24, Philipp Stanner wrote:
>>> struct DriverFoo {
>>> 	f: DriverFence<()>,
>>> }
>>>
>>> impl Drop for Driver Foo {
>>> 	pub fn drop(&mut self) {
>>> 		// Signals fence implicitly & automatically.
>>> 		self.f.signal(ECANCELED);
>>> 	}
>>> }
>>
>> Yeah, exactly that is still a bad idea :) See the HW eventually
>> doesn't necessarily stop doing DMA if you unload the driver.
> 
> I know.
> 
>> So just signaling all fences with ECANCELED is not enough.
> 
> 
> Yes. What I was trying to tell you as that you have no way to enforce
> this in Rust or C.
> 
> dma_fence_signal(f);
> free_driver_resources();
> // Driver forgets to stop the hardware. Memory corruption occurs.
> 
> You see? Neither your BUG_ON() or WARN_ON() saves you if the driver
> does it like that, no matter the programming language. You cannot
> prevent it.
> 
> The only one who understands how the hardware works is the driver. The
> only one who can stop it is the driver.
> 
> In Rust, the place where a driver drops its JobQueue is the same place
> where it has to halt its GPU ring correctly. Enforcing this cannot be
> done by dma_fence code.

I completely agree that we can't fix things from the dma_fence code, but it is our obligation to tell the user that something very very bad happened.

I mean that is what WARN_ON(), BUG_ON() and panic() are essentially good for, they never fix anything but just point out that the system should probably be rebooted and driver developers informed.

Regards,
Christian.

> 
> 
> P.

