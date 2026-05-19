Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3296BCD4F3C
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 02:42:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1D6410E372;
	Tue, 19 May 2026 02:42:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="dnSxkzy/";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010068.outbound.protection.outlook.com [52.101.46.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF74510E372
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 02:42:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MjFwccbhN+HrK111xkZutDcVJvZDl3Z18U6LycRrHYzzWdnjybDHlXXneWDiszn6/mdERX6pm/23d6gkZMnk9XYt//gDyU4OTb1uNnjUkPMptXEui7AFEvrjbRjlmRpB9rtxV48hyMyp9OKBrl87nhoJQs6uSbFP1X31iwFh9uK4nFSggpYOwMdFw8foM9hnxUbBgTleU/mjg2gcjhr13W+bndTv27JtEroIMqciAcSRRTuTVeUY9DZRgbC+p0Ikj3eMoLWeyGmeJCXe97xe8IG9GRb/qNSXUlQLlvxCkOAYXaUFJwLYzsbPWlM+YnBmtqDTI+eENNAFK8Vx/90+dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OZOHOg05rk2H4kfW0ddKfdV44HQr4kDtx0jkUMyKZh0=;
 b=OGJQup9LIjAOraetYDwUR9M+lEkPQZe2KGj95Q4WctGS9M4Q9U0DYTpczTqIxwYqay6+gRR4ThoPi2ufr14U32SBU/5DeINLKXtoJ1Y+yzKPNyqMcP5rSX0JK9Vnvs2q+rDbZ5ntFbhI/t+28a1+oM2Gh2hRZcJ0i80C0KGEik+Uh8zWZV5L6kZW/tFFq09KE6sgZoPTGyhTYQkU/ix+IKTsC/MumA+N7BkFUawO7qKdHJdloCEx42p+ywlcVlKqzR3ts9quqTiTyRTFUKg1bI5hVrd5fkl0lrDn8CUR+FXImlWyGDVlE+epj1/9zVoyMxV7Vv9/FBoR6+lWKxoVfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OZOHOg05rk2H4kfW0ddKfdV44HQr4kDtx0jkUMyKZh0=;
 b=dnSxkzy/uAT0cXTyceIn8QyVJGGSr4tjPZ8+lFKoHvMqUVdFa/YrOAwTmd10UIDH95C15zZptn7eFFs95MNSZkI06YEqzkHjbuxzu2knEZLcVSM/JGw42wEjZznnxr6xwK3mht+BAKwiwYkAvRrUEgfiGQB6hbmBZr/asieBJuMCPQq4+8LEy7FCj68b6tNKn3SlAbrQ2h1mEzFwObmVMs3uG2hrPUkSsUesCFYJ7ccuZkFH+tWcSdUoWWqyR8mt3Gz40PyUIHg/LjAPlGRkhn2Wv55KbuMqYqQrgpogE4DDIYy7FNkhM8/EbBW8uYV3MBQnXvEngrWZwvaeukWQ+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 IA1PR12MB6433.namprd12.prod.outlook.com (2603:10b6:208:3af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Tue, 19 May
 2026 02:42:08 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%5]) with mapi id 15.20.9913.012; Tue, 19 May 2026
 02:42:08 +0000
Message-ID: <b5fb1462-c409-4ddc-a6c4-a83dcfaeae63@nvidia.com>
Date: Mon, 18 May 2026 19:42:05 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/7] gpu: nova-core: run Booter Unloader and FWSEC-SB
 upon unbinding
To: Eliot Courtney <ecourtney@nvidia.com>,
 Alexandre Courbot <acourbot@nvidia.com>, Danilo Krummrich <dakr@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
References: <20260515-nova-unload-v5-0-c4d6250ad160@nvidia.com>
 <20260515-nova-unload-v5-7-c4d6250ad160@nvidia.com>
 <DIMAVKJECLKH.UXLZASCKVJK0@nvidia.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <DIMAVKJECLKH.UXLZASCKVJK0@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0185.namprd05.prod.outlook.com
 (2603:10b6:a03:330::10) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|IA1PR12MB6433:EE_
