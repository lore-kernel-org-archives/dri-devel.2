Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3AE2CD5BB4
	for <dri-devel@archiver.kernel.org>; Sat, 23 May 2026 02:49:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CF6A10F5B3;
	Sat, 23 May 2026 02:49:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="XvU+4r6z";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013032.outbound.protection.outlook.com
 [40.107.201.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A19F210F5B3
 for <dri-devel@lists.freedesktop.org>; Sat, 23 May 2026 02:49:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hiJqJcGvr4GEhrskZEMTSaPPxuAyCAEcjolAVsbXB+ljvxnqlirNdBbGvdQkEHUyPwDzOeUiUIP7oJvZh1C8rtqrYFpW9aIAFHgfkWae93d6ncGdhyyC8KdKUh3ncMZJdvVdYHPZJP9wKOE0a+Ue/Bs4Bm9Sn4GUUj1LkC3QwonztkrcY+Nnj/Tt4YZn+ozDzJoV1kmGOmobxTROnElU31FoOjiWYbiV9qcoeqLcqrPfn9JzOIF4aVrhBBNkdjG5FTl1BOm9BnmRAS0moyVQ4I8aXk7QD9+pK8CZXmjmhxblCwY+07BXeu/JlgQc98/2pYIE25UVibhD5cZWfxdyjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V45jLWb6Y6azLg11AdYIrx6wag2A3hdPyFAIBzAjj8I=;
 b=GZh/wG3skwiPXSeewNCe8rpifpXh4adY5SBt2zsMrt+CiBMQfKARmlcRkaYA2XaPfkIHdj+pPBI3XARL9A6FiIYDhwVC8+H2X3TXtbsbkZ5H+Ci6eYZl4qHTbEjIO3b9WM69bmktnDSr2WMj6UdphGMnyHPcJwPdsSO7Ni/QCaYbkDY5RwCHTl/DmLN5ad/TAYuaZaSb99yXRLyKQUioa7kcL+XZ2URn0jDLIzVaJyF5kJ0LFU6aqLMdjUHrNQR8ukycqc9HprwvCi7sD7mOQ+uu82nexoRF/oA3tqmF7N+ogGBbMXTkg6CS6IvDNJdEl/k/sREC0wWI2P3wPDWQiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V45jLWb6Y6azLg11AdYIrx6wag2A3hdPyFAIBzAjj8I=;
 b=XvU+4r6zo+kgxjox3S0UmaAOqOdQef4SN4vSM+mCjeOy6oUIaWS7UJqO/YeOGqAeLpkYv5G0ylVTqJMxSmFy4YUuhVXiFr7SDDgG48REL/i/PGQkHbcIJ6TvyDp3cS+HzJ3x7xok5Vd3JK/HeoKkMkOMai5xjoS6h3Z2fsfpnMqIvspuGNPHGkUWfQ5plSBxs6Fno4B9Va2kdD36Nmwb1mIZyj7quDwwBok5C6alPD2eA/8A8fLt3o3KwIaCD5qlVpnOgP/EEYeOGgOlnJfEKHG+VcXejAR9lfAkBZLHguE05BnGV2Yvco93ykJjxC/iWh7Shi938Q/N8czo9caAgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 PH8PR12MB6962.namprd12.prod.outlook.com (2603:10b6:510:1bd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Sat, 23 May
 2026 02:49:15 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%5]) with mapi id 15.21.0048.016; Sat, 23 May 2026
 02:49:14 +0000
Message-ID: <a48614b2-3cb8-48b3-a8b5-ce0b54aa0b00@nvidia.com>
Date: Fri, 22 May 2026 19:49:13 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/20] gpu: nova-core: vbios: drop unused
 falcon_data_offset from FwSecBiosBuilder
To: Eliot Courtney <ecourtney@nvidia.com>, Danilo Krummrich
 <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 nova-gpu@lists.linux.dev, rust-for-linux@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Joel Fernandes <joelagnelf@nvidia.com>
References: <20260519-fix-vbios-v4-0-5d3f210c5602@nvidia.com>
 <20260519-fix-vbios-v4-8-5d3f210c5602@nvidia.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20260519-fix-vbios-v4-8-5d3f210c5602@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR04CA0002.namprd04.prod.outlook.com
 (2603:10b6:a03:217::7) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|PH8PR12MB6962:EE_
