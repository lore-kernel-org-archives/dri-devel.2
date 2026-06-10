Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 230D6CD8CB9
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 03:37:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 780EE10E6CA;
	Wed, 10 Jun 2026 03:37:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="EPZCeEbT";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012033.outbound.protection.outlook.com [52.101.53.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AC2E10E6CA;
 Wed, 10 Jun 2026 03:37:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=moVN+zaOuJOtbupOWElFhHJ1T1A+lJXwhZVcp42LeVoaHFy51Ze5S0vKjpPMRIQVd+0xLJL1qxoBvJKtD/l03khLsIOVn0dvyF5MkEa/so+JVkCJHNifWbfAOfQHJmiG4Kluakl+Q7F0ufly9w0EuoPcNfQb55/YsP0nXGOz3cYi/2pIe/RvI67IXpwrDLO3yNIDhD2PYjMhwEEArEw/IsvLTAVnriZ0qkXCSEY18Uz0DsUMdhMZRd544SsQchp3OXQSUasXOuGuqRbUFQDvZTgZ8rgFfDIwptpYovosqeTA3redubEJms5a40lYkcTfxfuLZsvmeIO7nzdqcBUxgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MRkVAAPQxYhGoFjVJxobGwk67F9yEK5EwQRlvI4wylc=;
 b=U1H9CN0MNYtOOlwTAJq+F0SbqMCcBQpI1LotOadi+9moJlQ76R1vhefhE3cLUrRQnRsNTCn3j4gL7DijoX9sCTmdBHKjv3wm5mNbPSLEZSfSEj8VARxlEFQk8IbYjaRz+cvtVtYSS1A9T2Lpt5UGlZ1klUINxZcgJLtLzl3MggNLli3JWfQw7XtyuKch+grMshStn6pJGG/U6b/TpgxXMxIBidumQ0TGjH+62JReCGVX+dGuD/SnP5ecSY6as8jOE4Be7dteZLxNTzHxZ1ccufAKnXUnQbz7GE6AoXeGlbx56bHCRJ8O7eilqh1o6CK90NC8AJy+TG+0dkBZEHs0nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MRkVAAPQxYhGoFjVJxobGwk67F9yEK5EwQRlvI4wylc=;
 b=EPZCeEbTSlwf5k8f6xLVw5q/IJb5AK4NBYM3UDIIhGDku//5zgrOQsbTah+7jNyIIMMfHiAq4p+APXLxpv1V6BbIOqVwHL4ebv7oY7G8fBKW7bVsHjULcBXiDRmpnVSF/+CO/yvnc4mHK+cp+jdWjA9GLYsCb/c5ya4gLBRDpEQRkFu51h0Nqp/qMLfiafFRuwOnmFtOWfiyojgwNIhU1+Om3q3Cy6HSt7aWqiuDEUuLTTg59+Ryy3eHo8+AouE7fJB5HgpQIoyQlIDBDJB+z4enZqRnvTqfNTmx0i1/Z3f8eVd7JO/cQz1zdf6n79xIjL0C/u6qjwkLKPCdjS7bgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN1PR12MB2368.namprd12.prod.outlook.com (2603:10b6:802:32::23)
 by SA3PR12MB9226.namprd12.prod.outlook.com (2603:10b6:806:396::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.11; Wed, 10 Jun
 2026 03:37:37 +0000
Received: from SN1PR12MB2368.namprd12.prod.outlook.com
 ([fe80::281e:52ee:b18e:ad42]) by SN1PR12MB2368.namprd12.prod.outlook.com
 ([fe80::281e:52ee:b18e:ad42%7]) with mapi id 15.21.0113.011; Wed, 10 Jun 2026
 03:37:37 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 10 Jun 2026 12:37:31 +0900
Message-Id: <DJ520MQ8KUAW.3KS1POCHQ0X1Y@nvidia.com>
Cc: <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>, "Joel
 Fernandes" <joelagnelf@nvidia.com>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH 4/4] gpu: nova-core: gsp: Expose total physical VRAM end
 from FB region info
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Benno Lossin"
 <lossin@kernel.org>, "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260609-boot-vram-v1-0-d9382610507a@nvidia.com>
 <20260609-boot-vram-v1-4-d9382610507a@nvidia.com>
In-Reply-To: <20260609-boot-vram-v1-4-d9382610507a@nvidia.com>
X-ClientProxiedBy: TY4P301CA0061.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36a::17) To SN1PR12MB2368.namprd12.prod.outlook.com
 (2603:10b6:802:32::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PR12MB2368:EE_|SA3PR12MB9226:EE_
X-MS-Office365-Filtering-Correlation-Id: 95c17811-7b9f-485e-a4c1-08dec6a19c84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|10070799003|376014|7416014|22082099003|18002099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: VpEcnHmgXDw1AR4CJn8aCNiBTrs5M/HAmNSHAvx+6/uQbaxwNdD5Qk9x3S84tGoKXCyjWOnPk1D0ojm8LyrzTbV7hM1dlmv0XiPFNww2Qe3FdladIGY7cGvk4BnDPjQ+Yiv2bjdbAOV/NcL4bw/k+vAv0hevXFs9aIKKbi2ywO1zRZFoa/m3w/haAOPuG2iAEaOc7zL6qtw/IxM43V8/OJvVaTT/WA2IIWflU6bwbIGGIjSwNhecWD/15SMakQTN4xW1S7UaCaU3PtGeohvW//d/jIuFH8Xrh5yDHoH34bsvhne+S7Znl+DKeqpkcy7xxbiMK1BBI6/psUvpt9V70mFOzVqiqk0s8/fJu2GmukGJ+vA2LkJ7bzeQJUYwI5zDWuTntg5HIcUnMOaALtQ+R2Ugp2KCFm3FTDMZFHu2b0KyUoK5jnpqYKE5wsUWyjJDHHvpTFXub2bFU+rMckrx2EFh9HNH+1teRITmHNoLSZoFElqlDC6B0+sMDjd9odXroj3YdOiHR7YqzsoTSe9BY+/ub22vy8gnqqU863nLDAIigm5A7TrW0t5Nnh8xQLb8G7qlJdeDByAYsa3ANsM7Mlvrq56aOyHrLiEvr22dAzZnOI8p0tHY2h8nBcm4fQVy4HEXbn7Ch94t8Zt8VJofawRfnF4QbV66mCpq2RVp1m8k/QGroCAaN3cbY8RSMuB3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2368.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(10070799003)(376014)(7416014)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGluTng0NlhLMEl2NWRJaGRwMGZHeW82akZ5alUxKy9Fa3R0MGNuQUpGVnF0?=
 =?utf-8?B?UTdsL0UzRFFmRDh1Z2RhK21vTE41RFdBUGJjbktQZFlLSzlmeTlnb01URlVT?=
 =?utf-8?B?MEdqaXNoci84TVpnNmY0WnpxNzJXOHcxZ1RPNGNiRGNFOXpCWGdxM2ttM2x6?=
 =?utf-8?B?VjFVcjBkcmdQMlVwOUpWeG4zMnFqaURLTmhrNktWd2w5Q3RhMTFQdkJpdjZC?=
 =?utf-8?B?MkVzYkhuU1VMdXJMWmpZUjlSRkFDUnUwcTFRNFZWZ1pIazRJSkE5V1pKa2ZL?=
 =?utf-8?B?aisxSjZkMVJ1Nm1kNFo2VUQxUGlwd0d0K2N6TTVFUVd1WEE2SGd2NHNITVpU?=
 =?utf-8?B?SWtmMlNPc3JZUDR4WjBzSG5PbE42enkwUENJY0p3bWo3VWZwNzRZc2l4WjJj?=
 =?utf-8?B?RG4zSURWWEJWQkdvU2RRWjRMV0hCMGx1Yzc5TUxMUHFpam5FeFBIc0hmNnFE?=
 =?utf-8?B?bEl6Yjh6eHVJeE96N0lNT3VpdFMzM1JMRyt0VHJhT3F5TTdYeFJyTmtCNm1O?=
 =?utf-8?B?WmdXc2J5V0Y0STBQcDlXUVdvM0V1UTBnbW9JaWRDMG9rY3ZYUDhBc2JYakxG?=
 =?utf-8?B?ZzZKWENYRHNmWXhWa0ZwQTZBZUx6SUVhSmQxYkV3NTZEZEtrUkt5Q0NzUm9R?=
 =?utf-8?B?RHp1UHJtb0RDREdQWTdoeDlncUNvWU15Z2dpMitZNG5IUlplWml0STQ3cnp3?=
 =?utf-8?B?TTJEaDVNZE1tRlpESXN3bHA3MkVlRFZ2aGlGSEFqM1ZCdUhPd0Y5a1BWcWxQ?=
 =?utf-8?B?TFpMMThKT0ZBZjdYbjVFL3dRK0VWL3dSVktKTXhtc0g5UnFYT1piMmlVMlhL?=
 =?utf-8?B?RjIzeENQUnhFZkNrQkJEQXdlMUsyclNvaFJTMDRSRVc4akl3aHFaQmZTMjhx?=
 =?utf-8?B?bGtBbHdiUEVLMFBlWTVGbnNwOVhvblRiV0oxSXNhdXladitPNlFVZ0tqd3BP?=
 =?utf-8?B?Y3ZxeGtaeFhHWGpQcGlBSC83eitzOG1NcUFIcXloeWV0aGx2QytwNUh3SnpQ?=
 =?utf-8?B?dVpZTnI1MFMzc2lRSWJqbHpqNHBJdldwSW04WUhGR3Z1VEZ4V2Z0R0JoQnV0?=
 =?utf-8?B?Z3VGUEhCRDVXUEFVd2t4VHYyRnB2SjByTUhVTTNGcFhOdFFEcHQyT1gvYXkr?=
 =?utf-8?B?ZU1sZ3VTMGc4d2x0MW5Tb0Iwc3NWbW5PZDIydE9vQTR4Z3hKQ2oyemUyWUJW?=
 =?utf-8?B?RnAxZFZhR2pCdHlSSzlveEtiN2ViV1NsdmZadHNHUHcwS3pJRmphTE44a3hX?=
 =?utf-8?B?R3ZkZVZlKzlmQjM4U0tTQ3VnOUl1R1FqNmhqZWV6UU4xSnJ6czcxanNSeHBZ?=
 =?utf-8?B?dEFRclJuMEJXV2RlblRIUURvTGFhT2Z3OEN6SDRZUE4wakYybXVkTlovV0NC?=
 =?utf-8?B?aFRqbmttQW8rU0RNa1RPSUsvWFNNNklvOTltTXlLbmg3RVlnWm9UcHRIZXUy?=
 =?utf-8?B?dnI1bnVseDVKTUNqRDNQQnBlZ2pGYXJSbzNwTjZ0SnBwV2RaTEIwNGdBSlR5?=
 =?utf-8?B?UUpoSnRzWld2UFVYaVBuTGdSMTA3K3lXaXFhbVNiNi9aZjh3NDFDUkJJdTNv?=
 =?utf-8?B?VVBreXZvUTcvYVJPK3NmRzNOZUJaL2J2cCs0c2grdnNOOG5GQUtMMG5vZElU?=
 =?utf-8?B?UGhFREN6R1E4Kzd5YVNuejhRbW9xQ2F4RXhoUlVHNVVLUFEwbmM3NkxkMHJX?=
 =?utf-8?B?WEpWTXZRaE1abHRpdmpQQXBPaGhGYnZmQkpLa1lLTmhWR3ZtbS9IVVpmQUFm?=
 =?utf-8?B?dk1KR0ZpTk1Gc0dqM1lwZ3FOcllUOXFDbzZQdXUxTW9tLzlYUDJLU0tOUVZy?=
 =?utf-8?B?NHFOOGZCOUk1VzY1K1QzdUJZY1UxQ0FFMUlGR0pQdDI4UTJtSlcvUXhKa3My?=
 =?utf-8?B?eVROMldSQVZFUnhhY3BISks5alBIVERQTFVJYXJjWmdCL1VsSEdLNjNhZHox?=
 =?utf-8?B?RHVGTk00cUc5Nkk1b3RjVU1MZzhyK2ZHTFN4M21QOTZ2dDV4UVNjdmo0Zm1P?=
 =?utf-8?B?YmRkODBMSkxSTS9EbVNYbVNLMElUakVMUFc4VU8vMzAzdFErNVNEcXZENkYv?=
 =?utf-8?B?UGlwMkVJT2ZEeVlJZ2ZBR2JWTUVKbmovd3E0bGxZMHB4MmRkcVQrOWk3VUxv?=
 =?utf-8?B?NDNwQjVVR0RMWWg5TW13ZTZ5Tzgxc242YkYyQnlnNlBxdTc4N0dwVjRaNVl2?=
 =?utf-8?B?UUFiL1Q5SWVKeC9ud0FDRjEzVU92RUxxWUFuZmFKREphWjZqQWNiTDd2TUVn?=
 =?utf-8?B?aGJZR3phSG5JVDIxeGtYZW5DMlpYWlhycmR3bld4RU8vNGVheG1IQlFCQnpS?=
 =?utf-8?B?ekkxcjZwei91SGFVNnJaWWkrdXJDMW41NTZueGdGSWtJcFpjbUJ6Q05xZENE?=
 =?utf-8?Q?4jLIOoAfCoj859VXkR1GNF9yyBzB9ObfaXuKQr9roi6H0?=
X-MS-Exchange-AntiSpam-MessageData-1: vefGagORdt+lSQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95c17811-7b9f-485e-a4c1-08dec6a19c84
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2368.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 03:37:37.1183 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n57QwFFv1viNo7RVAOdmpBPrQYxawxJiErJfps9Th6BrJM+QMm/qPIr3SfxjyLcr8nqZjVT1egxy3glEwgmHtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9226
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

On Tue Jun 9, 2026 at 5:04 PM JST, Alexandre Courbot wrote:
> From: Joel Fernandes <joelagnelf@nvidia.com>
>
> Add `total_fb_end()` to `GspStaticConfigInfo` that computes the
> exclusive end address of the highest valid FB region covering both
> usable and GSP-reserved areas.
>
> This allows callers to know the full physical VRAM extent, not just
> the allocatable portion.
>
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> ---

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>

