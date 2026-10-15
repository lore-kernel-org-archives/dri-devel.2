Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9F09CC6B34
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 13:37:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D00B610EBE8;
	Thu, 15 Oct 2026 13:37:07 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010014.outbound.protection.outlook.com
 [40.93.198.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AA5210EBE8;
 Thu, 15 Oct 2026 13:37:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DzoMOu5eF59uQjpOKF71ZBOqTD2gfTS9HuXnWMXkD7Jj3vCel2RPyixVknWxTkk2z1V3yFTb+sAKtcW2D+Tck83ZgeTXsf/sSbkDcfCJ2FvLQK3uLfpuDO/SvWsh83sVEGx7cND0pW/4Zi13Sc/7KOXGl5ED175ZzF5z30Qd6VER9DNmkbIfwTur8SEQ/u5CMgD8yzGdh9RwarMDwNnD+GUByb2RwnLuMFBP0XKHIgIxpehxi2olTeOvieS/7iW9KqjIATzazUuKOrxX5OOtNgUDJs2U27V0cWPdMV0fKCBekWWsccstQZilrD/6fmInEQU9JHK+rxJXaDFzB/GyRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bOSEowWB7Xv9PDDxlm3ur85Aib1uhu62cuSACYT29Jo=;
 b=h6NOdGRUYSCZT/w8aDDPq7CyV1RcRbrZZk06ztkllli0L1zjgCfKsdjOYXzlwE4WJcBTACDF3hMIcOze3b1GostkBVxyVHYnk/aUB4vK4OLx27XU/v521fiugPPuRo5oP1faaoGhscEY/20YlrKGOAU7izsd5ZNrJIBDP35iNJFeu8vS6kvGS5St/5cGtVRjoR4SzGOTscuOLETNzGY9uxLjz71IeGZLfRgBpYXfmsY+Wd7KXLIsVA0ctkd4cGsGzFZPuMgJxpFmQFLIs0A1SUHpt5aNFJMRHvFxm/bfFYgekOSm2m/T5jZx2JtoJOsmXkJCoPNa/YLd4hTgirgr4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bOSEowWB7Xv9PDDxlm3ur85Aib1uhu62cuSACYT29Jo=;
 b=DF5MV3uMoFcfosXx2lyHNNhwopXIhA3CYFsnYzamX4JncqUbYW6RzbiVA2/jPPmwickXy6zqs1Ko2yi7IAElxRADklpreoITA2apJ6fmZIYepdJq3f3sWi29O0EqtqcGMvJrPr6JDODAFKzJxb43+bC4rxPs4xFt/pQkYDLepoGqQTiOEKEtyQEWKyxvMNNbzcxGh11sVriONcoBnecYul5jiI+MDUFj18SEqXUyh0tCXaq7oXSzOmGjPFa9fpCqcNNg6P1fbwWy8bcir+h+ebDzl5Ucpi/h4RbTM3z2+W2uZCtP//8S4ETm9LhIVdmiB32Y3FPB7hRBI4sRgM2u4g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by SA1PR12MB999228.namprd12.prod.outlook.com (2603:10b6:806:4db::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Thu, 15 Oct
 2026 13:36:58 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0522.011; Thu, 15 Oct 2026
 13:36:58 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 15 Oct 2026 22:36:55 +0900
Message-Id: <DM5GAQXBDK1D.E0GO2ISEKL28@nvidia.com>
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
Subject: Re: [PATCH v4 07/10] gpu: nova-core: gsp: cmdq: split the transport
 part of the receive path
From: "Alexandre Courbot" <acourbot@nvidia.com>
References: <20261009-cmdq-rpc-v4-0-c9ab8de1d3f2@nvidia.com>
 <20261009-cmdq-rpc-v4-7-c9ab8de1d3f2@nvidia.com>
 <DM49BYCF7DFJ.KDPNZK1EVPWB@nvidia.com>
In-Reply-To: <DM49BYCF7DFJ.KDPNZK1EVPWB@nvidia.com>
X-ClientProxiedBy: TYCP301CA0042.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:380::10) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|SA1PR12MB999228:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c04814c-fdb2-4728-646e-08df2ac162ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|23010399003|376014|10070799003|1800799024|366016|22082099003|18002099003|10067099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: BQHtLtLHveS5Fj+tu2Xqm8s/iENTNVqkwQ31R2Qpnhy4WHLpDfTFuQmx9yhBGKBJDZrW3ULcOOR8zDrR4GWgy3i09oL1c4rTsQu414PBfWHe5/rHQ45/xaJuJfLz6e2ltWI7npEXL1nhOmQospqh5z6OPirGfHUFOY1tQ7gZnywanulXDIYhTILmNLclc/xinubPeBkzH+q3fHXyQspIUoH4N4G2LHGeu4/p5/OGiSgkhSBulP6WcAnyQR2qvDU8arKpFeUGBeKUe6KZYxx60RQh/LvpOTtJy5BMltgVszdcvZovuhog7Fw3biAItxWpUimFaTUisqah/shsbEhfBygv6K2pMFW7Blblli9TjxTTzjL6Gs7wBcbFp28jrv5BPFHfHFOTpro7UVxO3EBs/mC/81VeXqOd46fHQP/jfKN8EQqx9KspnAdc2PmU/nF8SC00UnYmwoazkjQKslG4R9v+fEYKPfF2ATI/roT4j2KbdKKxRwIEeeISbolp6qqIFTGYGP8RwdcZSnnxW38z+2pu/zvVQ1LgRWfH8ZqOIfLjRyRQ0Pzr9/stuG2mUoAYYlUCER504q6UZ3G6p8+cdokBRZ9DBj0fHG997wEBZIExU/ObTmUdSy5lP+LqkHcS8HofR/zqXgP5t7uYkaysYKUlv5EBNAiWsU+5I6f5ngU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(23010399003)(376014)(10070799003)(1800799024)(366016)(22082099003)(18002099003)(10067099003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0FyNGQ2cEZvazJEL0F0bEJWcWJIZ29ZdkFOUnFqeE1lSVVzS0JuTEVsM3Bh?=
 =?utf-8?B?WW1nNDZtWitPaEFzZk9TaUkrT0pka252Q0d6OWJFRU4rRGFtMXkrV2QxM25z?=
 =?utf-8?B?TFBJcXRDNTRvYzZGTmlNajBpaEtTQ1hCRENVYnkxU2xvb0tzMVBtTTlkSXU3?=
 =?utf-8?B?ZUFOcFNYbGV1YUVXMXVLVmFvMzZwSnp3azI5R1l2K3czUlF6TkM0c0VUVmpW?=
 =?utf-8?B?REZDeGluaEU5VjExa1ZrSVM4dWVBSHkxeDVaaElnVzZYOEw0NU02SFFlUkxM?=
 =?utf-8?B?QjNWTkYrMUtkbndaY2xONGRqa2pEdmFuU2VBR2ZrSVhTVlc2ZFNEKzhjdmxT?=
 =?utf-8?B?Y2Z3T3NqVXJuREd1UjhhQ2VQVEoyOEY1WjdJbWpHcU1GTHlqY0FGRUNzNHVC?=
 =?utf-8?B?bnc5Ky9GMFFncjhtZkRsUFJUTk1VQ2FxOU5rdjZ1Z2dSTm15QWhoakN5b1gv?=
 =?utf-8?B?WFkvQU9vTDZNbVdkaUZpZlBpYVhoRWplazBnQlQ4YU9pYnpCK1Rud09hc0dy?=
 =?utf-8?B?dkFzYTdkYVpldEErdHFhK1dsTm1BQlh1Q05rOVRDZnVOYVZyU2NXYmNlSzQ4?=
 =?utf-8?B?VFpUMHBnNkNVMUF6a0QrVTNrZ3FPUjlEMDVMS3phUllmQnNEWVZoc3NsS2s4?=
 =?utf-8?B?UXdQanlZTUxhQW5YU3NNa0hWL1lvZEw4RWNSQWZPeDFxcFNTZ0lJMlBBRW0z?=
 =?utf-8?B?QkZJbnR0TzJRUDFJck5GZXBCeS9zc0JadTFtKzJSSjJmT2NldGNSQnFDTkxU?=
 =?utf-8?B?TklNakpQalJwOWVJajQ4UFNscFEwR3VWMWFvK29kbUVJNzdHcUVYMlJlNmx6?=
 =?utf-8?B?dzhqNGRycnR6MTFSSVBwd05lNld2OERNNW1ieE96UXBZeEliOWVPc0Y4QnV3?=
 =?utf-8?B?RWh3Szh4SzRZazFzS3I0R3BDeXNnVVNWSGY1V05xM0JNT2dDenprU3ErWng4?=
 =?utf-8?B?em1yajIyU1BIQmd5VWZUcTdmeUdTVlhxaU9VWEM4VngyS1BOQ3A4cmg2R3Bl?=
 =?utf-8?B?SmdXcFp6eUtldVJFQnNjRW1mSnkzZFR0T3RzV210aVlLcmVwVE1zcEF3NCs2?=
 =?utf-8?B?MnhhbWRHd1RNNUJqZVRrTlY4S1BGM0ErYUw3amJBWTRHQTN1Z1JxT1JhbzNh?=
 =?utf-8?B?VVh6SE5Ea1VlTDUzZ3ZYVkRrSlBtS1FWSGVtRzg2VjMzYk5ZVnN3NEt3Qys1?=
 =?utf-8?B?dUFSYitxRzhkYzhaZkVpbm8yV0VoUEFSWjlRV1pQU2dtWGUwd29WcVFJandF?=
 =?utf-8?B?VG5VaUVXRTRWMHZ6LytPWGg1RWwxMWJkVUE1a090OTdhSXhHUUpqdUYwQ2dB?=
 =?utf-8?B?ZUNOVXE1ajFYVk5CSERveWorRzRuTlB4NW8vcnEzd3pTeDNnYkx4TVdjbWd3?=
 =?utf-8?B?QjBEeGlMUlRiR1AwZGFiZnRGQzIrOFRaTUlZTysrci9TdU5vSXNlMktDaG9E?=
 =?utf-8?B?UC9DQnJzbld2dXNqZmVGQkl1dFVsNHlQeldBT2ZBVlhaRjF0WUJTZ0kwaXl1?=
 =?utf-8?B?UDlnOUVLUnlQK0lZSkZRWjBGT2hEOXpGME1uMVpSL1YvekJWNXRhOWFHNlNv?=
 =?utf-8?B?amovclNsT0lkWTB6SytFNWc4VWFkMTZjU3g0a0ZtSlpYdzcyVGh2bGQzOUpv?=
 =?utf-8?B?akM1UWE4ejJSOVV2MDNEUGkveW1qWVpWdFJXcVBLL1kxTU9CYVlwcm1uS2Nk?=
 =?utf-8?B?TzdIUnVUekZFYXdPZDZ1VWlTNWMvbEpZU0N0K1plRW15SHhKOTcyZ0pLazZD?=
 =?utf-8?B?a0dVTjk2MlBiU3M5MS9hVjRyNHZWa0NBV0tDZGxrVHE0dVIrOUhCVkR0S0to?=
 =?utf-8?B?b3VEZUduZ0JnWXVoRHJvMUUwNTF4VkhkWGFESkJ1c0RLWFhTb3RncWI0a2pH?=
 =?utf-8?B?M3p6bUlpVTdpRkNUeHpwYnpWSU5WU3VsWjJPYWN1VE5BL09vQ0IzZEdqT0tY?=
 =?utf-8?B?YmtxTURlTWZQZUZrcUZ2ZENWdVJOb0czTGhodmNCYW1DanBrbG1va0t2NXU0?=
 =?utf-8?B?cVZrS2RHaGFueWtFQ3c4aHR0Q0pVb1BjbUVETGtPUHZGTG5rTlpZbkJ0aUlM?=
 =?utf-8?B?bGkrQ3ZNTGlDUTAvSWdCSFA4NC85dUFqT2VoR3hmYnFJUVRycGVqRnF5b3gr?=
 =?utf-8?B?V3hEUEsvRzZHN1BOR0hROXMra3BKV3VEUHMrZk95RHJwWHcrb0htclVSS0xy?=
 =?utf-8?B?R1V4QmpQNS9SOW9VdVgreVE4TUlZMjhkbUIvbnVJVUNDc2N3WjdmWVQzckxr?=
 =?utf-8?B?TERDb1VrRTJHYVArbWpWQ3FxbkZUTElBaUFSN0dWZk9tQnA4T1lyQ1pvVXNh?=
 =?utf-8?B?eXZuNFFoSC9jcC85NDlJM2xCSTdvMGNFbkY1Q3lhK2F4U0F6YzFYZENSV3RL?=
 =?utf-8?Q?eFVw8QkqT09+6tYKyx5TVaAmBq1jcSdVnjmk1N8O/vV3g?=
X-MS-Exchange-AntiSpam-MessageData-1: 5ASeK+D1oAgB+w==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c04814c-fdb2-4728-646e-08df2ac162ac
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 13:36:58.4852 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w8vDSfCx+YFeUvH5hjmX0x2jkmBpIqAz7wEDPjGWrtKJgGdoO42KFCquVHa75RQXyMCHgPuV9VANGFAztB4fMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999228
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

On Wed Oct 14, 2026 at 12:56 PM JST, Eliot Courtney wrote:
<...>
>> -    /// Receive a message from the GSP.
>> +    /// Wait for the next element on the message queue, pass it to [`Me=
ssageElement::read`], and
>> +    /// advances the read pointer past it.
>>      ///
>> -    /// A message whose function code is `M::FUNCTION` is decoded and r=
eturned. Any other message
>> -    /// is logged as an event.
>> -    ///
>> -    /// The read pointer is always advanced past the message, regardles=
s of whether it matched.
>> +    /// The read pointer advances regardless of whether [`MessageElemen=
t::read`] succeeds or not.
>>      ///
>>      /// # Errors
>>      ///
>> -    /// - `ETIMEDOUT` if `timeout` has elapsed before any message becom=
es available.
>> -    /// - `EIO` if there was some inconsistency (e.g. message shorter t=
han advertised) on the
>> -    ///   message queue.
>> -    /// - `ENOMSG` if the message was not the awaited reply.
>> -    ///
>> -    /// Error codes returned by [`MessageFromGsp::read`] are propagated=
 as-is.
>> -    fn receive_msg<M: MessageFromGsp>(&mut self, timeout: Delta) -> Res=
ult<M>
>> -    where
>> -        // This allows all error types, including `Infallible`, to be u=
sed for `M::InitError`.
>> -        Error: From<M::InitError>,
>> -    {
>> +    /// Errors from [`Self::wait_for_msg`] and from [`MessageElement::r=
ead`] are propagated
>> +    /// as-is.
>> +    fn consume_element<M: MessageElement>(&mut self, timeout: Delta) ->=
 Result<M> {
>
> Ok, so we are changing the semantics to this always consumes the element
> in a few more cases. I think this is ok and it's documented so sgtm. And
> maybe we do something for poisoning later?

Yes, John had a proper poisoning mechanism in the r000 series, but I
suggested we revisit that after the r000 conversion to simplify and
introduce a generic `Poisonable` container (or something in the same
fashion as `Mutex`) instead of using a `bool`. So that's definitely on
the radar.
