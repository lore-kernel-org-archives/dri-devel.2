Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A3ACC43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:05:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D397A10E355;
	Mon, 29 Jun 2026 13:05:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="RNk6MnxV";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012049.outbound.protection.outlook.com [40.107.209.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B1DE10E355
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 13:05:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AS1Dz4Fnph1lrolW1yFZPcGfYsU3JpxcKHpKsWznfI1Z0UtILZ826LKA3SqlJXvu8TXRtAHpQ0NTqV9DouW+XAtpg9WkNYCZHxUC9mi8NdSXhcOS5Rn0pEWylJycIF0fnDce0GmhqOLudCvfk6vk4QyrfvZ6bUM9GlhQ+RNsyx06wIZEjHfgn/1tfhDlUDjj+p2S5AebQvieFw8J8LCZe0fsbX5+tZSHGCmSksQNtuPn3Ygbvcf/IpRNmGWBk+DmL8n3eCG0FVe5iGOZt3pvj3h6U86HudhvsIJfaqXtUQcxSaYcKrUpB/hUQ7ZN3qvPLbPrcNUTleY7tvj0YJAbwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P7RXHxeCaLz9iU4yGojDEMYPycSXWVypRh4323KIFhU=;
 b=Ldd8UN0SXwl42N3ylN8u7dQCGnIZMP2TAPaS54e2M282QLNGPyVlMhZRzAr8ZjFqNh3bLYSz6DmM9WEUifp2PtBqa+YuD4QsZJznpFAsAVl6FES6gybcsOwzayj9+xNJN/7GAB/mfYPH6RqLG/HT/NxCroAWshWiE2g9+kZ/DcdzrTmtdQseb9ugqERm12EeXw3T6n/fzrsjMybbVcMhcY6dV5oFgCUgP6Ytm+u7Sn1MiOt0OLSMiXU1IdiStKHsdxgBr3ANpmM/TRf6kXH9/DTL9q0P1SD1HtbhkosjoF7mNEoNfJqsBUxyR2ArFOzF1r2Qtc2EYd91AtV4E91SvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P7RXHxeCaLz9iU4yGojDEMYPycSXWVypRh4323KIFhU=;
 b=RNk6MnxVbeUwJn+zmcAdGmNLtctofmWrScmptSeHmSxStuWbj8Xhv9xyeaZfK071YO5FoWoNNI9JgIpGuo3TZG0/E3rlTIVb1//MlRm7/MB55LR5ISG9HjuQayaB9yhTsCC5BwzGh7TZu/wClKii0b4P0bpPyeBsQvGGOgNkyebx01NNzhS0GYKy9AdITxOLEjksaXVaTSWcuqtZhGiReSHvRg8ay6nyu7AoFpFT9E+1DlffnYjs5pWAX/gAbBo5nrR+Kk1ydCcvlr1i0YnjpXpJIroO5axOx+yFuMmaUZYnHn7DJmwnS5g/NOOSSJEq7eqSOXhwTId+tLPyVuTYuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS0PR12MB9037.namprd12.prod.outlook.com (2603:10b6:8:f1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 13:05:10 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 13:05:10 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 29 Jun 2026 22:05:05 +0900
Message-Id: <DJLJZJN79QEB.2JOTYSZJPTMTW@nvidia.com>
Cc: <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>
Subject: Re: [PATCH v3 00/12] gpu: nova-core: consolidate and streamline GSP
 boot process
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Gary Guo" <gary@garyguo.net>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, "Eliot Courtney" <ecourtney@nvidia.com>, "Zhi Wang"
 <zhiw@nvidia.com>
References: <20260629-nova-bootcontext-v3-0-26cb29ee8dee@nvidia.com>
In-Reply-To: <20260629-nova-bootcontext-v3-0-26cb29ee8dee@nvidia.com>
X-ClientProxiedBy: TY6P301CA0012.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:3be::13) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS0PR12MB9037:EE_
X-MS-Office365-Filtering-Correlation-Id: f50024f6-b398-48fd-2309-08ded5df0c84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|10070799003|1800799024|22082099003|18002099003|11063799006|56012099006|921020;
X-Microsoft-Antispam-Message-Info: 2DZpnqX24ylMBlUACPO6l5UcBbtWsCjtgDAStinp1nr5ct/OrSytB2vTIO5KRBvjHLsAPLmxucfG2Q671I3QZx6CWjq00k9l6JiqnAnUNWWTsH1Y+fwjLb5qMARnel2iLnqS2+No6oVZTJY5na3qrMVlJj5wFbMtvzDj2LDRQcJM+fV8M82E0U8RacSq0oaoeaGiCd+3iOb4Opn+F4XQ9SqoCNNQ4rKtPvajewr/eD8aMev3S+WA8tQFH6ultpOwmI0MpTYKP/X4B/YQcFcKSOUgtzecSrDNk7NoiPV+YyHUdE9hT/oBzFKnqvjAhn9eLKuzzM54yzx4vU2Ky97dSAvF8OpWq+Mjc6WNA4bBrsC2F43i5j1AbO3TzIPuM/QD/7iIxlxD6Eu1GV+9IW2plb9+c25Zasd5aW2XgorRImtMlw3yPo7YuA69A5Z2gD/KInJsrK9nbqvE8TIYkw3b2vfwhE0xhVpeWW1uSeRR/m2Gle0lCHdWcjZr/Qs88w65UXnBT7KFelfZxCWZv8sEQIcvFqp21Seps4EQwjUep4LgxgS27xuq0M/i8Y2wGkNXQX8bGyWMo8g5axdLrx9TkIIS6TFcbC9D3E/yI/K7oa8X3BEwhwa8PWnrusWQ3SUjvABrkqVErjOluCI28YIJ1LdkFXxIwIWELLIYNC6UjNNySeqUFP76w74Pj82Gmu9vC4US3bGD5UbrenC+haY1qw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(10070799003)(1800799024)(22082099003)(18002099003)(11063799006)(56012099006)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WmNVOUY5d3VkNmRXQlFjLy9jTEdKNElmWHh0anV0aVFjVHFjSC9OSEwreWdw?=
 =?utf-8?B?OTl4alltZ2V4bzgxSDNrd29JOTMxMHhrOE1TVjdkdE9HSEZEcXlEUzFHRU5J?=
 =?utf-8?B?TE9Nb1lYZWp4ak9yMzVyNG9Vc2RkTmhsSXRLQkZacGtKUkVqNFRPZXh4eFU4?=
 =?utf-8?B?aUo2Q3IvZWRsSHQrMHVRcTA0YXpUZmJYU05oUlRkTnh6MXFNVW5IZUpsMUtv?=
 =?utf-8?B?YlpTRVlSblBOKysxaGJFUmg5c1dpeHM1SUhEU0pvYm1Eeks3TjhLUUt4YUZY?=
 =?utf-8?B?UGo1Y1o3VnExeDU1R0tkU2t1dDRoUmZOdEJ1NXhUTGJlTUZ4QllzYWtVZkk5?=
 =?utf-8?B?TjVBNXR6Qy80TG9kMFRPODZpSndlVnY3VDQ2bnNQOU5jUjNITUFVaE5rMFJ1?=
 =?utf-8?B?Qm4xdFhRbzF0V1RPb0crc3I0QzVXeXlBVFlibmhnRWx5TkZMU0NOcCtjanBJ?=
 =?utf-8?B?eHcrbzFjbkFVYnF1WG5DOFdjWGtXd0ROSWlXZUMrMi8xUlhSRFdpa1lGeFZR?=
 =?utf-8?B?dGpVeVFZeVpBWXNEdGoyQkg1azVIYWpubHBwTW9WQ2gzSHVzS2hQaEZjcUw1?=
 =?utf-8?B?eEVpQmJha2M1dVlNZXVBUTdhV3Z5Mmc0eDYvY2xLcmxkeGZxZmxSdzVya1RY?=
 =?utf-8?B?SXJvMm1rOFdnb3RZclRSdjk4V3RNWWNvczRyYTFKNk1oaDYxM20rM2NDaUNs?=
 =?utf-8?B?YjVnY1lZL1g1N2xQcGpHc0xGRVVOZy90ekt0VWNwYjJzSWV2Q2I4dXpqd1pN?=
 =?utf-8?B?djJxVU1paVgyUHBSVWJ2MU1nOVlodHJZOXFmbkZUNlpnZFpjVWY1MDFaendl?=
 =?utf-8?B?b0xkQTJFSTQxN2N6SmpPdGJJRE1QK2tkZzVta2p0OWpveHpDZnM2SERzRHIr?=
 =?utf-8?B?YzFqa3NFQW92WGY0MEQ3WnBvQnVuZTZDVmRENC8wdjJvMmF6c3JiTkxsQ3VD?=
 =?utf-8?B?RlROSzVwb0dOYkdpbnJUUHhRRGg1R2hUSU9VZUljL2ZNZTlESzBrZTlLM05H?=
 =?utf-8?B?OXM3dWJ5UzVxQ3g0REZWdi8wZ0Zib2tBeEM5ODBBVHMreDBEOGg5L1lhUTR4?=
 =?utf-8?B?QStkMnd4ZTB1cWlnN25FdCtjclpNSDBFTUZXNTNkOWl6TzlPR2poRnp6b28w?=
 =?utf-8?B?UzVaaDVmOHlEUERRSjI2eXJHbGtvZ3Y0NXVwSzNHSWRmWFNUZFhBdDlXaXlN?=
 =?utf-8?B?SFpJcXpCNFJud0VIbTZ1disrellYWkxNaXdxSHFvbFBIZXNscDBQQWRlb1pr?=
 =?utf-8?B?R21NRXJQNjJvU21Ybk9XOGZBTVBhSjl2cVNUVmNSTGxIR3FFUlBCOURFOWVT?=
 =?utf-8?B?UUVwMnZ1WW5pYkF2ZHF6QzVEWVE2OVA3aGU3U2hMOTRKa3UzU2N3MTA2ZEdy?=
 =?utf-8?B?TkJMNW1mOXVKQkcyRE1qMU8zZTI2Y3hVem8xNXk5RHpob3RiQmdpbzJwZldx?=
 =?utf-8?B?SFphYmFGVlRzQ2pBRVNFU1JIRlhoTStTQm10Y0NtcmtBdmkyMm40N1B3a3N3?=
 =?utf-8?B?bG90UDQyWjdVQ041SEU3YTFLZFFJOU1SaHcxbVlPMjBkZHZUWHYxOUNLam0r?=
 =?utf-8?B?cWxtL0lpdUhJV2pKOUVkR3RUdTNrdGIxMTQwUW94dzNCZ1lybUo2VDB4RFNB?=
 =?utf-8?B?Vnl1WmNrZWJKMVcvdFRkazdIN1gvN2JOTlhVL0I2RlBQL1FxTG5MdTBCMFp2?=
 =?utf-8?B?L1pybWc3QVd2SU93WHlyc1A3TmJOQWJYRzBaQnZjWmVyVWRzdWZQb1ZsNnFR?=
 =?utf-8?B?Rmk5cXdFRmI2SldwWi8zRkRHUkVENWFkUDBZb2NqeVUyTFNlS2lNZ1paZnpo?=
 =?utf-8?B?ZXdhQ0pRa1B0RUFyS001THZVcFNNbXE1NWdrUXRjWVJPUDNRaU5Yem9wVGMy?=
 =?utf-8?B?NDJFTXcwM21Tak5wRzhpTVc2ZWNhTFkyaEZLamRGc0YrcGIrK1pPSEhyU0N3?=
 =?utf-8?B?eVc4b1h0S2J3YXdUUGIra292eTNvSjNnT0RCcXV1R1l4UlZ3WkI2dFcwdjdn?=
 =?utf-8?B?cG40RXZwTUROTlBsMlpXQ2ptRFd6bWF0d3hKVVREY05NV2ZMMlMxaG5HQkIr?=
 =?utf-8?B?dVg0eHpaTk1GTFNtaDRMT3ZUN0hIUnltT21jQU1obGpoZ1RxdFk3YTJnWStX?=
 =?utf-8?B?TDhJd3RlWDQ4S00velN4SGdtYUZlK3J3cVNydzNSbFlPVEZqaFFsMVF6UFg5?=
 =?utf-8?B?eEFwcXRIb0VIZnlFVDhpQThDeWEwN1RKQ1czdERBZWRVRElVVDVnZTBZMWJJ?=
 =?utf-8?B?ZFVGc1dyeWpneDBmc2ZXbnpva2dPWG42NHlaK1dKd3lkQXNza1d5R0RPaXNV?=
 =?utf-8?B?d3dVVk5sSTF6UTNjV1VkbUVhVGZ0MklSSVpkUlFMei9DQXo5Y1VFbVRFeTh3?=
 =?utf-8?Q?H/1i6WZtaYrghxG3YroCBBTboOvTUal8EgtfiKZK2mi9b?=
X-MS-Exchange-AntiSpam-MessageData-1: qLyZZnkdH+3Y5g==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f50024f6-b398-48fd-2309-08ded5df0c84
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 13:05:10.0638 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T5Wrg3ReVTLna1f9V6JIEK1U06VSLD6ZpNJ5sRgONc6TcBVWk6/abKuOnZlLdX69jgJH+AJ+PGZGj5iKAEUIWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9037
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

On Mon Jun 29, 2026 at 9:31 PM JST, Alexandre Courbot wrote:
> This series applies on `drm-rust-next`.

... is not true anymore now that [1] has been pushed. ^_^;

I will send a rebase-only v4 shortly, sorry for the noise.

[1] https://lore.kernel.org/all/20260625-drm-bar-refactor-v2-1-9db6b890d92e=
@proton.me/
