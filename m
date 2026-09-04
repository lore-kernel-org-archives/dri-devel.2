Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0421CC61DD6
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 11:14:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D38C10FAAE;
	Fri,  4 Sep 2026 11:14:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="n8YBBjFt";
	dkim-atps=neutral
Received: from LO0P265CU003.outbound.protection.outlook.com
 (mail-uksouthazon11022123.outbound.protection.outlook.com [52.101.96.123])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4771310FAAE
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 11:14:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W1QLi0ydEVGvUa08AeVqkWhss9eX3Xu6+HaeTGrigQiz9HsOhdZx28q0jlAxtD7WJj6scFeccoTyKXfDJZz4u55OVLm+GaXAHwkVU/Em8dgC4bAqpJXF+FrvwYrCUP9fC9FPcZOxK8Tr4k4RdjYG70IfnwXftA2iYiQa5YfO4FsUtdVfRRrCx9x36GUyM2+OKMV5461CwQC0B01yrwp39VWHhIm97hzMRdUi8kQqh0Zae8XVaUs/hx/EjyvKpcU05XfTvuIu3LAOmgPsKTP1LlrT/M44urYkzE9KI8BjMBWI5ODmXlu6PgB+XC7ShakKuuyMNHf3Bq4smI6ZcOKidQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eZCYVPdjMlmHz3zVmHR1qRwFzk2IfgQwat24X/cHyZ4=;
 b=tcZDrfIh6TfiYDFLOZmotrV4xMOuA7eJfqdOuc4bhpbhGxjVLdTemVj557Mp9OQbvkAGaIchZZfeHoJkwjwgcOzGtdihjFFXiWdPpXrmQN39cqx3x84Al0KB/nTPsvWaMK+h8n0LN3o6IpZJuHgJxQU473V2AOG3eZQ3LkOIkhPKbyfsgesvSI24S9JTmoDq1nrID9IpLO+1IlMho2G1XIzlcsbX8OG83lP143oZaGa8y4d+fFCuFPML/i1MejwSe184nbdYmSPm0ZRRAv0YXPlmahTdKTRrW7hw3fXT5TbFh5o4FuAb9/uTjNqAvB8Pv4anaUAiDxgBhd5uRZTNnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eZCYVPdjMlmHz3zVmHR1qRwFzk2IfgQwat24X/cHyZ4=;
 b=n8YBBjFtouuCcNvWGXVeaAtsu6i1mNNiW+OLn2/lThD0R7uBk6bN9iSZaCVdK6vpmG4fCtl2PmZ+qN2D3RJmjmoO40ThvKsdo0Il2MUyDG3V6EWQ3exyBfPb7s/YOItHUoLVA8MkzZpew4NZTey98MVSUZCYjTZp0+vkkwZPg0Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by CW1P265MB9383.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:29d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 11:13:59 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 11:13:59 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 04 Sep 2026 12:13:58 +0100
Message-Id: <DL6HKYRXHNFK.1D9HYNEPH4GCR@garyguo.net>
Cc: "nova-gpu" <nova-gpu@lists.linux.dev>, "M Henning"
 <mhenning@darkrefraction.com>, "Alice Ryhl" <aliceryhl@google.com>, "David
 Airlie" <airlied@gmail.com>, "Alexandre Courbot" <acourbot@nvidia.com>,
 "Benno Lossin" <lossin@kernel.org>, "Gary Guo" <gary@garyguo.net>, "Eliot
 Courtney" <ecourtney@nvidia.com>, "John Hubbard" <jhubbard@nvidia.com>,
 <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v5 05/11] drm: nova: Add an info ioctl
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, "Alistair Popple"
 <apopple@nvidia.com>
X-Mailer: aerc 0.22.0
References: <20260828033531.1117754-1-apopple@nvidia.com>
 <20260828033531.1117754-6-apopple@nvidia.com>
 <DL3WXUPD5JKE.2GZ1CNJH539ID@kernel.org>
 <DL453EFS03T6.2VGI5TJEQ52QO@kernel.org>
 <apdvTgAp5eGezO5t@nvdebian.thelocal>
 <DL4QCAZXM8EU.2K8MLAM00VNTX@kernel.org>
 <apioGUDamrCur_oR@nvdebian.thelocal>
 <DL5MA26KZEF9.3KHKQXZ4JD2G6@kernel.org>
