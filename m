Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5417D606A336
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 14:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=bIHWVP8b
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 864F610E273;
	Tue, 17 Nov 2026 14:02:23 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011030.outbound.protection.outlook.com
 [40.93.194.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E13F710E273
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 14:02:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EyRicUC37UW1ppTFqUREAgiCc6gzfzSpi8wdk40yHBDjsW3BeMTAcxBrLv8zE+qSl3pz0qhNzFqkjy6XEXbs9xqhkNSTpuW9XtLTUaqUefv9IDGu8xxqWrHeXaSg9gjCsWAatZG3x5hAnX85ZrKOWVQZuBch3BU7drj/iWJvoRO8LteYOQy+9UTZRa8H+YlhEIyYR9rSRGGIL5G0fR6SuwgwpwiT9mH0bWCjXdg8U9teaXEm8G/cQGBhhNhBFDTn6MbXaclf2gse75zsRX3G/R2DzR0+KC7OkVhXYqZSZoiZd1AWL6Xu5jYaKr111/zLBL7i8sNesH3c1UpvY3siJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zn+jMr76PCBRAMgmf6pERkO13tBXseln9vP+VK/rPLQ=;
 b=U5yXf2cs57mQucsOqn5gpAvjxYhXPxdJFzha+cXYinlBYjhaeRdcSycXLnhRbELwNkz8VF83gvnPe3K6p9w0MdDSnk4prlHjzTNy+QHJ5jcGrjcOblftojKaEY9gR0Fcyb1VsRljbduYpkPZUwuo0KgG3fbTg4zF5Erd6VIekx461+Y3b9GSW+9zYZCAhqugnXsUaTFAyLwAEijI65RqW6UpzUNfvQZWIw9BWG0v8ddDv4xxTpl2zNGj0Mh0qXz3YheL9uKUlw3nwRO8t2jzGrWWXwLZAXOvn9CwoWgAoRZw59HHJp3nPiqtE5Y5jd9Ybz46Cz5ODUxvMJ36wQ9Hqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zn+jMr76PCBRAMgmf6pERkO13tBXseln9vP+VK/rPLQ=;
 b=bIHWVP8bvr64vtHEc/SxdCvUk168zQGh8HImm+0K19RHR5h3g5HKmbreEfu/wPrB2Dm/f2+7RT9zO3Fn26sNl6Ei0FWXDiPTd2UYF91VV8fUGAa4FWhl5icab6KjdSHGdOFH4J4b29VxXPYXKosoujcQRxkk4xujIVBRYksuuhvjY6HMLIfJVgx49/kyGs8Q9oYfJ7Ele/WaHThmfqGdn5iuiW4CT/8+7hkmiBpjfTjzdD/Akdh80UR+y5WWh0H9e48B2dyoIwDgW+URTWfXqqeXsOWnrH5retC7tSuQOEvIneK6q2VwzqJ/2UC2+1+WYRx77HOd9tleYtmJ83pjYw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by BL4PR12MB9508.namprd12.prod.outlook.com (2603:10b6:208:58e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Tue, 17 Nov
 2026 14:02:06 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0615.012; Tue, 17 Nov 2026
 14:02:06 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 17 Nov 2026 23:02:03 +0900
Message-Id: <DMXJHYY9ZTRO.3G2LTK1PPDIV7@nvidia.com>
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Burak Emir"
 <burak.emir@gmail.com>, "Yury Norov" <yury.norov@gmail.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v12 2/2] gpu: nova-core: add ChannelIdPool
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
References: <20261112-chid-v12-0-49ad43286dad@nvidia.com>
 <20261112-chid-v12-2-49ad43286dad@nvidia.com>
In-Reply-To: <20261112-chid-v12-2-49ad43286dad@nvidia.com>
X-ClientProxiedBy: TY4P286CA0022.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b0::18) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|BL4PR12MB9508:EE_
X-MS-Office365-Filtering-Correlation-Id: dcdd6d08-d15d-4461-cdd8-08df44b35d38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|10070799003|7416014|376014|1800799024|22082099003|18002099003|11063799006|4143699003|56012099006|261022075727099003|261026121527099003|261022113327099003|10067099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: nFu+yzVHi6sLzGmFloHMaqJ7uhjdo1JmdtgQgtOMaZmA+fpMAwT82G6jh6ScdBigl/W/bBr3MTFXDK7XJ4ZqKZ5TCH8qIeyo2GHR9vn2oAra3vWV2qlfVNGG0kFIhbozTLJKAqQ2Kte+8J5OkFWYfBXq4uLVd363AUZ6+cinO2p6zp2/HDpTG6MuzDW/taJNdwUJLumEJdc8RvExq3wViW+JSSumLGUx17XPo0t1np44ZS30iHWHlnNXaajm0HHAd65AeEDTX+gUzztp46LQLChDwQOj6GNQ6oKYmhAaZvYxl63+9JyavEX7bFJpBqYbAVX++k1CU8Rh9jDSrrschkhiHLnXL2UYJrUd38JHBhvPTN8A4xsLHMANPlnewuiKRK3E70PR+M1kWLkugy/q9cbRRCwmMEvzssluDO+s0WKI628YQR3iP7V8TAUFEUgt6i0VAIeg8n+ohDY28z2ljCtgJ3RElPw3krsFcdX4sUTZzN1A2KOEcsqlXVsYwJP4xkDEak5jj4AR35eFExMve8+3uDudNdcwVS1yZeaaPh5xusuS4xzzrEqtqcFFQ/CQgrdfT8H8W0m+G5UsiOBIHPQ4FuWVf9HJ8anz18mGOmgLC09V6ATS3uxqXcoq0szP4afAXumyOG7lMvHRuQfrVB5cR+HvrsUH8HNLkmFouOM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(10070799003)(7416014)(376014)(1800799024)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006)(261022075727099003)(261026121527099003)(261022113327099003)(10067099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkZPT0xCYmI3L3RXbUYxSnhialZYVzlEcWNSYTZtMkVLdTNHYlNSUWYxZWVV?=
 =?utf-8?B?VW9PWjVEWjN4cW5KVEFWMWNiOHJMTlcvdGxwSDhZZVhycDQ3Y1EvWDlhZEJV?=
 =?utf-8?B?b0doYitRL0tnajJmcy9uK2xiWm9HTzZBS2dmMkRHRkZueGtMcGlvMjVvdXIy?=
 =?utf-8?B?RVNSNFFLWWFIbVdDRnRtdXoxRVZJTDZ4aVE2TE16RmdGNThjdkJCcHB3N0Yr?=
 =?utf-8?B?UG41d0pCeTN5MXVQMjB3bjRVRXNaVVhhWHBLcnRsbThCbVJEVDFGSWhFV0tU?=
 =?utf-8?B?OEJpSlZSN3NEaStMRkJOVG9hdTVtNEhGSXJRVnhCaldGUW1MWlNDMW4veGNp?=
 =?utf-8?B?R1ZIM0ROS3MwUHF4MW1yc2pyY3I2WDFBMnAyQU9naTRPeGkxeGN5R2N0ZHI5?=
 =?utf-8?B?Q2pBOTVzRUxjY0RmbjlEOGNkYVRvUkRwaytIWmNqNUkweVcrbFVkUXFEOFkx?=
 =?utf-8?B?RWpNTG5iY1dZOVBVUHpMSk5iSjFUNTB2ZUdtay9MRDJDTGdkSTNUWTRabnZz?=
 =?utf-8?B?amM5MnYwTG96ZU9EaHdtdmpUdXN6NWNnQ0JMU0NGMXJCbTFub3BGNTJLNS9j?=
 =?utf-8?B?THRVSlBhU3dGTFUzNEtlbHUyR3k2M0txVW1RRmIyVFVEbGoyanp2WjlmR1lE?=
 =?utf-8?B?c2lVVEZjMFhEU3luMXVBUHk4L3JBeEhMUk1sZXZkbnZSNjRGckxjWVVnN1Vw?=
 =?utf-8?B?YUNpUEw2Z1pOM2JFbGdMdC84T1ZBaGJIWk9SekZ2WU1OemdjZ0YzcW43U2tI?=
 =?utf-8?B?Tk9PV1E0d0hmbjl4K2xXWjlYaVVmL1VxbHQ0MzBvcytLK0VVaVdmQ3d2YWhQ?=
 =?utf-8?B?bWtUbTNLSS95U2dTRC8yRnNaNk51YUZianhiUFQ2M2ZiL3QyanFtVWFEWmdn?=
 =?utf-8?B?bGlqQWFQRjdBZndLTWxrUXp3MGdBUWpreWtYZ0dscUZMWGRJSmpGOWFMeUtk?=
 =?utf-8?B?WUdJWkloUE5sd2FHbFpndm5NcWVLYWNJdUZIZXljaVJRQmwzdTVORXdjSmdY?=
 =?utf-8?B?dlJIdkMvN0hId2hiMEZWbFg0SnZlYUJhazBzb0F4a3FsQndrMzVXZzg5MGc2?=
 =?utf-8?B?cU5NR1kwNWR6eGJqSEp3Nk5DMFZVemJGNnpqSXhUZER6Q25LNTZyby8xUDlK?=
 =?utf-8?B?K0hiYXZxTW5QMEw3R0RIRFVQd3JJWWYyOHM3enR1UmFjb01haytEM1NOSmpJ?=
 =?utf-8?B?dENZQ1U4YXQxbEJrVmNqUU83V3puS2pnUklwa0JqYUFXMnZwSUlLKzRGbHJT?=
 =?utf-8?B?UXIxMlJMT1JML00wUlVSR2ZTajBYdnhEZWtmUUVQWEZRZkRseUhVQkRoelZx?=
 =?utf-8?B?cFdzSSs3Yk83Y3g1b0FWVHlVVjhSQmM0TW9YT0QxSHFMbEdNK3gxaVJmZXhx?=
 =?utf-8?B?MkNiUzVIQmUrN1Jacjd6WWFlSE5BZmpIeFFhdXowTGt1UnpueUFqOFdSSFk1?=
 =?utf-8?B?QXBYUUt2UmV3OTJNVFhWTENKSjczVVZ6RTg0YkdPZTloT0o0Z3dBRTN5ak5n?=
 =?utf-8?B?VmhqK2RZTXl1OERwaEgrNmszUlIxaXpycSs1UVQ2YVRMQTlVU0w4a1VlWCt6?=
 =?utf-8?B?RmRablR5czRmbkl1SzJ0bHZZVll0bU9CdmJ3RFhhOUtwdWMxOXh5R28wTTdE?=
 =?utf-8?B?MUQ3TjRsQnlCbjNLQTlZRUE5a3BOU2NsS2Vrdk4zRlBhZEJlOHA2cGZUbjFx?=
 =?utf-8?B?TzFuRmZtNEl4SGxYUFUyZEZSYlQ1N2hSK3h0dzhrOUdhVGh6bnJpUzFiVXFF?=
 =?utf-8?B?Tjk4OWZEZE54aC83UThzbTZ5WWRhdEJkWXVEd1pJQkFUZzA0SlV0V1RlRjJt?=
 =?utf-8?B?OGZMaDl0NEg1RlVvWXJlMVJVcnpFWjRVN0NXWXljMnFZREdMSVRkbGRBZ00y?=
 =?utf-8?B?Q1BPZk1oTXQwUUdNbXhKNjRmVjB0ZVhNL284VGh4RE05alR1dmlNWW1OMDVp?=
 =?utf-8?B?eHR1MEhIOHZ6STFpa3F5REZnWlZFN0xwWlVNZ0VaTEdJaVBSQ2x6YjdQMWQ4?=
 =?utf-8?B?ZVRUTU8rYUpoQWtQd0NOc0RPY1BYRk8rR2wxc0lLdFROUnlLeHVKNmY3T3Bu?=
 =?utf-8?B?NjhmSVFTSXFXMkVXUmppSHYwSWk2QWpjZ2I2cnduN2hwS21rZ3ZxaHZEWE0z?=
 =?utf-8?B?R3oveEt3MnJtMTFZK2lTZW1McHdQd1dKc3FNVHJsNGsra1RkcmdLV0RSOW5u?=
 =?utf-8?B?d3Q2V090d3ZQd2Z0MUd4SmM2a1lhUVBTcW11MmhvWERvZit3c3lkeGtod1ly?=
 =?utf-8?B?dW9JVzFnWS95YWdzL1BmL01yQkkzQksrQkg4VnAwWCtiNEpPUWk3RHZRcEtj?=
 =?utf-8?B?OC92UzR5Y3pyY3A1bFUxUUpNQmJMKzhUVlV4NHJicDl3YUF6Q1NVajFRSTB0?=
 =?utf-8?Q?PiddyacpAF+MM4wjrhmrKrVlCdn5y4jYAUpoEx957M33t?=
X-MS-Exchange-AntiSpam-MessageData-1: leFxDjUr6YxchQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcdd6d08-d15d-4461-cdd8-08df44b35d38
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 14:02:06.5693 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g8T2Rg6MGVKLNb5MNdr6GPjxo/+pRPVaIEV0eXT0K5WnDqdwTiScH92oY25aOsfS96mdKBiWtDNKfSDl1yEvDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9508
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu Nov 12, 2026 at 9:37 PM JST, Eliot Courtney wrote:
> Add `ChannelIdPool` which adds automatic tracking and releasing of
> channel IDs on top of `IdPool`. This is necessary for apportioning
> ranges of channel IDs to be used in e.g. vGPU.
>
> Channel IDs are allocated as a contiguous sequence with a specific
> length and sometimes a specific alignment [1] for vGPU. The ID space is
> small (limited to 2048) and allocation is not on a hot path, so a
> bitmap-backed `IdPool` is a better fit than IDA/xarray (which allocate a
> single ID within a range, not a contiguous sequence) or a maple tree
> (where aligned allocation needs an alloc_range()+erase() retry loop that
> essentially reimplements bitmap_find_next_zero_area()) [2]. It is
> also faster than maple tree [3].
>
> Link: https://lore.kernel.org/all/84bc8bd2-e292-4b84-9580-a1b5df4c5bdc@nv=
idia.com/ # [1]
> Link: https://lore.kernel.org/all/20260710-chid-maple-v1-1-4ee869055268@n=
vidia.com/ # [2]
> Link: https://lore.kernel.org/all/20260717053241.916441-1-ynorov@nvidia.c=
om/ # [3]
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

This series looks ready to apply, but one question below:

> +#[kunit_tests(nova_core_channel)]
> +mod tests {
> +    use super::*;
> +    use kernel::sizes::SizeConstants;
> +
> +    #[test]
> +    fn chid_reservation() -> Result {
> +        let pool =3D KBox::pin_init(ChannelIdPool::new(cv!(2048)), GFP_K=
ERNEL)?;
> +
> +        let first =3D pool.reserve_ids(cv!(48), Alignment::SZ_1)?;
> +        assert_eq!(0, first.start);
> +        assert_eq!(48, first.len());
> +        assert_eq!(48, first.end);

I could simplify this into

    assert_eq!(0..48, *first);

> +
> +        let second =3D pool.reserve_ids(cv!(48), Alignment::SZ_1)?;
> +        assert!(first.end <=3D second.start || second.end <=3D first.sta=
rt);
> +
> +        let first_start =3D first.start;
> +        drop(first);
> +        assert_eq!(
> +            first_start,
> +            pool.reserve_ids(cv!(48), Alignment::SZ_1)?.start
> +        );
> +        Ok(())
> +    }
> +
> +    #[test]
> +    fn chid_reservation_drop() -> Result {
> +        let pool =3D KBox::pin_init(ChannelIdPool::new(cv!(8)), GFP_KERN=
EL)?;
> +
> +        let a =3D pool.reserve_ids(cv!(3), Alignment::SZ_1)?;
> +        let b =3D pool.reserve_ids(cv!(3), Alignment::SZ_1)?;
> +        let c =3D pool.reserve_ids(cv!(2), Alignment::SZ_1)?;
> +        assert_eq!(0, a.start);
> +        assert_eq!(3, b.start);
> +        assert_eq!(6, c.start);

And these ones into:

    assert_eq!(0..3, *a);
    assert_eq!(3..6, *b);
    assert_eq!(6..8, *c);

Most of the tests could be changed to be done on ranges, which have the
benefit of checking the first and last indices, as well as the length in
one go and provide better coverage. I have done the change locally and
checked that it worked. Would you be ok if I converted all the relevant
`assert_eq!` statements upon applying?
