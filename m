Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D349FF8867
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 14:36:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D64C10E3EA;
	Wed, 29 Apr 2026 14:36:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="n42lh80v";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011047.outbound.protection.outlook.com
 [40.93.194.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7669C10E3EA
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 14:36:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aaZ4Go7UJrg/jL00axfXp0ChLRX1DeyMml9TW2SGhlV9GE1WoMiWY1GvS9lX+WZ5IuaykPkSzze//AsNuRbPpOZsqb/mHgOPCLuff6NjySTQrluPhGaReqN3T67fN5Uh1Z/mbfDUBtQC75PpiGqhDs3CbvT3+eOaaMwadAD93Ijc2fk5cvFLE9j5rN36cIsdl+3xerDxpPsWWtLgiLwqCa5hRu+IdHEUhUqKGkaFwZ3MNO9hWWSRjfZ4eSDVqEcvuKo3sRUgV+44C5LBVAbli4Hii/w+X52KAXBkxuMCseCTAdp9IxkSmqVS+ypeaVLx0IkJ9wUYaV62Qvgiy0wMMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lC/jL6YTzb89isLzcBc9tFpMtF35XRO/2yXGCXS/RR8=;
 b=OjrVz14S7ACxitfMFlldFSpO4P5HeNbUJN0gr0/Bp3gLdJJLg6fpxS4+fKeJegcuv1r2I+ZPHVfN/BpZCo0fWTvg0idEtafLiJL7MWk6lJFKE9n+0MiJU4NXEaD37CD9mpqT3qqNihPsMKjptdoJlB14fwQRL4IZFPvsxgkqWsuWGFbDoMozybOionO4eTaqPOfaQyr6kJe3NShE1J9SfnX5sJb2wYpj988fvRyMDG8em7v0hAEdOwAuQ13fWFf3/kKvJt1C3nByHOHkWaiZix58mYQPXlCo+nIw0EkA8Bffyb3Jz2N64kl6KfC3hF1WDV3NXgflGV56AFhod9lffw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lC/jL6YTzb89isLzcBc9tFpMtF35XRO/2yXGCXS/RR8=;
 b=n42lh80vTGMdH8UhrqQZ63SUDdKl+KtQQmB+MykP+8Dy97iM7kKlUfyjEAdyAq8cCW07xaUKrCJuvucI45kzaccIZa+aby8pnymeAxBSMIBbN74Bs0x/6BMF7RVpoSJxB9Danu4mRqw25nTIXQnF+fkl6IJbiTTSk7+AZq/IiKlrTLAEEjVfQki1xb3tUE1KKOMDzmNHOcc6LMvOBxowD1wGdhscAAzR7EQxUj5XXHQOmOTFRNRHg/qmR8W4rZZxb/W0T+FbdnUjdWuAVMU5ugysfa0f0FWmv8hIsgP1StbL6DVT0StAhk/aSAxoTlQKgJN6B92Xuizmu5RTC8frow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Wed, 29 Apr
 2026 14:32:30 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.20.9870.013; Wed, 29 Apr 2026
 14:32:29 +0000
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Apr 2026 23:32:26 +0900
Message-Id: <DI5PN6T36R1G.2FIZD42MTRZ2I@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Joel Fernandes" <joelagnelf@nvidia.com>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 11/11] gpu: nova-core: vbios: use the first PCI-AT
 and FWSEC images
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
Content-Transfer-Encoding: quoted-printable
References: <20260421-fix-vbios-v3-0-8f648aef7a85@nvidia.com>
 <20260421-fix-vbios-v3-11-8f648aef7a85@nvidia.com>
In-Reply-To: <20260421-fix-vbios-v3-11-8f648aef7a85@nvidia.com>
X-ClientProxiedBy: TY4PR01CA0062.jpnprd01.prod.outlook.com
 (2603:1096:405:370::14) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|LV3PR12MB9404:EE_
X-MS-Office365-Filtering-Correlation-Id: 282b0f67-7457-4356-6c52-08dea5fc2488
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|366016|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Qm0EVwRBXa4rG5Ax7qT2UdcEZHAb0SNVwFI7QcFBgsCiM775pyWa+90AJZVWpN16cUGTG4Ra/5sgHDZtRq+HSBSYlKfwIANqAUFoTw+cBpj8INKgwHr/4oKzHXmU0+lYshcYZ4U0qCJjUCdrNSB9MQtpiUjXtoud05zoR3p5Jg/W+PDZhE/t1j+9pzUDv5joeTZ9rxxj2MTE1Dpfh1WV2j9Bm5aCX0hinQ4eaBBgqkqZ/lqU6cVaQQVvupmTxJYu0D9VGg/o0/GUfAm9gjaGqcSMyW3JRkYbC2DAdC6K0OaMA5bl0gIEGCMPVxEOfY+xA/wCYrd9HT6DSiPmPSp2o54vftOqCW9CoQN67Yep1FXm9ggYHgwJwkOQwP44H1RgH746/4xiBhcVgi9mrmLXuHNOZQiKpem/09jo9rp0UAMAnzvB4iZtGqmKB6GkJrRzvpVokvbhOsnpH3aW3Gs6sch/xBLm5wWSQ1I3EboTA1C2uH46WtMW7clPvBv1/TPTvRz25AotN6s0bwVcb9jHEm3it7lrGTPA4kTrK0gVfmNFMbrzbM9hbyl9eRjvh00CBkLUqgoNWRG3TznXggGkySuvCtPUhrtJPvnbgXijvybuNLttn/IJxJZ0TYrOtpVMVxN2ibC/UDA1I3GPuRhkWbq5ZFJ6iOGk9hbCUDg6DsRPfFB/CSOiAAlc36OiS1OfWQhvNw3C+h4x4pCxCgkauLxWmVsrjOJAntxbC1N8knY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1hSWS9ycjhjamdZK3ZMQnN6cWs4ek1uRlE1ckRaaHNaZ1ZmeGVWSjNqclVh?=
 =?utf-8?B?eDhkQjl5VTRvb0phR1NHNFVwclA2SS9IQ2tHckErOUpxd3lCSktTUTBIU083?=
 =?utf-8?B?UVI5ZWhsVzNtOTBrTkF0RHMzTzhjZEpFTll5YlNYaG0xVk5GaS9RSURXeG51?=
 =?utf-8?B?UklyakV0ZDRsb1lIeDVrcDREK0ZtbXR5cXN6Uk5nY05CamxURFJDRlJhdUxx?=
 =?utf-8?B?eU1uQ2ltT2lUNnFQeWFndUJvNTV2QkVhUEJhbUVBbytvRVplaEJOcTF5MDdL?=
 =?utf-8?B?MnNJTkxGRUQ2bDBOTDFCTW84Z3ZNUU9IVlpndmRuRUhFT1BXSWFaSC9uaVgz?=
 =?utf-8?B?blAyNXJRZVBoNWRqQXdObkJ5UGhhSUk3cjM2VnlRZVEyQWNwZ0FHM0VYK25j?=
 =?utf-8?B?MnpqNGMwZzdQVm1ORXZVYUdUa3FNTTh2UEV0eFhWcUxWVGluWng3a1p4bDdm?=
 =?utf-8?B?ZXJRbFAvWHVVR1NnSnhEczB3QmxzMkZaRmY3cnRDRUEweG01a2RIYWxoQ1dN?=
 =?utf-8?B?eHdVTDhkems3QUpPcklzM3lxREZPa0FRbDBRNktoOWtTNzZ1T0VRcUR2eFpv?=
 =?utf-8?B?REVsUjBNdHgrbTNFYlpBT0R2SkQ5SE1IdGcxazZZVmdpWnI4RjdqUzNhN0Ji?=
 =?utf-8?B?b2ZoOEc2b21MVUNiV2QxT3ZyTHZZeTVONU02MVpVaHIreEtRVXdnWnJ3RWgz?=
 =?utf-8?B?OTNaRTIyVlJLOW9xNyszRWE0U1dmTk9GQlJaT1JQYU1SV3B5YTR3aFN0UjJQ?=
 =?utf-8?B?OW5uL2FpNFo3YU4wTGY2Znpyc1cyRnVzNm9OV3NCQjhmUGhzUzVNTEJLQUlp?=
 =?utf-8?B?ZGQ5alFUVjdkUDgvd0FuYk9SY1hvaWQ2dlFXY3htK25pMUg2cEljSlIvQUlQ?=
 =?utf-8?B?cWUxMTVMU0lBcVJDeHBqL05TWE9tSlRreEhhc0VJZFJ6c1dvZ3FKbVJUVVlW?=
 =?utf-8?B?Z0kwZ1U5N1hFQVEzOHkwR3g2TXNZS09abElJbWY3Mjk3U0VRRHdSODJSbkwx?=
 =?utf-8?B?MHllUmJPZysrWkJxc1JRTGZ6czJlcUN2SzZWOVZlR2ZzTVdjTlQ0RGkzbVlt?=
 =?utf-8?B?L2M3bm93bFJXOHJ2dXpXTXp6ZzJJcmlkNlBXa01aOS9OVS9XR3Q4clRCOW44?=
 =?utf-8?B?clpsTThkTEtucEN3YnNOckZ4YWR3QVl0RTRrdFpkMmhkbUNHT1BGQWRmVjdM?=
 =?utf-8?B?YzlidDYzTldwazYrVEFwUjhFc0FmREUvamlBL0JvZXJSeXBKT2g5SkxzOUxO?=
 =?utf-8?B?R0FHemZXUURoRUEyeFpTVCtLb2JweHNxS0U5YTErclJrR2RYRHM0UStUdGlr?=
 =?utf-8?B?Wm96N05KNXhsWWpRbVAzdHBUcnVPNHNDUml2aHRIUDNqQmxuZndNcjFvUTdh?=
 =?utf-8?B?UEdCWUx6V09oRVVNQmxYY0FGOUQ3YTVsQ3RORzVuOE1DV01EdDhTSlkyVndh?=
 =?utf-8?B?OFA2amV2MUFhZmY4UVJjY1E0RWNtaE1sQ2xsU0xzSmdGUitHeHRvQTUydmcz?=
 =?utf-8?B?dUN1NjBoWFFnMXFNUWtlR214cit1T3NYc2pHSUY3a0d4UU1GZFNka1F4dWVQ?=
 =?utf-8?B?R3NkUms5ZFVjTUZCREZ0aVlodVlxR2lMc3N4d3VRNjhTc091ZFp5VHJyUnU4?=
 =?utf-8?B?RzhIUVNuQldoOUQ1UVRQYlZLQVpwZzR4akM2VFByc3BGbjZQaTVrRG43bmxG?=
 =?utf-8?B?UTdFbFZ5OEhtRktvVGVsQTJvTXpkc0JwR3YvejRZYlhYWEZTM2krY1VVVlZy?=
 =?utf-8?B?NHNTMGwwckRVTTI0dEVVcmM1TS80cU9RSWVaSFJMcDhDcHNVbWRLcXVpbUJS?=
 =?utf-8?B?eVRYdStlSGZLSVZ3ZUIwQVFlYjFZSTN2NmNxRm1UdjVSOWsyNGN1S3AvczBs?=
 =?utf-8?B?YkJxdjdidmRWYjBjY1dyRjh5bHdSa29sc08rZjZjdVFWaVl5SHcybjNPSVJl?=
 =?utf-8?B?N1d3YkhJdU1WR1Q1Z2J6cUw0cXZWQVpXZFVLajU2cmpRa2JMNERIY2Zmb0ZF?=
 =?utf-8?B?YjU1RWRXVEFNcURDTnArMWlFelVJeHdGWU16aVlNRDdWcTFvSlZJM2FsRWla?=
 =?utf-8?B?bm1FdGtmZEk4MXhEU2FockVTMWlwQ2JyMkh2dm9DcEdBbjRwcGdvUWJaTGIy?=
 =?utf-8?B?MGcxUkJrcE85bU9IV0VKOVhZcXRVdDJPZGFjTEUxbUVrcVFYNTZYQS95ZVIz?=
 =?utf-8?B?OUtOc2xzanBsRVNwT1ZZQkJhQnRrbEM0bm12SStMdjRCYnpzcGVTYWR1a3VL?=
 =?utf-8?B?Tm1hZC9FbCs0Qk1rQjBsZ2Q4eWYwQ2dCUjR0UkFwNkM3b2JETGJEOHBKeTRx?=
 =?utf-8?B?OWdnL1o4QkpCUThGOGxzenZadUZldVZJOUJZVUZtbjJkZ2pvZmtVNGFuSVdU?=
 =?utf-8?Q?fwPz+OQuN4uxdpzPOypCa/Iva0DWFxAiU0kWKuQWqRXxv?=
X-MS-Exchange-AntiSpam-MessageData-1: O3IPLhrTanYJSQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 282b0f67-7457-4356-6c52-08dea5fc2488
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 14:32:29.7815 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jjUHtTNlsjyLeR4Gj89ZZInXWogREBpRg6zBWHRfmuijPeJOoBS9PreYW7T9kWYoHd/1floWFgakY72GPaq9Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9404
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
> Currently, PCI-AT takes the final image if multiple exist. For FWSEC, it
> takes the first one and the last one. Align both of these to nouveau
> behavior by taking the first ones.
>
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> ---
>  drivers/gpu/nova-core/vbios.rs | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios=
.rs
> index 5cc251c73800..8cfc75b1184f 100644
> --- a/drivers/gpu/nova-core/vbios.rs
> +++ b/drivers/gpu/nova-core/vbios.rs
> @@ -251,12 +251,16 @@ pub(crate) fn new(dev: &device::Device, bar0: &Bar0=
) -> Result<Vbios> {
>              // Convert to a specific image type
>              match BiosImageType::try_from(image.pcir.code_type) {
>                  Ok(BiosImageType::PciAt) =3D> {
> -                    pci_at_image =3D Some(PciAtBiosImage::try_from(image=
)?);
> +                    // Silently ignore any extra PCI-AT images.
> +                    if pci_at_image.is_none() {
> +                        pci_at_image =3D Some(PciAtBiosImage::try_from(i=
mage)?);
> +                    }
>                  }

I am getting a Clippy here:

warning: this `if` can be collapsed into the outer `match`
   --> ../drivers/gpu/nova-core/vbios.rs:338:21
    |
338 | /                     if pci_at_image.is_none() {
339 | |                         pci_at_image =3D Some(PciAtBiosImage::try_f=
rom(image)?);
340 | |                     }
    | |_____________________^
    |
    =3D help: for further information visit https://rust-lang.github.io/rus=
t-clippy/rust-1.95.0/index.html#collapsible_match
    =3D note: `-W clippy::collapsible-match` implied by `-W clippy::all`
    =3D help: to override `-W clippy::all` add `#[allow(clippy::collapsible=
_match)]`
help: collapse nested if block
    |
336 ~                 Ok(BiosImageType::PciAt)
337 |                     // Silently ignore any extra PCI-AT images.
338 ~                     if pci_at_image.is_none() =3D> {
339 |                         pci_at_image =3D Some(PciAtBiosImage::try_fro=
m(image)?);
340 ~                     }

I have tested this series on Turing and probe completed successfully.
