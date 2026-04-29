Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23042CCFA13
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 13:50:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FB7F10F030;
	Wed, 29 Apr 2026 13:50:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="uUwiLTbs";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010001.outbound.protection.outlook.com
 [40.93.198.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2B0E10F030
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 13:50:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GtoxuiLCqzCf4WGSypFwuf4CM7I13+L/mCRkrQ7QTyZRSE5KMTNmFoSS5gPcCG8HNMhJetu99FaQMMbRVnuqe7VSvDV3Q6TSGX1jl7pvTwL1QPpOj+nZIjHNKI3V0DJHetyagcBqyczlZwygjjXSdJKBo5FWG2BGwkx5w3rLTfTQMLatnjuuymFQj4vUXK6sLzYwc/pnrHB7xcL3tL5vK5Ivnnq9VJAYbYyejhJ57JLvktPYQS+hgjg0a/BfXpcankAs2TTsFMCho7gUL3201tasS5W7T6OFMIFatzTFqeTYQDbnFUPLKiaN1d0/TzH3pmsqnRsAjJ9ZE/Q5/c10zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v/+jGbJ9l/ZdW+MlZVj2CWjOpIZqqYhtLl6YtI8S1JQ=;
 b=trLr7MrFWL1glA8EsqTadq4g+uHIXUT6l78T9i5Ir5IA+SauiiRVsUoc6VXl9OI1ht/ohxgvwmW9KpPSUgcsrHdgIzdZZtozjasBcP9MqENqMVxnWG26ETMzNhdL/6GyIbNYjCmflzG+oSA1OX95JQtSLiodW7cXkpAYAvmNCLgsclEBYK/lSlKrydbY/Hcz+3PfepOe+qasjIpVVV2SCLAbYPUl+eaGCHiXZaF1qRCnayuSqD+V58vUGX5tum6up441JYXsLguI43RtgsCUqZTefMZ8jPuFWpDrmCE7vlmeNqiHarSpD2lPZ7Dil+GPeFy5egzKHTnFR8kT7nF1IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v/+jGbJ9l/ZdW+MlZVj2CWjOpIZqqYhtLl6YtI8S1JQ=;
 b=uUwiLTbs/b7LNYFvNKzIQT3HEOb0VLqsRXwHukABtSndmJMhj5eZqxmTS0/vmxD/d/cNqFCYOIdNEk6dqc9k3kIZXSLLkf9e34DA06XXwdtL0tatCRMizxC+6CkxNgaHCUuHMhuCA6lYYxuQEARkF/h6OzDHr2xzxdg9g+Roux5yfInRrI/ImpiwwuAD2JQUfKsW1JgGbri5WDNU6JOMxlIZwdh6z68FIdHQ5I/75XwbEz1tFC5XLIBNm/KrMmdjZRlFISzGIVd9Vn8vgqjXEQmUuEjTaNNRRpILWzFJLXqnStY8V2uljd0UFqPXvB3r1Nn+4xR2ZrmfWkukvwfsEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by BY5PR12MB4273.namprd12.prod.outlook.com (2603:10b6:a03:212::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Wed, 29 Apr
 2026 13:50:24 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.20.9870.013; Wed, 29 Apr 2026
 13:50:23 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Apr 2026 22:50:20 +0900
Message-Id: <DI5OQY5NQYB6.233U92ZQHTZHC@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Joel Fernandes" <joelagnelf@nvidia.com>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 03/11] gpu: nova-core: vbios: use checked ops and
 accesses in `FwSecBiosImage::ucode`
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
References: <20260421-fix-vbios-v3-0-8f648aef7a85@nvidia.com>
 <20260421-fix-vbios-v3-3-8f648aef7a85@nvidia.com>
In-Reply-To: <20260421-fix-vbios-v3-3-8f648aef7a85@nvidia.com>
X-ClientProxiedBy: TYCP286CA0016.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263::6) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|BY5PR12MB4273:EE_
X-MS-Office365-Filtering-Correlation-Id: 25902660-8f25-4f49-6d35-08dea5f642cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|10070799003|1800799024|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: REiaqMXmuklUe+tn1cUHdjeLUcAT5nwt/7m/SZFi7GWPuN1Qh6udVNPJFfwd9QoQD3xQ9e4Ykfypqrdrh5d1nzWiJgabxy8RqPQSCnvKivk7fMusc/P7/WyTzCyIgCmhEuYzXmJkBGqfZw3KkMPQIAOtRkfajCN4CTIQ0xAx57nRFpRPh55WCsW/gU+Nt5mJT6T6K9QEN3XbAcd3dQmkwyfXt+PTgKKGHLUPb4zcSjSJ+ObI8EOaLLUkfofWseRbrG39ye/eyhrul9NtPmKtOEbLFxYzMpNE4ZaDfbxjU/RMsYArgLOAUTNHD8zVPbX1Mk1JhcHtpkV8fyyqR5v5zOWrUhQtSrLHTRXfrRRUl+GoNjUpxEZUKTbX6qFWYjRb86N2WLvaYlzVmgfFo+bCrb29m5vyyPUHh5cmz1Y9EwpZybRb7jU8mwKrKL890uLT/FDk52M9w1EU+XhxRxuK4+DMdgZgUNtwrYiJwgjv3kkbq+pSzPcREigr58FBTM6e4VcEgE74jdJ6E+NrUI8iJMKeqzovtU1SZh/sFEuXLVgTPQvQdpl5SqrIjWVJny/y3+zr3ix1HXQ5bihk8qZcVIh1YbXuUBCfPa+c5EzWDVHEcbUVRW1efmQPUZsvK7gPwPALZjByCBcxuw7kCdQgF87v/yzizEWWQJSOEPrsGPuJBWVeQkXG6ue79bIg1pTaDIQpY4jxvlXSTKO3FEQqCTb7RJwsvZEiWe9h3SjtnE4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXJiQ1RsMnpFZklWRXNuK1hSNkYrQVhEdnVDSk1ncTdUd3NPdURmb09MT0VW?=
 =?utf-8?B?NzIzSWo3N2lmZElFWWQzMWd6SDdBOUY5YXpldThGSS9GdHVlNDdiUFdmYnFO?=
 =?utf-8?B?K2dmU0ZCaDZ4NlpSVW5XM2FqQVJzYnhORURNeFYyb0IwR1EybGNBL1hFR1Fr?=
 =?utf-8?B?VkdxL1RUcjcrb05VR014dDhvYitMWHpkUGFBcUw4ZVVIZHVvTHY5V2hKTURv?=
 =?utf-8?B?MzhTN2pjbnVkcVJFUUd2MUxSWHNHZURnQWxzTjEvR3ZsaE4yR0FaYTBySHBO?=
 =?utf-8?B?eGpxSVFVd0J2WGhEMDRydW04VmdSV1lOdmtaUndHOTlidzZKelQra0FteEVw?=
 =?utf-8?B?dUhsWklrT3JpMnNZZ1VNTzB1WCtWa2Vvd2Y2SFlJa2NDSUhSaEsyZ1pVYXhj?=
 =?utf-8?B?aFNTNkVGUjZxdXpKVmNYUkZibGhmaWVYRVRTZDdYZVVseU8yV3lmMHlEdjJ1?=
 =?utf-8?B?SFg4bG5BbSs4cHFURGpOWGFCSGhOckRyM09QMkE3TVRnMVhCQmIxYnRROFUy?=
 =?utf-8?B?MVlFUTJNUTJLZTJtTGpLMzA0ZWUycUlmRDB3Z2xCWEFlMzg2b0NrRGJDUHpE?=
 =?utf-8?B?UkMwY0JDWURRRk9qZlU3WG9SYXM2MGgzRFp4WVQ5QnQyZkdRenAvTnlST2xj?=
 =?utf-8?B?YkZURk9mVVVqdkhCK0Q2Z29BUlhWcEZHam9mL1MwQllFbitwcHZqTG12aGtY?=
 =?utf-8?B?SEhIQ1UrMHZQS0tPeVpVRUtLQm9TVHBJajJBdDA4RnNOZG1SRk9lL1Q3U25V?=
 =?utf-8?B?azNjRkVwL3ExaXREVFhrR3FZL2x5ZjV1YnV4RTk3cU5KbTlKNmN4N1lnMDR6?=
 =?utf-8?B?eUFua29FOXhMQVlGV2gvelJTM01vN05LdFJxTEVpdjFBVkNPNFVPQnB4ZFFJ?=
 =?utf-8?B?WTc4Mm81OVVJM1dMbEs1QWNXaTlQd1E5Z2hPeHRYYlBTajZUd0tsMGlFV0NY?=
 =?utf-8?B?bGdCVSt4MlRoMEpWdVI2dWt6NGYyVXJBTUdZMjJjQU15VmlhUmdZcUpuYmtq?=
 =?utf-8?B?YlFLUmp4VTg5a1dUNnBob1dzWU1ZRkhzbTZBS3dnMWN6VGNlMUM2ais0NUVD?=
 =?utf-8?B?QjF3UE96MjJjeUU4MG56NmJTNktSdnFhVlZpQzVvaDRLM3JoV3BDZHFvZ2h5?=
 =?utf-8?B?enNDMTYvUXVNNmZTNW5UMy9XWDJtQjE1T012Znd4MXY3cjdzeER6ZU9HTW9Z?=
 =?utf-8?B?M3BDbXRUZ2RDUm02cUlsK0ZwaGFCdi9kLytXU293b1MxUTAwcnBONkJuY1RQ?=
 =?utf-8?B?NmxVUXVJdHA5WEFxZDZrL2hwdmNHT3p2MHpnajJsZ1VIT3V1SFQ1NjhlT2VV?=
 =?utf-8?B?N2ZibHFpMmlFdGFVaVBnQmh6dWtvQUtsVzhvNWVGanh3VFBnZWI4L0pCYkw3?=
 =?utf-8?B?cm9uWktCZHQ2bDRXOVpwaXJrNzhHZ0huZzRiN1NPRGlYT1kvcWNVelJySlpu?=
 =?utf-8?B?SGtTYStESDMxcW5DR3BQUXZFZjRUVHI2NkpSZ0RuVVJNLzhvbDFlQVRwNzF4?=
 =?utf-8?B?enduQkdUbzNRV3RjTURLVXhHMHc2Wit0a0RXWnQ5bDd2a0IyRzZWV1lZMUNv?=
 =?utf-8?B?WmUzb0E4Wks3UkxUcy9ieXI2bkhlK3U2NnFKeHYzeXdvK2Z1aVZkOUNJY2lx?=
 =?utf-8?B?SGR5VHo4bDdWUVRWNlNWc3FyMjNxZ2NGNWNiYWxmeHRVbVpJVTZIWGh3U05P?=
 =?utf-8?B?eXRKRklSQVRGa2NjWHA1TDFyNDhvMTlFbDJZWUx5cDBRaUkrMnVnSkIreno1?=
 =?utf-8?B?d3V4dWdoWFRUUEh6VXhEWXJTQUtmTzBMYWVBZTFwUTRIamZtdVhQekFBcDZL?=
 =?utf-8?B?ZnNKQVRHYjlnTDhOUVVjSmRJZVpiSS9xSU5oUU9XUXlBVDc0YzlRRXNmVk9D?=
 =?utf-8?B?RExCL2c2UGNtQ05jOURqVUdKcmlHS29sUno1Q1BwdUkyTlVLdWhQRjVWNnZZ?=
 =?utf-8?B?NE84T1pGRXNDMEZxV1FIazdBN0J6T2RiUGltSlNWUUJBTFpjbmdvYVhEbVBU?=
 =?utf-8?B?cTM5UXJrcXVJWko0VFVmalkwcjZUeWdDbVgrMTUreXNZQkFrMUttZ1ltZ3ZC?=
 =?utf-8?B?cWQyZURrcktQdldNMGN6ZVh1b1kzdnczYmQydGdPcGo4dkx4WmErMkJqQVdI?=
 =?utf-8?B?NlhhUVZhYmMxS3F2aEsxaEYxSHk3NHFkUndyUHNQd2Fjd3ovUUl0UWhPcFUy?=
 =?utf-8?B?ZUhUS2JQVGxCc1N5S3NEVnlnTnFXODUwUDRibVc4eDB1Nk5WNVFaNlZPNCtU?=
 =?utf-8?B?WjVMRjNiZ0RTbVpYdHJOTFp1Q0xiMjJENVAxczNuaHNYUlBvM2dwZHVta09O?=
 =?utf-8?B?R1VKYWJ6MzRrdTVBOVF4bjRKMFJDSXJrbXY2SjJ5L3o0cEZraXFXemxZZVlD?=
 =?utf-8?Q?rPGMmtVMQlUQAbwDUGubmINp8oB51TMNyb7D4vpHId6Qt?=
X-MS-Exchange-AntiSpam-MessageData-1: AV3mJTRYUU92sQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25902660-8f25-4f49-6d35-08dea5f642cf
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 13:50:23.8596 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SIaKFz/OXF3XWQFUoiXodfOhQDkyR+pf2KH/4+r1rwj1EtN7uO37HSbIbyTSG56AZYRb4vrxprQzsqBxbO+vpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4273
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
> Use checked arithmetic and access for extracting the microcode since the
> offsets are firmware derived.
>
> Fixes: 47c4846e4319 ("gpu: nova-core: vbios: Add support for FWSEC ucode =
extraction")
> Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> ---
>  drivers/gpu/nova-core/vbios.rs | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios=
.rs
> index de856000de23..632c8a90ea76 100644
> --- a/drivers/gpu/nova-core/vbios.rs
> +++ b/drivers/gpu/nova-core/vbios.rs
> @@ -1029,16 +1029,21 @@ pub(crate) fn header(&self) -> Result<FalconUCode=
Desc> {
> =20
>      /// Get the ucode data as a byte slice
>      pub(crate) fn ucode(&self, desc: &FalconUCodeDesc) -> Result<&[u8]> =
{
> -        let falcon_ucode_offset =3D self.falcon_ucode_offset;
> -
>          // The ucode data follows the descriptor.
> -        let ucode_data_offset =3D falcon_ucode_offset + desc.size();
> -        let size =3D usize::from_safe_cast(desc.imem_load_size() + desc.=
dmem_load_size());
> +        let data =3D self
> +            .base
> +            .data
> +            .get(self.falcon_ucode_offset..)
> +            .ok_or(ERANGE)?;
> +        let size =3D usize::from_safe_cast(
> +            desc.imem_load_size()
> +                .checked_add(desc.dmem_load_size())
> +                .ok_or(ERANGE)?,
> +        );
> =20
>          // Get the data slice, checking bounds in a single operation.
> -        self.base
> -            .data
> -            .get(ucode_data_offset..ucode_data_offset + size)
> +        data.get(desc.size()..)
> +            .and_then(|data| data.get(..size))
>              .ok_or(ERANGE)
>              .inspect_err(|_| {
>                  dev_err!(

This looks like we are doing part of the operation, stop to compute
size, and then resume the operation. As a result the `inspect_err` only
applies to the last `get` operation.

The following would flow better IMHO:

    let size =3D usize::from_safe_cast(
        desc.imem_load_size()
            .checked_add(desc.dmem_load_size())
            .ok_or(ERANGE)?
    );

    self.base
        .data
        .get(self.falcon_ucode_offset..)
        .and_then(|data| data.get(desc.size()..))
        .and_then(|data| data.get(..size))
        .ok_or(ERANGE)
        .inspect_err(|_| {
            dev_err!(
                self.base.dev,
                "fwsec ucode data not contained within BIOS bounds\n"
            )
        })

