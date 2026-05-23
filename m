Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 275D6CD5BB4
	for <dri-devel@archiver.kernel.org>; Sat, 23 May 2026 02:49:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7ED3A10E5BB;
	Sat, 23 May 2026 02:49:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="EO+LTHW9";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013017.outbound.protection.outlook.com
 [40.107.201.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C27B10E5BB
 for <dri-devel@lists.freedesktop.org>; Sat, 23 May 2026 02:49:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QVNDY4bQdwBMupchRA935HCC075TDTwg8K+YaiC34S+Bx1xZ4jboZCHZzOxAWUvX+r+YgN+rUqpjdZ57e6JS84jBI0Q/otIAG4AMURmC3q6j8Y6BimFRn7ny9SvwaVTR42AOxW+p+siQ7KDmeYjQsQRer3Luuf4GQOZlc7sDEI7hy2LQ6E0hpTmmmsy/iCD4SJ7Xtm0UT9BBMmGT/inmNYXBjp7Wt0v8YKXtAOsHguRuEBSDvGWbwu1B44JUIhgo4Mobt96AyJ4+rT99vcXI2rrHQV6xqVXbUMliT6blW3UuvOWhUpaHOpdjUHkR3K3zIyGhJ3/f2M6xTvLBmGc7pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U4rB8CPuxf1YxiYRqdWUsR39pYP79GytWXzjnUpTGCQ=;
 b=RhN88km3VXrRL7YvoKY+H+2lU9TzCQvI99GPZBhfEPi/jNbRpLhzRvnuk2H+Uv0w2kAlWWHXpwrl5XwNwvTJK6BYve7Q562UOBbj605h91r3Zd7Kn8WHHm4LxiHOLe30bDappDrdvsPgUZnAwW20NjtwIIs5fn/V+OWSmnjR8xekI3cxZehmj4tt4+MLOPVfFMss+dQY7YgW+QJOslabxvoDMMk/ly0ENt/ZYkFoZutj8W9kVA2vRDvR/QdiE5jCOI9R4cno/QjTdp/n23RExHy19YlCFnuCOiaIU51DNf2gKquIsMFcUz2kmFRsr+VUOWSwnHx81I5BNG5sLHqYxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U4rB8CPuxf1YxiYRqdWUsR39pYP79GytWXzjnUpTGCQ=;
 b=EO+LTHW9yCpCwdYzWVK1xXx2RfIpVRXxFCeF6bSZ0yUJOC+5r/r2tvDSRA/O7kIasqKWSGkXkWRnERQSUZrHL3o36XnlZij4Ar10CXDElhL/ryCaKbRxlIFXVGIFvnEKPCBL5kGJu0IVirU9xCkNEbjRvRqpc6QvHG0IReLV6qqt9Vm13exkcgZBwvUFpDmKfTRRJx/IsFN5qYB99QexmLBIw1jwRrhwg/1a7OsFzN688Oiq1mRuRUkTi2eayqtS/RX9ZGutUqIiyzd3JnN0GjLW/ZyvlWXTX0TgZ1xZfFJ8BLJ/ZMZ914wJKDwAyFOy8Nkya52962rsL60rhrWVCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 PH8PR12MB6962.namprd12.prod.outlook.com (2603:10b6:510:1bd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Sat, 23 May
 2026 02:49:05 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%5]) with mapi id 15.21.0048.016; Sat, 23 May 2026
 02:49:05 +0000
Message-ID: <f317f3d4-8ec5-4cb7-8499-1f9699af1b10@nvidia.com>
Date: Fri, 22 May 2026 19:49:03 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/20] gpu: nova-core: vbios: use checked accesses in
 `setup_falcon_data`
To: Eliot Courtney <ecourtney@nvidia.com>, Danilo Krummrich
 <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 nova-gpu@lists.linux.dev, rust-for-linux@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Joel Fernandes <joelagnelf@nvidia.com>
References: <20260519-fix-vbios-v4-0-5d3f210c5602@nvidia.com>
 <20260519-fix-vbios-v4-7-5d3f210c5602@nvidia.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20260519-fix-vbios-v4-7-5d3f210c5602@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR04CA0015.namprd04.prod.outlook.com
 (2603:10b6:a03:217::20) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|PH8PR12MB6962:EE_
