Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 945A5C98328
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 06:19:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E144810E79C;
	Mon, 28 Sep 2026 06:19:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Arsu/03M";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012071.outbound.protection.outlook.com
 [40.93.195.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5BFC10E7A1;
 Mon, 28 Sep 2026 06:19:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=We+EzDH8EnyY9q4ENVIQbt00ebYnAjDvs78KonWFZyFOCit7u3w2rx208gkk+nNxnYu2tKbGEgP+nNeS2Y15E2nB3n00VZWO6wJ8QOvbHDeEWS+jMejPB4C1pkP43podMw5N8IMG9DdRvSUoalGIKqOF6F+3j831Mntc5sVFUul6Ytq36IFqtyEG4S11VdaPJOgJQbSNQkfl5Q90GEYknl4F/F/y+FRdkHMOYMjUNa/VyM/+5MMZedPZVdKilK5vwqXu99yydFI+tZOQr2J4wHVw9Q0ELVG+tdtgn/XkXj37XvoG1nnQyxVvI316yLsFjvs9KVJtloYiWBB1M5gTNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FlYOflMS6TmsvmrLKLuxnJaM36/HAICp+2Y40xIkRuM=;
 b=WlAeL0CY7bg5dzU/WwQIHppM9gEbt0AHp1SfA71m7S5ydpvkA+op2Rtv+IxzMbTCa18lb0OlVTG65GTirpLuhS1KsRq7ICscq0cpVUI2VJT+vCw/k1mgusPBF+yphF9oFQUlqmJIQNYhCVMzicH9ZOhpHpoM3mP278dbnQfO96EgRzarMomvm7xg3DNnLMgEKnRTYmhQpv7mpnMpzaWeOXshvZWUTj1+N3cdbg0HKOTzUsKMwAivmeCDeEqFZ0MOHoEulScSad4ZT4TsH96fIaijyB9fARhJEgB1ebzgOcyqjXuPfsXFUeCztIkgzeba4ol871vWuyy9m0YXjy5ZmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FlYOflMS6TmsvmrLKLuxnJaM36/HAICp+2Y40xIkRuM=;
 b=Arsu/03MRvDEckEMRLIpgx3RpZQn28EhYSQ2TJ/FnkFfW/mD+wX9bjZBS2oXXsfEwqOuApnHiygriU96xH7OEfP/mXYsFyq9gqZkpFiVxS3Buj3Ovbv9AQ6xHg9KAj9rKD1uUJK2fq7Zz4YjLhxXrVf/Ku2yW3gjspwflkUPqKie1BXHyD5Hf5rJefbQMV4EI08C3iThJcA20fwzszOmNVwetJZvuaKwH4FGIW2Q0AbvGZvV7rhXZgj5Fz1VPXo4I6ALl/PjMrAmNkNEKgfJ8FxIRNOvu0YlPjT3/5YqqwF/3N8V+yEOmunFlLcmjeXp00FJu+VZ0+PvOQvATZEq9A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB6858.namprd12.prod.outlook.com (2603:10b6:510:1b4::20)
 by IA5PR12MB999277.namprd12.prod.outlook.com (2603:10b6:208:608::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 06:19:42 +0000
Received: from PH7PR12MB6858.namprd12.prod.outlook.com
 ([fe80::a550:dbcf:2fcf:463d]) by PH7PR12MB6858.namprd12.prod.outlook.com
 ([fe80::a550:dbcf:2fcf:463d%6]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 06:19:42 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 28 Sep 2026 15:19:28 +0900
Message-Id: <DLQQCJRLIWXA.32C5JK2QOGGTW@nvidia.com>
Subject: Re: [PATCH v2 4/9] gpu: nova-core: gsp: cmdq: split the transport
 part of the send path
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Benno Lossin"
 <lossin@kernel.org>, "Gary Guo" <gary@garyguo.net>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Zhi Wang"
 <zhiw@nvidia.com>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
References: <20260927-cmdq-rpc-v2-0-c3f66ae73be4@nvidia.com>
 <20260927-cmdq-rpc-v2-4-c3f66ae73be4@nvidia.com>
 <DLQP0I37RZTD.4C52AA74ID18@nvidia.com>
In-Reply-To: <DLQP0I37RZTD.4C52AA74ID18@nvidia.com>
X-ClientProxiedBy: OSTP286CA0101.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:219::17) To SN7PR12MB6862.namprd12.prod.outlook.com
 (2603:10b6:806:265::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6858:EE_|IA5PR12MB999277:EE_
X-MS-Office365-Filtering-Correlation-Id: c481abe4-0211-40c8-2074-08df1d287b43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|23010399003|10070799003|3023799007|6133799003|10067099003|11063799006|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: VajMFb8ql2o9MuN7jQ0nb10Xt9p83fzC2ePWwy8KhgxoyqhnNJWaKWPORpsyR2ClUiGR0RVvh2ZaQdEFhPvW5w4T0q+FsoAtj6s81TcUI8Pa4Ag7Fcs8q6HwVRoAaqErk6s/JMjy2+wY64fvcto4L3StxYf3ppOnIRkw1UfG9jCJidG5g0z1BbKE1c48yxEWymieuJ0I/cyifs1KgmN6aOOMW5satS4reJXtpU626AOqmKlhQ2qD8U3DIErCVLlAnChALtwy2IpVTzvuQqdsNvtze9ugIMoXzZXPDA4LlTfcGLsJo2Gyh3yz/kvxXon2jn+ujGgjE36+qUaY/+Zk/MztDtmfv3xHvtFd+Lw6Ziwh2ACUq6oh7BWuXyd0NMV1iRW2cUwWxMIg3CnRJdN/f9WJMJNFBCpow90Yu0LcoOgHcZ/j+mBtgux4971d7rvnk56uXEFZuJP4WP6dvjn/EuBkFQniFiS6Pq1qcExmqecBwHXkbPkAPjhpQefqQlvClTT/l4Nq/YbJe3JxH+D0fzUNsApJyZV9M2HaYQm9TgnoZz55UJVY7XEd4cAJsYuhKaQ2JM9ASfxpjrWiSBH0YgHUfzWs7FXgtzVnQ0P3qlauBaot8LkM9Q9IPYhfyP7LXZB0m6O/VK7R4SlMmJ24FhPF/clpc3GZVEh8P+eKf+4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6858.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(10070799003)(3023799007)(6133799003)(10067099003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aG1OSGhvd21RU01ib0VUYVJrZSt6Uk5MZnlOQ2p0QmFtZTYvcVBxOGZDSVN6?=
 =?utf-8?B?cWgyYlNEdHNwRkFhNmZpeW45NFBza0tkUjFTd0NIZGNqY1lYekVSY0FvWi8y?=
 =?utf-8?B?VENydlJqMXhBempjNWFHcEFvMUs4Z3JEc0dDWjBvMmZIUEt4YkIyZ3dHQ1ZX?=
 =?utf-8?B?cENqdk13ODJBSW5xbS9BTGQvUnhXU3J6OGRnVGpjTnRxSU9kdW5uaHZIUHh6?=
 =?utf-8?B?NXRDRGpza0hGZkV6NkIzOVQybGdnUWh2aG5xMHpaMUVWbFBJeFhHRnhjalFH?=
 =?utf-8?B?R2hqRGRUNEJMYkZHbXI3WkErY2xVVDZ4YUZwSmY0OGZvY3ZNZy9DbmltWDJk?=
 =?utf-8?B?UDFzTm5jY3p6RWZVU2N1ZnRldEU0cGFlRnkzSlovQTRmQXJzc21PSGVTSUsw?=
 =?utf-8?B?bHMxWmt4TDJRZ28rZTVTd01oaVVNTTR2M1Frd1N4WkM0NGdFaDIzSC9DMU9Z?=
 =?utf-8?B?R0YyWStDVkFSNU5BQUlpdmdWK2ZadFNselpKSUlMNXZPRGwzazJ5ZGx2RHFB?=
 =?utf-8?B?UGFQdklUa1UwRzBvZWZrNmFWVUtWOVJYdUhLN094WHArak04czVVZ1J6V1lp?=
 =?utf-8?B?YmdMTzNjTzRxZUVJWERiR2VvUEhJL2RTV1VDR1I1T05lWlU3RGhQclMzb1Np?=
 =?utf-8?B?TysvNkpra25pQStML0k2QkF6QVpCRlNtQlAwR3FmRCtIZWVYT3ZHRm1pdHlX?=
 =?utf-8?B?TEVIT2RTdWxjQ0xqNWFyUGp1emVaL2QrVS9sWXJDeDI5WFhEM2UyR0RIa1BT?=
 =?utf-8?B?WGhCNCtPNVpVODYzSE5IUDZqQk5iTEFrSi9qaEZ1VGFxUDdKUk01aXVzZWZB?=
 =?utf-8?B?MzVTbmI5VytGQ24rN1o2RTNGOUxLVXdxais2Vzl1WlJKNkJvVENKcmo1ZVF1?=
 =?utf-8?B?OTdGaXZQd3JGLzhXelBJTk5pL0k0aEk3ckN4M0dXbkl0cU9nUko1V3FWS1pl?=
 =?utf-8?B?M09mS1d1M1hKN2kvekViWGNReVVHUitrbEFGTzExMU0wTVVWb1M4VFNObG1M?=
 =?utf-8?B?cEkzcy9aNXFWaU5CcXNwdnpUUlI2Rjl4ckY2SXgyY0g4dSs2ZEVabGNTaDVJ?=
 =?utf-8?B?K3JJZVcvdy92VmtPd1FPSXBHZXZkMnJxY1JOM1hBK1F4Skx6dldzWXYrLzBZ?=
 =?utf-8?B?K1NrSlNLWDdJam4zWEJ2bDNaem90VVJmZWE0VjhKVmJubk1tbFVRUUp4S0hy?=
 =?utf-8?B?ak1DK3oxQy9KcllwWWE3RE1jRFZwQmNoWEprT1BEb3V2QkZHU2pIVDFTaEND?=
 =?utf-8?B?cDJRVThwemhUYml5TkZ1cUFBK2x5RE42K0NlOURja0x1MUI1UFRkM2FGWDZy?=
 =?utf-8?B?QTRwWGEzSGkxSHp1Ly9RMVY0NFNBNkZPTGxKUVpHcmQwODdIUmhzdGlGNGR0?=
 =?utf-8?B?MU00aktRSnBBSmwyZTM2ZTR0ZnhRSExTMHVZbHdHY3p5RTJsZEpBa2pQTTk3?=
 =?utf-8?B?TXRmU0doNmt4T3ZDcUxFUjB3ZmIyOEZIcVZBWmlxYU1TZ2JvdXJNQUt0VElO?=
 =?utf-8?B?U3BWRCtuQjd2MXp1bklrM1YxNC9jZXZyRzVlZFMzZ0dHMEN3WjMyZE91NVRu?=
 =?utf-8?B?UGtBYnIrV1ZzQ0R6Wkp3bDFEVlVQQlk0YW56UGNLdjV2cHh1bFJ1UXRwaU95?=
 =?utf-8?B?SlR1Q3FudXRockYwTDZMZVNPbTFBNUs1OUtSZXdwVFNuWXhLbkV1WlZNa01N?=
 =?utf-8?B?R051Q0tlNExWSHpFY01aclc2U2thNWlGanNBU0tCM2ZMV0xSbjlqQmU5N1Nm?=
 =?utf-8?B?Wjc1R1h4c29scXprT0U3ekpCdVl1SVdGR0lvU2tybzZud2d0cnlXalhpR1RN?=
 =?utf-8?B?eEwzUzVsOUFEampFMk82WWg5cFdUeUxuOXAyQjJVNjBKRFdaaGM0SStEL1ZL?=
 =?utf-8?B?bzNEVk1MMGtMbm5xK0FmQThZZGhxU3IzaUJ0S3l5MUdhRnA4bngyY1QxZXJu?=
 =?utf-8?B?ZzZzTlp1MU54SGVQZXJtNUpFbEhwSFVWZklxYnBZNktzZy9OU003a3ZqYkVk?=
 =?utf-8?B?NkRrVS91Mm9oMzZrOHQ5MWNTZEFxYmVadWxYMEUvbWdTZG1EZE9kNllobFRL?=
 =?utf-8?B?cGl3S0k5Uis5c2FkQXhEOGRGT3NHYytpL2hUZ0dsSkV5UmFtdXpJL0c5Ky9M?=
 =?utf-8?B?VllBWFM2VldudlVKczh2S2paaENPMzAxWStVMUhzUzFsZ2JuNzg4NVNWWkhu?=
 =?utf-8?B?Lyt6SW1zK2UrZGxxNnJlWTI4YmFYL204N3drNUk0N1p5d2NKSDBuVmFmYWZV?=
 =?utf-8?B?RXA0ZXJIaGhQQnQxQnBBemw3YzVLaFgxL2RVNzFlZnRqOS9XcVFIOHJ5TGNv?=
 =?utf-8?B?QlN0MVNWUjRYZVlQVjB6MUV5MEtNT2YxRVQrOGE0TFhMNDF3MUNwZHpqQVVE?=
 =?utf-8?Q?z/363F7QzA0MwhVcBY9Yme2tWobkkEt/0shaPpmR9kTEV?=
X-MS-Exchange-AntiSpam-MessageData-1: Eb9F6QEuSYFlxg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c481abe4-0211-40c8-2074-08df1d287b43
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB6862.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 06:19:42.3372 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x+ssjlzuARE4RSXn7Dknq4hS5IcHwCylFheiBQLY5AVpPoslyr08avPyyE7aXxceYWC+BOO+b3TCLqdQVNTuNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA5PR12MB999277
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

On Mon Sep 28, 2026 at 2:16 PM JST, Eliot Courtney wrote:
> On Sun Sep 27, 2026 at 10:46 PM JST, Alexandre Courbot wrote:
>> Move the transport part of `send_single_command` into
>> `send_command_element`, which allocates the queue slots, writes the
>> element header, calls a closure to fill the remainder of the command,
>> then computes the checksum, advances the write pointer and rings the
>> doorbell.
>>
>> The RPC part of `send_single_command` (writing the RPC header and the
>> command payload) is passed as a closure, unchanged apart from its
>> indentation. This sets things up for moving the RPC code into its own
>> sub-module, leaving the transport agnostic of the message type.
>>
>> No functional change intended.
>>
>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>> ---
>>  drivers/gpu/nova-core/gsp/cmdq.rs | 118 ++++++++++++++++++++++++-------=
-------
>>  1 file changed, 74 insertions(+), 44 deletions(-)
>>
>> diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/g=
sp/cmdq.rs
>> index 07e8e32c3d57..b6d50b0bd039 100644
>> --- a/drivers/gpu/nova-core/gsp/cmdq.rs
>> +++ b/drivers/gpu/nova-core/gsp/cmdq.rs
>> @@ -638,65 +638,35 @@ impl CmdqInner<'_> {
>>      /// Timeout for waiting for space on the command queue.
>>      const ALLOCATE_TIMEOUT: Delta =3D Delta::from_secs(1);
>> =20
>> -    /// Sends `command` to the GSP, without splitting it.
>> +    /// Allocates enough send slots to store a command of `sizes_in_byt=
es` length, initialize them
>> +    /// using `command_init`, and send the command to the GSP.
>>      ///
>>      /// # Errors
>>      ///
>>      /// - `EMSGSIZE` if the command exceeds the maximum queue element s=
ize.
>>      /// - `ETIMEDOUT` if space does not become available within the tim=
eout.
>> -    /// - `EIO` if the variable payload requested by the command has no=
t been entirely
>> -    ///   written to by its [`CommandToGsp::init_variable_payload`] met=
hod.
>>      ///
>> -    /// Error codes returned by the command initializers are propagated=
 as-is.
>> -    fn send_single_command<M>(&mut self, command: M) -> Result
>> -    where
>> -        M: CommandToGsp,
>> -        // This allows all error types, including `Infallible`, to be u=
sed for `M::InitError`.
>> -        Error: From<M::InitError>,
>> -    {
>> -        let size_in_bytes =3D command.size();
>> -        let dst =3D self
>> +    /// Error codes returned by `command_init` are returned as-is.
>> +    fn send_command_element(
>> +        &mut self,
>> +        size_in_bytes: usize,
>> +        command_init: impl FnOnce(&mut GspCommand<'_>) -> Result,
>> +    ) -> Result {
>> +        let mut dst =3D self
>>              .gsp_mem
>>              .allocate_command(size_in_bytes, Self::ALLOCATE_TIMEOUT)?;
>> =20
>> +        let seq =3D self.seq;
>
> nit: this local reads noisily to me
>
>> +
>>          // Fill the header.
>> -        let msg_element_init =3D GspMsgElement::init(self.seq, size_in_=
bytes);
>> +        let msg_element_init =3D GspMsgElement::init(seq, size_in_bytes=
);
>>          // SAFETY: `msg_header` is a valid reference, and not touched i=
f the initializer fails.
>>          unsafe {
>>              pin_init::raw_try_init(core::ptr::from_mut(dst.header), msg=
_element_init)?;
>>          }
>> =20
>> -        // Extract area for the command itself. The GSP message header =
and the command header
>> -        // together are guaranteed to fit entirely into a single page, =
so it's ok to only look
>> -        // at `dst.contents.0` here.
>> -        let (cmd, payload_1) =3D M::Command::from_bytes_mut_prefix(dst.=
contents.0).ok_or(EIO)?;
>> -        let rpc_header_init =3D RpcMessageHeader::init(size_in_bytes, M=
::FUNCTION);
>> -        // SAFETY: `rpc_header_mut()` and `cmd` are valid references, a=
nd not touched if the
>> -        // initializer fails.
>> -        unsafe {
>> -            pin_init::raw_try_init(
>> -                core::ptr::from_mut(dst.header.rpc_header_mut()),
>> -                rpc_header_init,
>> -            )?;
>> -            pin_init::raw_try_init(core::ptr::from_mut(cmd), command.in=
it())?;
>> -        }
>> -
>> -        // Fill the variable-length payload, which may be empty.
>> -        let mut sbuffer =3D SBufferIter::new_writer([&mut payload_1[..]=
, &mut dst.contents.1[..]]);
>> -        command.init_variable_payload(&mut sbuffer)?;
>> -
>> -        if !sbuffer.is_empty() {
>> -            return Err(EIO);
>> -        }
>> -        drop(sbuffer);
>> -
>> -        dev_dbg!(
>> -            &self.dev,
>> -            "GSP RPC: send: seq# {}, function=3D{:?}, length=3D0x{:x}\n=
",
>> -            self.seq,
>> -            M::FUNCTION,
>> -            size_in_bytes,
>> -        );
>> +        // Initialize the message payload.
>> +        command_init(&mut dst)?;
>> =20
>>          // Compute checksum now that the whole message is ready.
>>          dst.header
>> @@ -715,6 +685,66 @@ fn send_single_command<M>(&mut self, command: M) ->=
 Result
>>          Ok(())
>>      }
>> =20
>> +    /// Sends `command` to the GSP, without splitting it.
>> +    ///
>> +    /// # Errors
>> +    ///
>> +    /// - `EMSGSIZE` if the command exceeds the maximum queue element s=
ize.
>> +    /// - `ETIMEDOUT` if space does not become available within the tim=
eout.
>> +    /// - `EIO` if the variable payload requested by the command has no=
t been entirely
>> +    ///   written to by its [`CommandToGsp::init_variable_payload`] met=
hod.
>> +    ///
>> +    /// Error codes returned by the command initializers are propagated=
 as-is.
>> +    fn send_single_command<M>(&mut self, command: M) -> Result
>> +    where
>> +        M: CommandToGsp,
>> +        // This allows all error types, including `Infallible`, to be u=
sed for `M::InitError`.
>> +        Error: From<M::InitError>,
>> +    {
>> +        let dev =3D self.dev;
>> +        let seq =3D self.seq;
>> +        let size_in_bytes =3D command.size();
>
> I suspect if we pass dev and seq into the closure below, we can
> further split the RPC layer from the transport layer. That means the
> patches after this won't have to impl on CmdqInner for e.g.
> `send_single_command` and instead we can just define a trait that writes
> in the message layer data (so send_single_command could e.g. instead
> take an impl RpcCommandWriter or whatever, and we can impl
> RpcCommandWriter for anything that impls CommandToGsp, inserting the
> message layer protocol stuff in there).

That sounds like a much better design indeed - I was contemplating
introducing traits and thought it might be better to keep things simple
and revisit until r000 is completed, but it probably won't be limiting
us in any way, and removes the unneeded mirror methods in `CmdqInner`.

The same pattern can probably also be applied on the receiving side, so
I'll try and do it there as well.
