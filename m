Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD3B510A62F3
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 14:40:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3244810E119;
	Thu, 26 Mar 2026 14:40:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="RKJLi8++";
	dkim-atps=neutral
Received: from CWXP265CU008.outbound.protection.outlook.com
 (mail-ukwestazon11020125.outbound.protection.outlook.com [52.101.195.125])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4124C10EA6E
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 14:40:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G8x7jjkNy/jkty5BfH1RZEhg5gOmb/+tEF8ALXrkAq4w2+D2mgL5VAAuPAlI9knTqD+RwlmEGrjB4leFKsu+RdKJydWwoyfYAwRZe2o17KY7RhZrvNXpbtBz3PewpoQknXh5a79frx1cZmXyZMJ/4OyOhJ5uXQMnmQaZDAyiqYuaORN8yPzJgv+lUsl0k32M7yzKrxjPn8+0W+m/DcTpLLJ9i9//6uFpF0qn/RqZM8XGv0kOJa9GXeb2ylNBpMuc7Su6HaTzmYRfqhdPSFZvu3Elip4aUmN1EqvTK5734IO97/YVD/zSdt26WlDBubaAf0Eme0K9tCmNenjekdaswA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0hzy8vV2nwlsjEpnXJRF0Pyh6ynsZ2EScaoO7byWUCU=;
 b=STplBPlBnQ8j0niye5bRvxRQJl0wMGdPH/yUzoYeqMmA2mMLEDOoeuUDzZMxQG90kV4G9Pbz9WZB7biBQePeNZbewBeL6Luy03CBnluPhyzyxFMFBf8DFu4P0GXHJM/41nAmuz6TGGZaYFPgdKQ3GgjoUSlPRttOC4QXB/JdHJe43WcRtuh5eR5na7Un5d8kb0Gs13yqAl/uS9mdgTF/eDFH9cu1l7Ix4sJQZpqmuLCw39AhajBlmKu1b2QuQJoZKHRQ+dYp+2M/3REmrtxCSMldk7hFrwOg4iskm8FaviPbzp0KpOMFNqPdykV9ABLJZuVsvq3udMOrOh9nVqAH7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0hzy8vV2nwlsjEpnXJRF0Pyh6ynsZ2EScaoO7byWUCU=;
 b=RKJLi8++py1CrUudvHKlZ05ssnLkbbLda+bWi7NwK/ug12cfxJV4IFCVqEQ9Wii6DYll8MzdIIe8LyKB2N763GqQKpeiV+YLtulHvBbg+PoLcG9/kVujDNAHBGqDs61E+aq898Nqc5utQyNq/arvGFuRkdBFdLhKyipikyIPnOI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWLP265MB1812.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:5e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.22; Thu, 26 Mar
 2026 14:40:12 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9745.022; Thu, 26 Mar 2026
 14:40:12 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 26 Mar 2026 14:40:12 +0000
Message-Id: <DHCSILUEKVYC.3DNKLNI6RBENX@garyguo.net>
From: "Gary Guo" <gary@garyguo.net>
To: "Alvin Sun" <alvin.sun@linux.dev>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Boqun Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, "David Airlie" <airlied@gmail.com>, "Simona
 Vetter" <simona@ffwll.ch>, "Sumit Semwal" <sumit.semwal@linaro.org>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, "Daniel
 Almeida" <daniel.almeida@collabora.com>
Cc: <rust-for-linux@vger.kernel.org>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH 03/13] rust: sync: set_once: Rename InitError variants
 to fix clippy warning
X-Mailer: aerc 0.21.0
References: <20260326-b4-tyr-debugfs-v1-0-074badd18716@linux.dev>
 <20260326-b4-tyr-debugfs-v1-3-074badd18716@linux.dev>
