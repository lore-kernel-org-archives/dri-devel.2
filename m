Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B010EC43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 06:33:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF26710E45C;
	Thu,  2 Jul 2026 06:33:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Hl+8UXqy";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010044.outbound.protection.outlook.com [52.101.46.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 397C510E45A
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 06:33:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bAHSJOhLh0I6gYOOeJTEslCXVGyEtFHmZi1Ce4DqCI6+QncxbRaNYVinDlEivvWGnY7A160MnL6mZGoelN5pWY7tK05GMFYpwyH+nRZRGYbWPIgFZz6FFGb5Vi9KoAP/l7WmepJRBYDBLFKypJWb0QzfTUBnSMDZ134ayVseHqalkAzmZwzdeFROyYlp8mAzPPTaaiuM/GIi7uv4LuBtmkX2ZuI1LJQsPtohV8atAcyoHCf+pw82SZIdvWOtfbm4EBzmvBUUEZplSfcLYFwizjXmZvvdVy+HVXr94zZhbIC6aOqN/aPGA4LgsYEsX+9prwFG/mTclhY/2+NQVsVFFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q7qqTYBhJNjwEziQFut3xsuQW3CLyW0jnrn9rKpavEM=;
 b=LavcKZa0HvQsJDq3d2nZAVzGWigYjHXHKLIe8Emcz8k827UgERycnoeWuLLpHfBpNw2qerpysokoqKynUbt6OFJQqUJvj50ikmyBjzlcNTJU7ja9WOIeOIrzd/eg8RtoejK2vRkuz5yIJyc58P+PDO1+8LuycCemAE03sjcWY0DYUs8XSQmstFb2YIYhytLi1Zw8GkNClf8CXs8ZD60Ko89AO/3GAphm+SQ7vE+Sgi4kkuDl7n21ekRk1ccdR78wJtfOOEk4BMNgAatAuvzMv8c75S59U0huDxrygm2EBCea3DPHbTH4V23US38OxxUCWjOGqRIVnTf4GRi1BxW8ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q7qqTYBhJNjwEziQFut3xsuQW3CLyW0jnrn9rKpavEM=;
 b=Hl+8UXqyhZW1dZZzXSgK62LYv2vEDTvV8KYG0uL95tnzZiYdkumDMQvPFVC+3HMO2RRppwUSN3mWMWr0ULG3bOK14zNedS0kt+Yo88ZxIA+RohkIaTlbfSzDAGwezpDLgHAdiIhWUkHraTLUSjtfQB8zSN2EatFcZqjKtvuN7bBKiAS+dmIaSfoybeUYshH9zRlpYcF1lRrQw7+EOCyTlBeVTxI2tK4cOD+I1APs9kRXTdrEXAh/OIPoLO6zoHrXwYKuBSYqaCM5yK5ScDr6drXLel+NMZ6pLOZQvo0W5g4X4ivUU1AjKi874cJG+R9K7iadshyM0PxAb3gIPzSnAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SA1PR12MB8141.namprd12.prod.outlook.com (2603:10b6:806:339::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Thu, 2 Jul 2026
 06:33:24 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 06:33:24 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 02 Jul 2026 15:33:20 +0900
Message-Id: <DJNVJ87S582U.1WUB0LYFS3KJ4@nvidia.com>
Cc: <aliceryhl@google.com>, <daniel.almeida@collabora.com>,
 <ecourtney@nvidia.com>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <deborah.brouwer@collabora.com>, <boris.brezillon@collabora.com>,
 <lyude@redhat.com>, <driver-core@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v5 12/19] rust: drm: Add RegistrationGuard for
 drm_dev_enter/exit critical sections
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
References: <20260628145406.2107056-1-dakr@kernel.org>
 <20260628145406.2107056-13-dakr@kernel.org>
