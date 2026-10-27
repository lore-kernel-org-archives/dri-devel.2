Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A784D606A31A
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 01:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=QnE8BT+k
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E712310F1F9;
	Tue, 27 Oct 2026 01:08:56 +0000 (UTC)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012009.outbound.protection.outlook.com
 [40.107.200.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCA2C10F215;
 Tue, 27 Oct 2026 01:08:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FRp+NlfpwsnPDhKT2D4kGkaCYlO8NakvOF8KO2xbmF4u/5lPdyZyZkeI7Qwk/p8yBL6boM4O5DC+44w9xKu3zDfOp2IHyv6muYqOeCEk3EexOfRcnBkbeY5TfdTuNU9AyUhzbIHiDOx88oA+XC/krYXgbfP8LD5Xar4o9X8+w3tK6y8OOv2y5fFCe5RfhHB5CbBW5iEjzsaavHaC6tdSwjwe7T0PuFCE/Cv3x+UI6O0+vRjacQYr8+8wHcvopKSlhKNERSscs0iF4Bmg6e2IhGp2EV3FUXP7ey7VauExhwJqfxsyGw/O5L11vq6NcA30N/QPAXo4xr39YhwN09OxBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X5TtL2r8K7SK+7Q3tgq1Ijdv/961W5Ba6MMbNeg7jX8=;
 b=Z2Tne721CaN32rFfKIrt4LBO8vTrb5v2iYQa7bAmMaHzeyLpq0cPoyZzL8j2M3/i2KQIiCGmHlNQNv1HvqiZ4JLqECAo4Bs1cq5p0sjN5aUO9DegisbVAO99zDiasCSIO0j2ez0g9lyGGxtFM379ipW7vS/2/OPveoZbtpms0XLll+AlsdTjril8N3CRJLCmnSFueKQVw1BrBoqCIzGQBjkoMQS4ES7pdbrx12TRgymR0Xgsmp31v018yUPFU6aEPqBEf6b1n6Yp4Q9ZaYGk2QRdTNAltylPQ/HTcyC2ThfAfLrDFaRjiOteeEjUfAdZQV+E22tKo0BKZ2sd03Q2Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X5TtL2r8K7SK+7Q3tgq1Ijdv/961W5Ba6MMbNeg7jX8=;
 b=QnE8BT+krXQbGkmUpjuDLGAnRWNpzSq8yvP0A+AFuBwnGxmWK+ufbV09L3kRr3ZVc9Ueu9toJjL7Sj9MVExAasJMq2QWvqIGqKdKYlluOpOrj/SS5361GLJylm76tfyyiCocT0NBtpHLLWe3qG1ikp7AGLxx9r2Ikf+FkAwiXaNUl4/9CUMVKjh68jM3FA2GTyBXJqgfbBtwKIq/OI4DsE5coQk9xfPtFv8Yti4FCSPla+cH/H1s3MEwUNAeuMtu7JBDin1D/Ly8VZsYWDsv4dalsbPL2OfHLG2Qhe1dsZDGBIY0GL4j+/+VVYY9FvNNesxN5Zoft2IITiCLWYyLSA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by MN0PR12MB5881.namprd12.prod.outlook.com (2603:10b6:208:379::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.21; Tue, 27 Oct
 2026 01:08:43 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 01:08:43 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 27 Oct 2026 10:08:40 +0900
Message-Id: <DMF7WDQV4EUC.1GJ9LDZRFXMSI@nvidia.com>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Benno Lossin"
 <lossin@kernel.org>, "Gary Guo" <gary@garyguo.net>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Zhi Wang"
 <zhiw@nvidia.com>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v5 09/14] gpu: nova-core: gsp: cmdq: split the transport
 part of the receive path
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
References: <20261020-cmdq-rpc-v5-0-dceeb8f360ec@nvidia.com>
 <20261020-cmdq-rpc-v5-9-dceeb8f360ec@nvidia.com>
 <DMA55SJ39DQU.2NWD9I1FRH4Z8@nvidia.com>
In-Reply-To: <DMA55SJ39DQU.2NWD9I1FRH4Z8@nvidia.com>
X-ClientProxiedBy: TYCP286CA0057.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b5::20) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|MN0PR12MB5881:EE_
X-MS-Office365-Filtering-Correlation-Id: fc95ee28-88e2-4fdf-2cff-08df33c6d80c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|10070799003|376014|1800799024|7416014|366016|261026121527099003|4143699003|56012099006|11063799006|261022105027099003|261022075727099003|261021121427099003|261021123027099003|10067099003|22082099003|18002099003|261026140227099003|3023799007;
X-Microsoft-Antispam-Message-Info: BCeRcGsjAlWORDT9JQKcLqdJBsmHZCX+umVH5YBsI9sYcePb3oOzdNrckcqJ9fGi029YMGH2lnzUkfs2uJ1gIYscX5e9g4IDFNN8U7OuZ7C/+bqIytkJLvSmUGb+vP1kCS7OhQiwIyeBglcJT1/JryQUUFNMY6NAS5d0FGbEvkYJQ7lwquVdj2CnZUN1NrLmi+qUmW3vIS8rSSz5ixa3ijq1iPrUtvSXSjdV39cuhWqlcGRuQE/0AqJk9l8KVCShFbF3KpCOWwJitQCieSOFfSPIUG0sqhPs5IWNGjb0Wwax3DsjJeHMw/jx5wpdB8pOctl2d4vYSgGLy3LHQa1OTtkKhNwc/EMoRy7PUyliB/VUbxU8V54X4x6eVuHnuE0ncQYSeJuLwoVfvItU0gx9GbapcGS3RpdBmq0/bw//63ANnLPhix1Gcd7UOWDGW5uFvKQzA/tx4sZZJi+eOBDKud0CdH+RrcfXq0dk08u+Dq+xqaUsvNs8PI5y9ZC17/ymSPOuyMGyr2cMrQ+0HaBGNPeID+Kb62X5LyoyOFjRNJOchl0ONnOwoC2Z11L5wzJbJZ/mj6ymN1ATHjWmC91hYcuLW8YCpXXzuXakMUEgwqM0sSQorN20gOabeBwZxnrsyqM9y+MajV22j32FA21dPl7lB++btQoWgt9DDU/6f3c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(10070799003)(376014)(1800799024)(7416014)(366016)(261026121527099003)(4143699003)(56012099006)(11063799006)(261022105027099003)(261022075727099003)(261021121427099003)(261021123027099003)(10067099003)(22082099003)(18002099003)(261026140227099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzVWOTFVY2xWUkpDU1ozdVhNcFVLZU9MRThtRUQ4Vi9XZmJkTDQrV2M1MUI4?=
 =?utf-8?B?ZThwVnNRRXRUUFNUOGhlZUUrVmpGUVIwUlBBS3hYNWFGMHlyZlR4bllmc0pU?=
 =?utf-8?B?aFF3R0dRdFRoY2RmdTVUNFp0SlVCRE4zTVl2S3M4NUp6ditkYTFIUGpORkZq?=
 =?utf-8?B?Q3dJQWNRTlRSMmRUVExodmpBWmJxNU9VeDNTcUJCdG9WSi9UU2p2dENMWmNn?=
 =?utf-8?B?YnFQdDNnMVEvcU5mdnVOR09MYVhEVnZiTlZoM3l0QmxPUTdJOTdLNWRXQUxI?=
 =?utf-8?B?NzF3aTBRZXlwQVQ2WmdQZk1DTisyZGxMQ0xIM2ZsWUUyVTkySU53Y0tGVEFJ?=
 =?utf-8?B?WXhlam56OTNSSE1WSjcwanBWK2J2WDNrRitxTjNjME1MdEVFc0E3MlBGMVZn?=
 =?utf-8?B?R0pDaTZiZkxDMEVYWDVrbFJNRFd4b2k4b05nNUJSTzlYb1lsVDIxWDFUZE02?=
 =?utf-8?B?U3JhTXkySnhTbHpoc2J2alQ5YmkwWU04QTl1bHU1MEVZaG5hclZlYkhhK1RR?=
 =?utf-8?B?Szl1ejBZRDBqeXIvS2hVenNXMFNxdmR4eTdGSHdzbXpMMWhybXQycFk2MTBa?=
 =?utf-8?B?OFpULzFkclI5d3llOWpnSUJjLzJLTENkZDd6WGN2b21kdmQ5cG9NS3ZsVjdk?=
 =?utf-8?B?RjVNMkw5c0V0V0JwWEtaWldoNWJFWmVyaHArQ0cwUzlwKzFYd0Z6MzYyalNt?=
 =?utf-8?B?emc2UnVzTjg3cXhBNnVsTmEyRG4wbk14S0JIRUNrK0dEUUtLLzNwQUs4OWFV?=
 =?utf-8?B?bTd1SFp6cUJwUDJKdXZJbnJWTTlkUWJGREFxMW9CbUZnVENBcXBFWVkrbENY?=
 =?utf-8?B?Rml6ZHBLU2pmTC9ZdGgzRkt5K1lRYmNMYitoaW50cXIvREZOTkRPNlhNcUJO?=
 =?utf-8?B?eDRNc3h0WFBVY0sxTFVmK3RLV3h4b0hJNnZYOFM4RVBvR3RnTXlmUno0OXdT?=
 =?utf-8?B?SklhdExDNVhNczF3eWExNktla09CSHdIV2szditpTHYxYzNnaTIrd28zYXk5?=
 =?utf-8?B?eHJ2QUcyNWxmTnZWbTBFdEFVem1pQ1A4ZlRTN1JmWDhNZGQ4bEtDSDBIQk5z?=
 =?utf-8?B?TlVjNnhRS2pKWWZWTEkzbG5EeGkvSlhvd3o2VjZJRjFYeisySm9PNExGOEd0?=
 =?utf-8?B?STI0MFAza256a0tnMVF3NEk0czJzck51S0NJNGhJd3Z4NFcwejNJQ1dXcEZl?=
 =?utf-8?B?YW9HUHNmcTl4T3JhcU9YZGMzZHdWcHNxZWZBeHZRZG85NG9HcUtKR0ZMWDhn?=
 =?utf-8?B?NVVzNE1ZdllvVTdJa2xiQTRIVnBTMlFvWCtTeDN6dk84SUNlZ25iU04wRFlU?=
 =?utf-8?B?dDZ5cjM4Wm04emhHeG9ETWFhZ0JYMTNNNlJHd2tkZXNWcnRFYkEwRSs0cU1B?=
 =?utf-8?B?ZTRuN2JoZ3hrMjF0anlOcHpjbks1QnVHRUNydmNVanlqcGJvS0Z3THhMdlZ2?=
 =?utf-8?B?b0JoMll6YWN3a3NXTW1QMzErUGFBNFA4dW54YVZDZXJxN0ovQkFYOEhUQ0wx?=
 =?utf-8?B?aEViWHZ2eWFNckFVeVBxdEZrV2pKaUJ1ZWYwRDlpRG1HRE9lSUV6dkYrVE94?=
 =?utf-8?B?VDhzMEVMbXkvUnZoOTJKdjJkVEJKcEc2U1NFVStxSmtjemwybGE4Qk5YMXNh?=
 =?utf-8?B?OVIxV0NvS1JnQkhKOW9kTkIwWExZalFzRVNLVkg4MXM5UVFUMGpUZzBheG1x?=
 =?utf-8?B?ZzNDVGJxeGh6cmZUNk05dXNzK1l0RGtqeXRtSzJJN0RFVllnNnZuU0tlZHB4?=
 =?utf-8?B?YSt1dXZ6elRuZWNTWE5lcVVFZ0VFTEdwQWxyejdaMnNmdEs3Z2E4Q3piRXJ4?=
 =?utf-8?B?dXNza25QSU9nWGRxQTZJM3FyZ0w2MGJERURpRVJORnhEMHJLb1BVWjladEZx?=
 =?utf-8?B?VEpJSm9vOFFHRS9XRDhKZXIvQTArYlpHaHhtR2NmUkU1d05HM1NmYmNaa1Vx?=
 =?utf-8?B?WU1jOUVvK2lZcUpMVjMxTTR5dzQrRXNMNFh4MzRpemg3YldGbE5hdFNBVFlW?=
 =?utf-8?B?QmRLL01Ccm5qcCtvZStudEtseGdFOThNRGY0UTFTYnJ1R05jL0swZ3Q1Vmdi?=
 =?utf-8?B?ZTZYVjM1dEZsOGhqZVlBaSs2cCtPUmQvSnBXQ1BNOVQrc002bEJySzYrU2Yz?=
 =?utf-8?B?WHdCbXdFZFhZcGtOZjRzUWlEcmpxVFNVMDRHNkxFWWtFTklPdFBvTitKYWVJ?=
 =?utf-8?B?OEtZSG1mN1U4bi9tU2NtYjJmbDBWaVpUcGpTRXZTMmw1K0UrejlSaGVZc0pq?=
 =?utf-8?B?MThvd2NoZnV0K1I4VVFZTXkwWndFa2FIdGVvRlB6UzhnM2M1YTV6ZGlqVHJp?=
 =?utf-8?B?QmtNNkZMeTR3KzU2NExFcGovZU5TS3h1em5ydzdZbFJlRWZFalFLUVE2OUgx?=
 =?utf-8?Q?dAqgxVuahd97KNNMxvLoTkMheH/AoB+yOCPei1EsEFPBT?=
