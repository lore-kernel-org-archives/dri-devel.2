Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA100606A339
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 12:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=ekPhL/ct
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 056981123B1;
	Thu, 19 Nov 2026 12:56:17 +0000 (UTC)
Received: from CWXP265CU009.outbound.protection.outlook.com
 (mail-ukwestazon11021137.outbound.protection.outlook.com [52.101.100.137])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 627DF11238F
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 12:56:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UpsmsihAtFPoby3H/o3ztLqoU/LDq9jhLfTxXg6WFxP2Bm65DBvZaaCD5st6MDQoRR5bsmiLGWCew9wB9vbe2k6j6Okq1CgxFEhhsAFLOwhOt/gx2pfMQlgy+3CjqWvmKJy1yyhZS1fKEsKCF3RafOKkLYWUaX8GP1YI1g5fUQxuI0L4adOJMeCFICqot9MglCwqxeg6G0ptCO3VCqEBBAxEnyR5R2rX1oSa5t9OoUZIc9856I5S7brqxo6fu9jTcgmPt8765uJ0kwK/rl8dsWho8vpjZDaoYaYNEb/QVjmjNy65yS5eOQsTDK1nFkAy3ltjU/XUZ4sbCnhj10V8Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x+L4DBo+iN7sRByQnI/RUD2yBa5eyv8XoCVEXrHg8ck=;
 b=AyIk5a2awjR6pQAbR1Ltri9US05nPEEb8I/wCRxKq3rVOpLvJDsI7Yw39/9ibY6ZcZA6PelQSuTHi8epTfnEJR2ggHWLhX1CUCZcUFusEDg4nfbwirKO4+xexO1iNIb+A4ORdIOuiiLiBay99bJU932rMyzBB4/jXHWmplARh8OK6lVkFReg7DTf5T1DjxqvDs/7OGwptMPwTilEL8z/GvtGA27Xm/JbPGJJvVz9l5k/9LRyKmwcWQ9zjy+VpocO3q4qIg1AI4HLXbt5Y3oMYvZ1kkA3uPOzSEgUfPWdqdffiMphITP3QxtJAzloVilwNXl9645uqRICF0Q1yfNPDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x+L4DBo+iN7sRByQnI/RUD2yBa5eyv8XoCVEXrHg8ck=;
 b=ekPhL/ctJ4zuWBHDBfmfxWF33I/H1n+SJB6Haca/Jc/YbSxLop0+oZjFVUD20YW+wud7gs9ggiZwrBXtEFpU9N8xazB89ulQtscTx4HIIdENy2DkqicugwG9W2QQM8+QnX8aK70v/ZWTFVGeoh3rhjhBtzxUkvW/9XHkNnsMino=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1cb::9)
 by LOVP265MB8855.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:48a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 12:56:02 +0000
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3]) by CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3%2]) with mapi id 15.21.0615.015; Thu, 19 Nov 2026
 12:56:02 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Nov 2026 12:56:01 +0000
Message-Id: <DMZ7CHWBWU4O.3EA040FFBVCLG@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, "Gary Guo" <gary@garyguo.net>
Cc: <aliceryhl@google.com>, <daniel.almeida@collabora.com>,
 <airlied@gmail.com>, <simona@ffwll.ch>, <lossin@kernel.org>,
 <ojeda@kernel.org>, <boqun@kernel.org>, <bjorn3_gh@protonmail.com>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <tamird@kernel.org>,
 <acourbot@nvidia.com>, <work@onurozkan.dev>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] drm/tyr: name resource lifetimes after their types
From: "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.22.0
References: <20261118233727.3147222-1-dakr@kernel.org>
 <20261118233727.3147222-2-dakr@kernel.org>
 <DMYTKRS80NRC.18PBQHK9SZ8K9@garyguo.net>
 <DMZ4C3GGD9U0.360KJBSFLEK61@kernel.org>
 <DMZ5HM326EKD.1I8KUFD65L91Y@garyguo.net>
 <DMZ6RL5X2UXE.33EY9MDLO2AJA@kernel.org>
