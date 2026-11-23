Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94FF606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 16:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=eipdd4Bh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF2AB10EFD8;
	Mon, 23 Nov 2026 16:26:17 +0000 (UTC)
Received: from LO2P265CU024.outbound.protection.outlook.com
 (mail-uksouthazon11021142.outbound.protection.outlook.com [52.101.95.142])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48A7010EFD8
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 16:26:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bzs0bL/ULGhEH07ZZjQ9ss02aXYDfBEVzoQ8G2VKXh5wRCru/JQuUhVCohFq2Ac11LpXXKSjtgiNBnygWR26KNIGcMIOmYGI03xINnRYB21Z8KrMtKgZsZqR5x7DTthvfMBmG+n5oil07WeQCRpdPS6nFhlkqMiCNczEvhlB77y2j5HPkVtBa3Ar5fMlzzk9Ovq9kf+iLXZqLL595R4ha44/I2N804JhQuLgEnrmYZCKMiUXPJ4roXyxGc7gLnaYYVc0aiBRAGGG6zMGIeXKsllPP6k7l4Dpj5k4OKhhiTndoXeyevdZkTWKQa10rRSNGvIXIjWhTmNtVSwuEm3emw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zo/2fAzXp15PB33iSC2ahHHUyeysyEV3uFp9o5Dld5U=;
 b=RQog+cYYW3uzVJNBO2cdz5I+FdGuCgb1j/6EOHIbhe2hMoYkSBzChhQCkSVCRGOOKIHp+DjoVqMUp7MaTZOU8BYzB9OlPkZyd6gMw3F7HW+GT5Im8+MjZ9S06b/td3PFZiS84oDjDpNY883tx58eoHQBaROx30IBARRiKhD9GnOLVNLOXSgHoLUG+v300iOYUMkdKHePa5aYyV/sEeA9pvouy3QHWQub0lRhf9g/wgQxyp3YMvsgCXy4bth/GhS19nmCEC1zStzjPeO9mS2cLy3iLJEsKK8cOtRlC6eWoJMx8c4rkYGFlxQ3segX3VZNHyWuHrSDb+HzRyMLaqiFqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zo/2fAzXp15PB33iSC2ahHHUyeysyEV3uFp9o5Dld5U=;
 b=eipdd4Bh/dmu7stKzAx48+odVsbTomqcpY85uRnbFlsSyNGO2BDAk5hCClhV+8BcL9u4AZ7uH7AKjo9TkshCp5jshvjA1m1a6JQwbgZ509ac1sRasFyktzcHGXrtYhwSLnt2r/WWo2xOYtemtnylldU7eV5QHZrVgWPQX8mRbdM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1cb::9)
 by LO4P265MB7284.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2f0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 16:26:07 +0000
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3]) by CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3%2]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 16:26:07 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Nov 2026 16:26:05 +0000
Message-Id: <DN2QBIUMBZA0.29FJDLKLRSO24@garyguo.net>
Subject: Re: [PATCH 1/4] drm/tyr: name resource lifetimes after their types
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>
Cc: "Gary Guo" <gary@garyguo.net>, <daniel.almeida@collabora.com>,
 <airlied@gmail.com>, <simona@ffwll.ch>, <lossin@kernel.org>,
 <ojeda@kernel.org>, <boqun@kernel.org>, <bjorn3_gh@protonmail.com>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <tamird@kernel.org>,
 <acourbot@nvidia.com>, <work@onurozkan.dev>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.22.0
References: <20261118233727.3147222-1-dakr@kernel.org>
 <20261118233727.3147222-2-dakr@kernel.org>
 <DMYTKRS80NRC.18PBQHK9SZ8K9@garyguo.net>
 <DMZ4C3GGD9U0.360KJBSFLEK61@kernel.org>
 <DMZ5HM326EKD.1I8KUFD65L91Y@garyguo.net>
 <DMZ6RL5X2UXE.33EY9MDLO2AJA@kernel.org>
 <DMZ7CHWBWU4O.3EA040FFBVCLG@garyguo.net>
 <DMZ8NNSPL36I.15O2JQR7M65T0@kernel.org>
 <20261119154430.918072-1-aliceryhl@google.com>
 <DMZC2LXTA7IC.5BU39FYHJU1J@kernel.org>
