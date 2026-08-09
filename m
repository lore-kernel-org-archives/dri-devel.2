Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0013DC5AD2C
	for <dri-devel@archiver.kernel.org>; Sun,  9 Aug 2026 02:12:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D312110E03E;
	Sun,  9 Aug 2026 02:12:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="DptccLmk";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010004.outbound.protection.outlook.com [52.101.201.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E5CB10E03E
 for <dri-devel@lists.freedesktop.org>; Sun,  9 Aug 2026 02:12:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iWPmXjBPvLkvIVUSavojhrZsLGrBMIGkrwb55dYXdojdyv8LZ5iMk64CsE/1NDtB1TYTxlhSaI85yU+GDv87/URedvfzEJRZHYulsirg/8bohYWcw/2jN/MA65Ul/1t+0M3DvfA7JFKifL5Kbdj8CZm0rF7dVrHo4OJxF9XVNhO6LCvODYTYp3TTcKP0Wx23gGqNSUrp7higsBxdvG6mCX/tyXG4cmNVDumU2S6+zL0LhEfgmoRyz3xK7cSOm6ossHIcEVCgJN6z1sC7KIqZrpNTuDlKyEXif0PhuVqzSZxOuRLPslthqeW/qVqyBJTzyE3d4KBJcssyMhVNijTS0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fPCdzmeq/MgXyYntPi4m/sguf961AXSTocar9DXw6aA=;
 b=pdRbKQDCo6HsDoJj8nxOlU/CbdtL0JTrfKfFTZh9gbwk56UvcujZHafP22MXNhpQcXYMibS43z+mc+tdwMbYKK+faEJozN/tzw1zhMCSszsQgrgjH1eP1617D4GG++Dl4DO2MF1krqgARzBCihIcVV4/mLvd8WfDmHA3ZuYp3QWKwOGmvfh2V65VJ+O/p7561NfI8VIVbL02JXphzVSJcsBI8/CIdTWIzSxZnCwyetC7Air+Wmw+jQtWZuuI8mkAG8Qj5v7N0xSUSeBzC9mLY3gaFHmNByuBv1d9yODoFbSOZofftuv4fprHyMmU4URsx+LAx0T31kkxDI+XkCC+Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fPCdzmeq/MgXyYntPi4m/sguf961AXSTocar9DXw6aA=;
 b=DptccLmkTfAwruQTarKMBZfJmp1C0xYNAYnEzTsd0SS34fEF6D+QXoT/EidxoYcOlPmg+B/yzaVbOCLpPSxE9cKUlHKO/R/t38NPugvGW2cfGOp+5OOQ7OTpx/9VU/1SNIA7E9Wt4nbtc045ApRR8HdJ3+khPZ7eno+ogy66aedQdIDOuSh7HGxb69oCojMILSeI76tB902vFgcvxQqldDaIfOrYKRFvfPZ7Ev/rwERgAYZ4oQpHYQgor8GDjfmgN7L1AfDFl/fAxsExDQnJGb4wIJketBTpuep99IldBwj1qttZaOx1y591IclaUWC7mqoljfg0DL76jCq3AB5Mzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH7PR12MB6762.namprd12.prod.outlook.com (2603:10b6:510:1ac::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.24; Sun, 9 Aug
 2026 02:12:17 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0292.018; Sun, 9 Aug 2026
 02:12:17 +0000
Content-Type: text/plain; charset=UTF-8
Date: Sun, 09 Aug 2026 11:12:13 +0900
Message-Id: <DKK1S09OWP6A.361WY739QCTUE@nvidia.com>
Cc: "Eliot Courtney" <ecourtney@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun
 Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "Yury Norov"
 <yury.norov@gmail.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
 "Maxime Ripard" <mripard@kernel.org>, "Thomas Zimmermann"
 <tzimmermann@suse.de>, "Jonathan Corbet" <corbet@lwn.net>, "Shuah Khan"
 <skhan@linuxfoundation.org>, <driver-core@lists.linux.dev>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-doc@vger.kernel.org>
Subject: Re: [PATCH 02/12] rust: num: reject Bounded::shr overshifts at
 build time
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>
Content-Transfer-Encoding: quoted-printable
References: <20260805-pramin-split-v1-0-ff3e84a75dac@nvidia.com>
 <20260805-pramin-split-v1-2-ff3e84a75dac@nvidia.com>
 <DKIRNHGHK4O6.2IRJZGM6W79B@nvidia.com>
 <CANiq72kYqPySwS8ci84CEsvjJqCTBjrveSx14xxnNWJZWRFAuw@mail.gmail.com>
In-Reply-To: <CANiq72kYqPySwS8ci84CEsvjJqCTBjrveSx14xxnNWJZWRFAuw@mail.gmail.com>
X-ClientProxiedBy: TY6P286CA0007.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3b8::6) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH7PR12MB6762:EE_
X-MS-Office365-Filtering-Correlation-Id: aeaa697a-c938-4ce6-6fd5-08def5bba2be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|1800799024|366016|10070799003|10067099003|4143699003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: VkW6N1asg57nKenNFeZexu9LbRp6tD1pjB8vNLa0m5Vv/Fr04vDOwEsrNMHLMDvJxyVZrMxhLJ0438tjVeBx32d8mptgNJeYUQi9ZpFDgl7qmI2FD04Q6ZtltG0asFIRqluC/4zwoYD690IyICuHWtSIMKqekiPCF1lH0CUZkX6CfP18i1edy7l3AbnC7aRAE1PMGOjeb/9ilJZitJa/mSWgf0P0pY4JollTMqIbstsaWpzDoILFkuQOCCJbn3FfIDsbnx6yejiBsPBXUgi3sN6jHrUbly0L+z3QM3afBXDauE8/tZwdDkTJfUeUxsYMvs/0ID3GC8eerhGnBmxmqthxFFbmrVdF75rNGSMgNiF73r11ulA03SWs8wV7YfTo8HUDeLJyqHrO3C8+MK4SFmqPu+O62GkU5uOxhSPPUit+rVRFhUXIvv0+W5lBNviIrVbAme5Ir5H6Bb5rOoiR57/59ybLG2B4PMAYx9ebV6uwMtaUDoLtWPEgy/IVtGJP4Fnz7VLxofwxO8hLxaJ+3FCR5Be+GzfoVq2brxthrta/R2bGqT8HOlWSFsgmjlc/cRrRemRMbTyJCctuMUD9BwjhvqdKQCDIM4BWbB4uvnGvnI7/WsbKegoYzwMB6Zq70b/oCsUGLDa/l4EUSm+1ZjReExBZpcW3dPx59tsB8kU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(10070799003)(10067099003)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zm9zMTBZRGNaSnFPREVUK0k3d3k2RXYrcFNVc1pZSXFkTEtJTnIxVjRNeEFy?=
 =?utf-8?B?NGU2K0xHWjZZQ2w5bURjWHUwaTRjYVphRjhsVk9zMGZSeEYySnlYSHNxWEdp?=
 =?utf-8?B?cXlTcWNZWk9jWklrUlp2SVhkRHFFVG9PaFNyMkhwTng5NlJHVXFOU3RLNkR1?=
 =?utf-8?B?U093M2djemU3cmNGTWZYRDVpZTJ3d2hnVmI3ZUREMUlZditzN2FPL2c1dHBo?=
 =?utf-8?B?cUU0WTdVZVVhQXRvdWhrRlI0eG8zZk9LVTBOVzNoVTFXZlQ5empiU3Uxci9q?=
 =?utf-8?B?ZjJ3T0R0QzFaR3U4ZU9hWFNKYlM3YXhVeUtJWTZaR0xSaTRoZGtRYzN3UWNP?=
 =?utf-8?B?RmQwV1ZyeUQxY3FXK2wwVXV6czlnSHdGTGxKc0krQ1V2QVZ4Nnd4K01DSUl6?=
 =?utf-8?B?dHNMczE0VXE3c0EwTWFzbWwrWm5xTXFidkJ1cWUyL0t2dkZuS3FnY1pHK1Vx?=
 =?utf-8?B?bytoQS91T0JxdDlKODE3RkdUQ200czdmYzVRRDRGOWQzNnpJeElwM2VOYXdT?=
 =?utf-8?B?WDd6NnhKc0ZONVF0SklsS1haK1hVYmN2WU9hV05rek5pMUZPV255akpjYm81?=
 =?utf-8?B?UzBjUm5wOGFycWxnVzlEYWo1Q1JaU0M2TEpjMjh6QUJVRHY2dzRzTUhBOUNF?=
 =?utf-8?B?bXhxbEUzcGY1OFV0MzlPMnJyZnVtczdSS29lbFgwbndMYWpPMEEwUTFXemts?=
 =?utf-8?B?RTJldEpvWlB1R0JUSys1dUlHb1ZIL2UvWUZydVZBbkoyblY3NEswL2NyeHZ5?=
 =?utf-8?B?TW5uWTkvais3QmlBL3BXUUlXOWh6eEdkc0pjZTV5M2NyVHN4Q2pqRXlyTkZC?=
 =?utf-8?B?bU5IL0pmSWlrNXoyZ2dqUXB6bE52a2xBMVhoOWxVTFRvOXFiSVVjdnRkOTJQ?=
 =?utf-8?B?cDdya0RQbndjTFVRMEpCelo2azRMR1o2ckVsd0ptYlJDUU95RzM5WGgxc2FZ?=
 =?utf-8?B?L0tobStvWjM5OVhYR3BkS0ZYVXFzdW5uZ2h1L1M0c244amF3aGVqMVphaU1y?=
 =?utf-8?B?cHRtZXdvU2k2NVE0NVFNaGVZVURYdktSSldmSEtPVjNzOFkrYXowZ05uZVVL?=
 =?utf-8?B?SkMzWEJ3UzlzVUpyd1NUeGNTandQdjVZV1lMYWg4MWt1UFd6QzdKY25IL3ps?=
 =?utf-8?B?YWRNeEoxTzBqeVBmdFpxTktIWWt1dGVkMUEwMkZOWmlia1JPdU1WcjhkTExo?=
 =?utf-8?B?MXdpTUNjemtGM2ZKNGsyM25oeXF6T0Z4OUVVMGl1bmFHdFJGVTVzd0Z3aU8z?=
 =?utf-8?B?c001L1NDMEtnYit5ZDR6VjFaM1RYZkJoTEFWNEFjdjN5VHZReTBuZTgyenlz?=
 =?utf-8?B?TlFoYTZmOEFqRUNyVndRZ3drbmlIOUliVE9SNlQvVVgvM0N6cG5Ya25yK0tG?=
 =?utf-8?B?aStnT1RHZHZENW1ObkZOM1dLcHBmQVFrd1FXcHlZNTkvRzF2YkwvQkJrZXE1?=
 =?utf-8?B?WEJTMlp2OE1rcHVaU0NYMVNqU1Zta21WcWtkN0JGN2xwRjhtRDVMVXBwNi8v?=
 =?utf-8?B?VnNHYjJBeHZZTUM0ajllQWZtVUNLdkhhREUxSHJMZTBOTHhZeHhhQ0NOZmhK?=
 =?utf-8?B?R2FEaHNGSFZvcHRuYWpqWGZiOWd2UEJJVkVLdGpvSXNkWWVzb0lrSXEwL2h3?=
 =?utf-8?B?S0xDeWNwYUtIeFEzbS9ON1JpRWFBZFRHSTlZRXFIelZJUU9xMjI5enFMblpk?=
 =?utf-8?B?UnpCbjBSMlNuUHphYktpUnVLNFZCTEhSU2Yrdk81aWVVRkd1RWVzTzhsMEZB?=
 =?utf-8?B?Si8xY1Zva0lWWmowaWlVdzZ1S2dCWHJ6Qno0dUFBYlZ0cmVsSzRqMXhQcE9G?=
 =?utf-8?B?SnpBNGdON2JFYjZESFo2d1Jwb3FiWmdlUTJ6eGFoekNOUFQ3YnovaHBkM1FS?=
 =?utf-8?B?WEJ0MzVyaFVpNng0bUJHVFNnL21hUTBDQUdINDFiS2pKTHZ5cW9IOHFwby9Q?=
 =?utf-8?B?eld2b1pkZitVRStpcHlKSndEbUo3LytJQlQxb21UZ0RmSjZETDM0QWU1K0xL?=
 =?utf-8?B?ZXdGQWhhV1FJL2gwZXk1VDFZWjNEOGkvbks1VEgwNmZVSDFJUEdCWFZEOVUx?=
 =?utf-8?B?cS82M01JY0VWU3BSVmlRRnhNMkt3enE1SXhpQnhuUDZHWk9ZY21NaVhqMDBU?=
 =?utf-8?B?Z3pkLzlOd3A4VGlwcTV1bXFZeWloVlVZM0l3bzV6ZjlETmFkWGJFemFSMXFP?=
 =?utf-8?B?UzZpK25Hd1psc3MvYkp4MWxmcnNLVklPYTZKMUNTbUw2TmZobEtSYy9JZ2x1?=
 =?utf-8?B?Wm4yUVFHWGxpRjlva296M1BKMUhjZUo0VGVCTkd3YUJUbk1sdXhCQ1ZTS1N6?=
 =?utf-8?B?NFV1cVF5STZPNmxmV2NKOFRpYWdzOWpOVzRiSGdqV1dmelBnanBtYys3ZGZE?=
 =?utf-8?Q?qIlDvse7aQ0EEh1lqUqxY/luFWLPHYjFwuGohHn4XAWCO?=
X-MS-Exchange-AntiSpam-MessageData-1: JKqkI3ZrOHXg4Q==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aeaa697a-c938-4ce6-6fd5-08def5bba2be
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2026 02:12:17.2580 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QQCudIGLfbzMyZ/5iEg8XZQsBqJYiNWH0CEg3gX8hTy7nHjEJTj4b/GCuzwxkUJF8++jkie8ATMQwb5eij7kYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6762
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

On Sat Aug 8, 2026 at 2:12 AM JST, Miguel Ojeda wrote:
> On Fri, Aug 7, 2026 at 4:03=E2=80=AFPM Alexandre Courbot <acourbot@nvidia=
.com> wrote:
>>
>> Indeed it looks like this would panic with the kernel build, and can be
>> easily caught at build-time since `SHIFT` is a constant.
>>
>> Acked-by: Alexandre Courbot <acourbot@nvidia.com>
>
> Do you want me to take it this cycle? And maybe the next one too?

If this works for you it would remove them off the plate. OTOH I don't
think we will have another user besides PRAMIN for the short term, so
next cycle together with the rest of the series would work as well, as
long as they are merged into the same tree.

Thanks!
Alex.
