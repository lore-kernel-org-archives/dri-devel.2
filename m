Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 250D2CD98C5
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 17:15:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74AA010E566;
	Mon, 15 Jun 2026 17:15:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="WsxAMo1j";
	dkim-atps=neutral
Received: from LO3P265CU004.outbound.protection.outlook.com
 (mail-uksouthazon11020129.outbound.protection.outlook.com [52.101.196.129])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39DD610E566
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 17:15:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KfqOI+zJDfHraF0iqKp4NObFRE3yAcWPwBtz4emruHuwssX/WLBQaxr6KnB8aidUJugyzs+J9gQRdXr5nzi8Qk72P9g4wQLCYUM0y7t+YweKZNlqbLX3w3zGp2EZRjoS/J7fjKxAgs1eo0EIt5AsdUtb+RSIf9gCrcpIoLj6pGXu1nt4q27uroMNX2RHjCg/yiKk1MLqqRrk/6R7UCpS8ICj+9zyk6y+4tbhhgSWtmv91XOYwV5s0MVjTT5fVVQUmphR6TjcquwcqJEE5c5+JQ9v34BlMMckgOGzK5ZXOMEsB42PKqh9soAVW18KMS/AQ54DKIO0tzoYWCqLUTVKEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tMhnDgylT1j8AxspP47DpOmtyVPxyxeP9ZVRmsYLSnU=;
 b=WSyEOgrJ0KLny9Hw0a2fXymDv9q9wxXgFP74je9HbQxJxH1utcu3Ex0RznJNS219JBaw0uQVxZGRtuzZgxqKiw6xayrYr15a/5biLeXuv7dNh4mqRRxAyLvbahPg1s6JPQ9C6kf60Byx0vEmc3YKon2crSXjkbpU2j+6BZRCoKWT63o48N6Qm5011qbaK8Bj7JUYhQxBd/DqZpXbj4eZSV04CNzs3uzNu/dh4eORR+ccaSYhWZNartIkdtEZlP0CQBj+HFuTxwcPiHkrCoR4vY2sYBPFgZ1nuQYRSPE5tCpbN6XB8ff099lK2rK6SshZKAd+s9/KnVresPBHNc+j5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tMhnDgylT1j8AxspP47DpOmtyVPxyxeP9ZVRmsYLSnU=;
 b=WsxAMo1jjtwGFqJtX0llbECC66wrKB+xIdrQo7vbbg40Uu7ASXS/0Uf+u7oE7rM7vxnxo6OW0HlKAbNIYxxysmzzYEMyQcA//ljq3P4WYtKn8gY7le9Q4knWBIZfk2t+YgpYxQhq76Pe3/5nl4qdyZQ5ug2fTgU4Tbw+Pp5A1Ao=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CW1P265MB9152.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:270::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 17:15:07 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 17:15:07 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 15 Jun 2026 18:15:07 +0100
Message-Id: <DJ9SJCIX1XUO.RTFCL56MKU0D@garyguo.net>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH 02/13] gpu: nova-core: fsp: catch bogus queue pointer
 issues
From: "Gary Guo" <gary@garyguo.net>
To: "Eliot Courtney" <ecourtney@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Benno Lossin" <lossin@kernel.org>, "Gary Guo"
 <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260615-blackwell-fixes-v1-0-f2853e49ff7d@nvidia.com>
 <20260615-blackwell-fixes-v1-2-f2853e49ff7d@nvidia.com>
