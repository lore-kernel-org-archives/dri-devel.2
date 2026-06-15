Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 894B7CD98DA
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 17:24:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E083610E4BC;
	Mon, 15 Jun 2026 17:24:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="OaO7aFkT";
	dkim-atps=neutral
Received: from LO2P265CU024.outbound.protection.outlook.com
 (mail-uksouthazon11021098.outbound.protection.outlook.com [52.101.95.98])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D1C910E4BC
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 17:24:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jFNTRfCHsnJ8dsdoUI8IGsb4m05gAnc38kiDgDEpefZO7muoNdnLY1yAOh1wWRHB0t3gNsuKY25jwbVAcVhsfwqqaEbsSULBxj2qKFtW6gLuLAWKdyYqVbf1H4wmZIKUdyOnracBSoyYjeBZ56QRlbmrEorB26S+z3o+swz63QxkPQwClexawbz4Yylh6sSfT9wPY9sdLxVVzBAEOGvYEA3fNgibJ5mrK/VzyZrIKy1b3Ae4v9jzTpfhVaXqvwhtabEX1naQYbBmCy7tX46LLWN5RoboR/oFm7dB+2soxS+DKsifEHqt8bWAMKn5YaZ/gqAEmDo2aDrLxlY1oL6Rrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h/fbH3oTh4s5DUJn0KdUp5O8d01WkPoPM76oOz3dxEM=;
 b=tWdxMbdCFSesbiaQR1HrGIs547JuKmffanhabv+1CfMSvX5sQh68uMoh8mKUmrIXTCAp5sm4uCyTb2qg988knQ7NCau4oIKRwL16ujKOeegop11AuO3C6X4IvLkxxULW5fS/dVlJ0AEuACGdgHeG+IasvFWzEM4cIRGhQaeR5Ps6k9mDBNSlCejfQafLZhPgopKEc+rDCfuBpHiHeDpz7Lti3gLRtx6foDHBT5pPACZHaAu4mUArkMzHXyVo3rYhrikftjjhmRiB7erpqlkheKaK6Y+/UbIdZRcfPk7zHmpeBs+4KTYZ2XKvVKeJPtQYjcBoRfJHbhlSHHn42TGMWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h/fbH3oTh4s5DUJn0KdUp5O8d01WkPoPM76oOz3dxEM=;
 b=OaO7aFkT39vbBJktgy07Hpz86JizgSg5/q4K4pIpxDMucPHYEpXP7zG45JBZB/4sZKWaDz/DusirztDPcdCRVjKBkKYOdwSAwgBuSGd3Ulkd6nD5ht6M7Wzh7pLANZfPNVieO6vZ4UDD3o55w/leZvNW1SkRgxfJSWBvbJEYbss=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO0P265MB3385.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:168::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 17:24:19 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 17:24:19 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 15 Jun 2026 18:24:18 +0100
Message-Id: <DJ9SQDVZDCBW.1KCX09EOWZ3CL@garyguo.net>
From: "Gary Guo" <gary@garyguo.net>
To: "Eliot Courtney" <ecourtney@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Benno Lossin" <lossin@kernel.org>, "Gary Guo"
 <gary@garyguo.net>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH 06/13] gpu: nova-core: fsp: move FMC firmware loading
 into wait_secure_boot
X-Mailer: aerc 0.21.0
References: <20260615-blackwell-fixes-v1-0-f2853e49ff7d@nvidia.com>
 <20260615-blackwell-fixes-v1-6-f2853e49ff7d@nvidia.com>
