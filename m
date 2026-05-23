Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23DB7CD5BB4
	for <dri-devel@archiver.kernel.org>; Sat, 23 May 2026 02:47:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F10910E58A;
	Sat, 23 May 2026 02:47:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="qe67xK2f";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012009.outbound.protection.outlook.com [52.101.43.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8565310E58A
 for <dri-devel@lists.freedesktop.org>; Sat, 23 May 2026 02:47:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aMc5nnGhATBH2kqVGjRXdhmqrHX8V0fJPYPFBtHGrMuFLrXp9p8p4gK+4l0n/2Cml8++/NceVzBBfs2RDWOaaIeBFZ8eARhgwoILQGr1X39n0VCB3mP+SW9p3C2Bcrdmqu/Tz3V6CQf3hZ5yatqzcjdIjTOSXobp5H5DHIjdU0Z+z6t2BKhRCHehweUFe9sD8w4kfRszeDn7t0p8vkTM8AVv4YX1SK1UdhwbLn5P7NibvXmFZhRDOsVeVy9+ueSAA58Ze+jdSbMYKzV684zxTkJAgivYTGL12y/bXYHytNaXYpwxHwsmfbyiJOhh8jTmHSNlPG4PX8wmFj0xJGujYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ybNvlj4sDomkATggwKM5Mtpcc1lK7h3Dx2P9HEScDwM=;
 b=ZxcwDXbvqioELT8E3PvchoF5catIS8IqeuwJHPtOIX64V+eY5NqlzP83tWz9sFzRQhoXXyqHXsP2fC1V08omk1EkrjdHKOvRhHO3whxbQIdcN7nmPrTS1a7djBPjUKZe7gCyAqHzH7PhqK9AMCXVWR4JPuVPECAJys14b6CDYYwOwJJ7PU3qSPdrp6dLQbYGAQW3LNO1gqXnC8dAA3eQg6YEV88d85RcLpxmpIKn7hSkZP5GJ2cl0+eBryWiXLGm3w91fFzp5xmfIYZXYEehxvNuj9gM7lt5E6kqfiKbx5eX6JbqqGLbH7zHFU3DH5YZhBxxnv6yYeA6ZCRluEOUEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ybNvlj4sDomkATggwKM5Mtpcc1lK7h3Dx2P9HEScDwM=;
 b=qe67xK2fEPw1RqQAfYs2zTk4ncJ/+m+2Srw3AnNuLUdmFvTWIcc+ADjsIahn/oKhkEm76cHX5HdNqgTZIryf3nkSpQyxNSZs5IyAS/vx2X0/XE/wkQgyTNggOYiYZ77CuZLLH8d++eZfbEuKVjhGZHw1huffZAv6Y/TDvjwiSplOw/GczRSUNapQfjpiCZcnMjB58H8nVOq/JVH3mdpVzy7drFe67MT9+vVBi+j6RR9TdQ7Qz8TrO0yNUo1n7CeJGOztpPRv7nXqWzIUMQxT+EjNI4L9DD/Cbsl1tJ+dRyUSqo37ey49cdSzgYcbUOBqbnwitpqlxneKKi9uoEXt6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 PH8PR12MB6962.namprd12.prod.outlook.com (2603:10b6:510:1bd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Sat, 23 May
 2026 02:47:46 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%5]) with mapi id 15.21.0048.016; Sat, 23 May 2026
 02:47:45 +0000
Message-ID: <82987f7e-c859-4563-8d4f-e77dcdcbdf9b@nvidia.com>
Date: Fri, 22 May 2026 19:47:44 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/20] gpu: nova-core: vbios: use checked arithmetic
 for bios image range end
To: Eliot Courtney <ecourtney@nvidia.com>, Danilo Krummrich
 <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 nova-gpu@lists.linux.dev, rust-for-linux@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Joel Fernandes <joelagnelf@nvidia.com>
References: <20260519-fix-vbios-v4-0-5d3f210c5602@nvidia.com>
 <20260519-fix-vbios-v4-2-5d3f210c5602@nvidia.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20260519-fix-vbios-v4-2-5d3f210c5602@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0018.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::8) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|PH8PR12MB6962:EE_
