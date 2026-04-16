Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36150F8D753
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 15:57:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91F1910E8EE;
	Thu, 16 Apr 2026 15:57:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="j+85DSsq";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013012.outbound.protection.outlook.com
 [40.107.201.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5731310E8EE
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 15:57:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pg7Lu0JGPpd6lQBbeiRAWoM94l8caJTnGHzYmhJFNAZDlUEs/TNqN126UvfZ1JFkA7/Mk05ZjY+qqgiOLG5YlA4xq4+qUkQWbtTfSKgYcTO3tgcovjO0P5s624uDeAn1FbC1pHYUekRxiKUBe6kPDVA9kjJwwd4+zLu3A5bGajpFjtTb//VIBc8ogcJxlohiTEOpEcbkJ/hbrPCjOOYhEMMe/jYxXcB5Ciqh0OvEhK73YWZpq9nrFTknSGaa05ElTFW8p5C5tz3IlmbwloOhocpxYtqFChxwOt7cvTvaMeW3koEu9k80jFsWc2II7WCNH0YgAh0BNdMfbtPZD7Xt1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zcd+X0Q015augMVaSXn3WcntCeVW+GWm5Yj0NxfSihw=;
 b=e8UaRjGK+7QqTaYE9UE5cvaV1HtVCnfmbaWXcqFc+6LRPuACETkqpiDEw3n8yEEYdKll9hQTpVR0wOYYAaBrM+ldTQzlCVsFUokfu/sVrLj8el/Wt8E+aQLgLVMuZVFBz/oaTdSWi5MHd+4nqzK7w1Xa1++Au+k6jaaE+e8L47GppBUfMuOav77m8nfFsvd2EzHJlNh57t7cpTxD2RkNjr15mkC7Iohh5tEorCW2kh/zsJizRONTEXEwdTHxiNEuPbBXauZd91jN71WuKkBw+G9ztzehBgZRUWoI9pRP+dXHET1/lh3kxCmi+UcnCd4hpYQ0Yxo9VSVkgBPWvF2Ypg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zcd+X0Q015augMVaSXn3WcntCeVW+GWm5Yj0NxfSihw=;
 b=j+85DSsqIGGVeDhPsvXIlUM1SVEucB1GNST+YjL7jxRBkip/s66sXRCDas9l1j4c/M2S/sR+nv4HXvyYH+wXo6l9iAfUrIosXqoquHAENm7Qz0CGcZzic7Z0rncbPWBjeAvRcB1ntF6U+62VZvjeayJZUt27DIqGGC3QmMDpSsvrTHIy5iSxiAUXexSteJa1Y0In6/5pm7per6tVPM43em3eaaJTjiH8OTo4Ae6V1HrHdbGj63+U5LaNR7inq2XsTvI7WIQbB0oyKvL7lLVwWrNKQQQ7kDPCVQt/tpW0Mcm/rCnSsllCTw4MSU/ueiA0GhNqBSQ/9p+W9SJLGwYf5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 DM3PR12MB9352.namprd12.prod.outlook.com (2603:10b6:0:4a::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9818.25; Thu, 16 Apr 2026 15:57:02 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9818.017; Thu, 16 Apr 2026
 15:57:01 +0000
Message-ID: <87656950-23e4-414b-994c-d31adf55c5d5@nvidia.com>
Date: Thu, 16 Apr 2026 11:56:59 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/11] gpu: nova-core: vbios: keep PmuLookupTable local
 in setup_falcon_data
To: Eliot Courtney <ecourtney@nvidia.com>, Danilo Krummrich
 <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Timur Tabi <ttabi@nvidia.com>, rust-for-linux@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260414-fix-vbios-v2-0-705d30d16bba@nvidia.com>
 <20260414-fix-vbios-v2-7-705d30d16bba@nvidia.com>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <20260414-fix-vbios-v2-7-705d30d16bba@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0126.namprd03.prod.outlook.com
 (2603:10b6:408:fe::11) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|DM3PR12MB9352:EE_
X-MS-Office365-Filtering-Correlation-Id: e88bab53-7469-420d-d6ca-08de9bd0cc17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: sXKQnvD1quRXY28Z2VA7rewbMiOhso/gxEAg1t8vuuClG0KzDeUqDsVRcT/iENGl4Tme/s976/KE+MdI98aHKjSVmb/EI5W5ZfpT6lcNPWdzy2aArP+ypbVavgKZHtGsLsU2jodBp9V2vmTUTpKEfWj0H3APNSqHUE/s4tkFzGeqoL9TjKlWQm7piizdTgPS5yeHJjhvK3mhcpI82hWuHV/9q9qWd3NXD7W5pWNmLlUgoOfXEtR3dKNij5wxoy4yi3wV1oFm4QyDybyd+bV9WRSa4gGq3tMkjuMDDhLM+iPOf7omQ+gPwrcEgNPfVNCyYuwXXkKeMd8MEWqzGDzSGVaD0RDYtb8QiiufyhIlK3UDSgZzG5lbXm8BNU1hE/7c2FWYzvBlvhwkdYI2+BT3Ej5gzv0w0mZ0VgoB7eeMaY1qQLRekyDR5bMUXKUGMvF6EFRN4FkHFIMe+S35W0B6FmRttM4rghsAqox4BINoUvONLxiNXXDgQQm31JGA+XwxEf+jcx06XXvA8ikzRKyVk82+gm4liWyY24hxvdb41Im8/KB9Eff058xlxHA5SP5Sxd8iX8a13U6pgXQm8FYJs4t1155cag/9SZxxTS8DqY6BGmhXqAk13F8H2Y5mLaFoP+3up0u+08FILhiqG+QTbMGSDxEVci1D/wxu+uC/94ee/P2lWNT2tM2gKwIvnLOntSsaqvBeBF0NHfnhHZr4ol32FN/82131Et8M6fkxqVw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0NFZ251eTQ5WUVxZmVqUFhKbSt5Q3V2MjQyOWlRUDZzczhjenFVbTIxekJh?=
 =?utf-8?B?dzY5SzgxZmRwUG5iSDk4OUZpUTlIUHpxTm1oblRKRk9Md29CVEkvL2pMSDlt?=
 =?utf-8?B?Z3EzNVNUTjNTM2JsNEM0RFZaMld3dEM1QlVVNHg3VHVrSmF6RE5FK0xlWTk2?=
 =?utf-8?B?S2UxemNpcDBFUDRjME9Ec2w0VXRIUHFtN2EvVDErVUtWVUVlNDM2WnA0NTJI?=
 =?utf-8?B?SURGREZ4Q2dXeEtQTGdRVWozSTBsUUpQMFRaeWd0LzRxOGZLS1c5WkJ5dGVD?=
 =?utf-8?B?VmZ5cUpkbVdNVFl0SVdHdEdsVjFCdjVUcVliQjdUSExGYmREYW5xdmwxWnF6?=
 =?utf-8?B?RXdvVlBSaGZpdkdsV3lBeEZIZGFNYlFpRXZYSE83aU1uMENqREhzK0tDOGcy?=
 =?utf-8?B?M05WTFRxS3RKNXpBZnhnRlNQWW0wZysyTng5QVdUUkFZRVVuc25BY2Z1ZmdF?=
 =?utf-8?B?ZmZMU001b2d5akJ0NXVySXExUUJMaEFydDNPMEU1RG9vTG9Tc3B3bmFSQkNz?=
 =?utf-8?B?T1NMZUVXcDIrNE4veXZYb2xPcm1hRi9mc1VtbTJKUzFERFNnUUhOT01ob3Jq?=
 =?utf-8?B?bG5WRjhvZlZ2eTZDeVdJQVB1Z2diVS9jOTBXRk1NNWRsMHJ4d1pIUHRUVnJr?=
 =?utf-8?B?V1JxeFZjMWU2SGljcEU2Vk1HSTlQeVpoektOMWVtUThYT2JVOTNjZ3B0V05i?=
 =?utf-8?B?aEt5ejY0OThoSVJ3RzBPbUs1YThkNGo1a3FqM0xLY1A5UituNWNzMFhEcVJH?=
 =?utf-8?B?NG03L085Yzk0aGs1d1hjN0wzSUVqWGJmbEJCWWErYkU1TUpFVHlqL2FJVUVr?=
 =?utf-8?B?SmYwQ3ZPNEw1V0doekVuc3JVTExVeW5NUkdZckxhbUZ4clg5ZENtUW96di9O?=
 =?utf-8?B?N3YwdHpIdmJTVnExM0tBQ1kxOXREN3BWT1lhS2dHMGIrOFlvbHIvTUE3N29p?=
 =?utf-8?B?bEx4UWlCZUdLZkVCZEdlY0tEeFVxelgra0syaXpGY0xrZEx6Znk4ei9aS2Ry?=
 =?utf-8?B?SDlrUE9uUjJQS1BmV2Z1bnp2T0lWTmtXT1dRTUxOVUdiTHNPdkNicHMyTFRJ?=
 =?utf-8?B?U2dvTTRrak5rdEhnakpXK1hsb3VlT0NDSUk4dVcrRXhEVjQ2VGwxNlVzeEl5?=
 =?utf-8?B?L0M1YXJOWUszcVcvQ3I5cENRVmhKRkYrd0xpQThzTnpDb0VTUmhmRDZlUjY3?=
 =?utf-8?B?b1BvL01QMU5wSTZaMld2dHFqdW5VbWFURG5UcDN2emdXeUtUSEUzTUxKckxx?=
 =?utf-8?B?aVg3bEVHZlM0cGtSandwZnZ4RkpDemJ6ZFArU1pTcm5QWHFITk5oMlNkN0pO?=
 =?utf-8?B?Y1V2OEl3YlI0allMY0NnQzZCK3pXejlzUDFqNDFXcXlESHNHWXVYRXROUTRp?=
 =?utf-8?B?RHlsMGp5aXQ0bkN6ZlFQRG84Q3hpSFB5bVp1MVRoNlhQUW1jNWJheFZwdXpM?=
 =?utf-8?B?aUt5RmRoOXBRL1p2UGpLWEtQUmw1T1B1MEJDUHJoM053em5oNXdLRlVFeUpx?=
 =?utf-8?B?ZW9KRUNjN2pWZFV0SGNvWERDUXYzYTgxQy9FYkRWUGtQb0V1eS9mRFVpRGMr?=
 =?utf-8?B?MXo2WjNaN05iL2RYZzRMWHpIcDBnYlA3Q0R6dDNselUrVVFmT0svYk9ONEJP?=
 =?utf-8?B?N1hqUmFQbU8vWUx5bnlTdEc0d1ZvdGVOQlZxRk1NSVJpOXdiWkQxNzkxUnkz?=
 =?utf-8?B?VWtLeUovVmVmOGlNTWFDS3Y0Z2o0Y04wL0svMWVUQXhQUE1yQkNDWThXcVJX?=
 =?utf-8?B?cDZzaGxMaTdVZ2d6NnF6b0RZZllGMU9VV3QveWw2QmYyTVd6Qmpha1Y2REFF?=
 =?utf-8?B?UVFPMFNPQUtONlpwWmxtWjA3RUt5bTNsNU9pUXFudnBubDloNVViVzA1b3kr?=
 =?utf-8?B?ZzFJYlIzVUxHanlmcmpIMzFDSjZHamNCNXBMZ1ZRMGdHZHovRVZhV1RyZ3h2?=
 =?utf-8?B?cm8rVS9Ba3puaGc1anBWcmh2YWxmZy9OV3l3RlZvbW00SkJPTXlIV0ZycE41?=
 =?utf-8?B?T2NyTU9YNHprQU5FTG9QV21RRFJ1UUFsZ2Z1TUtBTzd4M2FSTEp6SmxRMjU5?=
 =?utf-8?B?SFpOcW8zWHcvTjIyYnU1NEVMS0RETWdmSURQU0tINlgzbzVpOGhVYVdWcWJj?=
 =?utf-8?B?TGJ0eEMxRFA3QUtlcWhTUktGYlVnSmVjVkp0Q3p4SGY5VUhPWXRXdnFUMGxR?=
 =?utf-8?B?Vzd4eXM2dFdKbSt6S09LNzJVelQ5QWNRVmZLWjMzZFNUcXlMT2VJazFnY3M2?=
 =?utf-8?B?M3JWbnBJTVpFQ2YvVDkxSFVtNmpCclhYR0dKUTViR1ZiQnlmTFZsNGJtM2tP?=
 =?utf-8?B?U0RNcmNsbjFxa1FSaHNaQW9UWDRld1VQNHRUMmM1Z003aG5ETG5qUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e88bab53-7469-420d-d6ca-08de9bd0cc17
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 15:57:01.6332 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f3n8+cdGOkbv3Uj0Z7mtgjbBAoZICJYrRdfgB1Ys2MIkuQ8SNNJzg2VGgfkcHHd/xzNHT9TZT+ddtvg67p9mxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9352
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



On 4/14/2026 7:54 AM, Eliot Courtney wrote:
> This does not need to be stored, so we can remove it.

Need more words/description, but patch is good.

Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>

Thanks.


> 
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> ---
>  drivers/gpu/nova-core/vbios.rs | 25 ++++++-------------------
>  1 file changed, 6 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
> index d63af95eb642..01f65d50cbb3 100644
> --- a/drivers/gpu/nova-core/vbios.rs
> +++ b/drivers/gpu/nova-core/vbios.rs
> @@ -256,7 +256,6 @@ pub(crate) fn new(dev: &device::Device, bar0: &Bar0) -> Result<Vbios> {
>                  Ok(BiosImageType::FwSec) => {
>                      let fwsec = FwSecBiosBuilder {
>                          base: image,
> -                        pmu_lookup_table: None,
>                          falcon_ucode_offset: None,
>                      };
>                      if first_fwsec_image.is_none() {
> @@ -630,8 +629,6 @@ struct FwSecBiosBuilder {
>      /// Once FwSecBiosBuilder is constructed, the `falcon_ucode_offset` will be copied into a new
>      /// [`FwSecBiosImage`].
>      ///
> -    /// The [`PmuLookupTable`] starts at the offset of the falcon data pointer.
> -    pmu_lookup_table: Option<PmuLookupTable>,
>      /// The offset of the Falcon ucode.
>      falcon_ucode_offset: Option<usize>,
>  }
> @@ -931,24 +928,14 @@ fn setup_falcon_data(
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

