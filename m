Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3F6606A325
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 08:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=MYbvhtfl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7570110F2C2;
	Tue, 27 Oct 2026 08:01:56 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011046.outbound.protection.outlook.com [52.101.57.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EEFB10F2C2;
 Tue, 27 Oct 2026 08:01:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iEfMxrUuAx5Coz1Gdhp3k1tICL4W8nLfZzM/LcAGw1ZomeVnr3GfjmVVWtVmH4W1NaQD0DjMuf63Ou5HpqYiqhKfwkIZkga0mArq5Wb27YATiQZTCTYtSmZLjQUC8+aWjqW8bRMBVEPetjVURzOjqMHhDjBrG+tbf4nQ+BB3xMY8kXHqIPbeSRasgZiwJ3GX1bK/335A7C5YLq0chfgaA+ZqdnQD3mqs5mm3K050NKTuvZcCKpZHautipJAn5uvTimtl/ly7d4tqYxgi1alECyHlL50j8D3XrUZOD3TMp/XfgRRR2Ckjs1M/gNIv4rDVVEaPXjgggizmcXNRxaf64g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y61Sbqy0fqJ7uPcPqzjvwLUWsxXIkkNfEEbjMBRS80s=;
 b=qyhTtD5Tzo8O1RHpPzBA5Cowp+GsIyuDmuSepWDfOGS4PZ6JD7FhpCuzNPyXEkXHXcZKoZJo6EFbqJp/oZtjZLN/oaV+gtj5NQ5hUJCzbXPOxKRvK1YqB46GA6jPBuIcaaUbZZinLy6wqnaiY/jX9V9viIB+qbSSHBPMbLdgvo0p9wUvSLTGhVagc6FeuOVtmy+KWY5eNlbznYJvo+4vPKjq9WhDEqfx9DtgM7cVFMnXXw3NLujT0W3IfAw4YEUFCuRv1v8DogdJGoII4BD72cGvbwrDddMyEYLw+dNl4OYQV3CAgbPQrH/HU+shLGq36NBivXmVcOO/rVm2dgYlUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y61Sbqy0fqJ7uPcPqzjvwLUWsxXIkkNfEEbjMBRS80s=;
 b=MYbvhtflKWtZ9eOq+karAeshCb4h23IQ/7y5TlKw11PCG13OC9U2iFjYUxoShJh2egLjmxTGOpwlyJyr0J06ra+OXOL3V6uCRKvqX7Q+r1uP8VpMb6/qhWRYFMHXBNujJhnay8wHcR9MKt5czwT7F7VbhoAVRkdWkBA0pGMeM9PqW8RzPeRy9pQMTzPGxoYSxqwesXtvg1BuSDR0ccaGhxjUtqRc6e20Y0LlGDXE1M4EuRDmU1ra1oj6uc/VcTZhtpP0ImsfZrA9AYZdozCR2mPE68vtUFL3fcw5piZADrMdKpAsB1JyrH3QykqiC/8F3WIZMMNASgCvfN8UKKGKhQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 PH7PR12MB6659.namprd12.prod.outlook.com (2603:10b6:510:210::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.22; Tue, 27 Oct 2026 08:01:44 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0546.016; Tue, 27 Oct 2026
 08:01:43 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 27 Oct 2026 17:01:40 +0900
Message-Id: <DMFGOLKMN5B5.2R9D11QN25WPS@nvidia.com>
Cc: "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 "Eliot Courtney" <ecourtney@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v6 11/15] gpu: nova-core: gsp: cmdq: do not sleep when
 waiting for a message with timeout 0
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "John Hubbard"
 <jhubbard@nvidia.com>, "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Benno Lossin" <lossin@kernel.org>, "Gary Guo"
 <gary@garyguo.net>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261027-cmdq-rpc-v6-0-bed9669724ba@nvidia.com>
 <20261027-cmdq-rpc-v6-11-bed9669724ba@nvidia.com>
In-Reply-To: <20261027-cmdq-rpc-v6-11-bed9669724ba@nvidia.com>
X-ClientProxiedBy: TY4P286CA0065.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:371::7) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|PH7PR12MB6659:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a9eeeea-03a1-49a7-b742-08df34008a56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|10070799003|1800799024|23010399003|366016|22082099003|18002099003|261026121527099003|56012099006|11063799006|4143699003|10067099003|261021123027099003|261022105027099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: CJoo/AwNEgDs2BwLE+8jPe53sLk7LggqrI3c3+qmLWYQPmVZMlO60OH8KceU3akY9nNdxzaiWBpSvyTRQ0avdLy2JBO64oRQhPB4o0bjFayotySvJV7v96SKS7RzGWvm3AB2WfRkEvUjUM+/c58sljULRSKDPJ45tJJXubKuLdFPOl2qMALUySnkhhOzq6rmun1/c0vK2wHwKJKlX/RSjLN9YB/LvnkBS+XBo9+3BtWl5MAWBPzmrj8Q0jl6piXa4le8IjfvfY26AkGWcqwnYyIlpMsVADErT/uVF8i6Nhn48Q8p6cdHwmocrFYVvwAxcChhH0muHpz4YQ/ZdzTsrSiyM3bpkjgJShr4SXvic22nkhUwApLcxI41YLDAy84EREv23/5UkeUxknB5mdupiSuvBe+dapYglJbqtkT3+qddha2ygTsGuQVrm6H4LkMzU8kACVFGrHE8qPeBL2oxWOQZczEWp3QsCdxYvMTRI33rAt3nYGKYBtWQUFTlwI2LeZHYAIRjrnOYGhqUYaqQqoLSZTxhTeDlT39qwoB1irRP3v5PPqJ6GZBufoYeTG1AGE0QNeE3d69VUocoHGYLVWyn5y+/suVdj6yZd2X/c5QKWMLL9/Gg2Sef+j8hZjs2XYtGy73cbKek7d+Cfm2MmaXSl+EG3vDTynQdcj2hRU8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(10070799003)(1800799024)(23010399003)(366016)(22082099003)(18002099003)(261026121527099003)(56012099006)(11063799006)(4143699003)(10067099003)(261021123027099003)(261022105027099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUdsQzlkU2wwTUhrYUdraDFIMFFJZkV2YjN4SUN5RDJZQStpeEloYmp3T3FS?=
 =?utf-8?B?NzR2Szg0N3pvdjJaSzY0WEdKc1Mwb0RLZ2ZJa2pIcUdla1lGS1NQemhPU3BX?=
 =?utf-8?B?eG1QYThGZFAvUlpVNGpHcVdqQXlVYlFjUzJXSkdSUWFGVzlSYjFjdmdjNXBQ?=
 =?utf-8?B?L0VucFpjQjRiRU8ybXd4ZDBKa3Q3OW1SalZOWnpmbHBOakNlY1EwOERFdkJL?=
 =?utf-8?B?VHNyaWljU3cybTRZMFFCemdFd0dicGxaQVYzQ2lWdXZsK3dPanJzVDUzVUVa?=
 =?utf-8?B?T0UxOWJoYWR6NHd6aFljMmZPT09jRGhQNTlvRVNmQ2l5K0NyWDNhZlNyRHZ1?=
 =?utf-8?B?MFlZdXVFczkwYXE2UTRmNHdBNkZMRVAxQ3pwVzlMU0xwVUlrVXpFRkQwa3pT?=
 =?utf-8?B?dWpMN0oxa1BxbHF0V1lrOTB2Rmo1dm1wU2FBamk5cGdvTCszNTFUUWt6elVC?=
 =?utf-8?B?NDUvRHZzY280czZvS2tTejRkTytOZFRUU2NPYmovWTJxM01Rdy84SFQ4ZGlw?=
 =?utf-8?B?cEdFN040RHoxaUZnRmlEbDd4dTcxaW1XeWpNWG5vVk1hKy9JSGoyZE9BcWUv?=
 =?utf-8?B?dFhkcStTbkJTNmhJdWFZNjBGOWhFVjhTRFlKWG4wY25LbUx1THJCeGx3VlY4?=
 =?utf-8?B?WHZKdml3QUVmdDVTTHI1bHl1S1M2R2N6MFR1TzYrWlkwQ3lTYUZQcDNNZzN5?=
 =?utf-8?B?MkhsQThUcWNXK3hkeGpqaWRQQmM1cUxYZkRNSG9HOThuOVBkN1pxZjNGeWRO?=
 =?utf-8?B?KysxTkM1VkVvY3pMdjQ2UFRzak42QVpXK3VUZlVJK0NINFoyU3dQRDUzakxF?=
 =?utf-8?B?QlNmUFhrWmpGcml0OFlzM2hTUmJzMjdEM25ZUkF2Y1B1QUo0ZXBxMTRLRjkz?=
 =?utf-8?B?M3ZKaFVGMTZST2FOcFJZc09qODMyeDJCZU9jMEkwOC8wMkF2MTExZXJ3d0pO?=
 =?utf-8?B?TzZ2alU2dmhZcmxQUE55cmhZQzROSjVyQ0RmU3M0cGIwaXovdXZYWGZFUGwy?=
 =?utf-8?B?UFNzUHE5d0FVVkEwYWQ1dUNoeGg0SkZ4QWs0UXRBaURnWmdFNmpscGpEL1ZG?=
 =?utf-8?B?RFBWekh6YW4xWGVaRkxST0IraWI3NStLTGpQUGxwR09kTkEvM1dsay95K1lp?=
 =?utf-8?B?ZW9aNlFjZWEzZ3gySFhLbXMycGljY2xCa0RXL0tIcnltaDNIYnZXMkRDSkVm?=
 =?utf-8?B?SEZvN2hmNncwMjJJb3pFTU5vSVV4SWRJcEFDeWRIZERhakJ4TlZzYmJhdkFN?=
 =?utf-8?B?MDh0Q29VUnhvejkzVG96NmR4OFA5NDRtYzAvMllLeEx0ZFhwV2dxdStnWjNQ?=
 =?utf-8?B?cXpTSTBuRG45NzJ3Y2ozWFRuL2l3Z1NrRnRNQkd2MU1za0czc2lDMlVhMWdZ?=
 =?utf-8?B?RVZUYUgwY2h3ZGp4bUhKaGhaT1Nvcmg5VWs1RlFJS3Q5MFJwU3A4dHlubTRE?=
 =?utf-8?B?VW13Z2xlbnNDYVMxOEt6aDlXTVByb3BNOTl3UXJuVW5vTlRTNDlWeFhURHd5?=
 =?utf-8?B?OXlTUUZwMW5WdzZ6Ym5JTE0zSjIxbW4ralh5SUV6dW1oQTZXZFdleFRFYksr?=
 =?utf-8?B?N0NoQytlUXpVQ3hiZ00vc0lIUHVjU0U5Q1hKQXJPUXFENG5hNHhtM3FXMS9H?=
 =?utf-8?B?Slo5T2ViOW1GeUt4aHNpSkJLY3BMaDZIaElTa2pBaXlGclBXNjFIdGdVck81?=
 =?utf-8?B?YVU4cW5pRGEyOUtwQ0Y3VUVwaVJ1M2twSnRzRTRlWlByaFJoSlBON2MrT0R4?=
 =?utf-8?B?N0FHYUtjdWdZcTR1dnUzR2pJV3prbS9hc0huZXpkK0psTW5TRXNHUWR1TGdv?=
 =?utf-8?B?bzIraHl0bDFlNzZGa3B0NDUxeFh3Tkk4dk9JSHB0NkdlODNZQ2hUNmFrS1hD?=
 =?utf-8?B?MmFrL2UrazV5cXV4QnVPY0xKU3h5d0l0WGJiODRMaHo3Ynl5djNJd2dIcTZD?=
 =?utf-8?B?SlNDSTZ1a3dqSDJyNnovdUwwbzdhM01ndXJ4Qm9ZWEdzTk9nZzJ6dFhCeUQ3?=
 =?utf-8?B?OEtobVZ6eCs3L01qZEk0MjBLQkZrVlNEdDVaTlVEWEVhU1VxU21RUDUwY3RU?=
 =?utf-8?B?N3FLK3hKOWg0azVWVytQemczcEM0bHpVc2wxSHkvNytORUVvZWNXbHovTGZt?=
 =?utf-8?B?OXlOQ2RzckdoZS9oa0I0QTQwaGFEcWk0TzFFWm5PWUpwRVJMQVljaTJDRDFT?=
 =?utf-8?B?RHdibnd0WXpGK0hlTnI0UmlKdW9zYkdZWjFHZFM2YVhDejAyZ0FEVnZGWnVr?=
 =?utf-8?B?eHNaOVhlTWs2OXBMaGdqTXFjY1p1NGlXY3RvaXVQQXR4SnlnTnl1eUd0VjRY?=
 =?utf-8?B?am0rUVZQOFZXc2c2Z281ZDgwVWNBNFVWaUFXa2JJMHRqamVuNkZzMnFva05o?=
 =?utf-8?Q?uVs+9P9Cnd6hEIrzS/F9TIloJR7PkesoOoMax1o18jF7N?=
X-MS-Exchange-AntiSpam-MessageData-1: OVL5KP58HRi1Nw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a9eeeea-03a1-49a7-b742-08df34008a56
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 08:01:43.6759 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4DOPUk7wb0LKM8ArI+2Vf2PDqmpEPehXlJ9ZdG/r/uHf2ej7ygco+0Wh470XJr/WqXMV6bEwvKqkRRcIcyIKpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6659
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue Oct 27, 2026 at 4:35 PM JST, Alexandre Courbot wrote:
> `read_poll_timeout` can potentially sleep for the specified
> `sleep_delta` if `timeout_delta` is `Delta::ZERO` and the system clock
> is coarse enough to not register a tick between the time the function
> has been called and the time the loop test is done. `wait_for_msg` has a
> short test condition and is particularly vulnerable to this condition.
>
> Add a dedicated branch when `timeout` is `Delta::ZERO` to perform the
> test without calling `read_poll_timeout` and avoid potentially sleeping
> for 1ms.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>

