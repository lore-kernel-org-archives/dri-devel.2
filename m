Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 519B9F459E0
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 14:53:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31D7A10E96E;
	Fri, 10 Apr 2026 14:53:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="rYDYGBI3";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012029.outbound.protection.outlook.com [52.101.48.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3E3D10E96E
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 14:53:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SI0V5rdWx4Cq6WSMGVvq+lGA0L1rR/rfNEpaDh4JaHNiTrn5gjM09cxWFaXHe250l/RAk0FJZPIi5iOJLc1+/SGbe5dt1w0n+xricT66ZJ03vP4/LtGmTKoCAG8GJWyNB8gf0d7qF9YDQPtMC1MKVxKuP4yaMuoAR9xZdnYK3qrfbilEyo7SUrFchL1k5sXSJYj3q0bhCCUIpyAbTc9DjEs9mzngwB2f85dE9Yw3QH4GH1wQ7BDsxPizqf6eNi0RR2vTzDvnpkf1IEM9jW6+p+UhIMBGuz3W/f1jamXz9k1V62CwL8AEQPb5WVzD4G5aXl7xgtPAFtH5dgg6Ae7DsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fbmK6nxQl/LVQo8Q5jvG/3ytlZqiYgdwSoq5Rk1d4Hc=;
 b=eaj8XXZpRVifG0pN3AeDXloxqmHMiAyb+Y5U0VxKx+8feesTWqpDcR8EpDptdVQeL6dxa2dvgQg4iujOd87oLzjdc5cGM7PAGPSqVBZ0Hj6FqHUuRipB6RTEbjDxUvP99DVMRKyvsbCTH0BMfeMj8i1HStc9vmx3w4EfnNSk5TegtJjqZ+GZKis5ytt1u70ZtbsZrSmxOsotmXawweg5pcbsFkK3Dm2XvsGUFnHKBZEEXphGeG/ynu7f/pJFwmwIu9tLKb87Pb6XSDa+Pk6JVB/VFKI1vptCrK7ybsFY8e8S+9PAo04f5/utx5NXL9aPYISKWsT+QiKYIK5WfIeizg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fbmK6nxQl/LVQo8Q5jvG/3ytlZqiYgdwSoq5Rk1d4Hc=;
 b=rYDYGBI3eFLx9t2K3PaTCFgOSs+DPS+e+Au1n97ZOgz/PV8aHJkJV+Qxdp9Ch1kTSAV06W4oxeKZFZB11g/bHcjWn9dXzS2n9VAJfi4OMchSwTCgYRCpNWW2GHut/H1/oYXTx35VGHezF+TGWUE1i0f3PJVgfG/j1ajBr22u0AtTaFPxzxZS1M4q7ji3MNbn5XHNq9fIEy8DJzIlwqTF6lKDoFOrDHq7HBu9SCzo4x/s0V0ku7Y/kCnFne9KrsvmOMCpTZ+MUzynkii+J3haH0ZkrFZh3a5LMtvXY7Zm7cSPeG3AFjoNcKUewTu6OyZuhJ1rWghiGVgINA0F7uskUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 PH8PR12MB7303.namprd12.prod.outlook.com (2603:10b6:510:220::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.42; Fri, 10 Apr
 2026 14:53:17 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9769.014; Fri, 10 Apr 2026
 14:53:17 +0000
Message-ID: <8bf30537-de54-4be0-a676-3e8aad6fb312@nvidia.com>
Date: Fri, 10 Apr 2026 10:53:14 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] gpu: nova-core: vbios: use checked accesses in
 `setup_falcon_data`
To: Eliot Courtney <ecourtney@nvidia.com>, Danilo Krummrich
 <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Timur Tabi <ttabi@nvidia.com>, rust-for-linux@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260410-fix-vbios-v1-0-bc6f71d153d6@nvidia.com>
 <20260410-fix-vbios-v1-3-bc6f71d153d6@nvidia.com>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <20260410-fix-vbios-v1-3-bc6f71d153d6@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CY5PR19CA0025.namprd19.prod.outlook.com
 (2603:10b6:930:15::28) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|PH8PR12MB7303:EE_
X-MS-Office365-Filtering-Correlation-Id: d6a1a8a2-0742-4ee3-716e-08de9710e62a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: yd965hp/eAI7ugcB/1eR1Tk+r2oPjFM8KYPMgQRxzrQJQrJcJlYgnprb/A2Qyx90e6YpZTq6WgBU59TpMJvTArzzguQLrFO/tVrek+NrxXT9YAuzXhnwqNLQnenuzL48F6VV55POdo2hZ1nm1cTUu8iLdTZBq8r4RcgGDOVNg1bm+bROJCx1YuyQsnwFgfimToh7oVqDIsvwVEy0vviP7MxeUOLnq+QIyDRd5G9Sba7X9cVQnR4S6wgoyMEtat5wTHowL/PU9RrycO4kAKZb0QQs/4fV0D6lZWAKjprE5FjFAIGHgRiBxVJgkqjZ+Ii8Ar3AYaLIQzfMlUvP6GiJ9IRL/d7nK13oEsozM4kyfbOiEbK029/jpUtoQDuMMSL1ypMga4YEqlL7szF2v9Kj1gimcJ6DLVVhqOHtz1FNpcGu+g/jiHlwvRhbvt+iQFJgDfu7alIlwXGsBUeSZMKdqBAykdPq10/wQL9rlHBus+UrqjnSEWOjcvu8gxL07IDfPeA0WfnaF79uXhhNjXyBB0DRP6R1V54Nbtk6sUXjvD7SKmul1AP/lNsXFyf7XO8uw8VuV1zL9nD9vMb7Jhrn3r8ijGSsrpstkl4e4YcXlKRN+5t8nUB7Kd0vBdPhoPGOJEJDHGeWAys4qxUKMiUBDg3uYdhrUXvSzwTM/E9L6h6i4UCOvG9TD2kz1yJ3ezjGxF+Z1QHdnGsFhVXhqgyFzZJcb6IssvbMzD+gewniPQA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0dnbU5PbzhkMVBXVEdPQlo4NzBQL3RXd01iaVB3aW9zK1ExdkRCSEw0NlFp?=
 =?utf-8?B?MTliVzN3cldxWU0wTzF0MTJXaWUwU1N4VnNzTThwRU85M2FjL2VlTHhEVjFa?=
 =?utf-8?B?UnE4MFA4U0lMYUZ6ZmFmTEpDdkdFZUQ0elBRZzkvUlBLcDZqemtyOXpjZkZG?=
 =?utf-8?B?MnZRbjZOV2pnV3REcVgrczBORVFJbE9FbkVaZlNCd3FDYTRabCt4d0NDL2Fv?=
 =?utf-8?B?ckdiWk5yN1F2UXJVOFR3dTZoQkFOcGp4MURUdUFGNzY3Y2FnT05iTEF5MHIv?=
 =?utf-8?B?RDNMSkRaMmRILzJQZU5qMjlGQjNRVEN4c05NSjJuZzJ3STRVYmt0Vm1mMjJy?=
 =?utf-8?B?dEJmMDhjTER6cWV6ZkJ4dXZYbnVCTWJOTFJGYlRHRm9qNW5JUGxaMTJscjJw?=
 =?utf-8?B?M1ZscHN2VmNXNzJDMlVuUWFvODFhT29nSXc3cVpjQU85MTZ5VmVKKzQzVUsx?=
 =?utf-8?B?U2x0NUQxcTlYbzRORFloNFBNS3NRbExIeHVqakQ4Wm5sSUdoMXljMFozRTZT?=
 =?utf-8?B?bkFpVUlrU0M0UThLbEJOYldDREFmTHZRQnpISTJSSlcvOVB2RDJhTlhORmlN?=
 =?utf-8?B?VktzejNEaTFwZGhjU3I1aFh6N3g5TjM2RDFBZ0xBRnREQmZNd2hWcERXdThk?=
 =?utf-8?B?dHRMbGozVG1MWmhWVmF5RUlkZHExSHpDZXY1Wm15WGlySW96UWM4amdMbzRx?=
 =?utf-8?B?SGlBYmZ4dVFrTmdNWDNpNFU4R0I2dS9ja0syU3VuL0RzVk5qKzZETHdkRHRQ?=
 =?utf-8?B?ZmVnclBFOGZySHdYL25jbG0zMHVlNFJEMzFKTWViOElvbDIzeTNsY3hVWlJM?=
 =?utf-8?B?WVpOKzcxNUl4MnpteDJJeVNIbit3dGVERVVVSktpbnh3ZGhUcGhIK2JGWjc0?=
 =?utf-8?B?bGZ0TUdVUXpmNEJ3dWFuKy9YU3RZaXE5bm82dnRQVHBMMk1HdjFNZ0RsaDRw?=
 =?utf-8?B?dG5mZU1laXBBdk92NTVUK01aVlQvM0IvRmtIRnZNRXpGbHRjY2Jzdm5FWTJw?=
 =?utf-8?B?dTJQVlNDVjNUT2FCMkNHZWhiMURPUjBKeXVnT1daTVJmQm84T3FtMTVIWEF2?=
 =?utf-8?B?TDJuSlR1aUt5WGFWOWVsTEIrOTE5RnVDREdncGhlQlpmQk1QVmxkT3dDMEs1?=
 =?utf-8?B?aEl0QmRNcnFSbm9LVlp3eGdnUTNSeTlReSs2L0pXZ1hIRXRQV3ZJRjJMY3lS?=
 =?utf-8?B?ank2THJQQ2Q2dDhFYVBDaTFUa283NzRhZk9tSUNNR3pJR3d2cFdTU2daTDB4?=
 =?utf-8?B?ekVROU5lNTlERzd2RmlnSW5TYWdRTDQ3b3hsOE9sWkJpUDBKYngxT2pqR1Np?=
 =?utf-8?B?bk54Qk9QVG15S2NtQXRsb25nVzBGc0s1aktNV2UxaXhFMjdMVXRlRHVSNHpE?=
 =?utf-8?B?c0l2SStZREJ2dUhEQksxOFE4MUZLTVF1VW1vYkVIbmMzRlpRVHkyMy8rTm9m?=
 =?utf-8?B?aE9nYktseXBSbkw4bzhPVklYWmZ3a1kvTUJLS0ZSbTBUdkJ3dXRKdE1IdTBH?=
 =?utf-8?B?Q3g2WVJSbzh4NjdXTXd2WWlycG0rMzlFRGhOMksxdUhXN3dFYUVEMkVpemx5?=
 =?utf-8?B?RVd2SForSXoxK051d1o3bWMvN1VhUGcyUm9EeHJVdmZ6dnpkSTlkOE15QWhB?=
 =?utf-8?B?dkNGVkZFbjRRWVBZQzNDQnIrc2NXaUU1M2I2bExyalgzeFllNVNyb29CMWxI?=
 =?utf-8?B?RStxdVZzT21XcXArWmN1ZklMZktxZ3ZEZlpiaVI1N3NsY2tzYW5oRkNIZUln?=
 =?utf-8?B?L1hkU2RGeDVmS1FqeTR6VFNZbVdQT1Fxc25Za3Q5Mm9VemtjckFpRUMvOEUr?=
 =?utf-8?B?RDNPZmZTV2YrNGJIdUI2dkNjOFgwMHR3eXFYZ3FtUHFNS2RzK05NMytXYVJ6?=
 =?utf-8?B?UDlvOVJWNitHVXFaT2tLWFBTUnpMRXZBYXJoZHpoeG8rbTAvOTZ6b2x5K3ln?=
 =?utf-8?B?YkFUQW5hMEtRMGNGcDZrdzBVZG1DaDF2V3JGckdtYW01N0RrV1hteTloYXQ0?=
 =?utf-8?B?MHRjd0UrZzZMdi9KYzBzUWJnVWpjMmdVcThrOTV1eVJYd1JXMDdJM3BSbHpE?=
 =?utf-8?B?TGNFTTArTCt4NXFRcm9Pci8xbVVZNUhERGxZdU1US2JGQTBHbUx0TDVHaFky?=
 =?utf-8?B?RTNSZnoxTGVYcEx6dGlsYi9WTXk0ZXlBVnJNWjhncFRmbzJSUW1qNFp5aWlh?=
 =?utf-8?B?elNjUHkxTk1SN0RnTmtmWnVZQlptbUNGbFUvWlplNlZQWWV4bkdyb3ZwTlBI?=
 =?utf-8?B?eWh3TzlCUUgzRnp1RnVkRUd1ZDlrbmNrMDNBbWZvSmNyRWxuT05XdXdNMEtU?=
 =?utf-8?B?Wk9SNDdzY2xuaDJaWGpxdVZhN0JPQ09FRjl1M1FXb3dMc0tkNWVqUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6a1a8a2-0742-4ee3-716e-08de9710e62a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 14:53:17.1830 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /xksiZ3ep12cuV5FSCi3/AOEw6RcW0/XxQoXeUFn5xnsWtRF/xf1ya9HG03QnxfgfHxrIY8KnDk6hJI5BTZWfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7303
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

Hi Eliot,

On 4/10/2026 4:38 AM, Eliot Courtney wrote:
> Use checked arithmetic and accesses where the values are firmware
> derived to prevent potential overflow.
> 
> Fixes: dc70c6ae2441 ("gpu: nova-core: vbios: Add support to look up PMU table in FWSEC")
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> ---
>  drivers/gpu/nova-core/vbios.rs | 20 ++++++++------------
>  1 file changed, 8 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
> index de856000de23..2b0dc1a9125d 100644
> --- a/drivers/gpu/nova-core/vbios.rs
> +++ b/drivers/gpu/nova-core/vbios.rs
> @@ -936,17 +936,12 @@ fn setup_falcon_data(
>  
>          self.falcon_data_offset = Some(offset);
>  
> -        if pmu_in_first_fwsec {
> -            self.pmu_lookup_table = Some(PmuLookupTable::new(
> -                &self.base.dev,
> -                &first_fwsec.base.data[offset..],
> -            )?);
> +        let pmu_lookup_data = if pmu_in_first_fwsec {
> +            &first_fwsec.base.data[offset..]

I suggest use get() here as well for consistency with your use of get()
further below.
  first_fwsec.base.data.get(offset..).ok_or(EINVAL)?

>          } else {
> -            self.pmu_lookup_table = Some(PmuLookupTable::new(
> -                &self.base.dev,
> -                &self.base.data[offset..],
> -            )?);
> -        }
> +            self.base.data.get(offset..).ok_or(EINVAL)?
> +        };
> +        self.pmu_lookup_table = Some(PmuLookupTable::new(&self.base.dev, pmu_lookup_data)?);
>  
>          match self
>              .pmu_lookup_table
> @@ -955,8 +950,9 @@ fn setup_falcon_data(
>              .find_entry_by_type(FALCON_UCODE_ENTRY_APPID_FWSEC_PROD)
>          {
>              Ok(entry) => {
> -                let mut ucode_offset = usize::from_safe_cast(entry.data);
> -                ucode_offset -= pci_at_image.base.data.len();
> +                let mut ucode_offset = usize::from_safe_cast(entry.data)
> +                    .checked_sub(pci_at_image.base.data.len())
> +                    .ok_or(EINVAL)?;
>                  if ucode_offset < first_fwsec.base.data.len() {
>                      dev_err!(self.base.dev, "Falcon Ucode offset not in second Fwsec.\n");
>                      return Err(EINVAL);

How about replace this whole block with:

  self.falcon_ucode_offset = Some(
      usize::from_safe_cast(entry.data)
          .checked_sub(pci_at_image.base.data.len())
          .and_then(|o| o.checked_sub(first_fwsec.base.data.len()))
          .ok_or(EINVAL)
          .inspect_err(|_| {
              dev_err!(self.base.dev,
                       "Falcon Ucode offset not in second Fwsec.\n");
          })?,
  );

That way, the error message also shows up when
checked_sub(pci_at_image.base.data.len()) fails and it is a bit cleaner.

If you agree with both the above suggestions:

Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>

thanks,

--
Joel Fernandes