In-Reply-To: <20260615-blackwell-fixes-v1-6-f2853e49ff7d@nvidia.com>
X-ClientProxiedBy: LO4P265CA0297.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:38f::6) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO0P265MB3385:EE_
X-MS-Office365-Filtering-Correlation-Id: c27c9d3e-2b78-4669-41d6-08decb02eed9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|23010399003|10070799003|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: qe+kpipPCGKhx4+KcBnEoy8bPDMF5z924jz+Ei8uFa3ZT350JkbpFpmq5o18c8LuN90rgyGCGYylvQ0D1goXt+3sM5CajGaeM5UrxfuZRkcJgdt6EHsfPiT2o5Rl4495ZVUb5qmQkRMASahqgFhmU7s7Y/Hq0jnmGDQi8RdludHCZJ8yke8Vp77G0RzjQJZJbkufIOimqO+yHUL86N7pzkcwRpCvAkVZA3JfIiR/d5CU7DYGpZrCRMcqaq3LyLapQxLvYGOTLfB3TTqONBDj+Qs66meqvwA8yAxNfOwS61kjmIkNlJVDE5M49Yh4mRMmYto8ojtPiWUTkIsS7cV+zk8k0zzU3Gkr6o8V379mWx+XyAvLePUn55z3NJBPULNjZz5fudXUg5ltopE4dFAIWVEvd22q2/OYXEqhgvOQKXRv52PRqG3Ui5Y98GohSNKiM6XIgLAKvMaJwVZwEaSuaXJCXrhzp5U+tSxv1Nnc3COUorLRbaEB7SLkxaDVvkWgU6x1GSzgf37Ncx9fR6w1ypaHbirsPV7W5VskQBOdQh8UUcXlm6kW7OBA5uhFAZ4CBBit2iZ9mTW9CwZkt16rnQQqwToUu76SsXgDjI9PkFo6wCNbLj+pKG0TudmXLfCTKN4ulpY0hDObSLuOfylmEYvgyGEBFoSfqmFFFPlu53DG1LDveKRw+CrdUBuXO7ZS
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(10070799003)(56012099006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzVCWjV3TFJKKzRhZk1PTmlQODhLSXk4MEZHVmVCaDN5c1U5dVR3bEc3VjBU?=
 =?utf-8?B?ZmIwd0lsZHA1NlAxaXRmNXRtdGZNc0FyL3FKWU00RFJ0bXFwclRMeElQbE1q?=
 =?utf-8?B?Q3F3U2lMWExpR05rWGQ5cnd3Y0hjczJxSHhEcVJlQkllWlJYL1FXakFBM3Z3?=
 =?utf-8?B?ckpGZ0FzYTRZVWtPay9YWTkvcmZnK0UzUENFc0owc29CMDJqdkNkeFhJeGVJ?=
 =?utf-8?B?dGhLdFlnOHBnSVp2Q2x2SE8xYWIwZDZyUFkyeHpmNTl5bnV2T3MwT2tRNFFz?=
 =?utf-8?B?OHlHTW5LcDdCSlpvWVdZRWhYZGNGajA5a0FmOC84ODJFcThxaVRqbmJYclRq?=
 =?utf-8?B?bmw4YWxpZ25uMTI5aHJ0cjZlN1dnODlTUzNlY3JyUkN4amI4RWZBT3htU1VF?=
 =?utf-8?B?ZXpiNGRUdHYzd0pNc2ZBa2MydGRiM1MyZ3d1bTFGdlpRQXFoYkprTzY3NlVk?=
 =?utf-8?B?R0lEUURheWxyRms2UFNpeCtxMkp3b21vN0crcnYra2hMWS9VN0hDdEZueXow?=
 =?utf-8?B?RFcySElVYmE4K2lOcnJDaVJpbUtMSzVPUlBHYktqWVovYzkrTVV1WWZXWVQy?=
 =?utf-8?B?WGhXd1ZTYTFWWlNxVmQ4TlVremdQR2JjV3NQOWxTbmgvL1A2RmFCK1A1VFI0?=
 =?utf-8?B?TkFGNnRvdU9naGc2aHZrRmxCMDdiYWNXV2tqUXJmYlo1dkxyMno3cGlXd2N5?=
 =?utf-8?B?NTdXbmRBNTM1N2FIT0l5RnJXazhLV25lWUhGR1gwblp6SkNVUVNsZi9TdjJC?=
 =?utf-8?B?Wkp5VHFraUtmRDlsQmRLVFg4c21tUmFtd3doMkpNbG9BSm9UZVlBelNkSFNp?=
 =?utf-8?B?RTNLUWhLTTh1TXYzQmkzL3RBeWszaC8vRytBSThGdmtOWlNHSU9oL09zQXdZ?=
 =?utf-8?B?WmdaOVF5Sy9FcjVFdWd1NDhKMjF5aGRxbFExanBkcVY2azNvV1N3VGZPdUVq?=
 =?utf-8?B?M1FGTFlkeDZmVmhBdUdyQWJ4MldTZndlSVUrSCtKNG1QdnlQTENvNk55RVBy?=
 =?utf-8?B?WXpjQi9DeThjcEtoMzBPbitRd0pNUUVlaVRwRThBTXhudnJGMmxpaG5PeWxj?=
 =?utf-8?B?bWdwQVhTUUFsb2E4L0NSbHhiYmMzZUtPUXlLOHdRWmJlVVBrYmRjK1VkcDVw?=
 =?utf-8?B?ZU1mRUtHRFpBM0EvNUFtTnlrSUtkaXY4MERuSUhaNW9LM1NXa1JRV08xMnh3?=
 =?utf-8?B?V0VQMzJGNUQ0dTltKzlWUDBibUJ5WTRRcElUN3VwVEU2MzR6SXdrOU1HRVpk?=
 =?utf-8?B?emloMDJ0YStuUzc3OXVWK2dzdFQrM0IrcFB2N2dveXgwZkV3bFpnaHNaaTdL?=
 =?utf-8?B?aTIwQnRYM3VmUmxUQU4xKzgzZ241Skk3aHVoU2FqdDRJVE5HUHJvRFlwUVlQ?=
 =?utf-8?B?M3FNN0krQnhGcGtLZitRSjkzZFRGV2F1WG9XU2JhMUVNY29Kc0NZYnJ3aGd4?=
 =?utf-8?B?ZFZ3WW0wNTFlMHFrckgwSTFLV0U4eVJrL1VSRlZFSXNLTDI4OUx6NTRxU3du?=
 =?utf-8?B?bzZ0cFhDMnVzSk04YjFoTTNkb2RYZnRiWHdDSmw1V3RnYmtsWWFuRkQ4aitL?=
 =?utf-8?B?NldwbzN6c1NaejhHV05UeFREWHJPOGhUVVduU0xYbWQzWkU0Vjc4WEFPaDll?=
 =?utf-8?B?cS9OWDIvUGN4djEwVnZTU3haakYvM01vTHVNeUc2T2ZMWXVVU1JIVDlRYXFz?=
 =?utf-8?B?YWhPQVJaV0FGdi95VnFTS1ZMelRyaGJYLy9qR3JkZUtlY0dvMHd5QTlQZ0NG?=
 =?utf-8?B?UHJpc1I1bUV5U2o4MElRQktpbGkyL2N6TDFTUCt0amY5b1JraElwNUJkSnJQ?=
 =?utf-8?B?cDNMeldWbm1hMTJHL0xVcW1yUmlxQjFhRG5HRERpYWh0ZUtscG4xaURCeG1N?=
 =?utf-8?B?cmZZVjMvdTlHQTlOMy9mSXdUNEFuL1F4VTc3dHJnaFphT1dXRGl2aUZhVjUr?=
 =?utf-8?B?aVlNU21NNTJLdytmRnBHY1dvcmtTWW12aUI1Q2I4NFVPV25PNHlRYzh4ZC93?=
 =?utf-8?B?ckxWayswdk5yZm9vSzBqM3pqWE9Fa3JrdUYyZG5WNmRCY21YbXIyMTNpR3pi?=
 =?utf-8?B?RXMxL053by9pTEswM2lEbm5yUk4zd1NJUUwzU01yMXIyYTFCelBieGI5TEhV?=
 =?utf-8?B?bndBQis5UnRYYVBra0xtNHE4aGJrZFd5TzdyOXVmeVFQaktQdHNYZEhLcGFT?=
 =?utf-8?B?aHJJbzI2VENLSGJwTzJ2VlhOVzduRUhSWDRCRzM5VTVGa0U3dFdnY2xvWHVW?=
 =?utf-8?B?cTRVenl5VWRmbVRlR3pmdTYrdVNycVFyWmRlRnpBOFFaZ05TQ1N6SmtUYjVz?=
 =?utf-8?B?aTlIc3c0OE4xbjdyK0RwTW53K1FlN0hmSDZVelR6Q3hMTjNwR0I4dz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: c27c9d3e-2b78-4669-41d6-08decb02eed9
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 17:24:19.1511 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: anxFyHWDhXEJDaeH0iPZbOReNnsfNHUGWqfK3JiodQfMXEjsejoLWdgsytYvtv4rxW3gnUxtCOT/Zs5cuGoUsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB3385
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

On Mon Jun 15, 2026 at 3:40 PM BST, Eliot Courtney wrote:
> `FspFirmware` is constructed and immediately passed into `Fsp`. It makes
> sense for `Fsp` to ask to load its firmware, so move it there.
>=20
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  drivers/gpu/nova-core/fsp.rs           | 11 +++++++----
>  drivers/gpu/nova-core/gsp/hal/gh100.rs |  8 +-------
>  2 files changed, 8 insertions(+), 11 deletions(-)

