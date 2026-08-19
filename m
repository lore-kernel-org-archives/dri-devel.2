Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63793C5DF88
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 17:29:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C8C610EDFC;
	Wed, 19 Aug 2026 17:28:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="mnm+wX/4";
	dkim-atps=neutral
Received: from LO2P265CU024.outbound.protection.outlook.com
 (mail-uksouthazon11021139.outbound.protection.outlook.com [52.101.95.139])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B4B910EB15
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 17:28:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uY2CxKXHaxIYaGL3MD6+GE5rlraZpmzs65qIcBwCsTDCAOnI/vTNmh8o3qoWqxuCUWN822Z4Whtsbc3IKIDWoB6WNmksdXhDuDOAV8VYnLJuC4qrvPiRmmyPndJxV3jWNlDQ/b9l89dq2N0iJga0vBWpCJ4gRkuwdlBwbc/1I6hmcBs90PFDCM8mm9M/5l8o7DOCFUom09xh+g3rrnlydCMIFGLiujMtW9ma2AAHJiF41MYsYb8urWaY6XGdpParI1SsGietBcVtPp7XysB2iokx0Alb1Z1vzAGhRnWaRU8/jM7yc07rPjsu87K5eEIxRwNbH1q1A7ZUjljfqOf2fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5+G+/uHPkHmK/hHHiAyX5CJANzlEjCbxhECJadPo4fc=;
 b=I6U9HEeHfhhN3b7VdBgZc/tHWjHQW5n4MF0HHnTIirURIJ98/GvAlpZP2jrvRoNLmfkdVxdT1QdTeKbeMeyEU+EEyn04DC1MD7z57TJgI92BUMPbk0C9xNx0Si3oa1J6FZKVNS0w1SDhk7TGrLMfN+ALzN7ufw0aOg2wFjLKhdyFK3VBSJNvME+4ec8/yPFN5CTfasrB9lvl8rArYtcl7CSHYPMaHa3ISPzQ+OJpbhTUN6frCT9zrP7jXia8M+lA8MOJglEyLbVWOvzHybkbW1zer1143FKLxEkHrGOKFSvy0oeJ7hqo5FVRkKMM6xKvWMbdS0eec848tJp2mOipLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5+G+/uHPkHmK/hHHiAyX5CJANzlEjCbxhECJadPo4fc=;
 b=mnm+wX/45iLSQvvpBaYPke938GQjLxXuDjqKfX+CVXQGz6WdBFdFh/FmhoQec6hgR2L7OOAKIJWjnkefyInNvkVd45J14thJsTlWU1dEcad43V61Eaivai8/k2lRhOLgVw+Uy5YUFC9sgIeWwrdlS6aS1TfDkQBa9l6K5TOhcx8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LO4P265MB6700.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2f2::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 17:28:53 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 17:28:53 +0000
From: Gary Guo <gary@garyguo.net>
Subject: [PATCH v3 0/2] gpu: nova: fix incorrect GSP barrier usage
Date: Wed, 19 Aug 2026 18:28:42 +0100
Message-Id: <20260819-rust-barrier-v3-0-d5b7bd7e6624@garyguo.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMrnhWoC/2WOzW7CMBCEXwX53E3XPxjoifdAHByzJG7BqdZOl
 CjKuxPDgQPHGc18M7NIxIGS+NnMgmkIKXRxFfprI3zrYkMQLqsWCpVFiwfgPmWoHa8tBqtxtye
 3s0pasVb+ma5hfOJO55dOff1LPhdGSdQuEdTsom+LdQuxHyHSmL/vLmXikmlDyh1Pz0+DLKzXv
 EElt8oYXUncHqw2oKBxPB3/iCPdqo4bUVYH9e58XB4UIGi8em/2JP0FjwXR9F0VKYvzsiwPAQ0
 KiBQBAAA=
X-Change-ID: 20260609-rust-barrier-63078ea76216
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Gary Guo <gary@garyguo.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787160532; l=1661;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=Juuer1fTYfgUKgJoHMZXtV1L6XGJIq7Z8TXvh8nrpy8=;
 b=8ZhzCU/FEZR/XFn9tzKlz3ta+Iloep5++MS+heENxaWBT/lZyo+rkxveKI/qv3VNLUWnd/Wf/
 3ElXCXpyWwcB7ahFuaGDbaY8cBDRMZ05Xg2q6CpCsoPD5aRNqdFdrkv
X-Developer-Key: i=gary@garyguo.net; a=ed25519;
 pk=vB3uIX95SM4eVrIqo1DWNWKDKD2xzB+yLLLr0yOPYMo=
