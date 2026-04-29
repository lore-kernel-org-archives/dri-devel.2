Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18596CCFA13
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 17:49:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 717B110E0EA;
	Wed, 29 Apr 2026 17:49:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="SC2FoQEy";
	dkim-atps=neutral
Received: from LO3P265CU004.outbound.protection.outlook.com
 (mail-uksouthazon11020139.outbound.protection.outlook.com [52.101.196.139])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E567810E0EA
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 17:49:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iUUssUZFM9nVNPpZqutqeIsRtzEx0gZ72Q4jVQtSoaDWlg2Mc12hoRsAs+51gSMrPHvoE+6Vbwd2MMEaJKNr4JbK+7UXhUQOUtay9RofMBXMDsQPW9N6VThFaBR2Qeaw3Hyw/sE3B+YTxPhVQm/yNC2dz8x0SpusEWaFJnENvIHp55YU3AUz5OrfjHBFSY22nMuEkyvV2nqUB7mhBe16r5UdXv/0xGSTtpIY4J0UGGUtkjrrvMk0zAP9YG7Hmi2FlCK3a/r81dCFTL6YtWDSHnKZzll+Kj9EnkZCT/NwjZRIVmqxuOw84PbnRmSV7xDdVCcNXMyBnpCOtVQb8wqKPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8BXS+Wi7RsX0CllrRFymIyLGFRtAy+TWpBVcHfwm7Ok=;
 b=rduDBLhR1Hv4XR87EDz5R69I8AFaHH0/wc3ISQTtRJt51RIzt3GVR7yYSUF0Vxeu5c0Q07BfG0C1JYZlBNvNae76MYYU4+gz1LKqGyLwA7UnnBezwS1uPYcCHa3ON6Yp40gUWTbUE3sbz7rTTEFzAaanv2o3qPNKlxaP0wLXP/cax2oSX/iZIcuoREmJIsCW0KSfSjDrXqM7JESx79BwAgsfOSGNg4aZRn/EBU/+pRCqE6fA6De0vQJlMKatLvBnq0w6CV0F4WiS1hqV1QG3NSG8PdqY37zflg+4VV+PwkR1o6jybgCoGc/WHrSJkGsIsf3p6ecztBjfJHNWvTeAwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8BXS+Wi7RsX0CllrRFymIyLGFRtAy+TWpBVcHfwm7Ok=;
 b=SC2FoQEykJ3X4O8+V79FOLLu/LWHnA+VvXrKsDM7t+WM6Az8hY+RS7zuz2MFor2tlVe/bx3fS9ya5mi/txPcHABnePpbY2Uy+PudHN8fROlqv6QuTruoiN7sU/1T4XBv0h9p16vY4CnCCztUI2ppnNVa4vzUMjgEBq4AR3WsEgs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO7P265MB8671.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4aa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Wed, 29 Apr
 2026 17:49:21 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.20.9870.020; Wed, 29 Apr 2026
 17:49:21 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Apr 2026 18:49:21 +0100
Message-Id: <DI5TTYAABYBC.2BCOWJTEJP79H@garyguo.net>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Joel Fernandes" <joelagnelf@nvidia.com>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 11/11] gpu: nova-core: vbios: use the first PCI-AT
 and FWSEC images
From: "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260421-fix-vbios-v3-0-8f648aef7a85@nvidia.com>
 <20260421-fix-vbios-v3-11-8f648aef7a85@nvidia.com>
 <DI5PN6T36R1G.2FIZD42MTRZ2I@nvidia.com>