X-MS-Office365-Filtering-Correlation-Id: 24359b32-3077-49e2-7096-08deb875daaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|4143699003|11063799006|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: Q+NIZfFLysxgagl0V9CC8VxCfz3p07aXTChE/HfKE79Zo6uKD/mAllne5U3IJ/V12pVBudYB7UXMS4Y+FrGt/jkHFYRxhf1kTzLsG0EKZzpJE4gtnaCU+Lvq7rbSiDFDKJmt5jzy0myWkmIp7TIuD265H9rppxdTNzqZB4t7ffExCzqUYg1CbcnN2ncvVa839j1iefSvzTljFAGG/9K9Zb3tP+fKRrymcs3m9YnY9VPvsBxq5IyprPXxbRFTvK0x2UmXAxGfsYx2L5L63d4TMHzH5R9JrModZrR/g5oKzV+N2jCbGMe239BDfkfboGChxCnuRJvoSitJoejdM1sPy4evmby+yZq7JoPbVKRFJwLzZxq0sFBfEtbHGl/Ce3llkj1kt28ayIrKxr7E5d9vrch9tYer2GY3ZRl+PUvwjfw0LDtM+fW3UMi/4Rdp3xLgXsuaU48Ke2RzhA0tKnX96y9DElctCvpw5Nmgxu11tQdql+tPo3B5GqVBARvxFWTVJeb/BkwZUM5csxdxLJyYCwjmsjQSLRvEvJVmNJdPgcoQPG2cAb1YvvxGRsSo3yjovqF3P8zx1pyQk35YQD9NpTZpx5hK5+E8W6irfgTnH2DbXMhWeOOIFoHyuK5Lhe9vjLL7sMvY6d+pFCb4cge10uUFTsvCdtC3z/NS2TEjqRVdM8FTQj6z5rrlOntzjRLk
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR12MB9416.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(4143699003)(11063799006)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWNzdDIxY1A2M2RoSXE1T2FHbkRFaU1oQ1dyaWhGZHZJU09ldkgvTmlRK25R?=
 =?utf-8?B?dUZFUGQ2UmZBek1zTmlia0hzcmJFU09Xckk4aTZ4Z25LVWFBOUN3TEdnRkEv?=
 =?utf-8?B?RDZEUUhPcXNUamlaLzE4MDBUNTZwZ21xdXNLa2RzM0FRdWhHWVRPeENWS1lY?=
 =?utf-8?B?bW9qb3FmS0FlVlRlTXBhcUJ2ZWwrZklBYXNUMTRCVDg0emY0d25BaXc2VS9B?=
 =?utf-8?B?UWowMEl3eURsQm9WRVZDU08zVmdPOEEwSEkzWVpVZG9IK1RhR2hsNXlFRTJI?=
 =?utf-8?B?YjkxcVFJRHRoNjk4ei9tSzRGeVFjLzYyV2pGK05KWXNJNlJjaDZqeXI1RGhl?=
 =?utf-8?B?MFNEaFNraWxzWDRqUkxyYXROdy9BS0RIOThYZU5hSStaTTV5RlZwbXhnUG4v?=
 =?utf-8?B?UXMxT2NzSERaV25zLzI5Wmw5STlkcmtETDFEbzVPU1JDTE52WGlTdGk0ck84?=
 =?utf-8?B?cnMxZWl4YzdVYzlBYVBmTlpkem9RbUNha05qOHdmdVU0Ym82UjRBZGwwUkZs?=
 =?utf-8?B?UXFiWkdhVFBqSFp3MmMzbXJVUS9wS2ZFLzFrRko4c1o3WFNuMUhtdXM3M3hQ?=
 =?utf-8?B?cHlYWUx3NFZjS1lEam9ja2dVVXFkaXZGQzN1V3NBYngvNVhEUGdFamhaaDlw?=
 =?utf-8?B?bGNZaTZpN0dkNkJ5NzZKWjBrNzlnakJ3cEljMWVpK2VNN2cwM05mY1BwT0tX?=
 =?utf-8?B?YnIwN0RNcWI4eW1MOUMza1pHNUxzdUtxMWlCOEJTdWJkclpoWElFTHRranFk?=
 =?utf-8?B?T3dweVpVSmx0VlFaU0JFV1BRbFZnT2pmVUN2Ui9jWnhMN1VIamkxRHRCM2JS?=
 =?utf-8?B?dklBcXc1WjM4SDdwQmxWcmNpVm81WEdkRlUyVHZBdGhKNlpDTisyaWxnTXBq?=
 =?utf-8?B?eit4SmRvSHZEN0wyYnJvY2lCSUtoZVE3bmVYRzdvbnUwcFdBbm9DeGl3MlBC?=
 =?utf-8?B?dmViaGFMRGd4MVNYS1BFZ1NjMlZLTGI4MXZKN2p0cWUwNlFiR2lYTklYQ0tk?=
 =?utf-8?B?MVJCODFLMThsQTFBaWFtL3cvR2REaWhiOGpJRmtEOTJPZVBjL1pvb3E1emtP?=
 =?utf-8?B?VFRxNENFRUh6T0VweFNORHhYUmdxRDZQUXBnZkJ2aWpyUFRzcHRoVDNycUdF?=
 =?utf-8?B?Z1MybG1CMm5ORzZVSm92RVl3cHNmOXMzbDlZWWRSYlJaMXBMMEN1aXhpUjhR?=
 =?utf-8?B?cUNYQXVuWWxjTlNOYzRkQXNCQzFLMDc2VGZWanB0dnpRYmp1RHdKK1ZQQTRP?=
 =?utf-8?B?SHdNZFNZRWhYUHlKTzR3U3NiOWJkbmpmMFdaVXFSaVFabk1rbUNtRmdGWk0z?=
 =?utf-8?B?VlBPVXZiMVFjbjkrSGlMVVNJVmFtWHVGWjlHY3lQSG5FTjA5UDFrVmErOHQ3?=
 =?utf-8?B?WFVtMVFpTHYrTDBpL2o0K25Ody9MU0JHRkJZbUkrYktucEp0UmFmMWUwcGdB?=
 =?utf-8?B?R1RzZEJlRDd2QnpCYksyRzV4QzZuaVpVTkxPYzZRVXpmOHlxTlVGRGxUU1hK?=
 =?utf-8?B?YXJKc2ZqbEFzNEdobGdkQk1lRnBvQlM1dFRoVVFFVDZGaWJLczZlZTBtb3hL?=
 =?utf-8?B?OEp5anB3VlVubmNlSjJXOGR4TWdRa05tdEVDRzhiTGdyWlRUV2pqc3pBeWMy?=
 =?utf-8?B?UkxwYVZ3YU1GcExWSU1FUkh1bVhFeEpFSzlNaEhEenVhNEpWQzJwSGMrRFhn?=
 =?utf-8?B?VGpXYmUrc1p5TUJ4VUxVWmlJTEFIVFVZaS91UDBoV1JxOENEZHM3bTBMOHpU?=
 =?utf-8?B?TUplKzgxRTRYeU92TWtEa01BdnN0TXo4S2ZncDBHaVQ1dzBkQi9GOWdrV3My?=
 =?utf-8?B?RGIyb2h1azNaVFpkQVZpa3drdCt4QXduMElYZ2ZFMVZsREVhWmdPOWU0YlNM?=
 =?utf-8?B?WlFqWHhFbVJTZ2N0ZWhOUkU5cHVINjl2bTVaM0NvUTREQlk0eFpjTFFPWUYw?=
 =?utf-8?B?VTZzREFKSXZVdWpJM0hRWGM2ZUdraStoYlVhMVZLSFQ1S0gwWjB1ZWVaZU9R?=
 =?utf-8?B?OFRFdFEzam50Uy9PZVNBWjZBOVZXODlEbHU0K3JmUURmMktxcXppaUV4VklW?=
 =?utf-8?B?dkdKUUtidHpIazl4dXdESEdrU0xvNlo4OVdZTFh1dlVLb0dzMTh1dGc1RFNn?=
 =?utf-8?B?blJPUzFuNVZXc1liNXFVM1plNm93UFB2MTNpS1RMemNIanBaODZGWUVyVHJ6?=
 =?utf-8?B?NnVaRzByNnJNcGlGNS9CRUJZWUh1QmxMTkVybkl3Z0VIc2tCZ1NpLytlMFk1?=
 =?utf-8?B?eFcxR013ajF5eUh6NjhJWDZZSGRjdktHcGlMYzFWRStKcE9haFlGcjg1OTJI?=
 =?utf-8?B?N3M4U1N1TWpsRXpUQm1UcEZSdEIzUmdiUnlXWHBzWmpqbXhRMnd5dz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24359b32-3077-49e2-7096-08deb875daaf
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2026 02:49:05.4171 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: imf4bvBom+hlxkb78vYqyhdXGFev+JPRTLRDmY7UlMIfMy+x8+/e7aI1L0mTDZDUgtCAU8sF9O/KTs4Pp7BEHQ==
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
> Use checked arithmetic for `ucode_offset` in `setup_falcon_data`. This
> prevents a malformed firmware from causing a panic.
> 
> Fixes: dc70c6ae2441 ("gpu: nova-core: vbios: Add support to look up PMU table in FWSEC")
> Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> ---
>  drivers/gpu/nova-core/vbios.rs | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,
-- 
John Hubbard