In-Reply-To: <20260326-b4-tyr-debugfs-v1-3-074badd18716@linux.dev>
X-ClientProxiedBy: LNXP123CA0021.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::33) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWLP265MB1812:EE_
X-MS-Office365-Filtering-Correlation-Id: 2088ece1-8770-4817-5d25-08de8b459676
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|376014|7416014|1800799024|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: AEMl96NM3hTPV9RzftdFEYxJzdmU3Ifkmu1Y4D3JSpylTO1JMoX2NS8BxtwPZEyKudVH2hXUMgut4E2gDDXv4u/9N20bfCGBP42s82ou8sKWLE2xQ5R181icsEDXEksv+qwMSBRBMKtRf5J7R4liPQTzDptVUy5TknOS6yjsh9o5WkSTXVFjwrgrALw+ZdwiEyPlpq9K2jVHl+RpWt/2bT3HMYBH01YMGRsgTsZo+iViEuFr9996NhzqaQLXu1yNNfuTMkRf7cUlYp/5V87gRfeJyQpbcZOFapZCjwY7C8CVAarZJpaVabghfEkyP2MA0OS2lmtq/mr0ib/I9ApS5rdrslqbIAETdDZrrRyhTbFTStn3aWSd6ZZILbh/baT6acejU5wuI8bsMJHv1rTPsLtc0YmpXABYRUtHaRmcJAjjGf2SwM8TLeVQu422nJf+SqsZQRc+5iTYcbOkY8e4t1gtEs4uHRJWA0Ks6WKQiw67bbjC/G0/ZNv+H/PVp9Sp1JSB5zaQ578B9uwPN1Mfm85uGn7wzaffleXDs5j3ajhl3xgDf3mEuUExv3buflvbyvqtrpLiEuRpx91TMiKCS3AWaUPghLNPBPVvRoMM2B0Vq7e34dLoeBlUXppPu3mPdM8Pm6qEYbRBt+ARV088SUv03fyokOaynVDmkbrugHPzWPBQD9GUwnz6YaERHEZ23eL4n+kGU6mhpaZp3pGcsTnb5liFikJHvS3ZR/KTJhDYB4hVw4Dtg3gJcGn7uJr9qCBzaH2utGaKFLtIiXaW/A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(376014)(7416014)(1800799024)(921020)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVNuQmFRUmJHbldmRHg5QlhiRVpocVpyWlJuYnZ2dGwzNkZjU1NmZzhFTm5M?=
 =?utf-8?B?Uy9ibDlra0VaRUM5c2Y4aGpla1VaR2wyaW9uTlhDZXpzNnFEQld5cUJsQjE0?=
 =?utf-8?B?Mk5jcGpjckZVcmtXNnFkOU5yb1BiS2V5TlhQcXNRcFRMUjY1UTVtQ05rTHRr?=
 =?utf-8?B?U0h3dW8zWHFtYnRmRXQwaS9IZGdZU1VYOEttd0prcHFDVW9RK0E2S1ZpbXFj?=
 =?utf-8?B?SVBJZm01aHNMS2crS3A0TWNyclF2SUJjdnh6L1hBZFFCZ2VkdElwM2d1WDQ2?=
 =?utf-8?B?TTNZYVFCdUh6bVNLY2ovQXZMU1dlOXg2T1JqL1VoVG5FYlFVNHpIUzlUSmJ6?=
 =?utf-8?B?NVRtV0wxY2hJbjhuRTZVcWZ3bU5hcEZPbXlVblhVZytxeVU1TWt5NGFJa0NO?=
 =?utf-8?B?Y2Fyd3BUbGN2YXVMUDNNaHhYcmlETkJBVzdsK3A3c0hyTU14eC9xTUhzSHdS?=
 =?utf-8?B?NHhuM01hYzNVR0VFMWl5djU0ZW1PSFh1WEpMT1dUMUhkbnJGeEFJcTliNzhh?=
 =?utf-8?B?ODF3Q1ZMRFJwK0ZFcW9ZbHNjOTc4TFhIeFBuQmt4NjhORTNHZzdKMmZFNy9u?=
 =?utf-8?B?LzVWUVlUUVVSNGM3eGxCRTJyZVd6R0phZHUvRnEwanlGM014ODZhL25xdTR4?=
 =?utf-8?B?S0JZRHNiS3dmamtmMHNoTXZkV3lldnNDZlk5aXhkU2RnSGJ3RVNtRUI5aDFt?=
 =?utf-8?B?M0QvcXF5bzFiU0ZuUWFabUxkTDdxc1JxWllOOUFjK1ZMeTVRc29GWi9HSzFC?=
 =?utf-8?B?czdUS2ZLdzZicEw1bnpSV3RPOEhxY1FsaHpyRkhBQUZzMnVMTVMyYkZlaHpZ?=
 =?utf-8?B?UVBOdHU0ZUIraXNtYmpNYjd5K3pzQUZmQ3JLMU5jK0pCcnJaUUI4cU5YanJi?=
 =?utf-8?B?YWpTMHMzU0J2OElkLzJObXRtdmZ2b2VPb1N2NmViT3dpYkkrVW5oZFluYnRT?=
 =?utf-8?B?WVl6ZG9JRENIUUVubXM1cU5pRnRjZUorbENndWxYaEtHRnhKNExOWE1yZ09a?=
 =?utf-8?B?ZGYvSUFuWmFBb3pya2FBWjc0MWc0SzM5R3kyUnZKeHZGbTZSbTNXTzNCaUNz?=
 =?utf-8?B?SHJ3dFBGcGllcEl0WkEzb2lNcnMvVmZrQnNxclNvczVsaTJjV0x0bEovQy85?=
 =?utf-8?B?SHBvb2pyYmtLNW5Wd0R3cUkraWUrNkFuVzYzaU5sbzRPczgwdWE3RTRtY0tU?=
 =?utf-8?B?Vk0ydlVNSlE0S2dSbTZOUCtZcExZWVRxdXl1YktabldnekhTQ0FMYWZESFlD?=
 =?utf-8?B?TjhjU3Z5SlFGODV2b2hZUk4xUnVyaHh2eUNZd0FJalJET0cxRkd4Zkd3Y0JT?=
 =?utf-8?B?MVZ4YzJSZ1JFSnBsRDBZYU0wdWNZeGdHMWpGOEM2OWFIUFdmRERTdVludG5T?=
 =?utf-8?B?SFk5clZPb3RUNXZzaEdsY0lHd3Q0aTBQV2RTUmdhaSsvWmszRUtLZmhjTExS?=
 =?utf-8?B?WURpTXRSbnFYNGVlZUlYTWpLS3JuOGhYQzRoc1JqaHpzRERhZHFEQkxSRlB0?=
 =?utf-8?B?ek5KclY3azljZVZFTm1TMzd3enpZMUNMUUViU3A5MjVMYUxzMHFDdW5pR3JV?=
 =?utf-8?B?NzhNOWZmZTg0WmtOT2pEcjdua2tEVkd5T0RBVDJGTkVZcmlLODVmUEFxVDJq?=
 =?utf-8?B?cFRoc0FnRC9HdUp3ZnB5QWV4Y2t3VjF5QXc2aTBGY3d3djRCMlMwMzgzNWxi?=
 =?utf-8?B?cWpWVndJSlQ2ZlZwbU5lNzE0REpZTmpMSzV2bkdjVVdhLzk1ejVReUZRNzk0?=
 =?utf-8?B?OVNCcGFvUXV6OFFOcGhySnAzamUzNVFPTUdtVzFDZi9SdEFNdFlCVG1ZdG03?=
 =?utf-8?B?akk1djJwcGhNdlNsa1UyU2t6bFFTb0llTnQ3SWQ3bWZtbS9oWEVucXNqbW1G?=
 =?utf-8?B?clo0VVhMNVJjTGcyTTlvQndXeGVFZHF4bDZNaUk1b1FIeDBvTWdseEZTd2Qw?=
 =?utf-8?B?WHgzSnRWTitvVzVWQzdGYlUxWVZHbW1zcisybS8vNTdhWlFuVnAxLzJ4czBJ?=
 =?utf-8?B?dmg2U2F6a1doOHpSOWppSHVYOG5hNEFBSzhBdFhhQUFINVlSeVRvMllWS29j?=
 =?utf-8?B?VitEZzdhQ3FZSVF6bGFITmpxeVFZT1ZPaENqaUUwYlpxL0xQZ0hjajlVbGVo?=
 =?utf-8?B?ZnlLTFA3MlVzM25tNDY0OUxtZG9qOUJvS1dOLzJZTzdoNTFJTXhZNmVpZlRy?=
 =?utf-8?B?L1VrQWhCVm5ONDNsR2wwM1B2NzB6dTNsV1hvR1lKYlJiTHlOcktJTUtWWTRC?=
 =?utf-8?B?KzROSlp4czdNVGM3M0d6S1h1a2JpTmF5Sk9WWDBaM0RzU2Zab051WVp6czZp?=
 =?utf-8?B?SHl1Z0lYcUJqLzVEVEFTOW5TWkFuM1FVVmdIR2FNekxZWVNSZVhkdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 2088ece1-8770-4817-5d25-08de8b459676
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 14:40:12.7302 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mEIdebxuXV8BYPga0ifEVSJeLHMdKb/wKFfOHO263cjYHOSJWWUuOfTwq8V527xwZM9bCLjjX6mvPdTekiLoEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB1812
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