In-Reply-To: <20260628145406.2107056-13-dakr@kernel.org>
X-ClientProxiedBy: OSTP286CA0085.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:227::7) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SA1PR12MB8141:EE_
X-MS-Office365-Filtering-Correlation-Id: 350affee-08fc-4137-0729-08ded803d15e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|23010399003|10070799003|6133799003|4143699003|18002099003|56012099006|11063799006|22082099003;
X-Microsoft-Antispam-Message-Info: b7T+VeHLpg/jEZoZ+QeO5yDiUBxMm+sYiwsmWl97qWGX0QSwdHtp2nOdTdz0xKyU2+xaxQv+H5aQ/caTSBRIFpXA16yc2yAm7PX+fo7g0uyqIkKJyAc7nw2sX20lX7xvXzHn0v6+jYGlooV/4Rjp31lWSmv2xjvi3Pld1Rs2bpekYQgQcHHsxnbPkHYCF4CI01CCVajn2sPkl5rgE94mQQqS17V3+/ztGoJ619xnfw7LI0ttyjaVUHs6nfpoSrLcjC1amplkPXfnR+5YL0dmHfid1UnYWmTJzhP2CkAJ+WwzrQAknyZwNRHX88L8WuxJZDZM6Hz8Y1pKvTpGoU1v1T+jkH1CDRGVNYUQYO0X2csQy5h1lpj3jOvD6KY6BKYT7Hrqf4jjGtjIFhan2WfHX9Yo81CU1X7rPVA6uByB4U3R3RUPXwNZId3Ytfli0YsGabwXKopDYMBihWUQz0obpF2SkKMv6o8Hve4aQPIubsisvk0JBM0Qx+0O+bozfvo2pTvZrpSjeS00g3kT4za8/2C42OTynV1yfzCrvfdCqXcg+/1+aOOllo7BjPjR8hVggDgHZoWdFFcEyQj1XzqidLXqcrU50MKNSz/I/D3j1y6cAVUZzAK7C4t56yj268OW0xx2sD2vqixdHMx/iRPGImsL2PgN9hj+4Fi0X9J06vM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(10070799003)(6133799003)(4143699003)(18002099003)(56012099006)(11063799006)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnRsS1gzcktoejVqOFUvQnZweitYZzN0YnBoMlB4NjY1QjRab2VUblAzcjU2?=
 =?utf-8?B?UWVqOVhJNGN6ZGhBQ3FrTStqWm1XRTd0M0c1aEZ0N3lKODcrcElUMFMvU2pI?=
 =?utf-8?B?ME51ekZhU2ZoVUNRM0E3eDhRZEVzQndNeU9meXQ4dm9SNGpnbjNySVg1N3dK?=
 =?utf-8?B?Q0J4azRMNGRGNXRURDNFMkZBMHdXZGZQZEpNYWYrZXVFQ0Q3Q2FGZVVVd3ZY?=
 =?utf-8?B?Q3Rlb3pyWnZBQ1EvdVc1MTdXZ1prbmZhTFc4MGxIYUlSVXN2cTR0ZzduOTJp?=
 =?utf-8?B?VWQ0NWdSQUpxZFFEeXRKdG1mNnIyNlZYRzlBckpFMGVudVl5Vy9welJTeVI5?=
 =?utf-8?B?WDRtRS9LWUdkOXFjeS9TVkxNVkE3Y3BOaHVzTnhWTGNYNkdRUXNoK1VLWFpK?=
 =?utf-8?B?UGN4WkpxV2dCWXg3S3Z5VWpRU1NzaUpsWEhMdTd0ZHZXZld6YWNQM2NnTHUr?=
 =?utf-8?B?R0pBek8zZ1NtelVYLzExWGk0MS9lNXZ3M0MzbnVQWlByK09LRHNDNW0wUnI0?=
 =?utf-8?B?dDk5eXVnY1ZNNkZxL3dPTHozL3ZOUStmNmRrNDY3OHN0SUQ1MVFKQkVscUJH?=
 =?utf-8?B?cFZ2UEtteHRnM2JBU2dhVE9zUWJjOGxmVHVBbEFCOTdXZ2tPay95SGFlUlgy?=
 =?utf-8?B?dUZMT3pkOFRRNEVrNHoySWwrd290Q3RRMXh3U3lZV2lua2VUN1hDZ0VSdUFC?=
 =?utf-8?B?OXBHdWV4SDdVRFNIZTRyeTBUQ1lGZVR0cExKQVJJa2xCWGltZzZ2a3VIcnNs?=
 =?utf-8?B?ZitWczZjT1NzVERUdU8yMkQrb2NQZEZBajQ4VENtM093VFpyN2RZOWd2eFVw?=
 =?utf-8?B?dTJpV2ZSSGYzT2VnNnlWNHZRRDltSjZvd2RUdWkzU1dnRnRzL3BiSDJJMm4y?=
 =?utf-8?B?ejVZMi9rcXZHTnBqMDA3ZnhKUURoaVd2N0RrRXFKdm1sUk1kUDErcmdsTG9F?=
 =?utf-8?B?S1FOWWt6UklraS9iaWNZMHErVnYzUFhueEV4QVZFSzdoWjN5Y3J6clBkTkpn?=
 =?utf-8?B?aXkyUEFWdmxvRWR6N1prUjBKMy9VZnhlZDBoZXY2eWE5ZE40M1VKd2lyOVVF?=
 =?utf-8?B?WmxONWZEREloMWs2aERrQWN4ZWk4MHMrUFJXa2o3cisyUVZDa1VQQm9sQUZr?=
 =?utf-8?B?b3RsRjVoaVRKcmJsbWdKTE1UelF6Yll3am1NM3hKcktaTDFrUDhXbjY1WVo2?=
 =?utf-8?B?WWJxcEpPS05iVGxKdEd3YXNDNVRWZ0F1SnBVUU9FU3lML3JWeDRyVDBOa1Ar?=
 =?utf-8?B?VWVrRDlGdHB4RE4xb2hHMFJremNVRTdRREQ5akhBV0JlcEdQeHlsT292NW1B?=
 =?utf-8?B?VVdnK1hJemNUL2xjNVRNSThacVpoeUx6V3FnYU95OUxrTFAwZGd1cUlZRDFj?=
 =?utf-8?B?V0R6T1RkODBDN3Y3eWcxNjQzWEpseTdqbEpuNTNnbUx1VW5hYVcxR0VwVWJQ?=
 =?utf-8?B?RkFUVGtXdWJnOGpqd0lEektGdjF6MDRvV0dxVDZRcFg4TTdGQXVRdXF4ZzBL?=
 =?utf-8?B?MWtPKzJ4SnhmcHpOeWVhaWJVYjZ6M1ErL3d0Q0FZV3l4TittSWl4dnpUbVFa?=
 =?utf-8?B?cXYrYkl6a2dKUXRvWFkrWSs3V01odUpIVzRzc1UxTmZGYVVDWVpCNWRHWGVM?=
 =?utf-8?B?dVN4VHNTVlBUeVRQbG8vTFdIRnBWc3VLcUJ4Q0orano3MGRIVlBHOWtZZUsz?=
 =?utf-8?B?RzVZczBSamdwdTBoclpmSkNNakpqaDBDUmpndjNLd3ZIdkM2dHRQcWFuOXFs?=
 =?utf-8?B?dEFyZXRlQVVtOWFWRElXd3RzL0doRytOYVUwUExhMHJXUm5JWkRoTW1yMHIr?=
 =?utf-8?B?UVYzbkFSY2tDSWd0THl5aG4rejRIS0M4RGMzUTJLdzhURjNWa0QxSlpDRHhj?=
 =?utf-8?B?NHBma3lCbXo4ODZYNW5MdUViME9TalF2WFlyRFJvYW1qTmNrREVXUFhDU29F?=
 =?utf-8?B?N1RKWUY3aEVmd25YTU42WlFGQ3RNWHNwamtTWlhRalJvUy9tZ1NXRzNhU2Vi?=
 =?utf-8?B?c1F1OE44ZUwvYzl3TUxpU2VsQXdicG9hSmVtNTRDTHlEV1JRb3g2TUJBZXdh?=
 =?utf-8?B?ZjdJclMvbkh2ZDFaelVLUWpGdzArOUROckduTlhqQ1RTLzNidzRjSlZvWXZp?=
 =?utf-8?B?MjBwQWZpM0pEdHZMWlFpOEhBRlpaQStjRkR0YldLN1UyMXpnemNrbDdtVzZU?=
 =?utf-8?B?aFpUWitYT0lkMUR3V1owejdBY3VyRmlvcktlLzNjNjBWcm5ibkEwYzFEaHlZ?=
 =?utf-8?B?dnhSOTdOZURpcFhlaWF5STJnTEl5cmR0d3JEVXNwMWlsUmVQbVoyYkh0Y1gx?=
 =?utf-8?B?Z3ZYeGxxclFnUnZhcnIxVUdDTERSU0ZKcFFOYUVhWG9ycXF4WDdaZEFTamxX?=
 =?utf-8?Q?c2S+nthTFCIDIsgP3Ar2tScifKFcY/DoUI0y2oV0wCrS0?=
