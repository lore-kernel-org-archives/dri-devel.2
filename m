Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF3E9C9830E
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 03:19:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 127D110E731;
	Mon, 28 Sep 2026 03:19:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="O8sVyxjK";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012008.outbound.protection.outlook.com [52.101.43.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9D3D10E731
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 03:19:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N4rYXDg+lqZkM15O0Zb/JiHIJhp9BqrLSpelv25hPkDG4OhcK6+0F62xe9a/gUdxEsOhZISVblOa0yz3GjPbPYrlHNFmeNwaqHIl0w6N5511nc61P86ubt+o42zlX6vcMZ1OuZZ0rr3fYpP1UeUttSrhJT53sTQ9E3kNs2U3BFL8fvp+YJQoeHAmf4p+20ZgNabSqH+Wmnj/m/J+C/+DzLBIrq2/Y0F7i3MYsJeUmgNhqRtd3/EPz4k9PthEr2+3ThmzxoGfO8RG7AQLWeXmO0hOiMzjBNPIsfTgCsy396naEjyEpg8GAimCLKy3B4qQqzRzNqf2OW2sg5wS4yzRdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ekQjOKpENlCYAfdJ76bm9CLiPVesMOrAjeNx7t27FMY=;
 b=VSfUwa/J6VCy1u9OENhvA51FJDMhvX3md/s73ZoSMskHZDMq0ccjf90sstLo+xbsK+QgUBbYIM7xrGBkkvrOLTuTG3PPQbV4RoqjCdW/ljwH4AuckX7PMfZTiRHz6FSZYkQYpGGJesWFPHLvbjSLiqnVteIxPjaoE5tSGHW88i1uJZQDtuTeGMLWqS4MZIEPAIAi4H1Iybf9tToS1SGSvwdohgCBwzeJ8PWekeZ1gOkoBqd4srqqkVo+jVpRO6X9WXxLa5TCICWVXlOnQ/8eTAklqnVK2o7LXXs5LJk5aGEHU58O7vl4gTMr6qZJvo8u9lN270uLjU844NC/J3Khiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ekQjOKpENlCYAfdJ76bm9CLiPVesMOrAjeNx7t27FMY=;
 b=O8sVyxjKHLccZU/YqTsXQodmta0lQTTcbRQ6j07syTWR95vCMPqiBTfFFdZUKl1bntIgNfq4bFHPoLpF7vamGyDAAZY489S0KbWfSqaDJht6eTnchj0IkR82bQELR/8xUUb8p7HLAIiprO+DJR1xvtQf0I+pDkN9ZlQYSVT8DNI5p6Ud+gdsl7oOJuxIN0sjmvF744urINh6y3HefkruIV7aZ3DqsEAKCIWHpZyO+W0UIVypsxCdY+lEEdHvAjcM8Wi4YZwLK+smA3xxUt0XZtmOtg1CoV0x4u2US8lxTxRRqBPDoGxtJ4i3aYm7wrL496ngp0K+G76AEj9rQxAJEA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by LV1PR12MB999305.namprd12.prod.outlook.com (2603:10b6:408:3f8::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 03:19:20 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 03:19:20 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 28 Sep 2026 12:19:17 +0900
Message-Id: <DLQMIL9HQRBR.3N6WCVYOAM5H1@nvidia.com>
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "John Hubbard" <jhubbard@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Benno Lossin"
 <lossin@kernel.org>, "Gary Guo" <gary@garyguo.net>
Cc: "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 "Eliot Courtney" <ecourtney@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>
Subject: Re: [PATCH v2 6/9] gpu: nova-core: gsp: cmdq: split the transport
 part of the receive path
References: <20260927-cmdq-rpc-v2-0-c3f66ae73be4@nvidia.com>
 <20260927-cmdq-rpc-v2-6-c3f66ae73be4@nvidia.com>
In-Reply-To: <20260927-cmdq-rpc-v2-6-c3f66ae73be4@nvidia.com>
X-ClientProxiedBy: TYCP286CA0119.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29c::18) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|LV1PR12MB999305:EE_
X-MS-Office365-Filtering-Correlation-Id: b0e429ea-9672-459c-4f35-08df1d0f496b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|23010399003|10070799003|10067099003|11063799006|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: IdxoHheYhRDhQmzjR3+7p4T0XB5rMeYGfaRwwu2mfwf832dkSlz+pcQpIW+OqpqWPSpUAWFFt90Yy5yTFcT22TuHye/twzK4OiDPfr3WOJVj4rg6JAb9VkaYtvLr82doKhfN/Gpm6iQOPcU4MJjPd0ezrWsGvjmBx5TtlHyuyLlcAuo51DqUnXIO9A9YOxexf9bpJFRL8Qh7gkU0KqIjQOZiREDzZf3t6osfwgFa7cuRXnir6Xupk+YQNvNBhW1qm6e4zaXyr2qu5KfjyWIkC31c52z3zwWw+sJgdIiMP0bZioV66NtUoqLSK/zh3aw90s1snkOMJT8V8+fPk1dPirc5mI05laZ7A5MJa5EwMweNO6LjL8Ztk1ZxvV8diOjiaY75cUpWRTggHldDGm5vqHTAFUWTRnpnwe65eEGBB6c8ERl1eDP1ATAu5Qz70Njj4Vr/ydLZn39BtMBrW0OYgrvqXkd7M6ra2JFoFdgSrxQAxX6Jy2SmbQNkQA2nZhXApP3ikXfirOZ3HDp8rBX+A29z8xXzzLBbZzSwF9LeOQBfdhgeZBqgk6msjHI4B9luXfWybrrkau2T1/YKn89kVR9fn04gTXd+NvnA7lNx93Dyp6Ku5/p/B0M+OFA8Dou7PMkPSc35gpBgJzeD9HesjbejpFkmQAItu+mfFc5UTzQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(10070799003)(10067099003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUdDVkxhNUVuSFFZd1pHdUoyZ1FVc0FobXdHUjlZeFlaV3laMzIzNFlXL1No?=
 =?utf-8?B?NEZxUkpqRWNCZjR2L1p3b2FvRUJGeTNoWm9LYy9zeThXNEFvS0ZMRGY2Q2lB?=
 =?utf-8?B?ZlE5b3JNQnhDMFh1bWhObzJoYXJ0TDZUSERFVWpWQUo5MVhQODdkenIwMi9i?=
 =?utf-8?B?eENpSzNWZkRsWHNFZGtoZ0o3RWM1RmVIckxDVnMyN3FMK2NLdHMxRkgxL2hE?=
 =?utf-8?B?MTBKYUdTbnNQYmFLWFlJNmVwVFU2WDEzbDNrUkk5bmV1cWJkK216d0I3cVdU?=
 =?utf-8?B?N2ZhcVhYVXFWTzMxUDh0WmpmWFBDV3hiWEZZQ2VkOVhMQmF2T0lBb2FWS1Nl?=
 =?utf-8?B?N2hxdDFrbHg5NFVZaDc1b3V5N0VKOWdxLzM5TEJyQktSejY3bVhjODRvTHU3?=
 =?utf-8?B?Wlc4OXhsc0UxcnQvTXY0QWNWL1VwWmRuWXBoMEE0bnlPbzEvTGppZmVzZjA0?=
 =?utf-8?B?R3NDUkNDS2pMay8vdEhZeUlNS3VmMll3OHFBRURXamNUS2RGR1pYUFRFQ1lW?=
 =?utf-8?B?ZmhSaGdBSWx3NzJ1WVJpbXBaajZ4UFM3TVJhYlJERjdkVzN3UUVzSWhRc08v?=
 =?utf-8?B?WFdlaTd1SzR5Ukg3bVBwRmM3UHNrQ1k5ekpLQ2ZmTEFOZU5EaG1tNkI3SEl0?=
 =?utf-8?B?V2VPTWZtcDAwNFl3cFptQVk0MjBnWTh2dlhPVVJwaHhWTUZrdlVVcWNXVVIw?=
 =?utf-8?B?TWhZT0IrSmVxRXBTZjBSbldqellGRm5ZOGJkMWQvYks4Q3BETjNhWVl5NHE1?=
 =?utf-8?B?REJ3ckV2Z0dTRGJVOFltdHBBeEFSTG91QVBqZ2U5Z2x6SnRSUXQ1M0tLTTho?=
 =?utf-8?B?SWxMRUp1cFZCWDdBeDFrMEJ6eHVLcTFDWXFhRVduSVlmblZYQU5MWXB1UG5S?=
 =?utf-8?B?dzlpTlhrWmRJVS9NcFFyeERFVDZqT2JDN0pVYkJlamkvVWI5K29vVUhYc3dx?=
 =?utf-8?B?VEZWcVVra0pqdlY5QWhFNktPTFRuSUM0ZVoyWk82WXgxRUltUVE5OTIvMktO?=
 =?utf-8?B?eVZPaEpBWTFDMWRzaXByOWVyMGRvVTN6NStEVXFVQ05raTRabmZybUNYZDBv?=
 =?utf-8?B?Tzdnc25oUC8rOGx6VHJzTlo0ZzVpREIwVzdpZW1pbWs1UzJiYUpQcng4dW9O?=
 =?utf-8?B?Tk9KLzFRQ0p0cDBoWGNodENUMkZuWEZieS9JL0hOcW1tUDFJRHAvRTN6OHU2?=
 =?utf-8?B?cXpUeU5yQ0lEQTBXZXVxUno4R1lkNGEzd0szeXYxOGZVU0hVSHcyaWtwZk5L?=
 =?utf-8?B?MG1tbjZjd0M5Qmk3YzUxSWoxTW1LR3NseTFFZDhJczVUek83RmFWYVVKTTY5?=
 =?utf-8?B?OFVVRVRKODlxbGlJUHljMUlybENZMmdqVEFNU0ozTjRzVVVaNDFrMkJjT0hI?=
 =?utf-8?B?K1N1VnZESHlLQ3R2UEYraXFibWhhR0RYbld3bUtLU1QvUHh4NlFMTFNSdk1H?=
 =?utf-8?B?WmdxcCswTmdrWVh5ZU81NllUN2RRd3ZjOWNoYmE3ZHBGcnJmcUxYZE9zTVg5?=
 =?utf-8?B?aWlJM3VCUENHSmFKWWdKNE1Qbm5wbTdjL3ptVE10bEJnSWkwaW44RGRjeHNh?=
 =?utf-8?B?bzBsQkZDQ2tyL1hueFJZZzFyZzJJdnlXb1MwQW5aZWF4bTRoem9KNXBtbjdo?=
 =?utf-8?B?SlM4VDE5b1d0akFjd3FkUkJ4aURualRNZnh0d0g2UVNoV3RYRmdxREZMdWFu?=
 =?utf-8?B?NzBaSDhRQnljT2ZvRVBSSUVHK290QVRKSjFEOVZDWCtoVXhjb1doZjdqMUdm?=
 =?utf-8?B?UktmU1RPM2F6dVpIbWt3YVBDUGxkeTBoS2VJTU1BYXlua2pCSU5QVXdOcmFw?=
 =?utf-8?B?S2RjMCtZemF4cTZtcFZmY3QzUEhrcEZ3THZiUmpiUGE0UEtHSlJIemFlcUg0?=
 =?utf-8?B?Wit2TjVyZVo2M1dNRmVweVN4SVNxYWIvdHBkZ1hkQWdFb2RKUVdRanhMYS96?=
 =?utf-8?B?YlZMbHc4SGlBZWJwT2Y4TUd2NHUyY0N3V0dkU0ZnSDJBOVJpUXlPdDZUL0Nk?=
 =?utf-8?B?SnZNQmdCeTk2dzZkZnp3LzdCWVlSTk0vc2NXL0hubHpzMHd4REp4WXdGdllh?=
 =?utf-8?B?ZDFhTkdRSEZtNk9ncDRTQkJ2Vk03R3MveWthL1hPVlkzeGdkTVF4SDNrNzFk?=
 =?utf-8?B?WXdhU3dFQmFibHdaaTdZQjRGQi9iQnpCc2ZIV3N1V1RVVjQ5NU80ZkJOZXFK?=
 =?utf-8?B?VGJ2aWlIeUtCeVpYcnBrZHo2SWd3ZWUyekNqTGp2MkgvQnppR2lwN2pLWFlO?=
 =?utf-8?B?cVc4YW9hYkwyZjllaFNuUUp3UDFiS01nbGxmSVVhUkVGQXBpR2FWemI4VWJz?=
 =?utf-8?B?THUybGRzaW1WVzdnVG0zWXBvaVg0VC9zRHNlakZjZlMwUVhhZnIrTjdyYUdo?=
 =?utf-8?Q?aCV/qMMVhTUgiP6BGzd/a11x/LL7JmILnxZzjxHP6Z+OT?=
X-MS-Exchange-AntiSpam-MessageData-1: KmbtCyY79wnFzw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0e429ea-9672-459c-4f35-08df1d0f496b
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 03:19:20.7089 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UPGcQ4sD64HVIWCDGf5rRVRLARn5PtFLJRRkZpqMaxZW+d/m+iZuq0aXJvvDNAN5Oo4UQro8M5ioCHu+qstutQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR12MB999305
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

On Sun Sep 27, 2026 at 10:46 PM JST, Alexandre Courbot wrote:
> `wait_for_msg` mixes two layers: the transport layer which polls the
> queue, extracts the element header and validates the checksum, and the
> RPC layer which reads the RPC header and trims the payload slices to the
> length advertised by the RPC header.
>
> Move the transport layer into `wait_for_element`, and introduce
> `consume_element`, a transport-level method which runs a closure on the
> next element before advancing the CPU read pointer past it, and
> `parse_rpc_message`, which validates the RPC layer. This sets things up
> for moving the RPC code into its own module, leaving the transport
>   agnostic of the message type.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
>  drivers/gpu/nova-core/gsp/cmdq.rs | 91 ++++++++++++++++++++++++++++-----=
------
>  1 file changed, 65 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gs=
p/cmdq.rs
> index 640afe2e29cb..169ef0865339 100644
> --- a/drivers/gpu/nova-core/gsp/cmdq.rs
> +++ b/drivers/gpu/nova-core/gsp/cmdq.rs
> @@ -411,7 +411,7 @@ struct GspCommand<'a> {
> =20
>  /// A message ready to be processed from the message queue.
>  ///
> -/// This is the type returned by [`CmdqInner::wait_for_msg`].
> +/// This is the type returned by [`CmdqInner::wait_for_element`].
>  struct GspMessage<'a> {
>      // Reference to the header of the message.
>      header: &'a GspMsgElement,
> @@ -566,7 +566,7 @@ fn send_command_element(
>          Ok(())
>      }
> =20
> -    /// Wait for a message to become available on the message queue.
> +    /// Wait for the next element to become available on the message que=
ue.
>      ///
>      /// This works purely at the transport layer and does not interpret =
or validate the message
>      /// beyond the advertised length in its [`GspMsgElement`].
> @@ -584,7 +584,7 @@ fn send_command_element(
>      ///   message queue.
>      ///
>      /// Error codes returned by the message constructor are propagated a=
s-is.
> -    fn wait_for_msg(&self, timeout: Delta) -> Result<GspMessage<'_>> {
> +    fn wait_for_element(&self, timeout: Delta) -> Result<GspMessage<'_>>=
 {
>          // Wait for a message to arrive from the GSP.
>          let (slice_1, slice_2) =3D read_poll_timeout(
>              || Ok(self.gsp_mem.driver_read_area()),
> @@ -606,18 +606,65 @@ fn wait_for_msg(&self, timeout: Delta) -> Result<Gs=
pMessage<'_>> {
>              return Err(EIO);
>          }
> =20
> +        Ok(GspMessage {
> +            header,
> +            contents: (slice_1, slice_2),
> +        })
> +    }
> +
> +    /// Wait for the next element on the message queue, pass it to `proc=
ess_element`, and advances
> +    /// the read pointer past it.
> +    ///
> +    /// The read pointer advances regardless of whether `process_element=
` succeeds or not.
> +    ///
> +    /// # Errors
> +    ///
> +    /// Errors from [`Self::wait_for_element`] and from `process_element=
` are propagated as-is.
> +    fn consume_element<R>(
> +        &mut self,
> +        timeout: Delta,
> +        process_element: impl FnOnce(GspMessage<'_>) -> Result<R>,
> +    ) -> Result<R> {
> +        let (elem_count, result) =3D {
> +            let message =3D self.wait_for_element(timeout)?;
> +
> +            (
> +                u32::try_from(message.header.length().div_ceil(GSP_PAGE_=
SIZE))?,
> +                process_element(message),
> +            )
> +        };
> +
> +        self.gsp_mem.advance_cpu_read_ptr(elem_count);
> +
> +        result
> +    }
> +
> +    /// Validate the RPC layer of `element` and trim its contents down t=
o the RPC payload.
> +    ///
> +    /// # Errors
> +    ///
> +    /// - `EIO` if the element is shorter than the payload length advert=
ised by the RPC header.
> +    fn parse_rpc_message<'a>(
> +        dev: &device::Device,
> +        element: GspMessage<'a>,
> +    ) -> Result<GspMessage<'a>> {

Since this trims the payload, we should return a different type
(`RpcMessage`?) with a field referring to the RPC header, otherwise we
risk getting confused as to which headers are in the payload or not.

Not re-sending just for that, but wanted to flag this for v3.
