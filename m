Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92342C5B572
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 20:21:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D997310F4FA;
	Thu, 13 Aug 2026 20:21:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="oMdFBvDj";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012071.outbound.protection.outlook.com [52.101.48.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E164B10F4FA
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 20:21:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dxxf8lrE35nfEplYEAeVZUG4NrseKNohNs4fgkhsRMbQZSNzL3/9vw8Jot0QgElVbN1XFZ1xo29NshPFa1YxKrX24SoYrwpXraOuUpr++UZ0gvRIKWvVGQeLZtwHjc9GMhdQ2kwOHGcuo490Udz5wmDgPjDbZBNXfRostkeUmw/Nimwi6uadlHNpb1Y9tMLNs4CZkwg9nMbxsknHW2M0Y9ynst4LVHfc9oCN0X6zvuagCFGAgLVsnutPaJuBmfylNC2ylavFx4G51OWQMQDjZdpuKELChsFnEIG5SIJEVJ540Il7c4TU+Yo/JvTRk9DKXn8idwN+7JyUKylX8I7Eug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IM0huDaW4MllwhuQojhdYhNh6VtcJAHtcltiWdex0WE=;
 b=a3gGaTjOtCiTRX6x/vq9b7obpIhSsSv5qZpyQZWdCHRc2cT7euqNghCV2++D+S+N+pQVdILYZtGfWBsOW9wz0BWDo74HgTe42zfDAg2w7PLBdD15z1il6x6l+2244LVtSlGCKweWztxv+WGQvrGVz/eiuetvz/gsX55x+a5lw/ykDAcAj4buaEPwHg1u3OT8k1AJc/glI6UoyjjqXebw2KrWQtzDcXo08zAJsZZeQL8eVd+C0rpkA004TYt2EtpVjkw2JhV1xgNqApJfJ80XD3MssUB36iATfE0OL6mzUrpS8C0SYrI9us2zzDnBp8ck9PeQQ34AgFB/PYf4hEZPnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IM0huDaW4MllwhuQojhdYhNh6VtcJAHtcltiWdex0WE=;
 b=oMdFBvDjZW9kUX4Zvct9fRKxPrYVb5IR+kEtuaCWsickyhiJojMAnTk2k73FzODKyN6xONMDRyAh7Vzr7aTQCHdaKP5cOv9XiuAxSf7rIQfHBGYxfd4h87yzQNXaMaRO3e4H9+o273Q/6nGqCPzBk3qUxF96cCO/6csJHdxop2+yP998i58Y5Qt4wZblPkHcTCadZNfhpBO4pOTrreXf1oUQW6p182ODiA6iruY4djO/xJsfK8ifQdf6s4zFvfZ0Sv1iDnTuW8yc94e04MIWLT1VgO5jW24hBU2yd1zU2j0kHmyljcNc5PrUbLuF3iq+5puEgcLWqPAhMk4UEkYFZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 CY8PR12MB7340.namprd12.prod.outlook.com (2603:10b6:930:50::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.11; Thu, 13 Aug 2026 20:21:05 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%4]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 20:21:05 +0000
Message-ID: <69d522ca-3b49-4afd-bdb8-dd20c2923ce6@nvidia.com>
Date: Thu, 13 Aug 2026 13:21:04 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] gpu: nova-core: gsp: retain the GSP-RM log buffers
 after unbind
To: Danilo Krummrich <dakr@kernel.org>
Cc: Timur Tabi <ttabi@nvidia.com>, Alexandre Courbot <acourbot@nvidia.com>,
 "vladazaharova2018@gmail.com" <vladazaharova2018@gmail.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "nova-gpu@lists.linux.dev" <nova-gpu@lists.linux.dev>,
 "aliceryhl@google.com" <aliceryhl@google.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
References: <20260812113752.532537-1-vladazaharova2018@gmail.com>
 <20260812113752.532537-2-vladazaharova2018@gmail.com>
 <a72edc5b-49c0-42e0-b21c-940e71909666@nvidia.com>
 <5efa940cf5271c7bc0d725b7f0df365f247f08da.camel@nvidia.com>
 <aecd067a-e308-44b5-ae46-8f9947c9b44e@nvidia.com>
 <DKO2ZZQU2MQ9.B0PAI47OAV0I@kernel.org>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <DKO2ZZQU2MQ9.B0PAI47OAV0I@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0263.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::28) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|CY8PR12MB7340:EE_