X-MS-Exchange-AntiSpam-MessageData-1: CB0LPb2Vd1UUsw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc95ee28-88e2-4fdf-2cff-08df33c6d80c
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 01:08:43.3654 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bKmJ+XMl5YiRrqyTu7XavqJy8Pstspu5KUYpIswDkzRtaxWeMwonUVbaVTAR51CmEcRQHYZi3UuENBrOsB28SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5881
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed Oct 21, 2026 at 10:56 AM JST, Eliot Courtney wrote:
> On Tue Oct 20, 2026 at 7:08 PM JST, Alexandre Courbot wrote:
>> `receive_msg` currently handles both the transport and RPC layers.
>> Retire it and split its logic between the new `consume_element`, a
>> transport-level method which passes the parsed message contents to a
>> closure before advancing the CPU read pointer past it, and the
>> already-existing `await_msg`, which calls `consume_element` with a
>> closure matching the RPC message.
>>
>> This introduces a small behavioral change: a matched RPC message that is
>> too short to contain the message component itself no longer stalls the
>> queue. This behavior is justified because it fixes an inconsistency:
>> unmatched RPC messages were always skipped, whereas matched RPC messages
>> could block the queue if they were too short. While a misconstructed RPC
>> message is a problem, it is not a fatal queue error as long as the
>> transport framing and checksum are valid.
>>
>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>> ---
>
> [...]
>
>> -    /// Receive a message from the GSP.
>> +    /// Wait for the next element on the message queue, pass it to `f`,=
 advance the read pointer