X-MS-Office365-Filtering-Correlation-Id: e86e03ad-e793-4628-b25b-08deb875e04b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|4143699003|11063799006|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: dkiIqBXA8gwJXzJLWsyjkCA1l1cQ9cVycKlPm9Giyi4dSYKJ8/tRzICXZ0xww8D1xfRNR0W8ZaBLqHSDWdVtkWF9CYzHdMg+xRLeDbbqsqT97UTbuliQtrVd3apcYWzZNcLraR56DErzRw/7aIh9/6i4O7AYm/G7MNL0lRd90dM9nyHrAhXOBdqOXSoGh1NNtYe7bGooWSL57cOHn9wRyv+jIFbKrF5oRbz0yifZRE9J9/XW9nqCIf6e5kOVPzuJo4kpkOIU+IG9IpC7ib74pgxqdWKnFXTpPlY87ZYNsEo1TBu+CB98iIAvRw5hLV6REHyNHQHJAfyxny6rZB36H+SVbqyjsBN01OlCOS45YD59iaRitAecZFZ6ZAtOXWpg5q65KqwOMlxkkqDUilcIOIg1BLhtRS4M8M31Hf32eLe61ZRUg5mZbhPYKa+H53fDpgngmkDxa0JoBi7sGd1x6q4gx2OJRoxGVwqMK9P2Dwk/QWZPYLqT99JLIb68uKd2MWCf+EQ9HNJTCB99/Ae3S3UBOemgRyo23t/DTpKyW/xq+m7nNi0Z4wTvz7uL9pun0+gH4K+eS0JB79PvUgH5B1dfgl5znbQNi8M0kAZg1CvMCRd8RxLU2WJXaltJ5D4GUtL2TSmr4M8z/rF/JT4o85apvG0ojO5xZO7a24qRf8wtXH4cAO/nIgfhcxfPiAhx
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR12MB9416.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(4143699003)(11063799006)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cCs0MUNvYUJ6RmtIT24xeGVNdFV6NkVNaXpodDlkT3MrRmJ2RENIQzJtNWRn?=
 =?utf-8?B?ci9ldVVMWkFjYWJiYnBOUFQ5VWo2UUdEdEJia2tubkZIWll0dC9PQXVNZDI0?=
 =?utf-8?B?cWhqK0pEcC9SNU5JZllvREtuSVh6Q2dOdmFrcG0xc244QzVZbHB6aGVMdXVn?=
 =?utf-8?B?czloRTFaY3lzbSs2aG1xbmVjYzBTWWR3NHVoKzdLZndjQXMyejJLcFJ3UEI5?=
 =?utf-8?B?bzJES1IrMG5MOHA5QlM3aDVrSW1mekkrNTQ5VnltaFRzb1FVVGRQSEozQ2R1?=
 =?utf-8?B?aDB2aTk2dURUeFZEZ3JJek8zU2R5SDZPOVlVNHpZVHZFcENZMEMyTjN3dVRZ?=
 =?utf-8?B?UUpqb2MvQTErbjZzNitvM1Y2OEswcnpGTHNESEZFM3ZxR1lTS3VZVFo4MkVS?=
 =?utf-8?B?SkNEb2JBbGlxcUY3Tm11a25yQ20rNSsxUEpKalZteTNhdHJqOFZZUDhGNDdL?=
 =?utf-8?B?MCtGbUFmTzNQajFtVTFSNFF2NFczUXRkU3Awb0dQQmxwbGlJNUpWeVcvM2lJ?=
 =?utf-8?B?Z0tPeEp3WGpnZW43VHVoNUNUeFJQSnJ5RWNFMHpUcG9uYkl6QWRsVnJvL1ov?=
 =?utf-8?B?T3pqdnpUVFhabmd5MGsreXAzZ01WVVJHOGdpTlFzei9nVjh4Q000UXhJTXZo?=
 =?utf-8?B?M05KS2FhOFBEMXV2MmN3Ti9rYmo0Mzdsc3E1UkRpekFTbk5NTVJZV1doa0VI?=
 =?utf-8?B?SXZCS2tzTk9IaGQrR0lCNHF4dVZmbDFzUE1IeTRlbWhDejAyOGVvN2JFT2JS?=
 =?utf-8?B?OUxyN0RRY1ByMWNPREVNbDZRakJQTXlXajlMNy9Pc1FWVFdyUTNTVVoyK2gy?=
 =?utf-8?B?bUZodUFlYmFnUFpvZUdpVlltU1o2U2QwMHRZWjJiVEpVM0twRzlSelhUUjdt?=
 =?utf-8?B?UkZHWTNuT2V2QWREOHU3aWhBVm9VZ0hqZDV3UzlMYUJzR2pJVnJMYVZJZmIw?=
 =?utf-8?B?YUxDTndDWWljYVVGMzZoZEFCNTJ4cXdnaE9WZWpFdkVKVHp6dWlNUjFsaTgr?=
 =?utf-8?B?RjY3Z05RWVpOa0k0REt4V3E5MUdDcjZYMERXamJ0aXpGN2ZHZy9vcW9VRk1W?=
 =?utf-8?B?eEdveno1Qmo1SmQ5VGRYVHlnd0ljTVFLaHEzV0pBcjFJbXNueno2QS9sT2Uw?=
 =?utf-8?B?aDBVbmt6UVFCak1SSG96WHFvZlduR2RlRDd1SEloMUhBTGoySlFQS3pmemZy?=
 =?utf-8?B?UVBrc3VlRER1V3F5Zm9JVS95bzFhM3hFQ01qZ0VxZlR3T0pQN3V4akhDVWhT?=
 =?utf-8?B?UFQ3b2NIaHVGVFJHSkxQUjNFT0NnVkdEbGxrZzN3RmJEaDFzU0d1MkZDN2Z6?=
 =?utf-8?B?d1F4c09WYlVDZVVOYk1zcWFScE5QcW1IeEx6TkJQNkVBMVVJcWlZV1Z4N0Ez?=
 =?utf-8?B?Y3VIYUZRSXZBNXpac3FuVk5WOTl6ZVZlK21BcUtuWHZoamt3Skg5YkhZYmxy?=
 =?utf-8?B?VE80enRKWlBKU0VkcGNiY0I1SmhLQ3JaMVpPcVFSOGNsYlBSWm1RMnBKa24z?=
 =?utf-8?B?Z0JpeDZnTnh6ZXlEQk9RckhLSmRaV3cxTXc3a3ZLUkM0clp2SFdPZm1Pb3Bt?=
 =?utf-8?B?a0poVGt6ZncwUEpFUGtmc0FTd3p5OEdqQ1JTOUxIMzJwdzJUa1VXTUFzOE9C?=
 =?utf-8?B?SWpaa3lNYkdFTmxuZE1XYzk5WEpBN0g5SmVEalNkUUZBRkV2VXlwQ0F6VlJZ?=
 =?utf-8?B?ajczMTFzOVBYRmhua2hGcUU4UjFFNTFHRjVLRTNrRWoxaGpzUURxWHVNdnNm?=
 =?utf-8?B?NmFtaFpBQnVjaEliZGxoK3pMUUVPeW13VGZuOC9sdms4ZjFTcXVSQ0VwOWJT?=
 =?utf-8?B?UmtrWnh4dkR5am5vOUFZcGlPbWR4SkMvTU8yYU55bUhJakxzTjlSZCsxUG5I?=
 =?utf-8?B?SEtQTUJBZXg4UDJ6UGNEamtRdjVqV0VNUy9POUErOGhlaTFsZ0xPajVRaDRM?=
 =?utf-8?B?VHFrMzhyOExnWXNyRU4zcHd0ZDdNcGIyNW9mNCtYVFJHdUFtYW5Rb1RMWXlQ?=
 =?utf-8?B?OC9hSUxuL21YYm1HbEpCbmxTMlVmSGs4czBqTExHZ2tEVzhXODcyOGZhL0FY?=
 =?utf-8?B?dWdJQ3ZnUUdqUXZVTzJhZVB2a2pxSlN1ZWRQTlhqWVcwejRpQVZ2Vnc3MVM0?=
 =?utf-8?B?cEptaDlGYndkTklaWUpjZk9IUm5NbG9iRjJsUlZkenIyZWhoZEVPNnVwWEx6?=
 =?utf-8?B?WFozd0pOZ21UdlRnYUJ1VmlrNmRjTW42OHlQWllIRGJxam9UMG5tZ2hoZEhB?=
 =?utf-8?B?VjZHM050Yi9YMzl2aXFJR0tqamNWcnd6eEZRVVkrSURpUkh3bDJLR1JCSk40?=
 =?utf-8?B?RjFDd0Rsa3YvS1JFZEVSdUlvakxtN0JPajh2Zk4xbjdsc2psT0pKdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e86e03ad-e793-4628-b25b-08deb875e04b
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2026 02:49:14.8256 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R8ECdn6AW8WwQd61fsBILcpZJyT44C29YXDoWfl1Lt3vZfup2GgON5f2fKFpyCa+anTP9IojBopvNz5wPKZpmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6962
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