In-Reply-To: <DMZ6RL5X2UXE.33EY9MDLO2AJA@kernel.org>
X-ClientProxiedBy: LO4P265CA0076.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bd::11) To CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:1cb::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP265MB6051:EE_|LOVP265MB8855:EE_
X-MS-Office365-Filtering-Correlation-Id: 3216135d-9a65-42b5-c6b3-08df463c76fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|366016|10070799003|1800799024|18002099003|22082099003|3023799007|4143699003|5023799004|10067099003|56012099006|261022105027099003|261026140227099003|261026121527099003|261102123227099003|261028144727099003|261021135927099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: l24NB6LJ0GwT9DhXU4n5uex3j6VavXiDLZGO8IRux4wsH5TqK1z9PN3YwB+ZgvXDq2WwKKLdjxpo+K4OvycmTWao7QxQ3dsRVR4M7DnM86qk0fBkIbMnNO/MwE3hClpylbNX8oeHmh6th1qMD5W9LmYrUnDD23jQxAHJhaDpM0kvt6MXBf4dZ8rKHkE5df12aklkc2N4RGbMMHgwMGWF8936/VvhXpZSSlBU7DuOloRLNJVbqaKiTi4ltXp5pO4C93KT1X46YXMWuHBvGir2tnkuVgF5jMyYiPSHEP6I7aPlQ4CMh0aTCNYnDlepIbRuhgxT6hJJ9fwuua3YgmSn3Yt1CXXmXPqIzs6yRHHDPIJ67XySmbSj2J9K0LKrzDzfQgzAltyBObwdi73SqY4eAHeWaMSHRgi+ZbXwtxHwLj6Tku7g5SPo4SW0pj7XuQONwS6dvcEkb7yqPXMRKw7O0/KX+e36XsgsSPkxXHx6KtrMiLS8LYezWz//ij1B9TC9UxQCkLbUcuoCBDgtdYfB0jkKyrPG1qlvWTf+HBJK7sd85YvwQgNaPSUXZ3C4nkHvNegLuRvE82P1+UshV3iCFJ5cjbW4fKJuh/JTN5J7K1NiloJk0f/BhyiPTBuOH70Cb9Re3tfXfXhdSV1ymVO9u0ZD3TeDCO9FKuAo3tE8PKI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(366016)(10070799003)(1800799024)(18002099003)(22082099003)(3023799007)(4143699003)(5023799004)(10067099003)(56012099006)(261022105027099003)(261026140227099003)(261026121527099003)(261102123227099003)(261028144727099003)(261021135927099003)(261021121427099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RDVzTjl0U3R6VjFyZTFsTzRpSWxaMGJRcnVrMGYyTUlQWXpEa0k3RERGT1p0?=
 =?utf-8?B?OVRiRGNrZ0JaaXlMckJWT0h6NW9BRTU3TFczbk94SXhCbFNOTHU5Y21vTkdq?=
 =?utf-8?B?L0dIZWdZeDZjMzBaRlgyRjJERkd6dVpiRzkyREJCSCtQSDQwd1JRbGVBeVUv?=
 =?utf-8?B?UndSdjJBNTNWaGJIUG0vMkdidk9XZEl2NW1TSm5hdGRrNUF4S0xXek10ZklR?=
 =?utf-8?B?L0xndDhrTEdpQkpLK0VRY2NUVmlKM0daOGZTem9RVTc0dTNTcytzb2hsYzB5?=
 =?utf-8?B?T1k4d0N4c2hZaVpZY0RlZHpaWFFtVDJ4Mlo2U3FVTEpEdWVpSlZ5VU9KU2lW?=
 =?utf-8?B?RU9zVjBMS1ZDUVZEQUJreXVzRGtsU1hNZi9sRFRqbkgzZzVCcnpoam5HWVBL?=
 =?utf-8?B?NjJ3N2x0Q0U2UTNUWlBLQ2NPZThCdnUzdVZtREo2Wm9zaHcvVDVVZ29kSXhT?=
 =?utf-8?B?U2pRWkF5RHdmeDFvMUE1MWxjcGQ1TXEweUEvNlZoTE1oRjkzT3lybnNpbzd2?=
 =?utf-8?B?aTh4S21jWHlWY3pPTEtlSUR6SnVwSm90My9iaEdTUVBqaFlQazl6UWdyd0Va?=
 =?utf-8?B?c01jdHExVjdpcHJsVmRpcURJckJSeENJbGFPQzRmbmx3cmtRZUZsUTliRE44?=
 =?utf-8?B?alZaa1kvOW82V3EzVTdjWE1lL1hGb1lTSWQwVXV1aW1uRnh2cVQzWjhMZGhK?=
 =?utf-8?B?UlIzKzgrMmlNMmdhUklJK2ljdHZjS0J4RnVxRW51RzQwSDhVU1JZa3VuV0lC?=
 =?utf-8?B?TC9ZSjl0WlhLV05WaUFBbTFiTS9UMHVkTUIyZ0YreC9NS2FFTXViWGh2US9D?=
 =?utf-8?B?ak9NdXZya011MjZ1WWFpRzRnamxTOEIwcDUyaFRnYXUrdC92N3dWVGxQTUdH?=
 =?utf-8?B?QWlZS1k0aHoyTHFTckhKQjhvYmVuN3lTQ3g1UmU4VkVHR2ZSRkFRVm1wcXJK?=
 =?utf-8?B?SXZYVHdoTXNaNW5TSXBkbzF4TTNSeUpUbm44bEl6SW0vMHovQ2Iyd2s3ekM0?=
 =?utf-8?B?cFRoZXM4YTNGSnQ0YmxnYzU5OU9oUDEwcWF3RmZjekNOVUltZ0llV3IvZHho?=
 =?utf-8?B?THYvUzFNOVFDekxxMHd3RE9LenAwaXIrTERGOW9tUlpldUE3aGREbUNLZVpz?=
 =?utf-8?B?UlJ6MDh1SHBoaUQ0akNKZXFtNmlOU0ZQU2pGSDRXTlB4QlI0VFB1R29zNlZp?=
 =?utf-8?B?RlZSSVhNSGltWlVYcVluZGZHbVdPeG1kUVdXSFFYV0pZSUR6TDFLdENmTmds?=
 =?utf-8?B?Sm5LMkk0bEYxZkovM25WOFkrd3BoVE8xVkphZFI2SFAvMnNkdVZZa2NuWkRn?=
 =?utf-8?B?VG4yNmRjMGMyYkZtTTdZWkNhcEoyd1h2YjFJTWhkczJLa1F1ZmlLYnR6L1RI?=
 =?utf-8?B?OGI1Y1daMmZnNHBIWmlJa3hjWEdldXlxYklXUDJJQUFreWR4WGRIcHJ2RjRx?=
 =?utf-8?B?cGEvVUVzdHowcVFSdUNHZWpiUXlTSkpPbWllQytRKzZ3dFhOcE9sRGRIRWk2?=
 =?utf-8?B?RmJVclQ3QXlqdEdlRWpNNEd5ejhadDBvMjFmd1BDYUZaWXlhd0o3ZU9CVTdY?=
 =?utf-8?B?Qkg2NGl0Ui9XQUJac3A4YnJCQmxTTzk0NjlkV1UyTHM4aVl3RTZHNHNlV09x?=
 =?utf-8?B?bmY1YnQrUy8xQWdSd3AwVWVlVGRYY1JjTHRDTzRwYWJkWVIwSUJiclpVRzd6?=
 =?utf-8?B?NElZb1llQ21CU2w1bTYzQ0Ird3dSdUZtUVNZd2ZoYUE0SUNkSUdCdUNXMlZR?=
 =?utf-8?B?TFNSZmFzQlltL0hONXdYeTJWRGkwSUdZQjlFSStCdUN0QitZVEFsUVBzb3NB?=
 =?utf-8?B?a2RhNCtNUTRKUk9YenFLWmljWG93U2ZTblBGYjlOSUE1T1o3Rit2ZmFaS20z?=
 =?utf-8?B?WThnWHJ4TnFJMU1WeGFma1BOcHZHNUJGNWlUSDlLYUZ6NHZpSkIxa1dKK0ln?=
 =?utf-8?B?U3JqM1NES3VsVUNabm9QUjdpV256bVZIZ2V3R0dKMmxtVjRFWVhwdjUvK0Jh?=
 =?utf-8?B?QkRXRHE5c2xHWjFoTEJxT3lVeWF3dGNUYjJXS3ZtQkpyNXM0NjZRM2N5cytJ?=
 =?utf-8?B?aEN2eTlzUjhZMGw4ZWxVUS9aSVNuSzBaVSt6NlFrOXN5NEl5ZFlMa1pwTVkw?=
 =?utf-8?B?Z1U3WStjcEk1M0lWZ1N0WnBSYmI5UVl6SHlCazRBQkd3T2d3M0luYktXYjBz?=
 =?utf-8?B?UTF4S0Rob3hEU3ppSzJNa3p2U1JzY0FtbGVzS3JpanR4bEk0UnlvN01BblQz?=
 =?utf-8?B?MEhqTlVMaFd2UWxBZmpXRXFQWjFFN1ZleFVadVJLazhXSCszZXpocFo3WjFQ?=
 =?utf-8?B?ZzZoOHRMelNTRnA4WG9LRU9hdTkvRFdydlRVVHpIWjRReWpqSDBWQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 3216135d-9a65-42b5-c6b3-08df463c76fd
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 12:56:01.9777 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VrSKC2CwXCbtwlRylIjdJH/+xu8W4MNI3RZRzHgkN5/08byz4E+QwzS+kPjshcn7gnAvFaQ/ogrB0QyDX2qQ+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOVP265MB8855
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu Nov 19, 2026 at 12:28 PM GMT, Danilo Krummrich wrote:
> On Thu Nov 19, 2026 at 12:28 PM CET, Gary Guo wrote:
>> On Thu Nov 19, 2026 at 10:34 AM GMT, Danilo Krummrich wrote:
>>> On Thu Nov 19, 2026 at 3:08 AM CET, Gary Guo wrote:
>>>> On Wed Nov 18, 2026 at 11:37 PM GMT, Danilo Krummrich wrote:
>>>>> The firmware, buffer, VM and MMU types use 'drm for their resource
>>>>> lifetimes, even though each parameter is local to its type.
>>>>
>>>> This doesn't make any sense, a lifetime on a type by definition cannot=
 refer to
