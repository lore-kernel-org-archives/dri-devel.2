Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFF52C624A4
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 13:13:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0231510F5A5;
	Thu,  3 Sep 2026 13:13:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="xE4kJfps";
	dkim-atps=neutral
Received: from LO3P265CU004.outbound.protection.outlook.com
 (mail-uksouthazon11020133.outbound.protection.outlook.com [52.101.196.133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1DDE10F5A5
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 13:13:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xxydyY/cOtHuU1kUFswH3l4GTFlECvwmkPpU5f18lso6Oft7hC5D/5Yn3AGjrqNOe9BpPNUQZMpJgGMSuzexAl8S7cAs4DF5dwH6F4x7W+AhQZjJ6LJzoKohEDC9IHZyWKnK8vQW3zsAepEYfQbXHdzBRYaumCYgGkIzNM96r30EKLitHy73eldGIMZTHv4lGXAHMczWq45zGtVwBEYJK8D6JaBBB7dQKRDSGlx//mZtF1XwcpabUbdGSlfc2dn/eiPBKHdXGo8PdkDu6Yg+v+WPJzYE+vw1rRsw263mRc8K8dEzwUgDl3u0IfxHoHw7Gna+h/T7bdfgWdOLOku4sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p2+s1yIyoxWcCi42ospVrfd3RZEqCQWybsdShaW0dH8=;
 b=e7esMeieGue5p8LVEPHftY0qWeHHa+PaFsxIycdMr8FUQjSfciIhU77fkAL7Ozx2hZlKTL6As/FVtIM98M+r6CvHdfpW+vkhy64cnCCECsY8ZVud4tSIR8KqPabss7xbl81/UuslWgfwOz13F9NZvZ2R+Y6HbKJe8GfGWTBOYiHruNRwwNHsWtmogH0oZnhafNleoZtLKGD6AF63Hrepi+zEZG1623YuNhYB6OyHVyQGcBl7ilWJ+J1+RqR83KQuWck2NXW2lhVbwfdOEbSoytHkCU0k9gefcI88ICs8ds1OKuxSzd2mSN+Jk7XXCxKgFSpJcEkQfyHpvMCiQN6/ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p2+s1yIyoxWcCi42ospVrfd3RZEqCQWybsdShaW0dH8=;
 b=xE4kJfps1xb0hlv7uTgI5uxLClkedqUmqrFGnQUxijlw+dUuNyHo2gPzkTQmL/Iv0WPmwe8Y9++Uu2+QNt3eJJKUWv44kH7NZZXzaCSaD9yMsJUWn/qADCUlb50j0me1GW9tSKLj3vfLySmbH6W823sLQyZEZ0JUmO/sroafiy4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LO4P265MB6666.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2f0::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 13:13:37 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 13:13:37 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 03 Sep 2026 14:13:36 +0100
Message-Id: <DL5PI0KB8YQN.1PH309MNNLB01@garyguo.net>
Cc: <driver-core@lists.linux.dev>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH 3/4] samples: rust_dma: separate driver type from driver
 data
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, <abdiel.janulgue@gmail.com>,
 <daniel.almeida@collabora.com>, <robin.murphy@arm.com>,
 <a.hindborg@kernel.org>, <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
 <aliceryhl@google.com>, <acourbot@nvidia.com>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <tmgross@umich.edu>, <tamird@kernel.org>,
 <work@onurozkan.dev>, <mmaurer@google.com>
X-Mailer: aerc 0.22.0
References: <20260830193824.471089-1-dakr@kernel.org>
 <20260830193824.471089-4-dakr@kernel.org>
In-Reply-To: <20260830193824.471089-4-dakr@kernel.org>
X-ClientProxiedBy: LO6P123CA0024.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:313::16) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LO4P265MB6666:EE_
X-MS-Office365-Filtering-Correlation-Id: 30387bd7-bf1b-4821-8220-08df09bd2a36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|1800799024|10070799003|366016|921020|4143699003|10067099003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: Usma513ztTQ6kwjXoSa/yqloLMqXdboYP6gKtPFWgImEdNLI34EZvKXTxZRFj3PBiFn1oe+3OCoXGhkefesHeiOnVOAxIsykn5xXGYa6jD8zICwl3Pf8yKR6yFjToj2dWOL1YiZiqIE9HtJ81hBF3/t9jRYFlHpHspO/dolzlwwmtfAC5xgry1+A/iK/ToM2IMH3SVPGsXFauuo8IhKnc2fvDrqSnIGE4vNXF41y459VkZ5myEEeM9jh5wszRfvV7DTJ1T0HBOjV6CNpOApt8zWuDhNr/c0yNSquNeuE/kt1clw+87yuFdWG6ca7SB82z4lFRlEjKHL5vbMS5DWZEIqTa/C0xJq+ATgsAPcpSCG8uRoNFUV4H26/6Q2IhdPlfe5wZ3PRRO9pF8XOSwooFeeFgZsATuvgFKq0Ct+7Es+LFXyjkfvYl2SYJfZbuVPRX/GoQdvuTh/NsYBAqZsyxvGqdC++I1+kj+TUibYocQuxexaX1WF05CYxgsY5bcVkGSC7eVc8lE8KPJk4nvNpHbJNXVFKgmLEpODFRAeLZTPJB/smxojwQWceICL6MmHz79uvp3JmeGwifuEdn4DW+3LrF4gujFo0XA/BLbcbw0kf713u8mlW7+SdGn5pMqSUc44dt4G5OsILhET06E39nqqN6a94AmJwh7w6GIwjDVKO4GdTWZZnjCKwBlJCl5kcvQnuwX5XGRwaatD5JUOZtA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(10070799003)(366016)(921020)(4143699003)(10067099003)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFNET1k2R1VrY0oxZW9Xc2pkT3dmTysvMm5vbHROWGxDRGxTWXdMcE1SSi9l?=
 =?utf-8?B?RFN6OFRZRDBqZ250d015K3JZazA5bFI3aTJzZjlYam83YlpDU00weGRZZ09P?=
 =?utf-8?B?N1VnTzFiSTBJZnN4MXN0R2NjaEV2WG5WWW5RZmlhRTZlcjBvMi9rL2xpZkVl?=
 =?utf-8?B?UllGRGtwdkZUb25rTmg4dk45bm1kcEdIVHFjUXE2Y1d6V21PdXhCOGJpR21J?=
 =?utf-8?B?VWpTU3BOMWxEZXVQNXJDMElXTXV1RGo2bk85REFqZGpwUkpIaTRUZHJpUkk5?=
 =?utf-8?B?K0puVDhqRzRrSkxZR21Ba0tOcmdXdy9zTmxqZzRERS9rQUJqWThYOFdKeXNM?=
 =?utf-8?B?eFpSU3U5T3NUVmlRWktySjhEZE9oNGI0TXBveHBqUXEwWGVuQWowQzk4YlBj?=
 =?utf-8?B?Z1pWMThZMG1odER2dHNRTXRNQkdpRU9HUUkxbTh5UGdnb2ZMNkpPZjd0T0Zm?=
 =?utf-8?B?a0ROTlpZdG5jWEJCdmhYTzVDN3AvZnRNL0lJVDFXeG9zamdFMnpSK2JhS3Rl?=
 =?utf-8?B?SEZwY3BGOG43dERZei9FNUtSczk2VjJHYy82VmgyVjVzTVFOMlFjQ1ZPNmw1?=
 =?utf-8?B?M3NPdGhkOGZZRjBpRndJTE9mejd2Ty96MHNKODR0Q1VFMjl1S0RwVElxZk5u?=
 =?utf-8?B?dDJoNFpneEFibEh5OHlJcEZ5djI3YXJLam4zVEhaV1RRNm5mckNaT2lmZGxU?=
 =?utf-8?B?aUVSR0hTci9vQjBXODBhQVJFNlp5eGFrWXlQeVgrRHBZSVg3bTEyYmNzUkEy?=
 =?utf-8?B?S0NUdFlVZ2Y0NVdyTzg1Q3JxMDJWVndBRmtjUkIwUVVqQUh4UFFOWEN1WjJw?=
 =?utf-8?B?UGwwVUdWbHhqUFQwdVc2TnkvN3lpeWpVQ01wVit4VGVWeHBFUjZSM0FTZVNY?=
 =?utf-8?B?TDZHRmMyT1hXRnFVRGJPTVNDdmF3VW5ZUXVNME9GWk93MDBGcHhnbjB0UVA1?=
 =?utf-8?B?d0dqTEpQc2xqMDQ4ZHJPYjNXdXRqVXVVMTAyd1R2NWovT1dLZTVSUkNKZUt4?=
 =?utf-8?B?aGZIaVhtMVZkNkdYVVNSRUZCazhvdzV3V3NpdGQyQkMxM2NuaVRsdlNBOGlK?=
 =?utf-8?B?VFhTNVZYek1JU0p4Z1hwN0w3QXZHbVoxQ0REN0QvR2RtemdQQUVZazFJMWVn?=
 =?utf-8?B?SHRDWlZIRXZwT25HNkJoNHJuNHJzMXVOLzJzMHlNdHk1Y1FXaVl2WWJJdWxL?=
 =?utf-8?B?bTdQbDNvVjA1UVJxb2JCNU5pbUl4NTdvTlFuL3hPTDdoQXdsdmphQkczY0Ex?=
 =?utf-8?B?elE5cDUwMFlxbUQyUG1rUjBzVGFheDBmVk1UTTc0cVlwN3RDa2srYVdVL2xv?=
 =?utf-8?B?akNZV3pOR1cvK2lmM1lVeGNyN0VRUmxjaEprR2hFcmJxT2ZySDI0d1orRDJJ?=
 =?utf-8?B?QzBNbUpRaG8zSnVTVVQrcnVWaWMwM0hpRTJYMlpwZmFJUzhjZFVrV2kyeG5U?=
 =?utf-8?B?R0hmbzRmMitMRHpDTEU1U3ltd1JtU1VLNU13MWJnWjBQSWxxUk5obXRxV3Yv?=
 =?utf-8?B?aUFrVWlGSUI2eDZSeVhzczUrcEk3dURYUWgxVVpSc0I1VTR3Wks4SlBHMHFo?=
 =?utf-8?B?NmdUYWplbU9Ha2kwZHVmenBiL0VpSkZPZU1BMEZseDNaZFQwa2d4TklJRUxm?=
 =?utf-8?B?c2hJTzd1M2ZXSHRtcTZKYkd6VmVmMGZSMzJ6WTdLWjgwNFpybitHMDhHcUxX?=
 =?utf-8?B?STRqVzRnQTEvTTFSaWEyWGJxdEMwS3E0cldJOFBxZHBNcHNGOUlsdUs3YVZF?=
 =?utf-8?B?R1JQSmhZWnFScHlOZUdkWVl4Uk1iSHBRYzQxeUorZ2JKSEtOb1RNbzhhNy82?=
 =?utf-8?B?NnhsT3M1STkyeCtSb3NzWlJXY2oyWDNBMzlsTFNEL3BNeUo1cGpWNTJpdWs5?=
 =?utf-8?B?SnJqblpjTW9ybTJCSnp2amVIekVvaDZIU3JJSHRrSENSS2l4QUdsUTBHN0Fn?=
 =?utf-8?B?ZUpXM3NiVDg1eVp1MW9uZVFsQ0JDcVpiRjVOK1BWdnI2NW50SDB3RDM1SHZx?=
 =?utf-8?B?MGZudXI4VHB5QmhlR3lGN213UnNaWURCUkNBSmYvbkV5TGNUeEpEcjFpS1Vx?=
 =?utf-8?B?VG1GNGFjS2g0L0dCVTdIVU84SXpkWURlTXZKY2VFcXlqOXhTUG9hNWpYcHhO?=
 =?utf-8?B?Z1hPdVNwUExwd0tWUVhpNHNIVC9VcWlzcGR1ZlRkekVVYUk5L0o3bzA2OUFN?=
 =?utf-8?B?NkFqWlNDQ055d1hUVWZOMjFZOVc4N3FSYkFoYjRHa0ZOY1VMOEJUSlMxdFRh?=
 =?utf-8?B?cXpCUHhyOXFFR2tadE9nZ04rbFgyWTVLTUZGRzNlSGkxK0Y4NjFQNlF4QWgv?=
 =?utf-8?B?OVJBQkxmY0drOVhWaGZycDlRTm1HdStneVJjcjhZUVdRM2pubmVnUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 30387bd7-bf1b-4821-8220-08df09bd2a36
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 13:13:37.2432 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jpB/nYT5f4XQY4nbjRFaiopCklNm/t2D6h511RQs4NTUVpUwDsDXPafg26U6p9f7UVdPP9L4Px0awEUexewH3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB6666
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

On Sun Aug 30, 2026 at 8:37 PM BST, Danilo Krummrich wrote:
> Split DmaSampleDriver into a driver type and a separate DmaSampleData
> struct for the driver's bus device private data, using
> DmaSampleData<'bound> as the Driver::Data<'bound> associated type.
>=20
> Store a &'bound pci::Device<Bound> reference instead of an
> ARef<pci::Device>, tying the data to the device's bound scope.
>=20
> This prepares for adding a lifetime parameter to dma::Coherent, which
> requires the data type to carry a lifetime.
>=20
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  samples/rust/rust_dma.rs | 26 +++++++++++++++-----------
>  1 file changed, 15 insertions(+), 11 deletions(-)

