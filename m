Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1072F8D760
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 16:14:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 592A610E8ED;
	Thu, 16 Apr 2026 16:14:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="MERUhzxI";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011025.outbound.protection.outlook.com [52.101.62.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2651110E8ED
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 16:14:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L0kBlgm2yZ5HRtDXkzz4eyMFFkY0iyIe7Yx5lZKcL8Ab/Wnu90SdWh1fSEeN5MYjiSlya1EfHU/8uSH2u1TxPiR8ZWzHbqdqUCzdE5giZEMAK4jHgCcDc5/SodLcpf3cgQ0kAK0XIPEvpjWoWB4UuAWRyin4A9gaT4KRJGxKTFZr8nC6EAvA6f1iaCEkY/Y/+Jkli0lcppdZdZWgCYc4Fd21XjKoyWV8CaJGUR35eZyilRTvCiSxV2P1oEy4vvCB+zxdpgbus/f6Um5xRgmTB471JioLFM/a/FCANYfB9QlVY6m3wwbzpyGnVxTRKXPVVda6imWkcTTtZPTin6rY0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wlPS3Qf/eW/dZBoKCaIVyWKLCqz23h/eDwUipe5hif4=;
 b=Arrdz6wjPNqnnIDWaaPOKW+4T5Aznc0rvAbBxTfhIzDKzKx6LC2BkgBiMuD7syFyVpxa8y9ogmpf585qfKS4Fg0JigS7O/MwSY0jd05jl/ACXXhHQNE6+8UydB1HmgZYwlH0Q2HTZtEH7tH3MJfhStBsXJlSXkKeIkSHtiZhSDC/bzjf8sQUllYQccVG0TJ3YeHT30vTr8o7rvITCkGvftdC17gSFgXzlZ9spSJHU16mmsD8GJLSQoIAWT2zta52Qbnuq/PJSj5ZV6To21ofja+MnagjC3qdO7XN2xG55r9OtL57vYP1EaAQJ1qvWyQltTMzaJtJc2cDwzpxmH5vbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wlPS3Qf/eW/dZBoKCaIVyWKLCqz23h/eDwUipe5hif4=;
 b=MERUhzxIpy+ObgeRK4guvd0/+DUJH5hIitsMndHNE8cc+nsiKYkYID5LldcsbId/M07KVlEvfEui4fjUtlesCP1QsNCJVoM6BRqDMpmzLAWNiKHIzHjanpVviUmEeICrOaI4YeQgVHFAa8Smbof+survuP0SPumqeZM0tF6Vi0saNbrBMPiPj4kz8PyXscoUAETmYiiaBBsynKHcpoKw0clzo/y8SRYzuxvI9+QaDOdZvxtVXiNUM1yCVB4PheDYuQLNv8NmEkYxmEB+lNUNjmCN7NeV9bU9T/1uki6cgPN9RRgSKtLGw+cAVk21nORmj5HFnz5UT/Ej7eeQOTyyOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 DS7PR12MB6142.namprd12.prod.outlook.com (2603:10b6:8:9a::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9818.20; Thu, 16 Apr 2026 16:14:46 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9818.017; Thu, 16 Apr 2026
 16:14:46 +0000
Message-ID: <427ffbcc-f4d4-477a-9fd9-d289500a74f8@nvidia.com>
Date: Thu, 16 Apr 2026 12:14:43 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/11] gpu: nova-core: vbios: use checked accesses in
 `setup_falcon_data`
To: Eliot Courtney <ecourtney@nvidia.com>, Danilo Krummrich
 <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Timur Tabi <ttabi@nvidia.com>, rust-for-linux@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260414-fix-vbios-v2-0-705d30d16bba@nvidia.com>
 <20260414-fix-vbios-v2-5-705d30d16bba@nvidia.com>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <20260414-fix-vbios-v2-5-705d30d16bba@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CY5PR15CA0068.namprd15.prod.outlook.com
 (2603:10b6:930:18::31) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|DS7PR12MB6142:EE_
X-MS-Office365-Filtering-Correlation-Id: 88fdb57e-2851-41a7-f2ab-08de9bd3469c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: 6UyNAbJMTU7X+IZg3X88zYKZiqWmLz3y62tNW8l5a+V3XaCbF71Af6f/ar1kNY4rHKa0QvLymbBtxX6AWTxBntFXgTYIwjKbI/OpxPnz8fmqVelGuQEnh28jtJCDP8otly4PPwgerGze9Vu5yJvfju6xSRN9rbzl/eI1ztelj3QdS4ZX5UNyNRxf4cfxoxBLn+ibtDX8oZkW2aGLYVNKcgoNs/WXSEAh3IWgWl3C3eNJN6TRBzUl+7nNbaLHJmeOrzbD2Xto9tlOsG6hiQvo3trF58lbBvnZUZW0FaDsyb5DdajRHRt9k6PQTAFc9lByl7r3IXhdmHpv06D2rSsOvzRiO0v/SJU/fPmAEjweOPWcY4HvS1wEJU4PVHv89WASRY4ZfmcRrhdluDz1TnPPdHprZiAfpHTj6NcN2UVtiqMBwALwd1GXDT5GfH5fY7UwVHbEJ8OSFLXCv1aCoHSv1QQXNOMkXacoLM5AhdRRyc1+tKTuGgpXRYA4UcAkVtjBCyT/cZU0tfjxS5PwEwYvTD0fFixBuUe1KHYbk2s8XuU6r1sbbEGnQlQ1bKmx7nZtlIkvulA7xgICWyIJ59hd8sRE69Q0atQpZ6bShGXvptAd/hTUjvK19tkXBI3Qv3KSBeolSk6mcEDeOtf+wOVzngp0wCZEXnDKiHjE/IGq+JYiR8AS8RGHTyhdYnLqg6WAiH1xKU1cx9KcWcW8Sw+o+8c26+RyQV5xdLL+m+wLwkA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YlYyMlBpQ1p3V1oxK1BFcVgydmZGUm9nWEFrckFTTnRuR0dTdVpvN3NiVTh4?=
 =?utf-8?B?aEFKS0trdlVOd2drWGpoeXNoaGU5L1JvUElaaHhDOG5wRllFa0Q1RU1QTDc5?=
 =?utf-8?B?VnZDZUg0VmNVckhUTmFRTnNPaENSQWxlRHhHZmlPVHBFZWxOQ2NpT2h4bVhE?=
 =?utf-8?B?aWZJY3lpOFV4dFI1bXVvNkRab2srYTMyOStjZXZQaHFZdG1vNHpjaU1OdkxD?=
 =?utf-8?B?Tk42dWVJeFdaMjJXcTBnbUJSekdqdDJoWHZ4eVRKMzE2Q05taUNGY2VLQUFU?=
 =?utf-8?B?bG1BVlpGNms2U3htOG9hUTdCcFR3bnJhemY2WVZIckJDay9GVSt0SkR5M2Uz?=
 =?utf-8?B?UklqVU45WjBsaldJbkgxZC84dU9WdU1oOGk3UFhBdjJ2R09xdGpOY3FMelpT?=
 =?utf-8?B?OEFhOXZOUHZqS0Zjb2NhVzQ5THkwd3V4YVVXeklmMXJvcE5od1FMZ1RRajUv?=
 =?utf-8?B?THNCS3dpTVNveGcwWlAxRklaa1dzWTRWMWZLSXdpZGxHRmF0Y3dzeTZpZUdZ?=
 =?utf-8?B?TStpWWRJVnJWS1VzS3dpNGdZcExUOHBhd2VkUU9iUGgzUUNCSGFmaGNTR0Nj?=
 =?utf-8?B?MzZ2MkZMVEs1c0R3clAxT3N0c0FjL3ovcWdGRWpVazdCbnV4aVM0ZnFDaWFW?=
 =?utf-8?B?U05CYmRtakpkSzlDcWhyeThZWUxkTGsvVnhISTVIWUtYUC9YZG9HNVU5UVJv?=
 =?utf-8?B?NS8rRHlCVEV3bDdXN0QzUzhBQlp3ODdmSFNGOUtaZi9VSG0yVHdQcGtHYktT?=
 =?utf-8?B?WGliMjdOZG5LYlFSdXVFcWpvU2srWWVBZ3NFSEJlQTFrTWs3cHAvOWhaaStY?=
 =?utf-8?B?dWk0TGRmUkhhZVljclMzSkdCaWVxTlR1WURiWVB4aDBxbHJXSm1jSXF6MlUw?=
 =?utf-8?B?Qk1Rb1R5UTBTQVZlN2hTMkJpd3JERkErWnVXT1RMUHdZc25Bem0vdzlwSmxq?=
 =?utf-8?B?N2hPZHkvdDBLRGt2RXFzTnBDRmdlTWVBYWJtWVMvUE1jUW43a2F6VlpTT0kx?=
 =?utf-8?B?NnBwS0F1MktRV0svOVdEaE1YbHRpQ2IwV1d2aEhUYXg5ZU0yOUFITjRHRGpv?=
 =?utf-8?B?Vzhtd1A1Mjl4U2t3QnBVT3lmYWNzSkVMM1pMdC81RU9jbmVKNENFcDk4Q1Nz?=
 =?utf-8?B?UE14K3FnZ0R0Wnp1OFM3cG5jeUN1OVJZVDdZWVRKTjVqTVpjdjF2dTFZTm93?=
 =?utf-8?B?LzhQeFJ1bDcwZTdYUzlndTdQZUlsMktBVkpmOE50VlNVeld3ekJnOVJGbm5l?=
 =?utf-8?B?YzBvSVU3UHpyemtMWnN6bmFXbzV3TmFmR0N1WDVXODdJTDZXQ2U3L2NtMGo1?=
 =?utf-8?B?YmEwYjFQb3YwVUN2WFM2enQ3MkpEbnVUSXUrNG1nQlZuaG5Od3p5eEFzY2JP?=
 =?utf-8?B?S0RvZzEzcFdJd1VzRjR6cDJCTm84VTViV1E3U1hNSm00UjNJV0pwY056UCt1?=
 =?utf-8?B?M0RLMnRjRWk2dG5DTzFCRDJhYit4ZStFSlNmRExRbXZRNUhQVDZxbm4vWlFR?=
 =?utf-8?B?ZXdGZWt0OXFEb0JlUkRHTmhNaTJTRFI3ZE1LUFp1L3JiVXUxckRiV1NsMGxF?=
 =?utf-8?B?bzZ5Zml0OWF5SXZYRHhZRHUreVVGR2hRSldmVVVqdHRLbGl3Y2dpU2xkK3dN?=
 =?utf-8?B?OXJOTmJ0TEx4ZENHTklaazVUYlVrTnZteEExWnRCS0pPdDBSV2hlSTNQL0RB?=
 =?utf-8?B?S2Z1ZnhMdVhnV0JmcVJXb1hkVWRYNktZenNReDhvTlBiTHVLVVJkREtTT3Yx?=
 =?utf-8?B?RjIyZ1g1YmRFWkwxcUhUUzRGcmdpN0x0ajRtUXIrd0Z0VElRb3NEK1ZCYitU?=
 =?utf-8?B?Q250dzc2OHdOUnZzdjZWWGc0aG5rWGJCaGY4dUgrUzl2TTN6d3NsSkRPWTJP?=
 =?utf-8?B?TWVvVklXcTlvNGhCOWtHaHVFcjVlNDdXR0ZFOGRaRjJwR0p5cG1EWk5TWFFw?=
 =?utf-8?B?b2VRS2NrbVM3djY4MWtjUlJrRHJZUmRRM2RuZU1qbU5TU0Y1RDRoMVhhekow?=
 =?utf-8?B?UXFBU1dleklrOWc4KyttRkxVNlk5bmdQTjBNeWNYa2EvTklSQkZoN0lFSTJp?=
 =?utf-8?B?aUJoZ25FcjZNR2pXM0cybWUrOTN4N2dPbTNPbWJLampmb3JGQ2FrM1I4YzMw?=
 =?utf-8?B?amQ1aGNvangvb3NNQ3lKTEZrNXhBZzNHZkwyUXlObWpBRWh6RkxsTzc0TEZF?=
 =?utf-8?B?UHdxM21QMERhTHRKNE9CWThaN0tqYXJKQ29NTEtyOVVXcXhGa1M3MGR3a2hN?=
 =?utf-8?B?UDM2NVpaNmZNRDR1cWY5NXE0QnBEeGFienFqRlE0NXplcGdENXYrRFJIOTZp?=
 =?utf-8?B?d09Qc3JPZzdMOStBZExFbHBZTHAzSEJpVnpUZjgyV2hYSFRUMkVyZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88fdb57e-2851-41a7-f2ab-08de9bd3469c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 16:14:45.9838 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4kawrs4ni1+PkgIybRdpDOjmRO8x6VjXQFreNkKq/jpRwCsXd5WPECP1TrUlJlWu87sSscnZDXWAABtzl3a0QA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6142
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
> Use checked arithmetic for `ucode_offset` in `setup_falcon_data`. This
> prevents a malformed firmware from causing a panic.
> 
> Fixes: dc70c6ae2441 ("gpu: nova-core: vbios: Add support to look up PMU table in FWSEC")
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>

Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>

Thanks.

> ---
>  drivers/gpu/nova-core/vbios.rs | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
> index bc752d135cbf..d8633e61178b 100644
> --- a/drivers/gpu/nova-core/vbios.rs
> +++ b/drivers/gpu/nova-core/vbios.rs
> @@ -955,14 +955,15 @@ fn setup_falcon_data(
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

