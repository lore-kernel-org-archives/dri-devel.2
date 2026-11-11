Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810ED606A336
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 05:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=HvF7sklR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E621910E351;
	Wed, 11 Nov 2026 05:00:41 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012005.outbound.protection.outlook.com [52.101.48.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC98310E351;
 Wed, 11 Nov 2026 05:00:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ffyTLCWk5ugq3rJLU10qm15cDX6AF4/iiuiLZ19hKkiNYM/AULX1ce0eflkbigw4jtV4OIVXVu0BjLaWRLXdrJ1ZSNXx9vW6ss6DnP9V/vWIRkvJOKWvaYfy2jTtwWn9L99RUQ5V0DgwbJpstg4E6BERsvdoDOVt/O0WqHO+UWTH178IR9+cpXStJNEd3tyJkPQXEXrNmRIdxk+xrGjvbtLiHUqAL33hKIDNxmYnFjkhLJt6uVg3sBny5sBJmWwCBi/3oRv5TWomumRI3jhcrjPgWubquWm7hm0SzEBaFyCyrIadoGxfYIEnGavjC/emNi0zuy/9ktruxT6/l4638Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y/dIgHtnCTsZVliC1mpnuZIqg5Ysnqr5tN7l7hAzysI=;
 b=FBeh24Vx3EdOsakEHUHEOLZuEMoxfKKj2jCadd/7c3u1IEVGA+IvDQ0nICcnORlFXkDXfnQ3+BV8HpUNZH/apJGQgIUol/R6fqekYxFBbsaTI2zSDIFBicKxCD+5K0JY+C/WAuMV0zH0m8LKBOZ4QY1HX+QvVZIK/cV1fNkECOvNTJwwGcH8FMtoW6CV2LSf/0jIz1zcpema2r9Xo4ZlJYm1oHWMxvs8z04JEVLlIDQWyoxFIg9HuGpSxSoWYDA8IL/VcToLUAuTgG2GOBBjNDupaVfnNA6f4Fm7e1euhkg64F50O9c+JBnt2wKgFAJ2YR+gclUZjYT5VnpTD/1JBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y/dIgHtnCTsZVliC1mpnuZIqg5Ysnqr5tN7l7hAzysI=;
 b=HvF7sklR1T6oLcod8/2rwCkf2gYKaph9lAK+QPqIAvf+KJnOo/PLkc+tz6P2CcoK30lBlRaY1GoAX4kYpQSZ2YuMQEgWXC1ZTIfOFkqK6qcsDxrWY4bPjVQJexttv2T99/3bFmyUVCjG6SwK7P5iFHQi6OY7iaut3bDVimdGQWTah3EE4WrnxU9ayLDxKJypecf+cUJY1fr4KfQk556QBYEzuSRXFYsWURHw2CwXQKswItQoxVfmL8zP9xC7KfAYeydvv3FArCCwBVAlprt7D1/xnACW73axPJryiRw+HfDJo8FUn5qo9+silPYXYKSKauN2iGBReP3PdsU91/S3aQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 MN0PR12MB6247.namprd12.prod.outlook.com (2603:10b6:208:3c1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 05:00:31 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0592.010; Wed, 11 Nov 2026
 05:00:31 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 11 Nov 2026 14:00:28 +0900
Message-Id: <DMS4810YPZUD.OWR39S5EZUNW@nvidia.com>
Cc: <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH] gpu: nova-core: use pin-init self-referential support
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>, <acourbot@nvidia.com>,
 <aliceryhl@google.com>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <lossin@kernel.org>, <gary@garyguo.net>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261110152746.140351-1-dakr@kernel.org>
In-Reply-To: <20261110152746.140351-1-dakr@kernel.org>
X-ClientProxiedBy: TYCP301CA0080.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7b::9) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|MN0PR12MB6247:EE_
X-MS-Office365-Filtering-Correlation-Id: 814bea06-e25f-4a9b-232d-08df3fb0b636
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|10070799003|7416014|22082099003|18002099003|261026140227099003|10067099003|11063799006|261028144727099003|261102123227099003|56012099006|261021121427099003|261009223027099003|261021123027099003|261022105027099003;
X-Microsoft-Antispam-Message-Info: ueCo49U9XATZoFXXYr9reiUn4hVh81D6qU27WlQtOI3brBaqZgKNUX0GjnAunfy59KTszoztsE4aeqFnA9YMV+ZqKL46PzGNSyuXlkl8XIJYf8V/Q+H6HyGkTWUFI1uCscfFB/unz+HDX3aNVn07BO9nvraHfXbER3SOhallm3inM1AGu7/N7Ed+T5P0WhL+pr9Rzqret+x2J9BwJYXni+Lf0g5Wx4eU2oAe0f51WrpxyoDJJf35hgtv/SyCbUOue/3zyHF6UjJ1zoRHzDl4oKwlgYcfl4I2o5ApAeQXIiNYsLJeezos3M0OF9WkeLjkgLeVLi8GElVG1VNVPEmpwFXes/cqKBA+iuLGsRAsE87K8WZkl09uPrRiGdrBAVdVUQlDiCmxuWu6llxydbKRnP6tDVFbg/rIrwKwiFJAtCLF61DNJlDZ/aGOqzGaLhV5KSMJj3L8CnnC35iTvOZK/TSMByuUcN23AlNhBtB8nCnrg1pARx4/Ys6Epxjjo1HjaPas952DS6UvvweK/lyPRVB5YilkadrmcZMX/oV+3Pvp7RwGkP2mXHg8d2g1jGpOW2ZeA+SUEWK7pHRrsjopGGbOVrmNAoSkq61OLl5gQ0nDVkIveErwnQA2NPkymPmIQmaSsiFLzvK4dqtx3VJm66DteKq1BlRBwZdPih/0e2U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(10070799003)(7416014)(22082099003)(18002099003)(261026140227099003)(10067099003)(11063799006)(261028144727099003)(261102123227099003)(56012099006)(261021121427099003)(261009223027099003)(261021123027099003)(261022105027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkcwSDQvK2FZOENiM2NKVE0xZWN4SzVqNzc1UGVjUGN4S1R2MXhmUFlsZXNn?=
 =?utf-8?B?TTkyWkdacWNSYkI4RWhRMEdhUEJtd050aUhlZ2FCaUVzNFRMS2NDWnJIb3Rp?=
 =?utf-8?B?M1N3L1FNMmpweEdEcFlKRGJqd1pVUm1kVk9RaWRZTTFtNldsT1J0YVhRS0Nn?=
 =?utf-8?B?MGlhd1BTcndjMGQrYThldVRlUkRzamxpQUlTRkcyOGdYaXMyOEs5UCs0TG9h?=
 =?utf-8?B?aGlXdFlMTTZSdDZrbGpQUE9odEVRNFplZ3VxLzh2QzFWM2tuTElScmgwZkJ6?=
 =?utf-8?B?Z1ZJM2FCbkp4M3VYMklaMzRlTkJLaGhETk51d0xEWGNIZlpQR2FVWHpPeHha?=
 =?utf-8?B?TlRJekszZGgrSDhNSkk3YTJTakNwdy9OSkxmNG9IMTVvcUxnb2ptbXN6dm1s?=
 =?utf-8?B?c09aNDZNeG9VS3JEdC9RVi94V1puVkY0T2d0UUJ6RFYzZ2xEbk1kV2ZPamRQ?=
 =?utf-8?B?aHo3dFFVeFJybVJRcyswOGtCYTlENTdjRjE2dnhlVHBydExOYU05cHpLbS9C?=
 =?utf-8?B?REszWk5sdTBJVTdHL1hmaGtvRXM1L3NERVk2cHhvK0c0MlRrUm11OVBBVzZr?=
 =?utf-8?B?NVMvRHVWMFNNZW9kZXVDRW0weC94VXNoeGpsMzZyS3YvZnZTamh0eTdEc29r?=
 =?utf-8?B?V2NSeFdReTBsN09UZTNJM3JURm1hNER6T0tHNWtNNUk3Q2ZkUjRwbFFTdmRD?=
 =?utf-8?B?dFg1MStueEowMGtIb2hFZ281Y25SSnFlcWNsMThsWFZnSU40NzVvUUtLTFF6?=
 =?utf-8?B?K2piWS9GT2Vob2drOFNCank4eVNmbUpQYXNTVUh4cTVERkxTblYwaVJBeUIw?=
 =?utf-8?B?Wjc1U05NYTFwcmdRVi92bDlzQTBJWnc0amdCQ01ERkxydkp2WGlUa20rMEs0?=
 =?utf-8?B?dGs5RmdQSHJzeTRhaUNzRXQwNnk3by9yc0xmVnZ0Y2lwZUpPS3g4bTlab3pC?=
 =?utf-8?B?WXFkaHYrSHVLbDRzMXVxMDE2WmNnNkd2UTZ0ZVFDZmYzUU81RHlYMjFhWVA5?=
 =?utf-8?B?S3BZVFNTMjJ0dDlhekEvUm9yLzgwbjhJSmFlZkNJcnJYdzVzVDJSTm5WQnJG?=
 =?utf-8?B?N0xxZ2ZseUNIRFBjTmJLdmpsNnlobVVDK3BKS0hDRU9iWk5taEdsSmZPVVRV?=
 =?utf-8?B?L1VtMzRLK0FUb1lxemZndlY1cVFmR0RndEZUN1lSUU0rd1dhYnQydWdTRWdq?=
 =?utf-8?B?T3hmQUFpQ0xLSzBDenhoT2N1eFhudlJvUXlSV3ZZVHNEZ1pjL3lLTGhmNkZE?=
 =?utf-8?B?dUp0Z0tJQ2xhTUlrSHRRUXowRVhBMGNxNmNiWjQyQkxkWC8wOGNsVHZFZXJ5?=
 =?utf-8?B?ejMyWGN1Q3M0RmhSODY5S1dRSzBSQkRnY1pSS0FCQ09vd1RQU1ZyTUIrMnE0?=
 =?utf-8?B?cGVsT2RiWEc1QVdTSDlKc3cwcnY1UGhUZGJveWEvYXd6VnUrTXYxbXlJZVBP?=
 =?utf-8?B?UVlXSFV3bDduVWFVb0xnNmcvbWpqRk95Wk5TaisyQnBkNGNBSWQ5WkNuU1FG?=
 =?utf-8?B?cGdoVzd1RmJwVVZlcC8rbWdYQUtHOWNLWDNCdzhJanllK1lCZTdWRkYyNXBz?=
 =?utf-8?B?TXdEN0hsODlZRjhBNUNvTWJLelQ0ckRHWE9NL0xXNDZtZEc0Yk9UcDlTbko0?=
 =?utf-8?B?aGRFTnNMeU9ReXlmZlJEVkJZUkxVRElXVUlqZlhRU21kMXpzMlYrU01iQXlu?=
 =?utf-8?B?QjhLNm55eTIrZGpUMjkzdHhFcDMwVGZPbWp1QWc4dEUvNk9mMzQvOENYVWpR?=
 =?utf-8?B?MHhJYXAwQ0h5ZytjV0R0L2g5ZnFiNmNteENVT0hDTzloYUZFUmM2azBBekZr?=
 =?utf-8?B?S3RxSzU2TXM0R3lTeHlYWHlUUkJwYW5GUVpESzJ3dWFMZml5a1lHMjRoWkhp?=
 =?utf-8?B?OFpTeUltdG9aYjlzd1AweGlIZDRSRW1vNHh4dzlWZ2RyenAySmJZb0tGWVpx?=
 =?utf-8?B?RkN3YXBIVkkyTi9STXVuaHB1T2NFclQ4bnlmWmU4OEtJb1IreTcycjVYU3Nh?=
 =?utf-8?B?VmJyZjBXZ3ZSWFNlNmN3VTJVOG0wQXdwM0lxQ2lWN0RVOEFxcnBRSFhDdkY5?=
 =?utf-8?B?eUdjN3EwNVBXSGVZQ1ZLMDhZQ2pqTkV6QVBIdERkV01ESU1tS3N4Mm0wQUVr?=
 =?utf-8?B?TEt3bXI4TjRrRWtPdndSUFJQc0hqeEdSdzZUNXZXcENYa01DaUR0Q2o5Q0hD?=
 =?utf-8?B?NVNOMXhVS0pyNXl5UnRFMms3RnZSUCtpaEtaRnU5OHRlU2ZiU3J5VGFWa25t?=
 =?utf-8?B?YmVEYUpuY1ArOEFyc1lwbDRkWm56b3BacmtLcDFxNkFFUjAxNTdRQUlmOHpr?=
 =?utf-8?B?UmVaVDE0T1MyL0cvNDZKaEdUOEQ5YnVTY0RPSjJyVERuTmVvVlpENE9TWXE2?=
 =?utf-8?Q?DQxSeVsY05B588DpAEozNgquUAV1FJDNprvdI7BhsKtPJ?=
X-MS-Exchange-AntiSpam-MessageData-1: fH6yBotCD96cog==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 814bea06-e25f-4a9b-232d-08df3fb0b636
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 05:00:31.5624 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VikVYif0tt7LjuQ2lpcaCHr5uXYBmN/Xzst3Cweh7z8b1QiuE/FZRQn8yltYx+cDaAZrD4UjJUsM+Lj+MHCFyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6247
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

On Wed Nov 11, 2026 at 12:27 AM JST, Danilo Krummrich wrote:
> Express all self-referential borrows through pin-init's self-referential
> support [1], replacing unsafely derived references.
>
> Cc: Gary Guo <gary@garyguo.net>
> Link: https://lore.kernel.org/all/20261008-dev-selfref-v2-0-e280b3c8fba5@=
garyguo.net/ [1]
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  drivers/gpu/nova-core/api.rs     | 24 ++++++++++++---
>  drivers/gpu/nova-core/driver.rs  | 53 +++++++++++---------------------
>  drivers/gpu/nova-core/gpu.rs     | 32 ++++++++-----------
>  drivers/gpu/nova-core/irq/gsp.rs | 17 +++++-----
>  4 files changed, 59 insertions(+), 67 deletions(-)
>
> diff --git a/drivers/gpu/nova-core/api.rs b/drivers/gpu/nova-core/api.rs
> index eec69aace3b2..94808af3886d 100644
> --- a/drivers/gpu/nova-core/api.rs
> +++ b/drivers/gpu/nova-core/api.rs
> @@ -22,11 +22,27 @@
>  };
> =20
>  /// API handle for the auxiliary bus child drivers to interact with nova=
-core.
> -pub struct NovaCoreApi<'bound> {
> -    pub(crate) gpu: Pin<&'bound Gpu<'bound>>,
> +#[pin_data]
> +pub struct NovaCoreApi<'bound>
> +where
> +    // `Gpu` is invariant in its resource lifetime, which outlives this =
API borrow.
> +    exists<'gpu_resources>: 'bound,
> +{
> +    #[uses('gpu_resources: invariant)]
> +    gpu: Pin<&'bound Gpu<'gpu_resources>>,
>      pub(crate) pdev: &'bound pci::Device<Bound>,

nit: should we remove pub(crate) for `pdev` from here too?

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>