In-Reply-To: <DI5PN6T36R1G.2FIZD42MTRZ2I@nvidia.com>
X-ClientProxiedBy: LO4P302CA0044.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:317::10) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO7P265MB8671:EE_
X-MS-Office365-Filtering-Correlation-Id: 90ec0564-7440-4597-1e29-08dea617a4ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|1800799024|376014|7416014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: bCodms8uK+YqF0hNXALJzl1sm9NovpPRelsQqc4n3vQ+YUO4SLptW0AIE+huWehRuHx9MAUlUUVDyG+hxlzh8PuaDXGy06GTaWHVrHv9+tcEMv64oG703oOqoRDKQgdHRGRCl/lDn+ANG0CBWTUzYyc8UTYasVMlnezjpmesON54cciQfyLtQbN8UF+I5J+4noEsEmTl41BHibsQnwfa9RhJvtA8apzRWcWj0q3A5wmVhWVtw+Fb5XWCA5S3mRTvHV5FnYHdBuUmboe9uPjeKnI9hR9vKEDGQBRvaNM54ofCegXLTnFJ7fi7Rvl5zVEBah5iCZb/xVx4/ABN3Cszv6D+uWlDpo4GJhGN8zWtUrP33z/37ghkQjVU+np8kS+AnEJNRtDJZoy/RzbPaWrWzN2vp3rwGtBVDBX81I43N3tuJ3gUoG8q9MqfrX8Jg6UKlIPVPr6O3BwV6pUfT+/WxmS6XuRejCevLpicgKlgRdTUy1BOpAjc+ngU+ppaW/wFgiNzAkonB12meN6tgGSdEkEAbY2E+PvUSMNesa+coJU35vqXpSdj33q4CFdOV/HnjgmOFYHbpS/aSr71YhgtUPsj/HH6o4rF1+JQB8hvWLpE1aTJL076IaZjEo+n3bMXFoe5K4dAKg/9gCgdkszvskAc80yWNU67CqJC/rsEd03DF6K1y/LZbybF52p9q+45
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(7416014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TlJHb2RUV0tiNGROQ1dsZndqak5IZDgvVit1S2xxOWV5T0RaV2RXU0ZLNktp?=
 =?utf-8?B?OWVoZHpPVkZHMXFKZ0QrMDh2SXhiYk9KcVUxMlBTdmZjdzR3V0dONTZQVDBW?=
 =?utf-8?B?UVdBQmZjQ2dJK3o1d0lyTzN5ajNzdnJyTjBrT21nekV5ZmFEQ092ZzhaaGJx?=
 =?utf-8?B?bHhCN3ZuR0Q2Z0hhMEhMNm85T082WmNsR1lVaGNWNldRcUJqNXl3N0FiQm9u?=
 =?utf-8?B?UUNaY3BPMDhzVmd4TW5Bc3YzdTBnNGo3blU5akExWmlZdVhFbmZtTXJSYVBv?=
 =?utf-8?B?THZKY3kzc2dYZ3hFWlBNUVJ1cnNNWTRPd2g3Zmx2azVmUFpheWtYeHMvWEc3?=
 =?utf-8?B?eXN0c2sySVRkbGlaWndaSDNibmJvZjFXc3NkUWdCUHJDMFRMejJnVWhKOEhk?=
 =?utf-8?B?aWhWaDVlNUlNaHhkYkhiLysxQUMvTjIyOWR4YXBGYWFYeWEvbHVvM0FXZkVQ?=
 =?utf-8?B?N1EyeTM3bkFrdVhIUFQ4V0ZGc2JDaCtnaW5xTmZVUUZGQ0ljL1NTd1lEd3FC?=
 =?utf-8?B?VnVWNUcwa24zSXQ1ZWpyUWRwdzRScnk1empnb1FibUh5RHBScktuSkV0Tm1C?=
 =?utf-8?B?dGkrZXpjSVFMNXdpYjNNY2FMSUdnUk4zU0pjOXhibTZJREUxMUozb1ZYaHVS?=
 =?utf-8?B?SDBxaVFUTTVUeDA5amU3MDE5dktkd3lwYnZoWTNMcnRqKy9mcWczcVAzeU5W?=
 =?utf-8?B?VG90MWcwblkraGcxeUYySWdmM3Mya2pkVE44T2hDTFVMeXRpWnlYbkJEdDkr?=
 =?utf-8?B?R01WQTdiRjBCMWhzMWoxSTFUS2pGaHRzejVrUzJiME0yMmdCb2hJWXFLTkE0?=
 =?utf-8?B?NzVhQWJWRytQRDJlT2kxeGdNa3BnOVRlZ0tsRWd4RXlUUHlucE0yV2Qya2or?=
 =?utf-8?B?ZDNGL2VKOXZ4NzF3V1Jtb05jVy92TlVUY1Uyc29yYlU4UlFiMHd5NnpyTThv?=
 =?utf-8?B?Ny9wMDRnUU55TVdocDFFUi8yLysvMmpYZDR3YmZNL2hLclRjUGNnaGhST21y?=
 =?utf-8?B?MXR0ekIrYUdZNzAyL1p6ZWM0YXJZNXhvcGRwLytwVUFDQllnMmVPZFR4bVUw?=
 =?utf-8?B?QlE0QUo0Sm5JalZwdDZZUitXa09zeWlUTWdZdU8zWk9FZ2NtTWwwYWZwb1R0?=
 =?utf-8?B?K3RRbE5PcTdGeG8zOWJGQUhyNElMYzVUa3BLT0hlRTZoeFhEUUlQczRLVUZr?=
 =?utf-8?B?NGxEdHl1WVhIU2ZydDExWVA4cEM5Sk5EZ09SN2xJZWlSbFBjSW4wVS92SHNC?=
 =?utf-8?B?T1dIbjUzcUtDSEIrbEVXTVdLYU9wR1o1UWhkclY5Y2hQZ2ZNcmJwM21PdmZD?=
 =?utf-8?B?SzZ5K1hTZ05hc2MzUW41Sk9kR1cwSEpyMWNPcnF3VnN4L2J3Zy9kdTRxT1I2?=
 =?utf-8?B?NHA0WFNtSzh1VmFEeksyTlNTSnUvTTJBTk1wcHZONklhaTR5ZnRlTFhybjVs?=
 =?utf-8?B?bmVYUW82YkZCandwUlB1U3ZJQzhPa1A5UW43TnNhOEx2Y3dMNy9sK291cUkx?=
 =?utf-8?B?TFE1ZlBPbVdVNkdSeFlxcHRvRmJZY0xWekQ1YkI3SW5Da2UyQ1laTXhUaC9L?=
 =?utf-8?B?c3RhQUhUU0VXdlJsQlJ4bDZuSmdHNE55dzZOcVZUU3FKQVEwNDJZZTF6eXFt?=
 =?utf-8?B?c0tFaFJETDBvWGpudVd2K0VwNk9UVkxUazNwWkJsbzUwNzd6alY0VWx4WTc4?=
 =?utf-8?B?N1UwT2lOaDNEOXUwWC9BSWdzZlIrekl6UkhFUnZ6OWRERHVnRWJEUEFHOEVt?=
 =?utf-8?B?bjJ4NVNESDJWUFhUR3RQWWZybUsxWm9SQ1p4c3AyWllEMW9DUTBtTDhhTnph?=
 =?utf-8?B?TGErSWZ4NjRENVZLdnlaSDRRKzFZN3ZpNnVXbEN1ZzR3dWM2UHRDVTF0V1pK?=
 =?utf-8?B?MGRpaWVENmFrSXlIYkQrQjFEZ3ZKbkpSa2xRQUNWeVI3NmJ4R2o5VzUwUW1a?=
 =?utf-8?B?d1o5eFJPUmJLRngxRk1BTVpUOWxsWlhiQXZoZG5ONENDMFo3TkNlem5qOE96?=
 =?utf-8?B?bUV2UnBCMHVBdmNqWmpNTmQ5bDVyQmZyWkIzRHRHUlJZdFQ2MEs3emw1SWF6?=
 =?utf-8?B?dDNSVldTMzBQRnI4V1lSRzNGVjdxNk8xMGFnV2pOek5td0xjRWk0NXpTL2Zl?=
 =?utf-8?B?TzN2S1N0MUtXNk10UW82SE94K0F5SFJrdm9DelZNb1ZUKzA0RVpOZ0pCMFhp?=
 =?utf-8?B?ekdjaGFLZzdoUFIzdjFxL0ZjVGVhSGQ2MGZyNFUzUjYwL0hFVmFxYXQyREM3?=
 =?utf-8?B?Slhmb29SNXNRVDJ3MjJjakJITnBLV2daRExhYjF5eEdxTHR6TkJ0YmlKL05H?=
 =?utf-8?B?a3FlL2FrNklMaUpRM3pCdzdOUlhneUNlb2VsT0dBVzhYTEtPdXVWdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 90ec0564-7440-4597-1e29-08dea617a4ee
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 17:49:21.6056 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8QnJ33wd3bX49E7Nh0Wl20uw6yUJR6mBa4RIPYKIVTXWyBbO9Rev44z/ISX7Vp0KfZZFQLYq9di27WOksH/hiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO7P265MB8671
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

On Wed Apr 29, 2026 at 3:32 PM BST, Alexandre Courbot wrote:
> On Tue Apr 21, 2026 at 5:20 PM JST, Eliot Courtney wrote:
>> Currently, PCI-AT takes the final image if multiple exist. For FWSEC, it
>> takes the first one and the last one. Align both of these to nouveau
>> behavior by taking the first ones.
>>
>> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
>> ---
>>  drivers/gpu/nova-core/vbios.rs | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbio=
s.rs
>> index 5cc251c73800..8cfc75b1184f 100644
>> --- a/drivers/gpu/nova-core/vbios.rs
>> +++ b/drivers/gpu/nova-core/vbios.rs
>> @@ -251,12 +251,16 @@ pub(crate) fn new(dev: &device::Device, bar0: &Bar=
0) -> Result<Vbios> {
>>              // Convert to a specific image type
>>              match BiosImageType::try_from(image.pcir.code_type) {
>>                  Ok(BiosImageType::PciAt) =3D> {
>> -                    pci_at_image =3D Some(PciAtBiosImage::try_from(imag=
e)?);
>> +                    // Silently ignore any extra PCI-AT images.
>> +                    if pci_at_image.is_none() {
>> +                        pci_at_image =3D Some(PciAtBiosImage::try_from(=
image)?);
>> +                    }
>>                  }
>
> I am getting a Clippy here:
>
> warning: this `if` can be collapsed into the outer `match`
>    --> ../drivers/gpu/nova-core/vbios.rs:338:21
>     |
> 338 | /                     if pci_at_image.is_none() {
> 339 | |                         pci_at_image =3D Some(PciAtBiosImage::try=
_from(image)?);
> 340 | |                     }
>     | |_____________________^
>     |
>     =3D help: for further information visit https://rust-lang.github.io/r=
ust-clippy/rust-1.95.0/index.html#collapsible_match
>     =3D note: `-W clippy::collapsible-match` implied by `-W clippy::all`
>     =3D help: to override `-W clippy::all` add `#[allow(clippy::collapsib=
le_match)]`
> help: collapse nested if block
>     |
> 336 ~                 Ok(BiosImageType::PciAt)
> 337 |                     // Silently ignore any extra PCI-AT images.
> 338 ~                     if pci_at_image.is_none() =3D> {
> 339 |                         pci_at_image =3D Some(PciAtBiosImage::try_f=
rom(image)?);
> 340 ~                     }
>
> I have tested this series on Turing and probe completed successfully.

Be aware of false positives and the suggested code changes the behaviour. S=
ee
https://lore.kernel.org/rust-for-linux/20260426144201.227108-1-ojeda@kernel=
.org/.

Best,
Gary
