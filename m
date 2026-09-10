Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B576C79FB9
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 07:47:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF65510F339;
	Thu, 10 Sep 2026 07:47:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="VvN5wpW3";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013036.outbound.protection.outlook.com
 [40.93.201.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E12E510F339
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 07:47:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y/plInwk4Ny6UTclw3O3mqwyD2bF+05UUnu9r+q4MDOPBGD436DdQQ+Xt9pEeFFiUWWgQ4HMhDUhwp7MoFv0OBbYayZPUQJP+FEs3utau/9QXH19ENeR05C0zobQA45Sg+VigEiNultPuOKvg1cJO7NOk23/8MTmIke1RwNlzREc3BaXPxB2CHZbQZnK+mj/RMwLLuumRYV6QXk0SqQCZhD/r0o+f0HRo89WXU7WrhYc+dTH8JyhRfkhmSGVhVC4ug/zELCH0Gilq6bP1jbSzepOjdIEakSacDie4Yc2L2pqY0lRp/BDKtbY0dbUNa4r2Sm/3AzYqqZTOHdNGd+d4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dsZvBj8zSgMQrzTRgRt1RAlM6oLm3qx2BIxXGso5whs=;
 b=s6cupPzTPes9eCbXqeDFt/9DVh32oJI8g7KaZ29GjcKQ0EYifkya6XSoj8Ia+55tFPpt+j6v8lCgVpK4k053eMUY+2Y9QuiaFAcAHjoDGm99I+68u38dQaMeYetKeF4VsLvhzz5yaTE/kMrgYMt1GIV5vO6xHXFue4GZQQWzmB1zI/+u4KZ6ebbQahPSm7Q/TJ9KgNDmTZzkB9/NJ5S2xvDLpJITU6XZwFpSIKlvfGOjhCYVgerEVclMQch+F7bhTQbsGiaKawn/pUqsbQFmXAP1qRoaXtIJJrLA774yOrn6pCv+YLc8HO8gcrLqJeB7uSDvZDpxkAZWng5M5LBHZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dsZvBj8zSgMQrzTRgRt1RAlM6oLm3qx2BIxXGso5whs=;
 b=VvN5wpW32j1UFKrpewAxVZ/sRykAARf3KHLbMp57eRshIGU8I3+eQ/h5phSSkM8vGAdTYx7gsiTr6cHucNBSyssokv/9/18q99afl1bW1U5wDXkPF0rqxB5UwATp/thPokPPsPwmSu9xGwuJECCdLxC/wK4R0grevyAAYNkjcifRirBjOdZXFfnwOqtEf9XGjmUfyc8g6yceVfGN2jQXMPlg56TFloZicvYGIrRufkGV7SRWxINe0uAX+1QP0TdBT/WjtrEkfcl4KFPh2FknE0n9C9CLUkpWumdMZmkqMfojiC5MMJw/YLqHPIeoL1M8ce1P1PJ56pOad+Hltdnnpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by CH2PR12MB4040.namprd12.prod.outlook.com (2603:10b6:610:ac::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 07:47:51 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 07:47:51 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 10 Sep 2026 16:47:48 +0900
Message-Id: <DLBGYDIEZY9O.13PCPPFAA7JN9@nvidia.com>
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Lorenzo Stoakes"
 <ljs@kernel.org>, "Vlastimil Babka" <vbabka@kernel.org>, "Liam R. Howlett"
 <liam@infradead.org>, "Uladzislau Rezki" <urezki@gmail.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v2 5/8] gpu: nova-core: add NVKV decoder
References: <20260827-b4-nvkv-v2-0-0de9d5c8658c@nvidia.com>
 <20260827-b4-nvkv-v2-5-0de9d5c8658c@nvidia.com>
In-Reply-To: <20260827-b4-nvkv-v2-5-0de9d5c8658c@nvidia.com>
X-ClientProxiedBy: TY4P286CA0020.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b0::13) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|CH2PR12MB4040:EE_
X-MS-Office365-Filtering-Correlation-Id: 27ac46ed-92ab-4e1f-4141-08df0f0fd09c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|10070799003|376014|7416014|4143699003|6133799003|10067099003|11063799006|56012099006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: hJCkqMO4pAbcO2ID0ZZFw4DbtLOfgIqUVh7PnaA9jjegK0wsZuF+H+c77NcdZ/QOF2KFxuig9LRq7HwzSzlXf2fYPMV988IrPEB8eQovMuh8fUaVtoR94YmxW1cwZoI1TveS5Kzh+Axw7UEihojAkqVjEE3KcyXJNN3O7Ubzdv7b/isby12TCo/mZaDmQb0IDBUNq39QsANLU96JhbrNOWuib4beZWp+TaZSTWEf0IkFE7YfEOmAlMISbD7NUEOXhm1mW8rfQNeXzkl9J4XA94dagUhaWej2o3usLX7RiCpOb480DkzBrUF2ln/Px3nV3dI90js4Y2OtL9iLhx/VPukZiuWEDhvcOg3/U3c+3PoAtpcX+SS5Md6pYTIAyko/Bn+VdbDq7i8u89r0uzaHTJTYjKkV5eJupJt3fhMRuDqxGKcCUbr7n48zV1UcW92w7RlR6MRZIqAnmILFqjKAS5FOeczsoPeUneWQcJmXq/iqbLjLbFhTJcB83VB0LH2M6+ZMRBSeTUJT7Vo0ctx5ua6Zm/NedEhon1X+UY+w5CtkmRVMei7j3qa3ElAkUebUtM4iS2vAbudWwtTH7p+vksnVnGHu1kksx1d7OkiuTAVJWKJW/l0dgEfukS7TUdp4LPW9fduvJMY3mBXLLUz8o7q7rZb51DG3v7HuUz37Ab8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(10070799003)(376014)(7416014)(4143699003)(6133799003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnpmUTRQTFVjeStnWS95MDNMN2NQM0RXSVF3SnJKQzlSZE5WazlpL3Z6VHM0?=
 =?utf-8?B?YU85ZkcwN0Z3S0tyUGpPc1hDemwxKysrWEcrTFByL29ma3pRMEhXOU9qMUhq?=
 =?utf-8?B?SytLeHU5bmlQdmhJYnV1OXgxZG94eGtjOWIyWUJZM0R2emdjUXp2VVR4RC9u?=
 =?utf-8?B?cVVrN2ZaZU5lcWhaRHFnQm5sS2YzMXUvMnFFT1RXN1U4VndMN0tPVjNkRXBs?=
 =?utf-8?B?QjByYTMvMGNtVWl5Y3NUNWsxTTJsbGdCRDhaMFI5K3BKbXIwUXZwNEluSlE5?=
 =?utf-8?B?VE85MzlwMXg4T3JRWHphaENjVEM0anhwbFFaZUFQN3cyYUpTZ3VJMmRuYm5m?=
 =?utf-8?B?UTJyUmNpT2NFdkEvU3p6enFzbWRqd0dpd3IwZGZwbFdSbFI1YmJFb2c4QXpL?=
 =?utf-8?B?VHdjNmJFK1JQWWxrWXdjZ2ZHenU1a2tFYjJtbHdScHBiKzgrU2hpeU41RkVa?=
 =?utf-8?B?d0kzUytBSWl6VWlNRWhOOGJka0MvaGRvdHFRem5hQlA3VGhHSGNRb3JuMGs5?=
 =?utf-8?B?ek10SHlaajNudzVQWnNrbTBWb09yOG1jZWlXeDR6Y2lhRWJSSHVTUnozOFZR?=
 =?utf-8?B?VHNuNG93d21iK3JXZVFZeGVMUzduVDhuNWR3YWtjZ0s1UGRxSkhmNWVKMG9n?=
 =?utf-8?B?QTc1c0lRMjVPanptYzlnNXcvdjNWK2Fadk1uZ1ROeGoyQ2pMN0xJU0VQbjRs?=
 =?utf-8?B?SGUzaE1VN1doSE5wN2lWUWdqQ014K2FvcUVMNFVDVWU2QlNYMjRyUjZtaDJC?=
 =?utf-8?B?eVhPSFNVZGJtQjhRZkFmTmRGbU02Q0ZselA0OWxmU2ZrN29SRFRIRklYT1dT?=
 =?utf-8?B?TWZERU9rZk5mOXF3OE1Maks1dDl6VTRHQ3phOGRhd1phTHI4bGdGS0tKV3dH?=
 =?utf-8?B?WW5mMks1bTlSa2VIOGViZnhIazUzUlo4RnE5bUJGY2VKOFByT3Q2UktkSUFK?=
 =?utf-8?B?cUxDNDJSN0p0SE4vQ3JNYjlFeXNpcitrZy9XZjRMY1FGTWxjNVBOU05VeFdx?=
 =?utf-8?B?cGR1ZTR1RE80UUZWSk9jdnErRnhRQ1FBOGd0YjJjTGtGR01CTG5BbzRPdEVU?=
 =?utf-8?B?ajg4OFJRVG1FZnRiTnMvN2lHbFdzRGk5dGZBY1NFb3BPNFB5N0NsQ2xKVHcw?=
 =?utf-8?B?ZHNFU1JyOVoveml0N3JvRTcyV1NDNkQ0eldoOVZNY2VmZGNoY3FRbTZtVkND?=
 =?utf-8?B?OVcwRWEvN2t0RXQzM0MzWStxdDRtTENpaGx0Y3JmN0JpZklKZkx1WVQ5eDlJ?=
 =?utf-8?B?Q0UyU3BlN1IwZVVob3BNeU1xUldsRjRBOEdOU2k3MFlKZ1B6Q2tkWXlSOWxX?=
 =?utf-8?B?NHBnbklodGVMcEx5TjJXRXB0eGx0ODJvRUd6alhLWlZYbGdQZUR2N1BhUjRW?=
 =?utf-8?B?VkQ2RnlKMUF0aDFFek9Scys2enkzOEZWMVQ3MEp3ZkJkWXY3UkswcFl6ZEs1?=
 =?utf-8?B?SjA4TG5JZURFMXFERTBUTlVVVlE3a2F5dlBXYlB5UVdkYmREYkVlQWxKMXNM?=
 =?utf-8?B?NitiQTMvM0RPZ0t3RXpqM1lJS0dGd0N6YWhoclNaTHF2ckdjdDhyeUtBTUpq?=
 =?utf-8?B?SzdmbGptUVp6RFd2T212TCs2MTIxVmI5am4zZ0QvZERzTnBuTGlGMm42a1RD?=
 =?utf-8?B?VUd4RG5WckNyNHpIMVZudEJBeTFaU29FNHovdERHNzRmUWhkbC9tODRPWnh1?=
 =?utf-8?B?R1VtTjdaVkhmYlZQTjFBUklTOE8wRXQ4Q0lJNWhhaG8wS3V6eTVTTWJ5allD?=
 =?utf-8?B?bnJTYURXamxmQmg3YnFIZ09BVHJZY2gwTHZyU2RDUzBnOThic0pWMUlFVGVn?=
 =?utf-8?B?WEQvc2xTUVVvZUs1b1FMU0Ivcy9hV3UyQUc4UFd3SElwNWc0c05qVlNyTWpI?=
 =?utf-8?B?Ui9iM1ZvbEphL1dvY2FoR3hDMllUSjhJa2FjQTgrV0M5cldIQnI0QXJ6OG1j?=
 =?utf-8?B?c29ablJtNW9zMTU4enozVmJnd25TWW04ZFlTcmhyOGQrSHpDdFBqdUNpTUpa?=
 =?utf-8?B?Nmw4V0NpTTlwNDJnMzJiRm9QUnpCTGJnQkkwcWI4UG9sakZBcytaY05MWjlH?=
 =?utf-8?B?dkRhWXJsWTYzY2dvcno4MUhnT0o1ejFuTHovWVZ2ZVhMckl1cTBnQkZ6WFRk?=
 =?utf-8?B?Y1Y0M0MvSE1GRzcyRHE1Mmg2ME1ZclRvVVFVZWl2elIxMlF1UENncDErQ1dr?=
 =?utf-8?B?OUt1bjBxR0haeTJDb3pQSXErK0hick5wR0lGdWFNY1FyZTV6a2t4RDFBMFZh?=
 =?utf-8?B?REd6VmVyMzgxd1d6RlFRcnJLeDBoSG9XVGVwUS9nWFI4OHIwZ1A0bVhDelpO?=
 =?utf-8?B?bzJML21qem9DQTR2dFp2OG5hc3Jhd0REb2luVmZXVlR6TTdpd2N3SGhsL1Ji?=
 =?utf-8?Q?y3Q82Mpe7ec3z2uK9mBIdGj0eARFK4A8275Yu4zfxIPsA?=
X-MS-Exchange-AntiSpam-MessageData-1: P1l9JaPbOA5tFw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27ac46ed-92ab-4e1f-4141-08df0f0fd09c
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 07:47:51.0805 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ACRztmeNPhz9tUID7b0ZDcL9ENFWyKWCH/HZpAalsh18DMjYZnW/7sXMiNuzJIX2d1EWmFVGCAVcR4hfBXUBHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4040
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

On Thu Aug 27, 2026 at 11:12 PM JST, Eliot Courtney wrote:
<...>
> +    /// Decodes every pair into `schema` and returns the result of [`Sch=
ema::finish`].
> +    pub(crate) fn decode<'s, S: Schema>(
> +        &self,
> +        schema: &'s mut S,
> +    ) -> Result<impl Init<S::Target, Error> + 's> {
> +        let mut cursor =3D Cursor::new(self.data);
> +        while !cursor.is_empty() {
> +            let op: Op =3D cursor.take_u64()?.into();
> +
> +            let key =3D op.key().into();
> +            let index =3D op.index();
> +            let op_value: u32 =3D op.value().into();
> +            match op.opcode()? {
> +                Opcode::Imm32 =3D> {
> +                    self.visit(schema, key, index, DecoderValue::Scalar3=
2(op_value))?;
> +                }
> +                Opcode::Seq32 =3D> {
> +                    let values =3D cursor.take_u32s(num::u32_as_usize(op=
_value))?;
> +                    for (i, &value) in values.iter().enumerate() {
> +                        let key =3D Self::seq_key(key, i)?;
> +                        self.visit(schema, key, index, DecoderValue::Sca=
lar32(value))?;
> +                    }
> +                }
> +                Opcode::Seq64 =3D> {
> +                    let values =3D cursor.take_u64s(num::u32_as_usize(op=
_value))?;
> +                    for (i, &value) in values.iter().enumerate() {
> +                        let key =3D Self::seq_key(key, i)?;
> +                        self.visit(schema, key, index, DecoderValue::Sca=
lar64(value))?;
> +                    }
> +                }

Another thing that could be worth clarifying: are `Seq32`/`Seq64` with a
count of `0` valid? Right now they won't trigger a visit or an error,
i.e. they will be silently ignored. Whereas arrays of size 0 do trigger
a visit (which sounds logical). I'm not saying this is a problem, just
wondering if the behavior is consistent with what NVKV specifies in such
cases.
