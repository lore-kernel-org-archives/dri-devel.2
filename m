Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C212CD98EE
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 06:22:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EAFA10EE07;
	Wed, 17 Jun 2026 06:22:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="oXPbnCNF";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011003.outbound.protection.outlook.com [52.101.62.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2127610EE07
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 06:22:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k4EqAIsvjDzqL4wg4dTQVNXZm0xpbteYDBGtzo/Io1GYGb++bsClIAGzIYozqe/q1T8YZH0UtIgCRLU+Q/V4z/RMb/dfi2yM4jxQdKqvdr7mVd6hhCXgcm6+fnn3YU7ALY+wlHl5YLMZUE7Tn+qJe7KRTBx1A+613b9lnZecUFF+LNrotxWL3/g091pHRyEbCmc753dp4pKB6D/FAOa9SZSidZZBUDGx2ZVSTUVdUh5ocANPl/N7NPnmCqku1Vr5nSuG+byjDouMSx0QcELeu/0c4nQELZNddJGzH03fOR63dI1gOjGyfqcIrAVdxdQ+OaCN/DQpmQML1cA428Bi4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BAZnURwZrWubDoAQt3NMbQmKVIj6Z8Kzl7CriQ3m/P4=;
 b=Qc9Bnsnbhz4UBNBtmjnaY+7h3efX0tC1uXTvY0m/CqpXIfaYFpW3JDuegBHCQ6oWJWcnPKXNf2f3fqxX598YkYTX5vQcBGonSiDkLvle7pyQgG3dCSkxIKCq2SvJJ2hQKg5/egE1ipxosSbAn7XqOpC0tsLtMgzQ12aLdM36v0TRleuqF9uwhrEanH6C7Tys4xuAVszCv9I1Md+THckW85XU0iCPHb3Rh2aKvEeQvmoZR8C8F0Ozn1PmNlN6wSaTYvJ6uxaNn1WBKLBaXqDJrbgQKOcqK/N2gKiThEIQHL+jxVzPMyZTXC7ZKd/lb/v1yehe5I2qQ5PadMpM7zr+jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BAZnURwZrWubDoAQt3NMbQmKVIj6Z8Kzl7CriQ3m/P4=;
 b=oXPbnCNFJatIuk5YjZ4N6HSi4RF2c191EiGi7SAeNCttPEYoSZUCf1M2G0AGGs36sQiwJUFDfNiRIh9gXX0gQ9ZUlo7R5eCNliY3Mf8OgCIawKNJCNHeq31zxbtwm0LLvolC8lg/NlolQeNMN3sNKxS6XfeCTr+skR4s3xqk2jAy0eJUgCyZRzUvedhfTjYl09eh4gDnWpYghXkuNL/yGQOufTYOglZPSK+4UgAVPnjO/TxyGaoWZkstLrrgd5Zy2CEHxS1qWmPtIcgREaXDqtgtPGp4gBISe5U+zazRRhlwVQ4EjtThUSQPVFVHXkARIROvyoGljq1o699ZTFBN2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CY5PR12MB6597.namprd12.prod.outlook.com (2603:10b6:930:43::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 06:22:29 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 06:22:29 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 17 Jun 2026 15:22:21 +0900
Message-Id: <DJB3WN3YJ502.HHFZNUE1M1NS@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Benno Lossin" <lossin@kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH 2/4] gpu: nova-core: move GPU static information
 acquisition to a GSP method
From: "Alexandre Courbot" <acourbot@nvidia.com>
References: <20260609-boot-vram-v1-0-d9382610507a@nvidia.com>
 <20260609-boot-vram-v1-2-d9382610507a@nvidia.com>
 <DJ5AI4A9XVNE.1G63OSC35Y99W@garyguo.net>
In-Reply-To: <DJ5AI4A9XVNE.1G63OSC35Y99W@garyguo.net>
X-ClientProxiedBy: TY4P301CA0099.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37b::15) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CY5PR12MB6597:EE_
X-MS-Office365-Filtering-Correlation-Id: 99dd67a1-0996-41a2-06a9-08decc38cec7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|23010399003|7416014|376014|1800799024|366016|56012099006|11063799006|22082099003|18002099003|3023799007|4143699003;
X-Microsoft-Antispam-Message-Info: lEeTLSj+QEsHY0Yq41ZzorJaAZA35xuVcl8Ly+U+T9cpSbuHs4G+uVXRBtT2jmqxTUV/uFAVju3IW1tJCosoYawswy7pnp9c6RuKJc+dr4SuTDJ0+XchO3lsbC0lqUsU/k966rysAxMf4PKSb90URFMsiqro3vqHC+UOWJVZ0tKdc+BD9Cf7kgLE/GIScTXptgSB1dg9OqPgCxrkCPk44kwQ0WhaXtvYbkyXCr6leBOwpHnY9tKYCoEVoRP+hcYh/aRwFiwUna0tuyWRWkA4H2URbELFh8XmML4TgWX7ESby7cJMLrwvlwGEe9G4Shs4VYWhX2fUUrmgSFA9hIzophbl7woMJi/pqfqwCosn8zer6ZLJGDcQIkzh9+2EjkXXBgAde7xIfP+mtVAJCKRWwO0zGlOZ0T4705r1VwkRhPcp6KKIG5hVRzpPHpYAW9seZgelwm+vFYfPkgUQ0bq4z2r141fapiDG+/bf7ZRsXAae4us+IinyVpr3b4RwBTtHh8xdLFmh7BO4CHWwGWVV5FYeEmPBuKRjC+RLLYvMjwquVvp+GLrsJu5y/HshPbudDBgUg+VxrCErOxr8h1OmydVxozpDiciNryQWnW1ci+zrknkJhlysDcapX772TsOUX1P16GgDTO2763i+iNFpl7jPsFAH/iE6beOy8At0S7xvIZVgzmffz9afUMkWTuYJ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(23010399003)(7416014)(376014)(1800799024)(366016)(56012099006)(11063799006)(22082099003)(18002099003)(3023799007)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N09QSkN1NlJmZVZMai8zcEhKUGhNcTQzTlBHRm9TdThSRGNCV1lWZTFjYWRU?=
 =?utf-8?B?c092cXk0ZWlHdURDK3lVa1czUGZQNkZ5aEo5TGo1YlkwbXRBNzgvNW5JYk5z?=
 =?utf-8?B?cmhUTUE5cXB6aFE1Zkllbk8xZFpwL1JrWWwzVGl0Vmh4YzhMNHpWaGlmYnlV?=
 =?utf-8?B?THR5MXozOHZkaXNNUnU3RlFiYVhyZjUrYWpQc1RTYUd3M2pvcENoNVNsWTRW?=
 =?utf-8?B?SGIwdlpwRnYzNFBPZkYvL3hDVVZrRG1Od2NJVmo0RktINTFZdlFhdlpjNXZM?=
 =?utf-8?B?eklmYVJROUZ2RDhaN2IrcHVITzhtRXBTNVpFeWRwb25HLzBGKzVXS3N5R1Ex?=
 =?utf-8?B?MXJkUGkrNTgvSnhIdzJtNllrMjczYVZPYXZhNWhySTZDOWkzUVNMby9nK2Qr?=
 =?utf-8?B?RE1Qa2MwU0hQK1J1Q2pmandHbXhZbC80dkM1VGgzT0hPZjlyNHV6ZHM4bmJM?=
 =?utf-8?B?QUFycm5vRUp5cHV0ZzVaWHYvbG9sLzlLQWZQblJTS01DSC90YW8zYjJoVEV6?=
 =?utf-8?B?eDhzSVMwM2tuRll6cVJSVWJqc0ZjdEVDZ1B6Nk8xSkNZbVNBcHlwbGd1VUV6?=
 =?utf-8?B?UWc5YjRBR2dwWVdqVVNpQ3BmNkNVejI4ZTBqY0tLSmZpc3VSSWpyRk9aRk1a?=
 =?utf-8?B?ek12QUdWNzg1MFA5RWV2cy9FZ2YybVFHTS9IVkl0SU9jeG9GZ0praVl5R3JI?=
 =?utf-8?B?TGt1cmh6SFhEZmtLOWtvQ3ltMDh3dDJuUUhRREhJdkZXOUpoQjkydTBLZlNY?=
 =?utf-8?B?dW04ODl0aFRqc1ZsNGI0bW9oSGhoTFovUW5yVHFTbEYyUVFvYk1MVkFjUFcy?=
 =?utf-8?B?bE9YbzhDRXBmRjM4R1Zlb0VnQ1p4V2ZrRk9VdEVSVnhOT0pxYnhjbXpHOXVE?=
 =?utf-8?B?ZDhNK0JIc3gvM0VLeWp3L3E2QlRoa2lNRDlXcHcvRnhlTG9PaUd6MnZ1ME5q?=
 =?utf-8?B?a010U3IyeGRtbVdqZ1F4Q2VOQWJkRlRwY0Vzckhwem04alBKTVg4MEFaWEZu?=
 =?utf-8?B?ZUFVTlF3ZXZHUWdhblhGdndGZmZKZlF0ZW01a29hazBONzlyZStIdWkwa0RU?=
 =?utf-8?B?N2FCSko5bVpzNzdrMk10aGszTFp5UElKRGladWl1T3dwTitjUWtNeGxlSWEr?=
 =?utf-8?B?WGUyZk5BK3c0VTZnWFVMY052bWFGQ0l1TG1HVVZXVzVZWDcwZmN0TjdDSUk3?=
 =?utf-8?B?dlRiQW80MGh3UDNaYXpDRkRyektnb1NVSkRFN2YzWUF6UWxzbTZMU1M1cTA4?=
 =?utf-8?B?d1BFYnpzOUdUS2xYVWt5OGw1dGFxY2RCR3dnWVN0RmdLeUtHUlA1UUR2Zmkv?=
 =?utf-8?B?cnB3alh5dWNYUVd1ZHJoNFRERlR5NWQ5cEJOYkdETXNkRzR4cXhmNHl6RjB0?=
 =?utf-8?B?NzRwVmRWdFVPT0Y2Q1h4Rk9iY1VFZ1dtREpSZm83QmNSTDVyVHU4ck5LdEEz?=
 =?utf-8?B?RjdCMWZyTFZNb0R5Tk5weGdSQ1NBUWVRTzJUV29sNlJQSW8veWY1NTNrRytD?=
 =?utf-8?B?Vmd1MCsyNUtLYXpoQlAzcDY5TlJMN0lEQnIvM0tnMnU0bGRpMzljczBEUDk0?=
 =?utf-8?B?MHVKblJrRmplZXBEakZLOVNpeHZqUGNUWTJQSmc4L2MzR3lFTUFnWnRLcjZL?=
 =?utf-8?B?WXlxMDdsenpXOFR4bHl6OVBIMEMycjlLd3hMR1RNME9jN3BwdHJkd011cnVT?=
 =?utf-8?B?c3lVc0NmSG1Kd0VCMSt4ckhCeVB6dTRTV0F0YkhIN0R1ckF0RVVHODdZdzNp?=
 =?utf-8?B?cWFUYWkwR3k2dHIrNDBXQUduc2hwM0xCZ2gxYUlqdG1ueXV6MEprWkt2ZGNM?=
 =?utf-8?B?M3FtWnU1dkh0cjlDNWlnZ2M2VmZ2WjFtU1B2R0RJMVVXUGkvcnZPSTl3NVhs?=
 =?utf-8?B?MEFDMjNEMXBSTTMvMjRvVlRzcm12d3FjbzYzenN2Y29jRVdmbFAyQVBMa25l?=
 =?utf-8?B?QVliemFoSnlhTnM4cGFZSHhoSlVIaGRLbXJKcE14ZnNrdjhsUnVKUktYNTFQ?=
 =?utf-8?B?TlFCZGlRMVVYZ2ZJZnZZM3AzVjZWOGpmY0RFaVNnajNBU0FseXdPMWdzc0ww?=
 =?utf-8?B?cFBSM0RzSkxYc2NEL1pQQ1MxZExWb1ErTVRmcnNZenB0ZEJPZTJqUUtqVGNi?=
 =?utf-8?B?Vk1kSkVVZ0ZZTFE2WEFSaGNaNmQzdWdDcTJiZVRnSVZCalpaTC9PcDJKbDNC?=
 =?utf-8?B?K0JpV2NFNEx5NHRZVklxNDNvVkZVMU5haFZlcjdOK1BjcnRBL01BWEFLcGRv?=
 =?utf-8?B?N2JBdnoyazJ2VmVnV1R4S2lrUEIxeXI1WVVaOGhiZHNFV3J1TDhuWVJhdjVI?=
 =?utf-8?B?Q2o2c3dTMzRHL0tlZDhhQWJjSlB6Mm5tTDluc0NTSXMycStidWdEUW01MUpL?=
 =?utf-8?Q?ohVmsyu6Cl/EmFnOFamziVUONrh+zK8NhPKEnnFkdqcYx?=
X-MS-Exchange-AntiSpam-MessageData-1: WTt++9brMD4bjA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99dd67a1-0996-41a2-06a9-08decc38cec7
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 06:22:29.4112 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E94rTjF12ZzpXZ1jKiEHdSvYuK9+5z016+G1xhfCQlXeuFz/ac56Ry2p5z3PoLNqpJvcSLJNHioGo4zY5b3kDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6597
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

On Wed Jun 10, 2026 at 7:16 PM JST, Gary Guo wrote:
> On Tue Jun 9, 2026 at 9:04 AM BST, Alexandre Courbot wrote:
>> The GSP static information is useful during regular driver runtime;
>> however it is currently obtained from `Gsp::boot`, with no elegant way
>> to pass it back to the caller.
>>
>> Solve this by moving the code acquiring it to a dedicated method of
>> `Gsp` that can be called as soon as the `Gsp` is booted. This allows us
>> to obtain and display the static information from the `Gpu` constructor,
>> and to store the static information for later use.
>>
>> Its location at the end of `Gsp::boot` was a bit out-of-place anyway:
>> technically, the GSP is considered booted after we have received the
>> `GspInitDone` message, so anything that happens afterwards is not part
>> of the boot sequence anymore.
>>
>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>> ---
>>  drivers/gpu/nova-core/gpu.rs      | 16 ++++++++++++++++
>>  drivers/gpu/nova-core/gsp.rs      | 15 +++++++++++----
>>  drivers/gpu/nova-core/gsp/boot.rs |  7 -------
>>  3 files changed, 27 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
>> index 6b3e02c71dee..a0cb36cdeeea 100644
>> --- a/drivers/gpu/nova-core/gpu.rs
>> +++ b/drivers/gpu/nova-core/gpu.rs
>> @@ -23,6 +23,7 @@
>>      fb::SysmemFlush,
>>      gsp::{
>>          self,
>> +        commands::GetGspStaticInfoReply,
>>          Gsp, //
>>      },
>>      regs,
>> @@ -290,6 +291,8 @@ pub(crate) struct Gpu<'gpu> {
>>      /// GSP and its resources.
>>      #[pin]
>>      gsp_resources: GspResources<'gpu>,
>> +    /// Static GPU information as provided by the GSP.
>> +    gsp_static_info: GetGspStaticInfoReply,
>>  }
>> =20
>>  #[pinned_drop]
>> @@ -354,6 +357,19 @@ pub(crate) fn new(
>>                  // is properly run in case of failure.
>>                  unload_bundle: gsp.boot(pdev, bar, spec.chipset, gsp_fa=
lcon, sec2_falcon)?,
>>              }),
>> +
>> +            gsp_static_info: {
>> +                let gsp =3D &gsp_resources.as_ref().get_ref().gsp;
>
> What's this `as_ref().get_ref()` for? This could just be referenced as
> `&gsp_resoruces.gsp`? Or am I missing something?

It can - I am not quite sure how I arrived at the above construct
honestly.