X-MS-Office365-Filtering-Correlation-Id: c40942a3-d123-4e71-2eeb-08deb5503828
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|4143699003|11063799003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 36WWCy281OgXd/J2bYGN7szNSAYcmb8SDR2/VI2PmvlETT+rJQnrxfT7zWpqYAz3UVUiUx4+zUyEF5/k8ckNWwYwCmC4G6tGNUtIQqVrEzAtbhnE9zI9RR0IROUVOYtkpBFCMSW6CFdpYhfU6NAvNV6r44h3x4zQbHK1j4RerNEB2wOgSqWCiQ3TJE0nGeDA/+2pXqKOS8IoTryycNiYysy2CZCBWEbePllWU1dcszT5D+PkDJTJ41GojeGFqHh/QzVl55ooeQf4VhuMeMs2aVYci99V0Mb/AM2rAw/HMiBhp6dHNdXe0tbpq7rlLDNx+jwdl/D5ZbUe4kFmSFBZGYbZaMiudVBLphupNi3dDrmazEVmBudMe2lfagQbj1GiN5XoImYNDneVKTo90Hah6+td2dhhgmqBXBCQ9rr/0c3B8OT04Tg5cdj+sQXZ4qNWIj4CVK+akN6AX0ahkGvYJrsr7PPbEjq3dh4t3nXJQZq/I+cZeI5TdYinbat4bJ57l/sb7rZ5byzNTK/BBVnzsOFDfmVaXlcuA/mGSKE9PQ4TAYKnz1pk7vFAooOAwcE4okkQbLKg+DLL6Xfr3JkhIhUrLRaFazIenyyMFjwFGgDGAwJ5xCFLVM3Id8yXb8O4AYNuRm6/Om0UcRAVs+AHjrgvlOl82plWi5wUNq2tBYcJfts9eMyWixOFfAxyB6Ef
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR12MB9416.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(4143699003)(11063799003)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czFoR0F6MHZybWR5MlJqWUE0dlNpbWlOU2hnSk9YQTJHcll2cURwMzdKU1ZX?=
 =?utf-8?B?bU9odkVRNTFDSnU1U0htcHBxUUdPKzFPTXJncnc3c0xyUWx1aTZuaiszdjZx?=
 =?utf-8?B?TXpacUhrTUM1T3dMRHpzSHRqUE5ycmJNa0p5akNWVkZqT0ZBcnN1NEZLSUFo?=
 =?utf-8?B?NitZZG9MNHJOaG9QUnVEdGFRU09JMXU0VGZ2cnlYY1p3dUVtQXJ0QWVmdG5r?=
 =?utf-8?B?dHl5cFBqbTJpVlU3NjBQZlFkdTlKbmpvMitMV2hoa0NhblZmcTRob3g5NEZO?=
 =?utf-8?B?b3p6VW55V1FDRGRhMWlrQ3hhTG9OYzV4WGFOdmpTeENkMXRqVVVVRjJDdm5u?=
 =?utf-8?B?emNESVRqVDRGcVVRSmpmT1dabFhrMldKRDVDd2FnY1d6anlHVWZsS200R1ZW?=
 =?utf-8?B?Ymk4S3JMUWdvbWtsTFFENWZybUcwOGFyZHdUVnlvM3IvbDRFOC9YSW1sK0kz?=
 =?utf-8?B?UGkyNlU5ME1LNzlhYlg4azFCSUJCQWJya2tsS1A3UmhoMkN3aFdNWjhMd2JP?=
 =?utf-8?B?ZVNSYWJIQzMrY0RTcklIK2lGenVEeDdLOFlleS9BMDZvNVZhTUtEMy9PSFky?=
 =?utf-8?B?OFptYWNRdmRtOHMreXNIS05MNFBCd20rQUMxNkFuUFp3RkcrcFJGdGNnMnRr?=
 =?utf-8?B?UzFyOUxZZUFPMGtaSU5qUU9WZFg5RzBsaTVQSkxySkI4b1kxcGwzV2VrY0pD?=
 =?utf-8?B?bG5tQnJtNTdzc2Rtc25QWDhNVW0wUU5PR1J3ZVE3MndwQWpDUUs2OW1uTTgx?=
 =?utf-8?B?dVpLeVQrbFpOUVdJaUFxaThXTE4ycjlpaURBdEFlN2FUUzJTSU1STjNpRVpV?=
 =?utf-8?B?QUs2MmlqdytOSWlhMlNPMDUxTERJRTRSOUJMSHJzN3RzOElRY2Z2dWd6cjJS?=
 =?utf-8?B?Q2NwbTEyTU5OLzhUYWZYaVZTQS9id0NrYjVSVXc3WUtyREFITzlSVVBqZTV1?=
 =?utf-8?B?ZFRGUzF6RUdIUmJGOU0yQ2d1ZHVsRkJRcW5OanNJOE56YzRkbExUMDVWSURX?=
 =?utf-8?B?OEd2UVZqRHRSblRLRk0ydzBYcC9lSWxpRzFZeWlSUlFzNkZSTXJNWWRNMys2?=
 =?utf-8?B?NURUelZ1dE5LT2VQN3NwMWI3cG1ZMzhHVEVBOTdqUld3QldDRDFXcGxSelQ1?=
 =?utf-8?B?UFlXRnBEbnhyM29DVndDMDg2L0g5cmxVd2JpZFVWM0dqZ0lIY0NwUC8yaS9z?=
 =?utf-8?B?U2MvVjZzWG15dTg0MThkdll2Z1F6dVhscVlBYnhsc0hnbGdycExUNkZrMUZI?=
 =?utf-8?B?RnFKWEZGaVZQWkVaL0UzMlB3T2Y3RDIvdnNqTUFqNlNpbmN3ejZjYU83dkIx?=
 =?utf-8?B?OUIwZzV1Snd6WlRxTTdKcHQ4Sk8zeDdUb1VzZ2ZYUkIzNDdHdFc1d2JQa0U3?=
 =?utf-8?B?UlR2MisyclZtMm85SW90ZStWTG9zaHdWN1hYTG1Rck5BSDIwZjhienV1V1FX?=
 =?utf-8?B?Y0RwS2d3NWJ0bEdlb2JwOUN5UXkvaVhQaTlZblA2NWlCRGZEWUxoTG9Kazlo?=
 =?utf-8?B?Qzc5NHdjZXZ2MmZFdFB2ZjkrR1lXVTR6SksrSkFWT1Y1N1VpakVrdGpPYlFL?=
 =?utf-8?B?Wkp2ZE5ZS0J0S3A1QkJRd2V6L1lHOXdYZnhJM3dQajFJb0FoZlJXc2RJUk5z?=
 =?utf-8?B?cGViZDNMeC9UUEszUlNNNERNWkRaRmw4Rmp6dURMTzNtamhqNWRmNW9yWlJn?=
 =?utf-8?B?dWJUMWsrRmxyYVpPdUNHdlIwdTBtc014WXYwZkpRK3hMbE5KbXIxNzhud0No?=
 =?utf-8?B?Q0NITzNST0hyMVU5cmRSK21ISU94TEpJNDBTMDZXeWRSdnd1N1YvUWRJZmZQ?=
 =?utf-8?B?TlduVWxhdElrRHNOZ1NpSDc3ZTlVN0ZJdnp5MU52SHd1TGI3czlVc0c1Y3FB?=
 =?utf-8?B?SHdGRWEzY3lqSGU0LzlINjA2M0NTZURrZFk4N1R5QkpXaEs2NE5NeUxrTVd0?=
 =?utf-8?B?OUMvdFQ1aGZtQ1k2L0dxTkRuNWl4WEdqU25GYzdDZWxyNm5MWUNud1kra29X?=
 =?utf-8?B?L24vdnZuL3F6VS9lWlRoSDJ5aDlhQWNJZXY2am1ZYWtQVllJQm1vVUdJYlBE?=
 =?utf-8?B?VzVzdjVUQzBVUWZzcDYzNHcyMlVxaGJSOGpMdXFCbi80bFVnZ2RjVU9Kb1A0?=
 =?utf-8?B?QWxOYjFwQXdPSGp5TGlvL2ZnRjZCb0pLR0d1dm4wTDFyZVZPVU0yY1pqNlhq?=
 =?utf-8?B?Vy9yTHcxa1YxT1ZYazhoTTNpSHlFTTJ4Rk5YakxQV2UrbGhMdzFDTkdxRkpN?=
 =?utf-8?B?YWlsd2RsRmVPTVQ4Z2JJSk1DdXJHRW1LOVUranN4MmJCSVEzWEJJMHlMRUEw?=
 =?utf-8?B?TGQxL2tIM1E5ZVNXNUVSdmxnQ0UyOHBRMFYzelhQcXdVMWtWRnJhdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c40942a3-d123-4e71-2eeb-08deb5503828
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 02:42:07.9799 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Plk+i/yGSp0Dt8jfov7TJwFQCdYpiD+d0UuoKn0OKVe2k/t/e0KuppUme14LeyQcqvZ9YMhLWN3l7pIN3321w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6433
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

