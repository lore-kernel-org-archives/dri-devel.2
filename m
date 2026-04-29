Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F182FF8867
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 14:28:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E360810E3C5;
	Wed, 29 Apr 2026 14:28:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="FwA14pBz";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011070.outbound.protection.outlook.com
 [40.93.194.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 227EE10E3C5
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 14:28:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ku7UyjUXTH8HopGVGn9KX8Pyc1yLJ89kbi6MaxtEo3KcXiSlqaAbrH1dfVh+wB579A28IUR3k3OUHzahxp2z0i/rHjvdKHB5Wu+3H7WFaFdetGT+p/nC5JL7kZsNAJXcSX7C+wt0y49jidOH5YQ4HKc6Mg6v5pxvOUAmyAWbdL+Vz/mTPmKeztPUbupggsQxa7ytH9NuwV9xUlk8lipS5/oxL7auvwK4ebzgsYuhDUay7crVBqDcT3Du8H5Cm6zCOXBYxWTpJDc50QlTo24Q5iYaArFz8Y21V/sX/PrksYySj7ncFnawKqCxR3HIj8HOmNLkUjqDyac2kVYvbG6YIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Wmrhv1iVrS2AObDIYnwZOra2yWqWtcegomHz0HXceY=;
 b=KgAhhc142PPLg6Iz4fw+83Tp9pfK4/nKToCCnqaVMqOVxwCKO8rTyNCbXaGjOgMbFQA+HQHlBm1OSqMtFKLB32xRYG23oR4/5qQIiYcgLm8DWT/5xlprdJHuttuR/d531inXT7zQFBZJ+k2MRZK2lf9S7y42BxCMyLCptJ14F2pN86gZqZCgbu7N3l8bKgE7slH3NsB8BlGDxQMd38B8Hyq4gJK1hEsqsTx6nIkBwn35oB3P5ZgJGWjaJ9mKuJUKL4AUEZl6WRZxPb3bc2mqu8qyISQvX65vXJEtpuPXneafs/AZr2uJLm9/iwfYtlzRVqv7ezfNnngwPRrOWnBuew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Wmrhv1iVrS2AObDIYnwZOra2yWqWtcegomHz0HXceY=;
 b=FwA14pBzoi4O8S1MjcWkv4VWCv/MwV9/gv7Nm5cLHPxjdxzdXpJL2LFtapEjbExB9w1cpeuqjqZEBt2GsyuzcPNAHiyEDwt/jQf7Z1otJVEnSNXStf5PRE0TbSpzs0MXY6TQHwoj4ORcN5Cw0mS/++rTq+H8lNTsxt6HtXHLRJvhsqeoixBXvHILPxYsMmjiRMzWzTuFdvKqMxcPTwzlKAYLfV0k008oXwvuIgRxVK1+62wsxqCuipvy2hdg08b3sGJFzgrttYMk7WtHasZCG334m8VqTZPXuAvGm+Xy9ACh1DlsIQ8B+WYC+2SrSPqlsA2TtnxQvEHqc2l9iHrF/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SJ1PR12MB6314.namprd12.prod.outlook.com (2603:10b6:a03:457::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Wed, 29 Apr
 2026 14:28:51 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.20.9870.013; Wed, 29 Apr 2026
 14:28:50 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Apr 2026 23:28:46 +0900
Message-Id: <DI5PKDUA19PU.2EQEZC5UEVSPA@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Joel Fernandes" <joelagnelf@nvidia.com>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 09/11] gpu: nova-core: vbios: simplify setup_falcon_data
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
References: <20260421-fix-vbios-v3-0-8f648aef7a85@nvidia.com>
 <20260421-fix-vbios-v3-9-8f648aef7a85@nvidia.com>
In-Reply-To: <20260421-fix-vbios-v3-9-8f648aef7a85@nvidia.com>
X-ClientProxiedBy: TYCPR01CA0113.jpnprd01.prod.outlook.com
 (2603:1096:405:4::29) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SJ1PR12MB6314:EE_
X-MS-Office365-Filtering-Correlation-Id: 739f072a-4305-4db4-eabe-08dea5fba1c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|1800799024|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: VXZfAza8gALJbQNVryzpr61GBtkAlcvyZHR/5mzHWUbEhvdVgOmaLuYwwr/x19uLU3xJlfSpmMEDzkMIR7C/+y5oGa/+sgTgOXMVwBhQD+HQFUSQMUiH9260Qspia0iK3ZwdaE95FnbOicJIIm8ahJddm088+18gkoTsNPZAerMd+AvMCbnHxJ99XlCb0XdsO++obeHOog9Mye43OJ99NFOiQowiPTQHSNhkDVZcx+IRfr/2Y/LAq90koNBwtWmxH705Vfqz6Ux+9KZ4b4pCbj4JzrpoQdnEtuJt6/0i7xrVcAGLzN9uz0ApIpBXx5ZYxUrdRXjrWIl+qlaMYkI641ss9gfXzdzRGr7QDkfUxpxn9p9Ls8MQDQRW1ZIj+qBPvzW0lmacWO0IoZy9tEAebGvb3oFe72uuQXBygHsmSA48wn8XSv6X+8TZY/87HaKHzkqkji3GYjevFkeBFbKc6459O0Id55BSt1G9898kN+6ViIuyDo388tSEDDODPCyD0hAYPe0HSpM/7USIGpN9K/jmvvruJaQUfnIYgykXt3Yzy8ORhHC5GD3w4JWWljlC4LMYJEC9mvSPri5EwFFA/o70LNcN4BVloWTF9v4s2Yy8Rvm9Jfv8oFo6XMiWQY2n1IPoqRDcn4t5yv1MLaNc1bpjqs8iGi2UP5DiDtHhclO6HegBadk1odNgSts9UaifZYDY9Q0uTWR8RjAgF2zsk74JR8kA1cipLXsDbZRv3kc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUJPa2FhdG1leGNTNFllbXo1bjZ5cFI5NVUxbVFjVDRPV3JyN0NZZDNtekhE?=
 =?utf-8?B?emdpaTBtZHpqZzFpMWxlUWZRRUk3bi9GNWxGV05IWCtxd0MvR2lnd05FOUN6?=
 =?utf-8?B?dGxmZnR2Y0wyL0MvWUJ4eUpZaGdYL0VEaFlYaU00YUhiZGlmNW5wNVBVekFV?=
 =?utf-8?B?MktQVi9uajhYb3p5b2xhTDNSWTAzZ2dwNiswTU5WcEE2OVJnakdZSVNrOFB2?=
 =?utf-8?B?VklDUDBJdFNyc0E2MURDTnFZVXRBdnIxRTJlS2xpbENiajdKMjAxOGNSN0lY?=
 =?utf-8?B?cHRhUlJKTkc2N0pBMmVHU1pNcHByakVHN3oxQjlPeGZCSkRnK0F0V1doY01E?=
 =?utf-8?B?UDhlVnZ5bmlNM2s0bUZFVGliRWEwL2ZqbTZ0VnpyU3NRMVZ3c2UxMDc2ZEwz?=
 =?utf-8?B?UVpXSWRqMXFKWnR0QTNEclhjUnR2VmN1RWlNVXl5d3doODVrdS9PQ1V6ZDFz?=
 =?utf-8?B?MlJ5ZVBIcmh6ZVBGd3dyMlBQcFNNWnMreVNwaFFDVE5SalU3RW9xZEhvSXBM?=
 =?utf-8?B?MFV3S2FhaWdXWU5zVGNjNmlEWEh0b2l4b3NBZkRQcExicmZnZUpoNkFvYzAr?=
 =?utf-8?B?Vmt1UUVhajRhZ1FkQmFTVmlMY3cxMG9KSUN5dFoxVTV5ZTEzamtYcU1sbnhG?=
 =?utf-8?B?bFhrMVI1V0dtMEF2alZKUlBhZ2VydGU4MDZIV0FacjRyaDk5VXVMYXBOQmk3?=
 =?utf-8?B?akhNWkY2d1VMZTBDdWU0V1BCVlVpdkJING80SDBLbnhIQVphcGVha29wUGIw?=
 =?utf-8?B?b2tBZmRPUXRrMXd1S2IrTmJYV21GRjhpZXY5Y0dsb1d5SnVzZXFzS2tmVnNn?=
 =?utf-8?B?bU9jRTUycVBzS2ErT2dpZ01QZmNZV05uejJKc3lhSlFaUnF2V2FaUXhiVlgr?=
 =?utf-8?B?VVY4VEFPOWt2UEp1K1lKczI5ZGRQRERXTnFTNDBYK3cyR2h6S1R6V1hBcS93?=
 =?utf-8?B?Y0Vvd1F1UC95UUxaTVN1eHZEQjlOV1VJd3BNRkk2Uk9aR1g4dk9zMDBPRHI2?=
 =?utf-8?B?Y21RSXBmMDJmL2Z3ZS9vUGhCVzgrOTZsR3EwUWRzZkFuRVlnRFhZRTh2dHJG?=
 =?utf-8?B?bVVoVS9CRDZxdWdncXdVQUZycWE1ZlJWS2V2VllZZ2NwYm5nTGUwWVFicTh3?=
 =?utf-8?B?U1ZhcGR6YTVlaHN2dWdJZlpyZnB5UEFQanhjWFg0K2dXclhua2pTdVA4aXpO?=
 =?utf-8?B?ZEo5YWhCdmY0aDRBdEUrWWJYVDFjM0RBcHlNd3VXZjlZNUZZVjFHZ3drMHlH?=
 =?utf-8?B?ZkVaNGZuV1pZMEVLa3k0ZTNhcDFxWi80VURLMjNGRGxCSXAwdFpBRkNGamRx?=
 =?utf-8?B?L1RlQytHbWFENTZDZjdMSTVxbG95NmJ6bFFMVEtFTFEwQy9QVGRWNUdGSS9N?=
 =?utf-8?B?YjY2MjRuSGdUWEJQc25tak02cTEzN1IzR2xtS1pXZjUyWmFMVVBFZjJOZnZR?=
 =?utf-8?B?Sk5yN2JSR2Fhc2xBenA4aVhhM2IwY1Z6L0RDVEdMcGhNbzhUd2M1dk1RZEI2?=
 =?utf-8?B?YU9yOTViOVpadk9xRVdYYXBLSHJQVEJ4K1pxaVFKMytpN3czZFc5bjFkV3dS?=
 =?utf-8?B?MzQxazloQ1dVUWdiMVRybVhlRjd2YXh0b2w3d2JRdU9LR0RXK1BQLzlhZTJz?=
 =?utf-8?B?bzBpNk5vU08vQm1HODVZY1d5bCtCYnBpeVpkZzRuOU84KzRBWG9kTW5oa2tQ?=
 =?utf-8?B?TC9TMGxQU3hlRWxFNlhTa0pzY0ljZW1qajIrU24yWGJ6YmVWLzMrNDd4SmFM?=
 =?utf-8?B?UTBkZVZxcWtPNC85cHcxdkRaODFkY3l2S0Mram1mUzNHUFpDTTJBVU55UGI3?=
 =?utf-8?B?WCtxN2ltb1pEa29MT0czcDdZY2JRMXgvNWppaHhnRkhPUEF3c2MxaEluSHFr?=
 =?utf-8?B?L0pKaGJVR0dZSkR3ZUhRK080TTN5YUpXbk5TaGdVZTRxdVBZUjZOd0VhY1ls?=
 =?utf-8?B?SkFPcGc0bnhkcHBwanhyRjVWYk5ybnVMZ3dkbGp1elFYUW5ralBTR2V5Wm5F?=
 =?utf-8?B?bXBrdTVsVHVEYXRRUXVtUjRIVjIvWHlGYmFYZ0hoOFZtWUV0azVRQlI4aUVM?=
 =?utf-8?B?cVhqYitmQkR2cGRkYzdPMjNZT1BYTE91bCt1WVFtbFlmcXRleVA1N3gxMzdE?=
 =?utf-8?B?U0tIK2xpSGVNemhZUTlIcGRkK3RCZXJGQjV0K296RzEyNjhUemRYeXlub2Jz?=
 =?utf-8?B?Z0d1cFBKc2UxaXJwemJ1L002VFFFUmhLL21kVDRNU3g3WU5vVDdqUmhqYkNM?=
 =?utf-8?B?UytpSkZGbzJzVnNxV0xKcVdLQUpMVWJqNG9ZdjFoeDVqR1grQ0I0U0pXcm9F?=
 =?utf-8?B?dUJVTVFBR0FzK2tyRVZCMm96YVpCNDdSVGF4a3F0TXBHQXBua2oxa29SS2xr?=
 =?utf-8?Q?zlnLlWXYb2C/1vTYjRMIjrnZOO7CK1KsmdllbVycV/Nf/?=
X-MS-Exchange-AntiSpam-MessageData-1: q8x1THV4NHF2xQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 739f072a-4305-4db4-eabe-08dea5fba1c9
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 14:28:50.8016 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1FrXzAv/1od1YcCdXUg+ddIkdubx0CyR8P5w1S9yZe/OL9Aus+98r1bkH3IwGqOmjmO9AnhBzgMMUeZLDQGrvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6314
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

On Tue Apr 21, 2026 at 5:20 PM JST, Eliot Courtney wrote:
> The code first computes `pmu_in_first_fwsec` or adjusts the offset and
> then uses it in a branch just once to get the correct source for the PMU
> table. This can be simplified to a single branch while also avoiding the
> mutation of `offset`. Also, adjust the code after this to keep the
> success case non-nested.
>
> Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> ---
>  drivers/gpu/nova-core/vbios.rs | 59 +++++++++++++++++++-----------------=
------
>  1 file changed, 26 insertions(+), 33 deletions(-)
>
> diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios=
.rs
> index 0c0e0402e715..d71ff5de794f 100644
> --- a/drivers/gpu/nova-core/vbios.rs
> +++ b/drivers/gpu/nova-core/vbios.rs
> @@ -904,48 +904,41 @@ fn setup_falcon_data(
>          pci_at_image: &PciAtBiosImage,
>          first_fwsec: &FwSecBiosBuilder,
>      ) -> Result {
> -        let mut offset =3D pci_at_image.falcon_data_offset()?;
> -        let mut pmu_in_first_fwsec =3D false;
> +        let offset =3D pci_at_image.falcon_data_offset()?;
> =20
> -        // The offset is now from the start of the first Fwsec image, ho=
wever
> -        // the offset points to a location in the second Fwsec image. Si=
nce
> -        // the fwsec images are contiguous, subtract the length of the f=
irst Fwsec
> -        // image from the offset to get the offset to the start of the s=
econd
> -        // Fwsec image.
> -        if offset < first_fwsec.base.data.len() {
> -            pmu_in_first_fwsec =3D true;
> +        // The offset is from the start of the first FwSec image, but it
> +        // may point into the second FwSec image. Treat the two FwSec im=
ages
> +        // as contiguous here and subtract the first image length when t=
he
> +        // target lies in the second one.
> +        let pmu_lookup_data =3D if offset < first_fwsec.base.data.len() =
{
> +            first_fwsec.base.data.get(offset..)
>          } else {
> -            offset -=3D first_fwsec.base.data.len();
> -        }
> -
> -        let pmu_lookup_data =3D if pmu_in_first_fwsec {
> -            &first_fwsec.base.data[offset..]
> -        } else {
> -            self.base.data.get(offset..).ok_or(EINVAL)?
> +            self.base.data.get(offset - first_fwsec.base.data.len()..)
>          };
> -        let pmu_lookup_table =3D PmuLookupTable::new(&self.base.dev, pmu=
_lookup_data)?;
> =20
> -        match pmu_lookup_table.find_entry_by_type(FALCON_UCODE_ENTRY_APP=
ID_FWSEC_PROD) {
> -            Ok(entry) =3D> {
> -                self.falcon_ucode_offset =3D Some(
> -                    usize::from_safe_cast(entry.data)
> -                        .checked_sub(pci_at_image.base.data.len())
> -                        .and_then(|o| o.checked_sub(first_fwsec.base.dat=
a.len()))
> -                        .ok_or(EINVAL)
> -                        .inspect_err(|_| {
> -                            dev_err!(self.base.dev, "Falcon Ucode offset=
 not in second Fwsec.\n");
> -                        })?,
> -                );
> -            }
> -            Err(e) =3D> {
> +        let pmu_lookup_table =3D pmu_lookup_data
> +            .ok_or(EINVAL)
> +            .and_then(|data| PmuLookupTable::new(&self.base.dev, data))?=
;

It looks a bit weird to check the result of the previous statement in
this one. How about:

        let pmu_lookup_data =3D if offset < first_fwsec.base.data.len() {
            ...
        }
        .ok_or(EINVAL);

        let pmu_lookup_table =3D PmuLookupTable::new(&self.base.dev, pmu_lo=
okup_data)?;

> +
> +        let entry =3D pmu_lookup_table
> +            .find_entry_by_type(FALCON_UCODE_ENTRY_APPID_FWSEC_PROD)

It doesn't necessarily need to be addressed in this series, but if you
feel like it I believe there is also potential to use `FromBytes` to
create `PmuLookupTableEntry` instead of building it byte-by-byte.