In-Reply-To: <DL5MA26KZEF9.3KHKQXZ4JD2G6@kernel.org>
X-ClientProxiedBy: LO6P265CA0024.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ff::19) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|CW1P265MB9383:EE_
X-MS-Office365-Filtering-Correlation-Id: a88e6c11-4006-4e06-245c-08df0a759e45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|23010399003|10070799003|3023799007|4143699003|22082099003|18002099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: 6wtNu0tYtZ0cXriZ8WLPDvTBoWJ5ijxHP2pmyke3J35SA7VnXU7XpLbI6XbZpHcrj5wVTJJP+oehlWOxMOGmqU9oqCipuxpEE5eiY/AUcsXYwXIfdopRQhB++zId4SHcYKsyu1iZnlAyVmvlp0YSapGzE+L593FskePF2aQg48JmopUvbQxcX8XqEau+X5FG5mN2Q10o/6pwDl7b9JYG+DEBNfWL676WFmz6LsV0o2bC4fq2E/KG3l1vjJKj7kKakU8eh+9LlBqD9SawhCAeW+rungS3jr/L80MxlQgK2awbgtOhad6sFMFRqQPG/6xpNOL24BJC2ZPPZVOq9EfK8yuWwzfezrvqv3O6KFQT4HiYx+/0LcP+2UCWU2T+fuIkabvFbnH4zS0SWMuithumf1jTIM2jaTPRmYmORMaQKcIGm136dgVhTBUrChHnBYF0aJUuZJV3XLFK1Q38RY1Q91cTQSNpXOSvjGJZTSC3tP0oFOxwKhaH7XILGRx94CB5J/k/sVVL0oEIVkGZ5Cb+ddMcNrBi/DlydDSrjaJYcGIuo6xye9P3WL/vi3f5NGaF++flSO7iouhf7/vAQItt7WO3YBMf9STNgqSSU/7SxQdk2XUlBxPzsF1YXNm6+AuaP8CXI/BXrtxCnRgLxRg2eJF0Nh9v+yBPPZ/R3q0FNWs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(23010399003)(10070799003)(3023799007)(4143699003)(22082099003)(18002099003)(56012099006)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2RmOFR6SGhGSmJjMnQ5Q094aWd6bmJ2MWZ6MjRGdVdMenY4WDdvNlczODVU?=
 =?utf-8?B?Mmk1dndSTUVBOC90YmRNQjI5U1pMTUNqUHhONnAyZkE0ZE5yUnNxeW1aOHBW?=
 =?utf-8?B?S2t1cjIyZGtXTjByRVU2T0NPTWZVRGNPT3UzalNIalRYMi8zbEVBSXBRczhS?=
 =?utf-8?B?QlJOOC9sZjFXWTNzejVFWWZFL1hhZWw4YlNEb1JrSUFCejBHaW92VWpsdFRI?=
 =?utf-8?B?cUs0V3lUYzk3OHAzT2xyNmN1MWlmRDZML2ZFa2hYamZ5Und6NXVBZ0xUb3dz?=
 =?utf-8?B?Q1pXSlJhVWI0ZFowT2RiWU9LcnpMUFExYmxCY0tTZ1A4MG9zRVhwenoyY1My?=
 =?utf-8?B?N0dxaU9hdlZhdFk4Zm41amdTcXkrbSsvNnJ4dFBJWUhxKzNpYm56U2lsaThF?=
 =?utf-8?B?TkpscDBDZmVQSi9jWU4zR1Y2SExHRHBNc0VRcFI0Q09ucFdVMFNvQlAyZXli?=
 =?utf-8?B?QWdsWTREUDZMdVZ2bVFnMjhQaE9Xa1hyUUM4ekpwWTZnM0hla0pJU3d4QTFj?=
 =?utf-8?B?TGh5bnVaTlNvQVFRZS9POEM4a0xPeWE1QXdLNlZCR01mTERWcWE3QlFxTmFM?=
 =?utf-8?B?Zkc5dWlKem1kenJoRld4b0Q3R2JKUzJjVEtMSUpuaFpHU2VkaHBJTG1QUk45?=
 =?utf-8?B?d3FnSUFtMDRNazlBUHB1VHc3T2tpc21KRkVoWWtyZzlFNklvbDRQOEF5bzVo?=
 =?utf-8?B?MVlBQmExelpwK3pMcms1YWFFRWloNXdBZEljU3VHSGh0ZEhTR2o1b1hRbWdD?=
 =?utf-8?B?MlBoeXIxYVBtZURKK2QwbXAwZWhwejgyWnBDMmxrTndkRlRGTFVkVnJ2Z05m?=
 =?utf-8?B?TTJwYTVVQ1ZYV0QrM0g2Y2MvWExwcGhZaEVPOHdWV3ZER0ZqOEdFeENFNmNZ?=
 =?utf-8?B?cTJ2SlRuSlNmRmxxaUJIQVB2dzBKTnZTaFFtM1JaM3Y4eXRYU3ZwL25EbURB?=
 =?utf-8?B?VHN0WVN2NjI2TThxOEVlWFV2YTNIUHFMUWh2ME0rUmRhK2ZKTTZRVnUrR3I0?=
 =?utf-8?B?Ny9GeHAzemlpMGQ4RElMZ2VENXFjc05PQXZnM3l3SWllT1UxRUNJRzlGTWpE?=
 =?utf-8?B?NStOWityZUFwc3lMSWtwOTFkVDVuc2JPMWRkWExXbW4ydkEwTWpzNWtNYlpu?=
 =?utf-8?B?Y05nTHVmZyszRUl5bDhXVDdFRVF2SEY5bDF3c2hvdUhvdjVRaGZZUm0zWlho?=
 =?utf-8?B?OHNQYWx5ZmtUdEZ6cXkzMXpBdzJpaGRGUjM5aWxldS9CSU9IRjRTcUVibW14?=
 =?utf-8?B?RGtWRVlwdWt3c0V1YWIwZVFEQnlEeWtzODJkU0x6bFlxNkE0OVBraEh1bGd2?=
 =?utf-8?B?SFNoWk5palJwbTBvbW9jUkRvdGFUUmtKY1hBRVBxeGsvNkhtdWNhNVI5Szcr?=
 =?utf-8?B?dHVKSzVXZjBQaDNFcW1RL0xTZnlFdElJV0oyTytlNlNsaVNQQmVBRjVNUFRw?=
 =?utf-8?B?TmJvR1I5ZjNXbFQwMGtZNTBDOGpZeEttTWl4WmJxcmYwTlBJZnE5Wk43MUhX?=
 =?utf-8?B?a3htRUo5QnRja2JWNVdNL2hXRGdrV2E2dUtRVjA4ekl5MnlwT3hndWp2NzBa?=
 =?utf-8?B?d0hWUENoM3Irc2VUTzRzeVZ5Qk0zbVR2M28ydXEwcWlPMUZwM0Y0eGcvM2V0?=
 =?utf-8?B?d1pkMXFUYi9LL0I3aFVQZ0JXUEhkS0VoZ2l0bUQ4L2hrNHJ2N0h2T0NxN3N0?=
 =?utf-8?B?OWRscHVnSm9OTXNDZlJxNmxqU3F3ZjJQRFh1YU02dWE3aXpLWDN1UUFRT3k5?=
 =?utf-8?B?bU1FN3kyRDIvUlVTT1FqMGhha2VXWSttOWEycVdmSGZ4aTNLY2htZ1NiK1Vz?=
 =?utf-8?B?OXh1c1ZKdnR0bDRXSElwSGtYUEZJb21rYytvb0YxQlZvT2VXbmlVRDdydlZn?=
 =?utf-8?B?eGNqSG5JSktDa1d0U1NhMmE5SU9sRGlWWWw3NkhtcDNvWXNzaVZxb0tPQ2hB?=
 =?utf-8?B?bU5SbjdTb0Qvb0dTbjRVMmMyZWoveGxYajVMZ2hncEdEbG81ekQyWDk4TU5z?=
 =?utf-8?B?Q2hwZlFnWWs5c3RBcUN4ZEZsS21OZFNFaExmb011M000RWQ3U05UZDJCdlVi?=
 =?utf-8?B?bHdDKy8xdW1qV2F6N3JTeDdkQnltSjd6a1k5RFR3Y0dDVFFtZFZNNmxqMlZv?=
 =?utf-8?B?NG5KUVFSK0hkWE5ETXhncXVxeHdmRDFwbUhpbS9IdkVQVk83VkpyS3lOcGU3?=
 =?utf-8?B?djR4bi80T3Y2dHYyYUx3cnhSdzdMSzREcFNtenJlZmNDaWJEL0x1VzA2YTBS?=
 =?utf-8?B?enBkb0JkQ0Fvb0tsYklEMGQ1RlFHenh6Nm5CWnFBMXZoaTYwbUlIejBPakVR?=
 =?utf-8?B?STk3ZURPblpDK0UrRmJMZmUwaUk2THZuUG4zMHNBTi90WGQrUnJ6Zz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: a88e6c11-4006-4e06-245c-08df0a759e45
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 11:13:59.3787 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JR0aztBHR3LOUqmYUibtSIYv2JZunkkcKlnhpagJL88ilmohHoBFCmfChBhHHAJmxWgj5w4n6Hxf9b7F/0vgkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P265MB9383
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