On Thu Mar 26, 2026 at 6:52 AM GMT, Alvin Sun wrote:
> Fixes clippy warning:
> warning: all variants have the same postfix: `Init`
>   --> rust/kernel/sync/set_once.rs:68:1

I am not sure that this makes the code look nicer :/

AlreadyInit is very clear on what's wrong, which `InitError::Already` is we=
ird.

Perhaps just allow this warning.

Best,
Gary

>
> Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
> ---
>  rust/kernel/sync/set_once.rs | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/rust/kernel/sync/set_once.rs b/rust/kernel/sync/set_once.rs
> index db9c5423fade3..3af5538aae1d4 100644
> --- a/rust/kernel/sync/set_once.rs
> +++ b/rust/kernel/sync/set_once.rs
> @@ -67,17 +67,17 @@ fn default() -> Self {
>  #[derive(Debug)]
>  pub enum InitError<E> {
>      /// The `Once` has already been initialized.
> -    AlreadyInit,
> +    Already,
>      /// The `Once` is being raced to initialize by another thread.
> -    RacedInit,
> +    Raced,
>      /// Error occurs during initialization.
> -    DuringInit(E),
> +    Inner(E),
>  }
> =20
>  impl<E> From<E> for InitError<E> {
>      #[inline]
>      fn from(err: E) -> Self {
> -        InitError::DuringInit(err)
> +        InitError::Inner(err)
>      }
>  }
> =20
> @@ -85,9 +85,9 @@ impl<E: Into<Error>> From<InitError<E>> for Error {
>      #[inline]
>      fn from(this: InitError<E>) -> Self {
>          match this {
> -            InitError::AlreadyInit =3D> EEXIST,
> -            InitError::RacedInit =3D> EBUSY,
> -            InitError::DuringInit(e) =3D> e.into(),
> +            InitError::Already =3D> EEXIST,
> +            InitError::Raced =3D> EBUSY,
> +            InitError::Inner(e) =3D> e.into(),
>          }
>      }
>  }
> @@ -155,8 +155,8 @@ pub fn init<E>(&self, init: impl Init<T, E>) -> Resul=
t<&T, InitError<E>> {
>                      }
>                  }
>              }
> -            Err(1) =3D> Err(InitError::RacedInit),
> -            Err(_) =3D> Err(InitError::AlreadyInit),
> +            Err(1) =3D> Err(InitError::Raced),
> +            Err(_) =3D> Err(InitError::Already),
>          }
>      }
> =20