X-MS-Exchange-AntiSpam-MessageData-1: g2ufsL3orQ6DwQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 350affee-08fc-4137-0729-08ded803d15e
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 06:33:24.4089 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1N/JGY3G5tLSHnbABk16uY2d4xCHR6sVAcbZqIs83DX/4qgKglC/BIE3KcmANuIhczs0BGnRXL03ptdvgG7JtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8141
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

On Sun Jun 28, 2026 at 11:53 PM JST, Danilo Krummrich wrote:
<...>
> +impl<T: drm::Driver> Device<T, Ioctl> {
> +    /// Guard against the parent bus device being unbound.
> +    ///
> +    /// Returns a [`RegistrationGuard`] if the device has not been unplu=
gged, [`None`] otherwise.
> +    ///
> +    /// While [`RegistrationGuard`] is held the parent device is guarant=
eed to be bound.
> +    #[must_use]
> +    pub fn registration_guard(&self) -> Option<RegistrationGuard<'_, T>>=
 {
> +        let mut idx: i32 =3D 0;

Forgot this nit: since this is used as a parameter of a C function,
don't we prefer to use `ffi::c_int` as the type?

> +        // SAFETY: `self.as_raw()` is a valid pointer to a `struct drm_d=
evice`.
> +        if unsafe { bindings::drm_dev_enter(self.as_raw(), &mut idx) } {
> +            // INVARIANT:
> +            // - `idx` is the SRCU index from the successful `drm_dev_en=
ter()` above.
> +            // - The parent bus device is bound: `drm_dev_enter()` succe=
eded, meaning
> +            //   `drm_dev_unplug()` has not completed; since it is only =
called from
> +            //   `Registration::drop()` during parent unbind, the parent=
 is still bound.
> +            Some(RegistrationGuard {
> +                // SAFETY: See INVARIANT above; the `Registered` context=
 invariant holds.
> +                dev: unsafe { self.assume_ctx() },
> +                idx,
> +                _not_send: NotThreadSafe,
> +            })
> +        } else {
> +            None
> +        }
> +    }
> +}
