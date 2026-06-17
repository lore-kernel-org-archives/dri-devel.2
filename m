Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AB5ECD98F0
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 03:13:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAEAC10E8D6;
	Wed, 17 Jun 2026 03:13:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="JBLs/KmH";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012012.outbound.protection.outlook.com [52.101.43.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C598710E8D6;
 Wed, 17 Jun 2026 03:13:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UaHq/6XmJp4ahRkRyoqzqBKKu3apdLVgfDmx0Dbw7g17A084T6kkxgPrYH9vdzUFh2pxWR/SrJZtM2ABdgAYUjNk2X42OtFp+x8gxA7TqkwaInURwOAG5Z6C/cYyZ1w4Peaoje7ow7xseJagao+vpIQ1JW+2w8ZoTWJNjl4XqhP34M15saBGAHyl4ewNCf8jU1KoHWxPebas6DfbQO5QNzceoXf10d+xQ7glppe5h1jEQ2wf5joqx6GWFqKFM70zKniVCVU8PZ54u8TRNcvT+mo+6//XKj7thDycyKMhRcFe46QSQooIs4lb35SPbtz+huw5lDVhPvi2oMcmtdubtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HBCgnBaDtq/eZgl/Xb6xPqIBN6WkHToLR4E+PHiokYw=;
 b=S1plntcGyuxLNJA5zPMrW997mHsJsGmNMVt81MASyLsbO3cdPYxF8TjGQtrFfZmuc2n6DWeOgFHf2Pd/46mJzTDdEscJ0TJuMTUGCKMdOhJJCxhRnhb8fRqIVKTpmgWddQdUVtVU4Y4OF8FOGgQ57cdlA/apFkbUmkdD6j+Y/b+fTcsQ42iBGrgZXfSJ0aTP/shc0yxkQ2FxeCjA1MicRKWxNU9nYzWfItjpUDpYHg5rusJ2eJdMkRdaYJ5iZaZalDomZSslNBwwEUFV+W7F84G2uRTZAe/C0HoVo2B4RoDUDSbL3GO9emQOPr3JH2pyn8G7sQ+gsVuzfQSxgHB+bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HBCgnBaDtq/eZgl/Xb6xPqIBN6WkHToLR4E+PHiokYw=;
 b=JBLs/KmHIEw8OLYfgOH6hf71KFNLpqMBBDF7WnUWxLzPxO2cTaxPpe94FQAXJM1x5/A8FMwBmw8AEha+tq4Gkj4NhVMepFUTxVrqMGT7HHPpPNsXPBy7NWMblqdNjsGzNckbjLT7Ny9GLltJVjODlzwYeN4NvjQGPJt5aGrmSjtJXcnuX9qPDpXffD//ho1ogTDP94HUWCw0vh2reANj8zdU7shotEzzWMLXhW8s7Vby53Y/Msbh6lhYbfQyMzxk0CK5PtEPFxHSZCdYO7i9ZnyyFE3BjCLknBDOpB/2DTOcW0//wo8vw4m0Hopt2zQll8YtB3sj3ZV8kM/TMHoufQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 CY5PR12MB6645.namprd12.prod.outlook.com (2603:10b6:930:42::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.11; Wed, 17 Jun 2026 03:12:58 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%5]) with mapi id 15.21.0113.015; Wed, 17 Jun 2026
 03:12:58 +0000
Message-ID: <a6f05632-bcc2-4bb3-871c-c0b0eb905393@nvidia.com>
Date: Tue, 16 Jun 2026 20:12:56 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/13] gpu: nova-core: fsp: try to enforce exclusive
 access to FSP channel
To: Eliot Courtney <ecourtney@nvidia.com>, Gary Guo <gary@garyguo.net>,
 Danilo Krummrich <dakr@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>,
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Benno Lossin <lossin@kernel.org>
Cc: Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 dri-devel <dri-devel-bounces@lists.freedesktop.org>
References: <20260615-blackwell-fixes-v1-0-f2853e49ff7d@nvidia.com>
 <20260615-blackwell-fixes-v1-3-f2853e49ff7d@nvidia.com>
 <DJ9SKDFB5Z63.JPEV0D1Q60L@garyguo.net>
 <DJAZIGJQ72A9.1688NC74RA4SY@nvidia.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <DJAZIGJQ72A9.1688NC74RA4SY@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0342.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::17) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|CY5PR12MB6645:EE_
