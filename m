Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5047CD98E2
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 06:20:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BB7310E94A;
	Wed, 17 Jun 2026 06:20:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="DgAV3JOQ";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010065.outbound.protection.outlook.com [52.101.56.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AE5E10E94A
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 06:20:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yje0bXCZEdYm5BvU3Z4vVBL2+fr38ibtiBkgLzzQek+UhAw1gJGRjhLt5srJAfK7zEgkjErwZiLkdfVamvqOvQ4bcHkSorH+YWSFXew4Q9hFFb82Dj0boAaq2cPN4ICl+b8DHB4LBNJsEbZdag1PP/eviCHgK7cA+UejQO25PVZoYawl01xFIfHmvp5+bljNbVW4A5eoFnPnMkRrTwXMKMgHzetgjjERSwRECWqhGs9MeqJiLBZsGZ//SVnO4OCQfMP5nZSzgWyB6IPajA8QuDgQ/1JopMgPpTGyVyo6CquP/X9hL3AIPWmX6u+7aSs0watc7jjh89qifCgzJPwOEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=giL5qK/WfqqlBfzpoKsIvxDkS7i3aroL4WtKxJ+uenk=;
 b=ltzFEvOGraauvMkqL2Ztoz5G9ZRhXAFh/grGPHCSYQ3XMNA9IIfQAOr6xJlGjHSo8e9u/AXPw6RbSFpvEe0RHsf1RAG4G3CeOSNPsU00kPsWRnQ7vEIuaGX/Nq04THlL1d531UpU92M82XBM3T4FFqjTVC15g/x9fWtFEOlyrWj2/VNHs/vni14yDOAhpMNJMro6+KAEKosGLaVytQ6imr3bKmbtB+U4NI5RFQ9gf/z6xoD2APNYLpBLjv7oTPJjETBvVMsAmIDcFGu2PLrXRvOUGuiTKTlJNkgkq8gFdKwV0Po3YdXlEjLP3XlFNj+YjbeTXOQl5GPEpWMBZQNrqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=giL5qK/WfqqlBfzpoKsIvxDkS7i3aroL4WtKxJ+uenk=;
 b=DgAV3JOQ8FD8kcovNXiMM74B8v7orMxmyp25P6Hx/9agTkcpLK0IpIV0PZhRfaJAgEsmtgJNJgvCdP1R8HxhkPitrNvQb9q7+IpKmFFoX2dasRHM9It3brpj8l31NWSzJwZONSTqaJG5iDCOG0dM4WUcNHmUcr7FHKVwIv4DYk/+9chjuCwU3yCA8/sj2wXBApT63fmVaZP5p5fNrITHO8/pAZ1viELuBP6lmZoQzAQFsH4d8VgWG5cidQr3PdXTa1O/RH2eCO28XLQFn0rvR7UYsihfPu9Aa2oWQaDlhfrKp1CSUf31rEAmXXPDdzzAmKfEqKBNnLRGCM6F5T6oAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MN0PR12MB5715.namprd12.prod.outlook.com (2603:10b6:208:372::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 06:20:15 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 06:20:15 +0000
Content-Type: text/plain; charset=UTF-8
Date: Wed, 17 Jun 2026 15:20:11 +0900
Message-Id: <DJB3UZLL1SNY.2Z2SW7140XNGK@nvidia.com>
Subject: Re: [PATCH 3/4] gpu: nova-core: gsp: Extract usable FB region from GSP
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Benno Lossin" <lossin@kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>, "Joel
 Fernandes" <joelagnelf@nvidia.com>, "John Hubbard" <jhubbard@nvidia.com>
Content-Transfer-Encoding: quoted-printable
References: <20260609-boot-vram-v1-0-d9382610507a@nvidia.com>
 <20260609-boot-vram-v1-3-d9382610507a@nvidia.com>
 <DJ5ANU6OL6X2.D8ZG3LV755I8@garyguo.net>
In-Reply-To: <DJ5ANU6OL6X2.D8ZG3LV755I8@garyguo.net>
X-ClientProxiedBy: TYCPR01CA0133.jpnprd01.prod.outlook.com
 (2603:1096:400:26d::14) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MN0PR12MB5715:EE_
X-MS-Office365-Filtering-Correlation-Id: db99b0c2-7014-4572-6842-08decc387ec3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|23010399003|1800799024|366016|376014|7416014|11063799006|4143699003|3023799007|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 9gZWAdgigIok6OE4ba2t519GI+OhjHZeu6Pfs2HB92DNkBAHEd+pkuY5qSJyxSANa2+4egzyl3DQggyMi7AXez/juafSrVgn7a89TJCoqPPZHyAJEBU8MuoN+3caYplR2HAVTfW8KkmclH0zMhd23526ps5EHpCmDbd9I5Yoz7F4YkBk5chcyWDyOB2at92GIO8HyF+/k7ej550qYwTmyR1cPuq5ltc7J6u3WI2awf1yPZtQqKMzkoDlTXmmBDMgfvb/+54K/BiS0G+qmT2XIJN0AoUXhum5xKhic8PxJH8x9x8vdjXfhJ/f2LxgIMYLJH92R/vYlI0MSmICoc+0/AmwnIEE+wdrb8aEjVbpeTuiO0j2ZKzmmFceKD7MTOjFp1WSPaFyg3ghOIOTpOxatzMolSjOWq2hPyrkUeiejUiFAkTNPvKgLVFjjdLQZjCJ0ZPHx9q/Y3uKTOgUmyXnKmYAO4JqdEWBq/thZ7XT3UwgseEi59sLHqf39J0SKNrvwALbVd4oa9SZs0HikXBRc/3dejVFjYDb6xd7d3Mf4Kcm++EqEBDo8LwBUp0Q4JdGM6bh8/BmsxnBn1R1vYh2CHtKA9DPbSl9VmuBELb15YqtNVloryYcjFwiGYbOrb2upw1KQYz1PlgVafdoHXCzn320jI1WVGk9nVL/J1NPWJ/wPtQ1cdKQVNJbTZb5LVWE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(23010399003)(1800799024)(366016)(376014)(7416014)(11063799006)(4143699003)(3023799007)(56012099006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUxMcDJkak1ncFMxbFRCbWRWaW15S3lFdUdBUFFUekZ5blVuTmhNU1pvK0pa?=
 =?utf-8?B?TEgwZTNEZjh2d2ZDQ3lkNGo5KzhrMjE2My9jNEp3MXB4RXkxbGJlOUpnbEZD?=
 =?utf-8?B?cVJXd05kaHU2aXlYa21tYjZ4UTZ6VTRCT3pQRlJ6UEFPcE1IcmowMmg3K1px?=
 =?utf-8?B?cHlYd0VNUUtqbGF0UUdrSkNSd0hQdUt5LzZmbldOeW84aU9PU3Axa1htWVYv?=
 =?utf-8?B?RDVSN0NIMk5URWNhdVpmS0FvKzRVS3ROQkFwVDBRdWo4TlR3WEtxeDFRa1JW?=
 =?utf-8?B?ZHhhSDFOaXJialRNZlJYU1dYYTE3QzBFNVdHbDE2Mk53NUxxWHg0K29teEpW?=
 =?utf-8?B?dXV0TTN6ZEpQN2NLb0oydkFyUHJ1dHdGeGQvR3BUeEROQ2pUZHVCTHZBdm1T?=
 =?utf-8?B?K1J2b20wVUxQRHQvRmladFprbWl5U3haems1VTh5WlR3UTZSVTQ3QjJHcnRs?=
 =?utf-8?B?Qkgwbi9vd2JxMDJHTUMrQ1hQc29uejZ2bzBoRGRiS2lzVVgrMjY4Tmp4SE1L?=
 =?utf-8?B?dHVwODMyeDVZU3lUUE95VzJHMktCNHY0MHM3QkRueEF4YjM0Q3JKVDJycXho?=
 =?utf-8?B?NFlhVlprN0lFeW8wK1Vhb296Nm5LMlc5ZGN6QjFNQ0pwYzV4b1RhbWZqUVJW?=
 =?utf-8?B?SmRSUFFrK2x6Qkk5dEVUODh6M1BuZW1GRnIyMUlCbjJlOHVJNmg5SC9yckRn?=
 =?utf-8?B?dE5CKzZpbFVhY3VqSEFkR09mSFdSUW5iTUlBN1pmdUZCUnN1dWhNU3EwaDFU?=
 =?utf-8?B?TllKOXlmdFpBMXZGVklUay8vZFMwY0JKNmRUOUVIeURORXYwVzRJSXZsNmIw?=
 =?utf-8?B?QUVRRUg1M1oycW5GTDdoQ2JjSkZNUm5iSE14OE1CWDZjMGxKbjk5ZWxGbGpz?=
 =?utf-8?B?eVJPcFhYZmhyTDdCekZVUDRtMVFoYStTU2lOc2ZGUXNFbVA0a2VBUllwYVdx?=
 =?utf-8?B?SmJVOXJ2dEx2TGFtZEYxTGVVTUFhblhQUnhvaFBwZTlYMjJDSUJMTlk2S1g2?=
 =?utf-8?B?dGk1WXVaNHdBdUorY3JmU2I2eWpDcEhORTE3aHEzWVdJdkpZOVMrOXpkTFJa?=
 =?utf-8?B?WDFJSXduZ2lNNHB1ZUtINmRxOW5JTm1mRUVPVlNwT044c1NBMlJkOGowZVps?=
 =?utf-8?B?R3VKUUxNTnA4Ymc1NUtMQm04b2lVdWpES3FxSE8wU3lrZ1RqQkhsWmJHc1Jw?=
 =?utf-8?B?OFRyaVIwRjlib2tWcEhXUEhpYlNWM3NneTF0Uk5ydUVDcFY0QlVJcUtlb29s?=
 =?utf-8?B?MTFWaGNuNlkvZFQ2SG42Q3RvN25OWWFaV1VidnhmK2o3THpjUytFTDBOTm95?=
 =?utf-8?B?dmhuUXZkQUtZWWpwTWZLOFlKczh0UElKbzVmZDMwcm52WE8wR2IxN1oweFRh?=
 =?utf-8?B?Mjg3eHhTTlRQMU5XVmN3Z1puZXMzbE5yRGp2MU9zYVdJaTFMT3lLdkNwcld3?=
 =?utf-8?B?WFNFRjc0bHRsRjQ3eW5VY3g4NkFpN2h3ZWRDUjM2bi9Pekc5L2dwbllUNHlE?=
 =?utf-8?B?WnhxbFk2N01WTmhCK1NrNyt2U2NxdW5TV0M2dDdWRzJTcVdFaVZNcUVTMVht?=
 =?utf-8?B?SUlneVpvcXpqR3RBRTBJYUxUL3dYZVJ4cWVTYTlGM2VJcjlJTWJvSTB5aGJp?=
 =?utf-8?B?QWRLYnBLRHh1WDArY1F5cUV3S2ZGQzVYVXZjLzhmWlNJVHI3VGZ0eDR2SFFZ?=
 =?utf-8?B?dFZoVFoyTzZwcWZFS0lOSWhUd3pSVVpvcGdSUjlVTTE3WGxOSHBNdzhoVGNo?=
 =?utf-8?B?anQ5cFRZemRQcjI2cWUyWmxuWWdXVVJtNWVSdFlyMzhqVmtUdjBmVmJDSVhR?=
 =?utf-8?B?c1ZBUSt2dGszWkdHeWdOd3d1T21rZjVsa3M4VXdJUG5MNExFTFZYZUlXczRE?=
 =?utf-8?B?M2VBRHhFQjI2ZGJpaDZwKzJKS2xhdmVLTXBmeWFNYzBYcHpVMjA5RUQ4cERY?=
 =?utf-8?B?L0VCcDFpenRxRzhKbE9FMHMxVnRVUGluaWZEYkJ2blAxSjIwSGJMd3J1R3hr?=
 =?utf-8?B?cFlwYjI4VWNGdmxTQ2N4VDJZWitCWmpVaVVTRXZHcVdYY09lSE91bW1BS2dy?=
 =?utf-8?B?cHZ3T0JxQjNTQjRQcFBCR1JVYmZpeUhvZEQ2REpkYXowcjVCSmdFajN5YWlH?=
 =?utf-8?B?VFdSajhTaDRzM1dWeUg5d1UzTzdHNVBPY2cvTndWY08zYnhENnlYNGIxL0Rh?=
 =?utf-8?B?NjJwT2RnS2VqKzh4alJnV1BoWnNRVGFQOS9odjc0RkgvS1VIKzhOb0x6eDFl?=
 =?utf-8?B?YmpvTzFTOW5hankwcmVFUC9GSHJTMzJzOGxyc3ZRV1pncHFTbE1ub2ZYaERa?=
 =?utf-8?B?NnNtR2JzRWZWUXBTOVdzamRYVXkrcm8wTFdpRVNkcXJkNnl1V2I0eG92d3Fj?=
 =?utf-8?Q?YeGdVyRVGzRKLEVcXZMUf1SlnXmnDQWBbtWrtg2ZQG6jc?=
X-MS-Exchange-AntiSpam-MessageData-1: yVLb5PMSiFlsYg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db99b0c2-7014-4572-6842-08decc387ec3
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 06:20:15.3083 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5N2g0bfonhDvpra/JjnN0sVbFANPbYeUNqrPfPo8knO4HQjs1s/Ofht1q2b4DVYaWTkWEV2wsm6oDzFzw4TkLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5715
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

On Wed Jun 10, 2026 at 7:23 PM JST, Gary Guo wrote:
> On Tue Jun 9, 2026 at 9:04 AM BST, Alexandre Courbot wrote:
>> From: Joel Fernandes <joelagnelf@nvidia.com>
>>
>> Add usable_fb_regions_iter() to GspStaticConfigInfo to extract the first
>> usable FB region from GSP's fbRegionInfoParams. Usable regions are those
>> that are not reserved or protected.
>>
>> The extracted region is stored in GetGspStaticInfoReply and exposed as
>> usable_fb_region field for use by the memory subsystem.
>>
>> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
>> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
>> ---
>>  drivers/gpu/nova-core/gsp/commands.rs    |  9 +++++--
>>  drivers/gpu/nova-core/gsp/fw/commands.rs | 40 +++++++++++++++++++++++++=
++++++-
>>  2 files changed, 46 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/nova-core/gsp/commands.rs b/drivers/gpu/nova-co=
re/gsp/commands.rs
>> index f84de9f4f045..d955f52a93bb 100644
>> --- a/drivers/gpu/nova-core/gsp/commands.rs
>> +++ b/drivers/gpu/nova-core/gsp/commands.rs
>> @@ -5,6 +5,7 @@
>>      array,
>>      convert::Infallible,
>>      ffi::FromBytesUntilNulError,
>> +    ops::Range,
>>      str::Utf8Error, //
>>  };
>> =20
>> @@ -191,15 +192,18 @@ fn init(&self) -> impl Init<Self::Command, Self::I=
nitError> {
>>      }
>>  }
>> =20
>> -/// The reply from the GSP to the [`GetGspInfo`] command.
>> +/// The reply from the GSP to the [`GetGspStaticInfo`] command.
>>  pub(crate) struct GetGspStaticInfoReply {
>>      gpu_name: [u8; 64],
>> +    /// Usable FB (VRAM) region for driver memory allocation.
>> +    #[expect(dead_code)]
>> +    pub(crate) usable_fb_region: Range<u64>,
>>  }
>> =20
>>  impl MessageFromGsp for GetGspStaticInfoReply {
>>      const FUNCTION: MsgFunction =3D MsgFunction::GetGspStaticInfo;
>>      type Message =3D fw::commands::GspStaticConfigInfo;
>> -    type InitError =3D Infallible;
>> +    type InitError =3D Error;
>> =20
>>      fn read(
>>          msg: &Self::Message,
>> @@ -207,6 +211,7 @@ fn read(
>>      ) -> Result<Self, Self::InitError> {
>>          Ok(GetGspStaticInfoReply {
>>              gpu_name: msg.gpu_name_str(),
>> +            usable_fb_region: msg.usable_fb_regions_iter().next().ok_or=
(ENODEV)?,
>
> Does it just essentially require a FB to be present? What would happen to=
 GPUs
> without display support like RTX PRO 4500 Blackwell Server Edition?

The naming is a bit unfortunate, but "FB" is generally accepted to be a
synonym for "VRAM" in NV-speak. Nouveau also uses this terminology to it
is not internal-only.

>
> I feel that this check should be done by the user of `GetGspStaticInfoRep=
ly`,
> the firmware doesn't reply with an error.

Indeed. Moving the check to the caller is difficult with the current
code since `GetGspStaticInfoReply` requires one region to be built.

But maybe we can collect all the regions into a `KVec`. This will let
the caller check that at least one is present, and also be more
useful as we will want to see all valid regions in the future anyway.

It will also let the caller compute the total amount of VRAM, rather
than having to store it in the message reply, despite that information
not technically being part of the message.

>
>>          })
>>      }
>>  }
>> diff --git a/drivers/gpu/nova-core/gsp/fw/commands.rs b/drivers/gpu/nova=
-core/gsp/fw/commands.rs
>> index 7bcc41fc7fa0..d025167927df 100644
>> --- a/drivers/gpu/nova-core/gsp/fw/commands.rs
>> +++ b/drivers/gpu/nova-core/gsp/fw/commands.rs
>> @@ -1,6 +1,8 @@
>>  // SPDX-License-Identifier: GPL-2.0
>>  // SPDX-FileCopyrightText: Copyright (c) 2025-2026 NVIDIA CORPORATION &=
 AFFILIATES. All rights reserved.
>> =20
>> +use core::ops::Range;
>> +
>>  use kernel::{
>>      device,
>>      pci,
>> @@ -13,7 +15,8 @@
>> =20
>>  use crate::{
>>      gpu::Chipset,
>> -    gsp::GSP_PAGE_SIZE, //
>> +    gsp::GSP_PAGE_SIZE,
>> +    num::IntoSafeCast, //
>>  };
>> =20
>>  use super::bindings;
>> @@ -129,6 +132,41 @@ impl GspStaticConfigInfo {
>>      pub(crate) fn gpu_name_str(&self) -> [u8; 64] {
>>          self.0.gpuNameString
>>      }
>> +
>> +    /// Returns an iterator over valid FB regions from GSP firmware dat=
a.
>> +    fn fb_regions(
>> +        &self,
>> +    ) -> impl Iterator<Item =3D &bindings::NV2080_CTRL_CMD_FB_GET_FB_RE=
GION_FB_REGION_INFO> {
>> +        let fb_info =3D &self.0.fbRegionInfoParams;
>> +        fb_info
>> +            .fbRegion
>> +            .iter()
>> +            .take(fb_info.numFBRegions.into_safe_cast())
>> +            .filter(|reg| reg.limit >=3D reg.base)
>> +    }
>> +
>> +    /// Iterates over usable FB regions from GSP firmware data.
>> +    ///
>> +    /// Each yielded region is a [`Range<u64>`] suitable for driver mem=
ory allocation.
>> +    /// Usable regions are those that satisfy all the following propert=
ies:
>> +    /// - Are not reserved for firmware internal use.
>> +    /// - Are not protected (hardware-enforced access restrictions).
>> +    /// - Support compression (can use GPU memory compression for bandw=
idth).
>> +    /// - Support ISO (isochronous memory for display requiring guarant=
eed bandwidth).
>> +    pub(crate) fn usable_fb_regions_iter(&self) -> impl Iterator<Item =
=3D Range<u64>> + '_ {
>
> I think this is a bit too verbose. `usable_fb_regions` should be okay.

Agreed.