On Thu Sep 3, 2026 at 11:42 AM BST, Danilo Krummrich wrote:
> On Thu Sep 3, 2026 at 3:12 AM CEST, Alistair Popple wrote:
>> Originally I thought the point of providing the decoded arch rather than
>> chip-id
>
> I think there never was a "rather than". The point was that if userspace =
has
> conditionals based on the architecture it shouldn't have to figure it out=
 based
> on the chipid, as this has been done by the kernel already.
>
>> because as you rightfully point out the kernel doesn't (currently at lea=
st)
>> care much about the implementation
>
> I still don't see how that value will ever be meaningful, there is no suc=
h thing
> as "all GPUs of a certain implementation regardless of architecture" have
> something in common, is it?

I don't think it's an issue that implementation field is only meaningful wh=
en
you get the architecture. That's pretty common for other IDs, e.g. PCI prod=
uct
ID is meaningless without having the vendor ID.

You mentioned in an earlier email about the typing, but we could still have
meaningful impl IDs fully typed like this:

    pub enum Arch {
        Turing(impl_id),
        Ampere(impl_id),
        ...
    }

and some langauges can do better, e.g. TypeScript allow you to write

    enumn ArchId {
        Turing,
        Ampere,
        ...
    }

    enum TuringImplId { ... }
    enum AmpereImplId { ... }

    type Id =3D
        { arch: ArchId.Turing, impl: TuringImplId } |
        { arch: ArchId.Ampere, impl: AmpereImplId };

So I think it's a reasonable design to have it.

>
> But since you say "currently at least", are there any plans to give this =
value
> some meaning beyond being a unique counter for chips within a certain
> architecture?
>
> If so, I think that'd be a horrible way to encode some chip commonality.

True, but I think the chip ID is as bad as impl ID. Feature detections shou=
ld
use dedicated featuire detection mechanism, not looking up IDs directly. I.=
e. we
should have userspace not having to use either chip ID or impl ID as much a=
s we
can.

That said, I do think looking up tables are unavoidable, for getting names =
or
applying some quirk fixes. And I agree with Alistair that if we include it,
including impl ID is better than the chip ID, as we should rather not havin=
g
user space relying on an arbitrary encoded chip ID.

Best,
Gary