X-MS-Office365-Filtering-Correlation-Id: fc4c4b37-15d9-40b4-6a5a-08decc1e5530
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|7416014|376014|18002099003|22082099003|3023799007|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: BdZr05/tDUoclU43I0ZURQ1vPCFdfsstWUEMcVc8ksivK0QZQZqM3O+d9bSYDcSZvLs8+6hT13r7fFTr8AxsrhI/ap+yLfkaHKEMKfgrT3/m3qrQGPhkfTrLOZh5pk3tXo6WMowR2hmOmuZQOlVQETv9pOkpEm9R5ZqAjSsh8eFHfzVqmo4i3bjGWXF/eQdlMVmdC0P4vicTaFlIHTjM62kb0hfK//qu+inqHZgW6Rub8ySQOdc0BL1YfGL7m71WZTOOCKjKpLjeQjWR90Ou6dilsCceLHPVi2DlL6guuHS6kZfd/XlB+RaIDsIhp+MZgT4DetOJXs4E1TNqhCj58ZErKGmo5xQrQt3yR/G/8S1Ier6iz5Sw5/QpbMzYu4UHBMXFajaMOoKRmsW6fP9tPWGS7WW/ELByzZ3/MLrNR2zARBnH65rErfihWwgoHIRNOQtigPkgLAvs6Xq3wlKUUd8EiXoQYAyhJ7bfI8krsGntYu/YSOwgLgYTnlRWyj8reKZXo4m1q2EdJSquDTwWkTHQb3UqKzhU8xtKQ3quIUuxxmQahtIMwn/BnvavsPLYGHjVN9Nz1cRW+UWNr/t2xReiw+Yr7XjxS6sgT5DhykMNqIoqlAP3UNT6wEfBm8P/apBnl41mTp7EoL4jBIbEIP1MnTHhIcbAUR/r+lT2+DqxtrD3QhpRYi1eXDegxcS2
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR12MB9416.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(18002099003)(22082099003)(3023799007)(11063799006)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clRaZThQQytCbUdYckRFb3RrWHk5UnlsVHUvMUEvUFRiWllkZkQ5L0ZhSUZn?=
 =?utf-8?B?bzdSYUhaRVZ0aThvQUtCYW5QZFJmbnBhOUNaVDFSM05RTy9NRU1MZWtFU0JD?=
 =?utf-8?B?VGRFRCtTUUl5cnBxaGxlN0wwYWlRU3pKU0NDWHRKTFJRRVdldktiZWJoZldj?=
 =?utf-8?B?dlM1dEthemVOUDF2c202Z2hGY1BmU1Mwd1J6VnNaZ2FCRnB2b1VlZXh4WHZV?=
 =?utf-8?B?NDNadGh6NVJQcW9jYUY0SERtUHZjQTd5U2hiV25lT2VIK1hvbUtMSFZlU2Z1?=
 =?utf-8?B?TWJsMzAyNHB4ekFTSk5HcHFmcm9KNlpZWUtrdDZCMnc4bXhScURabUN4VDF0?=
 =?utf-8?B?bld0NmdPL1hPNHpqb3FITUZGK1ZFMmZTWmhnRjRoSldldS9PRnZVYmswNHpH?=
 =?utf-8?B?RnFlK2hlVmNDSEFBbGVxT29kNzhPcDZJdzBEbk5pTTJBbXRKM0tpNit2TGJl?=
 =?utf-8?B?Q093UGtuVnczKzRUc2dOZmt1OFpVUVN4Q1pTQVVmS1dQdjlUNGx1VG4zS1ZR?=
 =?utf-8?B?S1hFWS9JRW8yZkhCWW01aXVOTDZVOTFwK21CdXgyUFJPRDE2S05TMzkvZGlV?=
 =?utf-8?B?eHZLYWtPMkk2RlZMQzJBc0NMdWxUcVY1ME9TSUZFaC9oaytFRCs3UVI3eU1r?=
 =?utf-8?B?RGppZUlwNmJHU29kQ1AzVlQrNUkzMHY0Z1I5dXdGbUp4SHUwQm5MeDQ3b2Zu?=
 =?utf-8?B?d2FUVjB0eUcrVFIzTytsVFZtWnA4VUZRSTh3UFdUbkp1UERRNXRmWkpMV21j?=
 =?utf-8?B?TzJmL2QyL2I2ZDQ2bnlJVHhqdXl6OGh0b2djQjJEdVE3c1JnVGtoUEFTTTMr?=
 =?utf-8?B?R3c4STRLUXJTVlMxMCtEZS94ZUdwYjA4VVY3Y05uVS9HK1RZU3pmamtzcVpP?=
 =?utf-8?B?d3AydHhNbDZOeGVEaEZoVXFOYjN5NjI0SGtDTHpOOEF3UmNwMXl4RVJzdTNj?=
 =?utf-8?B?KzVPSFlhSDZmOENNVGxTV1I5aUdJdzhDeWZyZzRxdC92elF4S1EyYitGdHRR?=
 =?utf-8?B?T00yYmZLNXNZUHJ6YU0xWWZLT2wxbWVBSU1FYm1HajkwNllHUzRFaVoyZk95?=
 =?utf-8?B?Tit4RTc4Y0VzQVNSOEhhdTdSSUZJMkxWb1RnMUd1ZGZVWXZsbXpJSXZjRXVp?=
 =?utf-8?B?b2pBM3VFdWlBWGNDUm92VGo0T1EyNXNPZkMxRzgybHNnMnFaRlF0bGNVOWZu?=
 =?utf-8?B?WGpCMWE4VTEwWWdGbXVMS09JV0REcklaZFdDb2xUSDlFZ2FlYm5lNUxYN1da?=
 =?utf-8?B?RWdvTGY3QVQzU0pCODl5SXNac1Y2YjhUWkx3SUZoRVNLeEs0OXBVQzVwdElu?=
 =?utf-8?B?aUZiUDFSY3B1Y2RyelhBUTlkQ2Frem1IamN4eWxWbzFrQkRnaVk2V0l0cnBX?=
 =?utf-8?B?QTZ5QjJBNUhPNDBIQ3B3VHRLTTY4NlRJVXd4YThkTTlPRVVkYlp2bzB5YmJW?=
 =?utf-8?B?ekpwdWxJcStYL0pEYnU2alZ6T0Nma25CNUgvMjd2OE1SSzFqS0FvS2RBVm9t?=
 =?utf-8?B?OCtwMjMvZi9LbkZ3UzV5L2VaKzhuaDhDYnBQME54dnhOQUllRW1SOUpkeVVC?=
 =?utf-8?B?Y0ZwNU8vMk1EMjJ4T21WREdEaHV4aGtTTzNpb1JIa3ZJejlDVVlDS1k0Q2FG?=
 =?utf-8?B?UnE0YnRTVE9weE1xTWdnY2RoSmNuNUZjT3hoZW1OK0diblhHdThhQWNTUUdj?=
 =?utf-8?B?UEpNVWczd29aNzcvQ1RpTUxOMllyMjViOGNIaXZ2dkd5b00vUk9lZVJsVkF5?=
 =?utf-8?B?azd6TlAvUjJtUE1QKy9SQUgwWk1aVDdQMTBqMHlaS0VDbWprakdia0hRR21l?=
 =?utf-8?B?M3VPSFlJT0dha0xiRnQvR2J1ekhTNSs0a2l4ZzU5aExhbHgrb0dsUEtXVWs2?=
 =?utf-8?B?UVM3U3pxYVh2Mk4wYVFMajlkNHVkN083LzlHVmErU3E0dWVTOHRpYVF4T0pH?=
 =?utf-8?B?Ni9KYlNuV0ZVZFVwQ0s1ck4wNC9HY2FlcnVicFp6dlJTbk4vQ2htNHF3MnJQ?=
 =?utf-8?B?RkN5ZFdvSDVVU3RURXd4cHQzNWtYM1lYM3JYZGU0bUt5VlZWalF6bWIzcTZQ?=
 =?utf-8?B?dE9nK2p3NE13SE54bmdhTkNCZzRUV3BOOTdILzdjSWY3MmlFWnhiMkNhV2I1?=
 =?utf-8?B?Y0VVM0UzWWZ2SlRCeDEzYjVvTjZsa0xCZjFRM1dRVnptR2ozZjZpOGdxdDI0?=
 =?utf-8?B?UWNJVFdQSVBnbXppejd0UmNWTzRQYzY5aHFkeC9ibWYzLyt2VUxoalZaMjdk?=
 =?utf-8?B?U1doZFR3TTMxSmJKV1BvMmhndHF4a1RvS2l2MzFhWXJiMjBFVDd0WTN1WnN2?=
 =?utf-8?B?THNWL3V0VDVrSzQ2ZEdtL1I5bS9KRXFXa2ZENDlHR3hlVEZVYU5Zdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc4c4b37-15d9-40b4-6a5a-08decc1e5530
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 03:12:58.5439 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TRqljFdGAr2Ve66kGAcgNRkyshwZC0hzhvxIxG118LOLXt8oZL7y+GL1TEr3tnC0u+M8LNIQdQfkbASbP3MJzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6645
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

