Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F905CD5BB8
	for <dri-devel@archiver.kernel.org>; Sat, 23 May 2026 02:49:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C198D10E680;
	Sat, 23 May 2026 02:49:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="mAZkwFDE";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011040.outbound.protection.outlook.com [52.101.62.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9497010E680
 for <dri-devel@lists.freedesktop.org>; Sat, 23 May 2026 02:49:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gN7PJ45P7SB+VMhFwkxY2jDQ29diaPYN3fnD/ca6ExHtdPjk/pQHP3crVwAf+lk8iwQ3g2DSEgUsLzwcEkB6m4Y3c1lAsS7ttKCM9kGch4pyEOg95VewpnwmAegtrfWBgTThr2olmwnM4IVv1Q1+A/39HJsdksJTBCuus0d3I5XyT+wLamf2o3Pg3KSDe+S5acCK7/jKj8tmzL+Y9yIpda9QfJntk030gs6Leuz02lfH0YWtdxCCW+w5EdTr8fz0PSwDlMS+16zBK5TP18i8YMH58llJ7ZzTGdI8UMEGFeQPLYFV/xjqD/tYv7tZDPeV2Iubwt1VsjrAy1NspxnI3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mp6RTiMXX6JuwfDurq6wqxz/4vXOUKAa7V7raGLXaXk=;
 b=IJOLA5V2Hj+0RRNtx9x0v63cokBEBOCz/WbHBeK067Jm4oEW/IHAgNgZ6mL0YRn/xupu+rmCYtldGFJVJyX6jUi+EAvg8qdCxxktxadcw1Pz1mFZTwd4yEYu30J1s3img0+Alm/Xbtp8z/I19VfQSIJImr2BuGNnHLyGf3HTO87XuSjVhWQ+KQrUID8XM8ex13u2F+4ZCsI8kEOSSsywy8i+RnSUm0XFUA3ok7jUtIbUUwnA1sddsF0/DIcjsNGEx8w9e2HkBJHYdFl20h2uLLfkD730b76mgSoSx1U9zi567QtvvDj4POASSCBBoFHd2OM0PJPboWd8owYreul9Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mp6RTiMXX6JuwfDurq6wqxz/4vXOUKAa7V7raGLXaXk=;
 b=mAZkwFDEXfxS9zW7OCxgOLp3S1DelV1m+qPFhCQEurYcfwC0hNalTrXBVnzLXxD+xe/yBXjv2jkRQtGzaOb/d0j6Fi/ErLmOzxhPJjEVeGVI/ei9LR4m1VXBwGt7X2DzHg64cDc7Zj3YOOxBNJQubsjRfT1pNpnNxsLH9oyy1GYqJON9qQ+Yughdle6/KS6OvkdtalePEXpeCjhtkZMDrCGunV/5bSqToaKQP87TAauMGbmDfHa7w3ZqN+Sf8PhteA4jyJdKOHRYaIOYvbD1wlS0kDcWhZDCHrtkBi/EqG2WisCwZj2gIeNatBF4UmuLODxQ6X6QDCb6kpYK/Akc8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 CH2PR12MB4101.namprd12.prod.outlook.com (2603:10b6:610:a8::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.14; Sat, 23 May 2026 02:49:29 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%5]) with mapi id 15.21.0048.016; Sat, 23 May 2026
 02:49:29 +0000
Message-ID: <3e0d895f-1f0e-4dc7-8b9e-069eb2571be3@nvidia.com>
Date: Fri, 22 May 2026 19:49:27 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/20] gpu: nova-core: vbios: keep PmuLookupTable local
 in setup_falcon_data
To: Eliot Courtney <ecourtney@nvidia.com>, Danilo Krummrich
 <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 nova-gpu@lists.linux.dev, rust-for-linux@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Joel Fernandes <joelagnelf@nvidia.com>
References: <20260519-fix-vbios-v4-0-5d3f210c5602@nvidia.com>
 <20260519-fix-vbios-v4-9-5d3f210c5602@nvidia.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20260519-fix-vbios-v4-9-5d3f210c5602@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0025.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::12) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|CH2PR12MB4101:EE_
