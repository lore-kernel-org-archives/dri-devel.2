Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE2A1CD5BC8
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 01:34:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E055F10E252;
	Tue, 26 May 2026 01:34:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="U3g/2yf0";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010030.outbound.protection.outlook.com [52.101.201.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CB2510E252
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 01:34:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LJpODA9q81YNPuXuVKcuW/KOkBfpbYj9xZ7M/kP9lBxXeEqv6rT34jbdVaJtRciQE/5C1pSXWS4VRuW9wUoZJ7Qd2kXvs91jCX5qc2P72XO70/tq2i/fR7AFIKMTz4vVQoX2OLHYmZY7CicTBqpritX4oF/1C0NNrmkPKPcgkpSCpuAQMwXBbvVLnkOKIUDAHo1Tt+CETGrJzGsslL/Jq2FyUiEIEGFKBYeQ+ZQ0/YkTytqdZhsKPa2TiAnK1WUVKJaVHAZwWMEZV2AoKdsZP3/YTSFjg3ol/QQk6jYNZVYlmP98IVL3Nwn4TC9n1JQYpWd1In+JTjSG9xokyotg7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9NJB7FFUAYwJ/nPRC33EyRF8T9qE2jZ4FIdBAeksV+I=;
 b=GDDHQr0GApLMbnGP8RXgEa+E+rXlPqBSNLECnIT7+xXWd4kkgbS5P17XYeoL9SkBH+4TdISRGvaIwmpugs5yS2tBbQUmTzYpfWOnldpbxuoj1pv+jVgWyiLZyaAkwwUCxj8ZqAI0lXgiHZfv7kCSNqu0+ykNfef78Qc7qJRSW8odq9hDhMQ/QUov0b8+bULAnjRGKn/d+OwJQ862Z3Ro0LSMMrnVfHXaP/ElNPFLrI/RWblncZUy7QT34NZzZzSvXjZzpHKprkdKdSQRqPw2W1w2E/rypDWdhwBvjLF/E9eH7AG63YRDWRu0Y4YGyvBI9lV418bHIX8MI7eFyGlN6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9NJB7FFUAYwJ/nPRC33EyRF8T9qE2jZ4FIdBAeksV+I=;
 b=U3g/2yf06INfmTMJxlqhIpxYBItUeMj6z18s4r/lnVwPuPZpDKtylomLeVpInGOLPoBLYkH2t5pQj0XVpFJY7XfYBpXMwnU69JVvlkOdESHf/paUDnAOcYiZh7EA0zbxomJ2iuNLB688mg6epFbQuxCkBAX79vMC4m/NGbp/kZ8z7nNMmhiRnHgxYQ5KJaP+NwY9Y0Mj5NegwtWxY3eqhxwyX4tygmMBzLWD51M6Y/XgrkKmVhjRf2F/8b7AV32jWON1EGVCN7DTAztbpdGmYc1pf95PamPQpfZA0Fv5aT2Vzh+6hqxFXc8EmX5i86sFyiEgFCuiv9ON70WW9/algA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SJ1PR12MB6290.namprd12.prod.outlook.com (2603:10b6:a03:457::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Tue, 26 May
 2026 01:34:11 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0048.016; Tue, 26 May 2026
 01:34:11 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 26 May 2026 10:34:07 +0900
Message-Id: <DIS7ZZ4S0YJI.3PC9N1EL4VJXL@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>, "Joel
 Fernandes" <joelagnelf@nvidia.com>
Subject: Re: [PATCH v5 00/22] gpu: nova-core: vbios: harden various array
 accesses and refactor
From: "Alexandre Courbot" <acourbot@nvidia.com>
References: <20260525-fix-vbios-v5-0-e5e455251537@nvidia.com>
In-Reply-To: <20260525-fix-vbios-v5-0-e5e455251537@nvidia.com>
X-ClientProxiedBy: TYCP286CA0248.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:456::16) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SJ1PR12MB6290:EE_
X-MS-Office365-Filtering-Correlation-Id: 84435a09-2ce2-4159-aa26-08debac6e313
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|10070799003|22082099003|18002099003|56012099003|11063799006;
X-Microsoft-Antispam-Message-Info: xL6qzelH9EWkoUQ5S+CgOPJXAeeYJbkYncIjYAOQVZSp1TS2Peka0vH4R3rHi1xE43wWdhFB/85uQnlpLShAkmWP8atX11y17o8PTKHxqp0TufMEMUdKUmNEUqSRtMKcSCogOZIZaGLiwqEGCc7hcO5uPuAZbbl/GtwJD+T5KYsCL0NISE8EGuaB5fI3BDpEmIIwIJLD0f1JR9UCZkdBM/XsGSbsDI71DDYanOQF5LWfJ1tH0oANTLRFlogpGIWnQDB2lQXwk6nP8sLHU5KUhQW2CV6OHn3a2jKpG5HZYXX5KY7WBjmS0ug9y72JsBPPnf3u1CNBCufa+ldYSl5tQwkxajDQnPVJ7BDnZimQmKz6wTRk/vgOLXswRN3u9ajssEA3BLqAG5JdHumgSJw8+YyK0+ivl4NtYtnnvJ6bJ+4+wTehgOrgpWSrUflf9g8tyMNr+6+wQxEVXCWUbKo1MOZA2n5bl57cQKuPb1IvJLPmfMjdX1UaZPRP7JfiBzvae3RnGrMNDXoIkVVXpabpq1W/aP8nwCbmRPsaIHjifP4YU4L7aJcgi3pPJ0fBppRw2+2No4+Z69VP96K1y0jG8dJiyYGRUlEcvEsupoiqBsuqcGfBA9Ym0dKtGs15/OdPm5EYN2jv1LJDSwrqd+v09wapdNNrWg/o3BT9krrPGebfFBRPfULCP2tfouUTlLdG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(22082099003)(18002099003)(56012099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1pEVnNtZy9BbkVWL3BpdElYL3lpUENVb2k0UmptRENVNnovRTNWQ0VGR1Ex?=
 =?utf-8?B?cGwrNXJmWnBrNkVBK2tVdjBNQ0hqMy8wMVBRSTFFdGNCWmQvUVpwbG5ZMzNi?=
 =?utf-8?B?WndxQWRZMloweEZoQ1JxckFZUC9oWjdJZHEwMTViUGFCYTV5M2I2bG9FOHZm?=
 =?utf-8?B?Qk14c3lza1VrWFFSWDNGZWtZWldLRCtYTUFPSkNGbmU5VVVUb2h4dFNCeWln?=
 =?utf-8?B?ZGJ3ZUFVV3l6eXUrNDNtdmtGVWxhM3k5ZGNhTTNGeFdtbmRPak8vdzZxa2JM?=
 =?utf-8?B?UkNLRUoxbmJScEtKTjFwMDhWcEFDS25xWVV6R2FaOVFhMVlsVlBseUhHMVhR?=
 =?utf-8?B?Ujh3eVF1aHNwcllvQUZjVW5mWGE1QkZ5M1NMK0h6SHptQmp3SHFla1BnVk12?=
 =?utf-8?B?N1g5bGFnK1p2TEpWNWxjbkVreGptM3hXQTM1SEFmMjVyOU1IR1NML04xUUpj?=
 =?utf-8?B?bFlCM0EyRmp4UlhZOXoxajhBSjNMYXFIR0gvaEtrZWR0QUc3WDNhRVRnVnQx?=
 =?utf-8?B?VG55Z1h3MWxHUjl4ZmlIWU1sdEIraS9tS0ZtbTRtbW8rczRqZ2VJMnRRMnJN?=
 =?utf-8?B?YjFXY2duNzQwU1Mxd3RpY21xYnhIeklIcklaZG1kRnoxdlhoOU9nbXMvTkZn?=
 =?utf-8?B?SVNOTVNCMEhjdUlkUUFjaEwzZUUrYmtUUE1JMGJMS0I2TndmYk03V1lwYmJZ?=
 =?utf-8?B?U0Qycml4SXIzM3VIQjRTNDkyaWFLQThwOVhLdmpqcjE2enpXcjV2V1lPWTlV?=
 =?utf-8?B?SXF4dVNNOEZmZVdCNFZnQmRReXFoN1AzM0hDcnB0Nk1DUGtMaFQ0cE5rWXNj?=
 =?utf-8?B?WHNzZ1llVklpeDd6Znd2WU9wU0FmMHFXNFFOU29HVlpjU251SlExSXhBSDNK?=
 =?utf-8?B?M0owY0puM20ra0Fkc0ZFcmd3Wmp0TGh6K1k3cTBueTYvbVRTS2tVVGlSTEF1?=
 =?utf-8?B?Z0hiSFBWZGEvY0RrdW8wb0doQzl2cTlEQW94TGUvbHl2d3FhUXJTT3A5ZThs?=
 =?utf-8?B?V2pQenFBQVBiMlRxc0FrKzgwYnRFUDZRNUJ2U21zbjlZM0VVcmpmUkk2ckhh?=
 =?utf-8?B?bHpYcXdoQVRjREVtSDdGaENpcjBXNmpXTXpWTnljdmNjWWUxQ1J0TlNwYysr?=
 =?utf-8?B?WEZWcjdZKytaY2VOazdGNUFaWWVvTUhrUlIrM2R2alJ3aFY5VVJkUzZtNW1u?=
 =?utf-8?B?dXJteXRpeGZzNUtuUVhSdjRPQ3o0dHhyanB0V0psTk94b2VKUDkyOUxYeDVI?=
 =?utf-8?B?L2M4RkU4bGVvanZ4enJJQ3BxcHJWNEM0QnAxM1ZrejRxYnNMWG9jcGgxOG5m?=
 =?utf-8?B?SFI5YUgwTEM5aE1GM1VkOHFzdEZZWGJIQ0JKNVI3YnFVRVBXWnluNkJucjlo?=
 =?utf-8?B?cWpORkF5UFhxdEI1UGhWRkU5cksyOTQwamJ6K2R2Qk11eXNRMHJQVWQ0c0w2?=
 =?utf-8?B?cThnMUtCd0FBeG14SVk4cER5NnhsVU9IRmNDRnRYdVV1MDJnNkRpN0ZoZXlT?=
 =?utf-8?B?TnRhdldHaHY0TFhGUWxDNGQ3NnZXUS9HNDVDd0ltTFNPeEx5ZWdVc3dPS0dJ?=
 =?utf-8?B?TkxXS01Sb2g3VE5RaURXMmdITWhlN0RiMUo3K3NCUFBLR0NxQUJ4TDFZVTBM?=
 =?utf-8?B?WUxXSnN3MjA1QlIzQ2FhYW41cnRFbHZZVU9MT0hLbVdlZWR6aEQvaW9RQ0RS?=
 =?utf-8?B?UUR2cjk0U3piWnhtUXo2S1NxR1BhMHk0MWNOK0xMMjRxWVJ4SUVXYmttWk1q?=
 =?utf-8?B?WURzbDBUYXcwOTM5N1pqZTVRZzNiKzJNbFBxOHBiaVZqaTNMVTJPalUyalUz?=
 =?utf-8?B?VjYrZlpTUXppclZVYm5rVWNXQ3JLTklhdHZxckNmcWJsUXdLVklsdVNGSWtq?=
 =?utf-8?B?TDBFM0pEQ3JkT0lVNHhDU3lrRTU5anJVL2kxQ2ZCSUdDaVNvMGp2c0RBTXVz?=
 =?utf-8?B?L2ZPR0pUQ2Q2cFJJdDdtMXpBM2ZORFFjcGVJVURTSjhNbHRSYWVQdDFVZ0NI?=
 =?utf-8?B?OHRrekJ0OGF1elRKVGhqbUpZTjdCRVY5L05Ta2NlbVVEY1ViT2VIK0lwenlC?=
 =?utf-8?B?OVBtY3B3c0RrT2Z5OFdNdXFPRjc2bm9meERoWE1lZC90b1AySE1YN0VMUkNy?=
 =?utf-8?B?RDQ4SVhKcVdWb2w4RitsUXBRMzZoR280SGQwdDVGVFlMdmtDK2drai9LdmNq?=
 =?utf-8?B?dGN4Y3dnV21BNys3SThWWFlycmprNUZWU296aHU2VDVJazh4bVJxSTJqNjdN?=
 =?utf-8?B?bk1WcVVuSlRPUmtTRkdOdUVTcDR3cUY1TDh5Mk1KenBFUmhUQW44S2dlalFL?=
 =?utf-8?B?RWE2YXNjbTFQZlNBTDJrQVpFcVI4aHZuTDAzRFkwNXJaeUxOOHYxNWZycjd2?=
 =?utf-8?Q?VVRzfPympXQt2xScSeCvvfE6wDZyG2YG0rlH6yvkI7oYk?=
X-MS-Exchange-AntiSpam-MessageData-1: FT2z2WG/BIvzyQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84435a09-2ce2-4159-aa26-08debac6e313
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 01:34:11.3388 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SsRA+f966dM6pbf8fVPfGAFHpD9ltdtku/2uwD2vTqA2oNYfiew8ul3kmaNB1Luqz4nzflCurlckeEgo5BzWiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6290
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

On Mon May 25, 2026 at 10:57 PM JST, Eliot Courtney wrote:
> We have some code that accesses arrays based on values from firmware.
> This patch series makes a bunch of those accesses more robust. This
> series only touches accesses that are not guaranteed to be safe by local
> invariants - some accesses are safe due to earlier checks and I haven't
> modified those.
>
> This series also refactors and removes some code that can be simplified.
> In particular, it removes `FwSecBiosBuilder`, removes unused fields,
> and moves type and constant definitions closer to their usages.
>
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>

A little bit after the party, but as requested:

Tested-by: Alexandre Courbot <acourbot@nvidia.com>

(made sure probe succeeded on Turing/Ampere/Blackwell).