>>>> a scope of itself.
>>>>
>>>> `'sec` is not the lifetime of `Section` and `'fw` is not the lifetime =
of
>>>> `Firmware` and I think this is just confusing.
>>>
>>> Yes, this was badly phrased. What is actually meant is that e.g. 'fw co=
nstrains
>>> how long a Firmware instance can be used.
>>
>> I think this is weird still. Any lifetime on a type would constrain how =
long an
>> instance of that type can be used, that's just type wellformness.
>>
>> I think what you're saying is basically "I couldn't think of a good name=
 so I
>> use the name of the type instead". To me I think using `'a` has the same=
 effect
>> and is less confusing because reader knows that it is a generic name and=
 is not
>> tied to any specific scope.
>
> Oh, I agree, 'a technically achieves the same thing.
>
> With self-referential pin-init, several lifetime roles appear together. I=
n the
> Firmware example below, 'fw describes its external borrows, 'res is the (=
hidden)
> invariant device resource lifetime, and 'vm describes the borrow of the e=
mbedded
> VM.

It's true that many lifetime names would appear with self-referential pin-i=
nit,
but apart from invariant lifetimes, the covariant lifetime parameters are a=
lmost
always the shortest living lifetime among things that it may reference.

>
> 	pub(crate) struct Firmware<'fw>
> 	where
> 	    exists<'res>: 'fw,
> 	{
> 	    /// Iomem need to access registers.
> 	    iomem: &'fw IoMem<'fw>,
> =09
> 	    /// List of firmware sections.
> 	    #[uses('res: invariant)]
> 	    sections: KVec<Section<'vm, 'res>>,
> =09
> 	    /// MCU VM.
> 	    #[pin]
> 	    #[uses('res: invariant)]
> 	    vm: Vm<'fw, 'res>,
> 	}
>
> 	pub(crate) struct Vm<'vm, 'res> {
> 	    as_data: Arc<VmAsData<'res>>,
> 	    mmu: &'vm Mmu<'res>,
> 	    dev: &'res Device<Bound>,
> 	    #[pin]
> 	    gpuvm_unique: Mutex<UniqueRefGpuVm<GpuVmData<'res>>>,
> 	    gpuvm: ARef<GpuVm<GpuVmData<'res>>>,
> 	    va_range: Range<u64>,
> 	}
>
> I find naming the external borrow parameter after the containing type eas=
ier to
> follow when reading these definitions.=20

In my view it's the exact opposite. If this is called `'a` then it's 100%
external borrow (surely nobody would call their field `'a`?) while otherwis=
e I'd
need to see if it's a field or a lifetime parameter.

>
> I thought we did settle on this convention in the past; am I misrememberi=
ng?

I don't think there's an established convention. I know this is the pattern=
 that
Nova is using, and I didn't question that. But I am wary of having this bec=
oming
established as a standard pattern.

If a rule is to be established, I'd rather it being the following:

- for invariant lifetime parameter, use the name of the borrowed resource
  (because you know the exact lifetime).

- for covariant lifetime parameter (especially if multiple resources are
  borrowed and the lifetime is the shortest among those), pick a generic na=
me

- for covariant lifetime parameter referencing just a single resource, I th=
ink
  either is fine -- (as long as it's unlikely to be used by unsafe code tha=
t may
  assume that it covers the full lifetime, e.g. 'bound).

Best,
Gary

>
>>> (In the following patch, in TyrDrmRegistrationData, Firmware borrows Mm=
u. That
>>> borrow has its own lifetime, distinct from TyrDrmRegistrationData's 'dr=
m
>>> parameter.)


