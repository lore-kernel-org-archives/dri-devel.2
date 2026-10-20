Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51628606A321
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 14:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=nmL9xqW9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AADAF10F62B;
	Tue, 20 Oct 2026 14:27:40 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012042.outbound.protection.outlook.com [52.101.53.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB6FD10EBB5
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 14:27:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qkwhdxDMJGd4fEBiYuQk0KPVyzMiZNO+Y2IsoQg3MVCs4DducABQb6DpKCzzScNndebKlbYOff3FoCmCKqnKuqP6cspuoaUmSu+8/Wws53oQX728+bUnqH9tJAi5Ys5TZEKKOKV2VpzHuiWDuqata04lp52AIqU4PB480yEznHUcfMMl53TuoQThKiCYL3/W28NeeXv31n5Qvoj5nbNx+AsnEz09TMnwntGHHXV5/5UkKKBpFEx9OLELSMaoCPh2xJJUPcnwbLORT88d9/R3ey4yEOwtzz8W4bO18L3va/zwKa8jXcxsX3Otld6uzY8C9W2DKY4ovExEFEZhY0pGGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cBKu+bqWsVujOXlQ8XkTdqHVDxD5xbSTA19CWY/qQf0=;
 b=fYqe7UAPHx+zkRZj25Cxxf30Gq2TtjyaH+6+SrYQGti+Ia/AcRBXT6x94aNVXuSy2fmiLiWtXcY6cw62Beq/7YyaCgE85ubUUk3RHOeLBsvBi/yBa5wMJcFCH/SNQco6yeBN6czWMNxhe8Ya41Md3l++3tBqqmUh3okq8IamxzR+bOsCannY6bJauC7uZ8Sc9g7mSEkBeDIiKhw/YZKNPSzIsTPUjONb//h29iShTlSl8khxqUWEVec8J7VWL3wwcfy5110YBR2PiQOW24b6OdC5ncJMlPNYjgANp8IqcLhGEZ3sWKAnBnXIa6Nb/bAS1jfHZ0TkqGE0wOv2Y9lO9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cBKu+bqWsVujOXlQ8XkTdqHVDxD5xbSTA19CWY/qQf0=;
 b=nmL9xqW97EO/vxd0D8XMwUa7Nm+MuSb3G1s9GvYpdkQeBl0ajODto14KknFYH30DtgYrQysCTPj1UbBEiq3kwLV5i+kwYwSuwg2cBZDDVOQzatdYageUuRO5Rvux6ZH/F1kaIqNmEAqh/2PDAMJN7mDP/spC8cGDRT4QqQnauT+51S4qzsET8fh4VsvPdskOCuW6bRYT3uLdwxDmJCn/4Gi0wRW+TjstXh6PWNWX2suvm2JDoSbKkkKmEueeliu1/rD+FCKElB82DBEn8SIv/HwE73a359ZjHAQVhO7EHzQYidg1z4k1vEAJdwpi9rEM60XCjTRVOpR8M0mJ7Q345g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by SA1PR12MB7441.namprd12.prod.outlook.com (2603:10b6:806:2b9::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 14:27:27 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 14:27:26 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 20 Oct 2026 23:27:23 +0900
Message-Id: <DM9QI47QSJ0L.2QMRVD4AP5WIV@nvidia.com>
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: <sashiko-bot@kernel.org>
Cc: <sashiko-reviews@lists.linux.dev>, "John Hubbard" <jhubbard@nvidia.com>,
 "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "Benno Lossin" <lossin@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 "Eliot Courtney" <ecourtney@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <ojeda@kernel.org>
Subject: Re: [PATCH v5 11/14] gpu: nova-core: gsp: cmdq: use consume_element
 to implement drain
References: <20261020-cmdq-rpc-v5-0-dceeb8f360ec@nvidia.com>
 <20261020-cmdq-rpc-v5-11-dceeb8f360ec@nvidia.com>
 <sashiko-outbox-178822@kernel.org>
In-Reply-To: <sashiko-outbox-178822@kernel.org>
X-ClientProxiedBy: TYWPR01CA0032.jpnprd01.prod.outlook.com
 (2603:1096:400:aa::19) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|SA1PR12MB7441:EE_
X-MS-Office365-Filtering-Correlation-Id: cc11dad9-7b3c-4168-809f-08df2eb643d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|7416014|376014|366016|1800799024|23010399003|56012099006|4143699003|11063799006|5023799004|261009223027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: TChHfYhnCKj7PuZ4KmZ4wFUHFcjy+OBC4UI5Om3uPqFArQLkDhityVc/7Quq8pRCbCBa1iKGuzFFInhg6cLcPUNqnVGg2l7PZd1yrvOIdXonxxKl1nTK49vjsq2g0WX2V76mIkvX5OqnUo6UTC/aN8PmkbTV5yfejTj6tGF5zWklXTB6zYCwvALAap2ZCr1ldd7t1PaYfRV7PTh4kr9UDHYnVKTOtZnyywJ5GIcBT/nc77JQQLqIEGZXf9vGCrOgnexJfCeqpTnslTWbLyHKb10rS4BUZbhRcnw5SCcA7AEtXgrf+XhqjebagF/ZY2rLJSfNAZzykPGrYpa2T2I3sRXytwykO1+Hs9GC1oPTs6F+c+v03w/MfpEvGgKe3S6bEf3YlEyJUx5shyaIyCQF/87m7FRRB2S+f46AoTvReP783wCezCSL2my1aOezl2YeHa/UKADkn93x8VyZqTb17qPcYek6/992LNRtL+xd1uZjJEYokei7hVDNi9a7dytcXRhrmU+iOwt96YBjUrKVNIzGPvxXPNZ3TwjNlwLzpqDKtdxS53KEJAGctDx+x2kE9ZxXECpgdEY1iPPRaNsooiKLDcBLIP6/BO9ikBft5V7Zxa+JHih3Aie2Bdvo1jz5G2+DzoPVuWvl5g4RAWWmbH/BHZuEwcCVyzYRrIYX1Lg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(7416014)(376014)(366016)(1800799024)(23010399003)(56012099006)(4143699003)(11063799006)(5023799004)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SE9tZGJtVHRYcHIya3ZWMVJkY25qdHI1ZWZpcWZoOGxjcWN0MWtmTE5IWVZJ?=
 =?utf-8?B?RFhlR0g5YnkyT2hFNVhUL3FqYjF2NmJMVnNVUUI5aGtqaDB3bnJyK1dRNXU1?=
 =?utf-8?B?OFFwZHY3blhJSVNrMnN5UEZ1SU12R0loZmN3czdVRDk0SmgxVUQwc3lRdzRh?=
 =?utf-8?B?SGlrVzNUT0xhREVMZTVSLzVJbnJnOURNNy8wNXVMU2FuT282K2Z0TzBzRVg1?=
 =?utf-8?B?OVVKWk9MVE5EeU53dHQ4SVhQMzNJVTFoRHc5RlNDeDc1aTBybHkvWjhqdEFU?=
 =?utf-8?B?VWxLSUJwNWVZYUdPM21TemI4Qzc3cGxqZlAwMFVrZGlFd1pway9iVm1oQU00?=
 =?utf-8?B?ZDlBL0VZaXAyQUVDQzFyUU5sNkJ1b3lCZ0RwdFpCaGZlcXlTKzJMYU9HSHpV?=
 =?utf-8?B?U2szKzZWeTBsbEdyemw4ZGphUjdFQ3dGT2M5SVJFaXBlZkNSUVQvUDRzTFFn?=
 =?utf-8?B?NUZiTjcxOCtaZWc1Zm11UFJlVVc5d2libmlPcUkrNFJIdHBUOVhDeWlBbi9M?=
 =?utf-8?B?cU84eWFzSzRzdUtiUVJwWWplcksxRnMwT3IwRjVJNjFpRnJOYnZja2ZpKzF6?=
 =?utf-8?B?Y0hsSVAwOEVEMEJuWk1NakpwUE0vYlpoYWVyVlpLWTR2VmZ3NHVlRHlhak5F?=
 =?utf-8?B?Y2pMMEVhRDErMFd3R0VNNUJzSkZVbisvRXluVW9ZTU1WbGdBZVh3UUR3WGxq?=
 =?utf-8?B?ZWV6Yzd0M3Z3UG9mOXZuVHBBRDB4dEpPU2JudFpzWHU5bjdFR09wT3hFZ3ZP?=
 =?utf-8?B?bEJ0OUc5RzBiVVRlVlhuV0hDV3R4WElqZHVucU9IbXl6aDJwUlY4MitSWTdi?=
 =?utf-8?B?cVVRbndWM3ZReDk3R1FRNlVZc3Z5aUowTGI5NUVlb20zcVBKQmZGdUVMNUd4?=
 =?utf-8?B?UVZxTUFpY09LZHJrdWdMcTJTQ2FhZFFaTUp1TTJ4VGQrL2xsYkxvcWp6UGJt?=
 =?utf-8?B?UW1WOXFBNVMyNEpLcFcvUSsrS1RHN0ZNczVncDdqK211eWJYcndpMFFPSG1o?=
 =?utf-8?B?OXNoVDdMZ0kzVlM4aFE3YThHanZkMEkxSzhIR0dDN1lrcTMrMFg5WDdQSGVY?=
 =?utf-8?B?TXIzY2FzYThWSTVuQk1sYW1lSWR4YitZTUFWNHQvTGE2ck1xU29wbiszTEZC?=
 =?utf-8?B?dTZsWmw2T3hZMHBwMEYrUmVtbkwycDd1alkzVFh6dmlHVmFqZGVMQVNBTVNW?=
 =?utf-8?B?VkNqYmxqNDhHV0hoNWZ0N1B4RGFPK3NoTE9nbkYzMzF4QUZvdmM2clNRZGo2?=
 =?utf-8?B?Tm9jaFllTWNXR1NPTmxkd1ZEa2dPbndTaEVWa09UdEhvOU1idmpTQ0NGUmox?=
 =?utf-8?B?a2t0dml1VjFWN3BuMlVzenVwNTVyNVIySE9PaW1pL21Tc1orQUU2QUQ4c2l6?=
 =?utf-8?B?ZnhVdUtib3JLTXdXTU0zNFdhRXRsTUg5OUcxTkp6cUxUR0xYZ1JhbEx1SGJX?=
 =?utf-8?B?RktuQXVXUUx0OC9iR0dCald6TmVneTN0Y0E2SzRUUm5FUi9udDIrVUsrejJp?=
 =?utf-8?B?aG54YmdOTkJMamF2ZzluR0h2ZGU4QkZOMFJEWHRJZFNwRDZERnc0Rlh3a0hl?=
 =?utf-8?B?SmY4TDMzeDhGb3g5S1pDTjNZM3MwTHEyTWl6eHJOSGpRUU4rOGY5NFpRSnlM?=
 =?utf-8?B?Yk5XdDVENHdFTktrVE14TlhnY2J5VmtvbGhVeFdub0pyaGVueEVsL05rQzd2?=
 =?utf-8?B?UGQ0N2xPeHZzV3N0bjJ1RCt5YVpiRkx4T0xzQm5KSytEMGl0SCszM2lnZ1Vw?=
 =?utf-8?B?KzFVT0tXbEtZS0s3MTUyOHZYblBWclJwMW0zMXY4NGQyaTZETFp2Q1VNODh5?=
 =?utf-8?B?WmNDcTBFVWUxVWxscDQ2ZXg1Z2VPMUEwelE1SWdFRjJOUXczTm5UcTl4S0d0?=
 =?utf-8?B?Qm9SZUNrQWF6OHFFdzBSUzU1OFFpYk1MekVVak5pa2pWOUZ5cGttUDBZNHdW?=
 =?utf-8?B?UHI0c0sycWdsSUI4RXVFcDZPSU9Cc2IyaDZlMy9CZlFlb0lmZHNaUmdmakhM?=
 =?utf-8?B?dXJFa2ZzUm9pc1I3L0FPM2VwRVhMdkNqZk1JMi9aNUVaOXBRZ3dmcXpFQ3pq?=
 =?utf-8?B?NnEyeFBLNkJIRFRRU3NGK3c0UnV1dU84U0tadjdoTEpkbWFidmJFbUtLTWFP?=
 =?utf-8?B?SEpKQlY4YXc2L0R6aUpwT29CSURjcXYrVkpPd242MUtWSHNicm95d1dlU1dZ?=
 =?utf-8?B?YTFaSTJmY0hPeGFYRkQ3SCtybEQrQkVtWW9nYzRYcG0vNXVzWUs4QkhzYlVo?=
 =?utf-8?B?clA0aVU4cXpGTjNxQ2tNbmJMcXlsdElTbENUaER1Vk5PanRnMW8yMWxBQ0xQ?=
 =?utf-8?B?bWwzTnUycmdndnI0dFJCdU5Mdm1zY2xlNjN6aDhtcjBoenYwMkU0eHJQME1H?=
 =?utf-8?Q?jL69/fQcuKQKCB9E1U8pcvvYJ78r0F41DnIqA5Y+MUrPN?=
X-MS-Exchange-AntiSpam-MessageData-1: vGU3+7/TB+VdjA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc11dad9-7b3c-4168-809f-08df2eb643d1
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 14:27:26.8259 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ltq3gBOZ5RNhHZplRglnF+49Md9EHtLLSL+rIY7ZbTD64iiaRmqnqLkaN8MSeqjn7sub+54We3sZ61cPdhUy2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7441
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue Oct 20, 2026 at 7:18 PM JST, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] gpu: nova-core: unintended 1ms sleep in CmdqInner::drain() on =
empty queue
> --
>
> commit c3321749b8f493965661eed66b6e6bf889cebd66
> Author: Alexandre Courbot <acourbot@nvidia.com>
>
> gpu: nova-core: gsp: cmdq: use consume_element to implement drain
>
> This commit refactors CmdqInner::drain() to use consume_element() and
> adds a log() helper method to GspParsedMessage.
>
>> diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/g=
sp/cmdq.rs
>> index 7db3d28e8902c..54e87fd7158cd 100644
>> --- a/drivers/gpu/nova-core/gsp/cmdq.rs
>> +++ b/drivers/gpu/nova-core/gsp/cmdq.rs
>
> [ ... ]
>
>> @@ -1054,21 +1063,14 @@ fn await_msg<M: MessageFromGsp>(&mut self) -> Re=
sult<M>
>>      /// `EIO` if a message fails framing or checksum validation, or if =
a message's page count
>>      /// overflows a `u32`.
>>      fn drain(&mut self) -> Result {
>> -        while !self.gsp_mem.driver_read_area().0.is_empty() {
>> -            // A message is available, so this returns without waiting.
>> -            let msg =3D self.wait_for_msg(Delta::ZERO)?;
>> -
>> -            let pages =3D
>> -                u32::try_from(msg.header.msg_length().div_ceil(GSP_PAGE=
_SIZE)).map_err(|_| {
>> -                    dev_err!(&self.dev, "GSP drain: message length over=
flow\n");
>> -                    EIO
>> -                })?;
>> -
>> -            RpcMessage::parse(self.dev, msg)?.log(self.dev);
>> -
>> -            self.gsp_mem.advance_cpu_read_ptr(pages);
>> +        loop {
>> +            match self.consume_element(Delta::ZERO, |message| message.l=
og(self.dev)) {
>> +                Ok(()) =3D> (),
>> +                // No more message pending on the queue, drain is compl=
ete.
>> +                Err(ETIMEDOUT) =3D> return Ok(()),
>> +                // Other errors are fatal, and stall the queue.
>> +                Err(e) =3D> return Err(e),
>> +            }
>>          }
>> -
>> -        Ok(())
>>      }
>>  }
>
> [Severity: Medium]
> Can removing the !self.gsp_mem.driver_read_area().0.is_empty() check
> cause CmdqInner::drain() to sleep for 1 ms when the queue is empty?
>
> Previously, CmdqInner::drain() only called wait_for_msg(Delta::ZERO)
> after confirming a message was available in driver_read_area(). With the
> new loop, consume_element(Delta::ZERO, ...) is called until the queue is
> empty, which invokes wait_for_msg(Delta::ZERO):
>
> drivers/gpu/nova-core/gsp/cmdq.rs:CmdqInner::wait_for_msg()
>         let (slice_1, slice_2) =3D read_poll_timeout(
>             || Ok(self.gsp_mem.driver_read_area()),
>             |driver_area| !driver_area.0.is_empty(),
>             Delta::from_millis(1),
>             timeout,
>         )
>
> In rust/kernel/io/poll.rs:read_poll_timeout(), when the condition is
> false, the timeout check uses a strict greater-than comparison:
>
>         if start.elapsed() > timeout_delta {
>             // Unlike the C version, we immediately return.
>             // We have just called `op()` so we don't need to call it aga=
in.
>             return Err(ETIMEDOUT);
>         }
>
>         if !sleep_delta.is_zero() {
>             fsleep(sleep_delta);
>         }
>
> Because op() only reads two u32 indices from coherent memory in RAM, if
> the monotonic clock has not advanced by at least 1 ns between
> Instant::now() and start.elapsed() (for instance on architectures with
> coarser timer resolution or under virtualization), start.elapsed() is
> Delta::ZERO. Since Delta::ZERO > Delta::ZERO is false,
> read_poll_timeout() falls through to fsleep(Delta::from_millis(1)) while
> holding the Cmdq mutex (in paths like GspInterrupt::handle_threaded() ->
> Cmdq::drain() and Gpu::new() -> Cmdq::drain()).
>
> Would it make sense to keep the while
> !self.gsp_mem.driver_read_area().0.is_empty() loop condition around
> self.consume_element(Delta::ZERO, |message| message.log(self.dev))?

Mmm, that's an interesting one, in that I am not sure there are any
concrete implications but I'd like to fix it anyway.

I was thinking that maybe we should add a special-case to
`read_poll_timeout` so it returns unconditionally after checking the
condition once if `timeout_delta =3D=3D Delta::ZERO`, but doing so would
make the `sleep_delta` argument moot so I guess that's not adequate (and
the current behavior is technically correct). So I think I'll
special-case nova-core's `wait_for_msg` instead.
