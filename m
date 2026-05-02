Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 133F8CD3423
	for <dri-devel@archiver.kernel.org>; Sat,  2 May 2026 15:41:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 648B810E0F9;
	Sat,  2 May 2026 15:41:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="sbe4S3uD";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012044.outbound.protection.outlook.com
 [40.107.200.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FD2810E0F9
 for <dri-devel@lists.freedesktop.org>; Sat,  2 May 2026 15:41:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=od0Ucov75fdOWU+u6ozheX1sHkMoBAWLDmRopAzc94/4uyXYiV0iDmygmtyoUpve9DQeh5ZNqt3AwJM8rZGivCxdN2KgmAW0ZMo7k0hXaTV0vMQBLTEfQV926XKF2QTv0o65aj8eHOHZTk+vpIlbe1TSxpUBB6H7tPfHsVfuE9HNMPGGdB7nHk00mW5HEvdWWOAu8NmcAbSdSufWSDvbeyzrMBQQLgIoxuu/QiWZrgiDp6EMpf0uaDXdNyzsexUbvjeu00dTHtg7HetdcfR7Y9U4cNl6YGXdSkho2Ba/LDMlzuI+6wszFHtYEEyk4N/tkqIST9j4tfyr9/lsC3SG/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u4g34PLMgf+BGBGa9AT1ycL6VauzCdQEu5K3XG4cCnE=;
 b=VObQaDF3c8RwWh222w/VZ+Y/hPYoGBJBhRgrGc7wUzEDFEdJAaxVc0Vnj1Myy1aFzlxU934j28UaEf/7UAm5GvITJRge0hyaYrGM8tcMO8Iakvq1Q5V8JkQacEZMYuyOm0ISS1IX/tNTYpIE/FXIDCOTsh9OFcTV1yr+iALfVtaT9YETpM7TWtj6ikum3kGJaLjKk8ZycOlt+G1xrIgs27eDE/1s5mXDEeZL8/7eaN1nBe/niEe6HpKqRz1zNe8c+XN1mdOLvefj6MM63vyzHMTVSsQQTAs0mrFEKYzgig4iIfQL5Zc6RzK2/WHbDkfZzCSQ16Jgfb2/fXEDO0uiGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u4g34PLMgf+BGBGa9AT1ycL6VauzCdQEu5K3XG4cCnE=;
 b=sbe4S3uDm49+IH1p33VUXNN0NVfur3a1wnqQ595WurgUmGrWoV1QjpyOb5cTjcu5dg5O2bZQey+hSQ2IXvernXHSYEJXo3Y7uy7uuyZkp0iVoX/m5hRSiXvjPYTjwerkwUoSo/r/Ppo7YRfazEmFpftyTSUPeYaWjBCZ0Cn08/tOtN2g8OJLt6TzXWB6JcvorkXbbbaTr422Svjtc2SQgV7ic4IYIIvJC2VtJjtQow4Q9KY2/3eGlg3ydDduhTtgvFdx+zfBrDkl1TuEnew1vTe+/QPxu32cnDSBYFqEJazV2c5+becRbp3iT4gNrUDM066W3vLUJhNPL7RuFa3GjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS2PR12MB9591.namprd12.prod.outlook.com (2603:10b6:8:27c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.22; Sat, 2 May
 2026 15:41:35 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.20.9870.022; Sat, 2 May 2026
 15:41:35 +0000
Content-Type: text/plain; charset=UTF-8
Date: Sun, 03 May 2026 00:41:31 +0900
Message-Id: <DI8AZQ06LCJR.1LDY75WJI77PM@nvidia.com>
Cc: <linux-kernel@vger.kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Boqun Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>, "Bjorn Roy
 Baron" <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>,
 "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, "Dave Airlie" <airlied@redhat.com>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>, <nova-gpu@lists.linux.dev>, "Nikola
 Djukic" <ndjukic@nvidia.com>, "David Airlie" <airlied@gmail.com>, "Boqun
 Feng" <boqun.feng@gmail.com>, "John Hubbard" <jhubbard@nvidia.com>,
 "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 "Edwin Peer" <epeer@nvidia.com>, "Andrea Righi" <arighi@nvidia.com>, "Andy
 Ritger" <aritger@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>, "Balbir Singh"
 <balbirs@nvidia.com>, "Philipp Stanner" <phasta@kernel.org>,
 <alexeyi@nvidia.com>, "Eliot Courtney" <ecourtney@nvidia.com>,
 <joel@joelfernandes.org>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v12 02/22] gpu: nova-core: gsp: Extract usable FB region
 from GSP
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Joel Fernandes" <joelagnelf@nvidia.com>
Content-Transfer-Encoding: quoted-printable
References: <20260425211454.174696-1-joelagnelf@nvidia.com>
 <20260425211454.174696-3-joelagnelf@nvidia.com>
In-Reply-To: <20260425211454.174696-3-joelagnelf@nvidia.com>
X-ClientProxiedBy: TYCPR01CA0148.jpnprd01.prod.outlook.com
 (2603:1096:400:2b7::7) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS2PR12MB9591:EE_
X-MS-Office365-Filtering-Correlation-Id: 183fcb25-f6d0-4f2e-ed6c-08dea8614ae9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|7416014|366016|1800799024|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: +6TriyMwJAwZEqEjuSAfqymu/15cO3tiXAf2tvVySjagnJltn2e4luo5i0Y1M84abqyCmHNdE11mPlHkBBMX/N4dObI9iPPz0aC01CgkZ3dmGhPiaF3hCKycyVYZsWA07lbrE5DVe2EEgw3qdbCTbbK/Oasb4zPA4AsCLQWqtvf79EZUmvfb3WB8CnR9artX5WulMPJ27abrBKG/WremwYDTw+i5b3ev02ZvRCx8aBYx2vuQAY6330vor2d2R1gqicWD0bL2jgtPgyjA2iOWY/IJU7IL7G13Yk7xqf9AX1xM4CUWkcpkDtB3eiyY1hmN/BeDJNjO3lGhIgLAeaAD8/Hue9aw0HQ4iiBKTYGe7wsvAwyddsgNhaa+400tT3dCj25BtL0qAKnsJ3W+gwKKeCtMtBBWarAwIem6P7Rbtc/Gl/6XJOwr/vHZeX5vB+/BaPJ0uq2Il8ctGAZeEDbASi9rDZia1bdl5X1K1wiIg6o/4Sh08wJtrSpTp89MRMJzr9MtVrQqOBfUEdopMglqrXBKjOcgA/wvmMZmwK5YYxd/z2TNCuXAqXwIo8xZH8Io6O/1OMlnr+YJhLGUQOwss7huPG6S6a/D+dfasR6pU5fu6DfUL2fQMcKiGP8URK/LTIiUDF17wXFoNTMSoM6j19vl43MREpAfBmDO4LCmSQqW9c2SVBcF7aO84/GSEk9Z
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(7416014)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjBYYklVamI5RFZjYzJoNDM1a0ZrWDB1MVRDMGtYNW5pVnBEZlhKNjJGRVNx?=
 =?utf-8?B?ejB2dk14ZElySlVzVk1lMGJHS2VxSzNZUFd3a2tKSTZ3OEsxcHlKUXJ0d1E4?=
 =?utf-8?B?UktOWGpJRVlIT2JTMjR6R2M1YjY0eWtBYlZvWXFMSDhGSTZrQ0JSbWpmYzJE?=
 =?utf-8?B?cXlNRm9tZWQyZmMyNjNpRXdkUWRDT0JCdFdyTVdFNngwS2N2a3hMc2pVM1I3?=
 =?utf-8?B?ekFoOGs4cjY3aHpnWDRSY29DdldBL1FUcGEzd0hKenF1eUpqZUFSM0hmUTUr?=
 =?utf-8?B?UGJuUzdzMGJ2Q3Uvb2hwRFRpWk5rZG8zVVhpZVBMN2JTUGw5NW5yU09hQUpZ?=
 =?utf-8?B?dWdLSDNzZ1lBdmQ4RkdyVFV2UlVadGk3WUdXektMSlNiUW8zRm03SDB5aVg3?=
 =?utf-8?B?QkE4YWkzbUxxS1VLZytwb1FhNDRFQ1B4MnlSMEFnZXFrNENNdWxacHF2Z1Y5?=
 =?utf-8?B?S2gyRExVNlhCMFlOR2YvU1VraUtVZWF6NjZMSzFMZTQ2MXd6dnRmRkllQmFk?=
 =?utf-8?B?NStGMzhqRTRWcFQxWnc4ODVrZDF6Z1I5elhDQ1FVS3M1L2FrUkFxMXJMTGMz?=
 =?utf-8?B?QmVEeXNCSTIxb3RXcnF0TGx4NDFNV3Q4NVVoZ1o1enlsUksrVHlOZzNYOFgx?=
 =?utf-8?B?eDV3RSswV1VsbHRxS2hDZU9CWDNhektUbFQ5OXNFNzB5dTJ3OU9tWGVTUlNW?=
 =?utf-8?B?NCtKZCtOQWF5ekpQdjBDNnlGbk5DckhyWmVXREtUbWhhYVdrYjBlVW1YQXcz?=
 =?utf-8?B?eHNlMFNGa2RwR2hxZkl6MmcrVDd6Y2RnWUxXSkE0WGpBTVo2ekhqNXF5MXVL?=
 =?utf-8?B?V1p4N1JjWHBrdndYTEhmRW9CV1NER2duZ2txUW9JZWd4OUNyN3B2NmZ4L0lL?=
 =?utf-8?B?ZThvV3NIbmpLZUlLdW1MRmZ0K09FQVVsK09zZC93NDJnZ3cybE9JZFIzNmt5?=
 =?utf-8?B?c1NzcjdkM0dpajRxeEQyMGtuWE5NcHRpSHVSdzRGL3ZWUVRSZmVmaDE1aTV1?=
 =?utf-8?B?OGh6RUthWndoMW41c0hNUDNJSmpCMTdaTllHc0xMVkhnZEt5dUZKWWNyL1BH?=
 =?utf-8?B?S3VtOXlOSUMvMTlHaElxUEwxK1NGdW5aaExuRS93NGh2ZFdNS3A3RTdVTUE1?=
 =?utf-8?B?SXlhUmF3UUM0VmNoa21nZEt6SGVRN2phVUNSeWxrMWt5WDJRMFh2THVEOVNF?=
 =?utf-8?B?VDRobzhwMU4vNXJ4cFU1K0d2bGlDRjJNcm9QMVZXMjlxMUhEMEloK1c4UUZQ?=
 =?utf-8?B?WUdZUGFvalFIU0tQd09SQnY3V3lyK1hGMzNib3pjckZQNFBVQVpreEJYSDB2?=
 =?utf-8?B?WkxwMGZySHByOGpUOC9xbGNUMDU3VlNOdG9NR3hWaG9SRm92MHIrY3UwcGd5?=
 =?utf-8?B?bGtIeGZaUnMwSVlvcTg4bVZnRGhlUGVsVUN6NnYrcTUxUklyWmVjTk8wWnRm?=
 =?utf-8?B?RDE2aHRyeDZxRFBzelkwYnlDUVBRUklwbzI4RE12bUg3T3VLc0lyYUIrMXZv?=
 =?utf-8?B?dTlkU1YxVjVZNWlEbmZnSDlQdDhKTHd1MVkyNmhvcWh6ZFZUWHJUdURZMG8y?=
 =?utf-8?B?UUJMallmNG15cWdsSzV6bld6akpFMUVMbWhvak5jSG9NZG5UeFpnbmVQcG1x?=
 =?utf-8?B?V0FiMEZwMTNONWJtVk9ZU3F3c1Y1Q2pUeVRENXJNVDVWR2svZng3N0FSZE9Z?=
 =?utf-8?B?MHdUcEVibEpubjlGSXlQVWpCcDdpWmlXbldEQjJXdThxY0NVUEhDSkU5VElR?=
 =?utf-8?B?TjVGblhuSlNsUzlWWDJQazRsTGwzZ3EvLzRrV2poaktxeTkwK3I1U2Jzemcr?=
 =?utf-8?B?V21VU3htMjNTYkN0b2ZQdlU4OVJOSUM4d25RZXZmVUxHTTZYbG9PUGV0SGR6?=
 =?utf-8?B?TVg5WHF4NVVyK2paeExLK2kwcGNZT1BxMG5jbEw4MjBLNVIvRTVoTE5yQnE4?=
 =?utf-8?B?MmFSNFlQMnNkWmhza1BFV3h5RUJNaUlYbTFLQTFMaEJIZ3lXS0RkblFZcXhI?=
 =?utf-8?B?dGd6UFhXbnRnMHlGYmRJVllxMHM4QXN6bDdIdHJSbEQ2V2pHeEh0K2l4d1JV?=
 =?utf-8?B?T3pqREEvQlEyQjlaVUpWUE10VDNVZFowU0NXWloza25kY3VsZHVDOVRtVnFY?=
 =?utf-8?B?NFpDRnVsd1BtT051NlY0MFRPWFJPdytUL3NUUGREMGZrL0FhZ1dZb1J1Vmxx?=
 =?utf-8?B?MzVIWGNKdmFud3BSUW9GR3hCN04vUHo5QTZvVzFVdlpTL0tvUVVNU3V0RkFT?=
 =?utf-8?B?eTlOTXVldXgzWUhXK0l0SS9QbTM3cktlL01aTEJaUStLSWFZMWZvTUdZNm1Z?=
 =?utf-8?B?VXdjeWVtV2RtVVRkaGtRUVlqOVh2Znoyb1RnVUxlWUdRUVFPT2RjTHFFbUVW?=
 =?utf-8?Q?Uwn0kJH78O1WX9iMJmxex8JQtzp8TFuUgKFGKaau0/qH4?=
X-MS-Exchange-AntiSpam-MessageData-1: VkYeSHIJuyu8wQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 183fcb25-f6d0-4f2e-ed6c-08dea8614ae9
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2026 15:41:35.6903 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 69GQlM1BfksAFhwie68XuPD/cjF8xKZqBC4x8PGHBsyUVKqCOOitubUWn+yVo2JscDOqxOaFH3MPB0nW5vpAsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9591
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

On Sun Apr 26, 2026 at 6:14 AM JST, Joel Fernandes wrote:
> Add first_usable_fb_region() to GspStaticConfigInfo to extract the first
> usable FB region from GSP's fbRegionInfoParams. Usable regions are those
> that are not reserved or protected.
>
> The extracted region is stored in GetGspStaticInfoReply and exposed as
> usable_fb_region field for use by the memory subsystem.
>
> Cc: Nikola Djukic <ndjukic@nvidia.com>
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> ---
>  drivers/gpu/nova-core/gsp/commands.rs    | 11 ++++--
>  drivers/gpu/nova-core/gsp/fw/commands.rs | 45 +++++++++++++++++++++++-
>  2 files changed, 52 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/nova-core/gsp/commands.rs b/drivers/gpu/nova-cor=
e/gsp/commands.rs
> index c89c7b57a751..d18abd8b5f04 100644
> --- a/drivers/gpu/nova-core/gsp/commands.rs
> +++ b/drivers/gpu/nova-core/gsp/commands.rs
> @@ -4,6 +4,7 @@
>      array,
>      convert::Infallible,
>      ffi::FromBytesUntilNulError,
> +    ops::Range,
>      str::Utf8Error, //
>  };
> =20
> @@ -189,15 +190,18 @@ fn init(&self) -> impl Init<Self::Command, Self::In=
itError> {
>      }
>  }
> =20
> -/// The reply from the GSP to the [`GetGspInfo`] command.
> +/// The reply from the GSP to the [`GetGspStaticInfo`] command.
>  pub(crate) struct GetGspStaticInfoReply {
>      gpu_name: [u8; 64],
> +    /// Usable FB (VRAM) region for driver memory allocation.
> +    #[expect(dead_code)]
> +    pub(crate) usable_fb_region: Range<u64>,
>  }
> =20
>  impl MessageFromGsp for GetGspStaticInfoReply {
>      const FUNCTION: MsgFunction =3D MsgFunction::GetGspStaticInfo;
>      type Message =3D GspStaticConfigInfo;
> -    type InitError =3D Infallible;
> +    type InitError =3D Error;
> =20
>      fn read(
>          msg: &Self::Message,
> @@ -205,6 +209,7 @@ fn read(
>      ) -> Result<Self, Self::InitError> {
>          Ok(GetGspStaticInfoReply {
>              gpu_name: msg.gpu_name_str(),
> +            usable_fb_region: msg.first_usable_fb_region().ok_or(ENODEV)=
?,
>          })
>      }
>  }
> @@ -233,7 +238,7 @@ pub(crate) fn gpu_name(&self) -> core::result::Result=
<&str, GpuNameError> {
>      }
>  }
> =20
> -/// Send the [`GetGspInfo`] command and awaits for its reply.
> +/// Send the [`GetGspStaticInfo`] command and awaits for its reply.
>  pub(crate) fn get_gsp_info(cmdq: &Cmdq, bar: &Bar0) -> Result<GetGspStat=
icInfoReply> {
>      cmdq.send_command(bar, GetGspStaticInfo)
>  }
> diff --git a/drivers/gpu/nova-core/gsp/fw/commands.rs b/drivers/gpu/nova-=
core/gsp/fw/commands.rs
> index db46276430be..a34d29280430 100644
> --- a/drivers/gpu/nova-core/gsp/fw/commands.rs
> +++ b/drivers/gpu/nova-core/gsp/fw/commands.rs
> @@ -1,5 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
> =20
> +use core::ops::Range;
> +
>  use kernel::{
>      device,
>      pci,
> @@ -10,7 +12,10 @@
>      }, //
>  };
> =20
> -use crate::gsp::GSP_PAGE_SIZE;
> +use crate::{
> +    gsp::GSP_PAGE_SIZE,
> +    num::IntoSafeCast, //
> +};
> =20
>  use super::bindings;
> =20
> @@ -121,6 +126,44 @@ impl GspStaticConfigInfo {
>      pub(crate) fn gpu_name_str(&self) -> [u8; 64] {
>          self.0.gpuNameString
>      }
> +
> +    /// Returns an iterator over valid FB regions from GSP firmware data=
.
> +    fn fb_regions(
> +        &self,
> +    ) -> impl Iterator<Item =3D &bindings::NV2080_CTRL_CMD_FB_GET_FB_REG=
ION_FB_REGION_INFO> {
> +        let fb_info =3D &self.0.fbRegionInfoParams;
> +        fb_info
> +            .fbRegion
> +            .iter()
> +            .take(fb_info.numFBRegions.into_safe_cast())
> +            .filter(|reg| reg.limit >=3D reg.base)
> +    }
> +
> +    /// Extracts the first usable FB region from GSP firmware data.
> +    ///
> +    /// Returns the first region suitable for driver memory allocation a=
s a [`Range<u64>`].
> +    /// Usable regions are those that satisfy all the following properti=
es:
> +    /// - Are not reserved for firmware internal use.
> +    /// - Are not protected (hardware-enforced access restrictions).
> +    /// - Support compression (can use GPU memory compression for bandwi=
dth).

"can use GPU memory compression for saving bandwidth" maybe?

> +    /// - Support ISO (isochronous memory for display requiring guarante=
ed bandwidth).
> +    ///
> +    /// TODO: Multiple discontinuous usable regions of RAM are possible =
in
> +    /// special cases. We need to support it.
> +    pub(crate) fn first_usable_fb_region(&self) -> Option<Range<u64>> {

Let's be forward-thinking, and turn this method into
`usable_fb_regions_iter`, returning an iterator. It is trivial to do
(just turn `find_map` into `filter`), we will need it later, and for now
the caller can just do `next()` to get the first region.
