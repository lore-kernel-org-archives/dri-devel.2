Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23802CA6015
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 02:28:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B90E10E3C2;
	Fri,  9 Oct 2026 02:28:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="PqSzv/Se";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010001.outbound.protection.outlook.com
 [52.101.193.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB87410E3C2;
 Fri,  9 Oct 2026 02:28:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nGy2yCZeMV5nFPBgNdfFpYby8AxRP/WbR2ZqXLotUbzAXqjjdsll4kCCH4a/Zk6qgjC5JBexnKHMnpLXS7ZRwPCWH86pfgRqOWnWCG2rsnqHY0t12wZ4A6x3cu1mBYvrxigPdWMdg8B6uO+0iBu7TPiZ+wLJmwBHJvrg8I6S8fcdQYz/4qX0uuOX9orX3eZbpG07VGzMZUvR1x6B2OX7rUd09DH9cyOyk3wC3XjS/JztwcwAq5/X/uBVXmmc2DEByF0VMkXAXfL5vjXX2ymX96QgAQRFgUge3u7va6srKHi4Ii2RzH4KisUjjcbs7TjSnQZ7z3sVIBVI0bN5XAcPxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=39jTdytqRLfVydvzPbiVczuBMEV1GTQc+LEsYQbSEMY=;
 b=j1a6abVEmp9XnJDFdiAeE9IOVGKXvSHJtugW5rw8YhbT+XBCwdVyjXh3HeKOT2XU9xNVbxHpRBGIenmjbyStnNFC2jztbfFZfZHudZx7RYDGB2GQgxPtMY6wuoxS+ccPqAZCiLtiPakunLpjFIwIM609UUu5GVCU26k0QNbC2ASzweRghoUu6M7OEyutU8LTzaEFvnQg/l93czaWQJ2j31NaIeaA0U5iXy/mMit2eu2UW81uon0VJRt+kTEWzDaLNzNd8fCegMBFWdx8kVsbU/BorYQ6oEwiQo1g1sghOLDoZ/BfUbxWejvB0dq18ZWHoQTX7NfsRt2zsnyT6dryWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=39jTdytqRLfVydvzPbiVczuBMEV1GTQc+LEsYQbSEMY=;
 b=PqSzv/SeouX7g/GmEq0+WqtULz3WHQuLONjnaPRAFAjm1BO3RxXgN7mGU8CL97ApWEToLW+AGp7kxJZatiCV/jO/DOY9B7DXjIsLWHYO/AFuVhifPiQ6pzg/A2L0MrYUq55ALmR5v6BD266iwKiKe3/yVeXyf1huZio3+ilFktC2lFelwlZY92qoQMgc0Q6X3jw1emWvOPSdadydT58npbV8dJ59e39fv9hUlh0XoBko7+Aw2S3qtYnzJ9AtrcOgBSbP1P5KgDJyvusyAmnkcuV8af8ZoklEYt3f5zbR+4ZTclPQPG5QI24EUyOvveyFfefyLIcWQ2wo9O/s3YHxPQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by SJ2PR12MB9239.namprd12.prod.outlook.com (2603:10b6:a03:55e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Fri, 9 Oct
 2026 02:28:01 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0472.016; Fri, 9 Oct 2026
 02:28:01 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 09 Oct 2026 11:27:58 +0900
Message-Id: <DLZYBAJK348J.3NGIWDX9HJF83@nvidia.com>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Benno Lossin"
 <lossin@kernel.org>, "Gary Guo" <gary@garyguo.net>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Zhi Wang"
 <zhiw@nvidia.com>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v3 4/9] gpu: nova-core: gsp: cmdq: split the transport
 part of the send path
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
References: <20260930-cmdq-rpc-v3-0-91613f06520b@nvidia.com>
 <20260930-cmdq-rpc-v3-4-91613f06520b@nvidia.com>
 <DLT564CV8CI0.1GHQWYK054K8V@nvidia.com>
In-Reply-To: <DLT564CV8CI0.1GHQWYK054K8V@nvidia.com>
X-ClientProxiedBy: OSTP286CA0099.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:219::16) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|SJ2PR12MB9239:EE_
X-MS-Office365-Filtering-Correlation-Id: 7eb98c5c-de0b-479d-316f-08df25acf0b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|10070799003|7416014|6133799003|22082099003|18002099003|10067099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: Bi9ZOD3At9Z7kbKlGVPE0RHURjpw1cD55fb7rgI2Zkym2sQnfzFX1Rl5rbXZhp4HNRVGJRoeJljIBnH3A3lZHmlhnJ6Szho3XuAgt67aXlL26jrLra4Gz1WHkYKwT5jIPA7sa9Y9EvxS+JaZ20iY6x9qzqgS+eec/URadTZVme+jPqJpw/W9ka/KLMky4W6mNDFOGiAlWBLXH8cPXYq95q45w94G+m+qXjd1PZKRG0ytqJn/PfIfh0gRCEXM2sQui1+cFXhE7MUEud5UQl4D9NbBHoqVfYpOG6gi4dE/3gG/EW/PqAk1OIw4VxWddwlrRX0BGoP2dzp1sWuALrD7ZoXwPmsrBPfeTYjCTwkAruD6JQIUh0YFuzmB2K19eXfsCtqzAJET8z1mP4HjsEwMkw561hSo4zzM6yjGGtSkSOB+lxX6FUK7MPqQY9UR4xOWTCLku49NiQDzDB0BlesudE2agjERasCEpUsacuY640UiggwakCF8EshjI2puIIb0HXEDKFO5aRFO+LOqeJI2gDo/xrYqaJ3Lp5vPm/3r5uwbqpEYlruq08aS4RcX7qxAPQfZMZqFQK7BlTce+Xm/pp2o2mbFJBoviqdzZbGFXC00LZ9mGxl8xpv10Y5KQeRtF9d6g3AzYIPw19cZAu4iNMCtK2zM4Bi8Llbdnf6VUrc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(10070799003)(7416014)(6133799003)(22082099003)(18002099003)(10067099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aW9ZMTJ2d0JwaTRnRVRLVEE5dmNIMkZTcmR6dndWaVhLdzBJRFVvUTZoTDJX?=
 =?utf-8?B?alh6VmQyclB2MFJjOWlSS2VpbGZNR241VDdNM2wyRkZ4OXZFMnBjY00vSmU5?=
 =?utf-8?B?bktFcC85dVJSS0FIb2N0WXRmN3hZVUNNeDJFVi8yVEtuNjBWSE1Zc2cwa05N?=
 =?utf-8?B?MVQ1cyt4OStiazhpQjJXWVMwQXExbjY2Zlp6Uk9ReTZrREUyWGJhYUVCY3ZX?=
 =?utf-8?B?eGRZNlB3NnlVTFEzdjJyVW1XTVA0M0VOV0kveGhGYzJhOGxLVkhMRlJBeTdn?=
 =?utf-8?B?YUpCZzZUdjRCcTRpaDBwTHBvWVZoaFdYejZpbytXUFdQZW1Lalp6UEpyTjJV?=
 =?utf-8?B?SjhUU1gyYzNNWjZEUnJvRFVJUFRRMUZRNmF0bkhmY210R2orTFlmOUJ5bFNI?=
 =?utf-8?B?QnoxNElJcldYTTNueXBiQzZTZnRYaExQUnRCb3JjK1RoVWp1VjM2c3UrZFpB?=
 =?utf-8?B?bkMxS3dhcVdsL3ZKL1JVcHEyeEVGb1pKZjVDdWdEZTNpeGJDcHdJeE9DajBK?=
 =?utf-8?B?UDQ0cUdqYUJ1SEFMU3JrcXVOVk9udXRNK3NmSnh0bTlRM0hZcEFpanNyYTdi?=
 =?utf-8?B?RkZpdCtMcjN1dStkMWtOZlB1bDlIeWduVnovYVpJRklIcFZ2LzhjTjlhZXpQ?=
 =?utf-8?B?emQzM0Y3UUw1VzR3ZG9SaDRtYU00aE5Ham5GZDVVejNxOG1YbTlMYnJWQlR1?=
 =?utf-8?B?QnpPUXUyaXlPREZrQjhNRG5MVGdFeFFET0JBcC9LbjM0NTJCVUFDNmRRWmdo?=
 =?utf-8?B?U0pTejI5N1NKK3hVTnoyV2F3WlpqY0ZaUWNMRmNIYU9XRjdONDBvQTdYM09k?=
 =?utf-8?B?bi9qMkpsUUJLVHNLdHRFdWJBYjFpbndUdXZwWlJmUjlCdm1VZ3dOTUo5aWZn?=
 =?utf-8?B?VzE1cmgrS3JZOWwzVmlFbU5ZZG5jZ0xodWw4VFFFaXJIbFNVNXhPUXJ5b1Vq?=
 =?utf-8?B?WFk5YVZLc1pxcm5majNCcVZJaEVEa3hLcnA4eGxJQURldTV4QzdlY0RBMmxm?=
 =?utf-8?B?SGVZMnF4Sm11ZEptK0V1cGJHZDVvSUoyNG9GSmZhRnRxWUVKRzg1NnRra0N1?=
 =?utf-8?B?R2dSdnN3enJhUTFqTkdtYzRzWm9PbG1zbGNSY3g2dnRTdmVmWVBjYTZzcGYx?=
 =?utf-8?B?aGFmblQyN3d5L203ZHVsZlR1Z1EzekNZNHdWUWxBQ0dGcEI2T0hmeTZCVk9W?=
 =?utf-8?B?MGlpdGJVbE14ZmJkRTNKQmExUmNPRGNvMW15RFJPOERLVHFjaldLckxTWUF1?=
 =?utf-8?B?NzV2TW02UEFXSEk0VmtpYnVqOE9nRG5KN25xQXJ1eFVDdUhhcWwzRVgxV1FP?=
 =?utf-8?B?T2dOK3JiSCswU2MrL1dNaUxHZ2JDSW5jUVFocXVwQ1dlQlVCU3JjTE9ySGly?=
 =?utf-8?B?alJRSnZHWU9iNlkrd0hMem83d1NVWXlvV1Z1TzBnWXM3VURpNTVtWmNNT1JG?=
 =?utf-8?B?bGFnS3ZFWE4vaGxDUHNNbUJCcVBteER3Z2REQXFyMkpKM2pIMzcxT3hSNW84?=
 =?utf-8?B?MU9MQkt1bWVlelFxTldQZTlTOFY1MDY2UVNLZ2twd0U0NWNxV3JUUFZhMm1u?=
 =?utf-8?B?ekRNYTVZNHJ4Q1FJeS93ZlFoa00rZ2N2KzRiTnM5M3E4aGRrYXovQThxWHU5?=
 =?utf-8?B?dWM2cCszOUVuMU1zVUNpWU1wcmdUS2duUWQwTkJKajEvK3NvaHlSbVB2eEo4?=
 =?utf-8?B?OHhxaTVWTGcyZ0tSNi9Oa0JsL0VBYkdZWGlqZXBraU5wVitmcERETzRiWnZw?=
 =?utf-8?B?Zm9CT0g4citEMWhGRXdkSldveE5zZE01eFU2anNDc0N5T08zdDd1aU9BSG0v?=
 =?utf-8?B?ZGUwSmliOEMrSFpVMVJMTkNoNTVseDg3NEVqNXJtV1AybU1nZWVTeVV0TTVy?=
 =?utf-8?B?a2FOY3Q1VG1oVEozWlNENEZGSXU3TzkyTWJYTDVIUmJBejBqL0lDblVhdE51?=
 =?utf-8?B?R1BtUkQwNzJWWmF2cm1hSnRoQlVTQWNiSVU0ZklFd1RnQkM5a3ZoTzJhc2Ft?=
 =?utf-8?B?SDFQQUhvU25jd01OTWhpNTUwbkFYcW5Hak9La2l6UysrZUZERnM4NG4wWGY5?=
 =?utf-8?B?S0hkMFpRMHhIeXpSQWZ3TExpendUZDMvaS9ueTR5VkYrTVdPeUt5MFlFV1F6?=
 =?utf-8?B?dHI0c3BCMk5rMnZudVBVRjZDUDNsQkpDWU1nQVVaNDVxSzVNNFVud0ZkUlVN?=
 =?utf-8?B?Rm4yZGorV3U1OFd1VUEybFJQYzJmQkQ2UkZHckM3ZTBkeWtkQlFUVVhwS3ll?=
 =?utf-8?B?d1o0ZURNcDdPZXYzSmxWUjRvZC81MWxCVERtQkZQUC9BVG5kWWZBeHN0RnhQ?=
 =?utf-8?B?Y3E0THZqMWM1UVJnOFhRVFVkWmdWMkdCeUdBMjRxSTNJVVlnZVZzaHUwMFBy?=
 =?utf-8?Q?oZFbaXo9ClpHuFqXanszk5cwC1oW0z8liDBXQnlfSxyUP?=
X-MS-Exchange-AntiSpam-MessageData-1: niiDfO5xfdQOvQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eb98c5c-de0b-479d-316f-08df25acf0b1
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 02:28:01.5181 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CImYB8k3FRiszxJf/eMcssO4x72ntl707tl2RIk/T+O7wUYchWokMeddvs1AcX03efJLPjI44tJ49ta99SADJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9239
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

On Thu Oct 1, 2026 at 11:21 AM JST, Eliot Courtney wrote:
> On Wed Sep 30, 2026 at 11:55 PM JST, Alexandre Courbot wrote:
>> Introduce the `CommandElement` trait and `RpcCommandElement` wrapper
>> type to define how messages (independently of their type) are sent
>> through the transport layer. `send_single_command` becomes
>> `send_command_element`, which allocates the queue slots, writes the
>> element header, and delegates the writing of the message itself to the
>> implementation of `CommandElement` before computing the checksum,
>> advancing the write pointer and ringing the doorbell.
>>
>> The RPC part of `send_single_command` (writing the RPC header and the
>> command payload) is now part of the `CommandElement` implementation.
>> This sets things up for moving the RPC code into its own sub-module,
>> leaving the transport agnostic of the message type.
>>
>> No functional change intended.
>>
>> Suggested-by: Eliot Courtney <ecourtney@nvidia.com>
>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>> ---
>>  drivers/gpu/nova-core/gsp/cmdq.rs | 133 +++++++++++++++++++++++--------=
-------
>>  1 file changed, 80 insertions(+), 53 deletions(-)
>>
>> diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/g=
sp/cmdq.rs
>> index bda79f23626d..d8a7716fc500 100644
>> --- a/drivers/gpu/nova-core/gsp/cmdq.rs
>> +++ b/drivers/gpu/nova-core/gsp/cmdq.rs
>> @@ -35,10 +35,7 @@
>>      },
>>  };
>> =20
>> -use continuation::{
>> -    ContinuationRecord,
>> -    SplitState, //
>> -};
>> +use continuation::SplitState;
>> =20
>>  use pin_init::pin_init_scope;
>> =20
>> @@ -67,6 +64,19 @@
>>  /// reply type are sent using [`Cmdq::send_command_no_wait`].
>>  pub(crate) struct NoReply;
>> =20
>> +/// Trait implemented by types that can be sent as a single command que=
ue element.
>> +///
>> +/// The command queue allocates `size()` bytes after the `GspMsgElement=
` header and calls `write()`
>> +/// to fill them.
>> +trait CommandElement {
>> +    /// Size in bytes of the element, not including the `GspMsgElement`=
 header.
>> +    fn size(&self) -> usize;
>> +
>> +    /// Writes the contents of the command into `dst`. `dev` is the que=
ue's device (to be used for
>> +    /// logging), `seq` is the sequence number of the element.
>> +    fn write(&self, dev: &device::Device, seq: u32, dst: &mut GspComman=
d<'_>) -> Result;
>> +}
>> +
>>  /// Trait implemented by types representing a command to send to the GS=
P.
>>  ///
>>  /// The main purpose of this trait is to provide [`Cmdq`] with the info=
rmation it needs to send
>> @@ -129,6 +139,62 @@ fn size(&self) -> usize {
>>      }
>>  }
>> =20
>> +/// Wrapper type for sending a RPC command as a command queue element.
>> +///
>> +/// [`CommandElement`] cannot be directly implemented for all [`Command=
ToGsp`] with a blanket
>> +/// implementation as it would conflict with other future command types=
.
>> +struct RpcCommandElement<M>(M);
>> +
>> +impl<M> CommandElement for RpcCommandElement<M>
>> +where
>> +    M: CommandToGsp,
>> +    Error: From<M::InitError>,
>> +{
>> +    fn size(&self) -> usize {
>> +        self.0.size()
>> +    }
>> +
>> +    fn write(&self, dev: &device::Device, seq: u32, dst: &mut GspComman=
d<'_>) -> Result {
>> +        let command =3D &self.0;
>> +        let size_in_bytes =3D command.size();
>> +        // Extract area for the command itself. The GSP message header =
and the command header
>> +        // together are guaranteed to fit entirely into a single page, =
so it's ok to only look
>> +        // at `dst.contents.0` here.
>> +        let (cmd, payload_1) =3D M::Command::from_bytes_mut_prefix(dst.=
contents.0).ok_or(EIO)?;
>> +        let rpc_header_init =3D RpcMessageHeader::init(size_in_bytes, M=
::FUNCTION);
>> +        // SAFETY: `dst.header.rpc_header_mut()` is a valid reference, =
and is not touched if the
>> +        // initializer fails.
>> +        unsafe {
>> +            pin_init::raw_try_init(
>> +                core::ptr::from_mut(dst.header.rpc_header_mut()),
>> +                rpc_header_init,
>> +            )?;
>> +        }
>> +        // SAFETY: `cmd` is a valid reference, and is not touched if th=
e initializer fails.
>> +        unsafe {
>> +            pin_init::raw_try_init(core::ptr::from_mut(cmd), command.in=
it())?;
>> +        }
>> +
>> +        // Fill the variable-length payload, which may be empty.
>> +        let mut sbuffer =3D SBufferIter::new_writer([&mut payload_1[..]=
, &mut dst.contents.1[..]]);
>> +        command.init_variable_payload(&mut sbuffer)?;
>> +
>> +        if !sbuffer.is_empty() {
>> +            return Err(EIO);
>> +        }
>> +
>> +        dev_dbg!(
>> +            dev,
>> +            "GSP RPC: send: seq# {}, function=3D{:?}, length=3D0x{:x}\n=
",
>> +            seq,
>> +            M::FUNCTION,
>> +            size_in_bytes,
>> +        );
>> +
>> +        Ok(())
>> +    }
>> +}
>> +
>>  /// Trait representing messages received from the GSP.
>>  ///
>>  /// This trait tells [`Cmdq::receive_msg`] how it can receive a given t=
ype of message.
>> @@ -638,24 +704,18 @@ impl CmdqInner<'_> {
>>      /// Timeout for waiting for space on the command queue.
>>      const ALLOCATE_TIMEOUT: Delta =3D Delta::from_secs(1);
>> =20
>> -    /// Sends `command` to the GSP, without splitting it.
>> +    /// Allocate enough send slots to store `command`, initialize them =
using
>> +    /// [`CommandElement::write`], and send the command to the GSP.
>
> nit: not sure what send slots are / seems like a new term? - I think the
> caller doesn't need to understand that it's per page anyway

Indeed, that detail is not necessary. Reworded, thanks!

