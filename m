Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA072CCFA13
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 13:24:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2416D89BAE;
	Wed, 29 Apr 2026 13:24:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="nOMqhdRH";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012059.outbound.protection.outlook.com [52.101.43.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E26F189BAE
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 13:24:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P9CtYSjg20dD2Xoh9MsuAyIj1Sy/u+OFQupsdoI7XhWXjCDRo59NsekCty+3XiMG/IuOgXfzuYTTO35flbct01evNK/zyq7N8p22wa4XZvDLmOiuca4zdxzwLMdBKQ9TCmiwfRgtb2AjbKDcfy49Z1b4GFuxjC2dsrA9KsiltiWj4f81S+EUsayehxY1uv74EEbYbI/9Ekcl2Kl0fUFQM+N+i17+7ZBUSt74KC3r/aF2kDKRxIWxRoQN9Ek34IYVlxtK2dtLQdRMYas8omJWl9fNOr6RVamXtaxNJc0GNwjN2IjaJL7yuEFbkC6r7nZDGuTfeDwF/HXU4Gtd+cGtpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L32hcnx/8I4hkn4AKmxrxc9ugGtjfVGw6+0iqRlD1Js=;
 b=kIOY6q75CdA4H8R5wNWvcdqFRKtl06QqW/1ni42szREwUGgWNRTmOJp48HqJQ8YvDhIdCqdFa78VWThz2NfNBNHetV0ot49jI3ELe6QLIXJ6AF6JekAMomgU24Jtxu8BZQNJUt3qcjSKS5REjRKIe2vFndaXW7lp4Rpr0VXXyKn5IOWWTfbIR/ffjd+hooCs6y9pfy3fmHUFAhqVLf0iZXm2ARe8arlvcxl1kgpcdke9NFyzuIii2wqpXaiY+5teqsk5twwlwCa5DuQgLprfCjS8BcTQMrKXVe/KbL0xzie2v69F7+APRdAPQoLpixfJ0lq607lMHDb701SdUyIbsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L32hcnx/8I4hkn4AKmxrxc9ugGtjfVGw6+0iqRlD1Js=;
 b=nOMqhdRHAW56hNVQeWp4rDcaIcZ8MeSDkD0EFDrGTbg9DbKykBJu0ced7A7DTi57Rj5Fi54BTb9Yje4ohmP4sDjeUFdIWa0gzh+/D/p7dMUMSTpafO3OYv+s8bBfIEqaBAWFB1p0SO8dn1TGsd9lm02Xyo9Y+jXyC2SQNR0YQypLjrL23YM8QkNeeHsq/8SKa7PlUy4LW+VZ0AVAhMh+4wz/3w/PW9cehZb3Y6lOrOn/4ShNqwCfuQ4AJ71CS+1RWPdb72a/vsXxukZlSB5UxNQTZdT9pMsKSCMRrQPGau0w8DQM+ieqbOFuZgWEVqTTCodGym81ybXpz7bOC5NPvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MN2PR12MB4333.namprd12.prod.outlook.com (2603:10b6:208:1d3::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Wed, 29 Apr
 2026 13:24:41 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.20.9870.013; Wed, 29 Apr 2026
 13:24:40 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Apr 2026 22:24:36 +0900
Message-Id: <DI5O794IQL4T.1TUZKR7LI9MOS@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Joel Fernandes" <joelagnelf@nvidia.com>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 01/11] gpu: nova-core: vbios: fix various cases of
 reading past `BIOS_MAX_SCAN_LEN`
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
References: <20260421-fix-vbios-v3-0-8f648aef7a85@nvidia.com>
 <20260421-fix-vbios-v3-1-8f648aef7a85@nvidia.com>
In-Reply-To: <20260421-fix-vbios-v3-1-8f648aef7a85@nvidia.com>
X-ClientProxiedBy: OSTP286CA0084.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:227::15) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MN2PR12MB4333:EE_
X-MS-Office365-Filtering-Correlation-Id: e58c096f-8516-441c-a390-08dea5f2ab0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|10070799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: +hFNqb1KcCQnW8SFVQIfX/CLvCNvABy7IjtmrM247BbCuEBrEcyF+19LqMw7IzO7s4dZie6XO41EI4s4ZEv7rtt6ZRHOq8vm977l6NrpS7JLsUaliMzEzF+XMJ8ZLSGd/JPbwOem65fW3Sr0sYZUSQFq1ahyX7lAQShhAlhwiCG0WzcMrFFhegatMeRbm4jK10H28w43I4PjtmkiC+NgtKf00z0I9fqR5esLe/cZWpqk1T/eSxGolLB57cXoYeEES4dVXdDEuvYhfrY3/7Ztg78P/G2p20h1CrLkbty3ZSkORb5ZHW9+azgc4SaBoWmmHg0RV+foh4QGl2D16CiTawgPcB+QzOtXLyGQrwd/QtUfEovfzWb1YYQZDpmaGE4ETJcXIFD5ykM1YMF8TaWarSOMBUr1XdvovNwEcWyxQd5wZtVZz4ltk+F7WSnZNRelFoFiF1Pce9TVN28rNvthl00nSEN8yuG1nHhktmZtgJHPRChy6F7g7bg2spTSg2qw02RCR+cCl23baEjCS8ohOVe19jZfiebzSGmyujC5WCeni1OwmKEDATMRuVs+Db2kBaFUyBlXbylUgZf4uJji2e+3D71rvnCC9Fo7q6QqAy391Y7Fx1p9eOjH3bQBtLEYCpU+IWKTRze5ADYbulv7rnIJJSxbM239j+P86uQr6hSKMkvfLxKvwvV+1oYsDakPcew9mD7NVN95qdcTaVTjvrZ/ecUL3UjRqRIJpeyC5bA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzdXaHF2UTA2YU1TZmVpMEFMNThubm85WkduR3JBRVhkdjl6MlJTQ0VycG15?=
 =?utf-8?B?c2pNK0JOYXVjUWRLV2w2RkxxOG54RWc5WUJEWjl2L3MrZ1UzTGpYVHhTQ0Nw?=
 =?utf-8?B?eVJmVTQ2ZmtpK01vSXR3QjBpamhvMGJOYmVzbkxpNkk1YnZENUh6ZmdxbEtp?=
 =?utf-8?B?SEF3ZmQvSDVOS2cwbjJOWEJyWHdPejgxOHZSV1YwOERNRlBESmY3L2pkQ3RL?=
 =?utf-8?B?OVZxdGJwc0ZXYVUwY3c0eUpqK1Z5Yko1RjVkc0JoN2Z3U3phWWV4b0hORFVl?=
 =?utf-8?B?Qi9HTHNaNnJFbFNMbzl3R3FIUFppZWZBRzVaNHJmUXZmbWFHdmdGT3JVZWJj?=
 =?utf-8?B?UEQ5dVptUlJjZk1vM213Uy9ILzAraW84WVBaTXlDUTlpVUhEMHRVR29Sb0w4?=
 =?utf-8?B?WFU4Q2lWNEZvZWZYRHhOck1yRzlpYTNUZ2cxMm5EMjJNU2VBUWlEZ2tiZzd5?=
 =?utf-8?B?Z3VPenVUcHJpbFdsdG5YS0JWclJwSlU5S1owZVJPTnZyV0laUXdXMHEzek01?=
 =?utf-8?B?T0FjbFZLY0ZTVkNPeGZuZjU3TGdPL2VGa3BPUUJpYW9uMzJFdWJocmZUaFpk?=
 =?utf-8?B?OVAycnZiak00ckdYeFRzSUUyN0JMdDhDbFNjVjQzb1oxa25lbUlpd21aWEpC?=
 =?utf-8?B?UlFmZnRXNU5jUXVoS2ltUHQzNlFDNzdsc0UrRllGTGU4VW9WemRpbVJobXNI?=
 =?utf-8?B?bDdWVGkrVkpkTnB2SmZDM3hkNnF6Wkd0NDdockFiblFyUm1ZQUV0WmJJeGtL?=
 =?utf-8?B?TVlsT0s1U2g3bHBsMEN4TlZIQmR1ZWRzbUlaRXpub29LNTdkSXhXSE92ZUhq?=
 =?utf-8?B?Yk56VU1NbGRObDNkcWY3dHM0NW51dFo0SmhBTjZtMW90REc5K2JuR0swalhD?=
 =?utf-8?B?TUZQK1VkKytpcEdBemhRek5kYlVNdkVWMEc3VHJBUnduR0pYQUtTL2Z1bGFs?=
 =?utf-8?B?RCt2bmM3bzVFaGFQNWVJMVR2SE4yNGFmS3l2cnJkY1pSSEtnTE85RFNDSjZ6?=
 =?utf-8?B?YWJJaEVsWVV0endJRzBMNVVMN3ZNZkt6OTBwRXZseWRKb2RxbHljc21IMklF?=
 =?utf-8?B?Z3haT2ZPWHk4d0w3OFZYVFVoSkUzNGtNL2RBdGhlMWs1Smh2K2RQNnNBV3ho?=
 =?utf-8?B?M3lmQVJoU0RMclNUYW9tdWY0bmFtR0tQUkZpRkhrSkc5aVZDYy9pbWc2NXo3?=
 =?utf-8?B?NDJaRVgwZnpOb1gxc1lMQnBKVnpNOE5ZeFNFb3BOLzlvQ0gvTDF1WnNnTlFD?=
 =?utf-8?B?dmg1K2hkNm1aUkR6K3RhYnlKWHRxeWVhL2hQaFovUW9hWmRrMUtKMzlVTFhX?=
 =?utf-8?B?bmM3cXJYNnZralI4OHZjcnd1UnpkY0Fpc0UyYkhvallsdUJJcCtJUDYrYjhw?=
 =?utf-8?B?ZzZ3dm5FOSswWXpIeHpEcnRLNTYxVWVPTDdEZFE0eG5NQmtIUEJ3MjdOVU5W?=
 =?utf-8?B?bW9mYWNLM3ZEUmR2MzhIb0ZWaWNRSmRnWmpIdTIvUms4ZlR5bDE3VW16bHdh?=
 =?utf-8?B?U0hVVW5lNW9pVW5tNE5ybVVVeE16OE9BMEhZU3pORmUrUUZoTEt5M3RjMFln?=
 =?utf-8?B?ZXB3UDd0dUp5Nk5KZVN1VlBFOE9mUHcvOEMxNjJNSkhmaG1ZaGxqVXhadjJV?=
 =?utf-8?B?RVBBb0RxTmk5c09wTGdIMEJHem8wdWFCMEdiMEdZZGFNOVhtWmtQODZnbGdm?=
 =?utf-8?B?ZWFNbEdsWjJsekxiQmM5RmdhZjBwNHhnSzVwTW1BUjUrNEhMRFRuT1NTWnZa?=
 =?utf-8?B?aU5xaXFyUyszM2F6MGQ2eGNLb3JxVlI5dXhEQXphZSs3NnlqTW1sYWhVTDlE?=
 =?utf-8?B?Y0pHNjdkYnFMN0JrWHEwbkg2UkF1WlRPVUxDU1ZuV1BnMmJWSnN5aEdhck5O?=
 =?utf-8?B?QWlnZFlKM0MwS2JxTk9qV2N5a3FEbzNyeUs2TU5oTU91aHpQUHBFeXVPejNr?=
 =?utf-8?B?VkhlVGhPejAyc3c0L2E5SDdjem9uMnd4amJpaG1qc0Nid3orV2ZReHZpQVRk?=
 =?utf-8?B?M25JQndIU0J5N004ZEluUi9uNm1SY0lqNWEvdXBWSmx2L09tUmZaUVA5aGZF?=
 =?utf-8?B?OHMwK1VjQ1BqaG1pcjFzQ0liMmIvYkh0RTIrM3VoRStkVEVXTkVpeitlZzYw?=
 =?utf-8?B?bHJVQ0dUVmQ4YTQvT0llSU51VkNMbmh2TURlWUZDV0g4dWo0WmN6M2lZZisv?=
 =?utf-8?B?dTQ2RzdBS0dlUnJwdXR6WkhmY3NWK2dEU3FDRUQ3akwrNFhnT0JaT2p3cFFE?=
 =?utf-8?B?cVRVTjM2UUoxOUVRWHpRam5WVDBSUEh5aEJGSVgzd0xOaWYyN2NaTHJ3cjdN?=
 =?utf-8?B?UmhuWE1ERktIR2xBU2REOGk3Ymw2SURqKzQ0UDEzWHRNNWtleGNwMzlkT1JT?=
 =?utf-8?Q?SixkGCpOHfKGQ+kwOWAG42SsPbhuS7XwyE+1VuNwdA4LN?=
X-MS-Exchange-AntiSpam-MessageData-1: M7iBaWc7q8oVQg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e58c096f-8516-441c-a390-08dea5f2ab0f
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 13:24:40.6660 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a/H8IfSkclhkggswGhG8LMJQIOcJVzOoNXhT6nZDVndcn3v+Z2MqmEDgMRmQkVF2104PUJAzAt4e9jmosTOWTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4333
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

On Tue Apr 21, 2026 at 5:20 PM JST, Eliot Courtney wrote:
> Fix various cases that allow reading past `BIOS_MAX_SCAN_LEN` when
> scanning the VBIOS.
>
> Fix bug where `read_more_at_offset` would unnecessarily read more data.
> This happens when the window to read has some part cached and some part
> not. It would read `len` bytes instead of just the uncached portion,
> which could read past `BIOS_MAX_SCAN_LEN`.
>
> Also add more checked arithmetic to catch potential overflows.
> `read_bios_image_at_offset` is called with a length from the VBIOS
> header, so we should be more defensive here.

This reads like this patch is doing 3 different things, or at least two,
since the second chunk (`read_bios_image_at_offset`) does not seem
related to `BIOS_MAX_SCAN_LEN`.

The general rule is that one patch should do one thing - the trick here
will be to either update the message to describe a larger thing (and not
3 small ones), or to split the patch. Both are acceptable IMHO.

>
> Fixes: 6fda04e7f0cd ("gpu: nova-core: vbios: Add base support for VBIOS c=
onstruction and iteration")
> Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> ---
>  drivers/gpu/nova-core/vbios.rs | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios=
.rs
> index ebda28e596c5..6de7e58e0da0 100644
> --- a/drivers/gpu/nova-core/vbios.rs
> +++ b/drivers/gpu/nova-core/vbios.rs
> @@ -132,17 +132,14 @@ fn read_more(&mut self, len: usize) -> Result {
> =20
>      /// Read bytes at a specific offset, filling any gap.
>      fn read_more_at_offset(&mut self, offset: usize, len: usize) -> Resu=
lt {
> -        if offset > BIOS_MAX_SCAN_LEN {
> +        let end =3D offset.checked_add(len).ok_or(EINVAL)?;
> +
> +        if end > BIOS_MAX_SCAN_LEN {
>              dev_err!(self.dev, "Error: exceeded BIOS scan limit.\n");
>              return Err(EINVAL);
>          }
> =20
> -        // If `offset` is beyond current data size, fill the gap first.
> -        let current_len =3D self.data.len();
> -        let gap_bytes =3D offset.saturating_sub(current_len);
> -
> -        // Now read the requested bytes at the offset.
> -        self.read_more(gap_bytes + len)
> +        self.read_more(end.saturating_sub(self.data.len()))
>      }
> =20
>      /// Read a BIOS image at a specific offset and create a [`BiosImage`=
] from it.
> @@ -155,8 +152,9 @@ fn read_bios_image_at_offset(
>          len: usize,
>          context: &str,
>      ) -> Result<BiosImage> {
> +        let end =3D offset.checked_add(len).ok_or(EINVAL)?;
>          let data_len =3D self.data.len();
> -        if offset + len > data_len {
> +        if end > data_len {

nit: `data_len` is only used on this line, so it can if `if end >
self.data.len() {`.

Otherwise these fixes look quite needed inded.