X-MS-Office365-Filtering-Correlation-Id: 26e474ae-1749-49fe-c617-08def9786718
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|56012099006|10067099003|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: gBWil1g+0BbOuBF0J8khQxDByVDGxTVXQF6D1EtjcqKj8bGS8hCNwn2dyDW8iOdhYsaRJs3GDdjNZUSnSG+Dx4oy8/smLIv2ZwrvB0FlWOELWBNNHE8KwXfDMY3R3ybbvO6V1/aAyI3bneFMelt91JtmXJoSzJP1TnRJToJFWQFE7bG9+wBDFdJNjQULOKDNtyAK+N0GnHSK3hOaH252KMhRlML7YLCrn6m548Y9TgImSiPjmPnXnvBZWCKc/DC4RhGI5p6TgPaIARI7i3qb74D7ixtTkSwuPItc3sM0rdGEiYJ3xJD+w9EkWnswyypyQRqSeH09QJ0Rux5R1hQqYABdqwK+ElZmaW95nwXa/oSZZykp0Up7WCcehvVusF5Ndiv5kC5YxiNOCVIe/Ac3JiTi9E8G+OI4LMcg5HVk1znjiMmk8ZukKhJeWchHfAEURc4djywL1pM228j3MIzekhotR4mTz/+hGqD3PvDpVMcA18pMyDfbwex82X3USozSwohyPn6o+knv4FEPuvsfNNgA6XSFwC6RCBnV8fCF/8yygnRHVn608xrzF/ESs9w5/NAXxr9CnnjEkV9cIiOinVoozUKI5YMGboJn6JN7DplqjStLhp26sZkOMjElyCRpdsRuLa0yoagUf4pkQdSwKQ9BtAM5nU+n/NmMD0LQNdo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR12MB9416.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(56012099006)(10067099003)(4143699003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWJDRXZRUE9Kc0RCK3JmNUVjd1Q5M0VZdTVDcWQwQmh2eFd5dUVoK1RtcWta?=
 =?utf-8?B?K25mS3ZmcE9nTFcvUmQ4WUkrTnphT2ZlVFl2d2p4a3N3SzJIYkcyQVhUZldw?=
 =?utf-8?B?V3FGUFl1UlBXc21DZTVBdXphZklLbG45bmZ4TmtDMHVkS1g1ajk1bDZpUmFh?=
 =?utf-8?B?UUttUFozN1lYTjJxWkVkT1J1UEFtZ1M5SGEySGhwc1cxeElBbTBBTFNvWmdW?=
 =?utf-8?B?azBGZW9VeENGanlaQkE0eHpUL21CQlJCVFVpcFQ5czZRUW5yR2xZY09mYm5y?=
 =?utf-8?B?NUdHOGc3a3plSzh5cW5zeTFzQmRsUTdpSERSRFBLNzE3L1k2SjV4S01tNGZt?=
 =?utf-8?B?UHBpbzFQdG9LeTNMUlpieEFMcVFoSmlGSTRHa1c1cFJMRHppT25rMmJxQU9T?=
 =?utf-8?B?TmFYME9qS3ZwV2xkMUFQeEQ0M0Qyd0xDM1hXWUZ0VWRrUFFvZGR4cHRTUzZk?=
 =?utf-8?B?NVJHeEE4Z2FteFg3ZFRPbmwxOWpWOEpQMDcreG5KakFDSWxBclhRYmN0NTBZ?=
 =?utf-8?B?citZYWRUM3l5Z2FIWUlsdFdNZ25BOWVERlV5S1VtR1VEOWRQd1M2Zm1FUjAw?=
 =?utf-8?B?VU9KaHBLb2x5enhLdXg0STNQdjJtMUZ1Y1k4em54eW95STBJK214YUJzNkpp?=
 =?utf-8?B?TCtlYVRXMXpJNHBwRGQrdFlNZUpqbTFVSzdKdXU3TjFlanVHeGRFR1ZqL2Zy?=
 =?utf-8?B?bmVaWVdzVTh6S2d0VmhEZHlZTjJGYTEwd0VqenNKTXFCY0VuSG9TTEZjRUJN?=
 =?utf-8?B?YzJyRFBveXFkU0Z5WHc3SDFiYVlxdnpWaEtOSnhENlA1aDJaNGI3K3BSL3JC?=
 =?utf-8?B?azJxZnJadlh5bjdsQ3dMT3Rkcm1KK1FxVUpReEkyNHQrdVR6bmZqV2U2U2FJ?=
 =?utf-8?B?STE1WExVZHRKOGZHcmlBanJEY2xBWk1MYUxucTF3UVJjNDVlYVgyVGxoRStj?=
 =?utf-8?B?TXhBWmptV2MzWVJ5NnJrSFpxQVZrbXFtbktjT2ZWK2V1RFptOFVxeC9WRlNP?=
 =?utf-8?B?NmtKUWVHZGVnOFpVTldPRzdSc0lvOXpaQ1pTVnhueWJGQ3l6eHpIRWlpOStv?=
 =?utf-8?B?M2gyNkpoME1GTHY1VHg1ODZ1NnVxTE1pSWx4cjYrZXN2eTBwTTl1UThyemNJ?=
 =?utf-8?B?SE9DcDNRMjNNQTIzRllaL0p5TVNUY29oUFRuQklPblFQdERRZ1BzMnJLZzBy?=
 =?utf-8?B?R2poK3ZDdVpURXlTemNRNys3Y0lvTUI5alpsOVduQ0VGdE1XcE9tYmZNemhI?=
 =?utf-8?B?Z0RaSkhsVGdiMmVUL2JmVHd2aTlZaXNRMnA4SzZkaGg3cXlvazRaaVo3ellZ?=
 =?utf-8?B?Z05aa253bFBnU2dLOVVPWFBjWFZRNkZNR1JrOVd0N1hxeG5NcTRVOHd4QlpY?=
 =?utf-8?B?VUVNeHpJeXhvd2JjdWNKYno2Q2dtaFIxN0d4MG44cW83Tk9pTVlNbE1hdCtE?=
 =?utf-8?B?dkRvRUxkc1gxbEZGSmRvY3JidGlzTFJxQWUrcFFSOWI0YWpNREJzSTJ3UzRI?=
 =?utf-8?B?RWF4bmc0alNITjZuTnhWY1A1aDF5a2JSQnN5aWVCb0loWmc3Zm8xQzZIUEY1?=
 =?utf-8?B?dCthYTEzejlYTGdYanNka1lZVlRRaUFSbVhzMXJWRkU4UTdmTVVvMmRMWndN?=
 =?utf-8?B?R2hzSzNHTmVnSTJhTFVaYzR5ODROWnpKRzYyMjVPYWlLU2RRZlNoNFBjUGtG?=
 =?utf-8?B?aUxhTk9SSDZYUVlJTVpjd0FhSHBsSkU4OFFxRms2YUNDU0RoVVNJYjhtYUcr?=
 =?utf-8?B?K0lxb2lVZXE4ZWJpaDNIWDRrOTZmaUtwWXJXQkFxRkc0KzN1dGxpSjFGKzIz?=
 =?utf-8?B?MDJ3VlptcldYMkpsUU1UcGV0NHZFUEtnTWRLOHZOSWF6dVBZTnNYMUYveWNV?=
 =?utf-8?B?MUZqWEhKTUExeC8rdWhNY0NFaUpmNW9OT0phb2k1QndBM3N5ZkttUmRoejdp?=
 =?utf-8?B?UE90L0ZtOWNzYjFNa3BKSlVZNS9PaFdmRWlCZ0tjcmJOcWl1Um83c0xjSTdF?=
 =?utf-8?B?cjg2Sm9nOW1zWXZXS0pETmV4R1A4M0lzSS91M0M5T3VwVkhXNWNDbG1pTVM2?=
 =?utf-8?B?SE5YTEw1NWZlSFBaampJdmFPZ0NzWDV3ek1zWkNYOTFDdUVtbi94djBnem8r?=
 =?utf-8?B?Q3A2Ly8wc1lIM01HWDVzeWRNczZSVEtWY2xmb2xzVFRTZXFqaElWTk9pYTNP?=
 =?utf-8?B?ZFFQQXp3ZWI1NTRWaWFCcmIyVkFFL3RxN0M4bHV3Rkx4dEovMVpLQzkvNUhq?=
 =?utf-8?B?SEYySVY3QStZQWNySnB4QXArSlNDU1Rma3dzbTNHZU5oZm8xSjNPckVJOGRz?=
 =?utf-8?B?Vyt0U3R1WU5kN2xsNk9lNnRLblVUR0sxbWZJYU1hWGFSYjVGbW1Udz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26e474ae-1749-49fe-c617-08def9786718
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 20:21:05.6053 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 97eCZ40WEPsZP3JBWwbxeytCD5T3ns/4mxNhEoXTGkU3/gqyOmet9aqSyZxjmEVTTQ5ncyVgqQO0q9dl1dXO9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7340
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

On 8/13/26 1:00 PM, Danilo Krummrich wrote:
> On Thu Aug 13, 2026 at 9:30 PM CEST, John Hubbard wrote:
>> On 8/13/26 9:29 AM, Timur Tabi wrote:
>>> On Wed, 2026-08-12 at 15:41 -0700, John Hubbard wrote:
>>>> And so should nova! (Except for the strangely worded "keep_gsp_logging"
>>>> param name.) See below.
>>>
>>> The patch set that added that parameter to Nouveau was under review for months, and no one had
>>> any complaints about it until now.  Regardless of whether it's "strange", I think it's important
>>
>> I'm not keeping a close eye on the nouveau list.
> 
> That was back in 2024 and when I reviewed this series I wasn't paying too much
> attention on the name.
> 
> That said, the name is in fact misleading as we do not keep the GSP logging, we
> only keep the logs.
> 
> Since we're now already in the game of bikeshedding over the name, I'd like to
> go with "gsp_keep_logs". :)
> 

Works for me.


thanks,
-- 
John Hubbard