In-Reply-To: <20260615-blackwell-fixes-v1-2-f2853e49ff7d@nvidia.com>
X-ClientProxiedBy: LO4P123CA0510.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::14) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CW1P265MB9152:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d2a2a7f-86a6-4f15-7d9d-08decb01a61b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|366016|376014|23010399003|10070799003|1800799024|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 3XbEU6lwatKR/EVJw4Gaqvm0XIo3whzGnMcDrsYuWDJlfaqMAhCO1yUHCfVNfeueel9FJQ8nIHDIV9yD1um+2KpoiVY1XBWRO5pSLX090cwD2ldjPg5UF4GWdW9vrnYWwZHwc9q8QgsToZlmJO/4tOzuZi5rKvu7EvT246ZwjbGVpaBbhPyM08XVPmtbANrl1LFrlxKDme+G+G5sfI6nvJmO08D0aZRcEGGW0hNvV5+WiE8KKLxsjXF3HQvQot00+EvuZrZcp/GVL8fLznP+3SseMLaut5BObyqyAmqnXBztNjYCgjFrOcXm91TufKp73ufereRNTw2gABgNE+tlB9iyeTsK5DhNuGot8hJ9eCDdk4lmhCHXXsVqbbUsuP+nGjQJXMV8gI1Al1dtlXCMCnmeEIOIVdEXFApM8Cy4RqorqFGabOYlbf+BUNpnnDvr3QcR5ogE+q24O8xFbmzgjmzq733X/SC5E5lJ0ucEHSal40OTk0XlcV7cLm72DQCP89jV+ApdmWzCEYik1RxFcrHKnU0neMfhWexTXyUorBNQ/b6MgzI3t9F7hli8gidHMv/uHT628uOLiqRNWx29YBCffN3PTsCFctShRecZB4pP71CxAxNVOOuRgxib58CtSf7FecX4+wyC1v/am1kz63QnbCUZLNZF6zH/nIu5vJ0bZnTMipn3/TEaP8X9PQTx
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(376014)(23010399003)(10070799003)(1800799024)(56012099006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlZxdWNYQkFHdlE3VysrYitHZVdXZnF3R2hVeVkvczEzT09ZMUhLZFkwQVpB?=
 =?utf-8?B?STlvSUlsUFNMcXNxY0NhK25ZdzV5V1F0SjltWFE3UEIvNm50c1dDMk9OY0ln?=
 =?utf-8?B?YlJKVWtXOHZRMjUyYTZOQVR2c0UxSktlbUFhWEZZd2VaRzNUUURYNG04TGs2?=
 =?utf-8?B?OTAveE9tN1kwYjlmR0xqTENIc2lrWmJnaTJ4UFpmc3FVUFE5WlhuM2dBeW13?=
 =?utf-8?B?MnRST0V4alZqWXFCdGtYdEE4VWZ3ajRmWHJWUVYzeVVteHFzZmVTTk00disw?=
 =?utf-8?B?YndHcVJLa1A0WnBMTDBjc3BIVXZsZzdYOG5xUkVuTXNtVkNObktKQWU0OVFY?=
 =?utf-8?B?VzVGVkl6UUdzM201SzRPQmpqMVZnMDhsUXdNWkcvWXB4SS9hZkZvTDRhd2pq?=
 =?utf-8?B?cDhmT2hiNFZib0V5QU82QUdlanpEY2EvMWkvVFRiSFdvU2RGeGNtaUo0Tmxp?=
 =?utf-8?B?ZG1xMkV0bGp6QjVQVndmZzhhL1d1M3BZb1Y2ZlVsdXJKVElEVFVrQjFtdXBs?=
 =?utf-8?B?TTM5TXNwVEZGakJDZmMyd1d1aWIxd1RoWE5hTWZnM0NaSVJnZVk0cVBDZmpY?=
 =?utf-8?B?ZEk5UG1XcmtCWVF5NU5Yc2FMQjljWEp4NmMyUGJBYjFEYnFtSTd5NU5OSUlp?=
 =?utf-8?B?RGpkRDRnZ0lVblZnd1UydFp6Rm1LQWdPYlJYZ1ozcUtad1Y3cWJxeGYydTF0?=
 =?utf-8?B?OXJGZVZRNzhwMHUrOHRxQldmbSt4UFJlNU1JeVJiOXdnVHVEdFBTbUF0VUNI?=
 =?utf-8?B?NUpGcDBIaXNoMFE0MFN0US92eFllR0ZvMlhkVzB5MFI4OWVub1NFck82bUk4?=
 =?utf-8?B?Q1pFRmx2YlpFNFdqeTJldGNoQW5lZVFidHZJeUFPbENEWDdUUUNvSE00N3NJ?=
 =?utf-8?B?SmxxYlRUdHQ4SWRqNGtPK0huZysvQjhPdDNpbjhmZ0lNZkxEZFhmNTRiK2xt?=
 =?utf-8?B?RW45bEl5VVRiaGlFSFhSWEo2Vi9lSUtSQjB4RWRpUEdQcE5PN0IwUFZzazhu?=
 =?utf-8?B?OGF6eW40a2R4cW9mQ240ZUJFelhvYkZYL0I1NnMrYW4xYkxFMXJ2eDNJdXlz?=
 =?utf-8?B?WmZBMmFTc25GWVhxNU1PYXprc2Z1OWFXRTBxNzgyVnlLWUJHOEc5eExON1g3?=
 =?utf-8?B?bG1YbVA0MVd5ZG1MMVhKUEdnSkdVQ3JERGxMYmVQOEs0Y0l0QS9SMzFCeHZq?=
 =?utf-8?B?c05JQWVabDNGSHlDcE9EQURJZ2dtUGxZR3lCSFc5MGJ4UlcwajdNMHExdnc1?=
 =?utf-8?B?OXhvVHpDODJwRkhVV3FTdnhpZzhSMkp1d0x3TjUyVjVRcXFIRkgraFRxaFln?=
 =?utf-8?B?ZVFnV1lIWGE3WThlNGxZQktjSVB2c050YmdVRmIrenYzQ1IxZkFRdG9LcHYy?=
 =?utf-8?B?OUkzMVBPRzh4MzJBeW55VW9pbUlTbHBjMkYzeHE3SytGNXRvaityTGpmRzFl?=
 =?utf-8?B?aVZnTlhGMHNmcGxIMFBxY1BtQ3Q4UXdUZjhVTnFQQnJoQUFRTmxTamg0UVlm?=
 =?utf-8?B?YyswQUlpcG1jalpjVENsSjQycTFuZDc3STRTTkRUTVpERlZ5VzByMHRyV1dO?=
 =?utf-8?B?M3JyNkUyd01PM2RpMUxYWnhuRXBQQ2VKSllBTzVqZ3hacitYb0lWYXc0WnZi?=
 =?utf-8?B?cGw2Tmd1MjMwdTlQMGUrTUEwS1N5TDhQR1JiSFkrSnJMMGYrOW5vNm5EdVhN?=
 =?utf-8?B?TjRmd3VnQ0xhMmdzbUduZzdFbE1CbVU4TmR4SGdaTUJVbytrUlVGeVNDd0lB?=
 =?utf-8?B?Y1NkbTdFOGwvM1YvQTF3SmMxRXY5VG8vSFE0NDNVL3VVeEVXbklCR2lCdXhX?=
 =?utf-8?B?WlNvU1o0MFpOcGFvb0JreU1IZlM5dlR0NGp2R2RPa1NiVkF3SHlZVkp4VkFT?=
 =?utf-8?B?bXdLQlREK2FjQ2k5SmgvOE5RY1ViOE1UREl4S3p0b2ZGbmhybkxLdFpHK0wv?=
 =?utf-8?B?ZVlhb1graWd3NlNPYXcyL1RpbENlaHcrM1p3TTNSL3hXcm1jeHR3MlhWd0xS?=
 =?utf-8?B?V1pMZ3dJWjdjZ3FiQTFUKzFsTGlOYzE3MFAybFhEVm93Qk1VUzgzdURyYzRa?=
 =?utf-8?B?R0hoUmVsZDhBR0JNT25qZTNzelQzNXdCRVBodzhVQ3g5aHQzVnVKbUQxVjRL?=
 =?utf-8?B?c2ZkZSt0Szc3VGNVeEtrMGdldmhPek1jWXZ1WkVMK1o5THpiekIvRUcrekhl?=
 =?utf-8?B?VHRSd1F5OWMwU1Y1c3QzYWxjVDNRK1N2MEkzbyttaW9ZZzVEOXFTSThhOFhM?=
 =?utf-8?B?RnpUREVJTTFPNHBCYWR3V084Ny9SQnlsQ2VuQTRxTTRpODByRlZmbllOOXVD?=
 =?utf-8?B?c3A4VEVOaFozNlphV0I3QmdGZzJycGtVbUM2M1dVVzVHUk1vTHFDZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d2a2a7f-86a6-4f15-7d9d-08decb01a61b
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 17:15:07.5943 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LP6i1hUe2W2SMG/WZjYqqzqJlzfJmAiyi1ji+RvX5Qn4ftBYn2U1MzUcYTtnN9fSbHHHWkP/01khu3vqAUXOUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P265MB9152
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
> Currently, `poll_msgq` will report a message of size 4 if the queue
> pointers are broken. It's easy to catch this if it occurs, so have
> `poll_msgq` return an error in this case.
>
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> ---
>  drivers/gpu/nova-core/falcon/fsp.rs | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/nova-core/falcon/fsp.rs b/drivers/gpu/nova-core/=
falcon/fsp.rs
> index e7419a6e71e2..21eaa8e261ce 100644
> --- a/drivers/gpu/nova-core/falcon/fsp.rs
> +++ b/drivers/gpu/nova-core/falcon/fsp.rs
> @@ -107,19 +107,22 @@ fn read_emem(&mut self, bar: Bar0<'_>, data: &mut [=
u8]) -> Result {
>      /// Poll FSP for incoming data.
>      ///
>      /// Returns the size of available data in bytes, or 0 if no data is =
available.
> +    /// Returns an error if the queue pointers are bogus (`tail < head`)=
.
>      ///
>      /// The FSP message queue is not circular. Pointers are reset to 0 a=
fter each
>      /// message exchange, so `tail >=3D head` is always true when data i=
s present.
> -    fn poll_msgq(&self, bar: Bar0<'_>) -> u32 {
> +    fn poll_msgq(&self, bar: Bar0<'_>) -> Result<u32> {
>          let head =3D bar.read(regs::NV_PFSP_MSGQ_HEAD::at(0)).val();
>          let tail =3D bar.read(regs::NV_PFSP_MSGQ_TAIL::at(0)).val();
> =20
>          if head =3D=3D tail {
> -            return 0;
> +            Ok(0)
> +        } else {
> +            // TAIL points at the last DWORD written, so the size is `ta=
il - head + 4`.
> +            tail.checked_sub(head)
> +                .and_then(|delta| delta.checked_add(4))
> +                .ok_or(EIO)

Whenever we fail with this, we should print a message (actually, the same t=
hing
probably should be done for patch 1 as well).

A plain EIO is going be very difficult to troubleshoot if this is ever hit.

Best,
Gary

>          }
> -
> -        // TAIL points at last DWORD written, so add 4 to get total size=
.
> -        tail.saturating_sub(head).saturating_add(4)
>      }
> =20
>      /// Writes `packet` to FSP EMEM and updates the queue pointers to no=
tify FSP.
> @@ -154,7 +157,7 @@ pub(crate) fn send_msg(&mut self, bar: Bar0<'_>, pack=
et: &[u8]) -> Result {
>      pub(crate) fn recv_msg(&mut self, bar: Bar0<'_>) -> Result<KVec<u8>>=
 {
>          let result =3D (|| {
>              let msg_size =3D read_poll_timeout(
> -                || Ok(self.poll_msgq(bar)),
> +                || self.poll_msgq(bar),
>                  |&size| size > 0,
>                  Delta::from_millis(10),
>                  Delta::from_millis(FSP_MSG_TIMEOUT_MS),


