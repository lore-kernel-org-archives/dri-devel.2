Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8194AF53D81
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 18:47:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9371D10E30F;
	Mon, 16 Mar 2026 18:47:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="f4Bk9H32";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011004.outbound.protection.outlook.com [40.107.208.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E353110E30F;
 Mon, 16 Mar 2026 18:47:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uzD6IlneULlwP0AQs86Nolti8bKE7/ZwpDVgRP2NRfasoB3zo0ETbQR5P97No5uYR+WaBZIXjYdmndXF1sSXhkN8TNsiIy4nlwSzHmWZp964umJ5rg5qb4axRHirzV3tV7V6afIAikmLgNZpsYe4rJLypwBJjALfB9piS+gkJ2WELmPtBx9fbhDhnIvrmXTRYul9ZtjWhb0CFjQ48sv42fBufNysqEpnTmLn6iaHpKOSGXAcD+/rYcfc1ooi0sdQTnT0y4HBjwJxXC2+Vp8wTlJF2mAPKDe7MZygzD8HJziR3TSWNwaokvCRMEe6r/1j7Ddrt4I7sbBrndTHxP7w0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sDvjSW2S86+hEUVO7LAFOMZEgVp8a7wlXv0ZtNH1M9U=;
 b=g4rMV0FsP0vkaiwr0fOjokx+deQCzDfZ2eZxwgtbOpQBhyFF4n7gxoQ90vBxSj9guawkMMKzKLM4REHa6ZdgIVtBi5YhqMUoNyPa2Tt9X02UiCv+GMyUIpcUNefh+ftCmBSO1AfKBZYtFQ/yp4AYx2zF3Jcob1BgXRGHXIf0UGy/JYgL+i9EfX7QNEJ7t9vEd1UCdUa9YfEgqLydRYsr20071F9uq2QHxe3EWzWr5voTlLvPYKecUD3JiZEq3IKzAqQ5Cm0qyHEWKSv1Qsp+LJyBVCdkWgdlZxW65Rk5nZmY+QXVrFXT3cYxToeJ2v2DvzqHLFwNCl4K+utk2GyHXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sDvjSW2S86+hEUVO7LAFOMZEgVp8a7wlXv0ZtNH1M9U=;
 b=f4Bk9H327imlaoxRbXRMMe5/QLevIYHVXBx6XkJPLirVNBiJfbyHyxeMzf8vKS3WvWuudRArqOsTJxH4uyk0mibcOLxJ2USNcwFLvAKAOjgx9HeM6rlapoeUYgqR3V0XME3x4/gWuSzVt98kFw4vpRamAqn2vqbV5YJy0aWfecWpWVsAml8qcne/HX43NOVw8r5UjWOwskTfI2EtFBzKuGeRpf/6Bz8YjMJF7vk0Gvd5FJzfri0omg8osnO/IgaFJv+oe4qvu4gWIE2JNRRBmaX8CALrViJRxD8pEaCKBwHrxGM+jg6xOPbhZW8f5PS8QFB8oPXOcJhhs5KtwkPhhg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 PH7PR12MB9222.namprd12.prod.outlook.com (2603:10b6:510:2ef::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.16; Mon, 16 Mar 2026 18:47:39 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9723.014; Mon, 16 Mar 2026
 18:47:39 +0000
Message-ID: <b9ac5703-7298-430c-9f8d-e358455d73c8@nvidia.com>
Date: Mon, 16 Mar 2026 14:47:36 -0400
User-Agent: Mozilla Thunderbird
From: Joel Fernandes <joelagnelf@nvidia.com>
Subject: Re: [PATCH v12 1/1] rust: interop: Add list module for C linked list
 interface
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 linux-kernel@vger.kernel.org, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, Alexandre Courbot <acourbot@nvidia.com>,
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org
References: <20260306203648.1136554-1-joelagnelf@nvidia.com>
 <20260306203648.1136554-2-joelagnelf@nvidia.com>
 <CANiq72m2Eo1UAuwMC0LhiD4+yqKixRm=+oHtEnpwY-VbNdR+fw@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CANiq72m2Eo1UAuwMC0LhiD4+yqKixRm=+oHtEnpwY-VbNdR+fw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0434.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::19) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|PH7PR12MB9222:EE_
X-MS-Office365-Filtering-Correlation-Id: d0f97342-3f76-4819-60aa-08de838c7f60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 2WEM1rtC0moQ4ZPMRvDPzvoj3Y37bXQOnfz5RM5UwdjQ+6D5hQDlJq6t/JRvuwQPyhJtk1g0UgTm1R+yeLn5i4f8A6dIjEZI4nk70pO4A2Bmkv65yQrCnCj8B0hLxsqWy7HZov55IDNHUZOWyp1YFlWdD/6SwKDy8YOr90rOLTFjtW/lEsrAhDcYPGcgQfnboahZHnkpgelmp0wavNbrGsEp7oGkruRgn5hGGKDXWT3Fs1v30l2gV0A0CrK3peLWmtZOnSdaVCk+72vUHFgySN6WFxPV5DaxOM+rWosew23Rm+48x61+9+o5iLo7t7q3BHXEBgTMffMflAIjiGl53Ar+FNt1omeR2sXx2hcSToVU6XvBc5u1Q83khcU3XHpKaiwO91XhL6QVb+DQOpLgH5G8xeYDmgcsXgMLwM6SNg5mbn8j5iuJT6rVqJt/lBRzj1IuDsfPZFkTVO1eGY48ZD/Qgx0KWFJf8ANiE9SvR0QAehSVchBdKhgk0T6m2ILzLMneb7lrAnncvYR739i7uFaCKvbIvfVMjaVLUOmelWqxpKujL3ch12bEXC7m7vMbsL7Gy0WrR4kob4IdxDvhl7KIfilPC0v/5QUGWuQOoC8qYl9wBRQbS8OIYzsNU06xXIav6oY8o9h+cX2MZaZZB1lozlxtGJYgqRFm8J7BBUU17tuG+5YCjeBAxR19Kxi4B6OPafawL8mSDVgGmOWMdIh4EcULM13IFJvl8n2mv0Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eTV5dEwrMDVWN0hwc013MTNPZ0xxVnUyRTdBRVg1My9IZ0ZRUHlKRnFjcVUw?=
 =?utf-8?B?LzgvQWt1UnVYZ0NabGpSY0JDTzFsOWtNZzNycnJKdVJ6R09xM29iL3hORGkz?=
 =?utf-8?B?OWFkWHN5bTJINnVRNzJXeGVEQmowUHI0alJodUVUTFFVbjBjWHhCM3JaMW9q?=
 =?utf-8?B?Y2ZiSEtBZnNVUTYxb1BrUk5NRnkrajZNQUljNmRZNW4reFBxODZ2YlVBZzVx?=
 =?utf-8?B?YUxyNFlKckxqMUVJbEdWZXpQN2NHTW4yRkxiTk1XSFo1Q0JTQyttSk85YTN0?=
 =?utf-8?B?eDY2STFGOXc0QzQvampNRjEwdjZrVUZUWERNS281b3Y5RmZWcTJnQ3hSWC9t?=
 =?utf-8?B?OUpDeXNaYTNXVis3SEZIL05kNmJjdmNsR08vV3dxVzFwSkVObVZQM2ZTQjZF?=
 =?utf-8?B?dUYyMFhxSjlSbENadnlSWGZ1YkZFZWFIZlUrb3E1eFMxN3Q3SWZrRmxCSjhn?=
 =?utf-8?B?Smk1NjZ5MWUvd1lDUm9WMWRBMzN6eDNSWnNxSGJmQlBQbW92cloyMldrdmxY?=
 =?utf-8?B?OFE4dzdiQ3VjL0ZKQVFkcmVxNWRZT1l0ejBxYXpiajFmVHN1eVFKamt6YjN4?=
 =?utf-8?B?S2RQMFBxUXp2NHJSSkwyR2pOSnFId3VTdDFwdGNWSTFJdDBFZlRSRjV4TWFB?=
 =?utf-8?B?K0RpK2FGdWFldnVPTHo2VU0vSmxoNVlQVCtMQWZPTWJFOGlrVWg0di9GQm9H?=
 =?utf-8?B?WjIvamt4dHlYQmpnUFg3WGJZZ3h3V3I4eVFoeVUzUVhTU1ZTd1BaN0JTR0FK?=
 =?utf-8?B?dytGMGVpQU9IbzBpUDlSR2JmWFYwQ1dkeHl4TkxhS01aUWZFZTdvQm9ocXdP?=
 =?utf-8?B?QTR2bFUvVEJ5cEgweDE3SEdlbXpqNDhlMkJ2dllOeUJSRUlHUVlLcUVmRyts?=
 =?utf-8?B?Y1dFNGRTdGtURGh3ajZHSzVFRm9oaVRUcHFLam85UG9sZmxCR3JhTm5mNEZC?=
 =?utf-8?B?ajN4QVFqSEhQSnVBV0phZndWazBSY1V1USs3RzVMNXhPWTR4cjhDUzl0T1Jq?=
 =?utf-8?B?Q1cvNmMzN2RsYmV1WDBEenVVQ2ZGb2FoZlhRN3hDelBua2pkZ1ZHaW9lOFF1?=
 =?utf-8?B?V2tTbXUvNU15cnBaNWt1UnM4S0x0ZllBUkFxdjZzVmRUcmtZWWYvbEhac2pM?=
 =?utf-8?B?dEw4RkNhSmNzVkx4S3U1MktWRXZoWW40M2FrbEwwVlpMSG1IeExHRUVrc2Jh?=
 =?utf-8?B?MnN1NVNxdlBNbEhHNHZJbmRzcU03bVB1M2ZmT3VGY1kraU5LZTNSU0FyYW9M?=
 =?utf-8?B?cVRuOElOdTZ3SCtLdlRaaXljRmtqOFZUb0JOM0xHUEdmMmMyR1NFOEMzNURZ?=
 =?utf-8?B?SUhaMVI4b09IUURxU2Y2L1RPL2hDdjJWbStMeXhaMkF4NTZWVlRwSnhhTnlX?=
 =?utf-8?B?QjBQZlhFREVmckxmTXNmbitKYlgyczRHS09Oamg4cFhlem5CdXlPUW83aDJY?=
 =?utf-8?B?TkpvQjkvVWFxdlphVjRYQmlxN2o3U21tTzJ4allxd2FyRXUxVkJJUGpEMU9Q?=
 =?utf-8?B?T2YxSTFzNUJGSTJSM3FNNU1LWmZEdHluUjVieVNDdERFV0lrQm5KbnpiVDAy?=
 =?utf-8?B?UC9sUkM0SXlpbXB0R1Nzc0NLd1VuTytHZWRCd0NkK1Z3ekR3cHo0TnB2K3ZC?=
 =?utf-8?B?SEF4MlluSXlUQjluWS9PVHYvam1nV2NXd2ZKbitCY0NCM1JpaGdyR0lEZjEx?=
 =?utf-8?B?OUZxaGlLVDlxdWZ1VDFCbHhLb05tMVhMN01zd1dYakRjT0wwMWpJNlhpNUhr?=
 =?utf-8?B?VFhoY2RCV3ZyK3M4ZTJ4YkJpcE5ScFkyOThHVFlPdVFvT3l1U3FkcnBBSmhx?=
 =?utf-8?B?U1lBczlDRFdDNTJHL3ZPYlVtYXA1WVhkOW9KR0wwa2Z6Q0R4UzNsWmpPbW9Z?=
 =?utf-8?B?ajBxTEgxZVpDOHF2QW0vU3pianRXUkpxSm9Qd1VBZGp1bmdsWlA4amlyN2dx?=
 =?utf-8?B?R2tTVm41cnNvajNUY0UwWExLZmpnYzNSeVZqVXhnZ3dPSENmcWU4MVJVVlRo?=
 =?utf-8?B?ZFpvNmp5d1I5YTRiRW9BRUZnS3M1bTdrVFVPL3EyTVZXSmxOc3RUQ3V2M09B?=
 =?utf-8?B?R3d4cUlRaTJmL3E0YW1qQUNYVGp1bEwxRk9mdVBNMm51UnRpdlBMNks0UXlL?=
 =?utf-8?B?aDB2YmY4Y1kyc3piNzNqc0pUU1VEWGR6OHJtVXo3aGRNZDNzajNzc2JldzZy?=
 =?utf-8?B?Q0RHSWZ2OVZGNzVpSlJaRU5CSXNMaXNueldhR0Fna05YR0pSRmF4dmk3Nys5?=
 =?utf-8?B?WHkyeWU5QmpNSXZtdDljWUw5U1F6OEtVd3FlbjhLN3JFUml0Vk85MGZ2UkU4?=
 =?utf-8?B?S0VUOXVibU1UM0VzNjQvSW9KSzJ1T05sL0JpMituaXVnMDREUUE5Zz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0f97342-3f76-4819-60aa-08de838c7f60
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 18:47:39.0843 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k5l7TSSd0134p6VQh18SBhWUq9cR+9+upA37/CgUoO6BM3JO7I9rCTiInG/X2vQOVZFCFAE0W4Bs0stB7Bfa8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9222
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

On Thu, 12 Mar 2026 20:16:00 +0100, Miguel Ojeda wrote:
>> Acked-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
>
> Acked-by: Miguel Ojeda <ojeda@kernel.org>

Thanks, will change to this.

>> +//! # // SAFETY: head and all the items are test objects allocated in this scope.
>
> `head`

Fixed.

>> +//! // Rust wrapper for the C struct.
>
> Empty newline comment between these:
>
>   //! //
>
> Actually, should this be `//! ///`?
>
>> +//! // The list item struct in this example is defined in C code as:
>> +//! //   struct SampleItemC {
>> +//! //       int value;
>> +//! //       struct list_head link;
>> +//! //   };
>> +//! //
>
> Let's try to use the usual style, i.e. no empty newline at the end of
> docs for an item.
>
> And the example should be in a proper code block with a C tag, so all
> together something like:
>
>     //! /// Rust wrapper for the C struct.
>     //! ///
>     //! /// The list item struct in this example is defined in C code as:
>     //! ///
>     //! /// ```c
>     //! /// struct SampleItemC {
>     //! ///     int value;
>     //! ///     struct list_head link;
>     //! /// };
>     //! /// ```

Fixed.

>> +//!         // SAFETY: [`Item`] has same layout as [`SampleItemC`].
>
> No need for intra-doc links in comments (for now at least).

Fixed.

>> +//! // Create typed [`CList`] from sentinel head.
>
> Empty newline comment.

Fixed.

>> +//! // SAFETY: head is valid and initialized, items are `SampleItemC` with
>
> `head`
>
> However, this is giving me a Clippy issue (please see the other email).

Fixed.

>> +///   `next`/`prev` pointers are valid and non-NULL.
>
> We started using `NULL` recently as a convention for the null pointer.

Fixed.

>> +        // - [`CListHead`] has same layout as `list_head`.
>
> Intra-doc link not needed.

Fixed.

>> +        // - `ptr` is valid and unmodified for 'a per caller guarantees.
>
> `'a`

Fixed.

>> +        // SAFETY: self.as_raw() is valid per type invariants.
>
> `self.as_raw()`

Fixed.

>> +/// perform conversion of returned [`CListHead`] to an item (using `container_of` macro or similar).
>
> Intra-doc link to `container_of`?

Added.

>> +        // - [`CList`] has same layout as [`CListHead`] due to repr(transparent).
>
> Intra-doc link not needed.

>> +        // Convert to item using OFFSET.
>
> `OFFSET`
>
> Newline comment after this one.

>> +/// Create a C doubly-circular linked list interface `CList` from a raw `list_head` pointer.
>
> [`CList`]

>> +///   pointing to a list that is not concurrently modified for the lifetime of the `CList`.
>
> [`CList`]

Fixed all these.

>> +/// Refer to the examples in this module's documentation.
>
> Perhaps we could have an intra-doc link here to the module.

Added.

>> +        // Compile-time check that field path is a list_head.
>
> `list_head`

Fixed.

Thanks for the thorough review!

--
Joel Fernandes