On 5/18/26 7:55 PM, Eliot Courtney wrote:
> This is unused, so we can remove it.
> 
> Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> ---
>  drivers/gpu/nova-core/vbios.rs | 5 -----
>  1 file changed, 5 deletions(-)

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,
-- 
John Hubbard

> 
> diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
> index 871f455bb720..8a0e16e6c9e8 100644
> --- a/drivers/gpu/nova-core/vbios.rs
> +++ b/drivers/gpu/nova-core/vbios.rs
> @@ -338,7 +338,6 @@ pub(crate) fn new(dev: &device::Device, bar0: &Bar0) -> Result<Vbios> {
>                  Ok(BiosImageType::FwSec) => {
>                      let fwsec = FwSecBiosBuilder {
>                          base: image,
> -                        falcon_data_offset: None,
>                          pmu_lookup_table: None,
>                          falcon_ucode_offset: None,
>                      };
> @@ -712,8 +711,6 @@ struct FwSecBiosBuilder {
>      /// Once FwSecBiosBuilder is constructed, the `falcon_ucode_offset` will be copied into a new
>      /// [`FwSecBiosImage`].
>      ///
> -    /// The offset of the Falcon data from the start of Fwsec image.
> -    falcon_data_offset: Option<usize>,
>      /// The [`PmuLookupTable`] starts at the offset of the falcon data pointer.
>      pmu_lookup_table: Option<PmuLookupTable>,
>      /// The offset of the Falcon ucode.
> @@ -1015,8 +1012,6 @@ fn setup_falcon_data(
>              offset -= first_fwsec.base.data.len();
>          }
>  
> -        self.falcon_data_offset = Some(offset);
> -
>          if pmu_in_first_fwsec {
>              self.pmu_lookup_table = Some(PmuLookupTable::new(
>                  &self.base.dev,
> 