X-ClientProxiedBy: LO4P123CA0414.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::23) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LO4P265MB6700:EE_
X-MS-Office365-Filtering-Correlation-Id: 32bae29e-d390-4670-0265-08defe1756f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|23010399003|376014|366016|18002099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: 4+pWlTyN3aEMi07XZFovCJTjoYYC9dLiYNyu9h9HwF+aV9+LVuRxqdFjeAWGwT0GZeO96QYb+DwBd7h1KxGHX820izXUm7Gbl1VbeXxTVTtGghOxfr00efGXK3tt4VpbvMZoUbJWQiYOe7JwJCnkYA4c3ZPSnRMJ5wABiWSVXtPU+XmTlCP5yDNu1bzOjOJF+b5P7KD3XToBjtqznQvc+VKaQrzJ6Y2CiKYYh79yubNcTm2Nu2GTLUmeDfXUjw3K2XqHk96JiT0Ofuxm73VX8gRSbat7EEZuG6dqAsrZqRYugFBYroRUhiu7GPpwJIqeYtEcLIOyiZGtyNegURoNZio608CsZAPtQcRNzz6NXQdI4NkQu83Uoc3EObTbsEMFJEBnJnQSEdqT02EJYuk5A2szIXsL/iS2hWkYUR6/oXNlpqS3L31GR5k4HbZbTwkdLvzpls0+pneiH0x5oIgD2a4yVjds8QQtXGHdHFGE9zHAoF0nNbqjLeOgtN+9kjfYOI/fyP+3yfDvV4MHaXSV9KQ7poRv6UKU0kD9XGUJXuaspU1pP4VNIjyJfV3jnRjox6XDWwq62aEsWi25Hwql+fl8gVhNXysKzCdD++4RQus=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(23010399003)(376014)(366016)(18002099003)(10067099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RS9YRWx0eEZXdk56SnNlM0VuQUlrTHJkNWdhK05CNDJickV6YUtheXdqdHlQ?=
 =?utf-8?B?QWlONFhSZXRwNnk3VVJpN3oralY0c1JDNU0xOTJqeldaVVQxOXMwTVdoMzRl?=
 =?utf-8?B?OFljenR6dm9EZnp3UDhCYlFKeERmd09pWmdJbEI2YUl1VnhNcXMxbDFEV3lZ?=
 =?utf-8?B?MXpGaHFnMzN6WUhxUSsrdXFaWnI4bTlrSlZ1Zy9RVnBzZmI1RGsvVHNsTFJr?=
 =?utf-8?B?a29JK2JrWERZVG5WSDVRZHArMFB1Wmt5T1g2bkRkWWt3VzA2dlNsU0x5VkRk?=
 =?utf-8?B?WHhJT1drdURHa3RDVG9URXJOZG1ULzFmdlVDN24vbE1JbkNVSGhSdVNwTDA4?=
 =?utf-8?B?WTh4Tmg0bFpza0RQT1FyMG1XVitUN1dKRVRCZXJnMVRWL0RUUEcwNlhIUkc4?=
 =?utf-8?B?eitNeGdTNkcvY2hvNXdyOTdFUG81SUFxWlN2OUJwdEg1RlIyR29yenJvS2FN?=
 =?utf-8?B?MS9hVkt5Q0RrWUtvMDNtZXNOOFV6ejh2c3pFVURyYy82bWt2WlpaR05oUlJS?=
 =?utf-8?B?dW43eEphOHpGcE1zNGZOU1lSaWo5bWoybGluTmZmMEF4U0RLdG4rQVNrSStw?=
 =?utf-8?B?Z3pUb3J3eEI0V1ZKNlBGSC9RL3RJYUR3YkVWbHBKcTBieFM4ZVVneUcySjJz?=
 =?utf-8?B?OFZ6ak5HUzVLUXFiamdPOTExSlBQSjM3ZmRYWTllbUMvbEFnS1JpWUduaWxm?=
 =?utf-8?B?Mk9hSnlUeStSaGRJelcwTVN0cUhNR3pYVm15NUp2M05sV25SOWJWQWczZENW?=
 =?utf-8?B?NHVOcFkyVFkrakJaS1dnV1Z1NHcwYUFqeS9BcnVCN1hvT2VHMmQ0cGRGcm50?=
 =?utf-8?B?MDM1OWgrQnl4Si9LSkVlQzJiM2NyWlF3WTRhdGVyM0diWndDQjVLT1hNWGRa?=
 =?utf-8?B?NjQ1WXB6bkpCTm40aXdrMThJVDBiSjdGMHM4VFc4MEVseW05WEkvQTRpRXlX?=
 =?utf-8?B?N3BFdUNOL3grano5U2ZvakQrYm9jcWJlTEI2Nlo5UDBLTEpySmpPUlpYdTRJ?=
 =?utf-8?B?Qmx2Q21iMlBuMFc0dWFJZVhSR01kSlp0MVEvYVVrbWNSL1gwOHlMb2czWm05?=
 =?utf-8?B?VDlkdzN4UzJlVWFMZk9aQzc1RjVUb2Qzc1Z3QjBYTHAyZC9iemJocDJKeUll?=
 =?utf-8?B?b3N5ckpVQzBqaUFFMDJmRlVVKzhXZld0cGJ0TXpFbys1S1lNRDFKN1NvTkc0?=
 =?utf-8?B?NU5OaW45SGI3eUliWDM1MmljZjRJb2hReXJnVW9SY1F2UmQ3L2dZM3RIZk1L?=
 =?utf-8?B?TEFXU0dPcXFqQlFvQVZmQlRDTTVZSi9yQjhsRWozV3B1N0JScHhvQ001anl2?=
 =?utf-8?B?WG5rQWpzZGdLWmw4TDBRSnZhRHMvMlpBVU9vRGRLdWxkS1hDVW9mbnVsVTk4?=
 =?utf-8?B?aGVZeUxjZk1PUjNQV092bUJJWkNHdUw5bm4wVHhIbEFFOHQ4dDErdEJWOXBK?=
 =?utf-8?B?WWFBcGcxOFF5Q1MvRDY2UHZPT3Fpb293anhKbWh5REhGSW41dmNCdVdHSG54?=
 =?utf-8?B?djVjUXJ3WURSZjhEQmppcmo1alYrMDB1elprbFFBN2lKN0xTb29tMEFzSytO?=
 =?utf-8?B?NnBaWm1HeUc5MkwvMEQySHJ1ZHJLNUlwb3hHOFMxR2FTMDhKM1M1TEVEMml1?=
 =?utf-8?B?TzN0S1V5MEdNaDRQSjVKSThld0svRllaMkUyOXcxdWY0Y0VtbGVnYnJkenN3?=
 =?utf-8?B?UEFBa3VLOHNSY1hWL1pqVHRSM1pHU3ZSaE9iMFZzRk5Yb25acHUwTE1HejhV?=
 =?utf-8?B?N3J0ZS9VanZaZVVSOWF6Y2NVM2ZncE11Um5wbERsTWNmcU5rREVuTG5VK1oz?=
 =?utf-8?B?TDVndlpZNSt5U092eklPZEl3VU5hSHhGTm1sblZENXBhamRheldGSjNOVGJU?=
 =?utf-8?B?aXJDWEZDK3pxNGcwQ3BzTllidjRCaXJtN2VhSXRZU0hoOXg5YWlIOURuS3Z1?=
 =?utf-8?B?WDJDYkdXQ0FJdnVqZG9DRXdYNS9mNFlCbC8xdXlWSVJJMVZQckl0TXkva3Js?=
 =?utf-8?B?ZWllR3J5Y1czMzZwUXFUbmZXOVVYTzYrRnlIWDJxaFdaSXFRM2tNSUNNd25r?=
 =?utf-8?B?WklYNHo4dVpPeUdDZFRPa0U3OFpYOGlSUVJhajJOYjlRR0Rid3B5eDY5aUtH?=
 =?utf-8?B?aVlGOXBKRWNNaGlyY2hXb3BLT2NCRXRZblJBTTFaU1M4RTM2OTdpQlFXNGFU?=
 =?utf-8?B?eDVtZFFld043TUZEMGdyeFZZcCt4TGdzeDVycElUZnZNZHJDSW5aWnc5YUh2?=
 =?utf-8?B?ZlZDM3dhZXNnRmx6NnNrb3pRbjFCRzVmVW5LZ2pOb015b2dzOTAzLytIWkJM?=
 =?utf-8?B?QWJvellnUmQ5Y1kyS05md2FKMmI1Tm1PNnFsRjdzTTQ0ZVZuamt2Zz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 32bae29e-d390-4670-0265-08defe1756f3
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 17:28:53.0572 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BO+gcOdnP13MjX8VgvMa1K90NcUj1XXKL7Ns7rAStaj8KLDjG8EG2CNhiLN5iB/gNudhMETHPGjZxauET7EtPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB6700
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

Currently Nova GSP code uses Rust barriers, which equivalent to LKMM SMP
barriers. This does not provide sufficient ordering for DMA operations on
AArch64. Fix this to be using the newly introduced `dma_mb(Ordering)` API.

Also, there is an incorrect placement of barrier, which is also fixed.

This should wait until v7.3-rc1 backmerge to drm-rust-next occurs.

---
Changes in v3:
- Drop abstraction changes which are already picked.
- Improve ordering comment messages.
- Replace control dependency reliance with explicit barrier.
- Link to v2: https://patch.msgid.link/20260609-rust-barrier-v2-0-30fcc48e1cd0@garyguo.net

Changes in v2:
- Dropped `Acquire` and `Release` aliases of `Full` (Joel)
- Use macros to implement most `MemoryBarrier`
- Split Nova change to GSP->CPU commit and CPU->GSP commit (Joel)
- Link to v1: https://patch.msgid.link/20260402152443.1059634-2-gary@kernel.org

To: Danilo Krummrich <dakr@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
To: Alexandre Courbot <acourbot@nvidia.com>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
Cc: nova-gpu@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org

---
Gary Guo (2):
      gpu: nova-core: fix barrier usage in CPU->GSP messaging path
      gpu: nova-core: fix barrier usage in GSP->CPU messaging path

 drivers/gpu/nova-core/gsp/cmdq.rs | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)
---
base-commit: e6664f2b33db9b6811eb4cec109f06cb2b4f458d
change-id: 20260609-rust-barrier-63078ea76216

Best regards,
--  
Gary Guo <gary@garyguo.net>