In-Reply-To: <DMZC2LXTA7IC.5BU39FYHJU1J@kernel.org>
X-ClientProxiedBy: LO4P123CA0126.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:192::23) To CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:1cb::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP265MB6051:EE_|LO4P265MB7284:EE_
X-MS-Office365-Filtering-Correlation-Id: 55851dfc-e798-43b7-ead8-08df497e79b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|10070799003|23010399003|366016|18002099003|22082099003|4143699003|10067099003|56012099006|261028144727099003|261026140227099003|261026121527099003|261021135927099003|261022105027099003;
X-Microsoft-Antispam-Message-Info: lofHO4k5kMWo/f935UVpCE63O1j5bsUBIhb1466T8z1q9J2Fkd5KgX1Fn94KgrxLkF/yQPaLKRmUzD4SZ83FHh0DcVVesz8ll2wyARpp5Gb90SHAUz6dIplChC2QX761Ae90Z/AIQr2GpMH2TY5npMBVy0Lv5q7OnJHJT5znRdZeFC+xJOfzi5GBH4mfj89SqZWUfO9aP2rZxUMxyvUMqcQSBZ2GTgpPznMYhQYDha+eSWN1VPt58RoDzUoYMNGvE+8Pe/qGw9YETVVkRowiY16Q1yNLKHsQ23Oiw2setByUOnE7iCrhgKIY8R2qpOXjxn76DCQTpEJlH+TkcqEb2SyvgDBa0d3KeyfngfFA0sUJXFlyxe1XdxldrPN2NagPRyITCo25LreSc9rdDqEhpmkE0/HuhzNDterWoWLvtIcYeiuVjtodA8cjAYfDJoNy6OiCj3ETuNUAQGaPUPNIXcHQM9v5TjBUZAWrFoWDQ4XiWOuH/k5pGmmtY5S7cWe77/PAxzcKoK6XgdgV4fiq/tcprWU1dNfFga71FnWzU4gbpwa8VOGLYKikXWWMKzyvqvWSuzhUUu30Hbls3ow3P2UdxpDorB5bybe33XnZnE6xExHxlLPztSgGJmBph4nSENFtuxyHi/yxxnjHNnQaLdQBRmLEFLt/jTxRDoUBuV8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(10070799003)(23010399003)(366016)(18002099003)(22082099003)(4143699003)(10067099003)(56012099006)(261028144727099003)(261026140227099003)(261026121527099003)(261021135927099003)(261022105027099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXZkc1N1VCt5T0w5WittT0NZT3lIenFrUCs2ajlJSklmU0xsUkNCYVF5aDQ1?=
 =?utf-8?B?NTdWTWw3dHgxaTNHZDhBTVJTWk1nYVNWbW8yL2N1eHRhb1VoU093TFJBV1Fu?=
 =?utf-8?B?WmVJME45bExLSWkyeXpqSHBaRFJJY2FmQUY2bE5KeW13OXJzQUk3RUxjMlJ5?=
 =?utf-8?B?RU9GT3VMTzNKQUc1WXAwUjkxYVowdzl1QzdyaEhLRThyTkMyZUpiTmVSMExi?=
 =?utf-8?B?amdpRmpTZUR6MG1UUkdCeUQ4MUp2cVJoQkphOEF1TmZvdjNURDZkY0J3WVAw?=
 =?utf-8?B?cHd3ajVPbllZNUtORm5qYWJqRTVqUGxGUVRjaHhaQWNlTXpoSVhKdGhlTFpP?=
 =?utf-8?B?OXBocFJPRTh2WXNFb2QvOUFTWlJOVFlxMjd5VjJNcWRtYUZ4QXpseFREZEhQ?=
 =?utf-8?B?OWhOZjlhbFNQc0NCalZKWlhuV1I3Q2d5dGs4Rk05amhyaWRueXVtK0VRdEdR?=
 =?utf-8?B?WVZpcHpiMzU5TlhMNzdOMTRzcjhOcWJZQTEzam5ITTF1SWtpa3krUTJEVWk1?=
 =?utf-8?B?ZW9iKzBYMTl1WHViRUVTYzZJWVhYenFRSzJsL3BNSGNNU1Z3OUxSK1IzbVRP?=
 =?utf-8?B?V2IyN08wdFZKclRTcWhDbWVNcW5Qd0VGUERWNDJoV2VXenllaE0yN29qc1Jh?=
 =?utf-8?B?M1VMT1k3cHRZeFBZVkFrTytrb0poVi9UcUJ5ZG4xN21FU3dlcXp5cFpNSjVk?=
 =?utf-8?B?Z1Boa3lVZmU0SVFEVlRPK1RqSVJHKzMrOXdRZVNmWjFUYlJidmFENzNwczha?=
 =?utf-8?B?RzY3Vm5ic0Z2a2NPb1BGcDVGUjR0bGJ5OEo2Y1E4NnM5bTRvQU10QlE2OG9P?=
 =?utf-8?B?SkxOYnBOOVRMUS9sckdyUUErbmRhd01meDVLN3psZGQvdHZaY25YYkx4Tk9B?=
 =?utf-8?B?WWtDOEMycEVwVWoxUWNsUS9jY2JHaUdvUEp3RlUxRjlwdGE5clJtV2E4Q0s5?=
 =?utf-8?B?blVudkNpMlQ5N1ExSFNNOVgrb1pPSHI4RUVPUENScE5hMitmNkhZQ0ZhcmpJ?=
 =?utf-8?B?SlNvLzBsRzFXdHR1NTU2SzZNemtTWXEvZXBOM2NUZXJ4dWR4SGZEZEYrcUlQ?=
 =?utf-8?B?OUxXUGk2bzJqUkZXSkFMR0FnbjJGa05LbVNxUmdMV2RocWJXL3JwUXlWekVu?=
 =?utf-8?B?ZmpHRk8xbHNENUZQV2lVSkIvUUMySVF3QzRXMWgyT2FWY28yNHh3d3pxQjcz?=
 =?utf-8?B?eWNoMzJhTm9QekRWcTJjLzhyQXR1dkpxa0R2U1p5RWNsZ0VhcVhISmIzUG15?=
 =?utf-8?B?Z1phQ2dCTDkvaCtXRHpzR0lTcG01QURRNFp0SUlkMG1KQ2o2QnFwZHc0b1Bw?=
 =?utf-8?B?aUNzNmtYMnVYbW9TNkpKdXJTS0xaVDRmOFlST1I3cUd5K2hMVlRKc3FnZ3hL?=
 =?utf-8?B?K0ZYaGZ3T3FhTytzNFBHQ24wazE3NWRzNHY1WC95VittUWEvMHhpa2had01j?=
 =?utf-8?B?eHJsQWV3RXNRZi9tSi90NW9KemFxWEFKc1Z6TDNhWVYvQXBuT1JqU1RVczRW?=
 =?utf-8?B?TmFieUdZd1FYU3ZWRFB5eXZxWGtwVldDNlhGMjNSQU9JeWZMYjI0OXR2dCtp?=
 =?utf-8?B?V0RRUUI2S093ZkdrVUdsYWNhYkxiTXZsQmF1QmtDTStZNUY4WGw5b1pnMXJU?=
 =?utf-8?B?Z0liQ3BqcFlyR0Q3bXV4aFZ3cTNoSDRHV2x1bXhuZXpmU3Z4UW5RYnpoYUxN?=
 =?utf-8?B?a3hHcXd6WkFQQ2hac3FvWXZuMHJ2czlWb3RSMUtEbEJPeVFFaGNUSXJjWGNS?=
 =?utf-8?B?V2txT1Jxc3hRYnpyWVF4VDI3UlgzRDRMeGl5OWFJbEcwMFRTYU1xSk8wdEV4?=
 =?utf-8?B?ZGJ0eHRsTk4rbFhkbzhaa05oMXdFb2tNY1dIVkxBbi80UklZSlVCdjlQUGdi?=
 =?utf-8?B?YjZ3NDhIbDM4b0orYVhhOFZyQnl1dkhRZ2JMd0JEVkl2QzVVb3BzOEorUjlj?=
 =?utf-8?B?Tmp3M2tnc0xhTm9RRzh1ZUs5UWZQdjZYOE5RZVIzWTUrejNwOEVJMHE1UXhn?=
 =?utf-8?B?RSs5dllKaUV4Z3V1bWF0bEZOZWkwRWVhU05aUS90UFhmcXlQNjJYaHBENnd5?=
 =?utf-8?B?aUZ2YUpuYVprQmNmRlgrZGdzWFpYRENsdTZaMi9YeWVQNldzRityQ28rUExl?=
 =?utf-8?B?YXgvNXZTMVEzOEo0b1lKN0YyMDJSNkdzMENrVzIxenpVWkdmcGRtd0R1U0Iv?=
 =?utf-8?B?djA3NWxRWHVlYzl3MWhCZ0xQQVZEY1hvRlJOOHZHNTI1dUxPeHlHbk83aU5I?=
 =?utf-8?B?cVNDQklxcjNhNFczTGpjaXJjb0RVdWpGb291ODJTZVg1T0FaTytKY2orOVR5?=
 =?utf-8?B?Yy9FMzZ6Rkk1aldHQWwvc0NBazBjdEFwYWlXMTk0aE1EQnZ4dWNvZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 55851dfc-e798-43b7-ead8-08df497e79b9
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 16:26:06.8870 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D7ATnO1WLupjT4rNoJnVPE7RDl0mGXtc9/+DUM2haCeIvz5m8UdXtt9NswwJRMckNi4eo4uCi5fgJc4Dzu9Pvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB7284
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

On Thu Nov 19, 2026 at 4:38 PM GMT, Danilo Krummrich wrote:
> On Thu Nov 19, 2026 at 4:44 PM CET, Alice Ryhl wrote:
>> On Thu, Nov 19, 2026 at 02:57:37PM +0100, Danilo Krummrich wrote:
>>> I think in the end it comes down to personal preference, so this is fin=
e with me
>>> too.
>>>
>>> Though, I'd use a generic name in the latter case too, such that it doe=
sn't need
>>> to be changed once a second resource is referenced later on.
>>
>> Agreed, using a generic name like `'a` (or borrowed-resource names for
>> invariant lifetimes) sounds good to me too.
>>
>> Also, when updating this for v2, note that `VmAsData<'drm>` in
>> `mmu/address_space.rs` and `GpuVmData<'drm>` (along with `VmMapArgs`,
>> `VmOpType`, `VmOpResources`, `VmOpRequest`, and `PtUpdateContext` in
>> `vm.rs`) were still left using `'drm`.
>
> Before I respin I'll wait for Gary to look into how the existential lifet=
ime
> could be moved to Vm (which is what I considered initially, but couldn't =
really
> get to work).
>
> I think having it on Firmware is reasonable, but I think having it on Vm =
would
> probably be better.

I think it's possible but doing so will be more messy (given that everythin=
g now
needs to have `with_...`). Having it on `Firmware` looks like the most clea=
n
approach.

Best,
Gary
