Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F13C606A330
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 08:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=SHmGnjS8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 559EA112148;
	Thu, 26 Nov 2026 08:21:09 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010042.outbound.protection.outlook.com [52.101.61.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3481A10E457
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 08:20:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sFZZKR1HmAVCWdXIfTLe/BHgpKcA/UxYvtVm+E/kt7q8tQxkEigfdUw4Yhiqfy5GWEi0R7QsRi6qLth6SDjCpvRhxjp93E5m/ker8grpcBQnyHTvuF/uspIzIocjuvhSa1T/3/haCxqqSS9zIccbaBLhQpglIuNw/+CuKYbG4jypOMmP/pH2oOaQK7ig4XUb6K6Jj22ishr1GlafQizI6SzEbEyw/m24B2NsaU8MMxpmo4hrfBWzKD5iIY3HBz14YILzX+Zv3uAt76NSReaqFUIwqcUItOlnKpbUjjxJ5DzrV3yFk/+QjtvKiW7JLSJ09pDTfu6RxCb6F5YVL5uhwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XBkvksnzZp+cQ/Y/8o03Xgo7RO/saFWcLO6lc3c2+6U=;
 b=Z3YWmYlzoLI0DeiFTL39Of9JLil2YRxX4lKzgg8K33xcUcqxaSA9kt+UPx/2xT+gNZUCkxFbozr0b9OkA0Z4Lg+yJ6k1dmqzHisTyDiq9mp320jfP3h14mBJaphRZKDqPHxJz/pT9SwjzqCvcpDnI3MeK/rYzqjNo0vza3xfpS9dA9TvSdCQl129F3WvbAmMr4FlsaMv9+pOLPp7nJ/+ceY02i2C8khuwCPHalrCqOlCsMUd2ikc0FYJR6T2jjje840WT0oMcC7y25H6XzFfxEmvB55KcsfresVHwxaBfGqPkVkQaPCnI3LBmrbqElFTYeS6XfDq9VwG/ip+1mXlcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XBkvksnzZp+cQ/Y/8o03Xgo7RO/saFWcLO6lc3c2+6U=;
 b=SHmGnjS8pJMMJ4w0TlwqgMgVM93U4Pnul3JcFVmPQMjlFsNx7H7EVlqDKozdAbDXojFX396PItTh/q0vvI66v7i20Q+EJaLAzzV+9E2FzX9VTVL75N6jd9KPvfyfAVNTs6dL0Ka1lRHvh3c2z071HmRwuvUEzFE7Z61T6h2aiXy0LQ9wH+0jiKZklf2dAH2mAZVOatVBxUq62z2XcMH0Es5kDOfckUUH5fZAAdo8yvNtv1bFdX8UujKAtpbdkHff8EEFFINUF2ebitTLft1yNYuF0Iugcl7auI+/aDMs2WccF5IDvjFzZKRY0NPnfa1hmMtUdn6mkPhpCibS43h+MQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 LV0PR12MB248855.namprd12.prod.outlook.com (2603:10b6:408:603::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Thu, 26 Nov
 2026 08:20:41 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 08:20:41 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Thu, 26 Nov 2026 17:20:10 +0900
Subject: [PATCH 1/7] gpu: nova-core: falcon: make pfalcon private
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-boot-rework2-v1-1-99a1dc6c7cc4@nvidia.com>
References: <20261126-boot-rework2-v1-0-99a1dc6c7cc4@nvidia.com>
In-Reply-To: <20261126-boot-rework2-v1-0-99a1dc6c7cc4@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP301CA0060.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:384::9) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|LV0PR12MB248855:EE_
X-MS-Office365-Filtering-Correlation-Id: a042e3b7-fe65-443c-3b0f-08df4b9628f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|10070799003|366016|22082099003|18002099003|56012099006|11063799006|261009223027099003|261021123027099003|10067099003|261026121527099003|261102123227099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: 1NCGnYyOjEIsW2eZtAx4wUyxNooP1tjOj5v00CGV61OmA37HeJjc35YfMvJRN+qpS22/Zmg34Lv9JLCbfjBghLcAsJXHBmMyMi6KKBeuHsubZ84f68mYz6NsBZ9Uq5fSYqzvqkaRedhFD/fmCr5j9dVHVN0GSjmfiy5b+0ivhIkO0RO/OWjkMySHeGRb4jc0Izq6bBOJaGr8wXW3Oc3GSpH9zxnz6ItMopfQTq9KNJunmkQZdSTNfFab7VNzDwAdrZvHMW2ngTCCywrMx0SguDl4LteHMyjWjHTqubXKztHr0RdqNZJgbfUcQdLzuE1gl+GOEXsCuaqoikxaaAebzGXtVQGjpyb4NO4whJYYmOXIKkjXbNkEDrGVPdz2LfHxP2Kp0Ur6EYH1Tt7ize+jnDem/jxNXSwqBLr6W/W93A214AUOIZPTC6oUhCJWfK/1aywGViMcsGJnRNW9Vo8b8jaoWnNvlBRmx2ZgOdenHf0pPmq8NJbT/pIv/G1PD6s7lTenm0WZnv6hi5BF/GrGd5YSh9kINx9MCwZ0LKRnDKOtskX+ZD7V2/cR3SsgX/LQVlDe4Ni3lS+XZAqbQSqykJKMRiubiGvc8qPtsJsdPK3Oq+WwUh9GukXHWQOf4+3lxyUTwpUmlchEeM12OevGhwc4M+x4tVrjCUshm4Aopf0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(10070799003)(366016)(22082099003)(18002099003)(56012099006)(11063799006)(261009223027099003)(261021123027099003)(10067099003)(261026121527099003)(261102123227099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmg4K1Erb2IwTXZPSEFkeHMrVWRSWVlnUFRIVkYzc2VWU0pVL3crV3Q0cjRK?=
 =?utf-8?B?SFFOL3V2Um1ESERJTHpiTHFMM0cwd1lRdzg4UDJOZ2lpaUhQdkxaV1VzQzNZ?=
 =?utf-8?B?cncvYTg2RUdSSzBhZEJMaHVTNno3TE9ocm9NZ2dNZzZTbVQvajZPbWhWRE40?=
 =?utf-8?B?WnF2SUtUOGpYOFNJeHkxa0xldDVlNTFORWVCbXV6Uld2bDJzVVV2QzZhZmg2?=
 =?utf-8?B?U3BWbUk5c21kWHFhSUl1R1VKUGZXU0d3UE1jdGxabUo4QkdYYUNNMnUzdGNm?=
 =?utf-8?B?RGpTdFk2QllNZUFKUllDQVgvUk9uMm8vYVFUTnY3RG0yazdBR0t5NFZ0eWlv?=
 =?utf-8?B?amZHTEkveitpd204aUI0VGJWZUVGQ0RBcnlNSXExNCtWdDIvVWdoc0dUU0ZY?=
 =?utf-8?B?ZEhLZHVJd0dyUDI2VTBuWmovOGEwRHhhOVB6cUtJZ2VaZHh3V0FxRjZxODJx?=
 =?utf-8?B?TmEvcnBnVGZQRmRMMG1JbnJiTjZvNWI0Y0dBQzByT2tvMUhPSU1vWnpBS3J0?=
 =?utf-8?B?dXdmeDM5RWtkVitRbFhkeTJUT0VRalk3bHU5aHlsYnVOUDlveFY0cEZZZy9y?=
 =?utf-8?B?V09XR3ozY09sL0trZlVyemVicDM2Y1U3d1BDYUg1cWJibzFpYW5lRGIzbFRs?=
 =?utf-8?B?MzJXNGdqeDZMNVdkN1RRdXhMOEhRaXRoTlgxTzZrOG9sWGlqbjFFZUFKVzhU?=
 =?utf-8?B?Z1ZwYWdsRzFsa2FjZmJVK3p3WWpqNnpLV3lkWUtOUVpMU0tLd2N0cVpubFVt?=
 =?utf-8?B?NTNudzZTZnNyN3RjL2JSSUN3RnRqdCsxckN5WlZsdTROK3lSaTVnUlphZnUy?=
 =?utf-8?B?OGg5bGhXc0krN1NFZE5FOVp0emRaa1I3Wi9YUTRxaWJXQzJRKzNvTG5Id3l2?=
 =?utf-8?B?Y1Avc3phKzFRbVhkaCt0YVR4emxkajNubFoyN2xIWjYySjdpQ1FsdmV3QzBY?=
 =?utf-8?B?VE1PUVJ3azlzN25zcmdRQ0VLa0lCVGNGZ3lzMzR4Q2lTRjZmdzQwdCtVN2lt?=
 =?utf-8?B?T1VSa2xwcVhGOWNLdjFhMnB0T3JmZlZGVlVydlAxWlZXelc2Qmc5VktXUFk4?=
 =?utf-8?B?TUpIL3FOd2RoaVdZbUw2L21QRnhhT3EwMlY3WTRJOFU5QnVBbm1ORTJYRFlk?=
 =?utf-8?B?bTFLMXRITkthT1FKdGt4YVVkMHNOWGRxbFljZmRPeCtoaHhRcXp3WEJjd3A5?=
 =?utf-8?B?NWN4c3VkN1FKeDNEUmxhMkNyYVA0STR3dVlIckcvaUpiaHN3d1BJVFZtOXpB?=
 =?utf-8?B?Q2d0OWYxS0NNNDVvejR6VlZCQW9FWE5FeVl0MGlVQUNwTjlIVGZSM1FBRUxv?=
 =?utf-8?B?cTdoRC9Sa25xQWNldkQzQVB2OW9Pc3c3UkJONTNITlN3QjYxcXRwN094eUda?=
 =?utf-8?B?ZDYxcmpTZWc4QjFpV0lMZnhTbHRiUzRHd2tORE9KaHFTVTVwaWswRWFMcUZs?=
 =?utf-8?B?UEFJZXVYQ3VTTDduSHZhS0Jzc0pTWHhWeFRNcVNYU2dZMkZuZlVIS3Y1UmVU?=
 =?utf-8?B?Y2lVRHJobmJ1dFREUkpkVVpvL2ZyL2trdlh5TVlxZXNYL3ludlU4LzRhZk1P?=
 =?utf-8?B?aklGUU1laUJzNEE5a0FOelJVOGV5bUtjTG9CbW41cFdYd1pCUjBYY3JEQlU1?=
 =?utf-8?B?RUU4U2pNQ2N6OVR4NFBlRFlXOW1TL1V2V2J1Wm9GZGp2VWg0a3hlMEZFZHNh?=
 =?utf-8?B?dGdnZE1HSGNMK3J6NXo2cjd5OTRucjBZQU81dGliNkZSZmMyTDhET3pndGdy?=
 =?utf-8?B?akh1cDdab25iTUdJMFBFbzBOYzlUY3VoeVFXYzNLakZTMFF6MVBkTkdwNGxu?=
 =?utf-8?B?T1RjNTM1ZmwvSEo3cGdFVS91aHU0b2F5TVYwOHdHZmxoNFNXUmY0VnZoYjVv?=
 =?utf-8?B?THdjRUZ4Rklnb2g0c01hU294dk01akFPTjJOQ242T3A3Vzc0WGRBcXcrQ3Jx?=
 =?utf-8?B?dkw1UG90MlJrRUVJMXRib2dVQVZHVTBWVEpKTlI2eHJVSSs0N2FtS0QxMDBS?=
 =?utf-8?B?RmsyYmJ3RWlQbTRBbXJsM0ZkTmN2NmNKSG01VW9KNXJBazVoR1ZyR1pOLzhh?=
 =?utf-8?B?OXc4TnNhd21YY0V6THphZzJHUUo0c1pWQkUvTUE4T1BVWTR0a0dOR0pBUUVT?=
 =?utf-8?B?aGplY0ErUFFpZnBKNzZRdnloU2dIZ2FEYmFmMU5ZRm5rTG8yZ3lYdkpidTZN?=
 =?utf-8?B?Ti9Kb3ZnZC9GUnZxRkNXdHNqN3NrYm9NU2UyN3QyelY3N3EyVDZiNGoyeWND?=
 =?utf-8?B?dTlETVErTlM4TS9KMTlXK1dKNWwzZzBFWkVweEFYVEhoZTVsRCtXMXhCclox?=
 =?utf-8?B?TThuTW5taEVHQVdKTmhnTUNYY1pNNE10dmRhTmxUQ3pZZlA5WmhPZUlUVGRC?=
 =?utf-8?Q?fqK3H37uD+6bGcLkSrZvET45l6DvTjJxCLTuR0FNWmvsn?=
X-MS-Exchange-AntiSpam-MessageData-1: MsixF63eoviO8w==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a042e3b7-fe65-443c-3b0f-08df4b9628f3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 08:20:41.5675 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nd44HLif6ed6eq4tnxvysXX3DDhHYzm9bTLzHXvTGgp6eU4AoK67um1xEPOeIP3tzWj3qJGXo/fT2A8StXmzRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB248855
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This can be private, so make it private.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/falcon.rs | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/nova-core/falcon.rs b/drivers/gpu/nova-core/falcon.rs
index fb4f1cad867e..8bcc9240d1bd 100644
--- a/drivers/gpu/nova-core/falcon.rs
+++ b/drivers/gpu/nova-core/falcon.rs
@@ -375,8 +375,7 @@ pub(crate) struct Falcon<'a, E: FalconEngine> {
     hal: KBox<dyn FalconHal<E>>,
     dev: &'a device::Device<device::Bound>,
     bar: Bar0<'a>,
-    // TODO: make private
-    pub(crate) pfalcon: Mmio<'a, PFalconRegisters>,
+    pfalcon: Mmio<'a, PFalconRegisters>,
     pfalcon2: Mmio<'a, PFalcon2Registers>,
 }
 

-- 
2.56.1

