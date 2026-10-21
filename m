Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841E8606A325
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 12:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=mBGKp5kA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0148D10E028;
	Wed, 21 Oct 2026 12:30:19 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012042.outbound.protection.outlook.com [40.107.209.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F8DC10E028
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 12:30:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=voq+4SSKGnKnIEtFZ0bvl0Ynk9FN6hwJggjCt5U7d+dHwi08oPwlV1Ej9hIpmzjP59E8QHGZRTvQEJmXiiO453qHcrptJJ2ED6Z2OZvdz0Ad9X1yPFVF5ieK15wRB5V1He7xJmG1GxKVF/LlPpD/XjbZfNFdWgM6lW3OFVxdmoDTAbnHz1+r65tDUdqp6PAEuicV41C1V3IPWiUvJK/I0CVWYmLHMSg3mE4l3f1t1A9FqBuJ90MjVfIzGkIRu9077Einyo9IoxX+SuQ2C7GhHvj3lvfsUm1kaOJ/sy3IM1ixz5Bk2WK0IpS7IfduKQnzTtNG1BPZhB9dUdNXw+zlYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VEWRu2YORSRHCBA0zKhhVZJJpxuYIQQdQ9z2QtwB5U0=;
 b=aIuYo62TncLjGJgVXReNPfuv3i3pSdgSR+szCpFqZRZcoUqvKHnkMr5tG3qfOLxbzAsFTLuAp6fJayxf5CAJVaP0tPwwumoQUnesqSB+52xMtn+PhtEVsI4w8uOwiIG0fNP/eEXsko5lDygGBvAcw2KQCQJQ0HlSQPP3wMAKgqXYjvCa6dx2CaFxzYoKG39b+hBWdgNcEZv3/IJ1z6N2tD3D8KPI2lnrkZyapnRDLYfzG2ygs+P0DLJ2C7z5UEL+jSBu6c2/CNbJFshdE0pG85cGZJVgIf5E4Hgsnruwgm07LA6lAcCSIfBEnNS53ZPxoRCRbKTNX5wwroPl/2LY/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VEWRu2YORSRHCBA0zKhhVZJJpxuYIQQdQ9z2QtwB5U0=;
 b=mBGKp5kABZ3KRClXpSJD/CD33OSdXf/SUOVF1I8o8LrvH7/3CqW5vpAdiFwqdP48Y8VNIZ4ecwR6FE06iIHhDw6Uf3HB9m5bz8WIJ/sWa4zXRRIs/ImrJ6SUYJaJnu9nwZT9iyDCmkbEvPeQl2o0O1Rz19Unlg78wZ0o9VtLOT4IU9bTW3qP5Y5/WBRD6MdFwz1dNAkYgWq3WI2nZhQOyxQmxV7XJs+PY1Pf4g/vT7+izi05nSA9JOdFEeG9ookmrtRIxuY8cnKCEf7Lyyvw5i3UUoDvSnPsJsi/ZlwytdYhhUIfepAVlA+VHQQZHeIElH230ujkEeb2QVdfPETNyQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by DS0PR12MB7557.namprd12.prod.outlook.com (2603:10b6:8:130::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 12:30:05 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 12:30:05 +0000
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Oct 2026 21:30:02 +0900
Message-Id: <DMAIMT058878.328POTUHV1SK3@nvidia.com>
Subject: Re: [PATCH v4 1/7] rust: alloc: add Vec::try_push_init and
 Vec::push_init
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Lorenzo Stoakes"
 <ljs@kernel.org>, "Vlastimil Babka" <vbabka@kernel.org>, "Liam R. Howlett"
 <liam@infradead.org>, "Uladzislau Rezki" <urezki@gmail.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>
Content-Transfer-Encoding: quoted-printable
References: <20261016-b4-nvkv-v4-0-e8b92b91aa5b@nvidia.com>
 <20261016-b4-nvkv-v4-1-e8b92b91aa5b@nvidia.com>
In-Reply-To: <20261016-b4-nvkv-v4-1-e8b92b91aa5b@nvidia.com>
X-ClientProxiedBy: TYCP301CA0056.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:384::18) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|DS0PR12MB7557:EE_
X-MS-Office365-Filtering-Correlation-Id: a85ea011-0802-4f64-1621-08df2f6f0923
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|10070799003|23010399003|1800799024|10067099003|56012099006|22082099003|18002099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: TiezXLUOquQ3jUIXixrXoAt0lgdCUvPpaMj10Q73e4aLVyOFRrBO4oQs3RWf9zSYUmSpUK+hGHySDTy/s2zCKeGHg17h57JsLU+QCUbuRyNYe+PHdkoN+HqYh/eNMqRbBIBi59UIQa7vkI+HTRzadSK8meEwh9RS0DX1Ps4BxmgAX8HiN9eAKR/CvTiL2I3UJY6X6qZHNkyP4j/UmiBuMyyefIk7PjKx6BA62oIovtn+LDXi9XsgXZEmAqir9aptrH8ZlLna3gPMGcGqpS5qAOtVp7lltM7TSvp6ExSODMjTMpoGl6fqFOUj3W6p92ocCam4VUGHxn4BtUGPnQgJWS9BjWxvw069tJ0kYuVnZ5t2EHc7Tz+JP9cvvrZ5qNm5LvKVilMdA4Y4HCnL3ZNx01FT4HB5UaFmpMPEjJ6K9LcvZWJEo4EJHeXPx9HRbDQD57pchzY0Gjm0bLujjxxna10JwZ84tG57I1f6uwdeJqaTn3hGHhQhguosXgw0OF6rGRggCoBXbdeBeLaVJzeoVxGsXljUdlJaa9YSugPTB4Aam2cc8ftZs9OVjJlVADGq3r0ocxM8Jt9srXC1+f4A0gl8tFrxLlFqGpnJad60G9g6hKS7scY9zDr/oXGuIBLvt5cB62S98w7SvkrrMunZV2hNYl4gzY1YfsEfov4Z5Sc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(10070799003)(23010399003)(1800799024)(10067099003)(56012099006)(22082099003)(18002099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGc1c1h0dXNiZ0NrZk9la3BCRUt6cUVJM0loR0tybVhCN05qTTFBbnROLys2?=
 =?utf-8?B?cmFGYWhXVkZCbEJaVzE5N3h4a2J5aXlhamppTnhVVEt0d243UGJ4OG8xSFdn?=
 =?utf-8?B?bFRZNWpSbURzZC9QT21YNlI0R21mVFdQb1VsT1c5dUdPcEhyK2dqb3orSGZv?=
 =?utf-8?B?VSt0Q29HUkdCVHhnQXQyRFlZUnlSMkZ2T1dvOFEzQ3ZIZVZQb3BoK0IxcEVR?=
 =?utf-8?B?QUo1TExSRDB5SEN6WDRzNDJnUXpsblRMQUNsbnBkdHhaSFFWMSs2cGlVQnIv?=
 =?utf-8?B?Zzdlb0NLWUhjVjFKTFdmYy8yVGRzRnRPbmhwVWxjcys5N0tRK3RYWG5wSTFk?=
 =?utf-8?B?MTIzclkxeWxVZE5kaFhETytlNnR6YjdwNGpxN1ErTnB6S1dlSS9NMVA4VEYv?=
 =?utf-8?B?bE5ZakNNZDY4N3AxeFNiZWNscEIzWk95MU5OemxFemVVRThVU1YyTGpoZ09i?=
 =?utf-8?B?RzYremNRQ3FNWlNtWTUrQ2RIdnhpK1llci8rM3V2dklBcTJtbGVxckpTWCt1?=
 =?utf-8?B?V2cxaVpqcW5GZlpoMjcvRXFZVWhWWmRSYm1UUVpsZXBSOUtXOVRKNDNiUE40?=
 =?utf-8?B?R3BRL295WnkvclBadWRtQkd6eE9TREZvZHlFdlVlb0c0Nkgwc3luekZxTk81?=
 =?utf-8?B?YTZaZDhMZUxKSzVaa0xTWmg3OEFwZWxuTGl4cWlGR0VjRmxwL0Z1enVBbUtK?=
 =?utf-8?B?UmRsUW9XSlRYNS9pUUNrejBtWFJ3MUx3YVptcnFmUTZmSVZ6Z1hRR0p0a25w?=
 =?utf-8?B?K1NiYkhONmxXWnRaaVJPVDl4WVdIdStCVmVLYnNMSzUxRWx3QTZsVFYrQ25a?=
 =?utf-8?B?TURBWk4yWVpvay9tZTl5WGRFWi9JY0ZuQW4va2dZT3lLR0ZCWlprRkhkbDJj?=
 =?utf-8?B?blBVcnpabVZqYklzVUprZFB6YXJ2TStoVENTMllhdGFINXFTWTU4VmRRdHJG?=
 =?utf-8?B?SFBYOVRjRVNoTS9hOUZRVHZqNVZqRFpBcWNuTXZNQXZSUXVWT3E2VEU1b3J3?=
 =?utf-8?B?bldteGZpYjYxWm5HOFpZMVBZVzZBeGZnQThHMXdvK3pabTc0QjZ2WVZ0TVhB?=
 =?utf-8?B?eS94anhhV1pFVVlIK0VwdFFQa1hud2NoNGE2bjVmOEVPTnJqNWJCVWJqcm9D?=
 =?utf-8?B?OWJOMWx3V21lclYzSS9FODBCdnpUelBlS0cyN09EZGZ6RXBZU1FRTGJzRmVv?=
 =?utf-8?B?Z0ZvK01xY2NjYzdUMVNzK0pTWEUweG52cUducGkwaEFSN0wzNTdodW91UkFo?=
 =?utf-8?B?MGpDSHl0ZWZlNi9FTGt0WDRLUVBzbFdKNHIrT2IrQ3hSQzRhdnUrK1lLV3dh?=
 =?utf-8?B?bEVXdHBPTWZTMzBTMmNWbnlXa3ZGc1VuUDFIcW8rcGthS2dxWmpRK3hFMTl4?=
 =?utf-8?B?T09xNXRtZmtKdFZPeGRUR0ExQ0xLRkdieW1NbW1USmVFdWduUGR2Tm4wa0ZW?=
 =?utf-8?B?UXVIWEFNbmh0QllzclFWUnRuSmlpOGlYa1EvMXM3RDBMU25jZGVxdk5jVU95?=
 =?utf-8?B?YmU1RjIrOWk3b1BnL0pROURjQlRXb1VvR0duUEdlZkU5UGxNM2NJVlcyYVJl?=
 =?utf-8?B?WWxzYlNYbTVuSHQrWExrbm03TnhkSEdIMDNadStCZDMvb0E2cXdUb0V3dWNo?=
 =?utf-8?B?SXFJd1VvMS81QlE0K3FyTW9QbnduTk8xUHpEdEVsekVQY1M4LzBNbWJMNHNN?=
 =?utf-8?B?MEpSYXBMTXRMbnk4ejhwYkxzZ1RTQTB2dUIyTWhBZmQzZ01ZVDdYenc0QUhN?=
 =?utf-8?B?YStGVXpxZWNGc1VpWE0zRjhCeDNPRVpvVjJsQ3lQdStIMSsxUnRTQ1JHcG43?=
 =?utf-8?B?TDhnZHloQUlQWnZ5UWdNOU5Md1pyOXlYRERKSytRVzVSQWx3ZlF2eFI5dFJk?=
 =?utf-8?B?MENRQS9vL1A1cm13S2V3M2pUVFc1eXluZk5aajdoT2h0czBUVGcxd20vdmVv?=
 =?utf-8?B?dnpVWElNWSswbE5qeUlLZHRqdkNxUU1KNngyOEc5SWErWUpDbjM5YXRJRXJU?=
 =?utf-8?B?eWx4akFNTXZ3TWo1WG1SZ3dmZE5HY0FLT2tiMzdwZmFBMEVrY29DeHJtSmxP?=
 =?utf-8?B?LzREWGpUWTRiLzFYTFdQTk9rN3VFeVVGWXVrTHlxTHBWRlNHMEJBL0VpQktQ?=
 =?utf-8?B?NUZFZU4xOGVCUGg2K09Md09ZRTJNL2k5eWFzNFhIcXladXdaWk5ncU5lbDk0?=
 =?utf-8?B?dFdTT0J0MWdIWFZZUEVYMk1QSUc4ZklTV1ZLUzdTb2JIdDhFemlyWjVILzZY?=
 =?utf-8?B?Umh3S0xHZitMZGE3MjFRZWEvUm9iZytQc3llVEJnRlhRd3VabjNlUWN0ZHow?=
 =?utf-8?B?YkZWU0dTVFA0bmRnaEhPWTlaNDh0eWhlcFl6eS9MQ2VUbXhId1lUTzc5OG5Z?=
 =?utf-8?Q?iVPIQZcJB9L0Wk9yHL8QKzwtYKUocFg7sdj4C7eIy9iC8?=
X-MS-Exchange-AntiSpam-MessageData-1: pUiJPlAv1JhkFg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a85ea011-0802-4f64-1621-08df2f6f0923
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 12:30:05.2367 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nwIdAA1bHNseWHikjhzEGdd6tMDNE66ANxE5TJqlCFWYDPmjtpJ7JHDE8RULA79DFb3HXrOO+NSg8l8utUvjmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7557
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

On Fri Oct 16, 2026 at 10:53 AM JST, Eliot Courtney wrote:
> Add `Vec::try_push_init` for fallible initializers (`impl Init<T, E>`)
> and a new sum error type `TryPushInitError<I, E>` that it returns. If
> allocation fails, it hands back the original initializer. A `From` impl
> for `Error` lets callers decay the `TryPushInitError<I, E>` to a regular
> Error if they want.
>
> Add `Vec::push_init` which is the init-infallible version of
> `try_push_init`.
>
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