X-MS-Office365-Filtering-Correlation-Id: 3eb49319-75b8-4bea-f5c5-08deb875ab43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|4143699003|11063799006|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: rU63b4zwIneVAvi1E1X7NZjNQCA3qZsiXhni8uWCYwMYO9AdJdAkfRsjDN9pN4Qs0uvPJpJjMEfLjrojXVtowNZltOvQrRtDqlXxmoU4Kp3mghGpIptT3f5rp6lXUPFzbMKt5IshBFDx9MQ59qIE1aTOXXFFiywnyamkW4U6Y/H7WjPlN7gHHhrnyr21yIt+S+N/DdOa29TGVy2BVfre+t3tUjQyIbSdumnJS0qbNsEWIguiXUn6hqRmVd+JF7oys+j1KfCGnfo+gMTqG4MnNy9BDam6asU2EBbLoO4GnqqS7dowzMkDDcnAuonpQ+5Ap/+LEQuVa3USR4a2enAiFo51hgdcWQw4NIViY9h53ziWFQUL/GW70dUj5rqTGmKFNVjWb+9oZgSrNOOu+dgQNjALLxokEquJ4Z+lTuZRUn4wnzfUfm3ZnqsAfaMnusVEKUeVqfPAMtIibNE6dLKZ0naJ4rMvbzgcHO0SOgmm2dKBUXjStVaeuZdreYYXZWakFqYvg64C+0/3QII5zwCA1RX5IqGc7KAtvZTB36Gx7TvDz9bpe2/7lUHaN2jR4I3CbGYusx7bs1FeWn0p6vNrWuiHqUj9tjiiiugcz1fOhl+KPYbMCCAu/Of/LUSqT8cBzl5DwbV+a58vEecS89K48425cPdZMpJEo7MhyHGbqLn3hdCgCvRK5JsqjlYazJX0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR12MB9416.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(4143699003)(11063799006)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFlXMElUTldpTEdsR08rTnhwdnhBQ2s1cFNFNGFiUUpzdlNzc1BRVHZlMEcz?=
 =?utf-8?B?TThnelVDSmtub1F6RUsxWjFpTGl1bkJvb1JYQ3hCNDFzRkI5MDN6TWlGRzN5?=
 =?utf-8?B?NHhVM283T0Q1MWhTMDJMVitYZC9rL1ZKRUptUUxWTCtzSGF1YjlhOWVxalh0?=
 =?utf-8?B?WXdsc3d1Zy96QVdUMWpFa0o0VE9mWS9uY2FXcEgwRC9EZDZYV214Mkp3aXR5?=
 =?utf-8?B?NVozWGVDUTljZ0xmTG1pTnpQSlM2Q2lPWGQwZU9IVTFHMUM3NlIvOUsvRTNs?=
 =?utf-8?B?TlQ1K0RRT01yckZYeFQ5ZGVTRDQ5VTBiNEFsdlhseTVWelVqaGVGUFNWYXY3?=
 =?utf-8?B?Wk5rclJXSVhmRFdZT2hySG1oQWN4SGNUL2l3VHRFTmlTaGovYUxmUjhPTDRl?=
 =?utf-8?B?QUlaaGdXZnVwTVRidTJKOTRscEFVK1NsOGw2cXBrNFM4V3l5bXpYM0JtU2NK?=
 =?utf-8?B?bjBlYXdrWkZIZnZuZjg1c244YnRkMCtVMFJDMEN2UW9aNWEycmVwYnNZdFA1?=
 =?utf-8?B?R0FVc3lyOTl2L3VkQmd3OFpmcGZlbUxKQ1I5QUQ3RzdMVkQ0dDkwU1pERUZJ?=
 =?utf-8?B?YUwybDJGWkwvNWxkQWxiRWovMFA1M2Y3RURaZ2cwUTR6VkRZZWhkRTM4OU1J?=
 =?utf-8?B?NXREaEZxSEFtUHZwN0JtS0JaYTVIRzJMbUJHcW4yaHNhcUo2N2ZkZWJHakpP?=
 =?utf-8?B?THk4bFhzbnR5ckhhSnA4NjRnZm0yZll5OTF4NXBXRWxoYzRGUUV6NjlPWm81?=
 =?utf-8?B?ZUd1OUY4WDdPVFQ4VWdCYmkxdzNRQUpTWjJWWDdmN3lBdklxcDA1a2ZSZHNs?=
 =?utf-8?B?T2ZNVjVMMFpqclp1KzlxVU5MTFc5V2JpeEQrWjRLYVhtV1lkaEFyM2U4VjFv?=
 =?utf-8?B?bHo3K3pxc0M0RVZTUGRRRGdoemFybkRkOUE0NUk0N3piREh2SnFucE9UZGtO?=
 =?utf-8?B?bHRzSGVMOG9ROEd4cE0ydThDTUZyaVlEZ1FobWZncWJpVmZmV2N5Y2lsZlRF?=
 =?utf-8?B?NDZKZWpSazl0ZVhYSEVsTkQ2YlIrdFd0MFJ5TlowVlZhL2FzRUxhZ1o1Z0Zi?=
 =?utf-8?B?WjgvVGxveWJGU3grd1pCQysyNlIwZEY0OFdyVW9ZZjk4ZXlyZUpUVXc2a3Nk?=
 =?utf-8?B?bW0rZzB6WXc0ckRXT250RTcxYjRldjN3U1lpaEpKVDFWZTRMaXJBME1OdG9Y?=
 =?utf-8?B?bXo2MmxQeDV5Z1dOWVpPT21Ec0N2WmI2MHlzMlZycDFvQUFEUHBLTVg0WHps?=
 =?utf-8?B?bUVLdDVMS1lkN0QzU3haSmFDd0lYYjZSK2RhbXZweUJlOWVKZXZ5YnE3dTJZ?=
 =?utf-8?B?MDBpeEVYSDhhYTVqVFVtc0RRdlpqd0lGdTdGWFJnelBDa2k1RTlmdE9sdU9Y?=
 =?utf-8?B?QkZqSHRRQURObFRGdjNraVdpLzFlOHhmakE0cEsydWszeFFlcjNIcjZ6QVBm?=
 =?utf-8?B?cUthdWEvSlc2SHkzdU1XampWdjE2cDFCV2V4Z0pYajhSeTFWbndNeEhrTWZv?=
 =?utf-8?B?bzdFU0RKZm1yOEl1aDJ0YjE0ZzVERW5DUVExNXg2MC85K05mbzVNeDdBc0hz?=
 =?utf-8?B?eDcwMzdXbUx2MW90Qm5rT3FaL0k3RnhJd1hwUTdQaFlwczNvc21ZbmhGU3FZ?=
 =?utf-8?B?ekxEL3hMNHYza3pOY3E2cmNIcTBzelFHODlvVk1qbERNK2Z6RTAvOGZRMW83?=
 =?utf-8?B?cURnM09Gd0VsNGNyRFZlb0VYZ1ZiSk5kMzlqbHlvd2hnazBmZHhteGh5TU4r?=
 =?utf-8?B?QitBSTlxNnlHcC9ZRVh2Z1NpQWhUR1ZzQmZKM2FzSHpGbHpTM3VCZ1FEL3J4?=
 =?utf-8?B?T3kvM01TUE9BRkFjb3Q2bkZ6eTA2VjJxVnAwRmtVdUI3UThzSG9MbzNYTjlp?=
 =?utf-8?B?M3hvRjlUWGI2V0V4aW9JL3paWDJ6Y3l2WHdUMTQ3ZnFDZm1DSEFwZzYrSXJ1?=
 =?utf-8?B?SWdDb1FkQlhOSlZ5clg5UHNvTWdVdDVEazlxekNJOGlyZFFVKzEvMHVTa2dF?=
 =?utf-8?B?QVVFRFp4eHVVYW1KaU56eUs5MnBIaFRMZytKY0R2RnpSZWVHN2lBMkh3L0o1?=
 =?utf-8?B?RGg4WHVjUWhJd25aTU93dThoN3pIZko4Ym9zdngyTlJpMjZXUmk3Y1EzSlZX?=
 =?utf-8?B?VDBzRHp3L0lCS2JZcEl6WG1kMFgxQUoyYlI5RlhLYjMzRWVya1BJb3lNd1pS?=
 =?utf-8?B?VHRnNklyNGlLMDFrZWlWMnk0eVlGSGdvL2JtL1UwZ3U4a3BTajdCMEw0VFNX?=
 =?utf-8?B?Y2Erc2djZHRrUEFhSHh2K1ltZUhqTWRGZGhUZnRqSmpMY2QySmRmb1dXa3NL?=
 =?utf-8?B?QWlqSzhLSGhGL0MyTklhWlVhNEdRVlVNbXNuaDRIUnF5WDJIQUk1UT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eb49319-75b8-4bea-f5c5-08deb875ab43
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2026 02:47:45.8577 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YQsM+QDtRi2P4j/su2uXgB9Z1myiGOUAzkV2s66w/GPNKWdNBZvWEQgApn7vecoITsfTCJH0la8V8WMs1EKIog==
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

