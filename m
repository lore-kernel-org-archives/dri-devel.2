Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 780B1CA600B
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 15:05:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9ADA10E900;
	Thu,  8 Oct 2026 15:05:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="JPUMJscl";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011002.outbound.protection.outlook.com
 [40.93.194.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B108B10E900
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 15:05:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fC061l+Wht8WnNcCGV7ELHo39X1t7Z1hvVq9KF4uun98I2XyVJdtY3fboILoLulvzyEjzUEkkJ/8CKMZB9fhba6rBbweoUJ5pj46MjANxmHK9nRPPccfjsbIPKzplaWE7sl5WmTFr3nN1XF68FXyPwTQXMsNY4OJmoH2SmdNh/G4oAOcJSFh8zW9k6GwweHXXZhfVqw/QX7dyPKBIHG2CPsmwCBJS1T9zfxXHazf6hkzJqFJY6DBd0UqZhNVuvp30IxiElEQm27YUJd3DiWA7BmT3CTtvTPlZz3+YauBKn2rRcc4/RWvXZLf4T12PIj9Fd/4JfY5CQG9Z56OQ/SZlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DSV3g4WHMXp1fUJ/Fkg7i6Y7bAc897dgztWB5wVjc5E=;
 b=nirx5Eis4ZuUd41MZVvAECAOPu4tGcTeBvN6CgKIsK/zJOLGgdlRaYurLobshsqqO7DAVCp97xjsRFr1JZSNK1J+JQap6LdOlPWJlIoLqd42OoHvQq8BSODzbyV6UWdRTO2CxoFr1Lw6op+CjNIIk64T+fw5QVIkG4leus9t+6pdMUdyjyuchnOdfLZm5lO1ybDt+NHQFF1+456MbjWB5oRhp1phLdRT/VYdumfzk39DhS19iqY8mzLqjGIzkzgl/ikVZx+A4514Y4hBog89VS7yelm+ZMfr/JhiqST/HJODJHqffUZX+b1sJKQvu/GkfdZCWIXK2C3MO/UPzzFI5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DSV3g4WHMXp1fUJ/Fkg7i6Y7bAc897dgztWB5wVjc5E=;
 b=JPUMJsclHxXqHiERkGpm/Le6CvKgqQSrIxwcOM5AZpsLIU1JFaePuzdfkFTl3HONzYRtvqXsw61G7h+v2ZeUcRMj6vzcv/Xv3DWAL9gVV8rh7ZGBufwhGw6fWvu8ZMvxf68ukansiY+xlwWZ6b9/zuUI+v6qL3k4Be1JymSafIPE5xO2b+YVEbWYAjweG0GL9qfGilpX970uWGWmHFOEOzkk/rw5V9nwjJy8qyJEWT3gZQrc20wm9dLparA/rkiWKeh565ZJJmIOZncNv5/rRgbrTUhVoVDexwRX7KGd+yM/jclsCCjCsX73zpufNVKmwiMD55OBCXVz6Sies7jG/Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by DM6PR12MB4155.namprd12.prod.outlook.com (2603:10b6:5:221::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Thu, 8 Oct
 2026 15:05:01 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0472.016; Thu, 8 Oct 2026
 15:05:00 +0000
Content-Type: text/plain; charset=UTF-8
Date: Fri, 09 Oct 2026 00:04:57 +0900
Message-Id: <DLZJSCA10YBI.2NIG6CA24G8L@nvidia.com>
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>, "Miguel Ojeda" <ojeda@kernel.org>
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Burak Emir"
 <burak.emir@gmail.com>, "Yury Norov" <yury.norov@gmail.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
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
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>, "Yury Norov"
 <ynorov@nvidia.com>
Subject: Re: [PATCH v9 0/9] rust: Add support for reserving of ranges of IDs
Content-Transfer-Encoding: quoted-printable
References: <20260930-chid-v9-0-0d6cca376cff@nvidia.com>
In-Reply-To: <20260930-chid-v9-0-0d6cca376cff@nvidia.com>
X-ClientProxiedBy: TYCP286CA0149.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31b::12) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|DM6PR12MB4155:EE_
X-MS-Office365-Filtering-Correlation-Id: 95b12000-ce58-4d11-0a8f-08df254d8665
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|23010399003|366016|10070799003|18002099003|22082099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: HXCFyX7MApR4VqfOU7tlPQN+UREKOG65YpHBiUdTjEDKv/YmQyvMT2SImZnBH0oNCx1mNI4GvdwMspbO7sJ5NEZBeeKvjwtRmouZ6uoU6FtiZSC2f2xhJmzT0h5E+BKg23n7Kr61Qn1zsowc+QGeX/497Kr2s6K+QDSxjMwOPq8fXujHNo7OPGSWwonqs8cxlELJf3a8tR9agsqRsck16sp/lQmSq2B1jxB51Y5d4Eu9i9jfdTGCBahva0xbVV2sFVqn/xVWK9o00+WgKUFsY3v8hBt4DFZfWcIZb1s03ZzeNP5HHxXqZkyO25SZB5gHmHB80CVUEg844QNBhu0/sF81GrtfwCsca/88+wMIQiwpinWF6LylIRV5JdskDdyOdEKnHnG+jTiu+UeUZ1r3V9gLc+aR6lr1O3UEw/FVAvQ5lY8et5iNcrYxGQOfWz3y+3lRZ4/Qi+FZPFqBoZPVAUUCOv12s1cmfpqfYrnw+33mqNa2YKXdTvmfrg/lWppnb/qyY7yzcvXgJ97TRAblT8etYsI44ts2sWz+1cwgarqiZx5iBdEwqxbf/E4uRu6UIaQzPdshk8StVYCznMCqWKyH2vCHoGvsQLeO/iQIWwBPx1ER+LEXCns5aSlkHo0aNcbsOFQti/pSRWEsgxaRBFMT4X/7M7yk7yjO9AnZ+mc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(10070799003)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnIwNC9XbDgrTmpPbi91L094Mkg0djZIaXBLd0h0REtyeGlmVjFCeEUzbnEx?=
 =?utf-8?B?T0ZMSUdSYUg3bmNLZ3paVUUzdnp3bFBaOWx6L3pHdWVaK1VtN3ZqRDNuZWJ0?=
 =?utf-8?B?N3BxbFFGOFBNMFJhUU9rbDF5ZmVqSzM0aFdKaDhUNUthaDY0OWNaM3Z1WkZo?=
 =?utf-8?B?aTlub201dHdFU3FURHV5OGJBc2hqaXVIOXMvUStiSHFoZ0tLejI1NlpUSmlV?=
 =?utf-8?B?OS9zbTQxMUp4ciswNm9QRUVvekZQT2NUdUxsU0NBZ0l2aXhvbmQ5TkZjelQw?=
 =?utf-8?B?M25rc2RMNGpPOS9EdDh6TlFXOHBobVhhWEVGQVpBQXFPTlBmOG1kUDcycXJR?=
 =?utf-8?B?OERnZFU1eDNKQXZwbGpVcFl0RkxpbFhTM1hGRDZXcW45a2l0cUVTdFhaSG54?=
 =?utf-8?B?YVc1VVcyWm0wbllEdEhINVR6UjlvczU0MHF4UjBlUUlSTGl0dUhLNklpaERn?=
 =?utf-8?B?eTdQYXhjQWtaUTdoZkVnMHBsckRXc3B2MStJRTNHUHpIMkVFODg4YnZnc3M3?=
 =?utf-8?B?NFpoNEl5Z3BwSEFRbDlnaHBHRHE5YnJuTTFNK3VMejI5TzkveVdTOXhVcjd1?=
 =?utf-8?B?aEpQaG5pOUhLdDJHUlMvSWVESHBWTzZDS2JBMUx1aldIRGRGN2pLRTB6Mzho?=
 =?utf-8?B?UHh3QVowYzJ2bmJaMEh2aGFMVGxOSVRvVldVTis4ZHJmcE5HSXpZWmxuWmM3?=
 =?utf-8?B?Q1JtNHdiOVY5NEZEd2p1aWF5SXRrZEQxMzBpaXN3anU1aU5qUllzTnA3aGlJ?=
 =?utf-8?B?cXZ2dnF3Sjcrc0VoRmFIYk40Y0czOU1FNDZxRlZKVjJZRnJST1FWTjZQYmRC?=
 =?utf-8?B?d2NpZmRZQ1lpSDNJL0VYZUF0NjhQMFcrVUZkNUl1STM2WWt4TU9LcTJrMFVZ?=
 =?utf-8?B?dldpN1JwU1NIeEQwazJHbXNQQVBEb01hREppQXhTYXJlcWpHTDd2Vi9aaUl4?=
 =?utf-8?B?TDhVZzg3M0V3MHl2RGIwWVNoeXc0bndmSGJGUlg5Y2pheGRRVlZJQlhFTmM2?=
 =?utf-8?B?Szdaci9vNXNSSjNsZSt0Qk1VOXY3N3dNWVY1dVlINmxuQjFmMjNPbmdVMTNZ?=
 =?utf-8?B?dW1HWWNPZHZLNzBPZzh3c3dPUlJBdE9yN0hKcXNXVkdSa1dkTHZwd3h3Sjh1?=
 =?utf-8?B?NHBTNGlGNjl6RGRiSFpIa1o1RnovVXFWbXluZkVzbWlHM3VYRTJCUnI3SVhj?=
 =?utf-8?B?SUlucWF1OGhpVHh1aUtiek1HdDdlWVJkZ3V3YWpycmtDTkpaUVJheWpRTTJX?=
 =?utf-8?B?Wm9HdFkyUVlGMXNoaU1yVFRRUHZEQlB1T2puazdOalRrc0tNVE5ySTNUSUZo?=
 =?utf-8?B?MUpsblZmODlKLzE3RmxjTTN0bFlOSFE1VFQ1dDN6U1ErTE1HTUs0Wmg5QmlP?=
 =?utf-8?B?MEVOVitWYUp5VEtHQlUwSTRwS2tHS2VlazlWcjQrZjBxOTYram5OVVA2dTdz?=
 =?utf-8?B?aW90Q2hlcmk3dWVjaEV0bEYyOTU3N3pQN2hUNXRNcFIrc24zOXkvb3M0bjl2?=
 =?utf-8?B?ZjVFb0kvWnBFT2d2WDJLMGdLMjNmVjBPQ0R4SklVTCtVT2NHL2VTYU5mU1ll?=
 =?utf-8?B?ai9KRTBMRVo3S1RQQmRqUjhIYlRLMUFYTC9UMmN6aGNhWkZBNFV6VUx6b3A3?=
 =?utf-8?B?V3FJbjg2SllIdW5hRG93SGwrekJER1pjYm1vSnB2eUdua05UV3VQT2tZTG55?=
 =?utf-8?B?eVVBSWx5QnpzVlYrd0dXVXNINDA4MFVzaVVTU3VFNFJDaFFvWEZqRitLZGVh?=
 =?utf-8?B?SFV6WThwdHkwcTdMTjBwdGJkRHRVN08vU3NlRmF2bUxoWllrZHR6NnNSdEw3?=
 =?utf-8?B?SmJ2bmNPN3ZQeEZsWm1uSzRKeFYvUlI0SWRvVE5iRmRybHZxODR3YkU5bitG?=
 =?utf-8?B?K0dhY1FWL0t2cXhwSldEdGFaSnRnYkUzckR4SC9vZE1MYmlFMDRiblV0UGZW?=
 =?utf-8?B?YzYrdkpNZ1VVM1drNjRpbGR5V28xUDJhWGQ3aVZSSmlvNDZLWXFUK2psemQv?=
 =?utf-8?B?KzBzUUdCRkpTNml2ZXkrQXJpaGcwZTRaSUUwcEtxbWt6WVgraCtkUGczbzAy?=
 =?utf-8?B?c21RMUdXTFFQaHkyYVdydHRaWTN0ZHN1dGEzd2xFbWw1bjllcGo2bWt4cW15?=
 =?utf-8?B?S3RPbVE4cVFKVkF4TTI3VlNFblQyVEFzL1JwOWduZ3ZWU2xtZmprSXZVSVc3?=
 =?utf-8?B?aXlWalZKb3NVd3VxaU5TZGp4VEpsamtNWURrcWZZdDJqVHNUeFErUGUzT0My?=
 =?utf-8?B?VFQ4b3JZeGdTeFk4NFRFeHJHMzBnOXp4L0hRd0REK3hBNlRoZVhJYXVpOTNS?=
 =?utf-8?B?T0c4ZWdWT2x0WUZ6V01seGw4L0UvNVk3TndzTXlPbkN0SFFCbjFNMGc0Ky9R?=
 =?utf-8?Q?wlVFF7oEglCIKDnSUjUlumv0w8wKvJ64t98u5sC6dER+d?=
X-MS-Exchange-AntiSpam-MessageData-1: hqtlpDqUE4hVOQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95b12000-ce58-4d11-0a8f-08df254d8665
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 15:05:00.9182 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kiEJ9ei2/ZXvTLP0CPFTRb2DzC3lKi06dadHv6xWLGwxQCaf1LieRriFAp7qYTB5nxAInzbUjJvetEWnYStJ1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4155
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

On Wed Sep 30, 2026 at 11:42 AM JST, Eliot Courtney wrote:
<...>
> Eliot Courtney (9):
>       rust: bitmap: use function-level cfg on kunit test
>       rust: bitmap: restrict bitmap length to at most i32::MAX
>       rust: sizes: add sub-1K size constants
>       rust: sizes: implement SizeConstants for Alignment
>       rust: use Alignment size constants
>       rust: bitmap: add contiguous area operations
>       rust: id_pool: add contiguous ID reservation
>       rust: id_pool: do not round capacity up to BitmapVec::MAX_INLINE_LE=
N
>       gpu: nova-core: add ChannelIdPool

I am wondering about the merge path for this series (and the `cv` one).
We would like to use it for 7.4 in `drm-rust-next`, but given the
current timing we can either merge it there after `-rc1` is tagged, or
take the bits that apply on `nust-next` now.

The bits that apply being:

- Patch 1 of the `cv!` series [1],
- Patches 1-4 and 6-7 of this series.

(patch 5 touches mostly nova-core and doesn't apply on `rust-next`,
patch 8 lacks the required tags, and patch 9 is a nova-core patch)

Since that's quite a bit of code outside of nova-core, maybe it is
better to merge the non-nova bits mentioned above through the Rust tree
in time for the 7.4 merge window. All the patches I have listed should
have the required tags, but the `cv!` patch needs one last respin to
address the remaining comments and add a "Pitfalls" section at the very
least. Miguel, does that sound doable?

[1] https://lore.kernel.org/all/20260917-cv-v4-1-547ef5727451@nvidia.com/
