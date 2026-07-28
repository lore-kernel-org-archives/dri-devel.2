Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 816C4C531D0
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 00:10:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C101D10E4F4;
	Tue, 28 Jul 2026 00:09:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="fNmMR7vt";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011026.outbound.protection.outlook.com [52.101.52.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5A7810E4F4
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 00:09:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C2l/63BUOS/J8GtxLloOXMv7jmj/L9Bluw33kg5LbH8/AsyAw1CpWyacYoDXnOeCAAUuhDyVQPTyubIvvxQDk7m0x4EDwqpjtq8/5LVYcdgO9GYzsjl53Rx9ZxK+gj+634gKRBvx44AXu++msRjY1gND3sJK7LsLD+x24fnY313d7JPjOiKYlXbLtO5lwsCK2hxVJmNlBEJ6QQnzrSuHEV4vG9Kc+7HsyW1reeKfkUmwMiTDyOFIOQ7ST8RhxPfU01WTVg1qseHk4mps/UNjmOnwqIZ/1epHLU7+gBrC7koezimHz+dxFl7yFC7vZfUDyxAHU/MrLjntArKzCwyG5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pl3vKG3je9xpcYbpCWko5SL3zjgu4Sh+oh7AMWA+iFE=;
 b=pUhx+gME12JcjhvcrR+iGjZwXHSA7jdIL1ZDGK2AO1lfFFNv/nirjMYnYQ1972iAvq7WgAQTRu3KuuGBjfqL3ebWpT8cMPTizgEtqIWmQ7oFaJSWKiRq1N7BTODU8iQ3Ksh+zCPePhYFklYew83OU8JuoZLUGS9sRkEsjtD757SEAGnE/mJsQZNhkFYs5vO1qa3AB7MfjmJEO+WCGr9ugKK2Fm8caVZEkyEeYToMb+9eeoHwTM4aKBwgCQuaezLAHCkp5YBNNkGVDkMecyQp7qscycDcFl56GQk+pEZTJFJqggHk17kjLXGpYIDFgho4//Z81d0caTK1V1Et6TF6xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pl3vKG3je9xpcYbpCWko5SL3zjgu4Sh+oh7AMWA+iFE=;
 b=fNmMR7vt9XTuByMUknio7e46iemRgvRX73HfyyfKMqfhExgzejLXwOOHZ4vZg0sWDROnjSZ/EYUOEPVT0tYV4RTbAXuTW48i/IXYSXynD3wymtGaDNxLKfmX4rIXl21vVLsotuFOQG5Y55a06Njkh5zCgMOwfDuSc/OXmkVt9epDi8ytBI0OFQ7wobhTW8SnHAV6DqPr1Ff4G/YTXB4MKbzOqudUr1Ge/dEuypnjJbkBPzbjDNA7BdKhRA/hzOfQOOYnDZmnP5lFTiSDz2+gM79G0hKnAj00qKtBrJZ9RDd6wKt97qVbwiuGnE2apfv1U0v0rQVju0PHk4Ga9R+Rng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DM4PR12MB6399.namprd12.prod.outlook.com (2603:10b6:8:b7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 00:09:53 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0245.012; Tue, 28 Jul 2026
 00:09:52 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 28 Jul 2026 09:09:49 +0900
Message-Id: <DK9RNQWROGCF.1639C80DTQN91@nvidia.com>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 "Eliot Courtney" <ecourtney@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, "Sashiko" <sashiko-bot@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>
Subject: Re: [PATCH] gpu: nova-core: fix packed registry table size
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Alistair Popple" <apopple@nvidia.com>
References: <20260723-nova-registry-size-fix-v1-1-8f471ba00ab4@nvidia.com>
In-Reply-To: <20260723-nova-registry-size-fix-v1-1-8f471ba00ab4@nvidia.com>
X-ClientProxiedBy: TY4P286CA0084.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36d::14) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DM4PR12MB6399:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a2538fa-6d2d-4495-820b-08deec3c8bfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|10070799003|366016|1800799024|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ++Sgh5+KW9oDkceNfV1vANFnCsMM903XoEy2uIaqIUU2QrV8uhfEVbner7DdG70c0bR9PqU+FFX9OpM789X0qewYi4iPFbnSKA7pFuLiFG70+XK6Yy1pQa+neTDSWnAwxDW3Vvi0SPMzMtDBx4+sN6JN3kafD1ZUhX9InhiU2S2VI2yYjnYO6zmdS1toYP3LDhwfRn3qc0eLUAG6TYaAbmtZgVxiPRMhPq43V+nU45NNluozVigWxbgN3jEP5MVsMgqUHV3BWVBTH0iwH1nGda2kq3bGqsUP4qQ3ErZjBKTO8SylrYWIvgrGqd3Sl/xjGJZFE+8RzhMIiYifaiECBmeRtYGmqQZ5VuusU3Jxs9mHURb3JymWghxlrGwU0jZBHJVVVmZUeAER2ISGUt969CUxzz+Y+KnNQujCcwt+aHSSCdrM10yykcGiB+P3dXN/+KVWyCZHI4kltXpC5k0pxlZtMr51+tBzO/ZiTZYAg8wEbu2NaTaxnlENDXfyuJS+BShG7+Bhk0XcijbbbSXmn4awD/5RaURuA3SB2+T7YVw74cWrMD/ceFHs8MMfcACBM7vnsHQb3jSurCh60XN8yy7Dm+MREKULzaM3O7v9zgW18YVK/PsuSMPeUzS4Z7CLRIuRiuBy1p5SmqGwX8oo4Jzmf4SFNGENWP5V8XcVZ5A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(10070799003)(366016)(1800799024)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2hoZU8rMzdlOHZFa2FLWXFFanUzaDc4dExuaFBGL3htbis3UlN2cU5IOGhK?=
 =?utf-8?B?KzlsV3dZb1BDWU5ZeENrZnQ5ZkN0SlZMVWFYZXpmNExlRlgwWmc1SUo5UTN6?=
 =?utf-8?B?bzNNSlVmSzUrK0sxN2ZLbW5JRWE3Ynh6ZkFXQ0lQV25LUGE0ZlZtTml2aUdl?=
 =?utf-8?B?ZmdKS3FYMk9qbE4yZW1XemJ2WDJTaUlGaUZtcWdZSjVIYm14Mlh0enU5cjkx?=
 =?utf-8?B?Mlc2S3U4SFZ3ekN0SHZiQ1F2djUvMm1kUW1DWVROMVN2cUNqbS8yK3daYVQ4?=
 =?utf-8?B?YXpSZWdLWGJRelZvNllGTURERUNOUzQ4cHNpQWpFekhjVm1QSkVQUmJLaTFV?=
 =?utf-8?B?US9ycENjNGg0VTkwa1NwRmUzcXdIZWFXRFE3c1hGbXBrbWtVWEc4TVdRVG0w?=
 =?utf-8?B?dDNwdVZiSHF2bkROSmRYYXlldFNrZkg1SjMxNVhhejVoRnR2aGd3SkZ5dDly?=
 =?utf-8?B?Zm1tbEJENlg1N0M0ODIxZmRBK2pzMTdsSU5KbzhWMFgwa2xaMWg3QzhISTVa?=
 =?utf-8?B?TVJmaW90dXVnTHQxUUF5a2FqcC91WkpGaCsyMDlHRTR4MlNXZy9jQ2ZqZUtL?=
 =?utf-8?B?TXZqQm1Xc3BZWWpxdWVla2FkMnYzODkwSlQ0UXQ0MmorUUU2ZDdVZVNua3dE?=
 =?utf-8?B?RkR5Ym9oN2x1MjNDS3Z1eXhCQmFhblBQeDFnQVBBcW5hckNFSWRHdkxpUkJJ?=
 =?utf-8?B?WU5Gand1UTQrZ3NFQXg5RWYvRzV3VWhJRGdXSFMyTXFsbVhySlJ5WW5meGNo?=
 =?utf-8?B?SlZjR1ZTSkNUZEY3TTg0bjJSNzdJOWphZlFRSnVURUJFNW00MWhDNnVucHhu?=
 =?utf-8?B?QS9mUlZqRkZOZE1tYWJUVS9vWjFJejI1Z0N4R1BWa1FpRzhreGtpSWVVUzJh?=
 =?utf-8?B?OTlrOCtuZmpXdDFXWndhalVNRzYyS3FyUkYxVVlaMkxFZ09Kd2YyakZZQUtE?=
 =?utf-8?B?d2Zab2cxQkE0ck1jb2RYZDQxQVB0MitjTzcwdXpUdUllZnJQeWpFQk9kdzEz?=
 =?utf-8?B?djQwaFBQUDVpVURzUnVFWThuRVlXbUlUKzJla01HMWZWS3VzMm1BWWJJN1h6?=
 =?utf-8?B?WGZhSHhLR09FNDdPYmlrZGVuVHVZMEk3NXQ5cnFkUHV3dEpCcHgwUE1mcG9V?=
 =?utf-8?B?T3ovaXlPME9lbzU3U0huK1pscjAxaWNkNExrWkxqaEd4a015WEROUDR2Tjcy?=
 =?utf-8?B?UUVUV3ZVUVZuWWZoQnk2OHdQcU1TeGxkZ1Y0OGNHbjRybzdyL0diWGtYS2J4?=
 =?utf-8?B?MEFiZ3JjeENTbnc0RmMzUllGc3FKWjhKbVY2VWVuaC84WDI5NXNhK1JOVEsw?=
 =?utf-8?B?RGUyazRFcFJ0bmx4dVpNV21HanN1SHNxMmwvZ256T1k4WUZNMXBLUEVXSmZq?=
 =?utf-8?B?WlZuaUJTU3RqdzlwVGFOVVJwcnB6cUlGSkxUdHBURjhXWC9udWhyZU14cTNU?=
 =?utf-8?B?cElPa0RXWjV2ZzNyNjRoUDhFYU5HU1JZRVpzZE9oTVdCL1JxanBTUEhVZ0ps?=
 =?utf-8?B?WFV0ZTY0eVRuRGpMdjN3RHB4QlAwRjJXb0lEQ0JsYVZicnlXaTlNREtMcUxZ?=
 =?utf-8?B?Z1RLMFF3eFNyRGNDb3lSTnN2U1cyckxpMCsraFhuOCtQQVdXRjc1L0NFU2lz?=
 =?utf-8?B?VDZBQ0RJakgxOWJXWktHZmpBRWxKRTV6WElSSzFMd1hYN2pHYXNhSU84eno5?=
 =?utf-8?B?ZWN2WG1Pb2trK2JwaFdORm1RZU9JT3F3VDdOcU1aS1VOZzFYcUUraWk4clZF?=
 =?utf-8?B?VnRyVFBqUWZvcUpGR2ZqS0w1eUczRVJuay93S05jZGlYRnFaUVZ0SzVVOVd4?=
 =?utf-8?B?Y2U1dVNnRk4zWGtHWkZ1U1hDQmdHcXpQS0MxMTVBSk0waDRKeDNmeTBXZ1Fs?=
 =?utf-8?B?RXBpYTZwY21pUE1yR01tVlh2eEVKTlEwRGJOOUJRVnZDNXpEUWUxMnErcTh0?=
 =?utf-8?B?QXFhN1ZrRVZSS0RaWVNjdnZzUlByMWFrandNMW9wNVg1L1FYMkU3UHF2ZmZk?=
 =?utf-8?B?MXpQa29VeU9sdmg5LytQQmRkdXN3YlY0SmdNaVpQcjliejgweDhtTU5uOTlo?=
 =?utf-8?B?OXE0aTlJbjNwanhhVWx2bmF0ek0zZTVvRGRmenJacXVMaG9QbmNvamMyTHFB?=
 =?utf-8?B?dVhUSzVHL3Nac1NkNUZKWXVJeU9VZ0hDYkIwRHFWVE4xeG9Rd1JlV2N6a3o4?=
 =?utf-8?B?Vkx4bENYYlFBdkZlWW9LMVUwTUUrUy8rM0IxYlE2TTNtL0pnT0trVis1UjZU?=
 =?utf-8?B?bkkzWWlkZGRMUnZDZk9GV3c4RzJ1a0l6NHNZNUpNWVBOOTlvYzF3VkZoUSto?=
 =?utf-8?B?MmZmYWdlTG5VUHdNdnRQMUE2QnJGak5taDVhOVhXaXJaZ1ZqZDIyUjRtMlVT?=
 =?utf-8?Q?WSZe3i2X+5OjCNZevyX8zNPlvpShdO5riBIhOX3HsPfob?=
X-MS-Exchange-AntiSpam-MessageData-1: zoucYCNq2Ng6Tw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a2538fa-6d2d-4495-820b-08deec3c8bfd
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 00:09:52.7297 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QjTe7KpQ/StEO/KFYhml/FsG0sr3svayBiTcjQsln2W9SdSY4bGhbysQyG/cJFkJApV9cCHvy4UU8yiOy8U7Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6399
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

On Thu Jul 23, 2026 at 3:54 PM JST, Alexandre Courbot wrote:
> `PACKED_REGISTRY_TABLE::size` describes the entire table, including its
> fixed-size header. `SetRegistry` currently initializes it with only the
> variable payload length, omitting the 8 bytes header.
>
> Fix this by using `CommandToGsp::size` to obtain the actual command
> size, including its header.
>
> Fixes: 19b0a6e7c2be ("gpu: nova-core: gsp: Add SetRegistry command")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/r/20260722075253.B6DDB1F00A3D@smtp.kernel=
.org
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>

Pushed to drm-rust-next, thanks!