On 5/18/26 7:54 PM, Eliot Courtney wrote:
> `read_bios_image_at_offset` is called with a length from the VBIOS
> header, so we should be more defensive here and use checked arithmetic.
> 
> Fixes: 6fda04e7f0cd ("gpu: nova-core: vbios: Add base support for VBIOS construction and iteration")
> Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> ---
>  drivers/gpu/nova-core/vbios.rs | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,
-- 
John Hubbard

> diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
> index 7bec81a37340..180928433766 100644
> --- a/drivers/gpu/nova-core/vbios.rs
> +++ b/drivers/gpu/nova-core/vbios.rs
> @@ -238,8 +238,8 @@ fn read_bios_image_at_offset(
>          len: usize,
>          context: &str,
>      ) -> Result<BiosImage> {
> -        let data_len = self.data.len();
> -        if offset + len > data_len {
> +        let end = offset.checked_add(len).ok_or(EINVAL)?;
> +        if end > self.data.len() {
>              self.read_more_at_offset(offset, len).inspect_err(|e| {
>                  dev_err!(
>                      self.dev,
> @@ -250,7 +250,7 @@ fn read_bios_image_at_offset(
>              })?;
>          }
>  
> -        BiosImage::new(self.dev, &self.data[offset..offset + len]).inspect_err(|err| {
> +        BiosImage::new(self.dev, &self.data[offset..end]).inspect_err(|err| {
>              dev_err!(
>                  self.dev,
>                  "Failed to {} at offset {:#x}: {:?}\n",
> 


