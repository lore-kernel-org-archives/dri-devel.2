Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A57606A32E
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 23:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=rO2TBxno
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A77A10E484;
	Fri,  6 Nov 2026 23:15:40 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012052.outbound.protection.outlook.com [52.101.43.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B15710E484
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 23:15:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lUebyoF0xOvTgU+WYkXKCkr6Y09sXi3zuA+rGTBNyA41ZRHUOAZMfVoFmX6G/tHMNfh7KnWO7IxzruP4/NOTUQ3xk0K6mjlsn/a3zOcfqLL9E6Fpmd5Z7gjQt4pArU+ikdfqG354vXQaTGZGzfurHUwQrs892i996ISbJKYv17IK3ZKvDByrdwHOcs1fHebYLBEhP6HDlyq+i8Hmr6OwIsK2EZPOmHSYGevLMPeXStj1n6Szc21prFmRt4c2mt43Mt8F98AWnHOeHpgx2UmkHdKT41Vo4q/+r1b8TpbGQrb4aMYILYqFAKiX+is6xrHsgzJ9+IeQySf6e9t7lL61Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P0TKrmOcnACBHLBZCrHhSTjhoR7OMTwV2zkm7Oo5/gQ=;
 b=a+Qn8bCEMYBTqLblUpOqetpAW2+EP4XijqqlLVXz4MJAd3Yf/mqNVUOvAjXyTp+nDZkTMUNMdX0lpB5iXqjiii/9E86wSICZWwq/P30G7/4QrwD0fgEQj3ljsdwY8ER95wvIID+Qg5eWIGklepSCpsvK/zgf5b/ZKCfni2o6YLjyLSXGrx8tZB1CmF60aIeRgX0ny8EMbIKgn54t8avt7uTi8LMjkbUgo5dUSEgmvw21Ah/Fxt/PpjPftR0d8U1sxeM1Ez+Wa1shz4lLPCJLkOJ+iaeFQD/Ma3aZ/ONjepKm0aKqHVNpq63TeTVH7i5uZlxlZ/C7cdY8LwJd3708QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P0TKrmOcnACBHLBZCrHhSTjhoR7OMTwV2zkm7Oo5/gQ=;
 b=rO2TBxnoEG8YDrJCDNOgKLK/86DQVmIV/CXPDgpTfsPFI9a8nKv9YUE5+is+Ax/Nab5ynqgibcz45iKnBly7BM1kmam6jOWiUd1WYxi51VI+J7hLH4pdUnBnO2Jroz4C2isx5ESBGvpwQ8Vc4C3BCvqGpfwfGM/JIZP5VMqXavuAcW4rkyXYp+QtqNmkB1kA2RciXV5yC/NUvAqzbuJE8wRCwT6WDrPUcRDVbq8A338OAhvRf4baq88FHB7AfnQVgs8bHQO/wuGIlp3vvuEQqQnJK+c+3/jSlLUJIU5KfrBytOJP4AQn5/d3QrgUFiSutE4Kitwln5YiHN29QP8pTQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by DM6PR12MB4106.namprd12.prod.outlook.com (2603:10b6:5:221::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Fri, 6 Nov
 2026 23:15:30 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0592.007; Fri, 6 Nov 2026
 23:15:30 +0000
Content-Type: text/plain; charset=UTF-8
Date: Sat, 07 Nov 2026 08:15:26 +0900
Message-Id: <DMOIDO8EG1W4.W5NWTTZNDB8V@nvidia.com>
Cc: "vladazaharova2018@gmail.com" <vladazaharova2018@gmail.com>, "John
 Hubbard" <jhubbard@nvidia.com>, "gary@garyguo.net" <gary@garyguo.net>,
 "nova-gpu@lists.linux.dev" <nova-gpu@lists.linux.dev>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "dakr@kernel.org" <dakr@kernel.org>, "linux-doc@vger.kernel.org"
 <linux-doc@vger.kernel.org>, "aliceryhl@google.com" <aliceryhl@google.com>
Subject: Re: [PATCH v6 0/3] gpu: nova-core: retain the GSP-RM log buffers
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Timur Tabi" <ttabi@nvidia.com>
Content-Transfer-Encoding: quoted-printable
References: <20261014154554.231015-1-vladazaharova2018@gmail.com>
 <b2ff5c437c41ba4f8c1a8f354d24d7e68517fbf3.camel@nvidia.com>
In-Reply-To: <b2ff5c437c41ba4f8c1a8f354d24d7e68517fbf3.camel@nvidia.com>
X-ClientProxiedBy: TY4P301CA0084.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36f::12) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|DM6PR12MB4106:EE_
X-MS-Office365-Filtering-Correlation-Id: f3465d18-68e6-45c6-daaa-08df3c5bd96e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|376014|1800799024|23010399003|366016|261009223027099003|56012099006|4143699003|261028144727099003|11063799006|261026140227099003|261022105027099003|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info: SVRLYt/2vSgjyYMxh9UZZGHqWAyniBdbC3o1lSh4lguhArjzN6TPgrEBCQKU9n9kkI4luW9Gm/cG+CDyR3j6Ml4ZjBPWDlCn2abUVgvBGbqmFsc16Pn76kEnGyXNxkB6OwpZ2Ute2SFwRA+o/1DajrPLrpl7YwzmNsugcLkYR/TarLFx4cHzuzEkf4KHcIfmegNIXETQkEdh44DYzuBkgr3YHOpRWO9P+BT6EBfFDr5WJ+zuAOfLmKy3FwVNh7d46zI2/zTAt7MbvqRgIl4HWy+AxT6ano5DLsioWgiKFmkCVygGHo3+y+LkQmZwAqIfl4qKc/ANNnCorUquOxcg+0KLWmhoeezTy+XY1BVIegS3NvsgCHVWl55kX6VCORouSSbrEEtSVDQJ7fRM8hs2srain0jJGcwsGkSq7gDyCS2nz3fL03Z1DcSdA043qhsI6MN9t3jfF/+8xSNHnkLVkKaNbYoBf0aaXkDOmuUk6sJNf8rjGy6b20PrpKRuEBIQGHK/fDsD9sVM+NPCZGzSwDvpiMLzDXt+D4t/eJiIKV1lJrJ1qPNyJn98/GidEIUhk5B+32F4EktlLKbCSIpKnvTV+6mZQ22pW4HWyEp0RfL35biXK04C0FSQ/d6Zm0mWAeu6B/ZJO7/GQFSGgFywbqTRAc9gdDKjSqExMA5IfpM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(1800799024)(23010399003)(366016)(261009223027099003)(56012099006)(4143699003)(261028144727099003)(11063799006)(261026140227099003)(261022105027099003)(18002099003)(22082099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mk9tSTliUldqcnJEOG5xL3ZMSEo5ZExwQ1dYK0FBUnBIem1qemFQU0I2RHRv?=
 =?utf-8?B?dCtKaGNFZWhlWTYxMm5GekNZb1JEd3Ftb1BMUDRXVzlCMlZycnVNWGNHSFA5?=
 =?utf-8?B?R0FyZkdvM3I2OFVLREJjSC9LelBHb2lOOC9zQURBMy9LOStid3gzYTBjZHNB?=
 =?utf-8?B?U1psSEF0RFI0Y0grWElDWGhBRllqRnZTQTlteXBOSVB3UTg2ZEVvVlhxcndI?=
 =?utf-8?B?NVZPbGQ0TkNITlNaZGFFSjhzaUl3ZWZoeUc2ZXdQYVM0dzZjTWxwSnVqcWMv?=
 =?utf-8?B?VkV5YUUzejc1VWpsd2c0a1ZkS0tiNkFJT2ZJR3VlR1dtYXVpc0FESGgyU0lT?=
 =?utf-8?B?Wi9uMExDa0lLaFNiZGhuTUVrcjBDZXhGaTZxQTdaVzY3UXRWTmtPTExzSmRD?=
 =?utf-8?B?ZExBNGxFajhnOHJ6QTVSaExDRDB4Mm5JZ2x3MnZRdzRwUDlOcU1ET1hOTFlI?=
 =?utf-8?B?K1dJbnBtcW9Oa0I2MWVvY3pJT242VWlGbHNzYnJNMUJlLzhCWGkvS2tXdlRj?=
 =?utf-8?B?eW1CT3pZSWJKZXJ1U1dXeW5oQ0Rta2dCWmRjZGxZanZpVDBFWmZybnlCUWVw?=
 =?utf-8?B?V3NXRDBoV0VmQVMweFdwczhlM1AyMDh1akhXYXZnQVlFU0IwVkEvSzZJaU0z?=
 =?utf-8?B?a2RrdEhab2hRRHVGTEZOYTh3OG5scjNMWVdqc1NwZUloT3ZzanEvVld1TmZD?=
 =?utf-8?B?YjNBbUkyNEs2Y3RqRFFjZ082VlZRY0p0Ly93UnFNTFZSMzJNRDRXUG9vTjhW?=
 =?utf-8?B?cEU2WDQvNzNJeHY1MVZoUkZhM3Bxa01wNVNwcWtYVEhUSzNSQzB4R2NvMGVk?=
 =?utf-8?B?ZkxjTThsS0x3SkFRTENaNi8vWHJZUngwbXN3QkwxZitpb1VZN253aGlmZEN6?=
 =?utf-8?B?Z0NvN0NYTmtZYzR2WXZ4OVZVK2w4eWkvS25XR1EyQlN3ckREcWtVNXo0eS96?=
 =?utf-8?B?R3NTazZUa2MwZ3NuZjZmQmplbHNmUklBeG9jcTlkYVdUUDRjcStpR0I2QUNW?=
 =?utf-8?B?MXVxRHZHQ2xPQXJjOUNrb1N5bkthOXFlakpPNHZIWDdZUUNoTXlHUnlGM1VN?=
 =?utf-8?B?Nzl0LzEzdTdpSE04R3F5a2xhN2xBeGJxWUNzR256bHl4eFhvd1JxRFJBaWIy?=
 =?utf-8?B?MVdHNjdSZWlNVGx5MHlXb0lYWjU5ekJKWnE4M0RRTWZSREFaaXpvSVExSVQ3?=
 =?utf-8?B?a2JBbWpLd2pnV09aWkZ2ZmFrVEdIZ2c4RHpXT3kwSGxEa1E3UUZoTVFESnFw?=
 =?utf-8?B?L0pkbkptNUs0T1hjOGhCdUtuem0wblR0eUMwNFlxM3BoblE0Q2RQaldILzU5?=
 =?utf-8?B?b2lvSjJVQTBTakYvOWhTVXI0amRSN0grOWxxajVqUWFNRERucmNuUzQ1Q05p?=
 =?utf-8?B?blF4b3piUXgrZVhDMW5DbktvTlV5bVZ4SG1HZTlWQUE1OGo1ZW9uTXdCQ2hO?=
 =?utf-8?B?a2hrMVd1SUx4eExGQVZvalJXbGdqbGVac0xFRXVvY0Y5QWVIN1F6amh3NXdi?=
 =?utf-8?B?bHlnS1hvVVAwQ3NGRzZpRHJodndoNDdkbzM0VitiQyttL1dibzRibnFOQm91?=
 =?utf-8?B?MzMvZklnZnQ4NUlkL1YwZzZYQmxpaWNWa2Jvd1R6RXNzSHVUdzNZMjI3QnZq?=
 =?utf-8?B?SWJOckhLM2Z2T3VrYUtrY0l1d2NTOXovUjMzUStIanJ5VGdJcm5Jb0p6WStH?=
 =?utf-8?B?VmNETTl1SmEydHl5SjhiN3UyM1UrRFdxYXR0VVdYaTd1eVRuWUgxSytxN1ZR?=
 =?utf-8?B?YktKR2NZTDJLYTdYc1JiemJLaVAxUVdFczIzNXloaVczZlZYN1V3b0duVHds?=
 =?utf-8?B?L1BLRFJYNG9NVWI0QXNhd05LV1JSSWFmWGZkWFkySzZrNkFwb0hnQ2VkNURZ?=
 =?utf-8?B?SFp6MWlKYk9zUFVuQ2JxWkZZMzk3bGNUWE9mSVFxK1JzQXdrYmUwNVFyWm9S?=
 =?utf-8?B?UDRjWjNYVExMcnVoQVBtNWdtSm5XNW9yUjdsQ0k0R3ZhTlBTUzBkNndQYWlG?=
 =?utf-8?B?UW1ZaS9IbGpaeTYzKzc0cTlISVY2OWIwdDhnQ2t1UnB5VEorTFpOblUyQmVo?=
 =?utf-8?B?TjhUaE9yeGlKL2VTaXpHZGlzaXpmb2tQbmZIMnJCQUVhY1VPemVzOFlyVVFB?=
 =?utf-8?B?c1RjaU5VRnIxclcxZFRVWU12M2ZFRks4Qy8wdXNVVHhqSTc3MG14aHVKUmVv?=
 =?utf-8?B?MzhJQ0NSekJGdXdmaWJPb1lqdnYvUGFyTThUQ2pjd3ZwOXYvVVZjRktTdytR?=
 =?utf-8?B?ZmFNOGhUSFprZHJGa3JpaU5EeFg3all4cWZrUzVFTDNMN0ZwOXRqQXlTSHdj?=
 =?utf-8?B?eVVodDV6NjZFSEJtdXJuSWpTa1lOSXNsMmd0UGpkNEpObzZJSjZtbUFCSDli?=
 =?utf-8?Q?G8TzdZ69SPgWanv0MBnh+rQZDGrktRc5engvRf45Fvbgx?=
X-MS-Exchange-AntiSpam-MessageData-1: sFvaPF40x6Jr5w==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3465d18-68e6-45c6-daaa-08df3c5bd96e
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 23:15:30.0006 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: olQ9FDcHlv8swO9+afsruxPNCgJyU4G/bqOYQa8By9YQTAmCAWvRiDb5qFQSVaw7dzd4fDSZYokg637vK9DHwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4106
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat Nov 7, 2026 at 5:51 AM JST, Timur Tabi wrote:
> On Wed, 2026-10-14 at 22:45 +0700, Vladislav Zaharov wrote:
>
>> Changes since v5:
>>  - keep the "put" pointer read before the barrier in the copy, rather
>>    than the one the copy reads again, which is not ordered against the
>>    rest of the data (reported by the Sashiko review bot)
>>  - rebase onto current drm-rust-next
>
> Can you rebase this onto https://github.com/Gnurou/linux/tree/r000_rebase=
_all
>
> This tree is the future of rust-drm-next, and there have been some signif=
icant changes to
> debugfs that result in a lot of merge conflicts.

This tree is also a moving target; let's not ask contributors to use
obscure bases that are weeks from reconciling with drm-rust-next.

The current v5 applies (almost) cleanly on today's drm-rust-next, so it
is fair game to review and merge if deemed ready. We can rebase our r000
code on top of it should it lands first.