>> +    /// past the message, and returns the result of `f`.
>>      ///
>> -    /// A message whose function code is `M::FUNCTION` is decoded and r=
eturned. Any other message
>> -    /// is logged as an event.
>> -    ///
>> -    /// The read pointer is always advanced past the message, regardles=
s of whether it matched.
>> +    /// The read pointer advances regardless of whether `f` succeeds or=
 not.
>>      ///
>>      /// # Errors
>>      ///
>>      /// - `ETIMEDOUT` if `timeout` has elapsed before any message becom=
es available.
>> -    /// - `EIO` if a message fails framing or checksum validation.
>> -    /// - `ENOMSG` if the message was not the awaited reply.
>> +    /// - `EIO` if a message fails framing or checksum validation. In t=
his case, the read pointer
>> +    ///   does not advance and the queue is stalled. This is a fatal er=
ror.
>>      ///
>> -    /// Error codes returned by [`MessageFromGsp::read`] are propagated=
 as-is.
>> -    fn receive_msg<M: MessageFromGsp>(&mut self, timeout: Delta) -> Res=
ult<M>
>> -    where
>> -        // This allows all error types, including `Infallible`, to be u=
sed for `M::InitError`.
>> -        Error: From<M::InitError>,
>> -    {
>> +    /// If an error is returned, then `f` has not been called.
>
> optional nit: Clarify in a comment that w.r.t. `EIO` and `f` not being
> called, that only applies for the outermost Err. i.e., we do have
> R =3D Result<>, so we have Result<Result<>> but we're only talking about
> the outer (transport) Result here. Maybe one way to clarify this is
> that `R` contains the output of the message layer and may itself
> be a Result<>, and this function returns a Result for the transport
> layer. Not sure of the best way to phrase it but you know what I mean.

Given that `R` is produced by `f` this is more or less explicit I think,
but I'll add the following to remove all ambiguity:

    /// Note that `R` may itself be a `Result`. In this case, the above onl=
y applies to the outer
    /// `Result` returned by this method.
