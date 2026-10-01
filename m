Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B811ACA5FA5
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 05:23:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2074B10E0B4;
	Thu,  1 Oct 2026 05:23:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="lasVHYib";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013065.outbound.protection.outlook.com
 [40.93.201.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14DC610E0D9;
 Thu,  1 Oct 2026 05:23:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ny5M4b2Eups9jqmTGlG6D5m8WFs7zgrUjD8eQ7HbfX6/VpPbExBEIs9oIWiX74MIGtmJCLOb1vtQoosi6BNbzf+DlO3FJ2I6vV5AKlkio+ZMyhwvZ3UNSaQs7JIi1++j5gjzQmYUHys3CcYCL+ZcxLdrSnOrgZH9u0ba4NHrCkAyJaH3Ry5rhEwwgHuaPmji4qs91UdQrT1vDqvlCu9RHpzCJ+7+roZV5YZR7rISGXYGuG9xcNPmCe3FwgvegNoie2mWU5mkzKt7/AahT+Fw9aROfXpsOBmpgD+YcNT4zSB1qx6iYAiJk4v95wlnrLt6vdyZSz4c6E23jSUjuZGbxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RdHdRee8Kb1IZqFh7XXmCVmRZehQfNmWnZiYzlsf+cQ=;
 b=uB71Vnrw+YItgzE2z8/HFeYYKdcU98dOqjANug9zmCjtEf6uu0KHjdzIVRvqYdTw1xN7PvjuceKXq34YPiALN6UsFz16soADAIUwrzLHh0vOcimMTKLGSHhZ0lTMeNMgwK11UQsONqZNaQIYbzy7QvPNpRIemn0MPdYywdeN4qmDQnfY/7FJTL5Lb9SeGjEXdmrLY8EK1R0y7MUR+vwZw8pAEc3+F+O138Kxg5CsHuNPiU1CS5GzTIsYqOj+pZUu27MCv2tldwzGS+H2bdmFhcr6u6Kd4ZO+btCrA1IkX/6v14xvYt2fnEw65QFiOPeqeKAF9cOAfZANNY9QcuZ4Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RdHdRee8Kb1IZqFh7XXmCVmRZehQfNmWnZiYzlsf+cQ=;
 b=lasVHYibSGy3eWNXOFHInbe4TbKG2W6wJiDYGUDHlvJVa9C50IUsttG7i6MGNnR5wNzR90MyGSzSig1+hE9zu23A3uNuXz8NWjspQgJmX9ukCy8UCqJpNPmxh1oprpCry4In2vG4n7txOUh5+1GOc/W0WYAi4H5FSN+mtoZgSkjXjMvjxpGWXE3KAtUAtKEC6kdDK17vZ4xpLpwcj3+DYQO0CY1Qki9mf2jGkE2dbxcAWbwqx+Ei+DP3vsAM9hL9rTNKCmUTI6uxDgPVAB5DNIYzj3K+tkN1YaaVQX8Y4BXot2zRrPgu8LM54eGYYMoT1m8ErQ0xAfq7FxgZwf57fQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 MN2PR12MB4455.namprd12.prod.outlook.com (2603:10b6:208:265::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 1 Oct
 2026 05:23:28 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0451.022; Thu, 1 Oct 2026
 05:23:27 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 01 Oct 2026 14:23:23 +0900
Message-Id: <DLT9190WEBPX.1X4UCVWUMNKEG@nvidia.com>
Cc: "Eliot Courtney" <ecourtney@nvidia.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "Burak Emir" <burak.emir@gmail.com>, "Yury Norov"
 <yury.norov@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v9 3/9] rust: sizes: add sub-1K size constants
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>, "Miguel Ojeda"
 <miguel.ojeda.sandonis@gmail.com>, "Alexandre Courbot"
 <acourbot@nvidia.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20260930-chid-v9-0-0d6cca376cff@nvidia.com>
 <20260930-chid-v9-3-0d6cca376cff@nvidia.com>
 <CANiq72kcqVfvVj_b7KTHKrCDj63LMKpsfP30zafoYB8c924i2Q@mail.gmail.com>
 <DLSLNL9HDUKM.HN7Z0MACZZSB@nvidia.com>
 <CANiq72n5jjW8U9VkYJZYFpL9Z5rPe=nRfs3DqmUdfxCW39oMgQ@mail.gmail.com>
 <DLT30TMEHB4P.3PX7HPU1C6UDR@garyguo.net>
In-Reply-To: <DLT30TMEHB4P.3PX7HPU1C6UDR@garyguo.net>
X-ClientProxiedBy: TY4PR01CA0096.jpnprd01.prod.outlook.com
 (2603:1096:405:37d::19) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|MN2PR12MB4455:EE_
X-MS-Office365-Filtering-Correlation-Id: 36f2ece2-b0f0-4d74-d8d9-08df1f7c1f78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|10070799003|23010399003|11063799006|56012099006|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: T8HGHVWlFJN6BfFobAFXklLMvX2iCn/Z7os1EQCj1u/wmkhroW/KrEnZFMOa/8OUU7/Tr4MCfDh6776P3+AglxR3EpfZHLJg9IRQGA51UH7uWRtBan0EAM6ettAN/79F0A0hrt/1IPWXaSZyIy+ilJSNGJNfMgbEKOEZ4JUuWKwfE9J+hvD1FYf8FWMVVjDLU18DMWesE+CYe6hkZ1308PIDfD57tCkEEzzGYUmhUJ2+AxBN61FTvdFQgym4WTwIJWEXEA4tvcXLcjv3jhiQY5Mzh7vBYXtxnP1uxbQpblnXxRmRlqZTACBz8io9zEEYiAs6c0+TFoXnqsWoy8bdG0eqdSYfyBlGJ2Mz7q8jYEqqjDA2tpnTrjOG5ToS4eDLXuOH3zkYbTfy84VvXWf8qj/wcJBDDSExi3mMq+rORZrZVBM/AQEggkZoyVWZJ2YVmT74j3ajYoXK2h+iSrUm+ehmGs07Rlco/znJtf4bxKmtsIBZCw7uGtYH5bemgWSxG+q1bW3Gn+Q9mFt1yltJOK/fvFraxI8FEfzt4tvbkelDkL/IuVpRrRxKfaSoGRwZDtHDatjZKgPP2kC8CnRL+jF+8MF6I2ApC4EqToFLIAjWBJateUn9GA3I9SGlCjDQGG0H2OnzsJ4q2wTHnSo6I1K3lEu1bV/jAhAK7KD/9Qo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(10070799003)(23010399003)(11063799006)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eU10d3cwMVRvWTNnemtuNVp2WEZkWm5INXNUMEhiejRQdlR5RGlPelFsTGFO?=
 =?utf-8?B?WG9senZMLzdOYm9xZ2ltQmpsRFhJNGt0TUtkYWNvUXVtZll2YnNUcGtGSCt5?=
 =?utf-8?B?N0tGK0FDWVNHdVEwbDJub2NrQnZYaTlLNFQ4elZyNkRXOFVBR3ZjaUJvdVVh?=
 =?utf-8?B?cmlPelFYWTMxWDlHKy8rNlhjc0hWU3h3cXYrTkE3UllpbTlzVEpsVXhUeS9T?=
 =?utf-8?B?U3JOZDdjem5NSUJWK0hoZ1FQS2ptV1V5MXVLa1dpR2dabWRoQzFJdWpWNWZI?=
 =?utf-8?B?bHN1ZnFtdnM4dTRxeGc5WlN4VXc0UWFjbUFwOE1SNTZkK0FBaThCVjhpN3hJ?=
 =?utf-8?B?L0JsL3VrN09aQmRDS0dvc2tjaUxuREpKN0QzdERTVzViaWNTOWpGS0RCOTUy?=
 =?utf-8?B?cjZYK0dsSTNWUjB3VkcwakxEMVB5ODVkYWwyemE2T201eTFFMmRWYnpvdTBn?=
 =?utf-8?B?MGJZMVdadG5zblk4N3U2YTZDZzlkdnBwTXJSMjNPYVRYOXhSWjA3LzNWNEQy?=
 =?utf-8?B?VUExMmpieHdhd1NzUW9mOTlsMnR3WWpzbWt2U1hCbXEwRjE1YlM4V2FIdVRK?=
 =?utf-8?B?TlAwN1FLdk4zN29ldGVVc1Y5NXJXZDFCQmNnclorVndsQ25BNGRCRHcvaGs1?=
 =?utf-8?B?a3JmdVpsYlVIZEtjTWVKREF1SGE0VkpGbnVqRTlWUzAxYUpFd1dqckRSUnNX?=
 =?utf-8?B?QUl2eW9WbEdkaTVwK3lNZXl0RzRTZkZueUZNQXhhUUVZSUVvdGZiNHJ2SVVT?=
 =?utf-8?B?S1NMTTVSVFAyUVhIV0tsemhiNUh2Rk1zVzd5eWphdTJDUTc3S0VpVDNKbWZJ?=
 =?utf-8?B?SHArdlZRS0VUOGUybjRmQjZlOGFRNEZoWFkwOHZqYWtNYlQ2S0FHUGlEVzY5?=
 =?utf-8?B?S0labmE5aFZPZkZqRzllRFVjemQ3cG9aM2d2S0hMeGZnQUZZeVBJVFZvNWhv?=
 =?utf-8?B?VUhtOHF1TUlYMWFQL0NuaURWK29XYTAvRWE0SE9QYjlGYWZCL2dLTFlzWUYw?=
 =?utf-8?B?ZEIvc3lIN1dhbStwano2Y0t0SDl1eXEvVS9NZVNYejhIdGFRZk5TRzE5TGtq?=
 =?utf-8?B?dTlFUEdUUWRqVEdxazZkTUYyQmFmQXpvMXl4ZVFmM1p3ZGNYa0Z5bElVZnZs?=
 =?utf-8?B?Nm5RODNwd1V0UVAvU3Q2N3E1SkxGdXNPNThSeU42dVRjUnYyNTNEYUxITVpw?=
 =?utf-8?B?c1lKNkYyR2lpdkNUM1RpRDZOL05Zc1VUQjltTFUwYURZN1hWYXRTU0hMRS9W?=
 =?utf-8?B?MG51S2VScVN0RG5YQ25Kam5wckNaeVd3U0hxQzJ0N2xWaUpFaFEydzhHTXhv?=
 =?utf-8?B?TWpNSG1iOFM3dThRMmNnQm1RWis0bkdiK2FuQjI1akxhSVlYdHdJeXpFMXIy?=
 =?utf-8?B?NlBxOVhPeVA5SHV6aDV0WkdmTUVKdDBkZCtFUW9zNTJpTzhwS3dMMmFva2ww?=
 =?utf-8?B?NkFVZ3c3RnFTSDFIbGp1dDQxcDFMUFVKeElxbG42TkZZKzlBVFA5RndFMThk?=
 =?utf-8?B?WFVsWUpESktXUGl1UWxYWENDMm9aZG8vdzM5dkVCVU4xWG9acHRsL0ozelR2?=
 =?utf-8?B?Zi9PcWpXWGZrejM4OEwyNHdPZDc4YVZ1cEFWR0Q1RTRaUVJFMkc2eGh3TFcr?=
 =?utf-8?B?V0JhU2k5T3BIWGxUUEhHWVR1UEowVXN4VUsxVjN1dlhlUFZ6K1M2c1A0S1pW?=
 =?utf-8?B?M2xvUkZCK3NJT0I3Vlg4V3F3L3hOKy95MDJ3WFczcURpRzU2b3BlSnB1MlBa?=
 =?utf-8?B?eDRkWFI3TlQxRWs1OWpHTGtEMDUzbk1ud2U2d0VzcXMyWjA1eFZPdUV3MFYz?=
 =?utf-8?B?OC9Qakd4WHRlQnBCa2wzWG5UbllLbGlMN2RPcXBqT3NBMGN1RG1GSEhkNGpm?=
 =?utf-8?B?dzNSdEtuV0dGVDI1WHVuRkxxb1RzMkhCNWRydDhOZnprQ1FiV25jK3VHNG9s?=
 =?utf-8?B?bWdldDRDREhQclNHV0xWRkg1UXo0TDFkYkpSMG1mL254eU1kOXlBZFVCT3ZD?=
 =?utf-8?B?K0FpTHRKZXlXaFhwR3RBbGtQeFNmL1Q5WUdiUjROZlo0TGUrOU5DSDJJcmNT?=
 =?utf-8?B?NHhEYXMyL1NxNGEyU29KL0R3dExSeC9NZWZrbzMwb0RXSkFZMytKZVhjUGNo?=
 =?utf-8?B?SGY0NHFkNzNBVXRwNTdoT0lVQXpVMEpUQ01yeXVRWFpkUUdqbGRiRko3ODBG?=
 =?utf-8?B?UGtWZ0t3eElLdnZrRGpvNjRGRHY3SC9Db1FuQkpKMTJycFAxaXdJSWhCWUps?=
 =?utf-8?B?NUFUVjRmTFNqNGtkNU1sdDJFMDJ2RVBDczR4bXlmTFNWSEUwRkpkaStlRFUr?=
 =?utf-8?B?cE1CMmg2MEVoT1NJWnlhbEhmSzlvOE1TeHpMSGs5ZzhzRk9La0hkL0NieWEx?=
 =?utf-8?Q?ukTnufYbtClt49bDzQaWXO9L4DX9UM287bzz8YYWO4fNB?=
X-MS-Exchange-AntiSpam-MessageData-1: aatfsWzF4dMu9g==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36f2ece2-b0f0-4d74-d8d9-08df1f7c1f78
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 05:23:27.5636 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q+nFRS57vW8icFDiYLX6BV3KBYfxb9/zXwuG0Ic1Dif/GCodZbkaX18J6Kt9uxALz2lLr+GUvWbskSgAj7vb6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4455
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

On Thu Oct 1, 2026 at 9:40 AM JST, Gary Guo wrote:
> On Wed Sep 30, 2026 at 12:22 PM BST, Miguel Ojeda wrote:
>> On Wed, Sep 30, 2026 at 1:04=E2=80=AFPM Alexandre Courbot <acourbot@nvid=
ia.com> wrote:
>>>
>>> I am considering picking the series through DRM, but it also has a
>>> dependency on the `cv!` macro [1].
>>>
>>> Is this ok if we take the patch introducing `cv!` through DRM as well?
>>>
>>> [1] https://lore.kernel.org/all/20260917-cv-v4-1-547ef5727451@nvidia.co=
m/
>>
>> I asked Gary yesterday if there was any more recent discussion on the
>> tag thing from v3. Does anyone want to do some cleanups this cycle
>> through rust-next with `cv!`?
>
> Given close proximity to LPC probably not.
>
> Best,
> Gary

I have a cleanup series locally already, I was planning to send it next
cycle.
