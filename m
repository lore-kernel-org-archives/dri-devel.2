Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E285DCC6B19
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 01:00:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49D9310E177;
	Wed, 14 Oct 2026 01:00:33 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011039.outbound.protection.outlook.com [52.101.57.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38DB310E177;
 Wed, 14 Oct 2026 01:00:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uo+jJnCHJtnLHrFsXvGSNgfDbSukYvQQRUVxWigIGhLnLEL3j81fGXfefHix2meyUF0LUwV+u5k4bX8Y3pKLFmtoGL5PHClG95JVAyUFDmQYuZJmLy5xvR5Oq8Lpv3EjkFPvNdodtIerv3A8qzTQqowQBDDvNds56nCuc18SrXMjLJzH3R+ZpfpPVEo1BpLezwxVgEcw1h2FM0NfHp6RPJ9i2jArQRO0eZ01lmDs+eSmoNK2jCVFyqtvoRL69SH7hKf3n0zvR1hjksqwBV2PDcF4v6aAPX7nOWzOea54LCfEMBDAe2gzFYiZf9s/YpfGjeD8K9ooT9PMWYKDVk/ueQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CNdRuNd3tqxkuhBr8GZMs7d5vGORbSmUvGEwMq29WdI=;
 b=IGNZltVbYhr9k58ON4G8X/q5urbdj3s4eKLZ3fNIrp3A/ayoCr27F88U6wsxB6dU5dTw5NqaXI4BOFO2+pvsq/xJ38+/ClN6oRqZtPmiPNlsQKGviU/SvZtRtlWLEqieI6GVTtQRBWVk+ag4cYOGZDXZM7f19uJmIbP/a/epZ5WF2LYV3OhswA+ps6xIRYMFUoMVtMf4mVc504GZjvP7cMOnm6KmEnwTjH0VkVDMRCgMShgtUyKJnjso60B2R8itJFthrisoqLZ3WxGUvncuzb4qfYTtVmdg2k0icN+nSf/uULWe6v7nbKhF6AalhvNg9gCg/3LyeabhtnMP+7PhXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CNdRuNd3tqxkuhBr8GZMs7d5vGORbSmUvGEwMq29WdI=;
 b=VBvK9FbC8evOGcyLJzckEuxq2a8QifRrXkR8iDQo3SW81BQNdRnX5wJH7DkF5OfGaY524ydt7LhxTN/ftbU2X00+GTJYj2+GaltFIGjil0TcV/v6Zj3ZSpYcgasEy5X/hwBBG8MkYWWA2FG8xGY+ma2V23LQhRRYPrmXvqPG7ul8QnND8gw9WxDCzaDHcprc3cHv4aKWXAiaNY7KiSWK06il5fu2Yorg7rcXCwKGaaWKrTR0i//gIyQWOeE/5hdJVTxzRbbuKQv/By1tYFQKmGE0z+RAfda/QAsRkopTxBEh8fB20MGgc1nsD+MDVdwPyk6H2G1I/tPAAGj3w1BsRg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 SJ0PR12MB6926.namprd12.prod.outlook.com (2603:10b6:a03:485::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.23; Wed, 14 Oct 2026 01:00:19 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 01:00:19 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 14 Oct 2026 10:00:15 +0900
Message-Id: <DM45KUU32XJY.3SEO01811QCUP@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "John Hubbard"
 <jhubbard@nvidia.com>, "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Benno Lossin" <lossin@kernel.org>, "Gary Guo"
 <gary@garyguo.net>
Cc: "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 "Eliot Courtney" <ecourtney@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v4 06/10] gpu: nova-core: gsp: cmdq: move RPC message
 logging to RpcMessage
From: "Eliot Courtney" <ecourtney@nvidia.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261009-cmdq-rpc-v4-0-c9ab8de1d3f2@nvidia.com>
 <20261009-cmdq-rpc-v4-6-c9ab8de1d3f2@nvidia.com>
In-Reply-To: <20261009-cmdq-rpc-v4-6-c9ab8de1d3f2@nvidia.com>
X-ClientProxiedBy: TYCP286CA0122.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b6::8) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|SJ0PR12MB6926:EE_
X-MS-Office365-Filtering-Correlation-Id: c3d5989c-ffae-46da-e566-08df298e8423
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|10070799003|23010399003|56012099006|4143699003|11063799006|22082099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: k8dlGE20726L0zT5Ubin2268XHzT/l9g1QD2y7pDQMKXOyaXO+s2reBS6vVfBw+vH2U39cxkEF4ha2PUlUS2YFJmsWgFx/nPb944aq+cukvDwGesSxnlQnXVmkPErtQ5mmumx5Q63Eow9c5uxfBG9fOBuYyy/deI2sUfaRkgYRTc4392RgZ+uzL4jJp8OZ5iSNny46el6dw7rjG3njN8bv/UjoepRYCZ2GI6RhH9o9V8fm9U+Uls3j/h4yLeT+ZYMhp2O8nWEFvFf0J56h0mLv2It0kCyLn7Fojy6+E63HzSi4qM6zWclQUWc8lC4Kq7ylxFY3MpQUzUfJKHZkHhILvLYWIhaeSXjctipVoowG9MAb6/BTvvmhqCLRQblFUImp7uLHccRH4rjH8886iIS4yynxbCID3zQ0YJ1huLWSVijoYsUQUpVWrFuJ8rht3T8of13xXFxVDC1pUtZGZg1BQOSqlLzqYKdKVnVkvInDUZzsT24ZUkcVyK9KIjNeSXmE68RPO21ln3mkO669ttn5hw0Njb3HxtDwfOuQGO0qLu4frAcyGVoexBf08pLc3zFC+m0peHZRzD9Tpwf72YsdtJvu1Bomp+n6iaZ3zew9yMCgWJQSyuRcxJ5vOY0Y+5UT+/4oh9fry99nRuQmspMLPrB30ywBoBukiLyhSdNFA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(10070799003)(23010399003)(56012099006)(4143699003)(11063799006)(22082099003)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1prTlNZN0UzN1hBZzhtUnE0MVgyd2cxTUVZaFdsTVJJQkZadHB6RXAwZWtt?=
 =?utf-8?B?Z3ZPTXlMYmFYc3JMb3UxeXdRZ0NpeEZNWExsNjBiTFRlOUx2TTdoVVZvdEtP?=
 =?utf-8?B?OXlYQzRpdzlMbFZjZTZFRW9ZQUlwNk1SSm1GQWI0TXlxL2wrcy8xQXF4QnlU?=
 =?utf-8?B?RXpZNUwwc05ESFRXd05RdVVGeExGMWxQaFBWY3AxYUY5dnNwTGdFcHhYbHMv?=
 =?utf-8?B?cStjNFc3WktyTXJWN2RFeGtUQ0hYVmJZWG02VUI1Z2I4TWhHZHFkdHBXL0xD?=
 =?utf-8?B?MlRZcExUQnF5MXZIRHpETGFOWVU3Vk9veHlXcjgxekNOaW9kamFqVDZuLzFl?=
 =?utf-8?B?U0FaaHhLS0lzZHpCeEZmNDBiQTB6dTlzb0dTejdUNC8xc0w2bVF5N3JSczJh?=
 =?utf-8?B?bFh2VkhUZTBGbUswSllLdGo2bDV5b0xGYzRtYkdQbHBWbVllR2thK0l2aE54?=
 =?utf-8?B?U2F3OGtRQWdiR2ZmUnVkK0ZNZ1paK2NWaEkvdG00eU1LdTg5cWJNUFFCTklO?=
 =?utf-8?B?alczYmhENTlaR1hsYTVxaEhjbnlwcHAyS2JKUmExNkxRQ0FnTTFnaENDNDBl?=
 =?utf-8?B?MWdINUtXa2NKblQ1ZnZrMTBnY1gxaUY2NzEzOUdVV2hrTkpBYUlvUWYxRHEx?=
 =?utf-8?B?ZUE5NlNYakh0c2VrOStLeWlSTlpDNWFVQzJ6TllmVTF6Z1dDUU4vTzVkMEI0?=
 =?utf-8?B?S3lkUG5MU3lMOFFQUU9oTGlvMC9DWUQ5djVGL204UkQ3dU1MMDlSVlg2K2g3?=
 =?utf-8?B?QU5sOG45RlhSRTdhQjREM1JzMEQ0V0VKRVNPQzJjNkZpZVBCUmFyK0tXQUto?=
 =?utf-8?B?VVVHbUtwbFcxTFgwUXp0ZDZ3dGlXYXJkOXhlYllEczNwVVIwajg1amlockRm?=
 =?utf-8?B?NWpJT3NsclZzaEpBNDZqM2cxdHJRbDFCalVmMkVJQTF2TkxmQ1ZxWjUyNUJp?=
 =?utf-8?B?K1h0TmhYbUhUWUUvckFnVWRCbEJmTWZZQUd5c3RjT0FiM2lVR0hnZ3djZmhi?=
 =?utf-8?B?R2ZMMDM4UEQxRm5POVUyZk53R2VKcTNtbG1IVkYxb0IyWjBmcHJFRkpnYWZL?=
 =?utf-8?B?UlBhRGtjeTRId3d2dG1HZ0s1S0hlcnNVcDRwcUFmMm5qcmMzME1DMytBM1Jr?=
 =?utf-8?B?TDJtTDl1OXNwcHZuWEp2WS9nRXphc2Zpb3JURlo5ekVpK0ZBUmZrZFBhaThO?=
 =?utf-8?B?YXJ4ZERVSGcwTDJjZitRL1hJeW01dkYyZ29lTmprby92U3RLRFVZN0JwSXFz?=
 =?utf-8?B?NnFuWGt4WkdDaWlSNDBhSkhScWp6QXZQdzIwbFY3SDROTVBLRnlyUDNkR1lM?=
 =?utf-8?B?MmVkQVFIeEdaN1hDd1o1ak5PMmxKSDFiRXV5Nk5WWXJweVRCM0t1M3QxZ2NM?=
 =?utf-8?B?Q1U2N08ydXhvYVFyVHpQekhvYVViWjVuODZiTHA0RzJxU3VseXV3SVFCcjZY?=
 =?utf-8?B?a24yOEZnOWhhaVBrSGozN3NYRlgyR1hLSnBQdEVXdXhWbGQ4T3lOQkRuQ29y?=
 =?utf-8?B?M25PUlJ0QTBTd0pXRVlqZHhsZnZRWGh1V2ZPRjhNR0hQbU1FV0RwL2ZpL0JP?=
 =?utf-8?B?ZktQNmZxaGRxdFBNZkhQQWRMWjErSWFIWXpQRUs2OFNIVFVBRk1DVEFJc05D?=
 =?utf-8?B?MFMzcnVMRkJSQm84ejI2NjFPM2x2U1VnYXl6MXFmUmdWZUNSUXlBNEJkZFdS?=
 =?utf-8?B?K0FaTC90anR6cUxrRjdUY0h2YzdXMDZDR1ZYa0JnVCtyMEkwcDRBYmZrUE5k?=
 =?utf-8?B?VmFWeGdOS1Z4YlZiMDJ2VDVUQmNlMm5Pa1FMZ1kyb1paQ21wajR1MXM4aUhO?=
 =?utf-8?B?anlDNmkwMWNqTEtSYlhGODdFT2ErelhBQTdkemVjOC9Ld2hKYkRxRFRzM0FI?=
 =?utf-8?B?R2labktxSjdlVXhTNHg0M2RNK1FRaW4zaW5VTVdoTWJvMTBmb3ppYmpIRks5?=
 =?utf-8?B?S0ZraXpMSVkrYUszbUVkQkZ4OWpia1BJbFBtajBxOW9qK1diWHVwQWlXakZT?=
 =?utf-8?B?eGFzMXBiQTFqL3M1SnYvTkRkUm5xL1BvdXdQcFQvUXNkWjNHTW5TdzdqZFg5?=
 =?utf-8?B?Yk5jU3ZIK2FCbTZIOWVJTmNGcFd1eXlZRDRtWVZFb0dQaGlGcWNZQlRjWU1N?=
 =?utf-8?B?bVN3Y0RNYU0rTCs5a3BiUU1SaWpUcVc5NWxJTGdweXZDbU5la2lPSytOTG5M?=
 =?utf-8?B?NS9XalBacUU3Y09iYThsY2UwN1Nsdi81TDJGWlA4c2J3OTY3MWtTL0pBRHly?=
 =?utf-8?B?RWJNT0d4dWtDdkpYU0h0eHFkTmRpZFBvQVY1RGlIbEZUZ1RFd1dwclJjcmxP?=
 =?utf-8?B?aFdHdTN3c1JGWkw4UC8xZlVqZkNXVEJERjZOZW4vdHdPTzZqTEdoSDFRVTdG?=
 =?utf-8?Q?Q787mEC6jZmE57wWfqD05BKbhliBFk6axSgVelTt+ZmKj?=
X-MS-Exchange-AntiSpam-MessageData-1: k9MeAd2FCCUpFg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3d5989c-ffae-46da-e566-08df298e8423
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 01:00:19.0992 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H+mwZ7CXOpQp7/Qah7xBYnF5Wd31Ky0+OTQKdTYybDc4Z2uT4YtskPNYHfIjcxNoXOaXms/SoS/1TYS1tUxoTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6926
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

On Fri Oct 9, 2026 at 8:54 PM JST, Alexandre Courbot wrote:
> The `RpcMessage` type is the right container for the `log_event` method,
> since it contains all the data we passed to it. Move it there so callers
> don't need to extract the required data themselves.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>