> 
> diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
> index 48a46684e279..871f455bb720 100644
> --- a/drivers/gpu/nova-core/vbios.rs
> +++ b/drivers/gpu/nova-core/vbios.rs
> @@ -1036,14 +1036,15 @@ fn setup_falcon_data(
>              .find_entry_by_type(FALCON_UCODE_ENTRY_APPID_FWSEC_PROD)
>          {
>              Ok(entry) => {
> -                let mut ucode_offset = usize::from_safe_cast(entry.data);
> -                ucode_offset -= pci_at_image.base.data.len();
> -                if ucode_offset < first_fwsec.base.data.len() {
> -                    dev_err!(self.base.dev, "Falcon Ucode offset not in second Fwsec.\n");
> -                    return Err(EINVAL);
> -                }
> -                ucode_offset -= first_fwsec.base.data.len();
> -                self.falcon_ucode_offset = Some(ucode_offset);
> +                self.falcon_ucode_offset = Some(
> +                    usize::from_safe_cast(entry.data)
> +                        .checked_sub(pci_at_image.base.data.len())
> +                        .and_then(|o| o.checked_sub(first_fwsec.base.data.len()))
> +                        .ok_or(EINVAL)
> +                        .inspect_err(|_| {
> +                            dev_err!(self.base.dev, "Falcon Ucode offset not in second Fwsec.\n");
> +                        })?,
> +                );
>              }
>              Err(e) => {
>                  dev_err!(
> 