On 5/18/26 7:33 PM, Eliot Courtney wrote:
> On Fri May 15, 2026 at 3:12 PM JST, Alexandre Courbot wrote:
...
>> @@ -129,6 +130,7 @@ pub(crate) fn unload(
>>           dev: &device::Device<device::Bound>,
>>           bar: &Bar0,
>>           gsp_falcon: &Falcon<Gsp>,
>> +        sec2_falcon: &Falcon<Sec2>,
>>       ) -> Result {
>>           // Shut down the GSP.
>>           Self::shutdown_gsp(
>> @@ -139,6 +141,18 @@ pub(crate) fn unload(
>>           )
>>           .inspect_err(|e| dev_err!(dev, "Unload guest driver failed: {:?}\n", e))?;
> 
> Suppose that shutdown_gsp fails. In that case, we early return and don't
> try to reset. Is that the correct behaviour? Maybe we still want to try
> to reset even though shutdown didn't work. OpenRM looks like it still
> tries the reset even if shutdown fails.

For shutdown and teardown paths, a counter-intuitive bit of lore
exists, which is, as suggested above: try to tear everything down,
even if one part of the teardown fails. Just soldier on.

Sorry for the drive by comment. I have many reviews that I need to
*properly* get done and haven't yet. But this is worth pointing
out because it is such a common pitfall.



thanks,
-- 
John Hubbard

