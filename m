Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AD4606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 04:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=j1F0r1Ie
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5330510E048;
	Fri, 27 Nov 2026 04:27:30 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013069.outbound.protection.outlook.com
 [40.107.201.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EEA210E048
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 04:27:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IL++x6tYHf4N8A53zzlCwdV6S4nAlMtHJ5aa5uGcYjEwqb28shZ4KE4ZajTAGOYeR+W5JX2Ry8203Zu8ZR4Ugmn3DYNrXYpG9P0yN5ZgTmtWF6Phm3trKTC+sN5gCDK0vcNkyefJJaI+VL9j7I64+0hUwbIEVACC+EaUkyOcbWIJWDU8VC1dK16M3xwYe0LIgtBCUd1lSuMbmBm1+7udOFq51BQxw6E7aHEBF2TEh1+FrCOUti7r8psNwwECv+wF5qVAgqJRT54kkjVqwS2ywgfioCDHbx9HG0VHXnjz9tycGzlUck2tizQ1C0Iup4JGe5OG7hyh20V4tm+Bq20gJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wv3hLfr27B6NzlcW8dssAXAsKC/NEE7uUw5Wd4Z27cA=;
 b=K85FI6mvp+au5AVBsrI25ITA62QJRwKPGBfTHT95dNowr83ovVXfTsZbZHOb88YY+Zszh8PJcJqPNMFoPakuH84TXPYi1LOgKRlmz4m0QHItzR8lA5qgPFG0G/6VAce+xXP9gOhdzAsU1vzirAPMURnyaC/DWgzHB+umkEL0BctTytMjM9i8LNuOB5x74yZkJ9UZRNgTHFTxsMaeIWrpiAeDFxpdIFV6fIN7b0PHCQzAATqKdo/4bZsvDJEKBJkuwjfN6nifD9exWHmjw/l3Dfbiw5dBMWohGNOuYC/XpljkGzjEScHAww9AiWuSv4gadyP8KUS95XWhRpJsRiTD5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wv3hLfr27B6NzlcW8dssAXAsKC/NEE7uUw5Wd4Z27cA=;
 b=j1F0r1Ie/bOVwnJxJhGaogYbZwhY+DsA5sSSqk2oxri0kzUlbFTNUcJAgVHmUYZbBnqp3u6p8wMN4fw2OTRxPMAW9RVzaVI00YoUGZ/raJYwYmgtRGzmzCiPkeHOmjCE348lCE5K57HF+o+YDPsBTOoWL9mLs4mSOhjwes431ATFvsKBww7jl6yZOh3+8LBVgQjNvTxj14q5oxtHjKt8Eb/vEWdwVQ4sI0Iifm+1pXgkDgf/zepuluqorrTIRvvSJKiABNr7O1sB7dpwa1F0DRqWsY2vtWkbGHqrtcH7Qa+slWTplVkLHaHIqbz9OYH9Oycd1lUxNxgv7s+qdHr91w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by CH3PR12MB8584.namprd12.prod.outlook.com (2603:10b6:610:164::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Fri, 27 Nov
 2026 04:23:15 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0662.004; Fri, 27 Nov 2026
 04:23:15 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, devicetree@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 Svyatoslav Ryhel <clamor95@gmail.com>
Subject: Re: [PATCH v8 02/12] drm/panel: panel-hitachi-tx10d07vm0baa: Convert
 to use MIPI DBI bus
Date: Fri, 27 Nov 2026 13:23:11 +0900
Message-ID: <hlO8KiQKSi62yShZAIyhpw@nvidia.com>
In-Reply-To: <20261122081820.53199-3-clamor95@gmail.com>
References: <20261122081820.53199-1-clamor95@gmail.com>
 <20261122081820.53199-3-clamor95@gmail.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TYCP286CA0246.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:456::12) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|CH3PR12MB8584:EE_
X-MS-Office365-Filtering-Correlation-Id: 34e5bd54-1201-4aba-e8b5-08df4c3e27e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|10070799003|23010399003|7416014|376014|18002099003|22082099003|921020|56012099006|261022075727099003|4143699003|11063799006|261022113327099003|261026121527099003|261028144727099003|261021123027099003|261102123227099003|261026140227099003|261009223027099003|261021121427099003|261022105027099003|10067099003;
X-Microsoft-Antispam-Message-Info: s1aIfb4U5ziA1fvfRUC/dKPWOQpUhKV5eD4KDAb73EpFj+RXZASfUfh4HFwmWdnWSclh8a19t8mIlNSpdYdL/9AEh5ioby1YoOIwVSoE5eAxoz6fzGhpLk073Tz3sUmi/8PFydQIJQUbdPbDxz3WHVS6IBSQdAg4IyRdN9XUjk46IdRSbXi2TVGXCkvFkcxV+bUAGnCv3G4mlpEgVx5vq6mgAD6DcUx1DxhNr+/2eIi6ePmaxTsz+jeEpHPqO5XLgMqIUGj8cMaPw+nEGKepswlQaMoWTlLNa9ZDzcL00u558+6i1e7eu5liDggVJP1aNlRE6wjlKeYzxcd5IrXVNhM5EKnAf+Irk9jwVW3zt0El5hFe8+woT0G3lwmsOXq9Byz+IS6Dl7gqukcQy6oZakBm2miRv2DBBdU5bhR7vCsmdn9WEKDFdLklZxclrYnESHhFmT4HC3fMhIV6kqfB6U3pzIkP9uWS+0S7YCl/8xPoKM72xClhzk/KGI8vZvegh4qPuN73NU4V1cgcUw4eRUj5QiYUPqdVTV3e/5iRkntq+ji4ei+cg1sSSM9hTM+/ezjJmOnMF9glMOpb4owQ7UNTlLJ55Jn/zXN4EMCNu/wzLpmS6jO3TJGyxBkLea+8tErEdKyFMXGgUobiKZeLwHcGFRudI+283NH3rqzM1301qqMpWtTyq9EPl41jQyEsYwATbIJdroR98Klsyy5eTw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(10070799003)(23010399003)(7416014)(376014)(18002099003)(22082099003)(921020)(56012099006)(261022075727099003)(4143699003)(11063799006)(261022113327099003)(261026121527099003)(261028144727099003)(261021123027099003)(261102123227099003)(261026140227099003)(261009223027099003)(261021121427099003)(261022105027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UE1Kd2FsWVFmMXErQzRuV21nM0xxU21wdEpESGpISEo1M090eTF5L3BGQ3JD?=
 =?utf-8?B?Rzh0My9uVUZObVk2SnJZYTNHK3FkY0NLUVluQU9xQUFpRG1lM0QydFQzdTVJ?=
 =?utf-8?B?Q3FxUTBvcEpvN2JaT2twSlYyZ3hJRERrYUJmWEZMSS9sUklRMGhRblNBejBP?=
 =?utf-8?B?dzdXbHdWcVhObDVPcWUzN3NYM0s1RFIzQmdOU0tNTVdsL1NVTUhFZ214RTJ6?=
 =?utf-8?B?VVlhSGFYSWhvYUQxdVlHUnpiVmg5L1BGbU01eDVhVXl1MFdGVEk0aUZmYkxm?=
 =?utf-8?B?QkJrOEVmN29uN2p5TmJqS0Y3RjR6eUVHcld5MldiekNTQmdpSEx2dHk2UHpP?=
 =?utf-8?B?d2V3VUN3VE16YTY2OVgraHBqWUVza3ZjUGhOTERvQ2pIbVFsMTlKNE9Eb1FW?=
 =?utf-8?B?bUNJZGZCT1ErcVdCOSsvRExGMWs5R0t1cm9TUDYxQ0ppbVg5N2dsRW0rSlhi?=
 =?utf-8?B?VE1rVHdwNkpTcEhsTklZMlB1M0pwbkxJUFVYN1VxakczSFJzbW55blFIazk4?=
 =?utf-8?B?NU1wR2E3aGZ2T0VpU2ZsVUJGYmlJaitoQUVEbFZjZEZ5MFhpYnJaUTJsL284?=
 =?utf-8?B?eWJ1a3JtWnZxdWtFcVVrK3VVK2hZUEJYbTd5Q214dEw2TXBjdHEyOTI1cGgy?=
 =?utf-8?B?QUhOODFNOVdxWmtDSHlIY2FVTmtTTnNOajZCdVJPMW9FUk42YWVwZVQ2cCtU?=
 =?utf-8?B?NHExWFdrOXQydGZaYTBSZm5JQk8zMVZKeW41cTA2WmZiYzhha3ZsNkFYTlVH?=
 =?utf-8?B?MWNKR0ZHYi9xcGVBVGdqSlRCNVIrYXp5UGhnU2puakVmcW9ZTnI3R1VHd0dN?=
 =?utf-8?B?UlltcHUvSFJ6aENwUTBEVDBwWUdoRU43clUwdjVFNUFrRTJOUEU5UFJPazhN?=
 =?utf-8?B?bStHS3NmdzJaMTNwTGJkUmx4U3FwSUhTZ2NjUVcyVFdHeHJoRExldk1WalBG?=
 =?utf-8?B?czB4UFVTd0VyZXczVWpGMFBxdUY2QU1NNzhVZmw1aTV6OU5JOU9ZMnRWZWVJ?=
 =?utf-8?B?S1hiWFluOHBTN05KZVNyMUtPRlk3MERqZ2NMOUxsd2FmbEQ5TWdUVzl6dXl0?=
 =?utf-8?B?OVY5a3RwMlREZWZJNHdQb0R0UVNQYUpuaEVNYlp3L0xrZmlSeG9EbGZjS0xL?=
 =?utf-8?B?UkFSTzdzeWRsNHdYalZuWnVnZU1QZGtWNnI2VDNESW5NaDR3THc5YXNIa2lx?=
 =?utf-8?B?M3p4SUluRnhmY0tIUWp1N1RSRWxnWTk1WXZKWEs0MGNDVVBnRXRrOGkzb2Rr?=
 =?utf-8?B?UTBldzVhcGZacHVQOS9Xb3creUxjRDk4a2R1dmtXY1h2WjVKbnpRZ01NSVFH?=
 =?utf-8?B?Z0FidTYwR05pMEZxV1VaVTk2SVViN253a0d1SEM1L2d1aE5ZRHVqUCsybmY0?=
 =?utf-8?B?anpEeVFvbEF1dm5obkUxZHZkOHJaaUMvN2hhanNaekkwbVkwTm9wSG0zZVBV?=
 =?utf-8?B?NnZpR1lzbVdibm94VUcwY1dqMEQ2SFBxMm9NcjRZWGdWOW41OVNaakpnSUVT?=
 =?utf-8?B?aWlvYzFVMEUwYU93bFZ0TGErUEhCK0hwYjk3Yk9CSkczdS9QbURreUI4WlJP?=
 =?utf-8?B?SmtTT3lQUjB1RDhmcWNBcmVwcndYd1dyWGt2RWJ2VmJCLzhocVdpNjlvZUs3?=
 =?utf-8?B?d21GOVI2YnVjYnRpajMxSHYwVHJsK0dXZzlqRldab0RSZmFwdTB1aE1jQXRu?=
 =?utf-8?B?dUpvR2lKRERKVXdqM2VHVHpmLzI4M0NsWlQyYU5lWldjZnE5VXRDbzhwU0l5?=
 =?utf-8?B?L3U2ckFQSEtDdTNBcDFlYThNaWZLN3hLbUw2T3BPNWMzcFNtTFp0eXpRMWt6?=
 =?utf-8?B?d3JSZ1NpbEJpbzlFMktJRzNwNGtyb3Q4RGNLRkVOTS9KVzIwdWNoQ3ljQzJI?=
 =?utf-8?B?UGtsVUhYTmQ5UVVJNVExOC8vYXZId3FFcmZKMFdYbFkzYU9pTmNJVms2N2Ju?=
 =?utf-8?B?K3JJR3JjOWVjUGIvR1dXczl4M2RGYUgwajhWN0U2ZFNITDJseGg1a2x0QmFj?=
 =?utf-8?B?ek1ITFNWM2xPRUJQUmdWVkRTRTJLOHdBcVJTRG85dEJ5WFBQSHRFaWZNMUFS?=
 =?utf-8?B?TElhTUp4MUx4OFF5Y0h4V0kvU2MvRkwyV0FZYU1NZ21kNzRKdlBvbGt4M3JP?=
 =?utf-8?B?Ri9qM3VhNStJWUlKelA2Wk1jc1Z5blNtU1RudXMvbnRRRWI2TU95N0tqMHA3?=
 =?utf-8?B?Q2J1UXF4MHMzdStnTkVPdFpnUVJ5eWZ3SE56TE51b0lVelU3d0dRaXRIZEJ6?=
 =?utf-8?B?L3FIVk9xaEZvMWJES01idFZIMDFScWlOellJdVlKaHBUOHpiWHRiOW5NbmUz?=
 =?utf-8?B?WE5JWGFOQVQxeEI4TVdNMHo0bVhYYnY2U2JJNjI3Tm1XWWJURDBlYjAxbWlD?=
 =?utf-8?Q?TBquAHVGm+neneT3cqKvNKrY/QYCZgiv5ZDdYbAb1kKfn?=
X-MS-Exchange-AntiSpam-MessageData-1: 2WP9WCQ1R2WvxQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34e5bd54-1201-4aba-e8b5-08df4c3e27e2
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 04:23:15.2776 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JrTrNI1KygeMlHwKohIyEqwzwOhAos0yjYBWVJAqHaJpJ6YmLK1+sBV8eyiKt380szD+FG0TtgP73GD/Ssr2dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8584
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sunday, November 22, 2026 5:18=E2=80=AFPM Svyatoslav Ryhel wrote:
> Switch from a generic platform driver to a dedicated MIPI DBI Type B
> driver.
>=20
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  .../drm/panel/panel-hitachi-tx10d07vm0baa.c   | 25 +++++++++----------
>  1 file changed, 12 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/panel/panel-hitachi-tx10d07vm0baa.c b/driver=
s/gpu/drm/panel/panel-hitachi-tx10d07vm0baa.c
> index 83c2af1be9755..318ece68b7806 100644
> --- a/drivers/gpu/drm/panel/panel-hitachi-tx10d07vm0baa.c
> +++ b/drivers/gpu/drm/panel/panel-hitachi-tx10d07vm0baa.c
> @@ -14,6 +14,7 @@
>  #include <video/mipi_display.h>
> =20
>  #include <drm/drm_mipi_dbi.h>
> +#include <drm/drm_mipi_dbi_bus.h>
>  #include <drm/drm_modes.h>
>  #include <drm/drm_of.h>
>  #include <drm/drm_panel.h>

You should now be able to get rid of includes of of_platform.h=20
(replacing with of.h) and platform_device.h. Agent says drm_of.h and=20
property.h are also unused.

> @@ -25,7 +26,7 @@ static const struct regulator_bulk_data hitachi_tx10d07=
vm0baa_supplies[] =3D {
> =20
>  struct hitachi_tx10d07vm0baa {
>  	struct drm_panel panel;
> -	struct mipi_dbi *dbi;
> +	struct mipi_dbi_device *dbidev;
> =20
>  	struct regulator_bulk_data *supplies;
>  	struct gpio_desc *reset_gpio;
> @@ -40,9 +41,10 @@ static inline struct hitachi_tx10d07vm0baa *to_hitachi=
_tx10d07vm0baa(struct drm_
>  ({ \
>  	const u8 d[] =3D { seq }; \
>  	struct drm_panel *panel =3D &(priv)->panel; \
> +	struct mipi_dbi_device *dbidev =3D (priv)->dbidev; \
>  	struct device *dev =3D panel->dev; \
>  	int ret; \
> -	ret =3D mipi_dbi_command_stackbuf((priv)->dbi, cmd, d, ARRAY_SIZE(d)); =
\
> +	ret =3D mipi_dbi_command_stackbuf((dbidev)->dbi, cmd, d, ARRAY_SIZE(d))=
; \
>  	if (ret) \
>  		dev_err_ratelimited(dev, "error %d when sending command %#02x\n", ret,=
 cmd); \
>  	ret; \
> @@ -54,10 +56,6 @@ static int hitachi_tx10d07vm0baa_prepare(struct drm_pa=
nel *panel)
>  	struct device *dev =3D panel->dev;
>  	int ret;
> =20
> -	priv->dbi =3D dev_get_drvdata(dev->parent);
> -	if (!priv->dbi)
> -		return -ENODEV;
> -
>  	gpiod_set_value_cansleep(priv->reset_gpio, 1);
> =20
>  	ret =3D regulator_bulk_enable(ARRAY_SIZE(hitachi_tx10d07vm0baa_supplies=
), priv->supplies);
> @@ -243,9 +241,9 @@ static const struct drm_panel_funcs hitachi_tx10d07vm=
0baa_panel_funcs =3D {
>  	.get_modes =3D hitachi_tx10d07vm0baa_get_modes,
>  };

Unnecessary semicolon here.

> =20
> -static int hitachi_tx10d07vm0baa_probe(struct platform_device *pdev)
> +static int hitachi_tx10d07vm0baa_probe(struct mipi_dbi_device *dbidev)
>  {
> -	struct device *dev =3D &pdev->dev;
> +	struct device *dev =3D &dbidev->dev;
>  	struct hitachi_tx10d07vm0baa *priv;
>  	int ret;
> =20
> @@ -264,6 +262,9 @@ static int hitachi_tx10d07vm0baa_probe(struct platfor=
m_device *pdev)
>  		return dev_err_probe(dev, PTR_ERR(priv->reset_gpio),
>  				     "Failed to get reset gpio\n");
> =20
> +	priv->dbidev =3D dbidev;
> +	mipi_dbi_set_drvdata(dbidev, priv);
> +
>  	ret =3D drm_panel_of_backlight(&priv->panel);
>  	if (ret)
>  		return dev_err_probe(dev, ret, "Failed to get backlight\n");
> @@ -272,9 +273,7 @@ static int hitachi_tx10d07vm0baa_probe(struct platfor=
m_device *pdev)
>  	if (ret)
>  		return dev_err_probe(dev, ret, "Failed to add panel\n");
> =20
> -	platform_set_drvdata(pdev, priv);
> -
> -	return 0;
> +	return devm_mipi_dbi_attach(dev, dbidev);
>  }
> =20
>  static const struct of_device_id hitachi_tx10d07vm0baa_of_match[] =3D {
> @@ -283,14 +282,14 @@ static const struct of_device_id hitachi_tx10d07vm0=
baa_of_match[] =3D {
>  };
>  MODULE_DEVICE_TABLE(of, hitachi_tx10d07vm0baa_of_match);
> =20
> -static struct platform_driver hitachi_tx10d07vm0baa_driver =3D {
> +static struct mipi_dbi_driver hitachi_tx10d07vm0baa_driver =3D {
>  	.driver =3D {
>  		.name =3D "panel-hitachi-tx10d07vm0baa",
>  		.of_match_table =3D hitachi_tx10d07vm0baa_of_match,
>  	},
>  	.probe =3D hitachi_tx10d07vm0baa_probe,
>  };
> -module_platform_driver(hitachi_tx10d07vm0baa_driver);
> +module_mipi_dbi_driver(hitachi_tx10d07vm0baa_driver);
> =20
>  MODULE_AUTHOR("Svyatoslav Ryhel <clamor95@gmail.com>");
>  MODULE_DESCRIPTION("HITACHI TX10D07VM0BAA MIPI DBI Type B panel driver")=
;
> --=20
> 2.53.0
>=20
>=20