On 6/16/26 7:55 PM, Eliot Courtney wrote:
> On Tue Jun 16, 2026 at 2:16 AM JST, Gary Guo wrote:
>> On Mon Jun 15, 2026 at 3:40 PM BST, Eliot Courtney wrote:
...
>>> +            || {
>>> +                let qhead = bar.read(regs::NV_PFSP_QUEUE_HEAD::at(0)).address();
>>> +                let qtail = bar.read(regs::NV_PFSP_QUEUE_TAIL::at(0)).address();
>>> +                let mhead = bar.read(regs::NV_PFSP_MSGQ_HEAD::at(0)).val();
>>> +                let mtail = bar.read(regs::NV_PFSP_MSGQ_TAIL::at(0)).val();
>>
>> How does this prevent race between kernel and GSP when initiating FSP
>> communcation?
> 
> You are right that it does not prevent it in the general case.
> 
> This is the logic that openrm uses and locally, much earlier, I observed
> sometimes I did actually need this for reprobe to work. I think the
> reason (but it's been a while) is that before we did not wait for GSP to
> halt on unload and probe failure, which could mean there's a leftover
> message from FSP that is not consumed if you reprobe quickly after a
> failure. Now that we wait for GSP to halt it's much harder for this kind

Can we bottom out on the root cause, before coding in a speculative fix?

Check with the RM folks internally, they will have debugging history
and lore too.

> of issue to occur. Actually, it might be impossible currently for this
> kind of race to happen without a failure on unload (e.g. timeout of
> waiting for GSP to reset).
> 
> The reason I thought to add this is more to match what appears to be
> the protocol that this transport uses (even if it might not be sound
> generally). I am curious what others think, if it's worth keeping this -

It depends on what we learn about the real root cause.


thanks,
-- 
John Hubbard