X-MS-Office365-Filtering-Correlation-Id: db81a5bf-c223-48b6-4ec3-08deb875e8ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|4143699003|18002099003|56012099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: 1GFGyontiHGh3oFvP5oAA8DTtWJIXgbL52yfpowId1sDoBZNozeIo+BHejXBDbd14GT6FHazGhfAHCU+YjgpOazJ8tS4HKhZicW4kO+BtR6tl+IWJXAwtXT0mMOFWTZbalB5ZA95bYztu8ZkH0MUSDx0M+YYrCLjv6DfIaJmoqUsa77WMxIDm17aJ/yah7LrtwstI7tP0/2rtYVHn7NrtnWL8LfyRTCnrNTkC4TttkydgFE7R6VslXgxQC4uehFHbg4DrB95HMN9OSmxc/2JDK2xf81pp2faI809XhwU6c6cqsdFjVZjfq0wf+jFnMjnsVRbw2JjoWDSBQKpuC0uvYWPpDisY3aZfyhc0Jrs1y8VqYL3zdSD3OKidBz3KOVue5YS2dRZ18sNWgxEwpZXtrPMpwPvxzAi9TnByv6ycF1CgXGXaVXyOosW3cbSwkdsL7Zw7g5OvtMYMFTMl4WVLL/pKDUN8vxE9G9PkC6DOB1xWdgYL/wY8iUNAg6nODNcg9e8xXrMd43Hbh7uS4Dw8LbJ/5zhMvRI7unTlZzF79If8Wn6StObp60Yv0bZ1W+Ro7i+r/w/vPoGt0qnA/R1n5TbCeqRp4kWgBfMpsCImZ7PL2ce7nMNP3JkykAOput0xQVGiGnZg6AE09f8v5PWmVAjJ8JukYAzW/GSPeSvxYEYQhV11294F7/sCJiQGBZC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR12MB9416.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(4143699003)(18002099003)(56012099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VC9DSTZNYm5iZVkzT0tZdXhzc0NBNTVDSGJhbTFCNHRxYVhRWU9YcW1MM3dk?=
 =?utf-8?B?V2Z0NHhBYmxVZVZpckw3aW1OMlIyZmM3U1hCUXRTN2o5bE1oM1huZWNRR0c1?=
 =?utf-8?B?UVR3K29qSkxLZXdMRUVvbmY1UHZQWjl2eFhxQTAwc2tycG5PdHp6OERRenB0?=
 =?utf-8?B?MU9NTXFLOFJDTjQwSlROT1VCRDRnU1JXbjlPcGRqc0dackViWmdIb2Y0TTI4?=
 =?utf-8?B?TmNqcStqSzVDYUx2ZmUremVtMFYyUkEwd0gzd3AzYlhuMWdNVi9RdEZCV1h2?=
 =?utf-8?B?UXFCWmo2R0UrV0RRMzVjT0tuTmR6YUtHLzhrSSswdjVvZWdENEY1ZllkNWhl?=
 =?utf-8?B?VlErSEJHcmV2djZFQXJnNjZINXBWeWFBc0xteEJydW1GaXRBRTEwVzJzNjNy?=
 =?utf-8?B?RS9HMUM0YWFEMFk1c3lBY3JzMDhzbzM1ZVAyWG94ODMwZ2YxVmRZaEJCa2sy?=
 =?utf-8?B?YjJTRHVzdjdmTWM4QmNCMmZiTnBDanN2emVwMlFFd0JXbU9BanJMOVdFemJZ?=
 =?utf-8?B?bkhJQnZnM25jbFhjK3hhenE0M25vaUU3RFFhZVM1S2pUbkFaZ1ovWTkyMnMz?=
 =?utf-8?B?QllRNHZYVEVLZGFkQnlFM0hUaGxnQzlRazl3UjVqMVRTUDJLWk9XRE1MOHRk?=
 =?utf-8?B?QWdlZllmSzVwOHh2dWQveU5FOGRQMThQTkFVT0p5V2tOalZKZlFFR3BaVzhN?=
 =?utf-8?B?emgxODdrdXRZNzRERUpBQlNxUXNOZXg4L3JoTkEvQ05oYUpEcjgzcm1yVXdY?=
 =?utf-8?B?TEU4d21EWklCMkMvMDhFS0kvNzY0TnR5bzlOM1RqdndLbEljdVhKdkR6aTdn?=
 =?utf-8?B?WkF0R0wxNWQ4bmdRMThNYVl2R01hWk1RQ3IvczYvVWxWSWRxcnAxM0N5RGlu?=
 =?utf-8?B?L3h0UyswUTg1aml1N3NoZWlWMnFUR0dncm52dUlnYWtITzU4cUNZM2MzTFpM?=
 =?utf-8?B?K3FGOVY2SmNnY0xOaFEvVlVNRGVWSVI4VzRYVFBVdFAvRWdGVTVPQWZiTll3?=
 =?utf-8?B?emwwM1QyUkc3SSsyQU0wV0N4RzM1TmtsVGlEZ0g0cWpjS2tuMjlrZkttSnZl?=
 =?utf-8?B?QkZFUTFUOThmMlJoL09LaGp4OERPNmxGSU1yOEtvVi9rNDI3aFp1TmlRamxk?=
 =?utf-8?B?SHhpYmNta2l2a3pxNWRQZHJlQ2VwQkdSY201ajFoajdCSE5TdzA1djZNNm1F?=
 =?utf-8?B?TnVzaUJzRm13SCt0cysrd3M3RUpmL2FwZWdFU0FPOVNzc0N0c2ZGdWZVZTJR?=
 =?utf-8?B?VkVaTDloa0N1ckdCdWpUMHJNWkJCUHB4am8vQUNhQkUxNFluUjYyMk5MSkFI?=
 =?utf-8?B?dDU1eDdPaGlxRTQ0MXoyRlU2cDZ2SGMwVURvclhEK0dveUg2Wm1heTdOL3M0?=
 =?utf-8?B?K3loMmJmZGFBYXdWU1ZCZHRKVzRCK1NQM2I3WnNwbjY1TDNnR2xLTjRBd2Va?=
 =?utf-8?B?bGUrUVpIZ3ludEhxMmxZbU4zNVdieEZ3em5FcEc5MnZjUVBpQ0psdG5DdDBy?=
 =?utf-8?B?aGFkYXJ6L2xiUDg3b2lYUkp1OEFvbFpUdDhvdlNOSXoxM3hUUTl3VngwaDF0?=
 =?utf-8?B?bzJncmpQYW12MmE2eng1T1VkT0FWK0J4bzdZbm5GcXp1bDYrUWVhYWVOSTFH?=
 =?utf-8?B?alg2dVllRk9ScnQ4U2I2TnVUMUoxRFRXbldOR1BpSnFOcmc1TndRR01Semxm?=
 =?utf-8?B?YzdYd3FzZnBxSEN1R0N5ejMva1dhc1p2eG5QM1V3NTV1Uzh2WUVJWm1YbzAr?=
 =?utf-8?B?NXJsUTlLOHRZOWdVNmQ1bjlxQUNtWGxQb0xnblQrV2t0SHZ0T1czYWhFWWUv?=
 =?utf-8?B?TmYrL3dKYTk2TVdsclJBSnRtTXorOE1mbFRrRXVhRDdtYkJ5VndpTTJOalpz?=
 =?utf-8?B?NE54NmtyUWIxek9YOE1FSFU2SGxIVUY2Wk8yNkk2NGNsQU9GWUwwdXpLNjcv?=
 =?utf-8?B?UjhVYXNHL3lHd3MrbGFwYjhQdjNjV2wvNUNMemQ2NUliRDFBMnFmWmVvZnpH?=
 =?utf-8?B?QWkrb3J3aEtHekdBeGliT3NxallWMkhtL1JwWVEzWnN1RXd3VGU1TFV1NXIr?=
 =?utf-8?B?QTJQR2k3aWxEaFk4alluY2V0MlIyRVBSSXY4azNUY3U0VE9aVStpelowVUJW?=
 =?utf-8?B?YWZuVERtYk0yeEI3eGx6WnVZdC9HY29ONTd1Smo1Vi93dFBDLzJiMmxCL2Zj?=
 =?utf-8?B?cmVFYmk0QUdEWTVFTG93SEtidHVkclFGZ0JLcjVHSnMyc0lEQmVWSVA4Y1Za?=
 =?utf-8?B?VEEvSHU0anJEbUNGMGZ2TSs1VU5yRGxTVm15Y1JRSEhHTGw2MG1jd1dhVVNB?=
 =?utf-8?B?eEdQSGZwT2d6T09yQnZmbmNTSkE1WGlzOUh1L0tDQlhaN2VvZUJxQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db81a5bf-c223-48b6-4ec3-08deb875e8ae
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2026 02:49:28.9255 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N/ASeooIHIXJOrkfQJEYJ6lqKIdI3vnQrlz+90Q5gBoJSo6ovXwlNblodwjmTTlF3Ds1Vf56/yIJ9EnZWjxaVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4101
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
> This does not need to be stored in `FwSecBiosBuilder` so we can remove
> it from there, and just create and use it locally in
> `setup_falcon_data`.
> 
> Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> ---
>  drivers/gpu/nova-core/vbios.rs | 25 ++++++-------------------
>  1 file changed, 6 insertions(+), 19 deletions(-)

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,
-- 
John Hubbard

> 
> diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
> index 8a0e16e6c9e8..cadc6dcffefb 100644
> --- a/drivers/gpu/nova-core/vbios.rs
> +++ b/drivers/gpu/nova-core/vbios.rs
> @@ -338,7 +338,6 @@ pub(crate) fn new(dev: &device::Device, bar0: &Bar0) -> Result<Vbios> {
>                  Ok(BiosImageType::FwSec) => {
>                      let fwsec = FwSecBiosBuilder {
>                          base: image,
> -                        pmu_lookup_table: None,
>                          falcon_ucode_offset: None,
>                      };
>                      if first_fwsec_image.is_none() {
> @@ -711,8 +710,6 @@ struct FwSecBiosBuilder {
>      /// Once FwSecBiosBuilder is constructed, the `falcon_ucode_offset` will be copied into a new
>      /// [`FwSecBiosImage`].
>      ///
> -    /// The [`PmuLookupTable`] starts at the offset of the falcon data pointer.
> -    pmu_lookup_table: Option<PmuLookupTable>,
>      /// The offset of the Falcon ucode.
>      falcon_ucode_offset: Option<usize>,
>  }
> @@ -1012,24 +1009,14 @@ fn setup_falcon_data(
>              offset -= first_fwsec.base.data.len();
>          }
>  
> -        if pmu_in_first_fwsec {
> -            self.pmu_lookup_table = Some(PmuLookupTable::new(
> -                &self.base.dev,
> -                &first_fwsec.base.data[offset..],
> -            )?);
> +        let pmu_lookup_data = if pmu_in_first_fwsec {
> +            &first_fwsec.base.data[offset..]
>          } else {
> -            self.pmu_lookup_table = Some(PmuLookupTable::new(
> -                &self.base.dev,
> -                &self.base.data[offset..],
> -            )?);
> -        }
> +            self.base.data.get(offset..).ok_or(EINVAL)?
> +        };
> +        let pmu_lookup_table = PmuLookupTable::new(&self.base.dev, pmu_lookup_data)?;
>  
> -        match self
> -            .pmu_lookup_table
> -            .as_ref()
> -            .ok_or(EINVAL)?
> -            .find_entry_by_type(FALCON_UCODE_ENTRY_APPID_FWSEC_PROD)
> -        {
> +        match pmu_lookup_table.find_entry_by_type(FALCON_UCODE_ENTRY_APPID_FWSEC_PROD) {
>              Ok(entry) => {
>                  self.falcon_ucode_offset = Some(
>                      usize::from_safe_cast(entry.data)
> 

